Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A632348CC96
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 20:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350674AbiALT4h (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 14:56:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33312 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357559AbiALTzQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 14:55:16 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id F201120B7186;
        Wed, 12 Jan 2022 11:55:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F201120B7186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642017316;
        bh=rvjPZZSRrsb83Ag7WhlT/ucQF79jPjZQ1qtuOq8jzwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktzppVqe0vY4wasgWHcJQCSWgC6UqpWGUBYdZUB3U7W66I9MStaWXvGtUWdZJqT/J
         Me2zBJkcrXwKuwcrk9uzku7NMAUi5DscZMrQQ8qbhx3badoekiJh7hIjL+GeTfKYUP
         qGiToQbQbDqL1J2trOWg2WYxY+L4XtEnhZ0QDmEM=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 4/9] drivers: hv: dxgkrnl: Implement operations with GPU sync objects
Date:   Wed, 12 Jan 2022 11:55:09 -0800
Message-Id: <61c1348d071908fe527ab0fe110585c6589af025.1641937419.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641937419.git.iourit@linux.microsoft.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement ioctls for using GPU synchronization objects:
   LX_DXCREATESYNCHRONIZATIONOBJECT,
   LX_DXSIGNALSYNCHRONIZATIONOBJECT,
   LX_DXWAITFORSYNCHRONIZATIONOBJECT,
   LX_DXDESTROYSYNCHRONIZATIONOBJECT,
   LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU,
   LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU,
   LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2,
   LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU,
   LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU.

GPU synchronization objects are used to synchornize GPU command
execution between different execution contexts. A wait for a sync
object could be submitted to a GPU context (thread) or could be
done on CPU. The wait is satisfied when the sync object is signaled.
The signal operation could be submitted to a GPU context (thread) or
could be signaled by a CPU thread.

The driver creates the corresponsing tracking structures and sends
VM bus messages to the host to do the corresponding operation.

When a caller needs to wait for a sync object on CPU, an event structure
is added to the global list (dxgglobal->host_event_list_head). Each
list entry has an ID and a pointer to the event to signal. When the sync
object is signaled on the host, the host sends a message to the guest
with the event ID to signal. dxgglobal_signal_host_event() processes this
message and signals the corresponding CPU event.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 280 ++++++++++-
 drivers/hv/dxgkrnl/dxgkrnl.h    |   4 +-
 drivers/hv/dxgkrnl/dxgvmbus.c   | 429 +++++++++++++++-
 drivers/hv/dxgkrnl/ioctl.c      | 840 ++++++++++++++++++++++++++++++++
 4 files changed, 1541 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 26648f7fe36f..da6d7c4a7dc5 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -167,6 +167,55 @@ void dxgadapter_remove_process(struct dxgprocess_adapter *process_info)
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
+void dxgadapter_add_shared_syncobj(struct dxgadapter *adapter,
+				   struct dxgsharedsyncobject *object)
+{
+	down_write(&adapter->shared_resource_list_lock);
+	list_add_tail(&object->adapter_shared_syncobj_list_entry,
+		      &adapter->adapter_shared_syncobj_list_head);
+	up_write(&adapter->shared_resource_list_lock);
+}
+
+void dxgadapter_remove_shared_syncobj(struct dxgadapter *adapter,
+				      struct dxgsharedsyncobject *object)
+{
+	down_write(&adapter->shared_resource_list_lock);
+	if (object->adapter_shared_syncobj_list_entry.next) {
+		list_del(&object->adapter_shared_syncobj_list_entry);
+		object->adapter_shared_syncobj_list_entry.next = NULL;
+	}
+	up_write(&adapter->shared_resource_list_lock);
+}
+
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
@@ -679,6 +728,30 @@ void dxgdevice_release(struct kref *refcount)
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
@@ -935,28 +1008,221 @@ void dxgprocess_adapter_remove_device(struct dxgdevice *device)
 	mutex_unlock(&device->adapter_info->device_list_mutex);
 }
 
-void dxghwqueue_destroy(struct dxgprocess *process, struct dxghwqueue *hwqueue)
+struct dxgsharedsyncobject *dxgsharedsyncobj_create(struct dxgadapter *adapter,
+						    struct dxgsyncobject *so)
 {
-	/* Placeholder */
+	struct dxgsharedsyncobject *syncobj;
+
+	syncobj = vzalloc(sizeof(*syncobj));
+	if (syncobj) {
+		kref_init(&syncobj->ssyncobj_kref);
+		INIT_LIST_HEAD(&syncobj->shared_syncobj_list_head);
+		syncobj->adapter = adapter;
+		syncobj->type = so->type;
+		syncobj->monitored_fence = so->monitored_fence;
+		dxgadapter_add_shared_syncobj(adapter, syncobj);
+		kref_get(&adapter->adapter_kref);
+		init_rwsem(&syncobj->syncobj_list_lock);
+		mutex_init(&syncobj->fd_mutex);
+	}
+	return syncobj;
 }
 
-void dxgpagingqueue_destroy(struct dxgpagingqueue *pqueue)
+void dxgsharedsyncobj_release(struct kref *refcount)
 {
-	/* Placeholder */
+	struct dxgsharedsyncobject *syncobj;
+
+	syncobj = container_of(refcount, struct dxgsharedsyncobject,
+			       ssyncobj_kref);
+	dev_dbg(dxgglobaldev, "Destroying shared sync object %p", syncobj);
+	if (syncobj->adapter) {
+		dxgadapter_remove_shared_syncobj(syncobj->adapter,
+							syncobj);
+		kref_put(&syncobj->adapter->adapter_kref,
+				dxgadapter_release);
+	}
+	vfree(syncobj);
 }
 
-void dxgpagingqueue_stop(struct dxgpagingqueue *pqueue)
+void dxgsharedsyncobj_add_syncobj(struct dxgsharedsyncobject *shared,
+				  struct dxgsyncobject *syncobj)
 {
-	/* Placeholder */
+	dev_dbg(dxgglobaldev, "%s 0x%p 0x%p", __func__, shared, syncobj);
+	kref_get(&shared->ssyncobj_kref);
+	down_write(&shared->syncobj_list_lock);
+	list_add(&syncobj->shared_syncobj_list_entry,
+		 &shared->shared_syncobj_list_head);
+	syncobj->shared_owner = shared;
+	up_write(&shared->syncobj_list_lock);
+}
+
+void dxgsharedsyncobj_remove_syncobj(struct dxgsharedsyncobject *shared,
+				     struct dxgsyncobject *syncobj)
+{
+	dev_dbg(dxgglobaldev, "%s 0x%p", __func__, shared);
+	down_write(&shared->syncobj_list_lock);
+	list_del(&syncobj->shared_syncobj_list_entry);
+	up_write(&shared->syncobj_list_lock);
+}
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
+	case _D3DDDI_CPU_NOTIFICATION:
+		syncobj->cpu_event = 1;
+		syncobj->host_event = vzalloc(sizeof(struct dxghostevent));
+		if (syncobj->host_event == NULL)
+			goto cleanup;
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
+	dev_dbg(dxgglobaldev, "%s 0x%p\n", __func__, syncobj);
+	return syncobj;
+cleanup:
+	if (syncobj->host_event)
+		vfree(syncobj->host_event);
+	if (syncobj)
+		vfree(syncobj);
+	return NULL;
 }
 
 void dxgsyncobject_destroy(struct dxgprocess *process,
 			   struct dxgsyncobject *syncobj)
 {
-	/* Placeholder */
+	int destroyed;
+	struct dxghosteventcpu *host_event;
+
+	dev_dbg(dxgglobaldev, "%s 0x%p", __func__, syncobj);
+
+	dxgsyncobject_stop(syncobj);
+
+	destroyed = test_and_set_bit(0, &syncobj->flags);
+	if (!destroyed) {
+		dev_dbg(dxgglobaldev, "Deleting handle: %x", syncobj->handle.v);
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
+		if (syncobj->cpu_event) {
+			host_event = syncobj->host_event;
+			if (host_event->cpu_event) {
+				eventfd_ctx_put(host_event->cpu_event);
+				if (host_event->hdr.event_id)
+					dxgglobal_remove_host_event(
+						&host_event->hdr);
+				host_event->cpu_event = NULL;
+			}
+		}
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
 }
 
 void dxgsyncobject_stop(struct dxgsyncobject *syncobj)
+{
+	int stopped = test_and_set_bit(1, &syncobj->flags);
+
+	if (!stopped) {
+		dev_dbg(dxgglobaldev, "stopping");
+		if (syncobj->monitored_fence) {
+			if (syncobj->mapped_address) {
+				int ret =
+				    dxg_unmap_iospace(syncobj->mapped_address,
+						      PAGE_SIZE);
+
+				(void)ret;
+				dev_dbg(dxgglobaldev, "fence is unmapped %d %p\n",
+					    ret, syncobj->mapped_address);
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
+	if (syncobj->shared_owner) {
+		dxgsharedsyncobj_remove_syncobj(syncobj->shared_owner,
+						syncobj);
+		kref_put(&syncobj->shared_owner->ssyncobj_kref,
+			 dxgsharedsyncobj_release);
+	}
+	if (syncobj->host_event)
+		vfree(syncobj->host_event);
+	vfree(syncobj);
+}
+
+void dxghwqueue_destroy(struct dxgprocess *process, struct dxghwqueue *hwqueue)
+{
+	/* Placeholder */
+}
+
+void dxgpagingqueue_destroy(struct dxgpagingqueue *pqueue)
+{
+	/* Placeholder */
+}
+
+void dxgpagingqueue_stop(struct dxgpagingqueue *pqueue)
 {
 	/* Placeholder */
 }
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 269391319f56..9d2d55d9b509 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -100,8 +100,8 @@ struct dxgpagingqueue {
  * a message from host.
  */
 enum dxghosteventtype {
-	dxghostevent_cpu_event,
-	dxghostevent_dma_fence
+	dxghostevent_cpu_event = 1,
+	dxghostevent_dma_fence = 2
 };
 
 struct dxghostevent {
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index aba5f1cef431..4fe799eb8968 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -251,18 +251,66 @@ static inline void command_vm_to_host_init1(struct dxgkvmb_command_vm_to_host
 	command->channel_type = DXGKVMB_VM_TO_HOST;
 }
 
+void set_guest_data(struct dxgkvmb_command_host_to_vm *packet,
+		    u32 packet_length)
+{
+	struct dxgkvmb_command_setguestdata *command = (void *)packet;
+
+	dev_dbg(dxgglobaldev, "%s: %d %d %p %p", __func__,
+		command->data_type,
+		command->data32,
+		command->guest_pointer,
+		&dxgglobal->device_state_counter);
+	if (command->data_type == SETGUESTDATA_DATATYPE_DWORD &&
+	    command->guest_pointer == &dxgglobal->device_state_counter &&
+	    command->data32 != 0) {
+		atomic_inc(&dxgglobal->device_state_counter);
+	}
+}
+
+void signal_guest_event(struct dxgkvmb_command_host_to_vm *packet,
+			u32 packet_length)
+{
+	struct dxgkvmb_command_signalguestevent *command = (void *)packet;
+
+	if (packet_length < sizeof(struct dxgkvmb_command_signalguestevent)) {
+		pr_err("invalid packet size");
+		return;
+	}
+	if (command->event == 0) {
+		pr_err("invalid event pointer");
+		return;
+	}
+	dxgglobal_signal_host_event(command->event);
+}
+
 void process_inband_packet(struct dxgvmbuschannel *channel,
 			   struct vmpacket_descriptor *desc)
 {
 	u32 packet_length = hv_pkt_datalen(desc);
+	struct dxgkvmb_command_host_to_vm *packet;
 
 	if (channel->adapter == NULL) {
 		if (packet_length < sizeof(struct dxgkvmb_command_host_to_vm)) {
 			pr_err("Invalid global packet");
 		} else {
-			/*
-			 *Placeholder
-			 */
+			packet = hv_pkt_data(desc);
+			dev_dbg(dxgglobaldev, "global packet %d",
+				    packet->command_type);
+			switch (packet->command_type) {
+			case DXGK_VMBCOMMAND_SETGUESTDATA:
+				set_guest_data(packet, packet_length);
+				break;
+			case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
+			case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
+				signal_guest_event(packet, packet_length);
+				break;
+			case DXGK_VMBCOMMAND_SENDWNFNOTIFICATION:
+				break;
+			default:
+				pr_err("unexpected host message %d",
+					   packet->command_type);
+			}
 		}
 	} else {
 		pr_err("Unexpected packet for adapter channel");
@@ -444,6 +492,18 @@ dxgvmb_send_sync_msg_ntstatus(struct dxgvmbuschannel *channel,
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
 int dxg_unmap_iospace(void *va, u32 size)
 {
 	int ret = 0;
@@ -464,6 +524,54 @@ int dxg_unmap_iospace(void *va, u32 size)
 	return 0;
 }
 
+static u8 *dxg_map_iospace(u64 iospace_address, u32 size,
+			   unsigned long protection, bool cached)
+{
+	struct vm_area_struct *vma;
+	unsigned long va;
+	int ret = 0;
+
+	dev_dbg(dxgglobaldev, "%s: %llx %x %lx",
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
+		dev_dbg(dxgglobaldev, "vma: %lx %lx %lx",
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
+	dev_dbg(dxgglobaldev, "%s end: %lx", __func__, va);
+	return (u8 *) va;
+}
+
 /*
  * Global messages to the host
  */
@@ -582,6 +690,39 @@ int dxgvmb_send_destroy_process(struct d3dkmthandle process)
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
 /*
  * Virtual GPU messages to the host
  */
@@ -1439,6 +1580,288 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
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
+				dev_dbg(dxgglobaldev, "fence cpu va: %p", va);
+				ret = copy_from_user(&value, va,
+						     sizeof(u64));
+				if (ret) {
+					pr_err("failed to read fence");
+					ret = -EINVAL;
+				} else {
+					dev_dbg(dxgglobaldev, "fence value:%lx",
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_signal_sync_object(struct dxgprocess *process,
+				   struct dxgadapter *adapter,
+				   struct d3dddicb_signalflags flags,
+				   u64 legacy_fence_value,
+				   struct d3dkmthandle context,
+				   u32 object_count,
+				   struct d3dkmthandle __user *objects,
+				   u32 context_count,
+				   struct d3dkmthandle __user *contexts,
+				   u32 fence_count,
+				   u64 __user *fences,
+				   struct eventfd_ctx *cpu_event_handle,
+				   struct d3dkmthandle device)
+{
+	int ret;
+	struct dxgkvmb_command_signalsyncobject *command;
+	u32 object_size = object_count * sizeof(struct d3dkmthandle);
+	u32 context_size = context_count * sizeof(struct d3dkmthandle);
+	u32 fence_size = fences ? fence_count * sizeof(u64) : 0;
+	u8 *current_pos;
+	u32 cmd_size = sizeof(struct dxgkvmb_command_signalsyncobject) +
+	    object_size + context_size + fence_size;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (context.v)
+		cmd_size += sizeof(struct d3dkmthandle);
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_SIGNALSYNCOBJECT,
+				   process->host_handle);
+
+	if (flags.enqueue_cpu_event)
+		command->cpu_event_handle = (u64) cpu_event_handle;
+	else
+		command->device = device;
+	command->flags = flags;
+	command->fence_value = legacy_fence_value;
+	command->object_count = object_count;
+	command->context_count = context_count;
+	current_pos = (u8 *) &command[1];
+	ret = copy_from_user(current_pos, objects, object_size);
+	if (ret) {
+		pr_err("Failed to read objects %p %d",
+			objects, object_size);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	current_pos += object_size;
+	if (context.v) {
+		command->context_count++;
+		*(struct d3dkmthandle *) current_pos = context;
+		current_pos += sizeof(struct d3dkmthandle);
+	}
+	if (context_size) {
+		ret = copy_from_user(current_pos, contexts, context_size);
+		if (ret) {
+			pr_err("Failed to read contexts %p %d",
+				contexts, context_size);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		current_pos += context_size;
+	}
+	if (fence_size) {
+		ret = copy_from_user(current_pos, fences, fence_size);
+		if (ret) {
+			pr_err("Failed to read fences %p %d",
+				fences, fence_size);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
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
+int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct
+				     d3dkmt_waitforsynchronizationobjectfromcpu
+				     *args,
+				     u64 cpu_event)
+{
+	int ret = -EINVAL;
+	struct dxgkvmb_command_waitforsyncobjectfromcpu *command;
+	u32 object_size = args->object_count * sizeof(struct d3dkmthandle);
+	u32 fence_size = args->object_count * sizeof(u64);
+	u8 *current_pos;
+	u32 cmd_size = sizeof(*command) + object_size + fence_size;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMCPU,
+				   process->host_handle);
+	command->device = args->device;
+	command->flags = args->flags;
+	command->object_count = args->object_count;
+	command->guest_event_pointer = (u64) cpu_event;
+	current_pos = (u8 *) &command[1];
+	ret = copy_from_user(current_pos, args->objects, object_size);
+	if (ret) {
+		pr_err("%s failed to copy objects", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	current_pos += object_size;
+	ret = copy_from_user(current_pos, args->fence_values, fence_size);
+	if (ret) {
+		pr_err("%s failed to copy fences", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_wait_sync_object_gpu(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmthandle context,
+				     u32 object_count,
+				     struct d3dkmthandle *objects,
+				     u64 *fences,
+				     bool legacy_fence)
+{
+	int ret;
+	struct dxgkvmb_command_waitforsyncobjectfromgpu *command;
+	u32 fence_size = object_count * sizeof(u64);
+	u32 object_size = object_count * sizeof(struct d3dkmthandle);
+	u8 *current_pos;
+	u32 cmd_size = object_size + fence_size - sizeof(u64) +
+	    sizeof(struct dxgkvmb_command_waitforsyncobjectfromgpu);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (object_count == 0 || object_count > D3DDDI_MAX_OBJECT_WAITED_ON) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMGPU,
+				   process->host_handle);
+	command->context = context;
+	command->object_count = object_count;
+	command->legacy_fence_object = legacy_fence;
+	current_pos = (u8 *) command->fence_values;
+	memcpy(current_pos, fences, fence_size);
+	current_pos += fence_size;
+	memcpy(current_pos, objects, object_size);
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
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args)
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 79dc22379ec4..f484b0da702c 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1473,6 +1473,828 @@ dxgk_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_createsynchronizationobject2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct eventfd_ctx *event = NULL;
+	struct dxgsyncobject *syncobj = NULL;
+	bool device_lock_acquired = false;
+	struct dxgsharedsyncobject *syncobjgbl = NULL;
+	struct dxghosteventcpu *host_event = NULL;
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
+	if (args.info.type == _D3DDDI_CPU_NOTIFICATION) {
+		event = eventfd_ctx_fdget((int)
+					  args.info.cpu_notification.event);
+		if (IS_ERR(event)) {
+			pr_err("failed to reference the event");
+			event = NULL;
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		host_event = syncobj->host_event;
+		host_event->hdr.event_id = dxgglobal_new_host_event_id();
+		host_event->cpu_event = event;
+		host_event->remove_from_list = false;
+		host_event->destroy_after_signal = false;
+		host_event->hdr.event_type = dxghostevent_cpu_event;
+		dxgglobal_add_host_event(&host_event->hdr);
+		args.info.cpu_notification.event = host_event->hdr.event_id;
+		dev_dbg(dxgglobaldev, "creating CPU notification event: %lld",
+			args.info.cpu_notification.event);
+	}
+
+	ret = dxgvmb_send_create_sync_object(process, adapter, &args, syncobj);
+	if (ret < 0)
+		goto cleanup;
+
+	if (args.info.flags.shared) {
+		if (args.info.shared_handle.v == 0) {
+			pr_err("shared handle should not be 0");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		syncobjgbl = dxgsharedsyncobj_create(device->adapter, syncobj);
+		if (syncobjgbl == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		dxgsharedsyncobj_add_syncobj(syncobjgbl, syncobj);
+
+		syncobjgbl->host_shared_handle = args.info.shared_handle;
+	}
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
+			event = NULL;
+		}
+		if (event)
+			eventfd_ctx_put(event);
+	}
+	if (syncobjgbl)
+		kref_put(&syncobjgbl->ssyncobj_kref, dxgsharedsyncobj_release);
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device_lock_acquired)
+		dxgdevice_release_lock_shared(device);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
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
+	dev_dbg(dxgglobaldev, "handle 0x%x", args.sync_object.v);
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	syncobj = hmgrtable_get_object_by_type(&process->handle_table,
+					       HMGRENTRY_TYPE_DXGSYNCOBJECT,
+					       args.sync_object);
+	if (syncobj) {
+		dev_dbg(dxgglobaldev, "syncobj 0x%p", syncobj);
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
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_signal_sync_object(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_signalsynchronizationobject2 args;
+	struct d3dkmt_signalsynchronizationobject2 *__user in_args = inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int ret;
+	u32 fence_count = 1;
+	struct eventfd_ctx *event = NULL;
+	struct dxghosteventcpu *host_event = NULL;
+	bool host_event_added = false;
+	u64 host_event_id = 0;
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
+	if (args.context_count >= D3DDDI_MAX_BROADCAST_CONTEXT ||
+	    args.object_count > D3DDDI_MAX_OBJECT_SIGNALED) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.flags.enqueue_cpu_event) {
+		host_event = vzalloc(sizeof(*host_event));
+		if (host_event == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		host_event->process = process;
+		event = eventfd_ctx_fdget((int)args.cpu_event_handle);
+		if (IS_ERR(event)) {
+			pr_err("failed to reference the event");
+			event = NULL;
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		fence_count = 0;
+		host_event->cpu_event = event;
+		host_event_id = dxgglobal_new_host_event_id();
+		host_event->hdr.event_type = dxghostevent_cpu_event;
+		host_event->hdr.event_id = host_event_id;
+		host_event->remove_from_list = true;
+		host_event->destroy_after_signal = true;
+		dxgglobal_add_host_event(&host_event->hdr);
+		host_event_added = true;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    args.context);
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
+					     args.flags, args.fence.fence_value,
+					     args.context, args.object_count,
+					     in_args->object_array,
+					     args.context_count,
+					     in_args->contexts, fence_count,
+					     NULL, (void *)host_event_id,
+					     zerohandle);
+
+	/*
+	 * When the send operation succeeds, the host event will be destroyed
+	 * after signal from the host
+	 */
+
+cleanup:
+
+	if (ret < 0) {
+		if (host_event_added) {
+			/* The event might be signaled and destroyed by host */
+			host_event = (struct dxghosteventcpu *)
+				dxgglobal_get_host_event(host_event_id);
+			if (host_event) {
+				eventfd_ctx_put(event);
+				event = NULL;
+				vfree(host_event);
+				host_event = NULL;
+			}
+		}
+		if (event)
+			eventfd_ctx_put(event);
+		if (host_event)
+			vfree(host_event);
+	}
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
+dxgk_signal_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_signalsynchronizationobjectfromcpu args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (args.object_count == 0 ||
+	    args.object_count > D3DDDI_MAX_OBJECT_SIGNALED) {
+		dev_dbg(dxgglobaldev, "Too many objects: %d",
+			args.object_count);
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
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_signal_sync_object(process, adapter,
+					     args.flags, 0, zerohandle,
+					     args.object_count, args.objects, 0,
+					     NULL, args.object_count,
+					     args.fence_values, NULL,
+					     args.device);
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
+dxgk_signal_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_signalsynchronizationobjectfromgpu args;
+	struct d3dkmt_signalsynchronizationobjectfromgpu *__user user_args =
+	    inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dddicb_signalflags flags = { };
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.object_count == 0 ||
+	    args.object_count > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    args.context);
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
+					     flags, 0, zerohandle,
+					     args.object_count,
+					     args.objects, 1,
+					     &user_args->context,
+					     args.object_count,
+					     args.monitored_fence_values, NULL,
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
+dxgk_signal_sync_object_gpu2(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_signalsynchronizationobjectfromgpu2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmthandle context_handle;
+	struct eventfd_ctx *event = NULL;
+	u64 *fences = NULL;
+	u32 fence_count = 0;
+	int ret;
+	struct dxghosteventcpu *host_event = NULL;
+	bool host_event_added = false;
+	u64 host_event_id = 0;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.flags.enqueue_cpu_event) {
+		if (args.object_count != 0 || args.cpu_event_handle == 0) {
+			pr_err("Bad input for EnqueueCpuEvent: %d %lld",
+				   args.object_count, args.cpu_event_handle);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	} else if (args.object_count == 0 ||
+		   args.object_count > DXG_MAX_VM_BUS_PACKET_SIZE ||
+		   args.context_count == 0 ||
+		   args.context_count > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("Invalid input: %d %d",
+			   args.object_count, args.context_count);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = copy_from_user(&context_handle, args.contexts,
+			     sizeof(struct d3dkmthandle));
+	if (ret) {
+		pr_err("%s failed to copy context handle", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.flags.enqueue_cpu_event) {
+		host_event = vzalloc(sizeof(*host_event));
+		if (host_event == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		host_event->process = process;
+		event = eventfd_ctx_fdget((int)args.cpu_event_handle);
+		if (IS_ERR(event)) {
+			pr_err("failed to reference the event");
+			event = NULL;
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		fence_count = 0;
+		host_event->cpu_event = event;
+		host_event_id = dxgglobal_new_host_event_id();
+		host_event->hdr.event_id = host_event_id;
+		host_event->hdr.event_type = dxghostevent_cpu_event;
+		host_event->remove_from_list = true;
+		host_event->destroy_after_signal = true;
+		dxgglobal_add_host_event(&host_event->hdr);
+		host_event_added = true;
+	} else {
+		fences = args.monitored_fence_values;
+		fence_count = args.object_count;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    context_handle);
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
+					     args.context_count, args.contexts,
+					     fence_count, fences,
+					     (void *)host_event_id, zerohandle);
+
+cleanup:
+
+	if (ret < 0) {
+		if (host_event_added) {
+			/* The event might be signaled and destroyed by host */
+			host_event = (struct dxghosteventcpu *)
+				dxgglobal_get_host_event(host_event_id);
+			if (host_event) {
+				eventfd_ctx_put(event);
+				event = NULL;
+				vfree(host_event);
+				host_event = NULL;
+			}
+		}
+		if (event)
+			eventfd_ctx_put(event);
+		if (host_event)
+			vfree(host_event);
+	}
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
+dxgk_wait_sync_object(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_waitforsynchronizationobject2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int ret;
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
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    args.context);
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
+	dev_dbg(dxgglobaldev, "Fence value: %lld", args.fence.fence_value);
+	ret = dxgvmb_send_wait_sync_object_gpu(process, adapter,
+					       args.context, args.object_count,
+					       args.object_array,
+					       &args.fence.fence_value, true);
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
+dxgk_wait_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_waitforsynchronizationobjectfromcpu args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct eventfd_ctx *event = NULL;
+	struct dxghosteventcpu host_event = { };
+	struct dxghosteventcpu *async_host_event = NULL;
+	struct completion local_event = { };
+	u64 event_id = 0;
+	int ret;
+	bool host_event_added = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.object_count > DXG_MAX_VM_BUS_PACKET_SIZE ||
+	    args.object_count == 0) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.async_event) {
+		async_host_event = vzalloc(sizeof(*async_host_event));
+		if (async_host_event == NULL) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		async_host_event->process = process;
+		event = eventfd_ctx_fdget((int)args.async_event);
+		if (IS_ERR(event)) {
+			pr_err("failed to reference the event");
+			event = NULL;
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		async_host_event->cpu_event = event;
+		async_host_event->hdr.event_id = dxgglobal_new_host_event_id();
+		async_host_event->destroy_after_signal = true;
+		async_host_event->hdr.event_type = dxghostevent_cpu_event;
+		dxgglobal_add_host_event(&async_host_event->hdr);
+		event_id = async_host_event->hdr.event_id;
+		host_event_added = true;
+	} else {
+		init_completion(&local_event);
+		host_event.completion_event = &local_event;
+		host_event.hdr.event_id = dxgglobal_new_host_event_id();
+		host_event.hdr.event_type = dxghostevent_cpu_event;
+		dxgglobal_add_host_event(&host_event.hdr);
+		event_id = host_event.hdr.event_id;
+	}
+
+	device = dxgprocess_device_by_handle(process, args.device);
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
+	ret = dxgvmb_send_wait_sync_object_cpu(process, adapter,
+					       &args, event_id);
+	if (ret < 0)
+		goto cleanup;
+
+	if (args.async_event == 0) {
+		dxgadapter_release_lock_shared(adapter);
+		adapter = NULL;
+		ret = wait_for_completion_killable(&local_event);
+		if (ret)
+			pr_err("%s: wait_for_completion_killable failed: %d",
+			       __func__, ret);
+	}
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	if (host_event.hdr.event_id)
+		dxgglobal_remove_host_event(&host_event.hdr);
+	if (ret < 0) {
+		if (host_event_added) {
+			async_host_event = (struct dxghosteventcpu *)
+				dxgglobal_get_host_event(event_id);
+			if (async_host_event) {
+				if (async_host_event->hdr.event_type ==
+				    dxghostevent_cpu_event) {
+					eventfd_ctx_put(event);
+					event = NULL;
+					vfree(async_host_event);
+					async_host_event = NULL;
+				} else {
+					pr_err("Invalid event type");
+					DXGKRNL_ASSERT(0);
+				}
+			}
+		}
+		if (event)
+			eventfd_ctx_put(event);
+		if (async_host_event)
+			vfree(async_host_event);
+	}
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_waitforsynchronizationobjectfromgpu args;
+	struct dxgcontext *context = NULL;
+	struct d3dkmthandle device_handle = {};
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct dxgsyncobject *syncobj = NULL;
+	struct d3dkmthandle *objects = NULL;
+	u32 object_size;
+	u64 *fences = NULL;
+	int ret;
+	enum hmgrentry_type syncobj_type = HMGRENTRY_TYPE_FREE;
+	bool monitored_fence = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.object_count > DXG_MAX_VM_BUS_PACKET_SIZE ||
+	    args.object_count == 0) {
+		pr_err("Invalid object count: %d", args.object_count);
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
+	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
+	context = hmgrtable_get_object_by_type(&process->handle_table,
+					       HMGRENTRY_TYPE_DXGCONTEXT,
+					       args.context);
+	if (context) {
+		device_handle = context->device_handle;
+		syncobj_type =
+		    hmgrtable_get_object_type(&process->handle_table,
+					      objects[0]);
+	}
+	if (device_handle.v == 0) {
+		pr_err("Invalid context handle: %x", args.context.v);
+		ret = -EINVAL;
+	} else {
+		if (syncobj_type == HMGRENTRY_TYPE_MONITOREDFENCE) {
+			monitored_fence = true;
+		} else if (syncobj_type == HMGRENTRY_TYPE_DXGSYNCOBJECT) {
+			syncobj =
+			    hmgrtable_get_object_by_type(&process->handle_table,
+						HMGRENTRY_TYPE_DXGSYNCOBJECT,
+						objects[0]);
+			if (syncobj == NULL) {
+				pr_err("Invalid syncobj: %x", objects[0].v);
+				ret = -EINVAL;
+			} else {
+				monitored_fence = syncobj->monitored_fence;
+			}
+		} else {
+			pr_err("Invalid syncobj type: %x", objects[0].v);
+			ret = -EINVAL;
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_SHARED);
+
+	if (ret < 0)
+		goto cleanup;
+
+	if (monitored_fence) {
+		object_size = sizeof(u64) * args.object_count;
+		fences = vzalloc(object_size);
+		if (fences == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		ret = copy_from_user(fences, args.monitored_fence_values,
+				     object_size);
+		if (ret) {
+			pr_err("%s failed to copy fences", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		fences = &args.fence_value;
+	}
+
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
+	ret = dxgvmb_send_wait_sync_object_gpu(process, adapter,
+					       args.context, args.object_count,
+					       objects, fences,
+					       !monitored_fence);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	if (objects)
+		vfree(objects);
+	if (fences && fences != &args.fence_value)
+		vfree(fences);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_render(struct dxgprocess *process, void *__user inargs)
 {
@@ -1565,6 +2387,12 @@ void init_ioctls(void)
 		  LX_DXCREATEALLOCATION);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
+	SET_IOCTL(/*0x10 */ dxgk_create_sync_object,
+		  LX_DXCREATESYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x11 */ dxgk_signal_sync_object,
+		  LX_DXSIGNALSYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x12 */ dxgk_wait_sync_object,
+		  LX_DXWAITFORSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x13 */ dxgk_destroy_allocation,
 		  LX_DXDESTROYALLOCATION2);
 	SET_IOCTL(/*0x14 */ dxgk_enum_adapters,
@@ -1577,10 +2405,22 @@ void init_ioctls(void)
 		  LX_DXDESTROYDEVICE);
 	SET_IOCTL(/*0x1a */ dxgk_destroy_hwcontext,
 		  LX_DXDESTROYHWCONTEXT);
+	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
+		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x23 */ dxgk_get_shared_resource_adapter_luid,
 		  LX_DXGETSHAREDRESOURCEADAPTERLUID);
 	SET_IOCTL(/*0x2d */ dxgk_render,
 		  LX_DXRENDER);
+	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
+		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU);
+	SET_IOCTL(/*0x32 */ dxgk_signal_sync_object_gpu,
+		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU);
+	SET_IOCTL(/*0x33 */ dxgk_signal_sync_object_gpu2,
+		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2);
+	SET_IOCTL(/*0x3a */ dxgk_wait_sync_object_cpu,
+		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU);
+	SET_IOCTL(/*0x3b */ dxgk_wait_sync_object_gpu,
+		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU);
 	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
 		  LX_DXENUMADAPTERS3);
 }
-- 
2.32.0

