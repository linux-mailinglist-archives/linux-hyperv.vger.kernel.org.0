Return-Path: <linux-hyperv+bounces-8468-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJWuFV9wcmlpkwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8468-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:45:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A52466CA32
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1C3B303F04D
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BE83783DB;
	Thu, 22 Jan 2026 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cXwHMWjO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A73859C7;
	Thu, 22 Jan 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107311; cv=none; b=G3aJuTyK0TUrVFmypG/IKwlNNKtarDc0O7KX9TBJkTjWgrAI3thXGV3jqVSsHGfAJpxjDTj/rHcRggWldBH4O9PSigcPEqOvTaQK/7BPFeP58huy8OxvtMO//K94pnpUGuMsHfwtlBDBspx2tDt6QHz68g1mcnVrsdOogWZ1AXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107311; c=relaxed/simple;
	bh=xqDRg42cn9s+PQJV3QJKXzwsDuQzgQ88O7+U4GmtgGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6UYZGhBCMf18LgAuKCco4IcQg/CwuxfX9az7y62NJI+aRxRxjVYFw5Cc+RUsrtkCjRPti5VGgOdQgMtk2Af5byWTmwSxDUV1mot8k/GdApXLDL1YOKR3MmQZRd37aHDGYNtcCOx1dyi+ofyY8JWgpHvXx6L/pInDnm6XRT/gxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cXwHMWjO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=yFPLZuBBqgdNTKRLDjxt0gL81wNcNDScS38n9r2rPKI=; b=cXwHMWjOm2oEhkNAPnQNLncQOK
	IbzQGv9QHEcU7F+A0JLGARqBMP+TjTf27DERgtvH455obdEe4YZo39JrFjco4MtS5pOPKQJBQtwOJ
	DGSoHp6b/rBoKwEF6XdFTidjwwGEZIVgIseWlL1Nuzt+tdCa+MTZZIL9bCGHmUpCYq9XRnZbrKfix
	CrCztLjStvIfETNqZUYy06fNR3QyRCN5BDiFkB/aAKFg3qltAjTmyri/UltYFW1tfFvcjMGT0WYIf
	q4/ALOZQkua15laKIgs0K8N7hYdjnsriKFj+6r+Nhl+2IKS3o9h7GSwKH5mTRXXD9uP6QcPXwhnqz
	fBisX80w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vizcR-00DE26-CJ; Thu, 22 Jan 2026 18:41:23 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 10:40:19 -0800
Subject: [PATCH net-next v2 7/9] net: sfc: efx: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-grxring_big_v4-v2-7-94dbe4dcaa10@debian.org>
References: <20260122-grxring_big_v4-v2-0-94dbe4dcaa10@debian.org>
In-Reply-To: <20260122-grxring_big_v4-v2-0-94dbe4dcaa10@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
 linux-net-drivers@amd.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3292; i=leitao@debian.org;
 h=from:subject:message-id; bh=xqDRg42cn9s+PQJV3QJKXzwsDuQzgQ88O7+U4GmtgGA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcm8k2zH1hNIRx9gt6FzGD69x/pKtOG+BPB2RL
 7pnd4lsxuyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXJvJAAKCRA1o5Of/Hh3
 bfR/EACpjiHLVOIMBpWzjxFrlLEJAP011LzkGj+DHLfV2S9dBjWYs0pzbrZQ43umUl4/RkOrnIn
 WPwSu4+KKDlj4UMZUZ2GP2OyITqvJY5MS9U7nbrtzvXgWusDf/UMI0AZ8zxW2E+xx4/xCXha2F0
 dzqqwuzvd7zLaMEmr1332fap1yqzt/9X3SwvPWFOwCaKpKsO8GRie0PV+dqMDy2kDSST+E7gxoN
 9w+7F0oNCg8eBBhXugRysLKMhV4LkqKEHaRy1dVQJRKAATx9LvDXG/jBe4qCc10Ps2515oQ3JTb
 m2d2lPQr8xHtOrTGU+MkFJnkB5seOtgBiPxk602RgW/PIaXdcQuzmDqwvZRNatU7fNblgfErEV9
 nPIr1vr2v9oE1oqxydOdGYOHON473MWbPhI3ZzR0KGj6EeVSO+r62/9dRt2EaErPR6UnO96IsR2
 lCrO0+N3m39SXg8p6CBDVhh9Aj1MIUC3TnpDa4fcq/vHUi2ceMK4eWppVJ8hWB5MQU6ozsMk8Al
 PsvACpFPCXvIDTx9bi5FC1tHHNKIaT4NW/uzmJUndRYPquq71jUjMzS5TrzkGiw+F6WMFbmk/r9
 0AwyLVNo8HkYGSpqLHUvYwtyKX0+004GYd2uVY4o3cZNxiAn1J4BuUh90arm7Ex2HZhHwXHfs+V
 CRvTQSNMrs2iTPw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8468-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A52466CA32
X-Rspamd-Action: no action

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/sfc/ef100_ethtool.c  |  1 +
 drivers/net/ethernet/sfc/ethtool.c        |  1 +
 drivers/net/ethernet/sfc/ethtool_common.c | 11 +++++++----
 drivers/net/ethernet/sfc/ethtool_common.h |  1 +
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef100_ethtool.c b/drivers/net/ethernet/sfc/ef100_ethtool.c
index 6c3b74000d3b6..05dc7b10c8855 100644
--- a/drivers/net/ethernet/sfc/ef100_ethtool.c
+++ b/drivers/net/ethernet/sfc/ef100_ethtool.c
@@ -54,6 +54,7 @@ const struct ethtool_ops ef100_ethtool_ops = {
 	.get_ethtool_stats	= efx_ethtool_get_stats,
 	.get_rxnfc              = efx_ethtool_get_rxnfc,
 	.set_rxnfc              = efx_ethtool_set_rxnfc,
+	.get_rx_ring_count	= efx_ethtool_get_rx_ring_count,
 	.reset                  = efx_ethtool_reset,
 
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 18fe5850a9786..362388754a292 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -261,6 +261,7 @@ const struct ethtool_ops efx_ethtool_ops = {
 	.reset			= efx_ethtool_reset,
 	.get_rxnfc		= efx_ethtool_get_rxnfc,
 	.set_rxnfc		= efx_ethtool_set_rxnfc,
+	.get_rx_ring_count	= efx_ethtool_get_rx_ring_count,
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
 	.rxfh_per_ctx_fields	= true,
diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index fa303e171d98b..2fc42b1a2bfb7 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -850,6 +850,13 @@ int efx_ethtool_get_rxfh_fields(struct net_device *net_dev,
 	return rc;
 }
 
+u32 efx_ethtool_get_rx_ring_count(struct net_device *net_dev)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+
+	return efx->n_rx_channels;
+}
+
 int efx_ethtool_get_rxnfc(struct net_device *net_dev,
 			  struct ethtool_rxnfc *info, u32 *rule_locs)
 {
@@ -858,10 +865,6 @@ int efx_ethtool_get_rxnfc(struct net_device *net_dev,
 	s32 rc = 0;
 
 	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = efx->n_rx_channels;
-		return 0;
-
 	case ETHTOOL_GRXCLSRLCNT:
 		info->data = efx_filter_get_rx_id_limit(efx);
 		if (info->data == 0)
diff --git a/drivers/net/ethernet/sfc/ethtool_common.h b/drivers/net/ethernet/sfc/ethtool_common.h
index 24db4fccbe78a..f96db42534546 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.h
+++ b/drivers/net/ethernet/sfc/ethtool_common.h
@@ -40,6 +40,7 @@ int efx_ethtool_set_fecparam(struct net_device *net_dev,
 			     struct ethtool_fecparam *fecparam);
 int efx_ethtool_get_rxnfc(struct net_device *net_dev,
 			  struct ethtool_rxnfc *info, u32 *rule_locs);
+u32 efx_ethtool_get_rx_ring_count(struct net_device *net_dev);
 int efx_ethtool_set_rxnfc(struct net_device *net_dev,
 			  struct ethtool_rxnfc *info);
 u32 efx_ethtool_get_rxfh_indir_size(struct net_device *net_dev);

-- 
2.47.3


