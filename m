Return-Path: <linux-hyperv+bounces-2561-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5425E930D09
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jul 2024 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7623E1C2085A
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jul 2024 03:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0063218307F;
	Mon, 15 Jul 2024 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HOTdTJot"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FDB1369B6;
	Mon, 15 Jul 2024 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721014823; cv=none; b=J00hFNfWsXnII9ZlTz9IcwZawtWZD1MZhkgWj9XQyQeRcp1f2D9xfsKpi+xYoNpINjK9K70Dh+TlyyISPCWCgWlATKYwFkhdUfVL6xRooGl01eq093hUDpjCkS1Nzd5D5pgv0CTaZLMAR3S3zPUH7kmBS6koPKghyoSb5rVxBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721014823; c=relaxed/simple;
	bh=kZGTKnTJxJGvlxR/aiSaUJIRZ9Zwl5h+ktjb/EwH3A8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AZ/oO1fYqpwpt3TSZE8J/Vsi8eeG0W3Ft4QTnN4o4RrkngT1xFrjdMQiVVIoeefKKReCSMavmKUisdP+XkH7EtoE+lrdtVai9/UeSDY4O0qCj9KLnxeeKcZUelhZrVdOlK11R22NiteGhfFok5G3jIN5iqbW87LRQerWCXtnKIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HOTdTJot; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id CB3C820B7177; Sun, 14 Jul 2024 20:40:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB3C820B7177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721014821;
	bh=UfdRbJ5OLVLdU1O2qNfawhqJrF9dYqQGQBz7ihEobtc=;
	h=From:To:Cc:Subject:Date:From;
	b=HOTdTJot6OIwIaPopU3n0HbsXQFArH/Nk3vs+/xPEFOd3w1RGHdiFStFwGph2jDiD
	 tXfsBTvUj+OzC/Xpsc8LaEbBuLyoXv/+Po1dbmvW72JLWTL/4QSdOT+ONtu1G12Ioh
	 T4QIFBxJWMcKKh83AUUqpABcGnypgLwwxg4j5Jw4=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>
Subject: [PATCH net-next] net: mana: Implement get_ringparam/set_ringparam for mana
Date: Sun, 14 Jul 2024 20:40:20 -0700
Message-Id: <1721014820-2507-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Currently the values of WQs for RX and TX queues for MANA devices
are hardcoded to default sizes.
Allow configuring these values for MANA devices as ringparam
configuration(get/set) through ethtool_ops.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 20 +++--
 .../ethernet/microsoft/mana/mana_ethtool.c    | 79 +++++++++++++++++++
 include/net/mana/mana.h                       | 21 ++++-
 3 files changed, 109 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 91f10910ea44..31355a95e891 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -618,7 +618,7 @@ static int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu)
 
 	dev = mpc->ac->gdma_dev->gdma_context->dev;
 
-	num_rxb = mpc->num_queues * RX_BUFFERS_PER_QUEUE;
+	num_rxb = mpc->num_queues * mpc->rx_queue_size;
 
 	WARN(mpc->rxbufs_pre, "mana rxbufs_pre exists\n");
 	mpc->rxbufs_pre = kmalloc_array(num_rxb, sizeof(void *), GFP_KERNEL);
@@ -1899,14 +1899,15 @@ static int mana_create_txq(struct mana_port_context *apc,
 		return -ENOMEM;
 
 	/*  The minimum size of the WQE is 32 bytes, hence
-	 *  MAX_SEND_BUFFERS_PER_QUEUE represents the maximum number of WQEs
+	 *  apc->tx_queue_size represents the maximum number of WQEs
 	 *  the SQ can store. This value is then used to size other queues
 	 *  to prevent overflow.
+	 *  Also note that the txq_size is always going to be MANA_PAGE_ALIGNED,
+	 *  as tx_queue_size is always a power of 2.
 	 */
-	txq_size = MAX_SEND_BUFFERS_PER_QUEUE * 32;
-	BUILD_BUG_ON(!MANA_PAGE_ALIGNED(txq_size));
+	txq_size = apc->tx_queue_size * 32;
 
-	cq_size = MAX_SEND_BUFFERS_PER_QUEUE * COMP_ENTRY_SIZE;
+	cq_size = apc->tx_queue_size * COMP_ENTRY_SIZE;
 	cq_size = MANA_PAGE_ALIGN(cq_size);
 
 	gc = gd->gdma_context;
@@ -2145,10 +2146,11 @@ static int mana_push_wqe(struct mana_rxq *rxq)
 
 static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
 {
+	struct mana_port_context *mpc = netdev_priv(rxq->ndev);
 	struct page_pool_params pprm = {};
 	int ret;
 
-	pprm.pool_size = RX_BUFFERS_PER_QUEUE;
+	pprm.pool_size = mpc->rx_queue_size;
 	pprm.nid = gc->numa_node;
 	pprm.napi = &rxq->rx_cq.napi;
 	pprm.netdev = rxq->ndev;
@@ -2180,13 +2182,13 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	gc = gd->gdma_context;
 
-	rxq = kzalloc(struct_size(rxq, rx_oobs, RX_BUFFERS_PER_QUEUE),
+	rxq = kzalloc(struct_size(rxq, rx_oobs, apc->rx_queue_size),
 		      GFP_KERNEL);
 	if (!rxq)
 		return NULL;
 
 	rxq->ndev = ndev;
-	rxq->num_rx_buf = RX_BUFFERS_PER_QUEUE;
+	rxq->num_rx_buf = apc->rx_queue_size;
 	rxq->rxq_idx = rxq_idx;
 	rxq->rxobj = INVALID_MANA_HANDLE;
 
@@ -2734,6 +2736,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	apc->ndev = ndev;
 	apc->max_queues = gc->max_num_queues;
 	apc->num_queues = gc->max_num_queues;
+	apc->tx_queue_size = DEF_TX_BUFFERS_PER_QUEUE;
+	apc->rx_queue_size = DEF_RX_BUFFERS_PER_QUEUE;
 	apc->port_handle = INVALID_MANA_HANDLE;
 	apc->pf_filter_handle = INVALID_MANA_HANDLE;
 	apc->port_idx = port_idx;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 146d5db1792f..7a4752dda7b8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -369,6 +369,83 @@ static int mana_set_channels(struct net_device *ndev,
 	return err;
 }
 
+static void mana_get_ringparam(struct net_device *ndev,
+			       struct ethtool_ringparam *ring,
+			       struct kernel_ethtool_ringparam *kernel_ring,
+			       struct netlink_ext_ack *extack)
+{
+	struct mana_port_context *apc = netdev_priv(ndev);
+
+	ring->rx_pending = apc->rx_queue_size;
+	ring->tx_pending = apc->tx_queue_size;
+	ring->rx_max_pending = MAX_RX_BUFFERS_PER_QUEUE;
+	ring->tx_max_pending = MAX_TX_BUFFERS_PER_QUEUE;
+}
+
+static int mana_set_ringparam(struct net_device *ndev,
+			      struct ethtool_ringparam *ring,
+			      struct kernel_ethtool_ringparam *kernel_ring,
+			      struct netlink_ext_ack *extack)
+{
+	struct mana_port_context *apc = netdev_priv(ndev);
+	u32 new_tx, new_rx;
+	u32 old_tx, old_rx;
+	int err1, err2;
+
+	if (ring->rx_jumbo_pending) {
+		netdev_err(ndev, "%s: rx_jumbo_pending not supported\n", __func__);
+		return -EINVAL;
+	}
+	if (ring->rx_mini_pending) {
+		netdev_err(ndev, "%s: rx_mini_pending not supported\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!apc)
+		return -EINVAL;
+
+	old_tx = apc->tx_queue_size;
+	old_rx = apc->rx_queue_size;
+	new_tx = clamp_t(u32, ring->tx_pending, MIN_TX_BUFFERS_PER_QUEUE, MAX_TX_BUFFERS_PER_QUEUE);
+	new_rx = clamp_t(u32, ring->rx_pending, MIN_RX_BUFFERS_PER_QUEUE, MAX_RX_BUFFERS_PER_QUEUE);
+
+	if (new_tx == old_tx && new_rx == old_rx)
+		return 0;
+
+	if (!is_power_of_2(new_tx)) {
+		netdev_err(ndev, "%s:Tx:%d not supported\n", __func__, new_tx);
+		return -EINVAL;
+	}
+
+	if (!is_power_of_2(new_rx)) {
+		netdev_err(ndev, "%s:Rx:%d not supported\n", __func__, new_rx);
+		return -EINVAL;
+	}
+
+	err1 = mana_detach(ndev, false);
+	if (err1) {
+		netdev_err(ndev, "mana_detach failed: %d\n", err1);
+		return err1;
+	}
+
+	apc->tx_queue_size = new_tx;
+	apc->rx_queue_size = new_rx;
+	err1 = mana_attach(ndev);
+	if (!err1)
+		return 0;
+
+	netdev_err(ndev, "mana_attach failed: %d\n", err1);
+
+	/* Try rolling back to the older values */
+	apc->tx_queue_size = old_tx;
+	apc->rx_queue_size = old_rx;
+	err2 = mana_attach(ndev);
+	if (err2)
+		netdev_err(ndev, "mana_reattach failed: %d\n", err2);
+
+	return err1;
+}
+
 const struct ethtool_ops mana_ethtool_ops = {
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
@@ -380,4 +457,6 @@ const struct ethtool_ops mana_ethtool_ops = {
 	.set_rxfh		= mana_set_rxfh,
 	.get_channels		= mana_get_channels,
 	.set_channels		= mana_set_channels,
+	.get_ringparam          = mana_get_ringparam,
+	.set_ringparam          = mana_set_ringparam,
 };
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index e39b8676fe54..3e27ca5155aa 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -38,9 +38,21 @@ enum TRI_STATE {
 
 #define COMP_ENTRY_SIZE 64
 
-#define RX_BUFFERS_PER_QUEUE 512
+/* This Max value for RX buffers is derived from __alloc_page()'s max page
+ * allocation calculation. It allows maximum 2^(MAX_ORDER -1) pages. RX buffer
+ * size beyond this value gets rejected by __alloc_page() call.
+ */
+#define MAX_RX_BUFFERS_PER_QUEUE 8192
+#define DEF_RX_BUFFERS_PER_QUEUE 512
+#define MIN_RX_BUFFERS_PER_QUEUE 128
 
-#define MAX_SEND_BUFFERS_PER_QUEUE 256
+/* This max value for TX buffers is dervied as the maximum allocatable
+ * pages supported on host per guest through testing. TX buffer size beyond
+ * this value is rejected by the hardware.
+ */
+#define MAX_TX_BUFFERS_PER_QUEUE 16384
+#define DEF_TX_BUFFERS_PER_QUEUE 256
+#define MIN_TX_BUFFERS_PER_QUEUE 128
 
 #define EQ_SIZE (8 * MANA_PAGE_SIZE)
 
@@ -285,7 +297,7 @@ struct mana_recv_buf_oob {
 	void *buf_va;
 	bool from_pool; /* allocated from a page pool */
 
-	/* SGL of the buffer going to be sent has part of the work request. */
+	/* SGL of the buffer going to be sent as part of the work request. */
 	u32 num_sge;
 	struct gdma_sge sgl[MAX_RX_WQE_SGL_ENTRIES];
 
@@ -437,6 +449,9 @@ struct mana_port_context {
 	unsigned int max_queues;
 	unsigned int num_queues;
 
+	unsigned int rx_queue_size;
+	unsigned int tx_queue_size;
+
 	mana_handle_t port_handle;
 	mana_handle_t pf_filter_handle;
 
-- 
2.34.1


