Return-Path: <linux-hyperv+bounces-7679-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D926C690FA
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 12:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E0C392AA3F
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFBD352F8D;
	Tue, 18 Nov 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d1lOsvbk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148934FF7A;
	Tue, 18 Nov 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465185; cv=none; b=GEkHdCg+20Nvcls8XMsLG7pABy4DtRYkgTKgNcVu4gEmX3xPuT7IyJs23oopx7tljGjpt3BEw1VsKoTe5CWxruqk6+M+X/YizgOT6b0eIs6lEwErsrd39vQFQDbCygoAj/AKdVoel35F16q3kZzVIgaBPR8AXuY8Xo1v0LBYcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465185; c=relaxed/simple;
	bh=x1wIAFncgvboxuHLahLbPOyRHNSWyKlaAo8thvAKIWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oNPVupgkknnEcv8DCii9KhFgjQIogx3jXogWRBWZGdtzXWosdw9J6Y6GDC+w55D8MdLoOzj4qFRZ5rEDqzN02wNF2d7S84ecpYGJWMUGr5CuJpc49OMkQysXGb2PbVMvdn6LeQeceinsq6gKmtd3cz4jBfqgcTEmBTVxujwtOb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d1lOsvbk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 950B0211CFB8; Tue, 18 Nov 2025 03:26:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 950B0211CFB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763465182;
	bh=VgYOnPe2VlONnKvj0poPVh0ufECls3xCkbpzYjs44w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1lOsvbkqVKRVeBYGrM3/egdFnYTgQCvjAI3ojrxuwoAXgGcsVLzf3/PmYayZbJQx
	 GCtvyapgjKm7oY44uzoX1z2FVL1LkIx5s07R6EH0l0gtxPfti+/GuyFOpqxmS2WGUG
	 RdVDpzln7Rxp7H2MyZeEyFZ3fpOLVVDoXrw+GRqE=
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
Subject: [PATCH net-next v6 2/2] net: mana: Drop TX skb on post_work_request failure and unmap resources
Date: Tue, 18 Nov 2025 03:11:09 -0800
Message-Id: <1763464269-10431-3-git-send-email-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1763464269-10431-1-git-send-email-gargaditya@linux.microsoft.com>
References: <1763464269-10431-1-git-send-email-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Drop TX packets when posting the work request fails and ensure DMA
mappings are always cleaned up.

Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
Changes in v6:
* No change.

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
index 7b49ab005e2d..1ad154f9db1a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -492,9 +492,9 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	if (err) {
 		(void)skb_dequeue_tail(&txq->pending_skbs);
+		mana_unmap_skb(skb, apc);
 		netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);
-		err = NETDEV_TX_BUSY;
-		goto tx_busy;
+		goto free_sgl_ptr;
 	}
 
 	err = NETDEV_TX_OK;
@@ -514,7 +514,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	tx_stats->bytes += len + ((num_gso_seg - 1) * gso_hs);
 	u64_stats_update_end(&tx_stats->syncp);
 
-tx_busy:
 	if (netif_tx_queue_stopped(net_txq) && mana_can_tx(gdma_sq)) {
 		netif_tx_wake_queue(net_txq);
 		apc->eth_stats.wake_queue++;
@@ -1687,7 +1686,7 @@ static int mana_move_wq_tail(struct gdma_queue *wq, u32 num_units)
 	return 0;
 }
 
-static void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
+void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
 {
 	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
 	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index fb28b3cac067..d7e089c6b694 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -593,6 +593,7 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 void mana_query_phy_stats(struct mana_port_context *apc);
 int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
+void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc);
 
 extern const struct ethtool_ops mana_ethtool_ops;
 extern struct dentry *mana_debugfs_root;
-- 
2.43.0


