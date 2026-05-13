Return-Path: <linux-hyperv+bounces-10865-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGVVOlzNBGrMPAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10865-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:13:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB67539B4D
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6059307FB84
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B63B2FEA;
	Wed, 13 May 2026 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hkitV59J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B860B3AEB2D;
	Wed, 13 May 2026 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698505; cv=none; b=bKFuZtV1II/2IUQT/Vj08HoN8fnDbl+2r6SK5XIhiHuSwVUKkqmJXmvUUFpHxSht4q9g+B2LsvnRdg4pfNtEV7SQtV423pFs5LnKe7pFZBNQC6RgtMNuFQD8/NE32w6u5F8EcxN5YiDbJZgGZBfCbWIcbODkQVfX2sfVPcMQk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698505; c=relaxed/simple;
	bh=NY0IB5D9eklJb/xzNvy1izJx6xPy5FnEFUgW/7hH228=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XG4N2ZXjT4n8+WXH7dehR8XeSRQXKiTntDYfRTXZqtY5/BBO++ePCQTShboJQd96h6if7o7qzT5JJQIRF1BQCGyYf1VcOs8/LpUPQdDDiTiluDPXCwb68ruFEb4ihcUY4QCad35RxcjDGX9ZfQU0PAqzzYhMRTj1M6Z1Z+fS8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hkitV59J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5EDB220B7166;
	Wed, 13 May 2026 11:55:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5EDB220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698500;
	bh=n5oH0j0wjNcSImKssJJxbElpf12ZhOjkTS+ssyOlEy4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hkitV59Jh397lGxZP+cyBu+CoCXGy8OUut+u5yKxtOMf6LcRJhm91A/LGqBFuodZt
	 1FIoMEP4iVkN4nzaEQ3nF5rUXqLoN9PYQsPbvLJtTdNhAz8h5/CjJR2DygTom6AD1v
	 peuFYtI9aUkA7SGcI8oet0+pui1aeS2oWTzb71dg=
Subject: [PATCH v4 5/6] mshv: Simplify pfn array handling in region processing
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:55:03 +0000
Message-ID: 
 <177869850302.19379.805878056178617122.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177869833161.19379.1357399549586915698.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177869833161.19379.1357399549586915698.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4EB67539B4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10865-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The current code requires passing both the full pfn array and an offset
parameter to region processing functions, forcing callees to manually
index into arrays. This approach is inflexible and makes it difficult
to work with different sources of pfn arrays.

Upcoming changes will need to pass pfn arrays obtained from the HMM
framework directly to these functions. The HMM framework returns arrays
that represent specific ranges rather than full region arrays with
offsets, making the current offset-based indexing pattern incompatible.

Refactor by having callers pass pre-offset pointers to pfn arrays and
removing offset-based indexing from callees. This allows functions to
work with any pfn array starting at index 0, regardless of its source,
and prepares the code for HMM integration.

No functional change intended.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 87204b2b48290..e20db61e9829f 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -99,14 +99,13 @@ static int mshv_chunk_stride(unsigned long pfn, u64 gfn, u64 pfn_count)
 
 /**
  * mshv_region_chunk_size - Length of the next contiguous PFN run in a region.
- * @region    : Memory region whose PFN array is being walked.
- * @pfn_offset: Offset into region->mreg_pfns at which to start.
- * @pfn_count : Upper bound on the run length.
- * @pfns      : Pointer to an array of PFNs corresponding to the region.
- * @huge_page : Out-parameter set to true if the run may be dispatched
+ * @gfn      : GFN corresponding to the start of the PFN run.
+ * @pfn_count: Upper bound on the run length.
+ * @pfns     : PFN array starting at the chunk's first PFN.
+ * @huge_page: Out-parameter set to true if the run may be dispatched
  *              as a 2 MiB chunk; false for 4 KiB-stride dispatch.
  *
- * Returns the length of the longest contiguous run starting at @pfn_offset
+ * Returns the length of the longest contiguous run starting at at @pfns[0]
  * that shares the classification of the first PFN: either a same-stride run of
  * valid PFNs (4 KiB or 2 MiB) or a hole of invalid PFNs. A hole that is
  * huge-page aligned in @gfn space and at least PTRS_PER_PMD entries long is
@@ -117,15 +116,11 @@ static int mshv_chunk_stride(unsigned long pfn, u64 gfn, u64 pfn_count)
  * Return: Length of the run in PFNs, or a negative errno from
  *         mshv_chunk_stride() if the backing folio order is unsupported.
  */
-static long mshv_region_chunk_size(struct mshv_region *region,
-				   u64 pfn_offset, u64 pfn_count,
+static long mshv_region_chunk_size(u64 gfn, u64 pfn_count,
 				   unsigned long *pfns, bool *huge_page)
 {
-	u64 gfn = region->start_gfn + pfn_offset;
 	u64 count = 0, stride;
 
-	pfns += pfn_offset;
-
 	if (!mshv_pfn_valid(pfns[0])) {
 		for (count = 1; count < pfn_count; count++) {
 			if (mshv_pfn_valid(pfns[count]))
@@ -162,7 +157,7 @@ static long mshv_region_chunk_size(struct mshv_region *region,
  * mshv_region_process_range - Processes a range of PFNs in a region.
  * @region    : Pointer to the memory region structure.
  * @flags     : Flags to pass to the handler.
- * @pfn_offset: Offset into the region's PFNs array to start processing.
+ * @pfn_offset: Offset into the region's PFN's array to start processing.
  * @pfn_count : Number of PFNs to process.
  * @pfns      : Pointer to an array of PFNs corresponding to the region.
  * @handler   : Callback function to handle each chunk of contiguous
@@ -183,6 +178,7 @@ static int mshv_region_process_range(struct mshv_region *region,
 				     unsigned long *pfns,
 				     pfn_handler_t handler)
 {
+	u64 gfn = region->start_gfn + pfn_offset;
 	u64 end;
 	long ret;
 
@@ -196,7 +192,7 @@ static int mshv_region_process_range(struct mshv_region *region,
 		bool huge_page;
 		long count;
 
-		count = mshv_region_chunk_size(region, pfn_offset, pfn_count,
+		count = mshv_region_chunk_size(gfn, pfn_count,
 					       pfns, &huge_page);
 		if (count < 0)
 			return count;
@@ -208,6 +204,8 @@ static int mshv_region_process_range(struct mshv_region *region,
 
 		pfn_offset += count;
 		pfn_count -= count;
+		pfns += count;
+		gfn += count;
 	}
 
 	return 0;
@@ -274,15 +272,14 @@ static int mshv_region_chunk_share(struct mshv_region *region,
 				   unsigned long *pfns,
 				   bool huge_page)
 {
-	if (!mshv_pfn_valid(pfns[pfn_offset]))
+	if (!mshv_pfn_valid(pfns[0]))
 		return -EINVAL;
 
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      pfns + pfn_offset,
-					      pfn_count,
+					      pfns, pfn_count,
 					      HV_MAP_GPA_READABLE |
 					      HV_MAP_GPA_WRITABLE,
 					      flags, true);
@@ -304,15 +301,15 @@ static int mshv_region_chunk_unshare(struct mshv_region *region,
 				     unsigned long *pfns,
 				     bool huge_page)
 {
-	if (!mshv_pfn_valid(pfns[pfn_offset]))
+	if (!mshv_pfn_valid(pfns[0]))
 		return -EINVAL;
 
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      pfns + pfn_offset,
-					      pfn_count, 0,
+					      pfns, pfn_count,
+					      0,
 					      flags, false);
 }
 
@@ -337,7 +334,7 @@ static int mshv_region_chunk_remap(struct mshv_region *region,
 	 * hypervisor track dirty pages, enabling precopy live
 	 * migration.
 	 */
-	if (!mshv_pfn_valid(pfns[pfn_offset]))
+	if (!mshv_pfn_valid(pfns[0]))
 		flags = HV_MAP_GPA_NO_ACCESS;
 
 	if (huge_page)
@@ -346,7 +343,7 @@ static int mshv_region_chunk_remap(struct mshv_region *region,
 	return hv_call_map_ram_pfns(region->partition->pt_id,
 				    region->start_gfn + pfn_offset,
 				    pfn_count, flags,
-				    pfns + pfn_offset);
+				    pfns);
 }
 
 static int mshv_region_remap_pfns(struct mshv_region *region,
@@ -682,7 +679,7 @@ static int mshv_region_collect_and_map(struct mshv_region *region,
 
 	ret = mshv_region_remap_pfns(region, region->hv_map_flags,
 				     pfn_offset, pfn_count,
-				     region->mreg_pfns);
+				     region->mreg_pfns + pfn_offset);
 
 	mutex_unlock(&region->mreg_mutex);
 out:



