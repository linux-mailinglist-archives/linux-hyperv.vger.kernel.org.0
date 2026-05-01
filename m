Return-Path: <linux-hyperv+bounces-10542-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGF2DeH/82n99QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10542-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 03:20:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940404A9911
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 03:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A6C3026141
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 01:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F3528504D;
	Fri,  1 May 2026 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jc/GnM0a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC12D2483;
	Fri,  1 May 2026 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598412; cv=none; b=MVDPyemAqnzovnRd0b2SYWUgtNdcPZ8jeS8KNdw46B6Ag1EvOkDwoA/8aDpoaHwuzXWHbcX1q7E8f79glX5G4tlut7qjGqtmeewwxoZyfd7StWm1Q34lw/UnRABhunUAHXa4J8bhz4zWWkvEvrBLiXyX807MtLOzbD3PSW3kpyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598412; c=relaxed/simple;
	bh=W3s7n7JPzlH3zsec/moByoNlBWG9mSeXYAbhywmpPXc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTfqyb+xio+9/CEjcs4xBU/7AnpLZ6ynzbAZ8Mh9voThOqpBNNuG+vwACoL1yeWezI+YAKweM+j4ZYwGyR8lQxBx4tty4w65d8PXFVvdEZMjdPV/ATrWp8aH5DOYdR6QDZ8BZNwp+GInOsTKdgJnHAhXAIOQyfaOfAYAhJ/jFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jc/GnM0a; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4894420B7167;
	Thu, 30 Apr 2026 18:20:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4894420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777598409;
	bh=kRsLTv87kjl9U9FBe0FqBtheFWVulOe+BilE8+AXiG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jc/GnM0a229OK0yqyS9JHp1/dyHl3TuNCDaUBaeloO6LHrfLm/JHH5VHkaBL450wS
	 uCilPAlCFFwwBOSq9mpscLUDv7E3yfNS3mmk2FCVr3xRe8c4IarHY5k5n/x5wMfSME
	 fGbE4bjINe+27FgoBHCJRzq37U+gcUAKdGKctpSE=
Subject: [PATCH 1/3] mm/hmm: Add hmm_range_fault_unlockable() for mmap
 lock-drop support
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
Date: Fri, 01 May 2026 01:20:08 +0000
Message-ID: 
 <177759840859.221039.13065406062747296947.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 940404A9911
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
	TAGGED_FROM(0.00)[bounces-10542-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]

Add hmm_range_fault_unlockable(), a new HMM entry point that allows the
mmap read lock to be dropped during page faults. This follows the
int *locked pattern from get_user_pages_remote() in mm/gup.c: callers
pass an int *locked variable indicating they can handle the lock being
dropped.

When locked is non-NULL, hmm_vma_fault() adds FAULT_FLAG_ALLOW_RETRY
and FAULT_FLAG_KILLABLE to the fault flags passed to handle_mm_fault().
If the fault handler drops the mmap lock (returning VM_FAULT_RETRY or
VM_FAULT_COMPLETED), the function sets *locked = 0 and returns 0,
signalling the caller to restart its walk with a fresh notifier
sequence. Fatal signals are checked before returning, matching GUP
behavior. The caller is responsible for re-acquiring the lock and
restarting from the beginning, since previously collected PFNs may be
stale after the lock was dropped.

The existing hmm_range_fault() is refactored into a thin wrapper that
calls hmm_range_fault_unlockable(range, NULL). Passing NULL means
FAULT_FLAG_ALLOW_RETRY is never set, preserving existing behavior for
all current callers with no functional change.

Faulting hugetlb pages is not supported on the unlockable path: if a
hugetlb page requires faulting, -EFAULT is returned. This is because
walk_hugetlb_range() holds hugetlb_vma_lock_read across the callback
and unconditionally unlocks on return; if the mmap lock is dropped
inside the callback the VMA may be freed, making the walk framework's
unlock a use-after-free. Hugetlb pages already present in page tables
are handled normally.

Documentation/mm/hmm.rst is updated with a new section describing the
unlockable API, its usage pattern, and the hugetlb limitation.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 Documentation/mm/hmm.rst |   89 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hmm.h      |    1 +
 mm/hmm.c                 |   91 +++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 172 insertions(+), 9 deletions(-)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index 7d61b7a8b65b7..13874b4dfd5f4 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -208,6 +208,95 @@ invalidate() callback. That lock must be held before calling
 mmu_interval_read_retry() to avoid any race with a concurrent CPU page table
 update.
 
+Scalable lock-drop support (hmm_range_fault_unlockable)
+=======================================================
+
+Some page fault handlers (e.g., userfaultfd) require the mmap lock to be
+dropped during fault resolution. Drivers that need to support such mappings
+can use::
+
+  int hmm_range_fault_unlockable(struct hmm_range *range, int *locked);
+
+This follows the same ``int *locked`` pattern used by ``get_user_pages_remote()``
+in ``mm/gup.c``. The caller sets ``*locked = 1`` and holds the mmap read lock
+before calling. If the lock is dropped during the fault (VM_FAULT_RETRY or
+VM_FAULT_COMPLETED), the function returns 0 with ``*locked = 0``, signalling
+the caller to restart its walk with a fresh notifier sequence. The caller is
+responsible for re-acquiring the lock and restarting from the beginning, since
+previously collected PFNs may be stale.
+
+The usage pattern is::
+
+ int driver_populate_range_unlockable(...)
+ {
+      struct hmm_range range;
+      int locked;
+      ...
+
+      range.notifier = &interval_sub;
+      range.start = ...;
+      range.end = ...;
+      range.hmm_pfns = ...;
+
+      if (!mmget_not_zero(interval_sub->notifier.mm))
+          return -EFAULT;
+
+ again:
+      range.notifier_seq = mmu_interval_read_begin(&interval_sub);
+      locked = 1;
+      mmap_read_lock(mm);
+      ret = hmm_range_fault_unlockable(&range, &locked);
+      if (locked)
+          mmap_read_unlock(mm);
+      if (ret) {
+          if (ret == -EBUSY)
+                 goto again;
+          return ret;
+      }
+      if (!locked)
+          goto again;
+
+      take_lock(driver->update);
+      if (mmu_interval_read_retry(&ni, range.notifier_seq) {
+          release_lock(driver->update);
+          goto again;
+      }
+
+      /* Use pfns array content to update device page table,
+       * under the update lock */
+
+      release_lock(driver->update);
+      return 0;
+ }
+
+Passing ``locked = NULL`` to ``hmm_range_fault_unlockable()`` is equivalent to
+calling ``hmm_range_fault()`` — the lock will never be dropped.
+
+Note: hugetlb pages are not supported with the unlockable path. If a hugetlb
+page requires faulting during an ``hmm_range_fault_unlockable()`` call,
+``-EFAULT`` is returned. Hugetlb pages that are already present in page tables
+are handled normally.
+
+This limitation exists because ``walk_hugetlb_range()`` in the page walk
+framework holds ``hugetlb_vma_lock_read`` across the callback and unconditionally
+unlocks on return. If the mmap lock is dropped inside the callback (via
+VM_FAULT_RETRY), the VMA may be freed before the walk framework's unlock,
+resulting in a use-after-free. Possible approaches to lift this limitation in
+the future:
+
+1. Extend the walk framework to allow callbacks to signal that the hugetlb vma
+   lock was dropped (e.g., a flag in ``struct mm_walk`` that tells
+   ``walk_hugetlb_range()`` to skip the unlock).
+
+2. Bypass ``walk_page_range()`` for hugetlb pages in the unlockable path and
+   walk hugetlb page tables directly with custom lock management (similar to
+   how GUP handles hugetlb without the walk framework).
+
+3. Re-acquire the mmap lock before returning from the hugetlb callback (like
+   ``fixup_user_fault()``), ensuring the VMA remains valid for the walk
+   framework's unlock. This changes the "never re-take" contract and would
+   require callers to handle hugetlb differently.
+
 Leverage default_flags and pfn_flags_mask
 =========================================
 
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index db75ffc949a7a..46e581865c48a 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -123,6 +123,7 @@ struct hmm_range {
  * Please see Documentation/mm/hmm.rst for how to use the range API.
  */
 int hmm_range_fault(struct hmm_range *range);
+int hmm_range_fault_unlockable(struct hmm_range *range, int *locked);
 
 /*
  * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
diff --git a/mm/hmm.c b/mm/hmm.c
index 5955f2f0c83db..9bf2fa37f2efd 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -33,6 +33,7 @@
 struct hmm_vma_walk {
 	struct hmm_range	*range;
 	unsigned long		last;
+	int			*locked;
 };
 
 enum {
@@ -86,10 +87,28 @@ static int hmm_vma_fault(unsigned long addr, unsigned long end,
 		fault_flags |= FAULT_FLAG_WRITE;
 	}
 
-	for (; addr < end; addr += PAGE_SIZE)
-		if (handle_mm_fault(vma, addr, fault_flags, NULL) &
-		    VM_FAULT_ERROR)
+	if (hmm_vma_walk->locked)
+		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		vm_fault_t ret;
+
+		ret = handle_mm_fault(vma, addr, fault_flags, NULL);
+
+		if (ret & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)) {
+			/*
+			 * The mmap lock has been dropped by the fault handler.
+			 * Record the failing address and signal lock-drop to
+			 * the caller.
+			 */
+			*hmm_vma_walk->locked = 0;
+			hmm_vma_walk->last = addr;
+			return -EAGAIN;
+		}
+
+		if (ret & VM_FAULT_ERROR)
 			return -EFAULT;
+	}
 	return -EBUSY;
 }
 
@@ -566,6 +585,17 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	if (required_fault) {
 		int ret;
 
+		/*
+		 * Faulting hugetlb pages on the unlockable path is not
+		 * supported. The walk framework holds hugetlb_vma_lock_read
+		 * which must be dropped before handle_mm_fault, but if the
+		 * mmap lock is also dropped (VM_FAULT_RETRY), the vma may
+		 * be freed and the walk framework's unconditional unlock
+		 * becomes a use-after-free.
+		 */
+		if (hmm_vma_walk->locked)
+			return -EFAULT;
+
 		spin_unlock(ptl);
 		hugetlb_vma_unlock_read(vma);
 		/*
@@ -655,14 +685,49 @@ static const struct mm_walk_ops hmm_walk_ops = {
  *
  * This is similar to get_user_pages(), except that it can read the page tables
  * without mutating them (ie causing faults).
+ *
+ * The mmap lock must be held by the caller and will remain held on return.
+ * For a variant that allows the mmap lock to be dropped during faults (e.g.,
+ * for userfaultfd support), see hmm_range_fault_unlockable().
  */
 int hmm_range_fault(struct hmm_range *range)
 {
+	return hmm_range_fault_unlockable(range, NULL);
+}
+EXPORT_SYMBOL(hmm_range_fault);
+
+/**
+ * hmm_range_fault_unlockable - fault a range with mmap lock-drop support
+ * @range:	argument structure
+ * @locked:	pointer to lock state variable (input: 1; output: 0 if lock
+ *		was dropped)
+ *
+ * Similar to hmm_range_fault() but allows the mmap lock to be dropped during
+ * page faults. This enables support for userfaultfd-backed mappings and other
+ * cases where handle_mm_fault() may need to release the mmap lock.
+ *
+ * The caller must hold the mmap read lock and set *locked = 1 before calling.
+ * On return:
+ *   - *locked == 1: mmap lock is still held, return value has normal semantics
+ *   - *locked == 0: mmap lock was dropped. The caller must re-acquire the lock
+ *     and restart the operation. Return value is -EBUSY in this case.
+ *
+ * When the lock is dropped internally, this function will attempt to
+ * re-acquire it and retry the fault with FAULT_FLAG_TRIED set. If the retry
+ * also results in lock-drop (possible but unusual), or if a fatal signal is
+ * pending, the function returns with *locked == 0.
+ *
+ * Returns 0 on success or a negative error code. See hmm_range_fault() for
+ * the full list of possible errors.
+ */
+int hmm_range_fault_unlockable(struct hmm_range *range, int *locked)
+{
+	struct mm_struct *mm = range->notifier->mm;
 	struct hmm_vma_walk hmm_vma_walk = {
 		.range = range,
 		.last = range->start,
+		.locked = locked,
 	};
-	struct mm_struct *mm = range->notifier->mm;
 	int ret;
 
 	mmap_assert_locked(mm);
@@ -674,16 +739,24 @@ int hmm_range_fault(struct hmm_range *range)
 			return -EBUSY;
 		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
 				      &hmm_walk_ops, &hmm_vma_walk);
+		if (ret == -EAGAIN) {
+			/*
+			 * The mmap lock was dropped during the fault
+			 * (e.g. userfaultfd). Signal the caller to restart
+			 * by returning with *locked = 0.
+			 */
+			if (fatal_signal_pending(current))
+				return -EINTR;
+			return 0;
+		}
 		/*
-		 * When -EBUSY is returned the loop restarts with
-		 * hmm_vma_walk.last set to an address that has not been stored
-		 * in pfns. All entries < last in the pfn array are set to their
-		 * output, and all >= are still at their input values.
+		 * -EBUSY: page table changed during the walk.
+		 * Restart from hmm_vma_walk.last.
 		 */
 	} while (ret == -EBUSY);
 	return ret;
 }
-EXPORT_SYMBOL(hmm_range_fault);
+EXPORT_SYMBOL(hmm_range_fault_unlockable);
 
 /**
  * hmm_dma_map_alloc - Allocate HMM map structure



