Return-Path: <linux-hyperv+bounces-1671-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0F875258
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 15:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A01C1F23233
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA70912EBCB;
	Thu,  7 Mar 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GoX4+C50"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2135D12C80A;
	Thu,  7 Mar 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823135; cv=none; b=f7ttwL4OOSOYBTukfoT4ZT/m+TnVOqoqilGWdb51+2Sd+E5KdZ1KPZmnKRymhseC1fGIBHPnPpAzEvjeYnjJyY9wph0ImbxoyiepNV/n82qZdLRz6tG3S5DSKP2R2shG7CbT+j6tuWSHqwftoiv914FLtuEB5l9FKEXhWzVbEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823135; c=relaxed/simple;
	bh=SVl7ghUZZvLmqoxnJx1TfVNS1aFO+cS/rPtTkMU4lFo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Bh9Rqhnzulkw8xEqf96zhLbvei7DZhey1IFF60+5YcBfvTC8hLq1LHzpwr8IZqps00BjKsKfvV1lnIy+zY1hLG+zPflg3aRSWg7pfDumwodB1OKczv7ntOwptrFhn0idoHYM9lqSf44ZPWhJWlcJPt4p+kVayphvXyRjs8TWdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GoX4+C50; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 8480E20B74C0; Thu,  7 Mar 2024 06:52:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8480E20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709823133;
	bh=DQrX++fk8abFgdjKuqnBcAVgOubzkQFol/TFp+HA04s=;
	h=From:To:Cc:Subject:Date:From;
	b=GoX4+C50fDnqEqTDLUQhX0jEvb2nweO7wCtxXMQfyCEtiaV1gxyaO5Rap/o7qic9e
	 eSjxHeK0NdFqJQmUANMTP0aRr6atuBQktgzhNaWQ9arYXkyfks1vS7OL/jvY3BNDeU
	 Fu/oiiRVCDjsDR+0hLQxeYSHfjLYGp/3JLuk+i7w=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH] net :mana : Add per-cpu stats for MANA device
Date: Thu,  7 Mar 2024 06:52:12 -0800
Message-Id: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Extend 'ethtool -S' output for mana devices to include per-CPU packet
stats

Built-on: Ubuntu22
Tested-on: Ubuntu22
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 22 ++++++++++
 .../ethernet/microsoft/mana/mana_ethtool.c    | 40 ++++++++++++++++++-
 include/net/mana/mana.h                       | 12 ++++++
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 59287c6e6cee..b27ee6684936 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -224,6 +224,7 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	int gso_hs = 0; /* zero for non-GSO pkts */
 	u16 txq_idx = skb_get_queue_mapping(skb);
 	struct gdma_dev *gd = apc->ac->gdma_dev;
+	struct mana_pcpu_stats *pcpu_stats;
 	bool ipv4 = false, ipv6 = false;
 	struct mana_tx_package pkg = {};
 	struct netdev_queue *net_txq;
@@ -234,6 +235,8 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct mana_cq *cq;
 	int err, len;
 
+	pcpu_stats = this_cpu_ptr(apc->pcpu_stats);
+
 	if (unlikely(!apc->port_is_up))
 		goto tx_drop;
 
@@ -412,6 +415,12 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	tx_stats->bytes += len;
 	u64_stats_update_end(&tx_stats->syncp);
 
+	/* Also update the per-CPU stats */
+	u64_stats_update_begin(&pcpu_stats->syncp);
+	pcpu_stats->tx_packets++;
+	pcpu_stats->tx_bytes += len;
+	u64_stats_update_end(&pcpu_stats->syncp);
+
 tx_busy:
 	if (netif_tx_queue_stopped(net_txq) && mana_can_tx(gdma_sq)) {
 		netif_tx_wake_queue(net_txq);
@@ -425,6 +434,9 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	kfree(pkg.sgl_ptr);
 tx_drop_count:
 	ndev->stats.tx_dropped++;
+	u64_stats_update_begin(&pcpu_stats->syncp);
+	pcpu_stats->tx_dropped++;
+	u64_stats_update_end(&pcpu_stats->syncp);
 tx_drop:
 	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
@@ -1505,6 +1517,8 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 	struct mana_stats_rx *rx_stats = &rxq->stats;
 	struct net_device *ndev = rxq->ndev;
 	uint pkt_len = cqe->ppi[0].pkt_len;
+	struct mana_pcpu_stats *pcpu_stats;
+	struct mana_port_context *apc;
 	u16 rxq_idx = rxq->rxq_idx;
 	struct napi_struct *napi;
 	struct xdp_buff xdp = {};
@@ -1512,6 +1526,9 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 	u32 hash_value;
 	u32 act;
 
+	apc = netdev_priv(ndev);
+	pcpu_stats = this_cpu_ptr(apc->pcpu_stats);
+
 	rxq->rx_cq.work_done++;
 	napi = &rxq->rx_cq.napi;
 
@@ -1570,6 +1587,11 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 		rx_stats->xdp_tx++;
 	u64_stats_update_end(&rx_stats->syncp);
 
+	u64_stats_update_begin(&pcpu_stats->syncp);
+	pcpu_stats->rx_packets++;
+	pcpu_stats->rx_bytes += pkt_len;
+	u64_stats_update_end(&pcpu_stats->syncp);
+
 	if (act == XDP_TX) {
 		skb_set_queue_mapping(skb, rxq_idx);
 		mana_xdp_tx(skb, ndev);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index ab2413d71f6c..e3aa47ead601 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -83,8 +83,9 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
 	if (stringset != ETH_SS_STATS)
 		return -EINVAL;
 
-	return ARRAY_SIZE(mana_eth_stats) + num_queues *
-				(MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
+	return ARRAY_SIZE(mana_eth_stats) +
+	       (num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT)) +
+	       (num_present_cpus() * (MANA_STATS_RX_PCPU + MANA_STATS_TX_PCPU));
 }
 
 static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
@@ -139,6 +140,19 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 		sprintf(p, "tx_%d_mana_map_err", i);
 		p += ETH_GSTRING_LEN;
 	}
+
+	for (i = 0; i < num_present_cpus(); i++) {
+		sprintf(p, "cpu%d_rx_packets", i);
+		p += ETH_GSTRING_LEN;
+		sprintf(p, "cpu%d_rx_bytes", i);
+		p += ETH_GSTRING_LEN;
+		sprintf(p, "cpu%d_tx_packets", i);
+		p += ETH_GSTRING_LEN;
+		sprintf(p, "cpu%d_tx_bytes", i);
+		p += ETH_GSTRING_LEN;
+		sprintf(p, "cpu%d_tx_dropped", i);
+		p += ETH_GSTRING_LEN;
+	}
 }
 
 static void mana_get_ethtool_stats(struct net_device *ndev,
@@ -222,6 +236,28 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 		data[i++] = csum_partial;
 		data[i++] = mana_map_err;
 	}
+
+	for_each_possible_cpu(q) {
+		const struct mana_pcpu_stats *pcpu_stats =
+				per_cpu_ptr(apc->pcpu_stats, q);
+		u64 rx_packets, rx_bytes, tx_packets, tx_bytes, tx_dropped;
+		unsigned int start;
+
+		do {
+			start = u64_stats_fetch_begin(&pcpu_stats->syncp);
+			rx_packets = pcpu_stats->rx_packets;
+			tx_packets = pcpu_stats->tx_packets;
+			rx_bytes = pcpu_stats->rx_bytes;
+			tx_bytes = pcpu_stats->tx_bytes;
+			tx_dropped = pcpu_stats->tx_dropped;
+		} while (u64_stats_fetch_retry(&pcpu_stats->syncp, start));
+
+		data[i++] = rx_packets;
+		data[i++] = rx_bytes;
+		data[i++] = tx_packets;
+		data[i++] = tx_bytes;
+		data[i++] = tx_dropped;
+	}
 }
 
 static int mana_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *cmd,
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 76147feb0d10..9a2414ee7f02 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -51,6 +51,8 @@ enum TRI_STATE {
 /* Update this count whenever the respective structures are changed */
 #define MANA_STATS_RX_COUNT 5
 #define MANA_STATS_TX_COUNT 11
+#define MANA_STATS_RX_PCPU 2
+#define MANA_STATS_TX_PCPU 3
 
 struct mana_stats_rx {
 	u64 packets;
@@ -386,6 +388,15 @@ struct mana_ethtool_stats {
 	u64 rx_cqe_unknown_type;
 };
 
+struct mana_pcpu_stats {
+	u64 rx_packets;
+	u64 rx_bytes;
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 tx_dropped;
+	struct u64_stats_sync syncp;
+};
+
 struct mana_context {
 	struct gdma_dev *gdma_dev;
 
@@ -449,6 +460,7 @@ struct mana_port_context {
 	bool port_st_save; /* Saved port state */
 
 	struct mana_ethtool_stats eth_stats;
+	struct mana_pcpu_stats __percpu *pcpu_stats;
 };
 
 netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev);
-- 
2.34.1


