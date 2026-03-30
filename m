Return-Path: <linux-hyperv+bounces-9835-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHewHArYymmWAgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9835-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:07:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE69D360CF2
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6643E305309E
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE8839A7F2;
	Mon, 30 Mar 2026 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RTags1iq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB98D395DB4;
	Mon, 30 Mar 2026 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901066; cv=none; b=QvKmNs1L2+CYnOsKnvTqe8pbEow07OpJzyA7F+xsAUlB5lZ+Bn2CShyr8DAJo0vvJvXCLTuJJOW/via5OIzaHgJZshat/e57RdfvADoJ/uYUQPBNonBO/Cuz7u3k38ruBGG23wWzbR9IM/OqFU3S5cZSC/Bu7fASNF6R2e1TSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901066; c=relaxed/simple;
	bh=D9V9ZCKUwx4ZqH8DA6Fm6+a+k8au7kF0svfQTgFY4LY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvO1/nwCYaCSm9OkEVjIJQuvAJmrleimtqyoChDni/WazCuNtB/Z9Gvg+N2QbynqmJ0wdLvJS78uDt0o5pXYwns4M/XlRMkvG+HieZ/+t4V6m+EL8pg8mPKeOPlVPlzp6iy4XELbgX+ezqeJJdQ6OKkLg6wuDD16n8NFpjkEL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RTags1iq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 78CA720B703B;
	Mon, 30 Mar 2026 13:04:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 78CA720B703B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774901064;
	bh=5tlBmdP/wyRPPwW+dbNMJcgOcQ2EBE6MOh2nzbeCK54=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RTags1iqrTQb6RPoHcRL/z5qCy17FW/affzls4tUzbKfdXUsOhR6FI/nlwInxuyxt
	 9XzMfL0foIIEfW8ljgmpKDHtZJeqQhWrBTd0Q7+vyoFhtBQ1PJA3a6pTBwd7JhxY1m
	 Z5RERo9VJXroVg3/2VzwfV5yIXkhLW5B0bfbweM0=
Subject: [PATCH 2/7] mshv: Add support to address range holes remapping
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 30 Mar 2026 20:04:24 +0000
Message-ID: 
 <177490106397.81669.13650500489059864399.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	TAGGED_FROM(0.00)[bounces-9835-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: BE69D360CF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Consolidate memory region processing to handle both valid and invalid PFNs
uniformly. This eliminates code duplication across remap, unmap, share, and
unshare operations by using a common range processing interface.

Holes are now remapped with no-access permissions to enable
hypervisor dirty page tracking for precopy live migration.

This refactoring is a precursor to an upcoming change that will map
present pages in movable regions upon region creation, requiring
consistent handling of both mapped and unmapped ranges.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |  108 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index b1a707d16c07..ed9c55841140 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -119,6 +119,57 @@ static long mshv_region_process_pfns(struct mshv_mem_region *region,
 	return count;
 }
 
+/**
+ * mshv_region_process_hole - Handle a hole (invalid PFNs) in a memory
+ *                            region
+ * @region    : Memory region containing the hole
+ * @flags     : Flags to pass to the handler function
+ * @pfn_offset: Starting PFN offset within the region
+ * @pfn_count : Number of PFNs in the hole
+ * @handler   : Callback function to invoke for the hole
+ *
+ * Invokes the handler function for a contiguous hole with the specified
+ * parameters.
+ *
+ * Return: Number of PFNs handled, or negative error code.
+ */
+static long mshv_region_process_hole(struct mshv_mem_region *region,
+				     u32 flags,
+				     u64 pfn_offset, u64 pfn_count,
+				     int (*handler)(struct mshv_mem_region *region,
+						    u32 flags,
+						    u64 pfn_offset,
+						    u64 pfn_count,
+						    bool huge_page))
+{
+	long ret;
+
+	ret = handler(region, flags, pfn_offset, pfn_count, 0);
+	if (ret)
+		return ret;
+
+	return pfn_count;
+}
+
+static long mshv_region_process_chunk(struct mshv_mem_region *region,
+				      u32 flags,
+				      u64 pfn_offset, u64 pfn_count,
+				      int (*handler)(struct mshv_mem_region *region,
+						     u32 flags,
+						     u64 pfn_offset,
+						     u64 pfn_count,
+						     bool huge_page))
+{
+	if (pfn_valid(region->mreg_pfns[pfn_offset]))
+		return mshv_region_process_pfns(region, flags,
+				pfn_offset, pfn_count,
+				handler);
+	else
+		return mshv_region_process_hole(region, flags,
+				pfn_offset, pfn_count,
+				handler);
+}
+
 /**
  * mshv_region_process_range - Processes a range of PFNs in a region.
  * @region    : Pointer to the memory region structure.
@@ -146,33 +197,47 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 						    u64 pfn_count,
 						    bool huge_page))
 {
-	u64 pfn_end;
+	u64 start, end;
 	long ret;
 
-	if (check_add_overflow(pfn_offset, pfn_count, &pfn_end))
+	if (!pfn_count)
+		return 0;
+
+	if (check_add_overflow(pfn_offset, pfn_count, &end))
 		return -EOVERFLOW;
 
-	if (pfn_end > region->nr_pfns)
+	if (end > region->nr_pfns)
 		return -EINVAL;
 
-	while (pfn_count) {
-		/* Skip non-present pages */
-		if (!pfn_valid(region->mreg_pfns[pfn_offset])) {
-			pfn_offset++;
-			pfn_count--;
+	start = pfn_offset;
+	end = pfn_offset + 1;
+
+	while (end < pfn_offset + pfn_count) {
+		/*
+		 * Accumulate contiguous pfns with the same validity
+		 * (valid or not).
+		 */
+		if (pfn_valid(region->mreg_pfns[start]) ==
+		    pfn_valid(region->mreg_pfns[end])) {
+			end++;
 			continue;
 		}
 
-		ret = mshv_region_process_pfns(region, flags,
-					       pfn_offset, pfn_count,
-					       handler);
+		ret = mshv_region_process_chunk(region, flags,
+						start, end - start,
+						handler);
 		if (ret < 0)
 			return ret;
 
-		pfn_offset += ret;
-		pfn_count -= ret;
+		start += ret;
 	}
 
+	ret = mshv_region_process_chunk(region, flags,
+					start, end - start,
+					handler);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -208,6 +273,9 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
 {
+	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
+		return -EINVAL;
+
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
@@ -233,6 +301,9 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
 				     u64 pfn_offset, u64 pfn_count,
 				     bool huge_page)
 {
+	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
+		return -EINVAL;
+
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
@@ -256,6 +327,14 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
 {
+	/*
+	 * Remap missing pages with no access to let the
+	 * hypervisor track dirty pages, enabling precopy live
+	 * migration.
+	 */
+	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
+		flags = HV_MAP_GPA_NO_ACCESS;
+
 	if (huge_page)
 		flags |= HV_MAP_GPA_LARGE_PAGE;
 
@@ -357,6 +436,9 @@ static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
 {
+	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
+		return 0;
+
 	if (huge_page)
 		flags |= HV_UNMAP_GPA_LARGE_PAGE;
 



