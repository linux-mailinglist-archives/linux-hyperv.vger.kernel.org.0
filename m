Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5124AA5CD
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379020AbiBECe0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:26 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45090 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378994AbiBECeY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:24 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id C916C20B8010;
        Fri,  4 Feb 2022 18:34:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C916C20B8010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028463;
        bh=x2ddbfPflgo1xk0q09bWkfLkxkgoehLuHkNOTPHI3p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CREHnL2YeTw/YNhljnqeRWF7O2LXP7yEOAsAhf75nhiNQF7IFg5ZgCXCvVLetCr77
         iZffl3ulc9Pi6b9I4/On+cTZ5g/+PEtX9Q9o527vscP+bfL6amua6KIi7YBMS/yGw/
         rWyCGCWGSSRIVqRwJVzCStRlafUp7x2AgnVLVFXQ=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 03/24] drivers: hv: dxgkrnl: Enumerate and open dxgadapter objects
Date:   Fri,  4 Feb 2022 18:34:01 -0800
Message-Id: <975c73e47ac6ecd92a65df19ee233cc10975b453.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement IOCTLs to enumerate and open dxgadapter objects:
  LX_DXENUMADAPTERS2(D3DKMTEnumAdapters2)
  LX_DXENUMADAPTERS3(D3DKMTEnumAdapters2)

Implement IOCTLS to open adapter by LUID and to close adapter
handle:
  LX_DXOPENADAPTERFROMLUID(D3DKMTOpenAdapterFromLuid),
  LX_DXCLOSEADAPTER(D3DKMTCloseAdapter).

Impllement IOCTL to query dxgadapter information:
  LX_DXQUERYADAPTERINFO.(D3DKMTQueryAdapterInfo).

When a dxgadapter is enumerated, a process handle (d3dkmthandle) is
created in the current process and returned to the caller.
The caller is responsible to close the adapter when it is not
longer used by calling D3DKMTCloseAdapter.

A dxgprocess has a list of opened dxgadapter objects
(dxgprocess_adapter is used to represent the entry in the list).
A dxgadapter also has a list of dxgprocess_adapter objects.
This is needed for cleanup because either a process or an adapter
could be destroyed first.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  77 ++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  49 ++++
 drivers/hv/dxgkrnl/dxgmodule.c  |  12 +
 drivers/hv/dxgkrnl/dxgprocess.c | 166 +++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.c   |  82 +++++++
 drivers/hv/dxgkrnl/ioctl.c      | 412 ++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/misc.h       |   1 +
 7 files changed, 799 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index e0a6fea00bd5..2c7823713547 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -102,6 +102,7 @@ void dxgadapter_start(struct dxgadapter *adapter)
 
 void dxgadapter_stop(struct dxgadapter *adapter)
 {
+	struct dxgprocess_adapter *entry;
 	bool adapter_stopped = false;
 
 	down_write(&adapter->core_lock);
@@ -114,6 +115,15 @@ void dxgadapter_stop(struct dxgadapter *adapter)
 	if (adapter_stopped)
 		return;
 
+	dxgglobal_acquire_process_adapter_lock();
+
+	list_for_each_entry(entry, &adapter->adapter_process_list_head,
+			    adapter_process_list_entry) {
+		dxgprocess_adapter_stop(entry);
+	}
+
+	dxgglobal_release_process_adapter_lock();
+
 	if (dxgadapter_acquire_lock_exclusive(adapter) == 0) {
 		dxgvmb_send_close_adapter(adapter);
 		dxgadapter_release_lock_exclusive(adapter);
@@ -137,6 +147,24 @@ bool dxgadapter_is_active(struct dxgadapter *adapter)
 	return adapter->adapter_state == DXGADAPTER_STATE_ACTIVE;
 }
 
+/* Protected by dxgglobal_acquire_process_adapter_lock */
+void dxgadapter_add_process(struct dxgadapter *adapter,
+			    struct dxgprocess_adapter *process_info)
+{
+	pr_debug("%s %p %p", __func__, adapter, process_info);
+	list_add_tail(&process_info->adapter_process_list_entry,
+		      &adapter->adapter_process_list_head);
+}
+
+void dxgadapter_remove_process(struct dxgprocess_adapter *process_info)
+{
+	pr_debug("%s %p %p", __func__,
+		    process_info->adapter, process_info);
+	list_del(&process_info->adapter_process_list_entry);
+	process_info->adapter_process_list_entry.next = NULL;
+	process_info->adapter_process_list_entry.prev = NULL;
+}
+
 int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter)
 {
 	down_write(&adapter->core_lock);
@@ -170,3 +198,52 @@ void dxgadapter_release_lock_shared(struct dxgadapter *adapter)
 {
 	up_read(&adapter->core_lock);
 }
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
+void dxgprocess_adapter_stop(struct dxgprocess_adapter *adapter_info)
+{
+}
+
+void dxgprocess_adapter_destroy(struct dxgprocess_adapter *adapter_info)
+{
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
+	pr_debug("%s %p %d",
+		    __func__, adapter_info, adapter_info->refcount);
+	adapter_info->refcount--;
+	if (adapter_info->refcount == 0)
+		dxgprocess_adapter_destroy(adapter_info);
+}
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 61512463baa4..fbc15731cbd5 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -119,6 +119,9 @@ struct dxgglobal {
 	/* protects acces to the global VM bus channel */
 	struct rw_semaphore	channel_lock;
 
+	/* protects the dxgprocess_adapter lists */
+	struct mutex		process_adapter_mutex;
+
 	bool			dxg_dev_initialized;
 	bool			vmbus_registered;
 	bool			pci_registered;
@@ -136,9 +139,31 @@ int dxgglobal_init_global_channel(void);
 void dxgglobal_destroy_global_channel(void);
 struct vmbus_channel *dxgglobal_get_vmbus(void);
 struct dxgvmbuschannel *dxgglobal_get_dxgvmbuschannel(void);
+void dxgglobal_acquire_process_adapter_lock(void);
+void dxgglobal_release_process_adapter_lock(void);
 int dxgglobal_acquire_channel_lock(void);
 void dxgglobal_release_channel_lock(void);
 
+/*
+ * Describes adapter information for each process
+ */
+struct dxgprocess_adapter {
+	/* Entry in dxgadapter::adapter_process_list_head */
+	struct list_head	adapter_process_list_entry;
+	/* Entry in dxgprocess::process_adapter_list_head */
+	struct list_head	process_adapter_list_entry;
+	struct dxgadapter	*adapter;
+	struct dxgprocess	*process;
+	int			refcount;
+};
+
+struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
+						     struct dxgadapter
+						     *adapter);
+void dxgprocess_adapter_release(struct dxgprocess_adapter *adapter);
+void dxgprocess_adapter_stop(struct dxgprocess_adapter *adapter_info);
+void dxgprocess_adapter_destroy(struct dxgprocess_adapter *adapter_info);
+
 /*
  * The structure represents a process, which opened the /dev/dxg device.
  * A corresponding object is created on the host.
@@ -167,15 +192,31 @@ struct dxgprocess {
 	struct hmgrtable	local_handle_table;
 	/* Handle of the corresponding objec on the host */
 	struct d3dkmthandle	host_handle;
+
+	/* List of opened adapters (dxgprocess_adapter) */
+	struct list_head	process_adapter_list_head;
 };
 
 struct dxgprocess *dxgprocess_create(void);
 void dxgprocess_destroy(struct dxgprocess *process);
 void dxgprocess_release(struct kref *refcount);
+int dxgprocess_open_adapter(struct dxgprocess *process,
+					struct dxgadapter *adapter,
+					struct d3dkmthandle *handle);
+int dxgprocess_close_adapter(struct dxgprocess *process,
+					 struct d3dkmthandle handle);
+struct dxgadapter *dxgprocess_get_adapter(struct dxgprocess *process,
+					  struct d3dkmthandle handle);
+struct dxgadapter *dxgprocess_adapter_by_handle(struct dxgprocess *process,
+						struct d3dkmthandle handle);
 void dxgprocess_ht_lock_shared_down(struct dxgprocess *process);
 void dxgprocess_ht_lock_shared_up(struct dxgprocess *process);
 void dxgprocess_ht_lock_exclusive_down(struct dxgprocess *process);
 void dxgprocess_ht_lock_exclusive_up(struct dxgprocess *process);
+struct dxgprocess_adapter *dxgprocess_get_adapter_info(struct dxgprocess
+						       *process,
+						       struct dxgadapter
+						       *adapter);
 
 enum dxgadapter_state {
 	DXGADAPTER_STATE_ACTIVE		= 0,
@@ -194,6 +235,8 @@ struct dxgadapter {
 	struct kref		adapter_kref;
 	/* Entry in the list of adapters in dxgglobal */
 	struct list_head	adapter_list_entry;
+	/* The list of dxgprocess_adapter entries */
+	struct list_head	adapter_process_list_head;
 	struct pci_dev		*pci_dev;
 	struct hv_device	*hv_dev;
 	struct dxgvmbuschannel	channel;
@@ -217,6 +260,9 @@ void dxgadapter_release_lock_shared(struct dxgadapter *adapter);
 int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter);
 void dxgadapter_acquire_lock_forced(struct dxgadapter *adapter);
 void dxgadapter_release_lock_exclusive(struct dxgadapter *adapter);
+void dxgadapter_add_process(struct dxgadapter *adapter,
+			    struct dxgprocess_adapter *process_info);
+void dxgadapter_remove_process(struct dxgprocess_adapter *process_info);
 
 void init_ioctls(void);
 long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
@@ -251,6 +297,9 @@ int dxgvmb_send_destroy_process(struct d3dkmthandle process);
 int dxgvmb_send_open_adapter(struct dxgadapter *adapter);
 int dxgvmb_send_close_adapter(struct dxgadapter *adapter);
 int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter);
+int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
+				   struct dxgadapter *adapter,
+				   struct d3dkmt_queryadapterinfo *args);
 int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
 			  void *command,
 			  u32 cmd_size);
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 64ac35e1863b..fafe0b6a6389 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -124,6 +124,16 @@ static struct dxgadapter *find_adapter(struct winluid *luid)
 	return adapter;
 }
 
+void dxgglobal_acquire_process_adapter_lock(void)
+{
+	mutex_lock(&dxgglobal->process_adapter_mutex);
+}
+
+void dxgglobal_release_process_adapter_lock(void)
+{
+	mutex_unlock(&dxgglobal->process_adapter_mutex);
+}
+
 /*
  * Creates a new dxgadapter object, which represents a virtual GPU, projected
  * by the host.
@@ -147,6 +157,7 @@ int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
 	kref_init(&adapter->adapter_kref);
 	init_rwsem(&adapter->core_lock);
 
+	INIT_LIST_HEAD(&adapter->adapter_process_list_head);
 	adapter->pci_dev = dev;
 	guid_to_luid(guid, &adapter->luid);
 
@@ -721,6 +732,7 @@ static int dxgglobal_create(void)
 	INIT_LIST_HEAD(&dxgglobal->plisthead);
 	mutex_init(&dxgglobal->plistmutex);
 	mutex_init(&dxgglobal->device_mutex);
+	mutex_init(&dxgglobal->process_adapter_mutex);
 
 	INIT_LIST_HEAD(&dxgglobal->thread_info_list_head);
 	mutex_init(&dxgglobal->thread_info_mutex);
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index 2a86ba1b4b1b..1fd7b7659792 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -47,6 +47,7 @@ struct dxgprocess *dxgprocess_create(void)
 
 			hmgrtable_init(&process->handle_table, process);
 			hmgrtable_init(&process->local_handle_table, process);
+			INIT_LIST_HEAD(&process->process_adapter_list_head);
 		}
 	}
 	return process;
@@ -54,6 +55,35 @@ struct dxgprocess *dxgprocess_create(void)
 
 void dxgprocess_destroy(struct dxgprocess *process)
 {
+	int i;
+	enum hmgrentry_type t;
+	struct d3dkmthandle h;
+	void *o;
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
 	hmgrtable_destroy(&process->handle_table);
 	hmgrtable_destroy(&process->local_handle_table);
 }
@@ -76,6 +106,142 @@ void dxgprocess_release(struct kref *refcount)
 	vfree(process);
 }
 
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
+			pr_debug("Found process info %p", entry);
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
+		pr_debug("creating new process adapter info\n");
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
 void dxgprocess_ht_lock_shared_down(struct dxgprocess *process)
 {
 	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 056d86c1859a..8b8e0aa0fa5d 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -655,3 +655,85 @@ int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter)
 		pr_debug("err: %s %d", __func__, ret);
 	return ret;
 }
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
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index fa7fc321addb..62a958f6f146 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -35,6 +35,408 @@ static char *errorstr(int ret)
 	return ret < 0 ? "err" : "";
 }
 
+static int dxgk_open_adapter_from_luid(struct dxgprocess *process,
+						   void *__user inargs)
+{
+	struct d3dkmt_openadapterfromluid args;
+	int ret;
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmt_openadapterfromluid *__user result = inargs;
+
+	pr_debug("ioctl: %s", __func__);
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
+			pr_debug("Compare luids: %d:%d  %d:%d",
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
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
+	pr_debug("ioctl: %s", __func__);
+	if (info_out == NULL || adapter_count_max == 0) {
+		pr_debug("buffer is NULL");
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
+				pr_debug("adapter: %x %x:%x",
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
+		pr_debug("Too many adapters");
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
+		pr_debug("found %d adapters", adapter_count);
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
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
+	pr_debug("ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.adapters == NULL) {
+		pr_debug("buffer is NULL");
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
+		pr_debug("buffer is too small");
+		ret = -EOVERFLOW;
+		goto cleanup;
+	}
+
+	if (args.num_adapters > D3DKMT_ADAPTERS_MAX) {
+		pr_debug("too many adapters");
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
+				pr_debug("adapter: %x %llx",
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
+		pr_debug("found %d adapters", args.num_adapters);
+	}
+
+	if (info)
+		vfree(info);
+	if (adapters)
+		vfree(adapters);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_enum_adapters3(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_enumadapters3 args;
+	int ret;
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
+	ret = dxgkp_enum_adapters(process, args.filter,
+				  args.adapter_count,
+				  args.adapters,
+				  &((struct d3dkmt_enumadapters3 *)inargs)->
+				  adapter_count);
+
+cleanup:
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_close_adapter(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmthandle args;
+	int ret;
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
+	ret = dxgprocess_close_adapter(process, args);
+	if (ret < 0)
+		pr_err("%s failed", __func__);
+
+cleanup:
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
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
+	pr_debug("ioctl: %s", __func__);
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
+	pr_debug("Type: %d Size: %x",
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
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 /*
  * IOCTL processing
  * The driver IOCTLs return
@@ -91,4 +493,14 @@ long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2)
 
 void init_ioctls(void)
 {
+	SET_IOCTL(/*0x1 */ dxgk_open_adapter_from_luid,
+		  LX_DXOPENADAPTERFROMLUID);
+	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
+		  LX_DXQUERYADAPTERINFO);
+	SET_IOCTL(/*0x14 */ dxgk_enum_adapters,
+		  LX_DXENUMADAPTERS2);
+	SET_IOCTL(/*0x15 */ dxgk_close_adapter,
+		  LX_DXCLOSEADAPTER);
+	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
+		  LX_DXENUMADAPTERS3);
 }
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index 433b59d3eb23..d00e7cc00470 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -31,6 +31,7 @@ extern const struct d3dkmthandle zerohandle;
  * table_lock
  * core_lock
  * device_lock
+ * process_adapter_mutex
  * adapter_list_lock
  * device_mutex
  */
-- 
2.35.1

