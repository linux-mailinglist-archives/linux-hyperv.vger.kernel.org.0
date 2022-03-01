Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40334C94D1
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiCATrb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiCATr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:27 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15CF96D844;
        Tue,  1 Mar 2022 11:46:37 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id D695E20B4782;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D695E20B4782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163995;
        bh=WVFx6iML5bGbyS/zXt5KlaQD4e/Gg2Ubqem125T9ajE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEruABcP6+Evj7C7jMUbjtfmtlev9vh4YzcH6GqimzbB3zGtHTyGh5iPM+q6Ubs0V
         IBR4Cp9XyIEufLqX9SZxgcrJhcHhdul+4eM47lx9zKQg5NqtnLVkv9PYzwQ53fgwvk
         NdGsJeNiOUsqh5wl6hesyFbDaRdepCmTkSoXvIBs=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 26/30] drivers: hv: dxgkrnl: Offer and reclaim allocations
Date:   Tue,  1 Mar 2022 11:46:13 -0800
Message-Id: <3a6779567438b02566012679f01ebb065e3761db.1646163379.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement ioctls to offer and reclaim compute device allocations:
  - LX_DXOFFERALLOCATIONS,
  - LX_DXRECLAIMALLOCATIONS2

When a user mode driver (UMD) does not need to access an allocation,
it can "offer" it by issuing the LX_DXOFFERALLOCATIONS ioctl.  This
means that the allocation is not in use and its local device memory
could be evicted. The freed space could be given to another allocation.
When the allocation is again needed, the UMD can attempt to"reclaim"
the allocation by issuing the LX_DXRECLAIMALLOCATIONS2 ioctl. If the
allocation is still not evicted, the reclaim operation succeeds and no
other action is required. If the reclaim operation fails, the caller
must restore the content of the allocation before it can be used by
the device.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   8 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 122 ++++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  27 ++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 119 +++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  |  67 +++++++++++++++++++
 5 files changed, 343 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index f1b3fa3214dc..59e10e7202cd 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -845,6 +845,14 @@ int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 					struct dxgadapter *adapter,
 					struct d3dkmt_getallocationpriority *a);
+int dxgvmb_send_offer_allocations(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_offerallocations *args);
+int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
+				    struct dxgadapter *adapter,
+				    struct d3dkmthandle device,
+				    struct d3dkmt_reclaimallocations2 *args,
+				    u64 __user *paging_fence_value);
 int dxgvmb_send_change_vidmem_reservation(struct dxgprocess *process,
 					  struct dxgadapter *adapter,
 					  struct d3dkmthandle other_process,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 04173dfe26a3..0ab7acf3787b 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2927,6 +2927,128 @@ int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_offer_allocations(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_offerallocations *args)
+{
+	struct dxgkvmb_command_offerallocations *command;
+	int ret = -EINVAL;
+	u32 alloc_size = sizeof(struct d3dkmthandle) * args->allocation_count;
+	u32 cmd_size = sizeof(struct dxgkvmb_command_offerallocations) +
+			alloc_size - sizeof(struct d3dkmthandle);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_OFFERALLOCATIONS,
+				   process->host_handle);
+	command->flags = args->flags;
+	command->priority = args->priority;
+	command->device = args->device;
+	command->allocation_count = args->allocation_count;
+	if (args->resources) {
+		command->resources = true;
+		ret = copy_from_user(command->allocations, args->resources,
+				     alloc_size);
+	} else {
+		ret = copy_from_user(command->allocations,
+				     args->allocations, alloc_size);
+	}
+	if (ret) {
+		pr_err("%s failed to copy input handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
+				    struct dxgadapter *adapter,
+				    struct d3dkmthandle device,
+				    struct d3dkmt_reclaimallocations2 *args,
+				    u64  __user *paging_fence_value)
+{
+	struct dxgkvmb_command_reclaimallocations *command;
+	struct dxgkvmb_command_reclaimallocations_return *result;
+	int ret;
+	u32 alloc_size = sizeof(struct d3dkmthandle) * args->allocation_count;
+	u32 cmd_size = sizeof(struct dxgkvmb_command_reclaimallocations) +
+	    alloc_size - sizeof(struct d3dkmthandle);
+	u32 result_size = sizeof(*result);
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	if (args->results)
+		result_size += (args->allocation_count - 1) *
+				sizeof(enum d3dddi_reclaim_result);
+
+	ret = init_message_res(&msg, adapter, process, cmd_size, result_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_RECLAIMALLOCATIONS,
+				   process->host_handle);
+	command->device = device;
+	command->paging_queue = args->paging_queue;
+	command->allocation_count = args->allocation_count;
+	command->write_results = args->results != NULL;
+	if (args->resources) {
+		command->resources = true;
+		ret = copy_from_user(command->allocations, args->resources,
+					 alloc_size);
+	} else {
+		ret = copy_from_user(command->allocations,
+					 args->allocations, alloc_size);
+	}
+	if (ret) {
+		pr_err("%s failed to copy input handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+	ret = copy_to_user(paging_fence_value,
+			   &result->paging_fence_value, sizeof(u64));
+	if (ret) {
+		pr_err("%s failed to copy paging fence", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = ntstatus2int(result->status);
+	if (NT_SUCCESS(result->status) && args->results) {
+		ret = copy_to_user(args->results, result->discarded,
+				   sizeof(result->discarded[0]) *
+				   args->allocation_count);
+		if (ret) {
+			pr_err("%s failed to copy results", __func__);
+			ret = -EINVAL;
+		}
+	}
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_change_vidmem_reservation(struct dxgprocess *process,
 					  struct dxgadapter *adapter,
 					  struct d3dkmthandle other_process,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 6c8ed5d547a5..7fa89ed16c2d 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -653,6 +653,33 @@ struct dxgkvmb_command_markdeviceaserror {
 	struct d3dkmt_markdeviceaserror args;
 };
 
+/* Returns ntstatus */
+struct dxgkvmb_command_offerallocations {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	u32				allocation_count;
+	enum d3dkmt_offer_priority	priority;
+	struct d3dkmt_offer_flags	flags;
+	bool				resources;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_reclaimallocations {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		paging_queue;
+	u32				allocation_count;
+	bool				resources;
+	bool				write_results;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_reclaimallocations_return {
+	u64				paging_fence_value;
+	struct ntstatus			status;
+	enum d3dddi_reclaim_result	discarded[1];
+};
+
 /* Returns ntstatus */
 struct dxgkvmb_command_changevideomemoryreservation {
 	struct dxgkvmb_command_vgpu_to_host hdr;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 4bff78c7b1d3..47ffdd1dda93 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1996,6 +1996,121 @@ dxgk_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_offer_allocations(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_offerallocations args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	pr_debug("ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.allocation_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.allocation_count == 0) {
+		pr_err("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if ((args.resources == NULL) == (args.allocations == NULL)) {
+		pr_err("invalid pointer to resources/allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_offer_allocations(process, adapter, &args);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_reclaim_allocations(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_reclaimallocations2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmt_reclaimallocations2 * __user in_args = inargs;
+
+	pr_debug("ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.allocation_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.allocation_count == 0) {
+		pr_err("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if ((args.resources == NULL) == (args.allocations == NULL)) {
+		pr_err("invalid pointer to resources/allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+						args.paging_queue);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_reclaim_allocations(process, adapter,
+					      device->handle, &args,
+					      &in_args->paging_fence_value);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_submit_command(struct dxgprocess *process, void *__user inargs)
 {
@@ -4662,8 +4777,12 @@ void init_ioctls(void)
 		  LX_DXLOCK2);
 	SET_IOCTL(/*0x26 */ dxgk_mark_device_as_error,
 		  LX_DXMARKDEVICEASERROR);
+	SET_IOCTL(/*0x27 */ dxgk_offer_allocations,
+		  LX_DXOFFERALLOCATIONS);
 	SET_IOCTL(/*0x2a */ dxgk_query_alloc_residency,
 		  LX_DXQUERYALLOCATIONRESIDENCY);
+	SET_IOCTL(/*0x2c */ dxgk_reclaim_allocations,
+		  LX_DXRECLAIMALLOCATIONS2);
 	SET_IOCTL(/*0x2e */ dxgk_set_allocation_priority,
 		  LX_DXSETALLOCATIONPRIORITY);
 	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 2cd88a9320d1..3849f714ae9c 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -57,6 +57,7 @@ struct winluid {
 #define D3DDDI_MAX_WRITTEN_PRIMARIES		16
 
 #define D3DKMT_CREATEALLOCATION_MAX		1024
+#define D3DKMT_MAKERESIDENT_ALLOC_MAX		(1024 * 10)
 #define D3DKMT_ADAPTERS_MAX			64
 #define D3DDDI_MAX_BROADCAST_CONTEXT		64
 #define D3DDDI_MAX_OBJECT_WAITED_ON		32
@@ -1083,6 +1084,68 @@ struct d3dddi_updateallocproperty {
 	};
 };
 
+enum d3dkmt_offer_priority {
+	_D3DKMT_OFFER_PRIORITY_LOW	= 1,
+	_D3DKMT_OFFER_PRIORITY_NORMAL	= 2,
+	_D3DKMT_OFFER_PRIORITY_HIGH	= 3,
+	_D3DKMT_OFFER_PRIORITY_AUTO	= 4,
+};
+
+struct d3dkmt_offer_flags {
+	union {
+		struct {
+			__u32	offer_immediately:1;
+			__u32	allow_decommit:1;
+			__u32	reserved:30;
+		};
+		__u32		value;
+	};
+};
+
+struct d3dkmt_offerallocations {
+	struct d3dkmthandle		device;
+	__u32				reserved;
+#ifdef __KERNEL__
+	struct d3dkmthandle		*resources;
+	const struct d3dkmthandle	*allocations;
+#else
+	__u64				resources;
+	__u64				allocations;
+#endif
+	__u32				allocation_count;
+	enum d3dkmt_offer_priority	priority;
+	struct d3dkmt_offer_flags	flags;
+	__u32				reserved1;
+};
+
+enum d3dddi_reclaim_result {
+	_D3DDDI_RECLAIM_RESULT_OK		= 0,
+	_D3DDDI_RECLAIM_RESULT_DISCARDED	= 1,
+	_D3DDDI_RECLAIM_RESULT_NOT_COMMITTED	= 2,
+};
+
+struct d3dkmt_reclaimallocations2 {
+	struct d3dkmthandle	paging_queue;
+	__u32			allocation_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*resources;
+	struct d3dkmthandle	*allocations;
+#else
+	__u64			resources;
+	__u64			allocations;
+#endif
+	union {
+#ifdef __KERNEL__
+		__u32				*discarded;
+		enum d3dddi_reclaim_result	*results;
+#else
+		__u64				discarded;
+		__u64				results;
+#endif
+	};
+	__u64			paging_fence_value;
+};
+
 struct d3dkmt_changevideomemoryreservation {
 	__u64			process;
 	struct d3dkmthandle	adapter;
@@ -1356,8 +1419,12 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
 #define LX_DXMARKDEVICEASERROR		\
 	_IOWR(0x47, 0x26, struct d3dkmt_markdeviceaserror)
+#define LX_DXOFFERALLOCATIONS		\
+	_IOWR(0x47, 0x27, struct d3dkmt_offerallocations)
 #define LX_DXQUERYALLOCATIONRESIDENCY	\
 	_IOWR(0x47, 0x2a, struct d3dkmt_queryallocationresidency)
+#define LX_DXRECLAIMALLOCATIONS2	\
+	_IOWR(0x47, 0x2c, struct d3dkmt_reclaimallocations2)
 #define LX_DXSETALLOCATIONPRIORITY	\
 	_IOWR(0x47, 0x2e, struct d3dkmt_setallocationpriority)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU \
-- 
2.35.1

