Return-Path: <linux-hyperv+bounces-9179-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E5NB31hq2mmcgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9179-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 00:21:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA7B22896E
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 00:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D42CD3037929
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 23:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F5C371D0D;
	Fri,  6 Mar 2026 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AQjcwHaE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB182DE709;
	Fri,  6 Mar 2026 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839284; cv=none; b=kL4zA8gYHxpcGxpP1XOhRC3guQfEcKbk7ZVdCE48/TzS44R9pz6hRr7mM4k31EjRaVvZrXTmsUdjMJjIGkcjN17S16eUUYTTXPz4JjXb7Hu1jwnoVvUbwxDSsGjPGwSs7LTcVX7l/waTvxZCLYs+BOkfNW/XUORGprY7F85O53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839284; c=relaxed/simple;
	bh=GU6VUvAZ6ojyiNUYsdAm/fP8o5P8tUiDZylrLI9PQCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/XUDlDPaf9yWbN8r+8tKIShC6WO+s5XWYizAAHGEcOVmWUpez5g6j4sgXz6foLvGBodkrClFp3UTx1ykBDsjaM24es9W6Zo1GDLvfbTC+ui9L3BTQYrcdQf2rliOO7QznpZjmYGtfuJGsdbmxVp/zjl0LltNGsgkdPrgWlj4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AQjcwHaE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 52FB620B6F03; Fri,  6 Mar 2026 15:21:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 52FB620B6F03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772839283;
	bh=VzDREWF7Ctdo0x+coyfVJnKr+oa/gkmyXdLzLJYj2M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQjcwHaE6Uc0st14MWMPfjWsgW8gJLwXKV/JWweQ3Q2YSVHu/8qI/ndqu17CxUtFk
	 ohb4/wHjUU/HzwzydJgZF2P+PVqUw2itoG/qZ5Abd2jIaigCghJNs66efg8aBS1ZYd
	 60aeMJca7aPhi8L3siPGS9zGfxwAuhJGX1VO4qCo=
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
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Breno Leitao <leitao@debian.org>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: paulros@microsoft.com
Subject: [PATCH net-next,V3, 2/3] net: mana: Add support for RX CQE Coalescing
Date: Fri,  6 Mar 2026 15:19:14 -0800
Message-ID: <20260306231936.549499-3-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260306231936.549499-1-haiyangz@linux.microsoft.com>
References: <20260306231936.549499-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8EA7B22896E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-9179-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Haiyang Zhang <haiyangz@microsoft.com>

Our NIC can have up to 4 RX packets on 1 CQE. To support this feature,
check and process the type CQE_RX_COALESCED_4. The default setting is
disabled, to avoid possible regression on latency.

And, add ethtool handler to switch this feature. To turn it on, run:
  ethtool -C <nic> rx-cqe-frames 4
To turn it off:
  ethtool -C <nic> rx-cqe-frames 1

The rx-cqe-nsec is the time out value in nanoseconds after the first
packet arrival in a coalesced CQE to be sent. It's read-only for this
NIC.

Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 72 ++++++++++++-------
 .../ethernet/microsoft/mana/mana_ethtool.c    | 60 +++++++++++++++-
 include/net/mana/mana.h                       |  8 ++-
 3 files changed, 111 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ea71de39f996..c06fec50e51f 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1365,6 +1365,7 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 			     sizeof(resp));
 
 	req->hdr.req.msg_version = GDMA_MESSAGE_V2;
+	req->hdr.resp.msg_version = GDMA_MESSAGE_V2;
 
 	req->vport = apc->port_handle;
 	req->num_indir_entries = apc->indir_table_sz;
@@ -1376,7 +1377,9 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	req->update_hashkey = update_key;
 	req->update_indir_tab = update_tab;
 	req->default_rxobj = apc->default_rxobj;
-	req->cqe_coalescing_enable = 0;
+
+	if (rx != TRI_STATE_FALSE)
+		req->cqe_coalescing_enable = apc->cqe_coalescing_enable;
 
 	if (update_key)
 		memcpy(&req->hashkey, apc->hashkey, MANA_HASH_KEY_SIZE);
@@ -1407,6 +1410,10 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 		err = -EPROTO;
 	}
 
+	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2)
+		apc->cqe_coalescing_timeout_ns =
+			resp.cqe_coalescing_timeout_ns;
+
 	netdev_info(ndev, "Configured steering vPort %llu entries %u\n",
 		    apc->port_handle, apc->indir_table_sz);
 out:
@@ -1915,11 +1922,12 @@ static struct sk_buff *mana_build_skb(struct mana_rxq *rxq, void *buf_va,
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
@@ -1963,7 +1971,7 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 	}
 
 	if (cqe->rx_hashtype != 0 && (ndev->features & NETIF_F_RXHASH)) {
-		hash_value = cqe->ppi[0].pkt_hash;
+		hash_value = cqe->ppi[i].pkt_hash;
 
 		if (cqe->rx_hashtype & MANA_HASH_L4)
 			skb_set_hash(skb, hash_value, PKT_HASH_TYPE_L4);
@@ -2098,9 +2106,11 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 	struct mana_recv_buf_oob *rxbuf_oob;
 	struct mana_port_context *apc;
 	struct device *dev = gc->dev;
+	bool coalesced = false;
 	void *old_buf = NULL;
 	u32 curr, pktlen;
 	bool old_fp;
+	int i;
 
 	apc = netdev_priv(ndev);
 
@@ -2112,13 +2122,16 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 		++ndev->stats.rx_dropped;
 		rxbuf_oob = &rxq->rx_oobs[rxq->buf_index];
 		netdev_warn_once(ndev, "Dropped a truncated packet\n");
-		goto drop;
 
-	case CQE_RX_COALESCED_4:
-		netdev_err(ndev, "RX coalescing is unsupported\n");
-		apc->eth_stats.rx_coalesced_err++;
+		mana_move_wq_tail(rxq->gdma_rq,
+				  rxbuf_oob->wqe_inf.wqe_size_in_bu);
+		mana_post_pkt_rxq(rxq);
 		return;
 
+	case CQE_RX_COALESCED_4:
+		coalesced = true;
+		break;
+
 	case CQE_RX_OBJECT_FENCE:
 		complete(&rxq->fence_event);
 		return;
@@ -2130,30 +2143,36 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 		return;
 	}
 
-	pktlen = oob->ppi[0].pkt_len;
+	for (i = 0; i < MANA_RXCOMP_OOB_NUM_PPI; i++) {
+		pktlen = oob->ppi[i].pkt_len;
+		if (pktlen == 0) {
+			if (i == 0)
+				netdev_err_once(
+					ndev,
+					"RX pkt len=0, rq=%u, cq=%u, rxobj=0x%llx\n",
+					rxq->gdma_id, cq->gdma_id, rxq->rxobj);
+			break;
+		}
 
-	if (pktlen == 0) {
-		/* data packets should never have packetlength of zero */
-		netdev_err(ndev, "RX pkt len=0, rq=%u, cq=%u, rxobj=0x%llx\n",
-			   rxq->gdma_id, cq->gdma_id, rxq->rxobj);
-		return;
-	}
+		curr = rxq->buf_index;
+		rxbuf_oob = &rxq->rx_oobs[curr];
+		WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu != 1);
 
-	curr = rxq->buf_index;
-	rxbuf_oob = &rxq->rx_oobs[curr];
-	WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu != 1);
+		mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
 
-	mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
+		/* Unsuccessful refill will have old_buf == NULL.
+		 * In this case, mana_rx_skb() will drop the packet.
+		 */
+		mana_rx_skb(old_buf, old_fp, oob, rxq, i);
 
-	/* Unsuccessful refill will have old_buf == NULL.
-	 * In this case, mana_rx_skb() will drop the packet.
-	 */
-	mana_rx_skb(old_buf, old_fp, oob, rxq);
+		mana_move_wq_tail(rxq->gdma_rq,
+				  rxbuf_oob->wqe_inf.wqe_size_in_bu);
 
-drop:
-	mana_move_wq_tail(rxq->gdma_rq, rxbuf_oob->wqe_inf.wqe_size_in_bu);
+		mana_post_pkt_rxq(rxq);
 
-	mana_post_pkt_rxq(rxq);
+		if (!coalesced)
+			break;
+	}
 }
 
 static void mana_poll_rx_cq(struct mana_cq *cq)
@@ -3332,6 +3351,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	apc->port_handle = INVALID_MANA_HANDLE;
 	apc->pf_filter_handle = INVALID_MANA_HANDLE;
 	apc->port_idx = port_idx;
+	apc->cqe_coalescing_enable = 0;
 
 	mutex_init(&apc->vport_mutex);
 	apc->vport_use_count = 0;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index f2d220b371b5..4b234b16e57a 100644
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
@@ -390,6 +388,61 @@ static void mana_get_channels(struct net_device *ndev,
 	channel->combined_count = apc->num_queues;
 }
 
+#define MANA_RX_CQE_NSEC_DEF 2048
+static int mana_get_coalesce(struct net_device *ndev,
+			     struct ethtool_coalesce *ec,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct mana_port_context *apc = netdev_priv(ndev);
+
+	kernel_coal->rx_cqe_frames =
+		apc->cqe_coalescing_enable ? MANA_RXCOMP_OOB_NUM_PPI : 1;
+
+	kernel_coal->rx_cqe_nsecs = apc->cqe_coalescing_timeout_ns;
+
+	/* Return the default timeout value for old FW not providing
+	 * this value.
+	 */
+	if (apc->port_is_up && apc->cqe_coalescing_enable &&
+	    !kernel_coal->rx_cqe_nsecs)
+		kernel_coal->rx_cqe_nsecs = MANA_RX_CQE_NSEC_DEF;
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
+	if (kernel_coal->rx_cqe_frames != 1 &&
+	    kernel_coal->rx_cqe_frames != MANA_RXCOMP_OOB_NUM_PPI) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "rx-frames must be 1 or %u, got %u",
+				   MANA_RXCOMP_OOB_NUM_PPI,
+				   kernel_coal->rx_cqe_frames);
+		return -EINVAL;
+	}
+
+	saved_cqe_coalescing_enable = apc->cqe_coalescing_enable;
+	apc->cqe_coalescing_enable =
+		kernel_coal->rx_cqe_frames == MANA_RXCOMP_OOB_NUM_PPI;
+
+	if (!apc->port_is_up)
+		return 0;
+
+	err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
+	if (err)
+		apc->cqe_coalescing_enable = saved_cqe_coalescing_enable;
+
+	return err;
+}
+
 static int mana_set_channels(struct net_device *ndev,
 			     struct ethtool_channels *channels)
 {
@@ -510,6 +563,7 @@ static int mana_get_link_ksettings(struct net_device *ndev,
 }
 
 const struct ethtool_ops mana_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_CQE_FRAMES,
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
 	.get_strings		= mana_get_strings,
@@ -520,6 +574,8 @@ const struct ethtool_ops mana_ethtool_ops = {
 	.set_rxfh		= mana_set_rxfh,
 	.get_channels		= mana_get_channels,
 	.set_channels		= mana_set_channels,
+	.get_coalesce		= mana_get_coalesce,
+	.set_coalesce		= mana_set_coalesce,
 	.get_ringparam          = mana_get_ringparam,
 	.set_ringparam          = mana_set_ringparam,
 	.get_link_ksettings	= mana_get_link_ksettings,
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index a078af283bdd..a7f89e7ddc56 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -378,7 +378,6 @@ struct mana_ethtool_stats {
 	u64 tx_cqe_err;
 	u64 tx_cqe_unknown_type;
 	u64 tx_linear_pkt_cnt;
-	u64 rx_coalesced_err;
 	u64 rx_cqe_unknown_type;
 };
 
@@ -557,6 +556,9 @@ struct mana_port_context {
 	bool port_is_up;
 	bool port_st_save; /* Saved port state */
 
+	u8 cqe_coalescing_enable;
+	u32 cqe_coalescing_timeout_ns;
+
 	struct mana_ethtool_stats eth_stats;
 
 	struct mana_ethtool_phy_stats phy_stats;
@@ -902,6 +904,10 @@ struct mana_cfg_rx_steer_req_v2 {
 
 struct mana_cfg_rx_steer_resp {
 	struct gdma_resp_hdr hdr;
+
+	/* V2 */
+	u32 cqe_coalescing_timeout_ns;
+	u32 reserved1;
 }; /* HW DATA */
 
 /* Register HW vPort */
-- 
2.34.1


