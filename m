Return-Path: <linux-hyperv+bounces-8424-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLZ8EgpMcWn2fgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8424-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 22:58:34 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E72425E64D
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 22:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A04778D105
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1A83A7DF6;
	Wed, 21 Jan 2026 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pCCpMLY6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E3258CE5;
	Wed, 21 Jan 2026 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031988; cv=none; b=blVTYW+lm3eXR5lVIWeMuMVVDKdwOdy7KOsOuV96W+nmzuJQ8iZvRWwRKIJxRp2Lgzal6/3Xrh2o6Zq/t+McXbZaXjxJ92c+Yq5fd/blalt5DIAnvmj/zYde6J6RWapRa46wZAH5nt7cQRMxJY6ulfzEb/YILsdkl59yJ3md/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031988; c=relaxed/simple;
	bh=L4E1wo8/6fKvJEozXW8vtzU2hTEpjK6jREA7Bfv0oJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkYE11tBWEs50yqgV0gNvDD5wk6rjQtpGEjaoQw9Yp9ZCCXXjCa1GbZ0PdyPxDgOWWY8uckELYabKDWkN1eV0cqgq/1xKEFfVIrqpIdVe6AV4i/fdV9fg3xJiKPallYEEjNFH+ILwLvjX2DSCdKLxm1Ri2KHvCBQ9Lvu+yDUNdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pCCpMLY6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 993B720B716D; Wed, 21 Jan 2026 13:46:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 993B720B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769031986;
	bh=uE6yNFSdJktjcXi31tIk+NXAAyXVgXT3CJcMYC5oQGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCCpMLY6aaHjBaV1L7lqGdaxICtgPl5GrxAKxR1QsC86Es27Dj5Bj6LDgglCFBM/j
	 6P7MnHmxTJvLCzl3yIFJBGTADaDk3qdOrW5aIxiYdj47F4bqHlAieI/dECEa6K360V
	 15VziVPNxu7AD27f7DqP1fDgR8xM3Q7eAX8RVk4A=
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
Subject: [PATCH v4 4/7] mshv: Always map child vp stats pages regardless of scheduler type
Date: Wed, 21 Jan 2026 13:46:20 -0800
Message-ID: <20260121214623.76374-5-nunodasneves@linux.microsoft.com>
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
	TAGGED_FROM(0.00)[bounces-8424-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,outlook.com,linux.microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: E72425E64D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Currently vp->vp_stats_pages is only used by the root scheduler for fast
interrupt injection.

Soon, vp_stats_pages will also be needed for exposing child VP stats to
userspace via debugfs. Mapping the pages a second time to a different
address causes an error on L1VH.

Remove the scheduler requirement and always map the vp stats pages.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index faca3cc63e79..fbfc9e7d9fa4 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1077,16 +1077,10 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 			goto unmap_register_page;
 	}
 
-	/*
-	 * This mapping of the stats page is for detecting if dispatch thread
-	 * is blocked - only relevant for root scheduler
-	 */
-	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT) {
-		ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
-					stats_pages);
-		if (ret)
-			goto unmap_ghcb_page;
-	}
+	ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
+				stats_pages);
+	if (ret)
+		goto unmap_ghcb_page;
 
 	vp = kzalloc(sizeof(*vp), GFP_KERNEL);
 	if (!vp)
@@ -1110,8 +1104,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
 		vp->vp_ghcb_page = page_to_virt(ghcb_page);
 
-	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
-		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
+	memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
 
 	/*
 	 * Keep anon_inode_getfd last: it installs fd in the file struct and
@@ -1133,8 +1126,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 free_vp:
 	kfree(vp);
 unmap_stats_pages:
-	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
-		mshv_vp_stats_unmap(partition->pt_id, args.vp_index, stats_pages);
+	mshv_vp_stats_unmap(partition->pt_id, args.vp_index, stats_pages);
 unmap_ghcb_page:
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
 		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
@@ -1754,9 +1746,8 @@ static void destroy_partition(struct mshv_partition *partition)
 			if (!vp)
 				continue;
 
-			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
-				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
-						    vp->vp_stats_pages);
+			mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
+					    vp->vp_stats_pages);
 
 			if (vp->vp_register_page) {
 				(void)hv_unmap_vp_state_page(partition->pt_id,
-- 
2.34.1


