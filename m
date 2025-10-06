Return-Path: <linux-hyperv+bounces-7107-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F22BBE6EB
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 17:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD9D188F95B
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36902D6E68;
	Mon,  6 Oct 2025 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m1IQQ7zb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624332652A6;
	Mon,  6 Oct 2025 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763177; cv=none; b=Gf4XfysncHMWDW6gG098DJVfdSOja1791QzmqCPc2zwtPm/znR30XD589/xolGvD9729E9XN5kIlSQPRAWj2wTXoMQIbRqKxgilscU4oYCshjDmlIap+CY4y0y7aUjFGBauAexT8mSpfAUGl5mJiHpKLj9XukdZRMWDjMZ8XXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763177; c=relaxed/simple;
	bh=kMS2+HKcSnRcWxOIxsgV8/+fy9uGs6TIiu0Mbk4qv1k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaCKdfaCwWmg/X9zaDzMWXDTQZUOhFSwYsAO+efFteF3JH8O+Ijfg4eIBR/X2KNJhavLyD1Vjd/tQh446Aj5ndOlEWonO7sG/fLV3IXiZA01M0PKIeqHoNPzi4OADBa9Cit3q0wDERFo8M6wzwUw/sI++yRLU4gwTLVPuVg4XUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m1IQQ7zb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 238C42012C1C;
	Mon,  6 Oct 2025 08:06:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 238C42012C1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759763172;
	bh=uYMbFUxKcFtMQ+I0N1S1Jv3fAPCxRy+Z3B4Tu+Xth9o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=m1IQQ7zbCuqYVA2SKKARdl75IU6J+VGwUqjXxJuKhRNbAQ0LDvdKqHXfSjNjbtAfy
	 srkR70ope4MG32RL3akxabDlNncszjZcTmvCNv9QPBGMBxpMjUPBGfAqTAuOVYHZoY
	 MYkBTx9ALTTJQd9rCTRxZI0/iQLtivFoQVHrHxZo=
Subject: [PATCH v4 1/5] Drivers: hv: Refactor and rename memory region
 handling functions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Oct 2025 15:06:12 +0000
Message-ID: 
 <175976317202.16834.13905194415092065784.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Simplify and unify memory region management to improve code clarity and
reliability. Consolidate pinning and invalidation logic, adopt consistent
naming, and remove redundant checks to reduce complexity.

Enhance documentation and update call sites for maintainability.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   80 +++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index fa42c40e1e02f..e923947d3c54d 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1120,8 +1120,8 @@ mshv_region_map(struct mshv_mem_region *region)
 }
 
 static void
-mshv_region_evict_pages(struct mshv_mem_region *region,
-			u64 page_offset, u64 page_count)
+mshv_region_invalidate_pages(struct mshv_mem_region *region,
+			     u64 page_offset, u64 page_count)
 {
 	if (region->flags.range_pinned)
 		unpin_user_pages(region->pages + page_offset, page_count);
@@ -1131,29 +1131,24 @@ mshv_region_evict_pages(struct mshv_mem_region *region,
 }
 
 static void
-mshv_region_evict(struct mshv_mem_region *region)
+mshv_region_invalidate(struct mshv_mem_region *region)
 {
-	mshv_region_evict_pages(region, 0, region->nr_pages);
+	mshv_region_invalidate_pages(region, 0, region->nr_pages);
 }
 
 static int
-mshv_region_populate_pages(struct mshv_mem_region *region,
-			   u64 page_offset, u64 page_count)
+mshv_region_pin(struct mshv_mem_region *region)
 {
 	u64 done_count, nr_pages;
 	struct page **pages;
 	__u64 userspace_addr;
 	int ret;
 
-	if (page_offset + page_count > region->nr_pages)
-		return -EINVAL;
-
-	for (done_count = 0; done_count < page_count; done_count += ret) {
-		pages = region->pages + page_offset + done_count;
+	for (done_count = 0; done_count < region->nr_pages; done_count += ret) {
+		pages = region->pages + done_count;
 		userspace_addr = region->start_uaddr +
-				(page_offset + done_count) *
-				HV_HYP_PAGE_SIZE;
-		nr_pages = min(page_count - done_count,
+				 done_count * HV_HYP_PAGE_SIZE;
+		nr_pages = min(region->nr_pages - done_count,
 			       MSHV_PIN_PAGES_BATCH_SIZE);
 
 		/*
@@ -1164,34 +1159,23 @@ mshv_region_populate_pages(struct mshv_mem_region *region,
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
 
-	if (PageHuge(region->pages[page_offset]))
+	if (PageHuge(region->pages[0]))
 		region->flags.large_pages = true;
 
 	return 0;
 
 release_pages:
-	mshv_region_evict_pages(region, page_offset, done_count);
+	mshv_region_invalidate_pages(region, 0, done_count);
 	return ret;
 }
 
-static int
-mshv_region_populate(struct mshv_mem_region *region)
-{
-	return mshv_region_populate_pages(region, 0, region->nr_pages);
-}
-
 static struct mshv_mem_region *
 mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 {
@@ -1264,19 +1248,27 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 	return 0;
 }
 
-/*
- * Map guest ram. if snp, make sure to release that from the host first
- * Side Effects: In case of failure, pages are unpinned when feasible.
+/**
+ * mshv_prepare_pinned_region - Pin and map memory regions
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
+static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 {
 	struct mshv_partition *partition = region->partition;
 	int ret;
 
-	ret = mshv_region_populate(region);
+	ret = mshv_region_pin(region);
 	if (ret) {
-		pt_err(partition, "Failed to populate memory region: %d\n",
+		pt_err(partition, "Failed to pin memory region: %d\n",
 		       ret);
 		goto err_out;
 	}
@@ -1294,7 +1286,7 @@ mshv_partition_mem_region_map(struct mshv_mem_region *region)
 			pt_err(partition,
 			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
 			       region->start_gfn, ret);
-			goto evict_region;
+			goto invalidate_region;
 		}
 	}
 
@@ -1304,7 +1296,7 @@ mshv_partition_mem_region_map(struct mshv_mem_region *region)
 
 		shrc = mshv_partition_region_share(region);
 		if (!shrc)
-			goto evict_region;
+			goto invalidate_region;
 
 		pt_err(partition,
 		       "Failed to share memory region (guest_pfn: %llu): %d\n",
@@ -1318,8 +1310,8 @@ mshv_partition_mem_region_map(struct mshv_mem_region *region)
 
 	return 0;
 
-evict_region:
-	mshv_region_evict(region);
+invalidate_region:
+	mshv_region_invalidate(region);
 err_out:
 	return ret;
 }
@@ -1368,7 +1360,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		ret = hv_call_map_mmio_pages(partition->pt_id, mem.guest_pfn,
 					     mmio_pfn, HVPFN_DOWN(mem.size));
 	else
-		ret = mshv_partition_mem_region_map(region);
+		ret = mshv_prepare_pinned_region(region);
 
 	if (ret)
 		goto errout;
@@ -1413,7 +1405,7 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
 				region->nr_pages, unmap_flags);
 
-	mshv_region_evict(region);
+	mshv_region_invalidate(region);
 
 	vfree(region);
 	return 0;
@@ -1827,7 +1819,7 @@ static void destroy_partition(struct mshv_partition *partition)
 			}
 		}
 
-		mshv_region_evict(region);
+		mshv_region_invalidate(region);
 
 		vfree(region);
 	}



