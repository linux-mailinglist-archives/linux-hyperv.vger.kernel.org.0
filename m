Return-Path: <linux-hyperv+bounces-6659-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A88D9B3AFF2
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 02:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717FD16BDC3
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 00:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C081D5CDE;
	Fri, 29 Aug 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mUcZ7Nrn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C9D190477;
	Fri, 29 Aug 2025 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756428237; cv=none; b=grhsMbPbxZtiNMvcEChFyr3ZuYWfbiIbVuTJLeEYzzjkowhj/J6OHsHWpO9hofAdTvXCTRmAe9w/WrsGfRh3x6yObmVaAsRPJzELr7tcrGT1XGTlH2uvhGTG+lpLbx4PUNnV9ED8kHBt0EqQrYsxS7KMKZymY9aIzGRMlCnLU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756428237; c=relaxed/simple;
	bh=n2ZLL7BuPP8iw/WYrr7IxLhVe6bEgdF9a/4RZFsFVqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=c3Eioh3waPO9H8J8PTeYH3nzEjIo53EvjPhQd7IB3I52Ybah2SCDdCanwxdURXZ0b7S/gzG9wM1w24IEgns+/sd6X8Ct9kJUgcGizn8lOfvOBWt5b8SDp9r5Va2RGvTObd7FYs4N4OT73nkwji6Bze/Ot/6JjXeCQYG1wfui0+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mUcZ7Nrn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 5751A2110814; Thu, 28 Aug 2025 17:43:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5751A2110814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756428235;
	bh=NsMPM8GP79gm+90qKi0vu2XTz2eD+i9B727sNuU/f6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUcZ7NrnktniwWl1eoFA/XElG0CmluMn+J8MpJ1h8oN/U81/h44qnWx3hc5KHyeFb
	 FEGOiiQxWDBXLmvyAx4i28YNC24RGaItpwof2g0Huv/jWrjamjy2dTdeUPVcyGl0i3
	 ReoEUadptsYSR85TUGHjWNmVqb5T/Ua7yIsv2loU=
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
Subject: [PATCH 2/6] mshv: Ignore second stats page map result failure
Date: Thu, 28 Aug 2025 17:43:46 -0700
Message-Id: <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>

Some versions of the hypervisor do not support HV_STATUS_AREA_PARENT and
return HV_STATUS_INVALID_PARAMETER for the second stats page mapping
request.

This results a failure in module init. Instead of failing, gracefully
fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
already-mapped stats_pages[HV_STATS_AREA_SELF].

Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c | 43 ++++++++++++++++++++++++++++++----
 drivers/hv/mshv_root_main.c    |  3 +++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index c9c274f29c3c..1c38576a673c 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -724,6 +724,24 @@ hv_call_notify_port_ring_empty(u32 sint_index)
 	return hv_result_to_errno(status);
 }
 
+static int
+hv_stats_get_area_type(enum hv_stats_object_type type,
+		       const union hv_stats_object_identity *identity)
+{
+	switch (type) {
+	case HV_STATS_OBJECT_HYPERVISOR:
+		return identity->hv.stats_area_type;
+	case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
+		return identity->lp.stats_area_type;
+	case HV_STATS_OBJECT_PARTITION:
+		return identity->partition.stats_area_type;
+	case HV_STATS_OBJECT_VP:
+		return identity->vp.stats_area_type;
+	}
+
+	return -EINVAL;
+}
+
 int hv_call_map_stat_page(enum hv_stats_object_type type,
 			  const union hv_stats_object_identity *identity,
 			  void **addr)
@@ -732,7 +750,7 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
 	struct hv_input_map_stats_page *input;
 	struct hv_output_map_stats_page *output;
 	u64 status, pfn;
-	int ret = 0;
+	int hv_status, ret = 0;
 
 	do {
 		local_irq_save(flags);
@@ -747,11 +765,28 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
 		pfn = output->map_location;
 
 		local_irq_restore(flags);
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
-			ret = hv_result_to_errno(status);
+
+		hv_status = hv_result(status);
+		if (hv_status != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (hv_result_success(status))
 				break;
-			return ret;
+
+			/*
+			 * Some versions of the hypervisor do not support the
+			 * PARENT stats area. In this case return "success" but
+			 * set the page to NULL. The caller checks for this
+			 * case instead just uses the SELF area.
+			 */
+			if (hv_stats_get_area_type(type, identity) == HV_STATS_AREA_PARENT &&
+			    hv_status == HV_STATUS_INVALID_PARAMETER) {
+				pr_debug_once("%s: PARENT area type is unsupported\n",
+					      __func__);
+				*addr = NULL;
+				return 0;
+			}
+
+			hv_status_debug(status, "\n");
+			return hv_result_to_errno(status);
 		}
 
 		ret = hv_call_deposit_pages(NUMA_NO_NODE,
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index bbdefe8a2e9c..56ababab57ce 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -929,6 +929,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
 	if (err)
 		goto unmap_self;
 
+	if (!stats_pages[HV_STATS_AREA_PARENT])
+		stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
+
 	return 0;
 
 unmap_self:
-- 
2.34.1


