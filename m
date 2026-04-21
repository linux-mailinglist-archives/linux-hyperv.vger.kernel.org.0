Return-Path: <linux-hyperv+bounces-10277-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOUtAWuN52m89wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10277-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:44:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 755D043C3D5
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5811F3098BBF
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0A63D88F1;
	Tue, 21 Apr 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pmoRimXr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353583D88FE;
	Tue, 21 Apr 2026 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782132; cv=none; b=J6F1vlFZKjhruHoqUD6cJiPOrzzQ6R51MGk4wQZDdT1ag0OmATO1oW+cnMwpYRCMgwsErGPjzj1HX2SYr21/ptn21Xn2gifPfW4pTJum0Pf2sUtrw0uIuBwOt4QaYI2Hsk6EmhgDz03I3WCf8HbfSu9n9jB3urY4xqkzTrxGhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782132; c=relaxed/simple;
	bh=5/zTIWErFZaCdTXN3dE8jPAuhT2G0sor2EJBRFnExuQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQzrhDgKDJHVBijkyxv+EZrQkIFDtd0cmNPvUv2DoLPvyMAAioV52TeClOKrAGjWweAT0mh4qK402bh322/NYhEViavCxMHHNWnqPyrG7QrM++VjRSrTc3XwydRTLyVvgpJKr6HWSqxELauZy0b4g7GEyoH634k/KslYFoi3KNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pmoRimXr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 22A9D20B6F01;
	Tue, 21 Apr 2026 07:35:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22A9D20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776782131;
	bh=q5WOcXtZgX8bk4krzSDppA5MTEx/Av2lwtCitlfMXFs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pmoRimXrAtwyWtM8EgWqIdXU2oJehIyMOxhFq1KpQtXi7NS2F7FYg49KAnRaF34bR
	 fjoTjBe2sNcy5zw4AE5le7eIkMav3/oRTbT7pviSlJc4CluSPQLfgFV+oMbU4ZR4dI
	 L9uey7M4N4kymI+MPmTJw0H4XBNZ1hjX9GeTBNAg=
Subject: [PATCH v2 3/7] mshv: Support regions with different VMAs
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Apr 2026 14:35:30 +0000
Message-ID: 
 <177678213054.13344.2853583033004177508.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10277-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: 755D043C3D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow HMM fault handling across memory regions that span multiple VMAs
with different protection flags. The previous implementation assumed a
single VMA per region, which would fail when guest memory crosses VMA
boundaries.

Iterate through VMAs within the range and handle each separately with
appropriate protection flags, enabling more flexible memory region
configurations for partitions.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   77 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 22 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 48f035ee0bc1..e4edbd4ced00 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -492,37 +492,73 @@ int mshv_region_get(struct mshv_mem_region *region)
 }
 
 /**
- * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memory region
+ * mshv_region_hmm_fault_and_lock - Handle HMM faults across VMAs and lock
+ *                                  the memory region
  * @region: Pointer to the memory region structure
- * @range: Pointer to the HMM range structure
+ * @start : Starting virtual address of the range to fault
+ * @end   : Ending virtual address of the range to fault (exclusive)
+ * @pfns  : Output array for page frame numbers with HMM flags
  *
  * This function performs the following steps:
  * 1. Reads the notifier sequence for the HMM range.
  * 2. Acquires a read lock on the memory map.
- * 3. Handles HMM faults for the specified range.
- * 4. Releases the read lock on the memory map.
- * 5. If successful, locks the memory region mutex.
- * 6. Verifies if the notifier sequence has changed during the operation.
- *    If it has, releases the mutex and returns -EBUSY to match with
- *    hmm_range_fault() return code for repeating.
+ * 3. Iterates through VMAs in the specified range, handling each
+ *    separately with appropriate protection flags (HMM_PFN_REQ_WRITE set
+ *    based on VMA flags).
+ * 4. Handles HMM faults for each VMA segment.
+ * 5. Releases the read lock on the memory map.
+ * 6. If successful, locks the memory region mutex.
+ * 7. Verifies if the notifier sequence has changed during the operation.
+ *    If it has, releases the mutex and returns -EBUSY to signal retry.
+ *
+ * The function expects the range [start, end) is backed by valid VMAs.
+ * Returns -EFAULT if any address in the range is not covered by a VMA.
  *
  * Return: 0 on success, a negative error code otherwise.
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
+		if (vma->vm_flags & VM_WRITE)
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
@@ -546,10 +582,7 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
 static int mshv_region_range_fault(struct mshv_mem_region *region,
 				   u64 pfn_offset, u64 pfn_count)
 {
-	struct hmm_range range = {
-		.notifier = &region->mreg_mni,
-		.default_flags = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
-	};
+	unsigned long start, end;
 	unsigned long *pfns;
 	int ret;
 	u64 i;
@@ -558,12 +591,12 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 	if (!pfns)
 		return -ENOMEM;
 
-	range.hmm_pfns = pfns;
-	range.start = region->start_uaddr + pfn_offset * HV_HYP_PAGE_SIZE;
-	range.end = range.start + pfn_count * HV_HYP_PAGE_SIZE;
+	start = region->start_uaddr + pfn_offset * PAGE_SIZE;
+	end = start + pfn_count * PAGE_SIZE;
 
 	do {
-		ret = mshv_region_hmm_fault_and_lock(region, &range);
+		ret = mshv_region_hmm_fault_and_lock(region, start, end,
+						     pfns);
 	} while (ret == -EBUSY);
 
 	if (ret)



