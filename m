Return-Path: <linux-hyperv+bounces-2783-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB1958445
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2024 12:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C917C1C248CC
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2024 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C1918EFCF;
	Tue, 20 Aug 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iNv4HiLY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D36618E77F;
	Tue, 20 Aug 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149366; cv=none; b=umWPXrvlPXUT1nQ53k6qGYApNONTTjNu0CvBvtmcXq2SmeT+qdz9xslLmf1hWVMR96oAnau8ZJRkGQKnlBvM9WpEE1ecdDI4oiddKce8A7nZyF/CkCgoOL0XGYzyGM2VmDuDJIxLsL83ZCcl9ALQRoKwFwCS6e0fmU62oJTFtQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149366; c=relaxed/simple;
	bh=tye0nsjvodtrRdFBK/H75v/lap7Bu4w8IUgFMn2C67o=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fJBcIx6rL4Ju5WRtadPfVJy2ZMUVUXilw0E7viO5VL52EVRMg0Qya8CRkDj2DPtexcCiXN5K/Ujjw0OxIXFDJ3QQTukPBeEoRPaYBfaF7Zec7FufAsb0Ccy30hnHsHhMLjkvZcOekQaBdN2+GKoKMfPGNrMOHv2P7R2tO9inWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iNv4HiLY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 8A7D020B7165; Tue, 20 Aug 2024 03:22:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A7D020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724149364;
	bh=00YxeYmZFXrOoRNBlddh1hQqsuv5B3hmZm5vzuk24cc=;
	h=From:To:Cc:Subject:Date:From;
	b=iNv4HiLYyhhMFPvnI3ROkHtfDR7Sj6bLCKDW08k1rNbI56tlCBsyl0qoQrkJl7hpo
	 EkVyoubMsPq4dyHZ08sbEB7m0FUduD7eVdtMGA33NnHRvwmm16EGUlt0zAJUS4ubtF
	 8EiQY3HiH69pyJnBJZpYqRKXoiZhE7QbmGtLjCzg=
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	yury.norov@gmail.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH net] net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup
Date: Tue, 20 Aug 2024 03:22:27 -0700
Message-Id: <1724149347-14430-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Currently napi_disable() gets called during rxq and txq cleanup,
even before napi is enabled and hrtimer is initialized. It causes
kernel panic.

? page_fault_oops+0x136/0x2b0
  ? page_counter_cancel+0x2e/0x80
  ? do_user_addr_fault+0x2f2/0x640
  ? refill_obj_stock+0xc4/0x110
  ? exc_page_fault+0x71/0x160
  ? asm_exc_page_fault+0x27/0x30
  ? __mmdrop+0x10/0x180
  ? __mmdrop+0xec/0x180
  ? hrtimer_active+0xd/0x50
  hrtimer_try_to_cancel+0x2c/0xf0
  hrtimer_cancel+0x15/0x30
  napi_disable+0x65/0x90
  mana_destroy_rxq+0x4c/0x2f0
  mana_create_rxq.isra.0+0x56c/0x6d0
  ? mana_uncfg_vport+0x50/0x50
  mana_alloc_queues+0x21b/0x320
  ? skb_dequeue+0x5f/0x80

Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")

Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 41 +++++++++++++------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 39f56973746d..882b05e087b9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1862,7 +1862,7 @@ static void mana_deinit_txq(struct mana_port_context *apc, struct mana_txq *txq)
 	mana_gd_destroy_queue(gd->gdma_context, txq->gdma_sq);
 }
 
-static void mana_destroy_txq(struct mana_port_context *apc)
+static void mana_cleanup_napi_txq(struct mana_port_context *apc)
 {
 	struct napi_struct *napi;
 	int i;
@@ -1875,7 +1875,17 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 		napi_synchronize(napi);
 		napi_disable(napi);
 		netif_napi_del(napi);
+	}
+}
+
+static void mana_destroy_txq(struct mana_port_context *apc)
+{
+	int i;
+
+	if (!apc->tx_qp)
+		return;
 
+	for (i = 0; i < apc->num_queues; i++) {
 		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
 
 		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
@@ -2007,6 +2017,21 @@ static int mana_create_txq(struct mana_port_context *apc,
 	return err;
 }
 
+static void mana_cleanup_napi_rxq(struct mana_port_context *apc,
+				  struct mana_rxq *rxq, bool validate_state)
+{
+	struct napi_struct *napi;
+
+	if (!rxq)
+		return;
+
+	napi = &rxq->rx_cq.napi;
+	if (validate_state)
+		napi_synchronize(napi);
+	napi_disable(napi);
+	netif_napi_del(napi);
+}
+
 static void mana_destroy_rxq(struct mana_port_context *apc,
 			     struct mana_rxq *rxq, bool validate_state)
 
@@ -2014,24 +2039,14 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
 	struct mana_recv_buf_oob *rx_oob;
 	struct device *dev = gc->dev;
-	struct napi_struct *napi;
 	struct page *page;
 	int i;
 
 	if (!rxq)
 		return;
 
-	napi = &rxq->rx_cq.napi;
-
-	if (validate_state)
-		napi_synchronize(napi);
-
-	napi_disable(napi);
-
 	xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
-	netif_napi_del(napi);
-
 	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
 
 	mana_deinit_cq(apc, &rxq->rx_cq);
@@ -2336,11 +2351,11 @@ static void mana_destroy_vport(struct mana_port_context *apc)
 		rxq = apc->rxqs[rxq_idx];
 		if (!rxq)
 			continue;
-
+		mana_cleanup_napi_rxq(apc, rxq, true);
 		mana_destroy_rxq(apc, rxq, true);
 		apc->rxqs[rxq_idx] = NULL;
 	}
-
+	mana_cleanup_napi_txq(apc);
 	mana_destroy_txq(apc);
 	mana_uncfg_vport(apc);
 
-- 
2.34.1


