Return-Path: <linux-hyperv+bounces-8297-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F74D2166A
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 22:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD7330942C8
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 21:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A88537999D;
	Wed, 14 Jan 2026 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nyU+Qy9l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A9E376BE0;
	Wed, 14 Jan 2026 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426711; cv=none; b=L6t+I0iL6/9yAlTFQ6VH5VJYfN8FRnWJoVVWsONFvJRTb1R613Q5NCoxhTKFTO5wbT7LAtD8nUjZ+pphqjk0k8Xc49Togj6A8w6QHdUtkQ+E3UWE5zmIQiHSSYFxKmm9jmmCvjNUNK74MNaZyiWsUgCn1pAWLCWAsCwF7NIZbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426711; c=relaxed/simple;
	bh=2s9lIeHsh8FM2pqJpMLaCsT4ujORbpAFNEZIFfRk+Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9davsyvrJu7kPHq1tZwERtUBdY9rmLss1ydtOWNSZfmed3XYTfXu59fI/4nW0N0KfYDW6N9/qmWi8Q6W5CYhxmpJ3Y1edlIwIQf4Uc5oTXNZEYMqBPgZxObW5Jm8N61YvjfURb+vQYWQPTJCAl5OT1Qbuyf97O1rEqqE9N84Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nyU+Qy9l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id C717120B716F; Wed, 14 Jan 2026 13:38:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C717120B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768426687;
	bh=9BzoOa0wVBQB143I2PH957+WYxTAU/R3jKcGrn898r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyU+Qy9lRs3B3IHUrKpqNzFjQJVArUl1umBg9d/QhAZwQQytIDFmaItqwRHsmYZ0b
	 jmnIvbNr9nLYeRkJ4APZcrQAFxE48My5UlIU65d9LV83bF9AWtCTcvY5j/Mx3M/Tdf
	 MO0iU4MmSz1ildRA39dVGdjA80PSSnI9ufgILtXM=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v3 3/6] mshv: Improve mshv_vp_stats_map/unmap(), add them to mshv_root.h
Date: Wed, 14 Jan 2026 13:38:00 -0800
Message-ID: <20260114213803.143486-4-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260114213803.143486-1-nunodasneves@linux.microsoft.com>
References: <20260114213803.143486-1-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

These functions are currently only used to map child partition VP stats,
on root partition. However, they will soon be used on L1VH, and and also
used for mapping the host's own VP stats.

Introduce a helper is_l1vh_parent() to determine whether we are mapping
our own VP stats. In this case, do not attempt to map the PARENT area.
Note this is a different case than mapping PARENT on an older hypervisor
where it is not available at all, so must be handled separately.

On unmap, pass the stats pages since on L1VH the kernel allocates them
and they must be freed in hv_unmap_stats_page().

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root.h      | 10 ++++++
 drivers/hv/mshv_root_main.c | 61 ++++++++++++++++++++++++++-----------
 2 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 05ba1f716f9e..e4912b0618fa 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -254,6 +254,16 @@ struct mshv_partition *mshv_partition_get(struct mshv_partition *partition);
 void mshv_partition_put(struct mshv_partition *partition);
 struct mshv_partition *mshv_partition_find(u64 partition_id) __must_hold(RCU);
 
+static inline bool is_l1vh_parent(u64 partition_id)
+{
+	return hv_l1vh_partition() && (partition_id == HV_PARTITION_ID_SELF);
+}
+
+int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
+		      struct hv_stats_page **stats_pages);
+void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
+			 struct hv_stats_page **stats_pages);
+
 /* hypercalls */
 
 int hv_call_withdraw_memory(u64 count, int node, u64 partition_id);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index be5ad0fbfbee..faca3cc63e79 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -956,23 +956,36 @@ mshv_vp_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
-				struct hv_stats_page *stats_pages[])
+void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
+			 struct hv_stats_page *stats_pages[])
 {
 	union hv_stats_object_identity identity = {
 		.vp.partition_id = partition_id,
 		.vp.vp_index = vp_index,
 	};
+	int err;
 
 	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
-	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
-
-	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
-	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
+	err = hv_unmap_stats_page(HV_STATS_OBJECT_VP,
+				  stats_pages[HV_STATS_AREA_SELF],
+				  &identity);
+	if (err)
+		pr_err("%s: failed to unmap partition %llu vp %u self stats, err: %d\n",
+		       __func__, partition_id, vp_index, err);
+
+	if (stats_pages[HV_STATS_AREA_PARENT] != stats_pages[HV_STATS_AREA_SELF]) {
+		identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
+		err = hv_unmap_stats_page(HV_STATS_OBJECT_VP,
+					  stats_pages[HV_STATS_AREA_PARENT],
+					  &identity);
+		if (err)
+			pr_err("%s: failed to unmap partition %llu vp %u parent stats, err: %d\n",
+			       __func__, partition_id, vp_index, err);
+	}
 }
 
-static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
-			     struct hv_stats_page *stats_pages[])
+int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
+		      struct hv_stats_page *stats_pages[])
 {
 	union hv_stats_object_identity identity = {
 		.vp.partition_id = partition_id,
@@ -983,23 +996,37 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
 	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
 	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
 				&stats_pages[HV_STATS_AREA_SELF]);
-	if (err)
+	if (err) {
+		pr_err("%s: failed to map partition %llu vp %u self stats, err: %d\n",
+		       __func__, partition_id, vp_index, err);
 		return err;
+	}
 
-	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
-	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
-				&stats_pages[HV_STATS_AREA_PARENT]);
-	if (err)
-		goto unmap_self;
-
-	if (!stats_pages[HV_STATS_AREA_PARENT])
+	/*
+	 * L1VH partition cannot access its vp stats in parent area.
+	 */
+	if (is_l1vh_parent(partition_id)) {
 		stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
+	} else {
+		identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
+		err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
+					&stats_pages[HV_STATS_AREA_PARENT]);
+		if (err) {
+			pr_err("%s: failed to map partition %llu vp %u parent stats, err: %d\n",
+			       __func__, partition_id, vp_index, err);
+			goto unmap_self;
+		}
+		if (!stats_pages[HV_STATS_AREA_PARENT])
+			stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
+	}
 
 	return 0;
 
 unmap_self:
 	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
-	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
+	hv_unmap_stats_page(HV_STATS_OBJECT_VP,
+			    stats_pages[HV_STATS_AREA_SELF],
+			    &identity);
 	return err;
 }
 
-- 
2.34.1


