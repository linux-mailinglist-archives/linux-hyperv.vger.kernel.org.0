Return-Path: <linux-hyperv+bounces-11836-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ymtUEwn1S2rIdgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11836-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 20:33:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C967148DC
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 20:33:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=R6yiFTI6;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11836-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11836-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B39A36C78C6
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2026 17:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D54435ABA;
	Mon,  6 Jul 2026 17:55:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA98436BE1
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Jul 2026 17:55:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360512; cv=none; b=Z3buREOmufLpR3sfUFwvOCVBY3S6r2IxJWw27S2qR9p3mU4+NFjnC6jVajyHBxW3Eht1wRjIS1xF0hpZ57sWhSW0wIWZN3WiP5rVBG2usQMEbkcZy2QxwDfnEBqymudXArrfQ4IJVb0MzW09/Z/ptqtud1y0Rw2Gjll6PAwNpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360512; c=relaxed/simple;
	bh=53AK29P86MgjUoX3f7bt3DDg0QMp64nciTDeRfStGgM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NChK7p/Ub/3JQTQUpjNNsY7N1tPNIdL4c+K21yu4O1p8zmEwVRHR7hYQEITXHWEv93nfnDP7daF06Fy4/P7yOlYNV3DMJFoWtFbBLMjg9nypFuQIwGx7e8qxfdJlNgAVlZTzYcrkZnS1gJhGiDzVQ7XP70+yO8ExA1zNNu8qnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6yiFTI6; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso2478022a91.1
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Jul 2026 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360509; x=1783965309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WWy+bnn3yMum/vuSl7ClBqJ7Vcv4n74EsH2PruuLics=;
        b=R6yiFTI6AFP5lpSRZ7pDAYj6F20KAF1OQ0wiZOWpB9sGvIIPE4iVukYhXZvze2IP3r
         O1HLb3SQGC8qkF4RD2IRj05Md9Rev6gFoYn3tyCfn8rjrg+9BCOrTuME5RDfO7oVCIyH
         llymIpm1lreIX3uH4bHqF8+PoORq00jSlSnQy9FA9Ry8JuHqsT5Q+2LOqQ4P7GbRzKPV
         VrRPvQ/vMR6BLOq2g0Ro0F7qbdlxe4M9s/JwH0wVhtBtWIu8z5dA/WUt+mhTaWOE8HCw
         q5yiczCJAfwstcnWH5nu1WkiHDoInO5PbKrtz7x1+VXadjlKTVBREcpN2KlpcNTL9p6w
         M3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360509; x=1783965309;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWy+bnn3yMum/vuSl7ClBqJ7Vcv4n74EsH2PruuLics=;
        b=WleCUco3qGIW11qk7BeFOkIYWdml92Pak5iPwTx0VYZycwNSty7/cOtqe44aBUDQbC
         ZS13knT6JcbbppLYbzoLumJMbM9lTA9qi0rlGPXLCEwgvY3+Z5bC4DZLXxT+h8qdIyrt
         mTjJ3vaauoKDL8jJpcbcuWFhh6ScvGwXknxIw+Y+dbeSoeehak4qIuKir/UsN3I3F03y
         sncDA33Uy5Biff+sf2xofA9u3Z4hw+son6zwAaUJc2afgoKC31uZgk+Xdcu/KAF1jJc9
         ZAYoUo7ifMFhCz1ojRpPexrUVhcHLuFN0xuiqozk8RALGVX9U6iA56UBiTLEmY6O4Mp/
         wFRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZ/yXRXQaC5PtRrzP8ofFiEHPP9VNZV8BJoIl/JtooyzZMKNPjtXyjl6jSRDiHkBDYdsbDdcL5nzIgojg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBiFhBfPxtK3bKh86gP9kj8/TKt1McvkIDkQb9VuL20+GZ6qG
	s7o6PRsXsF+tA+KzMdENYN8eTvab7NjmmNVid/2TgAt0H3ClUs+QoVzA9zSkqg==
X-Gm-Gg: AfdE7cmqe9UpEmKIe4XaVsgdyvIZdpZ9KLlgJ9qrcR7PXvCuMCQ5jyzG9+LJJlWNY0F
	19bb5Xm+SZH90q42Q+ftJ2zmobLUpL1YjUe/2ktZAiaitsrMbbomkXB3rFOntwgSnJgDVqKayiX
	TVYfL6N5yt2KYINUTUZzdGzZ/QXrggNZiTSB8hEJwpM2IPf39/SsN8Ju5vq0YyYINeTnin8bNHZ
	/TefBz/F5YxSnkKhbg1Mbiobg9OcILM6rcxmkgznKqKTBEgunThle/cXGnSg5+BVGsVw+R3yXUc
	EMMUmRXx62/iLfCytBhWVkRO+NVPQkjLUQjblkN2vOQlEVTwSyTlfm0b+ejS2EXNmlAcIOkLQg+
	TNTI0W+BJECSr1E7QRwRURuzpOXrQ9jQzEMT+Mld/q9jXSVLu7TeBsJLzh6wQtJOpVJi0Ri2A90
	9a/Ygd41cjc8IIm5TSu1eJnoFkle9fj0k3uAZgQwraZHTFI0CJoP9Y9Kzrk5Q=
X-Received: by 2002:a17:90b:2652:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-38755573a58mr1666168a91.7.1783360509393;
        Mon, 06 Jul 2026 10:55:09 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127c8b700sm5654078a91.11.2026.07.06.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:55:08 -0700 (PDT)
Subject: [PATCH v6 2/4] mm/hmm: add hmm_range_fault_unlocked() for mmap
 lock-drop support
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 akpm@linux-foundation.org, david@kernel.org, jgg@ziepe.ca, corbet@lwn.net,
 leon@kernel.org, ljs@kernel.org, mhocko@suse.com, rppt@kernel.org,
 shuah@kernel.org, skhan@linuxfoundation.org, surenb@google.com,
 vbabka@kernel.org, skinsburskii@gmail.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-hyperv@vger.kernel.org
Date: Mon, 06 Jul 2026 10:55:07 -0700
Message-ID: <178336050736.504354.6052508493877924780.stgit@skinsburskii>
In-Reply-To: <178336023903.504354.7500950448226027718.stgit@skinsburskii>
References: <178336023903.504354.7500950448226027718.stgit@skinsburskii>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11836-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,linux-foundation.org,kernel.org,ziepe.ca,lwn.net,suse.com,linuxfoundation.org,google.com,gmail.com,microsoft.com];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:jgg@ziepe.ca,m:corbet@lwn.net,m:leon@kernel.org,m:ljs@kernel.org,m:mhocko@suse.com,m:rppt@kernel.org,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:surenb@google.com,m:vbabka@kernel.org,m:skinsburskii@gmail.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-mm@kvack.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii:mid,interval_sub.mm:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3C967148DC

hmm_range_fault() requires the caller to hold the mmap read lock for the
duration of the call. This is incompatible with mappings whose fault
handler may release the mmap lock, notably userfaultfd-managed regions,
where handle_mm_fault() can return VM_FAULT_RETRY or VM_FAULT_COMPLETED
after dropping the lock. Drivers that need to populate device page tables
for such mappings have no way to do so today.

Add hmm_range_fault_unlocked() for callers that do not need to hold
mmap_lock across any work outside the HMM fault itself. The new helper
takes mmap_read_lock() internally, calls the common HMM fault
implementation, and releases the lock before returning if it is still
held.

When handle_mm_fault() drops mmap_lock, hmm_range_fault_unlocked() returns
-EBUSY. The caller must then restart its HMM walk with a fresh
mmu_interval_read_begin() sequence. If a fatal signal is pending after the
lock has been dropped, -EINTR is returned instead. This gives callers a
simple restart contract while allowing fault handlers that must drop
mmap_lock, including userfaultfd-backed mappings, to make progress.

The common implementation conditionally sets FAULT_FLAG_ALLOW_RETRY and
FAULT_FLAG_KILLABLE only for hmm_range_fault_unlocked(). The existing
hmm_range_fault() path still passes no locked state, does not allow
handle_mm_fault() to drop mmap_lock, and remains a thin wrapper preserving
the existing API contract for current callers.

The previous refactor that moved page fault handling out of the
page-table walk callbacks is what makes this change small. Faults now run
after walk_page_range() has unwound, with only mmap_lock held, so dropping
it does not interact with the walker's pte spinlock or hugetlb_vma_lock.
Hugetlb regions therefore participate in the unlocked path uniformly with
PTE- and PMD-level mappings; no special case is required.

Documentation/mm/hmm.rst is updated with a description of the new API and
the recommended caller pattern.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 Documentation/mm/hmm.rst |   59 +++++++++++++++++++++
 include/linux/hmm.h      |    1 
 mm/hmm.c                 |  129 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 160 insertions(+), 29 deletions(-)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index 7d61b7a8b65b..844343712abd 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -208,6 +208,65 @@ invalidate() callback. That lock must be held before calling
 mmu_interval_read_retry() to avoid any race with a concurrent CPU page table
 update.
 
+Dropping the mmap lock during page faults
+=========================================
+
+Some VMAs have fault handlers that need to release the mmap lock while
+servicing a fault (for example, regions managed by ``userfaultfd``).
+``hmm_range_fault()`` cannot be used on such mappings because it must hold the
+mmap lock for the duration of the call. Drivers that need to support them
+should call::
+
+  int hmm_range_fault_unlocked(struct hmm_range *range);
+
+The caller must not hold ``mmap_read_lock`` before the call.
+``hmm_range_fault_unlocked()`` takes the mmap read lock internally and allows
+``handle_mm_fault()`` to drop it during fault handling. If the mmap lock is
+dropped, the function returns ``-EBUSY``. The caller must then restart the
+walk from ``range->start`` with a fresh notifier sequence. ``-EINTR`` is
+returned if a fatal signal is pending during retry handling.
+
+A typical caller looks like this::
+
+ int driver_populate_range_unlocked(...)
+ {
+      struct hmm_range range;
+      ...
+
+      range.notifier = &interval_sub;
+      range.start = ...;
+      range.end = ...;
+      range.hmm_pfns = ...;
+
+      if (!mmget_not_zero(interval_sub.mm))
+          return -EFAULT;
+
+ again:
+      range.notifier_seq = mmu_interval_read_begin(&interval_sub);
+      ret = hmm_range_fault_unlocked(&range);
+      if (ret) {
+          if (ret == -EBUSY)
+              goto again;
+          goto out_put;
+      }
+
+      take_lock(driver->update);
+      if (mmu_interval_read_retry(&interval_sub, range.notifier_seq)) {
+          release_lock(driver->update);
+          goto again;
+      }
+
+      /* Use pfns array content to update device page table,
+       * under the update lock */
+
+      release_lock(driver->update);
+      ret = 0;
+
+ out_put:
+      mmput(interval_sub.mm);
+      return ret;
+ }
+
 Leverage default_flags and pfn_flags_mask
 =========================================
 
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index db75ffc949a7..1b584e5a2900 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -123,6 +123,7 @@ struct hmm_range {
  * Please see Documentation/mm/hmm.rst for how to use the range API.
  */
 int hmm_range_fault(struct hmm_range *range);
+int hmm_range_fault_unlocked(struct hmm_range *range);
 
 /*
  * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
diff --git a/mm/hmm.c b/mm/hmm.c
index 2129b1ee4c35..316116994209 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -32,6 +32,7 @@
 
 struct hmm_vma_walk {
 	struct hmm_range	*range;
+	int			*locked;
 	unsigned long		last;
 	unsigned long		end;
 	unsigned int		required_fault;
@@ -44,6 +45,14 @@ struct hmm_vma_walk {
  */
 #define HMM_FAULT_PENDING	-EAGAIN
 
+/*
+ * Internal sentinel returned by hmm_do_fault() when handle_mm_fault()
+ * completes a page fault with the mmap lock dropped. hmm_do_fault() sets
+ * *locked = 0; the outer loop consumes the sentinel and never propagates it
+ * to the caller.
+ */
+#define HMM_FAULT_UNLOCKED	-ENOLCK
+
 enum {
 	HMM_NEED_FAULT = 1 << 0,
 	HMM_NEED_WRITE_FAULT = 1 << 1,
@@ -73,9 +82,9 @@ static int hmm_pfns_fill(unsigned long addr, unsigned long end,
  *
  * Called by the walk callbacks when they discover that part of the range
  * needs a page fault.  The callback records what to fault and returns
- * HMM_FAULT_PENDING; the outer loop in hmm_range_fault() drops back out of
- * walk_page_range() and invokes handle_mm_fault() from a context where no
- * page-table or hugetlb_vma_lock is held.
+ * HMM_FAULT_PENDING; the outer loop in hmm_range_fault_locked() drops
+ * back out of walk_page_range() and invokes handle_mm_fault() from a context
+ * where no page-table or hugetlb_vma_lock is held.
  */
 static int hmm_record_fault(unsigned long addr, unsigned long end,
 			    unsigned int required_fault,
@@ -624,7 +633,7 @@ static const struct mm_walk_ops hmm_walk_ops = {
 /*
  * hmm_do_fault - fault in a range recorded by a walk callback
  *
- * Called from the outer loop in hmm_range_fault() after a callback
+ * Called from the outer loop in hmm_range_fault_locked() after a callback
  * returned HMM_FAULT_PENDING.  At this point we hold only mmap_lock;
  * the page-table spinlock and any hugetlb_vma_lock acquired by the walk
  * framework have already been released by the unwind.
@@ -641,6 +650,9 @@ static int hmm_do_fault(struct mm_struct *mm,
 	unsigned int fault_flags = FAULT_FLAG_REMOTE;
 	struct vm_area_struct *vma;
 
+	if (hmm_vma_walk->locked)
+		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+
 	vma = vma_lookup(mm, addr);
 	if (!vma)
 		return -EFAULT;
@@ -651,37 +663,33 @@ static int hmm_do_fault(struct mm_struct *mm,
 		fault_flags |= FAULT_FLAG_WRITE;
 	}
 
-	for (; addr < end; addr += PAGE_SIZE)
-		if (handle_mm_fault(vma, addr, fault_flags, NULL) &
-		    VM_FAULT_ERROR)
-			return -EFAULT;
+	for (; addr < end; addr += PAGE_SIZE) {
+		vm_fault_t ret;
+
+		ret = handle_mm_fault(vma, addr, fault_flags, NULL);
+
+		if (ret & (VM_FAULT_COMPLETED | VM_FAULT_RETRY)) {
+			*hmm_vma_walk->locked = 0;
+			return HMM_FAULT_UNLOCKED;
+		}
+
+		if (ret & VM_FAULT_ERROR) {
+			int err = vm_fault_to_errno(ret, 0);
+
+			if (err)
+				return err;
+			BUG();
+		}
+	}
 
 	return -EBUSY;
 }
 
-/**
- * hmm_range_fault - try to fault some address in a virtual address range
- * @range:	argument structure
- *
- * Returns 0 on success or one of the following error codes:
- *
- * -EINVAL:	Invalid arguments or mm or virtual address is in an invalid vma
- *		(e.g., device file vma).
- * -ENOMEM:	Out of memory.
- * -EPERM:	Invalid permission (e.g., asking for write and range is read
- *		only).
- * -EBUSY:	The range has been invalidated and the caller needs to wait for
- *		the invalidation to finish.
- * -EFAULT:     A page was requested to be valid and could not be made valid
- *              ie it has no backing VMA or it is illegal to access
- *
- * This is similar to get_user_pages(), except that it can read the page tables
- * without mutating them (ie causing faults).
- */
-int hmm_range_fault(struct hmm_range *range)
+static int hmm_range_fault_locked(struct hmm_range *range, int *locked)
 {
 	struct hmm_vma_walk hmm_vma_walk = {
 		.range = range,
+		.locked = locked,
 		.last = range->start,
 	};
 	struct mm_struct *mm = range->notifier->mm;
@@ -704,8 +712,14 @@ int hmm_range_fault(struct hmm_range *range)
 		 * returns -EBUSY so the loop re-walks and picks up the
 		 * now-present entries.
 		 */
-		if (ret == HMM_FAULT_PENDING)
+		if (ret == HMM_FAULT_PENDING) {
 			ret = hmm_do_fault(mm, &hmm_vma_walk);
+			if (ret == HMM_FAULT_UNLOCKED) {
+				if (fatal_signal_pending(current))
+					return -EINTR;
+				return -EBUSY;
+			}
+		}
 		/*
 		 * When -EBUSY is returned the loop restarts with
 		 * hmm_vma_walk.last set to an address that has not been stored
@@ -715,8 +729,65 @@ int hmm_range_fault(struct hmm_range *range)
 	} while (ret == -EBUSY);
 	return ret;
 }
+
+/**
+ * hmm_range_fault - try to fault some address in a virtual address range
+ * @range:	argument structure
+ *
+ * Returns 0 on success or one of the following error codes:
+ *
+ * -EINVAL:	Invalid arguments or mm or virtual address is in an invalid vma
+ *		(e.g., device file vma).
+ * -ENOMEM:	Out of memory.
+ * -EPERM:	Invalid permission (e.g., asking for write and range is read
+ *		only).
+ * -EBUSY:	The range has been invalidated and the caller needs to wait for
+ *		the invalidation to finish.
+ * -EFAULT:     A page was requested to be valid and could not be made valid
+ *              ie it has no backing VMA or it is illegal to access
+ *
+ * This is similar to get_user_pages(), except that it can read the page tables
+ * without mutating them (ie causing faults).
+ *
+ * The mmap lock must be held by the caller and will remain held on return.
+ * For a variant that allows the mmap lock to be dropped during faults (e.g.,
+ * for userfaultfd support), see hmm_range_fault_unlocked().
+ */
+int hmm_range_fault(struct hmm_range *range)
+{
+	return hmm_range_fault_locked(range, NULL);
+}
 EXPORT_SYMBOL(hmm_range_fault);
 
+/**
+ * hmm_range_fault_unlocked - fault in a range, possibly dropping the mmap lock
+ * @range:	argument structure
+ *
+ * This is similar to hmm_range_fault(), except the caller must not hold the
+ * mmap lock. The function takes the mmap read lock internally and allows
+ * handle_mm_fault() to drop it during faults. If the lock is dropped, the
+ * function returns -EBUSY and the caller must restart the walk with a fresh
+ * mmu_interval_read_begin() sequence.
+ *
+ * Returns 0 on success or one of the error codes documented for
+ * hmm_range_fault(). -EINTR is returned if a fatal signal is pending during
+ * retry handling.
+ */
+int hmm_range_fault_unlocked(struct hmm_range *range)
+{
+	struct mm_struct *mm = range->notifier->mm;
+	int locked = 1;
+	int ret;
+
+	mmap_read_lock(mm);
+	ret = hmm_range_fault_locked(range, &locked);
+	if (locked)
+		mmap_read_unlock(mm);
+
+	return ret;
+}
+EXPORT_SYMBOL(hmm_range_fault_unlocked);
+
 /**
  * hmm_dma_map_alloc - Allocate HMM map structure
  * @dev: device to allocate structure for



