Return-Path: <linux-hyperv+bounces-8425-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NfeCFdJcWn2fgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8425-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 22:47:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B035E3F0
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 22:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DE086C5A3C
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 21:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADA73D34A5;
	Wed, 21 Jan 2026 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sMHZDtGD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C84A2D662F;
	Wed, 21 Jan 2026 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031989; cv=none; b=Qxtxzcgqc4Iuskn7mJMaB3z2Bx7TTohioCNEjQpEeXOUXmBVM92B/A+fAVoTT8NQM3q+sal/gGxkQpcYxETfI344y4V55lNf9gL0vP318vuibpunQ03rNK9tDvgNpHMuMZ7g9sMO6rgpb43GoQblJoKdy1vO+0Vu/mrLqGWT61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031989; c=relaxed/simple;
	bh=LGyzTX4xWSJJekGMkFmdCSwur90Dz4p/8piG3psISFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJWiTHqbGVwgxD/o7mtpZ5I6NaSfpne9pjCQUjzjUJ4Vftv3Um55Bo6lWxq7id04qebcAfwHKfOMOjIuOvWIG86FqKI8a92DHyc6beVxQuND9j6dZ4ZBl33Pc/qIH+HYYRxYbEDuFhIzTqVS4azbsQamWQ6NpVVWS58llXPVR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sMHZDtGD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 15C2320B716E; Wed, 21 Jan 2026 13:46:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15C2320B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769031987;
	bh=BGaYS6fQUdhPyKlCCJgGza596ULYdDNfZRmn2XlPOsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMHZDtGD8/tOrCzQcA24yocVqaKy9LQV6tCuKqD6ZN6se16ovYKfcLR3xWRkKEwQN
	 QX+zO3EyP/0d3/bE5OufKYP0sL+tZPNFMuKp3xpM53B0Uhp0aecGMTSXcZxBY1qFhL
	 RcHFDOIVBXmztzo53U4Y0JctHYsvOOxDFZUV1gAg=
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
Subject: [PATCH v4 5/7] mshv: Update hv_stats_page definitions
Date: Wed, 21 Jan 2026 13:46:21 -0800
Message-ID: <20260121214623.76374-6-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8425-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,outlook.com,linux.microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 84B035E3F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hv_stats_page belongs in hvhdk.h, move it there.

It does not require a union to access the data for different counters,
just use a single u64 array for simplicity and to match the Windows
definitions.

While at it, correct the ARM64 value for VpRootDispatchThreadBlocked.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 22 ++++++----------------
 include/hyperv/hvhdk.h      |  8 ++++++++
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index fbfc9e7d9fa4..12825666e21b 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -39,23 +39,14 @@ MODULE_AUTHOR("Microsoft");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
 
-/* TODO move this to another file when debugfs code is added */
 enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
 #if defined(CONFIG_X86)
-	VpRootDispatchThreadBlocked			= 202,
+	VpRootDispatchThreadBlocked = 202,
 #elif defined(CONFIG_ARM64)
-	VpRootDispatchThreadBlocked			= 94,
+	VpRootDispatchThreadBlocked = 95,
 #endif
-	VpStatsMaxCounter
 };
 
-struct hv_stats_page {
-	union {
-		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
-		u8 data[HV_HYP_PAGE_SIZE];
-	};
-} __packed;
-
 struct mshv_root mshv_root;
 
 enum hv_scheduler_type hv_scheduler_type;
@@ -485,12 +476,11 @@ static u64 mshv_vp_interrupt_pending(struct mshv_vp *vp)
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
+	return parent_vp_cntrs[VpRootDispatchThreadBlocked] ||
+	       self_vp_cntrs[VpRootDispatchThreadBlocked];
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


