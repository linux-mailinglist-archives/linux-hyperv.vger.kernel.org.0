Return-Path: <linux-hyperv+bounces-6584-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEB2B33D84
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 13:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC29E1A81B7E
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3682D94B2;
	Mon, 25 Aug 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NSgUljRS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08EB2D0623;
	Mon, 25 Aug 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119798; cv=none; b=ie2l2keK5g+H/kthzFka24JQYA9yF1Mxo/j4eEY5bIjwN8jS6Er0ynCYHnHX8ZVEnYGYBb5ZaAQK+J4PeJDt2WzKnWHk5226vcrtgLJjYcidX1+IfxflfyBdoG9gdGlyVQ24a+57UPMv1PN5f9DVkDu7A2AOngi3cRvgD72ukys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119798; c=relaxed/simple;
	bh=i7Bh1lmrcNhrpuE5kAEpZHyG48GyUCraJrr1KmwINdE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kpqme/JcS8IqIO88nfwGBOScucInKG9d92rHtFxE7FiDPT8j3RR4FbDqcMI1SpWJPWM18+4zQ/oc1oovxOejqyis1FtihptGPvgZ+GoNF4xIuSw7vURZvnYFxTl6G++etfrxrAWlYPkwfnnYf4CKrEyjuVHG595oKt1fVpWA1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NSgUljRS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 41746211828C; Mon, 25 Aug 2025 04:03:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41746211828C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756119796;
	bh=QN/7ZaTct3LU/anujYLQq8OzF8EQzpibQw8k4S15RNg=;
	h=From:To:Cc:Subject:Date:From;
	b=NSgUljRSt6JU7MeyF6jX3RTLdwdrpx12Fnt802jxi7LXi3Pwvh3ozejSAPvaYRwyC
	 nn5JIjm3EbeiMF9j1vn44jrnaseEf7lbxYFlZl6g/KJinmTlm3KfyIn7sphcFrUVah
	 G7N8CijyWKlszwcZo0Q5NAqnAcwOk4+DPKG/tTJM=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shradhagupta@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	stable@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH net] net: mana: Remove redundant netdev_lock_ops_to_full() calls
Date: Mon, 25 Aug 2025 04:03:14 -0700
Message-Id: <1756119794-20110-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

NET_SHAPER is always selected for MANA driver. When NET_SHAPER is enabled,
netdev_lock_ops_to_full() reduces effectively to only an assert for lock,
which is always held in the path when NET_SHAPER is enabled.

Remove the redundant netdev_lock_ops_to_full() call.

Fixes: d5c8f0e4e0cb ("net: mana: Fix potential deadlocks in mana napi ops")
Cc: stable@vger.kernel.org
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 550843e2164b..f0dbf4e82e0b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2100,10 +2100,8 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 		napi = &apc->tx_qp[i].tx_cq.napi;
 		if (apc->tx_qp[i].txq.napi_initialized) {
 			napi_synchronize(napi);
-			netdev_lock_ops_to_full(napi->dev);
 			napi_disable_locked(napi);
 			netif_napi_del_locked(napi);
-			netdev_unlock_full_to_ops(napi->dev);
 			apc->tx_qp[i].txq.napi_initialized = false;
 		}
 		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
@@ -2256,10 +2254,8 @@ static int mana_create_txq(struct mana_port_context *apc,
 		mana_create_txq_debugfs(apc, i);
 
 		set_bit(NAPI_STATE_NO_BUSY_POLL, &cq->napi.state);
-		netdev_lock_ops_to_full(net);
 		netif_napi_add_locked(net, &cq->napi, mana_poll);
 		napi_enable_locked(&cq->napi);
-		netdev_unlock_full_to_ops(net);
 		txq->napi_initialized = true;
 
 		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
@@ -2295,10 +2291,8 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	if (napi_initialized) {
 		napi_synchronize(napi);
 
-		netdev_lock_ops_to_full(napi->dev);
 		napi_disable_locked(napi);
 		netif_napi_del_locked(napi);
-		netdev_unlock_full_to_ops(napi->dev);
 	}
 	xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
@@ -2549,18 +2543,14 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	gc->cq_table[cq->gdma_id] = cq->gdma_cq;
 
-	netdev_lock_ops_to_full(ndev);
 	netif_napi_add_weight_locked(ndev, &cq->napi, mana_poll, 1);
-	netdev_unlock_full_to_ops(ndev);
 
 	WARN_ON(xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq_idx,
 				 cq->napi.napi_id));
 	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
 					   rxq->page_pool));
 
-	netdev_lock_ops_to_full(ndev);
 	napi_enable_locked(&cq->napi);
-	netdev_unlock_full_to_ops(ndev);
 
 	mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 out:
-- 
2.43.0


