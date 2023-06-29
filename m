Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7974302D
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jun 2023 00:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjF2WKA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 18:10:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41668 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjF2WJ4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 18:09:56 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 5149E208396A; Thu, 29 Jun 2023 15:09:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5149E208396A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1688076595;
        bh=BKDtaYT+zbLI1TSAymoJ7YKaz9ZHdNfBW0iqigA2SuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQloIh6EgT3FUTVcllOIP2gKT7M5f4+4HRbIFevacgN7I4uhqpwc39c3Sen7pmFKg
         rQUbY+b+gzQDnvOgsPoyhBKqBrTROXo+howV8WJOHt0pH5lVX1qZ/15GtDCFkhz2dD
         6HlL3tzecMbH8/hixVgOhVXrRxH7pQrDCTUF8UnE=
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
Cc:     linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
        stable@vger.kernel.org
Subject: [PATCH net v4 1/2] net: mana: Batch ringing RX queue doorbell on receiving packets
Date:   Thu, 29 Jun 2023 15:09:30 -0700
Message-Id: <1688076571-24938-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688076571-24938-1-git-send-email-longli@linuxonhyperv.com>
References: <1688076571-24938-1-git-send-email-longli@linuxonhyperv.com>
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

Cc: stable@vger.kernel.org
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

