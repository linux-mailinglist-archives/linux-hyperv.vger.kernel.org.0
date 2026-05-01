Return-Path: <linux-hyperv+bounces-10543-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNS2APj/82n99QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10543-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 03:20:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF54A9944
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 03:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66267302F380
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF621E492D;
	Fri,  1 May 2026 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lkodVcL+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A232D6409;
	Fri,  1 May 2026 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598418; cv=none; b=JUNI/APBFYAC4GuyUF0ibsD1FWSXLAiStSbkqJepenku7FLMYB07uZwHAw3nMW1EEZC59Dnw+H85reYpv+YPDpVLxxggjQ56GrYyMX0/oZESJe6iKRWIOhKxnuIw8/N5ZwzkbWH4ojcfP5DR4XT/jX/+rSzmF9gCjduYOJbdprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598418; c=relaxed/simple;
	bh=9HF5Afvx5IUOLfZQpbfty7CpqEBsHOLufWqRJE1YAd8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnUKDaUR+SIMKosmtKWnkTWugGhsSG6fIEJNocwzlTFRFfvQOry7LPU139H2Mo/topBhhB+55Zv6d17CtIffvtbiEs4zurQU+Q66t6RsS4o6hasO9c15yZ5EjjueaJ6PZL8evgA7ka/chA5KKVOsbBGDS+Sc61YYcSqA40SxKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lkodVcL+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 60E8B20B7165;
	Thu, 30 Apr 2026 18:20:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60E8B20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777598415;
	bh=whyFbj0nqiCp1WYUzqSUPE+tBGDoPibJEA9HVyy+B+Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lkodVcL+t7p5idRS70Ba09XCVdeZVg2RpAXmGDb+5a+dHbsTKT28hk/bVv0jufvAt
	 u9MoANAzJG4G5PMRJla9o12rvxD25aHBH0W5Tyy4XFl9a8vvWJmnGC7Y3QoBxOVKoh
	 wORQbJzWb1/BB8BKZWdCIdJRTQxRA6vLvRGjHtIU=
Subject: [PATCH 2/3] mshv: Use hmm_range_fault_unlockable() for userfaultfd
 support
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 akpm@linux-foundation.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, corbet@lwn.net, leon@kernel.org,
 longli@microsoft.com, ljs@kernel.org, mhocko@suse.com, rppt@kernel.org,
 shuah@kernel.org, skhan@linuxfoundation.org, surenb@google.com,
 vbabka@kernel.org, wei.liu@kernel.org
Cc: linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Date: Fri, 01 May 2026 01:20:14 +0000
Message-ID: 
 <177759841468.221039.10642975915360903873.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177759835313.221039.2807391868456411507.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177759835313.221039.2807391868456411507.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 78FF54A9944
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10543-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]

Convert the mshv driver's HMM fault path to use
hmm_range_fault_unlockable() instead of hmm_range_fault(). This enables
userfaultfd-backed guest memory regions by allowing the mmap lock to be
dropped during page fault handling.

Extract the per-VMA walk into a dedicated mshv_region_hmm_fault_walk()
helper. The outer mshv_region_hmm_fault_and_lock() handles the do/while
restart loop: if the lock is dropped during a fault (userfaultfd resolution
or similar) or an invalidation occurs (-EBUSY), the function restarts the
entire walk from the beginning with a fresh notifier_seq, since the VMA
layout may have changed.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |  127 +++++++++++++++++++++++++++++++--------------
 1 file changed, 87 insertions(+), 40 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index d09940e88298e..05665446ca6d9 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -565,6 +565,75 @@ int mshv_region_get(struct mshv_region *region)
 	return kref_get_unless_zero(&region->mreg_refcount);
 }
 
+/**
+ * mshv_region_hmm_fault_walk - Walk VMAs and fault in pages for a range
+ * @region : Pointer to the memory region structure
+ * @range  : HMM range structure (caller sets notifier and notifier_seq)
+ * @start  : Starting virtual address of the range to fault (inclusive)
+ * @end    : Ending virtual address of the range to fault (exclusive)
+ * @pfns   : Output array for page frame numbers with HMM flags
+ * @locked : Pointer to lock state; set to 0 if mmap lock was dropped
+ * @do_fault: If true, fault in missing pages; if false, snapshot only
+ *
+ * Iterates through VMAs covering [start, end), collecting page frame
+ * numbers via hmm_range_fault_unlockable() for each VMA segment.
+ * When @do_fault is true, missing pages are faulted in and write faults
+ * are requested only when both the VMA and the hypervisor mapping permit
+ * writes, to avoid breaking copy-on-write semantics on read-only mappings.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int mshv_region_hmm_fault_walk(struct mshv_region *region,
+				      struct hmm_range *range,
+				      unsigned long start,
+				      unsigned long end,
+				      unsigned long *pfns,
+				      int *locked,
+				      bool do_fault)
+{
+	unsigned long cur_start = start;
+	unsigned long *cur_pfns = pfns;
+
+	while (cur_start < end) {
+		struct vm_area_struct *vma;
+
+		vma = vma_lookup(range->notifier->mm, cur_start);
+		if (!vma)
+			return -EFAULT;
+
+		range->hmm_pfns = cur_pfns;
+		range->start = cur_start;
+		range->end = min(vma->vm_end, end);
+		range->default_flags = 0;
+		if (do_fault) {
+			range->default_flags = HMM_PFN_REQ_FAULT;
+			/*
+			 * Only request writable pages from HMM when
+			 * both the VMA and the hypervisor mapping allow
+			 * writes. Without this, hmm_range_fault() would
+			 * trigger COW on read-only mappings (e.g. shared
+			 * zero pages, file-backed pages), breaking
+			 * copy-on-write semantics and potentially
+			 * granting the guest write access to shared host
+			 * pages.
+			 */
+			if ((vma->vm_flags & VM_WRITE) &&
+			    (region->hv_map_flags & HV_MAP_GPA_WRITABLE))
+				range->default_flags |= HMM_PFN_REQ_WRITE;
+		}
+
+		int ret = hmm_range_fault_unlockable(range, locked);
+
+		if (ret || !*locked)
+			return ret;
+
+		cur_start = range->end;
+		cur_pfns += (range->end - range->start) >> PAGE_SHIFT;
+	}
+
+	return 0;
+}
+
 /**
  * mshv_region_hmm_fault_and_lock - Fault in pages across VMAs and lock
  *                                  the memory region
@@ -575,11 +644,9 @@ int mshv_region_get(struct mshv_region *region)
  * @do_fault: If true, fault in missing pages; if false, snapshot only
  *            pages already present in page tables
  *
- * Iterates through VMAs covering [start, end), collecting page frame
- * numbers via hmm_range_fault() for each VMA segment.  When @do_fault
- * is true, missing pages are faulted in and write faults are requested
- * only when both the VMA and the hypervisor mapping permit writes, to
- * avoid breaking copy-on-write semantics on read-only mappings.
+ * Faults in pages covering [start, end) and acquires region->mreg_mutex.
+ * If the mmap lock is dropped during the fault (e.g. by userfaultfd) or
+ * the mmu notifier sequence is invalidated, the entire walk is restarted.
  *
  * On success, returns with region->mreg_mutex held; the caller is
  * responsible for releasing it.  Returns -EBUSY if the mmu notifier
@@ -597,47 +664,27 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_region *region,
 		.notifier = &region->mreg_mni,
 	};
 	struct mm_struct *mm = region->mreg_mni.mm;
+	int locked;
 	int ret;
 
-	range.notifier_seq = mmu_interval_read_begin(range.notifier);
-	mmap_read_lock(mm);
-	while (start < end) {
-		struct vm_area_struct *vma;
+	do {
+		range.notifier_seq = mmu_interval_read_begin(range.notifier);
+		locked = 1;
+		mmap_read_lock(mm);
 
-		vma = vma_lookup(mm, start);
-		if (!vma) {
-			ret = -EFAULT;
-			break;
-		}
+		ret = mshv_region_hmm_fault_walk(region, &range, start, end,
+						 pfns, &locked, do_fault);
 
-		range.hmm_pfns = pfns;
-		range.start = start;
-		range.end = min(vma->vm_end, end);
-		range.default_flags = 0;
-		if (do_fault) {
-			range.default_flags = HMM_PFN_REQ_FAULT;
-			/*
-			 * Only request writable pages from HMM when both
-			 * the VMA and the hypervisor mapping allow writes.
-			 * Without this, hmm_range_fault() would trigger
-			 * COW on read-only mappings (e.g. shared zero
-			 * pages, file-backed pages), breaking
-			 * copy-on-write semantics and potentially granting
-			 * the guest write access to shared host pages.
-			 */
-			if ((vma->vm_flags & VM_WRITE) &&
-			    (region->hv_map_flags & HV_MAP_GPA_WRITABLE))
-				range.default_flags |= HMM_PFN_REQ_WRITE;
-		}
+		if (locked)
+			mmap_read_unlock(mm);
 
-		ret = hmm_range_fault(&range);
-		if (ret)
-			break;
+		/*
+		 * If the lock was dropped (by userfaultfd or similar), restart
+		 * the entire walk with a fresh notifier_seq since the VMA layout
+		 * may have changed. Also restart on -EBUSY (invalidation).
+		 */
+	} while (!locked || ret == -EBUSY);
 
-		start = range.end;
-		pfns += (range.end - range.start) >> PAGE_SHIFT;
-	}
-	mmap_read_unlock(mm);
 	if (ret)
 		return ret;
 



