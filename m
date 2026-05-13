Return-Path: <linux-hyperv+bounces-10851-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG9vHFPIBGrdNwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10851-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:52:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 011875394D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80B52306444F
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9823A75A0;
	Wed, 13 May 2026 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QKckDb+b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEFB3A2E07;
	Wed, 13 May 2026 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698237; cv=none; b=S7SBioJu+4dDIPpiESurNB9v6T8u68xwgGQXgpATzK0IWTlR54srLrThiM2S1wblnPqPHPqHjLQLsguU45uiKxqvEvUdIY2AjEfVmHD+R+8QE5jdKcdDZJ9z8cocHizXdku+odKil3wclkCKtjNZaclu7F1aLURFLhonj12C0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698237; c=relaxed/simple;
	bh=mgjIUoNgBvnsUXOF5t+OENFDaiaUfmqBFKPaOvMpg5k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dh9fybkBl4tHYvWSrZzzB1IpcS3S5R3ZsCto5lXQVbNvA3TB09TYaS9Uhyi4bDNuIxPvz1SfBS/MQlifAnFoy8HblU3yGn4jTtjIaNpEsLmn+XKJA4leFerY1QT1sEB7wgMylWxPwVOvHVe46cXW7lZcysQIJndQS8/0s8tZYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QKckDb+b; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1639520B7167;
	Wed, 13 May 2026 11:50:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1639520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698231;
	bh=ssFM0w8PO1NgMYhUDblNH3EvR85n7jcJT+LzbdUuKO4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QKckDb+b/xLTkgmcmx1k9/v3FLVTHkoXhRz4MncydSVKdxgdz2mXQgmV9ccb7KFX5
	 GXFosmkF0oJWl+ypb6j0I5wzy4vECzFU/nNoRc0DWQbf0fj6mg7dAf2ilTRFGQMMUy
	 d44EV9pU84grr9LQmmzso5j5k8hvq/FeeMVfjUls=
Subject: [PATCH v3 03/11] mshv: Convert region storage from page pointers to
 PFNs
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:50:33 +0000
Message-ID: 
 <177869823372.18773.11368972211653528037.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 011875394D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10851-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

The HMM interface returns PFNs from hmm_range_fault(), and the
hypervisor hypercalls in this driver consume PFNs.  Storing struct
page pointers in mshv_mem_region between those two interfaces forces
a page_to_pfn() conversion at every hypercall site and a
hmm_pfn_to_page() conversion at the HMM fault site, neither of
which needs the struct page form.

Switch mreg_pages[] to mreg_pfns[] and propagate through
hv_call_map_ram_pfns(), hv_call_map_mmio_pfns(), hv_call_unmap_pfns(),
and hv_call_modify_spa_host_access(). Per-PFN conversions at those
sites go away; the HMM fault path writes hmm_range_fault() output
straight into mreg_pfns[] after stripping HMM_PFN_FLAGS. Convert
back to struct page only where the API requires it (e.g.
unpin_user_page() during region invalidation).

Use ULONG_MAX as the invalid-PFN sentinel (MSHV_INVALID_PFN); 0 is a
valid PFN on some architectures. mshv_region_init_pfns() centralises
the "mark slots empty" pattern so callers agree on the sentinel.

Trade-off: the bulk unpin_user_pages() call is replaced with a
per-PFN unpin_user_page() loop, losing per-folio coalescing for
huge-folio-backed pinned regions. The cost is paid only on region
teardown and MMU-notifier invalidation (it it will ever be added for pinned
regions).

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c      |  325 +++++++++++++++++++++++-----------------
 drivers/hv/mshv_root.h         |   21 +--
 drivers/hv/mshv_root_hv_call.c |   49 +++---
 drivers/hv/mshv_root_main.c    |   33 ++--
 4 files changed, 239 insertions(+), 189 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index d9e1fbfefe714..77fc94733cb20 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -18,12 +18,32 @@
 #include "mshv_root.h"
 
 #define MSHV_MAP_FAULT_IN_PAGES				PTRS_PER_PMD
+#define MSHV_INVALID_PFN				ULONG_MAX
+
+static inline bool mshv_pfn_valid(unsigned long pfn)
+{
+	return pfn != MSHV_INVALID_PFN;
+}
+
+static void mshv_region_init_pfns_range(struct mshv_mem_region *region,
+					u64 pfn_offset, u64 pfn_count)
+{
+	u64 i;
+
+	for (i = pfn_offset; i < pfn_offset + pfn_count; i++)
+		region->mreg_pfns[i] = MSHV_INVALID_PFN;
+}
+
+void mshv_region_init_pfns(struct mshv_mem_region *region)
+{
+	mshv_region_init_pfns_range(region, 0, region->nr_pfns);
+}
 
 /**
  * mshv_chunk_stride - Compute stride for mapping guest memory
- * @page      : The page to check for huge page backing
- * @gfn       : Guest frame number for the mapping
- * @page_count: Total number of pages in the mapping
+ * @page     : The page to check for huge page backing
+ * @gfn      : Guest frame number for the mapping
+ * @pfn_count: Total number of pages in the mapping
  *
  * Determines the appropriate stride (in pages) for mapping guest memory.
  * Uses huge page stride if the backing page is huge and the guest mapping
@@ -32,18 +52,19 @@
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
+	 * page, gfn must be huge-page aligned and pfn_count must be at
+	 * least the number of pages in a huge page.
 	 */
 	if (!PageCompound(page) || !PageHead(page) ||
 	    !IS_ALIGNED(gfn, PTRS_PER_PMD) ||
-	    page_count < PTRS_PER_PMD)
+	    pfn_count < PTRS_PER_PMD)
 		return 1;
 
 	page_order = folio_order(page_folio(page));
@@ -57,60 +78,61 @@ static int mshv_chunk_stride(struct page *page,
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
+	if (!mshv_pfn_valid(pfn))
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
+		if (!mshv_pfn_valid(pfn))
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
 
@@ -118,70 +140,72 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
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
+	u64 end;
 	long ret;
 
-	if (page_offset + page_count > region->nr_pages)
+	if (check_add_overflow(pfn_offset, pfn_count, &end))
+		return -EOVERFLOW;
+
+	if (end > region->nr_pfns)
 		return -EINVAL;
 
-	while (page_count) {
+	while (pfn_count) {
 		/* Skip non-present pages */
-		if (!region->mreg_pages[page_offset]) {
-			page_offset++;
-			page_count--;
+		if (!mshv_pfn_valid(region->mreg_pfns[pfn_offset])) {
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
 
-	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
+	region = vzalloc(struct_size(region, mreg_pfns, nr_pfns));
 	if (!region)
 		return ERR_PTR(-ENOMEM);
 
-	region->nr_pages = nr_pages;
+	region->nr_pfns = nr_pfns;
 	region->start_gfn = guest_pfn;
 	region->start_uaddr = uaddr;
 	region->hv_map_flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_ADJUSTABLE;
@@ -190,6 +214,8 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
 		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
 
+	mshv_region_init_pfns(region);
+
 	kref_init(&region->mreg_refcount);
 
 	return region;
@@ -197,15 +223,15 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 
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
@@ -216,21 +242,21 @@ int mshv_region_share(struct mshv_mem_region *region)
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
 
@@ -239,30 +265,30 @@ int mshv_region_unshare(struct mshv_mem_region *region)
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
 
@@ -270,38 +296,50 @@ int mshv_region_map(struct mshv_mem_region *region)
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
+		if (!mshv_pfn_valid(region->mreg_pfns[i]))
+			continue;
 
-	memset(region->mreg_pages + page_offset, 0,
-	       page_count * sizeof(struct page *));
+		if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
+			unpin_user_page(pfn_to_page(region->mreg_pfns[i]));
+	}
+
+	mshv_region_init_pfns_range(region, pfn_offset, pfn_count);
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
@@ -311,39 +349,50 @@ int mshv_region_pin(struct mshv_mem_region *region)
 		 * with the FOLL_LONGTERM flag does a large temporary
 		 * allocation of contiguous memory.
 		 */
-		ret = pin_user_pages_fast(userspace_addr, nr_pages,
+		ret = pin_user_pages_fast(userspace_addr, nr_pfns,
 					  FOLL_WRITE | FOLL_LONGTERM,
 					  pages);
-		if (ret != nr_pages)
+
+		for (i = 0; i < ret; i++)
+			pfns[i] = page_to_pfn(pages[i]);
+
+		/*
+		 * Demand all requested pages were successfully pinned
+		 * or fail otherwise.
+		 */
+		if (ret != nr_pfns)
 			goto release_pages;
+
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
 
@@ -427,8 +476,8 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
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
@@ -437,7 +486,7 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
  * Return: 0 on success, negative error code on failure.
  */
 static int mshv_region_range_fault(struct mshv_mem_region *region,
-				   u64 page_offset, u64 page_count)
+				   u64 pfn_offset, u64 pfn_count)
 {
 	struct hmm_range range = {
 		.notifier = &region->mreg_mni,
@@ -447,13 +496,13 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
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
 
 	/*
 	 * Only request writable pages from HMM when the region itself
@@ -471,11 +520,15 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
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
@@ -485,24 +538,24 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 
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
@@ -532,16 +585,16 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
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
@@ -550,12 +603,12 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 
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
 
@@ -567,9 +620,9 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
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
 
@@ -588,7 +641,7 @@ bool mshv_region_movable_init(struct mshv_mem_region *region)
 
 	ret = mmu_interval_notifier_insert(&region->mreg_mni, current->mm,
 					   region->start_uaddr,
-					   region->nr_pages << HV_HYP_PAGE_SHIFT,
+					   region->nr_pfns << HV_HYP_PAGE_SHIFT,
 					   &mshv_region_mni_ops);
 	if (ret)
 		return false;
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index e19a84ea07905..34c9b57c50f47 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -85,15 +85,15 @@ enum mshv_region_type {
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
@@ -332,8 +332,8 @@ int hv_map_stats_page(enum hv_stats_object_type type,
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
@@ -375,6 +375,7 @@ int mshv_region_share(struct mshv_mem_region *region);
 int mshv_region_unshare(struct mshv_mem_region *region);
 int mshv_region_map(struct mshv_mem_region *region);
 void mshv_region_invalidate(struct mshv_mem_region *region);
+void mshv_region_init_pfns(struct mshv_mem_region *region);
 int mshv_region_pin(struct mshv_mem_region *region);
 void mshv_region_put(struct mshv_mem_region *region);
 int mshv_region_get(struct mshv_mem_region *region);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cc580225e9e45..00d37c39cbf26 100644
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
-	u64 done = 0, page_count = page_struct_count;
+	u64 done = 0, page_count = pfns_count;
 	int ret = 0;
 
-	if (page_count == 0 || (pages && mmio_spa))
+	if (page_count == 0 || (pfns && mmio_spa))
 		return -EINVAL;
 
 	if (flags & HV_MAP_GPA_LARGE_PAGE) {
@@ -227,9 +226,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 		for (i = 0; i < rep_count; i++) {
 			if (flags & HV_MAP_GPA_NO_ACCESS)
 				pfnlist[i] = 0;
-			else if (pages)
-				pfnlist[i] = page_to_pfn(pages[(done + i) <<
-							 large_shift]);
+			else if (pfns)
+				pfnlist[i] = pfns[(done + i) << large_shift];
 			else
 				pfnlist[i] = mmio_spa + done + i;
 		}
@@ -257,38 +255,38 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 
 		if (flags & HV_MAP_GPA_LARGE_PAGE)
 			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
-		hv_call_unmap_gpa_pages(partition_id, gfn,
-					done << large_shift, unmap_flags);
+		hv_call_unmap_pfns(partition_id, gfn,
+				   done << large_shift, unmap_flags);
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
@@ -1036,15 +1034,15 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
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
 	u64 done = 0;
 	unsigned long irq_flags, large_shift = 0;
-	u64 page_count = page_struct_count;
+	u64 page_count = pfns_count;
 	u16 code = acquire ? HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS :
 			     HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS;
 
@@ -1076,8 +1074,7 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 		input_page->host_access = host_access;
 
 		for (i = 0; i < rep_count; i++)
-			input_page->spa_page_list[i] =
-				page_to_pfn(pages[(done + i) << large_shift]);
+			input_page->spa_page_list[i] = pfns[(done + i) << large_shift];
 
 		status = hv_do_rep_hypercall(code, rep_count, 0, input_page,
 					     NULL);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 03c65ff6a7397..986cb9a4c428e 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -619,7 +619,7 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 
 	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
 		if (gfn >= region->start_gfn &&
-		    gfn < region->start_gfn + region->nr_pages)
+		    gfn < region->start_gfn + region->nr_pfns)
 			return region;
 	}
 
@@ -1313,20 +1313,20 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
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
@@ -1412,8 +1412,7 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 		 * is intentional; unpinning host-inaccessible pages would be
 		 * unsafe).
 		 */
-		memset(region->mreg_pages, 0,
-		       region->nr_pages * sizeof(region->mreg_pages[0]));
+		mshv_region_init_pfns(region);
 		goto err_out;
 	}
 err_out:
@@ -1470,21 +1469,21 @@ mshv_map_user_memory(struct mshv_partition *partition,
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
@@ -1522,7 +1521,7 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	/* Paranoia check */
 	if (region->start_uaddr != mem->userspace_addr ||
 	    region->start_gfn != mem->guest_pfn ||
-	    region->nr_pages != HVPFN_DOWN(mem->size)) {
+	    region->nr_pfns != HVPFN_DOWN(mem->size)) {
 		spin_unlock(&partition->pt_mem_regions_lock);
 		return -EINVAL;
 	}



