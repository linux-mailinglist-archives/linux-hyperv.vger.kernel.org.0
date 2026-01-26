Return-Path: <linux-hyperv+bounces-8535-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC35GxDWd2mFlwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8535-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 22:01:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 412C98D6AE
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 22:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10994307DBFA
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 20:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F502C11E8;
	Mon, 26 Jan 2026 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GQDx6KmX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E12D879C;
	Mon, 26 Jan 2026 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460967; cv=none; b=ucF3jLA7cydg/PIpvE3VgBRUesGW1YUkcqfi62t2aDQrU7MN9fwQvDA9iqzoGp3Ol1a5AZ1gczLkUrdn8+96tEOyfKedyv3VTrj7rmPuq2l1mer3nPpo/p4PiYWEnPNckzJOdZHfR7mqYF/voNiAB3ER0GcJLFir4Vij0QLz96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460967; c=relaxed/simple;
	bh=Nobfny3EPvSX02TlfzwBxI4xnbjdZkbLbTvxNRmD95E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9yPAffytsMoIKOsYWPMqoIqABTc3XLTH6IBT4mTd9m/ML2tsH5Ozd+gTP7Ru+7BOo5T51ed4r/5CEt+SZBhW8H5ecJNXQtU3HcK9YrCt8izByAeXfuVOPqc7OhNxfDs95iNkMRv0siYAI6iAMHvA3zBTZMDQ79o2Hfuf0/+ZRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GQDx6KmX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 2D0BB20B716B; Mon, 26 Jan 2026 12:56:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D0BB20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769460966;
	bh=TwV8k/JQjbJYmYUQItWcVn2FbTjZy0L5HeBULhqi7T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQDx6KmX/KODawarO0GJ7Uh+ilZzCNHWu78IAaFDskaeo9LcnLpQ352Jd3EbTP40U
	 lXvHFWkG50CYhmyVhpTNOM4UiJG5gZNg5R9tnniebIHVWIGJ1EAtUIiKBxKS20Ufw6
	 3AVWh7TMOwDp2JkeUd/kfqmVJtqf+Pl6O1LrVATY=
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
Subject: [PATCH v5 5/7] mshv: Update hv_stats_page definitions
Date: Mon, 26 Jan 2026 12:56:01 -0800
Message-ID: <20260126205603.404655-6-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260126205603.404655-1-nunodasneves@linux.microsoft.com>
References: <20260126205603.404655-1-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8535-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,outlook.com,linux.microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 412C98D6AE
X-Rspamd-Action: no action

hv_stats_page belongs in hvhdk.h, move it there.

It does not require a union to access the data for different counters,
just use a single u64 array for simplicity and to match the Windows
definitions.

While at it, correct the ARM64 value for VpRootDispatchThreadBlocked.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 27 ++++++++-------------------
 include/hyperv/hvhdk.h      |  8 ++++++++
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index fbfc9e7d9fa4..414d9cee5252 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -39,22 +39,12 @@ MODULE_AUTHOR("Microsoft");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
 
-/* TODO move this to another file when debugfs code is added */
-enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
-#if defined(CONFIG_X86)
-	VpRootDispatchThreadBlocked			= 202,
+/* HV_THREAD_COUNTER */
+#if defined(CONFIG_X86_64)
+#define HV_VP_COUNTER_ROOT_DISPATCH_THREAD_BLOCKED 202
 #elif defined(CONFIG_ARM64)
-	VpRootDispatchThreadBlocked			= 94,
+#define HV_VP_COUNTER_ROOT_DISPATCH_THREAD_BLOCKED 95
 #endif
-	VpStatsMaxCounter
-};
-
-struct hv_stats_page {
-	union {
-		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
-		u8 data[HV_HYP_PAGE_SIZE];
-	};
-} __packed;
 
 struct mshv_root mshv_root;
 
@@ -485,12 +475,11 @@ static u64 mshv_vp_interrupt_pending(struct mshv_vp *vp)
 static bool mshv_vp_dispatch_thread_blocked(struct mshv_vp *vp)
 {
 	struct hv_stats_page **stats = vp->vp_stats_pages;
-	u64 *self_vp_cntrs = stats[HV_STATS_AREA_SELF]->vp_cntrs;
-	u64 *parent_vp_cntrs = stats[HV_STATS_AREA_PARENT]->vp_cntrs;
+	u64 *self_vp_cntrs = stats[HV_STATS_AREA_SELF]->data;
+	u64 *parent_vp_cntrs = stats[HV_STATS_AREA_PARENT]->data;
 
-	if (self_vp_cntrs[VpRootDispatchThreadBlocked])
-		return self_vp_cntrs[VpRootDispatchThreadBlocked];
-	return parent_vp_cntrs[VpRootDispatchThreadBlocked];
+	return parent_vp_cntrs[HV_VP_COUNTER_ROOT_DISPATCH_THREAD_BLOCKED] ||
+	       self_vp_cntrs[HV_VP_COUNTER_ROOT_DISPATCH_THREAD_BLOCKED];
 }
 
 static int
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 469186df7826..ac501969105c 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -10,6 +10,14 @@
 #include "hvhdk_mini.h"
 #include "hvgdk.h"
 
+/*
+ * Hypervisor statistics page format
+ */
+struct hv_stats_page {
+	u64 data[HV_HYP_PAGE_SIZE / sizeof(u64)];
+} __packed;
+
+
 /* Bits for dirty mask of hv_vp_register_page */
 #define HV_X64_REGISTER_CLASS_GENERAL	0
 #define HV_X64_REGISTER_CLASS_IP	1
-- 
2.34.1


