Return-Path: <linux-hyperv+bounces-9865-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vcJ7J8WvzGk1VgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9865-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 07:40:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95794374EED
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 07:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60434302A956
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 05:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8E0315D53;
	Wed,  1 Apr 2026 05:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XV6dE29f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51530E0D6;
	Wed,  1 Apr 2026 05:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022014; cv=none; b=YbakP5m8+AgVdU/r6tSD0JhgQm2sCEI2L56e3cB1aK02ODw9IKgTp7d1kuaD1wIwCeuqJTaInmIiOhD+dNgozTl1HLac0rH/x+3c0x5nrty95GPkd/Sphvh7efvfAOahpw9AmplKIPtWQ64Rg+xbH9QV1iebtecwAIg8Tb7+tgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022014; c=relaxed/simple;
	bh=D1nSRYKV03fklYAs3I9pzd20jICVHe/XAztKoR/d7L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4meCK9CtL5hNhdRZutRVvVSLBtYut85pPr1oXa8Ulx9Iz8DzIvsZj5sajVKYRC9/QwcV1INnMbI/8ytJw306fb8MXJmwPNDC9uxcTAQczjc0ZZrQE2EqnszS7W1Ii182u/IOHZX5f0QqiRcewDrzd41uANSyAov8O2LxPZOshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XV6dE29f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.21])
	by linux.microsoft.com (Postfix) with ESMTPSA id ECFD020B710C;
	Tue, 31 Mar 2026 22:40:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ECFD020B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775022012;
	bh=TxP+MC+wooBLsyZZR8+DLhtJoDpNcpbPWNAbp5HKFIY=;
	h=From:To:Cc:Subject:Date:From;
	b=XV6dE29f+K/5uMmeEwFG/0Tnpemxs5msWbZFanmSwV4+HvxK+AcWrSpUeuWvrNqiX
	 gQJriBlV7QGR4vpaPsF7UgEkho5RdiS+ado1Un9gxz0trBW2jKNXcCNNm92H0mZ9TY
	 Lppf0jjhL5WEy1AuwNdO0ZzJOBuXhR15y+4SSiJQ=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: mshv_vtl: Fix vmemmap_shift exceeding MAX_FOLIO_ORDER
Date: Wed,  1 Apr 2026 05:40:05 +0000
Message-ID: <20260401054005.1532381-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9865-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 95794374EED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When registering VTL0 memory via MSHV_ADD_VTL0_MEMORY, the kernel
computes pgmap->vmemmap_shift as the number of trailing zeros in the
OR of start_pfn and last_pfn, intending to use the largest compound
page order both endpoints are aligned to.

However, this value is not clamped to MAX_FOLIO_ORDER, so a
sufficiently aligned range (e.g. physical range 0x800000000000-
0x800080000000, corresponding to start_pfn=0x800000000 with 35
trailing zeros) can produce a shift larger than what
memremap_pages() accepts, triggering a WARN and returning -EINVAL:

  WARNING: ... memremap_pages+0x512/0x650
  requested folio size unsupported

The MAX_FOLIO_ORDER check was added by
commit 646b67d57589 ("mm/memremap: reject unreasonable folio/compound
page sizes in memremap_pages()").
When CONFIG_HAVE_GIGANTIC_FOLIOS=y, CONFIG_SPARSEMEM_VMEMMAP=y, and
CONFIG_HUGETLB_PAGE is not set, MAX_FOLIO_ORDER resolves to
(PUD_SHIFT - PAGE_SHIFT) = 18. Any range whose PFN alignment exceeds
order 18 hits this path.

Fix this by clamping vmemmap_shift to MAX_FOLIO_ORDER so we always
request the largest order the kernel supports, rather than an
out-of-range value.

Also fix the error path to propagate the actual error code from
devm_memremap_pages() instead of hard-coding -EFAULT, which was
masking the real -EINVAL return.

Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/mshv_vtl_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 5856975f32e12..255fed3a740c1 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -405,8 +405,12 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
 	/*
 	 * Determine the highest page order that can be used for the given memory range.
 	 * This works best when the range is aligned; i.e. both the start and the length.
+	 * Clamp to MAX_FOLIO_ORDER to avoid a WARN in memremap_pages() when the range
+	 * alignment exceeds the maximum supported folio order for this kernel config.
 	 */
-	pgmap->vmemmap_shift = count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn);
+	pgmap->vmemmap_shift = min_t(unsigned long,
+				     count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn),
+				     MAX_FOLIO_ORDER);
 	dev_dbg(vtl->module_dev,
 		"Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: %lu\n",
 		vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
@@ -415,7 +419,7 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
 	if (IS_ERR(addr)) {
 		dev_err(vtl->module_dev, "devm_memremap_pages error: %ld\n", PTR_ERR(addr));
 		kfree(pgmap);
-		return -EFAULT;
+		return PTR_ERR(addr);
 	}
 
 	/* Don't free pgmap, since it has to stick around until the memory

base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
-- 
2.43.0


