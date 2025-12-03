Return-Path: <linux-hyperv+bounces-7933-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 218C0CA13E1
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 20:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0DD6320E383
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 18:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A421A316185;
	Wed,  3 Dec 2025 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p85azOPN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A530C342;
	Wed,  3 Dec 2025 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786265; cv=none; b=nBdvBLk1xXRuRn6RhaU+IJHP0QJu+3n/wXa3BoLuNCf3JxPsiT3cYDc1ykKcQVPMZY8L5SvNQe4AkfUJRonjoVflf/YLechdpf82lAAa2Id6y0F70QJygxBqgWruXIESmlG+b7wMFVbW3yRJ9K+WwxbARVuTyDait/WgnSAFkA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786265; c=relaxed/simple;
	bh=+7LUVZxVWehQ9BNphaZH7G7g8cM/P7u6/qbvWWXceJw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aj9mhGifNqeCmhYw+RxMYe0UHxvffV4HK4p+t9DcRRbpc7e/3A9s3nRRhG8QE95Cavhpe2daRipiwZHaj0rZIpwaaEL5PkqTPCPQVIgpzBZ0CH76DnwReR2qth4kdNBkXU8SgLdlMcM9WrT6JVgThFinH2/baHwzWj5E38z46/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p85azOPN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B2A5A2120E8B;
	Wed,  3 Dec 2025 10:24:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2A5A2120E8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764786261;
	bh=pqOyGWoFst15b+rShnHT30OICgry5YF30OJpfifwlEs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=p85azOPNLgBooZlCNS9HP7pIBd5J61/0y+NW5uyjY4sf1ehLM1tOg4zqwUHhZtrwR
	 iL0oAvr6C67lZBcT7FFApUyjHADQOj7gRvOfcXISrjmBdVjkxADrqIWlKpeB/wqxHv
	 DM9ojtoV13hSyC9J1Mzdsk6PNs349duvy1ivWMhs=
Subject: [PATCH v8 4/6] Drivers: hv: Fix huge page handling in memory region
 traversal
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Dec 2025 18:24:21 +0000
Message-ID: 
 <176478626161.114132.15355588085583516799.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176478581828.114132.13305536829966527782.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176478581828.114132.13305536829966527782.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The previous code assumed that if a region's first page was huge, the
entire region consisted of huge pages and stored this in a large_pages
flag. This premise is incorrect not only for movable regions (where
pages can be split and merged on invalidate callbacks or page faults),
but even for pinned regions: THPs can be split and merged during
allocation, so a large, pinned region may contain a mix of huge and
regular pages.

This change removes the large_pages flag and replaces region-wide
assumptions with per-chunk inspection of the actual page size when
mapping, unmapping, sharing, and unsharing. This makes huge page
handling correct for mixed-page regions and avoids relying on stale
metadata that can easily become invalid as memory is remapped.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_regions.c |  213 +++++++++++++++++++++++++++++++++++++++------
 drivers/hv/mshv_root.h    |    3 -
 2 files changed, 184 insertions(+), 32 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 35b866670840..1356f68ccb29 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -14,6 +14,124 @@
 
 #include "mshv_root.h"
 
+/**
+ * mshv_region_process_chunk - Processes a contiguous chunk of memory pages
+ *                             in a region.
+ * @region     : Pointer to the memory region structure.
+ * @flags      : Flags to pass to the handler.
+ * @page_offset: Offset into the region's pages array to start processing.
+ * @page_count : Number of pages to process.
+ * @handler    : Callback function to handle the chunk.
+ *
+ * This function scans the region's pages starting from @page_offset,
+ * checking for contiguous present pages of the same size (normal or huge).
+ * It invokes @handler for the chunk of contiguous pages found. Returns the
+ * number of pages handled, or a negative error code if the first page is
+ * not present or the handler fails.
+ *
+ * Note: The @handler callback must be able to handle both normal and huge
+ * pages.
+ *
+ * Return: Number of pages handled, or negative error code.
+ */
+static long mshv_region_process_chunk(struct mshv_mem_region *region,
+				      u32 flags,
+				      u64 page_offset, u64 page_count,
+				      int (*handler)(struct mshv_mem_region *region,
+						     u32 flags,
+						     u64 page_offset,
+						     u64 page_count))
+{
+	u64 count, stride;
+	unsigned int page_order;
+	struct page *page;
+	int ret;
+
+	page = region->pages[page_offset];
+	if (!page)
+		return -EINVAL;
+
+	page_order = folio_order(page_folio(page));
+	/* 1G huge pages aren't supported by the hypercalls */
+	if (page_order == PUD_ORDER)
+		return -EINVAL;
+
+	stride = 1 << page_order;
+
+	/* Start at stride since the first page is validated */
+	for (count = stride; count < page_count; count += stride) {
+		page = region->pages[page_offset + count];
+
+		/* Break if current page is not present */
+		if (!page)
+			break;
+
+		/* Break if page size changes */
+		if (page_order != folio_order(page_folio(page)))
+			break;
+	}
+
+	ret = handler(region, flags, page_offset, count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * mshv_region_process_range - Processes a range of memory pages in a
+ *                             region.
+ * @region     : Pointer to the memory region structure.
+ * @flags      : Flags to pass to the handler.
+ * @page_offset: Offset into the region's pages array to start processing.
+ * @page_count : Number of pages to process.
+ * @handler    : Callback function to handle each chunk of contiguous
+ *               pages.
+ *
+ * Iterates over the specified range of pages in @region, skipping
+ * non-present pages. For each contiguous chunk of present pages, invokes
+ * @handler via mshv_region_process_chunk.
+ *
+ * Note: The @handler callback must be able to handle both normal and huge
+ * pages.
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ */
+static int mshv_region_process_range(struct mshv_mem_region *region,
+				     u32 flags,
+				     u64 page_offset, u64 page_count,
+				     int (*handler)(struct mshv_mem_region *region,
+						    u32 flags,
+						    u64 page_offset,
+						    u64 page_count))
+{
+	long ret;
+
+	if (page_offset + page_count > region->nr_pages)
+		return -EINVAL;
+
+	while (page_count) {
+		/* Skip non-present pages */
+		if (!region->pages[page_offset]) {
+			page_offset++;
+			page_count--;
+			continue;
+		}
+
+		ret = mshv_region_process_chunk(region, flags,
+						page_offset,
+						page_count,
+						handler);
+		if (ret < 0)
+			return ret;
+
+		page_offset += ret;
+		page_count -= ret;
+	}
+
+	return 0;
+}
+
 struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 					   u64 uaddr, u32 flags,
 					   bool is_mmio)
@@ -33,55 +151,80 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
 		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
 
-	/* Note: large_pages flag populated when we pin the pages */
 	if (!is_mmio)
 		region->flags.range_pinned = true;
 
 	return region;
 }
 
+static int mshv_region_chunk_share(struct mshv_mem_region *region,
+				   u32 flags,
+				   u64 page_offset, u64 page_count)
+{
+	if (PageTransCompound(region->pages[page_offset]))
+		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
+
+	return hv_call_modify_spa_host_access(region->partition->pt_id,
+					      region->pages + page_offset,
+					      page_count,
+					      HV_MAP_GPA_READABLE |
+					      HV_MAP_GPA_WRITABLE,
+					      flags, true);
+}
+
 int mshv_region_share(struct mshv_mem_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
 
-	if (region->flags.large_pages)
+	return mshv_region_process_range(region, flags,
+					 0, region->nr_pages,
+					 mshv_region_chunk_share);
+}
+
+static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
+				     u32 flags,
+				     u64 page_offset, u64 page_count)
+{
+	if (PageTransCompound(region->pages[page_offset]))
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-			region->pages, region->nr_pages,
-			HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE,
-			flags, true);
+					      region->pages + page_offset,
+					      page_count, 0,
+					      flags, false);
 }
 
 int mshv_region_unshare(struct mshv_mem_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
 
-	if (region->flags.large_pages)
-		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
-
-	return hv_call_modify_spa_host_access(region->partition->pt_id,
-			region->pages, region->nr_pages,
-			0,
-			flags, false);
+	return mshv_region_process_range(region, flags,
+					 0, region->nr_pages,
+					 mshv_region_chunk_unshare);
 }
 
-static int mshv_region_remap_pages(struct mshv_mem_region *region,
-				   u32 map_flags,
+static int mshv_region_chunk_remap(struct mshv_mem_region *region,
+				   u32 flags,
 				   u64 page_offset, u64 page_count)
 {
-	if (page_offset + page_count > region->nr_pages)
-		return -EINVAL;
-
-	if (region->flags.large_pages)
-		map_flags |= HV_MAP_GPA_LARGE_PAGE;
+	if (PageTransCompound(region->pages[page_offset]))
+		flags |= HV_MAP_GPA_LARGE_PAGE;
 
 	return hv_call_map_gpa_pages(region->partition->pt_id,
 				     region->start_gfn + page_offset,
-				     page_count, map_flags,
+				     page_count, flags,
 				     region->pages + page_offset);
 }
 
+static int mshv_region_remap_pages(struct mshv_mem_region *region,
+				   u32 map_flags,
+				   u64 page_offset, u64 page_count)
+{
+	return mshv_region_process_range(region, map_flags,
+					 page_offset, page_count,
+					 mshv_region_chunk_remap);
+}
+
 int mshv_region_map(struct mshv_mem_region *region)
 {
 	u32 map_flags = region->hv_map_flags;
@@ -134,9 +277,6 @@ int mshv_region_pin(struct mshv_mem_region *region)
 			goto release_pages;
 	}
 
-	if (PageHuge(region->pages[0]))
-		region->flags.large_pages = true;
-
 	return 0;
 
 release_pages:
@@ -144,10 +284,28 @@ int mshv_region_pin(struct mshv_mem_region *region)
 	return ret;
 }
 
+static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
+				   u32 flags,
+				   u64 page_offset, u64 page_count)
+{
+	if (PageTransCompound(region->pages[page_offset]))
+		flags |= HV_UNMAP_GPA_LARGE_PAGE;
+
+	return hv_call_unmap_gpa_pages(region->partition->pt_id,
+				       region->start_gfn + page_offset,
+				       page_count, flags);
+}
+
+static int mshv_region_unmap(struct mshv_mem_region *region)
+{
+	return mshv_region_process_range(region, 0,
+					 0, region->nr_pages,
+					 mshv_region_chunk_unmap);
+}
+
 void mshv_region_destroy(struct mshv_mem_region *region)
 {
 	struct mshv_partition *partition = region->partition;
-	u32 unmap_flags = 0;
 	int ret;
 
 	hlist_del(&region->hnode);
@@ -162,12 +320,7 @@ void mshv_region_destroy(struct mshv_mem_region *region)
 		}
 	}
 
-	if (region->flags.large_pages)
-		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
-
-	/* ignore unmap failures and continue as process may be exiting */
-	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
-				region->nr_pages, unmap_flags);
+	mshv_region_unmap(region);
 
 	mshv_region_invalidate(region);
 
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 0366f416c2f0..ff3374f13691 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -77,9 +77,8 @@ struct mshv_mem_region {
 	u64 start_uaddr;
 	u32 hv_map_flags;
 	struct {
-		u64 large_pages:  1; /* 2MiB */
 		u64 range_pinned: 1;
-		u64 reserved:	 62;
+		u64 reserved:	 63;
 	} flags;
 	struct mshv_partition *partition;
 	struct page *pages[];



