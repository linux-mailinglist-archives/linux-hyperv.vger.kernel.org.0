Return-Path: <linux-hyperv+bounces-6658-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3140B3AFF0
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 02:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273FB18909D9
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 00:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A396219F40B;
	Fri, 29 Aug 2025 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SXL+7lpM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451161A9FAA;
	Fri, 29 Aug 2025 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756428236; cv=none; b=PUN/YkmfY9iSspDxZMCl98sRzRaeqD0tBWTd/d8aTQF5f9sDjtjtvqBekCoEuxhxAcDxCZSTYi6Cegh7jjUQsnFe2GaRwsGGOL+aAsXsLKrI8RzYZ0i0VnyrMzcCX4EjbbtqxywBBTwdVE/oAgCjGa8TYBb0EZDTVNkUyJY2ZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756428236; c=relaxed/simple;
	bh=UQZe6BkuxfVeCNu2PuQKbfI1lUVs4Z/4kIYcu7Qcw28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OK1clQ/+tWKpTd9yVO+R2FG1xnavcHM5Gw22uJ63y7wBfGogLCaa3hI0iDIIAgTvsCjGWwFNVEZPIuf21zGfD1fUIjaMLDaBK0b3jmbNUT0LpomHqHpDj2Xob5SFu4K/N2CrjyrQKsekVatgwpfpWM/0/ZBxeYE1uq0ggmra5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SXL+7lpM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id E3D7A2110811; Thu, 28 Aug 2025 17:43:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3D7A2110811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756428234;
	bh=5FA0/6otOC2JcKtgyccpH+xtEmpjeHLMnlDwd40PRYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SXL+7lpMSvfPKcmCyputI/VDRAAFs17mLZs6AX0ltAHLMjoIoU11IwvQvkOAY5nQA
	 HvL/MBoD0fjWHgDRihXa7EpdvyKWt8O31DO7rTZoCJzLG6tqr5Qws01ux09McFQtFA
	 I0UjFBG+F1V9ktncScjv+9Id7RLAiRXKsP9D7c20=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH 1/6] mshv: Only map vp->vp_stats_pages if on root scheduler
Date: Thu, 28 Aug 2025 17:43:45 -0700
Message-Id: <1756428230-3599-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
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
---
 drivers/hv/mshv_root_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e4ee9beddaf5..bbdefe8a2e9c 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -987,7 +987,11 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
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
@@ -1016,7 +1020,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
 		vp->vp_ghcb_page = page_to_virt(ghcb_page);
 
-	if (hv_parent_partition())
+	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
 
 	/*
@@ -1039,7 +1043,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 free_vp:
 	kfree(vp);
 unmap_stats_pages:
-	if (hv_parent_partition())
+	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
 unmap_ghcb_page:
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available()) {
@@ -1793,7 +1797,7 @@ static void destroy_partition(struct mshv_partition *partition)
 			if (!vp)
 				continue;
 
-			if (hv_parent_partition())
+			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
 
 			if (vp->vp_register_page) {
-- 
2.34.1


