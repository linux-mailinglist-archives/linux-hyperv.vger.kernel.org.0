Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231764AA5DC
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378991AbiBECea (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:30 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45114 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379007AbiBECeZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:25 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id E24BF20B83F2;
        Fri,  4 Feb 2022 18:34:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E24BF20B83F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028465;
        bh=tz+qTzrumeIyc+TN4zKInmKvJDSXllu3mN/sBcNbrMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9udJGl+CCwYqvHsc54yVl7fX1Ki6F9/Fdo9issG2PUMvu6n0AsoKg4Upjq/rBOAV
         A4A27RuAOcKJh7ogxDJpoGcmY1abx/RqlP8iPk8Z2T31kNdXP17uC8hQuiKpQ/WpWG
         TUkDKgpIixSRpOjHZNJI9sCJu9US1w85cEfBB9JI=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 09/24] drivers: hv: dxgkrnl: Sharing of dxgresource objects
Date:   Fri,  4 Feb 2022 18:34:07 -0800
Message-Id: <1c02879d1a3bdf8d5c8b568d722366a26a283128.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement creation of shared resource and IOCTLs for sharing
dxgresource objects between processes in the virtual machine.

A dxgresource object is a collection of dxgallocation objects.
The WDDM API allows addition/removal allocations to a resource, but
has limitations on addition/removal of allocations to a shared
resource. When a resource is "sealed", addition/removal of allocations
is not allowed.

Resources are shared using FD (file descriptor) handles. The name
"NT handle" is used to be compatible with Windows implementation.

An FD handle is created by the LX_DXSHAREOBJECTS ioctl. The given FD
handle could be sent to another process using any Linux API.

To use a shared resource object in WDDM API calls, the object needs to be
opened using its FD handle. An resource object is opened by the following
ioctl: LX_DXOPENRESOURCEFROMNTHANDLE.

The LX_DXQUERYRESOURCEINFOFROMNTHANDLE ioctl is used to query private
driver data of a shared resource object. This private data needs to be
used to actually open the object using LX_DXOPENRESOURCEFROMNTHANDLE.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  81 ++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  77 ++++
 drivers/hv/dxgkrnl/dxgmodule.c  |   1 +
 drivers/hv/dxgkrnl/dxgvmbus.c   | 127 ++++++
 drivers/hv/dxgkrnl/ioctl.c      | 786 ++++++++++++++++++++++++++++++++
 5 files changed, 1072 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index f9aa92d17d52..1b8f2b63eb6d 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -165,6 +165,17 @@ void dxgadapter_remove_process(struct dxgprocess_adapter *process_info)
 	process_info->adapter_process_list_entry.prev = NULL;
 }
 
+void dxgadapter_remove_shared_resource(struct dxgadapter *adapter,
+				       struct dxgsharedresource *object)
+{
+	down_write(&adapter->shared_resource_list_lock);
+	if (object->shared_resource_list_entry.next) {
+		list_del(&object->shared_resource_list_entry);
+		object->shared_resource_list_entry.next = NULL;
+	}
+	up_write(&adapter->shared_resource_list_lock);
+}
+
 void dxgadapter_add_syncobj(struct dxgadapter *adapter,
 			    struct dxgsyncobject *object)
 {
@@ -492,6 +503,69 @@ void dxgdevice_remove_resource(struct dxgdevice *device,
 	}
 }
 
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
+	pr_debug("%s: %p %p", __func__, shared_resource, resource);
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
+	pr_debug("%s: %p %p", __func__, shared_resource, resource);
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
 struct dxgresource *dxgresource_create(struct dxgdevice *device)
 {
 	struct dxgresource *resource = vzalloc(sizeof(struct dxgresource));
@@ -534,6 +608,7 @@ void dxgresource_destroy(struct dxgresource *resource)
 	struct d3dkmt_destroyallocation2 args = { };
 	int destroyed = test_and_set_bit(0, &resource->flags);
 	struct dxgdevice *device = resource->device;
+	struct dxgsharedresource *shared_resource;
 
 	if (!destroyed) {
 		dxgresource_free_handle(resource);
@@ -549,6 +624,12 @@ void dxgresource_destroy(struct dxgresource *resource)
 			dxgallocation_destroy(alloc);
 		}
 		dxgdevice_remove_resource(device, resource);
+		shared_resource = resource->shared_owner;
+		if (shared_resource) {
+			dxgsharedresource_remove_resource(shared_resource,
+							  resource);
+			resource->shared_owner = NULL;
+		}
 	}
 	kref_put(&resource->resource_kref, dxgresource_release);
 }
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index ce403cc58151..f3ea98f0b384 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -33,6 +33,7 @@ struct dxgdevice;
 struct dxgcontext;
 struct dxgallocation;
 struct dxgresource;
+struct dxgsharedresource;
 struct dxgsyncobject;
 
 #include "misc.h"
@@ -355,6 +356,8 @@ struct dxgadapter {
 	struct list_head	adapter_list_entry;
 	/* The list of dxgprocess_adapter entries */
 	struct list_head	adapter_process_list_head;
+	/* List of all dxgsharedresource objects */
+	struct list_head	shared_resource_list_head;
 	/* List of all non-device dxgsyncobject objects */
 	struct list_head	syncobj_list_head;
 	/* This lock protects shared resource and syncobject lists */
@@ -388,6 +391,8 @@ void dxgadapter_remove_syncobj(struct dxgsyncobject *so);
 void dxgadapter_add_process(struct dxgadapter *adapter,
 			    struct dxgprocess_adapter *process_info);
 void dxgadapter_remove_process(struct dxgprocess_adapter *process_info);
+void dxgadapter_remove_shared_resource(struct dxgadapter *adapter,
+				       struct dxgsharedresource *object);
 
 /*
  * The object represent the device object.
@@ -467,6 +472,64 @@ void dxgcontext_destroy_safe(struct dxgprocess *pr, struct dxgcontext *ctx);
 void dxgcontext_release(struct kref *refcount);
 bool dxgcontext_is_active(struct dxgcontext *ctx);
 
+/*
+ * A shared resource object is created to track the list of dxgresource objects,
+ * which are opened for the same underlying shared resource.
+ * Objects are shared by using a file descriptor handle.
+ * FD is created by calling dxgk_share_objects and providing shandle to
+ * dxgsharedresource. The FD points to a dxgresource object, which is created
+ * by calling dxgk_open_resource_nt.  dxgresource object is referenced by the
+ * FD.
+ *
+ * The object is referenced by every dxgresource in its list.
+ *
+ */
+struct dxgsharedresource {
+	/* Every dxgresource object in the resource list takes a reference */
+	struct kref		sresource_kref;
+	struct dxgadapter	*adapter;
+	/* List of dxgresource objects, opened for the shared resource. */
+	/* Protected by dxgadapter::shared_resource_list_lock */
+	struct list_head	resource_list_head;
+	/* Entry in the list of dxgsharedresource in dxgadapter */
+	/* Protected by dxgadapter::shared_resource_list_lock */
+	struct list_head	shared_resource_list_entry;
+	struct mutex		fd_mutex;
+	/* Referenced by file descriptors */
+	int			host_shared_handle_nt_reference;
+	/* Corresponding global handle in the host */
+	struct d3dkmthandle	host_shared_handle;
+	/*
+	 * When the sync object is shared by NT handle, this is the
+	 * corresponding handle in the host
+	 */
+	struct d3dkmthandle	host_shared_handle_nt;
+	/* Values below are computed when the resource is sealed */
+	u32			runtime_private_data_size;
+	u32			alloc_private_data_size;
+	u32			resource_private_data_size;
+	u32			allocation_count;
+	union {
+		struct {
+			/* Cannot add new allocations */
+			u32	sealed:1;
+			u32	reserved:31;
+		};
+		long		flags;
+	};
+	u32			*alloc_private_data_sizes;
+	u8			*alloc_private_data;
+	u8			*runtime_private_data;
+	u8			*resource_private_data;
+};
+
+struct dxgsharedresource *dxgsharedresource_create(struct dxgadapter *adapter);
+void dxgsharedresource_destroy(struct kref *refcount);
+void dxgsharedresource_add_resource(struct dxgsharedresource *sres,
+				    struct dxgresource *res);
+void dxgsharedresource_remove_resource(struct dxgsharedresource *sres,
+				       struct dxgresource *res);
+
 struct dxgresource {
 	struct kref		resource_kref;
 	enum dxgobjectstate	object_state;
@@ -487,6 +550,8 @@ struct dxgresource {
 		};
 		long		flags;
 	};
+	/* Owner of the shared resource */
+	struct dxgsharedresource *shared_owner;
 };
 
 struct dxgresource *dxgresource_create(struct dxgdevice *dev);
@@ -632,6 +697,18 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
+int dxgvmb_send_create_nt_shared_object(struct dxgprocess *process,
+					struct d3dkmthandle object,
+					struct d3dkmthandle *shared_handle);
+int dxgvmb_send_destroy_nt_shared_object(struct d3dkmthandle shared_handle);
+int dxgvmb_send_open_resource(struct dxgprocess *process,
+			      struct dxgadapter *adapter,
+			      struct d3dkmthandle device,
+			      struct d3dkmthandle global_share,
+			      u32 allocation_count,
+			      u32 total_priv_drv_data_size,
+			      struct d3dkmthandle *resource_handle,
+			      struct d3dkmthandle *alloc_handles);
 int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 				  enum d3dkmdt_standardallocationtype t,
 				  struct d3dkmdt_gdisurfacedata *data,
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 1815df8e45fe..3af5a7a3ac74 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -250,6 +250,7 @@ int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
 	init_rwsem(&adapter->core_lock);
 
 	INIT_LIST_HEAD(&adapter->adapter_process_list_head);
+	INIT_LIST_HEAD(&adapter->shared_resource_list_head);
 	INIT_LIST_HEAD(&adapter->syncobj_list_head);
 	init_rwsem(&adapter->shared_resource_list_lock);
 	adapter->pci_dev = dev;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 6d81069e4a9a..af8d1aab871f 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -694,6 +694,79 @@ int dxgvmb_send_destroy_process(struct d3dkmthandle process)
 	return ret;
 }
 
+int dxgvmb_send_create_nt_shared_object(struct dxgprocess *process,
+					struct d3dkmthandle object,
+					struct d3dkmthandle *shared_handle)
+{
+	struct dxgkvmb_command_createntsharedobject *command;
+	int ret;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, process, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vm_to_host_init2(&command->hdr,
+				 DXGK_VMBCOMMAND_CREATENTSHAREDOBJECT,
+				 process->host_handle);
+	command->object = object;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_sync_msg(dxgglobal_get_dxgvmbuschannel(),
+				   msg.hdr, msg.size, shared_handle,
+				   sizeof(*shared_handle));
+
+	dxgglobal_release_channel_lock();
+
+	if (ret < 0)
+		goto cleanup;
+	if (shared_handle->v == 0) {
+		pr_err("failed to create NT shared object");
+		ret = -ENOTRECOVERABLE;
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_destroy_nt_shared_object(struct d3dkmthandle shared_handle)
+{
+	struct dxgkvmb_command_destroyntsharedobject *command;
+	int ret;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vm_to_host_init1(&command->hdr,
+				 DXGK_VMBCOMMAND_DESTROYNTSHAREDOBJECT);
+	command->shared_handle = shared_handle;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(dxgglobal_get_dxgvmbuschannel(),
+					    msg.hdr, msg.size);
+
+	dxgglobal_release_channel_lock();
+
+cleanup:
+	free_message(&msg, NULL);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_destroy_sync_object(struct dxgprocess *process,
 				    struct d3dkmthandle sync_object)
 {
@@ -1499,6 +1572,60 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_open_resource(struct dxgprocess *process,
+			      struct dxgadapter *adapter,
+			      struct d3dkmthandle device,
+			      struct d3dkmthandle global_share,
+			      u32 allocation_count,
+			      u32 total_priv_drv_data_size,
+			      struct d3dkmthandle *resource_handle,
+			      struct d3dkmthandle *alloc_handles)
+{
+	struct dxgkvmb_command_openresource *command;
+	struct dxgkvmb_command_openresource_return *result;
+	struct d3dkmthandle *handles;
+	int ret;
+	int i;
+	u32 result_size = allocation_count * sizeof(struct d3dkmthandle) +
+			   sizeof(*result);
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	ret = init_message_res(&msg, adapter, process, sizeof(*command),
+			       result_size);
+	if (ret)
+		goto cleanup;
+	command = msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_OPENRESOURCE,
+				   process->host_handle);
+	command->device = device;
+	command->nt_security_sharing = 1;
+	command->global_share = global_share;
+	command->allocation_count = allocation_count;
+	command->total_priv_drv_data_size = total_priv_drv_data_size;
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
+	*resource_handle = result->resource;
+	handles = (struct d3dkmthandle *) &result[1];
+	for (i = 0; i < allocation_count; i++)
+		alloc_handles[i] = handles[i];
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 				  enum d3dkmdt_standardallocationtype alloctype,
 				  struct d3dkmdt_gdisurfacedata *alloc_data,
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index b945da0da55a..05f59854cbbf 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -35,6 +35,33 @@ static char *errorstr(int ret)
 	return ret < 0 ? "err" : "";
 }
 
+static int dxgsharedresource_release(struct inode *inode, struct file *file)
+{
+	struct dxgsharedresource *resource = file->private_data;
+
+	pr_debug("%s: %p", __func__, resource);
+	mutex_lock(&resource->fd_mutex);
+	kref_get(&resource->sresource_kref);
+	resource->host_shared_handle_nt_reference--;
+	if (resource->host_shared_handle_nt_reference == 0) {
+		if (resource->host_shared_handle_nt.v) {
+			dxgvmb_send_destroy_nt_shared_object(
+					resource->host_shared_handle_nt);
+			pr_debug("Resource host_handle_nt destroyed: %x",
+				resource->host_shared_handle_nt.v);
+			resource->host_shared_handle_nt.v = 0;
+		}
+		kref_put(&resource->sresource_kref, dxgsharedresource_destroy);
+	}
+	mutex_unlock(&resource->fd_mutex);
+	kref_put(&resource->sresource_kref, dxgsharedresource_destroy);
+	return 0;
+}
+
+static const struct file_operations dxg_resource_fops = {
+	.release = dxgsharedresource_release,
+};
+
 static int dxgk_open_adapter_from_luid(struct dxgprocess *process,
 						   void *__user inargs)
 {
@@ -217,6 +244,97 @@ dxgkp_enum_adapters(struct dxgprocess *process,
 	return ret;
 }
 
+static int dxgsharedresource_seal(struct dxgsharedresource *shared_resource)
+{
+	int ret = 0;
+	int i = 0;
+	u8 *private_data;
+	u32 data_size;
+	struct dxgresource *resource;
+	struct dxgallocation *alloc;
+
+	pr_debug("Sealing resource: %p", shared_resource);
+
+	down_write(&shared_resource->adapter->shared_resource_list_lock);
+	if (shared_resource->sealed) {
+		pr_debug("Resource already sealed");
+		goto cleanup;
+	}
+	shared_resource->sealed = 1;
+	if (!list_empty(&shared_resource->resource_list_head)) {
+		resource =
+		    list_first_entry(&shared_resource->resource_list_head,
+				     struct dxgresource,
+				     shared_resource_list_entry);
+		pr_debug("First resource: %p", resource);
+		mutex_lock(&resource->resource_mutex);
+		list_for_each_entry(alloc, &resource->alloc_list_head,
+				    alloc_list_entry) {
+			pr_debug("Resource alloc: %p %d", alloc,
+				    alloc->priv_drv_data->data_size);
+			shared_resource->allocation_count++;
+			shared_resource->alloc_private_data_size +=
+			    alloc->priv_drv_data->data_size;
+			if (shared_resource->alloc_private_data_size <
+			    alloc->priv_drv_data->data_size) {
+				pr_err("alloc private data overflow");
+				ret = -EINVAL;
+				goto cleanup1;
+			}
+		}
+		if (shared_resource->alloc_private_data_size == 0) {
+			ret = -EINVAL;
+			goto cleanup1;
+		}
+		shared_resource->alloc_private_data =
+			vzalloc(shared_resource->alloc_private_data_size);
+		if (shared_resource->alloc_private_data == NULL) {
+			ret = -EINVAL;
+			goto cleanup1;
+		}
+		shared_resource->alloc_private_data_sizes =
+			vzalloc(sizeof(u32)*shared_resource->allocation_count);
+		if (shared_resource->alloc_private_data_sizes == NULL) {
+			ret = -EINVAL;
+			goto cleanup1;
+		}
+		private_data = shared_resource->alloc_private_data;
+		data_size = shared_resource->alloc_private_data_size;
+		i = 0;
+		list_for_each_entry(alloc, &resource->alloc_list_head,
+				    alloc_list_entry) {
+			u32 alloc_data_size = alloc->priv_drv_data->data_size;
+
+			if (alloc_data_size) {
+				if (data_size < alloc_data_size) {
+					pr_err("Invalid private data size");
+					ret = -EINVAL;
+					goto cleanup1;
+				}
+				shared_resource->alloc_private_data_sizes[i] =
+				    alloc_data_size;
+				memcpy(private_data,
+				       alloc->priv_drv_data->data,
+				       alloc_data_size);
+				vfree(alloc->priv_drv_data);
+				alloc->priv_drv_data = NULL;
+				private_data += alloc_data_size;
+				data_size -= alloc_data_size;
+			}
+			i++;
+		}
+		if (data_size != 0) {
+			pr_err("Data size mismatch");
+			ret = -EINVAL;
+		}
+cleanup1:
+		mutex_unlock(&resource->resource_mutex);
+	}
+cleanup:
+	up_write(&shared_resource->adapter->shared_resource_list_lock);
+	return ret;
+}
+
 static int
 dxgk_enum_adapters(struct dxgprocess *process, void *__user inargs)
 {
@@ -823,6 +941,7 @@ dxgk_create_allocation(struct dxgprocess *process, void *__user inargs)
 	u32 alloc_info_size = 0;
 	struct dxgresource *resource = NULL;
 	struct dxgallocation **dxgalloc = NULL;
+	struct dxgsharedresource *shared_resource = NULL;
 	bool resource_mutex_acquired = false;
 	u32 standard_alloc_priv_data_size = 0;
 	void *standard_alloc_priv_data = NULL;
@@ -995,6 +1114,76 @@ dxgk_create_allocation(struct dxgprocess *process, void *__user inargs)
 		}
 		resource->private_runtime_handle =
 		    args.private_runtime_resource_handle;
+		if (args.flags.create_shared) {
+			if (!args.flags.nt_security_sharing) {
+				pr_err("%s: nt_security_sharing must be set",
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
 	} else {
 		if (args.resource.v) {
 			/* Adding new allocations to the given resource */
@@ -1013,6 +1202,12 @@ dxgk_create_allocation(struct dxgprocess *process, void *__user inargs)
 				ret = -EINVAL;
 				goto cleanup;
 			}
+			if (resource->shared_owner &&
+			    resource->shared_owner->sealed) {
+				pr_err("Resource is sealed");
+				ret = -EINVAL;
+				goto cleanup;
+			}
 			/* Synchronize with resource destruction */
 			mutex_lock(&resource->resource_mutex);
 			if (!dxgresource_is_active(resource)) {
@@ -1117,9 +1312,16 @@ dxgk_create_allocation(struct dxgprocess *process, void *__user inargs)
 			}
 		}
 		if (resource && args.flags.create_resource) {
+			if (shared_resource) {
+				dxgsharedresource_remove_resource
+				    (shared_resource, resource);
+			}
 			dxgresource_destroy(resource);
 		}
 	}
+	if (shared_resource)
+		kref_put(&shared_resource->sresource_kref,
+			 dxgsharedresource_destroy);
 	if (dxgalloc)
 		vfree(dxgalloc);
 	if (standard_alloc_priv_data)
@@ -1165,6 +1367,10 @@ static int validate_alloc(struct dxgallocation *alloc0,
 			fail_reason = 4;
 			goto cleanup;
 		}
+		if (alloc->owner.resource->shared_owner) {
+			fail_reason = 5;
+			goto cleanup;
+		}
 	} else {
 		if (alloc->owner.device != device) {
 			fail_reason = 6;
@@ -2173,6 +2379,580 @@ dxgk_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgsharedresource_get_host_nt_handle(struct dxgsharedresource *resource,
+				     struct dxgprocess *process,
+				     struct d3dkmthandle objecthandle)
+{
+	int ret = 0;
+
+	mutex_lock(&resource->fd_mutex);
+	if (resource->host_shared_handle_nt_reference == 0) {
+		ret = dxgvmb_send_create_nt_shared_object(process,
+					objecthandle,
+					&resource->host_shared_handle_nt);
+		if (ret < 0)
+			goto cleanup;
+		pr_debug("Resource host_shared_handle_ht: %x",
+			    resource->host_shared_handle_nt.v);
+		kref_get(&resource->sresource_kref);
+	}
+	resource->host_shared_handle_nt_reference++;
+cleanup:
+	mutex_unlock(&resource->fd_mutex);
+	return ret;
+}
+
+enum dxg_sharedobject_type {
+	DXG_SHARED_RESOURCE
+};
+
+static int get_object_fd(enum dxg_sharedobject_type type,
+				     void *object, int *fdout)
+{
+	struct file *file;
+	int fd;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		pr_err("get_unused_fd_flags failed: %x", fd);
+		return -ENOTRECOVERABLE;
+	}
+
+	switch (type) {
+	case DXG_SHARED_RESOURCE:
+		file = anon_inode_getfile("dxgresource",
+					  &dxg_resource_fops, object, 0);
+		break;
+	default:
+		return -EINVAL;
+	};
+	if (IS_ERR(file)) {
+		pr_err("anon_inode_getfile failed: %x", fd);
+		put_unused_fd(fd);
+		return -ENOTRECOVERABLE;
+	}
+
+	fd_install(fd, file);
+	*fdout = fd;
+	return 0;
+}
+
+static int
+dxgk_share_objects(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_shareobjects args;
+	enum hmgrentry_type object_type;
+	struct dxgsyncobject *syncobj = NULL;
+	struct dxgresource *resource = NULL;
+	struct dxgsharedresource *shared_resource = NULL;
+	struct d3dkmthandle *handles = NULL;
+	int object_fd = 0;
+	void *obj = NULL;
+	u32 handle_size;
+	int ret;
+	u64 tmp = 0;
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
+	if (args.object_count == 0 || args.object_count > 1) {
+		pr_err("invalid object count %d", args.object_count);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	handle_size = args.object_count * sizeof(struct d3dkmthandle);
+
+	handles = vzalloc(handle_size);
+	if (handles == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	ret = copy_from_user(handles, args.objects, handle_size);
+	if (ret) {
+		pr_err("%s failed to copy object handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	pr_debug("Sharing handle: %x", handles[0].v);
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
+	object_type = hmgrtable_get_object_type(&process->handle_table,
+						handles[0]);
+	obj = hmgrtable_get_object(&process->handle_table, handles[0]);
+	if (obj == NULL) {
+		pr_err("invalid object handle %x", handles[0].v);
+		ret = -EINVAL;
+	} else {
+		switch (object_type) {
+		case HMGRENTRY_TYPE_DXGRESOURCE:
+			resource = obj;
+			if (resource->shared_owner) {
+				kref_get(&resource->resource_kref);
+				shared_resource = resource->shared_owner;
+			} else {
+				resource = NULL;
+				pr_err("resource object is not shared");
+				ret = -EINVAL;
+			}
+			break;
+		default:
+			pr_err("invalid object type %d", object_type);
+			ret = -EINVAL;
+			break;
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_SHARED);
+
+	if (ret < 0)
+		goto cleanup;
+
+	switch (object_type) {
+	case HMGRENTRY_TYPE_DXGRESOURCE:
+		ret = get_object_fd(DXG_SHARED_RESOURCE, shared_resource,
+				    &object_fd);
+		if (ret < 0) {
+			pr_err("%s get_object_fd failed for resource",
+				__func__);
+			goto cleanup;
+		}
+		ret = dxgsharedresource_get_host_nt_handle(shared_resource,
+							   process, handles[0]);
+		if (ret < 0) {
+			pr_err("%s get_host_res_nt_handle failed", __func__);
+			goto cleanup;
+		}
+		ret = dxgsharedresource_seal(shared_resource);
+		if (ret < 0) {
+			pr_err("%s dxgsharedresource_seal failed", __func__);
+			goto cleanup;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret < 0)
+		goto cleanup;
+
+	pr_debug("Object FD: %x", object_fd);
+
+	tmp = (u64) object_fd;
+
+	ret = copy_to_user(args.shared_handle, &tmp, sizeof(u64));
+	if (ret < 0)
+		pr_err("%s failed to copy shared handle", __func__);
+
+cleanup:
+	if (ret < 0) {
+		if (object_fd > 0)
+			put_unused_fd(object_fd);
+	}
+
+	if (handles)
+		vfree(handles);
+
+	if (syncobj)
+		kref_put(&syncobj->syncobj_kref, dxgsyncobject_release);
+
+	if (resource)
+		kref_put(&resource->resource_kref, dxgresource_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_query_resource_info_nt(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryresourceinfofromnthandle args;
+	int ret;
+	struct dxgdevice *device = NULL;
+	struct dxgsharedresource *shared_resource = NULL;
+	struct file *file = NULL;
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
+	file = fget(args.nt_handle);
+	if (!file) {
+		pr_err("failed to get file from handle: %llx",
+			   args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (file->f_op != &dxg_resource_fops) {
+		pr_err("invalid fd: %llx", args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	shared_resource = file->private_data;
+	if (shared_resource == NULL) {
+		pr_err("invalid private data: %llx", args.nt_handle);
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
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0) {
+		kref_put(&device->device_kref, dxgdevice_release);
+		device = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgsharedresource_seal(shared_resource);
+	if (ret < 0)
+		goto cleanup;
+
+	args.private_runtime_data_size =
+	    shared_resource->runtime_private_data_size;
+	args.resource_priv_drv_data_size =
+	    shared_resource->resource_private_data_size;
+	args.allocation_count = shared_resource->allocation_count;
+	args.total_priv_drv_data_size =
+	    shared_resource->alloc_private_data_size;
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret < 0)
+		pr_err("%s failed to copy output args", __func__);
+
+cleanup:
+
+	if (file)
+		fput(file);
+	if (device)
+		dxgdevice_release_lock_shared(device);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+assign_resource_handles(struct dxgprocess *process,
+			struct dxgsharedresource *shared_resource,
+			struct d3dkmt_openresourcefromnthandle *args,
+			struct d3dkmthandle resource_handle,
+			struct dxgresource *resource,
+			struct dxgallocation **allocs,
+			struct d3dkmthandle *handles)
+{
+	int ret;
+	int i;
+	u8 *cur_priv_data;
+	u32 total_priv_data_size = 0;
+	struct d3dddi_openallocationinfo2 open_alloc_info = { };
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	ret = hmgrtable_assign_handle(&process->handle_table, resource,
+				      HMGRENTRY_TYPE_DXGRESOURCE,
+				      resource_handle);
+	if (ret < 0)
+		goto cleanup;
+	resource->handle = resource_handle;
+	resource->handle_valid = 1;
+	cur_priv_data = args->total_priv_drv_data;
+	for (i = 0; i < args->allocation_count; i++) {
+		ret = hmgrtable_assign_handle(&process->handle_table, allocs[i],
+					      HMGRENTRY_TYPE_DXGALLOCATION,
+					      handles[i]);
+		if (ret < 0)
+			goto cleanup;
+		allocs[i]->alloc_handle = handles[i];
+		allocs[i]->handle_valid = 1;
+		open_alloc_info.allocation = handles[i];
+		if (shared_resource->alloc_private_data_sizes)
+			open_alloc_info.priv_drv_data_size =
+			    shared_resource->alloc_private_data_sizes[i];
+		else
+			open_alloc_info.priv_drv_data_size = 0;
+
+		total_priv_data_size += open_alloc_info.priv_drv_data_size;
+		open_alloc_info.priv_drv_data = cur_priv_data;
+		cur_priv_data += open_alloc_info.priv_drv_data_size;
+
+		ret = copy_to_user(&args->open_alloc_info[i],
+				   &open_alloc_info,
+				   sizeof(open_alloc_info));
+		if (ret < 0) {
+			pr_err("%s failed to copy alloc info", __func__);
+			goto cleanup;
+		}
+	}
+	args->total_priv_drv_data_size = total_priv_data_size;
+cleanup:
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	if (ret < 0) {
+		for (i = 0; i < args->allocation_count; i++)
+			dxgallocation_free_handle(allocs[i]);
+		dxgresource_free_handle(resource);
+	}
+	pr_debug("%s end %x", __func__, ret);
+	return ret;
+}
+
+static int
+open_resource(struct dxgprocess *process,
+	      struct d3dkmt_openresourcefromnthandle *args,
+	      __user struct d3dkmthandle *res_out,
+	      __user u32 *total_driver_data_size_out)
+{
+	int ret = 0;
+	int i;
+	struct d3dkmthandle *alloc_handles = NULL;
+	int alloc_handles_size = sizeof(struct d3dkmthandle) *
+				 args->allocation_count;
+	struct dxgsharedresource *shared_resource = NULL;
+	struct dxgresource *resource = NULL;
+	struct dxgallocation **allocs = NULL;
+	struct d3dkmthandle global_share = {};
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmthandle resource_handle = {};
+	struct file *file = NULL;
+
+	pr_debug("Opening resource handle: %llx", args->nt_handle);
+
+	file = fget(args->nt_handle);
+	if (!file) {
+		pr_err("failed to get file from handle: %llx",
+				args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (file->f_op != &dxg_resource_fops) {
+		pr_err("invalid fd type: %llx", args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	shared_resource = file->private_data;
+	if (shared_resource == NULL) {
+		pr_err("invalid private data: %llx",
+				args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (kref_get_unless_zero(&shared_resource->sresource_kref) == 0)
+		shared_resource = NULL;
+	else
+		global_share = shared_resource->host_shared_handle_nt;
+
+	if (shared_resource == NULL) {
+		pr_err("Invalid shared resource handle: %x",
+			   (u32)args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	pr_debug("Shared resource: %p %x", shared_resource,
+		    global_share.v);
+
+	device = dxgprocess_device_by_handle(process, args->device);
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
+	ret = dxgsharedresource_seal(shared_resource);
+	if (ret < 0)
+		goto cleanup;
+
+	if (args->allocation_count != shared_resource->allocation_count ||
+	    args->private_runtime_data_size <
+	    shared_resource->runtime_private_data_size ||
+	    args->resource_priv_drv_data_size <
+	    shared_resource->resource_private_data_size ||
+	    args->total_priv_drv_data_size <
+	    shared_resource->alloc_private_data_size) {
+		ret = -EINVAL;
+		pr_err("Invalid data sizes");
+		goto cleanup;
+	}
+
+	alloc_handles = vzalloc(alloc_handles_size);
+	if (alloc_handles == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	allocs = vzalloc(sizeof(void *) * args->allocation_count);
+	if (allocs == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	resource = dxgresource_create(device);
+	if (resource == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	dxgsharedresource_add_resource(shared_resource, resource);
+
+	for (i = 0; i < args->allocation_count; i++) {
+		allocs[i] = dxgallocation_create(process);
+		if (allocs[i] == NULL)
+			goto cleanup;
+		ret = dxgresource_add_alloc(resource, allocs[i]);
+		if (ret < 0)
+			goto cleanup;
+	}
+
+	ret = dxgvmb_send_open_resource(process, adapter,
+					device->handle, global_share,
+					args->allocation_count,
+					args->total_priv_drv_data_size,
+					&resource_handle, alloc_handles);
+	if (ret < 0) {
+		pr_err("dxgvmb_send_open_resource failed");
+		goto cleanup;
+	}
+
+	if (shared_resource->runtime_private_data_size) {
+		ret = copy_to_user(args->private_runtime_data,
+				shared_resource->runtime_private_data,
+				shared_resource->runtime_private_data_size);
+		if (ret < 0) {
+			pr_err("%s failed to copy runtime data", __func__);
+			goto cleanup;
+		}
+	}
+
+	if (shared_resource->resource_private_data_size) {
+		ret = copy_to_user(args->resource_priv_drv_data,
+				shared_resource->resource_private_data,
+				shared_resource->resource_private_data_size);
+		if (ret < 0) {
+			pr_err("%s failed to copy resource data", __func__);
+			goto cleanup;
+		}
+	}
+
+	if (shared_resource->alloc_private_data_size) {
+		ret = copy_to_user(args->total_priv_drv_data,
+				shared_resource->alloc_private_data,
+				shared_resource->alloc_private_data_size);
+		if (ret < 0) {
+			pr_err("%s failed to copy alloc data", __func__);
+			goto cleanup;
+		}
+	}
+
+	ret = assign_resource_handles(process, shared_resource, args,
+				      resource_handle, resource, allocs,
+				      alloc_handles);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(res_out, &resource_handle,
+			   sizeof(struct d3dkmthandle));
+	if (ret < 0) {
+		pr_err("%s failed to copy resource handle to user", __func__);
+		goto cleanup;
+	}
+
+	ret = copy_to_user(total_driver_data_size_out,
+			   &args->total_priv_drv_data_size, sizeof(u32));
+	if (ret < 0)
+		pr_err("%s failed to copy total driver data size", __func__);
+
+cleanup:
+
+	if (ret < 0) {
+		if (resource_handle.v) {
+			struct d3dkmt_destroyallocation2 tmp = { };
+
+			tmp.flags.assume_not_in_use = 1;
+			tmp.device = args->device;
+			tmp.resource = resource_handle;
+			ret = dxgvmb_send_destroy_allocation(process, device,
+							     &tmp, NULL);
+		}
+		if (resource)
+			dxgresource_destroy(resource);
+	}
+
+	if (file)
+		fput(file);
+	if (allocs)
+		vfree(allocs);
+	if (shared_resource)
+		kref_put(&shared_resource->sresource_kref,
+			 dxgsharedresource_destroy);
+	if (alloc_handles)
+		vfree(alloc_handles);
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		dxgdevice_release_lock_shared(device);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	return ret;
+}
+
+static int
+dxgk_open_resource_nt(struct dxgprocess *process,
+				      void *__user inargs)
+{
+	struct d3dkmt_openresourcefromnthandle args;
+	struct d3dkmt_openresourcefromnthandle *__user args_user = inargs;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = open_resource(process, &args,
+			    &args_user->resource,
+			    &args_user->total_priv_drv_data_size);
+
+cleanup:
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 /*
  * IOCTL processing
  * The driver IOCTLs return
@@ -2269,4 +3049,10 @@ void init_ioctls(void)
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU);
 	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
 		  LX_DXENUMADAPTERS3);
+	SET_IOCTL(/*0x3f */ dxgk_share_objects,
+		  LX_DXSHAREOBJECTS);
+	SET_IOCTL(/*0x41 */ dxgk_query_resource_info_nt,
+		  LX_DXQUERYRESOURCEINFOFROMNTHANDLE);
+	SET_IOCTL(/*0x42 */ dxgk_open_resource_nt,
+		  LX_DXOPENRESOURCEFROMNTHANDLE);
 }
-- 
2.35.1

