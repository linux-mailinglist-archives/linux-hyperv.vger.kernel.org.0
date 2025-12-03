Return-Path: <linux-hyperv+bounces-7931-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44424CA13DE
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 20:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FADC31FC4BB
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBB63081DF;
	Wed,  3 Dec 2025 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ok3KvYj0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB37C316195;
	Wed,  3 Dec 2025 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786253; cv=none; b=SSVrI/XK3qUPoV7QRDImOWS9VcWu7Tm9dlvHueTwS71kf5usSjlcGQ04kcho3PeAi3iR6iO325eUAYfnseJXin0WW1/Y57hc5PEHu+DdJl89n9kksMhxBk5srBRPKR0pp4VqDVznAPTNSI8V6pfXKIMUyPgj8r+5p1FTzB1uUIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786253; c=relaxed/simple;
	bh=vnAuwEOaHlpbLIbguuxxKEI6yoMxqxEDqZvyngFfVW4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGscPJmXjuI+8pl0/GwN4ITKBVqWvpdFNI8+1AhKknIdazTrdvGDFoW23fJGtkuJTc3mJX4ZHHilktW+Omp3hLrfhq8xdj+0n8f/gpMJdnkE0pEUtLLmd+2eyXVvSeUBK6QkZx1jTdoqKpNL4C6UESLBiEhLQiyKHM1uQiIMfw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ok3KvYj0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 119392120E8D;
	Wed,  3 Dec 2025 10:24:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 119392120E8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764786250;
	bh=AWXInAY7BnaCM/dqEX03IsAr9zidJyuQPLAkb1SDm20=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ok3KvYj0oAycXMJp1EOz6qQ7/ZByLqlYwGuq5M3K7TWQKLEi4KLaBOdXore4VnkuT
	 mG5OJtmbqdq8vyvKDvcxWiNCEYSpMZs8SxkgYyDWiufb7TodC1gcfk6TKAuEyYmf7Q
	 j9V8J3htNLQ0Dzu1yJOIWM5x19k828y3TFbDYBd8=
Subject: [PATCH v8 2/6] Drivers: hv: Centralize guest memory region
 destruction
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Dec 2025 18:24:09 +0000
Message-ID: 
 <176478624996.114132.6173428647993129125.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176478581828.114132.13305536829966527782.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176478581828.114132.13305536829966527782.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_root_main.c |   65 ++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index fec82619684a..ec18984c3f2d 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1356,13 +1356,42 @@ mshv_map_user_memory(struct mshv_partition *partition,
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
@@ -1377,18 +1406,8 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
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
 
@@ -1724,8 +1743,8 @@ static void destroy_partition(struct mshv_partition *partition)
 {
 	struct mshv_vp *vp;
 	struct mshv_mem_region *region;
-	int i, ret;
 	struct hlist_node *n;
+	int i;
 
 	if (refcount_read(&partition->pt_ref_count)) {
 		pt_err(partition,
@@ -1789,25 +1808,9 @@ static void destroy_partition(struct mshv_partition *partition)
 
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



