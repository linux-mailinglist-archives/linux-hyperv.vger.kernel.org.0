Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BA448CC93
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 20:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350213AbiALT4f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 14:56:35 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33308 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357557AbiALTzQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 14:55:16 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id C019720B7185;
        Wed, 12 Jan 2022 11:55:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C019720B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642017315;
        bh=rpl6QpZBClUinknag3q7s48WpPhk0Q5PuuoS5Ta74OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0cpR672zVrvM9iEn0JfuxqDyVGw4fWq8cxlyoNJ68Cl5pXq5iixdQmcvwtIy5q9Z
         ezbx+kFB81JB3ZLdwap7JoWWqck10I3MbiK8tYyAETPniR44CfE97AGRW7MurNr+RU
         CaYZT20Fkld86MUv5ecba5Koev3VEz+srGj1Wp6U=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 3/9] drivers: hv: dxgkrnl: Implement creation/destruction of GPU allocations/resources
Date:   Wed, 12 Jan 2022 11:55:08 -0800
Message-Id: <b64ae0f1fceff68b6fb43331f14062f25f2ba07a.1641937419.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641937419.git.iourit@linux.microsoft.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implemented the following ioctls:
- Creation and destruction of GPU accessible allocations:
  LX_DXCREATEALLOCATION, LX_DXDESTROYALLOCATION2,
- LX_DXGETSHAREDRESOURCEADAPTERLUID
- LX_DXRENDER
  At this moment GPU paravirtualization does not support D3DKMTRender API.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 310 ++++++++++++-
 drivers/hv/dxgkrnl/dxgvmbus.c   | 665 ++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c      | 745 ++++++++++++++++++++++++++++++++
 3 files changed, 1705 insertions(+), 15 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index b461d6b6f55e..26648f7fe36f 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -447,6 +447,230 @@ void dxgdevice_remove_context(struct dxgdevice *device,
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
+struct dxgsharedresource *dxgsharedresource_create(struct dxgadapter *adapter)
+{
+	struct dxgsharedresource *resource;
+
+	resource = vzalloc(sizeof(*resource));
+	if (resource) {
+		INIT_LIST_HEAD(&resource->resource_list_head);
+		kref_init(&resource->sresource_kref);
+		mutex_init(&resource->fd_mutex);
+		resource->adapter = adapter;
+	}
+	return resource;
+}
+
+void dxgsharedresource_destroy(struct kref *refcount)
+{
+	struct dxgsharedresource *resource;
+
+	resource = container_of(refcount, struct dxgsharedresource,
+				sresource_kref);
+	if (resource->runtime_private_data)
+		vfree(resource->runtime_private_data);
+	if (resource->resource_private_data)
+		vfree(resource->resource_private_data);
+	if (resource->alloc_private_data_sizes)
+		vfree(resource->alloc_private_data_sizes);
+	if (resource->alloc_private_data)
+		vfree(resource->alloc_private_data);
+	vfree(resource);
+}
+
+void dxgsharedresource_add_resource(struct dxgsharedresource *shared_resource,
+				    struct dxgresource *resource)
+{
+	down_write(&shared_resource->adapter->shared_resource_list_lock);
+	dev_dbg(dxgglobaldev, "%s: %p %p", __func__, shared_resource, resource);
+	list_add_tail(&resource->shared_resource_list_entry,
+		      &shared_resource->resource_list_head);
+	kref_get(&shared_resource->sresource_kref);
+	kref_get(&resource->resource_kref);
+	resource->shared_owner = shared_resource;
+	up_write(&shared_resource->adapter->shared_resource_list_lock);
+}
+
+void dxgsharedresource_remove_resource(struct dxgsharedresource
+				       *shared_resource,
+				       struct dxgresource *resource)
+{
+	struct dxgadapter *adapter = shared_resource->adapter;
+
+	down_write(&adapter->shared_resource_list_lock);
+	dev_dbg(dxgglobaldev, "%s: %p %p", __func__, shared_resource, resource);
+	if (resource->shared_resource_list_entry.next) {
+		list_del(&resource->shared_resource_list_entry);
+		resource->shared_resource_list_entry.next = NULL;
+		kref_put(&shared_resource->sresource_kref,
+			 dxgsharedresource_destroy);
+		resource->shared_owner = NULL;
+		kref_put(&resource->resource_kref, dxgresource_release);
+	}
+	up_write(&adapter->shared_resource_list_lock);
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
+	struct dxgsharedresource *shared_resource;
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
+		shared_resource = resource->shared_owner;
+		if (shared_resource) {
+			dxgsharedresource_remove_resource(shared_resource,
+							  resource);
+			resource->shared_owner = NULL;
+		}
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
@@ -522,6 +746,77 @@ void dxgcontext_release(struct kref *refcount)
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
+	dxgprocess_ht_lock_exclusive_down(alloc->process);
+	if (alloc->cpu_address_mapped) {
+		dxg_unmap_iospace(alloc->cpu_address,
+				  alloc->num_pages << PAGE_SHIFT);
+		alloc->cpu_address_mapped = false;
+		alloc->cpu_address = NULL;
+		alloc->cpu_address_refcount = 0;
+	}
+	dxgprocess_ht_lock_exclusive_up(alloc->process);
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
+		dev_dbg(dxgglobaldev, "Teardown gpadl %d",
+			alloc->gpadl.gpadl_handle);
+		vmbus_teardown_gpadl(dxgglobal_get_vmbus(), &alloc->gpadl);
+		dev_dbg(dxgglobaldev, "Teardown gpadl end");
+		alloc->gpadl.gpadl_handle = 0;
+	}
+	if (alloc->priv_drv_data)
+		vfree(alloc->priv_drv_data);
+	if (alloc->cpu_address_mapped)
+		pr_err("Alloc IO space is mapped: %p", alloc);
+	vfree(alloc);
+}
+
 struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 						     struct dxgadapter *adapter)
 {
@@ -655,21 +950,6 @@ void dxgpagingqueue_stop(struct dxgpagingqueue *pqueue)
 	/* Placeholder */
 }
 
-void dxgallocation_destroy(struct dxgallocation *alloc)
-{
-	/* Placeholder */
-}
-
-void dxgallocation_stop(struct dxgallocation *alloc)
-{
-	/* Placeholder */
-}
-
-void dxgresource_destroy(struct dxgresource *resource)
-{
-	/* Placeholder */
-}
-
 void dxgsyncobject_destroy(struct dxgprocess *process,
 			   struct dxgsyncobject *syncobj)
 {
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 13dc34214f50..aba5f1cef431 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -18,6 +18,7 @@
 #include <linux/hyperv.h>
 #include <linux/mman.h>
 #include <linux/delay.h>
+#include <linux/pagemap.h>
 #include "dxgkrnl.h"
 #include "dxgvmbus.h"
 
@@ -107,6 +108,40 @@ static int init_message(struct dxgvmbusmsg *msg, struct dxgadapter *adapter,
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
@@ -409,6 +444,26 @@ dxgvmb_send_sync_msg_ntstatus(struct dxgvmbuschannel *channel,
 	return ret;
 }
 
+int dxg_unmap_iospace(void *va, u32 size)
+{
+	int ret = 0;
+
+	dev_dbg(dxgglobaldev, "%s %p %x", __func__, va, size);
+
+	/*
+	 * When an app calls exit(), dxgkrnl is called to close the device
+	 * with current->mm equal to NULL.
+	 */
+	if (current->mm) {
+		ret = vm_munmap((unsigned long)va, size);
+		if (ret) {
+			pr_err("vm_munmap failed %d", ret);
+			return -ENOTRECOVERABLE;
+		}
+	}
+	return 0;
+}
+
 /*
  * Global messages to the host
  */
@@ -774,6 +829,616 @@ int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
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
+		dev_dbg(dxgglobaldev, "private data offset %d",
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
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
+	dev_dbg(dxgglobaldev, "   Alloc size: %lld", alloc_size);
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
+	dev_dbg(dxgglobaldev, "New gpadl %d", dxgalloc->gpadl.gpadl_handle);
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
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
+		dev_dbg(dxgglobaldev, "host allocation: %d %x",
+			     i, result->allocation_info[i].allocation.v);
+		destroy_buf->allocations[i] =
+		    result->allocation_info[i].allocation;
+	}
+
+	if (args->flags.create_resource) {
+		dev_dbg(dxgglobaldev, "new resource: %x", result->resource.v);
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
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
+	dev_dbg(dxgglobaldev, "command size, driver_data_size %d %d %ld %ld",
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args)
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 590ce9bfa592..79dc22379ec4 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -751,6 +751,735 @@ static int dxgk_destroy_hwcontext(struct dxgprocess *process,
 	return -ENOTTY;
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
+	dev_dbg(dxgglobaldev, "Priv data size: %d", priv_data_size);
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
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
+	struct dxgsharedresource *shared_resource = NULL;
+	bool resource_mutex_acquired = false;
+	u32 standard_alloc_priv_data_size = 0;
+	void *standard_alloc_priv_data = NULL;
+	u32 res_priv_data_size = 0;
+	void *res_priv_data = NULL;
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
+		dev_dbg(dxgglobaldev, "Alloc private data: %d",
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
+		if (args.flags.create_shared) {
+			if (!args.flags.nt_security_sharing) {
+				dev_err(dxgglobaldev,
+					"%s: nt_security_sharing must be set",
+					__func__);
+				ret = -EINVAL;
+				goto cleanup;
+			}
+			shared_resource = dxgsharedresource_create(adapter);
+			if (shared_resource == NULL) {
+				ret = -ENOMEM;
+				goto cleanup;
+			}
+			shared_resource->runtime_private_data_size =
+			    args.priv_drv_data_size;
+			shared_resource->resource_private_data_size =
+			    args.priv_drv_data_size;
+
+			shared_resource->runtime_private_data_size =
+			    args.private_runtime_data_size;
+			shared_resource->resource_private_data_size =
+			    args.priv_drv_data_size;
+			dxgsharedresource_add_resource(shared_resource,
+						       resource);
+			if (args.flags.standard_allocation) {
+				shared_resource->resource_private_data =
+					res_priv_data;
+				shared_resource->resource_private_data_size =
+					res_priv_data_size;
+				res_priv_data = NULL;
+			}
+			if (args.private_runtime_data_size) {
+				shared_resource->runtime_private_data =
+				    vzalloc(args.private_runtime_data_size);
+				if (shared_resource->runtime_private_data ==
+				    NULL) {
+					ret = -ENOMEM;
+					goto cleanup;
+				}
+				ret = copy_from_user(
+					shared_resource->runtime_private_data,
+					args.private_runtime_data,
+					args.private_runtime_data_size);
+				if (ret) {
+					pr_err("%s failed to copy runtime data",
+						__func__);
+					ret = -EINVAL;
+					goto cleanup;
+				}
+			}
+			if (args.priv_drv_data_size &&
+			    !args.flags.standard_allocation) {
+				shared_resource->resource_private_data =
+				    vzalloc(args.priv_drv_data_size);
+				if (shared_resource->resource_private_data ==
+				    NULL) {
+					ret = -ENOMEM;
+					goto cleanup;
+				}
+				ret = copy_from_user(
+					shared_resource->resource_private_data,
+					args.priv_drv_data,
+					args.priv_drv_data_size);
+				if (ret) {
+					pr_err("%s failed to copy res data",
+						__func__);
+					ret = -EINVAL;
+					goto cleanup;
+				}
+			}
+		}
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
+			if (resource->shared_owner &&
+			    resource->shared_owner->sealed) {
+				pr_err("Resource is sealed");
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
+			if (shared_resource) {
+				dxgsharedresource_remove_resource
+				    (shared_resource, resource);
+			}
+			dxgresource_destroy(resource);
+		}
+	}
+	if (shared_resource)
+		kref_put(&shared_resource->sresource_kref,
+			 dxgsharedresource_destroy);
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
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+int validate_alloc(struct dxgallocation *alloc0,
+			       struct dxgallocation *alloc,
+			       struct dxgdevice *device,
+			       struct d3dkmthandle alloc_handle)
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
+		if (alloc->owner.resource->shared_owner) {
+			fail_reason = 5;
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
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
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
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_render(struct dxgprocess *process, void *__user inargs)
+{
+	pr_err("%s is not implemented", __func__);
+	return -ENOTTY;
+}
+
 static int
 dxgk_create_context(struct dxgprocess *process, void *__user inargs)
 {
@@ -758,6 +1487,14 @@ dxgk_create_context(struct dxgprocess *process, void *__user inargs)
 	return -ENOTTY;
 }
 
+static int
+dxgk_get_shared_resource_adapter_luid(struct dxgprocess *process,
+				      void *__user inargs)
+{
+	pr_err("shared_resource_adapter_luid is not implemented");
+	return -ENOTTY;
+}
+
 /*
  * IOCTL processing
  * The driver IOCTLs return
@@ -824,8 +1561,12 @@ void init_ioctls(void)
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
@@ -836,6 +1577,10 @@ void init_ioctls(void)
 		  LX_DXDESTROYDEVICE);
 	SET_IOCTL(/*0x1a */ dxgk_destroy_hwcontext,
 		  LX_DXDESTROYHWCONTEXT);
+	SET_IOCTL(/*0x23 */ dxgk_get_shared_resource_adapter_luid,
+		  LX_DXGETSHAREDRESOURCEADAPTERLUID);
+	SET_IOCTL(/*0x2d */ dxgk_render,
+		  LX_DXRENDER);
 	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
 		  LX_DXENUMADAPTERS3);
 }
-- 
2.32.0

