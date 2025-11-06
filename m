Return-Path: <linux-hyperv+bounces-7446-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE511C3D8E0
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 23:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ECC54E375C
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D19030C372;
	Thu,  6 Nov 2025 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AVr7+Fp3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52030BB87;
	Thu,  6 Nov 2025 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467215; cv=none; b=IG9ErhbSKoYMytwY7cxQUzUMlJZi18jaZlMuF5+7ISHXSsewF7r2aDkI08WkQWH07HNglmX1GPbV5NVFvIFFreXZkZHKixPFyf8F/aBjVm/UOC4UjegPOLYKYYxUapaba7axIXzw+Nesv48SNLyrESQdkZvP0s4v+lqv4HJs2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467215; c=relaxed/simple;
	bh=NoAV/qqLTNPnOHQkJhqWiMxjidQ0Q1L5/4bu4KvL/24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aHftA1DgAk8VvpCFTS19zxzepC/SWsQGZxQdKNZ6LyPWsP07SddNX1Gpc+OXNipG4oLADMCjaZaJlTupq5+qDSHPURAv1U3VnZSSHRMKNtCbC7RTnqArEpQzIlkiwynDuNonHCbWtk3l5HJxrDh9ifBoMufxplw6j3jGAU8T0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AVr7+Fp3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 3556D201DAF3; Thu,  6 Nov 2025 14:13:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3556D201DAF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762467214;
	bh=YRIZduxeBia6u4O1awQgNLFFEi+mMnIOX8zBN1sXBzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVr7+Fp3PkuY9xiJkm1kkLldc9jMweIZ7AH3cvbCsNnuwx/jMg55x9vU6pMVFojAb
	 QdQau7ZWIad7mZkWWlfSja+ybwiN/3nA1HusgdFwB0IH4ovYV0HMnVrdFejmgR9dNA
	 QW2Vvp1qDxOjIgJODb0cr4GLJUSJks5bFymPq6cM=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	magnuskulke@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	skinsburskii@linux.microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	muislam@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2 1/2] mshv: Fix create memory region overlap check
Date: Thu,  6 Nov 2025 14:13:30 -0800
Message-Id: <1762467211-8213-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1762467211-8213-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1762467211-8213-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The current check is incorrect; it only checks if the beginning or end
of a region is within an existing region. This doesn't account for
userspace specifying a region that begins before and ends after an
existing region.

Change the logic to a range intersection check against gfns and uaddrs
for each region.

Remove mshv_partition_region_by_uaddr() as it is no longer used.

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Reported-by: Michael Kelley <mhklinux@outlook.com>
Closes: https://lore.kernel.org/linux-hyperv/SN6PR02MB41575BE0406D3AB22E1D7DB5D4C2A@SN6PR02MB4157.namprd02.prod.outlook.com/
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 814465a0912d..25a68912a78d 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1206,21 +1206,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 	return NULL;
 }
 
-static struct mshv_mem_region *
-mshv_partition_region_by_uaddr(struct mshv_partition *partition, u64 uaddr)
-{
-	struct mshv_mem_region *region;
-
-	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
-		if (uaddr >= region->start_uaddr &&
-		    uaddr < region->start_uaddr +
-			    (region->nr_pages << HV_HYP_PAGE_SHIFT))
-			return region;
-	}
-
-	return NULL;
-}
-
 /*
  * NB: caller checks and makes sure mem->size is page aligned
  * Returns: 0 with regionpp updated on success, or -errno
@@ -1230,15 +1215,21 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 					struct mshv_mem_region **regionpp,
 					bool is_mmio)
 {
-	struct mshv_mem_region *region;
+	struct mshv_mem_region *region, *rg;
 	u64 nr_pages = HVPFN_DOWN(mem->size);
 
 	/* Reject overlapping regions */
-	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
-	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1) ||
-	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr) ||
-	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr + mem->size - 1))
+	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
+		u64 rg_size = rg->nr_pages << HV_HYP_PAGE_SHIFT;
+
+		if ((mem->guest_pfn + nr_pages <= rg->start_gfn ||
+		     rg->start_gfn + rg->nr_pages <= mem->guest_pfn) &&
+		    (mem->userspace_addr + mem->size <= rg->start_uaddr ||
+		     rg->start_uaddr + rg_size <= mem->userspace_addr))
+			continue;
+
 		return -EEXIST;
+	}
 
 	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
 	if (!region)
-- 
2.34.1


