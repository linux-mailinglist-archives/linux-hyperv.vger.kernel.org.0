Return-Path: <linux-hyperv+bounces-8174-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A87CFFA05
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 20:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D98B93034932
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 19:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFBF358D25;
	Wed,  7 Jan 2026 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Nxdjjs9g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6969329377;
	Wed,  7 Jan 2026 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811549; cv=none; b=EEbFQf0nt4Mqxbxwf+j4ID7ehzxUam8srBhL8s6+euhNCx4GTdpKbDZLpAoMqcAmnkQf8Xcudd6Zeezm049rqG5EY92HN3d5LwxbkA6jN6iHf78lx3X8OkQEXP2hLcrolz+jDFA7SNiisvaOvzErtAAMs3yTDnbkqYja2PFprIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811549; c=relaxed/simple;
	bh=Kd6A9FbkUtd6NZKr6fveTymtDZRfC4/vXAk/E/zwQIg=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=SJ6aylBR9Z6GEgy2feLWl5gG1LnVCCHGJAW8gF8tKBO86G48A+5UX6n98UqPz0fmc2c8gm5DKF0yR9i4eVRGrfxb0l2qh9BXvlFOua/zTnPc4C6PD1gVwgO7QH6pBUHQ4oHGkG3URzYYbOUXXgPFtYozDVcy1QRtqMEFAXIemFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Nxdjjs9g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 28C912126886;
	Wed,  7 Jan 2026 10:45:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28C912126886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767811544;
	bh=kK73Q+AxentDmReNN745sHyLrtsn5inBVJaCOPOk79E=;
	h=Subject:From:To:Cc:Date:From;
	b=Nxdjjs9gh9gBELApBsubfThsZt8VKoqrtVRtiPKqlo6Qd647V4/Gta7+y6OWDiTeO
	 U3lbvKfPoXvkkBhRgO1owd4AoDxaAyFjarFCP68FpCYAGrSVmoeiU42k4S7cT6lr/s
	 8UNg+I7xl8/XTYSuSRUF20vm5j7eZPPzKzpU1J7Q=
Subject: [PATCH v2] mshv: Align huge page stride with guest mapping
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Jan 2026 18:45:43 +0000
Message-ID: 
 <176781093198.21595.6373086133020540990.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Ensure that a stride larger than 1 (huge page) is only used when page
points to a head of a huge page and both the guest frame number (gfn) and
the operation size (page_count) are aligned to the huge page size
(PTRS_PER_PMD). This matches the hypervisor requirement that map/unmap
operations for huge pages must be guest-aligned and cover a full huge page.

Add mshv_chunk_stride() to encapsulate this alignment and page-order
validation, and plumb a huge_page flag into the region chunk handlers.
This prevents issuing large-page map/unmap/share operations that the
hypervisor would reject due to misaligned guest mappings.

Fixes: abceb4297bf8 ("mshv: Fix huge page handling in memory region traversal")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   93 ++++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 30bacba6aec3..adba3564d9f1 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -19,6 +19,41 @@
 
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
+	/*
+	 * Use single page stride by default. For huge page stride, the
+	 * page must be compound and point to the head of the compound
+	 * page, and both gfn and page_count must be huge-page aligned.
+	 */
+	if (!PageCompound(page) || !PageHead(page) ||
+	    !IS_ALIGNED(gfn, PTRS_PER_PMD) ||
+	    !IS_ALIGNED(page_count, PTRS_PER_PMD))
+		return 1;
+
+	page_order = folio_order(page_folio(page));
+	/* The hypervisor only supports 2M huge page */
+	if (page_order != PMD_ORDER)
+		return -EINVAL;
+
+	return 1 << page_order;
+}
+
 /**
  * mshv_region_process_chunk - Processes a contiguous chunk of memory pages
  *                             in a region.
@@ -45,25 +80,23 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
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
+	stride = mshv_chunk_stride(page, gfn, page_count);
+	if (stride < 0)
+		return stride;
 
-	stride = 1 << page_order;
-
-	/* Start at stride since the first page is validated */
+	/* Start at stride since the first stride is validated */
 	for (count = stride; count < page_count; count += stride) {
 		page = region->pages[page_offset + count];
 
@@ -71,12 +104,13 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
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
 
@@ -108,7 +142,8 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 				     int (*handler)(struct mshv_mem_region *region,
 						    u32 flags,
 						    u64 page_offset,
-						    u64 page_count))
+						    u64 page_count,
+						    bool huge_page))
 {
 	long ret;
 
@@ -162,11 +197,10 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 
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
@@ -188,11 +222,10 @@ int mshv_region_share(struct mshv_mem_region *region)
 
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
@@ -212,11 +245,10 @@ int mshv_region_unshare(struct mshv_mem_region *region)
 
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
@@ -295,11 +327,10 @@ int mshv_region_pin(struct mshv_mem_region *region)
 
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



