Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C8848CC9C
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 20:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350298AbiALT4k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 14:56:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33344 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357570AbiALTzV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 14:55:21 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 027A320B718C;
        Wed, 12 Jan 2022 11:55:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 027A320B718C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642017317;
        bh=e1ZRZ3s4uvJ4M11uIAXlV2Th4jejfgbinloGkMmNoiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPRRCY0pJA7a5UnJLntscHom71p4/JmUAxkCo8YH55EmKqOVASaWJjSFR1mGM0dFJ
         iU/4t8fhf3U21aPNUselhZT4zEdhxt1tz7cxd7P3U1UlCPFBzbC4Heg4YolHYO8VQ1
         fuOiAOLfm7UixBuF1PqxIZTej3NfhjErgSyjinY8=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 9/9] drivers: hv: dxgkrnl: Implement DXGSYNCFILE
Date:   Wed, 12 Jan 2022 11:55:14 -0800
Message-Id: <e04c8e820bc166d9d4fe8e388aace731bb3255b0.1641937420.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641937419.git.iourit@linux.microsoft.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement the LX_DXCREATESYNCFILE IOCTL (D3DKMTCreateSyncFile).

dxgsyncfile is built on top of the Linux sync_file object and
provides a way for the user mode to synchronize with the execution
of the device DMA packets.

The IOCTL creates a dxgsyncfile object for the given GPU synchronization
object and a fence value. A sync_object file descriptor is returned to
the caller. The caller could wait for the object by using poll().
When the GPU synchronization object is signaled on the host, the host
sends a message to the virtual machine and the sync_file object is
signaled.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/Kconfig       |   2 +
 drivers/hv/dxgkrnl/Makefile      |   2 +-
 drivers/hv/dxgkrnl/dxgkrnl.h     |   2 +
 drivers/hv/dxgkrnl/dxgmodule.c   |  44 ++++++-
 drivers/hv/dxgkrnl/dxgsyncfile.c | 210 +++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgsyncfile.h |  30 +++++
 drivers/hv/dxgkrnl/dxgvmbus.c    | 145 ++++++++++++++-------
 drivers/hv/dxgkrnl/dxgvmbus.h    |  12 ++
 drivers/hv/dxgkrnl/ioctl.c       |  10 +-
 drivers/hv/dxgkrnl/misc.c        |   6 +
 drivers/hv/dxgkrnl/misc.h        |   1 +
 11 files changed, 414 insertions(+), 50 deletions(-)
 create mode 100644 drivers/hv/dxgkrnl/dxgsyncfile.c
 create mode 100644 drivers/hv/dxgkrnl/dxgsyncfile.h

diff --git a/drivers/hv/dxgkrnl/Kconfig b/drivers/hv/dxgkrnl/Kconfig
index 22d0914d8f1e..63b3eff9af5b 100644
--- a/drivers/hv/dxgkrnl/Kconfig
+++ b/drivers/hv/dxgkrnl/Kconfig
@@ -6,6 +6,8 @@ config DXGKRNL
 	tristate "Microsoft Paravirtualized GPU support"
 	depends on HYPERV
 	depends on 64BIT || COMPILE_TEST
+	select DMA_SHARED_BUFFER
+	select SYNC_FILE
 	help
 	  This driver supports paravirtualized virtual compute devices, exposed
 	  by Microsoft Hyper-V when Linux is running inside of a virtual machine
diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
index 745c66bebe5d..5fe06c27a1f2 100644
--- a/drivers/hv/dxgkrnl/Makefile
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the Linux video drivers.
 
 obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
-dxgkrnl-y		:= dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
+dxgkrnl-y := dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o dxgsyncfile.o
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 73d917cb11d5..b6ae31bcdb50 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -307,6 +307,7 @@ struct dxgglobal {
 	bool			pci_registered;
 	bool			global_channel_initialized;
 	bool			async_msg_enabled;
+	bool			map_guest_pages_enabled;
 };
 
 extern struct dxgglobal		*dxgglobal;
@@ -830,6 +831,7 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 				     struct
 				     d3dkmt_waitforsynchronizationobjectfromcpu
 				     *args,
+				     bool user_address,
 				     u64 cpu_event);
 int dxgvmb_send_lock2(struct dxgprocess *process,
 		      struct dxgadapter *adapter,
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index d50c1140c68f..1e3d8b5c1112 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -15,8 +15,10 @@
 #include <linux/eventfd.h>
 #include <linux/hyperv.h>
 #include <linux/pci.h>
+#include <linux/sync_file.h>
 
 #include "dxgkrnl.h"
+#include "dxgsyncfile.h"
 
 struct dxgglobal *dxgglobal;
 struct device *dxgglobaldev;
@@ -134,7 +136,7 @@ void dxgglobal_remove_host_event(struct dxghostevent *event)
 
 void signal_host_cpu_event(struct dxghostevent *eventhdr)
 {
-	struct  dxghosteventcpu *event = (struct  dxghosteventcpu *)eventhdr;
+	struct dxghosteventcpu *event = (struct dxghosteventcpu *)eventhdr;
 
 	if (event->remove_from_list ||
 		event->destroy_after_signal) {
@@ -157,6 +159,15 @@ void signal_host_cpu_event(struct dxghostevent *eventhdr)
 	}
 }
 
+void signal_dma_fence(struct dxghostevent *eventhdr)
+{
+	struct dxgsyncpoint *event = (struct dxgsyncpoint *)eventhdr;
+
+	event->fence_value++;
+	list_del(&eventhdr->host_event_list_entry);
+	dma_fence_signal(&event->base);
+}
+
 void dxgglobal_signal_host_event(u64 event_id)
 {
 	struct dxghostevent *event;
@@ -172,6 +183,8 @@ void dxgglobal_signal_host_event(u64 event_id)
 				    event_id);
 			if (event->event_type == dxghostevent_cpu_event)
 				signal_host_cpu_event(event);
+			else if (event->event_type == dxghostevent_dma_fence)
+				signal_dma_fence(event);
 			else
 				pr_err("Unknown host event type");
 			break;
@@ -404,6 +417,9 @@ const struct file_operations dxgk_fops = {
 /* Luid of the virtual GPU on the host (struct winluid) */
 #define DXGK_VMBUS_VGPU_LUID_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
 					sizeof(u32))
+/* The host caps (dxgk_vmbus_hostcaps) */
+#define DXGK_VMBUS_HOSTCAPS_OFFSET	(DXGK_VMBUS_VGPU_LUID_OFFSET + \
+					sizeof(struct winluid))
 /* The guest writes its capavilities to this adderss */
 #define DXGK_VMBUS_GUESTCAPS_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
 					sizeof(u32))
@@ -418,6 +434,24 @@ struct dxgk_vmbus_guestcaps {
 	};
 };
 
+/*
+ * The structure defines features, supported by the host.
+ *
+ * map_guest_memory
+ *   Host can map guest memory pages, so the guest can avoid using GPADLs
+ *   to represent existing system memory allocations.
+ */
+struct dxgk_vmbus_hostcaps {
+	union {
+		struct {
+			u32	map_guest_memory	: 1;
+			u32	reserved		: 31;
+		};
+		u32 host_caps;
+	};
+};
+
+
 static int dxg_pci_read_dwords(struct pci_dev *dev, int offset, int size,
 			       void *val)
 {
@@ -444,6 +478,7 @@ static int dxg_pci_probe_device(struct pci_dev *dev,
 	u32 vmbus_interface_ver = DXGK_VMBUS_INTERFACE_VERSION;
 	struct winluid vgpu_luid = {};
 	struct dxgk_vmbus_guestcaps guest_caps = {.wsl2 = 1};
+	struct dxgk_vmbus_hostcaps host_caps = {};
 
 	mutex_lock(&dxgglobal->device_mutex);
 
@@ -472,6 +507,13 @@ static int dxg_pci_probe_device(struct pci_dev *dev,
 		if (ret)
 			goto cleanup;
 
+		ret = pci_read_config_dword(dev, DXGK_VMBUS_HOSTCAPS_OFFSET,
+					&host_caps.host_caps);
+		if (ret == 0) {
+			if (host_caps.map_guest_memory)
+				dxgglobal->map_guest_pages_enabled = true;
+		}
+
 		if (dxgglobal->vmbus_ver > DXGK_VMBUS_INTERFACE_VERSION)
 			dxgglobal->vmbus_ver = DXGK_VMBUS_INTERFACE_VERSION;
 	}
diff --git a/drivers/hv/dxgkrnl/dxgsyncfile.c b/drivers/hv/dxgkrnl/dxgsyncfile.c
new file mode 100644
index 000000000000..f0705be548e0
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgsyncfile.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Ioctl implementation
+ *
+ */
+
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/anon_inodes.h>
+#include <linux/mman.h>
+
+#include "dxgkrnl.h"
+#include "dxgvmbus.h"
+#include "dxgsyncfile.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk:err: " fmt
+#undef dev_fmt
+#define dev_fmt(fmt)	"dxgk: " fmt
+
+static const struct dma_fence_ops dxgdmafence_ops;
+
+static inline struct dxgsyncpoint *to_syncpoint(struct dma_fence *fence)
+{
+	if (fence->ops != &dxgdmafence_ops)
+		return NULL;
+	return container_of(fence, struct dxgsyncpoint, base);
+}
+
+int dxgk_create_sync_file(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_createsyncfile args;
+	struct dxgsyncpoint *pt;
+	int ret = 0;
+	int fd = get_unused_fd_flags(O_CLOEXEC);
+	struct sync_file *sync_file = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmt_waitforsynchronizationobjectfromcpu waitargs = {};
+
+	if (fd < 0) {
+		pr_err("get_unused_fd_flags failed: %d", fd);
+		ret = fd;
+		goto cleanup;
+	}
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		pr_err("dxgprocess_device_by_handle failed");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0) {
+		pr_err("dxgdevice_acquire_lock_shared failed");
+		device = NULL;
+		goto cleanup;
+	}
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		pr_err("dxgadapter_acquire_lock_shared failed");
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	pt = kzalloc(sizeof(*pt), GFP_KERNEL);
+	if (!pt) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	spin_lock_init(&pt->lock);
+	pt->fence_value = args.fence_value;
+	pt->context = dma_fence_context_alloc(1);
+	pt->hdr.event_id = dxgglobal_new_host_event_id();
+	pt->hdr.event_type = dxghostevent_dma_fence;
+	dxgglobal_add_host_event(&pt->hdr);
+
+	dma_fence_init(&pt->base, &dxgdmafence_ops, &pt->lock,
+		       pt->context, args.fence_value);
+
+	sync_file = sync_file_create(&pt->base);
+	if (sync_file == NULL) {
+		pr_err("sync_file_create failed");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	dma_fence_put(&pt->base);
+
+	waitargs.device = args.device;
+	waitargs.object_count = 1;
+	waitargs.objects = &args.monitored_fence;
+	waitargs.fence_values = &args.fence_value;
+	ret = dxgvmb_send_wait_sync_object_cpu(process, adapter,
+					       &waitargs, false,
+					       pt->hdr.event_id);
+	if (ret < 0) {
+		pr_err("dxgvmb_send_wait_sync_object_cpu failed");
+		goto cleanup;
+	}
+
+	args.sync_file_handle = (u64)fd;
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy output args", __func__);
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	fd_install(fd, sync_file->file);
+
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		dxgdevice_release_lock_shared(device);
+	if (ret) {
+		if (sync_file) {
+			fput(sync_file->file);
+			/* sync_file_release will destroy dma_fence */
+			pt = NULL;
+		}
+		if (pt)
+			dma_fence_put(&pt->base);
+		if (fd >= 0)
+			put_unused_fd(fd);
+	}
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static const char *dxgdmafence_get_driver_name(struct dma_fence *fence)
+{
+	return "dxgkrnl";
+}
+
+static const char *dxgdmafence_get_timeline_name(struct dma_fence *fence)
+{
+	return "no_timeline";
+}
+
+static void dxgdmafence_release(struct dma_fence *fence)
+{
+	struct dxgsyncpoint *syncpoint;
+
+	syncpoint = to_syncpoint(fence);
+	if (syncpoint) {
+		if (syncpoint->hdr.event_id)
+			dxgglobal_get_host_event(syncpoint->hdr.event_id);
+		kfree(syncpoint);
+	}
+}
+
+static bool dxgdmafence_signaled(struct dma_fence *fence)
+{
+	struct dxgsyncpoint *syncpoint;
+
+	syncpoint = to_syncpoint(fence);
+	if (syncpoint == 0)
+		return true;
+	return __dma_fence_is_later(syncpoint->fence_value, fence->seqno,
+				    fence->ops);
+}
+
+static bool dxgdmafence_enable_signaling(struct dma_fence *fence)
+{
+	return true;
+}
+
+static void dxgdmafence_value_str(struct dma_fence *fence,
+				  char *str, int size)
+{
+	snprintf(str, size, "%lld", fence->seqno);
+}
+
+static void dxgdmafence_timeline_value_str(struct dma_fence *fence,
+					   char *str, int size)
+{
+	struct dxgsyncpoint *syncpoint;
+
+	syncpoint = to_syncpoint(fence);
+	snprintf(str, size, "%lld", syncpoint->fence_value);
+}
+
+static const struct dma_fence_ops dxgdmafence_ops = {
+	.get_driver_name = dxgdmafence_get_driver_name,
+	.get_timeline_name = dxgdmafence_get_timeline_name,
+	.enable_signaling = dxgdmafence_enable_signaling,
+	.signaled = dxgdmafence_signaled,
+	.release = dxgdmafence_release,
+	.fence_value_str = dxgdmafence_value_str,
+	.timeline_value_str = dxgdmafence_timeline_value_str,
+};
diff --git a/drivers/hv/dxgkrnl/dxgsyncfile.h b/drivers/hv/dxgkrnl/dxgsyncfile.h
new file mode 100644
index 000000000000..a91fb2ecd372
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgsyncfile.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Headers for sync file objects
+ *
+ */
+
+#ifndef _DXGSYNCFILE_H
+#define _DXGSYNCFILE_H
+
+#include <linux/sync_file.h>
+
+int dxgk_create_sync_file(struct dxgprocess *process, void *__user inargs);
+
+struct dxgsyncpoint {
+	struct dxghostevent	hdr;
+	struct dma_fence	base;
+	u64			fence_value;
+	u64			context;
+	spinlock_t		lock;
+	u64			u64;
+};
+
+#endif	 /* _DXGSYNCFILE_H */
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 773d8f364b34..185fb7e38c21 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1311,15 +1311,18 @@ int create_existing_sysmem(struct dxgdevice *device,
 	void *kmem = NULL;
 	int ret = 0;
 	struct dxgkvmb_command_setexistingsysmemstore *set_store_command;
+	struct dxgkvmb_command_setexistingsysmempages *set_pages_command;
 	u64 alloc_size = host_alloc->allocation_size;
 	u32 npages = alloc_size >> PAGE_SHIFT;
 	struct dxgvmbusmsg msg = {.hdr = NULL};
-
-	ret = init_message(&msg, device->adapter, device->process,
-			   sizeof(*set_store_command));
-	if (ret)
-		goto cleanup;
-	set_store_command = (void *)msg.msg;
+	const u32 max_pfns_in_message =
+		(DXG_MAX_VM_BUS_PACKET_SIZE - sizeof(*set_pages_command) -
+		PAGE_SIZE) / sizeof(__u64);
+	u32 alloc_offset_in_pages = 0;
+	struct page **page_in;
+	u64 *pfn;
+	u32 pages_to_send;
+	u32 i;
 
 	/*
 	 * Create a guest physical address list and set it as the allocation
@@ -1330,6 +1333,7 @@ int create_existing_sysmem(struct dxgdevice *device,
 	dev_dbg(dxgglobaldev, "   Alloc size: %lld", alloc_size);
 
 	dxgalloc->cpu_address = (void *)sysmem;
+
 	dxgalloc->pages = vzalloc(npages * sizeof(void *));
 	if (dxgalloc->pages == NULL) {
 		pr_err("failed to allocate pages");
@@ -1347,31 +1351,80 @@ int create_existing_sysmem(struct dxgdevice *device,
 		ret = -ENOMEM;
 		goto cleanup;
 	}
-	kmem = vmap(dxgalloc->pages, npages, VM_MAP, PAGE_KERNEL);
-	if (kmem == NULL) {
-		pr_err("vmap failed");
-		ret = -ENOMEM;
-		goto cleanup;
-	}
-	ret1 = vmbus_establish_gpadl(dxgglobal_get_vmbus(), kmem,
-				     alloc_size, &dxgalloc->gpadl);
-	if (ret1) {
-		pr_err("establish_gpadl failed: %d", ret1);
-		ret = -ENOMEM;
-		goto cleanup;
-	}
-	dev_dbg(dxgglobaldev, "New gpadl %d", dxgalloc->gpadl.gpadl_handle);
+	if (!dxgglobal->map_guest_pages_enabled) {
+		ret = init_message(&msg, device->adapter, device->process,
+				sizeof(*set_store_command));
+		if (ret)
+			goto cleanup;
+		set_store_command = (void *)msg.msg;
 
-	command_vgpu_to_host_init2(&set_store_command->hdr,
-				   DXGK_VMBCOMMAND_SETEXISTINGSYSMEMSTORE,
-				   device->process->host_handle);
-	set_store_command->device = device->handle;
-	set_store_command->device = device->handle;
-	set_store_command->allocation = host_alloc->allocation;
-	set_store_command->gpadl = dxgalloc->gpadl.gpadl_handle;
-	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
-	if (ret < 0)
-		pr_err("failed to set existing store: %x", ret);
+		kmem = vmap(dxgalloc->pages, npages, VM_MAP, PAGE_KERNEL);
+		if (kmem == NULL) {
+			pr_err("vmap failed");
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		ret1 = vmbus_establish_gpadl(dxgglobal_get_vmbus(), kmem,
+					alloc_size, &dxgalloc->gpadl);
+		if (ret1) {
+			pr_err("establish_gpadl failed: %d", ret1);
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		dev_dbg(dxgglobaldev, "New gpadl %d",
+			dxgalloc->gpadl.gpadl_handle);
+
+		command_vgpu_to_host_init2(&set_store_command->hdr,
+					DXGK_VMBCOMMAND_SETEXISTINGSYSMEMSTORE,
+					device->process->host_handle);
+		set_store_command->device = device->handle;
+		set_store_command->allocation = host_alloc->allocation;
+		set_store_command->gpadl = dxgalloc->gpadl.gpadl_handle;
+		ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
+						    msg.size);
+		if (ret < 0)
+			pr_err("failed to set existing store: %x", ret);
+	} else {
+		/*
+		 * Send the list of the allocation PFNs to the host. The host
+		 * will map the pages for GPU access.
+		 */
+
+		ret = init_message(&msg, device->adapter, device->process,
+				sizeof(*set_pages_command) +
+				max_pfns_in_message * sizeof(u64));
+		if (ret)
+			goto cleanup;
+		set_pages_command = (void *)msg.msg;
+		command_vgpu_to_host_init2(&set_pages_command->hdr,
+					DXGK_VMBCOMMAND_SETEXISTINGSYSMEMPAGES,
+					device->process->host_handle);
+		set_pages_command->device = device->handle;
+		set_pages_command->allocation = host_alloc->allocation;
+
+		page_in = dxgalloc->pages;
+		while (alloc_offset_in_pages < npages) {
+			pfn = (u64 *)((char *)msg.msg +
+				sizeof(*set_pages_command));
+			pages_to_send = min(npages - alloc_offset_in_pages,
+					    max_pfns_in_message);
+			set_pages_command->num_pages = pages_to_send;
+			set_pages_command->alloc_offset_in_pages =
+				alloc_offset_in_pages;
+
+			for (i = 0; i < pages_to_send; i++)
+				*pfn++ = page_to_pfn(*page_in++);
+
+			ret = dxgvmb_send_sync_msg_ntstatus(msg.channel,
+							    msg.hdr,
+							    msg.size);
+			if (ret < 0) {
+				pr_err("failed to set existing pages: %x", ret);
+				break;
+			}
+			alloc_offset_in_pages += pages_to_send;
+		}
+	}
 
 cleanup:
 	if (kmem)
@@ -2685,6 +2738,7 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 				     struct
 				     d3dkmt_waitforsynchronizationobjectfromcpu
 				     *args,
+				     bool user_address,
 				     u64 cpu_event)
 {
 	int ret = -EINVAL;
@@ -2708,18 +2762,25 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 	command->object_count = args->object_count;
 	command->guest_event_pointer = (u64) cpu_event;
 	current_pos = (u8 *) &command[1];
-	ret = copy_from_user(current_pos, args->objects, object_size);
-	if (ret) {
-		pr_err("%s failed to copy objects", __func__);
-		ret = -EINVAL;
-		goto cleanup;
-	}
-	current_pos += object_size;
-	ret = copy_from_user(current_pos, args->fence_values, fence_size);
-	if (ret) {
-		pr_err("%s failed to copy fences", __func__);
-		ret = -EINVAL;
-		goto cleanup;
+	if (user_address) {
+		ret = copy_from_user(current_pos, args->objects, object_size);
+		if (ret) {
+			pr_err("%s failed to copy objects", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		current_pos += object_size;
+		ret = copy_from_user(current_pos, args->fence_values,
+				     fence_size);
+		if (ret) {
+			pr_err("%s failed to copy fences", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		memcpy(current_pos, args->objects, object_size);
+		current_pos += object_size;
+		memcpy(current_pos, args->fence_values, fence_size);
 	}
 
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index a19ac804a320..dc766d95a0c4 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -139,6 +139,8 @@ enum dxgkvmb_commandtype {
 	DXGK_VMBCOMMAND_GETCONTEXTSCHEDULINGPRIORITY = 61,
 	DXGK_VMBCOMMAND_QUERYCLOCKCALIBRATION	= 62,
 	DXGK_VMBCOMMAND_QUERYRESOURCEINFO	= 64,
+	DXGK_VMBCOMMAND_LOGEVENT		= 65,
+	DXGK_VMBCOMMAND_SETEXISTINGSYSMEMPAGES	= 66,
 	DXGK_VMBCOMMAND_INVALID
 };
 
@@ -245,6 +247,16 @@ struct dxgkvmb_command_setexistingsysmemstore {
 	u32				gpadl;
 };
 
+/* Returns ntstatus */
+struct dxgkvmb_command_setexistingsysmempages {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		allocation;
+	u32				num_pages;
+	u32				alloc_offset_in_pages;
+	/* u64 pfn_array[num_pages] */
+};
+
 struct dxgkvmb_command_createprocess {
 	struct dxgkvmb_command_vm_to_host hdr;
 	void			*process;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 9770fabf163e..9236b6b95973 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -19,6 +19,7 @@
 
 #include "dxgkrnl.h"
 #include "dxgvmbus.h"
+#include "dxgsyncfile.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"dxgk:err: " fmt
@@ -32,11 +33,6 @@ struct ioctl_desc {
 };
 static struct ioctl_desc ioctls[LX_IO_MAX + 1];
 
-static char *errorstr(int ret)
-{
-	return ret < 0 ? "err" : "";
-}
-
 static int dxgsyncobj_release(struct inode *inode, struct file *file)
 {
 	struct dxgsharedsyncobject *syncobj = file->private_data;
@@ -3561,7 +3557,7 @@ dxgk_wait_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
 	}
 
 	ret = dxgvmb_send_wait_sync_object_cpu(process, adapter,
-					       &args, event_id);
+					       &args, true, event_id);
 	if (ret < 0)
 		goto cleanup;
 
@@ -5457,4 +5453,6 @@ void init_ioctls(void)
 		  LX_DXQUERYSTATISTICS);
 	SET_IOCTL(/*0x44 */ dxgk_share_object_with_host,
 		  LX_DXSHAREOBJECTWITHHOST);
+	SET_IOCTL(/*0x45 */ dxgk_create_sync_file,
+		  LX_DXCREATESYNCFILE);
 }
diff --git a/drivers/hv/dxgkrnl/misc.c b/drivers/hv/dxgkrnl/misc.c
index ffb491641836..1b152c269265 100644
--- a/drivers/hv/dxgkrnl/misc.c
+++ b/drivers/hv/dxgkrnl/misc.c
@@ -35,3 +35,9 @@ u16 *wcsncpy(u16 *dest, const u16 *src, size_t n)
 	dest[i - 1] = 0;
 	return dest;
 }
+
+char *errorstr(int ret)
+{
+	return ret < 0 ? "err" : "";
+}
+
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index 7fe3fc45b67c..3079dd55c7a4 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -44,6 +44,7 @@ extern const struct d3dkmthandle zerohandle;
  */
 
 u16 *wcsncpy(u16 *dest, const u16 *src, size_t n);
+char *errorstr(int ret);
 
 enum dxglockstate {
 	DXGLOCK_SHARED,
-- 
2.32.0

