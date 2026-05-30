Return-Path: <linux-hyperv+bounces-11415-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uqTbLsA/G2oMAgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11415-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:51:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1257F613182
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 21:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2F803017247
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D2C29B799;
	Sat, 30 May 2026 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RCW/ll0B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79636233952;
	Sat, 30 May 2026 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170682; cv=none; b=Z/AfWUbM/mxCoSvnVDp3SYLJw8U2RLBxETAPIfb7Cap0bav2fHDNEYKRZQsv9wr5IK0olhiN2DXKvnljyb7Xzzz9syGtSsNhlrgpcnCB7tggB2mpRjIQl9odwTcU2q8mH7zvO4Zx2ZTQ7+GlbsYffZxN4dV65NEe8r3MrTZ9hEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170682; c=relaxed/simple;
	bh=95CfneWAt1S7aCos/ViAGhcX8UjxDojb7em6I8E9LhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Luo8SAOU7mYC3FLxCgCPDh+YUP2A7cfKx8y/oWarKSJXzWxv/gJ4pM8qYOBvwIdY1S41lSvsvLWlXGuc2CjdgF2yEAM9cS3vhovHDmXl8PjCxdv0tRg/cjnILj+6K+SV5uKsbVbgS41JGUQMnhgcbG79Y1FJ2GHd5EC/ux+BW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RCW/ll0B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 7467B20B7166; Sat, 30 May 2026 12:51:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7467B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780170662;
	bh=JkHx7HIOT5Sgk20mbVQQS0xnT+myYBlGKwo31XmYPlc=;
	h=From:To:Cc:Subject:Date:From;
	b=RCW/ll0BiGD+uT8IL67or+EI+qFMSMn+TGAM3iYd/l7xS+pAyeqxIqff4uPC0JI0O
	 /FYmv/FE9oWdGSHD4YKXyeVl3gItMbNiEJ6854cC1w6MC1Iw6tgzkAzLUeh7P5FmQC
	 hr6hzTTDURSKQuhhLgEAIi1NThyPW2YZBFAkb13s=
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
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: paulros@microsoft.com
Subject: [PATCH net-next] net: mana: Add Interrupt Moderation support
Date: Sat, 30 May 2026 12:49:40 -0700
Message-ID: <20260530194957.1690459-1-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-11415-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 1257F613182
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haiyang Zhang <haiyangz@microsoft.com>

Add Static and Dynamic Interrupt Moderation (DIM) support for
Rx and Tx.
Update queue creation procedure with new data struct with the related
settings.
Add functions to collect stat for DIM, and workers to update DIM data
and settings.
Update ethtool handler to get/set the moderation settings from a user.
By default, adaptive-rx/tx (DIM) are enabled.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/Kconfig        |   1 +
 .../net/ethernet/microsoft/mana/gdma_main.c   |  27 ++++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 101 ++++++++++++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    | 120 +++++++++++++++++-
 include/net/mana/gdma.h                       |  24 +++-
 include/net/mana/mana.h                       |  42 ++++++
 6 files changed, 309 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/Kconfig b/drivers/net/ethernet/microsoft/Kconfig
index 3f36ee6a8ece..e9be18c92ca5 100644
--- a/drivers/net/ethernet/microsoft/Kconfig
+++ b/drivers/net/ethernet/microsoft/Kconfig
@@ -21,6 +21,7 @@ config MICROSOFT_MANA
 	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN)
 	depends on PCI_HYPERV
 	select AUXILIARY_BUS
+	select DIMLIB
 	select PAGE_POOL
 	select NET_SHAPER
 	help
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 712a0881d720..5aa0ea794a00 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -405,6 +405,7 @@ static int mana_gd_disable_queue(struct gdma_queue *queue)
 #define DOORBELL_OFFSET_RQ	0x400
 #define DOORBELL_OFFSET_CQ	0x800
 #define DOORBELL_OFFSET_EQ	0xFF8
+#define DOORBELL_OFFSET_DIM	0x820
 
 static void mana_gd_ring_doorbell(struct gdma_context *gc, u32 db_index,
 				  enum gdma_queue_type q_type, u32 qid,
@@ -445,6 +446,16 @@ static void mana_gd_ring_doorbell(struct gdma_context *gc, u32 db_index,
 		addr += DOORBELL_OFFSET_SQ;
 		break;
 
+	case GDMA_DIM:
+		e.dim.id = qid;
+		e.dim.mod_usec = tail_ptr;
+		e.dim.mod_usec_vld = tail_ptr >> 15;
+		e.dim.mod_comps = tail_ptr >> 16;
+		e.dim.mod_comps_vld = num_req;
+
+		addr += DOORBELL_OFFSET_DIM;
+		break;
+
 	default:
 		WARN_ON(1);
 		return;
@@ -479,6 +490,22 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
 }
 EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
 
+void mana_gd_ring_dim(struct gdma_queue *cq, u32 mod_usec, bool mod_usec_vld,
+		      u32 mod_comps, bool mod_comps_vld)
+{
+	struct gdma_context *gc = cq->gdma_dev->gdma_context;
+	u32 dim_val;
+
+	/* Convert the DIM values to doorbell parameters */
+	dim_val = (mod_usec & MANA_INTR_MODR_USEC_MAX) |
+		  (((u32)mod_usec_vld & 1) << 15) |
+		  ((mod_comps & MANA_INTR_MODR_COMP_MAX) << 16);
+
+	mana_gd_ring_doorbell(gc, cq->gdma_dev->doorbell, GDMA_DIM, cq->id,
+			      dim_val, (u8)mod_comps_vld & 1);
+}
+EXPORT_SYMBOL_NS(mana_gd_ring_dim, "NET_MANA");
+
 #define MANA_SERVICE_PERIOD 10
 
 static void mana_serv_rescan(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 82f1461a48e9..f1a16f8aca66 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1551,6 +1551,9 @@ int mana_create_wq_obj(struct mana_port_context *apc,
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
 			     sizeof(req), sizeof(resp));
+
+	req.hdr.req.msg_version = GDMA_MESSAGE_V3;
+	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
 	req.vport = vport;
 	req.wq_type = wq_type;
 	req.wq_gdma_region = wq_spec->gdma_region;
@@ -1559,6 +1562,9 @@ int mana_create_wq_obj(struct mana_port_context *apc,
 	req.cq_size = cq_spec->queue_size;
 	req.cq_moderation_ctx_id = cq_spec->modr_ctx_id;
 	req.cq_parent_qid = cq_spec->attached_eq;
+	req.req_cq_moderation = cq_spec->req_cq_moderation;
+	req.cq_moderation_comp = cq_spec->cq_moderation_comp;
+	req.cq_moderation_usec = cq_spec->cq_moderation_usec;
 
 	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
 				sizeof(resp));
@@ -2253,6 +2259,66 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
 		xdp_do_flush();
 }
 
+static void mana_rx_dim_work(struct work_struct *work)
+{
+	struct dim *dim = container_of(work, struct dim, work);
+	struct mana_cq *cq = container_of(dim, struct mana_cq, dim);
+	struct dim_cq_moder cur_moder =
+		net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+
+	cur_moder.usec = min_t(u16, cur_moder.usec, MANA_INTR_MODR_USEC_MAX);
+	cur_moder.pkts = min_t(u16, cur_moder.pkts, MANA_INTR_MODR_COMP_MAX);
+
+	mana_gd_ring_dim(cq->gdma_cq, cur_moder.usec, true,
+			 cur_moder.pkts, true);
+
+	dim->state = DIM_START_MEASURE;
+}
+
+static void mana_tx_dim_work(struct work_struct *work)
+{
+	struct dim *dim = container_of(work, struct dim, work);
+	struct mana_cq *cq = container_of(dim, struct mana_cq, dim);
+	struct dim_cq_moder cur_moder =
+		net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
+
+	cur_moder.usec = min_t(u16, cur_moder.usec, MANA_INTR_MODR_USEC_MAX);
+	cur_moder.pkts = min_t(u16, cur_moder.pkts, MANA_INTR_MODR_COMP_MAX);
+
+	mana_gd_ring_dim(cq->gdma_cq, cur_moder.usec, true,
+			 cur_moder.pkts, true);
+
+	dim->state = DIM_START_MEASURE;
+}
+
+static void mana_update_rx_dim(struct mana_cq *cq)
+{
+	struct mana_rxq *rxq = cq->rxq;
+	struct mana_port_context *apc = netdev_priv(rxq->ndev);
+	struct dim_sample dim_sample = {};
+
+	if (!apc->rx_dim_enabled)
+		return;
+
+	dim_update_sample(READ_ONCE(cq->dim_event_ctr), rxq->stats.packets,
+			  rxq->stats.bytes, &dim_sample);
+	net_dim(&cq->dim, &dim_sample);
+}
+
+static void mana_update_tx_dim(struct mana_cq *cq)
+{
+	struct mana_txq *txq = cq->txq;
+	struct mana_port_context *apc = netdev_priv(txq->ndev);
+	struct dim_sample dim_sample = {};
+
+	if (!apc->tx_dim_enabled)
+		return;
+
+	dim_update_sample(READ_ONCE(cq->dim_event_ctr), txq->stats.packets,
+			  txq->stats.bytes, &dim_sample);
+	net_dim(&cq->dim, &dim_sample);
+}
+
 static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
 {
 	struct mana_cq *cq = context;
@@ -2271,7 +2337,13 @@ static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
 	if (w < cq->budget) {
 		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
 		cq->work_done_since_doorbell = 0;
-		napi_complete_done(&cq->napi, w);
+
+		if (napi_complete_done(&cq->napi, w)) {
+			if (cq->type == MANA_CQ_TYPE_RX)
+				mana_update_rx_dim(cq);
+			else
+				mana_update_tx_dim(cq);
+		}
 	} else if (cq->work_done_since_doorbell >=
 		   (cq->gdma_cq->queue_size / COMP_ENTRY_SIZE) * 4) {
 		/* MANA hardware requires at least one doorbell ring every 8
@@ -2303,6 +2375,7 @@ static void mana_schedule_napi(void *context, struct gdma_queue *gdma_queue)
 {
 	struct mana_cq *cq = context;
 
+	WRITE_ONCE(cq->dim_event_ctr, cq->dim_event_ctr + 1);
 	napi_schedule_irqoff(&cq->napi);
 }
 
@@ -2345,6 +2418,7 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 		if (apc->tx_qp[i]->txq.napi_initialized) {
 			napi_synchronize(napi);
 			napi_disable_locked(napi);
+			cancel_work_sync(&apc->tx_qp[i]->tx_cq.dim.work);
 			netif_napi_del_locked(napi);
 			apc->tx_qp[i]->txq.napi_initialized = false;
 		}
@@ -2475,6 +2549,10 @@ static int mana_create_txq(struct mana_port_context *apc,
 		cq_spec.queue_size = cq->gdma_cq->queue_size;
 		cq_spec.modr_ctx_id = 0;
 		cq_spec.attached_eq = cq->gdma_cq->cq.parent->id;
+		cq_spec.req_cq_moderation = apc->tx_dim_enabled ||
+			(apc->intr_modr_tx_usec && apc->intr_modr_tx_comp);
+		cq_spec.cq_moderation_usec = apc->intr_modr_tx_usec;
+		cq_spec.cq_moderation_comp = apc->intr_modr_tx_comp;
 
 		err = mana_create_wq_obj(apc, apc->port_handle, GDMA_SQ,
 					 &wq_spec, &cq_spec,
@@ -2509,6 +2587,9 @@ static int mana_create_txq(struct mana_port_context *apc,
 		napi_enable_locked(&cq->napi);
 		txq->napi_initialized = true;
 
+		INIT_WORK(&cq->dim.work, mana_tx_dim_work);
+		cq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+
 		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 	}
 
@@ -2543,6 +2624,7 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 		napi_synchronize(napi);
 
 		napi_disable_locked(napi);
+		cancel_work_sync(&rxq->rx_cq.dim.work);
 		netif_napi_del_locked(napi);
 	}
 
@@ -2780,6 +2862,10 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	cq_spec.queue_size = cq->gdma_cq->queue_size;
 	cq_spec.modr_ctx_id = 0;
 	cq_spec.attached_eq = cq->gdma_cq->cq.parent->id;
+	cq_spec.req_cq_moderation = apc->rx_dim_enabled ||
+		(apc->intr_modr_rx_usec && apc->intr_modr_rx_comp);
+	cq_spec.cq_moderation_usec = apc->intr_modr_rx_usec;
+	cq_spec.cq_moderation_comp = apc->intr_modr_rx_comp;
 
 	err = mana_create_wq_obj(apc, apc->port_handle, GDMA_RQ,
 				 &wq_spec, &cq_spec, &rxq->rxobj);
@@ -2815,6 +2901,9 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	napi_enable_locked(&cq->napi);
 
+	INIT_WORK(&cq->dim.work, mana_rx_dim_work);
+	cq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+
 	mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 out:
 	if (!err)
@@ -3432,6 +3521,16 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	apc->port_idx = port_idx;
 	apc->cqe_coalescing_enable = 0;
 
+	/* Initialize interrupt moderation settings if supported by HW */
+	if (gc->pf_cap_flags1 & GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION) {
+		apc->intr_modr_rx_usec = MANA_INTR_MODR_USEC_DEF;
+		apc->intr_modr_rx_comp = MANA_INTR_MODR_COMP_DEF;
+		apc->intr_modr_tx_usec = MANA_INTR_MODR_USEC_DEF;
+		apc->intr_modr_tx_comp = MANA_INTR_MODR_COMP_DEF;
+		apc->rx_dim_enabled = MANA_ADAPTIVE_RX_DEF;
+		apc->tx_dim_enabled = MANA_ADAPTIVE_TX_DEF;
+	}
+
 	mutex_init(&apc->vport_mutex);
 	apc->vport_use_count = 0;
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 04350973e19e..a90216eba794 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -419,6 +419,15 @@ static int mana_get_coalesce(struct net_device *ndev,
 	    !kernel_coal->rx_cqe_nsecs)
 		kernel_coal->rx_cqe_nsecs = MANA_RX_CQE_NSEC_DEF;
 
+	ec->rx_coalesce_usecs = apc->intr_modr_rx_usec;
+	ec->rx_max_coalesced_frames = apc->intr_modr_rx_comp;
+
+	ec->tx_coalesce_usecs = apc->intr_modr_tx_usec;
+	ec->tx_max_coalesced_frames = apc->intr_modr_tx_comp;
+
+	ec->use_adaptive_rx_coalesce = apc->rx_dim_enabled;
+	ec->use_adaptive_tx_coalesce = apc->tx_dim_enabled;
+
 	return 0;
 }
 
@@ -429,8 +438,28 @@ static int mana_set_coalesce(struct net_device *ndev,
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
 	u8 saved_cqe_coalescing_enable;
+	u16 old_rx_usec, old_rx_comp;
+	u16 old_tx_usec, old_tx_comp;
+	bool old_rx_dim, old_tx_dim;
+	bool modr_changed = false;
+	bool dim_changed = false;
+	struct gdma_context *gc;
 	int err;
 
+	gc = apc->ac->gdma_dev->gdma_context;
+
+	/* Both static and dynamic interrupt moderation (DIM) rely on the
+	 * same HW capability advertised by the PF.
+	 */
+	if ((ec->use_adaptive_rx_coalesce || ec->use_adaptive_tx_coalesce ||
+	     ec->rx_coalesce_usecs || ec->tx_coalesce_usecs ||
+	     ec->rx_max_coalesced_frames || ec->tx_max_coalesced_frames) &&
+	    !(gc->pf_cap_flags1 & GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION)) {
+		NL_SET_ERR_MSG(extack,
+			       "Interrupt Moderation is not supported by HW");
+		return -EOPNOTSUPP;
+	}
+
 	if (kernel_coal->rx_cqe_frames != 1 &&
 	    kernel_coal->rx_cqe_frames != MANA_RXCOMP_OOB_NUM_PPI) {
 		NL_SET_ERR_MSG_FMT(extack,
@@ -440,6 +469,47 @@ static int mana_set_coalesce(struct net_device *ndev,
 		return -EINVAL;
 	}
 
+	if (ec->rx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX ||
+	    ec->tx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "coalesce usecs must be <= %u",
+				   MANA_INTR_MODR_USEC_MAX);
+		return -EINVAL;
+	}
+
+	if (ec->rx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX ||
+	    ec->tx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "coalesce frames must be <= %u",
+				   MANA_INTR_MODR_COMP_MAX);
+		return -EINVAL;
+	}
+
+	if (ec->rx_coalesce_usecs != apc->intr_modr_rx_usec ||
+	    ec->rx_max_coalesced_frames != apc->intr_modr_rx_comp ||
+	    ec->tx_coalesce_usecs != apc->intr_modr_tx_usec ||
+	    ec->tx_max_coalesced_frames != apc->intr_modr_tx_comp)
+		modr_changed = true;
+
+	old_rx_usec = apc->intr_modr_rx_usec;
+	old_rx_comp = apc->intr_modr_rx_comp;
+	old_tx_usec = apc->intr_modr_tx_usec;
+	old_tx_comp = apc->intr_modr_tx_comp;
+
+	apc->intr_modr_rx_usec = ec->rx_coalesce_usecs;
+	apc->intr_modr_rx_comp = ec->rx_max_coalesced_frames;
+	apc->intr_modr_tx_usec = ec->tx_coalesce_usecs;
+	apc->intr_modr_tx_comp = ec->tx_max_coalesced_frames;
+
+	if (!!ec->use_adaptive_rx_coalesce != apc->rx_dim_enabled ||
+	    !!ec->use_adaptive_tx_coalesce != apc->tx_dim_enabled)
+		dim_changed = true;
+
+	old_rx_dim = apc->rx_dim_enabled;
+	old_tx_dim = apc->tx_dim_enabled;
+	apc->rx_dim_enabled = !!ec->use_adaptive_rx_coalesce;
+	apc->tx_dim_enabled = !!ec->use_adaptive_tx_coalesce;
+
 	saved_cqe_coalescing_enable = apc->cqe_coalescing_enable;
 	apc->cqe_coalescing_enable =
 		kernel_coal->rx_cqe_frames == MANA_RXCOMP_OOB_NUM_PPI;
@@ -447,10 +517,46 @@ static int mana_set_coalesce(struct net_device *ndev,
 	if (!apc->port_is_up)
 		return 0;
 
-	err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
-	if (err)
-		apc->cqe_coalescing_enable = saved_cqe_coalescing_enable;
+	if (apc->cqe_coalescing_enable != saved_cqe_coalescing_enable &&
+	    !modr_changed && !dim_changed) {
+		/* If only CQE coalescing setting is changed, we can just update
+		 * RSS configuration.
+		 */
+		err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
+		if (err) {
+			netdev_err(ndev, "Change CQE coalescing failed: %d\n",
+				   err);
+			apc->cqe_coalescing_enable =
+				saved_cqe_coalescing_enable;
+			return err;
+		}
+		return 0;
+	}
+
+	if (modr_changed || dim_changed) {
+		err = mana_detach(ndev, false);
+		if (err) {
+			netdev_err(ndev, "mana_detach failed: %d\n", err);
+			goto restore_modr;
+		}
+
+		err = mana_attach(ndev);
+		if (err) {
+			netdev_err(ndev, "mana_attach failed: %d\n", err);
+			goto restore_modr;
+		}
+	}
+
+	return 0;
 
+restore_modr:
+	apc->cqe_coalescing_enable = saved_cqe_coalescing_enable;
+	apc->intr_modr_rx_usec = old_rx_usec;
+	apc->intr_modr_rx_comp = old_rx_comp;
+	apc->intr_modr_tx_usec = old_tx_usec;
+	apc->intr_modr_tx_comp = old_tx_comp;
+	apc->rx_dim_enabled = old_rx_dim;
+	apc->tx_dim_enabled = old_tx_dim;
 	return err;
 }
 
@@ -574,7 +680,13 @@ static int mana_get_link_ksettings(struct net_device *ndev,
 }
 
 const struct ethtool_ops mana_ethtool_ops = {
-	.supported_coalesce_params = ETHTOOL_COALESCE_RX_CQE_FRAMES,
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_CQE_FRAMES |
+				    ETHTOOL_COALESCE_RX_USECS |
+				    ETHTOOL_COALESCE_RX_MAX_FRAMES |
+				    ETHTOOL_COALESCE_TX_USECS |
+				    ETHTOOL_COALESCE_TX_MAX_FRAMES |
+				    ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+				    ETHTOOL_COALESCE_USE_ADAPTIVE_TX,
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
 	.get_strings		= mana_get_strings,
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 70d62bc32837..0a0cc7b080d3 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -47,6 +47,7 @@ enum gdma_queue_type {
 	GDMA_RQ,
 	GDMA_CQ,
 	GDMA_EQ,
+	GDMA_DIM,
 };
 
 enum gdma_work_request_flags {
@@ -126,6 +127,17 @@ union gdma_doorbell_entry {
 		u64 tail_ptr	: 31;
 		u64 arm		: 1;
 	} eq;
+
+	struct {
+		u64 id           : 24;
+		u64 reserved     : 8;
+		u64 mod_usec     : 10;
+		u64 reserve1     : 5;
+		u64 mod_usec_vld : 1;
+		u64 mod_comps    : 8;
+		u64 reserve2     : 7;
+		u64 mod_comps_vld: 1;
+	} dim;
 }; /* HW DATA */
 
 struct gdma_msg_hdr {
@@ -484,6 +496,9 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit);
 
 int mana_schedule_serv_work(struct gdma_context *gc, enum gdma_eqe_type type);
 
+void mana_gd_ring_dim(struct gdma_queue *cq, u32 mod_usec, bool mod_usec_vld,
+		      u32 mod_comps, bool mod_comps_vld);
+
 struct gdma_wqe {
 	u32 reserved	:24;
 	u32 last_vbytes	:8;
@@ -629,6 +644,9 @@ enum {
 /* Driver supports self recovery on Hardware Channel timeouts */
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY BIT(25)
 
+/* Driver supports dynamic interrupt moderation - DIM */
+#define GDMA_DRV_CAP_FLAG_1_DYN_INTERRUPT_MODERATION BIT(27)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -643,7 +661,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE | \
 	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
-	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY)
+	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY | \
+	 GDMA_DRV_CAP_FLAG_1_DYN_INTERRUPT_MODERATION)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
@@ -679,6 +698,9 @@ struct gdma_verify_ver_req {
 	u8 os_ver_str4[128];
 }; /* HW DATA */
 
+/* HW supports dynamic interrupt moderation - DIM */
+#define GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION BIT(15)
+
 struct gdma_verify_ver_resp {
 	struct gdma_resp_hdr hdr;
 	u64 gdma_protocol_ver;
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index d9c27310fd04..57868a79f23d 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -4,6 +4,7 @@
 #ifndef _MANA_H
 #define _MANA_H
 
+#include <linux/dim.h>
 #include <net/xdp.h>
 #include <net/net_shaper.h>
 
@@ -64,6 +65,16 @@ enum TRI_STATE {
 /* Maximum number of packets per coalesced CQE */
 #define MANA_RXCOMP_OOB_NUM_PPI 4
 
+/* Default/max interrupt moderation settings */
+#define MANA_INTR_MODR_USEC_DEF 0
+#define MANA_INTR_MODR_COMP_DEF 0
+
+#define MANA_ADAPTIVE_RX_DEF true
+#define MANA_ADAPTIVE_TX_DEF true
+
+#define MANA_INTR_MODR_USEC_MAX 1023
+#define MANA_INTR_MODR_COMP_MAX 255
+
 /* Update this count whenever the respective structures are changed */
 #define MANA_STATS_RX_COUNT (6 + MANA_RXCOMP_OOB_NUM_PPI - 1)
 #define MANA_STATS_TX_COUNT 11
@@ -297,6 +308,10 @@ struct mana_cq {
 	int work_done;
 	int work_done_since_doorbell;
 	int budget;
+
+	/* DIM - Dynamic Interrupt Moderation */
+	struct dim dim;
+	u16 dim_event_ctr;
 };
 
 struct mana_recv_buf_oob {
@@ -562,6 +577,15 @@ struct mana_port_context {
 	u8 cqe_coalescing_enable;
 	u32 cqe_coalescing_timeout_ns;
 
+	/* Interrupt moderation settings */
+	u16 intr_modr_rx_usec;
+	u16 intr_modr_rx_comp;
+	u16 intr_modr_tx_usec;
+	u16 intr_modr_tx_comp;
+
+	bool rx_dim_enabled;
+	bool tx_dim_enabled;
+
 	struct mana_ethtool_stats eth_stats;
 
 	struct mana_ethtool_phy_stats phy_stats;
@@ -622,6 +646,9 @@ struct mana_obj_spec {
 	u32 queue_size;
 	u32 attached_eq;
 	u32 modr_ctx_id;
+	u8 req_cq_moderation;
+	u16 cq_moderation_comp;
+	u16 cq_moderation_usec;
 };
 
 enum mana_command_code {
@@ -753,6 +780,15 @@ struct mana_create_wqobj_req {
 	u32 cq_size;
 	u32 cq_moderation_ctx_id;
 	u32 cq_parent_qid;
+
+	/* V2 */
+	u8 allow_rqwqe_chain;
+
+	/* V3 */
+	u8 req_cq_moderation;
+	u16 cq_moderation_comp;
+	u16 cq_moderation_usec;
+	u8 reserved2[2];
 }; /* HW DATA */
 
 struct mana_create_wqobj_resp {
@@ -760,6 +796,12 @@ struct mana_create_wqobj_resp {
 	u32 wq_id;
 	u32 cq_id;
 	mana_handle_t wq_obj;
+
+	/* V2 */
+	u16 cq_moderation_comp;
+	u16 cq_moderation_usec;
+	u8 cq_moderation_enabled;
+	u8 reserved1[3];
 }; /* HW DATA */
 
 /* Destroy WQ Object */
-- 
2.34.1


