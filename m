Return-Path: <linux-hyperv+bounces-10155-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePl8EaFa3mmLCAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10155-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:17:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2153FB9E9
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 073C8302B711
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5FE3E9F80;
	Tue, 14 Apr 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H42WZCDH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132C3E95A8;
	Tue, 14 Apr 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179720; cv=none; b=JBQJ6lrPTtDkTTUZauUlws1qA+qRMHHMSGPzktH+LRpIb+gCk3H8F1wNHI4Z6fTKZujpPcp6PpNDBtCmh781JrZEvPVujhWfPFzZYfyrpGIWDR8cp6iOhDXYUEKXZC2VC4fQJ0e7cucdtIGhRoTXjKOTd209IGbnqgrV7mYPNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179720; c=relaxed/simple;
	bh=Di1JA4Ram1MiQF1FyaOBMzcfg/g+eA4bIa7w+mZnfYo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqvNrurSM24YkStWbVz3sbBLIKCmt+smN/6mJcxRsauZSPqDpw1XEKxH0pUc5WWFs/q4s5nhQMgG18QNK5rgxljg14oG23rLgpLfTwhYI02/aljmDLkoQqFXNkHgHjvalpo7P2Qp06Y0lbQ2amfE7vfpZ7DzziJ8+UHh8xajfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H42WZCDH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 64E0B20B6F08; Tue, 14 Apr 2026 08:15:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64E0B20B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776179711;
	bh=rLZz0PkYAQ7B4IWNnTCFmEXHXhEdRzFN3farQz9kRRA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H42WZCDHrqJZfUKiEmY5AUspv0fEKNA5ews5vBOPD+Kun4RdgDKUS6iDQh4NbjX+/
	 jA/L/EsqWaByPh43BjeFLfun5Cg9i3lbJG0wGKqM9/9NDz2mMOMlmrSazueo2soN7A
	 jG9XIAzIpM+/2A2EmRQTzsoCz2+nD7fX15+SHGeo=
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	ssengar@linux.microsoft.com,
	jacob.e.keller@intel.com,
	dipayanroy@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	sbhatta@marvell.com,
	leitao@debian.org,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com
Subject: [PATCH net-next 1/2] net: mana: Use per-queue allocation for tx_qp to reduce allocation size
Date: Tue, 14 Apr 2026 08:13:29 -0700
Message-ID: <20260414151456.687506-2-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260414151456.687506-1-gargaditya@linux.microsoft.com>
References: <20260414151456.687506-1-gargaditya@linux.microsoft.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10155-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 3F2153FB9E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert tx_qp from a single contiguous array allocation to per-queue
individual allocations. Each mana_tx_qp struct is approximately 35KB.
With many queues (e.g., 32/64), the flat array requires a single
contiguous allocation that can fail under memory fragmentation.

Change mana_tx_qp *tx_qp to mana_tx_qp **tx_qp (array of pointers),
allocating each queue's mana_tx_qp individually via kvzalloc. This
reduces each allocation to ~35KB and provides vmalloc fallback,
avoiding allocation failure due to fragmentation.

Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 .../net/ethernet/microsoft/mana/mana_bpf.c    |  2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 49 ++++++++++++-------
 .../ethernet/microsoft/mana/mana_ethtool.c    |  2 +-
 include/net/mana/mana.h                       |  2 +-
 4 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index 7697c9b52ed3..b5e9bb184a1d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -68,7 +68,7 @@ int mana_xdp_xmit(struct net_device *ndev, int n, struct xdp_frame **frames,
 		count++;
 	}
 
-	tx_stats = &apc->tx_qp[q_idx].txq.stats;
+	tx_stats = &apc->tx_qp[q_idx]->txq.stats;
 
 	u64_stats_update_begin(&tx_stats->syncp);
 	tx_stats->xdp_xmit += count;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 09a53c977545..49ee77b0939a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -355,9 +355,9 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (skb_cow_head(skb, MANA_HEADROOM))
 		goto tx_drop_count;
 
-	txq = &apc->tx_qp[txq_idx].txq;
+	txq = &apc->tx_qp[txq_idx]->txq;
 	gdma_sq = txq->gdma_sq;
-	cq = &apc->tx_qp[txq_idx].tx_cq;
+	cq = &apc->tx_qp[txq_idx]->tx_cq;
 	tx_stats = &txq->stats;
 
 	BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES != MANA_MAX_TX_WQE_SGL_ENTRIES);
@@ -614,7 +614,7 @@ static void mana_get_stats64(struct net_device *ndev,
 	}
 
 	for (q = 0; q < num_queues; q++) {
-		tx_stats = &apc->tx_qp[q].txq.stats;
+		tx_stats = &apc->tx_qp[q]->txq.stats;
 
 		do {
 			start = u64_stats_fetch_begin(&tx_stats->syncp);
@@ -2284,21 +2284,26 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 		return;
 
 	for (i = 0; i < apc->num_queues; i++) {
-		debugfs_remove_recursive(apc->tx_qp[i].mana_tx_debugfs);
-		apc->tx_qp[i].mana_tx_debugfs = NULL;
+		if (!apc->tx_qp[i])
+			continue;
+
+		debugfs_remove_recursive(apc->tx_qp[i]->mana_tx_debugfs);
+		apc->tx_qp[i]->mana_tx_debugfs = NULL;
 
-		napi = &apc->tx_qp[i].tx_cq.napi;
-		if (apc->tx_qp[i].txq.napi_initialized) {
+		napi = &apc->tx_qp[i]->tx_cq.napi;
+		if (apc->tx_qp[i]->txq.napi_initialized) {
 			napi_synchronize(napi);
 			napi_disable_locked(napi);
 			netif_napi_del_locked(napi);
-			apc->tx_qp[i].txq.napi_initialized = false;
+			apc->tx_qp[i]->txq.napi_initialized = false;
 		}
-		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
+		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
 
-		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
+		mana_deinit_cq(apc, &apc->tx_qp[i]->tx_cq);
 
-		mana_deinit_txq(apc, &apc->tx_qp[i].txq);
+		mana_deinit_txq(apc, &apc->tx_qp[i]->txq);
+
+		kvfree(apc->tx_qp[i]);
 	}
 
 	kfree(apc->tx_qp);
@@ -2307,7 +2312,7 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 
 static void mana_create_txq_debugfs(struct mana_port_context *apc, int idx)
 {
-	struct mana_tx_qp *tx_qp = &apc->tx_qp[idx];
+	struct mana_tx_qp *tx_qp = apc->tx_qp[idx];
 	char qnum[32];
 
 	sprintf(qnum, "TX-%d", idx);
@@ -2346,7 +2351,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 	int err;
 	int i;
 
-	apc->tx_qp = kzalloc_objs(struct mana_tx_qp, apc->num_queues);
+	apc->tx_qp = kzalloc_objs(struct mana_tx_qp *, apc->num_queues);
 	if (!apc->tx_qp)
 		return -ENOMEM;
 
@@ -2366,10 +2371,16 @@ static int mana_create_txq(struct mana_port_context *apc,
 	gc = gd->gdma_context;
 
 	for (i = 0; i < apc->num_queues; i++) {
-		apc->tx_qp[i].tx_object = INVALID_MANA_HANDLE;
+		apc->tx_qp[i] = kvzalloc_obj(*apc->tx_qp[i]);
+		if (!apc->tx_qp[i]) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		apc->tx_qp[i]->tx_object = INVALID_MANA_HANDLE;
 
 		/* Create SQ */
-		txq = &apc->tx_qp[i].txq;
+		txq = &apc->tx_qp[i]->txq;
 
 		u64_stats_init(&txq->stats.syncp);
 		txq->ndev = net;
@@ -2387,7 +2398,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 			goto out;
 
 		/* Create SQ's CQ */
-		cq = &apc->tx_qp[i].tx_cq;
+		cq = &apc->tx_qp[i]->tx_cq;
 		cq->type = MANA_CQ_TYPE_TX;
 
 		cq->txq = txq;
@@ -2416,7 +2427,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 
 		err = mana_create_wq_obj(apc, apc->port_handle, GDMA_SQ,
 					 &wq_spec, &cq_spec,
-					 &apc->tx_qp[i].tx_object);
+					 &apc->tx_qp[i]->tx_object);
 
 		if (err)
 			goto out;
@@ -3242,7 +3253,7 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	 */
 
 	for (i = 0; i < apc->num_queues; i++) {
-		txq = &apc->tx_qp[i].txq;
+		txq = &apc->tx_qp[i]->txq;
 		tsleep = 1000;
 		while (atomic_read(&txq->pending_sends) > 0 &&
 		       time_before(jiffies, timeout)) {
@@ -3261,7 +3272,7 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	}
 
 	for (i = 0; i < apc->num_queues; i++) {
-		txq = &apc->tx_qp[i].txq;
+		txq = &apc->tx_qp[i]->txq;
 		while ((skb = skb_dequeue(&txq->pending_skbs))) {
 			mana_unmap_skb(skb, apc);
 			dev_kfree_skb_any(skb);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index f2d220b371b5..f5901e4c9816 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -251,7 +251,7 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	}
 
 	for (q = 0; q < num_queues; q++) {
-		tx_stats = &apc->tx_qp[q].txq.stats;
+		tx_stats = &apc->tx_qp[q]->txq.stats;
 
 		do {
 			start = u64_stats_fetch_begin(&tx_stats->syncp);
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index a078af283bdd..60b4a4146ea2 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -505,7 +505,7 @@ struct mana_port_context {
 	bool tx_shortform_allowed;
 	u16 tx_vp_offset;
 
-	struct mana_tx_qp *tx_qp;
+	struct mana_tx_qp **tx_qp;
 
 	/* Indirection Table for RX & TX. The values are queue indexes */
 	u32 *indir_table;
-- 
2.43.0


