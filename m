Return-Path: <linux-hyperv+bounces-11919-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ubj4MuxkUWqnDwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11919-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 23:32:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A473EF74
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 23:32:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=amRmznTv;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11919-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11919-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 252A430802F8
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 21:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1993D1A99;
	Fri, 10 Jul 2026 21:26:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB33C8700
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 21:26:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718803; cv=none; b=ZdwAcRmmERSNVtn3dOqrzbT+LvTHlAt+kmw1rPv+AO1w5R+AXOFzIgnRyGyQN1X2tH8fnbnt3AHbWhEI970raROkcxUjlbUBRH9L4Z4faunSQ+P87fxoZhVyLpMfKgGGyuPJ/MKPLKFbAS05xHriY+atGUD2Wlz4lll2x5cobN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718803; c=relaxed/simple;
	bh=SGN2zajB7g6F1+FA9RLw2HuWwA1m6Nf7GKGNqJxh1d8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYec+tiYJ4P1+239SMHew4FxlyxmYBhl0LXjTKHiHexC14Roc0DFfmhS7KzY8BLNE+Bh6qkidTahKbrY0mlXg/TvY6hAXRTkOHixgm+0srstGNWtHd7jrREtlrKKaK1fSh9NL0XxqUT/dSl8CUWZjriabNkpt4ZsexKfhsdmiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amRmznTv; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so22994245ad.2
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 14:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718797; x=1784323597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZqbwRVP/sfR6Y4F4lzaqregK9IVNqigDowAHMdHoVCE=;
        b=amRmznTvDLm86N6EINfPvft1zp+yPmNLbHxcAsPXDX8Eh8JQymH1TYs1W89s3YZkkM
         MBn6s/7TYFAXFZcbxlHqGoX5lli8QzdBbb+NVZfj8Vkw+ubTtjr+84ab4uMPjzHyNgJ2
         iXJkt1sPJ0mOuA/yOUHkKhFYPCTjcGb52z8ynv0lCkrJih/dYk8Sdo09a1hY0nlSCP6d
         PL6iAGjqwxMabgbzB71QXC/3XXUwo1XsVItsCVHpcaSTcCYIE0mTx5zIgKsAPrl9IzoE
         +MnRK+xjzImzN8JMsK8ZwZu9UcHiOK4Bf0uW9hGAUKFLj4q48qcjAa8+wxjh1pT+u0bY
         Q9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718797; x=1784323597;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqbwRVP/sfR6Y4F4lzaqregK9IVNqigDowAHMdHoVCE=;
        b=IQgyOFouMAhsCnnzm3Jh/JsxERzWPJ6vkwBHVpDALnSldW2h6cmRVJURgiwlf8NdbG
         RJt19y6RCjwrGqHhmtt1f++UKwiEGcZUyKICSVLG0vTRK/miXMy8W9WM7YDKNmlgr8S/
         98321n5hnoBffA1+LCgwlLhnqbQf0437ikg6LlPrY17JjyJemBqaY1JxvrEA4TVv+3I2
         a92pup2yuZfdNvBC/SwI3ZbR6GEd5IS/PGgYudaNZd52y+GCqvYhwpKHv9B8zvxjEhqU
         l4Gq3wEdyb0RNVzZ7sutCIzKz6B2qOnIT+2d9untx1rbhxbQVtpMKa+d5uD9dzo0IKMk
         ZKOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpiufQNFZGcZQgfHsejNgLLPA7McZIFXCkPwW0FCHVPCghrQQ7RZtpH0HgzC2vzTFp7jzMr2/ZjBzs4cto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFAXXluG65HPdyFD5rZpHWRJL3oXuFburz8wp+EiOfKoTPxDi
	Wm1g3I2skpet5PmnyD3d7NGk5a29KxCvnzTUFdbm/w/1kG+n4WsEZgmN
X-Gm-Gg: AfdE7ckzt6xdDx69dTSN+ywDiZoRsciWabEJK3eNcy6S+r2jEouOb4uoG4+f3tX4oP/
	sIaZVj5MLnsiBtXaA5FFMCiEAFAD+vCZVGeKuh4sb08rDfrLxanWONTb7TwV6/8sisEa2iIMmc6
	7ziXClXkxqhVIms9CJBZxawzmHTi3Ma4/ksDuzF/+zqnDVoZjbNbrMc3rZwmYgKy3zazbUpQ7I2
	++2BGlzs3wRlQ3n+u7TSHPJ4cSl6x6FbiBpqcTCBIlxxrlKa50X0rD1QXGiIn0euWbSisIab40w
	WVZNjiygXzwbmiZRlhCtk0rzi5oNbrfo+kJ3FJoxYY8FsYxrw1oqx6Ei37EiZjjsx97XEqenuTN
	6MlD4ibyH7RnpOTmQdI8YEHtqcNl1yitkDx+x568/sSPUyZLDqz/eddwQzlD6tWdtlDdJCr8OQ3
	NcNhUbt1WygEjYon67+2FUZu7qBN6k0JkW488q7pW7oh8CgBmXSvNYPVoNhqMMms8BFPqXcw==
X-Received: by 2002:a05:6a20:1604:b0:3bb:2200:f67b with SMTP id adf61e73a8af0-3c110cdb319mr625385637.40.1783718797427;
        Fri, 10 Jul 2026 14:26:37 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d58f3sm5552601a12.1.2026.07.10.14.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:26:36 -0700 (PDT)
Subject: [PATCH v8 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout() for
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
Date: Fri, 10 Jul 2026 14:26:35 -0700
Message-ID: <178371879503.900500.7148019929226548795.stgit@skinsburskii>
In-Reply-To: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
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
	TAGGED_FROM(0.00)[bounces-11919-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[interval_sub.mm:url,skinsburskii:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 347A473EF74

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
retries the walk internally. If the lock was dropped, the retry deadline is
also restarted because a lock-dropping fault handler made progress.
Ordinary -EBUSY retries keep the existing deadline, preserving the caller's
timeout policy for repeated mmu-notifier invalidations.

The caller only needs to perform the usual post-success
mmu_interval_read_retry() check while holding its update lock before
consuming the pfns. If mmap_lock acquisition is interrupted or a fatal
signal is pending during retry handling, -EINTR is returned instead.

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
 Documentation/mm/hmm.rst |   76 +++++++++++++++------
 include/linux/hmm.h      |    2 +
 mm/hmm.c                 |  165 ++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 192 insertions(+), 51 deletions(-)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index 7d61b7a8b65b..4e5a750748ae 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -156,42 +156,57 @@ During the ops->invalidate() callback the device driver must perform the
 update action to the range (mark range read only, or fully unmap, etc.). The
 device must complete the update before the driver callback returns.
 
-When the device driver wants to populate a range of virtual addresses, it can
-use::
+When the device driver wants to populate a range of virtual addresses, the
+normal interface is::
 
-  int hmm_range_fault(struct hmm_range *range);
+  int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
+                                       unsigned long timeout);
 
 It will trigger a page fault on missing or read-only entries if write access is
 requested (see below). Page faults use the generic mm page fault code path just
-like a CPU page fault. The usage pattern is::
+like a CPU page fault.
+
+The caller must not hold ``mmap_read_lock`` before the call.
+``hmm_range_fault_unlocked_timeout()`` takes the mmap read lock internally and
+allows ``handle_mm_fault()`` to drop it during fault handling. This is required
+for VMAs whose fault handlers may release the mmap lock, for example regions
+managed by ``userfaultfd``.
+
+If the mmap lock is dropped or the range is invalidated, the function refreshes
+``range->notifier_seq`` and restarts the walk internally. ``-EINTR`` is returned
+if mmap lock acquisition is interrupted or a fatal signal is pending during
+retry handling.
+
+The timeout is specified in jiffies; passing ``0`` means retry indefinitely. The
+timeout exists to preserve caller policy for repeated mmu-notifier invalidation
+and is checked between retry attempts. HMM does not interrupt page fault
+handling when the timeout expires, but returns ``-EBUSY`` if the retry budget is
+exhausted before a stable range is obtained.
+
+The usage pattern is::
 
  int driver_populate_range(...)
  {
       struct hmm_range range;
+      unsigned long timeout;
       ...
 
+      timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
       range.notifier = &interval_sub;
       range.start = ...;
       range.end = ...;
       range.hmm_pfns = ...;
 
-      if (!mmget_not_zero(interval_sub->notifier.mm))
+      if (!mmget_not_zero(interval_sub.mm))
           return -EFAULT;
 
  again:
-      range.notifier_seq = mmu_interval_read_begin(&interval_sub);
-      mmap_read_lock(mm);
-      ret = hmm_range_fault(&range);
-      if (ret) {
-          mmap_read_unlock(mm);
-          if (ret == -EBUSY)
-                 goto again;
-          return ret;
-      }
-      mmap_read_unlock(mm);
+      ret = hmm_range_fault_unlocked_timeout(&range, timeout);
+      if (ret)
+          goto out_put;
 
       take_lock(driver->update);
-      if (mmu_interval_read_retry(&ni, range.notifier_seq) {
+      if (mmu_interval_read_retry(&interval_sub, range.notifier_seq)) {
           release_lock(driver->update);
           goto again;
       }
@@ -200,7 +215,11 @@ like a CPU page fault. The usage pattern is::
        * under the update lock */
 
       release_lock(driver->update);
-      return 0;
+      ret = 0;
+
+ out_put:
+      mmput(interval_sub.mm);
+      return ret;
  }
 
 The driver->update lock is the same lock that the driver takes inside its
@@ -208,6 +227,19 @@ invalidate() callback. That lock must be held before calling
 mmu_interval_read_retry() to avoid any race with a concurrent CPU page table
 update.
 
+Holding the mmap lock across HMM faults
+=======================================
+
+Most callers should use ``hmm_range_fault_unlocked_timeout()``. If a driver
+really needs to hold the mmap lock across work outside HMM, it can use::
+
+  int hmm_range_fault(struct hmm_range *range);
+
+The mmap lock must be held by the caller and will remain held on return. This
+interface cannot support VMAs whose fault handlers need to drop the mmap lock.
+New callers should prefer ``hmm_range_fault_unlocked_timeout()`` unless they
+have a specific requirement to keep the mmap lock held across the call.
+
 Leverage default_flags and pfn_flags_mask
 =========================================
 
@@ -221,8 +253,8 @@ permission, it sets::
     range->default_flags = HMM_PFN_REQ_FAULT;
     range->pfn_flags_mask = 0;
 
-and calls hmm_range_fault() as described above. This will fill fault all pages
-in the range with at least read permission.
+and calls the HMM range fault helper as described above. This will fault
+all pages in the range with at least read permission.
 
 Now let's say the driver wants to do the same except for one page in the range for
 which it wants to have write permission. Now driver set::
@@ -236,9 +268,9 @@ address == range->start + (index_of_write << PAGE_SHIFT) it will fault with
 write permission i.e., if the CPU pte does not have write permission set then HMM
 will call handle_mm_fault().
 
-After hmm_range_fault completes the flag bits are set to the current state of
-the page tables, ie HMM_PFN_VALID | HMM_PFN_WRITE will be set if the page is
-writable.
+After the HMM range fault helper completes the flag bits are set to the
+current state of the page tables, ie HMM_PFN_VALID | HMM_PFN_WRITE will be
+set if the page is writable.
 
 
 Represent and manage device memory from core kernel point of view
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
index bc9361a715fa..fc2e1cd0cb22 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -32,6 +32,7 @@
 
 struct hmm_vma_walk {
 	struct hmm_range	*range;
+	bool			*locked;
 	unsigned long		last;
 	unsigned long		end;
 	unsigned int		required_fault;
@@ -44,6 +45,14 @@ struct hmm_vma_walk {
  */
 #define HMM_FAULT_PENDING	-EAGAIN
 
+/*
+ * Internal sentinel returned by hmm_do_fault() when handle_mm_fault()
+ * completes a page fault with the mmap lock dropped. hmm_do_fault() sets
+ * *locked = false; the outer loop consumes the sentinel and never propagates
+ * it to the caller.
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
@@ -651,37 +663,34 @@ static int hmm_do_fault(struct mm_struct *mm,
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
+			*hmm_vma_walk->locked = false;
+			return HMM_FAULT_UNLOCKED;
+		}
+
+		if (ret & VM_FAULT_ERROR) {
+			int err = vm_fault_to_errno(ret, 0);
+
+			if (WARN_ON(!err))
+				err = -EINVAL;
+
+			return err;
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
+static int hmm_range_fault_locked(struct hmm_range *range, bool *locked)
 {
 	struct hmm_vma_walk hmm_vma_walk = {
 		.range = range,
+		.locked = locked,
 		.last = range->start,
 	};
 	struct mm_struct *mm = range->notifier->mm;
@@ -704,8 +713,14 @@ int hmm_range_fault(struct hmm_range *range)
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
@@ -715,8 +730,100 @@ int hmm_range_fault(struct hmm_range *range)
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
+ * New users should prefer hmm_range_fault_unlocked_timeout() unless they
+ * specifically need to keep the mmap lock held across the call. This helper
+ * cannot support VMAs whose fault handlers need to drop the mmap lock.
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
+ * The caller must not hold the mmap lock. The function takes the mmap read
+ * lock internally and allows handle_mm_fault() to drop it during faults. If
+ * the mmap lock is dropped or the range is invalidated, the function refreshes
+ * range->notifier_seq and restarts the walk internally.
+ *
+ * Passing 0 for @timeout retries indefinitely. A non-zero @timeout is a caller
+ * policy limit for repeated mmu-notifier invalidation retries. HMM does not
+ * interrupt page fault handling when the timeout expires, but returns -EBUSY
+ * if the retry budget is exhausted before a stable range is obtained.
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
+	bool locked = false;
+	int ret;
+
+	do {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+
+		if (timeout) {
+			/*
+			 * If the previous fault dropped mmap_lock, then the fault
+			 * handler made progress. Restart the retry timeout in that
+			 * case, but keep the existing deadline for ordinary -EBUSY
+			 * retries.
+			 */
+			if (!locked)
+				deadline = jiffies + timeout;
+
+			if (time_after(jiffies, deadline))
+				return -EBUSY;
+		}
+
+		range->notifier_seq =
+			mmu_interval_read_begin(range->notifier);
+
+		ret = mmap_read_lock_killable(mm);
+		if (ret)
+			return ret;
+
+		locked = true;
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



