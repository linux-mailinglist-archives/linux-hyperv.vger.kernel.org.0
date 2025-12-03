Return-Path: <linux-hyperv+bounces-7924-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC33CA0C9E
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 19:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C6213015971
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D5A336ECE;
	Wed,  3 Dec 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rgdb3cuK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B9398FBF;
	Wed,  3 Dec 2025 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784415; cv=none; b=OQRr4Ts/pjZaMN28O5NurzD7dwJhcOXxUhN+U3BZdCtl7uiXa1eVFS8raHVBUniKhCnt09b9illOU33LPp+Kh/fK+Pfc4SKHdJjFnHRDnmTGxH5uCKmTJRWKqRFcdF1EXFTAFpDQkNlwtqTyRBZs5WBU8N0CLV9fIuD7EJX1F9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784415; c=relaxed/simple;
	bh=6wUU/72ODmcSjeJ3snUHRLHfD50gTJ38ovXXmSvnPS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Gw1DmP0MzPERM9/0K6bkmxD7YpxQipghLQYE88b4/gW9HdX72PfdptKOAvILDuThXMGCw1m6ZUt0a/EWlKdquHtMCUDqzjgWnVs0E5v3dQctc6B2IQog6G33LqRrMHz7XTuwWxvXw5feUfUIN/Lf8PvwwQpGSv1rZnMIMB+oFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rgdb3cuK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 4D3FE2120E8A; Wed,  3 Dec 2025 09:53:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D3FE2120E8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764784413;
	bh=usTBd/7qy6tRVzOqLNvWzpuDQV8TrYEWFuOam93MWRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgdb3cuKSOFvAhECgm0KxFtG4iNcTWatWC+IuqFUIdnbnacjtMwFVzF1hxoP1rRtv
	 gHQlGKEN8VDqdaPwYkuJEng4WjzLCKWZJFZeP+LrArSh6KiM4KfaIxBrQTEYBmUbb6
	 ZV/+DvEobwM+Jh+WU2JzMkEDwYqQ3F4ohSf7ObZc=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH 1/3] mshv: Ignore second stats page map result failure
Date: Wed,  3 Dec 2025 09:53:23 -0800
Message-Id: <1764784405-4484-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1764784405-4484-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1764784405-4484-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>

Older versions of the hypervisor do not support HV_STATS_AREA_PARENT
and return HV_STATUS_INVALID_PARAMETER for the second stats page
mapping request.

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
index 598eaff4ff29..0427785bb7fe 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -855,6 +855,24 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
 	return ret;
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
 static int hv_call_map_stats_page(enum hv_stats_object_type type,
 				  const union hv_stats_object_identity *identity,
 				  void **addr)
@@ -863,7 +881,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
 	struct hv_input_map_stats_page *input;
 	struct hv_output_map_stats_page *output;
 	u64 status, pfn;
-	int ret = 0;
+	int hv_status, ret = 0;
 
 	do {
 		local_irq_save(flags);
@@ -878,11 +896,28 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
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
+			 * Older versions of the hypervisor do not support the
+			 * PARENT stats area. In this case return "success" but
+			 * set the page to NULL. The caller should check for
+			 * this case and instead just use the SELF area.
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
index bc15d6f6922f..f59a4ab47685 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -905,6 +905,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
 	if (err)
 		goto unmap_self;
 
+	if (!stats_pages[HV_STATS_AREA_PARENT])
+		stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
+
 	return 0;
 
 unmap_self:
-- 
2.34.1


