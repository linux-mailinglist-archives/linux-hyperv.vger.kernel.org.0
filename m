Return-Path: <linux-hyperv+bounces-8533-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLMyJurUd2mFlwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8533-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 21:56:10 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5B08D5F5
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 21:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B824C3029A6B
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 20:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBEF2D9792;
	Mon, 26 Jan 2026 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LNYn8vZX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8CC2877DC;
	Mon, 26 Jan 2026 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460966; cv=none; b=PBuzx3V35aXPRKvVwLZUaNR35c8CBYX+0f/6rstm2EIJp8zGYLjWMGT487MSB2a2gicCSDfVKZ8lwT/wCwg4L5NaNngcwBBTku4+h0BAuYOzt14D1KAipTc6FOEkM0ncm+p6jN9DIOj2x4IW+bKV/OihRlK4S4hd0RsI0G5tJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460966; c=relaxed/simple;
	bh=2s9lIeHsh8FM2pqJpMLaCsT4ujORbpAFNEZIFfRk+Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEd3bTgrLgSr24l36L1aeffUk4FkF14EnlkA0flKM8clujl8xT5McKDLOysgYdMrMMSDcae2ucRkKZrXI8tfKy9On5sM7arGgZWg+6St8DQSWao6SruwCTaKbKjKm1bSrMjWhtYsSLdjE66WqiaUXI9wdX7UpacGZi67UrV+fms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LNYn8vZX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 5261F20B7169; Mon, 26 Jan 2026 12:56:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5261F20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769460965;
	bh=9BzoOa0wVBQB143I2PH957+WYxTAU/R3jKcGrn898r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNYn8vZXv6mbOQkujHwTbz0cLkrvurtmZzZzrFKelNxxwejK9XD1zZJ7pPwCEbGnF
	 gBo5dW4yDBUb2UBAQ/QE47EDp4gGQap2vFSA9DlUrF1abreLdmbeW4851eV6jUkxDI
	 ZLOUylwHpK8gGI3KRUevRvno50E7mFeygJqeENwY=
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
Subject: [PATCH v5 3/7] mshv: Improve mshv_vp_stats_map/unmap(), add them to mshv_root.h
Date: Mon, 26 Jan 2026 12:55:59 -0800
Message-ID: <20260126205603.404655-4-nunodasneves@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8533-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 5C5B08D5F5
X-Rspamd-Action: no action

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

These functions are currently only used to map child partition VP stats,
on root partition. However, they will soon be used on L1VH, and and also
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


