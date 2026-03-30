Return-Path: <linux-hyperv+bounces-9836-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLJTO0jYymmWAgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9836-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:08:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A8E360D03
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 070E13062F97
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 20:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993E391E65;
	Mon, 30 Mar 2026 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a/PNUds4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB58382F12;
	Mon, 30 Mar 2026 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901071; cv=none; b=bUxCgU0q8XKxE0YeEg7sh9tLS2FTDkBpFuxVsZW/pN1ofggykWnR/utSlje/5b9ojQGNQft8BvO5qGo80yuiLyS7wov5f/jSWxWqtmNcQneqsTC2QkrHyt1MsHR6ktecj6cMqkN9pztmkNxSi+XCbr3CH+UWBPwWAJZBTJFq03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901071; c=relaxed/simple;
	bh=gHSnkVgPqF6FLccLXsfynRoTwWe0aBSt1sYySM6cRUE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0NERhdt1EvtxvsayqOTO7Jfu/2GickikBqVQ92a48vHTMzIPp03iheLFkxEjr6reWJso6wpjPc7qlrMbHWupc42N1d0mq4hJF2RNs/QPcu5fa7Vg6K2xQgj+5eU5xCkQL6BZcYWZ8ooGKTrZsq5y0A91upmOFglisBMnRaxcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a/PNUds4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3889D20B6F01;
	Mon, 30 Mar 2026 13:04:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3889D20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774901070;
	bh=N4cDM9RJLflH//yaxj4hPx6jJIrr7MZSE8WwG6t84oQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=a/PNUds4PZB6gzf4hVp/MzjY0bwTXJDrRt7gplLae8PmJMagFa8tFdG7jOE4BEggZ
	 PUjRVsN/jqO7z1uezVOXZBJK3kxa7xf9ibKkibW4izSCQ3YmN/ZJ2MNFiHy019mEVz
	 xLYuouHYzWgWVLGAuCxIzOUcY6E7KKrpUXw8zoK0=
Subject: [PATCH 3/7] mshv: Support regions with different VMAs
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 30 Mar 2026 20:04:29 +0000
Message-ID: 
 <177490106973.81669.17734971204992890360.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9836-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 56A8E360D03
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
 drivers/hv/mshv_regions.c |   72 +++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index ed9c55841140..1bb1bfe177e2 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -492,37 +492,72 @@ int mshv_region_get(struct mshv_mem_region *region)
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
+ * The function expects the range [start, end] is backed by valid VMAs.
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
 	int ret;
 
-	range->notifier_seq = mmu_interval_read_begin(range->notifier);
+	range.notifier_seq = mmu_interval_read_begin(range.notifier);
 	mmap_read_lock(region->mreg_mni.mm);
-	ret = hmm_range_fault(range);
+	while (start < end) {
+		struct vm_area_struct *vma;
+
+		vma = vma_lookup(current->mm, start);
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
+		start = range.end + 1;
+		pfns += DIV_ROUND_UP(range.end - range.start, PAGE_SIZE);
+	}
 	mmap_read_unlock(region->mreg_mni.mm);
 	if (ret)
 		return ret;
 
 	mutex_lock(&region->mreg_mutex);
 
-	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
+	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
 		mutex_unlock(&region->mreg_mutex);
 		cond_resched();
 		return -EBUSY;
@@ -546,10 +581,7 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
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
@@ -558,12 +590,12 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
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



