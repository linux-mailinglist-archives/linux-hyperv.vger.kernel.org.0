Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3556737FD2
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jun 2023 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjFUK30 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jun 2023 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjFUK3L (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jun 2023 06:29:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C471C1737;
        Wed, 21 Jun 2023 03:29:04 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1099)
        id 266D621C2043; Wed, 21 Jun 2023 03:29:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 266D621C2043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687343344;
        bh=chZwILjB8n5vZjnofE7dyAXFYm12Ys8pfNtbWBPSFg0=;
        h=From:To:Cc:Subject:Date:From;
        b=VtCZ45Dj+681XgJ/rY2h8s7WG5WqyExIxJhfSehRcNJQ7Ixa/HwkMlDiba1CXkOge
         82oFWc8yJlqQZcOJ1PfnkUHxRGL5TRGAl/cHeJ0/3B0qg9PikYe0vebEuqqSrqf+wi
         yGPSkz6mg7CXO0Ma002vvPowWZhbjn4+MVCy7dPw=
From:   souradeep chakrabarti <schakrabarti@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH] net: mana: Fix MANA VF unload when host is unresponsive
Date:   Wed, 21 Jun 2023 03:29:01 -0700
Message-Id: <1687343341-10898-1-git-send-email-schakrabarti@linux.microsoft.com>
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

From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

This patch addresses  the VF unload issue, where mana_dealloc_queues()
gets stuck in infinite while loop, because of host unresponsiveness.
It adds a timeout in the while loop, to fix it.

Also this patch adds a new attribute in mana_context, which gets set when
mana_hwc_send_request() hits a timeout because of host unresponsiveness.
This flag then helps to avoid the timeouts in successive calls.

Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   |  4 +++-
 .../net/ethernet/microsoft/mana/hw_channel.c  | 12 ++++++++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 21 +++++++++++++++++--
 include/net/mana/mana.h                       |  2 ++
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 8f3f78b68592..5cc43ae78334 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -946,10 +946,12 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
 	struct gdma_context *gc = gd->gdma_context;
 	struct gdma_general_resp resp = {};
 	struct gdma_general_req req = {};
+	struct mana_context *ac;
 	int err;
 
 	if (gd->pdid == INVALID_PDID)
 		return -EINVAL;
+	ac = (struct mana_context *)gd->driver_data;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DEREGISTER_DEVICE, sizeof(req),
 			     sizeof(resp));
@@ -957,7 +959,7 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
 	req.hdr.dev_id = gd->dev_id;
 
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err || resp.hdr.status) {
+	if ((err || resp.hdr.status) && !ac->vf_unload_timeout) {
 		dev_err(gc->dev, "Failed to deregister device: %d, 0x%x\n",
 			err, resp.hdr.status);
 		if (!err)
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 9d1507eba5b9..557b890ad0ae 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /* Copyright (c) 2021, Microsoft Corporation. */
 
+#include "asm-generic/errno.h"
 #include <net/mana/gdma.h>
 #include <net/mana/hw_channel.h>
+#include <net/mana/mana.h>
 
 static int mana_hwc_get_msg_index(struct hw_channel_context *hwc, u16 *msg_id)
 {
@@ -786,12 +788,19 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	struct hwc_wq *txq = hwc->txq;
 	struct gdma_req_hdr *req_msg;
 	struct hwc_caller_ctx *ctx;
+	struct mana_context *ac;
 	u32 dest_vrcq = 0;
 	u32 dest_vrq = 0;
 	u16 msg_id;
 	int err;
 
 	mana_hwc_get_msg_index(hwc, &msg_id);
+	ac = (struct mana_context *)hwc->gdma_dev->driver_data;
+	if (ac->vf_unload_timeout) {
+		dev_err(hwc->dev, "HWC: vport is already unloaded.\n");
+		err = -ETIMEDOUT;
+		goto out;
+	}
 
 	tx_wr = &txq->msg_buf->reqs[msg_id];
 
@@ -825,9 +834,10 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 		goto out;
 	}
 
-	if (!wait_for_completion_timeout(&ctx->comp_event, 30 * HZ)) {
+	if (!wait_for_completion_timeout(&ctx->comp_event, 5 * HZ)) {
 		dev_err(hwc->dev, "HWC: Request timed out!\n");
 		err = -ETIMEDOUT;
+		ac->vf_unload_timeout = true;
 		goto out;
 	}
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d907727c7b7a..24f5508d2979 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2330,7 +2330,10 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	struct mana_port_context *apc = netdev_priv(ndev);
 	struct gdma_dev *gd = apc->ac->gdma_dev;
 	struct mana_txq *txq;
+	struct sk_buff *skb;
+	struct mana_cq *cq;
 	int i, err;
+	unsigned long timeout;
 
 	if (apc->port_is_up)
 		return -EINVAL;
@@ -2348,13 +2351,26 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	 *
 	 * Drain all the in-flight TX packets
 	 */
+
+	timeout = jiffies + 120 * HZ;
 	for (i = 0; i < apc->num_queues; i++) {
 		txq = &apc->tx_qp[i].txq;
-
-		while (atomic_read(&txq->pending_sends) > 0)
+		while (atomic_read(&txq->pending_sends) > 0 &&
+		       time_before(jiffies, timeout)) {
 			usleep_range(1000, 2000);
+		}
 	}
 
+	for (i = 0; i < apc->num_queues; i++) {
+		txq = &apc->tx_qp[i].txq;
+		cq = &apc->tx_qp[i].tx_cq;
+		while (atomic_read(&txq->pending_sends)) {
+			skb = skb_dequeue(&txq->pending_skbs);
+			mana_unmap_skb(skb, apc);
+			napi_consume_skb(skb, cq->budget);
+			atomic_sub(1, &txq->pending_sends);
+		}
+	}
 	/* We're 100% sure the queues can no longer be woken up, because
 	 * we're sure now mana_poll_tx_cq() can't be running.
 	 */
@@ -2605,6 +2621,7 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 		}
 	}
 
+	ac->vf_unload_timeout = false;
 	err = add_adev(gd);
 out:
 	if (err)
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 9eef19972845..34f5d8e06ede 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -361,6 +361,8 @@ struct mana_context {
 	struct mana_eq *eqs;
 
 	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
+
+	bool vf_unload_timeout;
 };
 
 struct mana_port_context {
-- 
2.34.1

