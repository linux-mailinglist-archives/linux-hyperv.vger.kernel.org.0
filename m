Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994014AA5CC
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbiBECe2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:28 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45084 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379001AbiBECeY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:24 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5153820B8019;
        Fri,  4 Feb 2022 18:34:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5153820B8019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028464;
        bh=/+PHDGwJnbjIUQ6Gs1MnXriutgbNHLn8+CSb0M89Om8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgRwfxdznAqWZug23cPnlJZ44zDVKb0VEhbYLibLjYuSoE/A3rESeOpMnVhux4oeI
         NBAD/t5H5k0LJs19HxuedfHXpuBDZvoZcPUYX8m9qslDcooaBk1GUZW5sM8w59/rOv
         yeIM2gKG+tB9QjHQJobsdFsm+Npn3ve5AW8JH6yE=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 06/24] drivers: hv: dxgkrnl: Creation of GPU allocations and resources
Date:   Fri,  4 Feb 2022 18:34:04 -0800
Message-Id: <72b26c8d74b5037e243c0814d5ad17b418a8dd08.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implemented ioctls to create and destroy GPU allocations and
resources:
  LX_DXCREATEALLOCATION(D3DKMTCreateAllocation),
  LX_DXDESTROYALLOCATION2(D3DKMTDestroyAllocation2).

GPU allocations (dxgallocation objects) represent memory allocation,
which could be accessible by GPU. Allocations can be created
around existing system memory (provided by the application) or
memory, allocated by dxgkrnl.

GPU resources (dxgresource objects) represent containers ofr GPU
allocations. Allocations could be dynamically added, removed from
a resource.

Each allocation/resource has associated driver private data, which
is provided during creation.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 274 ++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    | 109 ++++++
 drivers/hv/dxgkrnl/dxgmodule.c  |   1 +
 drivers/hv/dxgkrnl/dxgvmbus.c   | 645 ++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c      | 637 +++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/misc.h       |   3 +
 6 files changed, 1669 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 9cdc81d4db4a..3f51456272cc 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -211,8 +211,11 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 		device->process = process;
 		kref_get(&adapter->adapter_kref);
 		INIT_LIST_HEAD(&device->context_list_head);
+		INIT_LIST_HEAD(&device->alloc_list_head);
+		INIT_LIST_HEAD(&device->resource_list_head);
 		init_rwsem(&device->device_lock);
 		init_rwsem(&device->context_list_lock);
+		init_rwsem(&device->alloc_list_lock);
 		INIT_LIST_HEAD(&device->pqueue_list_head);
 		device->object_state = DXGOBJECTSTATE_CREATED;
 		device->execution_state = _D3DKMT_DEVICEEXECUTION_ACTIVE;
@@ -228,6 +231,16 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 
 void dxgdevice_stop(struct dxgdevice *device)
 {
+	struct dxgallocation *alloc;
+
+	pr_debug("%s: %p", __func__, device);
+	dxgdevice_acquire_alloc_list_lock(device);
+	list_for_each_entry(alloc, &device->alloc_list_head, alloc_list_entry) {
+		dxgallocation_stop(alloc);
+	}
+	dxgdevice_release_alloc_list_lock(device);
+
+	pr_debug("%s: end %p\n", __func__, device);
 }
 
 void dxgdevice_mark_destroyed(struct dxgdevice *device)
@@ -254,6 +267,33 @@ void dxgdevice_destroy(struct dxgdevice *device)
 
 	dxgdevice_stop(device);
 
+	dxgdevice_acquire_alloc_list_lock(device);
+
+	{
+		struct dxgallocation *alloc;
+		struct dxgallocation *tmp;
+
+		pr_debug("destroying allocations\n");
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
+		pr_debug("destroying resources\n");
+		list_for_each_entry_safe(resource, tmp,
+					 &device->resource_list_head,
+					 resource_list_entry) {
+			dxgresource_destroy(resource);
+		}
+	}
+
+	dxgdevice_release_alloc_list_lock(device);
+
 	{
 		struct dxgcontext *context;
 		struct dxgcontext *tmp;
@@ -331,6 +371,26 @@ void dxgdevice_release_context_list_lock(struct dxgdevice *device)
 	up_write(&device->context_list_lock);
 }
 
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
 void dxgdevice_add_context(struct dxgdevice *device, struct dxgcontext *context)
 {
 	down_write(&device->context_list_lock);
@@ -347,6 +407,160 @@ void dxgdevice_remove_context(struct dxgdevice *device,
 	}
 }
 
+void dxgdevice_add_alloc(struct dxgdevice *device, struct dxgallocation *alloc)
+{
+	dxgdevice_acquire_alloc_list_lock(device);
+	list_add_tail(&alloc->alloc_list_entry, &device->alloc_list_head);
+	kref_get(&device->device_kref);
+	alloc->owner.device = device;
+	dxgdevice_release_alloc_list_lock(device);
+}
+
+void dxgdevice_remove_alloc(struct dxgdevice *device,
+			    struct dxgallocation *alloc)
+{
+	if (alloc->alloc_list_entry.next) {
+		list_del(&alloc->alloc_list_entry);
+		alloc->alloc_list_entry.next = NULL;
+		kref_put(&device->device_kref, dxgdevice_release);
+	}
+}
+
+void dxgdevice_remove_alloc_safe(struct dxgdevice *device,
+				 struct dxgallocation *alloc)
+{
+	dxgdevice_acquire_alloc_list_lock(device);
+	dxgdevice_remove_alloc(device, alloc);
+	dxgdevice_release_alloc_list_lock(device);
+}
+
+void dxgdevice_add_resource(struct dxgdevice *device, struct dxgresource *res)
+{
+	dxgdevice_acquire_alloc_list_lock(device);
+	list_add_tail(&res->resource_list_entry, &device->resource_list_head);
+	kref_get(&device->device_kref);
+	dxgdevice_release_alloc_list_lock(device);
+}
+
+void dxgdevice_remove_resource(struct dxgdevice *device,
+			       struct dxgresource *res)
+{
+	if (res->resource_list_entry.next) {
+		list_del(&res->resource_list_entry);
+		res->resource_list_entry.next = NULL;
+		kref_put(&device->device_kref, dxgdevice_release);
+	}
+}
+
+struct dxgresource *dxgresource_create(struct dxgdevice *device)
+{
+	struct dxgresource *resource = vzalloc(sizeof(struct dxgresource));
+
+	if (resource) {
+		kref_init(&resource->resource_kref);
+		resource->device = device;
+		resource->process = device->process;
+		resource->object_state = DXGOBJECTSTATE_ACTIVE;
+		mutex_init(&resource->resource_mutex);
+		INIT_LIST_HEAD(&resource->alloc_list_head);
+		dxgdevice_add_resource(device, resource);
+	}
+	return resource;
+}
+
+void dxgresource_free_handle(struct dxgresource *resource)
+{
+	struct dxgallocation *alloc;
+	struct dxgprocess *process;
+
+	if (resource->handle_valid) {
+		process = resource->device->process;
+		hmgrtable_free_handle_safe(&process->handle_table,
+					   HMGRENTRY_TYPE_DXGRESOURCE,
+					   resource->handle);
+		resource->handle_valid = 0;
+	}
+	list_for_each_entry(alloc, &resource->alloc_list_head,
+			    alloc_list_entry) {
+		dxgallocation_free_handle(alloc);
+	}
+}
+
+void dxgresource_destroy(struct dxgresource *resource)
+{
+	/* device->alloc_list_lock is held */
+	struct dxgallocation *alloc;
+	struct dxgallocation *tmp;
+	struct d3dkmt_destroyallocation2 args = { };
+	int destroyed = test_and_set_bit(0, &resource->flags);
+	struct dxgdevice *device = resource->device;
+
+	if (!destroyed) {
+		dxgresource_free_handle(resource);
+		if (resource->handle.v) {
+			args.device = device->handle;
+			args.resource = resource->handle;
+			dxgvmb_send_destroy_allocation(device->process,
+						       device, &args, NULL);
+			resource->handle.v = 0;
+		}
+		list_for_each_entry_safe(alloc, tmp, &resource->alloc_list_head,
+					 alloc_list_entry) {
+			dxgallocation_destroy(alloc);
+		}
+		dxgdevice_remove_resource(device, resource);
+	}
+	kref_put(&resource->resource_kref, dxgresource_release);
+}
+
+void dxgresource_release(struct kref *refcount)
+{
+	struct dxgresource *resource;
+
+	resource = container_of(refcount, struct dxgresource, resource_kref);
+	vfree(resource);
+}
+
+bool dxgresource_is_active(struct dxgresource *resource)
+{
+	return resource->object_state == DXGOBJECTSTATE_ACTIVE;
+}
+
+int dxgresource_add_alloc(struct dxgresource *resource,
+				      struct dxgallocation *alloc)
+{
+	int ret = -ENODEV;
+	struct dxgdevice *device = resource->device;
+
+	dxgdevice_acquire_alloc_list_lock(device);
+	if (dxgresource_is_active(resource)) {
+		list_add_tail(&alloc->alloc_list_entry,
+			      &resource->alloc_list_head);
+		alloc->owner.resource = resource;
+		ret = 0;
+	}
+	alloc->resource_owner = 1;
+	dxgdevice_release_alloc_list_lock(device);
+	return ret;
+}
+
+void dxgresource_remove_alloc(struct dxgresource *resource,
+			      struct dxgallocation *alloc)
+{
+	if (alloc->alloc_list_entry.next) {
+		list_del(&alloc->alloc_list_entry);
+		alloc->alloc_list_entry.next = NULL;
+	}
+}
+
+void dxgresource_remove_alloc_safe(struct dxgresource *resource,
+				   struct dxgallocation *alloc)
+{
+	dxgdevice_acquire_alloc_list_lock(resource->device);
+	dxgresource_remove_alloc(resource, alloc);
+	dxgdevice_release_alloc_list_lock(resource->device);
+}
+
 void dxgdevice_release(struct kref *refcount)
 {
 	struct dxgdevice *device;
@@ -415,6 +629,66 @@ void dxgcontext_release(struct kref *refcount)
 	vfree(context);
 }
 
+struct dxgallocation *dxgallocation_create(struct dxgprocess *process)
+{
+	struct dxgallocation *alloc = vzalloc(sizeof(struct dxgallocation));
+
+	if (alloc)
+		alloc->process = process;
+	return alloc;
+}
+
+void dxgallocation_stop(struct dxgallocation *alloc)
+{
+	if (alloc->pages) {
+		release_pages(alloc->pages, alloc->num_pages);
+		vfree(alloc->pages);
+		alloc->pages = NULL;
+	}
+}
+
+void dxgallocation_free_handle(struct dxgallocation *alloc)
+{
+	dxgprocess_ht_lock_exclusive_down(alloc->process);
+	if (alloc->handle_valid) {
+		hmgrtable_free_handle(&alloc->process->handle_table,
+				      HMGRENTRY_TYPE_DXGALLOCATION,
+				      alloc->alloc_handle);
+		alloc->handle_valid = 0;
+	}
+	dxgprocess_ht_lock_exclusive_up(alloc->process);
+}
+
+void dxgallocation_destroy(struct dxgallocation *alloc)
+{
+	struct dxgprocess *process = alloc->process;
+	struct d3dkmt_destroyallocation2 args = { };
+
+	dxgallocation_stop(alloc);
+	if (alloc->resource_owner)
+		dxgresource_remove_alloc(alloc->owner.resource, alloc);
+	else if (alloc->owner.device)
+		dxgdevice_remove_alloc(alloc->owner.device, alloc);
+	dxgallocation_free_handle(alloc);
+	if (alloc->alloc_handle.v && !alloc->resource_owner) {
+		args.device = alloc->owner.device->handle;
+		args.alloc_count = 1;
+		dxgvmb_send_destroy_allocation(process,
+					       alloc->owner.device,
+					       &args, &alloc->alloc_handle);
+	}
+	if (alloc->gpadl.gpadl_handle) {
+		pr_debug("Teardown gpadl %d",
+			alloc->gpadl.gpadl_handle);
+		vmbus_teardown_gpadl(dxgglobal_get_vmbus(), &alloc->gpadl);
+		pr_debug("Teardown gpadl end");
+		alloc->gpadl.gpadl_handle = 0;
+	}
+	if (alloc->priv_drv_data)
+		vfree(alloc->priv_drv_data);
+	vfree(alloc);
+}
+
 struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 						     struct dxgadapter *adapter)
 {
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index b4ca479cdd1a..28c3dbef0ef3 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -31,6 +31,8 @@ struct dxgprocess;
 struct dxgadapter;
 struct dxgdevice;
 struct dxgcontext;
+struct dxgallocation;
+struct dxgresource;
 
 #include "misc.h"
 #include "hmgr.h"
@@ -252,6 +254,8 @@ struct dxgadapter {
 	struct list_head	adapter_list_entry;
 	/* The list of dxgprocess_adapter entries */
 	struct list_head	adapter_process_list_head;
+	/* This lock protects shared resource and syncobject lists */
+	struct rw_semaphore	shared_resource_list_lock;
 	struct pci_dev		*pci_dev;
 	struct hv_device	*hv_dev;
 	struct dxgvmbuschannel	channel;
@@ -298,6 +302,10 @@ struct dxgdevice {
 	struct rw_semaphore	device_lock;
 	struct rw_semaphore	context_list_lock;
 	struct list_head	context_list_head;
+	/* List of device allocations */
+	struct rw_semaphore	alloc_list_lock;
+	struct list_head	alloc_list_head;
+	struct list_head	resource_list_head;
 	/* List of paging queues. Protected by process handle table lock. */
 	struct list_head	pqueue_list_head;
 	struct d3dkmthandle	handle;
@@ -314,9 +322,19 @@ void dxgdevice_release_lock_shared(struct dxgdevice *dev);
 void dxgdevice_release(struct kref *refcount);
 void dxgdevice_add_context(struct dxgdevice *dev, struct dxgcontext *ctx);
 void dxgdevice_remove_context(struct dxgdevice *dev, struct dxgcontext *ctx);
+void dxgdevice_add_alloc(struct dxgdevice *dev, struct dxgallocation *a);
+void dxgdevice_remove_alloc(struct dxgdevice *dev, struct dxgallocation *a);
+void dxgdevice_remove_alloc_safe(struct dxgdevice *dev,
+				 struct dxgallocation *a);
+void dxgdevice_add_resource(struct dxgdevice *dev, struct dxgresource *res);
+void dxgdevice_remove_resource(struct dxgdevice *dev, struct dxgresource *res);
 bool dxgdevice_is_active(struct dxgdevice *dev);
 void dxgdevice_acquire_context_list_lock(struct dxgdevice *dev);
 void dxgdevice_release_context_list_lock(struct dxgdevice *dev);
+void dxgdevice_acquire_alloc_list_lock(struct dxgdevice *dev);
+void dxgdevice_release_alloc_list_lock(struct dxgdevice *dev);
+void dxgdevice_acquire_alloc_list_lock_shared(struct dxgdevice *dev);
+void dxgdevice_release_alloc_list_lock_shared(struct dxgdevice *dev);
 
 /*
  * The object represent the execution context of a device.
@@ -340,6 +358,79 @@ void dxgcontext_destroy_safe(struct dxgprocess *pr, struct dxgcontext *ctx);
 void dxgcontext_release(struct kref *refcount);
 bool dxgcontext_is_active(struct dxgcontext *ctx);
 
+struct dxgresource {
+	struct kref		resource_kref;
+	enum dxgobjectstate	object_state;
+	struct d3dkmthandle	handle;
+	struct list_head	alloc_list_head;
+	struct list_head	resource_list_entry;
+	struct list_head	shared_resource_list_entry;
+	struct dxgdevice	*device;
+	struct dxgprocess	*process;
+	/* Protects adding allocations to resource and resource destruction */
+	struct mutex		resource_mutex;
+	u64			private_runtime_handle;
+	union {
+		struct {
+			u32	destroyed:1;	/* Must be the first */
+			u32	handle_valid:1;
+			u32	reserved:30;
+		};
+		long		flags;
+	};
+};
+
+struct dxgresource *dxgresource_create(struct dxgdevice *dev);
+void dxgresource_destroy(struct dxgresource *res);
+void dxgresource_free_handle(struct dxgresource *res);
+void dxgresource_release(struct kref *refcount);
+int dxgresource_add_alloc(struct dxgresource *res,
+				      struct dxgallocation *a);
+void dxgresource_remove_alloc(struct dxgresource *res, struct dxgallocation *a);
+void dxgresource_remove_alloc_safe(struct dxgresource *res,
+				   struct dxgallocation *a);
+bool dxgresource_is_active(struct dxgresource *res);
+
+struct privdata {
+	u32 data_size;
+	u8 data[1];
+};
+
+struct dxgallocation {
+	/* Entry in the device list or resource list (when resource exists) */
+	struct list_head		alloc_list_entry;
+	/* Allocation owner */
+	union {
+		struct dxgdevice	*device;
+		struct dxgresource	*resource;
+	} owner;
+	struct dxgprocess		*process;
+	/* Pointer to private driver data desc. Used for shared resources */
+	struct privdata			*priv_drv_data;
+	struct d3dkmthandle		alloc_handle;
+	/* Set to 1 when allocation belongs to resource. */
+	u32				resource_owner:1;
+	/* Set to 1 when the allocatio is mapped as cached */
+	u32				cached:1;
+	u32				handle_valid:1;
+	/* GPADL address list for existing sysmem allocations */
+	struct vmbus_gpadl		gpadl;
+	/* Number of pages in the 'pages' array */
+	u32				num_pages;
+	/*
+	 * CPU address from the existing sysmem allocation, or
+	 * mapped to the CPU visible backing store in the IO space
+	 */
+	void				*cpu_address;
+	/* Describes pages for the existing sysmem allocation */
+	struct page			**pages;
+};
+
+struct dxgallocation *dxgallocation_create(struct dxgprocess *process);
+void dxgallocation_stop(struct dxgallocation *a);
+void dxgallocation_destroy(struct dxgallocation *a);
+void dxgallocation_free_handle(struct dxgallocation *a);
+
 void init_ioctls(void);
 long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
@@ -387,9 +478,27 @@ dxgvmb_send_create_context(struct dxgadapter *adapter,
 int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
 				struct dxgprocess *process,
 				struct d3dkmthandle h);
+int dxgvmb_send_create_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
+				  struct d3dkmt_createallocation *args,
+				  struct d3dkmt_createallocation *__user inargs,
+				  struct dxgresource *res,
+				  struct dxgallocation **allocs,
+				  struct d3dddi_allocationinfo2 *alloc_info,
+				  struct d3dkmt_createstandardallocation *stda);
+int dxgvmb_send_destroy_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
+				   struct d3dkmt_destroyallocation2 *args,
+				   struct d3dkmthandle *alloc_handles);
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
+int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
+				  enum d3dkmdt_standardallocationtype t,
+				  struct d3dkmdt_gdisurfacedata *data,
+				  u32 physical_adapter_index,
+				  u32 *alloc_priv_driver_size,
+				  void *prive_alloc_data,
+				  u32 *res_priv_data_size,
+				  void *priv_res_data);
 int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
 			  void *command,
 			  u32 cmd_size);
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index fafe0b6a6389..d865ac45f89d 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -158,6 +158,7 @@ int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
 	init_rwsem(&adapter->core_lock);
 
 	INIT_LIST_HEAD(&adapter->adapter_process_list_head);
+	init_rwsem(&adapter->shared_resource_list_lock);
 	adapter->pci_dev = dev;
 	guid_to_luid(guid, &adapter->luid);
 
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index bfd09f98f82c..541182c0b728 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -108,6 +108,40 @@ static int init_message(struct dxgvmbusmsg *msg, struct dxgadapter *adapter,
 	return 0;
 }
 
+static int init_message_res(struct dxgvmbusmsgres *msg,
+			    struct dxgadapter *adapter,
+			    struct dxgprocess *process,
+			    u32 size,
+			    u32 result_size)
+{
+	bool use_ext_header = dxgglobal->vmbus_ver >=
+			      DXGK_VMBUS_INTERFACE_VERSION;
+
+	if (use_ext_header)
+		size += sizeof(struct dxgvmb_ext_header);
+	msg->size = size;
+	msg->res_size += (result_size + 7) & ~7;
+	size += msg->res_size;
+	msg->hdr = vzalloc(size);
+	if (msg->hdr == NULL) {
+		pr_err("Failed to allocate VM bus message: %d", size);
+		return -ENOMEM;
+	}
+	if (use_ext_header) {
+		msg->msg = (char *)&msg->hdr[1];
+		msg->hdr->command_offset = sizeof(msg->hdr[0]);
+		msg->hdr->vgpu_luid = adapter->host_vgpu_luid;
+	} else {
+		msg->msg = (char *)msg->hdr;
+	}
+	msg->res = (char *)msg->hdr + msg->size;
+	if (dxgglobal->async_msg_enabled)
+		msg->channel = &dxgglobal->channel;
+	else
+		msg->channel = &adapter->channel;
+	return 0;
+}
+
 static void free_message(struct dxgvmbusmsg *msg, struct dxgprocess *process)
 {
 	if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
@@ -809,6 +843,617 @@ int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
 	return ret;
 }
 
+static int
+copy_private_data(struct d3dkmt_createallocation *args,
+		  struct dxgkvmb_command_createallocation *command,
+		  struct d3dddi_allocationinfo2 *input_alloc_info,
+		  struct d3dkmt_createstandardallocation *standard_alloc)
+{
+	struct dxgkvmb_command_createallocation_allocinfo *alloc_info;
+	struct d3dddi_allocationinfo2 *input_alloc;
+	int ret = 0;
+	int i;
+	u8 *private_data_dest = (u8 *) &command[1] +
+	    (args->alloc_count *
+	     sizeof(struct dxgkvmb_command_createallocation_allocinfo));
+
+	if (args->private_runtime_data_size) {
+		ret = copy_from_user(private_data_dest,
+				     args->private_runtime_data,
+				     args->private_runtime_data_size);
+		if (ret) {
+			pr_err("%s failed to copy runtime data", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		private_data_dest += args->private_runtime_data_size;
+	}
+
+	if (args->flags.standard_allocation) {
+		pr_debug("private data offset %d",
+			(u32) (private_data_dest - (u8 *) command));
+
+		args->priv_drv_data_size = sizeof(*args->standard_allocation);
+		memcpy(private_data_dest, standard_alloc,
+		       sizeof(*standard_alloc));
+		private_data_dest += args->priv_drv_data_size;
+	} else if (args->priv_drv_data_size) {
+		ret = copy_from_user(private_data_dest,
+				     args->priv_drv_data,
+				     args->priv_drv_data_size);
+		if (ret) {
+			pr_err("%s failed to copy private data", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		private_data_dest += args->priv_drv_data_size;
+	}
+
+	alloc_info = (void *)&command[1];
+	input_alloc = input_alloc_info;
+	if (input_alloc_info[0].sysmem)
+		command->flags.existing_sysmem = 1;
+	for (i = 0; i < args->alloc_count; i++) {
+		alloc_info->flags = input_alloc->flags.value;
+		alloc_info->vidpn_source_id = input_alloc->vidpn_source_id;
+		alloc_info->priv_drv_data_size =
+		    input_alloc->priv_drv_data_size;
+		if (input_alloc->priv_drv_data_size) {
+			ret = copy_from_user(private_data_dest,
+					     input_alloc->priv_drv_data,
+					     input_alloc->priv_drv_data_size);
+			if (ret) {
+				pr_err("%s failed to copy alloc data",
+					__func__);
+				ret = -EINVAL;
+				goto cleanup;
+			}
+			private_data_dest += input_alloc->priv_drv_data_size;
+		}
+		alloc_info++;
+		input_alloc++;
+	}
+
+cleanup:
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+static
+int create_existing_sysmem(struct dxgdevice *device,
+			   struct dxgkvmb_command_allocinfo_return *host_alloc,
+			   struct dxgallocation *dxgalloc,
+			   bool read_only,
+			   const void *sysmem)
+{
+	int ret1 = 0;
+	void *kmem = NULL;
+	int ret = 0;
+	struct dxgkvmb_command_setexistingsysmemstore *set_store_command;
+	u64 alloc_size = host_alloc->allocation_size;
+	u32 npages = alloc_size >> PAGE_SHIFT;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, device->adapter, device->process,
+			   sizeof(*set_store_command));
+	if (ret)
+		goto cleanup;
+	set_store_command = (void *)msg.msg;
+
+	/*
+	 * Create a guest physical address list and set it as the allocation
+	 * backing store in the host. This is done after creating the host
+	 * allocation, because only now the allocation size is known.
+	 */
+
+	pr_debug("   Alloc size: %lld", alloc_size);
+
+	dxgalloc->cpu_address = (void *)sysmem;
+	dxgalloc->pages = vzalloc(npages * sizeof(void *));
+	if (dxgalloc->pages == NULL) {
+		pr_err("failed to allocate pages");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	ret1 = get_user_pages_fast((unsigned long)sysmem, npages, !read_only,
+				  dxgalloc->pages);
+	if (ret1 != npages) {
+		pr_err("get_user_pages_fast failed: %d", ret1);
+		if (ret1 > 0 && ret1 < npages)
+			release_pages(dxgalloc->pages, ret1);
+		vfree(dxgalloc->pages);
+		dxgalloc->pages = NULL;
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	kmem = vmap(dxgalloc->pages, npages, VM_MAP, PAGE_KERNEL);
+	if (kmem == NULL) {
+		pr_err("vmap failed");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	ret1 = vmbus_establish_gpadl(dxgglobal_get_vmbus(), kmem,
+				     alloc_size, &dxgalloc->gpadl);
+	if (ret1) {
+		pr_err("establish_gpadl failed: %d", ret1);
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	pr_debug("New gpadl %d", dxgalloc->gpadl.gpadl_handle);
+
+	command_vgpu_to_host_init2(&set_store_command->hdr,
+				   DXGK_VMBCOMMAND_SETEXISTINGSYSMEMSTORE,
+				   device->process->host_handle);
+	set_store_command->device = device->handle;
+	set_store_command->device = device->handle;
+	set_store_command->allocation = host_alloc->allocation;
+	set_store_command->gpadl = dxgalloc->gpadl.gpadl_handle;
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+	if (ret < 0)
+		pr_err("failed to set existing store: %x", ret);
+
+cleanup:
+	if (kmem)
+		vunmap(kmem);
+	free_message(&msg, device->process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+static int
+process_allocation_handles(struct dxgprocess *process,
+			   struct dxgdevice *device,
+			   struct d3dkmt_createallocation *args,
+			   struct dxgkvmb_command_createallocation_return *res,
+			   struct dxgallocation **dxgalloc,
+			   struct dxgresource *resource)
+{
+	int ret = 0;
+	int i;
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	if (args->flags.create_resource) {
+		ret = hmgrtable_assign_handle(&process->handle_table, resource,
+					      HMGRENTRY_TYPE_DXGRESOURCE,
+					      res->resource);
+		if (ret < 0) {
+			pr_err("failed to assign resource handle %x",
+				   res->resource.v);
+		} else {
+			resource->handle = res->resource;
+			resource->handle_valid = 1;
+		}
+	}
+	for (i = 0; i < args->alloc_count; i++) {
+		struct dxgkvmb_command_allocinfo_return *host_alloc;
+
+		host_alloc = &res->allocation_info[i];
+		ret = hmgrtable_assign_handle(&process->handle_table,
+					      dxgalloc[i],
+					      HMGRENTRY_TYPE_DXGALLOCATION,
+					      host_alloc->allocation);
+		if (ret < 0) {
+			pr_err("failed to assign alloc handle %x %d %d",
+				   host_alloc->allocation.v,
+				   args->alloc_count, i);
+			break;
+		}
+		dxgalloc[i]->alloc_handle = host_alloc->allocation;
+		dxgalloc[i]->handle_valid = 1;
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+static int
+create_local_allocations(struct dxgprocess *process,
+			 struct dxgdevice *device,
+			 struct d3dkmt_createallocation *args,
+			 struct d3dkmt_createallocation *__user input_args,
+			 struct d3dddi_allocationinfo2 *alloc_info,
+			 struct dxgkvmb_command_createallocation_return *result,
+			 struct dxgresource *resource,
+			 struct dxgallocation **dxgalloc,
+			 u32 destroy_buffer_size)
+{
+	int i;
+	int alloc_count = args->alloc_count;
+	u8 *alloc_private_data = NULL;
+	int ret = 0;
+	int ret1;
+	struct dxgkvmb_command_destroyallocation *destroy_buf;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, device->adapter, process,
+			    destroy_buffer_size);
+	if (ret)
+		goto cleanup;
+	destroy_buf = (void *)msg.msg;
+
+	/* Prepare the command to destroy allocation in case of failure */
+	command_vgpu_to_host_init2(&destroy_buf->hdr,
+				   DXGK_VMBCOMMAND_DESTROYALLOCATION,
+				   process->host_handle);
+	destroy_buf->device = args->device;
+	destroy_buf->resource = args->resource;
+	destroy_buf->alloc_count = alloc_count;
+	destroy_buf->flags.assume_not_in_use = 1;
+	for (i = 0; i < alloc_count; i++) {
+		pr_debug("host allocation: %d %x",
+			     i, result->allocation_info[i].allocation.v);
+		destroy_buf->allocations[i] =
+		    result->allocation_info[i].allocation;
+	}
+
+	if (args->flags.create_resource) {
+		pr_debug("new resource: %x", result->resource.v);
+		ret = copy_to_user(&input_args->resource, &result->resource,
+				   sizeof(struct d3dkmthandle));
+		if (ret) {
+			pr_err("%s failed to copy resource handle", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	alloc_private_data = (u8 *) result +
+	    sizeof(struct dxgkvmb_command_createallocation_return) +
+	    sizeof(struct dxgkvmb_command_allocinfo_return) * (alloc_count - 1);
+
+	for (i = 0; i < alloc_count; i++) {
+		struct dxgkvmb_command_allocinfo_return *host_alloc;
+		struct d3dddi_allocationinfo2 *user_alloc;
+
+		host_alloc = &result->allocation_info[i];
+		user_alloc = &alloc_info[i];
+		dxgalloc[i]->num_pages =
+		    host_alloc->allocation_size >> PAGE_SHIFT;
+		if (user_alloc->sysmem) {
+			ret = create_existing_sysmem(device, host_alloc,
+						     dxgalloc[i],
+						     args->flags.read_only != 0,
+						     user_alloc->sysmem);
+			if (ret < 0)
+				goto cleanup;
+		}
+		dxgalloc[i]->cached = host_alloc->allocation_flags.cached;
+		if (host_alloc->priv_drv_data_size) {
+			ret = copy_to_user(user_alloc->priv_drv_data,
+					   alloc_private_data,
+					   host_alloc->priv_drv_data_size);
+			if (ret) {
+				pr_err("%s failed to copy private data",
+					__func__);
+				ret = -EINVAL;
+				goto cleanup;
+			}
+			alloc_private_data += host_alloc->priv_drv_data_size;
+		}
+		ret = copy_to_user(&args->allocation_info[i].allocation,
+				   &host_alloc->allocation,
+				   sizeof(struct d3dkmthandle));
+		if (ret) {
+			pr_err("%s failed to copy alloc handle", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	ret = process_allocation_handles(process, device, args, result,
+					 dxgalloc, resource);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(&input_args->global_share, &args->global_share,
+			   sizeof(struct d3dkmthandle));
+	if (ret) {
+		pr_err("%s failed to copy global share", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (ret < 0) {
+		/* Free local handles before freeing the handles in the host */
+		dxgdevice_acquire_alloc_list_lock(device);
+		if (dxgalloc)
+			for (i = 0; i < alloc_count; i++)
+				if (dxgalloc[i])
+					dxgallocation_free_handle(dxgalloc[i]);
+		if (resource && args->flags.create_resource)
+			dxgresource_free_handle(resource);
+		dxgdevice_release_alloc_list_lock(device);
+
+		/* Destroy allocations in the host to unmap gpadls */
+		ret1 = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
+						     msg.size);
+		if (ret1 < 0)
+			pr_err("failed to destroy allocations: %x", ret1);
+
+		dxgdevice_acquire_alloc_list_lock(device);
+		if (dxgalloc) {
+			for (i = 0; i < alloc_count; i++) {
+				if (dxgalloc[i]) {
+					dxgalloc[i]->alloc_handle.v = 0;
+					dxgallocation_destroy(dxgalloc[i]);
+					dxgalloc[i] = NULL;
+				}
+			}
+		}
+		if (resource && args->flags.create_resource) {
+			/*
+			 * Prevent the resource memory from freeing.
+			 * It will be freed in the top level function.
+			 */
+			kref_get(&resource->resource_kref);
+			dxgresource_destroy(resource);
+		}
+		dxgdevice_release_alloc_list_lock(device);
+	}
+
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_create_allocation(struct dxgprocess *process,
+				  struct dxgdevice *device,
+				  struct d3dkmt_createallocation *args,
+				  struct d3dkmt_createallocation *__user
+				  input_args,
+				  struct dxgresource *resource,
+				  struct dxgallocation **dxgalloc,
+				  struct d3dddi_allocationinfo2 *alloc_info,
+				  struct d3dkmt_createstandardallocation
+				  *standard_alloc)
+{
+	struct dxgkvmb_command_createallocation *command = NULL;
+	struct dxgkvmb_command_createallocation_return *result = NULL;
+	int ret = -EINVAL;
+	int i;
+	u32 result_size = 0;
+	u32 cmd_size = 0;
+	u32 destroy_buffer_size = 0;
+	u32 priv_drv_data_size;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (args->private_runtime_data_size >= DXG_MAX_VM_BUS_PACKET_SIZE ||
+	    args->priv_drv_data_size >= DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EOVERFLOW;
+		goto cleanup;
+	}
+
+	/*
+	 * Preallocate the buffer, which will be used for destruction in case
+	 * of a failure
+	 */
+	destroy_buffer_size = sizeof(struct dxgkvmb_command_destroyallocation) +
+	    args->alloc_count * sizeof(struct d3dkmthandle);
+
+	/* Compute the total private driver size */
+
+	priv_drv_data_size = 0;
+
+	for (i = 0; i < args->alloc_count; i++) {
+		if (alloc_info[i].priv_drv_data_size >=
+		    DXG_MAX_VM_BUS_PACKET_SIZE) {
+			ret = -EOVERFLOW;
+			goto cleanup;
+		} else {
+			priv_drv_data_size += alloc_info[i].priv_drv_data_size;
+		}
+		if (priv_drv_data_size >= DXG_MAX_VM_BUS_PACKET_SIZE) {
+			ret = -EOVERFLOW;
+			goto cleanup;
+		}
+	}
+
+	/*
+	 * Private driver data for the result includes only per allocation
+	 * private data
+	 */
+	result_size = sizeof(struct dxgkvmb_command_createallocation_return) +
+	    (args->alloc_count - 1) *
+	    sizeof(struct dxgkvmb_command_allocinfo_return) +
+	    priv_drv_data_size;
+	result = vzalloc(result_size);
+	if (result == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	/* Private drv data for the command includes the global private data */
+	priv_drv_data_size += args->priv_drv_data_size;
+
+	cmd_size = sizeof(struct dxgkvmb_command_createallocation) +
+	    args->alloc_count *
+	    sizeof(struct dxgkvmb_command_createallocation_allocinfo) +
+	    args->private_runtime_data_size + priv_drv_data_size;
+	if (cmd_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EOVERFLOW;
+		goto cleanup;
+	}
+
+	pr_debug("command size, driver_data_size %d %d %ld %ld",
+		    cmd_size, priv_drv_data_size,
+		    sizeof(struct dxgkvmb_command_createallocation),
+		    sizeof(struct dxgkvmb_command_createallocation_allocinfo));
+
+	ret = init_message(&msg, device->adapter, process,
+			   cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_CREATEALLOCATION,
+				   process->host_handle);
+	command->device = args->device;
+	command->flags = args->flags;
+	command->resource = args->resource;
+	command->private_runtime_resource_handle =
+	    args->private_runtime_resource_handle;
+	command->alloc_count = args->alloc_count;
+	command->private_runtime_data_size = args->private_runtime_data_size;
+	command->priv_drv_data_size = args->priv_drv_data_size;
+
+	ret = copy_private_data(args, command, alloc_info, standard_alloc);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, result_size);
+	if (ret < 0) {
+		pr_err("send_create_allocation failed %x", ret);
+		goto cleanup;
+	}
+
+	ret = create_local_allocations(process, device, args, input_args,
+				       alloc_info, result, resource, dxgalloc,
+				       destroy_buffer_size);
+cleanup:
+
+	if (result)
+		vfree(result);
+	free_message(&msg, process);
+
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
+				   struct dxgdevice *device,
+				   struct d3dkmt_destroyallocation2 *args,
+				   struct d3dkmthandle *alloc_handles)
+{
+	struct dxgkvmb_command_destroyallocation *destroy_buffer;
+	u32 destroy_buffer_size;
+	int ret;
+	int allocations_size = args->alloc_count * sizeof(struct d3dkmthandle);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	destroy_buffer_size = sizeof(struct dxgkvmb_command_destroyallocation) +
+	    allocations_size;
+
+	ret = init_message(&msg, device->adapter, process,
+			    destroy_buffer_size);
+	if (ret)
+		goto cleanup;
+	destroy_buffer = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&destroy_buffer->hdr,
+				   DXGK_VMBCOMMAND_DESTROYALLOCATION,
+				   process->host_handle);
+	destroy_buffer->device = args->device;
+	destroy_buffer->resource = args->resource;
+	destroy_buffer->alloc_count = args->alloc_count;
+	destroy_buffer->flags = args->flags;
+	if (allocations_size)
+		memcpy(destroy_buffer->allocations, alloc_handles,
+		       allocations_size);
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
+				  enum d3dkmdt_standardallocationtype alloctype,
+				  struct d3dkmdt_gdisurfacedata *alloc_data,
+				  u32 physical_adapter_index,
+				  u32 *alloc_priv_driver_size,
+				  void *priv_alloc_data,
+				  u32 *res_priv_data_size,
+				  void *priv_res_data)
+{
+	struct dxgkvmb_command_getstandardallocprivdata *command;
+	struct dxgkvmb_command_getstandardallocprivdata_return *result = NULL;
+	u32 result_size = sizeof(*result);
+	int ret;
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	if (priv_alloc_data)
+		result_size += *alloc_priv_driver_size;
+	if (priv_res_data)
+		result_size += *res_priv_data_size;
+	ret = init_message_res(&msg, device->adapter, device->process,
+			       sizeof(*command), result_size);
+	if (ret)
+		goto cleanup;
+	command = msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr,
+			DXGK_VMBCOMMAND_DDIGETSTANDARDALLOCATIONDRIVERDATA,
+			device->process->host_handle);
+
+	command->alloc_type = alloctype;
+	command->priv_driver_data_size = *alloc_priv_driver_size;
+	command->physical_adapter_index = physical_adapter_index;
+	command->priv_driver_resource_size = *res_priv_data_size;
+	switch (alloctype) {
+	case _D3DKMDT_STANDARDALLOCATION_GDISURFACE:
+		command->gdi_surface = *alloc_data;
+		break;
+	case _D3DKMDT_STANDARDALLOCATION_SHAREDPRIMARYSURFACE:
+	case _D3DKMDT_STANDARDALLOCATION_SHADOWSURFACE:
+	case _D3DKMDT_STANDARDALLOCATION_STAGINGSURFACE:
+	default:
+		pr_err("Invalid standard alloc type");
+		goto cleanup;
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
+	if (*alloc_priv_driver_size &&
+	    result->priv_driver_data_size != *alloc_priv_driver_size) {
+		pr_err("Priv data size mismatch");
+		goto cleanup;
+	}
+	if (*res_priv_data_size &&
+	    result->priv_driver_resource_size != *res_priv_data_size) {
+		pr_err("Resource priv data size mismatch");
+		goto cleanup;
+	}
+	*alloc_priv_driver_size = result->priv_driver_data_size;
+	*res_priv_data_size = result->priv_driver_resource_size;
+	if (priv_alloc_data) {
+		memcpy(priv_alloc_data, &result[1],
+		       result->priv_driver_data_size);
+	}
+	if (priv_res_data) {
+		memcpy(priv_res_data,
+		       (char *)(&result[1]) + result->priv_driver_data_size,
+		       result->priv_driver_resource_size);
+	}
+
+cleanup:
+
+	free_message((struct dxgvmbusmsg *)&msg, device->process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args)
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 879fb3c6b7b2..1f07a883debb 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -735,6 +735,639 @@ dxgk_destroy_context(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+get_standard_alloc_priv_data(struct dxgdevice *device,
+			     struct d3dkmt_createstandardallocation *alloc_info,
+			     u32 *standard_alloc_priv_data_size,
+			     void **standard_alloc_priv_data,
+			     u32 *standard_res_priv_data_size,
+			     void **standard_res_priv_data)
+{
+	int ret;
+	struct d3dkmdt_gdisurfacedata gdi_data = { };
+	u32 priv_data_size = 0;
+	u32 res_priv_data_size = 0;
+	void *priv_data = NULL;
+	void *res_priv_data = NULL;
+
+	gdi_data.type = _D3DKMDT_GDISURFACE_TEXTURE_CROSSADAPTER;
+	gdi_data.width = alloc_info->existing_heap_data.size;
+	gdi_data.height = 1;
+	gdi_data.format = _D3DDDIFMT_UNKNOWN;
+
+	*standard_alloc_priv_data_size = 0;
+	ret = dxgvmb_send_get_stdalloc_data(device,
+					_D3DKMDT_STANDARDALLOCATION_GDISURFACE,
+					&gdi_data, 0,
+					&priv_data_size, NULL,
+					&res_priv_data_size,
+					NULL);
+	if (ret < 0)
+		goto cleanup;
+	pr_debug("Priv data size: %d", priv_data_size);
+	if (priv_data_size == 0) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	priv_data = vzalloc(priv_data_size);
+	if (priv_data == NULL) {
+		ret = -ENOMEM;
+		pr_err("failed to allocate memory for priv data: %d",
+			   priv_data_size);
+		goto cleanup;
+	}
+	if (res_priv_data_size) {
+		res_priv_data = vzalloc(res_priv_data_size);
+		if (res_priv_data == NULL) {
+			ret = -ENOMEM;
+			pr_err("failed to alloc memory for res priv data: %d",
+				res_priv_data_size);
+			goto cleanup;
+		}
+	}
+	ret = dxgvmb_send_get_stdalloc_data(device,
+					_D3DKMDT_STANDARDALLOCATION_GDISURFACE,
+					&gdi_data, 0,
+					&priv_data_size,
+					priv_data,
+					&res_priv_data_size,
+					res_priv_data);
+	if (ret < 0)
+		goto cleanup;
+	*standard_alloc_priv_data_size = priv_data_size;
+	*standard_alloc_priv_data = priv_data;
+	*standard_res_priv_data_size = res_priv_data_size;
+	*standard_res_priv_data = res_priv_data;
+	priv_data = NULL;
+	res_priv_data = NULL;
+
+cleanup:
+	if (priv_data)
+		vfree(priv_data);
+	if (res_priv_data)
+		vfree(res_priv_data);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_create_allocation(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_createallocation args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct d3dddi_allocationinfo2 *alloc_info = NULL;
+	struct d3dkmt_createstandardallocation standard_alloc;
+	u32 alloc_info_size = 0;
+	struct dxgresource *resource = NULL;
+	struct dxgallocation **dxgalloc = NULL;
+	bool resource_mutex_acquired = false;
+	u32 standard_alloc_priv_data_size = 0;
+	void *standard_alloc_priv_data = NULL;
+	u32 res_priv_data_size = 0;
+	void *res_priv_data = NULL;
+	int i;
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
+	if (args.alloc_count > D3DKMT_CREATEALLOCATION_MAX ||
+	    args.alloc_count == 0) {
+		pr_err("invalid number of allocations to create");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	alloc_info_size = sizeof(struct d3dddi_allocationinfo2) *
+	    args.alloc_count;
+	alloc_info = vzalloc(alloc_info_size);
+	if (alloc_info == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	ret = copy_from_user(alloc_info, args.allocation_info,
+				 alloc_info_size);
+	if (ret) {
+		pr_err("%s failed to copy alloc info", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	for (i = 0; i < args.alloc_count; i++) {
+		if (args.flags.standard_allocation) {
+			if (alloc_info[i].priv_drv_data_size != 0) {
+				pr_err("private data size is not zero");
+				ret = -EINVAL;
+				goto cleanup;
+			}
+		}
+		if (alloc_info[i].priv_drv_data_size >=
+		    DXG_MAX_VM_BUS_PACKET_SIZE) {
+			pr_err("private data size is too big: %d %d %ld",
+				   i, alloc_info[i].priv_drv_data_size,
+				   sizeof(alloc_info[0]));
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	if (args.flags.existing_section || args.flags.create_protected) {
+		pr_err("invalid allocation flags");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.flags.standard_allocation) {
+		if (args.standard_allocation == NULL) {
+			pr_err("invalid standard allocation");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		ret = copy_from_user(&standard_alloc,
+				     args.standard_allocation,
+				     sizeof(standard_alloc));
+		if (ret) {
+			pr_err("%s failed to copy std alloc data", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		if (standard_alloc.type ==
+		    _D3DKMT_STANDARDALLOCATIONTYPE_EXISTINGHEAP) {
+			if (alloc_info[0].sysmem == NULL ||
+			   (unsigned long)alloc_info[0].sysmem &
+			   (PAGE_SIZE - 1)) {
+				pr_err("invalid sysmem pointer");
+				ret = STATUS_INVALID_PARAMETER;
+				goto cleanup;
+			}
+			if (!args.flags.existing_sysmem) {
+				pr_err("expected existing_sysmem flag");
+				ret = STATUS_INVALID_PARAMETER;
+				goto cleanup;
+			}
+		} else if (standard_alloc.type ==
+		    _D3DKMT_STANDARDALLOCATIONTYPE_CROSSADAPTER) {
+			if (args.flags.existing_sysmem) {
+				pr_err("existing_sysmem flag is invalid");
+				ret = STATUS_INVALID_PARAMETER;
+				goto cleanup;
+
+			}
+			if (alloc_info[0].sysmem != NULL) {
+				pr_err("sysmem should be NULL");
+				ret = STATUS_INVALID_PARAMETER;
+				goto cleanup;
+			}
+		} else {
+			pr_err("invalid standard allocation type");
+			ret = STATUS_INVALID_PARAMETER;
+			goto cleanup;
+		}
+
+		if (args.priv_drv_data_size != 0 ||
+		    args.alloc_count != 1 ||
+		    standard_alloc.existing_heap_data.size == 0 ||
+		    standard_alloc.existing_heap_data.size & (PAGE_SIZE - 1)) {
+			pr_err("invalid standard allocation");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		args.priv_drv_data_size =
+		    sizeof(struct d3dkmt_createstandardallocation);
+	}
+
+	if (args.flags.create_shared && !args.flags.create_resource) {
+		pr_err("create_resource must be set for create_shared");
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
+	if (args.flags.standard_allocation) {
+		ret = get_standard_alloc_priv_data(device,
+						&standard_alloc,
+						&standard_alloc_priv_data_size,
+						&standard_alloc_priv_data,
+						&res_priv_data_size,
+						&res_priv_data);
+		if (ret < 0)
+			goto cleanup;
+		pr_debug("Alloc private data: %d",
+			    standard_alloc_priv_data_size);
+	}
+
+	if (args.flags.create_resource) {
+		resource = dxgresource_create(device);
+		if (resource == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		resource->private_runtime_handle =
+		    args.private_runtime_resource_handle;
+	} else {
+		if (args.resource.v) {
+			/* Adding new allocations to the given resource */
+
+			dxgprocess_ht_lock_shared_down(process);
+			resource = hmgrtable_get_object_by_type(
+				&process->handle_table,
+				HMGRENTRY_TYPE_DXGRESOURCE,
+				args.resource);
+			kref_get(&resource->resource_kref);
+			dxgprocess_ht_lock_shared_up(process);
+
+			if (resource == NULL || resource->device != device) {
+				pr_err("invalid resource handle %x",
+					   args.resource.v);
+				ret = -EINVAL;
+				goto cleanup;
+			}
+			/* Synchronize with resource destruction */
+			mutex_lock(&resource->resource_mutex);
+			if (!dxgresource_is_active(resource)) {
+				mutex_unlock(&resource->resource_mutex);
+				ret = -EINVAL;
+				goto cleanup;
+			}
+			resource_mutex_acquired = true;
+		}
+	}
+
+	dxgalloc = vzalloc(sizeof(struct dxgallocation *) * args.alloc_count);
+	if (dxgalloc == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	for (i = 0; i < args.alloc_count; i++) {
+		struct dxgallocation *alloc;
+		u32 priv_data_size;
+
+		if (args.flags.standard_allocation)
+			priv_data_size = standard_alloc_priv_data_size;
+		else
+			priv_data_size = alloc_info[i].priv_drv_data_size;
+
+		if (alloc_info[i].sysmem && !args.flags.standard_allocation) {
+			if ((unsigned long)
+			    alloc_info[i].sysmem & (PAGE_SIZE - 1)) {
+				pr_err("invalid sysmem alloc %d, %p",
+					   i, alloc_info[i].sysmem);
+				ret = -EINVAL;
+				goto cleanup;
+			}
+		}
+		if ((alloc_info[0].sysmem == NULL) !=
+		    (alloc_info[i].sysmem == NULL)) {
+			pr_err("All allocations must have sysmem pointer");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+
+		dxgalloc[i] = dxgallocation_create(process);
+		if (dxgalloc[i] == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		alloc = dxgalloc[i];
+
+		if (resource) {
+			ret = dxgresource_add_alloc(resource, alloc);
+			if (ret < 0)
+				goto cleanup;
+		} else {
+			dxgdevice_add_alloc(device, alloc);
+		}
+		if (args.flags.create_shared) {
+			/* Remember alloc private data to use it during open */
+			alloc->priv_drv_data = vzalloc(priv_data_size +
+					offsetof(struct privdata, data) - 1);
+			if (alloc->priv_drv_data == NULL) {
+				ret = -ENOMEM;
+				goto cleanup;
+			}
+			if (args.flags.standard_allocation) {
+				memcpy(alloc->priv_drv_data->data,
+				       standard_alloc_priv_data,
+				       standard_alloc_priv_data_size);
+				alloc->priv_drv_data->data_size =
+				    standard_alloc_priv_data_size;
+			} else {
+				ret = copy_from_user(
+					alloc->priv_drv_data->data,
+					alloc_info[i].priv_drv_data,
+					priv_data_size);
+				if (ret) {
+					pr_err("%s failed to copy priv data",
+						__func__);
+					ret = -EINVAL;
+					goto cleanup;
+				}
+				alloc->priv_drv_data->data_size =
+				    priv_data_size;
+			}
+		}
+	}
+
+	ret = dxgvmb_send_create_allocation(process, device, &args, inargs,
+					    resource, dxgalloc, alloc_info,
+					    &standard_alloc);
+cleanup:
+
+	if (resource_mutex_acquired) {
+		mutex_unlock(&resource->resource_mutex);
+		kref_put(&resource->resource_kref, dxgresource_release);
+	}
+	if (ret < 0) {
+		if (dxgalloc) {
+			for (i = 0; i < args.alloc_count; i++) {
+				if (dxgalloc[i])
+					dxgallocation_destroy(dxgalloc[i]);
+			}
+		}
+		if (resource && args.flags.create_resource) {
+			dxgresource_destroy(resource);
+		}
+	}
+	if (dxgalloc)
+		vfree(dxgalloc);
+	if (standard_alloc_priv_data)
+		vfree(standard_alloc_priv_data);
+	if (res_priv_data)
+		vfree(res_priv_data);
+	if (alloc_info)
+		vfree(alloc_info);
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
+static int validate_alloc(struct dxgallocation *alloc0,
+			  struct dxgallocation *alloc,
+			  struct dxgdevice *device,
+			  struct d3dkmthandle alloc_handle)
+{
+	u32 fail_reason;
+
+	if (alloc == NULL) {
+		fail_reason = 1;
+		goto cleanup;
+	}
+	if (alloc->resource_owner != alloc0->resource_owner) {
+		fail_reason = 2;
+		goto cleanup;
+	}
+	if (alloc->resource_owner) {
+		if (alloc->owner.resource != alloc0->owner.resource) {
+			fail_reason = 3;
+			goto cleanup;
+		}
+		if (alloc->owner.resource->device != device) {
+			fail_reason = 4;
+			goto cleanup;
+		}
+	} else {
+		if (alloc->owner.device != device) {
+			fail_reason = 6;
+			goto cleanup;
+		}
+	}
+	return 0;
+cleanup:
+	pr_err("Alloc validation failed: reason: %d %x",
+		   fail_reason, alloc_handle.v);
+	return -EINVAL;
+}
+
+static int
+dxgk_destroy_allocation(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_destroyallocation2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int ret;
+	struct d3dkmthandle *alloc_handles = NULL;
+	struct dxgallocation **allocs = NULL;
+	struct dxgresource *resource = NULL;
+	int i;
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
+	if (args.alloc_count > D3DKMT_CREATEALLOCATION_MAX ||
+	    ((args.alloc_count == 0) == (args.resource.v == 0))) {
+		pr_err("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.alloc_count) {
+		u32 handle_size = sizeof(struct d3dkmthandle) *
+				   args.alloc_count;
+
+		alloc_handles = vzalloc(handle_size);
+		if (alloc_handles == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		allocs = vzalloc(sizeof(struct dxgallocation *) *
+				 args.alloc_count);
+		if (allocs == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		ret = copy_from_user(alloc_handles, args.allocations,
+					 handle_size);
+		if (ret) {
+			pr_err("%s failed to copy alloc handles", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
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
+	/* Acquire the device lock to synchronize with the device destriction */
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
+	/*
+	 * Destroy the local allocation handles first. If the host handle
+	 * is destroyed first, another object could be assigned to the process
+	 * table at the same place as the allocation handle and it will fail.
+	 */
+	if (args.alloc_count) {
+		dxgprocess_ht_lock_exclusive_down(process);
+		for (i = 0; i < args.alloc_count; i++) {
+			allocs[i] =
+			    hmgrtable_get_object_by_type(&process->handle_table,
+						HMGRENTRY_TYPE_DXGALLOCATION,
+						alloc_handles[i]);
+			ret =
+			    validate_alloc(allocs[0], allocs[i], device,
+					   alloc_handles[i]);
+			if (ret < 0) {
+				dxgprocess_ht_lock_exclusive_up(process);
+				goto cleanup;
+			}
+		}
+		dxgprocess_ht_lock_exclusive_up(process);
+		for (i = 0; i < args.alloc_count; i++)
+			dxgallocation_free_handle(allocs[i]);
+	} else {
+		struct dxgallocation *alloc;
+
+		dxgprocess_ht_lock_exclusive_down(process);
+		resource = hmgrtable_get_object_by_type(&process->handle_table,
+						HMGRENTRY_TYPE_DXGRESOURCE,
+						args.resource);
+		if (resource == NULL) {
+			pr_err("Invalid resource handle: %x",
+				   args.resource.v);
+			ret = -EINVAL;
+		} else if (resource->device != device) {
+			pr_err("Resource belongs to wrong device: %x",
+				   args.resource.v);
+			ret = -EINVAL;
+		} else {
+			hmgrtable_free_handle(&process->handle_table,
+					      HMGRENTRY_TYPE_DXGRESOURCE,
+					      args.resource);
+			resource->object_state = DXGOBJECTSTATE_DESTROYED;
+			resource->handle.v = 0;
+			resource->handle_valid = 0;
+		}
+		dxgprocess_ht_lock_exclusive_up(process);
+
+		if (ret < 0)
+			goto cleanup;
+
+		dxgdevice_acquire_alloc_list_lock_shared(device);
+		list_for_each_entry(alloc, &resource->alloc_list_head,
+				    alloc_list_entry) {
+			dxgallocation_free_handle(alloc);
+		}
+		dxgdevice_release_alloc_list_lock_shared(device);
+	}
+
+	if (args.alloc_count && allocs[0]->resource_owner)
+		resource = allocs[0]->owner.resource;
+
+	if (resource) {
+		kref_get(&resource->resource_kref);
+		mutex_lock(&resource->resource_mutex);
+	}
+
+	ret = dxgvmb_send_destroy_allocation(process, device, &args,
+					     alloc_handles);
+
+	/*
+	 * Destroy the allocations after the host destroyed it.
+	 * The allocation gpadl teardown will wait until the host unmaps its
+	 * gpadl.
+	 */
+	dxgdevice_acquire_alloc_list_lock(device);
+	if (args.alloc_count) {
+		for (i = 0; i < args.alloc_count; i++) {
+			if (allocs[i]) {
+				allocs[i]->alloc_handle.v = 0;
+				dxgallocation_destroy(allocs[i]);
+			}
+		}
+	} else {
+		dxgresource_destroy(resource);
+	}
+	dxgdevice_release_alloc_list_lock(device);
+
+	if (resource) {
+		mutex_unlock(&resource->resource_mutex);
+		kref_put(&resource->resource_kref, dxgresource_release);
+	}
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
+	if (alloc_handles)
+		vfree(alloc_handles);
+
+	if (allocs)
+		vfree(allocs);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 /*
  * IOCTL processing
  * The driver IOCTLs return
@@ -799,8 +1432,12 @@ void init_ioctls(void)
 		  LX_DXCREATECONTEXTVIRTUAL);
 	SET_IOCTL(/*0x5 */ dxgk_destroy_context,
 		  LX_DXDESTROYCONTEXT);
+	SET_IOCTL(/*0x6 */ dxgk_create_allocation,
+		  LX_DXCREATEALLOCATION);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
+	SET_IOCTL(/*0x13 */ dxgk_destroy_allocation,
+		  LX_DXDESTROYALLOCATION2);
 	SET_IOCTL(/*0x14 */ dxgk_enum_adapters,
 		  LX_DXENUMADAPTERS2);
 	SET_IOCTL(/*0x15 */ dxgk_close_adapter,
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index 8f7b37049308..41abdc504bc2 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -31,6 +31,9 @@ extern const struct d3dkmthandle zerohandle;
  * plistmutex
  * table_lock
  * context_list_lock
+ * alloc_list_lock
+ * resource_mutex
+ * shared_resource_list_lock
  * core_lock
  * device_lock
  * process_adapter_mutex
-- 
2.35.1

