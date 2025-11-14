Return-Path: <linux-hyperv+bounces-7586-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 531DAC5CE7F
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 12:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FA3135A9C2
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7CD314A8A;
	Fri, 14 Nov 2025 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VvoviU8g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25601285C84;
	Fri, 14 Nov 2025 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763120603; cv=none; b=hj5ULnG5Gy/TJ7KPgIqA1kca2+DmkMEdaWQo9B46pb1r0eb5SXpMW/GW8PPz57FGNcDVYnbmsG4njDHs4/0bAnWff/2vX2CB90upSjy3p9VeXIarS4X7xgCeyU0hF1/zo7apNV3RTESKtVXRTn2hU67cFTibnqybIQPnkRdErJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763120603; c=relaxed/simple;
	bh=H0XmW1YRUMDmwGxFGXL1u0E0HXVG57PSeKeGALPcevU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=eMljV4Y8vm8KLdv0SImKTOZSfrixjcpeG/z364zCUPuApuJIXgc2BuLPvVP6J+/0JummDQ6g7Kp4Fc11NJLMxkNRnxDEtjn6RwMT5COUvqJTjA96DP3XKLX9aU+ND06CkaaNSQ+QxKjMf8asoFctSYLN1WNBYv3g2gtDW70h14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VvoviU8g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id BC6D1201AE4B; Fri, 14 Nov 2025 03:43:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC6D1201AE4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763120601;
	bh=9y3klmW696wFMie/0tWLAl3ILaSeDWEYCiiB9yyCqT4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VvoviU8gZNSQ6s+u5R598mGaY47sq5Dj9FYs4j9jShRfpANaKr5tH0LZMO0+TnnkD
	 djSFdcrxZ3tDKgM5IXBXVbnTsMugBek7VjhCamLXwah4ip6bafSCBPPr1pxERKQ6Ew
	 P78g/nYqgh0JDuV4UiP0IaImIwKW+tt9RQFPk4nY=
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
Subject: [PATCH net-next v3 1/2] net: mana: Move hardware counter stats from per-port to per-VF context
Date: Fri, 14 Nov 2025 03:43:18 -0800
Message-Id: <1763120599-6331-2-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1763120599-6331-1-git-send-email-ernis@linux.microsoft.com>
References: <1763120599-6331-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Move hardware counter (HC) statistics from mana_port_context to
mana_context to enable sharing stats across multiple network ports
on the same MANA VF. Previously, each network port queried
hardware counters independently using MANA_QUERY_GF_STAT command
(GF = Generic Function stats from GDMA hardware), resulting in
redundant queries when multiple ports existed on the same device.

Isolate hardware counter stats by introducing mana_ethtool_hc_stats
in mana_context and update the code to ensure all stats are properly
reported via ethtool -S <interface>, maintaining consistency with
previous behavior.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v3:
* Update commit message for more readability.
* Use reverse x-mas tree format in mana_query_gf_stats.
Changes in v2:
* No change
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 67 ++++++++-------
 .../ethernet/microsoft/mana/mana_ethtool.c    | 85 ++++++++++---------
 include/net/mana/mana.h                       | 14 +--
 3 files changed, 90 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index cccd5b63cee6..d8ce4402c696 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2809,11 +2809,12 @@ int mana_config_rss(struct mana_port_context *apc, enum TRI_STATE rx,
 	return 0;
 }
 
-void mana_query_gf_stats(struct mana_port_context *apc)
+void mana_query_gf_stats(struct mana_context *ac)
 {
+	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct mana_query_gf_stat_resp resp = {};
 	struct mana_query_gf_stat_req req = {};
-	struct net_device *ndev = apc->ndev;
+	struct device *dev = gc->dev;
 	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_GF_STAT,
@@ -2847,52 +2848,52 @@ void mana_query_gf_stats(struct mana_port_context *apc)
 			STATISTICS_FLAGS_HC_TX_BCAST_BYTES |
 			STATISTICS_FLAGS_TX_ERRORS_GDMA_ERROR;
 
-	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
+	err = mana_send_request(ac, &req, sizeof(req), &resp,
 				sizeof(resp));
 	if (err) {
-		netdev_err(ndev, "Failed to query GF stats: %d\n", err);
+		dev_err(dev, "Failed to query GF stats: %d\n", err);
 		return;
 	}
 	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_GF_STAT,
 				   sizeof(resp));
 	if (err || resp.hdr.status) {
-		netdev_err(ndev, "Failed to query GF stats: %d, 0x%x\n", err,
-			   resp.hdr.status);
+		dev_err(dev, "Failed to query GF stats: %d, 0x%x\n", err,
+			resp.hdr.status);
 		return;
 	}
 
-	apc->eth_stats.hc_rx_discards_no_wqe = resp.rx_discards_nowqe;
-	apc->eth_stats.hc_rx_err_vport_disabled = resp.rx_err_vport_disabled;
-	apc->eth_stats.hc_rx_bytes = resp.hc_rx_bytes;
-	apc->eth_stats.hc_rx_ucast_pkts = resp.hc_rx_ucast_pkts;
-	apc->eth_stats.hc_rx_ucast_bytes = resp.hc_rx_ucast_bytes;
-	apc->eth_stats.hc_rx_bcast_pkts = resp.hc_rx_bcast_pkts;
-	apc->eth_stats.hc_rx_bcast_bytes = resp.hc_rx_bcast_bytes;
-	apc->eth_stats.hc_rx_mcast_pkts = resp.hc_rx_mcast_pkts;
-	apc->eth_stats.hc_rx_mcast_bytes = resp.hc_rx_mcast_bytes;
-	apc->eth_stats.hc_tx_err_gf_disabled = resp.tx_err_gf_disabled;
-	apc->eth_stats.hc_tx_err_vport_disabled = resp.tx_err_vport_disabled;
-	apc->eth_stats.hc_tx_err_inval_vportoffset_pkt =
+	ac->hc_stats.hc_rx_discards_no_wqe = resp.rx_discards_nowqe;
+	ac->hc_stats.hc_rx_err_vport_disabled = resp.rx_err_vport_disabled;
+	ac->hc_stats.hc_rx_bytes = resp.hc_rx_bytes;
+	ac->hc_stats.hc_rx_ucast_pkts = resp.hc_rx_ucast_pkts;
+	ac->hc_stats.hc_rx_ucast_bytes = resp.hc_rx_ucast_bytes;
+	ac->hc_stats.hc_rx_bcast_pkts = resp.hc_rx_bcast_pkts;
+	ac->hc_stats.hc_rx_bcast_bytes = resp.hc_rx_bcast_bytes;
+	ac->hc_stats.hc_rx_mcast_pkts = resp.hc_rx_mcast_pkts;
+	ac->hc_stats.hc_rx_mcast_bytes = resp.hc_rx_mcast_bytes;
+	ac->hc_stats.hc_tx_err_gf_disabled = resp.tx_err_gf_disabled;
+	ac->hc_stats.hc_tx_err_vport_disabled = resp.tx_err_vport_disabled;
+	ac->hc_stats.hc_tx_err_inval_vportoffset_pkt =
 					     resp.tx_err_inval_vport_offset_pkt;
-	apc->eth_stats.hc_tx_err_vlan_enforcement =
+	ac->hc_stats.hc_tx_err_vlan_enforcement =
 					     resp.tx_err_vlan_enforcement;
-	apc->eth_stats.hc_tx_err_eth_type_enforcement =
+	ac->hc_stats.hc_tx_err_eth_type_enforcement =
 					     resp.tx_err_ethtype_enforcement;
-	apc->eth_stats.hc_tx_err_sa_enforcement = resp.tx_err_SA_enforcement;
-	apc->eth_stats.hc_tx_err_sqpdid_enforcement =
+	ac->hc_stats.hc_tx_err_sa_enforcement = resp.tx_err_SA_enforcement;
+	ac->hc_stats.hc_tx_err_sqpdid_enforcement =
 					     resp.tx_err_SQPDID_enforcement;
-	apc->eth_stats.hc_tx_err_cqpdid_enforcement =
+	ac->hc_stats.hc_tx_err_cqpdid_enforcement =
 					     resp.tx_err_CQPDID_enforcement;
-	apc->eth_stats.hc_tx_err_mtu_violation = resp.tx_err_mtu_violation;
-	apc->eth_stats.hc_tx_err_inval_oob = resp.tx_err_inval_oob;
-	apc->eth_stats.hc_tx_bytes = resp.hc_tx_bytes;
-	apc->eth_stats.hc_tx_ucast_pkts = resp.hc_tx_ucast_pkts;
-	apc->eth_stats.hc_tx_ucast_bytes = resp.hc_tx_ucast_bytes;
-	apc->eth_stats.hc_tx_bcast_pkts = resp.hc_tx_bcast_pkts;
-	apc->eth_stats.hc_tx_bcast_bytes = resp.hc_tx_bcast_bytes;
-	apc->eth_stats.hc_tx_mcast_pkts = resp.hc_tx_mcast_pkts;
-	apc->eth_stats.hc_tx_mcast_bytes = resp.hc_tx_mcast_bytes;
-	apc->eth_stats.hc_tx_err_gdma = resp.tx_err_gdma;
+	ac->hc_stats.hc_tx_err_mtu_violation = resp.tx_err_mtu_violation;
+	ac->hc_stats.hc_tx_err_inval_oob = resp.tx_err_inval_oob;
+	ac->hc_stats.hc_tx_bytes = resp.hc_tx_bytes;
+	ac->hc_stats.hc_tx_ucast_pkts = resp.hc_tx_ucast_pkts;
+	ac->hc_stats.hc_tx_ucast_bytes = resp.hc_tx_ucast_bytes;
+	ac->hc_stats.hc_tx_bcast_pkts = resp.hc_tx_bcast_pkts;
+	ac->hc_stats.hc_tx_bcast_bytes = resp.hc_tx_bcast_bytes;
+	ac->hc_stats.hc_tx_mcast_pkts = resp.hc_tx_mcast_pkts;
+	ac->hc_stats.hc_tx_mcast_bytes = resp.hc_tx_mcast_bytes;
+	ac->hc_stats.hc_tx_err_gdma = resp.tx_err_gdma;
 }
 
 void mana_query_phy_stats(struct mana_port_context *apc)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index a1afa75a9463..3dfd96146424 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -15,66 +15,69 @@ struct mana_stats_desc {
 static const struct mana_stats_desc mana_eth_stats[] = {
 	{"stop_queue", offsetof(struct mana_ethtool_stats, stop_queue)},
 	{"wake_queue", offsetof(struct mana_ethtool_stats, wake_queue)},
-	{"hc_rx_discards_no_wqe", offsetof(struct mana_ethtool_stats,
+	{"tx_cq_err", offsetof(struct mana_ethtool_stats, tx_cqe_err)},
+	{"tx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
+					tx_cqe_unknown_type)},
+	{"rx_coalesced_err", offsetof(struct mana_ethtool_stats,
+					rx_coalesced_err)},
+	{"rx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
+					rx_cqe_unknown_type)},
+};
+
+static const struct mana_stats_desc mana_hc_stats[] = {
+	{"hc_rx_discards_no_wqe", offsetof(struct mana_ethtool_hc_stats,
 					   hc_rx_discards_no_wqe)},
-	{"hc_rx_err_vport_disabled", offsetof(struct mana_ethtool_stats,
+	{"hc_rx_err_vport_disabled", offsetof(struct mana_ethtool_hc_stats,
 					      hc_rx_err_vport_disabled)},
-	{"hc_rx_bytes", offsetof(struct mana_ethtool_stats, hc_rx_bytes)},
-	{"hc_rx_ucast_pkts", offsetof(struct mana_ethtool_stats,
+	{"hc_rx_bytes", offsetof(struct mana_ethtool_hc_stats, hc_rx_bytes)},
+	{"hc_rx_ucast_pkts", offsetof(struct mana_ethtool_hc_stats,
 				      hc_rx_ucast_pkts)},
-	{"hc_rx_ucast_bytes", offsetof(struct mana_ethtool_stats,
+	{"hc_rx_ucast_bytes", offsetof(struct mana_ethtool_hc_stats,
 				       hc_rx_ucast_bytes)},
-	{"hc_rx_bcast_pkts", offsetof(struct mana_ethtool_stats,
+	{"hc_rx_bcast_pkts", offsetof(struct mana_ethtool_hc_stats,
 				      hc_rx_bcast_pkts)},
-	{"hc_rx_bcast_bytes", offsetof(struct mana_ethtool_stats,
+	{"hc_rx_bcast_bytes", offsetof(struct mana_ethtool_hc_stats,
 				       hc_rx_bcast_bytes)},
-	{"hc_rx_mcast_pkts", offsetof(struct mana_ethtool_stats,
-			hc_rx_mcast_pkts)},
-	{"hc_rx_mcast_bytes", offsetof(struct mana_ethtool_stats,
+	{"hc_rx_mcast_pkts", offsetof(struct mana_ethtool_hc_stats,
+				      hc_rx_mcast_pkts)},
+	{"hc_rx_mcast_bytes", offsetof(struct mana_ethtool_hc_stats,
 				       hc_rx_mcast_bytes)},
-	{"hc_tx_err_gf_disabled", offsetof(struct mana_ethtool_stats,
+	{"hc_tx_err_gf_disabled", offsetof(struct mana_ethtool_hc_stats,
 					   hc_tx_err_gf_disabled)},
-	{"hc_tx_err_vport_disabled", offsetof(struct mana_ethtool_stats,
+	{"hc_tx_err_vport_disabled", offsetof(struct mana_ethtool_hc_stats,
 					      hc_tx_err_vport_disabled)},
 	{"hc_tx_err_inval_vportoffset_pkt",
-	 offsetof(struct mana_ethtool_stats,
+	 offsetof(struct mana_ethtool_hc_stats,
 		  hc_tx_err_inval_vportoffset_pkt)},
-	{"hc_tx_err_vlan_enforcement", offsetof(struct mana_ethtool_stats,
+	{"hc_tx_err_vlan_enforcement", offsetof(struct mana_ethtool_hc_stats,
 						hc_tx_err_vlan_enforcement)},
 	{"hc_tx_err_eth_type_enforcement",
-	 offsetof(struct mana_ethtool_stats, hc_tx_err_eth_type_enforcement)},
-	{"hc_tx_err_sa_enforcement", offsetof(struct mana_ethtool_stats,
+	 offsetof(struct mana_ethtool_hc_stats, hc_tx_err_eth_type_enforcement)},
+	{"hc_tx_err_sa_enforcement", offsetof(struct mana_ethtool_hc_stats,
 					      hc_tx_err_sa_enforcement)},
 	{"hc_tx_err_sqpdid_enforcement",
-	 offsetof(struct mana_ethtool_stats, hc_tx_err_sqpdid_enforcement)},
+	 offsetof(struct mana_ethtool_hc_stats, hc_tx_err_sqpdid_enforcement)},
 	{"hc_tx_err_cqpdid_enforcement",
-	 offsetof(struct mana_ethtool_stats, hc_tx_err_cqpdid_enforcement)},
-	{"hc_tx_err_mtu_violation", offsetof(struct mana_ethtool_stats,
+	 offsetof(struct mana_ethtool_hc_stats, hc_tx_err_cqpdid_enforcement)},
+	{"hc_tx_err_mtu_violation", offsetof(struct mana_ethtool_hc_stats,
 					     hc_tx_err_mtu_violation)},
-	{"hc_tx_err_inval_oob", offsetof(struct mana_ethtool_stats,
+	{"hc_tx_err_inval_oob", offsetof(struct mana_ethtool_hc_stats,
 					 hc_tx_err_inval_oob)},
-	{"hc_tx_err_gdma", offsetof(struct mana_ethtool_stats,
+	{"hc_tx_err_gdma", offsetof(struct mana_ethtool_hc_stats,
 				    hc_tx_err_gdma)},
-	{"hc_tx_bytes", offsetof(struct mana_ethtool_stats, hc_tx_bytes)},
-	{"hc_tx_ucast_pkts", offsetof(struct mana_ethtool_stats,
+	{"hc_tx_bytes", offsetof(struct mana_ethtool_hc_stats, hc_tx_bytes)},
+	{"hc_tx_ucast_pkts", offsetof(struct mana_ethtool_hc_stats,
 					hc_tx_ucast_pkts)},
-	{"hc_tx_ucast_bytes", offsetof(struct mana_ethtool_stats,
+	{"hc_tx_ucast_bytes", offsetof(struct mana_ethtool_hc_stats,
 					hc_tx_ucast_bytes)},
-	{"hc_tx_bcast_pkts", offsetof(struct mana_ethtool_stats,
+	{"hc_tx_bcast_pkts", offsetof(struct mana_ethtool_hc_stats,
 					hc_tx_bcast_pkts)},
-	{"hc_tx_bcast_bytes", offsetof(struct mana_ethtool_stats,
+	{"hc_tx_bcast_bytes", offsetof(struct mana_ethtool_hc_stats,
 					hc_tx_bcast_bytes)},
-	{"hc_tx_mcast_pkts", offsetof(struct mana_ethtool_stats,
+	{"hc_tx_mcast_pkts", offsetof(struct mana_ethtool_hc_stats,
 					hc_tx_mcast_pkts)},
-	{"hc_tx_mcast_bytes", offsetof(struct mana_ethtool_stats,
+	{"hc_tx_mcast_bytes", offsetof(struct mana_ethtool_hc_stats,
 					hc_tx_mcast_bytes)},
-	{"tx_cq_err", offsetof(struct mana_ethtool_stats, tx_cqe_err)},
-	{"tx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
-					tx_cqe_unknown_type)},
-	{"rx_coalesced_err", offsetof(struct mana_ethtool_stats,
-					rx_coalesced_err)},
-	{"rx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
-					rx_cqe_unknown_type)},
 };
 
 static const struct mana_stats_desc mana_phy_stats[] = {
@@ -138,7 +141,7 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
 	if (stringset != ETH_SS_STATS)
 		return -EINVAL;
 
-	return ARRAY_SIZE(mana_eth_stats) + ARRAY_SIZE(mana_phy_stats) +
+	return ARRAY_SIZE(mana_eth_stats) + ARRAY_SIZE(mana_phy_stats) + ARRAY_SIZE(mana_hc_stats) +
 			num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
 }
 
@@ -150,10 +153,12 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 
 	if (stringset != ETH_SS_STATS)
 		return;
-
 	for (i = 0; i < ARRAY_SIZE(mana_eth_stats); i++)
 		ethtool_puts(&data, mana_eth_stats[i].name);
 
+	for (i = 0; i < ARRAY_SIZE(mana_hc_stats); i++)
+		ethtool_puts(&data, mana_hc_stats[i].name);
+
 	for (i = 0; i < ARRAY_SIZE(mana_phy_stats); i++)
 		ethtool_puts(&data, mana_phy_stats[i].name);
 
@@ -186,6 +191,7 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	struct mana_port_context *apc = netdev_priv(ndev);
 	unsigned int num_queues = apc->num_queues;
 	void *eth_stats = &apc->eth_stats;
+	void *hc_stats = &apc->ac->hc_stats;
 	void *phy_stats = &apc->phy_stats;
 	struct mana_stats_rx *rx_stats;
 	struct mana_stats_tx *tx_stats;
@@ -208,7 +214,7 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	if (!apc->port_is_up)
 		return;
 	/* we call mana function to update stats from GDMA */
-	mana_query_gf_stats(apc);
+	mana_query_gf_stats(apc->ac);
 
 	/* We call this mana function to get the phy stats from GDMA and includes
 	 * aggregate tx/rx drop counters, Per-TC(Traffic Channel) tx/rx and pause
@@ -219,6 +225,9 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	for (q = 0; q < ARRAY_SIZE(mana_eth_stats); q++)
 		data[i++] = *(u64 *)(eth_stats + mana_eth_stats[q].offset);
 
+	for (q = 0; q < ARRAY_SIZE(mana_hc_stats); q++)
+		data[i++] = *(u64 *)(hc_stats + mana_hc_stats[q].offset);
+
 	for (q = 0; q < ARRAY_SIZE(mana_phy_stats); q++)
 		data[i++] = *(u64 *)(phy_stats + mana_phy_stats[q].offset);
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 8906901535f5..3484f42803e3 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -375,6 +375,13 @@ struct mana_tx_qp {
 struct mana_ethtool_stats {
 	u64 stop_queue;
 	u64 wake_queue;
+	u64 tx_cqe_err;
+	u64 tx_cqe_unknown_type;
+	u64 rx_coalesced_err;
+	u64 rx_cqe_unknown_type;
+};
+
+struct mana_ethtool_hc_stats {
 	u64 hc_rx_discards_no_wqe;
 	u64 hc_rx_err_vport_disabled;
 	u64 hc_rx_bytes;
@@ -402,10 +409,6 @@ struct mana_ethtool_stats {
 	u64 hc_tx_mcast_pkts;
 	u64 hc_tx_mcast_bytes;
 	u64 hc_tx_err_gdma;
-	u64 tx_cqe_err;
-	u64 tx_cqe_unknown_type;
-	u64 rx_coalesced_err;
-	u64 rx_cqe_unknown_type;
 };
 
 struct mana_ethtool_phy_stats {
@@ -473,6 +476,7 @@ struct mana_context {
 	u16 num_ports;
 	u8 bm_hostmode;
 
+	struct mana_ethtool_hc_stats hc_stats;
 	struct mana_eq *eqs;
 	struct dentry *mana_eqs_debugfs;
 
@@ -577,7 +581,7 @@ u32 mana_run_xdp(struct net_device *ndev, struct mana_rxq *rxq,
 struct bpf_prog *mana_xdp_get(struct mana_port_context *apc);
 void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
-void mana_query_gf_stats(struct mana_port_context *apc);
+void mana_query_gf_stats(struct mana_context *ac);
 int mana_query_link_cfg(struct mana_port_context *apc);
 int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 		      int enable_clamping);
-- 
2.34.1


