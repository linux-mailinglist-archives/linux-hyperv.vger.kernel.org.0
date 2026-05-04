Return-Path: <linux-hyperv+bounces-10592-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP4hAXvs+Gmi3AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10592-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 20:59:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C2D4C2D71
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 20:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 554CB300CCB3
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 18:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B576E3E6383;
	Mon,  4 May 2026 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Efs/XBhE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BFD3DE42C;
	Mon,  4 May 2026 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921143; cv=none; b=InvyVizJUyDEYWu94j2JY01HmxSzn4CqA5nplKmcDT9FDyKKvb3w80MdzF8IPouRjkB2Fvf23StBvIe4YDoxTCdtnIePJCdfDu7SdweEKdLZBQPzCpoirb0QKW0l52GbxdDpcsBnUF48FV1ftZJ+W9JL89I56oHuzjf4ptthXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921143; c=relaxed/simple;
	bh=L4Syd89FfZ6pnv2ZJm85Lr9BWrdmeErNx0QEO8lNHmI=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=h+ShBTgYmsx7eSK0i6zrsQk7O/Csm6YNQTkOMLvWZLtYK/lI3YPzS5Sna1CPnxdP6HgzGjMwegMhSQuSkVwUfrByGVEQ2aNpUxKDrFm+PzOdLdUe3gFoD8eB5U2L3Ry/VKKK9ljD++aPc8Ct6tf9GeP+FfBwn0sPoZTHIixjfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Efs/XBhE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1F8D320B7168;
	Mon,  4 May 2026 11:59:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F8D320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921140;
	bh=gUPUqXggJU2TePuBMwCOwh6JQV87v1Z2A42QtwOifvE=;
	h=Subject:From:To:Cc:Date:From;
	b=Efs/XBhEZunZJ0iecnBHcrIMq8Lho2JjBXExj3HFqUOIMheNZ6xpHYEHz5wkTUjTM
	 Uv8IcAWoOXRwaErx+Wzu4bqRvDpWhyG6ALohZlnhHuU9XjJ0Q1r69j9URXNwjbmZOm
	 u+yjIQ17wkeXaIJwKxZBJJIchJDSTQs+OmwfTotA=
Subject: [PATCH v3 00/18] mshv: Bug fixes across the mshv_root module
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 18:59:01 +0000
Message-ID: 
 <177792097254.89142.47656055124497980.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 63C2D4C2D71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10592-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]

This series addresses bugs found during a continued review of the
mshv_root module introduced by commit 621191d709b14 ("Drivers: hv:
Introduce mshv_root module to expose /dev/mshv to VMMs").

Changes since v2:
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

Changes since v1:
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
      mshv: Fix potential integer overflow in mshv_region_create
      mshv: Fix mshv_prepare_pinned_region error path for unencrypted partitions
      mshv: Fix potential u64 overflow in region overlap check
      mshv: Fix race in mshv_irqfd_deassign
      mshv: Add defensive synchronize_srcu in irqfd shutdown
      mshv: Add NULL check for vp in mshv_try_assert_irq_fast
      mshv: Fix broken seqcount read protection
      mshv: Consolidate irqfd interrupt injection paths
      mshv: Fix level-triggered check on uninitialized data
      mshv: Fix duplicate GSI detection for GSI 0
      mshv: Fix use-after-RCU in mshv_portid_lookup
      mshv: Fix sleeping under spinlock in mshv_portid_alloc
      mshv: Use kfree_rcu in mshv_portid_free
      mshv: Add missing vp_index bounds check in intercept ISR
      mshv: Add store/load ordering for VP array publish
      mshv: Validate scheduler message bounds from hypervisor
      mshv: Fix missing error code on VP allocation failure


 drivers/hv/mshv_eventfd.c      |  108 +++++++++++++++++++++++++---------------
 drivers/hv/mshv_irq.c          |    2 -
 drivers/hv/mshv_portid_table.c |   12 ++--
 drivers/hv/mshv_regions.c      |    2 -
 drivers/hv/mshv_root_hv_call.c |   18 ++-----
 drivers/hv/mshv_root_main.c    |   39 ++++++++++----
 drivers/hv/mshv_synic.c        |   36 +++++++++++--
 7 files changed, 136 insertions(+), 81 deletions(-)


