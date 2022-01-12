Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEBA48CC99
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 20:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350883AbiALT4j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 14:56:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33342 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357568AbiALTzU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 14:55:20 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8AD3F20B718A;
        Wed, 12 Jan 2022 11:55:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AD3F20B718A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642017316;
        bh=DqLlpJK6ypwntjsMQHRJQYysRt0xBLWvI9KxtSJ5I3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ae9Fywl4zuYY9hoZQpFhteI1t4cvvpyKjjcXXGTyOcLInUWgMyMtTSZOSstVZ47F9
         uWHt0jA3u97u+iA3Xsvoy26akUWrkAKH7A6Ncg8Qi9wefs7zBsS92inMtDf1MVV5tZ
         XAvmwreXd1aiTmVnJgpWx+vyxO08HehYly0z6FB4=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 7/9] drivers: hv: dxgkrnl: Implementation of submit command, paging and hardware queue.
Date:   Wed, 12 Jan 2022 11:55:12 -0800
Message-Id: <8bd750a810ac1b3c1cc7aceba7bdc61e1c05b428.1641937420.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641937419.git.iourit@linux.microsoft.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement various IOCTLs to deal with hardware queues and  paging queues.
Hardware queues are used when a compute device supports "hardware
scheduling". This means that the compute device itself schedules execution
of DMA buffers from hardware queues without CPU intervention. This is as
oppose to the "packet scheduling" mode where the software GPU scheduler
on the host schedules DMA buffer execution.

LX_DXSUBMITCOMMAND
   This IOCTL is used to submit GPU commands when the device supports the
   "packet scheduling" mode.

LX_DXSUBMITCOMMANDTOHWQUEUE
   This IOCTL is used to submit GPU commands when the device supports the
   "hardware scheduling" mode.

LX_DXCREATEPAGINGQUEUE, LX_DXDESTROYPAGINGQUEUE
   These IOCTLs are used to create/destroy a paging queue.
   Paging queues are used to handle residency of device accessible
   allocations. An allocation is resident, when the device has access to
   it. For example, the allocation resides in local device memory or
   device page tables point to system memory which is made non-pageable.

LX_DXCREATEHWQUEUE, LX_DXDESTROYHWQUEUE
   These IOCTLs are used to create/destroy hardware queue objects.
   Hardware queues are used when the compute device supports the
   "hardware scheduling" mode.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 164 ++++++++-
 drivers/hv/dxgkrnl/dxgvmbus.c   | 341 +++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c      | 634 ++++++++++++++++++++++++++++++++
 3 files changed, 1130 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index da6d7c4a7dc5..e7424f549c56 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -728,6 +728,26 @@ void dxgdevice_release(struct kref *refcount)
 	vfree(device);
 }
 
+void dxgdevice_add_paging_queue(struct dxgdevice *device,
+				struct dxgpagingqueue *entry)
+{
+	dxgdevice_acquire_alloc_list_lock(device);
+	list_add_tail(&entry->pqueue_list_entry, &device->pqueue_list_head);
+	dxgdevice_release_alloc_list_lock(device);
+}
+
+void dxgdevice_remove_paging_queue(struct dxgpagingqueue *pqueue)
+{
+	struct dxgdevice *device = pqueue->device;
+
+	dxgdevice_acquire_alloc_list_lock(device);
+	if (pqueue->pqueue_list_entry.next) {
+		list_del(&pqueue->pqueue_list_entry);
+		pqueue->pqueue_list_entry.next = NULL;
+	}
+	dxgdevice_release_alloc_list_lock(device);
+}
+
 void dxgdevice_add_syncobj(struct dxgdevice *device,
 			   struct dxgsyncobject *syncobj)
 {
@@ -819,6 +839,38 @@ void dxgcontext_release(struct kref *refcount)
 	vfree(context);
 }
 
+int dxgcontext_add_hwqueue(struct dxgcontext *context,
+			   struct dxghwqueue *hwqueue)
+{
+	int ret = 0;
+
+	down_write(&context->hwqueue_list_lock);
+	if (dxgcontext_is_active(context))
+		list_add_tail(&hwqueue->hwqueue_list_entry,
+			      &context->hwqueue_list_head);
+	else
+		ret = -ENODEV;
+	up_write(&context->hwqueue_list_lock);
+	return ret;
+}
+
+void dxgcontext_remove_hwqueue(struct dxgcontext *context,
+			       struct dxghwqueue *hwqueue)
+{
+	if (hwqueue->hwqueue_list_entry.next) {
+		list_del(&hwqueue->hwqueue_list_entry);
+		hwqueue->hwqueue_list_entry.next = NULL;
+	}
+}
+
+void dxgcontext_remove_hwqueue_safe(struct dxgcontext *context,
+				    struct dxghwqueue *hwqueue)
+{
+	down_write(&context->hwqueue_list_lock);
+	dxgcontext_remove_hwqueue(context, hwqueue);
+	up_write(&context->hwqueue_list_lock);
+}
+
 struct dxgallocation *dxgallocation_create(struct dxgprocess *process)
 {
 	struct dxgallocation *alloc = vzalloc(sizeof(struct dxgallocation));
@@ -890,6 +942,59 @@ void dxgallocation_destroy(struct dxgallocation *alloc)
 	vfree(alloc);
 }
 
+struct dxgpagingqueue *dxgpagingqueue_create(struct dxgdevice *device)
+{
+	struct dxgpagingqueue *pqueue;
+
+	pqueue = vzalloc(sizeof(*pqueue));
+	if (pqueue) {
+		pqueue->device = device;
+		pqueue->process = device->process;
+		pqueue->device_handle = device->handle;
+		dxgdevice_add_paging_queue(device, pqueue);
+	}
+	return pqueue;
+}
+
+void dxgpagingqueue_stop(struct dxgpagingqueue *pqueue)
+{
+	int ret;
+
+	if (pqueue->mapped_address) {
+		ret = dxg_unmap_iospace(pqueue->mapped_address, PAGE_SIZE);
+		dev_dbg(dxgglobaldev, "fence is unmapped %d %p",
+			    ret, pqueue->mapped_address);
+		pqueue->mapped_address = NULL;
+	}
+}
+
+void dxgpagingqueue_destroy(struct dxgpagingqueue *pqueue)
+{
+	struct dxgprocess *process = pqueue->process;
+
+	dev_dbg(dxgglobaldev, "%s %p %x\n", __func__, pqueue, pqueue->handle.v);
+
+	dxgpagingqueue_stop(pqueue);
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	if (pqueue->handle.v) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+				      pqueue->handle);
+		pqueue->handle.v = 0;
+	}
+	if (pqueue->syncobj_handle.v) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_MONITOREDFENCE,
+				      pqueue->syncobj_handle);
+		pqueue->syncobj_handle.v = 0;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	if (pqueue->device)
+		dxgdevice_remove_paging_queue(pqueue);
+	vfree(pqueue);
+}
+
 struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 						     struct dxgadapter *adapter)
 {
@@ -1188,8 +1293,8 @@ void dxgsyncobject_stop(struct dxgsyncobject *syncobj)
 						      PAGE_SIZE);
 
 				(void)ret;
-				dev_dbg(dxgglobaldev, "fence is unmapped %d %p\n",
-					    ret, syncobj->mapped_address);
+				dev_dbg(dxgglobaldev, "unmap fence %d %p\n",
+					ret, syncobj->mapped_address);
 				syncobj->mapped_address = NULL;
 			}
 		}
@@ -1212,18 +1317,59 @@ void dxgsyncobject_release(struct kref *refcount)
 	vfree(syncobj);
 }
 
-void dxghwqueue_destroy(struct dxgprocess *process, struct dxghwqueue *hwqueue)
+struct dxghwqueue *dxghwqueue_create(struct dxgcontext *context)
 {
-	/* Placeholder */
+	struct dxgprocess *process = context->device->process;
+	struct dxghwqueue *hwqueue = vzalloc(sizeof(*hwqueue));
+
+	if (hwqueue) {
+		kref_init(&hwqueue->hwqueue_kref);
+		hwqueue->context = context;
+		hwqueue->process = process;
+		hwqueue->device_handle = context->device->handle;
+		if (dxgcontext_add_hwqueue(context, hwqueue) < 0) {
+			kref_put(&hwqueue->hwqueue_kref, dxghwqueue_release);
+			hwqueue = NULL;
+		} else {
+			kref_get(&context->context_kref);
+		}
+	}
+	return hwqueue;
 }
 
-void dxgpagingqueue_destroy(struct dxgpagingqueue *pqueue)
+void dxghwqueue_destroy(struct dxgprocess *process, struct dxghwqueue *hwqueue)
 {
-	/* Placeholder */
+	dev_dbg(dxgglobaldev, "%s %p\n", __func__, hwqueue);
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	if (hwqueue->handle.v) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGHWQUEUE,
+				      hwqueue->handle);
+		hwqueue->handle.v = 0;
+	}
+	if (hwqueue->progress_fence_sync_object.v) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_MONITOREDFENCE,
+				      hwqueue->progress_fence_sync_object);
+		hwqueue->progress_fence_sync_object.v = 0;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (hwqueue->progress_fence_mapped_address) {
+		dxg_unmap_iospace(hwqueue->progress_fence_mapped_address,
+				  PAGE_SIZE);
+		hwqueue->progress_fence_mapped_address = NULL;
+	}
+	dxgcontext_remove_hwqueue_safe(hwqueue->context, hwqueue);
+
+	kref_put(&hwqueue->context->context_kref, dxgcontext_release);
+	kref_put(&hwqueue->hwqueue_kref, dxghwqueue_release);
 }
 
-void dxgpagingqueue_stop(struct dxgpagingqueue *pqueue)
+void dxghwqueue_release(struct kref *refcount)
 {
-	/* Placeholder */
-}
+	struct dxghwqueue *hwqueue;
 
+	hwqueue = container_of(refcount, struct dxghwqueue, hwqueue_kref);
+	vfree(hwqueue);
+}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 6fc0771f383d..67ff8bcbfb9a 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1106,6 +1106,80 @@ int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
 	return ret;
 }
 
+int dxgvmb_send_create_paging_queue(struct dxgprocess *process,
+				    struct dxgdevice *device,
+				    struct d3dkmt_createpagingqueue *args,
+				    struct dxgpagingqueue *pqueue)
+{
+	struct dxgkvmb_command_createpagingqueue_return result;
+	struct dxgkvmb_command_createpagingqueue *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, device->adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_CREATEPAGINGQUEUE,
+				   process->host_handle);
+	command->args = *args;
+	args->paging_queue.v = 0;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size, &result,
+				   sizeof(result));
+	if (ret < 0) {
+		pr_err("send_create_paging_queue failed %x", ret);
+		goto cleanup;
+	}
+
+	args->paging_queue = result.paging_queue;
+	args->sync_object = result.sync_object;
+	args->fence_cpu_virtual_address =
+	    dxg_map_iospace(result.fence_storage_physical_address, PAGE_SIZE,
+			    PROT_READ | PROT_WRITE, true);
+	if (args->fence_cpu_virtual_address == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	pqueue->mapped_address = args->fence_cpu_virtual_address;
+	pqueue->handle = args->paging_queue;
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_destroy_paging_queue(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmthandle h)
+{
+	int ret;
+	struct dxgkvmb_command_destroypagingqueue *command;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_DESTROYPAGINGQUEUE,
+				   process->host_handle);
+	command->paging_queue = h;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size, NULL, 0);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
 static int
 copy_private_data(struct d3dkmt_createallocation *args,
 		  struct dxgkvmb_command_createallocation *command,
@@ -1770,6 +1844,60 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 	return ret;
 }
 
+int dxgvmb_send_submit_command(struct dxgprocess *process,
+			       struct dxgadapter *adapter,
+			       struct d3dkmt_submitcommand *args)
+{
+	int ret;
+	u32 cmd_size;
+	struct dxgkvmb_command_submitcommand *command;
+	u32 hbufsize = args->num_history_buffers * sizeof(struct d3dkmthandle);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	cmd_size = sizeof(struct dxgkvmb_command_submitcommand) +
+	    hbufsize + args->priv_drv_data_size;
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	ret = copy_from_user(&command[1], args->history_buffer_array,
+			     hbufsize);
+	if (ret) {
+		pr_err("%s failed to copy history buffer", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_from_user((u8 *) &command[1] + hbufsize,
+			     args->priv_drv_data, args->priv_drv_data_size);
+	if (ret) {
+		pr_err("%s failed to copy history priv data", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_SUBMITCOMMAND,
+				   process->host_handle);
+	command->args = *args;
+
+	if (dxgglobal->async_msg_enabled) {
+		command->hdr.async_msg = 1;
+		ret = dxgvmb_send_async_msg(msg.channel, msg.hdr, msg.size);
+	} else {
+		ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
+						    msg.size);
+	}
+
+cleanup:
+
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
 static void set_result(struct d3dkmt_createsynchronizationobject2 *args,
 		       u64 fence_gpu_va, u8 *va)
 {
@@ -2052,6 +2180,161 @@ int dxgvmb_send_wait_sync_object_gpu(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
+			       struct dxgadapter *adapter,
+			       struct d3dkmt_createhwqueue *args,
+			       struct d3dkmt_createhwqueue *__user inargs,
+			       struct dxghwqueue *hwqueue)
+{
+	struct dxgkvmb_command_createhwqueue *command = NULL;
+	u32 cmd_size = sizeof(struct dxgkvmb_command_createhwqueue);
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (args->priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("invalid private driver data size");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args->priv_drv_data_size)
+		cmd_size += args->priv_drv_data_size - 1;
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_CREATEHWQUEUE,
+				   process->host_handle);
+	command->context = args->context;
+	command->flags = args->flags;
+	command->priv_drv_data_size = args->priv_drv_data_size;
+	if (args->priv_drv_data_size) {
+		ret = copy_from_user(command->priv_drv_data,
+				     args->priv_drv_data,
+				     args->priv_drv_data_size);
+		if (ret) {
+			pr_err("%s failed to copy private data", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   command, cmd_size);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(command->status);
+	if (ret < 0) {
+		pr_err("dxgvmb_send_sync_msg failed: %x", command->status.v);
+		goto cleanup;
+	}
+
+	ret = hmgrtable_assign_handle_safe(&process->handle_table, hwqueue,
+					   HMGRENTRY_TYPE_DXGHWQUEUE,
+					   command->hwqueue);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = hmgrtable_assign_handle_safe(&process->handle_table,
+				NULL,
+				HMGRENTRY_TYPE_MONITOREDFENCE,
+				command->hwqueue_progress_fence);
+	if (ret < 0)
+		goto cleanup;
+
+	hwqueue->handle = command->hwqueue;
+	hwqueue->progress_fence_sync_object = command->hwqueue_progress_fence;
+
+	hwqueue->progress_fence_mapped_address =
+		dxg_map_iospace((u64)command->hwqueue_progress_fence_cpuva,
+				PAGE_SIZE, PROT_READ | PROT_WRITE, true);
+	if (hwqueue->progress_fence_mapped_address == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = copy_to_user(&inargs->queue, &command->hwqueue,
+			   sizeof(struct d3dkmthandle));
+	if (ret < 0) {
+		pr_err("%s failed to copy hwqueue handle", __func__);
+		goto cleanup;
+	}
+	ret = copy_to_user(&inargs->queue_progress_fence,
+			   &command->hwqueue_progress_fence,
+			   sizeof(struct d3dkmthandle));
+	if (ret < 0) {
+		pr_err("%s failed to progress fence", __func__);
+		goto cleanup;
+	}
+	ret = copy_to_user(&inargs->queue_progress_fence_cpu_va,
+			   &hwqueue->progress_fence_mapped_address,
+			   sizeof(inargs->queue_progress_fence_cpu_va));
+	if (ret < 0) {
+		pr_err("%s failed to copy fence cpu va", __func__);
+		goto cleanup;
+	}
+	ret = copy_to_user(&inargs->queue_progress_fence_gpu_va,
+			   &command->hwqueue_progress_fence_gpuva,
+			   sizeof(u64));
+	if (ret < 0) {
+		pr_err("%s failed to copy fence gpu va", __func__);
+		goto cleanup;
+	}
+	if (args->priv_drv_data_size) {
+		ret = copy_to_user(args->priv_drv_data,
+				   command->priv_drv_data,
+				   args->priv_drv_data_size);
+		if (ret < 0)
+			pr_err("%s failed to copy private data", __func__);
+	}
+
+cleanup:
+	if (ret < 0) {
+		pr_err("%s failed %x", __func__, ret);
+		if (hwqueue->handle.v) {
+			hmgrtable_free_handle_safe(&process->handle_table,
+						   HMGRENTRY_TYPE_DXGHWQUEUE,
+						   hwqueue->handle);
+			hwqueue->handle.v = 0;
+		}
+		if (command && command->hwqueue.v)
+			dxgvmb_send_destroy_hwqueue(process, adapter,
+						    command->hwqueue);
+	}
+	free_message(&msg, process);
+	return ret;
+}
+
+int dxgvmb_send_destroy_hwqueue(struct dxgprocess *process,
+				struct dxgadapter *adapter,
+				struct d3dkmthandle handle)
+{
+	int ret;
+	struct dxgkvmb_command_destroyhwqueue *command;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_DESTROYHWQUEUE,
+				   process->host_handle);
+	command->hwqueue = handle;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args)
@@ -2133,3 +2416,61 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
 	return ret;
 }
+
+int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
+				       struct dxgadapter *adapter,
+				       struct d3dkmt_submitcommandtohwqueue
+				       *args)
+{
+	int ret = -EINVAL;
+	u32 cmd_size;
+	struct dxgkvmb_command_submitcommandtohwqueue *command;
+	u32 primaries_size = args->num_primaries * sizeof(struct d3dkmthandle);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	cmd_size = sizeof(*command) + args->priv_drv_data_size + primaries_size;
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	if (primaries_size) {
+		ret = copy_from_user(&command[1], args->written_primaries,
+					 primaries_size);
+		if (ret) {
+			pr_err("%s failed to copy primaries handles", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+	if (args->priv_drv_data_size) {
+		ret = copy_from_user((char *)&command[1] + primaries_size,
+				      args->priv_drv_data,
+				      args->priv_drv_data_size);
+		if (ret) {
+			pr_err("%s failed to copy primaries data", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_SUBMITCOMMANDTOHWQUEUE,
+				   process->host_handle);
+	command->args = *args;
+
+	if (dxgglobal->async_msg_enabled) {
+		command->hdr.async_msg = 1;
+		ret = dxgvmb_send_async_msg(msg.channel, msg.hdr, msg.size);
+	} else {
+		ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
+						    msg.size);
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 97f4d2471ca5..6e18002c9d25 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -897,6 +897,340 @@ static int dxgk_destroy_hwcontext(struct dxgprocess *process,
 	return -ENOTTY;
 }
 
+static int
+dxgk_create_hwqueue(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_createhwqueue args;
+	struct dxgdevice *device = NULL;
+	struct dxgcontext *context = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct dxghwqueue *hwqueue = NULL;
+	int ret;
+	bool device_lock_acquired = false;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	/*
+	 * The call acquires reference on the device. It is safe to access the
+	 * adapter, because the device holds reference on it.
+	 */
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    args.context);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0)
+		goto cleanup;
+
+	device_lock_acquired = true;
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
+	context = hmgrtable_get_object_by_type(&process->handle_table,
+					       HMGRENTRY_TYPE_DXGCONTEXT,
+					       args.context);
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_SHARED);
+
+	if (context == NULL) {
+		pr_err("Invalid context handle %x", args.context.v);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hwqueue = dxghwqueue_create(context);
+	if (hwqueue == NULL) {
+		ret = -ENOMEM;
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
+	ret = dxgvmb_send_create_hwqueue(process, adapter, &args,
+					 inargs, hwqueue);
+
+cleanup:
+
+	if (ret < 0 && hwqueue)
+		dxghwqueue_destroy(process, hwqueue);
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device_lock_acquired)
+		dxgdevice_release_lock_shared(device);
+
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int dxgk_destroy_hwqueue(struct dxgprocess *process,
+					    void *__user inargs)
+{
+	struct d3dkmt_destroyhwqueue args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxghwqueue *hwqueue = NULL;
+	struct d3dkmthandle device_handle = {};
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	hwqueue = hmgrtable_get_object_by_type(&process->handle_table,
+					       HMGRENTRY_TYPE_DXGHWQUEUE,
+					       args.queue);
+	if (hwqueue) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGHWQUEUE, args.queue);
+		hwqueue->handle.v = 0;
+		device_handle = hwqueue->device_handle;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (hwqueue == NULL) {
+		pr_err("invalid hwqueue handle: %x", args.queue.v);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	/*
+	 * The call acquires reference on the device. It is safe to access the
+	 * adapter, because the device holds reference on it.
+	 */
+	device = dxgprocess_device_by_handle(process, device_handle);
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
+	ret = dxgvmb_send_destroy_hwqueue(process, adapter, args.queue);
+
+	dxghwqueue_destroy(process, hwqueue);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_create_paging_queue(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_createpagingqueue args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct dxgpagingqueue *pqueue = NULL;
+	int ret;
+	struct d3dkmthandle host_handle = {};
+	bool device_lock_acquired = false;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	/*
+	 * The call acquires reference on the device. It is safe to access the
+	 * adapter, because the device holds reference on it.
+	 */
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0)
+		goto cleanup;
+
+	device_lock_acquired = true;
+	adapter = device->adapter;
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	pqueue = dxgpagingqueue_create(device);
+	if (pqueue == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_create_paging_queue(process, device, &args, pqueue);
+	if (ret >= 0) {
+		host_handle = args.paging_queue;
+
+		ret = copy_to_user(inargs, &args, sizeof(args));
+		if (ret < 0) {
+			pr_err("%s failed to copy input args", __func__);
+			goto cleanup;
+		}
+
+		hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+		ret = hmgrtable_assign_handle(&process->handle_table, pqueue,
+					      HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+					      host_handle);
+		if (ret >= 0) {
+			pqueue->handle = host_handle;
+			ret = hmgrtable_assign_handle(&process->handle_table,
+						NULL,
+						HMGRENTRY_TYPE_MONITOREDFENCE,
+						args.sync_object);
+			if (ret >= 0)
+				pqueue->syncobj_handle = args.sync_object;
+		}
+		hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+		/* should not fail after this */
+	}
+
+cleanup:
+
+	if (ret < 0) {
+		if (pqueue)
+			dxgpagingqueue_destroy(pqueue);
+		if (host_handle.v)
+			dxgvmb_send_destroy_paging_queue(process,
+							 adapter,
+							 host_handle);
+	}
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device) {
+		if (device_lock_acquired)
+			dxgdevice_release_lock_shared(device);
+		kref_put(&device->device_kref, dxgdevice_release);
+	}
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_destroy_paging_queue(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dddi_destroypagingqueue args;
+	struct dxgpagingqueue *paging_queue = NULL;
+	int ret;
+	struct d3dkmthandle device_handle = {};
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	paging_queue = hmgrtable_get_object_by_type(&process->handle_table,
+						HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+						args.paging_queue);
+	if (paging_queue) {
+		device_handle = paging_queue->device_handle;
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+				      args.paging_queue);
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_MONITOREDFENCE,
+				      paging_queue->syncobj_handle);
+		paging_queue->syncobj_handle.v = 0;
+		paging_queue->handle.v = 0;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	/*
+	 * The call acquires reference on the device. It is safe to access the
+	 * adapter, because the device holds reference on it.
+	 */
+	if (device_handle.v)
+		device = dxgprocess_device_by_handle(process, device_handle);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0) {
+		kref_put(&device->device_kref, dxgdevice_release);
+		device = NULL;
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
+	ret = dxgvmb_send_destroy_paging_queue(process, adapter,
+					       args.paging_queue);
+
+	dxgpagingqueue_destroy(paging_queue);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device) {
+		dxgdevice_release_lock_shared(device);
+		kref_put(&device->device_kref, dxgdevice_release);
+	}
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 get_standard_alloc_priv_data(struct dxgdevice *device,
 			     struct d3dkmt_createstandardallocation *alloc_info,
@@ -1619,6 +1953,290 @@ dxgk_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_submit_command(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_submitcommand args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.broadcast_context_count > D3DDDI_MAX_BROADCAST_CONTEXT ||
+	    args.broadcast_context_count == 0) {
+		pr_err("invalid number of contexts");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("invalid private data size");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.num_history_buffers > 1024) {
+		pr_err("invalid number of history buffers");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.num_primaries > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("invalid number of primaries");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    args.broadcast_context[0]);
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
+	ret = dxgvmb_send_submit_command(process, adapter, &args);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_submit_command_to_hwqueue(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_submitcommandtohwqueue args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("invalid private data size");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.num_primaries > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("invalid number of primaries");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGHWQUEUE,
+						    args.hwqueue);
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
+	ret = dxgvmb_send_submit_command_hwqueue(process, adapter, &args);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_submit_signal_to_hwqueue(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_submitsignalsyncobjectstohwqueue args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmthandle hwqueue = {};
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.hwqueue_count > D3DDDI_MAX_BROADCAST_CONTEXT ||
+	    args.hwqueue_count == 0) {
+		pr_err("invalid hwqueue count");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.object_count > D3DDDI_MAX_OBJECT_SIGNALED ||
+	    args.object_count == 0) {
+		pr_err("invalid number of syn cobject");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = copy_from_user(&hwqueue, args.hwqueues,
+			     sizeof(struct d3dkmthandle));
+	if (ret) {
+		pr_err("%s failed to copy hwqueue handle", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGHWQUEUE,
+						    hwqueue);
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
+	ret = dxgvmb_send_signal_sync_object(process, adapter,
+					     args.flags, 0, zerohandle,
+					     args.object_count, args.objects,
+					     args.hwqueue_count, args.hwqueues,
+					     args.object_count,
+					     args.fence_values, NULL,
+					     zerohandle);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_submit_wait_to_hwqueue(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_submitwaitforsyncobjectstohwqueue args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int ret;
+	struct d3dkmthandle *objects = NULL;
+	u32 object_size;
+	u64 *fences = NULL;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.object_count > D3DDDI_MAX_OBJECT_WAITED_ON ||
+	    args.object_count == 0) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	object_size = sizeof(struct d3dkmthandle) * args.object_count;
+	objects = vzalloc(object_size);
+	if (objects == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	ret = copy_from_user(objects, args.objects, object_size);
+	if (ret) {
+		pr_err("%s failed to copy objects", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	object_size = sizeof(u64) * args.object_count;
+	fences = vzalloc(object_size);
+	if (fences == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	ret = copy_from_user(fences, args.fence_values, object_size);
+	if (ret) {
+		pr_err("%s failed to copy fence values", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGHWQUEUE,
+						    args.hwqueue);
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
+	ret = dxgvmb_send_wait_sync_object_gpu(process, adapter,
+					       args.hwqueue, args.object_count,
+					       objects, fences, false);
+
+cleanup:
+
+	if (objects)
+		vfree(objects);
+	if (fences)
+		vfree(fences);
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
 {
@@ -3321,8 +3939,12 @@ void init_ioctls(void)
 		  LX_DXDESTROYCONTEXT);
 	SET_IOCTL(/*0x6 */ dxgk_create_allocation,
 		  LX_DXCREATEALLOCATION);
+	SET_IOCTL(/*0x7 */ dxgk_create_paging_queue,
+		  LX_DXCREATEPAGINGQUEUE);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
+	SET_IOCTL(/*0xf */ dxgk_submit_command,
+		  LX_DXSUBMITCOMMAND);
 	SET_IOCTL(/*0x10 */ dxgk_create_sync_object,
 		  LX_DXCREATESYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x11 */ dxgk_signal_sync_object,
@@ -3337,10 +3959,16 @@ void init_ioctls(void)
 		  LX_DXCLOSEADAPTER);
 	SET_IOCTL(/*0x17 */ dxgk_create_hwcontext,
 		  LX_DXCREATEHWCONTEXT);
+	SET_IOCTL(/*0x18 */ dxgk_create_hwqueue,
+		  LX_DXCREATEHWQUEUE);
 	SET_IOCTL(/*0x19 */ dxgk_destroy_device,
 		  LX_DXDESTROYDEVICE);
 	SET_IOCTL(/*0x1a */ dxgk_destroy_hwcontext,
 		  LX_DXDESTROYHWCONTEXT);
+	SET_IOCTL(/*0x1b */ dxgk_destroy_hwqueue,
+		  LX_DXDESTROYHWQUEUE);
+	SET_IOCTL(/*0x1c */ dxgk_destroy_paging_queue,
+		  LX_DXDESTROYPAGINGQUEUE);
 	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x23 */ dxgk_get_shared_resource_adapter_luid,
@@ -3359,6 +3987,12 @@ void init_ioctls(void)
 		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU);
 	SET_IOCTL(/*0x33 */ dxgk_signal_sync_object_gpu2,
 		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2);
+	SET_IOCTL(/*0x34 */ dxgk_submit_command_to_hwqueue,
+		  LX_DXSUBMITCOMMANDTOHWQUEUE);
+	SET_IOCTL(/*0x35 */ dxgk_submit_wait_to_hwqueue,
+		  LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE);
+	SET_IOCTL(/*0x36 */ dxgk_submit_signal_to_hwqueue,
+		  LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE);
 	SET_IOCTL(/*0x3a */ dxgk_wait_sync_object_cpu,
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x3b */ dxgk_wait_sync_object_gpu,
-- 
2.32.0

