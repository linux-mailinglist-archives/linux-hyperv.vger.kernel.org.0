Return-Path: <linux-hyperv+bounces-10896-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FdGF5GbBmoHlQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10896-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 06:05:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 523A254910E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 06:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BB71301A3FE
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 04:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB943D0935;
	Fri, 15 May 2026 04:05:21 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100C73CF050;
	Fri, 15 May 2026 04:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778817921; cv=none; b=Mkchnq6rP9Vu9Y4YwX8RaUXnrmHMNLvTG30EhHZCBN/jiYsNDrdExal0KEW+dZcrt8NayVAhFkdv49JE/Y4YnYw3Tqj9xFPB5O6+qlOV9pF20Da30ilUUvobwD8TNZ+ioGfU6DEakJTQvpY0qXFNJlmUmuLO0tpMD9LsXnbHObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778817921; c=relaxed/simple;
	bh=+gAHt/EzgjiXAygIy6TTEcoxjLlJiMCcEoEdfSdo1Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNtxW290WHiCEd6805Rq7hQmIa2ZxVX2OuzWOjZCI2ucYmtXPpTLkxdDP1M6GasCfC3BgQe/tsplUWriJxLP3oQTNSEcKTfNxDDRIIP27CiUDnWBvkERmrI7+MNaXh7rHMp/H/aaA/TO6FB8CKYXWyGsYAg7BAEc0+QJs6JG4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 4BE8C20B7167; Thu, 14 May 2026 21:05:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BE8C20B7167
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	shradhagupta@linux.microsoft.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 1/6] net: mana: Create separate EQs for each vPort
Date: Thu, 14 May 2026 21:05:03 -0700
Message-ID: <20260515040508.491748-2-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260515040508.491748-1-longli@microsoft.com>
References: <20260515040508.491748-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 523A254910E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10896-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.759];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

To prepare for assigning vPorts to dedicated MSI-X vectors, remove EQ
sharing among the vPorts and create dedicated EQs for each vPort.

Move the EQ definition from struct mana_context to struct mana_port_context
and update related support functions. Export mana_create_eq() and
mana_destroy_eq() for use by the MANA RDMA driver.

RSS QPs now take a vport reference via pd->vport_use_count to ensure
EQs outlive all QP consumers. The vport must already be configured by
a raw QP before an RSS QP can be created. EQs are only destroyed when
the last QP (raw or RSS) on the PD releases its reference.

Reject cross-port PD sharing for raw QPs. Since EQs and vport
configuration are per-port, a PD is bound to the port used by its
first raw QP. Subsequent raw QPs on the same PD must use the same
port or the creation fails with -EINVAL.

Serialize mana_set_channels() against RDMA vport configuration to
prevent num_queues from changing while RDMA holds EQs sized to the
current value. When the port is down, apc->vport_mutex is held for
the entire operation since mana_detach()/mana_attach() do not take
vport_mutex in that case. When the port is up, Ethernet owns the
vport exclusively so no additional locking is needed.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c             |  40 ++++--
 drivers/infiniband/hw/mana/mana_ib.h          |   8 ++
 drivers/infiniband/hw/mana/qp.c               |  37 +++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 117 +++++++++++-------
 .../ethernet/microsoft/mana/mana_ethtool.c    |  23 +++-
 include/net/mana/mana.h                       |  15 ++-
 6 files changed, 174 insertions(+), 66 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index ac5e75dd3494..f8a9013f0ca3 100644
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
@@ -40,13 +42,27 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
 
 	pd->vport_use_count++;
 	if (pd->vport_use_count > 1) {
+		/* Reject cross-port PD sharing. EQs and vport config
+		 * are per-port, so the PD must stay bound to the port
+		 * that was configured on the first raw QP creation.
+		 */
+		if (pd->vport_port != port) {
+			pd->vport_use_count--;
+			mutex_unlock(&pd->vport_mutex);
+			ibdev_dbg(&dev->ib_dev,
+				  "PD already bound to port %u\n",
+				  pd->vport_port);
+			return -EINVAL;
+		}
 		ibdev_dbg(&dev->ib_dev,
 			  "Skip as this PD is already configured vport\n");
 		mutex_unlock(&pd->vport_mutex);
 		return 0;
 	}
 
-	err = mana_cfg_vport(mpc, pd->pdn, doorbell_id);
+	pd->vport_port = port;
+
+	err = mana_cfg_vport(mpc, pd->pdn, doorbell_id, true);
 	if (err) {
 		pd->vport_use_count--;
 		mutex_unlock(&pd->vport_mutex);
@@ -55,15 +71,23 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
 		return err;
 	}
 
-	mutex_unlock(&pd->vport_mutex);
 
-	pd->tx_shortform_allowed = mpc->tx_shortform_allowed;
-	pd->tx_vp_offset = mpc->tx_vp_offset;
+	err = mana_create_eq(mpc);
+	if (err) {
+		mana_uncfg_vport(mpc);
+		pd->vport_use_count--;
+	} else {
+		pd->tx_shortform_allowed = mpc->tx_shortform_allowed;
+		pd->tx_vp_offset = mpc->tx_vp_offset;
+	}
+
+	mutex_unlock(&pd->vport_mutex);
 
-	ibdev_dbg(&dev->ib_dev, "vport handle %llx pdid %x doorbell_id %x\n",
-		  mpc->port_handle, pd->pdn, doorbell_id);
+	if (!err)
+		ibdev_dbg(&dev->ib_dev, "vport handle %llx pdid %x doorbell_id %x\n",
+			  mpc->port_handle, pd->pdn, doorbell_id);
 
-	return 0;
+	return err;
 }
 
 int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index c9c94e86a72b..916f03fb96dd 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -102,6 +102,14 @@ struct mana_ib_pd {
 	struct mutex vport_mutex;
 	int vport_use_count;
 
+	/* Port bound to this PD for raw QP usage. A PD can only be
+	 * associated with a single physical port because per-port EQs
+	 * and vport configuration are tied to the PD's refcount.
+	 * Set on the first raw QP creation; subsequent QPs on the
+	 * same PD must use the same port or get -EINVAL.
+	 */
+	u32 vport_port;
+
 	bool tx_shortform_allowed;
 	u32 tx_vp_offset;
 };
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 0fbcf449c134..108ec4c5ce51 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -79,6 +79,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 				 struct ib_qp_init_attr *attr,
 				 struct ib_udata *udata)
 {
+	struct mana_ib_pd *mana_pd = container_of(pd, struct mana_ib_pd, ibpd);
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
 	struct mana_ib_dev *mdev =
 		container_of(pd->device, struct mana_ib_dev, ib_dev);
@@ -155,6 +156,18 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 	qp->port = port;
 
+	/* Take a reference on the vport to ensure EQs outlive this QP.
+	 * The vport must already be configured by a raw QP.
+	 */
+	mutex_lock(&mana_pd->vport_mutex);
+	if (!mana_pd->vport_use_count) {
+		mutex_unlock(&mana_pd->vport_mutex);
+		ret = -EINVAL;
+		goto fail;
+	}
+	mana_pd->vport_use_count++;
+	mutex_unlock(&mana_pd->vport_mutex);
+
 	for (i = 0; i < ind_tbl_size; i++) {
 		struct mana_obj_spec wq_spec = {};
 		struct mana_obj_spec cq_spec = {};
@@ -171,13 +184,13 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		cq_spec.gdma_region = cq->queue.gdma_region;
 		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
 		cq_spec.modr_ctx_id = 0;
-		eq = &mpc->ac->eqs[cq->comp_vector];
+		eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];
 		cq_spec.attached_eq = eq->eq->id;
 
 		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
 					 &wq_spec, &cq_spec, &wq->rx_object);
 		if (ret)
-			goto fail;
+			goto free_vport;
 
 		/* The GDMA regions are now owned by the WQ object */
 		wq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
@@ -199,7 +212,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		ret = mana_ib_install_cq_cb(mdev, cq);
 		if (ret) {
 			mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
-			goto fail;
+			goto free_vport;
 		}
 	}
 	resp.num_entries = i;
@@ -210,7 +223,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 					 ucmd.rx_hash_key_len,
 					 ucmd.rx_hash_key);
 	if (ret)
-		goto fail;
+		goto free_vport;
 
 	ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
 	if (ret) {
@@ -226,7 +239,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 err_disable_vport_rx:
 	mana_disable_vport_rx(mpc);
-fail:
+free_vport:
 	while (i-- > 0) {
 		ibwq = ind_tbl->ind_tbl[i];
 		ibcq = ibwq->cq;
@@ -237,6 +250,9 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 	}
 
+	mana_ib_uncfg_vport(mdev, mana_pd, port);
+
+fail:
 	kfree(mana_ind_table);
 
 	return ret;
@@ -321,7 +337,11 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	cq_spec.queue_size = send_cq->cqe * COMP_ENTRY_SIZE;
 	cq_spec.modr_ctx_id = 0;
 	eq_vec = send_cq->comp_vector;
-	eq = &mpc->ac->eqs[eq_vec];
+	if (!mpc->eqs) {
+		err = -EINVAL;
+		goto err_destroy_queue;
+	}
+	eq = &mpc->eqs[eq_vec % mpc->num_queues];
 	cq_spec.attached_eq = eq->eq->id;
 
 	err = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ, &wq_spec,
@@ -785,14 +805,17 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 {
 	struct mana_ib_dev *mdev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
+	struct ib_pd *ibpd = qp->ibqp.pd;
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
+	struct mana_ib_pd *pd;
 	struct mana_ib_wq *wq;
 	struct ib_wq *ibwq;
 	int i;
 
 	ndev = mana_ib_get_netdev(qp->ibqp.device, qp->port);
 	mpc = netdev_priv(ndev);
+	pd = container_of(ibpd, struct mana_ib_pd, ibpd);
 
 	/* Disable vPort RX steering before destroying RX WQ objects.
 	 * Otherwise firmware still routes traffic to the destroyed queues,
@@ -817,6 +840,8 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 	}
 
+	mana_ib_uncfg_vport(mdev, pd, qp->port);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index b2faa7cf398f..18f8f653da3d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1295,7 +1295,7 @@ void mana_uncfg_vport(struct mana_port_context *apc)
 EXPORT_SYMBOL_NS(mana_uncfg_vport, "NET_MANA");
 
 int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
-		   u32 doorbell_pg_id)
+		   u32 doorbell_pg_id, bool check_channel_changing)
 {
 	struct mana_config_vport_resp resp = {};
 	struct mana_config_vport_req req = {};
@@ -1320,7 +1320,8 @@ int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
 	 * Ethernet usage on the same port.
 	 */
 	mutex_lock(&apc->vport_mutex);
-	if (apc->vport_use_count > 0) {
+	if (apc->vport_use_count > 0 ||
+	    (check_channel_changing && apc->channel_changing)) {
 		mutex_unlock(&apc->vport_mutex);
 		return -EBUSY;
 	}
@@ -1615,78 +1616,84 @@ void mana_destroy_wq_obj(struct mana_port_context *apc, u32 wq_type,
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
+	if (WARN_ON(apc->eqs))
+		return -EEXIST;
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
+	apc->mana_eqs_debugfs =
+		debugfs_create_dir("EQs", apc->mana_port_debugfs);
 
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
@@ -2451,7 +2458,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 		spec.monitor_avl_buf = false;
 		spec.queue_size = cq_size;
 		spec.cq.callback = mana_schedule_napi;
-		spec.cq.parent_eq = ac->eqs[i].eq;
+		spec.cq.parent_eq = apc->eqs[i].eq;
 		spec.cq.context = cq;
 		err = mana_gd_create_mana_wq_cq(gd, &spec, &cq->gdma_cq);
 		if (err)
@@ -2844,13 +2851,12 @@ static void mana_create_rxq_debugfs(struct mana_port_context *apc, int idx)
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
@@ -2869,9 +2875,8 @@ static int mana_add_rx_queues(struct mana_port_context *apc,
 	return err;
 }
 
-static void mana_destroy_vport(struct mana_port_context *apc)
+static void mana_destroy_rxqs(struct mana_port_context *apc)
 {
-	struct gdma_dev *gd = apc->ac->gdma_dev;
 	struct mana_rxq *rxq;
 	u32 rxq_idx;
 
@@ -2883,8 +2888,12 @@ static void mana_destroy_vport(struct mana_port_context *apc)
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
@@ -2905,11 +2914,7 @@ static int mana_create_vport(struct mana_port_context *apc,
 			return err;
 	}
 
-	err = mana_cfg_vport(apc, gd->pdid, gd->doorbell);
-	if (err)
-		return err;
-
-	return mana_create_txq(apc, net);
+	return mana_cfg_vport(apc, gd->pdid, gd->doorbell, false);
 }
 
 static int mana_rss_table_alloc(struct mana_port_context *apc)
@@ -3195,21 +3200,36 @@ int mana_alloc_queues(struct net_device *ndev)
 
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
 
@@ -3218,7 +3238,7 @@ int mana_alloc_queues(struct net_device *ndev)
 		netdev_err(ndev,
 			   "netif_set_real_num_rx_queues () failed for ndev with num_queues %u : %d\n",
 			   apc->num_queues, err);
-		goto destroy_vport;
+		goto destroy_rxq;
 	}
 
 	mana_rss_table_init(apc);
@@ -3226,19 +3246,25 @@ int mana_alloc_queues(struct net_device *ndev)
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
@@ -3343,6 +3369,9 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	mana_fence_rqs(apc);
 
 	/* Even in err case, still need to cleanup the vPort */
+	mana_destroy_rxqs(apc);
+	mana_destroy_txq(apc);
+	mana_destroy_eq(apc);
 	mana_destroy_vport(apc);
 
 	return 0;
@@ -3663,12 +3692,6 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	INIT_DELAYED_WORK(&ac->gf_stats_work, mana_gf_stats_work_handler);
 
-	err = mana_create_eq(ac);
-	if (err) {
-		dev_err(dev, "Failed to create EQs: %d\n", err);
-		goto out;
-	}
-
 	err = mana_query_device_cfg(ac, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
 				    MANA_MICRO_VERSION, &num_ports, &bm_hostmode);
 	if (err)
@@ -3808,8 +3831,6 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 		free_netdev(ndev);
 	}
 
-	mana_destroy_eq(ac);
-
 	if (ac->per_port_queue_reset_wq) {
 		destroy_workqueue(ac->per_port_queue_reset_wq);
 		ac->per_port_queue_reset_wq = NULL;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 04350973e19e..4633acc976f0 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -454,6 +454,11 @@ static int mana_set_coalesce(struct net_device *ndev,
 	return err;
 }
 
+/* mana_set_channels - change the number of queues on a port
+ *
+ * Returns -EBUSY if RDMA holds the vport with EQs sized to the
+ * current num_queues.
+ */
 static int mana_set_channels(struct net_device *ndev,
 			     struct ethtool_channels *channels)
 {
@@ -462,10 +467,22 @@ static int mana_set_channels(struct net_device *ndev,
 	unsigned int old_count = apc->num_queues;
 	int err;
 
+	/* Set channel_changing to block RDMA from grabbing the vport
+	 * during the detach/attach window. mana_cfg_vport() checks
+	 * this flag under vport_mutex and returns -EBUSY if set.
+	 */
+	mutex_lock(&apc->vport_mutex);
+	if (!apc->port_is_up && apc->vport_use_count) {
+		mutex_unlock(&apc->vport_mutex);
+		return -EBUSY;
+	}
+	apc->channel_changing = true;
+	mutex_unlock(&apc->vport_mutex);
+
 	err = mana_pre_alloc_rxbufs(apc, ndev->mtu, new_count);
 	if (err) {
 		netdev_err(ndev, "Insufficient memory for new allocations");
-		return err;
+		goto clear_flag;
 	}
 
 	err = mana_detach(ndev, false);
@@ -483,6 +500,10 @@ static int mana_set_channels(struct net_device *ndev,
 
 out:
 	mana_pre_dealloc_rxbufs(apc);
+clear_flag:
+	mutex_lock(&apc->vport_mutex);
+	apc->channel_changing = false;
+	mutex_unlock(&apc->vport_mutex);
 	return err;
 }
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index aa90a858c8e3..e2384c5ab1df 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -480,8 +480,6 @@ struct mana_context {
 	u8 bm_hostmode;
 
 	struct mana_ethtool_hc_stats hc_stats;
-	struct mana_eq *eqs;
-	struct dentry *mana_eqs_debugfs;
 	struct workqueue_struct *per_port_queue_reset_wq;
 	/* Workqueue for querying hardware stats */
 	struct delayed_work gf_stats_work;
@@ -501,6 +499,9 @@ struct mana_port_context {
 
 	u8 mac_addr[ETH_ALEN];
 
+	struct mana_eq *eqs;
+	struct dentry *mana_eqs_debugfs;
+
 	enum TRI_STATE rss_state;
 
 	mana_handle_t default_rxobj;
@@ -547,6 +548,12 @@ struct mana_port_context {
 	struct mutex vport_mutex;
 	int vport_use_count;
 
+	/* Set by mana_set_channels() under vport_mutex to block RDMA
+	 * from grabbing the vport during the detach/attach window.
+	 * Checked by mana_cfg_vport() when called from the RDMA path.
+	 */
+	bool channel_changing;
+
 	/* Net shaper handle*/
 	struct net_shaper_handle handle;
 
@@ -1032,8 +1039,10 @@ void mana_destroy_wq_obj(struct mana_port_context *apc, u32 wq_type,
 			 mana_handle_t wq_obj);
 
 int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
-		   u32 doorbell_pg_id);
+		   u32 doorbell_pg_id, bool check_channel_changing);
 void mana_uncfg_vport(struct mana_port_context *apc);
+int mana_create_eq(struct mana_port_context *apc);
+void mana_destroy_eq(struct mana_port_context *apc);
 
 struct net_device *mana_get_primary_netdev(struct mana_context *ac,
 					   u32 port_index,
-- 
2.43.0


