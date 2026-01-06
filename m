Return-Path: <linux-hyperv+bounces-8165-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8475CFAFD8
	for <lists+linux-hyperv@lfdr.de>; Tue, 06 Jan 2026 21:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA7D9304F2C1
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jan 2026 20:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AB42C0F6F;
	Tue,  6 Jan 2026 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s03yhNUx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B47329D293;
	Tue,  6 Jan 2026 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767732437; cv=none; b=oruu7awr/ZSNd4HfsLdA5EdPDReHK1Z7xf+ZlH+A+SUgc7jYvKFywsFYQ4VtP9O4bHoDewHDdFInJAO+5FVOeK+KTCG8k934vz2TRLKVGivXBFT3hZ+N6O1SmPa8288EbUVY6ycPXG4bU9BO7T0ZL7NVw1x2Poborb6ThT348sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767732437; c=relaxed/simple;
	bh=HFg4PDmsYeHdWxuOj2B29+aqDm4Hxy3XUk+zmloxa6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=f0ZemVaoyEdMwEa0H5gnq3+mZWttP67JhX7g7Ys1+49b8xuO8CNigXDJoYOXRAXVQUo7AdBF+AA9igtFSqjd2R+RhaSOmugivqo2Qj8UZ0k9Pq+JEBla6lMPo0hHHtePJjmpteHaL0kyOo8GoEvXTbGSKsznUmZSHum/vFydIW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s03yhNUx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id B15B82016FF5; Tue,  6 Jan 2026 12:47:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B15B82016FF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767732435;
	bh=j1Ue0DpzptuEADthEOV8JVMQKNZY7vwDj8mfrjhwUj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s03yhNUx1Nvow5qnTkgR4APVlz6IvDn8Nz91CuGNI4ytzh4vnSgnyPwU5e0QbhZOt
	 ws2SDusTwzxV8Kpagd/NnNf7eGGpjMXyJxcP13iXNuDnHLFrL5XwNVM5j6IcJOPrsK
	 wLbQIOO9R/r8s7rTY1DushZvcartO3FXNrUZKlQc=
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
Subject: [PATCH V2,net-next, 1/2] net: mana: Add support for coalesced RX packets on CQE
Date: Tue,  6 Jan 2026 12:46:46 -0800
Message-Id: <1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

Our NIC can have up to 4 RX packets on 1 CQE. To support this feature,
check and process the type CQE_RX_COALESCED_4. The default setting is
disabled, to avoid possible regression on latency.

And add ethtool handler to switch this feature. To turn it on, run:
  ethtool -C <nic> rx-frames 4
To turn it off:
  ethtool -C <nic> rx-frames 1

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
V2:
  Updated extack msg, as recommended by Jakub Kicinski, and Simon Horman.

---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 32 ++++++-----
 .../ethernet/microsoft/mana/mana_ethtool.c    | 55 +++++++++++++++++++
 include/net/mana/mana.h                       |  2 +
 3 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 1ad154f9db1a..a46a1adf83bc 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1330,7 +1330,7 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	req->update_hashkey = update_key;
 	req->update_indir_tab = update_tab;
 	req->default_rxobj = apc->default_rxobj;
-	req->cqe_coalescing_enable = 0;
+	req->cqe_coalescing_enable = apc->cqe_coalescing_enable;
 
 	if (update_key)
 		memcpy(&req->hashkey, apc->hashkey, MANA_HASH_KEY_SIZE);
@@ -1864,11 +1864,12 @@ static struct sk_buff *mana_build_skb(struct mana_rxq *rxq, void *buf_va,
 }
 
 static void mana_rx_skb(void *buf_va, bool from_pool,
-			struct mana_rxcomp_oob *cqe, struct mana_rxq *rxq)
+			struct mana_rxcomp_oob *cqe, struct mana_rxq *rxq,
+			int i)
 {
 	struct mana_stats_rx *rx_stats = &rxq->stats;
 	struct net_device *ndev = rxq->ndev;
-	uint pkt_len = cqe->ppi[0].pkt_len;
+	uint pkt_len = cqe->ppi[i].pkt_len;
 	u16 rxq_idx = rxq->rxq_idx;
 	struct napi_struct *napi;
 	struct xdp_buff xdp = {};
@@ -1912,7 +1913,7 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 	}
 
 	if (cqe->rx_hashtype != 0 && (ndev->features & NETIF_F_RXHASH)) {
-		hash_value = cqe->ppi[0].pkt_hash;
+		hash_value = cqe->ppi[i].pkt_hash;
 
 		if (cqe->rx_hashtype & MANA_HASH_L4)
 			skb_set_hash(skb, hash_value, PKT_HASH_TYPE_L4);
@@ -2047,9 +2048,11 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 	struct mana_recv_buf_oob *rxbuf_oob;
 	struct mana_port_context *apc;
 	struct device *dev = gc->dev;
+	bool coalesced = false;
 	void *old_buf = NULL;
 	u32 curr, pktlen;
 	bool old_fp;
+	int i = 0;
 
 	apc = netdev_priv(ndev);
 
@@ -2064,9 +2067,8 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 		goto drop;
 
 	case CQE_RX_COALESCED_4:
-		netdev_err(ndev, "RX coalescing is unsupported\n");
-		apc->eth_stats.rx_coalesced_err++;
-		return;
+		coalesced = true;
+		break;
 
 	case CQE_RX_OBJECT_FENCE:
 		complete(&rxq->fence_event);
@@ -2079,14 +2081,10 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 		return;
 	}
 
-	pktlen = oob->ppi[0].pkt_len;
-
-	if (pktlen == 0) {
-		/* data packets should never have packetlength of zero */
-		netdev_err(ndev, "RX pkt len=0, rq=%u, cq=%u, rxobj=0x%llx\n",
-			   rxq->gdma_id, cq->gdma_id, rxq->rxobj);
+nextpkt:
+	pktlen = oob->ppi[i].pkt_len;
+	if (pktlen == 0)
 		return;
-	}
 
 	curr = rxq->buf_index;
 	rxbuf_oob = &rxq->rx_oobs[curr];
@@ -2097,12 +2095,15 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 	/* Unsuccessful refill will have old_buf == NULL.
 	 * In this case, mana_rx_skb() will drop the packet.
 	 */
-	mana_rx_skb(old_buf, old_fp, oob, rxq);
+	mana_rx_skb(old_buf, old_fp, oob, rxq, i);
 
 drop:
 	mana_move_wq_tail(rxq->gdma_rq, rxbuf_oob->wqe_inf.wqe_size_in_bu);
 
 	mana_post_pkt_rxq(rxq);
+
+	if (coalesced && (++i < MANA_RXCOMP_OOB_NUM_PPI))
+		goto nextpkt;
 }
 
 static void mana_poll_rx_cq(struct mana_cq *cq)
@@ -3276,6 +3277,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	apc->port_handle = INVALID_MANA_HANDLE;
 	apc->pf_filter_handle = INVALID_MANA_HANDLE;
 	apc->port_idx = port_idx;
+	apc->cqe_coalescing_enable = 0;
 
 	mutex_init(&apc->vport_mutex);
 	apc->vport_use_count = 0;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 0e2f4343ac67..b2b9bfb50396 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -397,6 +397,58 @@ static void mana_get_channels(struct net_device *ndev,
 	channel->combined_count = apc->num_queues;
 }
 
+static int mana_get_coalesce(struct net_device *ndev,
+			     struct ethtool_coalesce *ec,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct mana_port_context *apc = netdev_priv(ndev);
+
+	ec->rx_max_coalesced_frames =
+		apc->cqe_coalescing_enable ? MANA_RXCOMP_OOB_NUM_PPI : 1;
+
+	return 0;
+}
+
+static int mana_set_coalesce(struct net_device *ndev,
+			     struct ethtool_coalesce *ec,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct mana_port_context *apc = netdev_priv(ndev);
+	u8 saved_cqe_coalescing_enable;
+	int err;
+
+	if (ec->rx_max_coalesced_frames != 1 &&
+	    ec->rx_max_coalesced_frames != MANA_RXCOMP_OOB_NUM_PPI) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "rx-frames must be 1 or %u, got %u",
+				   MANA_RXCOMP_OOB_NUM_PPI,
+				   ec->rx_max_coalesced_frames);
+		return -EINVAL;
+	}
+
+	saved_cqe_coalescing_enable = apc->cqe_coalescing_enable;
+	apc->cqe_coalescing_enable =
+		ec->rx_max_coalesced_frames == MANA_RXCOMP_OOB_NUM_PPI;
+
+	if (!apc->port_is_up)
+		return 0;
+
+	err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
+
+	if (err) {
+		netdev_err(ndev, "Set rx-frames to %u failed:%d\n",
+			   ec->rx_max_coalesced_frames, err);
+		NL_SET_ERR_MSG_FMT(extack, "Set rx-frames to %u failed",
+				   ec->rx_max_coalesced_frames);
+
+		apc->cqe_coalescing_enable = saved_cqe_coalescing_enable;
+	}
+
+	return err;
+}
+
 static int mana_set_channels(struct net_device *ndev,
 			     struct ethtool_channels *channels)
 {
@@ -517,6 +569,7 @@ static int mana_get_link_ksettings(struct net_device *ndev,
 }
 
 const struct ethtool_ops mana_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
 	.get_strings		= mana_get_strings,
@@ -527,6 +580,8 @@ const struct ethtool_ops mana_ethtool_ops = {
 	.set_rxfh		= mana_set_rxfh,
 	.get_channels		= mana_get_channels,
 	.set_channels		= mana_set_channels,
+	.get_coalesce		= mana_get_coalesce,
+	.set_coalesce		= mana_set_coalesce,
 	.get_ringparam          = mana_get_ringparam,
 	.set_ringparam          = mana_set_ringparam,
 	.get_link_ksettings	= mana_get_link_ksettings,
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index d7e089c6b694..51d26ebeff6c 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -556,6 +556,8 @@ struct mana_port_context {
 	bool port_is_up;
 	bool port_st_save; /* Saved port state */
 
+	u8 cqe_coalescing_enable;
+
 	struct mana_ethtool_stats eth_stats;
 
 	struct mana_ethtool_phy_stats phy_stats;
-- 
2.34.1


