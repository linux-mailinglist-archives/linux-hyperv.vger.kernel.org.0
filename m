Return-Path: <linux-hyperv+bounces-9171-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAZoFTRIq2lcbwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9171-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 22:33:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0429A227F9E
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 22:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 364D030351D5
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 21:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C536344056;
	Fri,  6 Mar 2026 21:33:23 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA5F339B41;
	Fri,  6 Mar 2026 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832803; cv=none; b=WEpok47pytlGWpXsnmWuV1Wyuh7rMKU0DXrgdguSsPJ3FSpWgZy+RCSt65pltzz5LWDi6KlMKfNqp5lALr62FhN34+Lcj4ei+Hag3Q5TqjjiU8q72Fr8kFfT8YtFxxP0mp8JGAZ4+1Lf1y+AIzUVg4JEObS3IE/OmYLdjs6rs8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832803; c=relaxed/simple;
	bh=IYsBGvr2BuvZ9Fb3G3GlqqBvEp9j4oZZXh8vpuEzs/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDu6krA4chsTH79et5NwgX1yB4aWgiEz4odmwQBlJ7jIembPyTy+R8jOrKmk+kadPr8NqX0jxX+xDmlH0P6tgRrMjgNuDCvRlBzxj90wnleIiA0kJYC53qLwOa98CJjd0UZ3wGEDFcLKZSmqUgIB12LWHTbCCX3Ac8TZ7bj4uPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 856ED20B6F17; Fri,  6 Mar 2026 13:33:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 856ED20B6F17
From: Long Li <longli@microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH net-next v3 1/6] net: mana: Create separate EQs for each vPort
Date: Fri,  6 Mar 2026 13:32:57 -0800
Message-ID: <20260306213302.544681-2-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260306213302.544681-1-longli@microsoft.com>
References: <20260306213302.544681-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0429A227F9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-9171-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.366];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

To prepare for assigning vPorts to dedicated MSI-X vectors, remove EQ
sharing among the vPorts and create dedicated EQs for each vPort.

Move the EQ definition from struct mana_context to struct mana_port_context
and update related support functions. Export mana_create_eq() and
mana_destroy_eq() for use by the MANA RDMA driver.

Signed-off-by: Long Li <longli@microsoft.com>
---
Changes in v3:
- Added NULL check for mpc->eqs in mana_ib_create_qp_rss() to prevent
  kernel crash when RSS QP is created before EQs are allocated
---
 drivers/infiniband/hw/mana/main.c             |  14 ++-
 drivers/infiniband/hw/mana/qp.c               |  12 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 109 ++++++++++--------
 include/net/mana/mana.h                       |   7 +-
 4 files changed, 90 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 8d99cd00f002..d51dd0ee85f4 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -20,8 +20,10 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
 	pd->vport_use_count--;
 	WARN_ON(pd->vport_use_count < 0);
 
-	if (!pd->vport_use_count)
+	if (!pd->vport_use_count) {
+		mana_destroy_eq(mpc);
 		mana_uncfg_vport(mpc);
+	}
 
 	mutex_unlock(&pd->vport_mutex);
 }
@@ -55,15 +57,21 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
 		return err;
 	}
 
-	mutex_unlock(&pd->vport_mutex);
 
 	pd->tx_shortform_allowed = mpc->tx_shortform_allowed;
 	pd->tx_vp_offset = mpc->tx_vp_offset;
+	err = mana_create_eq(mpc);
+	if (err) {
+		mana_uncfg_vport(mpc);
+		pd->vport_use_count--;
+	}
+
+	mutex_unlock(&pd->vport_mutex);
 
 	ibdev_dbg(&dev->ib_dev, "vport handle %llx pdid %x doorbell_id %x\n",
 		  mpc->port_handle, pd->pdn, doorbell_id);
 
-	return 0;
+	return err;
 }
 
 int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 82f84f7ad37a..039c86eca0dc 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -188,7 +188,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		cq_spec.gdma_region = cq->queue.gdma_region;
 		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
 		cq_spec.modr_ctx_id = 0;
-		eq = &mpc->ac->eqs[cq->comp_vector];
+		/* EQs are created when a raw QP configures the vport.
+		 * A raw QP must be created before creating rwq_ind_tbl.
+		 */
+		if (!mpc->eqs) {
+			ret = -EINVAL;
+			i--;
+			goto fail;
+		}
+		eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];
 		cq_spec.attached_eq = eq->eq->id;
 
 		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
@@ -340,7 +348,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	cq_spec.queue_size = send_cq->cqe * COMP_ENTRY_SIZE;
 	cq_spec.modr_ctx_id = 0;
 	eq_vec = send_cq->comp_vector;
-	eq = &mpc->ac->eqs[eq_vec];
+	eq = &mpc->eqs[eq_vec % mpc->num_queues];
 	cq_spec.attached_eq = eq->eq->id;
 
 	err = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ, &wq_spec,
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 56ee993e3a43..428dafaf315b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1588,78 +1588,82 @@ void mana_destroy_wq_obj(struct mana_port_context *apc, u32 wq_type,
 }
 EXPORT_SYMBOL_NS(mana_destroy_wq_obj, "NET_MANA");
 
-static void mana_destroy_eq(struct mana_context *ac)
+void mana_destroy_eq(struct mana_port_context *apc)
 {
+	struct mana_context *ac = apc->ac;
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct gdma_queue *eq;
 	int i;
 
-	if (!ac->eqs)
+	if (!apc->eqs)
 		return;
 
-	debugfs_remove_recursive(ac->mana_eqs_debugfs);
-	ac->mana_eqs_debugfs = NULL;
+	debugfs_remove_recursive(apc->mana_eqs_debugfs);
+	apc->mana_eqs_debugfs = NULL;
 
-	for (i = 0; i < gc->max_num_queues; i++) {
-		eq = ac->eqs[i].eq;
+	for (i = 0; i < apc->num_queues; i++) {
+		eq = apc->eqs[i].eq;
 		if (!eq)
 			continue;
 
 		mana_gd_destroy_queue(gc, eq);
 	}
 
-	kfree(ac->eqs);
-	ac->eqs = NULL;
+	kfree(apc->eqs);
+	apc->eqs = NULL;
 }
+EXPORT_SYMBOL_NS(mana_destroy_eq, "NET_MANA");
 
-static void mana_create_eq_debugfs(struct mana_context *ac, int i)
+static void mana_create_eq_debugfs(struct mana_port_context *apc, int i)
 {
-	struct mana_eq eq = ac->eqs[i];
+	struct mana_eq eq = apc->eqs[i];
 	char eqnum[32];
 
 	sprintf(eqnum, "eq%d", i);
-	eq.mana_eq_debugfs = debugfs_create_dir(eqnum, ac->mana_eqs_debugfs);
+	eq.mana_eq_debugfs = debugfs_create_dir(eqnum, apc->mana_eqs_debugfs);
 	debugfs_create_u32("head", 0400, eq.mana_eq_debugfs, &eq.eq->head);
 	debugfs_create_u32("tail", 0400, eq.mana_eq_debugfs, &eq.eq->tail);
 	debugfs_create_file("eq_dump", 0400, eq.mana_eq_debugfs, eq.eq, &mana_dbg_q_fops);
 }
 
-static int mana_create_eq(struct mana_context *ac)
+int mana_create_eq(struct mana_port_context *apc)
 {
-	struct gdma_dev *gd = ac->gdma_dev;
+	struct gdma_dev *gd = apc->ac->gdma_dev;
 	struct gdma_context *gc = gd->gdma_context;
 	struct gdma_queue_spec spec = {};
 	int err;
 	int i;
 
-	ac->eqs = kzalloc_objs(struct mana_eq, gc->max_num_queues);
-	if (!ac->eqs)
+	WARN_ON(apc->eqs);
+	apc->eqs = kzalloc_objs(struct mana_eq, apc->num_queues);
+	if (!apc->eqs)
 		return -ENOMEM;
 
 	spec.type = GDMA_EQ;
 	spec.monitor_avl_buf = false;
 	spec.queue_size = EQ_SIZE;
 	spec.eq.callback = NULL;
-	spec.eq.context = ac->eqs;
+	spec.eq.context = apc->eqs;
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
 
-	ac->mana_eqs_debugfs = debugfs_create_dir("EQs", gc->mana_pci_debugfs);
+	apc->mana_eqs_debugfs = debugfs_create_dir("EQs", apc->mana_port_debugfs);
 
-	for (i = 0; i < gc->max_num_queues; i++) {
+	for (i = 0; i < apc->num_queues; i++) {
 		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
-		err = mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq);
+		err = mana_gd_create_mana_eq(gd, &spec, &apc->eqs[i].eq);
 		if (err) {
 			dev_err(gc->dev, "Failed to create EQ %d : %d\n", i, err);
 			goto out;
 		}
-		mana_create_eq_debugfs(ac, i);
+		mana_create_eq_debugfs(apc, i);
 	}
 
 	return 0;
 out:
-	mana_destroy_eq(ac);
+	mana_destroy_eq(apc);
 	return err;
 }
+EXPORT_SYMBOL_NS(mana_create_eq, "NET_MANA");
 
 static int mana_fence_rq(struct mana_port_context *apc, struct mana_rxq *rxq)
 {
@@ -2377,7 +2381,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 		spec.monitor_avl_buf = false;
 		spec.queue_size = cq_size;
 		spec.cq.callback = mana_schedule_napi;
-		spec.cq.parent_eq = ac->eqs[i].eq;
+		spec.cq.parent_eq = apc->eqs[i].eq;
 		spec.cq.context = cq;
 		err = mana_gd_create_mana_wq_cq(gd, &spec, &cq->gdma_cq);
 		if (err)
@@ -2770,13 +2774,12 @@ static void mana_create_rxq_debugfs(struct mana_port_context *apc, int idx)
 static int mana_add_rx_queues(struct mana_port_context *apc,
 			      struct net_device *ndev)
 {
-	struct mana_context *ac = apc->ac;
 	struct mana_rxq *rxq;
 	int err = 0;
 	int i;
 
 	for (i = 0; i < apc->num_queues; i++) {
-		rxq = mana_create_rxq(apc, i, &ac->eqs[i], ndev);
+		rxq = mana_create_rxq(apc, i, &apc->eqs[i], ndev);
 		if (!rxq) {
 			err = -ENOMEM;
 			netdev_err(ndev, "Failed to create rxq %d : %d\n", i, err);
@@ -2795,9 +2798,8 @@ static int mana_add_rx_queues(struct mana_port_context *apc,
 	return err;
 }
 
-static void mana_destroy_vport(struct mana_port_context *apc)
+static void mana_destroy_rxqs(struct mana_port_context *apc)
 {
-	struct gdma_dev *gd = apc->ac->gdma_dev;
 	struct mana_rxq *rxq;
 	u32 rxq_idx;
 
@@ -2809,8 +2811,12 @@ static void mana_destroy_vport(struct mana_port_context *apc)
 		mana_destroy_rxq(apc, rxq, true);
 		apc->rxqs[rxq_idx] = NULL;
 	}
+}
+
+static void mana_destroy_vport(struct mana_port_context *apc)
+{
+	struct gdma_dev *gd = apc->ac->gdma_dev;
 
-	mana_destroy_txq(apc);
 	mana_uncfg_vport(apc);
 
 	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
@@ -2831,11 +2837,7 @@ static int mana_create_vport(struct mana_port_context *apc,
 			return err;
 	}
 
-	err = mana_cfg_vport(apc, gd->pdid, gd->doorbell);
-	if (err)
-		return err;
-
-	return mana_create_txq(apc, net);
+	return mana_cfg_vport(apc, gd->pdid, gd->doorbell);
 }
 
 static int mana_rss_table_alloc(struct mana_port_context *apc)
@@ -3112,21 +3114,36 @@ int mana_alloc_queues(struct net_device *ndev)
 
 	err = mana_create_vport(apc, ndev);
 	if (err) {
-		netdev_err(ndev, "Failed to create vPort %u : %d\n", apc->port_idx, err);
+		netdev_err(ndev, "Failed to create vPort %u : %d\n",
+			   apc->port_idx, err);
 		return err;
 	}
 
+	err = mana_create_eq(apc);
+	if (err) {
+		netdev_err(ndev, "Failed to create EQ on vPort %u: %d\n",
+			   apc->port_idx, err);
+		goto destroy_vport;
+	}
+
+	err = mana_create_txq(apc, ndev);
+	if (err) {
+		netdev_err(ndev, "Failed to create TXQ on vPort %u: %d\n",
+			   apc->port_idx, err);
+		goto destroy_eq;
+	}
+
 	err = netif_set_real_num_tx_queues(ndev, apc->num_queues);
 	if (err) {
 		netdev_err(ndev,
 			   "netif_set_real_num_tx_queues () failed for ndev with num_queues %u : %d\n",
 			   apc->num_queues, err);
-		goto destroy_vport;
+		goto destroy_txq;
 	}
 
 	err = mana_add_rx_queues(apc, ndev);
 	if (err)
-		goto destroy_vport;
+		goto destroy_rxq;
 
 	apc->rss_state = apc->num_queues > 1 ? TRI_STATE_TRUE : TRI_STATE_FALSE;
 
@@ -3135,7 +3152,7 @@ int mana_alloc_queues(struct net_device *ndev)
 		netdev_err(ndev,
 			   "netif_set_real_num_rx_queues () failed for ndev with num_queues %u : %d\n",
 			   apc->num_queues, err);
-		goto destroy_vport;
+		goto destroy_rxq;
 	}
 
 	mana_rss_table_init(apc);
@@ -3143,19 +3160,25 @@ int mana_alloc_queues(struct net_device *ndev)
 	err = mana_config_rss(apc, TRI_STATE_TRUE, true, true);
 	if (err) {
 		netdev_err(ndev, "Failed to configure RSS table: %d\n", err);
-		goto destroy_vport;
+		goto destroy_rxq;
 	}
 
 	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode) {
 		err = mana_pf_register_filter(apc);
 		if (err)
-			goto destroy_vport;
+			goto destroy_rxq;
 	}
 
 	mana_chn_setxdp(apc, mana_xdp_get(apc));
 
 	return 0;
 
+destroy_rxq:
+	mana_destroy_rxqs(apc);
+destroy_txq:
+	mana_destroy_txq(apc);
+destroy_eq:
+	mana_destroy_eq(apc);
 destroy_vport:
 	mana_destroy_vport(apc);
 	return err;
@@ -3258,6 +3281,9 @@ static int mana_dealloc_queues(struct net_device *ndev)
 		netdev_err(ndev, "Failed to disable vPort: %d\n", err);
 
 	/* Even in err case, still need to cleanup the vPort */
+	mana_destroy_rxqs(apc);
+	mana_destroy_txq(apc);
+	mana_destroy_eq(apc);
 	mana_destroy_vport(apc);
 
 	return 0;
@@ -3572,12 +3598,6 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 		gd->driver_data = ac;
 	}
 
-	err = mana_create_eq(ac);
-	if (err) {
-		dev_err(dev, "Failed to create EQs: %d\n", err);
-		goto out;
-	}
-
 	err = mana_query_device_cfg(ac, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
 				    MANA_MICRO_VERSION, &num_ports, &bm_hostmode);
 	if (err)
@@ -3716,7 +3736,6 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 		free_netdev(ndev);
 	}
 
-	mana_destroy_eq(ac);
 out:
 	if (ac->per_port_queue_reset_wq) {
 		destroy_workqueue(ac->per_port_queue_reset_wq);
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index a078af283bdd..787e637059df 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -478,8 +478,6 @@ struct mana_context {
 	u8 bm_hostmode;
 
 	struct mana_ethtool_hc_stats hc_stats;
-	struct mana_eq *eqs;
-	struct dentry *mana_eqs_debugfs;
 	struct workqueue_struct *per_port_queue_reset_wq;
 	/* Workqueue for querying hardware stats */
 	struct delayed_work gf_stats_work;
@@ -499,6 +497,9 @@ struct mana_port_context {
 
 	u8 mac_addr[ETH_ALEN];
 
+	struct mana_eq *eqs;
+	struct dentry *mana_eqs_debugfs;
+
 	enum TRI_STATE rss_state;
 
 	mana_handle_t default_rxobj;
@@ -1023,6 +1024,8 @@ void mana_destroy_wq_obj(struct mana_port_context *apc, u32 wq_type,
 int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
 		   u32 doorbell_pg_id);
 void mana_uncfg_vport(struct mana_port_context *apc);
+int mana_create_eq(struct mana_port_context *apc);
+void mana_destroy_eq(struct mana_port_context *apc);
 
 struct net_device *mana_get_primary_netdev(struct mana_context *ac,
 					   u32 port_index,
-- 
2.43.0


