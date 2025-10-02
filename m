Return-Path: <linux-hyperv+bounces-7055-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D84BB48E6
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 18:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D90189A673
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607DF266580;
	Thu,  2 Oct 2025 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XSrkNOWm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C69265CB2;
	Thu,  2 Oct 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422958; cv=none; b=Cv/90aZOTtuOhS10HdUTKv1seXG3bL7DLVOiVTF12nd0f5Haw7mqBpx63wqGInGTYtPl/mYT0GBtQrAXCWjslRrwkPTWq0yvOlSgQb4Xpw/z/XzmL3MWe3vizadX/Hd9z+P3vC9LH1iTlWFezy00lq1ZWmUsn4IA9zhhsC8cFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422958; c=relaxed/simple;
	bh=/CUYiqLneEB8SVdIAIDWntRasBAKWHm9g70JaSvB7Xo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UF0oEEwO+KRWN+qgWr6Dsdq4T68JD7i2yS74RNikbEyZzgaR4Qn94Zn0MPnzAcp2A2CaN2SVr+HuZe6dPrK15XQC3E81UWAcW+pwj824BjHLA+gAMJr41XQE49KISm/dmljNibLYE3ipF4xU6FaqTL4ZS7aoZMcyDPcPtfIrEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XSrkNOWm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2346D2118E36;
	Thu,  2 Oct 2025 09:35:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2346D2118E36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759422956;
	bh=84AxFrk6EsrGllRsmWVnOHvvwP68K64ka8t91dF8cDw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XSrkNOWmaUrgjDTCVzzeqkDBmfN2n+tHe6+LMDNcriTmDlhTdiuQUBav4NMxKw1T/
	 G2znypfRfvfr92W3pxIr8aoIj01YBGTsNOtQGTXUYeKInMoZp1w9kwqTgHLbAnzzf7
	 rgG7sHZEHoJ4x5BO6u1uBw7a4IY0SSniW+bfaczI=
Subject: [PATCH v3 2/5] Drivers: hv: Centralize guest memory region
 destruction
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Oct 2025 16:35:56 +0000
Message-ID: 
 <175942295602.128138.2815274429892114903.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <175942263069.128138.16103948906881178993.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <175942263069.128138.16103948906881178993.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Centralize guest memory region destruction to prevent resource leaks and
inconsistent cleanup across unmap and partition destruction paths.

Unify region removal, encrypted partition access recovery, and region
invalidation to improve maintainability and reliability. Reduce code
duplication and make future updates less error-prone by encapsulating
cleanup logic in a single helper.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   65 ++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 29d0c2c9ae4c8..7ef66c43e1515 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1375,13 +1375,42 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	return ret;
 }
 
+static void mshv_partition_destroy_region(struct mshv_mem_region *region)
+{
+	struct mshv_partition *partition = region->partition;
+	u32 unmap_flags = 0;
+	int ret;
+
+	hlist_del(&region->hnode);
+
+	if (mshv_partition_encrypted(partition)) {
+		ret = mshv_partition_region_share(region);
+		if (ret) {
+			pt_err(partition,
+			       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
+			       ret);
+			return;
+		}
+	}
+
+	if (region->flags.large_pages)
+		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
+
+	/* ignore unmap failures and continue as process may be exiting */
+	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
+				region->nr_pages, unmap_flags);
+
+	mshv_region_invalidate(region);
+
+	vfree(region);
+}
+
 /* Called for unmapping both the guest ram and the mmio space */
 static long
 mshv_unmap_user_memory(struct mshv_partition *partition,
 		       struct mshv_user_mem_region mem)
 {
 	struct mshv_mem_region *region;
-	u32 unmap_flags = 0;
 
 	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
 		return -EINVAL;
@@ -1396,18 +1425,8 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	    region->nr_pages != HVPFN_DOWN(mem.size))
 		return -EINVAL;
 
-	hlist_del(&region->hnode);
+	mshv_partition_destroy_region(region);
 
-	if (region->flags.large_pages)
-		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
-
-	/* ignore unmap failures and continue as process may be exiting */
-	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
-				region->nr_pages, unmap_flags);
-
-	mshv_region_invalidate(region);
-
-	vfree(region);
 	return 0;
 }
 
@@ -1743,8 +1762,8 @@ static void destroy_partition(struct mshv_partition *partition)
 {
 	struct mshv_vp *vp;
 	struct mshv_mem_region *region;
-	int i, ret;
 	struct hlist_node *n;
+	int i;
 
 	if (refcount_read(&partition->pt_ref_count)) {
 		pt_err(partition,
@@ -1804,25 +1823,9 @@ static void destroy_partition(struct mshv_partition *partition)
 
 	remove_partition(partition);
 
-	/* Remove regions, regain access to the memory and unpin the pages */
 	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
-				  hnode) {
-		hlist_del(&region->hnode);
-
-		if (mshv_partition_encrypted(partition)) {
-			ret = mshv_partition_region_share(region);
-			if (ret) {
-				pt_err(partition,
-				       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
-				      ret);
-				return;
-			}
-		}
-
-		mshv_region_invalidate(region);
-
-		vfree(region);
-	}
+				  hnode)
+		mshv_partition_destroy_region(region);
 
 	/* Withdraw and free all pages we deposited */
 	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);



