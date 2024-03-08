Return-Path: <linux-hyperv+bounces-1686-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B62876254
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 11:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEE31C212FD
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D47E55C3D;
	Fri,  8 Mar 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pCNqXgUG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D315F55C28;
	Fri,  8 Mar 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894674; cv=none; b=syQHfUBJOutzD+M3ieqkYuNpoAI+SuyfocuOqaVatn2L25ilV45J/rD5WjVpkwsLmfmkNm4muFvGMPFbzHH4AOnLaIA25lR1DugR54lQCr1uJU3ZlRrH7q08ZNE+8ny0foONtXc9+AolZJEWUUvf3ajKM08R4eTOOKH/6PFWisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894674; c=relaxed/simple;
	bh=fHg7qXHl3JJLm+fQ+rA4CU86eh0DEX1FAdwAbKLx4bQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EhFjbHErVXEzYdCZ0zu7j+AOYKmxVvrZdrI0sop6viVQmDXmo4gHxGJZTe/nPvhVic/CJGoH5X5N6TVu2mIn4r/pw+LeERh2wx1ixxbjtUd7VzNInZdHVqmE7PXxW8Ih5NX9YCWjhgD5V1F+zikC1Tb/mDlpgPsgnUZtoDCt31M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pCNqXgUG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 4468720B74C0; Fri,  8 Mar 2024 02:44:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4468720B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709894672;
	bh=FrEnmF2VXHdRIaXf1warOaT/gTc7q2+pSaa4s+pNfQM=;
	h=From:To:Cc:Subject:Date:From;
	b=pCNqXgUGUTxwM9TZzSEz+UeOS+Fovlzx2CPvwxGguf3H4bg6Sgq4/vyIqbl1rA8a4
	 xQRPn5UPuwtQZWgZz4h4yvJSPhcrZWNVrs891nqp1uSP6YZLWSvx048UGkaNR5RLWI
	 cPxZQmKoy2pTHMolQ+dASsuOWmyO1A9E4vsdP0V0=
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
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v2] net :mana : Add per-cpu stats for MANA device
Date: Fri,  8 Mar 2024 02:44:31 -0800
Message-Id: <1709894671-1018-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Extend 'ethtool -S' output for mana devices to include per-CPU packet
stats

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 Changes in v2
 * Corrected the patch description to remove redundant built and
   Tested info
 * Used num_possible_cpus() as suggested
 * Added the missing allocation and deallocation sections for
   per-CPU counters.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 30 ++++++++++++++
 .../ethernet/microsoft/mana/mana_ethtool.c    | 41 ++++++++++++++++++-
 include/net/mana/mana.h                       | 12 ++++++
 3 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 59287c6e6cee..0edf1f9e6dfc 100644
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
@@ -2660,6 +2682,7 @@ int mana_detach(struct net_device *ndev, bool from_close)
 
 	apc->port_st_save = apc->port_is_up;
 	apc->port_is_up = false;
+	free_percpu(apc->pcpu_stats);
 
 	/* Ensure port state updated before txq state */
 	smp_wmb();
@@ -2704,6 +2727,11 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	apc->port_handle = INVALID_MANA_HANDLE;
 	apc->pf_filter_handle = INVALID_MANA_HANDLE;
 	apc->port_idx = port_idx;
+	apc->pcpu_stats = netdev_alloc_pcpu_stats(struct mana_pcpu_stats);
+	if (!apc->pcpu_stats) {
+		err = -ENOMEM;
+		goto no_pcpu_stats;
+	}
 
 	mutex_init(&apc->vport_mutex);
 	apc->vport_use_count = 0;
@@ -2750,6 +2778,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	kfree(apc->rxqs);
 	apc->rxqs = NULL;
 free_net:
+	free_percpu(apc->pcpu_stats);
+no_pcpu_stats:
 	*ndev_storage = NULL;
 	netdev_err(ndev, "Failed to probe vPort %d: %d\n", port_idx, err);
 	free_netdev(ndev);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index ab2413d71f6c..755b249aa904 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -83,8 +83,10 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
 	if (stringset != ETH_SS_STATS)
 		return -EINVAL;
 
-	return ARRAY_SIZE(mana_eth_stats) + num_queues *
-				(MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
+	return ARRAY_SIZE(mana_eth_stats) +
+	       (num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT)) +
+	       (num_possible_cpus() * (MANA_STATS_RX_PCPU +
+				       MANA_STATS_TX_PCPU));
 }
 
 static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
@@ -139,6 +141,19 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 		sprintf(p, "tx_%d_mana_map_err", i);
 		p += ETH_GSTRING_LEN;
 	}
+
+	for (i = 0; i < num_possible_cpus(); i++) {
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
@@ -222,6 +237,28 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
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


