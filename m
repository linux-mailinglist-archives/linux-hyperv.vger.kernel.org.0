Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801674AA5CB
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378981AbiBECeZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:25 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45108 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378997AbiBECeY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:24 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0122A20B8013;
        Fri,  4 Feb 2022 18:34:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0122A20B8013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028464;
        bh=CMdGZRlhMdcOXOPZIsWCIf52c+KFQSKTAraiwATUkKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RGpaGCGayIqJ7ASKvX5EUinTct7+MBtR1jfVeGTHWvtjbvPWO3xfNFTiKDuuF7gIf
         2gPQNZK6OwX1kkCOtWEsFjfRNoL6yICVQQppf61od/tIeyQKXcyBh1IbTKeNJ7Lzuj
         CTFwFbUoHphZaehqgKaeyXHul3FTR3s5/irOK6fQ=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 04/24] drivers: hv: dxgkrnl: Creation of dxgdevice
Date:   Fri,  4 Feb 2022 18:34:02 -0800
Message-Id: <3cd773385baf50fba168d3c293363cd4584ad77c.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A dxgdevice object represents a container of GPU allocations,
GPU sync objects, GPU contexts, etc. It belongs to a dxgadapter
object.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 183 ++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  52 +++++++++
 drivers/hv/dxgkrnl/dxgprocess.c |  43 ++++++++
 drivers/hv/dxgkrnl/dxgvmbus.c   |  54 ++++++++++
 drivers/hv/dxgkrnl/ioctl.c      | 134 +++++++++++++++++++++++
 drivers/hv/dxgkrnl/misc.h       |   1 +
 6 files changed, 467 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 2c7823713547..c7e1dc55de49 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -199,6 +199,120 @@ void dxgadapter_release_lock_shared(struct dxgadapter *adapter)
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
+		init_rwsem(&device->device_lock);
+		INIT_LIST_HEAD(&device->pqueue_list_head);
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
+	pr_debug("%s: %p\n", __func__, device);
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
+	pr_debug("dxgdevice_destroy_end\n");
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
+void dxgdevice_release(struct kref *refcount)
+{
+	struct dxgdevice *device;
+
+	device = container_of(refcount, struct dxgdevice, device_kref);
+	vfree(device);
+}
+
 struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 						     struct dxgadapter *adapter)
 {
@@ -213,6 +327,8 @@ struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 		adapter_info->adapter = adapter;
 		adapter_info->process = process;
 		adapter_info->refcount = 1;
+		mutex_init(&adapter_info->device_list_mutex);
+		INIT_LIST_HEAD(&adapter_info->device_list_head);
 		list_add_tail(&adapter_info->process_adapter_list_entry,
 			      &process->process_adapter_list_head);
 		dxgadapter_add_process(adapter, adapter_info);
@@ -226,10 +342,32 @@ struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 
 void dxgprocess_adapter_stop(struct dxgprocess_adapter *adapter_info)
 {
+	struct dxgdevice *device;
+
+	mutex_lock(&adapter_info->device_list_mutex);
+	list_for_each_entry(device, &adapter_info->device_list_head,
+			    device_list_entry) {
+		dxgdevice_stop(device);
+	}
+	mutex_unlock(&adapter_info->device_list_mutex);
 }
 
 void dxgprocess_adapter_destroy(struct dxgprocess_adapter *adapter_info)
 {
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
 	dxgadapter_remove_process(adapter_info);
 	kref_put(&adapter_info->adapter->adapter_kref, dxgadapter_release);
 	list_del(&adapter_info->process_adapter_list_entry);
@@ -247,3 +385,48 @@ void dxgprocess_adapter_release(struct dxgprocess_adapter *adapter_info)
 	if (adapter_info->refcount == 0)
 		dxgprocess_adapter_destroy(adapter_info);
 }
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
+	pr_debug("%s %p\n", __func__, device);
+	mutex_lock(&device->adapter_info->device_list_mutex);
+	if (device->device_list_entry.next) {
+		list_del(&device->device_list_entry);
+		device->device_list_entry.next = NULL;
+	}
+	mutex_unlock(&device->adapter_info->device_list_mutex);
+}
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index fbc15731cbd5..e0a433c36a06 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -29,6 +29,7 @@
 
 struct dxgprocess;
 struct dxgadapter;
+struct dxgdevice;
 
 #include "misc.h"
 #include "hmgr.h"
@@ -152,6 +153,9 @@ struct dxgprocess_adapter {
 	struct list_head	adapter_process_list_entry;
 	/* Entry in dxgprocess::process_adapter_list_head */
 	struct list_head	process_adapter_list_entry;
+	/* List of all dxgdevice objects created for the process on adapter */
+	struct list_head	device_list_head;
+	struct mutex		device_list_mutex;
 	struct dxgadapter	*adapter;
 	struct dxgprocess	*process;
 	int			refcount;
@@ -161,6 +165,10 @@ struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 						     struct dxgadapter
 						     *adapter);
 void dxgprocess_adapter_release(struct dxgprocess_adapter *adapter);
+int dxgprocess_adapter_add_device(struct dxgprocess *process,
+					      struct dxgadapter *adapter,
+					      struct dxgdevice *device);
+void dxgprocess_adapter_remove_device(struct dxgdevice *device);
 void dxgprocess_adapter_stop(struct dxgprocess_adapter *adapter_info);
 void dxgprocess_adapter_destroy(struct dxgprocess_adapter *adapter_info);
 
@@ -209,6 +217,11 @@ struct dxgadapter *dxgprocess_get_adapter(struct dxgprocess *process,
 					  struct d3dkmthandle handle);
 struct dxgadapter *dxgprocess_adapter_by_handle(struct dxgprocess *process,
 						struct d3dkmthandle handle);
+struct dxgdevice *dxgprocess_device_by_handle(struct dxgprocess *process,
+					      struct d3dkmthandle handle);
+struct dxgdevice *dxgprocess_device_by_object_handle(struct dxgprocess *process,
+						     enum hmgrentry_type t,
+						     struct d3dkmthandle h);
 void dxgprocess_ht_lock_shared_down(struct dxgprocess *process);
 void dxgprocess_ht_lock_shared_up(struct dxgprocess *process);
 void dxgprocess_ht_lock_exclusive_down(struct dxgprocess *process);
@@ -228,6 +241,7 @@ enum dxgadapter_state {
  * This object represents the grapchis adapter.
  * Objects, which take reference on the adapter:
  * - dxgglobal
+ * - dxgdevice
  * - adapter handle (struct d3dkmthandle)
  */
 struct dxgadapter {
@@ -264,6 +278,38 @@ void dxgadapter_add_process(struct dxgadapter *adapter,
 			    struct dxgprocess_adapter *process_info);
 void dxgadapter_remove_process(struct dxgprocess_adapter *process_info);
 
+/*
+ * The object represent the device object.
+ * The following objects take reference on the device
+ * - device handle (struct d3dkmthandle)
+ */
+struct dxgdevice {
+	enum dxgobjectstate	object_state;
+	/* Device takes reference on the adapter */
+	struct dxgadapter	*adapter;
+	struct dxgprocess_adapter *adapter_info;
+	struct dxgprocess	*process;
+	/* Entry in the DGXPROCESS_ADAPTER device list */
+	struct list_head	device_list_entry;
+	struct kref		device_kref;
+	/* Protects destcruction of the device object */
+	struct rw_semaphore	device_lock;
+	/* List of paging queues. Protected by process handle table lock. */
+	struct list_head	pqueue_list_head;
+	struct d3dkmthandle	handle;
+	enum d3dkmt_deviceexecution_state execution_state;
+	u32			handle_valid;
+};
+
+struct dxgdevice *dxgdevice_create(struct dxgadapter *a, struct dxgprocess *p);
+void dxgdevice_destroy(struct dxgdevice *device);
+void dxgdevice_stop(struct dxgdevice *device);
+void dxgdevice_mark_destroyed(struct dxgdevice *device);
+int dxgdevice_acquire_lock_shared(struct dxgdevice *dev);
+void dxgdevice_release_lock_shared(struct dxgdevice *dev);
+void dxgdevice_release(struct kref *refcount);
+bool dxgdevice_is_active(struct dxgdevice *dev);
+
 void init_ioctls(void);
 long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
@@ -297,6 +343,12 @@ int dxgvmb_send_destroy_process(struct d3dkmthandle process);
 int dxgvmb_send_open_adapter(struct dxgadapter *adapter);
 int dxgvmb_send_close_adapter(struct dxgadapter *adapter);
 int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter);
+struct d3dkmthandle dxgvmb_send_create_device(struct dxgadapter *adapter,
+					      struct dxgprocess *process,
+					      struct d3dkmt_createdevice *args);
+int dxgvmb_send_destroy_device(struct dxgadapter *adapter,
+			       struct dxgprocess *process,
+			       struct d3dkmthandle h);
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index 1fd7b7659792..734585689213 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -242,6 +242,49 @@ struct dxgadapter *dxgprocess_adapter_by_handle(struct dxgprocess *process,
 	return adapter;
 }
 
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
 void dxgprocess_ht_lock_shared_down(struct dxgprocess *process)
 {
 	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 8b8e0aa0fa5d..5b560754ac0d 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -656,6 +656,60 @@ int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter)
 	return ret;
 }
 
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
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		result.device.v = 0;
+	free_message(&msg, process);
+cleanup:
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
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
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args)
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 62a958f6f146..a6be88b6c792 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -437,6 +437,136 @@ dxgk_query_adapter_info(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
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
+	pr_debug("ioctl: %s", __func__);
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 /*
  * IOCTL processing
  * The driver IOCTLs return
@@ -495,12 +625,16 @@ void init_ioctls(void)
 {
 	SET_IOCTL(/*0x1 */ dxgk_open_adapter_from_luid,
 		  LX_DXOPENADAPTERFROMLUID);
+	SET_IOCTL(/*0x2 */ dxgk_create_device,
+		  LX_DXCREATEDEVICE);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
 	SET_IOCTL(/*0x14 */ dxgk_enum_adapters,
 		  LX_DXENUMADAPTERS2);
 	SET_IOCTL(/*0x15 */ dxgk_close_adapter,
 		  LX_DXCLOSEADAPTER);
+	SET_IOCTL(/*0x19 */ dxgk_destroy_device,
+		  LX_DXDESTROYDEVICE);
 	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
 		  LX_DXENUMADAPTERS3);
 }
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index d00e7cc00470..8948f48ec9dc 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -25,6 +25,7 @@ extern const struct d3dkmthandle zerohandle;
  * The higher enum value, the higher is the lock order.
  * When a lower lock ois held, the higher lock should not be acquired.
  *
+ * device_list_mutex
  * channel_lock
  * fd_mutex
  * plistmutex
-- 
2.35.1

