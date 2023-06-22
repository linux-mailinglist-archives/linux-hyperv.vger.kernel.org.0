Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDFE73A5FE
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jun 2023 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjFVQWp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jun 2023 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjFVQWn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jun 2023 12:22:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F2141FE8;
        Thu, 22 Jun 2023 09:22:42 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 2637D21C20A2; Thu, 22 Jun 2023 09:22:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2637D21C20A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1687450961;
        bh=bpRMX3RMcGhusT5aTzmC87ILJ8BKTaQbhSuw8yFpVNw=;
        h=From:To:Cc:Subject:Date:From;
        b=Gg655xF/W9QuTA6iSWGzMfa5Y88+NWxxT7CxBWMTLltOohhrLituO8sn8cLto9Dk6
         30D4NeQsfwrBTpt87SSf2MbgvhMp2ohNQKMf7pl/qFiz5KazqQ1UwR77ZMXVIxhYtz
         PHtjkgh1X3mUVQ9UYhvIlrIOuV40neEgq7+iMQhI=
From:   longli@linuxonhyperv.com
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>, stable@vger.kernel.org
Subject: [PATCH v2] net: mana: Batch ringing RX queue doorbell on receiving packets
Date:   Thu, 22 Jun 2023 09:22:36 -0700
Message-Id: <1687450956-6407-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

It's inefficient to ring the doorbell page every time a WQE is posted to
the received queue.

Move the code for ringing doorbell page to where after we have posted all
WQEs to the receive queue during a callback from napi_poll().

Tests showed no regression in network latency benchmarks.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Long Li <longli@microsoft.com>
---
Change log:
v2:
Check for comp_read > 0 as it might be negative on completion error.
Set rq.wqe_cnt to 0 according to BNIC spec.

 drivers/net/ethernet/microsoft/mana/gdma_main.c |  5 ++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 10 ++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 8f3f78b68592..ef11d09a3655 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -300,8 +300,11 @@ static void mana_gd_ring_doorbell(struct gdma_context *gc, u32 db_index,
 
 void mana_gd_wq_ring_doorbell(struct gdma_context *gc, struct gdma_queue *queue)
 {
+	/* BNIC Spec specifies that client should set 0 for rq.wqe_cnt
+	 * This value is not used in sq
+	 */
 	mana_gd_ring_doorbell(gc, queue->gdma_dev->doorbell, queue->type,
-			      queue->id, queue->head * GDMA_WQE_BU_SIZE, 1);
+			      queue->id, queue->head * GDMA_WQE_BU_SIZE, 0);
 }
 
 void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index cd4d5ceb9f2d..1d8abe63fcb8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1383,8 +1383,8 @@ static void mana_post_pkt_rxq(struct mana_rxq *rxq)
 
 	recv_buf_oob = &rxq->rx_oobs[curr_index];
 
-	err = mana_gd_post_and_ring(rxq->gdma_rq, &recv_buf_oob->wqe_req,
-				    &recv_buf_oob->wqe_inf);
+	err = mana_gd_post_work_request(rxq->gdma_rq, &recv_buf_oob->wqe_req,
+					&recv_buf_oob->wqe_inf);
 	if (WARN_ON_ONCE(err))
 		return;
 
@@ -1654,6 +1654,12 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
 		mana_process_rx_cqe(rxq, cq, &comp[i]);
 	}
 
+	if (comp_read > 0) {
+		struct gdma_context *gc = rxq->gdma_rq->gdma_dev->gdma_context;
+
+		mana_gd_wq_ring_doorbell(gc, rxq->gdma_rq);
+	}
+
 	if (rxq->xdp_flush)
 		xdp_do_flush();
 }
-- 
2.34.1

