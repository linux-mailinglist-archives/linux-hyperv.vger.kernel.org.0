Return-Path: <linux-hyperv+bounces-8043-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B9FCC59D9
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 01:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11422300D8F8
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 00:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB86E1EDA2C;
	Wed, 17 Dec 2025 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M1QpYNTO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF304AEE2;
	Wed, 17 Dec 2025 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765932081; cv=none; b=GgvR7+0egomDK70K6VKpUkeJEoF1Plx/zeSBhG6OktDmJbbl6B67VHjx6XEdomsNUsV5YbJLfiTRv22WFh0tszM2EXlaFl+H6dnQYHrTGXSjUWVISU3sedf8C5yq1NBSQh2iXzfEOeApwkk+GBYdelRw21eeB067uQPk7SAA9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765932081; c=relaxed/simple;
	bh=K+BZakohZSBzRZJeHSKitoAHrLzYgjpfBeNBM4PXKnA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=s4iE9SukPb9E73aUsOOjL0OGpCKWkFqniZIs8BDojoCMrU5a51TSaFqyFJeH9mtn33E7e6V65T13j43IKgbOpBz33MyJR+xF4cPqDwvZZpd0OMPstdL9Gr/hVvy1oJ3E95wTI7CrVQ3d3K68v4XzuLwjoPmIvtWy+nYQ0hf2Ze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M1QpYNTO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 28E84200D63B;
	Tue, 16 Dec 2025 16:41:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28E84200D63B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765932079;
	bh=mBlJLK6jQTfOz+/AYjA44IB1lkaD7r2xeVR4bxCX/dU=;
	h=Subject:From:To:Cc:Date:From;
	b=M1QpYNTO2FtMCNAGp2N5lQWDHOVYeLek4ocg8fGoUmjLy9SVV29y48kYIj6so/KX8
	 MREy8zicU7Fc0K5+b7KHpw3eD/P8AfG31Livs7wICos1CQ8XCMEOd5B1tazr87dJ0x
	 QWS8GvnjNivcVd0UL02BnjwkJ0Gy0SvMJ9FsvisQ=
Subject: [PATCH] mshv: Align huge page stride with guest mapping
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 17 Dec 2025 00:41:19 +0000
Message-ID: 
 <176593206931.276257.13023250440372517478.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Ensure that a stride larger than 1 (huge page) is only used when both
the guest frame number (gfn) and the operation size (page_count) are
aligned to the huge page size (PTRS_PER_PMD). This matches the
hypervisor requirement that map/unmap operations for huge pages must be
guest-aligned and cover a full huge page.

Add mshv_chunk_stride() to encapsulate this alignment and page-order
validation, and plumb a huge_page flag into the region chunk handlers.
This prevents issuing large-page map/unmap/share operations that the
hypervisor would reject due to misaligned guest mappings.

Fixes: abceb4297bf8 ("mshv: Fix huge page handling in memory region traversal")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   94 ++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 31 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 30bacba6aec3..29776019bcde 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -19,6 +19,42 @@
 
 #define MSHV_MAP_FAULT_IN_PAGES				PTRS_PER_PMD
 
+/**
+ * mshv_chunk_stride - Compute stride for mapping guest memory
+ * @page      : The page to check for huge page backing
+ * @gfn       : Guest frame number for the mapping
+ * @page_count: Total number of pages in the mapping
+ *
+ * Determines the appropriate stride (in pages) for mapping guest memory.
+ * Uses huge page stride if the backing page is huge and the guest mapping
+ * is properly aligned; otherwise falls back to single page stride.
+ *
+ * Return: Stride in pages, or -EINVAL if page order is unsupported.
+ */
+static int mshv_chunk_stride(struct page *page,
+			     u64 gfn, u64 page_count)
+{
+	unsigned int page_order;
+
+	page_order = folio_order(page_folio(page));
+	/* The hypervisor only supports 4K and 2M page sizes */
+	if (page_order && page_order != PMD_ORDER)
+		return -EINVAL;
+
+	/*
+	 * Default to a single page stride. If page_order is set and both
+	 * the guest frame number (gfn) and page_count are huge-page
+	 * aligned (PTRS_PER_PMD), use a larger stride so the mapping can
+	 * be backed by a huge page in both guest and hypervisor.
+	 */
+	if (page_order &&
+	    IS_ALIGNED(gfn, PTRS_PER_PMD) &&
+	    IS_ALIGNED(page_count, PTRS_PER_PMD))
+		return 1 << page_order;
+
+	return 1;
+}
+
 /**
  * mshv_region_process_chunk - Processes a contiguous chunk of memory pages
  *                             in a region.
@@ -45,25 +81,23 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
 				      int (*handler)(struct mshv_mem_region *region,
 						     u32 flags,
 						     u64 page_offset,
-						     u64 page_count))
+						     u64 page_count,
+						     bool huge_page))
 {
-	u64 count, stride;
-	unsigned int page_order;
+	u64 gfn = region->start_gfn + page_offset;
+	u64 count;
 	struct page *page;
-	int ret;
+	int stride, ret;
 
 	page = region->pages[page_offset];
 	if (!page)
 		return -EINVAL;
 
-	page_order = folio_order(page_folio(page));
-	/* The hypervisor only supports 4K and 2M page sizes */
-	if (page_order && page_order != PMD_ORDER)
-		return -EINVAL;
-
-	stride = 1 << page_order;
+	stride = mshv_chunk_stride(page, gfn, page_count);
+	if (stride < 0)
+		return stride;
 
-	/* Start at stride since the first page is validated */
+	/* Start at stride since the first stride is validated */
 	for (count = stride; count < page_count; count += stride) {
 		page = region->pages[page_offset + count];
 
@@ -71,12 +105,13 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
 		if (!page)
 			break;
 
-		/* Break if page size changes */
-		if (page_order != folio_order(page_folio(page)))
+		/* Break if stride size changes */
+		if (stride != mshv_chunk_stride(page, gfn + count,
+						page_count - count))
 			break;
 	}
 
-	ret = handler(region, flags, page_offset, count);
+	ret = handler(region, flags, page_offset, count, stride > 1);
 	if (ret)
 		return ret;
 
@@ -108,7 +143,8 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 				     int (*handler)(struct mshv_mem_region *region,
 						    u32 flags,
 						    u64 page_offset,
-						    u64 page_count))
+						    u64 page_count,
+						    bool huge_page))
 {
 	long ret;
 
@@ -162,11 +198,10 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 
 static int mshv_region_chunk_share(struct mshv_mem_region *region,
 				   u32 flags,
-				   u64 page_offset, u64 page_count)
+				   u64 page_offset, u64 page_count,
+				   bool huge_page)
 {
-	struct page *page = region->pages[page_offset];
-
-	if (PageHuge(page) || PageTransCompound(page))
+	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
@@ -188,11 +223,10 @@ int mshv_region_share(struct mshv_mem_region *region)
 
 static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
 				     u32 flags,
-				     u64 page_offset, u64 page_count)
+				     u64 page_offset, u64 page_count,
+				     bool huge_page)
 {
-	struct page *page = region->pages[page_offset];
-
-	if (PageHuge(page) || PageTransCompound(page))
+	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
@@ -212,11 +246,10 @@ int mshv_region_unshare(struct mshv_mem_region *region)
 
 static int mshv_region_chunk_remap(struct mshv_mem_region *region,
 				   u32 flags,
-				   u64 page_offset, u64 page_count)
+				   u64 page_offset, u64 page_count,
+				   bool huge_page)
 {
-	struct page *page = region->pages[page_offset];
-
-	if (PageHuge(page) || PageTransCompound(page))
+	if (huge_page)
 		flags |= HV_MAP_GPA_LARGE_PAGE;
 
 	return hv_call_map_gpa_pages(region->partition->pt_id,
@@ -295,11 +328,10 @@ int mshv_region_pin(struct mshv_mem_region *region)
 
 static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
 				   u32 flags,
-				   u64 page_offset, u64 page_count)
+				   u64 page_offset, u64 page_count,
+				   bool huge_page)
 {
-	struct page *page = region->pages[page_offset];
-
-	if (PageHuge(page) || PageTransCompound(page))
+	if (huge_page)
 		flags |= HV_UNMAP_GPA_LARGE_PAGE;
 
 	return hv_call_unmap_gpa_pages(region->partition->pt_id,



