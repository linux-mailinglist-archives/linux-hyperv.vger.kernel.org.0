Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE5D4C94D6
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiCATr0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbiCATrT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:19 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61B546D38D;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 78CF720B4901;
        Tue,  1 Mar 2022 11:46:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 78CF720B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163992;
        bh=fWknQwFPjgMxfpsE9Ph6Hs3u0X091tpmY8nFZfHjlVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WI6N4nqq0Dpdah0WguZa7vFkdCK0CG9pLsoApfrWYYUuc6/Ppc0KuhEdEhuoMVqk/
         dGK0y16m8zbn6U+AZ63V1U8etu7JITvmIu8Xpz+6z/tzUhMDayGNdRXo3Kd0ZGZFBT
         gVUn0cCTu3Mxndry8W8AyzM/JaxZ8ud7F8pSUH6s=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 13/30] drivers: hv: dxgkrnl: Sharing of sync objects
Date:   Tue,  1 Mar 2022 11:46:00 -0800
Message-Id: <ec25408b0276c5ca53dd0f51c09622c03772f25f.1646163378.git.iourit@linux.microsoft.com>
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

Implement creation of a shared sync objects and the ioctl for sharing
dxgsyncobject objects between processes in the virtual machine.

Sync objects are shared using file descriptor (FD) handles.
The name "NT handle" is used to be compatible with Windows implementation.

An FD handle is created by the LX_DXSHAREOBJECTS ioctl. The created FD
handle could be sent to another process using any Linux API.

To use a shared sync object in other ioctls, the object needs to be
opened using its FD handle. A sync object is opened by the
LX_DXOPENSYNCOBJECTFROMNTHANDLE2 ioctl, which returns a d3dkmthandle
value.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  83 +++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  63 +++++++++
 drivers/hv/dxgkrnl/dxgmodule.c  |   1 +
 drivers/hv/dxgkrnl/dxgvmbus.c   |  63 +++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  15 ++
 drivers/hv/dxgkrnl/ioctl.c      | 240 ++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h    |  20 +++
 7 files changed, 485 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 48a39805944b..cb5575cdc308 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -176,6 +176,26 @@ void dxgadapter_remove_shared_resource(struct dxgadapter *adapter,
 	up_write(&adapter->shared_resource_list_lock);
 }
 
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
 void dxgadapter_add_syncobj(struct dxgadapter *adapter,
 			    struct dxgsyncobject *object)
 {
@@ -956,6 +976,63 @@ void dxgprocess_adapter_remove_device(struct dxgdevice *device)
 	mutex_unlock(&device->adapter_info->device_list_mutex);
 }
 
+struct dxgsharedsyncobject *dxgsharedsyncobj_create(struct dxgadapter *adapter,
+						    struct dxgsyncobject *so)
+{
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
+}
+
+void dxgsharedsyncobj_release(struct kref *refcount)
+{
+	struct dxgsharedsyncobject *syncobj;
+
+	syncobj = container_of(refcount, struct dxgsharedsyncobject,
+			       ssyncobj_kref);
+	pr_debug("Destroying shared sync object %p", syncobj);
+	if (syncobj->adapter) {
+		dxgadapter_remove_shared_syncobj(syncobj->adapter,
+							syncobj);
+		kref_put(&syncobj->adapter->adapter_kref,
+				dxgadapter_release);
+	}
+	vfree(syncobj);
+}
+
+void dxgsharedsyncobj_add_syncobj(struct dxgsharedsyncobject *shared,
+				  struct dxgsyncobject *syncobj)
+{
+	pr_debug("%s 0x%p 0x%p", __func__, shared, syncobj);
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
+	pr_debug("%s 0x%p", __func__, shared);
+	down_write(&shared->syncobj_list_lock);
+	list_del(&syncobj->shared_syncobj_list_entry);
+	up_write(&shared->syncobj_list_lock);
+}
+
 struct dxgsyncobject *dxgsyncobject_create(struct dxgprocess *process,
 					   struct dxgdevice *device,
 					   struct dxgadapter *adapter,
@@ -1090,6 +1167,12 @@ void dxgsyncobject_release(struct kref *refcount)
 	struct dxgsyncobject *syncobj;
 
 	syncobj = container_of(refcount, struct dxgsyncobject, syncobj_kref);
+	if (syncobj->shared_owner) {
+		dxgsharedsyncobj_remove_syncobj(syncobj->shared_owner,
+						syncobj);
+		kref_put(&syncobj->shared_owner->ssyncobj_kref,
+			 dxgsharedsyncobj_release);
+	}
 	if (syncobj->host_event)
 		vfree(syncobj->host_event);
 	vfree(syncobj);
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index bad69cf4dfd7..15cacdd43dee 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -35,6 +35,7 @@ struct dxgallocation;
 struct dxgresource;
 struct dxgsharedresource;
 struct dxgsyncobject;
+struct dxgsharedsyncobject;
 
 #include "misc.h"
 #include "hmgr.h"
@@ -122,6 +123,18 @@ struct dxghosteventcpu {
  * "device" syncobject, because the belong to a device (dxgdevice).
  * Device syncobjects are inserted to a list in dxgdevice.
  *
+ * A syncobject can be "shared", meaning that it could be opened by many
+ * processes.
+ *
+ * Shared syncobjects are inserted to a list in its owner
+ * (dxgsharedsyncobject).
+ * A syncobject can be shared by using a global handle or by using
+ * "NT security handle".
+ * When global handle sharing is used, the handle is created durinig object
+ * creation.
+ * When "NT security" is used, the handle for sharing is create be calling
+ * dxgk_share_objects. On Linux "NT handle" is represented by a file
+ * descriptor. FD points to dxgsharedsyncobject.
  */
 struct dxgsyncobject {
 	struct kref			syncobj_kref;
@@ -131,6 +144,8 @@ struct dxgsyncobject {
 	 * List entry in dxgadapter for other objects
 	 */
 	struct list_head		syncobj_list_entry;
+	/* List entry in the dxgsharedsyncobject object for shared synobjects */
+	struct list_head		shared_syncobj_list_entry;
 	/* Adapter, the syncobject belongs to. NULL for stopped sync obejcts. */
 	struct dxgadapter		*adapter;
 	/*
@@ -141,6 +156,8 @@ struct dxgsyncobject {
 	struct dxgprocess		*process;
 	/* Used by D3DDDI_CPU_NOTIFICATION objects */
 	struct dxghosteventcpu		*host_event;
+	/* Owner object for shared syncobjects */
+	struct dxgsharedsyncobject	*shared_owner;
 	/* CPU virtual address of the fence value for "device" syncobjects */
 	void				*mapped_address;
 	/* Handle in the process handle table */
@@ -172,6 +189,41 @@ struct dxgvgpuchannel {
 	struct hv_device	*hdev;
 };
 
+/*
+ * The object is used as parent of all sync objects, created for a shared
+ * syncobject. When a shared syncobject is created without NT security, the
+ * handle in the global handle table will point to this object.
+ */
+struct dxgsharedsyncobject {
+	struct kref			ssyncobj_kref;
+	/* Referenced by file descriptors */
+	int				host_shared_handle_nt_reference;
+	/* Corresponding handle in the host global handle table */
+	struct d3dkmthandle		host_shared_handle;
+	/*
+	 * When the sync object is shared by NT handle, this is the
+	 * corresponding handle in the host
+	 */
+	struct d3dkmthandle		host_shared_handle_nt;
+	/* Protects access to host_shared_handle_nt */
+	struct mutex			fd_mutex;
+	struct rw_semaphore		syncobj_list_lock;
+	struct list_head		shared_syncobj_list_head;
+	struct list_head		adapter_shared_syncobj_list_entry;
+	struct dxgadapter		*adapter;
+	enum d3dddi_synchronizationobject_type type;
+	u32				monitored_fence:1;
+};
+
+struct dxgsharedsyncobject *dxgsharedsyncobj_create(struct dxgadapter *adapter,
+						    struct dxgsyncobject
+						    *syncobj);
+void dxgsharedsyncobj_release(struct kref *refcount);
+void dxgsharedsyncobj_add_syncobj(struct dxgsharedsyncobject *sharedsyncobj,
+				  struct dxgsyncobject *syncobj);
+void dxgsharedsyncobj_remove_syncobj(struct dxgsharedsyncobject *sharedsyncobj,
+				     struct dxgsyncobject *syncobj);
+
 struct dxgsyncobject *dxgsyncobject_create(struct dxgprocess *process,
 					   struct dxgdevice *device,
 					   struct dxgadapter *adapter,
@@ -362,6 +414,8 @@ struct dxgadapter {
 	struct list_head	adapter_process_list_head;
 	/* List of all dxgsharedresource objects */
 	struct list_head	shared_resource_list_head;
+	/* List of all dxgsharedsyncobject objects */
+	struct list_head	adapter_shared_syncobj_list_head;
 	/* List of all non-device dxgsyncobject objects */
 	struct list_head	syncobj_list_head;
 	/* This lock protects shared resource and syncobject lists */
@@ -389,6 +443,10 @@ void dxgadapter_release_lock_shared(struct dxgadapter *adapter);
 int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter);
 void dxgadapter_acquire_lock_forced(struct dxgadapter *adapter);
 void dxgadapter_release_lock_exclusive(struct dxgadapter *adapter);
+void dxgadapter_add_shared_syncobj(struct dxgadapter *adapter,
+				   struct dxgsharedsyncobject *so);
+void dxgadapter_remove_shared_syncobj(struct dxgadapter *adapter,
+				      struct dxgsharedsyncobject *so);
 void dxgadapter_add_syncobj(struct dxgadapter *adapter,
 			    struct dxgsyncobject *so);
 void dxgadapter_remove_syncobj(struct dxgsyncobject *so);
@@ -703,6 +761,11 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
+int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
+				    struct dxgvmbuschannel *channel,
+				    struct d3dkmt_opensyncobjectfromnthandle2
+				    *args,
+				    struct dxgsyncobject *syncobj);
 int dxgvmb_send_create_nt_shared_object(struct dxgprocess *process,
 					struct d3dkmthandle object,
 					struct d3dkmthandle *shared_handle);
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 7ccf76c6ad9b..cfef880a512d 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -251,6 +251,7 @@ int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
 
 	INIT_LIST_HEAD(&adapter->adapter_process_list_head);
 	INIT_LIST_HEAD(&adapter->shared_resource_list_head);
+	INIT_LIST_HEAD(&adapter->adapter_shared_syncobj_list_head);
 	INIT_LIST_HEAD(&adapter->syncobj_list_head);
 	init_rwsem(&adapter->shared_resource_list_lock);
 	adapter->pci_dev = dev;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index b6b072b189ff..e159b9e70e1c 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -705,6 +705,69 @@ int dxgvmb_send_destroy_process(struct d3dkmthandle process)
 	return ret;
 }
 
+int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
+				    struct dxgvmbuschannel *channel,
+				    struct d3dkmt_opensyncobjectfromnthandle2
+				    *args,
+				    struct dxgsyncobject *syncobj)
+{
+	struct dxgkvmb_command_opensyncobject *command;
+	struct dxgkvmb_command_opensyncobject_return result = { };
+	int ret;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, process, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vm_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_OPENSYNCOBJECT,
+				 process->host_handle);
+	command->device = args->device;
+	command->global_sync_object = syncobj->shared_owner->host_shared_handle;
+	command->flags = args->flags;
+	if (syncobj->monitored_fence)
+		command->engine_affinity =
+			args->monitored_fence.engine_affinity;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_sync_msg(channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+
+	dxgglobal_release_channel_lock();
+
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result.status);
+	if (ret < 0)
+		goto cleanup;
+
+	args->sync_object = result.sync_object;
+	if (syncobj->monitored_fence) {
+		void *va = dxg_map_iospace(result.guest_cpu_physical_address,
+					   PAGE_SIZE, PROT_READ | PROT_WRITE,
+					   true);
+		if (va == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		args->monitored_fence.fence_value_cpu_va = va;
+		args->monitored_fence.fence_value_gpu_va =
+		    result.gpu_virtual_address;
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
 int dxgvmb_send_create_nt_shared_object(struct dxgprocess *process,
 					struct d3dkmthandle object,
 					struct d3dkmthandle *shared_handle)
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 60433744b46b..d9cc88dee186 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -172,6 +172,21 @@ struct dxgkvmb_command_signalguestevent {
 	bool				dereference_event;
 };
 
+struct dxgkvmb_command_opensyncobject {
+	struct dxgkvmb_command_vm_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		global_sync_object;
+	u32				engine_affinity;
+	struct d3dddi_synchronizationobject_flags flags;
+};
+
+struct dxgkvmb_command_opensyncobject_return {
+	struct d3dkmthandle		sync_object;
+	struct ntstatus			status;
+	u64				gpu_virtual_address;
+	u64				guest_cpu_physical_address;
+};
+
 /*
  * The command returns struct d3dkmthandle of a shared object for the
  * given pre-process object
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 05f59854cbbf..be9d72c4ae4e 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -35,6 +35,33 @@ static char *errorstr(int ret)
 	return ret < 0 ? "err" : "";
 }
 
+static int dxgsyncobj_release(struct inode *inode, struct file *file)
+{
+	struct dxgsharedsyncobject *syncobj = file->private_data;
+
+	pr_debug("%s: %p", __func__, syncobj);
+	mutex_lock(&syncobj->fd_mutex);
+	kref_get(&syncobj->ssyncobj_kref);
+	syncobj->host_shared_handle_nt_reference--;
+	if (syncobj->host_shared_handle_nt_reference == 0) {
+		if (syncobj->host_shared_handle_nt.v) {
+			dxgvmb_send_destroy_nt_shared_object(
+					syncobj->host_shared_handle_nt);
+			pr_debug("Syncobj host_handle_nt destroyed: %x",
+				    syncobj->host_shared_handle_nt.v);
+			syncobj->host_shared_handle_nt.v = 0;
+		}
+		kref_put(&syncobj->ssyncobj_kref, dxgsharedsyncobj_release);
+	}
+	mutex_unlock(&syncobj->fd_mutex);
+	kref_put(&syncobj->ssyncobj_kref, dxgsharedsyncobj_release);
+	return 0;
+}
+
+static const struct file_operations dxg_syncobj_fops = {
+	.release = dxgsyncobj_release,
+};
+
 static int dxgsharedresource_release(struct inode *inode, struct file *file)
 {
 	struct dxgsharedresource *resource = file->private_data;
@@ -1584,6 +1611,7 @@ dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
 	struct eventfd_ctx *event = NULL;
 	struct dxgsyncobject *syncobj = NULL;
 	bool device_lock_acquired = false;
+	struct dxgsharedsyncobject *syncobjgbl = NULL;
 	struct dxghosteventcpu *host_event = NULL;
 
 	ret = copy_from_user(&args, inargs, sizeof(args));
@@ -1644,6 +1672,22 @@ dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
 	if (ret < 0)
 		goto cleanup;
 
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
 	ret = copy_to_user(inargs, &args, sizeof(args));
 	if (ret) {
 		pr_err("%s failed to copy output args", __func__);
@@ -1672,6 +1716,8 @@ dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
 		if (event)
 			eventfd_ctx_put(event);
 	}
+	if (syncobjgbl)
+		kref_put(&syncobjgbl->ssyncobj_kref, dxgsharedsyncobj_release);
 	if (adapter)
 		dxgadapter_release_lock_shared(adapter);
 	if (device_lock_acquired)
@@ -1726,6 +1772,141 @@ dxgk_destroy_sync_object(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_open_sync_object_nt(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_opensyncobjectfromnthandle2 args;
+	struct dxgsyncobject *syncobj = NULL;
+	struct dxgsharedsyncobject *syncobj_fd = NULL;
+	struct file *file = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dddi_synchronizationobject_flags flags = { };
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
+	args.sync_object.v = 0;
+
+	if (args.device.v) {
+		device = dxgprocess_device_by_handle(process, args.device);
+		if (device == NULL) {
+			return -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		pr_err("device handle is missing");
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
+	file = fget(args.nt_handle);
+	if (!file) {
+		pr_err("failed to get file from handle: %llx",
+			   args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (file->f_op != &dxg_syncobj_fops) {
+		pr_err("invalid fd: %llx", args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	syncobj_fd = file->private_data;
+	if (syncobj_fd == NULL) {
+		pr_err("invalid private data: %llx", args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	flags.shared = 1;
+	flags.nt_security_sharing = 1;
+	syncobj = dxgsyncobject_create(process, device, adapter,
+				       syncobj_fd->type, flags);
+	if (syncobj == NULL) {
+		pr_err("failed to create sync object");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	dxgsharedsyncobj_add_syncobj(syncobj_fd, syncobj);
+
+	ret = dxgvmb_send_open_sync_object_nt(process, &dxgglobal->channel,
+					      &args, syncobj);
+	if (ret < 0) {
+		pr_err("failed to open sync object on host: %x",
+			syncobj_fd->host_shared_handle.v);
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	ret = hmgrtable_assign_handle(&process->handle_table, syncobj,
+				      HMGRENTRY_TYPE_DXGSYNCOBJECT,
+				      args.sync_object);
+	if (ret >= 0) {
+		syncobj->handle = args.sync_object;
+		kref_get(&syncobj->syncobj_kref);
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret >= 0)
+		goto success;
+	pr_err("%s failed to copy output args", __func__);
+
+cleanup:
+
+	if (syncobj) {
+		dxgsyncobject_destroy(process, syncobj);
+		syncobj = NULL;
+	}
+
+	if (args.sync_object.v)
+		dxgvmb_send_destroy_sync_object(process, args.sync_object);
+
+success:
+
+	if (file)
+		fput(file);
+	if (syncobj)
+		kref_put(&syncobj->syncobj_kref, dxgsyncobject_release);
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
 static int
 dxgk_signal_sync_object(struct dxgprocess *process, void *__user inargs)
 {
@@ -2379,6 +2560,30 @@ dxgk_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgsharedsyncobj_get_host_nt_handle(struct dxgsharedsyncobject *syncobj,
+				    struct dxgprocess *process,
+				    struct d3dkmthandle objecthandle)
+{
+	int ret = 0;
+
+	mutex_lock(&syncobj->fd_mutex);
+	if (syncobj->host_shared_handle_nt_reference == 0) {
+		ret = dxgvmb_send_create_nt_shared_object(process,
+			objecthandle,
+			&syncobj->host_shared_handle_nt);
+		if (ret < 0)
+			goto cleanup;
+		pr_debug("Host_shared_handle_ht: %x",
+			    syncobj->host_shared_handle_nt.v);
+		kref_get(&syncobj->ssyncobj_kref);
+	}
+	syncobj->host_shared_handle_nt_reference++;
+cleanup:
+	mutex_unlock(&syncobj->fd_mutex);
+	return ret;
+}
+
 static int
 dxgsharedresource_get_host_nt_handle(struct dxgsharedresource *resource,
 				     struct dxgprocess *process,
@@ -2404,6 +2609,7 @@ dxgsharedresource_get_host_nt_handle(struct dxgsharedresource *resource,
 }
 
 enum dxg_sharedobject_type {
+	DXG_SHARED_SYNCOBJECT,
 	DXG_SHARED_RESOURCE
 };
 
@@ -2420,6 +2626,10 @@ static int get_object_fd(enum dxg_sharedobject_type type,
 	}
 
 	switch (type) {
+	case DXG_SHARED_SYNCOBJECT:
+		file = anon_inode_getfile("dxgsyncobj",
+					  &dxg_syncobj_fops, object, 0);
+		break;
 	case DXG_SHARED_RESOURCE:
 		file = anon_inode_getfile("dxgresource",
 					  &dxg_resource_fops, object, 0);
@@ -2445,6 +2655,7 @@ dxgk_share_objects(struct dxgprocess *process, void *__user inargs)
 	enum hmgrentry_type object_type;
 	struct dxgsyncobject *syncobj = NULL;
 	struct dxgresource *resource = NULL;
+	struct dxgsharedsyncobject *shared_syncobj = NULL;
 	struct dxgsharedresource *shared_resource = NULL;
 	struct d3dkmthandle *handles = NULL;
 	int object_fd = 0;
@@ -2493,6 +2704,17 @@ dxgk_share_objects(struct dxgprocess *process, void *__user inargs)
 		ret = -EINVAL;
 	} else {
 		switch (object_type) {
+		case HMGRENTRY_TYPE_DXGSYNCOBJECT:
+			syncobj = obj;
+			if (syncobj->shared) {
+				kref_get(&syncobj->syncobj_kref);
+				shared_syncobj = syncobj->shared_owner;
+			} else {
+				pr_err("sync object is not shared");
+				syncobj = NULL;
+				ret = -EINVAL;
+			}
+			break;
 		case HMGRENTRY_TYPE_DXGRESOURCE:
 			resource = obj;
 			if (resource->shared_owner) {
@@ -2516,6 +2738,22 @@ dxgk_share_objects(struct dxgprocess *process, void *__user inargs)
 		goto cleanup;
 
 	switch (object_type) {
+	case HMGRENTRY_TYPE_DXGSYNCOBJECT:
+		ret = get_object_fd(DXG_SHARED_SYNCOBJECT, shared_syncobj,
+				    &object_fd);
+		if (ret < 0) {
+			pr_err("%s get_object_fd failed for sync object",
+				__func__);
+			goto cleanup;
+		}
+		ret = dxgsharedsyncobj_get_host_nt_handle(shared_syncobj,
+							  process,
+							  handles[0]);
+		if (ret < 0) {
+			pr_err("%s get_host_nt_handle failed", __func__);
+			goto cleanup;
+		}
+		break;
 	case HMGRENTRY_TYPE_DXGRESOURCE:
 		ret = get_object_fd(DXG_SHARED_RESOURCE, shared_resource,
 				    &object_fd);
@@ -3051,6 +3289,8 @@ void init_ioctls(void)
 		  LX_DXENUMADAPTERS3);
 	SET_IOCTL(/*0x3f */ dxgk_share_objects,
 		  LX_DXSHAREOBJECTS);
+	SET_IOCTL(/*0x40 */ dxgk_open_sync_object_nt,
+		  LX_DXOPENSYNCOBJECTFROMNTHANDLE2);
 	SET_IOCTL(/*0x41 */ dxgk_query_resource_info_nt,
 		  LX_DXQUERYRESOURCEINFOFROMNTHANDLE);
 	SET_IOCTL(/*0x42 */ dxgk_open_resource_nt,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 4f44dd855238..36466fc18608 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -690,6 +690,26 @@ struct d3dddi_openallocationinfo2 {
 	__u64			reserved[6];
 };
 
+struct d3dkmt_opensyncobjectfromnthandle2 {
+	__u64			nt_handle;
+	struct d3dkmthandle	device;
+	struct d3dddi_synchronizationobject_flags flags;
+	struct d3dkmthandle	sync_object;
+	__u32			reserved1;
+	union {
+		struct {
+#ifdef __KERNEL__
+			void	*fence_value_cpu_va;
+#else
+			__u64	fence_value_cpu_va;
+#endif
+			__u64	fence_value_gpu_va;
+			__u32	engine_affinity;
+		} monitored_fence;
+		__u64	reserved[8];
+	};
+};
+
 struct d3dkmt_openresourcefromnthandle {
 	struct d3dkmthandle	device;
 	__u32			reserved;
-- 
2.35.1

