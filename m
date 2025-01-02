Return-Path: <linux-hyperv+bounces-3568-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7603DA000D0
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 22:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8FD162A6E
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 21:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A02188904;
	Thu,  2 Jan 2025 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qK6dFQaf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB35B43173;
	Thu,  2 Jan 2025 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853983; cv=none; b=MMsMCu6aPMlNEu8S224u26c0prBfoDBMZocB4lolLtNXdnOLzxniDekHL/MRmDdPRRbwIIeCNzGs9k+wTK8eF7oO2Q6coAkVktnpyWefyZgS1T2eCX2oGAdmfqvT6YYdTOSPmHAmx4GHWlC+D/cYC0+sxDg4esjq/9gCRkEE85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853983; c=relaxed/simple;
	bh=NtWnK8Vpc0HnAvjnHbjLErSS+ykFC3CCfB0k45Z+spE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AgnehBlCyoBTH1wSr5NMbtVDtb7aBcjD1W+ShqrzMRu//j6GXJKA1QkUCg3CyMo3Pti07OZ0OgPP3mP+ZFcb7reXP7WFFIzBFtqYTtG2iOn9z5TGo1M6s3Q2480TCZcoo2xENK07CKmdjxpJ6KiRkB9MXJSlQl+RD0XBgITvk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qK6dFQaf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC.lan (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id E62A02041A87;
	Thu,  2 Jan 2025 13:39:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E62A02041A87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735853981;
	bh=1v2rM0Ln6+UpaDcZKIVhFpvHGaweAwvDkCDeeXhmWt8=;
	h=From:To:Cc:Subject:Date:From;
	b=qK6dFQafKgPmxUTUl3WpPKTYw8iCIGczSHxcZ9fFPnl1vrrWjAhNoJ5cdYssMNebo
	 IcyJ4DLxqpkWYjpDkmHwChPnW67QkHMG6gK1cYFFRcatYt5G7+2HQc4pZnDh4E1Oiv
	 hf3j4VFxoSKIgePNCYrlROTo8Ba7W+p3oJzrwTQg=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	Allen Pais <apais@linux.microsoft.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	Michael Frohlich <mfrohlich@microsoft.com>
Subject: [PATCH] hv_balloon: Fallback to generic_online_page() for non-HV hot added mem
Date: Thu,  2 Jan 2025 13:39:40 -0800
Message-Id: <20250102213940.413753-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When device memory blocks are hot-added via add_memory_driver_managed(),
the HV balloon driver intercepts them but fails to online these memory
blocks. This could result in device driver initialization failures.

To address this, fall back to the generic online callback for memory
blocks not added by the HV balloon driver. Similar cases are handled the
same way in virtio-mem driver.

Suggested-by: Vikram Sethi <vsethi@nvidia.com>
Tested-by: Michael Frohlich <mfrohlich@microsoft.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
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


