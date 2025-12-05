Return-Path: <linux-hyperv+bounces-7970-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F4FCA90E4
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 20:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3722317A49E
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 19:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EBA34C808;
	Fri,  5 Dec 2025 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AbTsZugB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646A4348890;
	Fri,  5 Dec 2025 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961475; cv=none; b=CwyE+KHvkGJs8wFAM1QQ0K6eP07LQ8VmDcru1ECKca/0zKiUMfPNvfgXZQvGYpHl07Jp+z9XdWqsJEGhCGgPR2YqWeT5m9j1suDGT4q7osmZ3cYjGL2LPUbbrC6BytxY4muo9w7YjRGnLNMguF1GcV9eH/op1tNyX5uKE7slJWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961475; c=relaxed/simple;
	bh=v34lNSYUMfAClbsC8dxdNs47oE5/pIRrGyM+BO0aMZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Spj/NgUSII+fvyUyX81iDdI8hagCtK06ymhX+FH7drN0Qp3X3qjvdFp1rGGf6eZG4outvfgvpd7ZF/95MLdsT6YA7dbyxBiI3oH73Jmtk5c00CBN/b+qUYJXqX3er8gc805yKl4ivYKCwHFFtugpLtuLePzPa8WrNYDkvljRaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AbTsZugB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 327212120EB9; Fri,  5 Dec 2025 10:58:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 327212120EB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764961124;
	bh=RZBYaJ6/0ul+gTNYIsLZ8iJuQGpVcMEkKZo5zmlTEY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AbTsZugBaRuJC6p+1+KzsPkH5OIcKXXuw3w/MlvmHT8X64yfHxH+znTC6MK83Tzbn
	 hCZ4VVWBnVaRtZr716Cx+x22Fqh2eyQej6AS8sU03l9Spz+SVSdTQegA09ucayU1bM
	 zcVAmi2CgJjfPt6tnqWMeaVWuqKiLzTHGMAHiGPg=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skinsburskii@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2 1/3] mshv: Ignore second stats page map result failure
Date: Fri,  5 Dec 2025 10:58:40 -0800
Message-Id: <1764961122-31679-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1764961122-31679-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1764961122-31679-1-git-send-email-nunodasneves@linux.microsoft.com>
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
Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c | 41 ++++++++++++++++++++++++++++++----
 drivers/hv/mshv_root_main.c    |  3 +++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 598eaff4ff29..b1770c7b500c 100644
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
@@ -878,11 +896,26 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
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


