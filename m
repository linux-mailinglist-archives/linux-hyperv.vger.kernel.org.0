Return-Path: <linux-hyperv+bounces-2821-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DAD95C97E
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 11:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43961F24DE6
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A1161313;
	Fri, 23 Aug 2024 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GT5QENx8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9453A15CD78;
	Fri, 23 Aug 2024 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406281; cv=none; b=MbELyy/KAzT/QtpJtKvUhmbcGHJXlRh8f2O0RVUxAlzcQ2rRUecSDWTBASVadX9wD13XyYdS0shF5qqOXsaznJ/Fb84mvQZDAO9A9uz1GW3biRXvzzyieDXKFD9o8bnjmZHm25ylCtA31vNq3wZ1dOaB7qYu7IyIfd7CqwgnY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406281; c=relaxed/simple;
	bh=72JCPyisVpo5s1wZI1A8vxFMtjQIauLjeFAGQ3ihPn4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JpUBXfTgKQJRwpVd3bGBlxSKvVE0Aw69y1pHDHUO+pSFHSEs1gr0nqDDbs82jOnYVMAiDh2aHGC3oGRT3JHoTp6yuioorBhgucNctvBXo9clAZsDjy7VXCgto0d352v3IdznKtRzBEKj+nzqUp2niNR0RGcfNA6l4wkEWdNhT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GT5QENx8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 1E6C020B7165; Fri, 23 Aug 2024 02:44:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E6C020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724406279;
	bh=oFZxcgjEt2RtouAMlSr6QhcGpux36C3Is+QtFB1p5pI=;
	h=From:To:Cc:Subject:Date:From;
	b=GT5QENx857qaOCHsCluER2skIQMAj2h9ZZx0QF3ACKtDBd7Th5YKoFhgXNeKTLNfR
	 dRlZL6jv4p6dVwyn2R/v9VM9g2qHXsoSFr6Wu0PkhwezpcqIsTHsEed66BFL/xrvf1
	 WqR0ILZ80RD3enceO7YTfjEYr9/gQdumNBjOdXJ4=
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
Subject: [PATCH V2 net] net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup
Date: Fri, 23 Aug 2024 02:44:29 -0700
Message-Id: <1724406269-10868-1-git-send-email-schakrabarti@linux.microsoft.com>
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
V2 -> V1:
Addressed the comment on cleaning up napi for the queues,
where queue creation was successful.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 39f56973746d..7448085fd49e 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1872,10 +1872,11 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 
 	for (i = 0; i < apc->num_queues; i++) {
 		napi = &apc->tx_qp[i].tx_cq.napi;
-		napi_synchronize(napi);
-		napi_disable(napi);
-		netif_napi_del(napi);
-
+		if (napi->dev == apc->ndev) {
+			napi_synchronize(napi);
+			napi_disable(napi);
+			netif_napi_del(napi);
+		}
 		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
 
 		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
@@ -2023,14 +2024,17 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 
 	napi = &rxq->rx_cq.napi;
 
-	if (validate_state)
-		napi_synchronize(napi);
+	if (napi->dev == apc->ndev) {
 
-	napi_disable(napi);
+		if (validate_state)
+			napi_synchronize(napi);
 
-	xdp_rxq_info_unreg(&rxq->xdp_rxq);
+		napi_disable(napi);
 
-	netif_napi_del(napi);
+		netif_napi_del(napi);
+	}
+
+	xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
 	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
 
-- 
2.34.1


