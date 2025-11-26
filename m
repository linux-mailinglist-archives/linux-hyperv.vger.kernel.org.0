Return-Path: <linux-hyperv+bounces-7832-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA54C87C85
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 03:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53430354C85
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 02:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA0530BF70;
	Wed, 26 Nov 2025 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c2Rb11nm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE18A30BF6B;
	Wed, 26 Nov 2025 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764122971; cv=none; b=mOTIYzBqCHq8VOtoG5pBOaRbS/SByjZ9WYqDyAaT10WnaUvToQGx3ewzUy/AO1XDC7wd8Txb3ITzfXJMLC8vJuIWepegu7mg3HxvNHnR/f53k3Zc4gZ0j0XGb00uPSNzdlX2kb96frkgx33Wi//5bgqGyNMgOU7slbPGmFTFZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764122971; c=relaxed/simple;
	bh=ajTxZRnjWRFB53pp9io6sTH9Q1zCIwQ5GQyD3voQl4E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChFu4969vW6+ds3/mKKMBEXSifnu6+CFhv+v6dRt4cFzaQcn+7Kobr8cW3G+Z4FwY6SsePGyNuQ10cAHVaUgVhb3yMbNuLMGaBY3lfe4unFyDfoCuy3gVS0d6J00JYOW5k8bkFYl83aMqIp7awy2Udz1ld7WnbP9TRqpZT85nBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c2Rb11nm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8D98F2120EA8;
	Tue, 25 Nov 2025 18:09:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D98F2120EA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764122968;
	bh=FYBW7BaRY7osgovjtgjBeV+H/w5HPmmwUssK1vm/nl8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=c2Rb11nmE+NoW/69qd4Qx6II3Fmf+KQooJEhhM0CXZDsUZfJZXReLk8+Mrk2EEJ0p
	 bxeU1OSX1A8B9auOj/bKGryBTevzZ7IjqUcEpaxp727PTlv6uGLSLQ3FRYZ2sJfV3l
	 x+03SZ4Vq7mx7XE1P8K5v39iRXV4yiLwIS646ScA=
Subject: [PATCH v7 7/7] Drivers: hv: Add support for movable memory regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Nov 2025 02:09:28 +0000
Message-ID: 
 <176412296844.447063.13441447034735423517.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Introduce support for movable memory regions in the Hyper-V root partition
driver to improve memory management flexibility and enable advanced use
cases such as dynamic memory remapping.

Mirror the address space between the Linux root partition and guest VMs
using HMM. The root partition owns the memory, while guest VMs act as
devices with page tables managed via hypercalls. MSHV handles VP intercepts
by invoking hmm_range_fault() and updating SLAT entries. When memory is
reclaimed, HMM invalidates the relevant regions, prompting MSHV to clear
SLAT entries; guest VMs will fault again on access.

Integrate mmu_interval_notifier for movable regions, implement handlers for
HMM faults and memory invalidation, and update memory region mapping logic
to support movable regions.

While MMU notifiers are commonly used in virtualization drivers, this
implementation leverages HMM (Heterogeneous Memory Management) for its
specialized functionality. HMM provides a framework for mirroring,
invalidation, and fault handling, reducing boilerplate and improving
maintainability compared to generic MMU notifiers.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/Kconfig          |    2 
 drivers/hv/mshv_regions.c   |  215 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/hv/mshv_root.h      |   17 +++
 drivers/hv/mshv_root_main.c |  139 +++++++++++++++++++++++-----
 4 files changed, 343 insertions(+), 30 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index d4a8d349200c..7937ac0cbd0f 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -76,6 +76,8 @@ config MSHV_ROOT
 	depends on PAGE_SIZE_4KB
 	select EVENTFD
 	select VIRT_XFER_TO_GUEST_WORK
+	select HMM_MIRROR
+	select MMU_NOTIFIER
 	default n
 	help
 	  Select this option to enable support for booting and running as root
diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 6450a7ed8493..d7b0f012c3be 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -7,6 +7,8 @@
  * Authors: Microsoft Linux virtualization team
  */
 
+#include <linux/hmm.h>
+#include <linux/hyperv.h>
 #include <linux/kref.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
@@ -15,6 +17,8 @@
 
 #include "mshv_root.h"
 
+#define MSHV_MAP_FAULT_IN_PAGES				PTRS_PER_PMD
+
 /**
  * mshv_region_process_chunk - Processes a contiguous chunk of memory pages
  *                             in a region.
@@ -152,9 +156,6 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
 		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
 
-	if (!is_mmio)
-		region->flags.range_pinned = true;
-
 	kref_init(&region->refcount);
 
 	return region;
@@ -239,7 +240,7 @@ int mshv_region_map(struct mshv_mem_region *region)
 static void mshv_region_invalidate_pages(struct mshv_mem_region *region,
 					 u64 page_offset, u64 page_count)
 {
-	if (region->flags.range_pinned)
+	if (region->type == MSHV_REGION_TYPE_MEM_PINNED)
 		unpin_user_pages(region->pages + page_offset, page_count);
 
 	memset(region->pages + page_offset, 0,
@@ -313,6 +314,9 @@ static void mshv_region_destroy(struct kref *ref)
 	struct mshv_partition *partition = region->partition;
 	int ret;
 
+	if (region->type == MSHV_REGION_TYPE_MEM_MOVABLE)
+		mshv_region_movable_fini(region);
+
 	if (mshv_partition_encrypted(partition)) {
 		ret = mshv_region_share(region);
 		if (ret) {
@@ -339,3 +343,206 @@ int mshv_region_get(struct mshv_mem_region *region)
 {
 	return kref_get_unless_zero(&region->refcount);
 }
+
+/**
+ * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memory region
+ * @region: Pointer to the memory region structure
+ * @range: Pointer to the HMM range structure
+ *
+ * This function performs the following steps:
+ * 1. Reads the notifier sequence for the HMM range.
+ * 2. Acquires a read lock on the memory map.
+ * 3. Handles HMM faults for the specified range.
+ * 4. Releases the read lock on the memory map.
+ * 5. If successful, locks the memory region mutex.
+ * 6. Verifies if the notifier sequence has changed during the operation.
+ *    If it has, releases the mutex and returns -EBUSY to match with
+ *    hmm_range_fault() return code for repeating.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
+					  struct hmm_range *range)
+{
+	int ret;
+
+	range->notifier_seq = mmu_interval_read_begin(range->notifier);
+	mmap_read_lock(region->mni.mm);
+	ret = hmm_range_fault(range);
+	mmap_read_unlock(region->mni.mm);
+	if (ret)
+		return ret;
+
+	mutex_lock(&region->mutex);
+
+	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
+		mutex_unlock(&region->mutex);
+		cond_resched();
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+/**
+ * mshv_region_range_fault - Handle memory range faults for a given region.
+ * @region: Pointer to the memory region structure.
+ * @page_offset: Offset of the page within the region.
+ * @page_count: Number of pages to handle.
+ *
+ * This function resolves memory faults for a specified range of pages
+ * within a memory region. It uses HMM (Heterogeneous Memory Management)
+ * to fault in the required pages and updates the region's page array.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int mshv_region_range_fault(struct mshv_mem_region *region,
+				   u64 page_offset, u64 page_count)
+{
+	struct hmm_range range = {
+		.notifier = &region->mni,
+		.default_flags = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
+	};
+	unsigned long *pfns;
+	int ret;
+	u64 i;
+
+	pfns = kmalloc_array(page_count, sizeof(unsigned long), GFP_KERNEL);
+	if (!pfns)
+		return -ENOMEM;
+
+	range.hmm_pfns = pfns;
+	range.start = region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
+	range.end = range.start + page_count * HV_HYP_PAGE_SIZE;
+
+	do {
+		ret = mshv_region_hmm_fault_and_lock(region, &range);
+	} while (ret == -EBUSY);
+
+	if (ret)
+		goto out;
+
+	for (i = 0; i < page_count; i++)
+		region->pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
+
+	ret = mshv_region_remap_pages(region, region->hv_map_flags,
+				      page_offset, page_count);
+
+	mutex_unlock(&region->mutex);
+out:
+	kfree(pfns);
+	return ret;
+}
+
+bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn)
+{
+	u64 page_offset, page_count;
+	int ret;
+
+	/* Align the page offset to the nearest MSHV_MAP_FAULT_IN_PAGES. */
+	page_offset = ALIGN_DOWN(gfn - region->start_gfn,
+				 MSHV_MAP_FAULT_IN_PAGES);
+
+	/* Map more pages than requested to reduce the number of faults. */
+	page_count = min(region->nr_pages - page_offset,
+			 MSHV_MAP_FAULT_IN_PAGES);
+
+	ret = mshv_region_range_fault(region, page_offset, page_count);
+
+	WARN_ONCE(ret,
+		  "p%llu: GPA intercept failed: region %#llx-%#llx, gfn %#llx, page_offset %llu, page_count %llu\n",
+		  region->partition->pt_id, region->start_uaddr,
+		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
+		  gfn, page_offset, page_count);
+
+	return !ret;
+}
+
+/**
+ * mshv_region_interval_invalidate - Invalidate a range of memory region
+ * @mni: Pointer to the mmu_interval_notifier structure
+ * @range: Pointer to the mmu_notifier_range structure
+ * @cur_seq: Current sequence number for the interval notifier
+ *
+ * This function invalidates a memory region by remapping its pages with
+ * no access permissions. It locks the region's mutex to ensure thread safety
+ * and updates the sequence number for the interval notifier. If the range
+ * is blockable, it uses a blocking lock; otherwise, it attempts a non-blocking
+ * lock and returns false if unsuccessful.
+ *
+ * NOTE: Failure to invalidate a region is a serious error, as the pages will
+ * be considered freed while they are still mapped by the hypervisor.
+ * Any attempt to access such pages will likely crash the system.
+ *
+ * Return: true if the region was successfully invalidated, false otherwise.
+ */
+static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
+					    const struct mmu_notifier_range *range,
+					    unsigned long cur_seq)
+{
+	struct mshv_mem_region *region = container_of(mni,
+						      struct mshv_mem_region,
+						      mni);
+	u64 page_offset, page_count;
+	unsigned long mstart, mend;
+	int ret = -EPERM;
+
+	if (mmu_notifier_range_blockable(range))
+		mutex_lock(&region->mutex);
+	else if (!mutex_trylock(&region->mutex))
+		goto out_fail;
+
+	mmu_interval_set_seq(mni, cur_seq);
+
+	mstart = max(range->start, region->start_uaddr);
+	mend = min(range->end, region->start_uaddr +
+		   (region->nr_pages << HV_HYP_PAGE_SHIFT));
+
+	page_offset = HVPFN_DOWN(mstart - region->start_uaddr);
+	page_count = HVPFN_DOWN(mend - mstart);
+
+	ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
+				      page_offset, page_count);
+	if (ret)
+		goto out_fail;
+
+	mshv_region_invalidate_pages(region, page_offset, page_count);
+
+	mutex_unlock(&region->mutex);
+
+	return true;
+
+out_fail:
+	WARN_ONCE(ret,
+		  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u, pages %#llx-%#llx, mm: %#llx): %d\n",
+		  region->start_uaddr,
+		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
+		  range->start, range->end, range->event,
+		  page_offset, page_offset + page_count - 1, (u64)range->mm, ret);
+	return false;
+}
+
+static const struct mmu_interval_notifier_ops mshv_region_mni_ops = {
+	.invalidate = mshv_region_interval_invalidate,
+};
+
+void mshv_region_movable_fini(struct mshv_mem_region *region)
+{
+	mmu_interval_notifier_remove(&region->mni);
+}
+
+bool mshv_region_movable_init(struct mshv_mem_region *region)
+{
+	int ret;
+
+	ret = mmu_interval_notifier_insert(&region->mni, current->mm,
+					   region->start_uaddr,
+					   region->nr_pages << HV_HYP_PAGE_SHIFT,
+					   &mshv_region_mni_ops);
+	if (ret)
+		return false;
+
+	mutex_init(&region->mutex);
+
+	return true;
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 4249534ba900..9cd76076d490 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -15,6 +15,7 @@
 #include <linux/hashtable.h>
 #include <linux/dev_printk.h>
 #include <linux/build_bug.h>
+#include <linux/mmu_notifier.h>
 #include <uapi/linux/mshv.h>
 
 /*
@@ -70,6 +71,12 @@ do { \
 #define vp_info(v, fmt, ...)	vp_devprintk(info, v, fmt, ##__VA_ARGS__)
 #define vp_dbg(v, fmt, ...)	vp_devprintk(dbg, v, fmt, ##__VA_ARGS__)
 
+enum mshv_region_type {
+	MSHV_REGION_TYPE_MEM_PINNED,
+	MSHV_REGION_TYPE_MEM_MOVABLE,
+	MSHV_REGION_TYPE_MMIO
+};
+
 struct mshv_mem_region {
 	struct hlist_node hnode;
 	struct kref refcount;
@@ -77,11 +84,10 @@ struct mshv_mem_region {
 	u64 start_gfn;
 	u64 start_uaddr;
 	u32 hv_map_flags;
-	struct {
-		u64 range_pinned: 1;
-		u64 reserved:	 63;
-	} flags;
 	struct mshv_partition *partition;
+	enum mshv_region_type type;
+	struct mmu_interval_notifier mni;
+	struct mutex mutex;	/* protects region pages remapping */
 	struct page *pages[];
 };
 
@@ -324,5 +330,8 @@ void mshv_region_invalidate(struct mshv_mem_region *region);
 int mshv_region_pin(struct mshv_mem_region *region);
 void mshv_region_put(struct mshv_mem_region *region);
 int mshv_region_get(struct mshv_mem_region *region);
+bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
+void mshv_region_movable_fini(struct mshv_mem_region *region);
+bool mshv_region_movable_init(struct mshv_mem_region *region);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 1ef2a28beb17..6003fb4477bc 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -594,14 +594,98 @@ static long mshv_run_vp_with_root_scheduler(struct mshv_vp *vp)
 static_assert(sizeof(struct hv_message) <= MSHV_RUN_VP_BUF_SZ,
 	      "sizeof(struct hv_message) must not exceed MSHV_RUN_VP_BUF_SZ");
 
+static struct mshv_mem_region *
+mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
+{
+	struct mshv_mem_region *region;
+
+	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
+		if (gfn >= region->start_gfn &&
+		    gfn < region->start_gfn + region->nr_pages)
+			return region;
+	}
+
+	return NULL;
+}
+
+#ifdef CONFIG_X86_64
+static struct mshv_mem_region *
+mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
+{
+	struct mshv_mem_region *region;
+
+	spin_lock(&p->pt_mem_regions_lock);
+	region = mshv_partition_region_by_gfn(p, gfn);
+	if (!region || !mshv_region_get(region)) {
+		spin_unlock(&p->pt_mem_regions_lock);
+		return NULL;
+	}
+	spin_unlock(&p->pt_mem_regions_lock);
+
+	return region;
+}
+
+/**
+ * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) intercepts.
+ * @vp: Pointer to the virtual processor structure.
+ *
+ * This function processes GPA intercepts by identifying the memory region
+ * corresponding to the intercepted GPA, aligning the page offset, and
+ * mapping the required pages. It ensures that the region is valid and
+ * handles faults efficiently by mapping multiple pages at once.
+ *
+ * Return: true if the intercept was handled successfully, false otherwise.
+ */
+static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
+{
+	struct mshv_partition *p = vp->vp_partition;
+	struct mshv_mem_region *region;
+	struct hv_x64_memory_intercept_message *msg;
+	bool ret;
+	u64 gfn;
+
+	msg = (struct hv_x64_memory_intercept_message *)
+		vp->vp_intercept_msg_page->u.payload;
+
+	gfn = HVPFN_DOWN(msg->guest_physical_address);
+
+	region = mshv_partition_region_by_gfn_get(p, gfn);
+	if (!region)
+		return false;
+
+	/* Only movable memory ranges are supported for GPA intercepts */
+	if (region->type == MSHV_REGION_TYPE_MEM_MOVABLE)
+		ret = mshv_region_handle_gfn_fault(region, gfn);
+	else
+		ret = false;
+
+	mshv_region_put(region);
+
+	return ret;
+}
+#else  /* CONFIG_X86_64 */
+static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
+#endif /* CONFIG_X86_64 */
+
+static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
+{
+	switch (vp->vp_intercept_msg_page->header.message_type) {
+	case HVMSG_GPA_INTERCEPT:
+		return mshv_handle_gpa_intercept(vp);
+	}
+	return false;
+}
+
 static long mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *ret_msg)
 {
 	long rc;
 
-	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
-		rc = mshv_run_vp_with_root_scheduler(vp);
-	else
-		rc = mshv_run_vp_with_hyp_scheduler(vp);
+	do {
+		if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
+			rc = mshv_run_vp_with_root_scheduler(vp);
+		else
+			rc = mshv_run_vp_with_hyp_scheduler(vp);
+	} while (rc == 0 && mshv_vp_handle_intercept(vp));
 
 	if (rc)
 		return rc;
@@ -1059,20 +1143,6 @@ static void mshv_async_hvcall_handler(void *data, u64 *status)
 	*status = partition->async_hypercall_status;
 }
 
-static struct mshv_mem_region *
-mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
-{
-	struct mshv_mem_region *region;
-
-	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
-		if (gfn >= region->start_gfn &&
-		    gfn < region->start_gfn + region->nr_pages)
-			return region;
-	}
-
-	return NULL;
-}
-
 /*
  * NB: caller checks and makes sure mem->size is page aligned
  * Returns: 0 with regionpp updated on success, or -errno
@@ -1100,6 +1170,14 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 	if (IS_ERR(rg))
 		return PTR_ERR(rg);
 
+	if (is_mmio)
+		rg->type = MSHV_REGION_TYPE_MMIO;
+	else if (mshv_partition_encrypted(partition) ||
+		 !mshv_region_movable_init(rg))
+		rg->type = MSHV_REGION_TYPE_MEM_PINNED;
+	else
+		rg->type = MSHV_REGION_TYPE_MEM_MOVABLE;
+
 	rg->partition = partition;
 
 	*regionpp = rg;
@@ -1215,11 +1293,28 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	if (ret)
 		return ret;
 
-	if (is_mmio)
-		ret = hv_call_map_mmio_pages(partition->pt_id, mem.guest_pfn,
-					     mmio_pfn, HVPFN_DOWN(mem.size));
-	else
+	switch (region->type) {
+	case MSHV_REGION_TYPE_MEM_PINNED:
 		ret = mshv_prepare_pinned_region(region);
+		break;
+	case MSHV_REGION_TYPE_MEM_MOVABLE:
+		/*
+		 * For movable memory regions, remap with no access to let
+		 * the hypervisor track dirty pages, enabling pre-copy live
+		 * migration.
+		 */
+		ret = hv_call_map_gpa_pages(partition->pt_id,
+					    region->start_gfn,
+					    region->nr_pages,
+					    HV_MAP_GPA_NO_ACCESS, NULL);
+		break;
+	case MSHV_REGION_TYPE_MMIO:
+		ret = hv_call_map_mmio_pages(partition->pt_id,
+					     region->start_gfn,
+					     mmio_pfn,
+					     region->nr_pages);
+		break;
+	}
 
 	if (ret)
 		goto errout;



