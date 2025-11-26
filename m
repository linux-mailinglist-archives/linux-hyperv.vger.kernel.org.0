Return-Path: <linux-hyperv+bounces-7827-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABCFC87C6C
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 03:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AC63B53BC
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 02:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FA730B51D;
	Wed, 26 Nov 2025 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kApT1uXW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983423090E1;
	Wed, 26 Nov 2025 02:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764122942; cv=none; b=UypVy8uvKRYxvsZ4JdIJ5iEYRZH4LaWKraG01N+ac0+DzZcetmqgxHm8MSlKg8/YlmU0fXAzDcKpAIquzrMdER3q3SJ8hFSdTIpNUb3XFw19BUN7G+DXdJC/Uqwwz1/nP2eiIa+Z3lo2fX1eB6qSAoiOyCHUm4qZFFUomYZO/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764122942; c=relaxed/simple;
	bh=RDGbzEBoOMrnjNpHnUaQm8dHgagT9ut0JqEL7gqQfuM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAw1ZjfhxiafHoErez3zqTdwcnZ6JMR4zlecBhHNBOSIVQA9H3y1JVaYznw9RTH14LUP679zNrGbYjKIU66SAkQfxw7SRrLjCb5eNyYtAHcMpudcjJRRHwzARLpmenM2ougud0JnF8pQzLaJ49hEpbZKvgY4EuwPZ1s7tha9NH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kApT1uXW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE21E2120EB5;
	Tue, 25 Nov 2025 18:08:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE21E2120EB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764122937;
	bh=AxHQy0NdP0igxTXDsgV08gm6QSSqa2U+xpEMCGlbxjk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kApT1uXW6Eez31CU7N/Hkp1xgZzpeyUhFAM16rT+6E4KPicIsoJBYpxOetv+dFAM1
	 kpfRLmjoOcwQCEfj4GOxl+alRVwM4rTkN67kfabb9Qt4Jijm1w8kSINQ+pxQjSUN9R
	 h8l9XIPTF2OuvSv5HBQSA68mh1YwxArUMvItL0s4=
Subject: [PATCH v7 2/7] Drivers: hv: Centralize guest memory region
 destruction
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Nov 2025 02:08:57 +0000
Message-ID: 
 <176412293764.447063.2221992979416155779.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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



