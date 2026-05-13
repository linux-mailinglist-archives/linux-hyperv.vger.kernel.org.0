Return-Path: <linux-hyperv+bounces-10860-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IqPDY3LBGp2OwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10860-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:05:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E62C5398D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E24316ECBD
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9B03AE704;
	Wed, 13 May 2026 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TAU00s93"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634C73ACA45;
	Wed, 13 May 2026 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698478; cv=none; b=DvKDlWUIfRW+Lh1nM7bRNh0QU8ncqNr421CT66/vO1RbeAgwNeRDPDT1TpXqlMWK/9+5m5mi6xfVUtG+cLoVB1SnndsNulCu3BbNZwNaANZKpaYXemboLAtJ/vQSHYPPICnKf0uvwtkn6SlKr1VENzIR52nio9Py4Ro9ZXS+/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698478; c=relaxed/simple;
	bh=kjDlkcEbohcrqcC/SRu8GFQ7UwWfQvpOo7YDLKDMhqo=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=nTyWwTxLz+k7ElhjzUgUSsPWMKSkotwXjZSdysHJq564AqDtXMnIQ1E+/aWCk0VUgpN19w4yA+Y3+6efiUFHF5yysXeLxjdbp8ZHRQ2F5pBceb9K9NpBUVh1PF1FBInB1T38f500OslFDaONC3X9+U4XyDyQNDs1xQUkNQcij6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TAU00s93; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8313420B7166;
	Wed, 13 May 2026 11:54:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8313420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698472;
	bh=Hac8Ju7C9ehD53g/jIfHdPPDEyjle0a1BIa8DdYnNm0=;
	h=Subject:From:To:Cc:Date:From;
	b=TAU00s93gFL27AUdzubG6UoHyi3UU2KCxKHJrC0VKChX4KCSAwhdoYHUDwt8TMThk
	 Vf8xquGoLaQDXKQGGvOqDsYEzwEW2IqnWi3Jh1M1Xr4MgCXGuzCTYHXA4eG6uVwJYB
	 RmzCVM9HEJNrAo+RaSLO9hJnPGFTG/5JWjdM1d7s=
Subject: [PATCH v4 0/6] mshv: Reduce memory consumption for unpinned regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:54:35 +0000
Message-ID: 
 <177869833161.19379.1357399549586915698.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8E62C5398D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10860-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

This series reduces memory consumption for unpinned regions by avoiding
PFN array allocation. A 1GB unpinned region currently wastes 2MB for an
unused PFN array that HMM-managed regions don't need.


v4:
 - Rebased on the latest state of the tree.
 - Dropped "mshv: Improve code readability with handler function typedef"
   as redundant.

v3:
- Fix missing unmap/remap of pages before the first huge page.

v2:
- Improved commit message
- Fixed invalid vfree(region->mreg_pfns) call for MMIO-backed regions
- Fixed unpinning of already-released pages in the error path during
  pinned region creation
- Removed redundant mshv_map_region helper in favor of the new
  optimized mapping logic

---

Stanislav Kinsburskii (6):
      mshv: Consolidate region creation and mapping
      mshv: Rename mshv_mem_region to mshv_region
      mshv: Optimize region unmap and invalidation with large pages
      mshv: Pass pfns array explicitly through processing chain
      mshv: Simplify pfn array handling in region processing
      mshv: Allocate pfns array only for pinned regions


 drivers/hv/mshv_regions.c   |  346 +++++++++++++++++++++++++++----------------
 drivers/hv/mshv_root.h      |   28 ++-
 drivers/hv/mshv_root_main.c |   81 ++++------
 3 files changed, 265 insertions(+), 190 deletions(-)


