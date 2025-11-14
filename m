Return-Path: <linux-hyperv+bounces-7598-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBBAC5F572
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 22:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9E13B7E9C
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E235581D;
	Fri, 14 Nov 2025 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mgKCNaae"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DB035502E;
	Fri, 14 Nov 2025 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155175; cv=none; b=fTtNs/eGog5lx104SXk679tI855Vzooyqo0ps1ZhsSrtsYJURf86N+oWA7S6FOk2mPk3O+mCRG2pks+zTMmQlcedTk1isH7v1nxGzgk6HzqivkFn87PusFbd3mFndjh1L25/rgU0K4Tb2yHGISEFfaDy8csWpCH2AQiyoIIsGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155175; c=relaxed/simple;
	bh=qAppDtmq4RZmDXIxIomimfZXh1p8unkN9SunTrsVs6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z/J1m1tRUAIz7vAT32xlsha5rTX4Bkrmupmh/vdRlyNa6kQJoqzpzNxgk+hDaEbqHkUMRj2B9nTpjkhW1bo/M4l2NgBLui3oefYrMju7uUj5PRdbWeJJLXC1Czuq3P9whLM9GYCEBCulPl1/3Nu5RvccRm8IEoaifdkvzen+UG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mgKCNaae; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 39841201AE67; Fri, 14 Nov 2025 13:19:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 39841201AE67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763155173;
	bh=YgwzmMqOcrNlI7yfupM3/trEvTD0ly+JPEobPCbJOyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgKCNaaeedMGLvyyTMf9nxcR4R2Wlk98Q5AT6Oaqc7tmhtRMZ8IKZwIhK1SxLQ4p2
	 lzJ36VHkXg8PMsuyV0SXAGNhatUnnSrSmdGmOyr+IS6fpcERZ5OOKOB71XEZUKZ05S
	 glFDF4Oa2ZdpW+RceR2HKTL8e7R5aldF+uVHuAFY=
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
Subject: [PATCH net-next v5 1/2] net: mana: Handle SKB if TX SGEs exceed hardware limit
Date: Fri, 14 Nov 2025 13:16:42 -0800
Message-Id: <1763155003-21503-2-git-send-email-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1763155003-21503-1-git-send-email-gargaditya@linux.microsoft.com>
References: <1763155003-21503-1-git-send-email-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
per TX WQE. Exceeding this limit can cause TX failures.
Add ndo_features_check() callback to validate SKB layout before
transmission. For GSO SKBs that would exceed the hardware SGE limit, clear
NETIF_F_GSO_MASK to enforce software segmentation in the stack.
Add a fallback in mana_start_xmit() to linearize non-GSO SKBs that still
exceed the SGE limit.

Also, Add ethtool counter for SKBs linearized

Co-developed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
---
Changes in v5:
* Drop skb_is_gso() check for disabling GSO in mana_features_check().
* Register .ndo_features_check conditionally to avoid unnecessary call.

Changes in v4:
* No change.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 41 ++++++++++++++++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    |  2 +
 include/net/mana/gdma.h                       |  8 +++-
 include/net/mana/mana.h                       |  1 +
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index cccd5b63cee6..d92069954fd9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/export.h>
+#include <linux/skbuff.h>
 
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
@@ -329,6 +330,22 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	cq = &apc->tx_qp[txq_idx].tx_cq;
 	tx_stats = &txq->stats;
 
+	BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES != MANA_MAX_TX_WQE_SGL_ENTRIES);
+#if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
+	if (skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
+		/* GSO skb with Hardware SGE limit exceeded is not expected here
+		 * as they are handled in mana_features_check() callback
+		 */
+		if (skb_linearize(skb)) {
+			netdev_warn_once(ndev, "Failed to linearize skb with nr_frags=%d and is_gso=%d\n",
+					 skb_shinfo(skb)->nr_frags,
+					 skb_is_gso(skb));
+			goto tx_drop_count;
+		}
+		apc->eth_stats.linear_pkt_tx_cnt++;
+	}
+#endif
+
 	pkg.tx_oob.s_oob.vcq_num = cq->gdma_id;
 	pkg.tx_oob.s_oob.vsq_frame = txq->vsq_frame;
 
@@ -442,8 +459,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		}
 	}
 
-	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
-
 	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
 		pkg.wqe_req.sgl = pkg.sgl_array;
 	} else {
@@ -518,6 +533,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+#if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
+static netdev_features_t mana_features_check(struct sk_buff *skb,
+					     struct net_device *ndev,
+					     netdev_features_t features)
+{
+	if (skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
+		/* Exceeds HW SGE limit.
+		 * GSO case:
+		 *   Disable GSO so the stack will software-segment the skb
+		 *   into smaller skbs that fit the SGE budget.
+		 * Non-GSO case:
+		 *   The xmit path will attempt skb_linearize() as a fallback.
+		 */
+		features &= ~NETIF_F_GSO_MASK;
+	}
+	return features;
+}
+#endif
+
 static void mana_get_stats64(struct net_device *ndev,
 			     struct rtnl_link_stats64 *st)
 {
@@ -878,6 +912,9 @@ static const struct net_device_ops mana_devops = {
 	.ndo_open		= mana_open,
 	.ndo_stop		= mana_close,
 	.ndo_select_queue	= mana_select_queue,
+#if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
+	.ndo_features_check	= mana_features_check,
+#endif
 	.ndo_start_xmit		= mana_start_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_get_stats64	= mana_get_stats64,
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index a1afa75a9463..fa5e1a2f06a9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -71,6 +71,8 @@ static const struct mana_stats_desc mana_eth_stats[] = {
 	{"tx_cq_err", offsetof(struct mana_ethtool_stats, tx_cqe_err)},
 	{"tx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
 					tx_cqe_unknown_type)},
+	{"linear_pkt_tx_cnt", offsetof(struct mana_ethtool_stats,
+					linear_pkt_tx_cnt)},
 	{"rx_coalesced_err", offsetof(struct mana_ethtool_stats,
 					rx_coalesced_err)},
 	{"rx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 637f42485dba..6dae78dc468f 100644
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
@@ -592,6 +594,9 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
 #define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
+/* Driver supports linearizing the skb when num_sge exceeds hardware limit */
+#define GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE BIT(20)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -601,7 +606,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
 	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
-	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE)
+	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE | \
+	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 8906901535f5..50a532fb30d6 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -404,6 +404,7 @@ struct mana_ethtool_stats {
 	u64 hc_tx_err_gdma;
 	u64 tx_cqe_err;
 	u64 tx_cqe_unknown_type;
+	u64 linear_pkt_tx_cnt;
 	u64 rx_coalesced_err;
 	u64 rx_cqe_unknown_type;
 };
-- 
2.43.0


