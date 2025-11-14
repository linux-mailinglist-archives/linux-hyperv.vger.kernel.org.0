Return-Path: <linux-hyperv+bounces-7587-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44069C5CEEA
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 12:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 381294EB833
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00054314D18;
	Fri, 14 Nov 2025 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UZKlzQBx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A53148B1;
	Fri, 14 Nov 2025 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763120604; cv=none; b=bUkhzxyOYLwlp1XMQNcHfM+120nKC2LCX28FURIg9B1du/fQZP2MLc8IEPyRFAChOorWehpEfFc/j90HOdvj/CiRjuOOw0d/ZiamJpg/8rSvD5s3enoR4M9GMzH793VlWf1RsnOruMsmQNK++JGOZejn6oK1EnahpvHngXNbWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763120604; c=relaxed/simple;
	bh=NAjEO2l/7TT2dg+RJwWy/qrXQnXVKSmFSZxHLdwJUUc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=ILRl4ZBI+NViDY1xgM4zREWTQcZh+BoCtOKSD4xEqjcIr88TIa5XER9GB5RUUVfz1xEyfI6924OAfm4XuWeUrq2BFb5SW8dQQZqyi8VV2N8LR7lvgq4gKVHJDL6JN4j7mFRpIc6JaOSccFmTnHu87KFeLfP5ifKyTQ/g3y+YfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UZKlzQBx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id EF0E8201AE5F; Fri, 14 Nov 2025 03:43:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF0E8201AE5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763120602;
	bh=vnJk8LGOxLRkcMfO5rBoEy0rgFlSz2jeBb39ewcebbg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UZKlzQBxz9WPXrtr1+/ehfZb3D+2qMp4rJ1jJEWsSPKpzMaLixbPddQJCMJdbv0tY
	 k6oNnMxxsyervV1Ov69ZVN0Q+bZyQ7wACt8uqYAHe7+mGFFjJTJJ6aA+T7jCqj97YN
	 25V5odEV24VQTf59fxZh2cycwsw2oC6wRSyqad/Y=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	sbhatta@marvell.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v3 2/2] net: mana: Add standard counter rx_missed_errors
Date: Fri, 14 Nov 2025 03:43:19 -0800
Message-Id: <1763120599-6331-3-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1763120599-6331-1-git-send-email-ernis@linux.microsoft.com>
References: <1763120599-6331-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Report standard counter stats->rx_missed_errors
using hc_rx_discards_no_wqe from the hardware.

Add a global workqueue to periodically run
mana_query_gf_stats every 2 seconds to get the latest
info in eth_stats and define a driver capability flag
to notify hardware of the periodic queries.

To avoid repeated failures and log flooding, the workqueue
is not rescheduled if mana_query_gf_stats fails on HWC timeout
error and the stats are reset to 0. Other errors are transient
which will not need a VF reset for recovery.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v3:
* Use schedule_delayed_work (global workqueue) instead of
  queue_delayed_work (dedicated workqueue) in MANA driver.
* Update commit message.
Changes in v2:
* Update commit message.
* Stop rescheduling workqueue only when HWC timeout is observed.
* Introduce new variable in mana_context for detecting HWC timeout.
* Warn once in mana_get_stat64 when HWC timeout is observed.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 36 +++++++++++++++++--
 .../ethernet/microsoft/mana/mana_ethtool.c    |  2 --
 include/net/mana/gdma.h                       |  6 +++-
 include/net/mana/mana.h                       |  6 +++-
 4 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d8ce4402c696..13f47be7aca6 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -534,6 +534,11 @@ static void mana_get_stats64(struct net_device *ndev,
 
 	netdev_stats_to_stats64(st, &ndev->stats);
 
+	if (apc->ac->hwc_timeout_occurred)
+		netdev_warn_once(ndev, "HWC timeout occurred\n");
+
+	st->rx_missed_errors = apc->ac->hc_stats.hc_rx_discards_no_wqe;
+
 	for (q = 0; q < num_queues; q++) {
 		rx_stats = &apc->rxqs[q]->stats;
 
@@ -2809,7 +2814,7 @@ int mana_config_rss(struct mana_port_context *apc, enum TRI_STATE rx,
 	return 0;
 }
 
-void mana_query_gf_stats(struct mana_context *ac)
+int mana_query_gf_stats(struct mana_context *ac)
 {
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct mana_query_gf_stat_resp resp = {};
@@ -2852,14 +2857,14 @@ void mana_query_gf_stats(struct mana_context *ac)
 				sizeof(resp));
 	if (err) {
 		dev_err(dev, "Failed to query GF stats: %d\n", err);
-		return;
+		return err;
 	}
 	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_GF_STAT,
 				   sizeof(resp));
 	if (err || resp.hdr.status) {
 		dev_err(dev, "Failed to query GF stats: %d, 0x%x\n", err,
 			resp.hdr.status);
-		return;
+		return err;
 	}
 
 	ac->hc_stats.hc_rx_discards_no_wqe = resp.rx_discards_nowqe;
@@ -2894,6 +2899,8 @@ void mana_query_gf_stats(struct mana_context *ac)
 	ac->hc_stats.hc_tx_mcast_pkts = resp.hc_tx_mcast_pkts;
 	ac->hc_stats.hc_tx_mcast_bytes = resp.hc_tx_mcast_bytes;
 	ac->hc_stats.hc_tx_err_gdma = resp.tx_err_gdma;
+
+	return 0;
 }
 
 void mana_query_phy_stats(struct mana_port_context *apc)
@@ -3428,6 +3435,24 @@ int mana_rdma_service_event(struct gdma_context *gc, enum gdma_service_type even
 	return 0;
 }
 
+#define MANA_GF_STATS_PERIOD (2 * HZ)
+
+static void mana_gf_stats_work_handler(struct work_struct *work)
+{
+	struct mana_context *ac =
+		container_of(to_delayed_work(work), struct mana_context, gf_stats_work);
+	int err;
+
+	err = mana_query_gf_stats(ac);
+	if (err == -ETIMEDOUT) {
+		/* HWC timeout detected - reset stats and stop rescheduling */
+		ac->hwc_timeout_occurred = true;
+		memset(&ac->hc_stats, 0, sizeof(ac->hc_stats));
+		return;
+	}
+	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);
+}
+
 int mana_probe(struct gdma_dev *gd, bool resuming)
 {
 	struct gdma_context *gc = gd->gdma_context;
@@ -3520,6 +3545,10 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	}
 
 	err = add_adev(gd, "eth");
+
+	INIT_DELAYED_WORK(&ac->gf_stats_work, mana_gf_stats_work_handler);
+	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);
+
 out:
 	if (err) {
 		mana_remove(gd, false);
@@ -3544,6 +3573,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	int i;
 
 	disable_work_sync(&ac->link_change_work);
+	cancel_delayed_work_sync(&ac->gf_stats_work);
 
 	/* adev currently doesn't support suspending, always remove it */
 	if (gd->adev)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 3dfd96146424..99e811208683 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -213,8 +213,6 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 
 	if (!apc->port_is_up)
 		return;
-	/* we call mana function to update stats from GDMA */
-	mana_query_gf_stats(apc->ac);
 
 	/* We call this mana function to get the phy stats from GDMA and includes
 	 * aggregate tx/rx drop counters, Per-TC(Traffic Channel) tx/rx and pause
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 637f42485dba..2e4f2f3175e5 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -592,6 +592,9 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
 #define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
+/* Driver can send HWC periodically to query stats */
+#define GDMA_DRV_CAP_FLAG_1_PERIODIC_STATS_QUERY BIT(21)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -601,7 +604,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
 	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
-	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE)
+	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE | \
+	 GDMA_DRV_CAP_FLAG_1_PERIODIC_STATS_QUERY)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 3484f42803e3..d37f4cea0ac3 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -480,6 +480,10 @@ struct mana_context {
 	struct mana_eq *eqs;
 	struct dentry *mana_eqs_debugfs;
 
+	/* Workqueue for querying hardware stats */
+	struct delayed_work gf_stats_work;
+	bool hwc_timeout_occurred;
+
 	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
 
 	/* Link state change work */
@@ -581,7 +585,7 @@ u32 mana_run_xdp(struct net_device *ndev, struct mana_rxq *rxq,
 struct bpf_prog *mana_xdp_get(struct mana_port_context *apc);
 void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
-void mana_query_gf_stats(struct mana_context *ac);
+int mana_query_gf_stats(struct mana_context *ac);
 int mana_query_link_cfg(struct mana_port_context *apc);
 int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 		      int enable_clamping);
-- 
2.34.1


