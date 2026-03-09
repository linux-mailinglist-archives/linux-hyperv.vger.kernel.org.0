Return-Path: <linux-hyperv+bounces-9201-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPZxNUE7r2kPQQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9201-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Mar 2026 22:27:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30329241A86
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Mar 2026 22:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C918301C8A4
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Mar 2026 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C7344056;
	Mon,  9 Mar 2026 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RAAoLQef"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CDD33C18B;
	Mon,  9 Mar 2026 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091320; cv=none; b=ZtrR1BKvPMMRep5wy2m1Actj42HniZF5blgef8Yx0SniAnGo9hEF+MhL8bD5Hz/5l9SRzRzHHHRSDVgLFVqElji/e2sACcGiVO3Zm52BJDHx7+QhJnY+koJfsWvIL9773FmKZhYBM/YjJttK0et8nF4606ItG6JR6UMaCBXyqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091320; c=relaxed/simple;
	bh=k14W8w7kq2m9e99Lv1gKIw4BrO6iuzmuPK4RgYTfpNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PU+kjABZQL5AG2MnBmbanIe5L53zHmf02kAQ8BwatnwStQ+GwuiWduVN8tgAFS/x2hegxSB1qEDvbpAG+LvH5jodmS1R5WOsQW4WSOob1Zrva7isNnGgXBbgIsQs8oLCmfT0EUuHiHXyQkEz4eym4i/PUKjWUDqXqhxE/dIsDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RAAoLQef; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 6BB7320B7001; Mon,  9 Mar 2026 14:21:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BB7320B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773091319;
	bh=yKmLaS+MDTUl0J7jpvzKqcd8ps7dyEEAoJV0XwrsNN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAAoLQefjik7gZQUNCr7XOAnoMCwsMBofA0pzEVPhWS8/cvsr3Q3LFNpJ6K7bQx4v
	 xmdEzaps+4JHkv+i1KQl2iEkO11UNLe5gQxNG8UGNmg6e/pikhE6tQBBwzViaZpY/B
	 ISTDY6MLnpyQMeL9UnHMB9UtFNYrkZehesuHdBLc=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: paulros@microsoft.com
Subject: [PATCH net-next,V4, 3/3] net: mana: Add ethtool counters for RX CQEs in coalesced type
Date: Mon,  9 Mar 2026 14:20:45 -0700
Message-ID: <20260309212106.764156-4-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260309212106.764156-1-haiyangz@linux.microsoft.com>
References: <20260309212106.764156-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30329241A86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-9201-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Haiyang Zhang <haiyangz@microsoft.com>

For RX CQEs with type CQE_RX_COALESCED_4, to measure the coalescing
efficiency, add counters to count how many contains 2, 3, 4 packets
respectively.
Also, add a counter for the error case of first packet with length == 0.

Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 21 ++++++++++++++++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    | 15 +++++++++++--
 include/net/mana/mana.h                       |  9 +++++---
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index fa30046dcd3d..85f7a56d0d90 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2148,11 +2148,23 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 		old_buf = NULL;
 		pktlen = oob->ppi[i].pkt_len;
 		if (pktlen == 0) {
-			if (i == 0)
+			/* Collect coalesced CQE count based on packets processed.
+			 * Coalesced CQEs have at least 2 packets, so index is i - 2.
+			 */
+			if (i > 1) {
+				u64_stats_update_begin(&rxq->stats.syncp);
+				rxq->stats.coalesced_cqe[i - 2]++;
+				u64_stats_update_end(&rxq->stats.syncp);
+			} else if (i == 0) {
+				/* Error case stat */
+				u64_stats_update_begin(&rxq->stats.syncp);
+				rxq->stats.pkt_len0_err++;
+				u64_stats_update_end(&rxq->stats.syncp);
 				netdev_err_once(
 					ndev,
 					"RX pkt len=0, rq=%u, cq=%u, rxobj=0x%llx\n",
 					rxq->gdma_id, cq->gdma_id, rxq->rxobj);
+			}
 			break;
 		}
 
@@ -2175,6 +2187,13 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 		if (!coalesced)
 			break;
 	}
+
+	/* Coalesced CQE with all 4 packets */
+	if (coalesced && i == MANA_RXCOMP_OOB_NUM_PPI) {
+		u64_stats_update_begin(&rxq->stats.syncp);
+		rxq->stats.coalesced_cqe[MANA_RXCOMP_OOB_NUM_PPI - 2]++;
+		u64_stats_update_end(&rxq->stats.syncp);
+	}
 }
 
 static void mana_poll_rx_cq(struct mana_cq *cq)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 4b234b16e57a..6a4b42fe0944 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -149,7 +149,7 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
 	unsigned int num_queues = apc->num_queues;
-	int i;
+	int i, j;
 
 	if (stringset != ETH_SS_STATS)
 		return;
@@ -168,6 +168,9 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 		ethtool_sprintf(&data, "rx_%d_xdp_drop", i);
 		ethtool_sprintf(&data, "rx_%d_xdp_tx", i);
 		ethtool_sprintf(&data, "rx_%d_xdp_redirect", i);
+		ethtool_sprintf(&data, "rx_%d_pkt_len0_err", i);
+		for (j = 0; j < MANA_RXCOMP_OOB_NUM_PPI - 1; j++)
+			ethtool_sprintf(&data, "rx_%d_coalesced_cqe_%d", i, j + 2);
 	}
 
 	for (i = 0; i < num_queues; i++) {
@@ -201,6 +204,8 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	u64 xdp_xmit;
 	u64 xdp_drop;
 	u64 xdp_tx;
+	u64 pkt_len0_err;
+	u64 coalesced_cqe[MANA_RXCOMP_OOB_NUM_PPI - 1];
 	u64 tso_packets;
 	u64 tso_bytes;
 	u64 tso_inner_packets;
@@ -209,7 +214,7 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	u64 short_pkt_fmt;
 	u64 csum_partial;
 	u64 mana_map_err;
-	int q, i = 0;
+	int q, i = 0, j;
 
 	if (!apc->port_is_up)
 		return;
@@ -239,6 +244,9 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 			xdp_drop = rx_stats->xdp_drop;
 			xdp_tx = rx_stats->xdp_tx;
 			xdp_redirect = rx_stats->xdp_redirect;
+			pkt_len0_err = rx_stats->pkt_len0_err;
+			for (j = 0; j < MANA_RXCOMP_OOB_NUM_PPI - 1; j++)
+				coalesced_cqe[j] = rx_stats->coalesced_cqe[j];
 		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
 
 		data[i++] = packets;
@@ -246,6 +254,9 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 		data[i++] = xdp_drop;
 		data[i++] = xdp_tx;
 		data[i++] = xdp_redirect;
+		data[i++] = pkt_len0_err;
+		for (j = 0; j < MANA_RXCOMP_OOB_NUM_PPI - 1; j++)
+			data[i++] = coalesced_cqe[j];
 	}
 
 	for (q = 0; q < num_queues; q++) {
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index a7f89e7ddc56..3336688fed5e 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -61,8 +61,11 @@ enum TRI_STATE {
 
 #define MAX_PORTS_IN_MANA_DEV 256
 
+/* Maximum number of packets per coalesced CQE */
+#define MANA_RXCOMP_OOB_NUM_PPI 4
+
 /* Update this count whenever the respective structures are changed */
-#define MANA_STATS_RX_COUNT 5
+#define MANA_STATS_RX_COUNT (6 + MANA_RXCOMP_OOB_NUM_PPI - 1)
 #define MANA_STATS_TX_COUNT 11
 
 #define MANA_RX_FRAG_ALIGNMENT 64
@@ -73,6 +76,8 @@ struct mana_stats_rx {
 	u64 xdp_drop;
 	u64 xdp_tx;
 	u64 xdp_redirect;
+	u64 pkt_len0_err;
+	u64 coalesced_cqe[MANA_RXCOMP_OOB_NUM_PPI - 1];
 	struct u64_stats_sync syncp;
 };
 
@@ -227,8 +232,6 @@ struct mana_rxcomp_perpkt_info {
 	u32 pkt_hash;
 }; /* HW DATA */
 
-#define MANA_RXCOMP_OOB_NUM_PPI 4
-
 /* Receive completion OOB */
 struct mana_rxcomp_oob {
 	struct mana_cqe_header cqe_hdr;
-- 
2.34.1


