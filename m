Return-Path: <linux-hyperv+bounces-9180-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DfLN4hhq2mmcgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9180-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 00:21:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF4C228984
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 00:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 575793037C24
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 23:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15D7372B20;
	Fri,  6 Mar 2026 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JS6auZ8i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADD335F8D1;
	Fri,  6 Mar 2026 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839295; cv=none; b=eolJuUtNfQtth0qICUga3O447RI4/VNHqYNRG9Q1c5/UefJRQqszq5wMR0wdBbQsxYWpY547czWP6OEqcAXIiwK+O8ZnJ9QnWTt1nuoeyVKWxq1DgwoN8xpSQPgI8h4NZI4e2twD3lYOb3lue5cZBcQXRdA61yB759uehJh43A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839295; c=relaxed/simple;
	bh=lvQUW+PyK18JZuqCxlrRqa/m1Q9KOONbdgc+NIU47sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ij+wuCWXjxs865qkXDwHyasNylxv1lydK2wxK3WsddiPEHx41Ya5neTpBenHZA884WhH3fBEhPmDNBwyw+wbTkHbNtbcEuHNBLgu4RABIoMqe8z4w9oOPltV7LT8pkE8EZFQ8vpTV9jikNuL1D5ksxHXgCNriAnEDUORUqIg3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JS6auZ8i; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 8C37820B6F04; Fri,  6 Mar 2026 15:21:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C37820B6F04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772839294;
	bh=3/XsRpcYmpvhq1ikbTNjSxMJraaSEcj+53QhaLZ/+fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JS6auZ8iYsq/OY3aDJv4FDPFyj5Et7m6tbnbmvZapzbzC96yPZ95JX8w82sifsdwS
	 6PSEgc0yKHBW00F7w4YE/it89H5QCrnJMfm5rYuwGMetMj8lDSboWnPu6vXKYNlJ2l
	 w/rEWtJrSWF/+doie9wuIozDM1gRDC7pQ4yvx/DY=
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
Subject: [PATCH net-next,V3, 3/3] net: mana: Add ethtool counters for RX CQEs in coalesced type
Date: Fri,  6 Mar 2026 15:19:15 -0800
Message-ID: <20260306231936.549499-4-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260306231936.549499-1-haiyangz@linux.microsoft.com>
References: <20260306231936.549499-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7DF4C228984
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-9180-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
index c06fec50e51f..11ea2b17502d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2146,11 +2146,23 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 	for (i = 0; i < MANA_RXCOMP_OOB_NUM_PPI; i++) {
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
 
@@ -2173,6 +2185,13 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
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


