Return-Path: <linux-hyperv+bounces-9996-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBqoE17b0WnJPQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-9996-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 05 Apr 2026 05:47:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FAB39D43B
	for <lists+linux-hyperv@lfdr.de>; Sun, 05 Apr 2026 05:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F077300998E
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Apr 2026 03:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB8E1A073F;
	Sun,  5 Apr 2026 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kAgMqVx1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED32340DFD6;
	Sun,  5 Apr 2026 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775360858; cv=none; b=V7IqxPFF2YazPPW3gskyo5d039bbMbWtRPFTRSUJQiLr0SCKCO4AvAzO9N/ED9rQysaZAiVfJAV7cC3dy2P+y6HbUl3me7egJJArVoKb7jnubLugD9Vbneikpjm00AXuD0+us5w65lNo7cBC0pUaUVDzqjhGmPxE6yneeng7baI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775360858; c=relaxed/simple;
	bh=GE6Xqp35Q4safSXDXCWd6QGGmtmNjvwlFxfUS+p/2HE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p/+Lxmp1uQpq9ymjyAMd1uIo+rvC5dBa/m0sMKZlQFb7nSx9Tb95b1LxcK2waluSJ0zfQTHBaSfroZ5HdK0xG6hbUx9Q86v+F1/uDTtxe/t9cnr3xjK/6LQEElDosaND2Q77S3PvtVZ6Gc2DnmNdLNYFEwNP3PWb13n+QEOkYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kAgMqVx1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id A98DE20B6F01; Sat,  4 Apr 2026 20:47:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A98DE20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775360856;
	bh=QYs8uZsCpDirbEisT0uHXS5U6nK+4UiJEvZ1Irrd4YE=;
	h=Date:From:To:Subject:From;
	b=kAgMqVx1fTNdmGaILPmZPvgYnMVrSC5zxvsXvu1RZ8tXxi/MctqVQ0HerOvtgQziZ
	 Qyj8reiY7s+sLvLUXnt+tT4nvE9lFMzu34Z7y2vcwCevCicoIRMDgCa3SOlSA/7XQU
	 MeBJuGugqEiL9HfNdiXoaLSq7TH0M5UTa5i//7CI=
Date: Sat, 4 Apr 2026 20:47:36 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	jacob.e.keller@intel.com, dipayanroy@microsoft.com,
	leitao@debian.org, kees@kernel.org
Subject: [PATCH net-next v5 2/2] net: mana: force full-page RX buffers via
 ethtool private flag
Message-ID: <adHbWGh3DE0L2glq@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9996-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: B1FAB39D43B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On some ARM64 platforms with 4K PAGE_SIZE, page_pool fragment
allocation in the RX refill path can cause 15-20% throughput
regression under high connection counts (>16 TCP streams).

Add an ethtool private flag "full-page-rx" that allows the user to
force one RX buffer per page, bypassing the page_pool fragment path.
This restores line-rate (180+ Gbps) performance on affected platforms.

Usage:
  ethtool --set-priv-flags ethx full-page-rx on

There is no behavioral change by default. The flag must be explicitly
enabled by the user or udev rule.

The existing single-buffer-per-page logic for XDP and jumbo frames is
consolidated into a new helper mana_use_single_rxbuf_per_page() which
is now the single decision point for both the automatic and
user-controlled paths.

Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 22 ++++-
 .../ethernet/microsoft/mana/mana_ethtool.c    | 89 +++++++++++++++++++
 include/net/mana/mana.h                       |  8 ++
 3 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 49c65cc1697c..59a1626c2be1 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -744,6 +744,25 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
 	return va;
 }
 
+static bool
+mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
+{
+	/* On some platforms with 4K PAGE_SIZE, page_pool fragment allocation
+	 * in the RX refill path (~2kB buffer) can cause significant throughput
+	 * regression under high connection counts. Allow user to force one RX
+	 * buffer per page via ethtool private flag to bypass the fragment
+	 * path.
+	 */
+	if (apc->priv_flags & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF))
+		return true;
+
+	/* For xdp and jumbo frames make sure only one packet fits per page. */
+	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc))
+		return true;
+
+	return false;
+}
+
 /* Get RX buffer's data size, alloc size, XDP headroom based on MTU */
 static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 			       int mtu, u32 *datasize, u32 *alloc_size,
@@ -754,8 +773,7 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 	/* Calculate datasize first (consistent across all cases) */
 	*datasize = mtu + ETH_HLEN;
 
-	/* For xdp and jumbo frames make sure only one packet fits per page */
-	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
+	if (mana_use_single_rxbuf_per_page(apc, mtu)) {
 		if (mana_xdp_get(apc)) {
 			*headroom = XDP_PACKET_HEADROOM;
 			*alloc_size = PAGE_SIZE;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index a28ca461c135..0547c903f613 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -133,6 +133,10 @@ static const struct mana_stats_desc mana_phy_stats[] = {
 	{ "hc_tc7_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc7_phy) },
 };
 
+static const char mana_priv_flags[MANA_PRIV_FLAG_MAX][ETH_GSTRING_LEN] = {
+	[MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF] = "full-page-rx"
+};
+
 static int mana_get_sset_count(struct net_device *ndev, int stringset)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
@@ -144,6 +148,10 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
 		       ARRAY_SIZE(mana_phy_stats) +
 		       ARRAY_SIZE(mana_hc_stats)  +
 		       num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
+
+	case ETH_SS_PRIV_FLAGS:
+		return MANA_PRIV_FLAG_MAX;
+
 	default:
 		return -EINVAL;
 	}
@@ -192,6 +200,14 @@ static void mana_get_strings_stats(struct mana_port_context *apc, u8 **data)
 	}
 }
 
+static void mana_get_strings_priv_flags(u8 **data)
+{
+	int i;
+
+	for (i = 0; i < MANA_PRIV_FLAG_MAX; i++)
+		ethtool_puts(data, mana_priv_flags[i]);
+}
+
 static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
@@ -200,6 +216,9 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 	case ETH_SS_STATS:
 		mana_get_strings_stats(apc, &data);
 		break;
+	case ETH_SS_PRIV_FLAGS:
+		mana_get_strings_priv_flags(&data);
+		break;
 	default:
 		break;
 	}
@@ -590,6 +609,74 @@ static int mana_get_link_ksettings(struct net_device *ndev,
 	return 0;
 }
 
+static u32 mana_get_priv_flags(struct net_device *ndev)
+{
+	struct mana_port_context *apc = netdev_priv(ndev);
+
+	return apc->priv_flags;
+}
+
+static int mana_set_priv_flags(struct net_device *ndev, u32 priv_flags)
+{
+	struct mana_port_context *apc = netdev_priv(ndev);
+	u32 changed = apc->priv_flags ^ priv_flags;
+	u32 old_priv_flags = apc->priv_flags;
+	bool schedule_port_reset = false;
+	int err = 0;
+
+	if (!changed)
+		return 0;
+
+	/* Reject unknown bits */
+	if (priv_flags & ~GENMASK(MANA_PRIV_FLAG_MAX - 1, 0))
+		return -EINVAL;
+
+	if (changed & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF)) {
+		apc->priv_flags = priv_flags;
+
+		if (!apc->port_is_up) {
+			/* Port is down, flag updated to apply on next up
+			 * so just return.
+			 */
+			return 0;
+		}
+
+		/* Pre-allocate buffers to prevent failure in mana_attach
+		 * later
+		 */
+		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
+		if (err) {
+			netdev_err(ndev,
+				   "Insufficient memory for new allocations\n");
+			apc->priv_flags = old_priv_flags;
+			return err;
+		}
+
+		err = mana_detach(ndev, false);
+		if (err) {
+			netdev_err(ndev, "mana_detach failed: %d\n", err);
+			apc->priv_flags = old_priv_flags;
+			goto out;
+		}
+
+		err = mana_attach(ndev);
+		if (err) {
+			netdev_err(ndev, "mana_attach failed: %d\n", err);
+			apc->priv_flags = old_priv_flags;
+			schedule_port_reset = true;
+		}
+	}
+
+out:
+	mana_pre_dealloc_rxbufs(apc);
+
+	if (err && schedule_port_reset)
+		queue_work(apc->ac->per_port_queue_reset_wq,
+			   &apc->queue_reset_work);
+
+	return err;
+}
+
 const struct ethtool_ops mana_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_CQE_FRAMES,
 	.get_ethtool_stats	= mana_get_ethtool_stats,
@@ -608,4 +695,6 @@ const struct ethtool_ops mana_ethtool_ops = {
 	.set_ringparam          = mana_set_ringparam,
 	.get_link_ksettings	= mana_get_link_ksettings,
 	.get_link		= ethtool_op_get_link,
+	.get_priv_flags		= mana_get_priv_flags,
+	.set_priv_flags		= mana_set_priv_flags,
 };
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 3336688fed5e..fd87e3d6c1f4 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -30,6 +30,12 @@ enum TRI_STATE {
 	TRI_STATE_TRUE = 1
 };
 
+/* MANA ethtool private flag bit positions */
+enum mana_priv_flag_bits {
+	MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF = 0,
+	MANA_PRIV_FLAG_MAX,
+};
+
 /* Number of entries for hardware indirection table must be in power of 2 */
 #define MANA_INDIRECT_TABLE_MAX_SIZE 512
 #define MANA_INDIRECT_TABLE_DEF_SIZE 64
@@ -531,6 +537,8 @@ struct mana_port_context {
 	u32 rxbpre_headroom;
 	u32 rxbpre_frag_count;
 
+	u32 priv_flags;
+
 	struct bpf_prog *bpf_prog;
 
 	/* Create num_queues EQs, SQs, SQ-CQs, RQs and RQ-CQs, respectively. */
-- 
2.43.0


