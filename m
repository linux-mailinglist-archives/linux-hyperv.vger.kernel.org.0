Return-Path: <linux-hyperv+bounces-11611-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OadxKnAGK2oG1gMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11611-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 21:03:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 388B1674A7A
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 21:03:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b="i/cDRXD7";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11611-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11611-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D6EC303E5A5
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E281392811;
	Thu, 11 Jun 2026 19:03:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B6F20DD51;
	Thu, 11 Jun 2026 19:03:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204589; cv=none; b=SYRUTRUcL3uoe6/Dk6+qZR6bGTzx6ejxisIzRnp2rGYXj3eFoyjnGdLkxm7boti4CM4GBtnUCTruSfDc1EMdhr17UUOHL3nubL6ZTrmr8Tbt++KNo5c5jq4KBr48iXu6MOSdvRi8A+t/O9dbhu5mX1XKehIsJSwA1AdSaQLa38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204589; c=relaxed/simple;
	bh=K7mlTmEKb2+Dk5M/C6pCMsDeN015FIx8a15DrFvPFFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJjabhKXGdlSfkorjbH9f+UJZ5otnzSGy5gPqDcW5R59P+9VSuEhtqQML081X7tPNWLTjY/8exaitsYt9hBGHm7RneeGm3UBOgNbP7uJt2S1kdfNlS9C+goZXbponA9vfxlIYID+hcvOd1RC0IsQ6POAUwwrUt9aa3HJcCjttvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i/cDRXD7; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 708BC20B7167; Thu, 11 Jun 2026 12:02:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 708BC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781204568;
	bh=MN9Sk/Fldvr7QOaT5GlF9TXCtn/EW7OZnhzEblBbtiI=;
	h=From:To:Cc:Subject:Date:From;
	b=i/cDRXD7VFBTEeOjE2R7nCH0WJZNLQkWMdoz+KZbm2EelMsxSs2inlSaNqr6vRQ8o
	 v5HK/fhSeA0xXDaCJZqudZ4mO3oK1yhKvbvrxsBTleTIN2yGAMBp4yhAsZnLZtBxqW
	 tfzdt7bWTP2kHy99JkNiTDdsRMUPIDibmU4HFFbw=
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
Subject: [PATCH net-next v3] net: mana: Add Interrupt Moderation support
Date: Thu, 11 Jun 2026 12:02:22 -0700
Message-ID: <20260611190239.2532429-1-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:kees@kernel.org,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11611-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 388B1674A7A

From: Haiyang Zhang <haiyangz@microsoft.com>

Add Static and Dynamic Interrupt Moderation (DIM) support for
Rx and Tx.
Update queue creation procedure with new data struct with the related
settings.
Add functions to collect stat for DIM, and workers to update DIM data
and settings.
Update ethtool handler to get/set the moderation settings from a user.
To avoid detach/re-attach ops, ring DIM doorbell to change settings
at run time.
By default, adaptive-rx/tx (DIM) are enabled.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v3:
  Updated to avoid detach/re-attach ops as suggested by Paolo.

v2:
  Updated with comments from Jedrzej.

---
 drivers/net/ethernet/microsoft/Kconfig        |   1 +
 .../net/ethernet/microsoft/mana/gdma_main.c   |  29 ++++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 147 +++++++++++++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    | 161 +++++++++++++++++-
 include/net/mana/gdma.h                       |  24 ++-
 include/net/mana/mana.h                       |  47 +++++
 6 files changed, 399 insertions(+), 10 deletions(-)

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
index c9ec80a1dd6f..7a012b1e5751 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /* Copyright (c) 2021, Microsoft Corporation. */
 
+#include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -464,6 +465,7 @@ static int mana_gd_disable_queue(struct gdma_queue *queue)
 #define DOORBELL_OFFSET_RQ	0x400
 #define DOORBELL_OFFSET_CQ	0x800
 #define DOORBELL_OFFSET_EQ	0xFF8
+#define DOORBELL_OFFSET_DIM	0x820
 
 static void mana_gd_ring_doorbell(struct gdma_context *gc, u32 db_index,
 				  enum gdma_queue_type q_type, u32 qid,
@@ -504,6 +506,16 @@ static void mana_gd_ring_doorbell(struct gdma_context *gc, u32 db_index,
 		addr += DOORBELL_OFFSET_SQ;
 		break;
 
+	case GDMA_DIM:
+		e.dim.id = qid;
+		e.dim.mod_usec = FIELD_GET(MANA_INTR_MODR_USEC_MAX, tail_ptr);
+		e.dim.mod_usec_vld = !!(tail_ptr & MANA_INTR_MODR_USEC_VLD);
+		e.dim.mod_comps = FIELD_GET(MANA_INTR_MODR_COMP_MASK, tail_ptr);
+		e.dim.mod_comps_vld = num_req;
+
+		addr += DOORBELL_OFFSET_DIM;
+		break;
+
 	default:
 		WARN_ON(1);
 		return;
@@ -538,6 +550,23 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
 }
 EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
 
+void mana_gd_ring_dim(struct gdma_queue *cq, u32 mod_usec, bool mod_usec_vld,
+		      u32 mod_comps, bool mod_comps_vld)
+{
+	struct gdma_context *gc = cq->gdma_dev->gdma_context;
+	u32 dim_val;
+
+	/* Convert the DIM values to doorbell parameters */
+	dim_val = FIELD_PREP(MANA_INTR_MODR_USEC_MAX, mod_usec) |
+		  FIELD_PREP(MANA_INTR_MODR_COMP_MASK, mod_comps);
+	if (mod_usec_vld)
+		dim_val |= MANA_INTR_MODR_USEC_VLD;
+
+	mana_gd_ring_doorbell(gc, cq->gdma_dev->doorbell, GDMA_DIM, cq->id,
+			      dim_val, mod_comps_vld);
+}
+EXPORT_SYMBOL_NS(mana_gd_ring_dim, "NET_MANA");
+
 #define MANA_SERVICE_PERIOD 10
 
 static void mana_serv_rescan(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 26aef21c6c2c..d92e022d8533 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1579,6 +1579,9 @@ int mana_create_wq_obj(struct mana_port_context *apc,
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
 			     sizeof(req), sizeof(resp));
+
+	req.hdr.req.msg_version = GDMA_MESSAGE_V3;
+	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
 	req.vport = vport;
 	req.wq_type = wq_type;
 	req.wq_gdma_region = wq_spec->gdma_region;
@@ -1587,6 +1590,9 @@ int mana_create_wq_obj(struct mana_port_context *apc,
 	req.cq_size = cq_spec->queue_size;
 	req.cq_moderation_ctx_id = cq_spec->modr_ctx_id;
 	req.cq_parent_qid = cq_spec->attached_eq;
+	req.req_cq_moderation = cq_spec->req_cq_moderation;
+	req.cq_moderation_comp = cq_spec->cq_moderation_comp;
+	req.cq_moderation_usec = cq_spec->cq_moderation_usec;
 
 	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
 				sizeof(resp));
@@ -2306,6 +2312,110 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
 		xdp_do_flush();
 }
 
+static void mana_rx_dim_work(struct work_struct *work)
+{
+	struct dim *dim = container_of(work, struct dim, work);
+	struct dim_cq_moder cur_moder;
+	struct mana_cq *cq;
+
+	cur_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+	cq = container_of(dim, struct mana_cq, dim);
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
+	struct dim_cq_moder cur_moder;
+	struct mana_cq *cq;
+
+	cur_moder = net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
+	cq = container_of(dim, struct mana_cq, dim);
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
+/* The caller must update apc->rx/tx_dim_enabled before disabling and
+ * after enabling. And synchronize_net() before draining the DIM work,
+ * so that NAPI cannot observe a stale flag.
+ */
+int mana_dim_change(struct mana_cq *cq, bool enable)
+{
+	bool is_rx = cq->type == MANA_CQ_TYPE_RX;
+	struct mana_port_context *apc;
+	work_func_t work_func;
+	u32 usec, comp;
+
+	if (is_rx) {
+		apc = netdev_priv(cq->rxq->ndev);
+		usec = apc->intr_modr_rx_usec;
+		comp = apc->intr_modr_rx_comp;
+		work_func = mana_rx_dim_work;
+	} else {
+		apc = netdev_priv(cq->txq->ndev);
+		usec = apc->intr_modr_tx_usec;
+		comp = apc->intr_modr_tx_comp;
+		work_func = mana_tx_dim_work;
+	}
+
+	/* On enable, zero the DIM state so net_dim() starts measuring from
+	 * scratch.
+	 * On disable, drain any pending DIM work and restore the static
+	 * moderation values.
+	 */
+	if (enable) {
+		memset(&cq->dim, 0, sizeof(cq->dim));
+		cq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+		INIT_WORK(&cq->dim.work, work_func);
+	} else {
+		cancel_work_sync(&cq->dim.work);
+		mana_gd_ring_dim(cq->gdma_cq, usec, true, comp, true);
+	}
+
+	return 0;
+}
+
+static void mana_update_rx_dim(struct mana_cq *cq)
+{
+	struct mana_port_context *apc = netdev_priv(cq->rxq->ndev);
+	struct dim_sample dim_sample = {};
+	struct mana_rxq *rxq = cq->rxq;
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
+	struct mana_port_context *apc = netdev_priv(cq->txq->ndev);
+	struct dim_sample dim_sample = {};
+	struct mana_txq *txq = cq->txq;
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
@@ -2324,7 +2434,13 @@ static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
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
@@ -2356,6 +2472,7 @@ static void mana_schedule_napi(void *context, struct gdma_queue *gdma_queue)
 {
 	struct mana_cq *cq = context;
 
+	WRITE_ONCE(cq->dim_event_ctr, cq->dim_event_ctr + 1);
 	napi_schedule_irqoff(&cq->napi);
 }
 
@@ -2398,6 +2515,7 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 		if (apc->tx_qp[i]->txq.napi_initialized) {
 			napi_synchronize(napi);
 			napi_disable_locked(napi);
+			cancel_work_sync(&apc->tx_qp[i]->tx_cq.dim.work);
 			netif_napi_del_locked(napi);
 			apc->tx_qp[i]->txq.napi_initialized = false;
 		}
@@ -2529,6 +2647,11 @@ static int mana_create_txq(struct mana_port_context *apc,
 		cq_spec.modr_ctx_id = 0;
 		cq_spec.attached_eq = cq->gdma_cq->cq.parent->id;
 
+		/* DIM setting can be changed at runtime */
+		cq_spec.req_cq_moderation = true;
+		cq_spec.cq_moderation_usec = apc->intr_modr_tx_usec;
+		cq_spec.cq_moderation_comp = apc->intr_modr_tx_comp;
+
 		err = mana_create_wq_obj(apc, apc->port_handle, GDMA_SQ,
 					 &wq_spec, &cq_spec,
 					 &apc->tx_qp[i]->tx_object);
@@ -2562,6 +2685,9 @@ static int mana_create_txq(struct mana_port_context *apc,
 		napi_enable_locked(&cq->napi);
 		txq->napi_initialized = true;
 
+		INIT_WORK(&cq->dim.work, mana_tx_dim_work);
+		cq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+
 		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 	}
 
@@ -2596,6 +2722,7 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 		napi_synchronize(napi);
 
 		napi_disable_locked(napi);
+		cancel_work_sync(&rxq->rx_cq.dim.work);
 		netif_napi_del_locked(napi);
 	}
 
@@ -2834,6 +2961,11 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	cq_spec.modr_ctx_id = 0;
 	cq_spec.attached_eq = cq->gdma_cq->cq.parent->id;
 
+	/* DIM setting can be changed at runtime */
+	cq_spec.req_cq_moderation = true;
+	cq_spec.cq_moderation_usec = apc->intr_modr_rx_usec;
+	cq_spec.cq_moderation_comp = apc->intr_modr_rx_comp;
+
 	err = mana_create_wq_obj(apc, apc->port_handle, GDMA_RQ,
 				 &wq_spec, &cq_spec, &rxq->rxobj);
 	if (err)
@@ -2868,6 +3000,9 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	napi_enable_locked(&cq->napi);
 
+	INIT_WORK(&cq->dim.work, mana_rx_dim_work);
+	cq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+
 	mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 out:
 	if (!err)
@@ -3532,6 +3667,16 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	apc->link_cfg_error = 1;
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
index 94e658d07a27..67a2b282ff4d 100644
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
 
@@ -428,9 +437,34 @@ static int mana_set_coalesce(struct net_device *ndev,
 			     struct netlink_ext_ack *extack)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
-	u8 saved_cqe_coalescing_enable;
+	struct {
+		u16 intr_modr_rx_usec;
+		u16 intr_modr_rx_comp;
+		u16 intr_modr_tx_usec;
+		u16 intr_modr_tx_comp;
+		u8 cqe_coalescing_enable;
+		bool rx_dim_enabled;
+		bool tx_dim_enabled;
+	} saved;
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
@@ -440,18 +474,123 @@ static int mana_set_coalesce(struct net_device *ndev,
 		return -EINVAL;
 	}
 
-	saved_cqe_coalescing_enable = apc->cqe_coalescing_enable;
+	if (ec->rx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX ||
+	    ec->tx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "coalesce usecs must be <= %lu",
+				   MANA_INTR_MODR_USEC_MAX);
+		return -EINVAL;
+	}
+
+	if (ec->rx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX ||
+	    ec->tx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "coalesce frames must be <= %lu",
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
+	saved.intr_modr_rx_usec = apc->intr_modr_rx_usec;
+	saved.intr_modr_rx_comp = apc->intr_modr_rx_comp;
+	saved.intr_modr_tx_usec = apc->intr_modr_tx_usec;
+	saved.intr_modr_tx_comp = apc->intr_modr_tx_comp;
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
+	saved.rx_dim_enabled = apc->rx_dim_enabled;
+	saved.tx_dim_enabled = apc->tx_dim_enabled;
+
+	saved.cqe_coalescing_enable = apc->cqe_coalescing_enable;
 	apc->cqe_coalescing_enable =
 		kernel_coal->rx_cqe_frames == MANA_RXCOMP_OOB_NUM_PPI;
 
-	if (!apc->port_is_up)
+	if (!apc->port_is_up) {
+		apc->rx_dim_enabled = !!ec->use_adaptive_rx_coalesce;
+		apc->tx_dim_enabled = !!ec->use_adaptive_tx_coalesce;
 		return 0;
+	}
 
-	err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
-	if (err)
-		apc->cqe_coalescing_enable = saved_cqe_coalescing_enable;
+	if (apc->cqe_coalescing_enable != saved.cqe_coalescing_enable) {
+		/* CQE coalescing setting is applied via RSS configuration. */
+		err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
+		if (err) {
+			netdev_err(ndev, "Change CQE coalescing failed: %d\n",
+				   err);
+			apc->cqe_coalescing_enable =
+				saved.cqe_coalescing_enable;
+			apc->intr_modr_rx_usec = saved.intr_modr_rx_usec;
+			apc->intr_modr_rx_comp = saved.intr_modr_rx_comp;
+			apc->intr_modr_tx_usec = saved.intr_modr_tx_usec;
+			apc->intr_modr_tx_comp = saved.intr_modr_tx_comp;
+			return err;
+		}
+	}
 
-	return err;
+	if (modr_changed || dim_changed) {
+		bool new_rx_dim = !!ec->use_adaptive_rx_coalesce;
+		bool new_tx_dim = !!ec->use_adaptive_tx_coalesce;
+		bool disable_rx_dim = saved.rx_dim_enabled && !new_rx_dim;
+		bool disable_tx_dim = saved.tx_dim_enabled && !new_tx_dim;
+		bool enable_rx_dim = !saved.rx_dim_enabled && new_rx_dim;
+		bool enable_tx_dim = !saved.tx_dim_enabled && new_tx_dim;
+		int q;
+
+		/* On disable: clear the per-port flag first and
+		 * synchronize_net() so any in-flight NAPI poll observes
+		 * the new value and will not schedule further DIM work;
+		 * then drain pending work and restore the static
+		 * moderation values.
+		 */
+		if (disable_rx_dim)
+			apc->rx_dim_enabled = false;
+		if (disable_tx_dim)
+			apc->tx_dim_enabled = false;
+		if (disable_rx_dim || disable_tx_dim)
+			synchronize_net();
+
+		for (q = 0; q < apc->num_queues; q++) {
+			struct mana_cq *rx_cq = &apc->rxqs[q]->rx_cq;
+			struct mana_cq *tx_cq = &apc->tx_qp[q]->tx_cq;
+
+			if (disable_rx_dim)
+				mana_dim_change(rx_cq, false);
+			else if (enable_rx_dim)
+				mana_dim_change(rx_cq, true);
+			else if (!new_rx_dim && modr_changed)
+				mana_gd_ring_dim(rx_cq->gdma_cq,
+						 apc->intr_modr_rx_usec, true,
+						 apc->intr_modr_rx_comp, true);
+
+			if (disable_tx_dim)
+				mana_dim_change(tx_cq, false);
+			else if (enable_tx_dim)
+				mana_dim_change(tx_cq, true);
+			else if (!new_tx_dim && modr_changed)
+				mana_gd_ring_dim(tx_cq->gdma_cq,
+						 apc->intr_modr_tx_usec, true,
+						 apc->intr_modr_tx_comp, true);
+		}
+
+		if (enable_rx_dim)
+			apc->rx_dim_enabled = true;
+		if (enable_tx_dim)
+			apc->tx_dim_enabled = true;
+	}
+
+	return 0;
 }
 
 /* mana_set_channels - change the number of queues on a port
@@ -595,7 +734,13 @@ static int mana_get_link_ksettings(struct net_device *ndev,
 }
 
 const struct ethtool_ops mana_ethtool_ops = {
-	.supported_coalesce_params = ETHTOOL_COALESCE_RX_CQE_FRAMES,
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_CQE_FRAMES |
+				     ETHTOOL_COALESCE_RX_USECS |
+				     ETHTOOL_COALESCE_RX_MAX_FRAMES |
+				     ETHTOOL_COALESCE_TX_USECS |
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_TX,
 	.op_needs_rtnl		= ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
 				  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
 	.get_ethtool_stats	= mana_get_ethtool_stats,
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 0c395917b214..8529cef0d7c4 100644
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
@@ -502,6 +514,9 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit);
 
 int mana_schedule_serv_work(struct gdma_context *gc, enum gdma_eqe_type type);
 
+void mana_gd_ring_dim(struct gdma_queue *cq, u32 mod_usec, bool mod_usec_vld,
+		      u32 mod_comps, bool mod_comps_vld);
+
 struct gdma_wqe {
 	u32 reserved	:24;
 	u32 last_vbytes	:8;
@@ -650,6 +665,9 @@ enum {
 /* Driver supports self recovery on Hardware Channel timeouts */
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY BIT(25)
 
+/* Driver supports dynamic interrupt moderation - DIM */
+#define GDMA_DRV_CAP_FLAG_1_DYN_INTERRUPT_MODERATION BIT(28)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -665,7 +683,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY | \
-	 GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT)
+	 GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT | \
+	 GDMA_DRV_CAP_FLAG_1_DYN_INTERRUPT_MODERATION)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
@@ -701,6 +720,9 @@ struct gdma_verify_ver_req {
 	u8 os_ver_str4[128];
 }; /* HW DATA */
 
+/* HW supports dynamic interrupt moderation - DIM */
+#define GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION BIT(15)
+
 struct gdma_verify_ver_resp {
 	struct gdma_resp_hdr hdr;
 	u64 gdma_protocol_ver;
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 13c87baf018e..f7d0109c9c22 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -4,6 +4,7 @@
 #ifndef _MANA_H
 #define _MANA_H
 
+#include <linux/dim.h>
 #include <net/xdp.h>
 #include <net/net_shaper.h>
 
@@ -64,6 +65,19 @@ enum TRI_STATE {
 /* Maximum number of packets per coalesced CQE */
 #define MANA_RXCOMP_OOB_NUM_PPI 4
 
+/* Default/max interrupt moderation settings */
+#define MANA_INTR_MODR_USEC_DEF 0
+#define MANA_INTR_MODR_COMP_DEF 0
+
+#define MANA_ADAPTIVE_RX_DEF true
+#define MANA_ADAPTIVE_TX_DEF true
+
+/* DIM doorbell value field layout */
+#define MANA_INTR_MODR_USEC_MAX    GENMASK(9, 0)
+#define MANA_INTR_MODR_USEC_VLD    BIT(15)
+#define MANA_INTR_MODR_COMP_MAX    GENMASK(7, 0)
+#define MANA_INTR_MODR_COMP_MASK   GENMASK(23, 16)
+
 /* Update this count whenever the respective structures are changed */
 #define MANA_STATS_RX_COUNT (6 + MANA_RXCOMP_OOB_NUM_PPI - 1)
 #define MANA_STATS_TX_COUNT 11
@@ -297,6 +311,10 @@ struct mana_cq {
 	int work_done;
 	int work_done_since_doorbell;
 	int budget;
+
+	/* DIM - Dynamic Interrupt Moderation */
+	struct dim dim;
+	u16 dim_event_ctr;
 };
 
 struct mana_recv_buf_oob {
@@ -573,6 +591,15 @@ struct mana_port_context {
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
@@ -598,6 +625,8 @@ int mana_alloc_queues(struct net_device *ndev);
 int mana_attach(struct net_device *ndev);
 int mana_detach(struct net_device *ndev, bool from_close);
 
+int mana_dim_change(struct mana_cq *cq, bool enable);
+
 int mana_probe(struct gdma_dev *gd, bool resuming);
 void mana_remove(struct gdma_dev *gd, bool suspending);
 
@@ -633,6 +662,9 @@ struct mana_obj_spec {
 	u32 queue_size;
 	u32 attached_eq;
 	u32 modr_ctx_id;
+	u8 req_cq_moderation;
+	u16 cq_moderation_comp;
+	u16 cq_moderation_usec;
 };
 
 enum mana_command_code {
@@ -764,6 +796,15 @@ struct mana_create_wqobj_req {
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
@@ -771,6 +812,12 @@ struct mana_create_wqobj_resp {
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


