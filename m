Return-Path: <linux-hyperv+bounces-10480-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF6GF0lL8mnNpQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10480-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:17:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB126498E1E
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 598B7301FF9C
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5364B41B36F;
	Wed, 29 Apr 2026 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lWhwMdf8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7BF41C2EB;
	Wed, 29 Apr 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486660; cv=none; b=uhZgn4qrhYlVf4rZjIY3l7lUvPJmPMXvdxviL9MxPo1k3nAngM6XgZ8ZjEBSArMxCl81KxBlV2leaTNAvnCT9EI4ey9Kl5rKKmGrzLIoxdS60Y+d+ajaf8tllXQ9HMZC0TetgwkbBf1quqVcbxoOaLsJS8fvpsqETfjT9h00WXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486660; c=relaxed/simple;
	bh=GVkAxCyVYEX2m14EmJpzvZj13BqP/2aGLml9yMh7Ths=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Y/+hm4kZWqVH62ENEOl4UWwaFpHVOdxlNA4PXyC9hGcyS2x4cj1KtgiqRSsvTFuwxa+GArmN4HeHdAteseN3UcnXZEFZDJL0hObEgumrqmFkf4BeMMs+UcnJicawdJedxS708DGYONuiRi1gXq3JwdMd2PRfOm9QGsvMpIrtQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lWhwMdf8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id BAC0120B716C;
	Wed, 29 Apr 2026 11:17:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAC0120B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777486657;
	bh=maYBAwMCGdYvF5VkLq+7HmnUqcLCaH4iybcfIHKeil8=;
	h=Subject:From:To:Cc:Date:From;
	b=lWhwMdf8rchLBVpYPhbagxjlrqH81cU7/fMWs+tu9FBsNfF+zaqYMaOx+wfXmx5mn
	 mxAPv1Hpe9cdbCATLRZPWPIvA6hEwgRvQ62gO78gAXdTxEuHsZZdb+huaL+2TYpJB1
	 FejtYRisIvQp6INKv+tujSOAglMUqa0ZZg2Qcg3s=
Subject: [PATCH 00/10] mshv: Bug fixes across the mshv_root module
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Apr 2026 18:17:37 +0000
Message-ID: 
 <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AB126498E1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10480-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]

 This series addresses bugs found during a review of the mshv_root module
 introduced by commit 621191d709b14 ("Drivers: hv: Introduce mshv_root
 module to expose /dev/mshv to VMMs").

 The fixes range from data corruption and use-after-free to silent
 functional failures:

  - IRQ state leak and type truncation in hypercall helpers
    (hv_call_modify_spa_host_access)
  - Integer overflow on userspace-controlled allocation size
    (mshv_region_create)
  - Missing locking, broken seqcount read protection, and a check on
    uninitialized data in the irqfd path — the latter makes
    level-triggered interrupt resampling completely non-functional
  - Duplicate GSI 0 detection using the wrong predicate
  - Use-after-RCU in port ID lookup
  - Missing VP index bounds check in intercept ISR (OOB in interrupt
    context)
  - Missing error code on VP allocation failure (silent success to
    userspace)

---

Stanislav Kinsburskii (10):
      mshv: Fix IRQ leak and type hazards in hv_call_modify_spa_host_access
      mshv: Fix potential integer overflow in mshv_region_create
      mshv: Fix missing lock in mshv_irqfd_deassign
      mshv: Fix broken seqcount read protection
      mshv: Fix level-triggered check on uninitialized data
      mshv: Fix duplicate GSI detection for GSI 0
      mshv: Fix use-after-RCU in mshv_portid_lookup
      mshv: Use kfree_rcu in mshv_portid_free
      mshv: Add missing vp_index bounds check in intercept ISR
      mshv: Fix missing error code on VP allocation failure


 drivers/hv/mshv_eventfd.c      |   75 ++++++++++++++++++++++------------------
 drivers/hv/mshv_irq.c          |    2 +
 drivers/hv/mshv_portid_table.c |    6 +--
 drivers/hv/mshv_regions.c      |    2 +
 drivers/hv/mshv_root_hv_call.c |   18 +++-------
 drivers/hv/mshv_root_main.c    |    4 ++
 drivers/hv/mshv_synic.c        |    4 ++
 7 files changed, 59 insertions(+), 52 deletions(-)


