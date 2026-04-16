Return-Path: <linux-hyperv+bounces-10189-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EL+CJPn4GnhnAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10189-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 15:43:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4740F061
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 15:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3626D3131770
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8533C3BA225;
	Thu, 16 Apr 2026 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="ZJqqfJgg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2149426560B;
	Thu, 16 Apr 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776346664; cv=pass; b=gdS5D2vsxMemDMvcfn3M1ocSRTlgz8p/26HKD76AhlfuW0K98EFJVe7I2vm3GiUfV3MPQC1HjXfFAA1qudBWV5F4jrgs9tD7AXfyWfwbThdBEgo7/xkFhw/zWBka8mK+j+OypLKBSh8uu3XTtL65SlsKBJF9N/WA4n1PKezQsSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776346664; c=relaxed/simple;
	bh=6EI8+Q+FNy/ULBuIYHQkRBK5KlR1NuGnnbNeE3P47Z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CL435SM1sX++Lv+Q/rHtdKx1i6nAjr19ceKdoPBV8ZOVdprY/myCztaNZtqGDgtptkPOYn4U0cCCzedHbVginmU8LKDHCuqzpZHOMPxiOOn92aLnmRfXJnP+W+HieYrac0qE5h7JkXRpPOBkEaD/H5cWEHcFMFsiYHsE8AlUdI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=ZJqqfJgg; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1776346655; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SDFGk1XZGBCwcLs/Ed7dpI+cIVhRDdZxC06qFNieDBVWyI80+wUywMSAB/lVGawHzjWRQK5x0FNspyZ7LEh1oUvYZ4sUHckTY8c6XpbqdpxW4uaMtC0D3nvkP9ZlQX8WpdSWXT0cMZH10KH8Q0u3TJ5toFiInyrseqNBpIcFywY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776346655; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ATPFIhiEiNxguH1FPzF6uvJKHH1c81hYC4ia8rWn0HA=; 
	b=fl7WGfSivUlQShZg7L/fsseiyNkwEfMeOEG77cg2Vk5FVdy4qU9GcDXElIZSizR8OOtrBpDrnTvF2S4qD2aEMvmQqAkFau5bpI1xp8zrZEkLmpCMjNKIEFwCYcIKRUrkFJaOsf7/eflg/kzU5f9a0d6HMmUcH2cysMUF44fqOhE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776346655;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=ATPFIhiEiNxguH1FPzF6uvJKHH1c81hYC4ia8rWn0HA=;
	b=ZJqqfJggPbhGCFdlntgf5tFYpiWfW0DNALW2p0/BsWbChmMlw6q+gFHG6wMG9ss3
	v+w+H/rfoUQwz8golfxjkbe/6rOytxBdoouV9ZN4DWRf6oSnR0uqao3o3SNvLKtHsce
	ooEHMcDEbfc/xyUvFP6cVFC/tQnD8Av65uhtmnbc=
Received: by mx.zohomail.com with SMTPS id 1776346652697970.5173128212078;
	Thu, 16 Apr 2026 06:37:32 -0700 (PDT)
From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
Date: Thu, 16 Apr 2026 13:37:15 +0000
Subject: [PATCH] mshv: remove page order restriction to enable 1G hugepage
 support
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-huge_1g-v1-1-e066738cddfb@anirudhrb.com>
X-B4-Tracking: v=1; b=H4sIAArm4GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mz3YzS9NR4w3TdVBMTEzNDY0vjZIs0JaDqgqLUtMwKsEnRsbW1AC/
 Su4lZAAAA
X-Change-ID: 20260416-huge_1g-e44461393c8f
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10189-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:email,anirudhrb.com:dkim,anirudhrb.com:mid]
X-Rspamd-Queue-Id: 95D4740F061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The hypervisor's map GPA hypercall handles large pages intelligently,
combining 2M pages into 1G mappings when alignment allows.

Remove the PMD_ORDER check in mshv_chunk_stride() so that 1G hugepages
and other large page orders are passed through as 2M-aligned chunks,
letting the hypervisor promote them to 1G mappings automatically.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_regions.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index fdffd4f002f6..5f617a96d97a 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -29,7 +29,7 @@
  * Uses huge page stride if the backing page is huge and the guest mapping
  * is properly aligned; otherwise falls back to single page stride.
  *
- * Return: Stride in pages, or -EINVAL if page order is unsupported.
+ * Return: Stride in pages.
  */
 static int mshv_chunk_stride(struct page *page,
 			     u64 gfn, u64 page_count)
@@ -47,9 +47,6 @@ static int mshv_chunk_stride(struct page *page,
 		return 1;
 
 	page_order = folio_order(page_folio(page));
-	/* The hypervisor only supports 2M huge page */
-	if (page_order != PMD_ORDER)
-		return -EINVAL;
 
 	return 1 << page_order;
 }

---
base-commit: cd9f2e7d6e5b1837ef40b96e300fa28b73ab5a77
change-id: 20260416-huge_1g-e44461393c8f

Best regards,
-- 
Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


