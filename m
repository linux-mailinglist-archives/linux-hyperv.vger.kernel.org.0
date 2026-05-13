Return-Path: <linux-hyperv+bounces-10852-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AXIOV/IBGodOgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10852-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:52:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DD55394EB
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2ACE30166E9
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8D3F4112;
	Wed, 13 May 2026 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QOK1TTwc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048F53A75A0;
	Wed, 13 May 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698242; cv=none; b=LSZU4d3gyj8GTPh1aR+RiO3EAOLqC6zdclOGh2ZdSbQsYRjU1/ylrLYgBAvcXnofjzayoDSui//SRY7NXrREWy7pkie6gMxJei4UxYmTvAJQI5P7h6UOCfNBkDU1jjvjuStJ/2uHJixLSMPuiT0gtiHvtz3kS7HqNyyOMgkppOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698242; c=relaxed/simple;
	bh=7hZ9wYS6jEwlaO5u3UmcxSv/4C/b1OJp+7kNlUu5RdU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fv0xqzRftBt2/ir3L8xLHhWM5b4fpKQ5GYZ2Y4egmWa9pGL5A1wffglw+ViosZp3f0fcCHfIWYcMuYQW/fB05QF7V3efJvJGwxKLIOP13UlYyzMFSLgjjFg76i5LtKRBwJ75b17l00H/VjMANsIHRtPqKazdefgsEj6anYCfA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QOK1TTwc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 976A820B7166;
	Wed, 13 May 2026 11:50:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 976A820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698237;
	bh=YoRR5pCmq5c8ghv3Ylc4itHbJsU4JB+uTVU9CiiGtr4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QOK1TTwc/KzbET8UK/LEsDylCyv2iE86j5HdWjgy7AhPTaDUcoDdWqEi+tHkosVVn
	 TbL0mePaqPRId/Zt2eFCGesd9Vd0vQhtK2q5vpUhhrudoKtJrtR+pV4DWZmLO2/wWn
	 5skz6dK9jfcDiVe51f1++F9tb4/xeeNLX6X7oMUY=
Subject: [PATCH v3 04/11] mshv: Refactor region segmentation into a dedicated
 helper
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:50:40 +0000
Message-ID: 
 <177869824026.18773.2167526892519098832.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: 67DD55394EB
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
	TAGGED_FROM(0.00)[bounces-10852-lists,linux-hyperv=lfdr.de];
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

mshv_region_process_pfns() conflated three concerns: validating the first
PFN of a chunk, locating the longest contiguous run of same-stride PFNs
starting from there, and dispatching the chunk to the handler. The
locate-and-dispatch interleaving made the partial-consume case (4K-to-2M
stride transition inside a same-validity run) emergent rather than
explicit, and required process_range to handle a return value that was
simultaneously a count and an error code.

Split the locate step out into mshv_region_chunk_size().  The new helper
takes a starting offset and an upper bound, returns the length of the
same-stride run, and reports whether that run is huge-page-backed via an
out-parameter. mshv_region_process_pfns() goes away;
mshv_region_process_range() now drives the loop directly, calling
chunk_size() for the next segment length and dispatching the handler with
the precomputed huge_page hint.

mshv_chunk_stride() additionally takes a PFN instead of a struct page * and
validates it internally, so each call site no longer needs its own
mshv_pfn_valid() check before pfn_to_page().

No functional change; the per-handler dispatch shape, segmentation
boundaries, and lock context are all preserved.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |  103 ++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 53 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 77fc94733cb20..090c4052f0f4d 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -41,7 +41,7 @@ void mshv_region_init_pfns(struct mshv_mem_region *region)
 
 /**
  * mshv_chunk_stride - Compute stride for mapping guest memory
- * @page     : The page to check for huge page backing
+ * @pfn      : The PFN to check for huge page backing
  * @gfn      : Guest frame number for the mapping
  * @pfn_count: Total number of pages in the mapping
  *
@@ -51,11 +51,16 @@ void mshv_region_init_pfns(struct mshv_mem_region *region)
  *
  * Return: Stride in pages, or -EINVAL if page order is unsupported.
  */
-static int mshv_chunk_stride(struct page *page,
-			     u64 gfn, u64 pfn_count)
+static int mshv_chunk_stride(unsigned long pfn, u64 gfn, u64 pfn_count)
 {
+	struct page *page;
 	unsigned int page_order;
 
+	if (!mshv_pfn_valid(pfn))
+		return -EINVAL;
+
+	page = pfn_to_page(pfn);
+
 	/*
 	 * Use single page stride by default. For huge page stride, the
 	 * page must be compound and point to the head of the compound
@@ -76,65 +81,51 @@ static int mshv_chunk_stride(struct page *page,
 }
 
 /**
- * mshv_region_process_chunk - Processes a contiguous chunk of memory pages
- *                             in a region.
- * @region    : Pointer to the memory region structure.
- * @flags     : Flags to pass to the handler.
- * @pfn_offset: Offset into the region's PFNs array to start processing.
- * @pfn_count : Number of PFNs to process.
- * @handler   : Callback function to handle the chunk.
+ * mshv_region_chunk_size - Length of the next same-stride PFN run.
+ * @region    : Memory region whose PFN array is being walked.
+ * @pfn_offset: Offset into region->mreg_pfns at which to start; the
+ *              PFN at this offset must be valid.
+ * @pfn_count : Upper bound on the run length (not necessarily the
+ *              region's total length; typically the residual passed
+ *              from mshv_region_process_range()).
+ * @huge_page : Out-parameter set to true if the run is backed by
+ *              PMD-order folios and may be dispatched as 2 MiB
+ *              chunks; false for 4 KiB-stride dispatch.
  *
- * This function scans the region's PFNs starting from @pfn_offset,
- * checking for contiguous valid PFNs backed by pages of the same size
- * (normal or huge). It invokes @handler for the chunk of contiguous valid
- * PFNs found. Returns the number of PFNs handled, or a negative error code
- * if the first PFN is invalid or the handler fails.
+ * Walks the PFN array starting at @pfn_offset and returns the length
+ * of the longest contiguous run that shares the stride classification
+ * (4 KiB vs 2 MiB) of the first PFN.  An invalid PFN inside the run
+ * terminates it.  The run is bounded above by @pfn_count.
  *
- * Note: The @handler callback must be able to handle valid PFNs backed by
- * both normal and huge pages.
+ * The caller may then dispatch [pfn_offset, pfn_offset + return) to a
+ * handler with @huge_page indicating which stride applies.  After the
+ * dispatch the caller advances by the returned length and re-invokes
+ * this function for the next run.
  *
- * Return: Number of pages handled, or negative error code.
+ * Return: Length of the run in PFNs, or a negative errno from
+ *         mshv_chunk_stride() if the starting PFN is invalid or its
+ *         backing folio order is unsupported.
  */
-static long mshv_region_process_pfns(struct mshv_mem_region *region,
-				     u32 flags,
-				     u64 pfn_offset, u64 pfn_count,
-				     int (*handler)(struct mshv_mem_region *region,
-						    u32 flags,
-						    u64 pfn_offset,
-						    u64 pfn_count,
-						    bool huge_page))
+static long mshv_region_chunk_size(struct mshv_mem_region *region,
+				   u64 pfn_offset, u64 pfn_count,
+				   bool *huge_page)
 {
+	unsigned long *pfns = region->mreg_pfns + pfn_offset;
 	u64 gfn = region->start_gfn + pfn_offset;
-	u64 count;
-	unsigned long pfn;
-	int stride, ret;
+	u64 count = 0, stride;
 
-	pfn = region->mreg_pfns[pfn_offset];
-	if (!mshv_pfn_valid(pfn))
-		return -EINVAL;
-
-	stride = mshv_chunk_stride(pfn_to_page(pfn), gfn, pfn_count);
+	stride = mshv_chunk_stride(pfns[0], gfn, pfn_count);
 	if (stride < 0)
 		return stride;
 
-	/* Start at stride since the first stride is validated */
-	for (count = stride; count < pfn_count ; count += stride) {
-		pfn = region->mreg_pfns[pfn_offset + count];
-
-		/* Break if current pfn is invalid */
-		if (!mshv_pfn_valid(pfn))
-			break;
-
-		/* Break if stride size changes */
-		if (stride != mshv_chunk_stride(pfn_to_page(pfn),
+	for (count = stride; count < pfn_count; count += stride) {
+		if (stride != mshv_chunk_stride(pfns[count],
 						gfn + count,
 						pfn_count - count))
 			break;
 	}
 
-	ret = handler(region, flags, pfn_offset, count, stride > 1);
-	if (ret)
-		return ret;
+	*huge_page = stride > 1;
 
 	return count;
 }
@@ -150,7 +141,7 @@ static long mshv_region_process_pfns(struct mshv_mem_region *region,
  *
  * Iterates over the specified range of PFNs in @region, skipping
  * invalid PFNs. For each contiguous chunk of valid PFNS, invokes
- * @handler via mshv_region_process_pfns.
+ * @handler.
  *
  * Note: The @handler callback must be able to handle PFNs backed by both
  * normal and huge pages.
@@ -176,6 +167,9 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 		return -EINVAL;
 
 	while (pfn_count) {
+		bool huge_page;
+		long count;
+
 		/* Skip non-present pages */
 		if (!mshv_pfn_valid(region->mreg_pfns[pfn_offset])) {
 			pfn_offset++;
@@ -183,14 +177,17 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 			continue;
 		}
 
-		ret = mshv_region_process_pfns(region, flags,
-					       pfn_offset, pfn_count,
-					       handler);
+		count = mshv_region_chunk_size(region, pfn_offset, pfn_count,
+					       &huge_page);
+		if (count < 0)
+			return count;
+
+		ret = handler(region, flags, pfn_offset, count, huge_page);
 		if (ret < 0)
 			return ret;
 
-		pfn_offset += ret;
-		pfn_count -= ret;
+		pfn_offset += count;
+		pfn_count -= count;
 	}
 
 	return 0;



