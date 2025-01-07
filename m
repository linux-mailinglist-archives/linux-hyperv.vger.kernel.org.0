Return-Path: <linux-hyperv+bounces-3597-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03866A048F0
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 19:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB681882E14
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390AE1F4705;
	Tue,  7 Jan 2025 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VuN4X+1S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B11F0E23;
	Tue,  7 Jan 2025 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273364; cv=none; b=tY3RUscb0yUt9n7sTlbtw9LeCdzRBGI8/1No40eHLKRNQo8G03BMb5Bepk60yRn008M1oVAAiVo/norOAyBaiRvM+OaHHnhBDm/JP8/J1DisaqZXa5OvZiQeoWl2t6XMVq39saMsorYNLnhjmGGh/aONj8Jclu9mtzp9GaPqN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273364; c=relaxed/simple;
	bh=Ec/dFJUeuoSzqbhrePUsN6EXP2h5TvChtYx/qtKzJv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kzhba34UZ0GM9bU5u3P6BwNdUfzBL2WJcSmcAbcNTDipQC66P5MBEsCiMKIE01xFZy+J9Y/fCwp0gNsa3YvC2QKHqDu7m3VMYhikybskh3d+ARH/LB1VizJaLD+D3tYys5IZZ8dX1NvicOu2IYNgPwjy8rto1xgR5pABODQTxB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VuN4X+1S; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC.lan (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D9FD2126CD3;
	Tue,  7 Jan 2025 10:09:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D9FD2126CD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736273359;
	bh=y0Jpsia0vYC/hn+P7+Et3FOvZWbaWYqQxv3gOIHUT0E=;
	h=From:To:Cc:Subject:Date:From;
	b=VuN4X+1S/da6kTfnsDEA2H4gyNMC2cwEGqx1KhLNHkH3UUMbPgndGFt24MiTBVKEh
	 I8dlHCCfr+aLEWpRA/uEfUjckyrbg0+2/yyuuNNV/JqdnoHCeu9a500hW8XRTPu/J3
	 Se6eYVb+zO8wKwa50QsqtBXZXI2iB+44/PgKamqg=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Allen Pais <apais@linux.microsoft.com>,
	Michael Frohlich <mfrohlich@microsoft.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH v2] hv_balloon: Fallback to generic_online_page() for non-HV hot added mem
Date: Tue,  7 Jan 2025 10:09:18 -0800
Message-Id: <20250107180918.1053933-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Hyper-V balloon driver installs a custom callback for handling page
onlining operations performed by the memory hotplug subsystem. This
custom callback is global, and overrides the default callback
(generic_online_page) that Linux otherwise uses. The custom callback
properly handles memory that is hot-added by the balloon driver as part
of a Hyper-V hot-add region.

But memory can also be hot-added directly by a device driver for a vPCI
device, particularly GPUs. In such a case, the custom callback installed by
the balloon driver runs, but won't find the page in its hot-add region list
and doesn't online it, which could cause driver initialization failures.

Fix this by having the balloon custom callback run generic_online_page()
when the page isn't part of a Hyper-V hot-add region, thereby doing the
default Linux behavior. This allows device driver hot-adds to work
properly. Similar cases are handled the same way in the virtio-mem driver.

Suggested-by: Vikram Sethi <vsethi@nvidia.com>
Tested-by: Michael Frohlich <mfrohlich@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v2: Updated commit message suggested by Michael Kelley.
---
 drivers/hv/hv_balloon.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index a99112e6f0b8..c999daf34108 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -766,16 +766,18 @@ static void hv_online_page(struct page *pg, unsigned int order)
 	struct hv_hotadd_state *has;
 	unsigned long pfn = page_to_pfn(pg);
 
-	guard(spinlock_irqsave)(&dm_device.ha_lock);
-	list_for_each_entry(has, &dm_device.ha_region_list, list) {
-		/* The page belongs to a different HAS. */
-		if (pfn < has->start_pfn ||
-		    (pfn + (1UL << order) > has->end_pfn))
-			continue;
+	scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
+		list_for_each_entry(has, &dm_device.ha_region_list, list) {
+			/* The page belongs to a different HAS. */
+			if (pfn < has->start_pfn ||
+				(pfn + (1UL << order) > has->end_pfn))
+				continue;
 
-		hv_bring_pgs_online(has, pfn, 1UL << order);
-		break;
+			hv_bring_pgs_online(has, pfn, 1UL << order);
+			return;
+		}
 	}
+	generic_online_page(pg, order);
 }
 
 static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
-- 
2.34.1


