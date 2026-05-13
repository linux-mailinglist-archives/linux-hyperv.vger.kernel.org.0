Return-Path: <linux-hyperv+bounces-10864-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI07JoLKBGp2OwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10864-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:01:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0544F539787
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1828230AFD1E
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F973AE1A5;
	Wed, 13 May 2026 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Huo7SzB6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD243A3E7F;
	Wed, 13 May 2026 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698499; cv=none; b=Hiept5emX7TIS5uPMOQlLNirbl/4NRuVx8hqmOVIIYTw1+lRVSBUgO/7dfQ2z0mrU/7wRRI8w/uXifLKCYhRlqlaoQCtMDC9WGrONsY7iNDyO70qqfJHtQYIucpz5zeXUu068DaOmHGv7Yo4NOQVicJj3nHE7cSRjc0Vx9Qfto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698499; c=relaxed/simple;
	bh=h0lmQHlD51j/A7ZB58MPFWt71AJyK//quc95lpqohQA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXfrt/Tv8jtV0+zU9HMq4SSnXXCOG+Zf0Po6LUD26YKkr7BdxE3jAOn5Z32lgRLkU0mVnked504xjge0Y+0ZKyCOLaBwaQOr469MoP8J6oYfZCqFXVeDNCUrzv2DvkAQ/UOKEe+3X8JWRXH52YrqtS7VLh3KXiGor/q7hkPuNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Huo7SzB6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id D7AD120B7166;
	Wed, 13 May 2026 11:54:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7AD120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698494;
	bh=G7u+kaWdNFmBa0HSOONDyGLXiCVn0X9HTJqwXaZrKwg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Huo7SzB6+qomedTpNPbJsN9uXJpuy3SN7zKZx7UaZafX10OT8lTkcbtej16aKMdcB
	 eqDr+WuanLBPX4CqUiztdjKXUbkCuNlzVBaQdSaX4Z3dBoIjJiGjFcJxElEvIuy2M9
	 g35ZkF7zZEEdYhPkd3C3gOVcIoqBAMlvw4KyihO8=
Subject: [PATCH v4 4/6] mshv: Pass pfns array explicitly through processing
 chain
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:54:57 +0000
Message-ID: 
 <177869849752.19379.6746945702976892314.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: 0544F539787
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
	TAGGED_FROM(0.00)[bounces-10864-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The current implementation relies on accessing region->pfns directly
within the pfn processing chain, making it difficult to use these
handlers with alternative pfn sources. This tight coupling limits
flexibility when processing pfns from different locations, such as
temporary arrays or external sources.

By threading the pfns pointer through the entire processing chain
(mshv_region_process_range, mshv_region_chunk_size, and all
handlers), we decouple the processing logic from the storage location.
This enables future enhancements like processing pfns from multiple
sources or implementing more sophisticated memory management strategies
without duplicating the core processing logic.

No functional change intended.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   50 +++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index cb42ee49c2e2f..87204b2b48290 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -31,6 +31,10 @@
 typedef int (*gfn_handler_t)(struct mshv_region *region,
 			      u64 gfn, u64 count, u32 flags);
 
+typedef int (*pfn_handler_t)(struct mshv_region *region, u32 flags,
+			     u64 pfn_offset, u64 pfn_count,
+			     unsigned long *pfns, bool huge_page);
+
 static const struct mmu_interval_notifier_ops mshv_region_mni_ops;
 
 static inline bool mshv_pfn_valid(unsigned long pfn)
@@ -98,6 +102,7 @@ static int mshv_chunk_stride(unsigned long pfn, u64 gfn, u64 pfn_count)
  * @region    : Memory region whose PFN array is being walked.
  * @pfn_offset: Offset into region->mreg_pfns at which to start.
  * @pfn_count : Upper bound on the run length.
+ * @pfns      : Pointer to an array of PFNs corresponding to the region.
  * @huge_page : Out-parameter set to true if the run may be dispatched
  *              as a 2 MiB chunk; false for 4 KiB-stride dispatch.
  *
@@ -114,12 +119,13 @@ static int mshv_chunk_stride(unsigned long pfn, u64 gfn, u64 pfn_count)
  */
 static long mshv_region_chunk_size(struct mshv_region *region,
 				   u64 pfn_offset, u64 pfn_count,
-				   bool *huge_page)
+				   unsigned long *pfns, bool *huge_page)
 {
-	unsigned long *pfns = region->mreg_pfns + pfn_offset;
 	u64 gfn = region->start_gfn + pfn_offset;
 	u64 count = 0, stride;
 
+	pfns += pfn_offset;
+
 	if (!mshv_pfn_valid(pfns[0])) {
 		for (count = 1; count < pfn_count; count++) {
 			if (mshv_pfn_valid(pfns[count]))
@@ -158,6 +164,7 @@ static long mshv_region_chunk_size(struct mshv_region *region,
  * @flags     : Flags to pass to the handler.
  * @pfn_offset: Offset into the region's PFNs array to start processing.
  * @pfn_count : Number of PFNs to process.
+ * @pfns      : Pointer to an array of PFNs corresponding to the region.
  * @handler   : Callback function to handle each chunk of contiguous
  *              valid PFNs.
  *
@@ -173,11 +180,8 @@ static long mshv_region_chunk_size(struct mshv_region *region,
 static int mshv_region_process_range(struct mshv_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
-				     int (*handler)(struct mshv_region *region,
-						    u32 flags,
-						    u64 pfn_offset,
-						    u64 pfn_count,
-						    bool huge_page))
+				     unsigned long *pfns,
+				     pfn_handler_t handler)
 {
 	u64 end;
 	long ret;
@@ -193,11 +197,12 @@ static int mshv_region_process_range(struct mshv_region *region,
 		long count;
 
 		count = mshv_region_chunk_size(region, pfn_offset, pfn_count,
-					       &huge_page);
+					       pfns, &huge_page);
 		if (count < 0)
 			return count;
 
-		ret = handler(region, flags, pfn_offset, count, huge_page);
+		ret = handler(region, flags, pfn_offset, count, pfns,
+			      huge_page);
 		if (ret < 0)
 			return ret;
 
@@ -266,16 +271,17 @@ struct mshv_region *mshv_region_create(struct mshv_partition *partition,
 static int mshv_region_chunk_share(struct mshv_region *region,
 				   u32 flags,
 				   u64 pfn_offset, u64 pfn_count,
+				   unsigned long *pfns,
 				   bool huge_page)
 {
-	if (!mshv_pfn_valid(region->mreg_pfns[pfn_offset]))
+	if (!mshv_pfn_valid(pfns[pfn_offset]))
 		return -EINVAL;
 
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      region->mreg_pfns + pfn_offset,
+					      pfns + pfn_offset,
 					      pfn_count,
 					      HV_MAP_GPA_READABLE |
 					      HV_MAP_GPA_WRITABLE,
@@ -288,22 +294,24 @@ static int mshv_region_share(struct mshv_region *region)
 
 	return mshv_region_process_range(region, flags,
 					 0, region->nr_pfns,
+					 region->mreg_pfns,
 					 mshv_region_chunk_share);
 }
 
 static int mshv_region_chunk_unshare(struct mshv_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
+				     unsigned long *pfns,
 				     bool huge_page)
 {
-	if (!mshv_pfn_valid(region->mreg_pfns[pfn_offset]))
+	if (!mshv_pfn_valid(pfns[pfn_offset]))
 		return -EINVAL;
 
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      region->mreg_pfns + pfn_offset,
+					      pfns + pfn_offset,
 					      pfn_count, 0,
 					      flags, false);
 }
@@ -314,12 +322,14 @@ static int mshv_region_unshare(struct mshv_region *region)
 
 	return mshv_region_process_range(region, flags,
 					 0, region->nr_pfns,
+					 region->mreg_pfns,
 					 mshv_region_chunk_unshare);
 }
 
 static int mshv_region_chunk_remap(struct mshv_region *region,
 				   u32 flags,
 				   u64 pfn_offset, u64 pfn_count,
+				   unsigned long *pfns,
 				   bool huge_page)
 {
 	/*
@@ -327,7 +337,7 @@ static int mshv_region_chunk_remap(struct mshv_region *region,
 	 * hypervisor track dirty pages, enabling precopy live
 	 * migration.
 	 */
-	if (!mshv_pfn_valid(region->mreg_pfns[pfn_offset]))
+	if (!mshv_pfn_valid(pfns[pfn_offset]))
 		flags = HV_MAP_GPA_NO_ACCESS;
 
 	if (huge_page)
@@ -336,15 +346,17 @@ static int mshv_region_chunk_remap(struct mshv_region *region,
 	return hv_call_map_ram_pfns(region->partition->pt_id,
 				    region->start_gfn + pfn_offset,
 				    pfn_count, flags,
-				    region->mreg_pfns + pfn_offset);
+				    pfns + pfn_offset);
 }
 
 static int mshv_region_remap_pfns(struct mshv_region *region,
 				  u32 map_flags,
-				  u64 pfn_offset, u64 pfn_count)
+				  u64 pfn_offset, u64 pfn_count,
+				  unsigned long *pfns)
 {
 	return mshv_region_process_range(region, map_flags,
 					 pfn_offset, pfn_count,
+					 pfns,
 					 mshv_region_chunk_remap);
 }
 
@@ -353,7 +365,8 @@ static int mshv_region_map(struct mshv_region *region)
 	u32 map_flags = region->hv_map_flags;
 
 	return mshv_region_remap_pfns(region, map_flags,
-				      0, region->nr_pfns);
+				      0, region->nr_pfns,
+				      region->mreg_pfns);
 }
 
 static void mshv_region_invalidate_pfns(struct mshv_region *region,
@@ -668,7 +681,8 @@ static int mshv_region_collect_and_map(struct mshv_region *region,
 	}
 
 	ret = mshv_region_remap_pfns(region, region->hv_map_flags,
-				     pfn_offset, pfn_count);
+				     pfn_offset, pfn_count,
+				     region->mreg_pfns);
 
 	mutex_unlock(&region->mreg_mutex);
 out:



