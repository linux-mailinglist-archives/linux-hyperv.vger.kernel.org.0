Return-Path: <linux-hyperv+bounces-5849-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD69AD4EBC
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 10:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1C21778EF
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195E23F43C;
	Wed, 11 Jun 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f5kdgpoE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D62D543C;
	Wed, 11 Jun 2025 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631597; cv=none; b=KGD1mwea/5Fv4VQQ+I8CBw6f2wk3Lx663E7kaOzes14HVEZCaJ9yxL3dutdUyV2QCnQB8zpgmNQikMprmswkqGlYmDXBxsXvGVV9LGOHR/EdEPp90qR5r9rI+sekVIluGmqsgVoX2zDj0RiT2r2VbXfk8DG3ApPHgwZJN9wNbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631597; c=relaxed/simple;
	bh=g2DXMg5rmDnhugpiHMmf1QfeOmclMqtPIujzWBitXX8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=LayuUdDlQ8pM/s+7cU0w1q7GhFnkBalTkDhwlq4vaKCsVkHdqqqw/U7MoZBfaMxcTfjTgeHNrvVeUJprPUAvDwWKumiMNK6fHkxTOIwhANwG2+svPgbfjh+MmEgN5HBu9cCMX915ct++WbzjVyfv7mBgfpaVF7saAXue4eJXEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f5kdgpoE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 832F22115189; Wed, 11 Jun 2025 01:46:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 832F22115189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749631595;
	bh=r+GqLCuBE+ClBIUMKxQZzaAOal17+iAyuCgNMG8+Nm0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f5kdgpoEK3sZJT0i3w+IW0E99j79V2CPaRqZXhQndQH38n1bdsQrTfXaB/pHbFzvP
	 he0ZO8kEn1vSm0LaMm+Cld4Qw1mvbgu0HQ2G1kTiAgo+BiEcJzO8qk9c5IW29JRbXa
	 78/rwrfx36XOg2ZY+d+Eq10kI5mQQXXAgD14F5OA=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kotaranov@microsoft.com,
	longli@microsoft.com,
	horms@kernel.org,
	shirazsaleem@microsoft.com,
	leon@kernel.org,
	ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	schakrabarti@linux.microsoft.com,
	rosenp@gmail.com,
	sdf@fomichev.me,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 1/4] net: mana: Fix potential deadlocks in mana napi ops
Date: Wed, 11 Jun 2025 01:46:13 -0700
Message-Id: <1749631576-2517-2-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
References: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

When net_shaper_ops are enabled for MANA, netdev_ops_lock
becomes active.

The netvsc sets up MANA VF via following call chain:

netvsc_vf_setup()
        dev_change_flags()
		...
         __dev_open() OR __dev_close()

dev_change_flags() holds the netdev mutex via netdev_lock_ops.

During this process, mana_create_txq() and mana_create_rxq()
invoke netif_napi_add_tx(), netif_napi_add_weight(), and napi_enable(),
all of which attempt to acquire the same lock,
leading to a potential deadlock.

Similarly, mana_destroy_txq() and mana_destroy_rxq() call
netif_napi_disable() and netif_napi_del(), which also contend
for the same lock.

Switch to the _locked variants of these APIs to avoid deadlocks
when the netdev_ops_lock is held.

Fixes: d4c22ec680c8 ("net: hold netdev instance lock during ndo_open/ndo_stop")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 39 ++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ccd2885c939e..3c879d8a39e3 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1911,8 +1911,13 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 		napi = &apc->tx_qp[i].tx_cq.napi;
 		if (apc->tx_qp[i].txq.napi_initialized) {
 			napi_synchronize(napi);
-			napi_disable(napi);
-			netif_napi_del(napi);
+			if (netdev_need_ops_lock(napi->dev)) {
+				napi_disable_locked(napi);
+				netif_napi_del_locked(napi);
+			} else {
+				napi_disable(napi);
+				netif_napi_del(napi);
+			}
 			apc->tx_qp[i].txq.napi_initialized = false;
 		}
 		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
@@ -2064,8 +2069,14 @@ static int mana_create_txq(struct mana_port_context *apc,
 
 		mana_create_txq_debugfs(apc, i);
 
-		netif_napi_add_tx(net, &cq->napi, mana_poll);
-		napi_enable(&cq->napi);
+		if (netdev_need_ops_lock(net)) {
+			set_bit(NAPI_STATE_NO_BUSY_POLL, &cq->napi.state);
+			netif_napi_add_locked(net, &cq->napi, mana_poll);
+			napi_enable_locked(&cq->napi);
+		} else {
+			netif_napi_add_tx(net, &cq->napi, mana_poll);
+			napi_enable(&cq->napi);
+		}
 		txq->napi_initialized = true;
 
 		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
@@ -2101,9 +2112,13 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	if (napi_initialized) {
 		napi_synchronize(napi);
 
-		napi_disable(napi);
-
-		netif_napi_del(napi);
+		if (netdev_need_ops_lock(napi->dev)) {
+			napi_disable_locked(napi);
+			netif_napi_del_locked(napi);
+		} else {
+			napi_disable(napi);
+			netif_napi_del(napi);
+		}
 	}
 	xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
@@ -2354,14 +2369,20 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	gc->cq_table[cq->gdma_id] = cq->gdma_cq;
 
-	netif_napi_add_weight(ndev, &cq->napi, mana_poll, 1);
+	if (netdev_need_ops_lock(ndev))
+		netif_napi_add_weight_locked(ndev, &cq->napi, mana_poll, 1);
+	else
+		netif_napi_add_weight(ndev, &cq->napi, mana_poll, 1);
 
 	WARN_ON(xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq_idx,
 				 cq->napi.napi_id));
 	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
 					   rxq->page_pool));
 
-	napi_enable(&cq->napi);
+	if (netdev_need_ops_lock(ndev))
+		napi_enable_locked(&cq->napi);
+	else
+		napi_enable(&cq->napi);
 
 	mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 out:
-- 
2.34.1


