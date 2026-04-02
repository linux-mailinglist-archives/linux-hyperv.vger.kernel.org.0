Return-Path: <linux-hyperv+bounces-9920-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNzCI5+vzml+pQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9920-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:04:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 879D238CDBC
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85DE43014F4E
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0B2336897;
	Thu,  2 Apr 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LGFJJ3Nk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984F3128D7;
	Thu,  2 Apr 2026 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153050; cv=none; b=YFQFylXBmsA78q7YmwFZnQTkWjtSWAonAv+gvhG7Dmd46HDWJDfJU7MZYepOaxUK+J1kNhCICiKPegKillIdT4LsIZaRNbahl8HURcpyROexuniyMNBGWEeg0T96OvX2sqd5JPpPS7lVNBvEhVAvQPmnrorElOg2GeOU3HonMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153050; c=relaxed/simple;
	bh=LY8NkeVPAXBVOjpY3sLvL09nCimbJDOezTIjvmBoKdY=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=QtwBd0iu2KO43R0sKy+s8ksu0+v0hxtcW1G3oFxeQYmPI3o1fuyKYAJozOtpVQiCCvrQs9/tOf9fi+T4infONw0eVcdDxJjBQpq8Csy1gDxQzD7bK1zr0bmBXLxBJjDg6QVaHqWkSrOWXyM/kxMTbgBZtfbVTILOn5fSjFarXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LGFJJ3Nk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id E084120B710C;
	Thu,  2 Apr 2026 11:04:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E084120B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775153048;
	bh=dAr9wMyNyMyOd8EEYSGvvQvgCoVd1hOFJrKPRWE9d1o=;
	h=Subject:From:To:Cc:Date:From;
	b=LGFJJ3Nkok2Q7bZVtqZR/BLaUG3w/NzGKHhB35p0uKAPWb8+PexYAMB/stTtzorkB
	 aykGGCXBWEuf/papyvr3Dx8Xi1nv/EBtEMRuceG6aW/XaGybv3RuCEPIr2aE3/ROPY
	 2DcLM7uv19C60/zgqdYvwRb/yCojnxLtosyuhin0=
Subject: [PATCH v2 0/7] mshv: Reduce memory consumption for unpinned regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 18:04:08 +0000
Message-ID: 
 <177515251087.119822.1940529498624181326.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9920-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 879D238CDBC
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

v2: 
- Improved commit message
- Fixed invalid vfree(region->mreg_pfns) call for MMIO-backed regions
- Fixed unpinning of already-released pages in the error path during
  pinned region creation
- Removed redundant mshv_map_region helper in favor of the new
  optimized mapping logic

---

Stanislav Kinsburskii (7):
      mshv: Consolidate region creation and mapping
      mshv: Improve code readability with handler function typedef
      mshv: Rename mshv_mem_region to mshv_region
      mshv: Optimize memory region mapping operations
      mshv: Pass pfns array explicitly through processing chain
      mshv: Simplify pfn array handling in region processing
      mshv: Allocate pfns array only for pinned regions


 drivers/hv/mshv_regions.c   |  350 +++++++++++++++++++++++++------------------
 drivers/hv/mshv_root.h      |   26 ++-
 drivers/hv/mshv_root_main.c |   79 ++++------
 3 files changed, 249 insertions(+), 206 deletions(-)


