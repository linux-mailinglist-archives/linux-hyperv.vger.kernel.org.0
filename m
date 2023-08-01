Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3676B4BB
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Aug 2023 14:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjHAM36 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Aug 2023 08:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjHAM35 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Aug 2023 08:29:57 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 399961FC6;
        Tue,  1 Aug 2023 05:29:56 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1099)
        id 87B5A238AF50; Tue,  1 Aug 2023 05:29:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87B5A238AF50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690892995;
        bh=Le5IWUlV+SOiU8nvbAjGXFDnfuBjbT8nhrykMj0k14k=;
        h=From:To:Cc:Subject:Date:From;
        b=QbxCkPlXOL/LLmKwjN3yXH6ja2Lg3P8hNezx5avxJmSJyLmBcOP9KapwTglQPrWgI
         rRV1trxCqelfaklwj2dNcuOWZSeI38r8SfjIGl+2JI/8e3XBUHCvdcdwhMbb5c0Oaf
         TOxfJApD/w9ureNlZ3mTBBTnR8k+zD5B2SV+Tp7M=
From:   Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     schakrabarti@microsoft.com,
        Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
        stable@vger.kernel.org
Subject: [PATCH V7 net] net: mana: Fix MANA VF unload when hardware is
Date:   Tue,  1 Aug 2023 05:29:13 -0700
Message-Id: <1690892953-25201-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
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

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")

Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
V6 -> V7:
* Optimized the while loop for freeing skb.

V5 -> V6:
* Added pcie_flr to reset the pci after timeout.
* Fixed the position of changelog.
* Removed unused variable like cq.

V4 -> V5:
* Added fixes tag
* Changed the usleep_range from static to incremental value.
* Initialized timeout in the begining.

V3 -> V4:
* Removed the unnecessary braces from mana_dealloc_queues().

V2 -> V3:
* Removed the unnecessary braces from mana_dealloc_queues().

V1 -> V2:
* Added net branch
* Removed the typecasting to (struct mana_context*) of void pointer
* Repositioned timeout variable in mana_dealloc_queues()
* Repositioned vf_unload_timeout in mana_context struct, to utilise the
 6 bytes hole
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a499e460594b..3c5552a176d0 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -8,6 +8,7 @@
 #include <linux/ethtool.h>
 #include <linux/filter.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
 
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
@@ -2345,9 +2346,12 @@ int mana_attach(struct net_device *ndev)
 static int mana_dealloc_queues(struct net_device *ndev)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
+	unsigned long timeout = jiffies + 120 * HZ;
 	struct gdma_dev *gd = apc->ac->gdma_dev;
 	struct mana_txq *txq;
+	struct sk_buff *skb;
 	int i, err;
+	u32 tsleep;
 
 	if (apc->port_is_up)
 		return -EINVAL;
@@ -2363,15 +2367,40 @@ static int mana_dealloc_queues(struct net_device *ndev)
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
+			usleep_range(tsleep, tsleep + 1000);
+			tsleep <<= 1;
+		}
+		if (atomic_read(&txq->pending_sends)) {
+			err = pcie_flr(to_pci_dev(gd->gdma_context->dev));
+			if (err) {
+				netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
+					   err, atomic_read(&txq->pending_sends),
+					   txq->gdma_txq_id);
+			}
+			break;
+		}
 	}
 
+	for (i = 0; i < apc->num_queues; i++) {
+		txq = &apc->tx_qp[i].txq;
+		while (skb = skb_dequeue(&txq->pending_skbs)) {
+			mana_unmap_skb(skb, apc);
+			dev_consume_skb_any(skb);
+		}
+		atomic_set(&txq->pending_sends, 0);
+	}
 	/* We're 100% sure the queues can no longer be woken up, because
 	 * we're sure now mana_poll_tx_cq() can't be running.
 	 */
-- 
2.34.1

