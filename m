Return-Path: <linux-hyperv+bounces-6990-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF10BA4999
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 18:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D0E7A9FE5
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E00A25A34F;
	Fri, 26 Sep 2025 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k6czJhbJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24ED13B58C;
	Fri, 26 Sep 2025 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903805; cv=none; b=Hy+7RzKuWUbNxMHKBWhDHMHXmif0q0nHi2qxNvzK+jGwZMmP30FS7q+0PR1dK/6Exy0ZGvd798VJD+ExmJRe1k1SUdblrdGB1da4CiNZX8JwNtdpLXZj6T+3BVaCo9W/+VH90n8LVLcAArhBCGFdy+Fr0eFnClEmkL/AySmA/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903805; c=relaxed/simple;
	bh=rYuclI6H2pgLBJCrCodRbO4Nwzob+vO7dbysl+fbkgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GjWb+6RpbBw+gat8kCrIdY/MfalB55CoFpvvS7YMbc5AeKNuAoX3FIlQX7ooxn0d5LuMT2/zBXNfq7cxxVdcjAS1pBmESNKEM5FbN5nD6d0NA0RtcbnrL5/RpEMm2TU37DDRhr+sotaZjMCtDLmI8sLaJTHJ+IIHCw05XZy0fD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k6czJhbJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id CD5392124F6D; Fri, 26 Sep 2025 09:23:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD5392124F6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758903797;
	bh=Wjdr5YIOLFpVlaG0LHMyJq1K9oNDoFxiKDO4QpFJ3Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6czJhbJdCn9sBbY0xXx8d4dlvUpj/qTRWxXMvT2QwSVFVX7tkaApoDwjMdFDsm+C
	 gfzXPs4rBxn+s5CtOLEq1HdGXo1pyVXhuTf5/gNmXgfZU5PGBhu1D20/uMa6HI1G1b
	 og+hs/6Qo3oGVgGxcvGRbyjuZaEim3FwxWMHAMc4=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com,
	anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com,
	skinsburskii@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v4 1/5] mshv: Only map vp->vp_stats_pages if on root scheduler
Date: Fri, 26 Sep 2025 09:23:11 -0700
Message-Id: <1758903795-18636-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This mapping is only used for checking if the dispatch thread is
blocked. This is only relevant for the root scheduler, so check the
scheduler type to determine whether to map/unmap these pages, instead of
the current check, which is incorrect.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e3b2bd417c46..24df47726363 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -934,7 +934,11 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 			goto unmap_register_page;
 	}
 
-	if (hv_parent_partition()) {
+	/*
+	 * This mapping of the stats page is for detecting if dispatch thread
+	 * is blocked - only relevant for root scheduler
+	 */
+	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT) {
 		ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
 					stats_pages);
 		if (ret)
@@ -963,7 +967,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
 		vp->vp_ghcb_page = page_to_virt(ghcb_page);
 
-	if (hv_parent_partition())
+	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
 
 	/*
@@ -986,7 +990,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 free_vp:
 	kfree(vp);
 unmap_stats_pages:
-	if (hv_parent_partition())
+	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
 unmap_ghcb_page:
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available()) {
@@ -1740,7 +1744,7 @@ static void destroy_partition(struct mshv_partition *partition)
 			if (!vp)
 				continue;
 
-			if (hv_parent_partition())
+			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
 
 			if (vp->vp_register_page) {
-- 
2.34.1


