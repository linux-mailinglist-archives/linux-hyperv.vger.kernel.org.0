Return-Path: <linux-hyperv+bounces-9834-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMUwG+7XymmWAgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9834-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:07:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B94360CDD
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D15C3049970
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1D395272;
	Mon, 30 Mar 2026 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EG4YIxMF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280F437647F;
	Mon, 30 Mar 2026 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901061; cv=none; b=GMcSwIhiNKKWolB6K84AC8VBNBPT0Z49Uqrelh2W+4LOGROvk+v7QpWyap2REps42b1NNlyD2g5sxFzKvJnmAJpjykQeo9UhrbgARvWoix6cDuimyncCZzGiHnF4KzpKoGwwzXxOaNYfb0akewO2xFwOfEwRo8QoWzvZGcCmtxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901061; c=relaxed/simple;
	bh=vpsDaXaQYoHwGEXHoQL+yTVfY4IQL6mXgZEW3P9j61I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FC+tKeaCbW7fQNBXRXgjApRMv7QV95ZcTh5yFvnKMc8flNbj+XP1uOIEAbw7tHBBLM+2dLrCAwzudKN9ufPTt388lSmmz7AnM4f4imkBUthEo5v4897VXHBWQIYSBAJntQy43Qw4bjXCx4g1AHQBRVleVcdY6C45BuazQ/41qn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EG4YIxMF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1EF5920B7001;
	Mon, 30 Mar 2026 13:04:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1EF5920B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774901058;
	bh=X4ML2KRbciq3RA552WFA/JOYDllu1oNyp4JspV9APqQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EG4YIxMFwPJOZrTyrv8ilq/n3i0raqtgwZ3Wk84/8NosilovlkQ/hSZkxhTamdQKk
	 0ph2hVKi4AA0SF7goD4SUxoYjdw0b36tTM7AJhBhDwelMC4KblSUIk/o5McdIRM6I5
	 hA0AEbbeFy+jo9CNArXk1m5TJZRjtMLCQndsbJRs=
Subject: [PATCH 1/7] mshv: Convert from page pointers to PFNs
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 30 Mar 2026 20:04:17 +0000
Message-ID: 
 <177490105758.81669.969284388846280218.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-9834-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: C1B94360CDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The HMM interface returns PFNs from hmm_range_fault(), and the
hypervisor hypercalls operate on PFNs. Storing page pointers in
between these interfaces requires unnecessary conversions and
temporary allocations.

Store PFNs directly in memory regions to match the natural data flow.
This eliminates the temporary PFN array allocation in the HMM fault
path and reduces page_to_pfn() conversions throughout the driver.
Convert to page structs via pfn_to_page() only when operations like
unpin_user_page() require them.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c      |  297 ++++++++++++++++++++++------------------
 drivers/hv/mshv_root.h         |   20 +--
 drivers/hv/mshv_root_hv_call.c |   50 +++----
 drivers/hv/mshv_root_main.c    |   30 ++--
 4 files changed, 212 insertions(+), 185 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index fdffd4f002f6..b1a707d16c07 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -18,12 +18,13 @@
 #include "mshv_root.h"
 
 #define MSHV_MAP_FAULT_IN_PAGES				PTRS_PER_PMD
+#define MSHV_INVALID_PFN				ULONG_MAX
 
 /**
  * mshv_chunk_stride - Compute stride for mapping guest memory
  * @page      : The page to check for huge page backing
  * @gfn       : Guest frame number for the mapping
- * @page_count: Total number of pages in the mapping
+ * @pfn_count: Total number of pages in the mapping
  *
  * Determines the appropriate stride (in pages) for mapping guest memory.
  * Uses huge page stride if the backing page is huge and the guest mapping
@@ -32,18 +33,18 @@
  * Return: Stride in pages, or -EINVAL if page order is unsupported.
  */
 static int mshv_chunk_stride(struct page *page,
-			     u64 gfn, u64 page_count)
+			     u64 gfn, u64 pfn_count)
 {
 	unsigned int page_order;
 
 	/*
 	 * Use single page stride by default. For huge page stride, the
 	 * page must be compound and point to the head of the compound
-	 * page, and both gfn and page_count must be huge-page aligned.
+	 * page, and both gfn and pfn_count must be huge-page aligned.
 	 */
 	if (!PageCompound(page) || !PageHead(page) ||
 	    !IS_ALIGNED(gfn, PTRS_PER_PMD) ||
-	    !IS_ALIGNED(page_count, PTRS_PER_PMD))
+	    !IS_ALIGNED(pfn_count, PTRS_PER_PMD))
 		return 1;
 
 	page_order = folio_order(page_folio(page));
@@ -57,60 +58,61 @@ static int mshv_chunk_stride(struct page *page,
 /**
  * mshv_region_process_chunk - Processes a contiguous chunk of memory pages
  *                             in a region.
- * @region     : Pointer to the memory region structure.
- * @flags      : Flags to pass to the handler.
- * @page_offset: Offset into the region's pages array to start processing.
- * @page_count : Number of pages to process.
- * @handler    : Callback function to handle the chunk.
+ * @region    : Pointer to the memory region structure.
+ * @flags     : Flags to pass to the handler.
+ * @pfn_offset: Offset into the region's PFNs array to start processing.
+ * @pfn_count : Number of PFNs to process.
+ * @handler   : Callback function to handle the chunk.
  *
- * This function scans the region's pages starting from @page_offset,
- * checking for contiguous present pages of the same size (normal or huge).
- * It invokes @handler for the chunk of contiguous pages found. Returns the
- * number of pages handled, or a negative error code if the first page is
- * not present or the handler fails.
+ * This function scans the region's PFNs starting from @pfn_offset,
+ * checking for contiguous valid PFNs backed by pages of the same size
+ * (normal or huge). It invokes @handler for the chunk of contiguous valid
+ * PFNs found. Returns the number of PFNs handled, or a negative error code
+ * if the first PFN is invalid or the handler fails.
  *
- * Note: The @handler callback must be able to handle both normal and huge
- * pages.
+ * Note: The @handler callback must be able to handle valid PFNs backed by
+ * both normal and huge pages.
  *
  * Return: Number of pages handled, or negative error code.
  */
-static long mshv_region_process_chunk(struct mshv_mem_region *region,
-				      u32 flags,
-				      u64 page_offset, u64 page_count,
-				      int (*handler)(struct mshv_mem_region *region,
-						     u32 flags,
-						     u64 page_offset,
-						     u64 page_count,
-						     bool huge_page))
+static long mshv_region_process_pfns(struct mshv_mem_region *region,
+				     u32 flags,
+				     u64 pfn_offset, u64 pfn_count,
+				     int (*handler)(struct mshv_mem_region *region,
+						    u32 flags,
+						    u64 pfn_offset,
+						    u64 pfn_count,
+						    bool huge_page))
 {
-	u64 gfn = region->start_gfn + page_offset;
+	u64 gfn = region->start_gfn + pfn_offset;
 	u64 count;
-	struct page *page;
+	unsigned long pfn;
 	int stride, ret;
 
-	page = region->mreg_pages[page_offset];
-	if (!page)
+	pfn = region->mreg_pfns[pfn_offset];
+	if (!pfn_valid(pfn))
 		return -EINVAL;
 
-	stride = mshv_chunk_stride(page, gfn, page_count);
+	stride = mshv_chunk_stride(pfn_to_page(pfn), gfn, pfn_count);
 	if (stride < 0)
 		return stride;
 
 	/* Start at stride since the first stride is validated */
-	for (count = stride; count < page_count; count += stride) {
-		page = region->mreg_pages[page_offset + count];
+	for (count = stride; count < pfn_count ; count += stride) {
+		pfn = region->mreg_pfns[pfn_offset + count];
 
-		/* Break if current page is not present */
-		if (!page)
+		/* Break if current pfn is invalid */
+		if (!pfn_valid(pfn))
 			break;
 
 		/* Break if stride size changes */
-		if (stride != mshv_chunk_stride(page, gfn + count,
-						page_count - count))
+		if (stride != mshv_chunk_stride(pfn_to_page(pfn),
+						gfn + count,
+						pfn_count - count))
 			break;
 	}
 
-	ret = handler(region, flags, page_offset, count, stride > 1);
+	ret = handler(region, flags, pfn_offset, count, stride > 1);
 	if (ret)
 		return ret;
 
@@ -118,70 +120,73 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
 }
 
 /**
- * mshv_region_process_range - Processes a range of memory pages in a
- *                             region.
- * @region     : Pointer to the memory region structure.
- * @flags      : Flags to pass to the handler.
- * @page_offset: Offset into the region's pages array to start processing.
- * @page_count : Number of pages to process.
- * @handler    : Callback function to handle each chunk of contiguous
- *               pages.
+ * mshv_region_process_range - Processes a range of PFNs in a region.
+ * @region    : Pointer to the memory region structure.
+ * @flags     : Flags to pass to the handler.
+ * @pfn_offset: Offset into the region's PFNs array to start processing.
+ * @pfn_count : Number of PFNs to process.
+ * @handler   : Callback function to handle each chunk of contiguous
+ *              valid PFNs.
  *
- * Iterates over the specified range of pages in @region, skipping
- * non-present pages. For each contiguous chunk of present pages, invokes
- * @handler via mshv_region_process_chunk.
+ * Iterates over the specified range of PFNs in @region, skipping
+ * invalid PFNs. For each contiguous chunk of valid PFNS, invokes
+ * @handler via mshv_region_process_pfns.
  *
- * Note: The @handler callback must be able to handle both normal and huge
- * pages.
+ * Note: The @handler callback must be able to handle PFNs backed by both
+ * normal and huge pages.
  *
  * Returns 0 on success, or a negative error code on failure.
  */
 static int mshv_region_process_range(struct mshv_mem_region *region,
 				     u32 flags,
-				     u64 page_offset, u64 page_count,
+				     u64 pfn_offset, u64 pfn_count,
 				     int (*handler)(struct mshv_mem_region *region,
 						    u32 flags,
-						    u64 page_offset,
-						    u64 page_count,
+						    u64 pfn_offset,
+						    u64 pfn_count,
 						    bool huge_page))
 {
+	u64 pfn_end;
 	long ret;
 
-	if (page_offset + page_count > region->nr_pages)
+	if (check_add_overflow(pfn_offset, pfn_count, &pfn_end))
+		return -EOVERFLOW;
+
+	if (pfn_end > region->nr_pfns)
 		return -EINVAL;
 
-	while (page_count) {
+	while (pfn_count) {
 		/* Skip non-present pages */
-		if (!region->mreg_pages[page_offset]) {
-			page_offset++;
-			page_count--;
+		if (!pfn_valid(region->mreg_pfns[pfn_offset])) {
+			pfn_offset++;
+			pfn_count--;
 			continue;
 		}
 
-		ret = mshv_region_process_chunk(region, flags,
-						page_offset,
-						page_count,
-						handler);
+		ret = mshv_region_process_pfns(region, flags,
+					       pfn_offset, pfn_count,
+					       handler);
 		if (ret < 0)
 			return ret;
 
-		page_offset += ret;
-		page_count -= ret;
+		pfn_offset += ret;
+		pfn_count -= ret;
 	}
 
 	return 0;
 }
 
-struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
+struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pfns,
 					   u64 uaddr, u32 flags)
 {
 	struct mshv_mem_region *region;
+	u64 i;
 
-	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
+	region = vzalloc(sizeof(*region) + sizeof(unsigned long) * nr_pfns);
 	if (!region)
 		return ERR_PTR(-ENOMEM);
 
-	region->nr_pages = nr_pages;
+	region->nr_pfns = nr_pfns;
 	region->start_gfn = guest_pfn;
 	region->start_uaddr = uaddr;
 	region->hv_map_flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_ADJUSTABLE;
@@ -190,6 +195,9 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
 		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
 
+	for (i = 0; i < nr_pfns; i++)
+		region->mreg_pfns[i] = MSHV_INVALID_PFN;
+
 	kref_init(&region->mreg_refcount);
 
 	return region;
@@ -197,15 +205,15 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 
 static int mshv_region_chunk_share(struct mshv_mem_region *region,
 				   u32 flags,
-				   u64 page_offset, u64 page_count,
+				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
 {
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      region->mreg_pages + page_offset,
-					      page_count,
+					      region->mreg_pfns + pfn_offset,
+					      pfn_count,
 					      HV_MAP_GPA_READABLE |
 					      HV_MAP_GPA_WRITABLE,
 					      flags, true);
@@ -216,21 +224,21 @@ int mshv_region_share(struct mshv_mem_region *region)
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
 
 	return mshv_region_process_range(region, flags,
-					 0, region->nr_pages,
+					 0, region->nr_pfns,
 					 mshv_region_chunk_share);
 }
 
 static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
 				     u32 flags,
-				     u64 page_offset, u64 page_count,
+				     u64 pfn_offset, u64 pfn_count,
 				     bool huge_page)
 {
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      region->mreg_pages + page_offset,
-					      page_count, 0,
+					      region->mreg_pfns + pfn_offset,
+					      pfn_count, 0,
 					      flags, false);
 }
 
@@ -239,30 +247,30 @@ int mshv_region_unshare(struct mshv_mem_region *region)
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
 
 	return mshv_region_process_range(region, flags,
-					 0, region->nr_pages,
+					 0, region->nr_pfns,
 					 mshv_region_chunk_unshare);
 }
 
 static int mshv_region_chunk_remap(struct mshv_mem_region *region,
 				   u32 flags,
-				   u64 page_offset, u64 page_count,
+				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
 {
 	if (huge_page)
 		flags |= HV_MAP_GPA_LARGE_PAGE;
 
-	return hv_call_map_gpa_pages(region->partition->pt_id,
-				     region->start_gfn + page_offset,
-				     page_count, flags,
-				     region->mreg_pages + page_offset);
+	return hv_call_map_ram_pfns(region->partition->pt_id,
+				    region->start_gfn + pfn_offset,
+				    pfn_count, flags,
+				    region->mreg_pfns + pfn_offset);
 }
 
-static int mshv_region_remap_pages(struct mshv_mem_region *region,
-				   u32 map_flags,
-				   u64 page_offset, u64 page_count)
+static int mshv_region_remap_pfns(struct mshv_mem_region *region,
+				  u32 map_flags,
+				  u64 pfn_offset, u64 pfn_count)
 {
 	return mshv_region_process_range(region, map_flags,
-					 page_offset, page_count,
+					 pfn_offset, pfn_count,
 					 mshv_region_chunk_remap);
 }
 
@@ -270,38 +278,50 @@ int mshv_region_map(struct mshv_mem_region *region)
 {
 	u32 map_flags = region->hv_map_flags;
 
-	return mshv_region_remap_pages(region, map_flags,
-				       0, region->nr_pages);
+	return mshv_region_remap_pfns(region, map_flags,
+				      0, region->nr_pfns);
 }
 
-static void mshv_region_invalidate_pages(struct mshv_mem_region *region,
-					 u64 page_offset, u64 page_count)
+static void mshv_region_invalidate_pfns(struct mshv_mem_region *region,
+					u64 pfn_offset, u64 pfn_count)
 {
-	if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
-		unpin_user_pages(region->mreg_pages + page_offset, page_count);
+	u64 i;
+
+	for (i = pfn_offset; i < pfn_offset + pfn_count; i++) {
+		if (!pfn_valid(region->mreg_pfns[i]))
+			continue;
+
+		if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
+			unpin_user_page(pfn_to_page(region->mreg_pfns[i]));
 
-	memset(region->mreg_pages + page_offset, 0,
-	       page_count * sizeof(struct page *));
+		region->mreg_pfns[i] = MSHV_INVALID_PFN;
+	}
 }
 
 void mshv_region_invalidate(struct mshv_mem_region *region)
 {
-	mshv_region_invalidate_pages(region, 0, region->nr_pages);
+	mshv_region_invalidate_pfns(region, 0, region->nr_pfns);
 }
 
 int mshv_region_pin(struct mshv_mem_region *region)
 {
-	u64 done_count, nr_pages;
+	u64 done_count, nr_pfns, i;
+	unsigned long *pfns;
 	struct page **pages;
 	__u64 userspace_addr;
 	int ret;
 
-	for (done_count = 0; done_count < region->nr_pages; done_count += ret) {
-		pages = region->mreg_pages + done_count;
+	pages = kmalloc_array(MSHV_PIN_PAGES_BATCH_SIZE,
+			      sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	for (done_count = 0; done_count < region->nr_pfns; done_count += ret) {
+		pfns = region->mreg_pfns + done_count;
 		userspace_addr = region->start_uaddr +
 				 done_count * HV_HYP_PAGE_SIZE;
-		nr_pages = min(region->nr_pages - done_count,
-			       MSHV_PIN_PAGES_BATCH_SIZE);
+		nr_pfns = min(region->nr_pfns - done_count,
+			      MSHV_PIN_PAGES_BATCH_SIZE);
 
 		/*
 		 * Pinning assuming 4k pages works for large pages too.
@@ -311,39 +331,44 @@ int mshv_region_pin(struct mshv_mem_region *region)
 		 * with the FOLL_LONGTERM flag does a large temporary
 		 * allocation of contiguous memory.
 		 */
-		ret = pin_user_pages_fast(userspace_addr, nr_pages,
+		ret = pin_user_pages_fast(userspace_addr, nr_pfns,
 					  FOLL_WRITE | FOLL_LONGTERM,
 					  pages);
-		if (ret != nr_pages)
+		if (ret != nr_pfns)
 			goto release_pages;
+
+		for (i = 0; i < ret; i++)
+			pfns[i] = page_to_pfn(pages[i]);
 	}
 
+	kfree(pages);
 	return 0;
 
 release_pages:
 	if (ret > 0)
 		done_count += ret;
-	mshv_region_invalidate_pages(region, 0, done_count);
+	mshv_region_invalidate_pfns(region, 0, done_count);
+	kfree(pages);
 	return ret < 0 ? ret : -ENOMEM;
 }
 
 static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
 				   u32 flags,
-				   u64 page_offset, u64 page_count,
+				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
 {
 	if (huge_page)
 		flags |= HV_UNMAP_GPA_LARGE_PAGE;
 
-	return hv_call_unmap_gpa_pages(region->partition->pt_id,
-				       region->start_gfn + page_offset,
-				       page_count, flags);
+	return hv_call_unmap_pfns(region->partition->pt_id,
+				  region->start_gfn + pfn_offset,
+				  pfn_count, flags);
 }
 
 static int mshv_region_unmap(struct mshv_mem_region *region)
 {
 	return mshv_region_process_range(region, 0,
-					 0, region->nr_pages,
+					 0, region->nr_pfns,
 					 mshv_region_chunk_unmap);
 }
 
@@ -427,8 +452,8 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
 /**
  * mshv_region_range_fault - Handle memory range faults for a given region.
  * @region: Pointer to the memory region structure.
- * @page_offset: Offset of the page within the region.
- * @page_count: Number of pages to handle.
+ * @pfn_offset: Offset of the page within the region.
+ * @pfn_count: Number of pages to handle.
  *
  * This function resolves memory faults for a specified range of pages
  * within a memory region. It uses HMM (Heterogeneous Memory Management)
@@ -437,7 +462,7 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
  * Return: 0 on success, negative error code on failure.
  */
 static int mshv_region_range_fault(struct mshv_mem_region *region,
-				   u64 page_offset, u64 page_count)
+				   u64 pfn_offset, u64 pfn_count)
 {
 	struct hmm_range range = {
 		.notifier = &region->mreg_mni,
@@ -447,13 +472,13 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 	int ret;
 	u64 i;
 
-	pfns = kmalloc_array(page_count, sizeof(*pfns), GFP_KERNEL);
+	pfns = kmalloc_array(pfn_count, sizeof(*pfns), GFP_KERNEL);
 	if (!pfns)
 		return -ENOMEM;
 
 	range.hmm_pfns = pfns;
-	range.start = region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
-	range.end = range.start + page_count * HV_HYP_PAGE_SIZE;
+	range.start = region->start_uaddr + pfn_offset * HV_HYP_PAGE_SIZE;
+	range.end = range.start + pfn_count * HV_HYP_PAGE_SIZE;
 
 	do {
 		ret = mshv_region_hmm_fault_and_lock(region, &range);
@@ -462,11 +487,15 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 	if (ret)
 		goto out;
 
-	for (i = 0; i < page_count; i++)
-		region->mreg_pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
+	for (i = 0; i < pfn_count; i++) {
+		if (!(pfns[i] & HMM_PFN_VALID))
+			continue;
+		/* Drop HMM_PFN_* flags to ensure PFNs are valid. */
+		region->mreg_pfns[pfn_offset + i] = pfns[i] & ~HMM_PFN_FLAGS;
+	}
 
-	ret = mshv_region_remap_pages(region, region->hv_map_flags,
-				      page_offset, page_count);
+	ret = mshv_region_remap_pfns(region, region->hv_map_flags,
+				     pfn_offset, pfn_count);
 
 	mutex_unlock(&region->mreg_mutex);
 out:
@@ -476,24 +505,24 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 
 bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn)
 {
-	u64 page_offset, page_count;
+	u64 pfn_offset, pfn_count;
 	int ret;
 
 	/* Align the page offset to the nearest MSHV_MAP_FAULT_IN_PAGES. */
-	page_offset = ALIGN_DOWN(gfn - region->start_gfn,
-				 MSHV_MAP_FAULT_IN_PAGES);
+	pfn_offset = ALIGN_DOWN(gfn - region->start_gfn,
+				MSHV_MAP_FAULT_IN_PAGES);
 
 	/* Map more pages than requested to reduce the number of faults. */
-	page_count = min(region->nr_pages - page_offset,
-			 MSHV_MAP_FAULT_IN_PAGES);
+	pfn_count = min(region->nr_pfns - pfn_offset,
+			MSHV_MAP_FAULT_IN_PAGES);
 
-	ret = mshv_region_range_fault(region, page_offset, page_count);
+	ret = mshv_region_range_fault(region, pfn_offset, pfn_count);
 
 	WARN_ONCE(ret,
-		  "p%llu: GPA intercept failed: region %#llx-%#llx, gfn %#llx, page_offset %llu, page_count %llu\n",
+		  "p%llu: GPA intercept failed: region %#llx-%#llx, gfn %#llx, pfn_offset %llu, pfn_count %llu\n",
 		  region->partition->pt_id, region->start_uaddr,
-		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
-		  gfn, page_offset, page_count);
+		  region->start_uaddr + (region->nr_pfns << HV_HYP_PAGE_SHIFT),
+		  gfn, pfn_offset, pfn_count);
 
 	return !ret;
 }
@@ -523,16 +552,16 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 	struct mshv_mem_region *region = container_of(mni,
 						      struct mshv_mem_region,
 						      mreg_mni);
-	u64 page_offset, page_count;
+	u64 pfn_offset, pfn_count;
 	unsigned long mstart, mend;
 	int ret = -EPERM;
 
 	mstart = max(range->start, region->start_uaddr);
 	mend = min(range->end, region->start_uaddr +
-		   (region->nr_pages << HV_HYP_PAGE_SHIFT));
+		   (region->nr_pfns << HV_HYP_PAGE_SHIFT));
 
-	page_offset = HVPFN_DOWN(mstart - region->start_uaddr);
-	page_count = HVPFN_DOWN(mend - mstart);
+	pfn_offset = HVPFN_DOWN(mstart - region->start_uaddr);
+	pfn_count = HVPFN_DOWN(mend - mstart);
 
 	if (mmu_notifier_range_blockable(range))
 		mutex_lock(&region->mreg_mutex);
@@ -541,12 +570,12 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 
 	mmu_interval_set_seq(mni, cur_seq);
 
-	ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
-				      page_offset, page_count);
+	ret = mshv_region_remap_pfns(region, HV_MAP_GPA_NO_ACCESS,
+				     pfn_offset, pfn_count);
 	if (ret)
 		goto out_unlock;
 
-	mshv_region_invalidate_pages(region, page_offset, page_count);
+	mshv_region_invalidate_pfns(region, pfn_offset, pfn_count);
 
 	mutex_unlock(&region->mreg_mutex);
 
@@ -558,9 +587,9 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 	WARN_ONCE(ret,
 		  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u, pages %#llx-%#llx, mm: %#llx): %d\n",
 		  region->start_uaddr,
-		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
+		  region->start_uaddr + (region->nr_pfns << HV_HYP_PAGE_SHIFT),
 		  range->start, range->end, range->event,
-		  page_offset, page_offset + page_count - 1, (u64)range->mm, ret);
+		  pfn_offset, pfn_offset + pfn_count - 1, (u64)range->mm, ret);
 	return false;
 }
 
@@ -579,7 +608,7 @@ bool mshv_region_movable_init(struct mshv_mem_region *region)
 
 	ret = mmu_interval_notifier_insert(&region->mreg_mni, current->mm,
 					   region->start_uaddr,
-					   region->nr_pages << HV_HYP_PAGE_SHIFT,
+					   region->nr_pfns << HV_HYP_PAGE_SHIFT,
 					   &mshv_region_mni_ops);
 	if (ret)
 		return false;
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 947dfb76bb19..f1d4bee97a3f 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -84,15 +84,15 @@ enum mshv_region_type {
 struct mshv_mem_region {
 	struct hlist_node hnode;
 	struct kref mreg_refcount;
-	u64 nr_pages;
+	u64 nr_pfns;
 	u64 start_gfn;
 	u64 start_uaddr;
 	u32 hv_map_flags;
 	struct mshv_partition *partition;
 	enum mshv_region_type mreg_type;
 	struct mmu_interval_notifier mreg_mni;
-	struct mutex mreg_mutex;	/* protects region pages remapping */
-	struct page *mreg_pages[];
+	struct mutex mreg_mutex;	/* protects region PFNs remapping */
+	unsigned long mreg_pfns[];
 };
 
 struct mshv_irq_ack_notifier {
@@ -282,11 +282,11 @@ int hv_call_create_partition(u64 flags,
 int hv_call_initialize_partition(u64 partition_id);
 int hv_call_finalize_partition(u64 partition_id);
 int hv_call_delete_partition(u64 partition_id);
-int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs);
-int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
-			  u32 flags, struct page **pages);
-int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
-			    u32 flags);
+int hv_call_map_mmio_pfns(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs);
+int hv_call_map_ram_pfns(u64 partition_id, u64 gpa_target, u64 pfn_count,
+			 u32 flags, unsigned long *pfns);
+int hv_call_unmap_pfns(u64 partition_id, u64 gpa_target, u64 pfn_count,
+		       u32 flags);
 int hv_call_delete_vp(u64 partition_id, u32 vp_index);
 int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
 				     u64 dest_addr,
@@ -329,8 +329,8 @@ int hv_map_stats_page(enum hv_stats_object_type type,
 int hv_unmap_stats_page(enum hv_stats_object_type type,
 			struct hv_stats_page *page_addr,
 			const union hv_stats_object_identity *identity);
-int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
-				   u64 page_struct_count, u32 host_access,
+int hv_call_modify_spa_host_access(u64 partition_id, unsigned long *pfns,
+				   u64 pfns_count, u32 host_access,
 				   u32 flags, u8 acquire);
 int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 arg,
 				      void *property_value, size_t property_value_sz);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb55d4d4be2e..a95f2cfc5da5 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -188,17 +188,16 @@ int hv_call_delete_partition(u64 partition_id)
 	return hv_result_to_errno(status);
 }
 
-/* Ask the hypervisor to map guest ram pages or the guest mmio space */
-static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
-			       u32 flags, struct page **pages, u64 mmio_spa)
+static int hv_do_map_pfns(u64 partition_id, u64 gfn, u64 pfns_count,
+			  u32 flags, unsigned long *pfns, u64 mmio_spa)
 {
 	struct hv_input_map_gpa_pages *input_page;
 	u64 status, *pfnlist;
 	unsigned long irq_flags, large_shift = 0;
 	int ret = 0, done = 0;
-	u64 page_count = page_struct_count;
+	u64 page_count = pfns_count;
 
-	if (page_count == 0 || (pages && mmio_spa))
+	if (page_count == 0 || (pfns && mmio_spa))
 		return -EINVAL;
 
 	if (flags & HV_MAP_GPA_LARGE_PAGE) {
@@ -227,14 +226,14 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 		for (i = 0; i < rep_count; i++)
 			if (flags & HV_MAP_GPA_NO_ACCESS) {
 				pfnlist[i] = 0;
-			} else if (pages) {
+			} else if (pfns) {
 				u64 index = (done + i) << large_shift;
 
-				if (index >= page_struct_count) {
+				if (index >= pfns_count) {
 					ret = -EINVAL;
 					break;
 				}
-				pfnlist[i] = page_to_pfn(pages[index]);
+				pfnlist[i] = pfns[index];
 			} else {
 				pfnlist[i] = mmio_spa + done + i;
 			}
@@ -266,37 +265,37 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 
 		if (flags & HV_MAP_GPA_LARGE_PAGE)
 			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
-		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
+		hv_call_unmap_pfns(partition_id, gfn, done, unmap_flags);
 	}
 
 	return ret;
 }
 
 /* Ask the hypervisor to map guest ram pages */
-int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
-			  u32 flags, struct page **pages)
+int hv_call_map_ram_pfns(u64 partition_id, u64 gfn, u64 pfn_count,
+			 u32 flags, unsigned long *pfns)
 {
-	return hv_do_map_gpa_hcall(partition_id, gpa_target, page_count,
-				   flags, pages, 0);
+	return hv_do_map_pfns(partition_id, gfn, pfn_count, flags,
+			      pfns, 0);
 }
 
-/* Ask the hypervisor to map guest mmio space */
-int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs)
+int hv_call_map_mmio_pfns(u64 partition_id, u64 gfn, u64 mmio_spa,
+			  u64 pfn_count)
 {
 	int i;
 	u32 flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
 		    HV_MAP_GPA_NOT_CACHED;
 
-	for (i = 0; i < numpgs; i++)
+	for (i = 0; i < pfn_count; i++)
 		if (page_is_ram(mmio_spa + i))
 			return -EINVAL;
 
-	return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
-				   mmio_spa);
+	return hv_do_map_pfns(partition_id, gfn, pfn_count, flags,
+			      NULL, mmio_spa);
 }
 
-int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
-			    u32 flags)
+int hv_call_unmap_pfns(u64 partition_id, u64 gfn, u64 page_count_4k,
+		       u32 flags)
 {
 	struct hv_input_unmap_gpa_pages *input_page;
 	u64 status, page_count = page_count_4k;
@@ -1009,15 +1008,15 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 	return ret;
 }
 
-int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
-				   u64 page_struct_count, u32 host_access,
+int hv_call_modify_spa_host_access(u64 partition_id, unsigned long *pfns,
+				   u64 pfns_count, u32 host_access,
 				   u32 flags, u8 acquire)
 {
 	struct hv_input_modify_sparse_spa_page_host_access *input_page;
 	u64 status;
 	int done = 0;
 	unsigned long irq_flags, large_shift = 0;
-	u64 page_count = page_struct_count;
+	u64 page_count = pfns_count;
 	u16 code = acquire ? HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS :
 			     HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS;
 
@@ -1051,11 +1050,10 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 		for (i = 0; i < rep_count; i++) {
 			u64 index = (done + i) << large_shift;
 
-			if (index >= page_struct_count)
+			if (index >= pfns_count)
 				return -EINVAL;
 
-			input_page->spa_page_list[i] =
-						page_to_pfn(pages[index]);
+			input_page->spa_page_list[i] = pfns[index];
 		}
 
 		status = hv_do_rep_hypercall(code, rep_count, 0, input_page,
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index f2d83d6c8c4f..685e4b562186 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -619,7 +619,7 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 
 	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
 		if (gfn >= region->start_gfn &&
-		    gfn < region->start_gfn + region->nr_pages)
+		    gfn < region->start_gfn + region->nr_pfns)
 			return region;
 	}
 
@@ -1221,20 +1221,20 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 					bool is_mmio)
 {
 	struct mshv_mem_region *rg;
-	u64 nr_pages = HVPFN_DOWN(mem->size);
+	u64 nr_pfns = HVPFN_DOWN(mem->size);
 
 	/* Reject overlapping regions */
 	spin_lock(&partition->pt_mem_regions_lock);
 	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
-		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
-		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
+		if (mem->guest_pfn + nr_pfns <= rg->start_gfn ||
+		    rg->start_gfn + rg->nr_pfns <= mem->guest_pfn)
 			continue;
 		spin_unlock(&partition->pt_mem_regions_lock);
 		return -EEXIST;
 	}
 	spin_unlock(&partition->pt_mem_regions_lock);
 
-	rg = mshv_region_create(mem->guest_pfn, nr_pages,
+	rg = mshv_region_create(mem->guest_pfn, nr_pfns,
 				mem->userspace_addr, mem->flags);
 	if (IS_ERR(rg))
 		return PTR_ERR(rg);
@@ -1372,21 +1372,21 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		 * the hypervisor track dirty pages, enabling pre-copy live
 		 * migration.
 		 */
-		ret = hv_call_map_gpa_pages(partition->pt_id,
-					    region->start_gfn,
-					    region->nr_pages,
-					    HV_MAP_GPA_NO_ACCESS, NULL);
+		ret = hv_call_map_ram_pfns(partition->pt_id,
+					   region->start_gfn,
+					   region->nr_pfns,
+					   HV_MAP_GPA_NO_ACCESS, NULL);
 		break;
 	case MSHV_REGION_TYPE_MMIO:
-		ret = hv_call_map_mmio_pages(partition->pt_id,
-					     region->start_gfn,
-					     mmio_pfn,
-					     region->nr_pages);
+		ret = hv_call_map_mmio_pfns(partition->pt_id,
+					    region->start_gfn,
+					    mmio_pfn,
+					    region->nr_pfns);
 		break;
 	}
 
 	trace_mshv_map_user_memory(partition->pt_id, region->start_uaddr,
-				   region->start_gfn, region->nr_pages,
+				   region->start_gfn, region->nr_pfns,
 				   region->hv_map_flags, ret);
 
 	if (ret)
@@ -1424,7 +1424,7 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	/* Paranoia check */
 	if (region->start_uaddr != mem.userspace_addr ||
 	    region->start_gfn != mem.guest_pfn ||
-	    region->nr_pages != HVPFN_DOWN(mem.size)) {
+	    region->nr_pfns != HVPFN_DOWN(mem.size)) {
 		spin_unlock(&partition->pt_mem_regions_lock);
 		return -EINVAL;
 	}



