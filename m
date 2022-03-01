Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD5B4C94EC
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiCATra (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiCATr0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:26 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE97E6D3A5;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id B9ABA20B4919;
        Tue,  1 Mar 2022 11:46:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9ABA20B4919
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163993;
        bh=j5sPVZ/n6Xc+LmmjF67a3nhDxrWnR/uMbvRINgjIltc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYYVpZkzxB+H92sZJH8qaiTdyT+7nKMAuF3H2HLwCwz/afv6FQRJ84ixdOKnm/l/0
         UBoCSpK5Lpx9w1wZgAVB5yHnHulNkCX5jCdl7Z2MVHrEzk9NX2FSd2J8d8tDOFxEeN
         wIQ6Q3U8o5+kwI78YIblelLuPY03ymcz5f6dw8dQ=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 20/30] drivers: hv: dxgkrnl: Manage device allocation properties
Date:   Tue,  1 Mar 2022 11:46:07 -0800
Message-Id: <f949c64e28d098f873d61de49e143c04d2ee7187.1646163378.git.iourit@linux.microsoft.com>
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

Implement ioctls to manage properties of a compute device allocation:
  - LX_DXUPDATEALLOCPROPERTY,
  - LX_DXSETALLOCATIONPRIORITY,
  - LX_DXGETALLOCATIONPRIORITY,
  - LX_DXQUERYALLOCATIONRESIDENCY.
  - LX_DXCHANGEVIDEOMEMORYRESERVATION,

The LX_DXUPDATEALLOCPROPERTY ioctl requests the host to update
various properties of a compute devoce allocation.

The LX_DXSETALLOCATIONPRIORITY and LX_DXGETALLOCATIONPRIORITY ioctls
are used to set/get allocation priority, which defines the
importance of the allocation to be in the local device memory.

The LX_DXQUERYALLOCATIONRESIDENCY ioctl queries if the allocation
is located in the compute device accessible memory.

The LX_DXCHANGEVIDEOMEMORYRESERVATION ioctl changes compute device
memory reservation of an allocation.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  21 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 300 ++++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  50 ++++++
 drivers/hv/dxgkrnl/ioctl.c    | 212 ++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  | 127 ++++++++++++++
 5 files changed, 710 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index cf41a3eef75e..e50f9dbbd5fb 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -831,6 +831,23 @@ int dxgvmb_send_lock2(struct dxgprocess *process,
 int dxgvmb_send_unlock2(struct dxgprocess *process,
 			struct dxgadapter *adapter,
 			struct d3dkmt_unlock2 *args);
+int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
+				      struct dxgadapter *adapter,
+				      struct d3dddi_updateallocproperty *args,
+				      struct d3dddi_updateallocproperty *__user
+				      inargs);
+int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
+					struct dxgadapter *adapter,
+					struct d3dkmt_setallocationpriority *a);
+int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
+					struct dxgadapter *adapter,
+					struct d3dkmt_getallocationpriority *a);
+int dxgvmb_send_change_vidmem_reservation(struct dxgprocess *process,
+					  struct dxgadapter *adapter,
+					  struct d3dkmthandle other_process,
+					  struct
+					  d3dkmt_changevideomemoryreservation
+					  *args);
 int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_createhwqueue *args,
@@ -850,6 +867,10 @@ int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
 				    struct d3dkmt_opensyncobjectfromnthandle2
 				    *args,
 				    struct dxgsyncobject *syncobj);
+int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
+				      struct dxgadapter *adapter,
+				      struct d3dkmt_queryallocationresidency
+				      *args);
 int dxgvmb_send_get_device_state(struct dxgprocess *process,
 				 struct dxgadapter *adapter,
 				 struct d3dkmt_getdevicestate *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 0c2796934d1d..7c95f63e7f88 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1812,6 +1812,79 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
+				      struct dxgadapter *adapter,
+				      struct d3dkmt_queryallocationresidency
+				      *args)
+{
+	int ret = -EINVAL;
+	struct dxgkvmb_command_queryallocationresidency *command = NULL;
+	u32 cmd_size = sizeof(*command);
+	u32 alloc_size = 0;
+	u32 result_allocation_size = 0;
+	struct dxgkvmb_command_queryallocationresidency_return *result = NULL;
+	u32 result_size = sizeof(*result);
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	if (args->allocation_count > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args->allocation_count) {
+		alloc_size = args->allocation_count *
+			     sizeof(struct d3dkmthandle);
+		cmd_size += alloc_size;
+		result_allocation_size = args->allocation_count *
+		    sizeof(args->residency_status[0]);
+	} else {
+		result_allocation_size = sizeof(args->residency_status[0]);
+	}
+	result_size += result_allocation_size;
+
+	ret = init_message_res(&msg, adapter, process, cmd_size, result_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_QUERYALLOCATIONRESIDENCY,
+				   process->host_handle);
+	command->args = *args;
+	if (alloc_size) {
+		ret = copy_from_user(&command[1], args->allocations,
+				     alloc_size);
+		if (ret) {
+			pr_err("%s failed to copy alloc handles", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result->status);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(args->residency_status, &result[1],
+			   result_allocation_size);
+	if (ret) {
+		pr_err("%s failed to copy residency status", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_get_device_state(struct dxgprocess *process,
 				 struct dxgadapter *adapter,
 				 struct d3dkmt_getdevicestate *args,
@@ -2439,6 +2512,233 @@ int dxgvmb_send_unlock2(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
+				      struct dxgadapter *adapter,
+				      struct d3dddi_updateallocproperty *args,
+				      struct d3dddi_updateallocproperty *__user
+				      inargs)
+{
+	int ret;
+	int ret1;
+	struct dxgkvmb_command_updateallocationproperty *command;
+	struct dxgkvmb_command_updateallocationproperty_return result = { };
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_UPDATEALLOCATIONPROPERTY,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+
+	if (ret < 0)
+		goto cleanup;
+	ret = ntstatus2int(result.status);
+	/* STATUS_PENING is a success code > 0 */
+	if (ret == STATUS_PENDING) {
+		ret1 = copy_to_user(&inargs->paging_fence_value,
+				    &result.paging_fence_value,
+				    sizeof(u64));
+		if (ret1) {
+			pr_err("%s failed to copy paging fence", __func__);
+			ret = -EINVAL;
+		}
+	}
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
+				struct dxgadapter *adapter,
+				struct d3dkmt_setallocationpriority *args)
+{
+	u32 cmd_size = sizeof(struct dxgkvmb_command_setallocationpriority);
+	u32 alloc_size = 0;
+	u32 priority_size = 0;
+	struct dxgkvmb_command_setallocationpriority *command;
+	int ret;
+	struct d3dkmthandle *allocations;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (args->allocation_count > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (args->resource.v) {
+		priority_size = sizeof(u32);
+		if (args->allocation_count != 0) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		if (args->allocation_count == 0) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		alloc_size = args->allocation_count *
+			     sizeof(struct d3dkmthandle);
+		cmd_size += alloc_size;
+		priority_size = sizeof(u32) * args->allocation_count;
+	}
+	cmd_size += priority_size;
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_SETALLOCATIONPRIORITY,
+				   process->host_handle);
+	command->device = args->device;
+	command->allocation_count = args->allocation_count;
+	command->resource = args->resource;
+	allocations = (struct d3dkmthandle *) &command[1];
+	ret = copy_from_user(allocations, args->allocation_list,
+			     alloc_size);
+	if (ret) {
+		pr_err("%s failed to copy alloc handle", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_from_user((u8 *) allocations + alloc_size,
+				args->priorities, priority_size);
+	if (ret) {
+		pr_err("%s failed to copy alloc priority", __func__);
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
+int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
+				struct dxgadapter *adapter,
+				struct d3dkmt_getallocationpriority *args)
+{
+	u32 cmd_size = sizeof(struct dxgkvmb_command_getallocationpriority);
+	u32 result_size;
+	u32 alloc_size = 0;
+	u32 priority_size = 0;
+	struct dxgkvmb_command_getallocationpriority *command;
+	struct dxgkvmb_command_getallocationpriority_return *result;
+	int ret;
+	struct d3dkmthandle *allocations;
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	if (args->allocation_count > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (args->resource.v) {
+		priority_size = sizeof(u32);
+		if (args->allocation_count != 0) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		if (args->allocation_count == 0) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		alloc_size = args->allocation_count *
+			sizeof(struct d3dkmthandle);
+		cmd_size += alloc_size;
+		priority_size = sizeof(u32) * args->allocation_count;
+	}
+	result_size = sizeof(*result) + priority_size;
+
+	ret = init_message_res(&msg, adapter, process, cmd_size, result_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_GETALLOCATIONPRIORITY,
+				   process->host_handle);
+	command->device = args->device;
+	command->allocation_count = args->allocation_count;
+	command->resource = args->resource;
+	allocations = (struct d3dkmthandle *) &command[1];
+	ret = copy_from_user(allocations, args->allocation_list,
+			     alloc_size);
+	if (ret) {
+		pr_err("%s failed to copy alloc handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr,
+				   msg.size + msg.res_size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result->status);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(args->priorities,
+			   (u8 *) result + sizeof(*result),
+			   priority_size);
+	if (ret) {
+		pr_err("%s failed to copy priorities", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_change_vidmem_reservation(struct dxgprocess *process,
+					  struct dxgadapter *adapter,
+					  struct d3dkmthandle other_process,
+					  struct
+					  d3dkmt_changevideomemoryreservation
+					  *args)
+{
+	struct dxgkvmb_command_changevideomemoryreservation *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_CHANGEVIDEOMEMORYRESERVATION,
+				   process->host_handle);
+	command->args = *args;
+	command->args.process = other_process.v;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_createhwqueue *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 3e2edfeefd1a..5b7654ef63f3 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -308,6 +308,29 @@ struct dxgkvmb_command_queryadapterinfo_return {
 	u8				private_data[1];
 };
 
+/* Returns ntstatus */
+struct dxgkvmb_command_setallocationpriority {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+	u32				allocation_count;
+	/* struct d3dkmthandle    allocations[allocation_count or 0]; */
+	/* u32 priorities[allocation_count or 1]; */
+};
+
+struct dxgkvmb_command_getallocationpriority {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+	u32				allocation_count;
+	/* struct d3dkmthandle allocations[allocation_count or 0]; */
+};
+
+struct dxgkvmb_command_getallocationpriority_return {
+	struct ntstatus			status;
+	/* u32 priorities[allocation_count or 1]; */
+};
+
 struct dxgkvmb_command_createdevice {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_createdeviceflags	flags;
@@ -589,6 +612,22 @@ struct dxgkvmb_command_unlock2 {
 	bool				use_legacy_unlock;
 };
 
+struct dxgkvmb_command_updateallocationproperty {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dddi_updateallocproperty args;
+};
+
+struct dxgkvmb_command_updateallocationproperty_return {
+	u64				paging_fence_value;
+	struct ntstatus			status;
+};
+
+/* Returns ntstatus */
+struct dxgkvmb_command_changevideomemoryreservation {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_changevideomemoryreservation args;
+};
+
 /* Returns the same structure */
 struct dxgkvmb_command_createhwqueue {
 	struct dxgkvmb_command_vgpu_to_host hdr;
@@ -609,6 +648,17 @@ struct dxgkvmb_command_destroyhwqueue {
 	struct d3dkmthandle		hwqueue;
 };
 
+struct dxgkvmb_command_queryallocationresidency {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_queryallocationresidency args;
+	/* struct d3dkmthandle allocations[0 or number of allocations] */
+};
+
+struct dxgkvmb_command_queryallocationresidency_return {
+	struct ntstatus			status;
+	/* d3dkmt_allocationresidencystatus[NumAllocations] */
+};
+
 struct dxgkvmb_command_getdevicestate {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_getdevicestate	args;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 12a4593c6aa5..7ebad4524f94 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3337,6 +3337,208 @@ dxgk_unlock2(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_update_alloc_property(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dddi_updateallocproperty args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
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
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_update_alloc_property(process, adapter,
+						&args, inargs);
+
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_query_alloc_residency(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryallocationresidency args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if ((args.allocation_count == 0) == (args.resource.v == 0)) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	ret = dxgvmb_send_query_alloc_residency(process, adapter, &args);
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_set_allocation_priority(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_setallocationpriority args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	ret = dxgvmb_send_set_allocation_priority(process, adapter, &args);
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_get_allocation_priority(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_getallocationpriority args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	ret = dxgvmb_send_get_allocation_priority(process, adapter, &args);
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_changevideomemoryreservation args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	bool adapter_locked = false;
+
+	pr_debug("ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.process != 0) {
+		pr_err("setting memory reservation for other process");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	adapter_locked = true;
+	args.adapter.v = 0;
+	ret = dxgvmb_send_change_vidmem_reservation(process, adapter,
+						    zerohandle, &args);
+
+cleanup:
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_get_device_state(struct dxgprocess *process, void *__user inargs)
 {
@@ -4158,6 +4360,8 @@ void init_ioctls(void)
 		  LX_DXENUMADAPTERS2);
 	SET_IOCTL(/*0x15 */ dxgk_close_adapter,
 		  LX_DXCLOSEADAPTER);
+	SET_IOCTL(/*0x16 */ dxgk_change_vidmem_reservation,
+		  LX_DXCHANGEVIDEOMEMORYRESERVATION);
 	SET_IOCTL(/*0x18 */ dxgk_create_hwqueue,
 		  LX_DXCREATEHWQUEUE);
 	SET_IOCTL(/*0x19 */ dxgk_destroy_device,
@@ -4170,6 +4374,10 @@ void init_ioctls(void)
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x25 */ dxgk_lock2,
 		  LX_DXLOCK2);
+	SET_IOCTL(/*0x2a */ dxgk_query_alloc_residency,
+		  LX_DXQUERYALLOCATIONRESIDENCY);
+	SET_IOCTL(/*0x2e */ dxgk_set_allocation_priority,
+		  LX_DXSETALLOCATIONPRIORITY);
 	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
 		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x32 */ dxgk_signal_sync_object_gpu,
@@ -4184,10 +4392,14 @@ void init_ioctls(void)
 		  LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE);
 	SET_IOCTL(/*0x37 */ dxgk_unlock2,
 		  LX_DXUNLOCK2);
+	SET_IOCTL(/*0x38 */ dxgk_update_alloc_property,
+		  LX_DXUPDATEALLOCPROPERTY);
 	SET_IOCTL(/*0x3a */ dxgk_wait_sync_object_cpu,
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x3b */ dxgk_wait_sync_object_gpu,
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU);
+	SET_IOCTL(/*0x3c */ dxgk_get_allocation_priority,
+		  LX_DXGETALLOCATIONPRIORITY);
 	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
 		  LX_DXENUMADAPTERS3);
 	SET_IOCTL(/*0x3f */ dxgk_share_objects,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 5bc1535ea881..2dac2d13196a 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -664,6 +664,63 @@ struct d3dkmt_submitcommandtohwqueue {
 #endif
 };
 
+struct d3dkmt_setallocationpriority {
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocation_list;
+#else
+	__u64				allocation_list;
+#endif
+	__u32				allocation_count;
+	__u32				reserved;
+#ifdef __KERNEL__
+	const __u32			*priorities;
+#else
+	__u64				priorities;
+#endif
+};
+
+struct d3dkmt_getallocationpriority {
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocation_list;
+#else
+	__u64				allocation_list;
+#endif
+	__u32				allocation_count;
+	__u32				reserved;
+#ifdef __KERNEL__
+	__u32				*priorities;
+#else
+	__u64				priorities;
+#endif
+};
+
+enum d3dkmt_allocationresidencystatus {
+	_D3DKMT_ALLOCATIONRESIDENCYSTATUS_RESIDENTINGPUMEMORY		= 1,
+	_D3DKMT_ALLOCATIONRESIDENCYSTATUS_RESIDENTINSHAREDMEMORY	= 2,
+	_D3DKMT_ALLOCATIONRESIDENCYSTATUS_NOTRESIDENT			= 3,
+};
+
+struct d3dkmt_queryallocationresidency {
+	struct d3dkmthandle			device;
+	struct d3dkmthandle			resource;
+#ifdef __KERNEL__
+	struct d3dkmthandle			*allocations;
+#else
+	__u64					allocations;
+#endif
+	__u32					allocation_count;
+	__u32					reserved;
+#ifdef __KERNEL__
+	enum d3dkmt_allocationresidencystatus	*residency_status;
+#else
+	__u64					residency_status;
+#endif
+};
+
 struct d3dddicb_lock2flags {
 	union {
 		struct {
@@ -831,6 +888,11 @@ struct d3dkmt_destroyallocation2 {
 	struct d3dddicb_destroyallocation2flags flags;
 };
 
+enum d3dkmt_memory_segment_group {
+	_D3DKMT_MEMORY_SEGMENT_GROUP_LOCAL	= 0,
+	_D3DKMT_MEMORY_SEGMENT_GROUP_NON_LOCAL	= 1
+};
+
 struct d3dkmt_adaptertype {
 	union {
 		struct {
@@ -882,6 +944,61 @@ struct d3dddi_openallocationinfo2 {
 	__u64			reserved[6];
 };
 
+struct d3dddi_updateallocproperty_flags {
+	union {
+		struct {
+			__u32			accessed_physically:1;
+			__u32			reserved:31;
+		};
+		__u32				value;
+	};
+};
+
+struct d3dddi_segmentpreference {
+	union {
+		struct {
+			__u32			segment_id0:5;
+			__u32			direction0:1;
+			__u32			segment_id1:5;
+			__u32			direction1:1;
+			__u32			segment_id2:5;
+			__u32			direction2:1;
+			__u32			segment_id3:5;
+			__u32			direction3:1;
+			__u32			segment_id4:5;
+			__u32			direction4:1;
+			__u32			reserved:2;
+		};
+		__u32				value;
+	};
+};
+
+struct d3dddi_updateallocproperty {
+	struct d3dkmthandle			paging_queue;
+	struct d3dkmthandle			allocation;
+	__u32					supported_segment_set;
+	struct d3dddi_segmentpreference		preferred_segment;
+	struct d3dddi_updateallocproperty_flags	flags;
+	__u64					paging_fence_value;
+	union {
+		struct {
+			__u32			set_accessed_physically:1;
+			__u32			set_supported_segmentSet:1;
+			__u32			set_preferred_segment:1;
+			__u32			reserved:29;
+		};
+		__u32				property_mask_value;
+	};
+};
+
+struct d3dkmt_changevideomemoryreservation {
+	__u64			process;
+	struct d3dkmthandle	adapter;
+	enum d3dkmt_memory_segment_group memory_segment_group;
+	__u64			reservation;
+	__u32			physical_adapter_index;
+};
+
 struct d3dkmt_createhwqueue {
 	struct d3dkmthandle	context;
 	struct d3dddi_createhwqueueflags flags;
@@ -1095,6 +1212,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x14, struct d3dkmt_enumadapters2)
 #define LX_DXCLOSEADAPTER		\
 	_IOWR(0x47, 0x15, struct d3dkmt_closeadapter)
+#define LX_DXCHANGEVIDEOMEMORYRESERVATION \
+	_IOWR(0x47, 0x16, struct d3dkmt_changevideomemoryreservation)
 #define LX_DXCREATEHWQUEUE		\
 	_IOWR(0x47, 0x18, struct d3dkmt_createhwqueue)
 #define LX_DXDESTROYHWQUEUE		\
@@ -1107,6 +1226,10 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
 #define LX_DXLOCK2			\
 	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
+#define LX_DXQUERYALLOCATIONRESIDENCY	\
+	_IOWR(0x47, 0x2a, struct d3dkmt_queryallocationresidency)
+#define LX_DXSETALLOCATIONPRIORITY	\
+	_IOWR(0x47, 0x2e, struct d3dkmt_setallocationpriority)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU \
 	_IOWR(0x47, 0x31, struct d3dkmt_signalsynchronizationobjectfromcpu)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU \
@@ -1121,10 +1244,14 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x36, struct d3dkmt_submitwaitforsyncobjectstohwqueue)
 #define LX_DXUNLOCK2			\
 	_IOWR(0x47, 0x37, struct d3dkmt_unlock2)
+#define LX_DXUPDATEALLOCPROPERTY	\
+	_IOWR(0x47, 0x38, struct d3dddi_updateallocproperty)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU \
 	_IOWR(0x47, 0x3a, struct d3dkmt_waitforsynchronizationobjectfromcpu)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU \
 	_IOWR(0x47, 0x3b, struct d3dkmt_waitforsynchronizationobjectfromgpu)
+#define LX_DXGETALLOCATIONPRIORITY	\
+	_IOWR(0x47, 0x3c, struct d3dkmt_getallocationpriority)
 #define LX_DXENUMADAPTERS3		\
 	_IOWR(0x47, 0x3e, struct d3dkmt_enumadapters3)
 #define LX_DXSHAREOBJECTS		\
-- 
2.35.1

