Return-Path: <linux-hyperv+bounces-8534-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MLBEejVd2mFlwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8534-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 22:00:24 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E62BC8D697
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 22:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05542304CA56
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 20:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF43B2D9EC5;
	Mon, 26 Jan 2026 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZiC1QIBo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849162BEFEE;
	Mon, 26 Jan 2026 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460966; cv=none; b=SYPhS95ZNpMcWd76AKA7130h+rgsBO9qnTaoYzojV8DlO9XxhqfW3PKSzPK+DCpcd6sndY+SfGwrzwnh+ssuPAhuCZQgIhFk9MD/cWNzaQyQKZMLXOkmNWc1gXox663hY6zwanrt/OjW6qka9g/W8wKnDCQWdw9Z9kyAP8zBegA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460966; c=relaxed/simple;
	bh=L4E1wo8/6fKvJEozXW8vtzU2hTEpjK6jREA7Bfv0oJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDIERa/BvB4HDaU2NOj5w4VIUnZw5nh8u9YFuZugN5u5TlYl4gZOovlajRocrTOHNAtyKNba9LObib7b/WoIN4DFOR5yjImIrVCsbwJIyuP0ae90rQxfkstCtbfXQU4k4LZ33/+bZAIWodbIWs13BrBS0LWL3JprqE2EgUn94u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZiC1QIBo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 8D8D020B716A; Mon, 26 Jan 2026 12:56:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D8D020B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769460965;
	bh=uE6yNFSdJktjcXi31tIk+NXAAyXVgXT3CJcMYC5oQGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZiC1QIBowXMMXqmbZiZiHJK8UN+hnot+SN9WjOdm9gIdMjTDKvP8GXSuLhGcfsKPK
	 lJOF4ugfHNbeenje8b64EbtYq44ByJmgW+mFlXeF4errb+QCEX/XgM6xaeD4uSD3Pg
	 ycHBp5FDPK6w5hDe/vEHo+ODpCQBxfeVZLRR4m5c=
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
Subject: [PATCH v5 4/7] mshv: Always map child vp stats pages regardless of scheduler type
Date: Mon, 26 Jan 2026 12:56:00 -0800
Message-ID: <20260126205603.404655-5-nunodasneves@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8534-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: E62BC8D697
X-Rspamd-Action: no action

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


