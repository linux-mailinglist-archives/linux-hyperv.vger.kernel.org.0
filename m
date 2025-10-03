Return-Path: <linux-hyperv+bounces-7068-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5ACBB75D6
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Oct 2025 17:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26FA487651
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Oct 2025 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C813AD05;
	Fri,  3 Oct 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qlYiUHkF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44AB1C6B4;
	Fri,  3 Oct 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506446; cv=none; b=W87+3zHm9TEdmq2uXo4+GudTHGp+cswJZQInLEVMYCGrclfUOcuxwjzFyE3WAHsOnY1QynR3FQRYQCPlkqq+KmBSnNBK1abGj82rubuerEkpy6MsxMA1v0lgYaT8QLiU3zBTbOFf9eqPhVXxpp0kqzJBBQ/WlotsqXtw6KXBqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506446; c=relaxed/simple;
	bh=QeOdkk/HPd8F+lWj3osQlyj0903mD8z9jFN3xWQIL0E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AHWrUFac4qmjwypit5su/bpU2DwvBUoGgcDkeHldsqwIfWMvgNc0onaW5wIXC3wQei1wLJ2RBWDAP/H2V1Pw1yUF+zkIBIp3vXeJNXuz6ZXkVYKK/ArIwbGI2tu/5bZTQb8Q+NWt+dd/KaLigW2Go/7JH4yDYtKZ2pi3oXaBUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qlYiUHkF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 474EB211C261; Fri,  3 Oct 2025 08:47:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 474EB211C261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759506444;
	bh=pXrCFoiP29LJ+ofNopBlzkuBSlGEqfHo1NT4ymmIUKA=;
	h=Date:From:To:Subject:From;
	b=qlYiUHkFqtHJubOJCMK9OZoof82SUso7n1G2o6BzLuNsUoh4LxrK3sJlRHhNNxZiq
	 hAJbqFA//t+eVjeE2c9F3Wh6qE+zdJYbSx/dxYPPZgpLWCUmcLfdjmhjZFem+jK/KO
	 hnej7hLI1LKUWaQOTHaSrr8TeoUByWwaAmJ2FlzI=
Date: Fri, 3 Oct 2025 08:47:24 -0700
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	gargaditya@microsoft.com, gargaditya@linux.microsoft.com,
	ssengar@linux.microsoft.com
Subject: [PATCH net-next] net: mana: Linearize SKB if TX SGEs exceeds
 hardware limit
Message-ID: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)

The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
per TX WQE. In rare configurations where MAX_SKB_FRAGS + 2 exceeds this
limit, the driver drops the skb. Add a check in mana_start_xmit() to
detect such cases and linearize the SKB before transmission.

Return NETDEV_TX_BUSY only for -ENOSPC from mana_gd_post_work_request(),
send other errors to free_sgl_ptr to free resources and record the tx
drop.

Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 26 +++++++++++++++----
 include/net/mana/gdma.h                       |  8 +++++-
 include/net/mana/mana.h                       |  1 +
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index f4fc86f20213..22605753ca84 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -20,6 +20,7 @@
 
 #include <net/mana/mana.h>
 #include <net/mana/mana_auxiliary.h>
+#include <linux/skbuff.h>
 
 static DEFINE_IDA(mana_adev_ida);
 
@@ -289,6 +290,19 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	cq = &apc->tx_qp[txq_idx].tx_cq;
 	tx_stats = &txq->stats;
 
+	BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES != MANA_MAX_TX_WQE_SGL_ENTRIES);
+	#if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
+		if (skb_shinfo(skb)->nr_frags + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES) {
+			netdev_info_once(ndev,
+					 "nr_frags %d exceeds max supported sge limit. Attempting skb_linearize\n",
+					 skb_shinfo(skb)->nr_frags);
+			if (skb_linearize(skb)) {
+				netdev_warn_once(ndev, "Failed to linearize skb\n");
+				goto tx_drop_count;
+			}
+		}
+	#endif
+
 	pkg.tx_oob.s_oob.vcq_num = cq->gdma_id;
 	pkg.tx_oob.s_oob.vsq_frame = txq->vsq_frame;
 
@@ -402,8 +416,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		}
 	}
 
-	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
-
 	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
 		pkg.wqe_req.sgl = pkg.sgl_array;
 	} else {
@@ -438,9 +450,13 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	if (err) {
 		(void)skb_dequeue_tail(&txq->pending_skbs);
+		mana_unmap_skb(skb, apc);
 		netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);
-		err = NETDEV_TX_BUSY;
-		goto tx_busy;
+		if (err == -ENOSPC) {
+			err = NETDEV_TX_BUSY;
+			goto tx_busy;
+		}
+		goto free_sgl_ptr;
 	}
 
 	err = NETDEV_TX_OK;
@@ -1606,7 +1622,7 @@ static int mana_move_wq_tail(struct gdma_queue *wq, u32 num_units)
 	return 0;
 }
 
-static void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
+void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
 {
 	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
 	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 57df78cfbf82..67fab1a5f382 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -489,6 +489,8 @@ struct gdma_wqe {
 #define MAX_TX_WQE_SIZE 512
 #define MAX_RX_WQE_SIZE 256
 
+#define MANA_MAX_TX_WQE_SGL_ENTRIES 30
+
 #define MAX_TX_WQE_SGL_ENTRIES	((GDMA_MAX_SQE_SIZE -			   \
 			sizeof(struct gdma_sge) - INLINE_OOB_SMALL_SIZE) / \
 			sizeof(struct gdma_sge))
@@ -591,6 +593,9 @@ enum {
 /* Driver can self reset on FPGA Reconfig EQE notification */
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
 
+/* Driver supports linearizing the skb when num_sge exceeds hardware limit */
+#define GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE BIT(20)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -599,7 +604,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
 	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
 	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
-	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
+	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 0921485565c0..330e1bb088bb 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -580,6 +580,7 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 void mana_query_phy_stats(struct mana_port_context *apc);
 int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
+void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc);
 
 extern const struct ethtool_ops mana_ethtool_ops;
 extern struct dentry *mana_debugfs_root;
-- 
2.34.1


