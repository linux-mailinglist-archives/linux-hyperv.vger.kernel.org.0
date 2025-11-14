Return-Path: <linux-hyperv+bounces-7599-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FCAC5F583
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 22:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41A934E5F98
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 21:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7033559E8;
	Fri, 14 Nov 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pMbgVEc+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCE3557FD;
	Fri, 14 Nov 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155175; cv=none; b=aRqnMH3OuuvCMm42/0lBzRr+whIQa1O2y0yML49wtk84/RcnF2VNibHAAm4gnvz4q08yo7zi3COVaLVL5DZna2kGjizOhlFD6E0xAcP9ta2C57M1w5sK9sFZkxQ2m8ms0VFHAfmFOKo2IoX1OHuZxoCLWuaaD3u6Y5zirIC5YeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155175; c=relaxed/simple;
	bh=Nu30pldOwGlys8I2ywWDSu8pAPSxOvcDnI2VUKLe1hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oozK8+PzpAHAGwerJ8UlZLnX1gEYo2/Mk3Z4icZdKeHmXsTSfIFg1cxlhhWq0Ux5MC/3jGOvwbvdRSbT8CQytAZY0kkkVKNOd2Ok8lf7Nbt2nKT7YQpGO1rUMoTxIfzYZ9rIcqBy+nPiXyhNBf37HkZPTx5/aZpUeggFjsygtPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pMbgVEc+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 33AFF201AE68; Fri, 14 Nov 2025 13:19:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33AFF201AE68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763155174;
	bh=81onwcqImC0AKbBfwuNL6qtdSNr5P5GozI4oWfMmqfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMbgVEc+aVoQ9Y5y2p2gHwmgO1OZkIY8RX1dheo525PkBrtEv0o52rbn3OIHdyv5e
	 w9DfCe9PWWrusvDUmCOM887MOmHGXgHecoWFBdWuEnsJA69ynZijnepR8BxHVW/lth
	 dTy8gJnVOXumz1RwbFb3E2v5n2fqwTxvM71NXVGs=
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	leon@kernel.org,
	mlevitsk@redhat.com,
	yury.norov@gmail.com,
	sbhatta@marvell.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	gargaditya@microsoft.com
Cc: Aditya Garg <gargaditya@linux.microsoft.com>
Subject: [PATCH net-next v5 2/2] net: mana: Drop TX skb on post_work_request failure and unmap resources
Date: Fri, 14 Nov 2025 13:16:43 -0800
Message-Id: <1763155003-21503-3-git-send-email-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1763155003-21503-1-git-send-email-gargaditya@linux.microsoft.com>
References: <1763155003-21503-1-git-send-email-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Drop TX packets when posting the work request fails and ensure DMA
mappings are always cleaned up.

Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
---
Changes in v5:
* No change.

Changes in v4:
* Fix warning during build reported by kernel test robot
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 6 +-----
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 7 +++----
 include/net/mana/mana.h                         | 1 +
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index effe0a2f207a..8fd70b34807a 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1300,7 +1300,6 @@ int mana_gd_post_work_request(struct gdma_queue *wq,
 			      struct gdma_posted_wqe_info *wqe_info)
 {
 	u32 client_oob_size = wqe_req->inline_oob_size;
-	struct gdma_context *gc;
 	u32 sgl_data_size;
 	u32 max_wqe_size;
 	u32 wqe_size;
@@ -1330,11 +1329,8 @@ int mana_gd_post_work_request(struct gdma_queue *wq,
 	if (wqe_size > max_wqe_size)
 		return -EINVAL;
 
-	if (wq->monitor_avl_buf && wqe_size > mana_gd_wq_avail_space(wq)) {
-		gc = wq->gdma_dev->gdma_context;
-		dev_err(gc->dev, "unsuccessful flow control!\n");
+	if (wq->monitor_avl_buf && wqe_size > mana_gd_wq_avail_space(wq))
 		return -ENOSPC;
-	}
 
 	if (wqe_info)
 		wqe_info->wqe_size_in_bu = wqe_size / GDMA_WQE_BU_SIZE;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d92069954fd9..d656c0882343 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -493,9 +493,9 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	if (err) {
 		(void)skb_dequeue_tail(&txq->pending_skbs);
+		mana_unmap_skb(skb, apc);
 		netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);
-		err = NETDEV_TX_BUSY;
-		goto tx_busy;
+		goto free_sgl_ptr;
 	}
 
 	err = NETDEV_TX_OK;
@@ -515,7 +515,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	tx_stats->bytes += len + ((num_gso_seg - 1) * gso_hs);
 	u64_stats_update_end(&tx_stats->syncp);
 
-tx_busy:
 	if (netif_tx_queue_stopped(net_txq) && mana_can_tx(gdma_sq)) {
 		netif_tx_wake_queue(net_txq);
 		apc->eth_stats.wake_queue++;
@@ -1683,7 +1682,7 @@ static int mana_move_wq_tail(struct gdma_queue *wq, u32 num_units)
 	return 0;
 }
 
-static void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
+void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
 {
 	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
 	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 50a532fb30d6..d05457d3e1ab 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -585,6 +585,7 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 void mana_query_phy_stats(struct mana_port_context *apc);
 int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
+void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc);
 
 extern const struct ethtool_ops mana_ethtool_ops;
 extern struct dentry *mana_debugfs_root;
-- 
2.43.0


