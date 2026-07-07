Return-Path: <linux-hyperv+bounces-11848-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HL2MMNRXTWqMygEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11848-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Jul 2026 21:47:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77B71F5CB
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Jul 2026 21:47:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=E5wpVUWK;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11848-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11848-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCFB03018C22
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jul 2026 19:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0D31F872D;
	Tue,  7 Jul 2026 19:47:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1833B7B97
	for <linux-hyperv@vger.kernel.org>; Tue,  7 Jul 2026 19:47:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453627; cv=none; b=ap1q8V/ONMBjRSFVFSlmohox16MdJTQ8pbBdpiGGiXO/gPgKTKw4J9m4sBZJel77YUKUAX65bUIKhZANNE2qWbPxwoDLH6Xuur4utnlah9bu+wp7geqAJByoU/ylM41WNjIEVsb4o3OZiA5UDIKNQGbmWw7L4P9Ui/EHgckcwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453627; c=relaxed/simple;
	bh=hwl7OP55UI2lZCXqs2xQ0lQfepAfVq1rfr/4O1f6QPU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgsP2nMnschGNFBjbrHKVpzRDNgRvXJS5hfWZt/0irZkWDn8ciAd9YM+NChDIdluvX/hHza41UYTTjHCgbio/1+1wqn4uyNAQZoN8rYIhwIWmE8BHl2Agbcd+DnbvCSDUQVHlzlVJYjURMEJZajqZkXdoSRSCIxjS3Z05vb3JEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5wpVUWK; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cab973140bso55450105ad.3
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Jul 2026 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783453624; x=1784058424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=X+CVN3h9eUUn5cnhwzVU69Wvf2wjPvEZWVRD1j6vs7c=;
        b=E5wpVUWKB7zMShLqiK6yDYBvtr4PJegLc9TbXxaoJo/wCSa8+m2EH4dCJ8g9F54dqw
         x6SImVe2eMMMuhfRXhte+LFGLtSD9LNvxE3VUQW2XnRjz3L/JPCFS0ka3coczgxpj6DU
         /DODj4cka4tTZ8X27YLPFI5AQphekr9wkp1+vfgMSsZet3VUotNGHjbCs3CPRSUgZ9d4
         4jIvkUgCVkih82j2ZZDebwpm1KQXT+Zx9PcIWJVNJw3ElC5NldY2zcRXb339/xTAc/Ea
         QJ0zGf7F2BSbzGknp1I5U6VCu5xstSFO0lUFlleSTWsb9z2oFr11HMIiG8jWyHEPH2mo
         nBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453624; x=1784058424;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+CVN3h9eUUn5cnhwzVU69Wvf2wjPvEZWVRD1j6vs7c=;
        b=U92OfrfMDTNBRuFZeRhiAKUJ+7Oz4e1ooJrzS4JrknRL3iprmjkQ9TpzDZgf0spLP6
         qy5esgobMdhjo25CzOvtmCLCEbH8S9GLILjZO2XnuiKMgYnHplSUd4Uko5oDwJuVzNzu
         PHxL1qoi5AZ7rrDCP48yxM5+VS+duiglJEr3siWNy86Fq0wMb0dWNT0z2OPbkghweo+L
         M/fc5KeMU/l1liQK3Gm7awEkvDsFbGVXSBI8AIQR6Y2K9NA89iNkF5bZh2OtdqdFKAP4
         w3FH97W4yv2Ja5bNCk01z7PFoFKBcH2QyHbaooucZJIPEtq00GT9ZRRmL3wuYuSpZKjV
         vRbA==
X-Forwarded-Encrypted: i=1; AHgh+RpTO4ZoNnI0rttnF6tJq9uLT+lqyIjnUxpGVxC6SUs5o/PQ1YyuxvqUxIYL3Ek/3mj556tgJ+41X33uMQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys7mO9mO1IOsuLC14QQ7KqMC858TlG6M1FLZYOQRzBtUWtoyqB
	i8Uhx85NVOVg2aHN2AgD7zjMsuIhA5qN8gNaSZWN/20Y5+02AWht+n5DXyImyg==
X-Gm-Gg: AfdE7cnIpswETeWUAgKuj/7f+pRegrQ7wo3IizI90jNuPHzs/Ly1Ou4UJmDgtXSCz/e
	vB6Jbnc2XVisPa40NABi0usEIRXbszUkBs/3BhSMQwHm460GYXrG0T9kdRX/G+jR6JH3AblxRO1
	cs3/JpzRXKf7mnEJXvYHm9QdhG+80R7OPPt2StBgn2yc7PeGb8f108QkOJtDY50ZqUQVLxUHlO2
	0ovrpqDAUYV/APHg08OxQNI2UBxyjrvjDJvgJOl2zquL2Z95waH0NnYcWBEnpaMNiTgsQ0045l7
	bmZNZAWyXDbYFMeIvJYdHQfIxlB2LPNF12+d7mgT8ptUDkpgQelviOHna3SFY6KuUq8JGBzW2UW
	2AHMdVGoWpiJ/B+vX2fCt/dNt/v84khYcdRMexIcgnxMrv2PN0JdF6Q5NPxoZQGqFnHqbZI+sqw
	6klOYyhKt690tWskENreMPTaKjsln2QwD97LFJ/iYF77CuWp8zzjoWoaeGMZU=
X-Received: by 2002:a17:903:37c3:b0:2cc:9473:97c8 with SMTP id d9443c01a7336-2ccbe722810mr68422355ad.15.1783453623691;
        Tue, 07 Jul 2026 12:47:03 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1ea7fsm17010495ad.38.2026.07.07.12.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:47:03 -0700 (PDT)
Subject: [PATCH v7 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout() for
 mmap lock-drop support
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, wei.liu@kernel.org,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Tue, 07 Jul 2026 12:47:01 -0700
Message-ID: <178345362182.660027.12809852179204464964.stgit@skinsburskii>
In-Reply-To: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11848-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:skinsburskii@gmail.com,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A77B71F5CB

hmm_range_fault() requires the caller to hold the mmap read lock for the
duration of the call. This is incompatible with mappings whose fault
handler may release the mmap lock, notably userfaultfd-managed regions,
where handle_mm_fault() can return VM_FAULT_RETRY or VM_FAULT_COMPLETED
after dropping the lock. Drivers that need to populate device page tables
for such mappings have no way to do so today.

Add hmm_range_fault_unlocked_timeout() for callers that do not need to hold
mmap_lock across any work outside the HMM fault itself. The helper takes
mmap_read_lock_killable() internally, calls the common HMM fault
implementation, and releases the lock before returning if it is still held.
The timeout is specified in jiffies; passing 0 retries indefinitely, while
a non-zero timeout makes the helper return -EBUSY when the retry budget
expires.

When handle_mm_fault() drops mmap_lock, or when the range is invalidated,
hmm_range_fault_unlocked_timeout() refreshes range->notifier_seq and
retries the walk internally. The caller only needs to perform the usual
post-success mmu_interval_read_retry() check while holding its update lock
before consuming the pfns. If mmap_lock acquisition is interrupted or a
fatal signal is pending during retry handling, -EINTR is returned instead.

The common implementation conditionally sets FAULT_FLAG_ALLOW_RETRY and
FAULT_FLAG_KILLABLE only for hmm_range_fault_unlocked_timeout(). The
existing hmm_range_fault() path still passes no locked state, does not
allow handle_mm_fault() to drop mmap_lock, and remains a thin wrapper
preserving the existing API contract for current callers.

The previous refactor that moved page fault handling out of the page-table
walk callbacks is what makes this change small. Faults now run after
walk_page_range() has unwound, with only mmap_lock held, so dropping it
does not interact with the walker's pte spinlock or hugetlb_vma_lock.
Hugetlb regions therefore participate in the unlocked path uniformly with
PTE- and PMD-level mappings; no special case is required.

Documentation/mm/hmm.rst is updated with a description of the new API and
the recommended caller pattern.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 Documentation/mm/hmm.rst |   63 +++++++++++++++++++
 include/linux/hmm.h      |    2 +
 mm/hmm.c                 |  152 +++++++++++++++++++++++++++++++++++++---------
 3 files changed, 188 insertions(+), 29 deletions(-)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index 7d61b7a8b65b..70885f153d03 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -208,6 +208,69 @@ invalidate() callback. That lock must be held before calling
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
+  int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
+                                       unsigned long timeout);
+
+The caller must not hold ``mmap_read_lock`` before the call.
+``hmm_range_fault_unlocked_timeout()`` takes the mmap read lock internally and
+allows ``handle_mm_fault()`` to drop it during fault handling. If the mmap lock
+is dropped or the range is invalidated, the function refreshes
+``range->notifier_seq`` and restarts the walk internally. ``-EINTR`` is
+returned if mmap lock acquisition is interrupted or a fatal signal is pending
+during retry handling.
+
+The timeout is specified in jiffies; passing ``0`` means retry indefinitely. If
+the timeout expires while the function is retrying after ``-EBUSY``,
+``-EBUSY`` is returned to the caller.
+
+A typical caller looks like this::
+
+ int driver_populate_range_unlocked(...)
+ {
+      struct hmm_range range;
+      unsigned long timeout;
+      ...
+
+      timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+      range.notifier = &interval_sub;
+      range.start = ...;
+      range.end = ...;
+      range.hmm_pfns = ...;
+
+      if (!mmget_not_zero(interval_sub.mm))
+          return -EFAULT;
+
+ again:
+      ret = hmm_range_fault_unlocked_timeout(&range, timeout);
+      if (ret)
+          goto out_put;
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
index db75ffc949a7..6f04e3932f5b 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -123,6 +123,8 @@ struct hmm_range {
  * Please see Documentation/mm/hmm.rst for how to use the range API.
  */
 int hmm_range_fault(struct hmm_range *range);
+int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
+				     unsigned long timeout);
 
 /*
  * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
diff --git a/mm/hmm.c b/mm/hmm.c
index 2129b1ee4c35..15110409be00 100644
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
@@ -715,8 +729,88 @@ int hmm_range_fault(struct hmm_range *range)
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
+ * for userfaultfd support), see hmm_range_fault_unlocked_timeout().
+ */
+int hmm_range_fault(struct hmm_range *range)
+{
+	return hmm_range_fault_locked(range, NULL);
+}
 EXPORT_SYMBOL(hmm_range_fault);
 
+/**
+ * hmm_range_fault_unlocked_timeout - fault in a range with a retry timeout
+ * @range:	argument structure
+ * @timeout:	timeout in jiffies for internal -EBUSY retries, or 0 to retry
+ *		indefinitely
+ *
+ * This is similar to hmm_range_fault(), except the caller must not hold the
+ * mmap lock. The function takes the mmap read lock internally and allows
+ * handle_mm_fault() to drop it during faults. If the mmap lock is dropped or
+ * the range is invalidated, the function refreshes range->notifier_seq and
+ * restarts the walk internally. Passing 0 for @timeout retries indefinitely;
+ * otherwise, if @timeout expires while retrying -EBUSY, -EBUSY is returned to
+ * the caller.
+ *
+ * Returns 0 on success or one of the error codes documented for
+ * hmm_range_fault(). -EINTR is returned if mmap_lock acquisition is
+ * interrupted or a fatal signal is pending during retry handling.
+ */
+int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
+				     unsigned long timeout)
+{
+	struct mm_struct *mm = range->notifier->mm;
+	unsigned long deadline = 0;
+	int locked, ret;
+
+	if (timeout)
+		deadline = jiffies + timeout;
+
+	do {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+
+		if (timeout && time_after(jiffies, deadline))
+			return -EBUSY;
+
+		range->notifier_seq =
+			mmu_interval_read_begin(range->notifier);
+
+		ret = mmap_read_lock_killable(mm);
+		if (ret)
+			return ret;
+
+		locked = 1;
+		ret = hmm_range_fault_locked(range, &locked);
+		if (locked)
+			mmap_read_unlock(mm);
+	} while (ret == -EBUSY);
+
+	return ret;
+}
+EXPORT_SYMBOL(hmm_range_fault_unlocked_timeout);
+
 /**
  * hmm_dma_map_alloc - Allocate HMM map structure
  * @dev: device to allocate structure for



