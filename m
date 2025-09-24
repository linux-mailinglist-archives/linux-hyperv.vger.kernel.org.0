Return-Path: <linux-hyperv+bounces-6982-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49CB9C468
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Sep 2025 23:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1497A9643
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Sep 2025 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E467244685;
	Wed, 24 Sep 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HXg/hyNh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6245153BED;
	Wed, 24 Sep 2025 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749474; cv=none; b=C8d6aCUpy+TmT/5e3a9XOta9Mc9gjAusx0kNGOJekBK5N+fqbMYfkQSaTSPKMfU1XJf+/qOhOjASPiQjdcqMWpzn0SpUF1RBT8cMNFJ1hRvsa2kRKnMFSm6rpUUUflYGwZLsFqNHvPsRTVKo2QOyL/eSJfyMXRROGOFbiW/RH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749474; c=relaxed/simple;
	bh=vCk/f4/agtuYpqn5f1hHMjoE7g/Z0Xt442FP4tgJI0o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLpQrhpHGxH88EeH5ZRRbIGWeydfzKrXUdbQLBxTCjLWmv5xe6yfal9qTmXo4+Lpv5eqd9pUGaF4GXLdOsdGpV3VwCAPatdO3tgKWPvqOS1Cvwo1k6RWsxZUl7hq6fBHmkbS4YHPXxg12FUO9Kq3PmbK9VIuh5MjVBtu9snqWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HXg/hyNh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 89D3A211764A;
	Wed, 24 Sep 2025 14:31:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89D3A211764A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758749462;
	bh=VBY5jZgtwgbupGDWP+D9acRrvWwU4s78M1gnJ+o+xXs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HXg/hyNhijxQgxOTKORWuxlUL9gWefN1FajMGY3GAWZW7RcWELrzkVeV/yXrLn4Ez
	 OZj5N2IMLAMDPSTyk/ZDDTI7MnJxRsQNPWCEdKb0n+ikBwLzuzJ8rSZdva1Ovo6KV9
	 d/ALBr4l0FycS0QnugT7TePoDbd8KC+Huckpsd9g=
Subject: [PATCH 1/3] Drivers: hv: Rename a few memory region related functions
 for clarity
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 24 Sep 2025 21:31:02 +0000
Message-ID: 
 <175874946244.157998.2185691597101633735.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

A cleanup and precursor patch.

Rename "mshv_partition_mem_region_map" to "mshv_handle_pinned_region",
"mshv_region_populate" to "mshv_pin_region" and
"mshv_region_populate_pages" to "mshv_region_pin_pages"
to better reflect its purpose of handling pinned memory regions.

Update the "mshv_handle_pinned_region" function's documentation to provide
detailed information about its behavior and return values.

Also drop the check for range as pinned, as this function is static and
all the memory regions are pinned anyway.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index a1c8c3bc79bf1..5ed6bce334417 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1137,8 +1137,8 @@ mshv_region_evict(struct mshv_mem_region *region)
 }
 
 static int
-mshv_region_populate_pages(struct mshv_mem_region *region,
-			   u64 page_offset, u64 page_count)
+mshv_region_pin_pages(struct mshv_mem_region *region,
+		      u64 page_offset, u64 page_count)
 {
 	u64 done_count, nr_pages;
 	struct page **pages;
@@ -1164,14 +1164,9 @@ mshv_region_populate_pages(struct mshv_mem_region *region,
 		 * with the FOLL_LONGTERM flag does a large temporary
 		 * allocation of contiguous memory.
 		 */
-		if (region->flags.range_pinned)
-			ret = pin_user_pages_fast(userspace_addr,
-						  nr_pages,
-						  FOLL_WRITE | FOLL_LONGTERM,
-						  pages);
-		else
-			ret = -EOPNOTSUPP;
-
+		ret = pin_user_pages_fast(userspace_addr, nr_pages,
+					  FOLL_WRITE | FOLL_LONGTERM,
+					  pages);
 		if (ret < 0)
 			goto release_pages;
 	}
@@ -1187,9 +1182,9 @@ mshv_region_populate_pages(struct mshv_mem_region *region,
 }
 
 static int
-mshv_region_populate(struct mshv_mem_region *region)
+mshv_region_pin(struct mshv_mem_region *region)
 {
-	return mshv_region_populate_pages(region, 0, region->nr_pages);
+	return mshv_region_pin_pages(region, 0, region->nr_pages);
 }
 
 static struct mshv_mem_region *
@@ -1264,17 +1259,25 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 	return 0;
 }
 
-/*
- * Map guest ram. if snp, make sure to release that from the host first
- * Side Effects: In case of failure, pages are unpinned when feasible.
+/**
+ * mshv_handle_pinned_region - Handle pinned memory regions
+ * @region: Pointer to the memory region structure
+ *
+ * This function processes memory regions that are explicitly marked as pinned.
+ * Pinned regions are preallocated, mapped upfront, and do not rely on fault-based
+ * population. The function ensures the region is properly populated, handles
+ * encryption requirements for SNP partitions if applicable, maps the region,
+ * and performs necessary sharing or eviction operations based on the mapping
+ * result.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
-static int
-mshv_partition_mem_region_map(struct mshv_mem_region *region)
+static int mshv_handle_pinned_region(struct mshv_mem_region *region)
 {
 	struct mshv_partition *partition = region->partition;
 	int ret;
 
-	ret = mshv_region_populate(region);
+	ret = mshv_region_pin(region);
 	if (ret) {
 		pt_err(partition, "Failed to populate memory region: %d\n",
 		       ret);
@@ -1368,7 +1371,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		ret = hv_call_map_mmio_pages(partition->pt_id, mem.guest_pfn,
 					     mmio_pfn, HVPFN_DOWN(mem.size));
 	else
-		ret = mshv_partition_mem_region_map(region);
+		ret = mshv_handle_pinned_region(region);
 
 	if (ret)
 		goto errout;



