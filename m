Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E393E1DD7
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 23:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhHEVYv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 17:24:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46544 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhHEVYs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 17:24:48 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 89D2E20B36F4;
        Thu,  5 Aug 2021 14:24:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89D2E20B36F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628198673;
        bh=j0d6G/idjyJRdfhFI31uez3gehF7wRmkmi/9IM8qet0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1J6WuV1bqXeReIiVmFIzMuZ5m+gekNIBhMocuq1CwuNhhUck+q3FAjxa++5hViCn
         uYuOM2oiJfQepoBjs3ow32g/unP+XTP/QR0jjSaIi7TxMNYpgHgpUHSS4dB3TBh3UI
         Sio6lPrwX1HMYiQK0wSJILvqT5WU5XRGCH8iib18=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH 08/19] drivers/hv: map and unmap guest memory
Date:   Thu,  5 Aug 2021 14:23:50 -0700
Message-Id: <1628198641-791-9-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce ioctls for mapping and unmapping regions of guest memory.

Uses a table of memory 'slots' similar to KVM, but the slot
number is not visible to userspace.

For now, this simple implementation requires each new mapping to be
disjoint - the underlying hypercalls have no such restriction, and
implicitly overwrite any mappings on the pages in the specified regions.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst        |  17 +++
 drivers/hv/hv_call.c                   | 114 +++++++++++++++
 drivers/hv/mshv.h                      |  13 ++
 drivers/hv/mshv_main.c                 | 194 ++++++++++++++++++++++++-
 include/asm-generic/hyperv-tlfs.h      |  23 ++-
 include/linux/mshv.h                   |  14 ++
 include/uapi/asm-generic/hyperv-tlfs.h |   9 ++
 include/uapi/linux/mshv.h              |  15 ++
 8 files changed, 394 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index f92892b27ccc..71c93b73e999 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -70,3 +70,20 @@ will be supported when the core API is stable.
 This ioctl creates a guest partition, returning a file descriptor to use as a
 handle for partition ioctls.
 
+3.3 MSHV_MAP_GUEST_MEMORY and MSHV_UNMAP_GUEST_MEMORY
+-----------------------------------------------------
+:Type: partition ioctl
+:Parameters: struct mshv_user_mem_region
+:Returns: 0 on success
+
+Create a mapping from memory in the user space of the calling process (running
+in the root partition) to a region of guest physical memory in a guest partition.
+
+Mappings must be disjoint from each other in both userspace and guest physical
+address space.
+
+Note: In the current implementation, this memory is pinned to real physical
+memory to stop the pages being moved by Linux in the root partition,
+and subsequently being clobbered by the hypervisor. So the region is backed
+by real physical memory.
+
diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
index a22b1cfb3563..31d59de4a7f7 100644
--- a/drivers/hv/hv_call.c
+++ b/drivers/hv/hv_call.c
@@ -180,3 +180,117 @@ int hv_call_delete_partition(u64 partition_id)
 	return hv_status_to_errno(status);
 }
 
+int hv_call_map_gpa_pages(
+		u64 partition_id,
+		u64 gpa_target,
+		u64 page_count, u32 flags,
+		struct page **pages)
+{
+	struct hv_map_gpa_pages *input_page;
+	u64 status;
+	int i;
+	struct page **p;
+	u32 completed = 0;
+	unsigned long remaining = page_count;
+	int rep_count;
+	unsigned long irq_flags;
+	int ret = 0;
+
+	while (remaining) {
+
+		rep_count = min(remaining, HV_MAP_GPA_BATCH_SIZE);
+
+		local_irq_save(irq_flags);
+		input_page = (struct hv_map_gpa_pages *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
+
+		input_page->target_partition_id = partition_id;
+		input_page->target_gpa_base = gpa_target;
+		input_page->map_flags = flags;
+
+		for (i = 0, p = pages; i < rep_count; i++, p++)
+			input_page->source_gpa_page_list[i] = page_to_pfn(*p);
+		status = hv_do_rep_hypercall(
+			HVCALL_MAP_GPA_PAGES, rep_count, 0, input_page, NULL);
+		local_irq_restore(irq_flags);
+
+		completed = hv_repcomp(status);
+
+		if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
+			ret = hv_call_deposit_pages(NUMA_NO_NODE,
+						    partition_id,
+						    HV_MAP_GPA_DEPOSIT_PAGES);
+			if (ret)
+				break;
+		} else if (!hv_result_success(status)) {
+			pr_err("%s: completed %llu out of %llu, %s\n",
+			       __func__,
+			       page_count - remaining, page_count,
+			       hv_status_to_string(status));
+			ret = hv_status_to_errno(status);
+			break;
+		}
+
+		pages += completed;
+		remaining -= completed;
+		gpa_target += completed;
+	}
+
+	if (ret && remaining < page_count) {
+		pr_err("%s: Partially succeeded; mapped regions may be in invalid state",
+		       __func__);
+		ret = -EBADFD;
+	}
+
+	return ret;
+}
+
+int hv_call_unmap_gpa_pages(
+		u64 partition_id,
+		u64 gpa_target,
+		u64 page_count, u32 flags)
+{
+	struct hv_unmap_gpa_pages *input_page;
+	u64 status;
+	int ret = 0;
+	u32 completed = 0;
+	unsigned long remaining = page_count;
+	int rep_count;
+	unsigned long irq_flags;
+
+	while (remaining) {
+		local_irq_save(irq_flags);
+		input_page = (struct hv_unmap_gpa_pages *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
+
+		input_page->target_partition_id = partition_id;
+		input_page->target_gpa_base = gpa_target;
+		input_page->unmap_flags = flags;
+		rep_count = min(remaining, HV_MAP_GPA_BATCH_SIZE);
+		status = hv_do_rep_hypercall(
+			HVCALL_UNMAP_GPA_PAGES, rep_count, 0, input_page, NULL);
+		local_irq_restore(irq_flags);
+
+		completed = hv_repcomp(status);
+		if (!hv_result_success(status)) {
+			pr_err("%s: completed %llu out of %llu, %s\n",
+			       __func__,
+			       page_count - remaining, page_count,
+			       hv_status_to_string(status));
+			ret = hv_status_to_errno(status);
+			break;
+		}
+
+		remaining -= completed;
+		gpa_target += completed;
+	}
+
+	if (ret && remaining < page_count) {
+		pr_err("%s: Partially succeeded; mapped regions may be in invalid state",
+		       __func__);
+		ret = -EBADFD;
+	}
+
+	return ret;
+}
+
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index cf48ec5840b7..13d9df7c3e0d 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -15,8 +15,12 @@
 
 /* Determined empirically */
 #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
+#define HV_MAP_GPA_DEPOSIT_PAGES	256
 
 #define HV_WITHDRAW_BATCH_SIZE	(HV_HYP_PAGE_SIZE / sizeof(u64))
+#define HV_MAP_GPA_BATCH_SIZE	\
+		((HV_HYP_PAGE_SIZE - sizeof(struct hv_map_gpa_pages)) / sizeof(u64))
+#define PIN_PAGES_BATCH_SIZE	(0x10000000 / HV_HYP_PAGE_SIZE)
 
 /*
  * Hyper-V hypercalls
@@ -30,5 +34,14 @@ int hv_call_create_partition(
 int hv_call_initialize_partition(u64 partition_id);
 int hv_call_finalize_partition(u64 partition_id);
 int hv_call_delete_partition(u64 partition_id);
+int hv_call_map_gpa_pages(
+		u64 partition_id,
+		u64 gpa_target,
+		u64 page_count, u32 flags,
+		struct page **pages);
+int hv_call_unmap_gpa_pages(
+		u64 partition_id,
+		u64 gpa_target,
+		u64 page_count, u32 flags);
 
 #endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 67126afaa6e9..816ab64c1260 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -53,16 +53,194 @@ static struct miscdevice mshv_dev = {
 	.mode = 0600,
 };
 
+static long
+mshv_partition_ioctl_map_memory(struct mshv_partition *partition,
+				struct mshv_user_mem_region __user *user_mem)
+{
+	struct mshv_user_mem_region mem;
+	struct mshv_mem_region *region;
+	int completed;
+	unsigned long remaining, batch_size;
+	int i;
+	struct page **pages;
+	u64 page_count, user_start, user_end, gpfn_start, gpfn_end;
+	u64 region_page_count, region_user_start, region_user_end;
+	u64 region_gpfn_start, region_gpfn_end;
+	long ret = 0;
+
+	/* Check we have enough slots*/
+	if (partition->regions.count == MSHV_MAX_MEM_REGIONS) {
+		pr_err("%s: not enough memory region slots\n", __func__);
+		return -ENOSPC;
+	}
+
+	if (copy_from_user(&mem, user_mem, sizeof(mem)))
+		return -EFAULT;
+
+	if (!mem.size ||
+	    !PAGE_ALIGNED(mem.size) ||
+	    !PAGE_ALIGNED(mem.userspace_addr) ||
+	    !access_ok(mem.userspace_addr, mem.size))
+		return -EINVAL;
+
+	/* Reject overlapping regions */
+	page_count = mem.size >> HV_HYP_PAGE_SHIFT;
+	user_start = mem.userspace_addr;
+	user_end = mem.userspace_addr + mem.size;
+	gpfn_start = mem.guest_pfn;
+	gpfn_end = mem.guest_pfn + page_count;
+	for (i = 0; i < MSHV_MAX_MEM_REGIONS; ++i) {
+		region = &partition->regions.slots[i];
+		if (!region->size)
+			continue;
+		region_page_count = region->size >> HV_HYP_PAGE_SHIFT;
+		region_user_start = region->userspace_addr;
+		region_user_end = region->userspace_addr + region->size;
+		region_gpfn_start = region->guest_pfn;
+		region_gpfn_end = region->guest_pfn + region_page_count;
+
+		if (!(user_end <= region_user_start) &&
+		    !(region_user_end <= user_start)) {
+			return -EEXIST;
+		}
+		if (!(gpfn_end <= region_gpfn_start) &&
+		    !(region_gpfn_end <= gpfn_start)) {
+			return -EEXIST;
+		}
+	}
+
+	/* Pin the userspace pages */
+	pages = vzalloc(sizeof(struct page *) * page_count);
+	if (!pages)
+		return -ENOMEM;
+
+	remaining = page_count;
+	while (remaining) {
+		/*
+		 * We need to batch this, as pin_user_pages_fast with the
+		 * FOLL_LONGTERM flag does a big temporary allocation
+		 * of contiguous memory
+		 */
+		batch_size = min(remaining, PIN_PAGES_BATCH_SIZE);
+		completed = pin_user_pages_fast(
+				mem.userspace_addr + (page_count - remaining) * HV_HYP_PAGE_SIZE,
+				batch_size,
+				FOLL_WRITE | FOLL_LONGTERM,
+				&pages[page_count - remaining]);
+		if (completed < 0) {
+			pr_err("%s: failed to pin user pages error %i\n",
+			       __func__,
+			       completed);
+			ret = completed;
+			goto err_unpin_pages;
+		}
+		remaining -= completed;
+	}
+
+	/* Map the pages to GPA pages */
+	ret = hv_call_map_gpa_pages(partition->id, mem.guest_pfn,
+				    page_count, mem.flags, pages);
+	if (ret)
+		goto err_unpin_pages;
+
+	/* Install the new region */
+	for (i = 0; i < MSHV_MAX_MEM_REGIONS; ++i) {
+		if (!partition->regions.slots[i].size) {
+			region = &partition->regions.slots[i];
+			break;
+		}
+	}
+	region->pages = pages;
+	region->size = mem.size;
+	region->guest_pfn = mem.guest_pfn;
+	region->userspace_addr = mem.userspace_addr;
+
+	partition->regions.count++;
+
+	return 0;
+
+err_unpin_pages:
+	unpin_user_pages(pages, page_count - remaining);
+	vfree(pages);
+
+	return ret;
+}
+
+static long
+mshv_partition_ioctl_unmap_memory(struct mshv_partition *partition,
+				  struct mshv_user_mem_region __user *user_mem)
+{
+	struct mshv_user_mem_region mem;
+	struct mshv_mem_region *region_ptr;
+	int i;
+	u64 page_count;
+	long ret;
+
+	if (!partition->regions.count)
+		return -EINVAL;
+
+	if (copy_from_user(&mem, user_mem, sizeof(mem)))
+		return -EFAULT;
+
+	/* Find matching region */
+	for (i = 0; i < MSHV_MAX_MEM_REGIONS; ++i) {
+		if (!partition->regions.slots[i].size)
+			continue;
+		region_ptr = &partition->regions.slots[i];
+		if (region_ptr->userspace_addr == mem.userspace_addr &&
+		    region_ptr->size == mem.size &&
+		    region_ptr->guest_pfn == mem.guest_pfn)
+			break;
+	}
+
+	if (i == MSHV_MAX_MEM_REGIONS)
+		return -EINVAL;
+
+	page_count = region_ptr->size >> HV_HYP_PAGE_SHIFT;
+	ret = hv_call_unmap_gpa_pages(partition->id, region_ptr->guest_pfn,
+				      page_count, 0);
+	if (ret)
+		return ret;
+
+	unpin_user_pages(region_ptr->pages, page_count);
+	vfree(region_ptr->pages);
+	memset(region_ptr, 0, sizeof(*region_ptr));
+	partition->regions.count--;
+
+	return 0;
+}
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
-	return -ENOTTY;
+	struct mshv_partition *partition = filp->private_data;
+	long ret;
+
+	if (mutex_lock_killable(&partition->mutex))
+		return -EINTR;
+
+	switch (ioctl) {
+	case MSHV_MAP_GUEST_MEMORY:
+		ret = mshv_partition_ioctl_map_memory(partition,
+							(void __user *)arg);
+		break;
+	case MSHV_UNMAP_GUEST_MEMORY:
+		ret = mshv_partition_ioctl_unmap_memory(partition,
+							(void __user *)arg);
+		break;
+	default:
+		ret = -ENOTTY;
+	}
+
+	mutex_unlock(&partition->mutex);
+	return ret;
 }
 
 static void
 destroy_partition(struct mshv_partition *partition)
 {
-	unsigned long flags;
+	unsigned long flags, page_count;
+	struct mshv_mem_region *region;
 	int i;
 
 	/* Remove from list of partitions */
@@ -94,6 +272,16 @@ destroy_partition(struct mshv_partition *partition)
 
 	hv_call_delete_partition(partition->id);
 
+	/* Remove regions and unpin the pages */
+	for (i = 0; i < MSHV_MAX_MEM_REGIONS; ++i) {
+		region = &partition->regions.slots[i];
+		if (!region->size)
+			continue;
+		page_count = region->size >> HV_HYP_PAGE_SHIFT;
+		unpin_user_pages(region->pages, page_count);
+		vfree(region->pages);
+	}
+
 	kfree(partition);
 }
 
@@ -161,6 +349,8 @@ mshv_ioctl_create_partition(void __user *user_arg)
 	if (!partition)
 		return -ENOMEM;
 
+	mutex_init(&partition->mutex);
+
 	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
 		ret = fd;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 2e1573978569..8684e7f9ec5b 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -20,9 +20,9 @@
  * guest physical pages and guest physical page addresses, since the guest page
  * size may not be 4096 on all architectures.
  */
-#define HV_HYP_PAGE_SHIFT      12
-#define HV_HYP_PAGE_SIZE       BIT(HV_HYP_PAGE_SHIFT)
-#define HV_HYP_PAGE_MASK       (~(HV_HYP_PAGE_SIZE - 1))
+#define HV_HYP_PAGE_SHIFT		12
+#define HV_HYP_PAGE_SIZE		BIT(HV_HYP_PAGE_SHIFT)
+#define HV_HYP_PAGE_MASK		(~(HV_HYP_PAGE_SIZE - 1))
 
 /*
  * Hyper-V provides two categories of flags relevant to guest VMs.  The
@@ -150,6 +150,8 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_GET_PARTITION_ID			0x0046
 #define HVCALL_DEPOSIT_MEMORY			0x0048
 #define HVCALL_WITHDRAW_MEMORY			0x0049
+#define HVCALL_MAP_GPA_PAGES			0x004b
+#define HVCALL_UNMAP_GPA_PAGES			0x004c
 #define HVCALL_CREATE_VP			0x004e
 #define HVCALL_GET_VP_REGISTERS			0x0050
 #define HVCALL_SET_VP_REGISTERS			0x0051
@@ -886,4 +888,19 @@ struct hv_delete_partition {
 	u64 partition_id;
 } __packed;
 
+struct hv_map_gpa_pages {
+	u64 target_partition_id;
+	u64 target_gpa_base;
+	u32 map_flags;
+	u32 padding;
+	u64 source_gpa_page_list[];
+} __packed;
+
+struct hv_unmap_gpa_pages {
+	u64 target_partition_id;
+	u64 target_gpa_base;
+	u32 unmap_flags;
+	u32 padding;
+} __packed;
+
 #endif
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index fc4f35089b2c..91a742f37440 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -7,13 +7,27 @@
  */
 
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <uapi/linux/mshv.h>
 
 #define MSHV_MAX_PARTITIONS		128
+#define MSHV_MAX_MEM_REGIONS		64
+
+struct mshv_mem_region {
+	u64 size; /* bytes */
+	u64 guest_pfn;
+	u64 userspace_addr; /* start of the userspace allocated memory */
+	struct page **pages;
+};
 
 struct mshv_partition {
 	u64 id;
 	refcount_t ref_count;
+	struct mutex mutex;
+	struct {
+		u32 count;
+		struct mshv_mem_region slots[MSHV_MAX_MEM_REGIONS];
+	} regions;
 };
 
 struct mshv {
diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
index 7a858226a9c5..e7b09b9f00de 100644
--- a/include/uapi/asm-generic/hyperv-tlfs.h
+++ b/include/uapi/asm-generic/hyperv-tlfs.h
@@ -12,4 +12,13 @@
 #define HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED          BIT(4)
 #define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED                    BIT(13)
 
+/* HV Map GPA (Guest Physical Address) Flags */
+#define HV_MAP_GPA_PERMISSIONS_NONE     0x0
+#define HV_MAP_GPA_READABLE             0x1
+#define HV_MAP_GPA_WRITABLE             0x2
+#define HV_MAP_GPA_KERNEL_EXECUTABLE    0x4
+#define HV_MAP_GPA_USER_EXECUTABLE      0x8
+#define HV_MAP_GPA_EXECUTABLE           0xC
+#define HV_MAP_GPA_PERMISSIONS_MASK     0xF
+
 #endif
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 03b1ed66245d..7ead5f1c8b14 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -19,10 +19,25 @@ struct mshv_create_partition {
 	struct hv_partition_creation_properties partition_creation_properties;
 };
 
+/*
+ * Mappings can't overlap in GPA space or userspace
+ * To unmap, these fields must match an existing mapping
+ */
+struct mshv_user_mem_region {
+	__u64 size;		/* bytes */
+	__u64 guest_pfn;
+	__u64 userspace_addr;	/* start of the userspace allocated memory */
+	__u32 flags;		/* ignored on unmap */
+};
+
 #define MSHV_IOCTL 0xB8
 
 /* mshv device */
 #define MSHV_CHECK_EXTENSION    _IOW(MSHV_IOCTL, 0x00, __u32)
 #define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x01, struct mshv_create_partition)
 
+/* partition device */
+#define MSHV_MAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x02, struct mshv_user_mem_region)
+#define MSHV_UNMAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x03, struct mshv_user_mem_region)
+
 #endif
-- 
2.23.4

