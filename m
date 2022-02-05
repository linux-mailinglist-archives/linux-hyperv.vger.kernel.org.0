Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DED4AA5D6
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379094AbiBECeu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45114 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379090AbiBECel (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:41 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8591620B876C;
        Fri,  4 Feb 2022 18:34:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8591620B876C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028467;
        bh=QRMNYTPNMSqnVfHuxVfo8vle8yuKMubYRnCcGl9y8+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7guHpLMlvJGEchvsndrV/smvz8gidzyYtPTL5QjasZpWNWDS3nAIX+FHZWmoj/9Q
         e4HEAQIRBVnLCHRZD56wvCs2ANFsoswrGXj2TsjV3MVrniyFigKfe2VwCkbxg3gDsX
         LomQQX6UuS6GhLB7oYTaLkPpf0ddH3kDGtOjPK6I=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 24/24] drivers: hv: dxgkrnl: Add support to map guest pages by host
Date:   Fri,  4 Feb 2022 18:34:22 -0800
Message-Id: <dee1370d61c9517bc537c0038067fb08c7b61c17.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dxgkrnl uses GPADLs to implement GPU allocations around existing
system memory. This method has limitations:
- a single GPADL can represent only ~32MB of memory
- there is a limit of how much memory the total size of GPADLs
  in a VM can be.
To avoid these limitations the host implemented mapping guest pages.
Presence of this support is determined by reading PCI config space.
When the support is enabled, dxgkrnl does not use GPADLs and instead
- pins memory pages of an existing system memory buffer
- sends PFNs of the pages to the host via a new VM bus message
- the host maps the PFNs to get access to the memory

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/Makefile    |   2 +-
 drivers/hv/dxgkrnl/dxgkrnl.h   |   2 +
 drivers/hv/dxgkrnl/dxgmodule.c |  30 ++++++-
 drivers/hv/dxgkrnl/dxgvmbus.c  | 145 +++++++++++++++++++++++----------
 drivers/hv/dxgkrnl/dxgvmbus.h  |  12 +++
 drivers/hv/dxgkrnl/ioctl.c     |   7 +-
 drivers/hv/dxgkrnl/misc.c      |   6 ++
 drivers/hv/dxgkrnl/misc.h      |   1 +
 8 files changed, 155 insertions(+), 50 deletions(-)

diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
index 745c66bebe5d..eedc678c9c2d 100644
--- a/drivers/hv/dxgkrnl/Makefile
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the Linux video drivers.
 
 obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
-dxgkrnl-y		:= dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
+dxgkrnl-y := dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 4a2b4c7611ff..2f1399ccc668 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -301,6 +301,7 @@ struct dxgglobal {
 	bool			pci_registered;
 	bool			global_channel_initialized;
 	bool			async_msg_enabled;
+	bool			map_guest_pages_enabled;
 };
 
 extern struct dxgglobal		*dxgglobal;
@@ -831,6 +832,7 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 				     struct
 				     d3dkmt_waitforsynchronizationobjectfromcpu
 				     *args,
+				     bool user_address,
 				     u64 cpu_event);
 int dxgvmb_send_lock2(struct dxgprocess *process,
 		      struct dxgadapter *adapter,
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 3928512bcc64..0447035eb402 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -144,7 +144,7 @@ void dxgglobal_remove_host_event(struct dxghostevent *event)
 
 void signal_host_cpu_event(struct dxghostevent *eventhdr)
 {
-	struct  dxghosteventcpu *event = (struct  dxghosteventcpu *)eventhdr;
+	struct dxghosteventcpu *event = (struct dxghosteventcpu *)eventhdr;
 
 	if (event->remove_from_list ||
 		event->destroy_after_signal) {
@@ -430,6 +430,9 @@ const struct file_operations dxgk_fops = {
 /* Luid of the virtual GPU on the host (struct winluid) */
 #define DXGK_VMBUS_VGPU_LUID_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
 					sizeof(u32))
+/* The host caps (dxgk_vmbus_hostcaps) */
+#define DXGK_VMBUS_HOSTCAPS_OFFSET	(DXGK_VMBUS_VGPU_LUID_OFFSET + \
+					sizeof(struct winluid))
 /* The guest writes its capavilities to this adderss */
 #define DXGK_VMBUS_GUESTCAPS_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
 					sizeof(u32))
@@ -445,6 +448,23 @@ struct dxgk_vmbus_guestcaps {
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
 /*
  * A helper function to read PCI config space.
  */
@@ -474,6 +494,7 @@ static int dxg_pci_probe_device(struct pci_dev *dev,
 	u32 vmbus_interface_ver = DXGK_VMBUS_INTERFACE_VERSION;
 	struct winluid vgpu_luid = {};
 	struct dxgk_vmbus_guestcaps guest_caps = {.wsl2 = 1};
+	struct dxgk_vmbus_hostcaps host_caps = {};
 
 	mutex_lock(&dxgglobal->device_mutex);
 
@@ -502,6 +523,13 @@ static int dxg_pci_probe_device(struct pci_dev *dev,
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
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 7a4b17938f53..3e8db1843830 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1336,15 +1336,18 @@ int create_existing_sysmem(struct dxgdevice *device,
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
@@ -1355,6 +1358,7 @@ int create_existing_sysmem(struct dxgdevice *device,
 	pr_debug("   Alloc size: %lld", alloc_size);
 
 	dxgalloc->cpu_address = (void *)sysmem;
+
 	dxgalloc->pages = vzalloc(npages * sizeof(void *));
 	if (dxgalloc->pages == NULL) {
 		pr_err("failed to allocate pages");
@@ -1372,31 +1376,80 @@ int create_existing_sysmem(struct dxgdevice *device,
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
-	pr_debug("New gpadl %d", dxgalloc->gpadl.gpadl_handle);
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
+		pr_debug("New gpadl %d",
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
@@ -2710,6 +2763,7 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 				     struct
 				     d3dkmt_waitforsynchronizationobjectfromcpu
 				     *args,
+				     bool user_address,
 				     u64 cpu_event)
 {
 	int ret = -EINVAL;
@@ -2733,18 +2787,25 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
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
index b1434742fa80..48e97f87e329 100644
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
index 26bdcdfeba86..333168f8d813 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -30,11 +30,6 @@ struct ioctl_desc {
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
@@ -3557,7 +3552,7 @@ dxgk_wait_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
 	}
 
 	ret = dxgvmb_send_wait_sync_object_cpu(process, adapter,
-					       &args, event_id);
+					       &args, true, event_id);
 	if (ret < 0)
 		goto cleanup;
 
diff --git a/drivers/hv/dxgkrnl/misc.c b/drivers/hv/dxgkrnl/misc.c
index cb1e0635bebc..39e52b165b27 100644
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
index f56d21b48814..721d4f5be235 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -43,6 +43,7 @@ extern const struct d3dkmthandle zerohandle;
  */
 
 u16 *wcsncpy(u16 *dest, const u16 *src, size_t n);
+char *errorstr(int ret);
 
 enum dxglockstate {
 	DXGLOCK_SHARED,
-- 
2.35.1

