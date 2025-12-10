Return-Path: <linux-hyperv+bounces-8009-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 260B7CB3B35
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Dec 2025 18:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E21430155FB
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Dec 2025 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED62F12C0;
	Wed, 10 Dec 2025 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aOToH8Xd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C12E173E;
	Wed, 10 Dec 2025 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765389349; cv=none; b=X8Ufqr5BHDcsDemeWbSDypsBo+tBjWkqaMMCFwFM4KvkSxjAmCSAbU8bdqmUYqB4n+fDTUClpsargIGvB1z1QFjiAgd8MbBFkUgLOzFkxHR1ppeuxUqyK8WA2uExu0DnHV2CZVi7McptZIjzK5tXT/TWsZCn3kwuDs1IyZcWamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765389349; c=relaxed/simple;
	bh=BshfaIrw9Zg3l/N2lZtgTYfPtZ453ECubO3qifeWUtA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=I00vHOnQ+bK3HNooFq98LSBLTBLAkrWdZ5S4wtPblgWhvzL/4C4qQkf0WR0pIYVjKyrjiWO9zY54Z+OZ5Zs+Il56z/bRmxeJF8/QypgLRSDGodFfXFPmFx+j41344Efg/aePfbidC481Sfi8Y7zUHnaEBvEh/rvo3lrXIYvfe9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aOToH8Xd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8B9D82116032;
	Wed, 10 Dec 2025 09:55:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B9D82116032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765389347;
	bh=e76f2j3RTVYfvY3BPLRbYMnB6ZA+QOC6rQGgrvu1jf0=;
	h=Subject:From:To:Cc:Date:From;
	b=aOToH8XddijC2VgpKjrbnSV9TNb3xm0JadqEo2siXI8exjMHdJwlEM9227pTjbB0H
	 CpsVblHooKbXzDpjM3beL89Ma4ZBHUp+TmRsBlA63ajbX/U/lVQ2FNiLIIorjtIwyo
	 VqQpKGKmGM/TywhKAlUfGUqwqF/ND1lUi9/LNBtA=
Subject: [PATCH] mshv: Initialize local variables early upon region
 invalidation
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 10 Dec 2025 17:55:47 +0000
Message-ID: 
 <176538934140.22759.15324831745272282048.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Ensure local variables are initialized before use so that the warning can
print the right values if locking the region to invalidate fails due to
inability to lock the region.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index dc2d7044fb91..8abf80129f9b 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -494,13 +494,6 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 	unsigned long mstart, mend;
 	int ret = -EPERM;
 
-	if (mmu_notifier_range_blockable(range))
-		mutex_lock(&region->mutex);
-	else if (!mutex_trylock(&region->mutex))
-		goto out_fail;
-
-	mmu_interval_set_seq(mni, cur_seq);
-
 	mstart = max(range->start, region->start_uaddr);
 	mend = min(range->end, region->start_uaddr +
 		   (region->nr_pages << HV_HYP_PAGE_SHIFT));
@@ -508,6 +501,13 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 	page_offset = HVPFN_DOWN(mstart - region->start_uaddr);
 	page_count = HVPFN_DOWN(mend - mstart);
 
+	if (mmu_notifier_range_blockable(range))
+		mutex_lock(&region->mutex);
+	else if (!mutex_trylock(&region->mutex))
+		goto out_fail;
+
+	mmu_interval_set_seq(mni, cur_seq);
+
 	ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
 				      page_offset, page_count);
 	if (ret)



