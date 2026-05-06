Return-Path: <linux-hyperv+bounces-10648-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AXRNV1G+2lPYgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10648-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 15:47:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D74DB4B2
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 15:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EBB93007888
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2026 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81CD401A04;
	Wed,  6 May 2026 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="o/l+OtSa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C422AE65;
	Wed,  6 May 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075227; cv=pass; b=LI1kwBhSUEuo8RIWgvrJ11NzBbHGwJn7mjQPTU5dLQRb1hppXncF3Z98DTNLvfGrcmnw0oVA2KFslmBhWneKtGiUuuc47+JGwlGd7+TH4C/QXvXM8zlWuqswbnGXo7MtKmDDYuRrdMzaKCEnS5TfI/f3WtM85XnOEmkB9Kqi2D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075227; c=relaxed/simple;
	bh=xPWQnMduBjjbO0oknLukxJH5zHKPGkmkCkVapKY5xZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yw5bEo/br/z35EsHNoefMqGnhj/FboBZSE9NHM602abvcHMI7mG1C8uDY8Xg0K/3sMt57t5KoV5rnSROR9+SSkbLTM2pjXTGqXj+rOYBAj01hBkVYm84OsUKILIvVBjqj99SjHsNaqAyNwrt87L/7ZvaOLth1J/TY1quT2qboHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=o/l+OtSa; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1778075219; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d5JItoedjWVx5fFT75tdjx3SqLFb58+gYuGEyrvvM4XiVyu/pkqaCWDrxxM4u8Dvnd8r6cgDOpJE8qZ7wzxvomvvFFhBHI115elEiT7GInOnF6Fd+W/pyT5IgKeW9FznAqDJNmK3LeXWRTeG4qEnAw0ym4EeqLZgytA1Y+E0VGw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778075219; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GpJIyAesMjDXq45XaLcdUQ+wer/UnVnzU05YKx827YM=; 
	b=SOoklq4CDGftUbDAJEY4suddaNBAxtdc0TNmeys0MbyV8O1JjRyaeZgDpUsSfAvLNrhsT+VtfgLsobJ1LLFL864qiXCAHpXfQ594wziLtksQSNGyrCbBQHdBMEANeCyWt3ur6fzlUdACsjcKunF/VQkdgg2yTwJWS6Ds7Gv2LV8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778075219;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=GpJIyAesMjDXq45XaLcdUQ+wer/UnVnzU05YKx827YM=;
	b=o/l+OtSa8II9tnZfzzeusI8XakeGb+2Q/JvfowI/njYssMFb78UfNKgiDPkQND1Z
	d7C0ibcDQGm2dBd8SfGmhNDT/SyV/gijO3CJf2/KUDy4J9ksP1EwNN8y9PPiIU2Sy7N
	wQCMeYBLUUYR1m1PxehdS7qBObLzPNGsdwf7TJX8=
Received: by mx.zohomail.com with SMTPS id 1778075216593598.9349122556887;
	Wed, 6 May 2026 06:46:56 -0700 (PDT)
From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
Date: Wed, 06 May 2026 13:44:53 +0000
Subject: [PATCH v3] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-huge_1g-v3-1-26e1e4c439e4@anirudhrb.com>
X-B4-Tracking: v=1; b=H4sIANRF+2kC/2WMyw6CMBQFf8V0bU1flOLK/zDGlPZC70IwrTQaw
 r9b2JDock7OzEwSRIREzoeZRMiYcBwKyOOBuGCHHij6wkQwoZnimoaphzvvKSilNJeNdKYj5f2
 M0OF7K11vhQOm1xg/Wzjzdf1vZE45BaZ1LY3zvmsvdsA4+RDbkxsfZO1ksbsVq3ZXFLfVtuFS1
 NYY/+suy/IFvCLMpN4AAAA=
X-Change-ID: 20260416-huge_1g-e44461393c8f
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 4C9D74DB4B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10648-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anirudhrb.com:email,anirudhrb.com:dkim,anirudhrb.com:mid]

The hypervisor's map GPA hypercall coalesces contiguous 2M-aligned
chunks into 1G mappings when alignment permits, so the driver can
support 1G hugepages by feeding them in as 2M chunks. Note that this
is the only way to make 1G mappings; there is no way to directly map
a 1G hugepage using the hypercall.

Update mshv_chunk_stride() to:

  - Accept 2M-aligned tail pages of a larger folio. The previous
    PageHead() check rejected every page after the head of a 1G
    hugepage and fell back to 4K mappings for the remaining 1022 MB.
    Replace it with a PFN alignment check so any 2M-aligned page of a
    sufficiently large folio is acceptable.

  - Always emit a 2M (PMD_ORDER) stride for the huge-page case. The
    hypercall has no 1G stride, so 1G folios are processed as a
    sequence of 2M chunks. Folios whose order is neither PMD_ORDER nor
    PUD_ORDER (e.g. mTHP) fall back to single-page stride; mapping
    them as 2M would fail in the hypervisor anyway.

Assisted-by: Copilot-CLI:claude-opus-4.7
Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
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
 drivers/hv/mshv_regions.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index fdffd4f002f6..1756b733968c 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -29,29 +29,28 @@
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
+	 * page must be compound, the page's PFN must itself be 2M-aligned
+	 * (so that a 2M-aligned tail page of a larger folio is acceptable),
+	 * and both gfn and page_count must be huge-page aligned.
 	 */
-	if (!PageCompound(page) || !PageHead(page) ||
+	if (!PageCompound(page) ||
+	    !IS_ALIGNED(page_to_pfn(page), PTRS_PER_PMD) ||
 	    !IS_ALIGNED(gfn, PTRS_PER_PMD) ||
-	    !IS_ALIGNED(page_count, PTRS_PER_PMD))
+	    !IS_ALIGNED(page_count, PTRS_PER_PMD) ||
+	    (page_order != PMD_ORDER && page_order != PUD_ORDER))
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
@@ -86,15 +85,14 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
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


