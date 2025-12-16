Return-Path: <linux-hyperv+bounces-8033-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59179CC3C1D
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 15:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AFB4314A1E4
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70462D8396;
	Tue, 16 Dec 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="ZE6GecSM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A62D5C7A;
	Tue, 16 Dec 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895382; cv=pass; b=JpKlWv0CvUpJj8f+mfYpTN8q9LrhQ//HFFc2IK5a3ovIPkOmi+N3WQV/ru8ZNaz1u00f6aXQufr2iIbxLE+nxYpqcoW4th57evboKwes8BtbFZUQcAt98hL1cLEhdFUqxUxrw8Y5XHFpWgdsLiDoRyfqpNPa+i79iy7lirisOjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895382; c=relaxed/simple;
	bh=YJ4G9r4L0Jx6x414i+Xnd4G2394MxhYpDAU2aQQV3TY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6iiPbDwsHIqMt9vVeLRmzy1hjPd4pKbg5+PjULn6QLW6aiXHNJCiliv2jEII8EqyVSuzlml06XCGdwC+5lQ/CaAF77MFb7m3m4zFFYyW6KcrPmC9JtJg1LPM3dNWKS1AA/jCD/Yye2fNG0n2+FO0SkPesNkr3ovedh0msrHBF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=unknown smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=ZE6GecSM; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1765895362; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S7s4NMRuOuPFmqTTY6w5ermGwg6PMpxbOjxVWHdWg9qihR7Lyx46rvsTr2CiP0iP6uDA3h8SpBy87Smbs9SVplmFbfFncZNPRSOpsuvqKSUg3hwnpxvMbXrjEWmOGyEJidPQg/29c82zt9XtLfHQ3LY6tLX46/8DkMmJLjbQgYs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765895362; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gDKvsGO9n6po0YoCP8JsZC+13ddLq6bhNGvoxU/02E8=; 
	b=jxityUWaHAnUcquW7QncIgnD2cFBEi2uXbgHw81SsxtvUUIog5tN5MitTkrKyMG8DgHh10g9INItatSE2aDg0PbCaNwTmdvd1/8pk0Vj8zXMs5YCbqd1K7iwO//Bnok3Et0I3UBTEDlbCn9cxl7g0jdSdb5Qxv/By0RXTiy3wrU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765895362;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=gDKvsGO9n6po0YoCP8JsZC+13ddLq6bhNGvoxU/02E8=;
	b=ZE6GecSMCBxDH2B6HpHumnUUjIj5M/TzbIbvsejz7vI746Wlft2SvzcFZgDhm/8Z
	y6uXYYPENBqypfe866m5hh+bGwFcSzU0BiSWIwVcPMJOrlZOAjwDXzcwqQjGLarn8bh
	82ZBuBiYg2S0wvvJVt6uWJ1aG6fFDn75sbzxo3mI=
Received: by mx.zohomail.com with SMTPS id 1765895359949149.64783037122322;
	Tue, 16 Dec 2025 06:29:19 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH 3/3] mshv: release mutex on region invalidation failure
Date: Tue, 16 Dec 2025 14:20:30 +0000
Message-Id: <20251216142030.4095527-4-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216142030.4095527-1-anirudh@anirudhrb.com>
References: <20251216142030.4095527-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

In the region invalidation failure path in
mshv_region_interval_invalidate(), the region mutex is not released. Fix
it by releasing the mutex in the failure path.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_regions.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 8abf80129f9b..30bacba6aec3 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -511,7 +511,7 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 	ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
 				      page_offset, page_count);
 	if (ret)
-		goto out_fail;
+		goto out_unlock;
 
 	mshv_region_invalidate_pages(region, page_offset, page_count);
 
@@ -519,6 +519,8 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 
 	return true;
 
+out_unlock:
+	mutex_unlock(&region->mutex);
 out_fail:
 	WARN_ONCE(ret,
 		  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u, pages %#llx-%#llx, mm: %#llx): %d\n",
-- 
2.34.1


