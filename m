Return-Path: <linux-hyperv+bounces-7494-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60FC4C591
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 09:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD70718C34FA
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648B9314B76;
	Tue, 11 Nov 2025 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P7JPprkQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293332D43F;
	Tue, 11 Nov 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848882; cv=none; b=HKRz6ECel8j/gMqXNh4iwAGa1PgoenMO84DKzd0oGeAkGYW8uawCRPHtOKhTyYwFG7cqxJXJcP4OdWmRg0hr3RlPUGYBlg8gOw3B/j6b4FFKu1rmGdBMxbSwfDsW6hT+u0rsLZUbJhuqIjBlJJ/jec0AHyeMEcydwXmmefnu3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848882; c=relaxed/simple;
	bh=1h4gdR+TCSYQGJF48StulHpEy7fFsWRuNP3JneEhd2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sp1GaPNxtjGp4qikzIvN+8udH+I1Q2gDoYZPVylX4jHWqs9Pm1r2uX7zbbWjS8ogp8o4K05ZTK0HFt3ot/BY3JUhZlTnkzi7vYKDEyXNBHxDHWlMtA1F6PXTnuALSQU9p0vnWbTX7dd/Kzvvp4dm51yeMMIzLoVXtsCQfkgSXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P7JPprkQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 76222212AE45; Tue, 11 Nov 2025 00:14:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76222212AE45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762848880;
	bh=kGKvStNQ+JNMppHZ3F98mObNapVsEdbSU4ej1cfRrDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7JPprkQxd4EM+oL7Qgwij+7I2VGhGw89iWPfw27Q8Wn2W6ywf/uDak1QJwgxdvO3
	 RCcUGkuHhnIykI6p1DT9DTfO891nt0zF+fss3b16gbSBEDBxGPK0m8rTanAYyFwtob
	 mcGiyu0jOAQyk4fWBXCFcRk0s6+JsGbDacXrsYCU=
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
Subject: [PATCH net-next v3 1/2] net: mana: Handle SKB if TX SGEs exceed hardware limit
Date: Tue, 11 Nov 2025 00:13:00 -0800
Message-Id: <1762848781-357-2-git-send-email-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1762848781-357-1-git-send-email-gargaditya@linux.microsoft.com>
References: <1762848781-357-1-git-send-email-gargaditya@linux.microsoft.com>
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
 drivers/net/ethernet/microsoft/mana/mana_en.c | 37 ++++++++++++++++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    |  2 +
 include/net/mana/gdma.h                       |  6 ++-
 include/net/mana/mana.h                       |  1 +
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index cccd5b63cee6..67ae5421f9ee 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/export.h>
+#include <linux/skbuff.h>
 
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
@@ -329,6 +330,20 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	cq = &apc->tx_qp[txq_idx].tx_cq;
 	tx_stats = &txq->stats;
 
+	if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
+	    skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
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
+
 	pkg.tx_oob.s_oob.vcq_num = cq->gdma_id;
 	pkg.tx_oob.s_oob.vsq_frame = txq->vsq_frame;
 
@@ -442,8 +457,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		}
 	}
 
-	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
-
 	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
 		pkg.wqe_req.sgl = pkg.sgl_array;
 	} else {
@@ -518,6 +531,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+static netdev_features_t mana_features_check(struct sk_buff *skb,
+					     struct net_device *ndev,
+					     netdev_features_t features)
+{
+	if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
+	    skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
+		/* Exceeds HW SGE limit.
+		 * GSO case:
+		 *   Disable GSO so the stack will software-segment the skb
+		 *   into smaller skbs that fit the SGE budget.
+		 * Non-GSO case:
+		 *   The xmit path will attempt skb_linearize() as a fallback.
+		 */
+		if (skb_is_gso(skb))
+			features &= ~NETIF_F_GSO_MASK;
+	}
+	return features;
+}
+
 static void mana_get_stats64(struct net_device *ndev,
 			     struct rtnl_link_stats64 *st)
 {
@@ -878,6 +910,7 @@ static const struct net_device_ops mana_devops = {
 	.ndo_open		= mana_open,
 	.ndo_stop		= mana_close,
 	.ndo_select_queue	= mana_select_queue,
+	.ndo_features_check	= mana_features_check,
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
index 637f42485dba..84614ebe0f4c 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -592,6 +592,9 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
 #define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
+/* Driver supports linearizing the skb when num_sge exceeds hardware limit */
+#define GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE BIT(20)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -601,7 +604,8 @@ enum {
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


