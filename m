Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705614C94D5
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiCATr2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiCATrT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:19 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6039B6D386;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id A50C220B4906;
        Tue,  1 Mar 2022 11:46:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A50C220B4906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163992;
        bh=xycBGuQ5kO6X2b4snuPAPfsCyjYl72l3GgpoOwKrg6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWTS2WFZjXuuS+oDRYzChP1f4tEuEkLq38Vtn0NjnfUeEkiJzzxiwpPDa8EK1Fa5V
         wukmyAF4XhMJ2q2u194fmgbhq7p+khQKKclIasyN56KP2L+DhV+nLZOFvjjSKlVFLi
         /sKxR4MI93I9V0FKBIvMBTkqs9Muy9OceC9pHw6c=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 14/30] drivers: hv: dxgkrnl: Creation of hardware queues. Sync object operations to hw queue.
Date:   Tue,  1 Mar 2022 11:46:01 -0800
Message-Id: <8c85016f6fde5e10433bb32e421fdec607edd4d9.1646163378.git.iourit@linux.microsoft.com>
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

Implement ioctls for creation/destruction of the hardware queue objects:
  - LX_DXCREATEHWQUEUE
  - LX_DXDESTROYHWQUEUE

Implement ioctls to submit "signal" and "wait" operations for
sync objects to hardware queues:
  - LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE,
  - LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE

Hardware queues are used when a compute device supports "hardware
scheduling". This means that the compute device itself schedules execution
of DMA buffers from hardware queues without CPU intervention. This is as
oppose to the "packet scheduling" mode where the software scheduler on the
host schedules DMA buffer execution.

A hardware queue belongs to a dxgcontext object and has an associated
monitored fence object to track execution progress. The monitored fence
object has a mapped CPU address to read the fence value by CPU.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  96 ++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  33 ++++
 drivers/hv/dxgkrnl/dxgprocess.c |   4 +
 drivers/hv/dxgkrnl/dxgvmbus.c   | 155 +++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  20 ++
 drivers/hv/dxgkrnl/ioctl.c      | 321 ++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h    |  73 ++++++++
 7 files changed, 702 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index cb5575cdc308..cdc057371bfe 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -758,6 +758,9 @@ struct dxgcontext *dxgcontext_create(struct dxgdevice *device)
  */
 void dxgcontext_destroy(struct dxgprocess *process, struct dxgcontext *context)
 {
+	struct dxghwqueue *hwqueue;
+	struct dxghwqueue *tmp;
+
 	pr_debug("%s %p\n", __func__, context);
 	context->object_state = DXGOBJECTSTATE_DESTROYED;
 	if (context->device) {
@@ -769,6 +772,10 @@ void dxgcontext_destroy(struct dxgprocess *process, struct dxgcontext *context)
 		dxgdevice_remove_context(context->device, context);
 		kref_put(&context->device->device_kref, dxgdevice_release);
 	}
+	list_for_each_entry_safe(hwqueue, tmp, &context->hwqueue_list_head,
+				 hwqueue_list_entry) {
+		dxghwqueue_destroy(process, hwqueue);
+	}
 	kref_put(&context->context_kref, dxgcontext_release);
 }
 
@@ -795,6 +802,38 @@ void dxgcontext_release(struct kref *refcount)
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
@@ -1177,3 +1216,60 @@ void dxgsyncobject_release(struct kref *refcount)
 		vfree(syncobj->host_event);
 	vfree(syncobj);
 }
+
+struct dxghwqueue *dxghwqueue_create(struct dxgcontext *context)
+{
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
+}
+
+void dxghwqueue_destroy(struct dxgprocess *process, struct dxghwqueue *hwqueue)
+{
+	pr_debug("%s %p\n", __func__, hwqueue);
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
+}
+
+void dxghwqueue_release(struct kref *refcount)
+{
+	struct dxghwqueue *hwqueue;
+
+	hwqueue = container_of(refcount, struct dxghwqueue, hwqueue_kref);
+	vfree(hwqueue);
+}
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 15cacdd43dee..74f412b0d6f5 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -36,6 +36,7 @@ struct dxgresource;
 struct dxgsharedresource;
 struct dxgsyncobject;
 struct dxgsharedsyncobject;
+struct dxghwqueue;
 
 #include "misc.h"
 #include "hmgr.h"
@@ -532,8 +533,32 @@ struct dxgcontext *dxgcontext_create(struct dxgdevice *dev);
 void dxgcontext_destroy(struct dxgprocess *pr, struct dxgcontext *ctx);
 void dxgcontext_destroy_safe(struct dxgprocess *pr, struct dxgcontext *ctx);
 void dxgcontext_release(struct kref *refcount);
+int dxgcontext_add_hwqueue(struct dxgcontext *ctx,
+				       struct dxghwqueue *hq);
+void dxgcontext_remove_hwqueue(struct dxgcontext *ctx, struct dxghwqueue *hq);
+void dxgcontext_remove_hwqueue_safe(struct dxgcontext *ctx,
+				    struct dxghwqueue *hq);
 bool dxgcontext_is_active(struct dxgcontext *ctx);
 
+/*
+ * The object represent the execution hardware queue of a device.
+ */
+struct dxghwqueue {
+	/* entry in the context hw queue list */
+	struct list_head	hwqueue_list_entry;
+	struct kref		hwqueue_kref;
+	struct dxgcontext	*context;
+	struct dxgprocess	*process;
+	struct d3dkmthandle	progress_fence_sync_object;
+	struct d3dkmthandle	handle;
+	struct d3dkmthandle	device_handle;
+	void			*progress_fence_mapped_address;
+};
+
+struct dxghwqueue *dxghwqueue_create(struct dxgcontext *ctx);
+void dxghwqueue_destroy(struct dxgprocess *pr, struct dxghwqueue *hq);
+void dxghwqueue_release(struct kref *refcount);
+
 /*
  * A shared resource object is created to track the list of dxgresource objects,
  * which are opened for the same underlying shared resource.
@@ -758,6 +783,14 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 				     d3dkmt_waitforsynchronizationobjectfromcpu
 				     *args,
 				     u64 cpu_event);
+int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
+			       struct dxgadapter *adapter,
+			       struct d3dkmt_createhwqueue *args,
+			       struct d3dkmt_createhwqueue *__user inargs,
+			       struct dxghwqueue *hq);
+int dxgvmb_send_destroy_hwqueue(struct dxgprocess *process,
+				struct dxgadapter *adapter,
+				struct d3dkmthandle handle);
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index 30af930cc8c0..32aad8bfa1a5 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -278,6 +278,10 @@ struct dxgdevice *dxgprocess_device_by_object_handle(struct dxgprocess *process,
 			device_handle =
 			    ((struct dxgcontext *)obj)->device_handle;
 			break;
+		case HMGRENTRY_TYPE_DXGHWQUEUE:
+			device_handle =
+			    ((struct dxghwqueue *)obj)->device_handle;
+			break;
 		default:
 			pr_err("invalid handle type: %d\n", t);
 			break;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index e159b9e70e1c..5d292858edec 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2094,6 +2094,161 @@ int dxgvmb_send_wait_sync_object_gpu(struct dxgprocess *process,
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
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args)
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index d9cc88dee186..a4000b3a1743 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -523,4 +523,24 @@ struct dxgkvmb_command_waitforsyncobjectfromgpu {
 	/* struct d3dkmthandle ObjectHandles[object_count] */
 };
 
+/* Returns the same structure */
+struct dxgkvmb_command_createhwqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct ntstatus			status;
+	struct d3dkmthandle		hwqueue;
+	struct d3dkmthandle		hwqueue_progress_fence;
+	void				*hwqueue_progress_fence_cpuva;
+	u64				hwqueue_progress_fence_gpuva;
+	struct d3dkmthandle		context;
+	struct d3dddi_createhwqueueflags flags;
+	u32				priv_drv_data_size;
+	char				priv_drv_data[1];
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_destroyhwqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		hwqueue;
+};
+
 #endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index be9d72c4ae4e..111a63235627 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -880,6 +880,160 @@ dxgk_destroy_context(struct dxgprocess *process, void *__user inargs)
 	return ret;
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
+	pr_debug("ioctl: %s", __func__);
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
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
+	pr_debug("ioctl: %s", __func__);
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 get_standard_alloc_priv_data(struct dxgdevice *device,
 			     struct d3dkmt_createstandardallocation *alloc_info,
@@ -1601,6 +1755,165 @@ dxgk_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_submit_signal_to_hwqueue(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_submitsignalsyncobjectstohwqueue args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmthandle hwqueue = {};
+
+	pr_debug("ioctl: %s", __func__);
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
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
+	pr_debug("ioctl: %s", __func__);
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
 {
@@ -3271,8 +3584,12 @@ void init_ioctls(void)
 		  LX_DXENUMADAPTERS2);
 	SET_IOCTL(/*0x15 */ dxgk_close_adapter,
 		  LX_DXCLOSEADAPTER);
+	SET_IOCTL(/*0x18 */ dxgk_create_hwqueue,
+		  LX_DXCREATEHWQUEUE);
 	SET_IOCTL(/*0x19 */ dxgk_destroy_device,
 		  LX_DXDESTROYDEVICE);
+	SET_IOCTL(/*0x1b */ dxgk_destroy_hwqueue,
+		  LX_DXDESTROYHWQUEUE);
 	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
@@ -3281,6 +3598,10 @@ void init_ioctls(void)
 		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU);
 	SET_IOCTL(/*0x33 */ dxgk_signal_sync_object_gpu2,
 		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2);
+	SET_IOCTL(/*0x35 */ dxgk_submit_wait_to_hwqueue,
+		  LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE);
+	SET_IOCTL(/*0x36 */ dxgk_submit_signal_to_hwqueue,
+		  LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE);
 	SET_IOCTL(/*0x3a */ dxgk_wait_sync_object_cpu,
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x3b */ dxgk_wait_sync_object_gpu,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 36466fc18608..0b3cbe8ddcab 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -197,6 +197,16 @@ struct d3dkmt_createcontextvirtual {
 	struct d3dkmthandle		context;
 };
 
+struct d3dddi_createhwqueueflags {
+	union {
+		struct {
+			__u32		disable_gpu_timeout:1;
+			__u32		reserved:31;
+		};
+		__u32			value;
+	};
+};
+
 enum d3dkmdt_gdisurfacetype {
 	_D3DKMDT_GDISURFACE_INVALID				= 0,
 	_D3DKMDT_GDISURFACE_TEXTURE				= 1,
@@ -690,6 +700,61 @@ struct d3dddi_openallocationinfo2 {
 	__u64			reserved[6];
 };
 
+struct d3dkmt_createhwqueue {
+	struct d3dkmthandle	context;
+	struct d3dddi_createhwqueueflags flags;
+	__u32			priv_drv_data_size;
+	__u32			reserved;
+#ifdef __KERNEL__
+	void			*priv_drv_data;
+#else
+	__u64			priv_drv_data;
+#endif
+	struct d3dkmthandle	queue;
+	struct d3dkmthandle	queue_progress_fence;
+#ifdef __KERNEL__
+	void			*queue_progress_fence_cpu_va;
+#else
+	__u64			queue_progress_fence_cpu_va;
+#endif
+	__u64			queue_progress_fence_gpu_va;
+};
+
+struct d3dkmt_destroyhwqueue {
+	struct d3dkmthandle	queue;
+};
+
+struct d3dkmt_submitwaitforsyncobjectstohwqueue {
+	struct d3dkmthandle	hwqueue;
+	__u32			object_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*objects;
+	__u64			*fence_values;
+#else
+	__u64			objects;
+	__u64			fence_values;
+#endif
+};
+
+struct d3dkmt_submitsignalsyncobjectstohwqueue {
+	struct d3dddicb_signalflags	flags;
+	__u32				hwqueue_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle		*hwqueues;
+#else
+	__u64				hwqueues;
+#endif
+	__u32				object_count;
+	__u32				reserved;
+#ifdef __KERNEL__
+	struct d3dkmthandle		*objects;
+	__u64				*fence_values;
+#else
+	__u64				objects;
+	__u64				fence_values;
+#endif
+};
+
 struct d3dkmt_opensyncobjectfromnthandle2 {
 	__u64			nt_handle;
 	struct d3dkmthandle	device;
@@ -835,6 +900,10 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x14, struct d3dkmt_enumadapters2)
 #define LX_DXCLOSEADAPTER		\
 	_IOWR(0x47, 0x15, struct d3dkmt_closeadapter)
+#define LX_DXCREATEHWQUEUE		\
+	_IOWR(0x47, 0x18, struct d3dkmt_createhwqueue)
+#define LX_DXDESTROYHWQUEUE		\
+	_IOWR(0x47, 0x1b, struct d3dkmt_destroyhwqueue)
 #define LX_DXDESTROYDEVICE		\
 	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
 #define LX_DXDESTROYSYNCHRONIZATIONOBJECT \
@@ -845,6 +914,10 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x32, struct d3dkmt_signalsynchronizationobjectfromgpu)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2 \
 	_IOWR(0x47, 0x33, struct d3dkmt_signalsynchronizationobjectfromgpu2)
+#define LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE \
+	_IOWR(0x47, 0x35, struct d3dkmt_submitsignalsyncobjectstohwqueue)
+#define LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE \
+	_IOWR(0x47, 0x36, struct d3dkmt_submitwaitforsyncobjectstohwqueue)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU \
 	_IOWR(0x47, 0x3a, struct d3dkmt_waitforsynchronizationobjectfromcpu)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU \
-- 
2.35.1

