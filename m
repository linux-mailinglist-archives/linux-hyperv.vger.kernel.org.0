Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A74AA5E6
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379108AbiBECen (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45144 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379021AbiBECe0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:26 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 561AD20B8761;
        Fri,  4 Feb 2022 18:34:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 561AD20B8761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028466;
        bh=8fvVMjdllpeKBqGvvkWOFsZlDq64y3KJ5drWV15MeSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpWzBbTEx6S8mFwfWOFeUn458MmiIZEjRLjF0sffhdcuy4OjamGEall0jxT8QYP64
         TzlqIw9O5PFYTvSfc56TcloATcwG6iukOdN5+3Ylk8jT7XHzbKKJD1aCMGnIHmBJ9t
         7GCze9kMmjE9ePkAaqCPo1+Zk5xKri2NQ6TBmFXo=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 17/24] drivers: hv: dxgkrnl: IOCTLs to handle GPU allocation properties
Date:   Fri,  4 Feb 2022 18:34:15 -0800
Message-Id: <60ae85e5fed288205df8fdaeec720fd91946200e.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

LX_DXCHANGEVIDEOMEMORYRESERVATION,
LX_DXUPDATEALLOCPROPERTY,
LX_DXSETALLOCATIONPRIORITY,
LX_DXGETALLOCATIONPRIORITY,
LX_DXQUERYALLOCATIONRESIDENCY.

Implement various IOCTLs related to GPU allocations. The IOCTLs
are logically simple and have the same implementation pattern:
- Read input data
- Build and send a VM bus message to the host
- Return results to the caller

- LX_DXCHANGEVIDEOMEMORYRESERVATION (D3DKMTChangeMemoryReservation)

- LX_DXUPDATEALLOCPROPERTY (D3DKMTUpdateAllocationProperty)
  Request the host to update verious properties of an allocation.

- LX_DXSETALLOCATIONPRIORITY, LX_DXGETALLOCATIONPRIORITY
  Set/get allocation priority, which defines how soon the allocation
  is evicted from GPU accessible memory.

- LX_DXQUERYALLOCATIONRESIDENCY (D3DKMTQueryAllocationResidency)
  Queries if the allocation is located in the GPU accessible memory.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  21 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 300 ++++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 212 ++++++++++++++++++++++++
 3 files changed, 533 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index fa46abf0350a..128c5cd2be3d 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -825,6 +825,23 @@ int dxgvmb_send_lock2(struct dxgprocess *process,
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
@@ -844,6 +861,10 @@ int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
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
index a064efa320cf..a1bb7a10bf60 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1774,6 +1774,79 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
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
@@ -2401,6 +2474,233 @@ int dxgvmb_send_unlock2(struct dxgprocess *process,
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
-- 
2.35.1

