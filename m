Return-Path: <linux-hyperv+bounces-10552-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gi3OGid99WnZLgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10552-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:27:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1AE4B0D2E
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF32F3010243
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 04:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9919263C7F;
	Sat,  2 May 2026 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EtR2CT5N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB71A9B24;
	Sat,  2 May 2026 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696033; cv=none; b=fVloPR8sviuG2q0WIE//Dt0SyI9UOpcQlEA4z2QADUrLmGSeWLf8WrN7UcqZd//kO3ErfOXbb3U78eVoI6XZ4BS7sAdzRvefLGytKlFNTA80BnuH28v0DwHHu/BmTil5c31l3QBl42nEgcq7HffaLI9qpRRoy94Lo5DUzOWGjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696033; c=relaxed/simple;
	bh=z6cRl3sdcH1Sh1i25dmuw8HxOJ/7EjzMbd1iTyLxo+E=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=mCCHf/5ZGAe4yYhlR4bHqd2sDGs05L+ArSsIPTYQz9RS0NqR67VGsGxjZWbCJXgPZOXXK9Agfc+oR7s1LHhLCJIuKauHv4NAVbi4IcIn6T85hbDkh8VQzaxvoKH39cQqYsrfYquQD13MxDWWb4nWD2skPmYK09YkQKFsWQljj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EtR2CT5N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 57BBA20B7168;
	Fri,  1 May 2026 21:27:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57BBA20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696031;
	bh=1Mv/b1DJagwBsTXp+GA+ANZ6mUFhByQ+l+zeO3/FZzY=;
	h=Subject:From:To:Cc:Date:From;
	b=EtR2CT5N6a5i5knXwC4xrIH73C5kICY37zJwqABfopmnbVvt7rectco+wwjR8MZSo
	 lkWzSyJm61WiY7/1a04Qk6PNMbaJmJkgdzb+HZnwT5tp8XD+CgIVDGKUpAp7c2Njg3
	 mmnK1F1t3NdJrysEc5mvidA5FoMa7AAyYKBgyI+E=
Subject: [PATCH v2 00/18] mshv: Bug fixes across the mshv_root module
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:27:11 +0000
Message-ID: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC1AE4B0D2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10552-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]

This series addresses bugs found during a continued review of the
mshv_root module introduced by commit 621191d709b14 ("Drivers: hv:
Introduce mshv_root module to expose /dev/mshv to VMMs").

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


 drivers/hv/mshv_eventfd.c      |  104 +++++++++++++++++++++++++---------------
 drivers/hv/mshv_irq.c          |    2 -
 drivers/hv/mshv_portid_table.c |   12 ++---
 drivers/hv/mshv_regions.c      |    2 -
 drivers/hv/mshv_root_hv_call.c |   18 ++-----
 drivers/hv/mshv_root_main.c    |   24 +++++++--
 drivers/hv/mshv_synic.c        |   34 ++++++++++---
 7 files changed, 122 insertions(+), 74 deletions(-)


