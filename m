Return-Path: <linux-hyperv+bounces-5803-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85EAAD1B20
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04D33A4349
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 10:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7731E5702;
	Mon,  9 Jun 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CCIjsG/l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD651922DE;
	Mon,  9 Jun 2025 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749463272; cv=none; b=hdksbyO5l2ZgUfXh89nrx5O+Ogn9+56f0eyCfuVS8wnu2w6px4yUFynVfgWnFzbxGsj9gCNJQLJ8O/VJ46Q/a5E3NpJnodJ7QBx8dBNE55PYFQEiY3XGeNMzp0qHKqrhd/5N6XEXdbPQk1alH+5BRV3LjIjRnysiEZrUzJA0Pdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749463272; c=relaxed/simple;
	bh=ogRi/YjddSjNJJnDjJxYiXMBYPVlFRa/EbYo8Fcany8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VCEtPt4BCI8DX2NkHSxcoPtfEnWBQiM+KG3e1IBj1HOWl3qA8Gz5A+VIAWEN5tINaZHDWJMPrFbf5aA1zHJf6SyJDgt0I2QmxL6P0h0n/1pWLHZflZf7LeNviR6eAJgakE1F81AQw0etZg/R3mYHs3bxmMj/bMgNaL2W6TvAhO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CCIjsG/l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 984CC21175B1; Mon,  9 Jun 2025 03:01:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 984CC21175B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749463263;
	bh=0NCra6KWUZ6qp+6dXiRnt2NLfFSkIUxXATp7qs0SaYg=;
	h=Date:From:To:Subject:From;
	b=CCIjsG/lP0qErkq39bMZpwUWYy2sbfTgIh4r8iPcF/ndWeZloWbdSq6WzxzmTRs5n
	 IRGeG0dCZj7oApFojBoghcX6d5GZ9nLMYMyEzQWGb7f0lV8Zs7gjgB0sy/9iJjaDH2
	 x3OURk7U612SBkN4ro/9uy2kRKSLpuxB5/kdVpDM=
Date: Mon, 9 Jun 2025 03:01:03 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: andrew+net@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	mhklinux@outlook.com, ernis@linux.microsoft.com,
	dipayanroy@microsoft.com, schakrabarti@linux.microsoft.com,
	rosenp@gmail.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH] net: mana: Expose additional hardware counters for drop and
 TC via ethtool.
Message-ID: <20250609100103.GA7102@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)

Add support for reporting additional hardware counters for drop and
TC using the ethtool -S interface.

These counters include:

- Aggregate Rx/Tx drop counters
- Per-TC Rx/Tx packet counters
- Per-TC Rx/Tx byte counters
- Per-TC Rx/Tx pause frame counters

The counters are exposed using ethtool_ops->get_ethtool_stats and
ethtool_ops->get_strings. This feature/counters are not available
to all versions of hardware.

Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/hw_channel.c  |   6 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c |  87 +++++++++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    |  76 +++++++++-
 include/net/mana/mana.h                       | 131 ++++++++++++++++++
 4 files changed, 292 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 1ba49602089b..feb3b74700ed 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021, Microsoft Corporation. */
 
 #include <net/mana/gdma.h>
+#include <net/mana/mana.h>
 #include <net/mana/hw_channel.h>
 #include <linux/vmalloc.h>
 
@@ -871,8 +872,9 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	}
 
 	if (ctx->status_code && ctx->status_code != GDMA_STATUS_MORE_ENTRIES) {
-		dev_err(hwc->dev, "HWC: Failed hw_channel req: 0x%x\n",
-			ctx->status_code);
+		if (req_msg->req.msg_type != MANA_QUERY_PHY_STAT)
+			dev_err(hwc->dev, "HWC: Failed hw_channel req: 0x%x\n",
+				ctx->status_code);
 		err = -EPROTO;
 		goto out;
 	}
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9c58d9e0bbb5..d2b6e3f09ec2 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -774,8 +774,9 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
 	err = mana_gd_send_request(gc, in_len, in_buf, out_len,
 				   out_buf);
 	if (err || resp->status) {
-		dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
-			err, resp->status);
+		if (req->req.msg_type != MANA_QUERY_PHY_STAT)
+			dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
+				err, resp->status);
 		return err ? err : -EPROTO;
 	}
 
@@ -2611,6 +2612,88 @@ void mana_query_gf_stats(struct mana_port_context *apc)
 	apc->eth_stats.hc_tx_err_gdma = resp.tx_err_gdma;
 }
 
+void mana_query_phy_stats(struct mana_port_context *apc)
+{
+	struct mana_query_phy_stat_resp resp = {};
+	struct mana_query_phy_stat_req req = {};
+	struct net_device *ndev = apc->ndev;
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_PHY_STAT,
+			     sizeof(req), sizeof(resp));
+	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
+				sizeof(resp));
+	if (err)
+		return;
+
+	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_PHY_STAT,
+				   sizeof(resp));
+	if (err || resp.hdr.status) {
+		netdev_err(ndev,
+			   "Failed to query PHY stats: %d, resp:0x%x\n",
+				err, resp.hdr.status);
+		return;
+	}
+
+	/* Aggregate drop counters */
+	apc->phy_stats.rx_pkt_drop_phy = resp.rx_pkt_drop_phy;
+	apc->phy_stats.tx_pkt_drop_phy = resp.tx_pkt_drop_phy;
+
+	/* Per TC traffic Counters */
+	apc->phy_stats.rx_pkt_tc0_phy = resp.rx_pkt_tc0_phy;
+	apc->phy_stats.tx_pkt_tc0_phy = resp.tx_pkt_tc0_phy;
+	apc->phy_stats.rx_pkt_tc1_phy = resp.rx_pkt_tc1_phy;
+	apc->phy_stats.tx_pkt_tc1_phy = resp.tx_pkt_tc1_phy;
+	apc->phy_stats.rx_pkt_tc2_phy = resp.rx_pkt_tc2_phy;
+	apc->phy_stats.tx_pkt_tc2_phy = resp.tx_pkt_tc2_phy;
+	apc->phy_stats.rx_pkt_tc3_phy = resp.rx_pkt_tc3_phy;
+	apc->phy_stats.tx_pkt_tc3_phy = resp.tx_pkt_tc3_phy;
+	apc->phy_stats.rx_pkt_tc4_phy = resp.rx_pkt_tc4_phy;
+	apc->phy_stats.tx_pkt_tc4_phy = resp.tx_pkt_tc4_phy;
+	apc->phy_stats.rx_pkt_tc5_phy = resp.rx_pkt_tc5_phy;
+	apc->phy_stats.tx_pkt_tc5_phy = resp.tx_pkt_tc5_phy;
+	apc->phy_stats.rx_pkt_tc6_phy = resp.rx_pkt_tc6_phy;
+	apc->phy_stats.tx_pkt_tc6_phy = resp.tx_pkt_tc6_phy;
+	apc->phy_stats.rx_pkt_tc7_phy = resp.rx_pkt_tc7_phy;
+	apc->phy_stats.tx_pkt_tc7_phy = resp.tx_pkt_tc7_phy;
+
+	/* Per TC byte Counters */
+	apc->phy_stats.rx_byte_tc0_phy = resp.rx_byte_tc0_phy;
+	apc->phy_stats.tx_byte_tc0_phy = resp.tx_byte_tc0_phy;
+	apc->phy_stats.rx_byte_tc1_phy = resp.rx_byte_tc1_phy;
+	apc->phy_stats.tx_byte_tc1_phy = resp.tx_byte_tc1_phy;
+	apc->phy_stats.rx_byte_tc2_phy = resp.rx_byte_tc2_phy;
+	apc->phy_stats.tx_byte_tc2_phy = resp.tx_byte_tc2_phy;
+	apc->phy_stats.rx_byte_tc3_phy = resp.rx_byte_tc3_phy;
+	apc->phy_stats.tx_byte_tc3_phy = resp.tx_byte_tc3_phy;
+	apc->phy_stats.rx_byte_tc4_phy = resp.rx_byte_tc4_phy;
+	apc->phy_stats.tx_byte_tc4_phy = resp.tx_byte_tc4_phy;
+	apc->phy_stats.rx_byte_tc5_phy = resp.rx_byte_tc5_phy;
+	apc->phy_stats.tx_byte_tc5_phy = resp.tx_byte_tc5_phy;
+	apc->phy_stats.rx_byte_tc6_phy = resp.rx_byte_tc6_phy;
+	apc->phy_stats.tx_byte_tc6_phy = resp.tx_byte_tc6_phy;
+	apc->phy_stats.rx_byte_tc7_phy = resp.rx_byte_tc7_phy;
+	apc->phy_stats.tx_byte_tc7_phy = resp.tx_byte_tc7_phy;
+
+	/* Per TC pause Counters */
+	apc->phy_stats.rx_pause_tc0_phy = resp.rx_pause_tc0_phy;
+	apc->phy_stats.tx_pause_tc0_phy = resp.tx_pause_tc0_phy;
+	apc->phy_stats.rx_pause_tc1_phy = resp.rx_pause_tc1_phy;
+	apc->phy_stats.tx_pause_tc1_phy = resp.tx_pause_tc1_phy;
+	apc->phy_stats.rx_pause_tc2_phy = resp.rx_pause_tc2_phy;
+	apc->phy_stats.tx_pause_tc2_phy = resp.tx_pause_tc2_phy;
+	apc->phy_stats.rx_pause_tc3_phy = resp.rx_pause_tc3_phy;
+	apc->phy_stats.tx_pause_tc3_phy = resp.tx_pause_tc3_phy;
+	apc->phy_stats.rx_pause_tc4_phy = resp.rx_pause_tc4_phy;
+	apc->phy_stats.tx_pause_tc4_phy = resp.tx_pause_tc4_phy;
+	apc->phy_stats.rx_pause_tc5_phy = resp.rx_pause_tc5_phy;
+	apc->phy_stats.tx_pause_tc5_phy = resp.tx_pause_tc5_phy;
+	apc->phy_stats.rx_pause_tc6_phy = resp.rx_pause_tc6_phy;
+	apc->phy_stats.tx_pause_tc6_phy = resp.tx_pause_tc6_phy;
+	apc->phy_stats.rx_pause_tc7_phy = resp.rx_pause_tc7_phy;
+	apc->phy_stats.tx_pause_tc7_phy = resp.tx_pause_tc7_phy;
+}
+
 static int mana_init_port(struct net_device *ndev)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index c419626073f5..4fb3a04994a2 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -7,10 +7,12 @@
 
 #include <net/mana/mana.h>
 
-static const struct {
+struct mana_stats_desc {
 	char name[ETH_GSTRING_LEN];
 	u16 offset;
-} mana_eth_stats[] = {
+};
+
+static const struct mana_stats_desc mana_eth_stats[] = {
 	{"stop_queue", offsetof(struct mana_ethtool_stats, stop_queue)},
 	{"wake_queue", offsetof(struct mana_ethtool_stats, wake_queue)},
 	{"hc_rx_discards_no_wqe", offsetof(struct mana_ethtool_stats,
@@ -75,6 +77,59 @@ static const struct {
 					rx_cqe_unknown_type)},
 };
 
+static const struct mana_stats_desc mana_phy_stats[] = {
+	{ "hc_rx_pkt_drop_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_drop_phy) },
+	{ "hc_tx_pkt_drop_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_drop_phy) },
+	{ "hc_tc0_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc0_phy) },
+	{ "hc_tc0_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc0_phy) },
+	{ "hc_tc0_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc0_phy) },
+	{ "hc_tc0_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc0_phy) },
+	{ "hc_tc1_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc1_phy) },
+	{ "hc_tc1_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc1_phy) },
+	{ "hc_tc1_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc1_phy) },
+	{ "hc_tc1_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc1_phy) },
+	{ "hc_tc2_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc2_phy) },
+	{ "hc_tc2_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc2_phy) },
+	{ "hc_tc2_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc2_phy) },
+	{ "hc_tc2_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc2_phy) },
+	{ "hc_tc3_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc3_phy) },
+	{ "hc_tc3_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc3_phy) },
+	{ "hc_tc3_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc3_phy) },
+	{ "hc_tc3_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc3_phy) },
+	{ "hc_tc4_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc4_phy) },
+	{ "hc_tc4_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc4_phy) },
+	{ "hc_tc4_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc4_phy) },
+	{ "hc_tc4_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc4_phy) },
+	{ "hc_tc5_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc5_phy) },
+	{ "hc_tc5_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc5_phy) },
+	{ "hc_tc5_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc5_phy) },
+	{ "hc_tc5_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc5_phy) },
+	{ "hc_tc6_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc6_phy) },
+	{ "hc_tc6_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc6_phy) },
+	{ "hc_tc6_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc6_phy) },
+	{ "hc_tc6_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc6_phy) },
+	{ "hc_tc7_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc7_phy) },
+	{ "hc_tc7_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc7_phy) },
+	{ "hc_tc7_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc7_phy) },
+	{ "hc_tc7_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc7_phy) },
+	{ "hc_tc0_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc0_phy) },
+	{ "hc_tc0_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc0_phy) },
+	{ "hc_tc1_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc1_phy) },
+	{ "hc_tc1_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc1_phy) },
+	{ "hc_tc2_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc2_phy) },
+	{ "hc_tc2_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc2_phy) },
+	{ "hc_tc3_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc3_phy) },
+	{ "hc_tc3_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc3_phy) },
+	{ "hc_tc4_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc4_phy) },
+	{ "hc_tc4_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc4_phy) },
+	{ "hc_tc5_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc5_phy) },
+	{ "hc_tc5_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc5_phy) },
+	{ "hc_tc6_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc6_phy) },
+	{ "hc_tc6_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc6_phy) },
+	{ "hc_tc7_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc7_phy) },
+	{ "hc_tc7_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc7_phy) },
+};
+
 static int mana_get_sset_count(struct net_device *ndev, int stringset)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
@@ -83,8 +138,8 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
 	if (stringset != ETH_SS_STATS)
 		return -EINVAL;
 
-	return ARRAY_SIZE(mana_eth_stats) + num_queues *
-				(MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
+	return ARRAY_SIZE(mana_eth_stats) + ARRAY_SIZE(mana_phy_stats) +
+			num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
 }
 
 static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
@@ -99,6 +154,9 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 	for (i = 0; i < ARRAY_SIZE(mana_eth_stats); i++)
 		ethtool_puts(&data, mana_eth_stats[i].name);
 
+	for (i = 0; i < ARRAY_SIZE(mana_phy_stats); i++)
+		ethtool_puts(&data, mana_phy_stats[i].name);
+
 	for (i = 0; i < num_queues; i++) {
 		ethtool_sprintf(&data, "rx_%d_packets", i);
 		ethtool_sprintf(&data, "rx_%d_bytes", i);
@@ -128,6 +186,7 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	struct mana_port_context *apc = netdev_priv(ndev);
 	unsigned int num_queues = apc->num_queues;
 	void *eth_stats = &apc->eth_stats;
+	void *phy_stats = &apc->phy_stats;
 	struct mana_stats_rx *rx_stats;
 	struct mana_stats_tx *tx_stats;
 	unsigned int start;
@@ -151,9 +210,18 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	/* we call mana function to update stats from GDMA */
 	mana_query_gf_stats(apc);
 
+	/* We call this mana function to get the phy stats from GDMA and includes
+	 * aggregate tx/rx drop counters, Per-TC(Traffic Channel) tx/rx and pause
+	 * counters.
+	 */
+	mana_query_phy_stats(apc);
+
 	for (q = 0; q < ARRAY_SIZE(mana_eth_stats); q++)
 		data[i++] = *(u64 *)(eth_stats + mana_eth_stats[q].offset);
 
+	for (q = 0; q < ARRAY_SIZE(mana_phy_stats); q++)
+		data[i++] = *(u64 *)(phy_stats + mana_phy_stats[q].offset);
+
 	for (q = 0; q < num_queues; q++) {
 		rx_stats = &apc->rxqs[q]->stats;
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 38238c1d00bf..be6d5e878321 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -404,6 +404,65 @@ struct mana_ethtool_stats {
 	u64 rx_cqe_unknown_type;
 };
 
+struct mana_ethtool_phy_stats {
+	/* Drop Counters */
+	u64 rx_pkt_drop_phy;
+	u64 tx_pkt_drop_phy;
+
+	/* Per TC traffic Counters */
+	u64 rx_pkt_tc0_phy;
+	u64 tx_pkt_tc0_phy;
+	u64 rx_pkt_tc1_phy;
+	u64 tx_pkt_tc1_phy;
+	u64 rx_pkt_tc2_phy;
+	u64 tx_pkt_tc2_phy;
+	u64 rx_pkt_tc3_phy;
+	u64 tx_pkt_tc3_phy;
+	u64 rx_pkt_tc4_phy;
+	u64 tx_pkt_tc4_phy;
+	u64 rx_pkt_tc5_phy;
+	u64 tx_pkt_tc5_phy;
+	u64 rx_pkt_tc6_phy;
+	u64 tx_pkt_tc6_phy;
+	u64 rx_pkt_tc7_phy;
+	u64 tx_pkt_tc7_phy;
+
+	u64 rx_byte_tc0_phy;
+	u64 tx_byte_tc0_phy;
+	u64 rx_byte_tc1_phy;
+	u64 tx_byte_tc1_phy;
+	u64 rx_byte_tc2_phy;
+	u64 tx_byte_tc2_phy;
+	u64 rx_byte_tc3_phy;
+	u64 tx_byte_tc3_phy;
+	u64 rx_byte_tc4_phy;
+	u64 tx_byte_tc4_phy;
+	u64 rx_byte_tc5_phy;
+	u64 tx_byte_tc5_phy;
+	u64 rx_byte_tc6_phy;
+	u64 tx_byte_tc6_phy;
+	u64 rx_byte_tc7_phy;
+	u64 tx_byte_tc7_phy;
+
+	/* Per TC pause Counters */
+	u64 rx_pause_tc0_phy;
+	u64 tx_pause_tc0_phy;
+	u64 rx_pause_tc1_phy;
+	u64 tx_pause_tc1_phy;
+	u64 rx_pause_tc2_phy;
+	u64 tx_pause_tc2_phy;
+	u64 rx_pause_tc3_phy;
+	u64 tx_pause_tc3_phy;
+	u64 rx_pause_tc4_phy;
+	u64 tx_pause_tc4_phy;
+	u64 rx_pause_tc5_phy;
+	u64 tx_pause_tc5_phy;
+	u64 rx_pause_tc6_phy;
+	u64 tx_pause_tc6_phy;
+	u64 rx_pause_tc7_phy;
+	u64 tx_pause_tc7_phy;
+};
+
 struct mana_context {
 	struct gdma_dev *gdma_dev;
 
@@ -474,6 +533,8 @@ struct mana_port_context {
 
 	struct mana_ethtool_stats eth_stats;
 
+	struct mana_ethtool_phy_stats phy_stats;
+
 	/* Debugfs */
 	struct dentry *mana_port_debugfs;
 };
@@ -498,6 +559,7 @@ struct bpf_prog *mana_xdp_get(struct mana_port_context *apc);
 void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
 void mana_query_gf_stats(struct mana_port_context *apc);
+void mana_query_phy_stats(struct mana_port_context *apc);
 int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
 
@@ -524,6 +586,7 @@ enum mana_command_code {
 	MANA_FENCE_RQ		= 0x20006,
 	MANA_CONFIG_VPORT_RX	= 0x20007,
 	MANA_QUERY_VPORT_CONFIG	= 0x20008,
+	MANA_QUERY_PHY_STAT     = 0x2000c,
 
 	/* Privileged commands for the PF mode */
 	MANA_REGISTER_FILTER	= 0x28000,
@@ -686,6 +749,74 @@ struct mana_query_gf_stat_resp {
 	u64 tx_err_gdma;
 }; /* HW DATA */
 
+/* Query phy stats */
+struct mana_query_phy_stat_req {
+	struct gdma_req_hdr hdr;
+	u64 req_stats;
+}; /* HW DATA */
+
+struct mana_query_phy_stat_resp {
+	struct gdma_resp_hdr hdr;
+	u64 reported_stats;
+
+	/* Aggregate Drop Counters */
+	u64 rx_pkt_drop_phy;
+	u64 tx_pkt_drop_phy;
+
+	/* Per TC(Traffic class) traffic Counters */
+	u64 rx_pkt_tc0_phy;
+	u64 tx_pkt_tc0_phy;
+	u64 rx_pkt_tc1_phy;
+	u64 tx_pkt_tc1_phy;
+	u64 rx_pkt_tc2_phy;
+	u64 tx_pkt_tc2_phy;
+	u64 rx_pkt_tc3_phy;
+	u64 tx_pkt_tc3_phy;
+	u64 rx_pkt_tc4_phy;
+	u64 tx_pkt_tc4_phy;
+	u64 rx_pkt_tc5_phy;
+	u64 tx_pkt_tc5_phy;
+	u64 rx_pkt_tc6_phy;
+	u64 tx_pkt_tc6_phy;
+	u64 rx_pkt_tc7_phy;
+	u64 tx_pkt_tc7_phy;
+
+	u64 rx_byte_tc0_phy;
+	u64 tx_byte_tc0_phy;
+	u64 rx_byte_tc1_phy;
+	u64 tx_byte_tc1_phy;
+	u64 rx_byte_tc2_phy;
+	u64 tx_byte_tc2_phy;
+	u64 rx_byte_tc3_phy;
+	u64 tx_byte_tc3_phy;
+	u64 rx_byte_tc4_phy;
+	u64 tx_byte_tc4_phy;
+	u64 rx_byte_tc5_phy;
+	u64 tx_byte_tc5_phy;
+	u64 rx_byte_tc6_phy;
+	u64 tx_byte_tc6_phy;
+	u64 rx_byte_tc7_phy;
+	u64 tx_byte_tc7_phy;
+
+	/* Per TC(Traffic Class) pause Counters */
+	u64 rx_pause_tc0_phy;
+	u64 tx_pause_tc0_phy;
+	u64 rx_pause_tc1_phy;
+	u64 tx_pause_tc1_phy;
+	u64 rx_pause_tc2_phy;
+	u64 tx_pause_tc2_phy;
+	u64 rx_pause_tc3_phy;
+	u64 tx_pause_tc3_phy;
+	u64 rx_pause_tc4_phy;
+	u64 tx_pause_tc4_phy;
+	u64 rx_pause_tc5_phy;
+	u64 tx_pause_tc5_phy;
+	u64 rx_pause_tc6_phy;
+	u64 tx_pause_tc6_phy;
+	u64 rx_pause_tc7_phy;
+	u64 tx_pause_tc7_phy;
+}; /* HW DATA */
+
 /* Configure vPort Rx Steering */
 struct mana_cfg_rx_steer_req_v2 {
 	struct gdma_req_hdr hdr;
-- 
2.43.0


