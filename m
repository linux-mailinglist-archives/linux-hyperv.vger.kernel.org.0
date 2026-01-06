Return-Path: <linux-hyperv+bounces-8166-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C98CFB047
	for <lists+linux-hyperv@lfdr.de>; Tue, 06 Jan 2026 21:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1EE23107BBD
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jan 2026 20:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A676311C33;
	Tue,  6 Jan 2026 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rh0gG7i7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898F72E8E12;
	Tue,  6 Jan 2026 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767732452; cv=none; b=SJ2Q90eL/EAmiTyU7xEbeFKIEEL9bOtfgKeWqvqRStpWdgNCfFqBY8lQhLIM7haH4/iGZPP4Zubro+/+o1tyjDr2NNtSch6Fy/iPQKgDo+jL60SX8hnsvBDE5wjKnA4v9WwJNLMAFfQ155kyGiJsz4aniWi39A9KDN8r6u2EuXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767732452; c=relaxed/simple;
	bh=/XUM58x0qMCFVNoXe/qHf9qF+/lV2lREIwujTiNZsRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m3nmZd/XRqNNEyV5cZP0Z95uCXt3qlz41MyDp62pK2uqEI1WDAHVWW1BKZSYpnPqm411sKTSSI9jMMUzttz//Ho0hi4t2oBZ/kdexANo2mRfGZlbCDwNgovVt2nIYWqsISV+xRjWh8Bo/5PTa9AZto0Jt3VrmXXw2z27BeiVV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rh0gG7i7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 461D32016FF6; Tue,  6 Jan 2026 12:47:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 461D32016FF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767732450;
	bh=ILSyG7EhBROqCXYQNMwAVhwbbWcsVbfgTOhIEsrbvDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rh0gG7i7rQh+oouZrBsj28Tuf7dbGxz0Zm6xV6yww+WRduAyFWH8ZJ5qG7uDMJswT
	 62+eA/noO7AKjAnqMy8hczxW7igIQX5tMF6+xAf5nv2V4geXUDiB8AXGYBI26ulgqF
	 fkgHAAa5K1jwEVU38/omfOHYlTW9ywGoAbqzWzj0=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: paulros@microsoft.com
Subject: [PATCH V2,net-next, 2/2] net: mana: Add ethtool counters for RX CQEs in coalesced type
Date: Tue,  6 Jan 2026 12:46:47 -0800
Message-Id: <1767732407-12389-3-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

For RX CQEs with type CQE_RX_COALESCED_4, to measure the coalescing
efficiency, add counters to count how many contains 2, 3, 4 packets
respectively.
Also, add a counter for the error case of first packet with length == 0.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 25 +++++++++++++++++--
 .../ethernet/microsoft/mana/mana_ethtool.c    | 17 ++++++++++---
 include/net/mana/mana.h                       | 10 +++++---
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a46a1adf83bc..78824567d80b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2083,8 +2083,22 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 
 nextpkt:
 	pktlen = oob->ppi[i].pkt_len;
-	if (pktlen == 0)
+	if (pktlen == 0) {
+		/* Collect coalesced CQE count based on packets processed.
+		 * Coalesced CQEs have at least 2 packets, so index is i - 2.
+		 */
+		if (i > 1) {
+			u64_stats_update_begin(&rxq->stats.syncp);
+			rxq->stats.coalesced_cqe[i - 2]++;
+			u64_stats_update_end(&rxq->stats.syncp);
+		} else if (i == 0) {
+			/* Error case stat */
+			u64_stats_update_begin(&rxq->stats.syncp);
+			rxq->stats.pkt_len0_err++;
+			u64_stats_update_end(&rxq->stats.syncp);
+		}
 		return;
+	}
 
 	curr = rxq->buf_index;
 	rxbuf_oob = &rxq->rx_oobs[curr];
@@ -2102,8 +2116,15 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 
 	mana_post_pkt_rxq(rxq);
 
-	if (coalesced && (++i < MANA_RXCOMP_OOB_NUM_PPI))
+	if (!coalesced)
+		return;
+
+	if (++i < MANA_RXCOMP_OOB_NUM_PPI)
 		goto nextpkt;
+
+	u64_stats_update_begin(&rxq->stats.syncp);
+	rxq->stats.coalesced_cqe[MANA_RXCOMP_OOB_NUM_PPI - 2]++;
+	u64_stats_update_end(&rxq->stats.syncp);
 }
 
 static void mana_poll_rx_cq(struct mana_cq *cq)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index b2b9bfb50396..635796bfdaf1 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -20,8 +20,6 @@ static const struct mana_stats_desc mana_eth_stats[] = {
 					tx_cqe_unknown_type)},
 	{"tx_linear_pkt_cnt", offsetof(struct mana_ethtool_stats,
 				       tx_linear_pkt_cnt)},
-	{"rx_coalesced_err", offsetof(struct mana_ethtool_stats,
-					rx_coalesced_err)},
 	{"rx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
 					rx_cqe_unknown_type)},
 };
@@ -151,7 +149,7 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
 	unsigned int num_queues = apc->num_queues;
-	int i;
+	int i, j;
 
 	if (stringset != ETH_SS_STATS)
 		return;
@@ -170,6 +168,9 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 		ethtool_sprintf(&data, "rx_%d_xdp_drop", i);
 		ethtool_sprintf(&data, "rx_%d_xdp_tx", i);
 		ethtool_sprintf(&data, "rx_%d_xdp_redirect", i);
+		ethtool_sprintf(&data, "rx_%d_pkt_len0_err", i);
+		for (j = 0; j < MANA_RXCOMP_OOB_NUM_PPI - 1; j++)
+			ethtool_sprintf(&data, "rx_%d_coalesced_cqe_%d", i, j + 2);
 	}
 
 	for (i = 0; i < num_queues; i++) {
@@ -203,6 +204,8 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	u64 xdp_xmit;
 	u64 xdp_drop;
 	u64 xdp_tx;
+	u64 pkt_len0_err;
+	u64 coalesced_cqe[MANA_RXCOMP_OOB_NUM_PPI - 1];
 	u64 tso_packets;
 	u64 tso_bytes;
 	u64 tso_inner_packets;
@@ -211,7 +214,7 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	u64 short_pkt_fmt;
 	u64 csum_partial;
 	u64 mana_map_err;
-	int q, i = 0;
+	int q, i = 0, j;
 
 	if (!apc->port_is_up)
 		return;
@@ -241,6 +244,9 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 			xdp_drop = rx_stats->xdp_drop;
 			xdp_tx = rx_stats->xdp_tx;
 			xdp_redirect = rx_stats->xdp_redirect;
+			pkt_len0_err = rx_stats->pkt_len0_err;
+			for (j = 0; j < MANA_RXCOMP_OOB_NUM_PPI - 1; j++)
+				coalesced_cqe[j] = rx_stats->coalesced_cqe[j];
 		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
 
 		data[i++] = packets;
@@ -248,6 +254,9 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 		data[i++] = xdp_drop;
 		data[i++] = xdp_tx;
 		data[i++] = xdp_redirect;
+		data[i++] = pkt_len0_err;
+		for (j = 0; j < MANA_RXCOMP_OOB_NUM_PPI - 1; j++)
+			data[i++] = coalesced_cqe[j];
 	}
 
 	for (q = 0; q < num_queues; q++) {
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 51d26ebeff6c..f8dd19860103 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -61,8 +61,11 @@ enum TRI_STATE {
 
 #define MAX_PORTS_IN_MANA_DEV 256
 
+/* Maximum number of packets per coalesced CQE */
+#define MANA_RXCOMP_OOB_NUM_PPI 4
+
 /* Update this count whenever the respective structures are changed */
-#define MANA_STATS_RX_COUNT 5
+#define MANA_STATS_RX_COUNT (6 + MANA_RXCOMP_OOB_NUM_PPI - 1)
 #define MANA_STATS_TX_COUNT 11
 
 #define MANA_RX_FRAG_ALIGNMENT 64
@@ -73,6 +76,8 @@ struct mana_stats_rx {
 	u64 xdp_drop;
 	u64 xdp_tx;
 	u64 xdp_redirect;
+	u64 pkt_len0_err;
+	u64 coalesced_cqe[MANA_RXCOMP_OOB_NUM_PPI - 1];
 	struct u64_stats_sync syncp;
 };
 
@@ -227,8 +232,6 @@ struct mana_rxcomp_perpkt_info {
 	u32 pkt_hash;
 }; /* HW DATA */
 
-#define MANA_RXCOMP_OOB_NUM_PPI 4
-
 /* Receive completion OOB */
 struct mana_rxcomp_oob {
 	struct mana_cqe_header cqe_hdr;
@@ -378,7 +381,6 @@ struct mana_ethtool_stats {
 	u64 tx_cqe_err;
 	u64 tx_cqe_unknown_type;
 	u64 tx_linear_pkt_cnt;
-	u64 rx_coalesced_err;
 	u64 rx_cqe_unknown_type;
 };
 
-- 
2.34.1


