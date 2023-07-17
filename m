Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F13756D63
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jul 2023 21:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGQTf4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jul 2023 15:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjGQTfy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jul 2023 15:35:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC45E9D;
        Mon, 17 Jul 2023 12:35:53 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 44AF121C7A00; Mon, 17 Jul 2023 12:35:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44AF121C7A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1689622553;
        bh=6tfn9MlpjDiql9rVzLqowicC40WOAVLxwr5d3454KNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ez625pjLMLsth5TvE2UwuLvAepr2qIf6AyBbCE6o+Cm5/dDveTcKFcvNNHOIwSCNq
         9aNl62Vk5AtHPirJUKgZZcmg1GLgq5uRxy7eyZoLMu0h9rQAD59F3mXZ8E8avnZ6MA
         VEUZLIPM2Duep6e5DsNwUwNDU7PoWMoOvccBsIC4=
From:   longli@linuxonhyperv.com
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Shachar Raindel <shacharr@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: [PATCH net-next v5 1/2] net: mana: Batch ringing RX queue doorbell on receiving packets
Date:   Mon, 17 Jul 2023 12:35:38 -0700
Message-Id: <1689622539-5334-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1689622539-5334-1-git-send-email-longli@linuxonhyperv.com>
References: <1689622539-5334-1-git-send-email-longli@linuxonhyperv.com>
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

It's inefficient to ring the doorbell page every time a WQE is posted to
the received queue. Excessive MMIO writes result in CPU spending more
time waiting on LOCK instructions (atomic operations), resulting in
poor scaling performance.

Move the code for ringing doorbell page to where after we have posted all
WQEs to the receive queue during a callback from napi_poll().

With this change, tests showed an improvement from 120G/s to 160G/s on a
200G physical link, with 16 or 32 hardware queues.

Tests showed no regression in network latency benchmarks on single
connection.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
Change log:
v2:
Check for comp_read > 0 as it might be negative on completion error.
Set rq.wqe_cnt to 0 according to BNIC spec.

v3:
Add details in the commit on the reason of performance increase and test numbers.
Add details in the commit on why rq.wqe_cnt should be set to 0 according to hardware spec.
Add "Reviewed-by" from Haiyang and Dexuan.

v4:
Split the original patch into two: one for batching doorbell, one for setting the correct wqe count

v5:
drop Cc: stable and use net-next

 drivers/net/ethernet/microsoft/mana/mana_en.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

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

