Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764C34C94CD
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiCATrg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237346AbiCATr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:27 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E8056D4F5;
        Tue,  1 Mar 2022 11:46:37 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4D8FB20B4784;
        Tue,  1 Mar 2022 11:46:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D8FB20B4784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163995;
        bh=/Sy7sYYCaagQ04pZD5ZlDuw6uHNmW5vIvJzWgaUFnC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rffHMHe0wRzqVN6d5fenAOROTgwiKynaEQgRRiDmfp21E6lCaBgsQdBeGengINawg
         okCmc4m91ouwbW7PKQRXKMJQgLWZnBqLnVmb8TlJ1F62BbxcRujpyGG44cINWw7sqx
         Zk/6a9qedSyRZYilhDRlHB9gmVocgkyyLS3Gdx34=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 28/30] drivers: hv: dxgkrnl: Manage residency of allocations
Date:   Tue,  1 Mar 2022 11:46:15 -0800
Message-Id: <ba2e10e1ed44875909069ea399d34619c0937f91.1646163379.git.iourit@linux.microsoft.com>
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

Implement ioctls to manage residency of compute device allocations:
  - LX_DXMAKERESIDENT,
  - LX_DXEVICT.

An allocation is "resident" when the compute devoce is setup to
access it. It means that the allocation is in the local device
memory or in non-pageable system memory.

The current design does not support on demand compute device page
faulting. An allocation must be resident before the compute device
is allowed to access it.

The LX_DXMAKERESIDENT ioctl instructs the video memory manager to
make the given allocations resident. The operation is submitted to
a paging queue (dxgpagingqueue). When the ioctl returns a "pending"
status, a monitored fence sync object can be used to synchronize
with the completion of the operation.

The LX_DXEVICT ioctl istructs the video memory manager to evict
the given allocations from device accessible memory.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   4 +
 drivers/hv/dxgkrnl/dxgvmbus.c |  98 +++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  27 +++++++
 drivers/hv/dxgkrnl/ioctl.c    | 144 ++++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  |  54 +++++++++++++
 5 files changed, 327 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 00c3bb5f3ab8..c841203a1683 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -790,6 +790,10 @@ int dxgvmb_send_create_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 int dxgvmb_send_destroy_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 				   struct d3dkmt_destroyallocation2 *args,
 				   struct d3dkmthandle *alloc_handles);
+int dxgvmb_send_make_resident(struct dxgprocess *pr, struct dxgadapter *adapter,
+			      struct d3dddi_makeresident *args);
+int dxgvmb_send_evict(struct dxgprocess *pr, struct dxgadapter *adapter,
+		      struct d3dkmt_evict *args);
 int dxgvmb_send_submit_command(struct dxgprocess *pr,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_submitcommand *args);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 2f0914b71c3c..9f5b8edb186e 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2262,6 +2262,104 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 	return ret;
 }
 
+int dxgvmb_send_make_resident(struct dxgprocess *process,
+			      struct dxgadapter *adapter,
+			      struct d3dddi_makeresident *args)
+{
+	int ret;
+	u32 cmd_size;
+	struct dxgkvmb_command_makeresident_return result = { };
+	struct dxgkvmb_command_makeresident *command = NULL;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	cmd_size = (args->alloc_count - 1) * sizeof(struct d3dkmthandle) +
+		   sizeof(struct dxgkvmb_command_makeresident);
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	ret = copy_from_user(command->allocations, args->allocation_list,
+			     args->alloc_count *
+			     sizeof(struct d3dkmthandle));
+	if (ret) {
+		pr_err("%s failed to copy alloc handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_MAKERESIDENT,
+				   process->host_handle);
+	command->alloc_count = args->alloc_count;
+	command->paging_queue = args->paging_queue;
+	command->flags = args->flags;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0) {
+		pr_err("send_make_resident failed %x", ret);
+		goto cleanup;
+	}
+
+	args->paging_fence_value = result.paging_fence_value;
+	args->num_bytes_to_trim = result.num_bytes_to_trim;
+	ret = ntstatus2int(result.status);
+
+cleanup:
+
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_evict(struct dxgprocess *process,
+		      struct dxgadapter *adapter,
+		      struct d3dkmt_evict *args)
+{
+	int ret;
+	u32 cmd_size;
+	struct dxgkvmb_command_evict_return result = { };
+	struct dxgkvmb_command_evict *command = NULL;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	cmd_size = (args->alloc_count - 1) * sizeof(struct d3dkmthandle) +
+	    sizeof(struct dxgkvmb_command_evict);
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	ret = copy_from_user(command->allocations, args->allocations,
+			     args->alloc_count *
+			     sizeof(struct d3dkmthandle));
+	if (ret) {
+		pr_err("%s failed to copy alloc handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_EVICT, process->host_handle);
+	command->alloc_count = args->alloc_count;
+	command->device = args->device;
+	command->flags = args->flags;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0) {
+		pr_err("send_evict failed %x", ret);
+		goto cleanup;
+	}
+	args->num_bytes_to_trim = result.num_bytes_to_trim;
+
+cleanup:
+
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_submit_command(struct dxgprocess *process,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_submitcommand *args)
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 2e522d6652da..59357bd5c7b9 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -372,6 +372,33 @@ struct dxgkvmb_command_flushdevice {
 	enum dxgdevice_flushschedulerreason	reason;
 };
 
+struct dxgkvmb_command_makeresident {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		paging_queue;
+	struct d3dddi_makeresident_flags flags;
+	u32				alloc_count;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_makeresident_return {
+	u64			paging_fence_value;
+	u64			num_bytes_to_trim;
+	struct ntstatus		status;
+};
+
+struct dxgkvmb_command_evict {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dddi_evict_flags	flags;
+	u32				alloc_count;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_evict_return {
+	u64			num_bytes_to_trim;
+};
+
 struct dxgkvmb_command_submitcommand {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_submitcommand	args;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 0a4fca6ee2aa..a90c1a897d55 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1996,6 +1996,146 @@ dxgk_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_make_resident(struct dxgprocess *process, void *__user inargs)
+{
+	int ret, ret2;
+	struct d3dddi_makeresident args;
+	struct d3dddi_makeresident *input = inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	pr_debug("ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.alloc_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.alloc_count == 0) {
+		pr_err("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (args.paging_queue.v == 0) {
+		pr_err("paging queue is missing");
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
+	ret = dxgvmb_send_make_resident(process, adapter, &args);
+	if (ret < 0)
+		goto cleanup;
+	/* STATUS_PENING is a success code > 0. It is returned to user mode */
+	if (!(ret == STATUS_PENDING || ret == 0)) {
+		pr_err("%s Unexpected error %x", __func__, ret);
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->paging_fence_value,
+			    &args.paging_fence_value, sizeof(u64));
+	if (ret2) {
+		pr_err("%s failed to copy paging fence", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->num_bytes_to_trim,
+			    &args.num_bytes_to_trim, sizeof(u64));
+	if (ret2) {
+		pr_err("%s failed to copy bytes to trim", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+
+	return ret;
+}
+
+static int
+dxgk_evict(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_evict args;
+	struct d3dkmt_evict *input = inargs;
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
+	if (args.alloc_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.alloc_count == 0) {
+		pr_err("invalid number of allocations");
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
+	ret = dxgvmb_send_evict(process, adapter, &args);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(&input->num_bytes_to_trim,
+			   &args.num_bytes_to_trim, sizeof(u64));
+	if (ret) {
+		pr_err("%s failed to copy bytes to trim to user", __func__);
+		ret = -EINVAL;
+	}
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
 dxgk_offer_allocations(struct dxgprocess *process, void *__user inargs)
 {
@@ -4906,6 +5046,8 @@ void init_ioctls(void)
 		  LX_DXQUERYADAPTERINFO);
 	SET_IOCTL(/*0xa */ dxgk_query_vidmem_info,
 		  LX_DXQUERYVIDEOMEMORYINFO);
+	SET_IOCTL(/*0xb */ dxgk_make_resident,
+		  LX_DXMAKERESIDENT);
 	SET_IOCTL(/*0xd */ dxgk_escape,
 		  LX_DXESCAPE);
 	SET_IOCTL(/*0xe */ dxgk_get_device_state,
@@ -4936,6 +5078,8 @@ void init_ioctls(void)
 		  LX_DXDESTROYPAGINGQUEUE);
 	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x1e */ dxgk_evict,
+		  LX_DXEVICT);
 	SET_IOCTL(/*0x1f */ dxgk_flush_heap_transitions,
 		  LX_DXFLUSHHEAPTRANSITIONS);
 	SET_IOCTL(/*0x21 */ dxgk_get_context_process_scheduling_priority,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 11e2f3c9c88c..95d6df5f01b5 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -958,6 +958,56 @@ struct d3dkmt_destroyallocation2 {
 	struct d3dddicb_destroyallocation2flags flags;
 };
 
+struct d3dddi_makeresident_flags {
+	union {
+		struct {
+			__u32		cant_trim_further:1;
+			__u32		must_succeed:1;
+			__u32		reserved:30;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dddi_makeresident {
+	struct d3dkmthandle		paging_queue;
+	__u32				alloc_count;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocation_list;
+	const __u32			*priority_list;
+#else
+	__u64				allocation_list;
+	__u64				priority_list;
+#endif
+	struct d3dddi_makeresident_flags flags;
+	__u64				paging_fence_value;
+	__u64				num_bytes_to_trim;
+};
+
+struct d3dddi_evict_flags {
+	union {
+		struct {
+			__u32		evict_only_if_necessary:1;
+			__u32		not_written_to:1;
+			__u32		reserved:30;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dkmt_evict {
+	struct d3dkmthandle		device;
+	__u32				alloc_count;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocations;
+#else
+	__u64				allocations;
+#endif
+	struct d3dddi_evict_flags	flags;
+	__u32				reserved;
+	__u64				num_bytes_to_trim;
+};
+
 enum d3dkmt_memory_segment_group {
 	_D3DKMT_MEMORY_SEGMENT_GROUP_LOCAL	= 0,
 	_D3DKMT_MEMORY_SEGMENT_GROUP_NON_LOCAL	= 1
@@ -1403,6 +1453,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXQUERYVIDEOMEMORYINFO	\
 	_IOWR(0x47, 0x0a, struct d3dkmt_queryvideomemoryinfo)
+#define LX_DXMAKERESIDENT		\
+	_IOWR(0x47, 0x0b, struct d3dddi_makeresident)
 #define LX_DXESCAPE			\
 	_IOWR(0x47, 0x0d, struct d3dkmt_escape)
 #define LX_DXGETDEVICESTATE		\
@@ -1433,6 +1485,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
 #define LX_DXDESTROYSYNCHRONIZATIONOBJECT \
 	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
+#define LX_DXEVICT			\
+	_IOWR(0x47, 0x1e, struct d3dkmt_evict)
 #define LX_DXFLUSHHEAPTRANSITIONS	\
 	_IOWR(0x47, 0x1f, struct d3dkmt_flushheaptransitions)
 #define LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY \
-- 
2.35.1

