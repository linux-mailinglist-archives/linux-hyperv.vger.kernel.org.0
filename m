Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C12448CC94
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 20:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbiALT4g (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 14:56:36 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33294 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357554AbiALTzQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 14:55:16 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8C87A20B717B;
        Wed, 12 Jan 2022 11:55:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C87A20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642017315;
        bh=7duGMSJO3L04fUJz9scynGUdPwA68G/nhh1UJ0B+6GY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2vgSi5AI6FEtevU+rX/Q1gKma8xq3EkyM6h1XV/zVrEEoLuxOJd+tUVAjgJcbbz4
         u1YurlrjGczSQjkFjEHIwXGLNrPLIpHVQgkTqnt8GxC0dsyOZvb9PhsvZ/yXKRzXHQ
         TbLWGwAvy8ixguXS8ATipBWNzRX1h8eJljkSwP50=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 2/9] drivers: hv: dxgkrnl: Open device object, adapter enumeration, dxgdevice, dxgcontext creation
Date:   Wed, 12 Jan 2022 11:55:07 -0800
Message-Id: <79cf6932161dd52c226c9f7a729b5b3a0a217fc3.1641937419.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641937419.git.iourit@linux.microsoft.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

- Handle opening of the device (/dev/dxg) file object and creation of
dxgprocess. dxgprocess is created for each process, which opens /dev/dxg.
dxgprocess is ref counted, so the exicting dxgprocess objects is used for
a process, which opens the device object multiple time.
dxgprocess is destroyed when the device object is closed.

- Implement ioctls for virtual GPU adapter enumeration:
LX_DXENUMADAPTERS2, LX_DXENUMADAPTERS3
The IOCTLs return a d3dkmt handle for each enumerated adapter.

- Implement ioctl to query adapter information:
LX_DXQUERYADAPTERINFO.

- Implement ioctls to open and closet a dxgadapter object:
LX_DXOPENADAPTERFROMLUID, LX_DXCLOSEADAPTER
Note that dxgadapter is opened when LX_DXENUMADAPTERS2, LX_DXENUMADAPTERS3
are called.

- Implement ioctls for dxgdevice and dxgcontext creation/destruction:
LX_DXCREATEDEVICE, LX_DXCREATECONTEXT, LX_DXCREATECONTEXTVIRTUAL,
LX_DXDESTROYCONTEXT, LX_DXCREATEHWCONTEXT, LX_DXDESTROYDEVICE,
LX_DXDESTROYHWCONTEXT

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 494 +++++++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |   4 -
 drivers/hv/dxgkrnl/dxgprocess.c | 316 ++++++++++++-
 drivers/hv/dxgkrnl/dxgvmbus.c   | 314 ++++++++++++
 drivers/hv/dxgkrnl/hmgr.c       | 509 ++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c      | 812 +++++++++++++++++++++++++++++++-
 6 files changed, 2436 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 164d91e68552..b461d6b6f55e 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -149,6 +149,24 @@ bool dxgadapter_is_active(struct dxgadapter *adapter)
 	return adapter->adapter_state == DXGADAPTER_STATE_ACTIVE;
 }
 
+/* Protected by dxgglobal_acquire_process_adapter_lock */
+void dxgadapter_add_process(struct dxgadapter *adapter,
+			    struct dxgprocess_adapter *process_info)
+{
+	dev_dbg(dxgglobaldev, "%s %p %p", __func__, adapter, process_info);
+	list_add_tail(&process_info->adapter_process_list_entry,
+		      &adapter->adapter_process_list_head);
+}
+
+void dxgadapter_remove_process(struct dxgprocess_adapter *process_info)
+{
+	dev_dbg(dxgglobaldev, "%s %p %p", __func__,
+		    process_info->adapter, process_info);
+	list_del(&process_info->adapter_process_list_entry);
+	process_info->adapter_process_list_entry.next = NULL;
+	process_info->adapter_process_list_entry.prev = NULL;
+}
+
 int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter)
 {
 	down_write(&adapter->core_lock);
@@ -183,7 +201,483 @@ void dxgadapter_release_lock_shared(struct dxgadapter *adapter)
 	up_read(&adapter->core_lock);
 }
 
+struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
+				   struct dxgprocess *process)
+{
+	struct dxgdevice *device = vzalloc(sizeof(struct dxgdevice));
+	int ret;
+
+	if (device) {
+		kref_init(&device->device_kref);
+		device->adapter = adapter;
+		device->process = process;
+		kref_get(&adapter->adapter_kref);
+		INIT_LIST_HEAD(&device->context_list_head);
+		INIT_LIST_HEAD(&device->alloc_list_head);
+		INIT_LIST_HEAD(&device->resource_list_head);
+		init_rwsem(&device->device_lock);
+		init_rwsem(&device->context_list_lock);
+		init_rwsem(&device->alloc_list_lock);
+		INIT_LIST_HEAD(&device->pqueue_list_head);
+		INIT_LIST_HEAD(&device->syncobj_list_head);
+		device->object_state = DXGOBJECTSTATE_CREATED;
+		device->execution_state = _D3DKMT_DEVICEEXECUTION_ACTIVE;
+
+		ret = dxgprocess_adapter_add_device(process, adapter, device);
+		if (ret < 0) {
+			kref_put(&device->device_kref, dxgdevice_release);
+			device = NULL;
+		}
+	}
+	return device;
+}
+
+void dxgdevice_stop(struct dxgdevice *device)
+{
+	struct dxgallocation *alloc;
+	struct dxgpagingqueue *pqueue;
+	struct dxgsyncobject *syncobj;
+
+	dev_dbg(dxgglobaldev, "%s: %p", __func__, device);
+	dxgdevice_acquire_alloc_list_lock(device);
+	list_for_each_entry(alloc, &device->alloc_list_head, alloc_list_entry) {
+		dxgallocation_stop(alloc);
+	}
+	dxgdevice_release_alloc_list_lock(device);
+
+	hmgrtable_lock(&device->process->handle_table, DXGLOCK_EXCL);
+	list_for_each_entry(pqueue, &device->pqueue_list_head,
+			    pqueue_list_entry) {
+		dxgpagingqueue_stop(pqueue);
+	}
+	list_for_each_entry(syncobj, &device->syncobj_list_head,
+			    syncobj_list_entry) {
+		dxgsyncobject_stop(syncobj);
+	}
+	hmgrtable_unlock(&device->process->handle_table, DXGLOCK_EXCL);
+	dev_dbg(dxgglobaldev, "%s: end %p\n", __func__, device);
+}
+
+void dxgdevice_mark_destroyed(struct dxgdevice *device)
+{
+	down_write(&device->device_lock);
+	device->object_state = DXGOBJECTSTATE_DESTROYED;
+	up_write(&device->device_lock);
+}
+
+void dxgdevice_destroy(struct dxgdevice *device)
+{
+	struct dxgprocess *process = device->process;
+	struct dxgadapter *adapter = device->adapter;
+	struct d3dkmthandle device_handle = {};
+
+	dev_dbg(dxgglobaldev, "%s: %p\n", __func__, device);
+
+	down_write(&device->device_lock);
+
+	if (device->object_state != DXGOBJECTSTATE_ACTIVE)
+		goto cleanup;
+
+	device->object_state = DXGOBJECTSTATE_DESTROYED;
+
+	dxgdevice_stop(device);
+
+	dxgdevice_acquire_alloc_list_lock(device);
+
+	while (!list_empty(&device->syncobj_list_head)) {
+		struct dxgsyncobject *syncobj =
+		    list_first_entry(&device->syncobj_list_head,
+				     struct dxgsyncobject,
+				     syncobj_list_entry);
+		list_del(&syncobj->syncobj_list_entry);
+		syncobj->syncobj_list_entry.next = NULL;
+		dxgdevice_release_alloc_list_lock(device);
+
+		dxgsyncobject_destroy(process, syncobj);
+
+		dxgdevice_acquire_alloc_list_lock(device);
+	}
+
+	{
+		struct dxgallocation *alloc;
+		struct dxgallocation *tmp;
+
+		dev_dbg(dxgglobaldev, "destroying allocations\n");
+		list_for_each_entry_safe(alloc, tmp, &device->alloc_list_head,
+					 alloc_list_entry) {
+			dxgallocation_destroy(alloc);
+		}
+	}
+
+	{
+		struct dxgresource *resource;
+		struct dxgresource *tmp;
+
+		dev_dbg(dxgglobaldev, "destroying resources\n");
+		list_for_each_entry_safe(resource, tmp,
+					 &device->resource_list_head,
+					 resource_list_entry) {
+			dxgresource_destroy(resource);
+		}
+	}
+
+	dxgdevice_release_alloc_list_lock(device);
+
+	{
+		struct dxgcontext *context;
+		struct dxgcontext *tmp;
+
+		dev_dbg(dxgglobaldev, "destroying contexts\n");
+		dxgdevice_acquire_context_list_lock(device);
+		list_for_each_entry_safe(context, tmp,
+					 &device->context_list_head,
+					 context_list_entry) {
+			dxgcontext_destroy(process, context);
+		}
+		dxgdevice_release_context_list_lock(device);
+	}
+
+	{
+		struct dxgpagingqueue *tmp;
+		struct dxgpagingqueue *pqueue;
+
+		dev_dbg(dxgglobaldev, "destroying paging queues\n");
+		list_for_each_entry_safe(pqueue, tmp, &device->pqueue_list_head,
+					 pqueue_list_entry) {
+			dxgpagingqueue_destroy(pqueue);
+		}
+	}
+
+	/* Guest handles need to be released before the host handles */
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	if (device->handle_valid) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGDEVICE, device->handle);
+		device_handle = device->handle;
+		device->handle_valid = 0;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (device_handle.v) {
+		up_write(&device->device_lock);
+		if (dxgadapter_acquire_lock_shared(adapter) == 0) {
+			dxgvmb_send_destroy_device(adapter, process,
+						   device_handle);
+			dxgadapter_release_lock_shared(adapter);
+		}
+		down_write(&device->device_lock);
+	}
+
+cleanup:
+
+	if (device->adapter) {
+		dxgprocess_adapter_remove_device(device);
+		kref_put(&device->adapter->adapter_kref, dxgadapter_release);
+	}
+
+	up_write(&device->device_lock);
+
+	kref_put(&device->device_kref, dxgdevice_release);
+	dev_dbg(dxgglobaldev, "dxgdevice_destroy_end\n");
+}
+
+int dxgdevice_acquire_lock_shared(struct dxgdevice *device)
+{
+	down_read(&device->device_lock);
+	if (!dxgdevice_is_active(device)) {
+		up_read(&device->device_lock);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+void dxgdevice_release_lock_shared(struct dxgdevice *device)
+{
+	up_read(&device->device_lock);
+}
+
+bool dxgdevice_is_active(struct dxgdevice *device)
+{
+	return device->object_state == DXGOBJECTSTATE_ACTIVE;
+}
+
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
+void dxgdevice_acquire_alloc_list_lock(struct dxgdevice *device)
+{
+	down_write(&device->alloc_list_lock);
+}
+
+void dxgdevice_release_alloc_list_lock(struct dxgdevice *device)
+{
+	up_write(&device->alloc_list_lock);
+}
+
+void dxgdevice_acquire_alloc_list_lock_shared(struct dxgdevice *device)
+{
+	down_read(&device->alloc_list_lock);
+}
+
+void dxgdevice_release_alloc_list_lock_shared(struct dxgdevice *device)
+{
+	up_read(&device->alloc_list_lock);
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
+void dxgdevice_release(struct kref *refcount)
+{
+	struct dxgdevice *device;
+
+	device = container_of(refcount, struct dxgdevice, device_kref);
+	vfree(device);
+}
+
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
+	struct dxghwqueue *hwqueue;
+	struct dxghwqueue *tmp;
+
+	dev_dbg(dxgglobaldev, "%s %p\n", __func__, context);
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
+	list_for_each_entry_safe(hwqueue, tmp, &context->hwqueue_list_head,
+				 hwqueue_list_entry) {
+		dxghwqueue_destroy(process, hwqueue);
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
+struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
+						     struct dxgadapter *adapter)
+{
+	struct dxgprocess_adapter *adapter_info;
+
+	adapter_info = vzalloc(sizeof(*adapter_info));
+	if (adapter_info) {
+		if (kref_get_unless_zero(&adapter->adapter_kref) == 0) {
+			pr_err("failed to acquire adapter reference");
+			goto cleanup;
+		}
+		adapter_info->adapter = adapter;
+		adapter_info->process = process;
+		adapter_info->refcount = 1;
+		mutex_init(&adapter_info->device_list_mutex);
+		INIT_LIST_HEAD(&adapter_info->device_list_head);
+		list_add_tail(&adapter_info->process_adapter_list_entry,
+			      &process->process_adapter_list_head);
+		dxgadapter_add_process(adapter, adapter_info);
+	}
+	return adapter_info;
+cleanup:
+	if (adapter_info)
+		vfree(adapter_info);
+	return NULL;
+}
+
 void dxgprocess_adapter_stop(struct dxgprocess_adapter *adapter_info)
+{
+	struct dxgdevice *device;
+
+	mutex_lock(&adapter_info->device_list_mutex);
+	list_for_each_entry(device, &adapter_info->device_list_head,
+			    device_list_entry) {
+		dxgdevice_stop(device);
+	}
+	mutex_unlock(&adapter_info->device_list_mutex);
+}
+
+void dxgprocess_adapter_destroy(struct dxgprocess_adapter *adapter_info)
+{
+	struct dxgdevice *device;
+
+	mutex_lock(&adapter_info->device_list_mutex);
+	while (!list_empty(&adapter_info->device_list_head)) {
+		device = list_first_entry(&adapter_info->device_list_head,
+					  struct dxgdevice, device_list_entry);
+		list_del(&device->device_list_entry);
+		device->device_list_entry.next = NULL;
+		mutex_unlock(&adapter_info->device_list_mutex);
+		dxgdevice_destroy(device);
+		mutex_lock(&adapter_info->device_list_mutex);
+	}
+	mutex_unlock(&adapter_info->device_list_mutex);
+
+	dxgadapter_remove_process(adapter_info);
+	kref_put(&adapter_info->adapter->adapter_kref, dxgadapter_release);
+	list_del(&adapter_info->process_adapter_list_entry);
+	vfree(adapter_info);
+}
+
+/*
+ * Must be called when dxgglobal::process_adapter_mutex is held
+ */
+void dxgprocess_adapter_release(struct dxgprocess_adapter *adapter_info)
+{
+	dev_dbg(dxgglobaldev, "%s %p %d",
+		    __func__, adapter_info, adapter_info->refcount);
+	adapter_info->refcount--;
+	if (adapter_info->refcount == 0)
+		dxgprocess_adapter_destroy(adapter_info);
+}
+
+int dxgprocess_adapter_add_device(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct dxgdevice *device)
+{
+	struct dxgprocess_adapter *entry;
+	struct dxgprocess_adapter *adapter_info = NULL;
+	int ret = 0;
+
+	dxgglobal_acquire_process_adapter_lock();
+
+	list_for_each_entry(entry, &process->process_adapter_list_head,
+			    process_adapter_list_entry) {
+		if (entry->adapter == adapter) {
+			adapter_info = entry;
+			break;
+		}
+	}
+	if (adapter_info == NULL) {
+		pr_err("failed to find process adapter info\n");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	mutex_lock(&adapter_info->device_list_mutex);
+	list_add_tail(&device->device_list_entry,
+		      &adapter_info->device_list_head);
+	device->adapter_info = adapter_info;
+	mutex_unlock(&adapter_info->device_list_mutex);
+
+cleanup:
+
+	dxgglobal_release_process_adapter_lock();
+	return ret;
+}
+
+void dxgprocess_adapter_remove_device(struct dxgdevice *device)
+{
+	dev_dbg(dxgglobaldev, "%s %p\n", __func__, device);
+	mutex_lock(&device->adapter_info->device_list_mutex);
+	if (device->device_list_entry.next) {
+		list_del(&device->device_list_entry);
+		device->device_list_entry.next = NULL;
+	}
+	mutex_unlock(&device->adapter_info->device_list_mutex);
+}
+
+void dxghwqueue_destroy(struct dxgprocess *process, struct dxghwqueue *hwqueue)
+{
+	/* Placeholder */
+}
+
+void dxgpagingqueue_destroy(struct dxgpagingqueue *pqueue)
 {
 	/* Placeholder */
 }
+
+void dxgpagingqueue_stop(struct dxgpagingqueue *pqueue)
+{
+	/* Placeholder */
+}
+
+void dxgallocation_destroy(struct dxgallocation *alloc)
+{
+	/* Placeholder */
+}
+
+void dxgallocation_stop(struct dxgallocation *alloc)
+{
+	/* Placeholder */
+}
+
+void dxgresource_destroy(struct dxgresource *resource)
+{
+	/* Placeholder */
+}
+
+void dxgsyncobject_destroy(struct dxgprocess *process,
+			   struct dxgsyncobject *syncobj)
+{
+	/* Placeholder */
+}
+
+void dxgsyncobject_stop(struct dxgsyncobject *syncobj)
+{
+	/* Placeholder */
+}
+
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 412ff6a5950a..269391319f56 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -723,10 +723,6 @@ long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 
 int dxg_unmap_iospace(void *va, u32 size);
-int dxg_copy_from_user(void *to, const void __user *from,
-				   unsigned long len);
-int dxg_copy_to_user(void __user *to, const void *from,
-				 unsigned long len);
 static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
 {
 	*luid = *(struct winluid *)&guid->b[0];
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index 4b57ecf47bb3..b05df641dc77 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2019, Microsoft Corporation.
  *
  * Author:
- *   Iouri Tarassov <iourit@microsoft.com>
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
  *
  * Dxgkrnl Graphics Driver
  * DXGPROCESS implementation
@@ -22,16 +22,322 @@
  */
 struct dxgprocess *dxgprocess_create(void)
 {
-	/* Placeholder */
-	return NULL;
+	struct dxgprocess *process;
+	int ret;
+
+	process = vzalloc(sizeof(struct dxgprocess));
+	if (process != NULL) {
+		dev_dbg(dxgglobaldev, "new dxgprocess created\n");
+		process->process = current;
+		process->pid = current->pid;
+		process->tgid = current->tgid;
+		mutex_init(&process->process_mutex);
+		ret = dxgvmb_send_create_process(process);
+		if (ret < 0) {
+			dev_dbg(dxgglobaldev, "send_create_process failed\n");
+			vfree(process);
+			process = NULL;
+		} else {
+			INIT_LIST_HEAD(&process->plistentry);
+			kref_init(&process->process_kref);
+
+			mutex_lock(&dxgglobal->plistmutex);
+			list_add_tail(&process->plistentry,
+				      &dxgglobal->plisthead);
+			mutex_unlock(&dxgglobal->plistmutex);
+
+			hmgrtable_init(&process->handle_table, process);
+			hmgrtable_init(&process->local_handle_table, process);
+			INIT_LIST_HEAD(&process->process_adapter_list_head);
+		}
+	}
+	return process;
 }
 
 void dxgprocess_destroy(struct dxgprocess *process)
 {
-	/* Placeholder */
+	int i;
+	enum hmgrentry_type t;
+	struct d3dkmthandle h;
+	void *o;
+	struct dxgsyncobject *syncobj;
+	struct dxgprocess_adapter *entry;
+	struct dxgprocess_adapter *tmp;
+
+	/* Destroy all adapter state */
+	dxgglobal_acquire_process_adapter_lock();
+	list_for_each_entry_safe(entry, tmp,
+				 &process->process_adapter_list_head,
+				 process_adapter_list_entry) {
+		dxgprocess_adapter_destroy(entry);
+	}
+	dxgglobal_release_process_adapter_lock();
+
+	i = 0;
+	while (hmgrtable_next_entry(&process->local_handle_table,
+				    &i, &t, &h, &o)) {
+		switch (t) {
+		case HMGRENTRY_TYPE_DXGADAPTER:
+			dxgprocess_close_adapter(process, h);
+			break;
+		default:
+			pr_err("invalid entry in local handle table %d", t);
+			break;
+		}
+	}
+
+	i = 0;
+	while (hmgrtable_next_entry(&process->handle_table, &i, &t, &h, &o)) {
+		switch (t) {
+		case HMGRENTRY_TYPE_DXGSYNCOBJECT:
+			dev_dbg(dxgglobaldev, "Destroy syncobj: %p %d", o, i);
+			syncobj = o;
+			syncobj->handle.v = 0;
+			dxgsyncobject_destroy(process, syncobj);
+			break;
+		default:
+			pr_err("invalid entry in handle table %d", t);
+			break;
+		}
+	}
+
+	hmgrtable_destroy(&process->handle_table);
+	hmgrtable_destroy(&process->local_handle_table);
+
+	for (i = 0; i < 2; i++) {
+		if (process->test_handle_table[i]) {
+			hmgrtable_destroy(process->test_handle_table[i]);
+			vfree(process->test_handle_table[i]);
+			process->test_handle_table[i] = NULL;
+		}
+	}
 }
 
 void dxgprocess_release(struct kref *refcount)
 {
-	/* Placeholder */
+	struct dxgprocess *process;
+
+	process = container_of(refcount, struct dxgprocess, process_kref);
+
+	mutex_lock(&dxgglobal->plistmutex);
+	list_del(&process->plistentry);
+	process->plistentry.next = NULL;
+	mutex_unlock(&dxgglobal->plistmutex);
+
+	dxgprocess_destroy(process);
+
+	if (process->host_handle.v)
+		dxgvmb_send_destroy_process(process->host_handle);
+	vfree(process);
+}
+
+struct dxgprocess_adapter *dxgprocess_get_adapter_info(struct dxgprocess
+						       *process,
+						       struct dxgadapter
+						       *adapter)
+{
+	struct dxgprocess_adapter *entry;
+
+	list_for_each_entry(entry, &process->process_adapter_list_head,
+			    process_adapter_list_entry) {
+		if (adapter == entry->adapter) {
+			dev_dbg(dxgglobaldev, "Found process info %p", entry);
+			return entry;
+		}
+	}
+	return NULL;
+}
+
+/*
+ * Dxgprocess takes references on dxgadapter and dxgprocess_adapter.
+ */
+int dxgprocess_open_adapter(struct dxgprocess *process,
+					struct dxgadapter *adapter,
+					struct d3dkmthandle *h)
+{
+	int ret = 0;
+	struct dxgprocess_adapter *adapter_info;
+	struct d3dkmthandle handle;
+
+	h->v = 0;
+	adapter_info = dxgprocess_get_adapter_info(process, adapter);
+	if (adapter_info == NULL) {
+		dev_dbg(dxgglobaldev, "creating new process adapter info\n");
+		adapter_info = dxgprocess_adapter_create(process, adapter);
+		if (adapter_info == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+	} else {
+		adapter_info->refcount++;
+	}
+
+	handle = hmgrtable_alloc_handle_safe(&process->local_handle_table,
+					     adapter, HMGRENTRY_TYPE_DXGADAPTER,
+					     true);
+	if (handle.v) {
+		*h = handle;
+	} else {
+		pr_err("failed to create adapter handle\n");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+cleanup:
+
+	if (ret < 0) {
+		if (adapter_info) {
+			dxgglobal_acquire_process_adapter_lock();
+			dxgprocess_adapter_release(adapter_info);
+			dxgglobal_release_process_adapter_lock();
+		}
+	}
+
+	return ret;
+}
+
+int dxgprocess_close_adapter(struct dxgprocess *process,
+			     struct d3dkmthandle handle)
+{
+	struct dxgadapter *adapter;
+	struct dxgprocess_adapter *adapter_info;
+	int ret = 0;
+
+	if (handle.v == 0)
+		return 0;
+
+	hmgrtable_lock(&process->local_handle_table, DXGLOCK_EXCL);
+	adapter = dxgprocess_get_adapter(process, handle);
+	if (adapter)
+		hmgrtable_free_handle(&process->local_handle_table,
+				      HMGRENTRY_TYPE_DXGADAPTER, handle);
+	hmgrtable_unlock(&process->local_handle_table, DXGLOCK_EXCL);
+
+	if (adapter) {
+		adapter_info = dxgprocess_get_adapter_info(process, adapter);
+		if (adapter_info) {
+			dxgglobal_acquire_process_adapter_lock();
+			dxgprocess_adapter_release(adapter_info);
+			dxgglobal_release_process_adapter_lock();
+		} else {
+			ret = -EINVAL;
+		}
+	} else {
+		pr_err("%s failed %x", __func__, handle.v);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+struct dxgadapter *dxgprocess_get_adapter(struct dxgprocess *process,
+					  struct d3dkmthandle handle)
+{
+	struct dxgadapter *adapter;
+
+	adapter = hmgrtable_get_object_by_type(&process->local_handle_table,
+					       HMGRENTRY_TYPE_DXGADAPTER,
+					       handle);
+	if (adapter == NULL)
+		pr_err("%s failed %x\n", __func__, handle.v);
+	return adapter;
+}
+
+/*
+ * Gets the adapter object from the process handle table.
+ * The adapter object is referenced.
+ * The function acquired the handle table lock shared.
+ */
+struct dxgadapter *dxgprocess_adapter_by_handle(struct dxgprocess *process,
+						struct d3dkmthandle handle)
+{
+	struct dxgadapter *adapter;
+
+	hmgrtable_lock(&process->local_handle_table, DXGLOCK_SHARED);
+	adapter = hmgrtable_get_object_by_type(&process->local_handle_table,
+					       HMGRENTRY_TYPE_DXGADAPTER,
+					       handle);
+	if (adapter == NULL)
+		pr_err("adapter_by_handle failed %x\n", handle.v);
+	else if (kref_get_unless_zero(&adapter->adapter_kref) == 0) {
+		pr_err("failed to acquire adapter reference\n");
+		adapter = NULL;
+	}
+	hmgrtable_unlock(&process->local_handle_table, DXGLOCK_SHARED);
+	return adapter;
+}
+
+struct dxgdevice *dxgprocess_device_by_object_handle(struct dxgprocess *process,
+						     enum hmgrentry_type t,
+						     struct d3dkmthandle handle)
+{
+	struct dxgdevice *device = NULL;
+	void *obj;
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
+	obj = hmgrtable_get_object_by_type(&process->handle_table, t, handle);
+	if (obj) {
+		struct d3dkmthandle device_handle = {};
+
+		switch (t) {
+		case HMGRENTRY_TYPE_DXGDEVICE:
+			device = obj;
+			break;
+		case HMGRENTRY_TYPE_DXGCONTEXT:
+			device_handle =
+			    ((struct dxgcontext *)obj)->device_handle;
+			break;
+		case HMGRENTRY_TYPE_DXGPAGINGQUEUE:
+			device_handle =
+			    ((struct dxgpagingqueue *)obj)->device_handle;
+			break;
+		case HMGRENTRY_TYPE_DXGHWQUEUE:
+			device_handle =
+			    ((struct dxghwqueue *)obj)->device_handle;
+			break;
+		default:
+			pr_err("invalid handle type: %d\n", t);
+			break;
+		}
+		if (device == NULL)
+			device = hmgrtable_get_object_by_type(
+					&process->handle_table,
+					 HMGRENTRY_TYPE_DXGDEVICE,
+					 device_handle);
+		if (device)
+			if (kref_get_unless_zero(&device->device_kref) == 0)
+				device = NULL;
+	}
+	if (device == NULL)
+		pr_err("device_by_handle failed: %d %x\n", t, handle.v);
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_SHARED);
+	return device;
+}
+
+struct dxgdevice *dxgprocess_device_by_handle(struct dxgprocess *process,
+					      struct d3dkmthandle handle)
+{
+	return dxgprocess_device_by_object_handle(process,
+						  HMGRENTRY_TYPE_DXGDEVICE,
+						  handle);
+}
+
+void dxgprocess_ht_lock_shared_down(struct dxgprocess *process)
+{
+	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
+}
+
+void dxgprocess_ht_lock_shared_up(struct dxgprocess *process)
+{
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_SHARED);
+}
+
+void dxgprocess_ht_lock_exclusive_down(struct dxgprocess *process)
+{
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+}
+
+void dxgprocess_ht_lock_exclusive_up(struct dxgprocess *process)
+{
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
 }
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index f27150a6b8b1..13dc34214f50 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -448,6 +448,84 @@ int dxgvmb_send_set_iospace_region(u64 start, u64 len,
 	return ret;
 }
 
+int dxgvmb_send_create_process(struct dxgprocess *process)
+{
+	int ret;
+	struct dxgkvmb_command_createprocess *command;
+	struct dxgkvmb_command_createprocess_return result = { 0 };
+	struct dxgvmbusmsg msg;
+	char s[WIN_MAX_PATH];
+	int i;
+
+	ret = init_message(&msg, NULL, process, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	command_vm_to_host_init1(&command->hdr, DXGK_VMBCOMMAND_CREATEPROCESS);
+	command->process = process;
+	command->process_id = process->process->pid;
+	command->linux_process = 1;
+	s[0] = 0;
+	__get_task_comm(s, WIN_MAX_PATH, process->process);
+	for (i = 0; i < WIN_MAX_PATH; i++) {
+		command->process_name[i] = s[i];
+		if (s[i] == 0)
+			break;
+	}
+
+	ret = dxgvmb_send_sync_msg(&dxgglobal->channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0) {
+		pr_err("create_process failed %d", ret);
+	} else if (result.hprocess.v == 0) {
+		pr_err("create_process returned 0 handle");
+		ret = -ENOTRECOVERABLE;
+	} else {
+		process->host_handle = result.hprocess;
+		dev_dbg(dxgglobaldev, "create_process returned %x",
+			    process->host_handle.v);
+	}
+
+	dxgglobal_release_channel_lock();
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_destroy_process(struct d3dkmthandle process)
+{
+	int ret;
+	struct dxgkvmb_command_destroyprocess *command;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+	command_vm_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_DESTROYPROCESS,
+				 process);
+	ret = dxgvmb_send_sync_msg_ntstatus(&dxgglobal->channel,
+					    msg.hdr, msg.size);
+	dxgglobal_release_channel_lock();
+
+cleanup:
+	free_message(&msg, NULL);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
 
 /*
  * Virtual GPU messages to the host
@@ -541,3 +619,239 @@ int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter)
 		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
 	return ret;
 }
+
+struct d3dkmthandle dxgvmb_send_create_device(struct dxgadapter *adapter,
+					struct dxgprocess *process,
+					struct d3dkmt_createdevice *args)
+{
+	int ret;
+	struct dxgkvmb_command_createdevice *command;
+	struct dxgkvmb_command_createdevice_return result = { };
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_CREATEDEVICE,
+				   process->host_handle);
+	command->flags = args->flags;
+	command->error_code = &dxgglobal->device_state_counter;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		result.device.v = 0;
+	free_message(&msg, process);
+cleanup:
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return result.device;
+}
+
+int dxgvmb_send_destroy_device(struct dxgadapter *adapter,
+			       struct dxgprocess *process,
+			       struct d3dkmthandle h)
+{
+	int ret;
+	struct dxgkvmb_command_destroydevice *command;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_DESTROYDEVICE,
+				   process->host_handle);
+	command->device = h;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
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
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
+				   struct dxgadapter *adapter,
+				   struct d3dkmt_queryadapterinfo *args)
+{
+	struct dxgkvmb_command_queryadapterinfo *command;
+	u32 cmd_size = sizeof(*command) + args->private_data_size - 1;
+	int ret;
+	u32 private_data_size;
+	void *private_data;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	ret = copy_from_user(command->private_data,
+			     args->private_data, args->private_data_size);
+	if (ret) {
+		pr_err("%s Faled to copy private data", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_QUERYADAPTERINFO,
+				   process->host_handle);
+	command->private_data_size = args->private_data_size;
+	command->query_type = args->type;
+
+	if (dxgglobal->vmbus_ver >= DXGK_VMBUS_INTERFACE_VERSION) {
+		private_data = msg.msg;
+		private_data_size = command->private_data_size +
+				    sizeof(struct ntstatus);
+	} else {
+		private_data = command->private_data;
+		private_data_size = command->private_data_size;
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   private_data, private_data_size);
+	if (ret < 0)
+		goto cleanup;
+
+	if (dxgglobal->vmbus_ver >= DXGK_VMBUS_INTERFACE_VERSION) {
+		ret = ntstatus2int(*(struct ntstatus *)private_data);
+		if (ret < 0)
+			goto cleanup;
+		private_data = (char *)private_data + sizeof(struct ntstatus);
+	}
+
+	switch (args->type) {
+	case _KMTQAITYPE_ADAPTERTYPE:
+	case _KMTQAITYPE_ADAPTERTYPE_RENDER:
+		{
+			struct d3dkmt_adaptertype *adapter_type =
+			    (void *)private_data;
+			adapter_type->paravirtualized = 1;
+			adapter_type->display_supported = 0;
+			adapter_type->post_device = 0;
+			adapter_type->indirect_display_device = 0;
+			adapter_type->acg_supported = 0;
+			adapter_type->support_set_timings_from_vidpn = 0;
+			break;
+		}
+	default:
+		break;
+	}
+	ret = copy_to_user(args->private_data, private_data,
+			   args->private_data_size);
+	if (ret) {
+		pr_err("%s Faled to copy private data to user", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
diff --git a/drivers/hv/dxgkrnl/hmgr.c b/drivers/hv/dxgkrnl/hmgr.c
index cdb6539df006..46a8e59b51b7 100644
--- a/drivers/hv/dxgkrnl/hmgr.c
+++ b/drivers/hv/dxgkrnl/hmgr.c
@@ -65,7 +65,220 @@ struct hmgrentry {
 	u32 destroyed:1;
 };
 
+#define HMGRTABLE_SIZE_INCREMENT	1024
+#define HMGRTABLE_MIN_FREE_ENTRIES 128
 #define HMGRTABLE_INVALID_INDEX (~((1 << HMGRHANDLE_INDEX_BITS) - 1))
+#define HMGRTABLE_SIZE_MAX		0xFFFFFFF
+
+static u32 table_size_increment = HMGRTABLE_SIZE_INCREMENT;
+
+static inline u32 get_unique(struct d3dkmthandle h)
+{
+	return (h.v & HMGRHANDLE_UNIQUE_MASK) >> HMGRHANDLE_UNIQUE_SHIFT;
+}
+
+static u32 get_index(struct d3dkmthandle h)
+{
+	return (h.v & HMGRHANDLE_INDEX_MASK) >> HMGRHANDLE_INDEX_SHIFT;
+}
+
+u32 get_instance(struct d3dkmthandle h)
+{
+	return (h.v & HMGRHANDLE_INSTANCE_MASK) >> HMGRHANDLE_INSTANCE_SHIFT;
+}
+
+static bool is_handle_valid(struct hmgrtable *table, struct d3dkmthandle h,
+			    bool ignore_destroyed, enum hmgrentry_type t)
+{
+	u32 index = get_index(h);
+	u32 unique = get_unique(h);
+	struct hmgrentry *entry;
+
+	if (index >= table->table_size) {
+		pr_err("%s Invalid index %x %d\n", __func__, h.v, index);
+		return false;
+	}
+
+	entry = &table->entry_table[index];
+	if (unique != entry->unique) {
+		pr_err("%s Invalid unique %x %d %d %d %p",
+			   __func__, h.v, unique, entry->unique,
+			   index, entry->object);
+		return false;
+	}
+
+	if (entry->destroyed && !ignore_destroyed) {
+		pr_err("%s Invalid destroyed", __func__);
+		return false;
+	}
+
+	if (entry->type == HMGRENTRY_TYPE_FREE) {
+		pr_err("%s Entry is freed %x %d", __func__, h.v, index);
+		return false;
+	}
+
+	if (t != HMGRENTRY_TYPE_FREE && t != entry->type) {
+		pr_err("%s type mismatch %x %d %d", __func__, h.v,
+			   t, entry->type);
+		return false;
+	}
+
+	return true;
+}
+
+static struct d3dkmthandle build_handle(u32 index, u32 unique, u32 instance)
+{
+	struct d3dkmthandle handle;
+
+	handle.v = (index << HMGRHANDLE_INDEX_SHIFT) & HMGRHANDLE_INDEX_MASK;
+	handle.v |= (unique << HMGRHANDLE_UNIQUE_SHIFT) &
+	    HMGRHANDLE_UNIQUE_MASK;
+	handle.v |= (instance << HMGRHANDLE_INSTANCE_SHIFT) &
+	    HMGRHANDLE_INSTANCE_MASK;
+
+	return handle;
+}
+
+inline u32 hmgrtable_get_used_entry_count(struct hmgrtable *table)
+{
+	DXGKRNL_ASSERT(table->table_size >= table->free_count);
+	return (table->table_size - table->free_count);
+}
+
+bool hmgrtable_mark_destroyed(struct hmgrtable *table, struct d3dkmthandle h)
+{
+	if (!is_handle_valid(table, h, false, HMGRENTRY_TYPE_FREE))
+		return false;
+
+	table->entry_table[get_index(h)].destroyed = true;
+	return true;
+}
+
+bool hmgrtable_unmark_destroyed(struct hmgrtable *table, struct d3dkmthandle h)
+{
+	if (!is_handle_valid(table, h, true, HMGRENTRY_TYPE_FREE))
+		return true;
+
+	DXGKRNL_ASSERT(table->entry_table[get_index(h)].destroyed);
+	table->entry_table[get_index(h)].destroyed = 0;
+	return true;
+}
+
+static inline bool is_empty(struct hmgrtable *table)
+{
+	return (table->free_count == table->table_size);
+}
+
+void print_status(struct hmgrtable *table)
+{
+	int i;
+
+	dev_dbg(dxgglobaldev, "hmgrtable head, tail %p %d %d\n",
+		    table, table->free_handle_list_head,
+		    table->free_handle_list_tail);
+	if (table->entry_table == NULL)
+		return;
+	for (i = 0; i < 3; i++) {
+		if (table->entry_table[i].type != HMGRENTRY_TYPE_FREE)
+			dev_dbg(dxgglobaldev, "hmgrtable entry %p %d %p\n",
+				    table, i, table->entry_table[i].object);
+		else
+			dev_dbg(dxgglobaldev, "hmgrtable entry %p %d %d %d\n",
+				    table, i,
+				    table->entry_table[i].next_free_index,
+				    table->entry_table[i].prev_free_index);
+	}
+}
+
+static bool expand_table(struct hmgrtable *table, u32 NumEntries)
+{
+	u32 new_table_size;
+	struct hmgrentry *new_entry;
+	u32 table_index;
+	u32 new_free_count;
+	u32 prev_free_index;
+	u32 tail_index = table->free_handle_list_tail;
+
+	/* The tail should point to the last free element in the list */
+	if (table->free_count != 0) {
+		if (tail_index >= table->table_size ||
+		    table->entry_table[tail_index].next_free_index !=
+		    HMGRTABLE_INVALID_INDEX) {
+			pr_err("%s:corruption\n", __func__);
+			pr_err("tail_index: %x", tail_index);
+			pr_err("table size: %x", table->table_size);
+			pr_err("free_count: %d", table->free_count);
+			pr_err("NumEntries: %x", NumEntries);
+			return false;
+		}
+	}
+
+	new_free_count = table_size_increment + table->free_count;
+	new_table_size = table->table_size + table_size_increment;
+	if (new_table_size < NumEntries) {
+		new_free_count += NumEntries - new_table_size;
+		new_table_size = NumEntries;
+	}
+
+	if (new_table_size > HMGRHANDLE_INDEX_MAX) {
+		pr_err("%s:corruption\n", __func__);
+		return false;
+	}
+
+	new_entry = (struct hmgrentry *)
+	    vzalloc(new_table_size * sizeof(struct hmgrentry));
+	if (new_entry == NULL) {
+		pr_err("%s:allocation failed\n", __func__);
+		return false;
+	}
+
+	if (table->entry_table) {
+		memcpy(new_entry, table->entry_table,
+		       table->table_size * sizeof(struct hmgrentry));
+		vfree(table->entry_table);
+	} else {
+		table->free_handle_list_head = 0;
+	}
+
+	table->entry_table = new_entry;
+
+	/* Initialize new table entries and add to the free list */
+	table_index = table->table_size;
+
+	prev_free_index = table->free_handle_list_tail;
+
+	while (table_index < new_table_size) {
+		struct hmgrentry *entry = &table->entry_table[table_index];
+
+		entry->prev_free_index = prev_free_index;
+		entry->next_free_index = table_index + 1;
+		entry->type = HMGRENTRY_TYPE_FREE;
+		entry->unique = 1;
+		entry->instance = 0;
+		prev_free_index = table_index;
+
+		table_index++;
+	}
+
+	table->entry_table[table_index - 1].next_free_index =
+	    (u32) HMGRTABLE_INVALID_INDEX;
+
+	if (table->free_count != 0) {
+		/* Link the current free list with the new entries */
+		struct hmgrentry *entry;
+
+		entry = &table->entry_table[table->free_handle_list_tail];
+		entry->next_free_index = table->table_size;
+	}
+	table->free_handle_list_tail = new_table_size - 1;
+	if (table->free_handle_list_head == HMGRTABLE_INVALID_INDEX)
+		table->free_handle_list_head = table->table_size;
+
+	table->table_size = new_table_size;
+	table->free_count = new_free_count;
+
+	return true;
+}
 
 void hmgrtable_init(struct hmgrtable *table, struct dxgprocess *process)
 {
@@ -86,3 +299,299 @@ void hmgrtable_destroy(struct hmgrtable *table)
 	}
 }
 
+void hmgrtable_lock(struct hmgrtable *table, enum dxglockstate state)
+{
+	if (state == DXGLOCK_EXCL)
+		down_write(&table->table_lock);
+	else
+		down_read(&table->table_lock);
+}
+
+void hmgrtable_unlock(struct hmgrtable *table, enum dxglockstate state)
+{
+	if (state == DXGLOCK_EXCL)
+		up_write(&table->table_lock);
+	else
+		up_read(&table->table_lock);
+}
+
+struct d3dkmthandle hmgrtable_alloc_handle(struct hmgrtable *table,
+					   void *object,
+					   enum hmgrentry_type type,
+					   bool make_valid)
+{
+	u32 index;
+	struct hmgrentry *entry;
+	u32 unique;
+
+	DXGKRNL_ASSERT(type <= HMGRENTRY_TYPE_LIMIT);
+	DXGKRNL_ASSERT(type > HMGRENTRY_TYPE_FREE);
+
+	if (table->free_count <= HMGRTABLE_MIN_FREE_ENTRIES) {
+		if (!expand_table(table, 0)) {
+			pr_err("hmgrtable expand_table failed\n");
+			return zerohandle;
+		}
+	}
+
+	if (table->free_handle_list_head >= table->table_size) {
+		pr_err("hmgrtable corrupted handle table head\n");
+		return zerohandle;
+	}
+
+	index = table->free_handle_list_head;
+	entry = &table->entry_table[index];
+
+	if (entry->type != HMGRENTRY_TYPE_FREE) {
+		pr_err("hmgrtable expected free handle\n");
+		return zerohandle;
+	}
+
+	table->free_handle_list_head = entry->next_free_index;
+
+	if (entry->next_free_index != table->free_handle_list_tail) {
+		if (entry->next_free_index >= table->table_size) {
+			pr_err("hmgrtable invalid next free index\n");
+			return zerohandle;
+		}
+		table->entry_table[entry->next_free_index].prev_free_index =
+		    HMGRTABLE_INVALID_INDEX;
+	}
+
+	unique = table->entry_table[index].unique;
+
+	table->entry_table[index].object = object;
+	table->entry_table[index].type = type;
+	table->entry_table[index].instance = 0;
+	table->entry_table[index].destroyed = !make_valid;
+	table->free_count--;
+	DXGKRNL_ASSERT(table->free_count <= table->table_size);
+
+	return build_handle(index, unique, table->entry_table[index].instance);
+}
+
+int hmgrtable_assign_handle_safe(struct hmgrtable *table,
+				 void *object,
+				 enum hmgrentry_type type,
+				 struct d3dkmthandle h)
+{
+	int ret;
+
+	hmgrtable_lock(table, DXGLOCK_EXCL);
+	ret = hmgrtable_assign_handle(table, object, type, h);
+	hmgrtable_unlock(table, DXGLOCK_EXCL);
+	return ret;
+}
+
+int hmgrtable_assign_handle(struct hmgrtable *table, void *object,
+			    enum hmgrentry_type type, struct d3dkmthandle h)
+{
+	u32 index = get_index(h);
+	u32 unique = get_unique(h);
+	struct hmgrentry *entry = NULL;
+
+	dev_dbg(dxgglobaldev, "%s %x, %d %p, %p\n",
+		    __func__, h.v, index, object, table);
+
+	if (index >= HMGRHANDLE_INDEX_MAX) {
+		pr_err("handle index is too big: %x %d", h.v, index);
+		return -EINVAL;
+	}
+
+	if (index >= table->table_size) {
+		u32 new_size = index + table_size_increment;
+
+		if (new_size > HMGRHANDLE_INDEX_MAX)
+			new_size = HMGRHANDLE_INDEX_MAX;
+		if (!expand_table(table, new_size)) {
+			pr_err("failed to expand handle table %d", new_size);
+			return -ENOMEM;
+		}
+	}
+
+	entry = &table->entry_table[index];
+
+	if (entry->type != HMGRENTRY_TYPE_FREE) {
+		pr_err("the entry is already busy: %d %x",
+			   entry->type,
+			   hmgrtable_build_entry_handle(table, index).v);
+		return -EINVAL;
+	}
+
+	if (index != table->free_handle_list_tail) {
+		if (entry->next_free_index >= table->table_size) {
+			pr_err("hmgr: invalid next free index %d\n",
+				   entry->next_free_index);
+			return -EINVAL;
+		}
+		table->entry_table[entry->next_free_index].prev_free_index =
+		    entry->prev_free_index;
+	} else {
+		table->free_handle_list_tail = entry->prev_free_index;
+	}
+
+	if (index != table->free_handle_list_head) {
+		if (entry->prev_free_index >= table->table_size) {
+			pr_err("hmgr: invalid next prev index %d\n",
+				   entry->prev_free_index);
+			return -EINVAL;
+		}
+		table->entry_table[entry->prev_free_index].next_free_index =
+		    entry->next_free_index;
+	} else {
+		table->free_handle_list_head = entry->next_free_index;
+	}
+
+	entry->prev_free_index = HMGRTABLE_INVALID_INDEX;
+	entry->next_free_index = HMGRTABLE_INVALID_INDEX;
+	entry->object = object;
+	entry->type = type;
+	entry->instance = 0;
+	entry->unique = unique;
+	entry->destroyed = false;
+
+	table->free_count--;
+	DXGKRNL_ASSERT(table->free_count <= table->table_size);
+	return 0;
+}
+
+struct d3dkmthandle hmgrtable_alloc_handle_safe(struct hmgrtable *table,
+						void *obj,
+						enum hmgrentry_type type,
+						bool make_valid)
+{
+	struct d3dkmthandle h;
+
+	hmgrtable_lock(table, DXGLOCK_EXCL);
+	h = hmgrtable_alloc_handle(table, obj, type, make_valid);
+	hmgrtable_unlock(table, DXGLOCK_EXCL);
+	return h;
+}
+
+void hmgrtable_free_handle(struct hmgrtable *table, enum hmgrentry_type t,
+			   struct d3dkmthandle h)
+{
+	struct hmgrentry *entry;
+	u32 i = get_index(h);
+
+	dev_dbg(dxgglobaldev, "%s: %p %x\n", __func__, table, h.v);
+
+	/* Ignore the destroyed flag when checking the handle */
+	if (is_handle_valid(table, h, true, t)) {
+		DXGKRNL_ASSERT(table->free_count < table->table_size);
+		entry = &table->entry_table[i];
+		entry->unique = 1;
+		entry->type = HMGRENTRY_TYPE_FREE;
+		entry->destroyed = 0;
+		if (entry->unique != HMGRHANDLE_UNIQUE_MAX)
+			entry->unique += 1;
+		else
+			entry->unique = 1;
+
+		table->free_count++;
+		DXGKRNL_ASSERT(table->free_count <= table->table_size);
+
+		/*
+		 * Insert the index to the free list at the tail.
+		 */
+		entry->next_free_index = HMGRTABLE_INVALID_INDEX;
+		entry->prev_free_index = table->free_handle_list_tail;
+		entry = &table->entry_table[table->free_handle_list_tail];
+		entry->next_free_index = i;
+		table->free_handle_list_tail = i;
+	} else {
+		pr_err("%s:error: %d %x\n", __func__, i, h.v);
+	}
+}
+
+void hmgrtable_free_handle_safe(struct hmgrtable *table, enum hmgrentry_type t,
+				struct d3dkmthandle h)
+{
+	hmgrtable_lock(table, DXGLOCK_EXCL);
+	hmgrtable_free_handle(table, t, h);
+	hmgrtable_unlock(table, DXGLOCK_EXCL);
+}
+
+struct d3dkmthandle hmgrtable_build_entry_handle(struct hmgrtable *table,
+						 u32 index)
+{
+	DXGKRNL_ASSERT(index < table->table_size);
+
+	return build_handle(index, table->entry_table[index].unique,
+			    table->entry_table[index].instance);
+}
+
+void *hmgrtable_get_object(struct hmgrtable *table, struct d3dkmthandle h)
+{
+	if (!is_handle_valid(table, h, false, HMGRENTRY_TYPE_FREE))
+		return NULL;
+
+	return table->entry_table[get_index(h)].object;
+}
+
+void *hmgrtable_get_object_by_type(struct hmgrtable *table,
+				   enum hmgrentry_type type,
+				   struct d3dkmthandle h)
+{
+	if (!is_handle_valid(table, h, false, type)) {
+		pr_err("%s invalid handle %x\n", __func__, h.v);
+		return NULL;
+	}
+	return table->entry_table[get_index(h)].object;
+}
+
+void *hmgrtable_get_entry_object(struct hmgrtable *table, u32 index)
+{
+	DXGKRNL_ASSERT(index < table->table_size);
+	DXGKRNL_ASSERT(table->entry_table[index].type != HMGRENTRY_TYPE_FREE);
+
+	return table->entry_table[index].object;
+}
+
+enum hmgrentry_type hmgrtable_get_entry_type(struct hmgrtable *table,
+					     u32 index)
+{
+	DXGKRNL_ASSERT(index < table->table_size);
+	return (enum hmgrentry_type)table->entry_table[index].type;
+}
+
+enum hmgrentry_type hmgrtable_get_object_type(struct hmgrtable *table,
+					      struct d3dkmthandle h)
+{
+	if (!is_handle_valid(table, h, false, HMGRENTRY_TYPE_FREE))
+		return HMGRENTRY_TYPE_FREE;
+
+	return hmgrtable_get_entry_type(table, get_index(h));
+}
+
+void *hmgrtable_get_object_ignore_destroyed(struct hmgrtable *table,
+					    struct d3dkmthandle h,
+					    enum hmgrentry_type type)
+{
+	if (!is_handle_valid(table, h, true, type))
+		return NULL;
+	return table->entry_table[get_index(h)].object;
+}
+
+bool hmgrtable_next_entry(struct hmgrtable *tbl,
+			  u32 *index,
+			  enum hmgrentry_type *type,
+			  struct d3dkmthandle *handle,
+			  void **object)
+{
+	u32 i;
+	struct hmgrentry *entry;
+
+	for (i = *index; i < tbl->table_size; i++) {
+		entry = &tbl->entry_table[i];
+		if (entry->type != HMGRENTRY_TYPE_FREE) {
+			*index = i + 1;
+			*object = entry->object;
+			*handle = build_handle(i, entry->unique,
+					       entry->instance);
+			*type = entry->type;
+			return true;
+		}
+	}
+	return false;
+}
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index c6548fbdd8ef..590ce9bfa592 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -17,21 +17,825 @@
 #include <linux/anon_inodes.h>
 #include <linux/mman.h>
 
+#include "dxgkrnl.h"
+#include "dxgvmbus.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk:err: " fmt
+#undef dev_fmt
+#define dev_fmt(fmt)	"dxgk: " fmt
+
+struct ioctl_desc {
+	int (*ioctl_callback)(struct dxgprocess *p, void __user *arg);
+	u32 ioctl;
+	u32 arg_size;
+};
+static struct ioctl_desc ioctls[LX_IO_MAX + 1];
+
+static char *errorstr(int ret)
+{
+	return ret < 0 ? "err" : "";
+}
+
+static int dxgk_open_adapter_from_luid(struct dxgprocess *process,
+						   void *__user inargs)
+{
+	struct d3dkmt_openadapterfromluid args;
+	int ret;
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmt_openadapterfromluid *__user result = inargs;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s Faled to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_SHARED);
+	dxgglobal_acquire_process_adapter_lock();
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (dxgadapter_acquire_lock_shared(entry) == 0) {
+			dev_dbg(dxgglobaldev, "Compare luids: %d:%d  %d:%d",
+				    entry->luid.b, entry->luid.a,
+				    args.adapter_luid.b, args.adapter_luid.a);
+			if (*(u64 *) &entry->luid ==
+			    *(u64 *) &args.adapter_luid) {
+				ret =
+				    dxgprocess_open_adapter(process, entry,
+						    &args.adapter_handle);
+
+				if (ret >= 0) {
+					ret = copy_to_user(
+						&result->adapter_handle,
+						&args.adapter_handle,
+						sizeof(struct d3dkmthandle));
+					if (ret)
+						ret = -EINVAL;
+				}
+				adapter = entry;
+			}
+			dxgadapter_release_lock_shared(entry);
+			if (adapter)
+				break;
+		}
+	}
+
+	dxgglobal_release_process_adapter_lock();
+	dxgglobal_release_adapter_list_lock(DXGLOCK_SHARED);
+
+	if (args.adapter_handle.v == 0)
+		ret = -EINVAL;
+
+cleanup:
+
+	if (ret < 0)
+		dxgprocess_close_adapter(process, args.adapter_handle);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgkp_enum_adapters(struct dxgprocess *process,
+		    union d3dkmt_enumadapters_filter filter,
+		    u32 adapter_count_max,
+		    struct d3dkmt_adapterinfo *__user info_out,
+		    u32 * __user adapter_count_out)
+{
+	int ret = 0;
+	struct dxgadapter *entry;
+	struct d3dkmt_adapterinfo *info = NULL;
+	struct dxgadapter **adapters = NULL;
+	int adapter_count = 0;
+	int i;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+	if (info_out == NULL || adapter_count_max == 0) {
+		dev_dbg(dxgglobaldev, "buffer is NULL");
+		ret = copy_to_user(adapter_count_out,
+				   &dxgglobal->num_adapters, sizeof(u32));
+		if (ret) {
+			pr_err("%s copy_to_user faled",	__func__);
+			ret = -EINVAL;
+		}
+		goto cleanup;
+	}
+
+	if (adapter_count_max > 0xFFFF) {
+		pr_err("too many adapters");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	info = vzalloc(sizeof(struct d3dkmt_adapterinfo) * adapter_count_max);
+	if (info == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	adapters = vzalloc(sizeof(struct dxgadapter *) * adapter_count_max);
+	if (adapters == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_SHARED);
+	dxgglobal_acquire_process_adapter_lock();
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (dxgadapter_acquire_lock_shared(entry) == 0) {
+			struct d3dkmt_adapterinfo *inf = &info[adapter_count];
+
+			ret = dxgprocess_open_adapter(process, entry,
+						      &inf->adapter_handle);
+			if (ret >= 0) {
+				inf->adapter_luid = entry->luid;
+				adapters[adapter_count] = entry;
+				dev_dbg(dxgglobaldev, "adapter: %x %x:%x",
+					    inf->adapter_handle.v,
+					    inf->adapter_luid.b,
+					    inf->adapter_luid.a);
+				adapter_count++;
+			}
+			dxgadapter_release_lock_shared(entry);
+		}
+		if (ret < 0)
+			break;
+	}
+
+	dxgglobal_release_process_adapter_lock();
+	dxgglobal_release_adapter_list_lock(DXGLOCK_SHARED);
+
+	if (adapter_count > adapter_count_max) {
+		ret = STATUS_BUFFER_TOO_SMALL;
+		dev_dbg(dxgglobaldev, "Too many adapters");
+		ret = copy_to_user(adapter_count_out,
+				   &dxgglobal->num_adapters, sizeof(u32));
+		if (ret) {
+			pr_err("%s copy_to_user failed", __func__);
+			ret = -EINVAL;
+		}
+		goto cleanup;
+	}
+
+	ret = copy_to_user(adapter_count_out, &adapter_count,
+			   sizeof(adapter_count));
+	if (ret) {
+		pr_err("%s failed to copy adapter_count", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(info_out, info, sizeof(info[0]) * adapter_count);
+	if (ret) {
+		pr_err("%s failed to copy adapter info", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (ret >= 0) {
+		dev_dbg(dxgglobaldev, "found %d adapters", adapter_count);
+		goto success;
+	}
+	if (info) {
+		for (i = 0; i < adapter_count; i++)
+			dxgprocess_close_adapter(process,
+						 info[i].adapter_handle);
+	}
+success:
+	if (info)
+		vfree(info);
+	if (adapters)
+		vfree(adapters);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_enum_adapters(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_enumadapters2 args;
+	int ret;
+	struct dxgadapter *entry;
+	struct d3dkmt_adapterinfo *info = NULL;
+	struct dxgadapter **adapters = NULL;
+	int adapter_count = 0;
+	int i;
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
+	if (args.adapters == NULL) {
+		dev_dbg(dxgglobaldev, "buffer is NULL");
+		args.num_adapters = dxgglobal->num_adapters;
+		ret = copy_to_user(inargs, &args, sizeof(args));
+		if (ret) {
+			pr_err("%s failed to copy args to user", __func__);
+			ret = -EINVAL;
+		}
+		goto cleanup;
+	}
+	if (args.num_adapters < dxgglobal->num_adapters) {
+		args.num_adapters = dxgglobal->num_adapters;
+		dev_dbg(dxgglobaldev, "buffer is too small");
+		ret = -EOVERFLOW;
+		goto cleanup;
+	}
+
+	if (args.num_adapters > D3DKMT_ADAPTERS_MAX) {
+		dev_dbg(dxgglobaldev, "too many adapters");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	info = vzalloc(sizeof(struct d3dkmt_adapterinfo) * args.num_adapters);
+	if (info == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	adapters = vzalloc(sizeof(struct dxgadapter *) * args.num_adapters);
+	if (adapters == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_SHARED);
+	dxgglobal_acquire_process_adapter_lock();
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (dxgadapter_acquire_lock_shared(entry) == 0) {
+			struct d3dkmt_adapterinfo *inf = &info[adapter_count];
+
+			ret = dxgprocess_open_adapter(process, entry,
+						      &inf->adapter_handle);
+			if (ret >= 0) {
+				inf->adapter_luid = entry->luid;
+				adapters[adapter_count] = entry;
+				dev_dbg(dxgglobaldev, "adapter: %x %llx",
+					    inf->adapter_handle.v,
+					    *(u64 *) &inf->adapter_luid);
+				adapter_count++;
+			}
+			dxgadapter_release_lock_shared(entry);
+		}
+		if (ret < 0)
+			break;
+	}
+
+	dxgglobal_release_process_adapter_lock();
+	dxgglobal_release_adapter_list_lock(DXGLOCK_SHARED);
+
+	args.num_adapters = adapter_count;
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy args to user", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(args.adapters, info,
+			   sizeof(info[0]) * args.num_adapters);
+	if (ret) {
+		pr_err("%s failed to copy adapter info to user", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (ret < 0) {
+		if (info) {
+			for (i = 0; i < args.num_adapters; i++) {
+				dxgprocess_close_adapter(process,
+							info[i].adapter_handle);
+			}
+		}
+	} else {
+		dev_dbg(dxgglobaldev, "found %d adapters", args.num_adapters);
+	}
+
+	if (info)
+		vfree(info);
+	if (adapters)
+		vfree(adapters);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_enum_adapters3(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_enumadapters3 args;
+	int ret;
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
+	ret = dxgkp_enum_adapters(process, args.filter,
+				  args.adapter_count,
+				  args.adapters,
+				  &((struct d3dkmt_enumadapters3 *)inargs)->
+				  adapter_count);
+
+cleanup:
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_close_adapter(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmthandle args;
+	int ret;
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
+	ret = dxgprocess_close_adapter(process, args);
+	if (ret < 0)
+		pr_err("%s failed", __func__);
+
+cleanup:
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_query_adapter_info(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryadapterinfo args;
+	int ret;
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
+	if (args.private_data_size > DXG_MAX_VM_BUS_PACKET_SIZE ||
+	    args.private_data_size == 0) {
+		pr_err("invalid private data size");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	dev_dbg(dxgglobaldev, "Type: %d Size: %x",
+		args.type, args.private_data_size);
+
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_query_adapter_info(process, adapter, &args);
+
+	dxgadapter_release_lock_shared(adapter);
+
+cleanup:
+
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_create_device(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_createdevice args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct d3dkmthandle host_device_handle = {};
+	bool adapter_locked = false;
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
+	/* The call acquires reference on the adapter */
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgdevice_create(adapter, process);
+	if (device == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0)
+		goto cleanup;
+
+	adapter_locked = true;
+
+	host_device_handle = dxgvmb_send_create_device(adapter, process, &args);
+	if (host_device_handle.v) {
+		ret = copy_to_user(&((struct d3dkmt_createdevice *)inargs)->
+				   device, &host_device_handle,
+				   sizeof(struct d3dkmthandle));
+		if (ret) {
+			pr_err("%s failed to copy device handle", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+
+		hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+		ret = hmgrtable_assign_handle(&process->handle_table, device,
+					      HMGRENTRY_TYPE_DXGDEVICE,
+					      host_device_handle);
+		if (ret >= 0) {
+			device->handle = host_device_handle;
+			device->handle_valid = 1;
+			device->object_state = DXGOBJECTSTATE_ACTIVE;
+		}
+		hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	}
+
+cleanup:
+
+	if (ret < 0) {
+		if (host_device_handle.v)
+			dxgvmb_send_destroy_device(adapter, process,
+						   host_device_handle);
+		if (device)
+			dxgdevice_destroy(device);
+	}
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_destroy_device(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_destroydevice args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
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
+	device = hmgrtable_get_object_by_type(&process->handle_table,
+					      HMGRENTRY_TYPE_DXGDEVICE,
+					      args.device);
+	if (device) {
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGDEVICE, args.device);
+		device->handle_valid = 0;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (device == NULL) {
+		pr_err("invalid device handle: %x", args.device.v);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = device->adapter;
+
+	dxgdevice_destroy(device);
+
+	if (dxgadapter_acquire_lock_shared(adapter) == 0) {
+		dxgvmb_send_destroy_device(adapter, process, args.device);
+		dxgadapter_release_lock_shared(adapter);
+	}
+
+cleanup:
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
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
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
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
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int dxgk_create_hwcontext(struct dxgprocess *process,
+					     void *__user inargs)
+{
+	/* This is obsolete entry point */
+	return -ENOTTY;
+}
+
+static int dxgk_destroy_hwcontext(struct dxgprocess *process,
+					      void *__user inargs)
+{
+	/* This is obsolete entry point */
+	return -ENOTTY;
+}
+
+static int
+dxgk_create_context(struct dxgprocess *process, void *__user inargs)
+{
+	pr_err("%s is not implemented", __func__);
+	return -ENOTTY;
+}
+
 /*
- * Placeholder for IOCTL implementation
+ * IOCTL processing
+ * The driver IOCTLs return
+ * - 0 in case of success
+ * - positive values, which are Windows NTSTATUS (for example, STATUS_PENDING).
+ *   Positive values are success codes.
+ * - Linux negative error codes
  */
+static int dxgk_ioctl(struct file *f, unsigned int p1, unsigned long p2)
+{
+	int code = _IOC_NR(p1);
+	int status;
+	struct dxgprocess *process;
+
+	if (code < 1 || code > LX_IO_MAX) {
+		pr_err("bad ioctl %x %x %x %x",
+			   code, _IOC_TYPE(p1), _IOC_SIZE(p1), _IOC_DIR(p1));
+		return -ENOTTY;
+	}
+	if (ioctls[code].ioctl_callback == NULL) {
+		pr_err("ioctl callback is NULL %x", code);
+		return -ENOTTY;
+	}
+	if (ioctls[code].ioctl != p1) {
+		pr_err("ioctl mismatch. Code: %x User: %x Kernel: %x",
+			   code, p1, ioctls[code].ioctl);
+		return -ENOTTY;
+	}
+	process = (struct dxgprocess *)f->private_data;
+	if (process->tgid != current->tgid) {
+		pr_err("Call from a wrong process: %d %d",
+			   process->tgid, current->tgid);
+		return -ENOTTY;
+	}
+	status = ioctls[code].ioctl_callback(process, (void *__user)p2);
+	return status;
+}
 
 long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2)
 {
-	return -ENODEV;
+	dev_dbg(dxgglobaldev, "  compat ioctl %x", p1);
+	return dxgk_ioctl(f, p1, p2);
 }
 
 long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2)
 {
-	return -ENODEV;
+	dev_dbg(dxgglobaldev, "   unlocked ioctl %x Code:%d", p1, _IOC_NR(p1));
+	return dxgk_ioctl(f, p1, p2);
 }
 
+#define SET_IOCTL(callback, v)				\
+	ioctls[_IOC_NR(v)].ioctl_callback = callback;	\
+	ioctls[_IOC_NR(v)].ioctl = v
+
 void init_ioctls(void)
 {
-	/* Placeholder */
+	SET_IOCTL(/*0x1 */ dxgk_open_adapter_from_luid,
+		  LX_DXOPENADAPTERFROMLUID);
+	SET_IOCTL(/*0x2 */ dxgk_create_device,
+		  LX_DXCREATEDEVICE);
+	SET_IOCTL(/*0x3 */ dxgk_create_context,
+		  LX_DXCREATECONTEXT);
+	SET_IOCTL(/*0x4 */ dxgk_create_context_virtual,
+		  LX_DXCREATECONTEXTVIRTUAL);
+	SET_IOCTL(/*0x5 */ dxgk_destroy_context,
+		  LX_DXDESTROYCONTEXT);
+	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
+		  LX_DXQUERYADAPTERINFO);
+	SET_IOCTL(/*0x14 */ dxgk_enum_adapters,
+		  LX_DXENUMADAPTERS2);
+	SET_IOCTL(/*0x15 */ dxgk_close_adapter,
+		  LX_DXCLOSEADAPTER);
+	SET_IOCTL(/*0x17 */ dxgk_create_hwcontext,
+		  LX_DXCREATEHWCONTEXT);
+	SET_IOCTL(/*0x19 */ dxgk_destroy_device,
+		  LX_DXDESTROYDEVICE);
+	SET_IOCTL(/*0x1a */ dxgk_destroy_hwcontext,
+		  LX_DXDESTROYHWCONTEXT);
+	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
+		  LX_DXENUMADAPTERS3);
 }
-- 
2.32.0

