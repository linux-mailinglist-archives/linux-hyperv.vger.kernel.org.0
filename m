Return-Path: <linux-hyperv+bounces-10857-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K9WNzjJBGqnOgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10857-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:55:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5689A539648
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDF73304293E
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3043AE6E2;
	Wed, 13 May 2026 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W1BW8fv+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CAF3ACF15;
	Wed, 13 May 2026 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698270; cv=none; b=t3UY1HhVRCHFNGZkHXCxQj5Stc5alGPXpNKfu9PtcWQhSzyYI2yZRaSlHOioDRibpMjrEwQzJsSf8SP1/+j7L6f9akgLMGgn0QkPad6eQzkgzp6eak8by9OZHcFY9ZDGuEbVDEd+nEqWjvK1PXOXp/tOjkICjzVquR10k/TE4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698270; c=relaxed/simple;
	bh=GwhWhqJxT7S/orVQGwYHglttCo7jDxBSvj68DRVTVVc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sme0C35Ub8h1lrc4oQdHtf6WBAy55k61I4lLAzBtl0hohDRuZbgQx+5BONR0KBKNo2Vnan84EFzv2YVbYe7Oe3HgHsVmzAyYDkpMKIK4ceQ11bdNtRJqhvO5vXM5XeV7uOIm1w15Oc0CEf8oJHf3LKft+W6qzYtR3qUMSRacSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=W1BW8fv+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id AAC5520B7166;
	Wed, 13 May 2026 11:51:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAC5520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698265;
	bh=7QYydHr2iqwnEFVbaL8tahbM7WsLP4i9Gtj/lv5AV7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=W1BW8fv+ThydarNwdwbNPacDi0lkZX+bh0PBwkY2URKqAOi3+tAuXQtaTM80Gu/d/
	 90L/jdKR6kCuoVSJC6NQrePJaB8L7z4mJOopSDVsbjUh/H4jdF3EIiKg3m6aV6fpIo
	 OFtZB4NID+12+CJ1NQPSmHM7CLzY75dImUi8wadU=
Subject: [PATCH v3 09/11] mshv: Map populated pages on movable region creation
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:51:08 +0000
Message-ID: 
 <177869826832.18773.13988378662894007753.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5689A539648
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10857-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

Map any populated pages into the hypervisor upfront when creating a
movable region, rather than waiting for faults. Previously, movable
regions were created with all pages marked as HV_MAP_GPA_NO_ACCESS
regardless of whether the userspace mapping contained populated pages.

This guarantees that if the caller passes a populated mapping, those
present pages will be mapped into the hypervisor immediately during
region creation instead of being faulted in later.

Pages that are present but not writable in host page tables (e.g.
shared zero pages) are left as no-access mappings to preserve copy-on-write
semantics; they will be faulted in on demand.

The region is processed in bounded chunks to avoid soft lockups and
livelock from concurrent invalidations.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c   |  126 +++++++++++++++++++++++++++++++++----------
 drivers/hv/mshv_root.h      |    1 
 drivers/hv/mshv_root_main.c |   10 ---
 3 files changed, 98 insertions(+), 39 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index d9e33e9ef8550..85f8b7bddf939 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -17,8 +17,12 @@
 
 #include "mshv_root.h"
 
+/* Process memory regions in chunks to avoid soft lockups and livelock */
+#define MSHV_MAX_PFN_BATCH				(SZ_2M / PAGE_SIZE)
+
 #define MSHV_MAP_FAULT_IN_PAGES				\
 	(PTRS_PER_PMD * max_t(unsigned long, 1, PAGE_SIZE / HV_HYP_PAGE_SIZE))
+
 #define MSHV_INVALID_PFN				ULONG_MAX
 
 static inline bool mshv_pfn_valid(unsigned long pfn)
@@ -450,13 +454,16 @@ int mshv_region_get(struct mshv_mem_region *region)
 /**
  * mshv_region_hmm_fault_and_lock - Fault in pages across VMAs and lock
  *                                  the memory region
- * @region: Pointer to the memory region structure
- * @start : Starting virtual address of the range to fault (inclusive)
- * @end   : Ending virtual address of the range to fault (exclusive)
- * @pfns  : Output array for page frame numbers with HMM flags
+ * @region  : Pointer to the memory region structure
+ * @start   : Starting virtual address of the range to fault (inclusive)
+ * @end     : Ending virtual address of the range to fault (exclusive)
+ * @pfns    : Output array for page frame numbers with HMM flags
+ * @do_fault: If true, fault in missing pages; if false, snapshot only
+ *            pages already present in page tables
  *
- * Iterates through VMAs covering [start, end), faulting in pages via
- * hmm_range_fault() for each VMA segment.  Write faults are requested
+ * Iterates through VMAs covering [start, end), collecting page frame
+ * numbers via hmm_range_fault() for each VMA segment.  When @do_fault
+ * is true, missing pages are faulted in and write faults are requested
  * only when both the VMA and the hypervisor mapping permit writes, to
  * avoid breaking copy-on-write semantics on read-only mappings.
  *
@@ -469,7 +476,8 @@ int mshv_region_get(struct mshv_mem_region *region)
 static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
 					  unsigned long start,
 					  unsigned long end,
-					  unsigned long *pfns)
+					  unsigned long *pfns,
+					  bool do_fault)
 {
 	struct hmm_range range = {
 		.notifier = &region->mreg_mni,
@@ -491,18 +499,22 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
 		range.hmm_pfns = pfns;
 		range.start = start;
 		range.end = min(vma->vm_end, end);
-		range.default_flags = HMM_PFN_REQ_FAULT;
-		/*
-		 * Only request writable pages from HMM when both the
-		 * VMA and the hypervisor mapping allow writes.  Without
-		 * this, hmm_range_fault() would trigger COW on read-only
-		 * mappings (e.g. shared zero pages, file-backed pages),
-		 * breaking copy-on-write semantics and potentially
-		 * granting the guest write access to shared host pages.
-		 */
-		if ((vma->vm_flags & VM_WRITE) &&
-		    (region->hv_map_flags & HV_MAP_GPA_WRITABLE))
-			range.default_flags |= HMM_PFN_REQ_WRITE;
+		range.default_flags = 0;
+		if (do_fault) {
+			range.default_flags = HMM_PFN_REQ_FAULT;
+			/*
+			 * Only request writable pages from HMM when both
+			 * the VMA and the hypervisor mapping allow writes.
+			 * Without this, hmm_range_fault() would trigger
+			 * COW on read-only mappings (e.g. shared zero
+			 * pages, file-backed pages), breaking
+			 * copy-on-write semantics and potentially granting
+			 * the guest write access to shared host pages.
+			 */
+			if ((vma->vm_flags & VM_WRITE) &&
+			    (region->hv_map_flags & HV_MAP_GPA_WRITABLE))
+				range.default_flags |= HMM_PFN_REQ_WRITE;
+		}
 
 		ret = hmm_range_fault(&range);
 		if (ret)
@@ -527,19 +539,33 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
 }
 
 /**
- * mshv_region_range_fault - Handle memory range faults for a given region.
- * @region: Pointer to the memory region structure.
- * @pfn_offset: Offset of the page within the region.
- * @pfn_count: Number of pages to handle.
+ * mshv_region_collect_and_map - Collect PFNs for a user range and map them
+ * @region    : memory region being processed
+ * @pfn_offset: PFNs offset within the region
+ * @pfn_count : number of PFNs to process
+ * @do_fault  : if true, fault in missing pages;
+ *              if false, collect only present pages
  *
- * This function resolves memory faults for a specified range of pages
- * within a memory region. It uses HMM (Heterogeneous Memory Management)
- * to fault in the required pages and updates the region's page array.
+ * Collects PFNs for the specified portion of @region from the
+ * corresponding userspace VMAs and maps them into the hypervisor. The
+ * behavior depends on @do_fault:
  *
- * Return: 0 on success, negative error code on failure.
+ * - true: Fault in missing pages from userspace, ensuring all pages in the
+ *   range are present. Used for on-demand page population.
+ * - false: Collect PFNs only for pages already present in userspace,
+ *   leaving missing pages as invalid PFN markers.
+ *   Used for initial region setup.
+ *
+ * Collected PFNs are stored in region->mreg_pfns[] with HMM bookkeeping
+ * flags cleared, then the range is mapped into the hypervisor. Present
+ * PFNs get mapped with region access permissions; missing PFNs (invalid
+ * entries) get mapped with no-access permissions.
+ *
+ * Return: 0 on success, negative errno on failure.
  */
-static int mshv_region_range_fault(struct mshv_mem_region *region,
-				   u64 pfn_offset, u64 pfn_count)
+static int mshv_region_collect_and_map(struct mshv_mem_region *region,
+				       u64 pfn_offset, u64 pfn_count,
+				       bool do_fault)
 {
 	unsigned long start, end;
 	unsigned long *pfns;
@@ -555,7 +581,7 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 
 	do {
 		ret = mshv_region_hmm_fault_and_lock(region, start, end,
-						     pfns);
+						     pfns, do_fault);
 	} while (ret == -EBUSY);
 
 	if (ret)
@@ -564,6 +590,11 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 	for (i = 0; i < pfn_count; i++) {
 		if (!(pfns[i] & HMM_PFN_VALID))
 			continue;
+		/* Skip read-only pages to avoid bypassing COW */
+		if (!do_fault &&
+		    (region->hv_map_flags & HV_MAP_GPA_WRITABLE) &&
+		    !(pfns[i] & HMM_PFN_WRITE))
+			continue;
 		/* Drop HMM_PFN_* flags to ensure PFNs are valid. */
 		region->mreg_pfns[pfn_offset + i] = pfns[i] & ~HMM_PFN_FLAGS;
 	}
@@ -577,6 +608,13 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 	return ret;
 }
 
+static int mshv_region_range_fault(struct mshv_mem_region *region,
+				   u64 pfn_offset, u64 pfn_count)
+{
+	return mshv_region_collect_and_map(region, pfn_offset, pfn_count,
+					   true);
+}
+
 bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn)
 {
 	u64 pfn_offset, pfn_count;
@@ -764,3 +802,31 @@ int mshv_map_pinned_region(struct mshv_mem_region *region)
 err_out:
 	return ret;
 }
+
+/*
+ * mshv_map_movable_region - Map a movable memory region to the hypervisor
+ * @region: The memory region to map
+ *
+ * Maps the entire movable region by processing it in bounded chunks to avoid
+ * soft lockups from holding mmap_read_lock() too long and to prevent livelock
+ * if concurrent memory invalidations force restarts.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int mshv_map_movable_region(struct mshv_mem_region *region)
+{
+	u64 pfn, count;
+	int ret;
+
+	for (pfn = 0; pfn < region->nr_pfns; pfn += MSHV_MAX_PFN_BATCH) {
+		count = min_t(u64, MSHV_MAX_PFN_BATCH, region->nr_pfns - pfn);
+
+		ret = mshv_region_collect_and_map(region, pfn, count, false);
+		if (ret)
+			return ret;
+
+		cond_resched();
+	}
+
+	return 0;
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 2a4eff27917f2..0f4fc57a14cd0 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -378,5 +378,6 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 int mshv_map_pinned_region(struct mshv_mem_region *region);
+int mshv_map_movable_region(struct mshv_mem_region *region);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 4af2b98738ee2..e38438c539c5d 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1391,15 +1391,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		ret = mshv_map_pinned_region(region);
 		break;
 	case MSHV_REGION_TYPE_MEM_MOVABLE:
-		/*
-		 * For movable memory regions, remap with no access to let
-		 * the hypervisor track dirty pages, enabling pre-copy live
-		 * migration.
-		 */
-		ret = hv_call_map_ram_pfns(partition->pt_id,
-					   region->start_gfn,
-					   region->nr_pfns,
-					   HV_MAP_GPA_NO_ACCESS, NULL);
+		ret = mshv_map_movable_region(region);
 		break;
 	case MSHV_REGION_TYPE_MMIO:
 		ret = hv_call_map_mmio_pfns(partition->pt_id,



