Return-Path: <linux-hyperv+bounces-7826-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D52C87C63
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 03:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 740D84E4938
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 02:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CED305E2F;
	Wed, 26 Nov 2025 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D2rw0XXv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AA514A4F0;
	Wed, 26 Nov 2025 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764122939; cv=none; b=hNxN8NTszTqlrjSTvKcnGEMSysi1nWhsi/OTyOD2+iv4EM0LuRoum2ieufvjmm2jkUxFZ8ykVXUx8QBJ8g3PmiDBcUqmuWOVViX+3c4Gr3A2vTmLevO/DHzoXkuQa/qin3OBZuzLvqmEAZv8q9PgfKEOsCQ8aJtmNWO4HDLcyOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764122939; c=relaxed/simple;
	bh=2bXgMQMcZpgvErwZt6KRRoojVWmQYcvYtdaJw2O6/uc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9WMYsI1KUCan1SUPx0YFlOsHC5ln5B2LHjtjpsAl1jfjGDevEu0pKuVGsHI0EYi68TmPoYT6Tk3AYZdwJUospYWOirCKqEp3zBP6YqAwZ751MWb4/g1uxwuOzd12JHZBc488uhaOtg74l6wRyvKj4Bwn+CGy7sbU1UhlrSji7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D2rw0XXv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1D2162120EAF;
	Tue, 25 Nov 2025 18:08:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D2162120EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764122932;
	bh=MtO6see8Q1t6x1SL3kCoJPQQEnu19WJnZs+6Flfqknk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=D2rw0XXvRdXJDggNpfevDVrmqF0bUEFw07ytZjAn6Rk0T+763nlVgygUCkMfzsLK4
	 5mXFn6R+WO2E9ySafAvcIWnbm6pZQF/5uW7c6WLf4R2GTXTCIcd0VtzT6R6UmUXm/b
	 pd9LiDgf8SLoWDbYEKnCr8nOt1sW61B3A/wOJgSs=
Subject: [PATCH v7 1/7] Drivers: hv: Refactor and rename memory region
 handling functions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Nov 2025 02:08:52 +0000
Message-ID: 
 <176412293200.447063.17654735378558127143.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   80 +++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index bc15d6f6922f..fec82619684a 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1114,8 +1114,8 @@ mshv_region_map(struct mshv_mem_region *region)
 }
 
 static void
-mshv_region_evict_pages(struct mshv_mem_region *region,
-			u64 page_offset, u64 page_count)
+mshv_region_invalidate_pages(struct mshv_mem_region *region,
+			     u64 page_offset, u64 page_count)
 {
 	if (region->flags.range_pinned)
 		unpin_user_pages(region->pages + page_offset, page_count);
@@ -1125,29 +1125,24 @@ mshv_region_evict_pages(struct mshv_mem_region *region,
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
@@ -1158,34 +1153,23 @@ mshv_region_populate_pages(struct mshv_mem_region *region,
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
@@ -1245,19 +1229,27 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
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
@@ -1275,7 +1267,7 @@ mshv_partition_mem_region_map(struct mshv_mem_region *region)
 			pt_err(partition,
 			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
 			       region->start_gfn, ret);
-			goto evict_region;
+			goto invalidate_region;
 		}
 	}
 
@@ -1285,7 +1277,7 @@ mshv_partition_mem_region_map(struct mshv_mem_region *region)
 
 		shrc = mshv_partition_region_share(region);
 		if (!shrc)
-			goto evict_region;
+			goto invalidate_region;
 
 		pt_err(partition,
 		       "Failed to share memory region (guest_pfn: %llu): %d\n",
@@ -1299,8 +1291,8 @@ mshv_partition_mem_region_map(struct mshv_mem_region *region)
 
 	return 0;
 
-evict_region:
-	mshv_region_evict(region);
+invalidate_region:
+	mshv_region_invalidate(region);
 err_out:
 	return ret;
 }
@@ -1349,7 +1341,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		ret = hv_call_map_mmio_pages(partition->pt_id, mem.guest_pfn,
 					     mmio_pfn, HVPFN_DOWN(mem.size));
 	else
-		ret = mshv_partition_mem_region_map(region);
+		ret = mshv_prepare_pinned_region(region);
 
 	if (ret)
 		goto errout;
@@ -1394,7 +1386,7 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
 				region->nr_pages, unmap_flags);
 
-	mshv_region_evict(region);
+	mshv_region_invalidate(region);
 
 	vfree(region);
 	return 0;
@@ -1812,7 +1804,7 @@ static void destroy_partition(struct mshv_partition *partition)
 			}
 		}
 
-		mshv_region_evict(region);
+		mshv_region_invalidate(region);
 
 		vfree(region);
 	}



