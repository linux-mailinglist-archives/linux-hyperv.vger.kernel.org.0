Return-Path: <linux-hyperv+bounces-9925-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP5KHXawzml+pQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9925-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:07:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7FD38CE2D
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2230302FF05
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64C6370D75;
	Thu,  2 Apr 2026 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VatxAZYR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EA5336897;
	Thu,  2 Apr 2026 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153078; cv=none; b=nNOxWWG6/34VIsQLW+Sm+TgKvMb9PgAN5H1lzj2DcTnyFPnI1jazyOwmODzRLhztIsua43nCcRDmfX09MDyKSkloCsU6bbGaxONuk6GZoetqsgytTHND4hpXSyK0QRjENsUfdIscqu9HDNCZkltBEvPQx4TiF7v9V9U6R0IcQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153078; c=relaxed/simple;
	bh=r0yy+k/tcXJeYf/4ZZMTV+jf6f7hsIl3hDOKRmSk9Ek=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ize43cMezdR6I/+6YP5hdGmrHX752LzJvBI4C2ulCIgCbhzFZDbpHAAcYJkqkzPEpK1p2pwZJyYvtKEOZA5Rhmct9XBFZJ9uVZvUvJsz1fAgDS3SljEJh8lSlOYCBMsCq0EI/Q9rEk1FnDvR98hRLOfk+xywHfJLJcdGuZfoJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VatxAZYR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id A8B8020B6F08;
	Thu,  2 Apr 2026 11:04:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8B8020B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775153076;
	bh=sQ2eYzb2cLjkYhJquZ4ji3LJgIEXX0VAa63NWlb5cTA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VatxAZYR67OucsCKBL92s9dew9LRuxcN1HFNhq10iD/YwGYhefsiqi8crq6NYbnI2
	 xj7o5c90a6N8X04fWQAUS+us4b/mBbUbdpGkJf1d8rucO9BmU1p/p4i6jVQfWLU3BC
	 /tSLjfAGv0rbwbRBTICg9Vp7jN/VN72dAgenpce4=
Subject: [PATCH v2 5/7] mshv: Pass pfns array explicitly through processing
 chain
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 18:04:36 +0000
Message-ID: 
 <177515307609.119822.2673027709755055401.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177515251087.119822.1940529498624181326.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177515251087.119822.1940529498624181326.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9925-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 6F7FD38CE2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current implementation relies on accessing region->pfns directly
within the pfn processing chain, making it difficult to use these
handlers with alternative pfn sources. This tight coupling limits
flexibility when processing pfns from different locations, such as
temporary arrays or external sources.

By threading the pfns pointer through the entire processing chain
(mshv_region_process_range, mshv_region_process_chunk, and all
handlers), we decouple the processing logic from the storage location.
This enables future enhancements like processing pfns from multiple
sources or implementing more sophisticated memory management strategies
without duplicating the core processing logic.

No functional change intended.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   61 +++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index a92381219758..120ce2588501 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -22,7 +22,7 @@
 
 typedef int (*pfn_handler_t)(struct mshv_region *region, u32 flags,
 			     u64 pfn_offset, u64 pfn_count,
-			     bool huge_page);
+			     unsigned long *pfns, bool huge_page);
 
 static const struct mmu_interval_notifier_ops mshv_region_mni_ops;
 
@@ -84,6 +84,7 @@ static int mshv_chunk_stride(struct page *page,
 static long mshv_region_process_pfns(struct mshv_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
+				     unsigned long *pfns,
 				     pfn_handler_t handler)
 {
 	u64 gfn = region->start_gfn + pfn_offset;
@@ -91,7 +92,7 @@ static long mshv_region_process_pfns(struct mshv_region *region,
 	unsigned long pfn;
 	int stride, ret;
 
-	pfn = region->mreg_pfns[pfn_offset];
+	pfn = pfns[pfn_offset];
 	if (!pfn_valid(pfn))
 		return -EINVAL;
 
@@ -101,7 +102,7 @@ static long mshv_region_process_pfns(struct mshv_region *region,
 
 	/* Start at stride since the first stride is validated */
 	for (count = stride; count < pfn_count ; count += stride) {
-		pfn = region->mreg_pfns[pfn_offset + count];
+		pfn = pfns[pfn_offset + count];
 
 		/* Break if current pfn is invalid */
 		if (!pfn_valid(pfn))
@@ -114,7 +115,7 @@ static long mshv_region_process_pfns(struct mshv_region *region,
 			break;
 	}
 
-	ret = handler(region, flags, pfn_offset, count, stride > 1);
+	ret = handler(region, flags, pfn_offset, count, pfns, stride > 1);
 	if (ret)
 		return ret;
 
@@ -138,11 +139,12 @@ static long mshv_region_process_pfns(struct mshv_region *region,
 static long mshv_region_process_hole(struct mshv_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
+				     unsigned long *pfns,
 				     pfn_handler_t handler)
 {
 	long ret;
 
-	ret = handler(region, flags, pfn_offset, pfn_count, 0);
+	ret = handler(region, flags, pfn_offset, pfn_count, pfns, 0);
 	if (ret)
 		return ret;
 
@@ -152,15 +154,16 @@ static long mshv_region_process_hole(struct mshv_region *region,
 static long mshv_region_process_chunk(struct mshv_region *region,
 				      u32 flags,
 				      u64 pfn_offset, u64 pfn_count,
+				      unsigned long *pfns,
 				      pfn_handler_t handler)
 {
-	if (pfn_valid(region->mreg_pfns[pfn_offset]))
+	if (pfn_valid(pfns[pfn_offset]))
 		return mshv_region_process_pfns(region, flags,
-				pfn_offset, pfn_count,
+				pfn_offset, pfn_count, pfns,
 				handler);
 	else
 		return mshv_region_process_hole(region, flags,
-				pfn_offset, pfn_count,
+				pfn_offset, pfn_count, pfns,
 				handler);
 }
 
@@ -170,12 +173,13 @@ static long mshv_region_process_chunk(struct mshv_region *region,
  * @flags     : Flags to pass to the handler.
  * @pfn_offset: Offset into the region's PFNs array to start processing.
  * @pfn_count : Number of PFNs to process.
+ * @pfns      : Pointer to an array of PFNs corresponding to the region.
  * @handler   : Callback function to handle each chunk of contiguous
  *              valid PFNs.
  *
- * Iterates over the specified range of PFNs in @region, skipping
- * invalid PFNs. For each contiguous chunk of valid PFNS, invokes
- * @handler via mshv_region_process_pfns.
+ * Iterates over the specified range of PFNs, skipping invalid PFNs.
+ * For each contiguous chunk of valid PFNS, invokes @handler via
+ * mshv_region_process_pfns.
  *
  * Note: The @handler callback must be able to handle PFNs backed by both
  * normal and huge pages.
@@ -185,6 +189,7 @@ static long mshv_region_process_chunk(struct mshv_region *region,
 static int mshv_region_process_range(struct mshv_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
+				     unsigned long *pfns,
 				     pfn_handler_t handler)
 {
 	u64 start, end;
@@ -207,15 +212,14 @@ static int mshv_region_process_range(struct mshv_region *region,
 		 * Accumulate contiguous pfns with the same validity
 		 * (valid or not).
 		 */
-		if (pfn_valid(region->mreg_pfns[start]) ==
-		    pfn_valid(region->mreg_pfns[end])) {
+		if (pfn_valid(pfns[start]) == pfn_valid(pfns[end])) {
 			end++;
 			continue;
 		}
 
 		ret = mshv_region_process_chunk(region, flags,
 						start, end - start,
-						handler);
+						pfns, handler);
 		if (ret < 0)
 			return ret;
 
@@ -224,7 +228,7 @@ static int mshv_region_process_range(struct mshv_region *region,
 
 	ret = mshv_region_process_chunk(region, flags,
 					start, end - start,
-					handler);
+					pfns, handler);
 	if (ret < 0)
 		return ret;
 
@@ -289,16 +293,17 @@ struct mshv_region *mshv_region_create(enum mshv_region_type type,
 static int mshv_region_chunk_share(struct mshv_region *region,
 				   u32 flags,
 				   u64 pfn_offset, u64 pfn_count,
+				   unsigned long *pfns,
 				   bool huge_page)
 {
-	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
+	if (!pfn_valid(pfns[pfn_offset]))
 		return -EINVAL;
 
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      region->mreg_pfns + pfn_offset,
+					      pfns + pfn_offset,
 					      pfn_count,
 					      HV_MAP_GPA_READABLE |
 					      HV_MAP_GPA_WRITABLE,
@@ -311,22 +316,24 @@ static int mshv_region_share(struct mshv_region *region)
 
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
-	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
+	if (!pfn_valid(pfns[pfn_offset]))
 		return -EINVAL;
 
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      region->mreg_pfns + pfn_offset,
+					      pfns + pfn_offset,
 					      pfn_count, 0,
 					      flags, false);
 }
@@ -337,12 +344,14 @@ static int mshv_region_unshare(struct mshv_region *region)
 
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
@@ -350,7 +359,7 @@ static int mshv_region_chunk_remap(struct mshv_region *region,
 	 * hypervisor track dirty pages, enabling precopy live
 	 * migration.
 	 */
-	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
+	if (!pfn_valid(pfns[pfn_offset]))
 		flags = HV_MAP_GPA_NO_ACCESS;
 
 	if (huge_page)
@@ -359,15 +368,17 @@ static int mshv_region_chunk_remap(struct mshv_region *region,
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
 
@@ -376,7 +387,8 @@ static int mshv_region_map(struct mshv_region *region)
 	u32 map_flags = region->hv_map_flags;
 
 	return mshv_region_remap_pfns(region, map_flags,
-				      0, region->nr_pfns);
+				      0, region->nr_pfns,
+				      region->mreg_pfns);
 }
 
 static void mshv_region_invalidate_pfns(struct mshv_region *region,
@@ -645,7 +657,8 @@ static int mshv_region_collect_and_map(struct mshv_region *region,
 	}
 
 	ret = mshv_region_remap_pfns(region, region->hv_map_flags,
-				     pfn_offset, pfn_count);
+				     pfn_offset, pfn_count,
+				     region->mreg_pfns);
 
 	mutex_unlock(&region->mreg_mutex);
 out:



