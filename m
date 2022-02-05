Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE654AA5CF
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379036AbiBECe2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:28 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45090 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379004AbiBECeY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:24 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 837C820B8029;
        Fri,  4 Feb 2022 18:34:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 837C820B8029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028464;
        bh=EIrjHbheOQ0PQHv7kwOqUhp+IROFKpCdIzkkDL6D0nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIqVipIU0LZup4AwJCLTkIYcQCVcheM+mABNabtLdrejt5RACDzFEVoew8IBno7wY
         /AhCEtVMALDsA4oljosQHaiTD2e03euwUlM1XRZKMD3dTIr3pstGjbSWshyBNgNzU6
         MRcogaLvclmNJD2GDu2QK78g/ROZVpVXizdZJyJw=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 07/24] drivers: hv: dxgkrnl: Create and destroy GPU sync objects
Date:   Fri,  4 Feb 2022 18:34:05 -0800
Message-Id: <f9ced6438ddb3aa0438f12fd25a331796834395b.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

GPU synchronization objects are used to synchornize GPU command
execution between different execution contexts.

Implement ioctls to create and destroy sync objects:
LX_DXCREATESYNCHRONIZATIONOBJECT(D3DKMTCreateSynchronizationObject),
LX_DXDESTROYSYNCHRONIZATIONOBJECT(D3DKMTDestroySynchronizationObject)

Monitored fence sync objects have a CPU virtual address to allow
an application to read the fence value. dxg_map_iospace and
dxg_unmap_iospace implement creation of the CPU virtual address.
This is done as follow:
- The host allocates a portion of the guest IO space, which is mapped
  to the actual fence value memory on the host
- The host returns the guest IO space address to the guest
- The guest allocates a CPU virtual address and updates page tables
  to point to the IO space address

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 184 +++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  80 +++++++++++++
 drivers/hv/dxgkrnl/dxgmodule.c  |   1 +
 drivers/hv/dxgkrnl/dxgprocess.c |  16 +++
 drivers/hv/dxgkrnl/dxgvmbus.c   | 199 ++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c      | 130 +++++++++++++++++++++
 6 files changed, 610 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 3f51456272cc..2a9a731c3352 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -165,6 +165,24 @@ void dxgadapter_remove_process(struct dxgprocess_adapter *process_info)
 	process_info->adapter_process_list_entry.prev = NULL;
 }
 
+void dxgadapter_add_syncobj(struct dxgadapter *adapter,
+			    struct dxgsyncobject *object)
+{
+	down_write(&adapter->shared_resource_list_lock);
+	list_add_tail(&object->syncobj_list_entry, &adapter->syncobj_list_head);
+	up_write(&adapter->shared_resource_list_lock);
+}
+
+void dxgadapter_remove_syncobj(struct dxgsyncobject *object)
+{
+	down_write(&object->adapter->shared_resource_list_lock);
+	if (object->syncobj_list_entry.next) {
+		list_del(&object->syncobj_list_entry);
+		object->syncobj_list_entry.next = NULL;
+	}
+	up_write(&object->adapter->shared_resource_list_lock);
+}
+
 int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter)
 {
 	down_write(&adapter->core_lock);
@@ -217,6 +235,7 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 		init_rwsem(&device->context_list_lock);
 		init_rwsem(&device->alloc_list_lock);
 		INIT_LIST_HEAD(&device->pqueue_list_head);
+		INIT_LIST_HEAD(&device->syncobj_list_head);
 		device->object_state = DXGOBJECTSTATE_CREATED;
 		device->execution_state = _D3DKMT_DEVICEEXECUTION_ACTIVE;
 
@@ -232,6 +251,7 @@ struct dxgdevice *dxgdevice_create(struct dxgadapter *adapter,
 void dxgdevice_stop(struct dxgdevice *device)
 {
 	struct dxgallocation *alloc;
+	struct dxgsyncobject *syncobj;
 
 	pr_debug("%s: %p", __func__, device);
 	dxgdevice_acquire_alloc_list_lock(device);
@@ -240,6 +260,12 @@ void dxgdevice_stop(struct dxgdevice *device)
 	}
 	dxgdevice_release_alloc_list_lock(device);
 
+	hmgrtable_lock(&device->process->handle_table, DXGLOCK_EXCL);
+	list_for_each_entry(syncobj, &device->syncobj_list_head,
+			    syncobj_list_entry) {
+		dxgsyncobject_stop(syncobj);
+	}
+	hmgrtable_unlock(&device->process->handle_table, DXGLOCK_EXCL);
 	pr_debug("%s: end %p\n", __func__, device);
 }
 
@@ -269,6 +295,20 @@ void dxgdevice_destroy(struct dxgdevice *device)
 
 	dxgdevice_acquire_alloc_list_lock(device);
 
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
 	{
 		struct dxgallocation *alloc;
 		struct dxgallocation *tmp;
@@ -569,6 +609,30 @@ void dxgdevice_release(struct kref *refcount)
 	vfree(device);
 }
 
+void dxgdevice_add_syncobj(struct dxgdevice *device,
+			   struct dxgsyncobject *syncobj)
+{
+	dxgdevice_acquire_alloc_list_lock(device);
+	list_add_tail(&syncobj->syncobj_list_entry, &device->syncobj_list_head);
+	kref_get(&syncobj->syncobj_kref);
+	dxgdevice_release_alloc_list_lock(device);
+}
+
+void dxgdevice_remove_syncobj(struct dxgsyncobject *entry)
+{
+	struct dxgdevice *device = entry->device;
+
+	dxgdevice_acquire_alloc_list_lock(device);
+	if (entry->syncobj_list_entry.next) {
+		list_del(&entry->syncobj_list_entry);
+		entry->syncobj_list_entry.next = NULL;
+		kref_put(&entry->syncobj_kref, dxgsyncobject_release);
+	}
+	dxgdevice_release_alloc_list_lock(device);
+	kref_put(&device->device_kref, dxgdevice_release);
+	entry->device = NULL;
+}
+
 struct dxgcontext *dxgcontext_create(struct dxgdevice *device)
 {
 	struct dxgcontext *context = vzalloc(sizeof(struct dxgcontext));
@@ -806,3 +870,123 @@ void dxgprocess_adapter_remove_device(struct dxgdevice *device)
 	}
 	mutex_unlock(&device->adapter_info->device_list_mutex);
 }
+
+struct dxgsyncobject *dxgsyncobject_create(struct dxgprocess *process,
+					   struct dxgdevice *device,
+					   struct dxgadapter *adapter,
+					   enum
+					   d3dddi_synchronizationobject_type
+					   type,
+					   struct
+					   d3dddi_synchronizationobject_flags
+					   flags)
+{
+	struct dxgsyncobject *syncobj;
+
+	syncobj = vzalloc(sizeof(*syncobj));
+	if (syncobj == NULL)
+		goto cleanup;
+	syncobj->type = type;
+	syncobj->process = process;
+	switch (type) {
+	case _D3DDDI_MONITORED_FENCE:
+	case _D3DDDI_PERIODIC_MONITORED_FENCE:
+		syncobj->monitored_fence = 1;
+		break;
+	default:
+		break;
+	}
+	if (flags.shared) {
+		syncobj->shared = 1;
+		if (!flags.nt_security_sharing) {
+			dev_err(dxgglobaldev,
+				"%s: nt_security_sharing must be set",
+				__func__);
+			goto cleanup;
+		}
+	}
+
+	kref_init(&syncobj->syncobj_kref);
+
+	if (syncobj->monitored_fence) {
+		syncobj->device = device;
+		syncobj->device_handle = device->handle;
+		kref_get(&device->device_kref);
+		dxgdevice_add_syncobj(device, syncobj);
+	} else {
+		dxgadapter_add_syncobj(adapter, syncobj);
+	}
+	syncobj->adapter = adapter;
+	kref_get(&adapter->adapter_kref);
+
+	pr_debug("%s 0x%p\n", __func__, syncobj);
+	return syncobj;
+cleanup:
+	if (syncobj)
+		vfree(syncobj);
+	return NULL;
+}
+
+void dxgsyncobject_destroy(struct dxgprocess *process,
+			   struct dxgsyncobject *syncobj)
+{
+	int destroyed;
+
+	pr_debug("%s 0x%p", __func__, syncobj);
+
+	dxgsyncobject_stop(syncobj);
+
+	destroyed = test_and_set_bit(0, &syncobj->flags);
+	if (!destroyed) {
+		pr_debug("Deleting handle: %x", syncobj->handle.v);
+		hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+		if (syncobj->handle.v) {
+			hmgrtable_free_handle(&process->handle_table,
+					      HMGRENTRY_TYPE_DXGSYNCOBJECT,
+					      syncobj->handle);
+			syncobj->handle.v = 0;
+			kref_put(&syncobj->syncobj_kref, dxgsyncobject_release);
+		}
+		hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+		if (syncobj->monitored_fence)
+			dxgdevice_remove_syncobj(syncobj);
+		else
+			dxgadapter_remove_syncobj(syncobj);
+		if (syncobj->adapter) {
+			kref_put(&syncobj->adapter->adapter_kref,
+				 dxgadapter_release);
+			syncobj->adapter = NULL;
+		}
+	}
+	kref_put(&syncobj->syncobj_kref, dxgsyncobject_release);
+}
+
+void dxgsyncobject_stop(struct dxgsyncobject *syncobj)
+{
+	int stopped = test_and_set_bit(1, &syncobj->flags);
+
+	if (!stopped) {
+		pr_debug("stopping");
+		if (syncobj->monitored_fence) {
+			if (syncobj->mapped_address) {
+				int ret =
+				    dxg_unmap_iospace(syncobj->mapped_address,
+						      PAGE_SIZE);
+
+				(void)ret;
+				pr_debug("unmap fence %d %p\n",
+					ret, syncobj->mapped_address);
+				syncobj->mapped_address = NULL;
+			}
+		}
+	}
+}
+
+void dxgsyncobject_release(struct kref *refcount)
+{
+	struct dxgsyncobject *syncobj;
+
+	syncobj = container_of(refcount, struct dxgsyncobject, syncobj_kref);
+	vfree(syncobj);
+}
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 28c3dbef0ef3..bffa7f1a21c1 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -33,6 +33,7 @@ struct dxgdevice;
 struct dxgcontext;
 struct dxgallocation;
 struct dxgresource;
+struct dxgsyncobject;
 
 #include "misc.h"
 #include "hmgr.h"
@@ -81,6 +82,56 @@ int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev);
 void dxgvmbuschannel_destroy(struct dxgvmbuschannel *ch);
 void dxgvmbuschannel_receive(void *ctx);
 
+/*
+ * This is GPU synchronization object, which is used to synchronize execution
+ * between GPU contextx/hardware queues or for tracking GPU execution progress.
+ * A dxgsyncobject is created when somebody creates a syncobject or opens a
+ * shared syncobject.
+ * A syncobject belongs to an adapter, unless it is a cross-adapter object.
+ * Cross adapter syncobjects are currently not implemented.
+ *
+ * D3DDDI_MONITORED_FENCE and D3DDDI_PERIODIC_MONITORED_FENCE are called
+ * "device" syncobject, because the belong to a device (dxgdevice).
+ * Device syncobjects are inserted to a list in dxgdevice.
+ *
+ */
+struct dxgsyncobject {
+	struct kref			syncobj_kref;
+	enum d3dddi_synchronizationobject_type	type;
+	/*
+	 * List entry in dxgdevice for device sync objects.
+	 * List entry in dxgadapter for other objects
+	 */
+	struct list_head		syncobj_list_entry;
+	/* Adapter, the syncobject belongs to. NULL for stopped sync obejcts. */
+	struct dxgadapter		*adapter;
+	/*
+	 * Pointer to the device, which was used to create the object.
+	 * This is NULL for non-device syncbjects
+	 */
+	struct dxgdevice		*device;
+	struct dxgprocess		*process;
+	/* CPU virtual address of the fence value for "device" syncobjects */
+	void				*mapped_address;
+	/* Handle in the process handle table */
+	struct d3dkmthandle		handle;
+	/* Cached handle of the device. Used to avoid device dereference. */
+	struct d3dkmthandle		device_handle;
+	union {
+		struct {
+			/* Must be the first bit */
+			u32		destroyed:1;
+			/* Must be the second bit */
+			u32		stopped:1;
+			/* device syncobject */
+			u32		monitored_fence:1;
+			u32		shared:1;
+			u32		reserved:27;
+		};
+		long			flags;
+	};
+};
+
 /*
  * The structure defines an offered vGPU vm bus channel.
  */
@@ -90,6 +141,20 @@ struct dxgvgpuchannel {
 	struct hv_device	*hdev;
 };
 
+struct dxgsyncobject *dxgsyncobject_create(struct dxgprocess *process,
+					   struct dxgdevice *device,
+					   struct dxgadapter *adapter,
+					   enum
+					   d3dddi_synchronizationobject_type
+					   type,
+					   struct
+					   d3dddi_synchronizationobject_flags
+					   flags);
+void dxgsyncobject_destroy(struct dxgprocess *process,
+			   struct dxgsyncobject *syncobj);
+void dxgsyncobject_stop(struct dxgsyncobject *syncobj);
+void dxgsyncobject_release(struct kref *refcount);
+
 struct dxgglobal {
 	struct dxgvmbuschannel	channel;
 	struct delayed_work	dwork;
@@ -254,6 +319,8 @@ struct dxgadapter {
 	struct list_head	adapter_list_entry;
 	/* The list of dxgprocess_adapter entries */
 	struct list_head	adapter_process_list_head;
+	/* List of all non-device dxgsyncobject objects */
+	struct list_head	syncobj_list_head;
 	/* This lock protects shared resource and syncobject lists */
 	struct rw_semaphore	shared_resource_list_lock;
 	struct pci_dev		*pci_dev;
@@ -279,6 +346,9 @@ void dxgadapter_release_lock_shared(struct dxgadapter *adapter);
 int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter);
 void dxgadapter_acquire_lock_forced(struct dxgadapter *adapter);
 void dxgadapter_release_lock_exclusive(struct dxgadapter *adapter);
+void dxgadapter_add_syncobj(struct dxgadapter *adapter,
+			    struct dxgsyncobject *so);
+void dxgadapter_remove_syncobj(struct dxgsyncobject *so);
 void dxgadapter_add_process(struct dxgadapter *adapter,
 			    struct dxgprocess_adapter *process_info);
 void dxgadapter_remove_process(struct dxgprocess_adapter *process_info);
@@ -308,6 +378,7 @@ struct dxgdevice {
 	struct list_head	resource_list_head;
 	/* List of paging queues. Protected by process handle table lock. */
 	struct list_head	pqueue_list_head;
+	struct list_head	syncobj_list_head;
 	struct d3dkmthandle	handle;
 	enum d3dkmt_deviceexecution_state execution_state;
 	u32			handle_valid;
@@ -328,6 +399,8 @@ void dxgdevice_remove_alloc_safe(struct dxgdevice *dev,
 				 struct dxgallocation *a);
 void dxgdevice_add_resource(struct dxgdevice *dev, struct dxgresource *res);
 void dxgdevice_remove_resource(struct dxgdevice *dev, struct dxgresource *res);
+void dxgdevice_add_syncobj(struct dxgdevice *dev, struct dxgsyncobject *so);
+void dxgdevice_remove_syncobj(struct dxgsyncobject *so);
 bool dxgdevice_is_active(struct dxgdevice *dev);
 void dxgdevice_acquire_context_list_lock(struct dxgdevice *dev);
 void dxgdevice_release_context_list_lock(struct dxgdevice *dev);
@@ -435,6 +508,7 @@ void init_ioctls(void);
 long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 
+int dxg_unmap_iospace(void *va, u32 size);
 static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
 {
 	*luid = *(struct winluid *)&guid->b[0];
@@ -488,6 +562,12 @@ int dxgvmb_send_create_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 int dxgvmb_send_destroy_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 				   struct d3dkmt_destroyallocation2 *args,
 				   struct d3dkmthandle *alloc_handles);
+int dxgvmb_send_create_sync_object(struct dxgprocess *pr,
+				   struct dxgadapter *adapter,
+				   struct d3dkmt_createsynchronizationobject2
+				   *args, struct dxgsyncobject *so);
+int dxgvmb_send_destroy_sync_object(struct dxgprocess *pr,
+				    struct d3dkmthandle h);
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index d865ac45f89d..9d339f15a4b7 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -158,6 +158,7 @@ int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
 	init_rwsem(&adapter->core_lock);
 
 	INIT_LIST_HEAD(&adapter->adapter_process_list_head);
+	INIT_LIST_HEAD(&adapter->syncobj_list_head);
 	init_rwsem(&adapter->shared_resource_list_lock);
 	adapter->pci_dev = dev;
 	guid_to_luid(guid, &adapter->luid);
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index 1e6500e12a22..30af930cc8c0 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -59,6 +59,7 @@ void dxgprocess_destroy(struct dxgprocess *process)
 	enum hmgrentry_type t;
 	struct d3dkmthandle h;
 	void *o;
+	struct dxgsyncobject *syncobj;
 	struct dxgprocess_adapter *entry;
 	struct dxgprocess_adapter *tmp;
 
@@ -84,6 +85,21 @@ void dxgprocess_destroy(struct dxgprocess *process)
 		}
 	}
 
+	i = 0;
+	while (hmgrtable_next_entry(&process->handle_table, &i, &t, &h, &o)) {
+		switch (t) {
+		case HMGRENTRY_TYPE_DXGSYNCOBJECT:
+			pr_debug("Destroy syncobj: %p %d", o, i);
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
 	hmgrtable_destroy(&process->handle_table);
 	hmgrtable_destroy(&process->local_handle_table);
 }
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 541182c0b728..2cc49283c090 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -479,6 +479,86 @@ dxgvmb_send_sync_msg_ntstatus(struct dxgvmbuschannel *channel,
 	return ret;
 }
 
+static int check_iospace_address(unsigned long address, u32 size)
+{
+	if (address < dxgglobal->mmiospace_base ||
+	    size > dxgglobal->mmiospace_size ||
+	    address >= (dxgglobal->mmiospace_base +
+			dxgglobal->mmiospace_size - size)) {
+		pr_err("invalid iospace address %lx", address);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int dxg_unmap_iospace(void *va, u32 size)
+{
+	int ret = 0;
+
+	pr_debug("%s %p %x", __func__, va, size);
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
+static u8 *dxg_map_iospace(u64 iospace_address, u32 size,
+			   unsigned long protection, bool cached)
+{
+	struct vm_area_struct *vma;
+	unsigned long va;
+	int ret = 0;
+
+	pr_debug("%s: %llx %x %lx",
+		    __func__, iospace_address, size, protection);
+	if (check_iospace_address(iospace_address, size) < 0) {
+		pr_err("%s: invalid address", __func__);
+		return NULL;
+	}
+
+	va = vm_mmap(NULL, 0, size, protection, MAP_SHARED | MAP_ANONYMOUS, 0);
+	if ((long)va <= 0) {
+		pr_err("vm_mmap failed %lx %d", va, size);
+		return NULL;
+	}
+
+	mmap_read_lock(current->mm);
+	vma = find_vma(current->mm, (unsigned long)va);
+	if (vma) {
+		pgprot_t prot = vma->vm_page_prot;
+
+		if (!cached)
+			prot = pgprot_writecombine(prot);
+		pr_debug("vma: %lx %lx %lx",
+			    vma->vm_start, vma->vm_end, va);
+		vma->vm_pgoff = iospace_address >> PAGE_SHIFT;
+		ret = io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+					 size, prot);
+		if (ret)
+			pr_err("io_remap_pfn_range failed: %d", ret);
+	} else {
+		pr_err("failed to find vma: %p %lx", vma, va);
+		ret = -ENOMEM;
+	}
+	mmap_read_unlock(current->mm);
+
+	if (ret) {
+		dxg_unmap_iospace((void *)va, size);
+		return NULL;
+	}
+	pr_debug("%s end: %lx", __func__, va);
+	return (u8 *) va;
+}
+
 /*
  * Global messages to the host
  */
@@ -597,6 +677,39 @@ int dxgvmb_send_destroy_process(struct d3dkmthandle process)
 	return ret;
 }
 
+int dxgvmb_send_destroy_sync_object(struct dxgprocess *process,
+				    struct d3dkmthandle sync_object)
+{
+	struct dxgkvmb_command_destroysyncobject *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
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
+	command_vm_to_host_init2(&command->hdr,
+				 DXGK_VMBCOMMAND_DESTROYSYNCOBJECT,
+				 process->host_handle);
+	command->sync_object = sync_object;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(dxgglobal_get_dxgvmbuschannel(),
+					    msg.hdr, msg.size);
+
+	dxgglobal_release_channel_lock();
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 /*
  * Virtual GPU messages to the host
  */
@@ -1454,6 +1567,92 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 	return ret;
 }
 
+static void set_result(struct d3dkmt_createsynchronizationobject2 *args,
+		       u64 fence_gpu_va, u8 *va)
+{
+	args->info.periodic_monitored_fence.fence_gpu_virtual_address =
+	    fence_gpu_va;
+	args->info.periodic_monitored_fence.fence_cpu_virtual_address = va;
+}
+
+int
+dxgvmb_send_create_sync_object(struct dxgprocess *process,
+			       struct dxgadapter *adapter,
+			       struct d3dkmt_createsynchronizationobject2 *args,
+			       struct dxgsyncobject *syncobj)
+{
+	struct dxgkvmb_command_createsyncobject_return result = { };
+	struct dxgkvmb_command_createsyncobject *command;
+	int ret;
+	u8 *va = 0;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_CREATESYNCOBJECT,
+				   process->host_handle);
+	command->args = *args;
+	command->client_hint = 1;	/* CLIENTHINT_UMD */
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size, &result,
+				   sizeof(result));
+	if (ret < 0) {
+		pr_err("%s failed %d", __func__, ret);
+		goto cleanup;
+	}
+	args->sync_object = result.sync_object;
+	if (syncobj->shared) {
+		if (result.global_sync_object.v == 0) {
+			pr_err("shared handle is 0");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		args->info.shared_handle = result.global_sync_object;
+	}
+
+	if (syncobj->monitored_fence) {
+		va = dxg_map_iospace(result.fence_storage_address, PAGE_SIZE,
+				     PROT_READ | PROT_WRITE, true);
+		if (va == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		if (args->info.type == _D3DDDI_MONITORED_FENCE) {
+			args->info.monitored_fence.fence_gpu_virtual_address =
+			    result.fence_gpu_va;
+			args->info.monitored_fence.fence_cpu_virtual_address =
+			    va;
+			{
+				unsigned long value;
+
+				pr_debug("fence cpu va: %p", va);
+				ret = copy_from_user(&value, va,
+						     sizeof(u64));
+				if (ret) {
+					pr_err("failed to read fence");
+					ret = -EINVAL;
+				} else {
+					pr_debug("fence value:%lx",
+						value);
+				}
+			}
+		} else {
+			set_result(args, result.fence_gpu_va, va);
+		}
+		syncobj->mapped_address = va;
+	}
+
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
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 1f07a883debb..bc1ac2dd302f 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1368,6 +1368,132 @@ dxgk_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_createsynchronizationobject2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct dxgsyncobject *syncobj = NULL;
+	bool device_lock_acquired = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
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
+	syncobj = dxgsyncobject_create(process, device, adapter, args.info.type,
+				       args.info.flags);
+	if (syncobj == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_create_sync_object(process, adapter, &args, syncobj);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy output args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	ret = hmgrtable_assign_handle(&process->handle_table, syncobj,
+				      HMGRENTRY_TYPE_DXGSYNCOBJECT,
+				      args.sync_object);
+	if (ret >= 0)
+		syncobj->handle = args.sync_object;
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+cleanup:
+
+	if (ret < 0) {
+		if (syncobj) {
+			dxgsyncobject_destroy(process, syncobj);
+			if (args.sync_object.v)
+				dxgvmb_send_destroy_sync_object(process,
+							args.sync_object);
+		}
+	}
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device_lock_acquired)
+		dxgdevice_release_lock_shared(device);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_destroy_sync_object(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_destroysynchronizationobject args;
+	struct dxgsyncobject *syncobj = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	pr_debug("handle 0x%x", args.sync_object.v);
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	syncobj = hmgrtable_get_object_by_type(&process->handle_table,
+					       HMGRENTRY_TYPE_DXGSYNCOBJECT,
+					       args.sync_object);
+	if (syncobj) {
+		pr_debug("syncobj 0x%p", syncobj);
+		syncobj->handle.v = 0;
+		hmgrtable_free_handle(&process->handle_table,
+				      HMGRENTRY_TYPE_DXGSYNCOBJECT,
+				      args.sync_object);
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (syncobj == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	dxgsyncobject_destroy(process, syncobj);
+
+	ret = dxgvmb_send_destroy_sync_object(process, args.sync_object);
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
@@ -1436,6 +1562,8 @@ void init_ioctls(void)
 		  LX_DXCREATEALLOCATION);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
+	SET_IOCTL(/*0x10 */ dxgk_create_sync_object,
+		  LX_DXCREATESYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x13 */ dxgk_destroy_allocation,
 		  LX_DXDESTROYALLOCATION2);
 	SET_IOCTL(/*0x14 */ dxgk_enum_adapters,
@@ -1444,6 +1572,8 @@ void init_ioctls(void)
 		  LX_DXCLOSEADAPTER);
 	SET_IOCTL(/*0x19 */ dxgk_destroy_device,
 		  LX_DXDESTROYDEVICE);
+	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
+		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
 		  LX_DXENUMADAPTERS3);
 }
-- 
2.35.1

