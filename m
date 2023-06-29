Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E4743029
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jun 2023 00:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjF2WKA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 18:10:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41696 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjF2WJ5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 18:09:57 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 20A7220AECAD; Thu, 29 Jun 2023 15:09:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20A7220AECAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1688076596;
        bh=sNVCTU5gFBqe2BQjTeFzfJALosLnCbsvG4CoTL1NyEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDaBTtSqHtUX0HV8fAgs5RDMLHjO7gn4fSzK5XPajhYEnBJnZnjChdh81UVoWPqro
         DRLG+Vx8mrN3oaM/KcdZMq2puu07wo5Eajn+HxTooK1XuAfynP0YfMvXqQRJ9+2xWv
         +w/ReMKXpbzZcy6YvSZRQPqWoVvNVBszicCyAvA8=
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
Subject: [PATCH net v4 2/2] net: mana: Use the correct WQE count for ringing RQ doorbell
Date:   Thu, 29 Jun 2023 15:09:31 -0700
Message-Id: <1688076571-24938-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688076571-24938-1-git-send-email-longli@linuxonhyperv.com>
References: <1688076571-24938-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

The hardware specification specifies that WQE_COUNT should set to 0 for
the Receive Queue. Although currently the hardware doesn't enforce the
check, in the future releases it may check on this value.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
Change log:
v4:
Split the original patch into two: one for batching doorbell, one for setting the correct wqe count

 drivers/net/ethernet/microsoft/mana/gdma_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 8f3f78b68592..3765d3389a9a 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -300,8 +300,11 @@ static void mana_gd_ring_doorbell(struct gdma_context *gc, u32 db_index,
 
 void mana_gd_wq_ring_doorbell(struct gdma_context *gc, struct gdma_queue *queue)
 {
+	/* Hardware Spec specifies that software client should set 0 for
+	 * wqe_cnt for Receive Queues. This value is not used in Send Queues.
+	 */
 	mana_gd_ring_doorbell(gc, queue->gdma_dev->doorbell, queue->type,
-			      queue->id, queue->head * GDMA_WQE_BU_SIZE, 1);
+			      queue->id, queue->head * GDMA_WQE_BU_SIZE, 0);
 }
 
 void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
-- 
2.34.1

