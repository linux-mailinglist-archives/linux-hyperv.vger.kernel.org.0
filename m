Return-Path: <linux-hyperv+bounces-6983-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C16B9C473
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Sep 2025 23:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62A1326A05
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Sep 2025 21:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D89728935A;
	Wed, 24 Sep 2025 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V+VV+96D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB36F28852E;
	Wed, 24 Sep 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749480; cv=none; b=Xg1gKDNaIiG3WE6pMwAjQ8GCp1vM3XY91n/E1FCBYNwsx3Tn/UMRAlRwAetbnk52DXh4V2qhDDoEGP4LEZeRmHsU1qi07E1ALfwNIrOEX9FitDv8luU+CWrdQ1ZiFn3Iq1mA1TETZnZqWck2XyLHttACZ1GJYR/Y30KxHDU5XwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749480; c=relaxed/simple;
	bh=rdMBWUyMPaNB6qmDw7mkFLQ1Ud//oaECHGMTRV7fWhc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKvpIQG0rVCfFVbmjdrsVpMCRCXAzbiOWhHTvRUtf51dpER1wUGmWeuW8AoMv4LHvtAmY661nM+f/Tus7mp8iKlRSD3b2Y7SDAWLD17bqG9TW5a8eprKN3sAEbJglZtKXufUHrnCYVSEwYxT9Sr/2bmeUvaUupLukllcySo/hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V+VV+96D; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 98B84211AD2C;
	Wed, 24 Sep 2025 14:31:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98B84211AD2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758749477;
	bh=c2lUUjlFGg/YGyEslb/0bHCo+517vdVQeNdMwXmeHjU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=V+VV+96DBGHU82EWMSzSYCaVr15tJajAX9MSZ+1nLRxWsBzSXxaFa52vdMk5jcKc0
	 IJznt3GpReBy3oElIDL8oySG+h1KhJZszM6f1LhrXUQtFVF02n5+/ddJUPti6IRqGj
	 K884v7jLp7lkmF1vEJy18cIwUiBmH4BsqPqEOyqs=
Subject: [PATCH 2/3] Drivers: hv: Centralize guest memory region destruction
 in helper
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 24 Sep 2025 21:31:17 +0000
Message-ID: 
 <175874947750.157998.7004962396456082421.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This is a precursor and cleanup patch.

- Introduce mshv_partition_destroy_region() to encapsulate memory region
  cleanup, including:
  - Removing the region from the partition's list
  - Regaining access for encrypted partitions
  - Unmapping only mapped pages for efficiency
  - Evicting and freeing the region

- Update mshv_unmap_user_memory() to call mshv_partition_destroy_region()
  instead of duplicating cleanup logic.

- Update destroy_partition() to use mshv_partition_destroy_region() for
  all regions, removing the previous inlined cleanup loop.

These changes eliminate code duplication, ensure consistent cleanup, and
improve maintainability for both unmap and partition destruction paths.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   83 ++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 5ed6bce334417..c0f6023e459c2 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1386,13 +1386,59 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	return ret;
 }
 
+static void mshv_partition_destroy_region(struct mshv_mem_region *region)
+{
+	struct mshv_partition *partition = region->partition;
+	u64 page_offset, page_count;
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
+	/*
+	 * Unmap only the mapped pages to optimize performance,
+	 * especially for large memory regions.
+	 */
+	for (page_offset = 0; page_offset < region->nr_pages; page_offset += page_count) {
+		page_count = 1;
+		if (!region->pages[page_offset])
+			continue;
+
+		for (; page_count < region->nr_pages - page_offset; page_count++) {
+			if (!region->pages[page_offset + page_count])
+				break;
+		}
+
+		/* ignore unmap failures and continue as process may be exiting */
+		hv_call_unmap_gpa_pages(partition->pt_id,
+					region->start_gfn + page_offset,
+					page_count, unmap_flags);
+	}
+
+	mshv_region_evict(region);
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
@@ -1407,18 +1453,7 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	    region->nr_pages != HVPFN_DOWN(mem.size))
 		return -EINVAL;
 
-	hlist_del(&region->hnode);
-
-	if (region->flags.large_pages)
-		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
-
-	/* ignore unmap failures and continue as process may be exiting */
-	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
-				region->nr_pages, unmap_flags);
-
-	mshv_region_evict(region);
-
-	vfree(region);
+	mshv_partition_destroy_region(region);
 	return 0;
 }
 
@@ -1754,8 +1789,8 @@ static void destroy_partition(struct mshv_partition *partition)
 {
 	struct mshv_vp *vp;
 	struct mshv_mem_region *region;
-	int i, ret;
 	struct hlist_node *n;
+	int i;
 
 	if (refcount_read(&partition->pt_ref_count)) {
 		pt_err(partition,
@@ -1815,25 +1850,9 @@ static void destroy_partition(struct mshv_partition *partition)
 
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
-		mshv_region_evict(region);
-
-		vfree(region);
-	}
+				  hnode)
+		mshv_partition_destroy_region(region);
 
 	/* Withdraw and free all pages we deposited */
 	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);



