Return-Path: <linux-hyperv+bounces-10835-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI3bGeKMBGqvLQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10835-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 16:38:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B06F45353AE
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 16:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5056334729BD
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A102BDC16;
	Wed, 13 May 2026 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Ik5vclci"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AE62BD58A;
	Wed, 13 May 2026 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678775; cv=pass; b=rioTTTsuqzqsuL8oLVXmS+V3e09c2dXYNNWDuN0Rj26pGugbPzA4Hmg+nSNSCBuE+jJoDWyz6QAIT2TycKM8Jt/uMcVcJyXKVstHhWUoydMYBP0dGrBs8OSPXhVSCB34iiqTZ2kgE1+iVZ/J9hmpybp3tfe7ffsZr9WWgQchH1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678775; c=relaxed/simple;
	bh=dYbeadsAGJ+Zbhm0oJXGSDW4T6i4SeUFR4SovzEaHGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=La7N8EriXSXxB+vCwlJQPYJSxTZI04i1caeyw1j9jUplr0WFVGqyhElcT56bRLL5JRt2x5omXkyLxYnZ1E9PLFfV8Iw1d68+UglGtPLKZ4IVnzm8L8CFXOF+d+ODl7aGoAc5vC7qI9bVYY0EvlaXTNG+AGJ2goaG56ULfr/0qcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Ik5vclci; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1778678765; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QKLWC9V93kzTvP0x8kKwDigxBOH5tWAVDmX+dIjn21/iEx2e9GXAZgKLxypY7BG4yZgTzhp2Vg0g33PgrSElt/0fAKBgn6FAkLTKQRLQ4Rskt+cqaOj1lMHGU9kl7/Iv8rzWu1Q6bozl/GYWR3cbkgrUU5xkTvWPjE/uWPlgrn4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778678765; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SQBhBfoR+XlO9YE2a+cU1/6jM7FCJVPL1K4VCq+R744=; 
	b=CYMFlr0nHS/oWU7XI5SFRGQQlQcgO5hBVXS0VfI7tluJkUaBI7PLTvT/gTe6VjVsG8SLHagri0PlaPqm1ZEdqGswSCUQNrbV5ty9QFifblgh2uj9n0+869tK998v6r8z5ylhodZ/39+X+XJC/RWjSpimDkPTyYEht9l8iav9Xbk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778678765;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=SQBhBfoR+XlO9YE2a+cU1/6jM7FCJVPL1K4VCq+R744=;
	b=Ik5vclci710rkV3OLBiqHc355L1xTbf+4k6P2TZJXIHoYLPtCCZZ7LJSw33gZTzL
	40N/RIqypyPDwq3ESVVyZ08ZW6t+Q30LkElFqorqUg8LpxmocFik5MOK1lKv6r7djPA
	p7Wz6/kJWHRctFg+O23Fd70ZKp/Jm09KTG+Ukrto=
Received: by mx.zohomail.com with SMTPS id 1778678762389573.8445751188488;
	Wed, 13 May 2026 06:26:02 -0700 (PDT)
From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
Date: Wed, 13 May 2026 13:25:56 +0000
Subject: [PATCH v4] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-huge_1g-v4-1-33cda59e4a70@anirudhrb.com>
X-B4-Tracking: v=1; b=H4sIAON7BGoC/23N3w6CIBiH4VtxHEfjn4gddR+tNYRP4SBtkKzmv
 PfQE111+PvG8zKhCMFDRKdiQgGSj37o8xCHAhmn+w6wt3kjRpgkgkrsxg5utMMghJCU19yoFuX
 XjwCtf62lyzVv5+NzCO81nOhy/W0kiikGImXFlbG2bc6692G0LjRHM9zR0klssyUpN8uybaSuK
 WeVVsr+s3xvd//ybJkECsIIXoP4tvM8fwAX5r0GGgEAAA==
X-Change-ID: 20260416-huge_1g-e44461393c8f
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>, 
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
X-Rspamd-Queue-Id: B06F45353AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10835-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:email,anirudhrb.com:mid,anirudhrb.com:dkim]
X-Rspamd-Action: no action

The hypervisor's map GPA hypercall coalesces contiguous 2M-aligned
chunks into 1G mappings when alignment permits, so the driver can
support 1G hugepages by feeding them in as 2M chunks. Note that this
is the only way to make 1G mappings; there is no way to directly map
a 1G hugepage using the hypercall.

Always emit a 2M (PMD_ORDER) stride for the huge-page case. The
hypercall has no 1G stride, so 1G folios are processed as a
sequence of 2M chunks. Folios whose order is less than PMD_ORDER
(e.g. mTHP) fall back to single-page stride; mapping them as 2M
would fail in the hypervisor anyway.

Assisted-by: Copilot-CLI:claude-opus-4.7
Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
Changes in v4:
- Changed the check to page_order < PMD_ORDER for using page stride of 1
  - Also updated the commit message.
- Pick up Acked-by:
- Link to v3: https://lore.kernel.org/r/20260506-huge_1g-v3-1-26e1e4c439e4@anirudhrb.com

Changes in v3:
- Fixed various corner cases reported by Sashiko.
- Link to v2: https://lore.kernel.org/r/20260505-huge_1g-v2-1-b6a91327a88d@anirudhrb.com

Changes in v2:
- Handled the case where we can have 2M aligned pages in the middle of a
  1G page
- Brought back the page order check but expanded it to include 1G
- Clamp stride to requested page count in mshv_region_process_chunk
- Link to v1: https://lore.kernel.org/r/20260416-huge_1g-v1-1-e066738cddfb@anirudhrb.com
---
 drivers/hv/mshv_regions.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index fdffd4f002f6..6d65e5b42152 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -29,29 +29,27 @@
  * Uses huge page stride if the backing page is huge and the guest mapping
  * is properly aligned; otherwise falls back to single page stride.
  *
- * Return: Stride in pages, or -EINVAL if page order is unsupported.
+ * Return: Stride in pages.
  */
-static int mshv_chunk_stride(struct page *page,
-			     u64 gfn, u64 page_count)
+static unsigned int mshv_chunk_stride(struct page *page, u64 gfn,
+				      u64 page_count)
 {
-	unsigned int page_order;
+	unsigned int page_order = folio_order(page_folio(page));
 
 	/*
 	 * Use single page stride by default. For huge page stride, the
-	 * page must be compound and point to the head of the compound
-	 * page, and both gfn and page_count must be huge-page aligned.
+	 * folio order must be at least PMD_ORDER, the page's PFN must be
+	 * 2M-aligned (so that a 2M-aligned tail page of a larger folio is
+	 * acceptable), and both gfn and page_count must be 2M-aligned.
 	 */
-	if (!PageCompound(page) || !PageHead(page) ||
+	if (page_order < PMD_ORDER ||
+	    !IS_ALIGNED(page_to_pfn(page), PTRS_PER_PMD) ||
 	    !IS_ALIGNED(gfn, PTRS_PER_PMD) ||
 	    !IS_ALIGNED(page_count, PTRS_PER_PMD))
 		return 1;
 
-	page_order = folio_order(page_folio(page));
-	/* The hypervisor only supports 2M huge page */
-	if (page_order != PMD_ORDER)
-		return -EINVAL;
-
-	return 1 << page_order;
+	/* Use 2M stride always i.e. process 1G folios as 2M chunks */
+	return 1 << PMD_ORDER;
 }
 
 /**
@@ -86,15 +84,14 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
 	u64 gfn = region->start_gfn + page_offset;
 	u64 count;
 	struct page *page;
-	int stride, ret;
+	unsigned int stride;
+	int ret;
 
 	page = region->mreg_pages[page_offset];
 	if (!page)
 		return -EINVAL;
 
 	stride = mshv_chunk_stride(page, gfn, page_count);
-	if (stride < 0)
-		return stride;
 
 	/* Start at stride since the first stride is validated */
 	for (count = stride; count < page_count; count += stride) {

---
base-commit: cd9f2e7d6e5b1837ef40b96e300fa28b73ab5a77
change-id: 20260416-huge_1g-e44461393c8f

Best regards,
-- 
Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


