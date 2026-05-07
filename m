Return-Path: <linux-hyperv+bounces-10674-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI5vIauz/GmOSwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10674-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:45:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DFA4EB4CC
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 974CF302F0F1
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EE643D504;
	Thu,  7 May 2026 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JRNXVknF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39E6402B8B;
	Thu,  7 May 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168587; cv=none; b=dOmObOfGRFRT/riZXXEY7xMLE1Y97ETLODRU6WUbphm3TILkBtkT9YTJu8kPbO3/vamm8JEF3Y5hN3bgVLv7OUsYE/RJetBBhjE9tA08bPD1ZYnDSrctKYMzVomVBKmGPM+d4JpsvokkqEF2NL+CJ/TskvpvYGFOK/MxExr1eFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168587; c=relaxed/simple;
	bh=AADru0g4CRXOY1WXGsim+BtAQEAqTnZOranraaK+ej0=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=rvcDcOIo1R/Ro9LocMvIIt2pRJhYBj1d/SkfsFDGEEeq/St5o+t/6fSIZfT4K7N+v6QjNlDK3a58Jp9o8t9t5LATpjZdQDPpWXVziDXO7YIPX2cu/mXR3r6Y6E3hD607qL67d8SmZB2uYjWrlcZnTd1ImgSoNuGf2aKFwLkPknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JRNXVknF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8766820B7165;
	Thu,  7 May 2026 08:42:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8766820B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168575;
	bh=dBucTbLfWR3XRbW34FMxY7hvEzq290GXysFMajZv8ss=;
	h=Subject:From:To:Cc:Date:From;
	b=JRNXVknFivE+oKOLKG9/FEk6WU8eINWjak8SOCmbMaFxTNS1phv9YfguIFFN3KfOF
	 t5iOys1X6rrUkBynPDgVtnYFMHgxHkAYXiLB65plxJp6Yo5ibt/qpqUHvpGCPZl9m3
	 E/AN1FhQQbtkxTgkkhfC/CU7lvIIfCGp/Ui2SEQ8=
Subject: [PATCH v4 00/18] mshv: Bug fixes across the mshv_root module
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:42:58 +0000
Message-ID: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 02DFA4EB4CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10674-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Action: no action

This series addresses bugs found during a continued review of the
mshv_root module mostly introduced by commit 621191d709b14 ("Drivers: hv:
Introduce mshv_root module to expose /dev/mshv to VMMs").

Changes in v4:
- Dropped the following patches as the issues they fix don't happen in
  practice:
    - mshv: Fix potential integer overflow in mshv_region_create
    - mshv: Fix potential u64 overflow in region overlap check
    - mshv: Add defensive synchronize_srcu in irqfd shutdown

- Added new fixes:
    - mshv: irqfd: Reject routing updates that invalidate resampler binding
    - mshv: Fix sleeping under spinlock in mshv_portid_alloc
    - mshv: Order pt_vp_array publish against irqfd assertion path
    - mshv: Defer mshv_vp free to an RCU grace period
    - mshv: Publish VP to pt_vp_array before installing the file descriptor

- Replaced:
    - mshv: Fix use-after-RCU in mshv_portid_lookup 
      by
      mshv: portid_table: Make mshv_portid_lookup() RCU-aware by contract
    - mshv: Add store/load ordering for VP array publish
      by
      mshv: Order pt_vp_array publish against irqfd assertion path

Changes in v3:
- "Fix mshv_prepare_pinned_region error path for unencrypted
  partitions": removed inline mshv_region_invalidate() to prevent
  zeroing mreg_pages before mshv_region_destroy() can unmap partial
  SLAT mappings; for encrypted share-failure, memset the page array
  without unpinning (pages are host-inaccessible).
- "Consolidate irqfd interrupt injection paths": fixed data race in
  mshv_irqfd_assign EPOLLIN path — girq_ent is now snapshotted inside
  the seqcount loop (matching mshv_irqfd_wakeup) to prevent a
  concurrent routing update from injecting vector 0 to VP 0.
- "Add missing vp_index bounds check in intercept ISR": added
  array_index_nospec() after the bounds check to prevent speculative
  out-of-bounds array access.
- "Add store/load ordering for VP array publish": added missing
  smp_load_acquire in mshv_try_assert_irq_fast.

Changes in v2:
- Added 8 new patches addressing issues found by Sashiko (automated
  review) covering the irqfd, portid, scheduler message, and VP
  lifecycle paths.
- Consolidated the irqfd fast/slow injection paths to eliminate
  duplicated seqcount reads and fix the GSI 0 validity bypass.
- Added memory ordering for the lockless VP array.

The fixes range from data corruption and use-after-free to silent
functional failures and sleeping-while-atomic:

 Memory region management:
  - Integer overflow on userspace-controlled allocation size
    (mshv_region_create)
  - Silent success on map failure for unencrypted partitions
    (mshv_prepare_pinned_region)
  - u64 overflow in region overlap check allowing overlapping mappings

 IRQ/eventfd path:
  - IRQ state leak and type truncation in hypercall helpers
  - Missing locking and hlist_del vs hlist_del_init race in irqfd
    deassign
  - Defensive synchronize_srcu in irqfd shutdown (follows KVM pattern)
  - NULL pointer dereference on spurious interrupt to non-existent VP
    (mshv_try_assert_irq_fast)
  - Broken seqcount read protection — torn reads of interrupt routing
  - Duplicated and inconsistent validity checks between fast/slow
    injection paths; fast path could inject vector 0 spuriously
  - Level-triggered check on uninitialized data making interrupt
    resampling completely non-functional
  - Duplicate GSI 0 detection using the wrong predicate

 Port ID table:
  - Use-after-RCU in mshv_portid_lookup (dereference outside read-side
    critical section)
  - Sleeping under spinlock in mshv_portid_alloc (GFP_KERNEL inside
    idr_lock)
  - Use kfree_rcu for deferred free without blocking

 SynIC / ISR paths:
  - Missing VP index bounds check in intercept ISR (OOB in interrupt
    context from untrusted hypervisor data)
  - Missing store/load ordering for VP array publish — lockless ISR
    readers could observe partially-initialized VP
  - Missing bounds validation in scheduler messages
    (handle_pair_message vp_count, handle_bitset_message bank_mask)

 Miscellaneous:
  - Missing error code on VP allocation failure (silent success to
    userspace)

Kudos to Claude and Sashiko for assisting with analysis and
implementation.

---

Stanislav Kinsburskii (18):
      mshv: Fix IRQ leak and type hazards in hv_call_modify_spa_host_access
      mshv: Fix mshv_prepare_pinned_region error path for unencrypted partitions
      mshv: Fix race in mshv_irqfd_deassign
      mshv: Add NULL check for vp in mshv_try_assert_irq_fast
      mshv: irqfd: Reject routing updates that invalidate resampler binding
      mshv: Fix broken seqcount read protection
      mshv: Consolidate irqfd interrupt injection paths
      mshv: Fix level-triggered check on uninitialized data
      mshv: Fix duplicate GSI detection for GSI 0
      mshv: portid_table: Make mshv_portid_lookup() RCU-aware by contract
      mshv: Fix sleeping under spinlock in mshv_portid_alloc
      mshv: Use kfree_rcu in mshv_portid_free
      mshv: Add missing vp_index bounds check in intercept ISR
      mshv: Order pt_vp_array publish against irqfd assertion path
      mshv: Defer mshv_vp free to an RCU grace period
      mshv: Validate scheduler message bounds from hypervisor
      mshv: Publish VP to pt_vp_array before installing the file descriptor
      mshv: Fix missing error code on VP allocation failure


 drivers/hv/mshv_eventfd.c      |  136 +++++++++++++++++++++++++---------------
 drivers/hv/mshv_irq.c          |   46 +++++++++++++-
 drivers/hv/mshv_portid_table.c |   31 ++++-----
 drivers/hv/mshv_root.h         |    3 +
 drivers/hv/mshv_root_hv_call.c |   18 ++---
 drivers/hv/mshv_root_main.c    |   72 +++++++++++++++------
 drivers/hv/mshv_synic.c        |   40 +++++++++---
 7 files changed, 233 insertions(+), 113 deletions(-)


