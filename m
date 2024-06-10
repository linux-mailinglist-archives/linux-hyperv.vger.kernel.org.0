Return-Path: <linux-hyperv+bounces-2370-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C47901F61
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 12:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6113A28578B
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 10:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630378C64;
	Mon, 10 Jun 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V7YN5G+J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72DA15B3;
	Mon, 10 Jun 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015328; cv=none; b=bys+Zs/JDxdyqXkRnJUdveAydOUSxA/G1QKVeeHyB2/4YYgIrSVGYN0O8/vA4gW/6l/s+Kqa9JqSvSKdcVlroXDPu1vltI2RfDYJIwpHVmkI5UDXHw4dMRukbDVebzmB88JgexyR2x77WpbJfNbbaUmPZx7PPMoNjozMNWp2oNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015328; c=relaxed/simple;
	bh=/PCXR7vy55K8JOQThan3qAMt46GpCt36Nbt0eKSiwVg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=erYSzWuZUf4vsfdOmixCiitT0buMkSjOlOntgSHfcaqWxLWC80f7YhiekfnMSEbp3qCiaTBTfijNrOongHG6GQ1K9w/OlE1cTx0cH4O2vfG31x72bDBGhymQRnmjLkQhFE4cddhKzJLINldJfoRB3e5N4D3G3AE1TWiLEInS6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V7YN5G+J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id BF3C720B915A; Mon, 10 Jun 2024 03:28:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF3C720B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718015320;
	bh=/PJrwTJJpzDcjKWE8Ma3yeysPlLM0m6JWTIKBCHiv3U=;
	h=From:To:Cc:Subject:Date:From;
	b=V7YN5G+Jh/egJI1cVFSOHdqWF4MdktsIT+Ars2FfNqIcqXJ42ahH2XEF3LtJhTTSk
	 DKY/CSx8BZdb9FssLCwNsgTzRRjE2fRW+8q/c2yR79Kj6pz6J36m+pfAWiz3wMqyS6
	 f3wB6vaxIKcFS1Kkh1vMOKalJkcmQtp1d0JimDy0=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Kees Cook <keescook@chromium.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Long Li <longli@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH net-next v4] net: mana: Allow variable size indirection table
Date: Mon, 10 Jun 2024 03:28:39 -0700
Message-Id: <1718015319-9609-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Allow variable size indirection table allocation in MANA instead
of using a constant value MANA_INDIRECT_TABLE_SIZE.
The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
indirection table is allocated dynamically.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 Changes in v4:
 * Skip NULLify after free
 * Log proper errors in mana_probe() if mana_attach(), mana_probe_port()
   fails
 * Implement mana_cleanup_indir_table() to avoid code duplication.

 Changes in v3:
 * Fixed the memory leak(save_table) in mana_set_rxfh()

 Changes in v2:
 * Rebased to latest net-next tree
 * Rearranged cleanup code in mana_probe_port to avoid extra operations
---
 drivers/infiniband/hw/mana/qp.c               | 10 +--
 drivers/net/ethernet/microsoft/mana/mana_en.c | 85 ++++++++++++++++---
 .../ethernet/microsoft/mana/mana_ethtool.c    | 27 ++++--
 include/net/mana/gdma.h                       |  4 +-
 include/net/mana/mana.h                       |  9 +-
 5 files changed, 104 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index ba13c5abf8ef..2d411a16a127 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -21,7 +21,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 
 	gc = mdev_to_gc(dev);
 
-	req_buf_size = struct_size(req, indir_tab, MANA_INDIRECT_TABLE_SIZE);
+	req_buf_size = struct_size(req, indir_tab, MANA_INDIRECT_TABLE_DEF_SIZE);
 	req = kzalloc(req_buf_size, GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
@@ -41,18 +41,18 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	if (log_ind_tbl_size)
 		req->rss_enable = true;
 
-	req->num_indir_entries = MANA_INDIRECT_TABLE_SIZE;
+	req->num_indir_entries = MANA_INDIRECT_TABLE_DEF_SIZE;
 	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
 					 indir_tab);
 	req->update_indir_tab = true;
 	req->cqe_coalescing_enable = 1;
 
 	/* The ind table passed to the hardware must have
-	 * MANA_INDIRECT_TABLE_SIZE entries. Adjust the verb
+	 * MANA_INDIRECT_TABLE_DEF_SIZE entries. Adjust the verb
 	 * ind_table to MANA_INDIRECT_TABLE_SIZE if required
 	 */
 	ibdev_dbg(&dev->ib_dev, "ind table size %u\n", 1 << log_ind_tbl_size);
-	for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++) {
+	for (i = 0; i < MANA_INDIRECT_TABLE_DEF_SIZE; i++) {
 		req->indir_tab[i] = ind_table[i % (1 << log_ind_tbl_size)];
 		ibdev_dbg(&dev->ib_dev, "index %u handle 0x%llx\n", i,
 			  req->indir_tab[i]);
@@ -137,7 +137,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	}
 
 	ind_tbl_size = 1 << ind_tbl->log_ind_tbl_size;
-	if (ind_tbl_size > MANA_INDIRECT_TABLE_SIZE) {
+	if (ind_tbl_size > MANA_INDIRECT_TABLE_DEF_SIZE) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Indirect table size %d exceeding limit\n",
 			  ind_tbl_size);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d087cf954f75..d87b57626769 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -481,7 +481,7 @@ static int mana_get_tx_queue(struct net_device *ndev, struct sk_buff *skb,
 	struct sock *sk = skb->sk;
 	int txq;
 
-	txq = apc->indir_table[hash & MANA_INDIRECT_TABLE_MASK];
+	txq = apc->indir_table[hash & (apc->indir_table_sz - 1)];
 
 	if (txq != old_q && sk && sk_fullsock(sk) &&
 	    rcu_access_pointer(sk->sk_dst_cache))
@@ -721,6 +721,13 @@ static void mana_cleanup_port_context(struct mana_port_context *apc)
 	apc->rxqs = NULL;
 }
 
+static void mana_cleanup_indir_table(struct mana_port_context *apc)
+{
+	apc->indir_table_sz = 0;
+	kfree(apc->indir_table);
+	kfree(apc->rxobj_table);
+}
+
 static int mana_init_port_context(struct mana_port_context *apc)
 {
 	apc->rxqs = kcalloc(apc->num_queues, sizeof(struct mana_rxq *),
@@ -962,7 +969,16 @@ static int mana_query_vport_cfg(struct mana_port_context *apc, u32 vport_index,
 
 	*max_sq = resp.max_num_sq;
 	*max_rq = resp.max_num_rq;
-	*num_indir_entry = resp.num_indirection_ent;
+	if (resp.num_indirection_ent > 0 &&
+	    resp.num_indirection_ent <= MANA_INDIRECT_TABLE_MAX_SIZE &&
+	    is_power_of_2(resp.num_indirection_ent)) {
+		*num_indir_entry = resp.num_indirection_ent;
+	} else {
+		netdev_warn(apc->ndev,
+			    "Setting indirection table size to default %d for vPort %d\n",
+			    MANA_INDIRECT_TABLE_DEF_SIZE, apc->port_idx);
+		*num_indir_entry = MANA_INDIRECT_TABLE_DEF_SIZE;
+	}
 
 	apc->port_handle = resp.vport;
 	ether_addr_copy(apc->mac_addr, resp.mac_addr);
@@ -1054,14 +1070,13 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 				   bool update_default_rxobj, bool update_key,
 				   bool update_tab)
 {
-	u16 num_entries = MANA_INDIRECT_TABLE_SIZE;
 	struct mana_cfg_rx_steer_req_v2 *req;
 	struct mana_cfg_rx_steer_resp resp = {};
 	struct net_device *ndev = apc->ndev;
 	u32 req_buf_size;
 	int err;
 
-	req_buf_size = struct_size(req, indir_tab, num_entries);
+	req_buf_size = struct_size(req, indir_tab, apc->indir_table_sz);
 	req = kzalloc(req_buf_size, GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
@@ -1072,7 +1087,7 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	req->hdr.req.msg_version = GDMA_MESSAGE_V2;
 
 	req->vport = apc->port_handle;
-	req->num_indir_entries = num_entries;
+	req->num_indir_entries = apc->indir_table_sz;
 	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
 					 indir_tab);
 	req->rx_enable = rx;
@@ -1111,7 +1126,7 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	}
 
 	netdev_info(ndev, "Configured steering vPort %llu entries %u\n",
-		    apc->port_handle, num_entries);
+		    apc->port_handle, apc->indir_table_sz);
 out:
 	kfree(req);
 	return err;
@@ -2344,11 +2359,33 @@ static int mana_create_vport(struct mana_port_context *apc,
 	return mana_create_txq(apc, net);
 }
 
+static int mana_rss_table_alloc(struct mana_port_context *apc)
+{
+	if (!apc->indir_table_sz) {
+		netdev_err(apc->ndev,
+			   "Indirection table size not set for vPort %d\n",
+			   apc->port_idx);
+		return -EINVAL;
+	}
+
+	apc->indir_table = kcalloc(apc->indir_table_sz, sizeof(u32), GFP_KERNEL);
+	if (!apc->indir_table)
+		return -ENOMEM;
+
+	apc->rxobj_table = kcalloc(apc->indir_table_sz, sizeof(mana_handle_t), GFP_KERNEL);
+	if (!apc->rxobj_table) {
+		kfree(apc->indir_table);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static void mana_rss_table_init(struct mana_port_context *apc)
 {
 	int i;
 
-	for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
+	for (i = 0; i < apc->indir_table_sz; i++)
 		apc->indir_table[i] =
 			ethtool_rxfh_indir_default(i, apc->num_queues);
 }
@@ -2361,7 +2398,7 @@ int mana_config_rss(struct mana_port_context *apc, enum TRI_STATE rx,
 	int i;
 
 	if (update_tab) {
-		for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++) {
+		for (i = 0; i < apc->indir_table_sz; i++) {
 			queue_idx = apc->indir_table[i];
 			apc->rxobj_table[i] = apc->rxqs[queue_idx]->rxobj;
 		}
@@ -2466,7 +2503,6 @@ static int mana_init_port(struct net_device *ndev)
 	struct mana_port_context *apc = netdev_priv(ndev);
 	u32 max_txq, max_rxq, max_queues;
 	int port_idx = apc->port_idx;
-	u32 num_indirect_entries;
 	int err;
 
 	err = mana_init_port_context(apc);
@@ -2474,7 +2510,7 @@ static int mana_init_port(struct net_device *ndev)
 		return err;
 
 	err = mana_query_vport_cfg(apc, port_idx, &max_txq, &max_rxq,
-				   &num_indirect_entries);
+				   &apc->indir_table_sz);
 	if (err) {
 		netdev_err(ndev, "Failed to query info for vPort %d\n",
 			   port_idx);
@@ -2723,6 +2759,10 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	if (err)
 		goto free_net;
 
+	err = mana_rss_table_alloc(apc);
+	if (err)
+		goto reset_apc;
+
 	netdev_lockdep_set_classes(ndev);
 
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
@@ -2739,11 +2779,13 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	err = register_netdev(ndev);
 	if (err) {
 		netdev_err(ndev, "Unable to register netdev.\n");
-		goto reset_apc;
+		goto free_indir;
 	}
 
 	return 0;
 
+free_indir:
+	mana_cleanup_indir_table(apc);
 reset_apc:
 	kfree(apc->rxqs);
 	apc->rxqs = NULL;
@@ -2872,16 +2914,30 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	if (!resuming) {
 		for (i = 0; i < ac->num_ports; i++) {
 			err = mana_probe_port(ac, i, &ac->ports[i]);
-			if (err)
+			/* we log the port for which the probe failed and stop
+			 * probes for subsequent ports.
+			 * Note that we keep running ports, for which the probes
+			 * were successful, unless add_adev fails too
+			 */
+			if (err) {
+				dev_err(dev, "Probe Failed for port %d\n", i);
 				break;
+			}
 		}
 	} else {
 		for (i = 0; i < ac->num_ports; i++) {
 			rtnl_lock();
 			err = mana_attach(ac->ports[i]);
 			rtnl_unlock();
-			if (err)
+			/* we log the port for which the attach failed and stop
+			 * attach for subsequent ports
+			 * Note that we keep running ports, for which the attach
+			 * were successful, unless add_adev fails too
+			 */
+			if (err) {
+				dev_err(dev, "Attach Failed for port %d\n", i);
 				break;
+			}
 		}
 	}
 
@@ -2897,6 +2953,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 {
 	struct gdma_context *gc = gd->gdma_context;
 	struct mana_context *ac = gd->driver_data;
+	struct mana_port_context *apc;
 	struct device *dev = gc->dev;
 	struct net_device *ndev;
 	int err;
@@ -2908,6 +2965,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 
 	for (i = 0; i < ac->num_ports; i++) {
 		ndev = ac->ports[i];
+		apc = netdev_priv(ndev);
 		if (!ndev) {
 			if (i == 0)
 				dev_err(dev, "No net device to remove\n");
@@ -2931,6 +2989,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 		}
 
 		unregister_netdevice(ndev);
+		mana_cleanup_indir_table(apc);
 
 		rtnl_unlock();
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index ab2413d71f6c..146d5db1792f 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -245,7 +245,9 @@ static u32 mana_get_rxfh_key_size(struct net_device *ndev)
 
 static u32 mana_rss_indir_size(struct net_device *ndev)
 {
-	return MANA_INDIRECT_TABLE_SIZE;
+	struct mana_port_context *apc = netdev_priv(ndev);
+
+	return apc->indir_table_sz;
 }
 
 static int mana_get_rxfh(struct net_device *ndev,
@@ -257,7 +259,7 @@ static int mana_get_rxfh(struct net_device *ndev,
 	rxfh->hfunc = ETH_RSS_HASH_TOP; /* Toeplitz */
 
 	if (rxfh->indir) {
-		for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
+		for (i = 0; i < apc->indir_table_sz; i++)
 			rxfh->indir[i] = apc->indir_table[i];
 	}
 
@@ -273,8 +275,8 @@ static int mana_set_rxfh(struct net_device *ndev,
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
 	bool update_hash = false, update_table = false;
-	u32 save_table[MANA_INDIRECT_TABLE_SIZE];
 	u8 save_key[MANA_HASH_KEY_SIZE];
+	u32 *save_table;
 	int i, err;
 
 	if (!apc->port_is_up)
@@ -284,13 +286,19 @@ static int mana_set_rxfh(struct net_device *ndev,
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
+	save_table = kcalloc(apc->indir_table_sz, sizeof(u32), GFP_KERNEL);
+	if (!save_table)
+		return -ENOMEM;
+
 	if (rxfh->indir) {
-		for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
-			if (rxfh->indir[i] >= apc->num_queues)
-				return -EINVAL;
+		for (i = 0; i < apc->indir_table_sz; i++)
+			if (rxfh->indir[i] >= apc->num_queues) {
+				err = -EINVAL;
+				goto cleanup;
+			}
 
 		update_table = true;
-		for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++) {
+		for (i = 0; i < apc->indir_table_sz; i++) {
 			save_table[i] = apc->indir_table[i];
 			apc->indir_table[i] = rxfh->indir[i];
 		}
@@ -306,7 +314,7 @@ static int mana_set_rxfh(struct net_device *ndev,
 
 	if (err) { /* recover to original values */
 		if (update_table) {
-			for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
+			for (i = 0; i < apc->indir_table_sz; i++)
 				apc->indir_table[i] = save_table[i];
 		}
 
@@ -316,6 +324,9 @@ static int mana_set_rxfh(struct net_device *ndev,
 		mana_config_rss(apc, TRI_STATE_TRUE, update_hash, update_table);
 	}
 
+cleanup:
+	kfree(save_table);
+
 	return err;
 }
 
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 27684135bb4d..c547756c4284 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -543,11 +543,13 @@ enum {
  */
 #define GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX BIT(2)
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
+#define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
 
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
-	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG)
+	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
+	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 561f6719fb4e..59823901b74f 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -30,8 +30,8 @@ enum TRI_STATE {
 };
 
 /* Number of entries for hardware indirection table must be in power of 2 */
-#define MANA_INDIRECT_TABLE_SIZE 64
-#define MANA_INDIRECT_TABLE_MASK (MANA_INDIRECT_TABLE_SIZE - 1)
+#define MANA_INDIRECT_TABLE_MAX_SIZE 512
+#define MANA_INDIRECT_TABLE_DEF_SIZE 64
 
 /* The Toeplitz hash key's length in bytes: should be multiple of 8 */
 #define MANA_HASH_KEY_SIZE 40
@@ -410,10 +410,11 @@ struct mana_port_context {
 	struct mana_tx_qp *tx_qp;
 
 	/* Indirection Table for RX & TX. The values are queue indexes */
-	u32 indir_table[MANA_INDIRECT_TABLE_SIZE];
+	u32 *indir_table;
+	u32 indir_table_sz;
 
 	/* Indirection table containing RxObject Handles */
-	mana_handle_t rxobj_table[MANA_INDIRECT_TABLE_SIZE];
+	mana_handle_t *rxobj_table;
 
 	/*  Hash key used by the NIC */
 	u8 hashkey[MANA_HASH_KEY_SIZE];
-- 
2.34.1


