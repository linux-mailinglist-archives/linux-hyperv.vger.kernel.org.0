Return-Path: <linux-hyperv+bounces-7369-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A579C19D91
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 11:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1D51CC1ABC
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 10:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D32D343D66;
	Wed, 29 Oct 2025 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oVqOBANR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B397330327;
	Wed, 29 Oct 2025 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734278; cv=none; b=JLxSWVMZ+lFT0BsFB9ffFJgVI7tV7gfsVikYtF+O6GevcTxKUH4nhNLBdpq+0MBowp9zh4WVAdD1hDntuHPA24Hq0llVvem5kXJ/6raT0a6eAR4+KO//eoCJbMxgpn7jiyU2pvqw0C9kmMTqX8vV2sRqxBK0/KDnC/U/Lx98/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734278; c=relaxed/simple;
	bh=h4ktVjJwrvb+bW+hTEgjMWw+BOzwEf7vjzxDc/TH23U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=qpmXbiRY0ec1uuyBury7ch3azMdtNFcDUKzcaRIJKqchvzLEBKn2TLxYv7cX9k6oP3Aag8m6ggUPtjZdZijvSQlsp9YdtnqvGoNVqAe2C4TJOVSiiZjywlxVuu6BbowzbDuj0xsBPY2fbm8cTJeiSBB7/g/YCaB7dUAbHUeJRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oVqOBANR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 24176211CF97; Wed, 29 Oct 2025 03:37:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24176211CF97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761734276;
	bh=sFK0LEa0ZlLnJ1Tx9uM2+AFX9+Izg/RNjd0uSAEK018=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oVqOBANRtDzf05i5fW2QhJukQmI+aTusWxEvH5e5YOpwO5uoL3c7sZ0TK7UVFGiJq
	 otpcFzKh+ILDLkzO5W/RreqrSTmytnzntEQuYi1gDXCL6GQSr4f6otjs8E2mE5RgSi
	 Ii2BbiyKzcNN3siHsKu1nVak2RRYICcaaMeiKTNM=
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
	rosenp@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: mana: Add standard counter rx_missed_errors
Date: Wed, 29 Oct 2025 03:37:52 -0700
Message-Id: <1761734272-32055-3-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1761734272-32055-1-git-send-email-ernis@linux.microsoft.com>
References: <1761734272-32055-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Report standard counter stats->rx_missed_errors
using hc_rx_discards_no_wqe from the hardware.

Add a dedicated workqueue to periodically run
mana_query_gf_stats every 2 seconds to get the latest
info in eth_stats and define a driver capability flag
to notify hardware of the periodic queries.

To avoid repeated failures and log flooding, the workqueue
is not rescheduled if mana_query_gf_stats fails on HWC timeout
error and the stats are reset to 0. Other errors are transient
which will not need a VF reset for recovery.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
Changes in v2:
* Update commit message.
* Stop rescheduling workqueue only when HWC timeout is observed.
* Introduce new variable in mana_context for detecting HWC timeout.
* Warn once in mana_get_stat64 when HWC timeout is observed.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 46 +++++++++++++++++--
 .../ethernet/microsoft/mana/mana_ethtool.c    |  2 -
 include/net/mana/gdma.h                       |  6 ++-
 include/net/mana/mana.h                       |  6 ++-
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 009e869ef296..48df44889f05 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -494,6 +494,11 @@ static void mana_get_stats64(struct net_device *ndev,
 
 	netdev_stats_to_stats64(st, &ndev->stats);
 
+	if (apc->ac->hwc_timeout_occurred)
+		netdev_warn_once(ndev, "HWC timeout occurred\n");
+
+	st->rx_missed_errors = apc->ac->hc_stats.hc_rx_discards_no_wqe;
+
 	for (q = 0; q < num_queues; q++) {
 		rx_stats = &apc->rxqs[q]->stats;
 
@@ -2769,7 +2774,7 @@ int mana_config_rss(struct mana_port_context *apc, enum TRI_STATE rx,
 	return 0;
 }
 
-void mana_query_gf_stats(struct mana_context *ac)
+int mana_query_gf_stats(struct mana_context *ac)
 {
 	struct mana_query_gf_stat_resp resp = {};
 	struct mana_query_gf_stat_req req = {};
@@ -2812,14 +2817,14 @@ void mana_query_gf_stats(struct mana_context *ac)
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
@@ -2854,6 +2859,8 @@ void mana_query_gf_stats(struct mana_context *ac)
 	ac->hc_stats.hc_tx_mcast_pkts = resp.hc_tx_mcast_pkts;
 	ac->hc_stats.hc_tx_mcast_bytes = resp.hc_tx_mcast_bytes;
 	ac->hc_stats.hc_tx_err_gdma = resp.tx_err_gdma;
+
+	return 0;
 }
 
 void mana_query_phy_stats(struct mana_port_context *apc)
@@ -3390,6 +3397,24 @@ int mana_rdma_service_event(struct gdma_context *gc, enum gdma_service_type even
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
+	queue_delayed_work(ac->gf_stats_wq, &ac->gf_stats_work, MANA_GF_STATS_PERIOD);
+}
+
 int mana_probe(struct gdma_dev *gd, bool resuming)
 {
 	struct gdma_context *gc = gd->gdma_context;
@@ -3478,6 +3503,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	}
 
 	err = add_adev(gd, "eth");
+	ac->gf_stats_wq = create_singlethread_workqueue("mana_gf_stats");
+	if (!ac->gf_stats_wq) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	INIT_DELAYED_WORK(&ac->gf_stats_work, mana_gf_stats_work_handler);
+	queue_delayed_work(ac->gf_stats_wq, &ac->gf_stats_work, MANA_GF_STATS_PERIOD);
+
 out:
 	if (err) {
 		mana_remove(gd, false);
@@ -3501,6 +3535,12 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	int err;
 	int i;
 
+	if (ac->gf_stats_wq) {
+		cancel_delayed_work_sync(&ac->gf_stats_work);
+		destroy_workqueue(ac->gf_stats_wq);
+		ac->gf_stats_wq = NULL;
+	}
+
 	/* adev currently doesn't support suspending, always remove it */
 	if (gd->adev)
 		remove_adev(gd);
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
index 57df78cfbf82..88a81fb164a0 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -591,6 +591,9 @@ enum {
 /* Driver can self reset on FPGA Reconfig EQE notification */
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
 
+/* Driver can send HWC periodically to query stats */
+#define GDMA_DRV_CAP_FLAG_1_PERIODIC_STATS_QUERY BIT(21)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -599,7 +602,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
 	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
 	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
-	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
+	 GDMA_DRV_CAP_FLAG_1_PERIODIC_STATS_QUERY)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 519c4384c51f..79532490cee6 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -480,6 +480,10 @@ struct mana_context {
 	struct mana_eq *eqs;
 	struct dentry *mana_eqs_debugfs;
 
+	struct workqueue_struct *gf_stats_wq;
+	struct delayed_work gf_stats_work;
+	bool hwc_timeout_occurred;
+
 	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
 };
 
@@ -577,7 +581,7 @@ u32 mana_run_xdp(struct net_device *ndev, struct mana_rxq *rxq,
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


