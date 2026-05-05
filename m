Return-Path: <linux-hyperv+bounces-10623-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNXOCSiH+Wmx9QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10623-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 07:59:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7875C4C70C7
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 07:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED9330075C5
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2026 05:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FE23C2768;
	Tue,  5 May 2026 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="atqR4IjK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B83C2772;
	Tue,  5 May 2026 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960741; cv=pass; b=DxkZs0YIwsH651Vf8VP0CriwRvXFPkB5OwlVSAjKaYiXN4MqVsLf3dCjdYAkunW4Vvd2MHdqCJI+j0UbCIneBPekNM3RRSu8MoDP2XqSsF63juJbia6BZksyQBoooV7XLvoZYQsm0tsd8cmxEefywl4AnbDT8N+WYojahJkS70I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960741; c=relaxed/simple;
	bh=Lw827fZdNbiDMsYMtKRMHVQb9Sbl7FDKkrSOmHBLsYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FvpQ1beJTWSdumKWXvgFB0GBdjy8JxbQ+MGaFSVRypeDYYAVLfxLBiLW8fNcqojc3Bd6WoOhacGDPQryKeOn3NWn70oyBCvMU/fuCinR/DIuEGYbBqRNo9mqgmy8/KZDeKkSkYzczmipoGix47x926a866+9hSDfW1rBjksFJww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=atqR4IjK; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1777960733; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NE8etlf1uGN4+OuksR3Q7MJRT2cTIGz12YNySltAgNJUhcSCfWLgnm9K+3yr09uTOqIh43JMlR3yRQxqnj+xKbzUkXtTcWQY0IG8PD7d7X+h+SUAbjAHBFhTXfdqJF01JXVeZLpmFYAmePidl8aVHR26MxaJqo6Sc/fSPrwBKRY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777960733; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vDYUzOGAJq68zacrE3BmhlGXJbEsF7AKAeUFPKBqIfk=; 
	b=Yhh/1dvCNuy8YuPadXIEnM4lMCuOwVPQuv+qjXJbmAgE/GXNcN6b2QV/lJO55cfVAfolGn3eQSJx+cmQcz6T5cmnCXL8fmV20V+6wiKDTUy2n0zZ/JD0mOWx8WAuhnVOlfVSPGvgZpNPG1eK4j7tP3WOKVYsulUjlLGBYNyLFC8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777960733;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=vDYUzOGAJq68zacrE3BmhlGXJbEsF7AKAeUFPKBqIfk=;
	b=atqR4IjKCoWjyzQwt6qKYAaaq/X1n3WMJlGf82D1hwakBHaVySJAr4zjMPfXmOAU
	Rk+8aj/NH1igZq5SrxsB6rgCJpsfWGG4nj9KHS+MO5wCLHvzyuPGJF4+CMsr7V+Vq4l
	zekBGYOKqPS+ppURxj5TlFDGKX2h3Lw2NSYDOuSM=
Received: by mx.zohomail.com with SMTPS id 1777960730928244.52798854866376;
	Mon, 4 May 2026 22:58:50 -0700 (PDT)
From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
Date: Tue, 05 May 2026 05:58:19 +0000
Subject: [PATCH v2] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-huge_1g-v2-1-b6a91327a88d@anirudhrb.com>
X-B4-Tracking: v=1; b=H4sIAPuG+WkC/2XMQQ7CIBCF4as0sxZTWoLVlfcwjWlhKLMQzGCJp
 uHuYrcu/5eXb4OETJjg0mzAmClRDDW6QwPGT2FBQbY2dG2nWyW18OuCd7kIVEpp2Z97Mzio7ye
 jo/cu3cbantIr8meHs/yt/0aWQgpstT71g7HWzdcpEK/W83w08QFjKeUL0KOc0KIAAAA=
X-Change-ID: 20260416-huge_1g-e44461393c8f
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 7875C4C70C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10623-lists,linux-hyperv=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The hypervisor's map GPA hypercall coalesces contiguous 2M-aligned chunks
into 1G mappings when alignment permits, so the driver can support 1G
hugepages by feeding them in as 2M chunks. Note that this is the only
way to make 1G mappings. There is no way to directly map a 1G hugepage
using the hypercall.

Update mshv_chunk_stride() to:

  - Accept 2M-aligned tail pages of a larger folio. The previous
    PageHead() check rejected every page after the head of a 1G hugepage
    and fell back to 4K mappings for the remaining 1022 MB. Replace it
    with a PFN alignment check so any 2M-aligned page of a sufficiently
    large folio is acceptable.

  - Allow only PMD_ORDER and PUD_ORDER folios. Other compound orders
    (e.g. mTHP) remain unsupported and are rejected with -EINVAL plus a
    pr_err(); silently mapping them with HV_MAP_GPA_LARGE_PAGE would
    fail anyway.

Cap the stride returned by mshv_chunk_stride() against page_count in
mshv_region_process_chunk() to avoid overflow situations. For example,
The natural stride of a 1G folio (1 << PUD_ORDER = 262144 pages) exceeds
the per-fault batch (MSHV_MAP_FAULT_IN_PAGES = 512), which would otherwise
cause an out-of-bounds read past mreg_pages.

Assisted-by: Copilot-CLI:claude-opus-4.7
Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
Changes in v2:
- Handled the case where we can have 2M aligned pages in the middle of a
  1G page
- Brought back the page order check but expanded it to include 1G
- Clamp stride to requested page count in mshv_region_process_chunk
- Link to v1: https://lore.kernel.org/r/20260416-huge_1g-v1-1-e066738cddfb@anirudhrb.com
---
 drivers/hv/mshv_regions.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index fdffd4f002f6..8a9d7fb558c4 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -29,6 +29,8 @@
  * Uses huge page stride if the backing page is huge and the guest mapping
  * is properly aligned; otherwise falls back to single page stride.
  *
+ * Only PMD_ORDER (2 MB) and PUD_ORDER (1 GB) folios are supported.
+ *
  * Return: Stride in pages, or -EINVAL if page order is unsupported.
  */
 static int mshv_chunk_stride(struct page *page,
@@ -38,18 +40,21 @@ static int mshv_chunk_stride(struct page *page,
 
 	/*
 	 * Use single page stride by default. For huge page stride, the
-	 * page must be compound and point to the head of the compound
-	 * page, and both gfn and page_count must be huge-page aligned.
+	 * page must be compound, the page's PFN must itself be 2 M-aligned
+	 * (so that a 2M-aligned tail page of a larger folio is acceptable),
+	 * and both gfn and page_count must be huge-page aligned.
 	 */
-	if (!PageCompound(page) || !PageHead(page) ||
+	if (!PageCompound(page) ||
+	    !IS_ALIGNED(page_to_pfn(page), PTRS_PER_PMD) ||
 	    !IS_ALIGNED(gfn, PTRS_PER_PMD) ||
 	    !IS_ALIGNED(page_count, PTRS_PER_PMD))
 		return 1;
 
 	page_order = folio_order(page_folio(page));
-	/* The hypervisor only supports 2M huge page */
-	if (page_order != PMD_ORDER)
+	if (page_order != PMD_ORDER && page_order != PUD_ORDER) {
+		pr_err("mshv: unsupported folio order %u\n", page_order);
 		return -EINVAL;
+	}
 
 	return 1 << page_order;
 }
@@ -96,6 +101,8 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
 	if (stride < 0)
 		return stride;
 
+	stride = min_t(u64, stride, page_count);
+
 	/* Start at stride since the first stride is validated */
 	for (count = stride; count < page_count; count += stride) {
 		page = region->mreg_pages[page_offset + count];

---
base-commit: cd9f2e7d6e5b1837ef40b96e300fa28b73ab5a77
change-id: 20260416-huge_1g-e44461393c8f

Best regards,
-- 
Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


