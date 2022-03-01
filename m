Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB4F4C94BD
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbiCATrT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbiCATrP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:15 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C8AF6C947;
        Tue,  1 Mar 2022 11:46:32 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7DF4820B7188;
        Tue,  1 Mar 2022 11:46:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DF4820B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163991;
        bh=oMh9JE0qg+UPJ28qLupf5UfTSpgdioTbiqjYJmw232g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=csfhTxAuDC3Tnglz+c3QJVE8/lMxjh/lJrU5G0Ne0E4p8OPcYzf75AMxpt7yepgY0
         8Ov2B2OjVHI8FdXOdUm/DVu1pkK0rRntB7JM556QKLC9j66ASzQsCSZzNluX7v39vr
         86CYMPZ1P6NKdnp81ck4Zj/iETv39BsfgCFdh+3Q=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 08/30] drivers: hv: dxgkrnl: Creation of dxgcontext objects
Date:   Tue,  1 Mar 2022 11:45:55 -0800
Message-Id: <aabd5033766fe4751a5042e7a8c3ce82c2e83c17.1646163378.git.iourit@linux.microsoft.com>
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

Implement ioctls for creation/destruction of dxgcontext
objects:
  - the LX_DXCREATECONTEXTVIRTUAL ioctl
  - the LX_DXDESTROYCONTEXT ioctl.

A dxgcontext object represents a compute device execution thread.
Ccompute device DMA buffers and synchronization operations are
submitted for execution to a dxgcontext. dxgcontexts objects
belong to a dxgdevice object.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 102 +++++++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  38 +++++++
 drivers/hv/dxgkrnl/dxgprocess.c |   4 +
 drivers/hv/dxgkrnl/dxgvmbus.c   | 102 ++++++++++++++++++-
 drivers/hv/dxgkrnl/dxgvmbus.h   |  18 ++++
 drivers/hv/dxgkrnl/ioctl.c      | 172 ++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/misc.h       |   1 +
 include/uapi/misc/d3dkmthk.h    |  47 +++++++++
 8 files changed, 483 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index ad71ba65e6af..52ed325792fa 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -210,7 +210,9 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 		device->adapter = adapter;
 		device->process = process;
 		kref_get(&adapter->adapter_kref);
+		INIT_LIST_HEAD(&device->context_list_head);
 		init_rwsem(&device->device_lock);
+		init_rwsem(&device->context_list_lock);
 		INIT_LIST_HEAD(&device->pqueue_list_head);
 		device->object_state = DXGOBJECTSTATE_CREATED;
 		device->execution_state = _D3DKMT_DEVICEEXECUTION_ACTIVE;
@@ -252,6 +254,20 @@ void dxgdevice_destroy(struct dxgdevice *device)
 
 	dxgdevice_stop(device);
 
+	{
+		struct dxgcontext *context;
+		struct dxgcontext *tmp;
+
+		pr_debug("destroying contexts\n");
+		dxgdevice_acquire_context_list_lock(device);
+		list_for_each_entry_safe(context, tmp,
+					 &device->context_list_head,
+					 context_list_entry) {
+			dxgcontext_destroy(process, context);
+		}
+		dxgdevice_release_context_list_lock(device);
+	}
+
 	/* Guest handles need to be released before the host handles */
 	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
 	if (device->handle_valid) {
@@ -306,6 +322,32 @@ bool dxgdevice_is_active(struct dxgdevice *device)
 	return device->object_state == DXGOBJECTSTATE_ACTIVE;
 }
 
+void dxgdevice_acquire_context_list_lock(struct dxgdevice *device)
+{
+	down_write(&device->context_list_lock);
+}
+
+void dxgdevice_release_context_list_lock(struct dxgdevice *device)
+{
+	up_write(&device->context_list_lock);
+}
+
+void dxgdevice_add_context(struct dxgdevice *device, struct dxgcontext *context)
+{
+	down_write(&device->context_list_lock);
+	list_add_tail(&context->context_list_entry, &device->context_list_head);
+	up_write(&device->context_list_lock);
+}
+
+void dxgdevice_remove_context(struct dxgdevice *device,
+			      struct dxgcontext *context)
+{
+	if (context->context_list_entry.next) {
+		list_del(&context->context_list_entry);
+		context->context_list_entry.next = NULL;
+	}
+}
+
 void dxgdevice_release(struct kref *refcount)
 {
 	struct dxgdevice *device;
@@ -314,6 +356,66 @@ void dxgdevice_release(struct kref *refcount)
 	vfree(device);
 }
 
+struct dxgcontext *dxgcontext_create(struct dxgdevice *device)
+{
+	struct dxgcontext *context = vzalloc(sizeof(struct dxgcontext));
+
+	if (context) {
+		kref_init(&context->context_kref);
+		context->device = device;
+		context->process = device->process;
+		context->device_handle = device->handle;
+		kref_get(&device->device_kref);
+		INIT_LIST_HEAD(&context->hwqueue_list_head);
+		init_rwsem(&context->hwqueue_list_lock);
+		dxgdevice_add_context(device, context);
+		context->object_state = DXGOBJECTSTATE_ACTIVE;
+	}
+	return context;
+}
+
+/*
+ * Called when the device context list lock is held
+ */
+void dxgcontext_destroy(struct dxgprocess *process, struct dxgcontext *context)
+{
+	pr_debug("%s %p\n", __func__, context);
+	context->object_state = DXGOBJECTSTATE_DESTROYED;
+	if (context->device) {
+		if (context->handle.v) {
+			hmgrtable_free_handle_safe(&process->handle_table,
+						   HMGRENTRY_TYPE_DXGCONTEXT,
+						   context->handle);
+		}
+		dxgdevice_remove_context(context->device, context);
+		kref_put(&context->device->device_kref, dxgdevice_release);
+	}
+	kref_put(&context->context_kref, dxgcontext_release);
+}
+
+void dxgcontext_destroy_safe(struct dxgprocess *process,
+			     struct dxgcontext *context)
+{
+	struct dxgdevice *device = context->device;
+
+	dxgdevice_acquire_context_list_lock(device);
+	dxgcontext_destroy(process, context);
+	dxgdevice_release_context_list_lock(device);
+}
+
+bool dxgcontext_is_active(struct dxgcontext *context)
+{
+	return context->object_state == DXGOBJECTSTATE_ACTIVE;
+}
+
+void dxgcontext_release(struct kref *refcount)
+{
+	struct dxgcontext *context;
+
+	context = container_of(refcount, struct dxgcontext, context_kref);
+	vfree(context);
+}
+
 struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 						     struct dxgadapter *adapter)
 {
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 242b98fc20d5..1ac2d4a64dc1 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -30,6 +30,7 @@
 struct dxgprocess;
 struct dxgadapter;
 struct dxgdevice;
+struct dxgcontext;
 
 #include "misc.h"
 #include "hmgr.h"
@@ -285,6 +286,7 @@ void dxgadapter_remove_process(struct dxgprocess_adapter *process_info);
 /*
  * The object represent the device object.
  * The following objects take reference on the device
+ * - dxgcontext
  * - device handle (struct d3dkmthandle)
  */
 struct dxgdevice {
@@ -298,6 +300,8 @@ struct dxgdevice {
 	struct kref		device_kref;
 	/* Protects destcruction of the device object */
 	struct rw_semaphore	device_lock;
+	struct rw_semaphore	context_list_lock;
+	struct list_head	context_list_head;
 	/* List of paging queues. Protected by process handle table lock. */
 	struct list_head	pqueue_list_head;
 	struct d3dkmthandle	handle;
@@ -312,7 +316,33 @@ void dxgdevice_mark_destroyed(struct dxgdevice *device);
 int dxgdevice_acquire_lock_shared(struct dxgdevice *dev);
 void dxgdevice_release_lock_shared(struct dxgdevice *dev);
 void dxgdevice_release(struct kref *refcount);
+void dxgdevice_add_context(struct dxgdevice *dev, struct dxgcontext *ctx);
+void dxgdevice_remove_context(struct dxgdevice *dev, struct dxgcontext *ctx);
 bool dxgdevice_is_active(struct dxgdevice *dev);
+void dxgdevice_acquire_context_list_lock(struct dxgdevice *dev);
+void dxgdevice_release_context_list_lock(struct dxgdevice *dev);
+
+/*
+ * The object represent the execution context of a device.
+ */
+struct dxgcontext {
+	enum dxgobjectstate	object_state;
+	struct dxgdevice	*device;
+	struct dxgprocess	*process;
+	/* entry in the device context list */
+	struct list_head	context_list_entry;
+	struct list_head	hwqueue_list_head;
+	struct rw_semaphore	hwqueue_list_lock;
+	struct kref		context_kref;
+	struct d3dkmthandle	handle;
+	struct d3dkmthandle	device_handle;
+};
+
+struct dxgcontext *dxgcontext_create(struct dxgdevice *dev);
+void dxgcontext_destroy(struct dxgprocess *pr, struct dxgcontext *ctx);
+void dxgcontext_destroy_safe(struct dxgprocess *pr, struct dxgcontext *ctx);
+void dxgcontext_release(struct kref *refcount);
+bool dxgcontext_is_active(struct dxgcontext *ctx);
 
 void init_ioctls(void);
 long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
@@ -355,6 +385,14 @@ int dxgvmb_send_destroy_device(struct dxgadapter *adapter,
 			       struct d3dkmthandle h);
 int dxgvmb_send_flush_device(struct dxgdevice *device,
 			     enum dxgdevice_flushschedulerreason reason);
+struct d3dkmthandle
+dxgvmb_send_create_context(struct dxgadapter *adapter,
+			   struct dxgprocess *process,
+			   struct d3dkmt_createcontextvirtual
+			   *args);
+int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
+				struct dxgprocess *process,
+				struct d3dkmthandle h);
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index 734585689213..1e6500e12a22 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -258,6 +258,10 @@ struct dxgdevice *dxgprocess_device_by_object_handle(struct dxgprocess *process,
 		case HMGRENTRY_TYPE_DXGDEVICE:
 			device = obj;
 			break;
+		case HMGRENTRY_TYPE_DXGCONTEXT:
+			device_handle =
+			    ((struct dxgcontext *)obj)->device_handle;
+			break;
 		default:
 			pr_err("invalid handle type: %d\n", t);
 			break;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 2bc2eca0e7da..e85c1d9abc47 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -725,7 +725,7 @@ int dxgvmb_send_flush_device(struct dxgdevice *device,
 			     enum dxgdevice_flushschedulerreason reason)
 {
 	int ret;
-	struct dxgkvmb_command_flushdevice *command;
+	struct dxgkvmb_command_flushdevice *command = NULL;
 	struct dxgvmbusmsg msg = {.hdr = NULL};
 	struct dxgprocess *process = device->process;
 
@@ -739,6 +739,106 @@ int dxgvmb_send_flush_device(struct dxgdevice *device,
 	command->device = device->handle;
 	command->reason = reason;
 
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+struct d3dkmthandle
+dxgvmb_send_create_context(struct dxgadapter *adapter,
+			   struct dxgprocess *process,
+			   struct d3dkmt_createcontextvirtual *args)
+{
+	struct dxgkvmb_command_createcontextvirtual *command = NULL;
+	u32 cmd_size;
+	int ret;
+	struct d3dkmthandle context = {};
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (args->priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("PrivateDriverDataSize is invalid");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	cmd_size = sizeof(struct dxgkvmb_command_createcontextvirtual) +
+	    args->priv_drv_data_size - 1;
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_CREATECONTEXTVIRTUAL,
+				   process->host_handle);
+	command->device = args->device;
+	command->node_ordinal = args->node_ordinal;
+	command->engine_affinity = args->engine_affinity;
+	command->flags = args->flags;
+	command->client_hint = args->client_hint;
+	command->priv_drv_data_size = args->priv_drv_data_size;
+	if (args->priv_drv_data_size) {
+		ret = copy_from_user(command->priv_drv_data,
+				     args->priv_drv_data,
+				     args->priv_drv_data_size);
+		if (ret) {
+			pr_err("%s Faled to copy private data",
+				__func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+	/* Input command is returned back as output */
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   command, cmd_size);
+	if (ret < 0) {
+		goto cleanup;
+	} else {
+		context = command->context;
+		if (args->priv_drv_data_size) {
+			ret = copy_to_user(args->priv_drv_data,
+					   command->priv_drv_data,
+					   args->priv_drv_data_size);
+			if (ret) {
+				pr_err("%s Faled to copy private data to user",
+					__func__);
+				ret = -EINVAL;
+				dxgvmb_send_destroy_context(adapter, process,
+							    context);
+				context.v = 0;
+			}
+		}
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return context;
+}
+
+int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
+				struct dxgprocess *process,
+				struct d3dkmthandle h)
+{
+	int ret;
+	struct dxgkvmb_command_destroycontext *command;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_DESTROYCONTEXT,
+				   process->host_handle);
+	command->context = h;
+
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 cleanup:
 	free_message(&msg, process);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 67448bee392a..adaccc464e21 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -269,4 +269,22 @@ struct dxgkvmb_command_flushdevice {
 	enum dxgdevice_flushschedulerreason	reason;
 };
 
+struct dxgkvmb_command_createcontextvirtual {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	struct d3dkmthandle		device;
+	u32				node_ordinal;
+	u32				engine_affinity;
+	struct d3dddi_createcontextflags flags;
+	enum d3dkmt_clienthint		client_hint;
+	u32				priv_drv_data_size;
+	u8				priv_drv_data[1];
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_destroycontext {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle	context;
+};
+
 #endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index a6be88b6c792..879fb3c6b7b2 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -567,6 +567,174 @@ dxgk_destroy_device(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_create_context_virtual(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_createcontextvirtual args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgcontext *context = NULL;
+	struct d3dkmthandle host_context_handle = {};
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
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	context = dxgcontext_create(device);
+	if (context == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	host_context_handle = dxgvmb_send_create_context(adapter,
+							 process, &args);
+	if (host_context_handle.v) {
+		hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+		ret = hmgrtable_assign_handle(&process->handle_table, context,
+					      HMGRENTRY_TYPE_DXGCONTEXT,
+					      host_context_handle);
+		if (ret >= 0)
+			context->handle = host_context_handle;
+		hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+		if (ret < 0)
+			goto cleanup;
+		ret = copy_to_user(&((struct d3dkmt_createcontextvirtual *)
+				   inargs)->context, &host_context_handle,
+				   sizeof(struct d3dkmthandle));
+		if (ret) {
+			pr_err("%s failed to copy context handle", __func__);
+			ret = -EINVAL;
+		}
+	} else {
+		pr_err("invalid host handle");
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (ret < 0) {
+		if (host_context_handle.v) {
+			dxgvmb_send_destroy_context(adapter, process,
+						    host_context_handle);
+		}
+		if (context)
+			dxgcontext_destroy_safe(process, context);
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_destroy_context(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_destroycontext args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgcontext *context = NULL;
+	struct dxgdevice *device = NULL;
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
+	context = hmgrtable_get_object_by_type(&process->handle_table,
+					       HMGRENTRY_TYPE_DXGCONTEXT,
+					       args.context);
+	if (context) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGCONTEXT, args.context);
+		context->handle.v = 0;
+		device_handle = context->device_handle;
+		context->object_state = DXGOBJECTSTATE_DESTROYED;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (context == NULL) {
+		pr_err("invalid context handle: %x", args.context.v);
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
+	ret = dxgvmb_send_destroy_context(adapter, process, args.context);
+
+	dxgcontext_destroy_safe(process, context);
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
 /*
  * IOCTL processing
  * The driver IOCTLs return
@@ -627,6 +795,10 @@ void init_ioctls(void)
 		  LX_DXOPENADAPTERFROMLUID);
 	SET_IOCTL(/*0x2 */ dxgk_create_device,
 		  LX_DXCREATEDEVICE);
+	SET_IOCTL(/*0x4 */ dxgk_create_context_virtual,
+		  LX_DXCREATECONTEXTVIRTUAL);
+	SET_IOCTL(/*0x5 */ dxgk_destroy_context,
+		  LX_DXDESTROYCONTEXT);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
 	SET_IOCTL(/*0x14 */ dxgk_enum_adapters,
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index 8948f48ec9dc..8f7b37049308 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -30,6 +30,7 @@ extern const struct d3dkmthandle zerohandle;
  * fd_mutex
  * plistmutex
  * table_lock
+ * context_list_lock
  * core_lock
  * device_lock
  * process_adapter_mutex
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index f303b52be8bc..b17ef6e30ece 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -150,6 +150,49 @@ struct d3dkmt_destroydevice {
 	struct d3dkmthandle		device;
 };
 
+enum d3dkmt_clienthint {
+	_D3DKMT_CLIENTHNT_UNKNOWN	= 0,
+	_D3DKMT_CLIENTHINT_OPENGL	= 1,
+	_D3DKMT_CLIENTHINT_CDD		= 2,
+	_D3DKMT_CLIENTHINT_DX7		= 7,
+	_D3DKMT_CLIENTHINT_DX8		= 8,
+	_D3DKMT_CLIENTHINT_DX9		= 9,
+	_D3DKMT_CLIENTHINT_DX10		= 10,
+};
+
+struct d3dddi_createcontextflags {
+	union {
+		struct {
+			__u32		null_rendering:1;
+			__u32		initial_data:1;
+			__u32		disable_gpu_timeout:1;
+			__u32		synchronization_only:1;
+			__u32		hw_queue_supported:1;
+			__u32		reserved:27;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dkmt_destroycontext {
+	struct d3dkmthandle		context;
+};
+
+struct d3dkmt_createcontextvirtual {
+	struct d3dkmthandle		device;
+	__u32				node_ordinal;
+	__u32				engine_affinity;
+	struct d3dddi_createcontextflags flags;
+#ifdef __KERNEL__
+	void				*priv_drv_data;
+#else
+	__u64				priv_drv_data;
+#endif
+	__u32				priv_drv_data_size;
+	enum d3dkmt_clienthint		client_hint;
+	struct d3dkmthandle		context;
+};
+
 struct d3dkmt_adaptertype {
 	union {
 		struct {
@@ -228,6 +271,10 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x01, struct d3dkmt_openadapterfromluid)
 #define LX_DXCREATEDEVICE		\
 	_IOWR(0x47, 0x02, struct d3dkmt_createdevice)
+#define LX_DXCREATECONTEXTVIRTUAL	\
+	_IOWR(0x47, 0x04, struct d3dkmt_createcontextvirtual)
+#define LX_DXDESTROYCONTEXT		\
+	_IOWR(0x47, 0x05, struct d3dkmt_destroycontext)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXENUMADAPTERS2		\
-- 
2.35.1

