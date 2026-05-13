Return-Path: <linux-hyperv+bounces-10854-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPEILr7IBGqnOgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10854-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:53:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A645395A0
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1113D309AD0C
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE9339281B;
	Wed, 13 May 2026 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nToiu0K6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76D3ACF15;
	Wed, 13 May 2026 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698253; cv=none; b=mfxTgRvBGas39GTPG6PmY8NQRvflrOXbd4BLX0zzbtlavb6gsHkNdsIFP/tULBvFPa9433nmkY9Ge5tadXWb7dXksB0frGcVgfri6eiuvAC7m9Ayva+Oqsn7UdCuKWL5/7xDWlrEKeXlFSolOZ7CQB1ZSIjOcx+RRrd5p5O5cCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698253; c=relaxed/simple;
	bh=7G4l8D5sCjM+U0YP9SJUlkCscUAxiErxx/pAYy82FHY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afbD6vnRirjgq25dXOZVapPQboKyuwBAMS2Sqhpr3HzP6acuLxY/isdu4OXDDy9dPgrTD0rFoijLDb+sO+/SPmD2FNEEEx1vPfaCpRDX6lU/PKMIOwPu6MYndjP8u2VMA9t3pjALXVFEbri99P/gHEJ6Ps0hJbCt7SSqeUgtMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nToiu0K6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1930120B7166;
	Wed, 13 May 2026 11:50:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1930120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698249;
	bh=kxX5mxiHXu13jvA4ACQP4QOJ/g388j+0n9Av8rpN378=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nToiu0K6rLOn0ogcPhVqdLxyHwKQCylsPtlN0ZTIiaybuzQnIbVAuPRv0uNXLkhvw
	 h66qT/SUEgFUu4yKEHZ/tChJp+SB7skUO3/Knlzmu72SLYnEGCPnHuXUcTS8Owu2l1
	 I96hTR5wlYL7qDLMOKp7Cw0blDm3NIpM6zNGg88g=
Subject: [PATCH v3 06/11] mshv: Iterate VMAs when faulting in region pages
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:50:51 +0000
Message-ID: 
 <177869825173.18773.4607760400762394290.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30A645395A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10854-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

mshv_region_hmm_fault_and_lock() called hmm_range_fault() once for the
entire requested range. hmm_range_fault() can only handle a single VMA per
call, so a region whose user address range spans multiple VMAs fails the
fault even though each individual VMA is fault-able.

Walk the requested range VMA by VMA under mmap_read_lock and call
hmm_range_fault() for each [vma->vm_start, vma->vm_end) ∩ [start, end)
segment. The mmu notifier sequence is captured once before the loop, so a
writer racing with the multi-VMA fault is still detected at the closing
mmu_interval_read_retry().

Tighten the read-only gate added in 3f8e229cb787 ("mshv: Don't request HMM
write fault for read-only regions") so HMM_PFN_REQ_WRITE is requested only
when both the region (HV_MAP_GPA_WRITABLE) and the backing VMA (VM_WRITE)
permit writes. Without the per-VMA check, a writable region whose
underlying VMA is read-only would still trigger COW on the host's read-only
pages.

While here, restructure mshv_region_hmm_fault_and_lock() to take the range
as (start, end, pfns) directly rather than a populated hmm_range; the
struct is now constructed inside the function since its fields are
recomputed per VMA.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   97 +++++++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 35 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 579a29f2924b8..807fff43deb43 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -447,37 +447,76 @@ int mshv_region_get(struct mshv_mem_region *region)
 }
 
 /**
- * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memory region
+ * mshv_region_hmm_fault_and_lock - Fault in pages across VMAs and lock
+ *                                  the memory region
  * @region: Pointer to the memory region structure
- * @range: Pointer to the HMM range structure
+ * @start : Starting virtual address of the range to fault (inclusive)
+ * @end   : Ending virtual address of the range to fault (exclusive)
+ * @pfns  : Output array for page frame numbers with HMM flags
  *
- * This function performs the following steps:
- * 1. Reads the notifier sequence for the HMM range.
- * 2. Acquires a read lock on the memory map.
- * 3. Handles HMM faults for the specified range.
- * 4. Releases the read lock on the memory map.
- * 5. If successful, locks the memory region mutex.
- * 6. Verifies if the notifier sequence has changed during the operation.
- *    If it has, releases the mutex and returns -EBUSY to match with
- *    hmm_range_fault() return code for repeating.
+ * Iterates through VMAs covering [start, end), faulting in pages via
+ * hmm_range_fault() for each VMA segment.  Write faults are requested
+ * only when both the VMA and the hypervisor mapping permit writes, to
+ * avoid breaking copy-on-write semantics on read-only mappings.
  *
- * Return: 0 on success, a negative error code otherwise.
+ * On success, returns with region->mreg_mutex held; the caller is
+ * responsible for releasing it.  Returns -EBUSY if the mmu notifier
+ * sequence changed during the operation, signalling the caller to retry.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
 static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
-					  struct hmm_range *range)
+					  unsigned long start,
+					  unsigned long end,
+					  unsigned long *pfns)
 {
+	struct hmm_range range = {
+		.notifier = &region->mreg_mni,
+	};
+	struct mm_struct *mm = region->mreg_mni.mm;
 	int ret;
 
-	range->notifier_seq = mmu_interval_read_begin(range->notifier);
-	mmap_read_lock(region->mreg_mni.mm);
-	ret = hmm_range_fault(range);
-	mmap_read_unlock(region->mreg_mni.mm);
+	range.notifier_seq = mmu_interval_read_begin(range.notifier);
+	mmap_read_lock(mm);
+	while (start < end) {
+		struct vm_area_struct *vma;
+
+		vma = vma_lookup(mm, start);
+		if (!vma) {
+			ret = -EFAULT;
+			break;
+		}
+
+		range.hmm_pfns = pfns;
+		range.start = start;
+		range.end = min(vma->vm_end, end);
+		range.default_flags = HMM_PFN_REQ_FAULT;
+		/*
+		 * Only request writable pages from HMM when both the
+		 * VMA and the hypervisor mapping allow writes.  Without
+		 * this, hmm_range_fault() would trigger COW on read-only
+		 * mappings (e.g. shared zero pages, file-backed pages),
+		 * breaking copy-on-write semantics and potentially
+		 * granting the guest write access to shared host pages.
+		 */
+		if ((vma->vm_flags & VM_WRITE) &&
+		    (region->hv_map_flags & HV_MAP_GPA_WRITABLE))
+			range.default_flags |= HMM_PFN_REQ_WRITE;
+
+		ret = hmm_range_fault(&range);
+		if (ret)
+			break;
+
+		start = range.end;
+		pfns += (range.end - range.start) >> PAGE_SHIFT;
+	}
+	mmap_read_unlock(mm);
 	if (ret)
 		return ret;
 
 	mutex_lock(&region->mreg_mutex);
 
-	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
+	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
 		mutex_unlock(&region->mreg_mutex);
 		cond_resched();
 		return -EBUSY;
@@ -501,10 +540,7 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
 static int mshv_region_range_fault(struct mshv_mem_region *region,
 				   u64 pfn_offset, u64 pfn_count)
 {
-	struct hmm_range range = {
-		.notifier = &region->mreg_mni,
-		.default_flags = HMM_PFN_REQ_FAULT,
-	};
+	unsigned long start, end;
 	unsigned long *pfns;
 	int ret;
 	u64 i;
@@ -513,21 +549,12 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 	if (!pfns)
 		return -ENOMEM;
 
-	range.hmm_pfns = pfns;
-	range.start = region->start_uaddr + pfn_offset * HV_HYP_PAGE_SIZE;
-	range.end = range.start + pfn_count * HV_HYP_PAGE_SIZE;
-
-	/*
-	 * Only request writable pages from HMM when the region itself
-	 * permits writes.  Without this, hmm_range_fault() would
-	 * trigger COW on read-only regions, breaking copy-on-write
-	 * semantics on shared host pages.
-	 */
-	if (region->hv_map_flags & HV_MAP_GPA_WRITABLE)
-		range.default_flags |= HMM_PFN_REQ_WRITE;
+	start = region->start_uaddr + pfn_offset * HV_HYP_PAGE_SIZE;
+	end = start + pfn_count * HV_HYP_PAGE_SIZE;
 
 	do {
-		ret = mshv_region_hmm_fault_and_lock(region, &range);
+		ret = mshv_region_hmm_fault_and_lock(region, start, end,
+						     pfns);
 	} while (ret == -EBUSY);
 
 	if (ret)



