Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B802747F2B
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jul 2023 10:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjGEIQT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jul 2023 04:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjGEIQS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jul 2023 04:16:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3598E1709;
        Wed,  5 Jul 2023 01:16:17 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1099)
        id 6B27B20A1043; Wed,  5 Jul 2023 01:16:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B27B20A1043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688544976;
        bh=WbiYtCCkfhxy2EY5js2nXgs66lTqxblIFI1ejNxQRPc=;
        h=From:To:Cc:Subject:Date:From;
        b=scSfyhRTze3AHlBP9Vv0lBFdiZGT/u683sHmKUvnmvqpfkrSOrAsuFbTLSAJ90qyC
         BHwcyQavvZSqPT1fSBsXFR5DgKoz1arui0ECqrj69rN9LH7jGEZ3Ot/vuxdenE/3C1
         AhjBq2JrCi/duD+KPEATi5hKhnZ1UNpnkb/f0Kx8=
From:   Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     stable@vger.kernel.org, schakrabarti@microsoft.com,
        Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH V5 net] net: mana: Fix MANA VF unload when hardware is unresponsive
Date:   Wed,  5 Jul 2023 01:16:13 -0700
Message-Id: <1688544973-2507-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
hardware to complete any inflight packets and set the pending send count
to zero. But if the hardware has failed, mana_dealloc_queues()
could wait forever.

Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,
which is a somewhat arbitrary value that is more than long enough for
functional hardware to complete any sends.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
---
V4 -> V5:
* Added fixes tag
* Changed the usleep_range from static to incremental value.
* Initialized timeout in the begining.
---
Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a499e460594b..56b7074db1a2 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2345,9 +2345,13 @@ int mana_attach(struct net_device *ndev)
 static int mana_dealloc_queues(struct net_device *ndev)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
+	unsigned long timeout = jiffies + 120 * HZ;
 	struct gdma_dev *gd = apc->ac->gdma_dev;
 	struct mana_txq *txq;
+	struct sk_buff *skb;
+	struct mana_cq *cq;
 	int i, err;
+	u32 tsleep;
 
 	if (apc->port_is_up)
 		return -EINVAL;
@@ -2363,15 +2367,33 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	 * to false, but it doesn't matter since mana_start_xmit() drops any
 	 * new packets due to apc->port_is_up being false.
 	 *
-	 * Drain all the in-flight TX packets
+	 * Drain all the in-flight TX packets.
+	 * A timeout of 120 seconds for all the queues is used.
+	 * This will break the while loop when h/w is not responding.
+	 * This value of 120 has been decided here considering max
+	 * number of queues.
 	 */
+
 	for (i = 0; i < apc->num_queues; i++) {
 		txq = &apc->tx_qp[i].txq;
-
-		while (atomic_read(&txq->pending_sends) > 0)
-			usleep_range(1000, 2000);
+		tsleep = 1000;
+		while (atomic_read(&txq->pending_sends) > 0 &&
+		       time_before(jiffies, timeout)) {
+			usleep_range(tsleep, tsleep << 1);
+			tsleep <<= 1;
+		}
 	}
 
+	for (i = 0; i < apc->num_queues; i++) {
+		txq = &apc->tx_qp[i].txq;
+		cq = &apc->tx_qp[i].tx_cq;
+		while (atomic_read(&txq->pending_sends)) {
+			skb = skb_dequeue(&txq->pending_skbs);
+			mana_unmap_skb(skb, apc);
+			dev_consume_skb_any(skb);
+			atomic_sub(1, &txq->pending_sends);
+		}
+	}
 	/* We're 100% sure the queues can no longer be woken up, because
 	 * we're sure now mana_poll_tx_cq() can't be running.
 	 */
-- 
2.34.1

