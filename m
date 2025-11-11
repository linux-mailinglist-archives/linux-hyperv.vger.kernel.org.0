Return-Path: <linux-hyperv+bounces-7495-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95E7C4C5FA
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 09:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1E74249C3
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 08:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653DF332904;
	Tue, 11 Nov 2025 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P+CjRbeD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82C032E14A;
	Tue, 11 Nov 2025 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848884; cv=none; b=nM5FnaZ3Hh/O4JOCVU8GuJVl7oF047ue2YGpZFJ1JVxmCae7e1Z7IC7Q0TEWjODqLGv1Iv2sVX9FGGcgUGOjFhBfGj4AoOIW6OctJLpKzeqoOUBJW6RbgXCKr0DaM3y/97abNIFk/BF6iStN6VIAyyFn0VWdUqVzCKPg39WgV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848884; c=relaxed/simple;
	bh=papQpdMxZeZiO6Qt8EOXXoWcGPBUIrAgpmOX1fAOG5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aYa8lPHP1YUt1OBk6TqA0mRbhRqjGApHux3OFJf4WHDY1mj3ydwFGMA12JXFx1693BmdFaC7Mekg2YtE4RdM0Y4QhL3/3GZqhRDrmnOXUWFk6ZwrN8N+2221lOhPmbPGg7EFvYQVBRs1zTGEzlTkH7lDYXhxxMi+7RtiwX8KFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P+CjRbeD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 8DFF2212AE4B; Tue, 11 Nov 2025 00:14:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DFF2212AE4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762848882;
	bh=T4NA8arxo+rcogMEzVL17or5uDR3MncUC/lGtD/Hn6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+CjRbeD4IJ74AlXQL5IEVSDdThbsyK9diqgJLhxKXRlqw6uiwy76aLAgeYvOE8+L
	 vt1nvE9/X854hHkksfeDNluXdVfClT4HMio9HMYo/OFQsaT4/dLISssPrX6sf/IBNp
	 Z2sMVAMqpUFxmeDPPOG3YT+ImPixe+sh88yZ2M/Q=
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
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	gargaditya@microsoft.com
Cc: Aditya Garg <gargaditya@linux.microsoft.com>
Subject: [PATCH net-next v3 2/2] net: mana: Drop TX skb on post_work_request failure and unmap resources
Date: Tue, 11 Nov 2025 00:13:01 -0800
Message-Id: <1762848781-357-3-git-send-email-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1762848781-357-1-git-send-email-gargaditya@linux.microsoft.com>
References: <1762848781-357-1-git-send-email-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Drop TX packets when posting the work request fails and ensure DMA
mappings are always cleaned up.

Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 1 -
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 7 +++----
 include/net/mana/mana.h                         | 1 +
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index effe0a2f207a..65dd8060c7f4 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1332,7 +1332,6 @@ int mana_gd_post_work_request(struct gdma_queue *wq,
 
 	if (wq->monitor_avl_buf && wqe_size > mana_gd_wq_avail_space(wq)) {
 		gc = wq->gdma_dev->gdma_context;
-		dev_err(gc->dev, "unsuccessful flow control!\n");
 		return -ENOSPC;
 	}
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 67ae5421f9ee..066d822f68f0 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -491,9 +491,9 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	if (err) {
 		(void)skb_dequeue_tail(&txq->pending_skbs);
+		mana_unmap_skb(skb, apc);
 		netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);
-		err = NETDEV_TX_BUSY;
-		goto tx_busy;
+		goto free_sgl_ptr;
 	}
 
 	err = NETDEV_TX_OK;
@@ -513,7 +513,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	tx_stats->bytes += len + ((num_gso_seg - 1) * gso_hs);
 	u64_stats_update_end(&tx_stats->syncp);
 
-tx_busy:
 	if (netif_tx_queue_stopped(net_txq) && mana_can_tx(gdma_sq)) {
 		netif_tx_wake_queue(net_txq);
 		apc->eth_stats.wake_queue++;
@@ -1679,7 +1678,7 @@ static int mana_move_wq_tail(struct gdma_queue *wq, u32 num_units)
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


