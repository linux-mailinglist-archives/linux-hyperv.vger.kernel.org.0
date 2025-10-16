Return-Path: <linux-hyperv+bounces-7223-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C80BE11AA
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 02:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803413E3D62
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 00:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93EE17A316;
	Thu, 16 Oct 2025 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ll6PiEkr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0E5129A78;
	Thu, 16 Oct 2025 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574416; cv=none; b=tHi80OgNlUJmEJb1h5Hc5NG0LVtjA8XWXCc3yPtNG+goBIDbQPTPDTtBXrx2OrMR3IhCpSqahsY1PkJMi6flZA6jApHzUjDVCRxqAwhDRZ4Ls/ocVhGY9wnIDtCZ39UMFG/B14B7AgThNpohl76Bv0FHqkYWHB84wFRZgxjKtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574416; c=relaxed/simple;
	bh=cqNFVTXBNQ2SpKFPvlA+cOBjE8OBe8H+EN+XiXuL67w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mfhtb3ay9TF5tBU64EkLAc2FX7wf4dgToncsfAYsq40P9pN7JeDjAQUq+TEFLABipieOfL7zbOy5ybDEJU0C2LP5INQMqIMD4o7HqiUqIM4iM0TapMAKRwDRZjWACueTUwb2kIR3XGJtDjaM/chwu26pNY2AjKTB7Lw8GQqa+fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ll6PiEkr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7872B21244D5;
	Wed, 15 Oct 2025 17:26:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7872B21244D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760574414;
	bh=adNdKM9gcCwjrZPtXeun02dsTbVAWZRqQ8mY5RpLg2Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ll6PiEkrK546yA6+rr2T4Tejg1Lq52dvAhtt2WUXak9AiTiX9iKaCO+KYS6PXmxIW
	 VGGRYdiWtxPcB06VRX/yQR1T3A4UTN7uvr0L06Th1mxIftHndPS3cZ0Z8BqVE1g+6Y
	 Q+DmVbw6MwqVGDTxGH65T5tUv/JY1lGzFT5FUN7w=
Subject: [PATCH v5 1/5] Drivers: hv: Refactor and rename memory region
 handling functions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 16 Oct 2025 00:26:54 +0000
Message-ID: 
 <176057441436.74314.13128899061261938711.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176057396465.74314.10055784909009416453.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176057396465.74314.10055784909009416453.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
index fa42c40e1e02..e923947d3c54 100644
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



