Return-Path: <linux-hyperv+bounces-8570-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCbiKnFSemnk5AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8570-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 19:16:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9740DA7A0D
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 19:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BD6830107B6
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 18:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B8F37105C;
	Wed, 28 Jan 2026 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HYkCrrRk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A12FE58D;
	Wed, 28 Jan 2026 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623909; cv=none; b=rfqH2eyZ1qZu+GjI2xfpAqxsRAyP4RLQdcwnaCBLG+uBbKZ07dlZkxDzDsGk6D6OtTfYEbdNZ1zz/ux6uzHz4Lsn75JmvqIKI4GjNeJuMV0Lay/7NMAguEftwl4VfOaE0H6SirAlvk8pKil6uAF+WDMNfr5xIM+nB6tZs47KNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623909; c=relaxed/simple;
	bh=XoWr9E6GpJVfiqW5j7TGfpouzFnYRVdh59ggwDHSzrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQyZWTWuNS/a+7Cno5qaKHj4Sp7h/6rbTtrT+dF+kQBYoL2+hfHyhh6ARXQHUf7eZLYz6YNFsmRDuBokJBEwAih3vNRYdKWYCVhollmaDv+zKM9wfe/ZiMtLdEAiiMkji3vgovSd80EUkqw8+XgcFZFohvyOXq3MgncSjZOp5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HYkCrrRk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 685AA20B7169; Wed, 28 Jan 2026 10:11:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 685AA20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769623908;
	bh=LLskYnn36sZloCu/fmiglMXyDQHLYorP70jSLnEIhig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYkCrrRkHwd+9RpnENrKsrlQbUQSPB9zSzP0onXiqxkfx65V8dfl0A9DZyLc27NH8
	 1DBRBZe+uGEYOJdqC9FNKVySGREVFzZTtwNptg7GnqEJ1u1tY/JWLDeIAPfehQ8FAM
	 c/DR9Ae30X78JUfCG3aPvcZtuNfcR+Y05HbLkZNs=
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
Subject: [PATCH v6 3/7] mshv: Improve mshv_vp_stats_map/unmap(), add them to mshv_root.h
Date: Wed, 28 Jan 2026 10:11:42 -0800
Message-ID: <20260128181146.517708-4-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260128181146.517708-1-nunodasneves@linux.microsoft.com>
References: <20260128181146.517708-1-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-8570-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9740DA7A0D
X-Rspamd-Action: no action

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

These functions are currently only used to map child partition VP stats,
on root partition. However, they will soon be used on L1VH, and also
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


