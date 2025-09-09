Return-Path: <linux-hyperv+bounces-6795-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E1BB4A0F3
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 06:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BBD1B253B0
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 04:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CD72EBBAD;
	Tue,  9 Sep 2025 04:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I/ooZ1Dr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319502EB87F;
	Tue,  9 Sep 2025 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393835; cv=none; b=KSmz82bw+Wo3rqypEaePwMyq8BA2RY7QEFXTaKGSlh/nnLf05eOvnMbzaL+nZ8pOqnsOlAEL5KG85qGbRtdjkv+kRV+1xil01D2Vj8HtfVxBdzBTeZ3ql0JvlUDxzbVU2R5OjT5cM5qghSStCfxuctv8q4nhmJl2IBIdn3l1ZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393835; c=relaxed/simple;
	bh=pAklHncUUrC3+JMDSaPQjQtXplyaFbYEKFtpkASOMEQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ea1CB5Zyvpa9mofOp1TE/Wena7B0DQL3WNY2m8Xm2p6nf6UpmfF3Y0tdczaZLJgI8CviMvGs0HAR9f+rppmNMM705ZFPdStu978J/hpaC33HRk1T1pNZNsJuu98HFUUMMyptjJfydD5W2t5BWWmdJMzJd3N/fvGIbc1oea+EVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I/ooZ1Dr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id BF17F21199F8; Mon,  8 Sep 2025 21:57:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF17F21199F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757393833;
	bh=1h7EaJRM62Y3gt1V8myh8hVCzoRX/OXNgyS0Ir6iv34=;
	h=From:To:Cc:Subject:Date:From;
	b=I/ooZ1DrUh4XrkvMTlz3vwJ0HE6cV9UopLQIloaoUr51+P7dQh9WfA/q7CTil7nZ/
	 CXuqgd4HODAZk4iQvUdWj/27FgzIpXLxXyYwcsCQbPwno48oO0EOGtr2NTmtpkcVGv
	 MBo9R8sjnxxP6qCs9W+yml5Rxxr6VR7/HmOYY2lE=
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
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v3] net: mana: Remove redundant netdev_lock_ops_to_full() calls
Date: Mon,  8 Sep 2025 21:57:10 -0700
Message-Id: <1757393830-20837-1-git-send-email-ssengar@linux.microsoft.com>
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

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V3] - remove stable CC for real
[v2] - removed Fixes tag and stable CC

 drivers/net/ethernet/microsoft/mana/mana_en.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index f4fc86f..0142fd9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2145,10 +2145,8 @@ static void mana_destroy_txq(struct mana_port_context *apc)
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
@@ -2301,10 +2299,8 @@ static int mana_create_txq(struct mana_port_context *apc,
 		mana_create_txq_debugfs(apc, i);
 
 		set_bit(NAPI_STATE_NO_BUSY_POLL, &cq->napi.state);
-		netdev_lock_ops_to_full(net);
 		netif_napi_add_locked(net, &cq->napi, mana_poll);
 		napi_enable_locked(&cq->napi);
-		netdev_unlock_full_to_ops(net);
 		txq->napi_initialized = true;
 
 		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
@@ -2340,10 +2336,8 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	if (napi_initialized) {
 		napi_synchronize(napi);
 
-		netdev_lock_ops_to_full(napi->dev);
 		napi_disable_locked(napi);
 		netif_napi_del_locked(napi);
-		netdev_unlock_full_to_ops(napi->dev);
 	}
 	xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
@@ -2604,18 +2598,14 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
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
1.8.3.1


