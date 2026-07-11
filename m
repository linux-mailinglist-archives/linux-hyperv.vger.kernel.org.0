Return-Path: <linux-hyperv+bounces-11941-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bLJSJGnDUWrCIQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11941-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 06:15:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7224740456
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 06:15:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=mnBHH7sY;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11941-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11941-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A40CE301C3F5
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 04:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13422FF66B;
	Sat, 11 Jul 2026 04:14:45 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9CA282F38;
	Sat, 11 Jul 2026 04:14:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783743285; cv=none; b=SlR6c/p9JjqQOJzp999Jg7QYSE2rZmIRxMkVnFIPpLRZgq/jw4d7Wrfs4SVcfbDCanGis0wQ6xlaE5/dp4Ger3JoLBLZKduVALiCVg2gaqXjU3XOd112spU/PBCdXDHCImN9i5yB7/WPunE53fcvtLPAfNOOZ+aeKxfkfKKJ//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783743285; c=relaxed/simple;
	bh=X7QJjvpvHjHpmWwuzRa5CsPYmJlLpSeLC9bJMVdAJCM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CejGaAvaR1ugsiG23lhbPZeKDWkCI5YVII1ec/6dSy39bCn4DidwY2uTKk4J0g/q7lQl/v8kWQ+ygnEejIZ1UP2Ejm0JkiOg6Y0nC+7SvnLJkEYH5djCgwF1sQ54TO0Wrts055wm9rXjtQ1eQG+M9Gjt0Zuuunwcm6KsPnM04zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mnBHH7sY; arc=none smtp.client-ip=13.77.154.182
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E60AE20B7179;
	Fri, 10 Jul 2026 21:14:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E60AE20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783743274;
	bh=u8EOU44g1FOdRu0Bw54fL30NJMc8hT6UXleCv4VS1+k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mnBHH7sYLx5C+iGfTLsA3EWKsEPX0ghFpuDWJHIK1mMZ1yAjGfT8ANstAQNGurO2Z
	 4hBRifwBw0SsJ0Etu4aMeNyCj86FI58/j+6USjzKb+wj8REJm2JNzhas2quDLqNumA
	 VUqT5G9n92F/j/DSanNl3zjx/I+Ej9OPOlXQ8r/8=
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stephen@networkplumber.org,
	jacob.e.keller@intel.com,
	dipayanroy@microsoft.com,
	leitao@debian.org,
	kees@kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	sdf@fomichev.me,
	yury.norov@gmail.com,
	pavan.chebbi@broadcom.com,
	schakrabarti@linux.microsoft.com,
	gargaditya@linux.microsoft.com
Subject: [PATCH net-next v12 3/4] net: mana: force full-page RX buffers via ethtool private flag
Date: Fri, 10 Jul 2026 21:10:23 -0700
Message-ID: <20260711041415.3008868-4-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260711041415.3008868-1-dipayanroy@linux.microsoft.com>
References: <20260711041415.3008868-1-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11941-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:ernis@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stephen@networkplumber.org,m:jacob.e.keller@intel.com,m:dipayanroy@microsoft.com,m:leitao@debian.org,m:kees@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:sdf@fomichev.me,m:yury.norov@gmail.com,m:pavan.chebbi@broadcom.com,m:schakrabarti@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,linux.microsoft.com:mid,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7224740456

On some ARM64 platforms with 4K PAGE_SIZE, page_pool fragment
allocation in the RX refill path can cause 15-20% throughput
regression under high connection counts (>16 TCP streams).

Add an ethtool private flag "full-page-rx" that allows the user to
force one RX buffer per page, bypassing the page_pool fragment path.
This restores line-rate (180+ Gbps) performance on affected platforms.

Usage:
  ethtool --set-priv-flags eth0 full-page-rx on

There is no behavioral change by default. The flag must be explicitly
enabled by the user or udev rule.

The existing single-buffer-per-page logic for XDP and jumbo frames is
consolidated into a new helper mana_use_single_rxbuf_per_page() which
is now the single decision point for both the automatic and
user-controlled paths.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c |  22 +++-
 .../ethernet/microsoft/mana/mana_ethtool.c    | 100 ++++++++++++++++++
 include/net/mana/mana.h                       |   8 ++
 3 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 5e3c7a2a2b49..3e5c52e4886b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -755,6 +755,25 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
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
@@ -765,8 +784,7 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 	/* Calculate datasize first (consistent across all cases) */
 	*datasize = mtu + ETH_HLEN;
 
-	/* For xdp and jumbo frames make sure only one packet fits per page */
-	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
+	if (mana_use_single_rxbuf_per_page(apc, mtu)) {
 		if (mana_xdp_get(apc)) {
 			*headroom = XDP_PACKET_HEADROOM;
 			*alloc_size = PAGE_SIZE;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 482cd16009ab..f77509818d07 100644
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
@@ -756,6 +775,84 @@ static int mana_get_link_ksettings(struct net_device *ndev,
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
+	apc->priv_flags = priv_flags;
+
+	if (changed & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF)) {
+		if (!apc->port_is_up)
+			return 0;
+
+		/* If XDP is attached or MTU is jumbo, single-buffer-per-page
+		 * is already forced regardless of this flag. Skip the
+		 * expensive detach/attach cycle since nothing changes.
+		 */
+		if (ndev->mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 ||
+		    mana_xdp_get(apc))
+			return 0;
+
+		/* Block RDMA from grabbing the vport during detach/attach */
+		mutex_lock(&apc->vport_mutex);
+		apc->channel_changing = true;
+		mutex_unlock(&apc->vport_mutex);
+
+		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
+		if (err) {
+			netdev_err(ndev,
+				   "Insufficient memory for new allocations\n");
+			apc->priv_flags = old_priv_flags;
+			goto clear_flag;
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
+clear_flag:
+	mutex_lock(&apc->vport_mutex);
+	apc->channel_changing = false;
+	mutex_unlock(&apc->vport_mutex);
+
+	if (schedule_port_reset)
+		queue_work(apc->ac->per_port_queue_reset_wq,
+			   &apc->queue_reset_work);
+
+	return err;
+}
+
 const struct ethtool_ops mana_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_CQE_FRAMES |
 				     ETHTOOL_COALESCE_RX_USECS |
@@ -766,6 +863,7 @@ const struct ethtool_ops mana_ethtool_ops = {
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_TX,
 	.op_needs_rtnl		= ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
 				  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
+				  ETHTOOL_OP_NEEDS_RTNL_SPFLAGS |
 				  ETHTOOL_OP_NEEDS_RTNL_GLINK,
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
@@ -783,4 +881,6 @@ const struct ethtool_ops mana_ethtool_ops = {
 	.set_ringparam          = mana_set_ringparam,
 	.get_link_ksettings	= mana_get_link_ksettings,
 	.get_link		= ethtool_op_get_link,
+	.get_priv_flags		= mana_get_priv_flags,
+	.set_priv_flags		= mana_set_priv_flags,
 };
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 226b61504596..768d9f9bf167 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -31,6 +31,12 @@ enum TRI_STATE {
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
@@ -565,6 +571,8 @@ struct mana_port_context {
 	u32 rxbpre_headroom;
 	u32 rxbpre_frag_count;
 
+	u32 priv_flags;
+
 	struct bpf_prog *bpf_prog;
 
 	/* Create num_queues EQs, SQs, SQ-CQs, RQs and RQ-CQs, respectively. */
-- 
2.43.0


