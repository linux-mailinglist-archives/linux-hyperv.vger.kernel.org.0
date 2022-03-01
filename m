Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13034C94DF
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbiCATrb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbiCATr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:27 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88A5F6CA51;
        Tue,  1 Mar 2022 11:46:37 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id B80C320B4786;
        Tue,  1 Mar 2022 11:46:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B80C320B4786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163995;
        bh=obdvnqlHmkvn9M2d7Exuvt81IO8OE1vDafzPLkz/EIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNKJ1pT8/zKwRlBZdJMMmLrDJv/9fszYieIsQ/XNkkN63QJZbaNsgen70Vqcoee2b
         0sFkuvef6G2BKeZO1bX+G8UrNCtuVKxPihJ2zHVCX4JdnbKwCKROSrw3DiBAbSWtf7
         K0V8SWut2AGCS9VOU4n8jXhohi8ndjzx8vJVs+/o=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 30/30] drivers: hv: dxgkrnl: Add support to map guest pages by host
Date:   Tue,  1 Mar 2022 11:46:17 -0800
Message-Id: <7e303134ccd13b25080f7ebde5dc57f302972d55.1646163379.git.iourit@linux.microsoft.com>
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

Implement support for mapping guest memory pages by the host.
This removes hyper-v limitations of using GPADL (guest physical
address list).

Dxgkrnl uses hyper-v GPADLs to share guest system memory with the
host. This method has limitations:
- a single GPADL can represent only ~32MB of memory
- there is a limit of how much memory the total size of GPADLs
  in a VM can represent.
To avoid these limitations the host implemented mapping guest memory
pages. Presence of this support is determined by reading PCI config
space. When the support is enabled, dxgkrnl does not use GPADLs and
instead uses the following code flow:
- memory pages of an existing system memory buffer are pinned
- PFNs of the pages are sent to the host via a VM bus message
- the host maps the PFNs to get access to the memory

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/Makefile    |   2 +-
 drivers/hv/dxgkrnl/dxgkrnl.h   |   2 +
 drivers/hv/dxgkrnl/dxgmodule.c |  30 ++++++-
 drivers/hv/dxgkrnl/dxgvmbus.c  | 145 +++++++++++++++++++++++----------
 drivers/hv/dxgkrnl/dxgvmbus.h  |  10 +++
 drivers/hv/dxgkrnl/ioctl.c     |   7 +-
 drivers/hv/dxgkrnl/misc.c      |   6 ++
 drivers/hv/dxgkrnl/misc.h      |   1 +
 8 files changed, 153 insertions(+), 50 deletions(-)

diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
index 9d821e83448a..fc85a47a6ad5 100644
--- a/drivers/hv/dxgkrnl/Makefile
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the hyper-v compute device driver (dxgkrnl).
 
 obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
-dxgkrnl-y		:= dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
+dxgkrnl-y := dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index de6333fdada6..2dfbdc4487e1 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -305,6 +305,7 @@ struct dxgglobal {
 	bool			pci_registered;
 	bool			global_channel_initialized;
 	bool			async_msg_enabled;
+	bool			map_guest_pages_enabled;
 };
 
 extern struct dxgglobal		*dxgglobal;
@@ -837,6 +838,7 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 				     struct
 				     d3dkmt_waitforsynchronizationobjectfromcpu
 				     *args,
+				     bool user_address,
 				     u64 cpu_event);
 int dxgvmb_send_lock2(struct dxgprocess *process,
 		      struct dxgadapter *adapter,
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index cfef880a512d..468c9b5dd43f 100644
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
index 49c36d86c9bf..da92bc53becb 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1374,15 +1374,18 @@ int create_existing_sysmem(struct dxgdevice *device,
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
@@ -1393,6 +1396,7 @@ int create_existing_sysmem(struct dxgdevice *device,
 	pr_debug("   Alloc size: %lld", alloc_size);
 
 	dxgalloc->cpu_address = (void *)sysmem;
+
 	dxgalloc->pages = vzalloc(npages * sizeof(void *));
 	if (dxgalloc->pages == NULL) {
 		pr_err("failed to allocate pages");
@@ -1410,31 +1414,80 @@ int create_existing_sysmem(struct dxgdevice *device,
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
@@ -2748,6 +2801,7 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 				     struct
 				     d3dkmt_waitforsynchronizationobjectfromcpu
 				     *args,
+				     bool user_address,
 				     u64 cpu_event)
 {
 	int ret = -EINVAL;
@@ -2771,18 +2825,25 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
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
index 3eda60da013d..74f57ead10d7 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -234,6 +234,16 @@ struct dxgkvmb_command_setexistingsysmemstore {
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
index b2fd3d55d72a..92e1031ba652 100644
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
@@ -3536,7 +3531,7 @@ dxgk_wait_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
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

