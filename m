Return-Path: <linux-hyperv+bounces-9884-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFbvN0+YzWkrfQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9884-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 00:12:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA282380DB0
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 00:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F221300C6EC
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473BD31A56D;
	Wed,  1 Apr 2026 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pGG77EMo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07868341AB6;
	Wed,  1 Apr 2026 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081546; cv=none; b=Er0f/BYgQKTnRyp9ZpQ5b8KQZdmMP3wFWuxl3nkT2GLzqGIqxZSwWeqnBa2E2EKEZ95+Jtpwf4N++rkhxgjaxHTiEpjHgM6ZuzL5a2NiWHH1RZ6j3NxCAnZYSvgdXrKisVxllGPi8AbOj/IE+rItHqOHD7AmvagXXpj6bmg6Iqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081546; c=relaxed/simple;
	bh=9rhEWIBppKetDx6S1v3ujdCVZyqqf3/CIPVX9qLGTkQ=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Y2A051f7RwjDprSUzaKi/4gRweDhzfN/QSSJhwrh/JaJKPRTRZCyDnm8DwYsFZY6PTrvQBzqB1HaY54J+5uz22Brf2MjqTLoZctkIkgDA/3Qhz4VKbieIVulnzFGwC75K/p1QHcq40yyty3y89kZY4uQJWyAqVxJ9uxXK2YEGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pGG77EMo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9F77A20B710C;
	Wed,  1 Apr 2026 15:12:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F77A20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775081544;
	bh=yKpH4TWgNxsnf5YAZYk+0M02uH92VNTeJyIkpjNohmI=;
	h=Subject:From:To:Cc:Date:From;
	b=pGG77EMogVvsR0zlAIyHycmQ5YqDQt5r5dyWOh3OS9M3m25oEW36EazmHifH9Piwi
	 +EYmHMZdl8/e/UUmWs7xuQWsiAAazprQGjFQfgBB5dB17J5Dt4+dtPLsUBwiFDR1Aq
	 bJGNQI8/KoVGG9tf/DhSSgRReX6E4Y3mjha/Bgw8=
Subject: [PATCH 0/7] mshv: Reduce memory consumption for unpinned regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 01 Apr 2026 22:12:24 +0000
Message-ID: 
 <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9884-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA282380DB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series reduces memory consumption for unpinned regions by avoiding
PFN array allocation. A 1GB unpinned region currently wastes 2MB for an
unused PFN array that HMM-managed regions don't need.

The first three patches are preparatory refactoring. Patch 1 consolidates
region creation and mapping logic, reducing API surface by 4 functions.
Patch 2 introduces a typedef for PFN handler callbacks to simplify
function signatures. Patch 3 renames mshv_mem_region to mshv_region to
align with existing function naming conventions.

Patch 4 optimizes unmap and no-access remap operations by eliminating
redundant PFN iteration when all frames are guaranteed to be mapped.
This uses large page flags for aligned chunks and removes unnecessary
helper functions.

Patches 5-6 decouple PFN processing from the region->pfns storage.
Patch 5 threads the pfns pointer explicitly through the processing
chain. Patch 6 removes offset-based indexing by having callers pass
pre-offset pointers.

Patch 7 converts the pfns array from a flexible array member to a
conditional pointer, allocated only for pinned regions that need it
for share/unshare/evict operations. This eliminates the memory waste
for unpinned regions and allows using kzalloc instead of vzalloc.

---

Stanislav Kinsburskii (7):
      mshv: Consolidate region creation and mapping
      mshv: Improve code readability with handler function typedef
      mshv: Rename mshv_mem_region to mshv_region
      mshv: Optimize memory region mapping operations
      mshv: Pass pfns array explicitly through processing chain
      mshv: Simplify pfn array handling in region processing
      mshv: Allocate pfns array only for pinned regions


 drivers/hv/mshv_regions.c   |  345 +++++++++++++++++++++++++------------------
 drivers/hv/mshv_root.h      |   26 ++-
 drivers/hv/mshv_root_main.c |   79 ++++------
 3 files changed, 248 insertions(+), 202 deletions(-)


