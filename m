Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4714C94BB
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbiCATrS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbiCATrO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:14 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AA7D6CA51;
        Tue,  1 Mar 2022 11:46:31 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id AF64C20B6AEE;
        Tue,  1 Mar 2022 11:46:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF64C20B6AEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163990;
        bh=urZJtLCjfHRmF07C9OYS55sNai357B/p/zEWmLdJIrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StfP8sNP3b1ExG7IPgY/wstH10pY/wMJplzVkIkiyw8ocoXo+fURfxOxfzH34G3sq
         UjOx5Lj8TDD8UeBa9qbM7F0AV67ZN41YD7rch76BqwkJLHviw8or/mtVtLLhB5vZrW
         eh1Gj0oFYvC/sxn6qk/fqwBIFCnrEHHpEH16QIxE=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 04/30] drivers: hv: dxgkrnl: Creation of dxgadapter object
Date:   Tue,  1 Mar 2022 11:45:51 -0800
Message-Id: <03e9d393c08a348ca60539bb5f8d2dd6b5afaf0f.1646163378.git.iourit@linux.microsoft.com>
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

Handle creation and destruction of dxgadapter object, which
represents a virtual compute device, projected to the VM by
the host. The dxgadapter object is created when the
corresponding VM bus channel is offered by Hyper-V.

There could be multiple virtual compute device objects,
projected by the host to VM. They are enumerated by
issuing IOCTLs to the /dev/dxg device.

The adapter object can start functioning only when the global VM bus
channel and the corresponding per device VM bus channel are
initialized. Notifications about arrival of a virtual compute PCI
device and VM bus channels can happen in any order. Therefore,
the initial dxgadapter object state is DXGADAPTER_STATE_WAITING_VMBUS.
A list of VM bus channels and a list of waiting dxgadapter objects
are maintained. When dxgkrnl is notified about a VM bus channel
arrival, if tries to start all adapters, which are not started yet.

Properties of the adapter object are determined by sending VM
bus messages to the host to the corresponding VM bus channel.

When the per virtual compute device VM bus channel or the global
channel are destroyed, the adapter object is destroyed.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/Makefile     |   2 +-
 drivers/hv/dxgkrnl/dxgadapter.c | 172 +++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  89 +++++++++++++
 drivers/hv/dxgkrnl/dxgmodule.c  | 200 ++++++++++++++++++++++++++++-
 drivers/hv/dxgkrnl/dxgvmbus.c   | 216 +++++++++++++++++++++++++++++---
 drivers/hv/dxgkrnl/dxgvmbus.h   | 128 +++++++++++++++++++
 drivers/hv/dxgkrnl/hmgr.h       |  75 -----------
 drivers/hv/dxgkrnl/misc.c       |  37 ++++++
 drivers/hv/dxgkrnl/misc.h       |  17 +++
 9 files changed, 839 insertions(+), 97 deletions(-)
 create mode 100644 drivers/hv/dxgkrnl/dxgadapter.c
 delete mode 100644 drivers/hv/dxgkrnl/hmgr.h
 create mode 100644 drivers/hv/dxgkrnl/misc.c

diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
index 76349064b60a..2ed07d877c91 100644
--- a/drivers/hv/dxgkrnl/Makefile
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the hyper-v compute device driver (dxgkrnl).
 
 obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
-dxgkrnl-y		:= dxgmodule.o dxgvmbus.o
+dxgkrnl-y		:= dxgmodule.o misc.o dxgadapter.o ioctl.o dxgvmbus.o
diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
new file mode 100644
index 000000000000..e0a6fea00bd5
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Implementation of dxgadapter and its objects
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/hyperv.h>
+#include <linux/pagemap.h>
+#include <linux/eventfd.h>
+
+#include "dxgkrnl.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+int dxgadapter_set_vmbus(struct dxgadapter *adapter, struct hv_device *hdev)
+{
+	int ret;
+
+	guid_to_luid(&hdev->channel->offermsg.offer.if_instance,
+		     &adapter->luid);
+	pr_debug("%s: %x:%x %p %pUb\n",
+		    __func__, adapter->luid.b, adapter->luid.a, hdev->channel,
+		    &hdev->channel->offermsg.offer.if_instance);
+
+	ret = dxgvmbuschannel_init(&adapter->channel, hdev);
+	if (ret)
+		goto cleanup;
+
+	adapter->channel.adapter = adapter;
+	adapter->hv_dev = hdev;
+
+	ret = dxgvmb_send_open_adapter(adapter);
+	if (ret < 0) {
+		pr_err("dxgvmb_send_open_adapter failed: %d\n", ret);
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_get_internal_adapter_info(adapter);
+	if (ret < 0)
+		pr_err("get_internal_adapter_info failed: %d", ret);
+
+cleanup:
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+void dxgadapter_start(struct dxgadapter *adapter)
+{
+	struct dxgvgpuchannel *ch = NULL;
+	struct dxgvgpuchannel *entry;
+	int ret;
+
+	pr_debug("%s %x-%x",
+		__func__, adapter->luid.a, adapter->luid.b);
+
+	/* Find the corresponding vGPU vm bus channel */
+	list_for_each_entry(entry, &dxgglobal->vgpu_ch_list_head,
+			    vgpu_ch_list_entry) {
+		if (memcmp(&adapter->luid,
+			   &entry->adapter_luid,
+			   sizeof(struct winluid)) == 0) {
+			ch = entry;
+			break;
+		}
+	}
+	if (ch == NULL) {
+		pr_debug("%s vGPU chanel is not ready", __func__);
+		return;
+	}
+
+	/* The global channel is initialized when the first adapter starts */
+	if (!dxgglobal->global_channel_initialized) {
+		ret = dxgglobal_init_global_channel();
+		if (ret) {
+			dxgglobal_destroy_global_channel();
+			return;
+		}
+		dxgglobal->global_channel_initialized = true;
+	}
+
+	/* Initialize vGPU vm bus channel */
+	ret = dxgadapter_set_vmbus(adapter, ch->hdev);
+	if (ret) {
+		pr_err("Failed to start adapter %p", adapter);
+		adapter->adapter_state = DXGADAPTER_STATE_STOPPED;
+		return;
+	}
+
+	adapter->adapter_state = DXGADAPTER_STATE_ACTIVE;
+	pr_debug("%s Adapter started %p", __func__, adapter);
+}
+
+void dxgadapter_stop(struct dxgadapter *adapter)
+{
+	bool adapter_stopped = false;
+
+	down_write(&adapter->core_lock);
+	if (!adapter->stopping_adapter)
+		adapter->stopping_adapter = true;
+	else
+		adapter_stopped = true;
+	up_write(&adapter->core_lock);
+
+	if (adapter_stopped)
+		return;
+
+	if (dxgadapter_acquire_lock_exclusive(adapter) == 0) {
+		dxgvmb_send_close_adapter(adapter);
+		dxgadapter_release_lock_exclusive(adapter);
+	}
+	dxgvmbuschannel_destroy(&adapter->channel);
+
+	adapter->adapter_state = DXGADAPTER_STATE_STOPPED;
+}
+
+void dxgadapter_release(struct kref *refcount)
+{
+	struct dxgadapter *adapter;
+
+	adapter = container_of(refcount, struct dxgadapter, adapter_kref);
+	pr_debug("%s %p\n", __func__, adapter);
+	vfree(adapter);
+}
+
+bool dxgadapter_is_active(struct dxgadapter *adapter)
+{
+	return adapter->adapter_state == DXGADAPTER_STATE_ACTIVE;
+}
+
+int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter)
+{
+	down_write(&adapter->core_lock);
+	if (adapter->adapter_state != DXGADAPTER_STATE_ACTIVE) {
+		dxgadapter_release_lock_exclusive(adapter);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+void dxgadapter_acquire_lock_forced(struct dxgadapter *adapter)
+{
+	down_write(&adapter->core_lock);
+}
+
+void dxgadapter_release_lock_exclusive(struct dxgadapter *adapter)
+{
+	up_write(&adapter->core_lock);
+}
+
+int dxgadapter_acquire_lock_shared(struct dxgadapter *adapter)
+{
+	down_read(&adapter->core_lock);
+	if (adapter->adapter_state == DXGADAPTER_STATE_ACTIVE)
+		return 0;
+	dxgadapter_release_lock_shared(adapter);
+	return -ENODEV;
+}
+
+void dxgadapter_release_lock_shared(struct dxgadapter *adapter)
+{
+	up_read(&adapter->core_lock);
+}
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 533f3bb3ece2..c0fd0bb267f2 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -32,9 +32,39 @@ struct dxgadapter;
 #include "misc.h"
 #include <uapi/misc/d3dkmthk.h>
 
+struct dxgk_device_types {
+	u32 post_device:1;
+	u32 post_device_certain:1;
+	u32 software_device:1;
+	u32 soft_gpu_device:1;
+	u32 warp_device:1;
+	u32 bdd_device:1;
+	u32 support_miracast:1;
+	u32 mismatched_lda:1;
+	u32 indirect_display_device:1;
+	u32 xbox_one_device:1;
+	u32 child_id_support_dwm_clone:1;
+	u32 child_id_support_dwm_clone2:1;
+	u32 has_internal_panel:1;
+	u32 rfx_vgpu_device:1;
+	u32 virtual_render_device:1;
+	u32 support_preserve_boot_display:1;
+	u32 is_uefi_frame_buffer:1;
+	u32 removable_device:1;
+	u32 virtual_monitor_device:1;
+};
+
+enum dxgobjectstate {
+	DXGOBJECTSTATE_CREATED,
+	DXGOBJECTSTATE_ACTIVE,
+	DXGOBJECTSTATE_STOPPED,
+	DXGOBJECTSTATE_DESTROYED,
+};
+
 struct dxgvmbuschannel {
 	struct vmbus_channel	*channel;
 	struct hv_device	*hdev;
+	struct dxgadapter	*adapter;
 	spinlock_t		packet_list_mutex;
 	struct list_head	packet_list_head;
 	struct kmem_cache	*packet_cache;
@@ -70,6 +100,14 @@ struct dxgglobal {
 	struct list_head	plisthead;
 	struct mutex		plistmutex;
 
+	/* list of created adapters */
+	struct list_head	adapter_list_head;
+	struct rw_semaphore	adapter_list_lock;
+
+	/* List of all current threads for lock order tracking. */
+	struct mutex		thread_info_mutex;
+	struct list_head	thread_info_list_head;
+
 	/*
 	 * List of the vGPU VM bus channels (dxgvgpuchannel)
 	 * Protected by device_mutex
@@ -88,6 +126,10 @@ struct dxgglobal {
 
 extern struct dxgglobal		*dxgglobal;
 
+int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
+			     struct winluid host_vgpu_luid);
+void dxgglobal_acquire_adapter_list_lock(enum dxglockstate state);
+void dxgglobal_release_adapter_list_lock(enum dxglockstate state);
 int dxgglobal_init_global_channel(void);
 void dxgglobal_destroy_global_channel(void);
 struct vmbus_channel *dxgglobal_get_vmbus(void);
@@ -99,6 +141,47 @@ struct dxgprocess {
 	/* Placeholder */
 };
 
+enum dxgadapter_state {
+	DXGADAPTER_STATE_ACTIVE		= 0,
+	DXGADAPTER_STATE_STOPPED	= 1,
+	DXGADAPTER_STATE_WAITING_VMBUS	= 2,
+};
+
+/*
+ * This object represents the grapchis adapter.
+ * Objects, which take reference on the adapter:
+ * - dxgglobal
+ * - adapter handle (struct d3dkmthandle)
+ */
+struct dxgadapter {
+	struct rw_semaphore	core_lock;
+	struct kref		adapter_kref;
+	/* Entry in the list of adapters in dxgglobal */
+	struct list_head	adapter_list_entry;
+	struct pci_dev		*pci_dev;
+	struct hv_device	*hv_dev;
+	struct dxgvmbuschannel	channel;
+	struct d3dkmthandle	host_handle;
+	enum dxgadapter_state	adapter_state;
+	struct winluid		host_adapter_luid;
+	struct winluid		host_vgpu_luid;
+	struct winluid		luid;	/* VM bus channel luid */
+	u16			device_description[80];
+	u16			device_instance_id[WIN_MAX_PATH];
+	bool			stopping_adapter;
+};
+
+int dxgadapter_set_vmbus(struct dxgadapter *adapter, struct hv_device *hdev);
+bool dxgadapter_is_active(struct dxgadapter *adapter);
+void dxgadapter_start(struct dxgadapter *adapter);
+void dxgadapter_stop(struct dxgadapter *adapter);
+void dxgadapter_release(struct kref *refcount);
+int dxgadapter_acquire_lock_shared(struct dxgadapter *adapter);
+void dxgadapter_release_lock_shared(struct dxgadapter *adapter);
+int dxgadapter_acquire_lock_exclusive(struct dxgadapter *adapter);
+void dxgadapter_acquire_lock_forced(struct dxgadapter *adapter);
+void dxgadapter_release_lock_exclusive(struct dxgadapter *adapter);
+
 void init_ioctls(void);
 long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
 long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
@@ -127,6 +210,12 @@ static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
 void dxgvmb_initialize(void);
 int dxgvmb_send_set_iospace_region(u64 start, u64 len,
 				   struct vmbus_gpadl *shared_mem_gpadl);
+int dxgvmb_send_open_adapter(struct dxgadapter *adapter);
+int dxgvmb_send_close_adapter(struct dxgadapter *adapter);
+int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter);
+int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
+			  void *command,
+			  u32 cmd_size);
 
 int ntstatus2int(struct ntstatus status);
 
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 78f233e354b9..5ae57977731c 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -62,6 +62,148 @@ void dxgglobal_release_channel_lock(void)
 	up_read(&dxgglobal->channel_lock);
 }
 
+void dxgglobal_acquire_adapter_list_lock(enum dxglockstate state)
+{
+	if (state == DXGLOCK_EXCL)
+		down_write(&dxgglobal->adapter_list_lock);
+	else
+		down_read(&dxgglobal->adapter_list_lock);
+}
+
+void dxgglobal_release_adapter_list_lock(enum dxglockstate state)
+{
+	if (state == DXGLOCK_EXCL)
+		up_write(&dxgglobal->adapter_list_lock);
+	else
+		up_read(&dxgglobal->adapter_list_lock);
+}
+
+/*
+ * Returns a pointer to dxgadapter object, which corresponds to the given PCI
+ * device, or NULL.
+ */
+static struct dxgadapter *find_pci_adapter(struct pci_dev *dev)
+{
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (dev == entry->pci_dev) {
+			adapter = entry;
+			break;
+		}
+	}
+
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+	return adapter;
+}
+
+/*
+ * Returns a pointer to dxgadapter object, which has the givel LUID
+ * device, or NULL.
+ */
+static struct dxgadapter *find_adapter(struct winluid *luid)
+{
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (memcmp(luid, &entry->luid, sizeof(struct winluid)) == 0) {
+			adapter = entry;
+			break;
+		}
+	}
+
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+	return adapter;
+}
+
+/*
+ * Creates a new dxgadapter object, which represents a virtual GPU, projected
+ * by the host.
+ * The adapter is in the waiting state. It will become active when the global
+ * VM bus channel and the adapter VM bus channel are created.
+ */
+int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
+			     struct winluid host_vgpu_luid)
+{
+	struct dxgadapter *adapter;
+	int ret = 0;
+
+	adapter = vzalloc(sizeof(struct dxgadapter));
+	if (adapter == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	adapter->adapter_state = DXGADAPTER_STATE_WAITING_VMBUS;
+	adapter->host_vgpu_luid = host_vgpu_luid;
+	kref_init(&adapter->adapter_kref);
+	init_rwsem(&adapter->core_lock);
+
+	adapter->pci_dev = dev;
+	guid_to_luid(guid, &adapter->luid);
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+
+	list_add_tail(&adapter->adapter_list_entry,
+		      &dxgglobal->adapter_list_head);
+	dxgglobal->num_adapters++;
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+
+	pr_debug("new adapter added %p %x-%x\n", adapter,
+		    adapter->luid.a, adapter->luid.b);
+cleanup:
+	pr_debug("%s end: %d", __func__, ret);
+	return ret;
+}
+
+/*
+ * Attempts to start dxgadapter objects, which are not active yet.
+ */
+static void dxgglobal_start_adapters(void)
+{
+	struct dxgadapter *adapter;
+
+	if (dxgglobal->hdev == NULL) {
+		pr_debug("Global channel is not ready");
+		return;
+	}
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+	list_for_each_entry(adapter, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (adapter->adapter_state == DXGADAPTER_STATE_WAITING_VMBUS)
+			dxgadapter_start(adapter);
+	}
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+}
+
+/*
+ * Stopsthe active dxgadapter objects.
+ */
+static void dxgglobal_stop_adapters(void)
+{
+	struct dxgadapter *adapter;
+
+	if (dxgglobal->hdev == NULL) {
+		pr_debug("Global channel is not ready");
+		return;
+	}
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+	list_for_each_entry(adapter, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (adapter->adapter_state == DXGADAPTER_STATE_ACTIVE)
+			dxgadapter_stop(adapter);
+	}
+	dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+}
+
 /*
  * File operations for the /dev/dxg device
  */
@@ -207,12 +349,22 @@ static int dxg_pci_probe_device(struct pci_dev *dev,
 			goto cleanup;
 	}
 
+	/* Create new virtual GPU adapter */
+
 	pr_debug("Adapter channel: %pUb\n", &guid);
 	pr_debug("Vmbus interface version: %d\n",
 		dxgglobal->vmbus_ver);
 	pr_debug("Host vGPU luid: %x-%x\n",
 		vgpu_luid.b, vgpu_luid.a);
 
+	ret = dxgglobal_create_adapter(dev, &guid, vgpu_luid);
+	if (ret)
+		goto cleanup;
+
+	/* Attempt to start the adapter in case VM bus channels are created */
+
+	dxgglobal_start_adapters();
+
 cleanup:
 
 	mutex_unlock(&dxgglobal->device_mutex);
@@ -224,7 +376,24 @@ static int dxg_pci_probe_device(struct pci_dev *dev,
 
 static void dxg_pci_remove_device(struct pci_dev *dev)
 {
-	/* Placeholder */
+	struct dxgadapter *adapter;
+
+	mutex_lock(&dxgglobal->device_mutex);
+
+	adapter = find_pci_adapter(dev);
+	if (adapter) {
+		dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
+		list_del(&adapter->adapter_list_entry);
+		dxgglobal->num_adapters--;
+		dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
+
+		dxgadapter_stop(adapter);
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	} else {
+		pr_err("Failed to find dxgadapter");
+	}
+
+	mutex_unlock(&dxgglobal->device_mutex);
 }
 
 static struct pci_device_id dxg_pci_id_table = {
@@ -347,6 +516,25 @@ void dxgglobal_destroy_global_channel(void)
 	up_write(&dxgglobal->channel_lock);
 }
 
+static void dxgglobal_stop_adapter_vmbus(struct hv_device *hdev)
+{
+	struct dxgadapter *adapter = NULL;
+	struct winluid luid;
+
+	guid_to_luid(&hdev->channel->offermsg.offer.if_instance, &luid);
+
+	pr_debug("%s: %x:%x\n", __func__, luid.b, luid.a);
+
+	adapter = find_adapter(&luid);
+
+	if (adapter && adapter->adapter_state == DXGADAPTER_STATE_ACTIVE) {
+		down_write(&adapter->core_lock);
+		dxgvmbuschannel_destroy(&adapter->channel);
+		adapter->adapter_state = DXGADAPTER_STATE_STOPPED;
+		up_write(&adapter->core_lock);
+	}
+}
+
 static const struct hv_vmbus_device_id id_table[] = {
 	/* Per GPU Device GUID */
 	{ HV_GPUP_DXGK_VGPU_GUID },
@@ -378,6 +566,7 @@ static int dxg_probe_vmbus(struct hv_device *hdev,
 		vgpuch->hdev = hdev;
 		list_add_tail(&vgpuch->vgpu_ch_list_entry,
 			      &dxgglobal->vgpu_ch_list_head);
+		dxgglobal_start_adapters();
 	} else if (uuid_le_cmp(hdev->dev_type, id_table[1].guid) == 0) {
 		/* This is the global Dxgkgnl channel */
 		pr_debug("Global channel: %pUb",
@@ -389,6 +578,7 @@ static int dxg_probe_vmbus(struct hv_device *hdev,
 			goto error;
 		}
 		dxgglobal->hdev = hdev;
+		dxgglobal_start_adapters();
 	} else {
 		/* Unknown device type */
 		pr_err("probe: unknown device type\n");
@@ -414,6 +604,7 @@ static int dxg_remove_vmbus(struct hv_device *hdev)
 
 	if (uuid_le_cmp(hdev->dev_type, id_table[0].guid) == 0) {
 		pr_debug("Remove virtual GPU channel\n");
+		dxgglobal_stop_adapter_vmbus(hdev);
 		list_for_each_entry(vgpu_channel,
 				    &dxgglobal->vgpu_ch_list_head,
 				    vgpu_ch_list_entry) {
@@ -466,7 +657,12 @@ static int dxgglobal_create(void)
 	mutex_init(&dxgglobal->plistmutex);
 	mutex_init(&dxgglobal->device_mutex);
 
+	INIT_LIST_HEAD(&dxgglobal->thread_info_list_head);
+	mutex_init(&dxgglobal->thread_info_mutex);
+
 	INIT_LIST_HEAD(&dxgglobal->vgpu_ch_list_head);
+	INIT_LIST_HEAD(&dxgglobal->adapter_list_head);
+	init_rwsem(&dxgglobal->adapter_list_lock);
 
 	init_rwsem(&dxgglobal->channel_lock);
 
@@ -477,6 +673,8 @@ static int dxgglobal_create(void)
 static void dxgglobal_destroy(void)
 {
 	if (dxgglobal) {
+		dxgglobal_stop_adapters();
+
 		if (dxgglobal->vmbus_registered)
 			vmbus_driver_unregister(&dxg_drv);
 
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 399dec02a3a1..6b02932819c8 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -77,7 +77,7 @@ struct dxgvmbusmsgres {
 	void				*res;
 };
 
-static int init_message(struct dxgvmbusmsg *msg,
+static int init_message(struct dxgvmbusmsg *msg, struct dxgadapter *adapter,
 			struct dxgprocess *process, u32 size)
 {
 	bool use_ext_header = dxgglobal->vmbus_ver >=
@@ -97,10 +97,15 @@ static int init_message(struct dxgvmbusmsg *msg,
 	if (use_ext_header) {
 		msg->msg = (char *)&msg->hdr[1];
 		msg->hdr->command_offset = sizeof(msg->hdr[0]);
+		if (adapter)
+			msg->hdr->vgpu_luid = adapter->host_vgpu_luid;
 	} else {
 		msg->msg = (char *)msg->hdr;
 	}
-	msg->channel = &dxgglobal->channel;
+	if (adapter && !dxgglobal->async_msg_enabled)
+		msg->channel = &adapter->channel;
+	else
+		msg->channel = &dxgglobal->channel;
 	return 0;
 }
 
@@ -114,6 +119,37 @@ static void free_message(struct dxgvmbusmsg *msg, struct dxgprocess *process)
  * Helper functions
  */
 
+static void command_vm_to_host_init2(struct dxgkvmb_command_vm_to_host *command,
+				     enum dxgkvmb_commandtype_global t,
+				     struct d3dkmthandle process)
+{
+	command->command_type	= t;
+	command->process	= process;
+	command->command_id	= 0;
+	command->channel_type	= DXGKVMB_VM_TO_HOST;
+}
+
+static void command_vgpu_to_host_init1(struct dxgkvmb_command_vgpu_to_host
+					*command,
+					enum dxgkvmb_commandtype type)
+{
+	command->command_type	= type;
+	command->process.v	= 0;
+	command->command_id	= 0;
+	command->channel_type	= DXGKVMB_VGPU_TO_HOST;
+}
+
+static void command_vgpu_to_host_init2(struct dxgkvmb_command_vgpu_to_host
+					*command,
+					enum dxgkvmb_commandtype type,
+					struct d3dkmthandle process)
+{
+	command->command_type	= type;
+	command->process	= process;
+	command->command_id	= 0;
+	command->channel_type	= DXGKVMB_VGPU_TO_HOST;
+}
+
 int ntstatus2int(struct ntstatus status)
 {
 	if (NT_SUCCESS(status))
@@ -212,22 +248,26 @@ static void process_inband_packet(struct dxgvmbuschannel *channel,
 	u32 packet_length = hv_pkt_datalen(desc);
 	struct dxgkvmb_command_host_to_vm *packet;
 
-	if (packet_length < sizeof(struct dxgkvmb_command_host_to_vm)) {
-		pr_err("Invalid global packet");
-	} else {
-		packet = hv_pkt_data(desc);
-		pr_debug("global packet %d",
-				packet->command_type);
-		switch (packet->command_type) {
-		case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
-		case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
-			break;
-		case DXGK_VMBCOMMAND_SENDWNFNOTIFICATION:
-			break;
-		default:
-			pr_err("unexpected host message %d",
-					packet->command_type);
+	if (channel->adapter == NULL) {
+		if (packet_length < sizeof(struct dxgkvmb_command_host_to_vm)) {
+			pr_err("Invalid global packet");
+		} else {
+			packet = hv_pkt_data(desc);
+			pr_debug("global packet %d",
+				    packet->command_type);
+			switch (packet->command_type) {
+			case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
+			case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
+				break;
+			case DXGK_VMBCOMMAND_SENDWNFNOTIFICATION:
+				break;
+			default:
+				pr_err("unexpected host message %d",
+					   packet->command_type);
+			}
 		}
+	} else {
+		pr_err("Unexpected packet for adapter channel");
 	}
 }
 
@@ -275,6 +315,7 @@ void dxgvmbuschannel_receive(void *ctx)
 	struct vmpacket_descriptor *desc;
 	u32 packet_length = 0;
 
+	pr_debug("%s %p", __func__, channel->adapter);
 	foreach_vmbus_pkt(desc, channel->channel) {
 		packet_length = hv_pkt_datalen(desc);
 		pr_debug("next packet (id, size, type): %llu %d %d",
@@ -299,6 +340,7 @@ int dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
 	int ret;
 	struct dxgvmbuspacket *packet = NULL;
 	struct dxgkvmb_command_vm_to_host *cmd1;
+	struct dxgkvmb_command_vgpu_to_host *cmd2;
 
 	if (cmd_size > DXG_MAX_VM_BUS_PACKET_SIZE ||
 	    result_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
@@ -312,8 +354,15 @@ int dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
 		return -ENOMEM;
 	}
 
-	pr_debug("send_sync_msg global: %d %p %d %d",
-		cmd1->command_type, command, cmd_size, result_size);
+	if (channel->adapter == NULL) {
+		cmd1 = command;
+		pr_debug("send_sync_msg global: %d %p %d %d",
+			cmd1->command_type, command, cmd_size, result_size);
+	} else {
+		cmd2 = command;
+		pr_debug("send_sync_msg adapter: %d %p %d %d",
+			cmd2->command_type, command, cmd_size, result_size);
+	}
 
 	packet->request_id = atomic64_inc_return(&channel->packet_request_id);
 	init_completion(&packet->wait);
@@ -358,6 +407,41 @@ int dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
 	return ret;
 }
 
+int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
+			  void *command,
+			  u32 cmd_size)
+{
+	int ret;
+	int try_count = 0;
+
+	if (cmd_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("%s invalid data size", __func__);
+		return -EINVAL;
+	}
+
+	if (channel->adapter) {
+		pr_err("Async messages should be sent to the global channel");
+		return -EINVAL;
+	}
+
+	do {
+		ret = vmbus_sendpacket(channel->channel, command, cmd_size,
+				0, VM_PKT_DATA_INBAND, 0);
+		/*
+		 * -EAGAIN is returned when the VM bus ring buffer if full.
+		 * Wait 2ms to allow the host to process messages and try again.
+		 */
+		if (ret == -EAGAIN) {
+			usleep_range(1000, 2000);
+			try_count++;
+		}
+	} while (ret == -EAGAIN && try_count < 5000);
+	if (ret < 0)
+		pr_err("vmbus_sendpacket failed: %x", ret);
+
+	return ret;
+}
+
 static int
 dxgvmb_send_sync_msg_ntstatus(struct dxgvmbuschannel *channel,
 			      void *command, u32 cmd_size)
@@ -383,7 +467,7 @@ int dxgvmb_send_set_iospace_region(u64 start, u64 len,
 	struct dxgkvmb_command_setiospaceregion *command;
 	struct dxgvmbusmsg msg;
 
-	ret = init_message(&msg, NULL, sizeof(*command));
+	ret = init_message(&msg, NULL, NULL, sizeof(*command));
 	if (ret)
 		return ret;
 	command = (void *)msg.msg;
@@ -411,3 +495,95 @@ int dxgvmb_send_set_iospace_region(u64 start, u64 len,
 	return ret;
 }
 
+/*
+ * Virtual GPU messages to the host
+ */
+
+int dxgvmb_send_open_adapter(struct dxgadapter *adapter)
+{
+	int ret;
+	struct dxgkvmb_command_openadapter *command;
+	struct dxgkvmb_command_openadapter_return result = { };
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, adapter, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init1(&command->hdr, DXGK_VMBCOMMAND_OPENADAPTER);
+	command->vmbus_interface_version = dxgglobal->vmbus_ver;
+	command->vmbus_last_compatible_interface_version =
+	    DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result.status);
+	adapter->host_handle = result.host_adapter_handle;
+
+cleanup:
+	free_message(&msg, NULL);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_close_adapter(struct dxgadapter *adapter)
+{
+	int ret;
+	struct dxgkvmb_command_closeadapter *command;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, adapter, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init1(&command->hdr, DXGK_VMBCOMMAND_CLOSEADAPTER);
+	command->host_handle = adapter->host_handle;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   NULL, 0);
+	free_message(&msg, NULL);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter)
+{
+	int ret;
+	struct dxgkvmb_command_getinternaladapterinfo *command;
+	struct dxgkvmb_command_getinternaladapterinfo_return result = { };
+	struct dxgvmbusmsg msg;
+	u32 result_size = sizeof(result);
+
+	ret = init_message(&msg, adapter, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init1(&command->hdr,
+				   DXGK_VMBCOMMAND_GETINTERNALADAPTERINFO);
+	if (dxgglobal->vmbus_ver < DXGK_VMBUS_INTERFACE_VERSION)
+		result_size -= sizeof(struct winluid);
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, result_size);
+	if (ret >= 0) {
+		adapter->host_adapter_luid = result.host_adapter_luid;
+		adapter->host_vgpu_luid = result.host_vgpu_luid;
+		wcsncpy(adapter->device_description, result.device_description,
+			sizeof(adapter->device_description) / sizeof(u16));
+		wcsncpy(adapter->device_instance_id, result.device_instance_id,
+			sizeof(adapter->device_instance_id) / sizeof(u16));
+		dxgglobal->async_msg_enabled = result.async_msg_enabled != 0;
+	}
+	free_message(&msg, NULL);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index d6136fd1ce9a..eda259324588 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -47,6 +47,83 @@ enum dxgkvmb_commandtype_global {
 	DXGK_VMBCOMMAND_INVALID_VM_TO_HOST
 };
 
+/*
+ *
+ * Commands, sent to the host via the per adapter VM bus channel
+ * DXG_GUEST_VGPU_VMBUS
+ *
+ */
+
+enum dxgkvmb_commandtype {
+	DXGK_VMBCOMMAND_CREATEDEVICE		= 0,
+	DXGK_VMBCOMMAND_DESTROYDEVICE		= 1,
+	DXGK_VMBCOMMAND_QUERYADAPTERINFO	= 2,
+	DXGK_VMBCOMMAND_DDIQUERYADAPTERINFO	= 3,
+	DXGK_VMBCOMMAND_CREATEALLOCATION	= 4,
+	DXGK_VMBCOMMAND_DESTROYALLOCATION	= 5,
+	DXGK_VMBCOMMAND_CREATECONTEXTVIRTUAL	= 6,
+	DXGK_VMBCOMMAND_DESTROYCONTEXT		= 7,
+	DXGK_VMBCOMMAND_CREATESYNCOBJECT	= 8,
+	DXGK_VMBCOMMAND_CREATEPAGINGQUEUE	= 9,
+	DXGK_VMBCOMMAND_DESTROYPAGINGQUEUE	= 10,
+	DXGK_VMBCOMMAND_MAKERESIDENT		= 11,
+	DXGK_VMBCOMMAND_EVICT			= 12,
+	DXGK_VMBCOMMAND_ESCAPE			= 13,
+	DXGK_VMBCOMMAND_OPENADAPTER		= 14,
+	DXGK_VMBCOMMAND_CLOSEADAPTER		= 15,
+	DXGK_VMBCOMMAND_FREEGPUVIRTUALADDRESS	= 16,
+	DXGK_VMBCOMMAND_MAPGPUVIRTUALADDRESS	= 17,
+	DXGK_VMBCOMMAND_RESERVEGPUVIRTUALADDRESS = 18,
+	DXGK_VMBCOMMAND_UPDATEGPUVIRTUALADDRESS	= 19,
+	DXGK_VMBCOMMAND_SUBMITCOMMAND		= 20,
+	dxgk_vmbcommand_queryvideomemoryinfo	= 21,
+	DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMCPU = 22,
+	DXGK_VMBCOMMAND_LOCK2			= 23,
+	DXGK_VMBCOMMAND_UNLOCK2			= 24,
+	DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMGPU = 25,
+	DXGK_VMBCOMMAND_SIGNALSYNCOBJECT	= 26,
+	DXGK_VMBCOMMAND_SIGNALFENCENTSHAREDBYREF = 27,
+	DXGK_VMBCOMMAND_GETDEVICESTATE		= 28,
+	DXGK_VMBCOMMAND_MARKDEVICEASERROR	= 29,
+	DXGK_VMBCOMMAND_ADAPTERSTOP		= 30,
+	DXGK_VMBCOMMAND_SETQUEUEDLIMIT		= 31,
+	DXGK_VMBCOMMAND_OPENRESOURCE		= 32,
+	DXGK_VMBCOMMAND_SETCONTEXTSCHEDULINGPRIORITY = 33,
+	DXGK_VMBCOMMAND_PRESENTHISTORYTOKEN	= 34,
+	DXGK_VMBCOMMAND_SETREDIRECTEDFLIPFENCEVALUE = 35,
+	DXGK_VMBCOMMAND_GETINTERNALADAPTERINFO	= 36,
+	DXGK_VMBCOMMAND_FLUSHHEAPTRANSITIONS	= 37,
+	DXGK_VMBCOMMAND_BLT			= 38,
+	DXGK_VMBCOMMAND_DDIGETSTANDARDALLOCATIONDRIVERDATA = 39,
+	DXGK_VMBCOMMAND_CDDGDICOMMAND		= 40,
+	DXGK_VMBCOMMAND_QUERYALLOCATIONRESIDENCY = 41,
+	DXGK_VMBCOMMAND_FLUSHDEVICE		= 42,
+	DXGK_VMBCOMMAND_FLUSHADAPTER		= 43,
+	DXGK_VMBCOMMAND_DDIGETNODEMETADATA	= 44,
+	DXGK_VMBCOMMAND_SETEXISTINGSYSMEMSTORE	= 45,
+	DXGK_VMBCOMMAND_ISSYNCOBJECTSIGNALED	= 46,
+	DXGK_VMBCOMMAND_CDDSYNCGPUACCESS	= 47,
+	DXGK_VMBCOMMAND_QUERYSTATISTICS		= 48,
+	DXGK_VMBCOMMAND_CHANGEVIDEOMEMORYRESERVATION = 49,
+	DXGK_VMBCOMMAND_CREATEHWQUEUE		= 50,
+	DXGK_VMBCOMMAND_DESTROYHWQUEUE		= 51,
+	DXGK_VMBCOMMAND_SUBMITCOMMANDTOHWQUEUE	= 52,
+	DXGK_VMBCOMMAND_GETDRIVERSTOREFILE	= 53,
+	DXGK_VMBCOMMAND_READDRIVERSTOREFILE	= 54,
+	DXGK_VMBCOMMAND_GETNEXTHARDLINK		= 55,
+	DXGK_VMBCOMMAND_UPDATEALLOCATIONPROPERTY = 56,
+	DXGK_VMBCOMMAND_OFFERALLOCATIONS	= 57,
+	DXGK_VMBCOMMAND_RECLAIMALLOCATIONS	= 58,
+	DXGK_VMBCOMMAND_SETALLOCATIONPRIORITY	= 59,
+	DXGK_VMBCOMMAND_GETALLOCATIONPRIORITY	= 60,
+	DXGK_VMBCOMMAND_GETCONTEXTSCHEDULINGPRIORITY = 61,
+	DXGK_VMBCOMMAND_QUERYCLOCKCALIBRATION	= 62,
+	DXGK_VMBCOMMAND_QUERYRESOURCEINFO	= 64,
+	DXGK_VMBCOMMAND_LOGEVENT		= 65,
+	DXGK_VMBCOMMAND_SETEXISTINGSYSMEMPAGES	= 66,
+	DXGK_VMBCOMMAND_INVALID
+};
+
 /*
  * Commands, sent by the host to the VM
  */
@@ -66,6 +143,15 @@ struct dxgkvmb_command_vm_to_host {
 	enum dxgkvmb_commandtype_global	command_type;
 };
 
+struct dxgkvmb_command_vgpu_to_host {
+	u64				command_id;
+	struct d3dkmthandle		process;
+	u32				channel_type	: 8;
+	u32				async_msg	: 1;
+	u32				reserved	: 23;
+	enum dxgkvmb_commandtype	command_type;
+};
+
 struct dxgkvmb_command_host_to_vm {
 	u64					command_id;
 	struct d3dkmthandle			process;
@@ -83,4 +169,46 @@ struct dxgkvmb_command_setiospaceregion {
 	u32				shared_page_gpadl;
 };
 
+struct dxgkvmb_command_openadapter {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	u32				vmbus_interface_version;
+	u32				vmbus_last_compatible_interface_version;
+	struct winluid			guest_adapter_luid;
+};
+
+struct dxgkvmb_command_openadapter_return {
+	struct d3dkmthandle		host_adapter_handle;
+	struct ntstatus			status;
+	u32				vmbus_interface_version;
+	u32				vmbus_last_compatible_interface_version;
+};
+
+struct dxgkvmb_command_closeadapter {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		host_handle;
+};
+
+struct dxgkvmb_command_getinternaladapterinfo {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+};
+
+struct dxgkvmb_command_getinternaladapterinfo_return {
+	struct dxgk_device_types	device_types;
+	u32				driver_store_copy_mode;
+	u32				driver_ddi_version;
+	u32				secure_virtual_machine	: 1;
+	u32				virtual_machine_reset	: 1;
+	u32				is_vail_supported	: 1;
+	u32				hw_sch_enabled		: 1;
+	u32				hw_sch_capable		: 1;
+	u32				va_backed_vm		: 1;
+	u32				async_msg_enabled	: 1;
+	u32				hw_support_state	: 2;
+	u32				reserved		: 23;
+	struct winluid			host_adapter_luid;
+	u16				device_description[80];
+	u16				device_instance_id[WIN_MAX_PATH];
+	struct winluid			host_vgpu_luid;
+};
+
 #endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/hmgr.h b/drivers/hv/dxgkrnl/hmgr.h
deleted file mode 100644
index b8b8f3ae5939..000000000000
--- a/drivers/hv/dxgkrnl/hmgr.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-/*
- * Copyright (c) 2019, Microsoft Corporation.
- *
- * Author:
- *   Iouri Tarassov <iourit@linux.microsoft.com>
- *
- * Dxgkrnl Graphics Driver
- * Handle manager definitions
- *
- */
-
-#ifndef _HMGR_H_
-#define _HMGR_H_
-
-#include "misc.h"
-
-struct hmgrentry;
-
-/*
- * Handle manager table.
- *
- * Implementation notes:
- *   A list of free handles is built on top of the array of table entries.
- *   free_handle_list_head is the index of the first entry in the list.
- *   m_FreeHandleListTail is the index of an entry in the list, which is
- *   HMGRTABLE_MIN_FREE_ENTRIES from the head. It means that when a handle is
- *   freed, the next time the handle can be re-used is after allocating
- *   HMGRTABLE_MIN_FREE_ENTRIES number of handles.
- *   Handles are allocated from the start of the list and free handles are
- *   inserted after the tail of the list.
- *
- */
-struct hmgrtable {
-	struct dxgprocess	*process;
-	struct hmgrentry	*entry_table;
-	u32			free_handle_list_head;
-	u32			free_handle_list_tail;
-	u32			table_size;
-	u32			free_count;
-	struct rw_semaphore	table_lock;
-};
-
-/*
- * Handle entry data types.
- */
-#define HMGRENTRY_TYPE_BITS 5
-
-enum hmgrentry_type {
-	HMGRENTRY_TYPE_FREE				= 0,
-	HMGRENTRY_TYPE_DXGADAPTER			= 1,
-	HMGRENTRY_TYPE_DXGSHAREDRESOURCE		= 2,
-	HMGRENTRY_TYPE_DXGDEVICE			= 3,
-	HMGRENTRY_TYPE_DXGRESOURCE			= 4,
-	HMGRENTRY_TYPE_DXGALLOCATION			= 5,
-	HMGRENTRY_TYPE_DXGOVERLAY			= 6,
-	HMGRENTRY_TYPE_DXGCONTEXT			= 7,
-	HMGRENTRY_TYPE_DXGSYNCOBJECT			= 8,
-	HMGRENTRY_TYPE_DXGKEYEDMUTEX			= 9,
-	HMGRENTRY_TYPE_DXGPAGINGQUEUE			= 10,
-	HMGRENTRY_TYPE_DXGDEVICESYNCOBJECT		= 11,
-	HMGRENTRY_TYPE_DXGPROCESS			= 12,
-	HMGRENTRY_TYPE_DXGSHAREDVMOBJECT		= 13,
-	HMGRENTRY_TYPE_DXGPROTECTEDSESSION		= 14,
-	HMGRENTRY_TYPE_DXGHWQUEUE			= 15,
-	HMGRENTRY_TYPE_DXGREMOTEBUNDLEOBJECT		= 16,
-	HMGRENTRY_TYPE_DXGCOMPOSITIONSURFACEOBJECT	= 17,
-	HMGRENTRY_TYPE_DXGCOMPOSITIONSURFACEPROXY	= 18,
-	HMGRENTRY_TYPE_DXGTRACKEDWORKLOAD		= 19,
-	HMGRENTRY_TYPE_LIMIT		= ((1 << HMGRENTRY_TYPE_BITS) - 1),
-	HMGRENTRY_TYPE_MONITOREDFENCE	= HMGRENTRY_TYPE_LIMIT + 1,
-};
-
-#endif
diff --git a/drivers/hv/dxgkrnl/misc.c b/drivers/hv/dxgkrnl/misc.c
new file mode 100644
index 000000000000..cb1e0635bebc
--- /dev/null
+++ b/drivers/hv/dxgkrnl/misc.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Helper functions
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/uaccess.h>
+
+#include "dxgkrnl.h"
+#include "misc.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+u16 *wcsncpy(u16 *dest, const u16 *src, size_t n)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		dest[i] = src[i];
+		if (src[i] == 0) {
+			i++;
+			break;
+		}
+	}
+	dest[i - 1] = 0;
+	return dest;
+}
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index 9fa3c7c8c3f5..1ff0c0e28332 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -14,6 +14,9 @@
 #ifndef _MISC_H_
 #define _MISC_H_
 
+/* Max characters in Windows path */
+#define WIN_MAX_PATH		260
+
 extern const struct d3dkmthandle zerohandle;
 
 /*
@@ -23,9 +26,23 @@ extern const struct d3dkmthandle zerohandle;
  * When a lower lock ois held, the higher lock should not be acquired.
  *
  * channel_lock
+ * fd_mutex
+ * plistmutex
+ * table_lock
+ * core_lock
+ * device_lock
+ * process->process_mutex
+ * adapter_list_lock
  * device_mutex
  */
 
+u16 *wcsncpy(u16 *dest, const u16 *src, size_t n);
+
+enum dxglockstate {
+	DXGLOCK_SHARED,
+	DXGLOCK_EXCL
+};
+
 /*
  * Some of the Windows return codes, which needs to be translated to Linux
  * IOCTL return codes. Positive values are success codes and need to be
-- 
2.35.1

