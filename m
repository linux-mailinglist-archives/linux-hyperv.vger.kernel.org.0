Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9598D4C94DE
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbiCATr1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbiCATrT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:19 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FE0D6D38F;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id D151420B490B;
        Tue,  1 Mar 2022 11:46:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D151420B490B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163992;
        bh=UABm5fI+6AdGzqAqrH+XCehjWA4RVlPeH2n7LAghWN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/tRQLG9lbiqqExelMoP3F/4aFUNtjrCBC5kE+TVI+8uLi7Mo1c+OBEwdfgSXJ8PY
         TOUQ1VQ3O7rAE+en6TVgfRwZ0tt4wecNFfZuFAXcZELAgd5XGcivHLTRJqgA0B2DUg
         VE6BmhSoGB1QsFjzU/1nz0T/Nn+OZCdvY/4t7VSs=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 15/30] drivers: hv: dxgkrnl: Creation of paging queue objects.
Date:   Tue,  1 Mar 2022 11:46:02 -0800
Message-Id: <894d2c4f4089602f318b4f2aff6c5532653a6b19.1646163378.git.iourit@linux.microsoft.com>
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

Implement ioctls for creation/destruction of the paging queue objects:
  - LX_DXCREATEPAGINGQUEUE,
  - LX_DXDESTROYPAGINGQUEUE

Paging queue objects (dxgpagingqueue) contain operations, which
handle residency of device accessible allocations. An allocation is
resident, when the device has access to it. For example, the allocation
resides in local device memory or device page tables point to system
memory which is made non-pageable.

Each paging queue has an associated monitored fence sync object, which
is used to detect when a paging operation is completed.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  89 +++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  24 +++++
 drivers/hv/dxgkrnl/dxgprocess.c |   4 +
 drivers/hv/dxgkrnl/dxgvmbus.c   |  74 +++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  17 +++
 drivers/hv/dxgkrnl/ioctl.c      | 184 ++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h    |  27 +++++
 7 files changed, 419 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index cdc057371bfe..b162a37cf389 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -282,6 +282,7 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 void dxgdevice_stop(struct dxgdevice *device)
 {
 	struct dxgallocation *alloc;
+	struct dxgpagingqueue *pqueue;
 	struct dxgsyncobject *syncobj;
 
 	pr_debug("%s: %p", __func__, device);
@@ -292,6 +293,10 @@ void dxgdevice_stop(struct dxgdevice *device)
 	dxgdevice_release_alloc_list_lock(device);
 
 	hmgrtable_lock(&device->process->handle_table, DXGLOCK_EXCL);
+	list_for_each_entry(pqueue, &device->pqueue_list_head,
+			    pqueue_list_entry) {
+		dxgpagingqueue_stop(pqueue);
+	}
 	list_for_each_entry(syncobj, &device->syncobj_list_head,
 			    syncobj_list_entry) {
 		dxgsyncobject_stop(syncobj);
@@ -379,6 +384,17 @@ void dxgdevice_destroy(struct dxgdevice *device)
 		dxgdevice_release_context_list_lock(device);
 	}
 
+	{
+		struct dxgpagingqueue *tmp;
+		struct dxgpagingqueue *pqueue;
+
+		pr_debug("destroying paging queues\n");
+		list_for_each_entry_safe(pqueue, tmp, &device->pqueue_list_head,
+					 pqueue_list_entry) {
+			dxgpagingqueue_destroy(pqueue);
+		}
+	}
+
 	/* Guest handles need to be released before the host handles */
 	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
 	if (device->handle_valid) {
@@ -711,6 +727,26 @@ void dxgdevice_release(struct kref *refcount)
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
@@ -894,6 +930,59 @@ void dxgallocation_destroy(struct dxgallocation *alloc)
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
+		pr_debug("fence is unmapped %d %p",
+			    ret, pqueue->mapped_address);
+		pqueue->mapped_address = NULL;
+	}
+}
+
+void dxgpagingqueue_destroy(struct dxgpagingqueue *pqueue)
+{
+	struct dxgprocess *process = pqueue->process;
+
+	pr_debug("%s %p %x\n", __func__, pqueue, pqueue->handle.v);
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
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 74f412b0d6f5..a9aaefe9c168 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -89,6 +89,16 @@ int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev);
 void dxgvmbuschannel_destroy(struct dxgvmbuschannel *ch);
 void dxgvmbuschannel_receive(void *ctx);
 
+struct dxgpagingqueue {
+	struct dxgdevice	*device;
+	struct dxgprocess	*process;
+	struct list_head	pqueue_list_entry;
+	struct d3dkmthandle	device_handle;
+	struct d3dkmthandle	handle;
+	struct d3dkmthandle	syncobj_handle;
+	void			*mapped_address;
+};
+
 /*
  * The structure describes an event, which will be signaled by
  * a message from host.
@@ -112,6 +122,10 @@ struct dxghosteventcpu {
 	bool			remove_from_list;
 };
 
+struct dxgpagingqueue *dxgpagingqueue_create(struct dxgdevice *device);
+void dxgpagingqueue_destroy(struct dxgpagingqueue *pqueue);
+void dxgpagingqueue_stop(struct dxgpagingqueue *pqueue);
+
 /*
  * This is GPU synchronization object, which is used to synchronize execution
  * between GPU contextx/hardware queues or for tracking GPU execution progress.
@@ -503,6 +517,9 @@ void dxgdevice_remove_alloc_safe(struct dxgdevice *dev,
 				 struct dxgallocation *a);
 void dxgdevice_add_resource(struct dxgdevice *dev, struct dxgresource *res);
 void dxgdevice_remove_resource(struct dxgdevice *dev, struct dxgresource *res);
+void dxgdevice_add_paging_queue(struct dxgdevice *dev,
+				struct dxgpagingqueue *pqueue);
+void dxgdevice_remove_paging_queue(struct dxgpagingqueue *pqueue);
 void dxgdevice_add_syncobj(struct dxgdevice *dev, struct dxgsyncobject *so);
 void dxgdevice_remove_syncobj(struct dxgsyncobject *so);
 bool dxgdevice_is_active(struct dxgdevice *dev);
@@ -742,6 +759,13 @@ dxgvmb_send_create_context(struct dxgadapter *adapter,
 int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
 				struct dxgprocess *process,
 				struct d3dkmthandle h);
+int dxgvmb_send_create_paging_queue(struct dxgprocess *pr,
+				    struct dxgdevice *dev,
+				    struct d3dkmt_createpagingqueue *args,
+				    struct dxgpagingqueue *pq);
+int dxgvmb_send_destroy_paging_queue(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmthandle h);
 int dxgvmb_send_create_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 				  struct d3dkmt_createallocation *args,
 				  struct d3dkmt_createallocation *__user inargs,
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index 32aad8bfa1a5..d4199995d279 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -278,6 +278,10 @@ struct dxgdevice *dxgprocess_device_by_object_handle(struct dxgprocess *process,
 			device_handle =
 			    ((struct dxgcontext *)obj)->device_handle;
 			break;
+		case HMGRENTRY_TYPE_DXGPAGINGQUEUE:
+			device_handle =
+			    ((struct dxgpagingqueue *)obj)->device_handle;
+			break;
 		case HMGRENTRY_TYPE_DXGHWQUEUE:
 			device_handle =
 			    ((struct dxghwqueue *)obj)->device_handle;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 5d292858edec..fcfd5544f651 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1147,6 +1147,80 @@ int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
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
+		pr_debug("err: %s %d", __func__, ret);
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
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 static int
 copy_private_data(struct d3dkmt_createallocation *args,
 		  struct dxgkvmb_command_createallocation *command,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index a4000b3a1743..10ec7efa4f27 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -462,6 +462,23 @@ struct dxgkvmb_command_destroycontext {
 	struct d3dkmthandle	context;
 };
 
+struct dxgkvmb_command_createpagingqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_createpagingqueue	args;
+};
+
+struct dxgkvmb_command_createpagingqueue_return {
+	struct d3dkmthandle	paging_queue;
+	struct d3dkmthandle	sync_object;
+	u64			fence_storage_physical_address;
+	u64			fence_storage_offset;
+};
+
+struct dxgkvmb_command_destroypagingqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle	paging_queue;
+};
+
 struct dxgkvmb_command_createsyncobject {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_createsynchronizationobject2 args;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 111a63235627..8992679de5c4 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1034,6 +1034,186 @@ static int dxgk_destroy_hwqueue(struct dxgprocess *process,
 	return ret;
 }
 
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 get_standard_alloc_priv_data(struct dxgdevice *device,
 			     struct d3dkmt_createstandardallocation *alloc_info,
@@ -3570,6 +3750,8 @@ void init_ioctls(void)
 		  LX_DXDESTROYCONTEXT);
 	SET_IOCTL(/*0x6 */ dxgk_create_allocation,
 		  LX_DXCREATEALLOCATION);
+	SET_IOCTL(/*0x7 */ dxgk_create_paging_queue,
+		  LX_DXCREATEPAGINGQUEUE);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
 	SET_IOCTL(/*0x10 */ dxgk_create_sync_object,
@@ -3590,6 +3772,8 @@ void init_ioctls(void)
 		  LX_DXDESTROYDEVICE);
 	SET_IOCTL(/*0x1b */ dxgk_destroy_hwqueue,
 		  LX_DXDESTROYHWQUEUE);
+	SET_IOCTL(/*0x1c */ dxgk_destroy_paging_queue,
+		  LX_DXDESTROYPAGINGQUEUE);
 	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 0b3cbe8ddcab..a35e02c4cf17 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -207,6 +207,29 @@ struct d3dddi_createhwqueueflags {
 	};
 };
 
+enum d3dddi_pagingqueue_priority {
+	_D3DDDI_PAGINGQUEUE_PRIORITY_BELOW_NORMAL	= -1,
+	_D3DDDI_PAGINGQUEUE_PRIORITY_NORMAL		= 0,
+	_D3DDDI_PAGINGQUEUE_PRIORITY_ABOVE_NORMAL	= 1,
+};
+
+struct d3dkmt_createpagingqueue {
+	struct d3dkmthandle		device;
+	enum d3dddi_pagingqueue_priority priority;
+	struct d3dkmthandle		paging_queue;
+	struct d3dkmthandle		sync_object;
+#ifdef __KERNEL__
+	void				*fence_cpu_virtual_address;
+#else
+	__u64				fence_cpu_virtual_address;
+#endif
+	__u32				physical_adapter_index;
+};
+
+struct d3dddi_destroypagingqueue {
+	struct d3dkmthandle		paging_queue;
+};
+
 enum d3dkmdt_gdisurfacetype {
 	_D3DKMDT_GDISURFACE_INVALID				= 0,
 	_D3DKMDT_GDISURFACE_TEXTURE				= 1,
@@ -886,6 +909,8 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x05, struct d3dkmt_destroycontext)
 #define LX_DXCREATEALLOCATION		\
 	_IOWR(0x47, 0x06, struct d3dkmt_createallocation)
+#define LX_DXCREATEPAGINGQUEUE		\
+	_IOWR(0x47, 0x07, struct d3dkmt_createpagingqueue)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXCREATESYNCHRONIZATIONOBJECT \
@@ -904,6 +929,8 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x18, struct d3dkmt_createhwqueue)
 #define LX_DXDESTROYHWQUEUE		\
 	_IOWR(0x47, 0x1b, struct d3dkmt_destroyhwqueue)
+#define LX_DXDESTROYPAGINGQUEUE		\
+	_IOWR(0x47, 0x1c, struct d3dddi_destroypagingqueue)
 #define LX_DXDESTROYDEVICE		\
 	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
 #define LX_DXDESTROYSYNCHRONIZATIONOBJECT \
-- 
2.35.1

