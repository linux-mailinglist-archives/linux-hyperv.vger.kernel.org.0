Return-Path: <linux-hyperv+bounces-8464-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJcJAmlvcmlpkwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8464-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:41:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 600AB6C97C
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4731D300A133
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7EC3859D9;
	Thu, 22 Jan 2026 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fkJE1Adb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA08381713;
	Thu, 22 Jan 2026 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107270; cv=none; b=ffOzYZxscC6zRfxQHPFr3Y9LdRuckXAlhp4OMLjMUc6+1l2Sk55nZjzQLSWkpQWn3XPYXJapvaZ98m83kdgpwb6FI5BYAI3LrtKwK2kRD1Uj0FL4NBcWfWQ6vf7ONm716u9pb/YrwKIaiR299RLC/ZNkk2K+1FMPKeNqBH7oIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107270; c=relaxed/simple;
	bh=OKbGb+qTrd7mgSuZ+uguuxpL+ep+/TBEvmLlF+53LxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lY10lmw86UvbGy6d0OqWTKkCXlv3xOcH86aGaLSNLqdT7lC5TP56HjPEj9TbdT3H1sQTdLX9h16nqmTJAV8ICIqH4+w8K+KTq0rxk1ub+CxcI54sV8r0AsKbyVIjulfrP/KtzWreCaEf/pxS2so0rTzct3aAqM9IEmsk4p4ar+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fkJE1Adb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=XD2UTz5oPmh8TXyMBvF/w2pVWzLX0Zi6SpoC7dDXlfY=; b=fkJE1AdbtL0hrCieGHVW4Dqi+f
	7YTSSfELrVl9gxm2CMWzrToiXHdOjphia9ZzP6QCOpdUUy5o4nAVkAPGSP06lJ1PpDfYDPXEJb1Zo
	I2Y/lc42kAk/3/vmSNhmIASr51C0uwdd/IjmSjtqhuBchDpr/KH/XTxpSGplB97/l70W+1pppuJZb
	bxjPvZ7r/qCTygd9bDwbxWYSW5xjQSs9YPdM1WG0HkDG8sg8/Cx1PW8Wy2QZzMW3m7yF/hOQcvkk0
	3ditwGsYst+1XKxila13YWGZM1wyEpA6++Zq8iySUQa1ndy+LfNDnoM/IsjpzIuMBQMfihjcExIWC
	9bu2lNIQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vizc4-00DE0l-FJ; Thu, 22 Jan 2026 18:41:00 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 10:40:15 -0800
Subject: [PATCH net-next v2 3/9] net: nfp: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-grxring_big_v4-v2-3-94dbe4dcaa10@debian.org>
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
 linux-net-drivers@amd.com, Breno Leitao <leitao@debian.org>, 
 Subbaraya Sundeep <sbhatta@marvell.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=leitao@debian.org;
 h=from:subject:message-id; bh=OKbGb+qTrd7mgSuZ+uguuxpL+ep+/TBEvmLlF+53LxA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcm8kGSg4mxjaQVxW5sCIoyLw+Ucz/Rvvk9zsD
 xchsU7W8X6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXJvJAAKCRA1o5Of/Hh3
 bQg5D/9xkqgE2hwe2CRiSoJId83kWO5WFcX3mwMiJAh6J9+bEMF8G9lacbkU2LCpoNDqM7PF3u8
 SRGIX92RNGXa/n0z+MLdAxGy0BITb5+1Tru8e0JwDWIJi4IG+emgijgt1A6PwSH3IbizM6bYJQW
 0yUQEbMfXnNc14rrPxAGrGS2VjZ7AcLj411/PGP6QNVjBJnVDnHfQW6Yiv55aW+OQOEhezB8GZ+
 7uJq9W+TBr6dphKHiue2OFycFJ9KaaM6TiGYJX/FM28WWs2rPEbaRANDAwxjz0evHdywMucSQfc
 DUYQW/NRaguuO36EqQ+MHHnPQF1ri1hleyTjJB8L28jjD7rBhGdwxHKGhVI39isLB4+1er6/GCL
 DJ/qNcakdiQR1twtgR6+xGChCJs0XJTjhu5mX8WunnG/YShj+9E5tgUpbivdosGbKLLejb1fF8F
 072zUmgjmYGL4OKdcB3HajIbLOPGTsvzoIPzX2ps+960r32vzjtajfckP0quo+iwMRYcUykQF6R
 Xv2jVQhL5jeaevg25o/M2dNSiYPUt7TzcHXXVkDpDdMzp0/NbuKfgxc2ScsqxIZKjLQPPbdeQXX
 ikrFfieoos0zrD1MMBUD14VmYefBf8F6p7Lms7BrKtSEmoq8R99qcteh3nuuATQ6C9atGo2HKq7
 8E8QAYeX+8lIMSA==
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
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8464-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 600AB6C97C
X-Rspamd-Action: no action

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index 16c828dd5c1a3..e88b1c4732a57 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -1435,15 +1435,19 @@ static int nfp_net_get_fs_loc(struct nfp_net *nn, u32 *rule_locs)
 	return 0;
 }
 
+static u32 nfp_net_get_rx_ring_count(struct net_device *netdev)
+{
+	struct nfp_net *nn = netdev_priv(netdev);
+
+	return nn->dp.num_rx_rings;
+}
+
 static int nfp_net_get_rxnfc(struct net_device *netdev,
 			     struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = nn->dp.num_rx_rings;
-		return 0;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = nn->fs.count;
 		return 0;
@@ -2501,6 +2505,7 @@ static const struct ethtool_ops nfp_net_ethtool_ops = {
 	.get_sset_count		= nfp_net_get_sset_count,
 	.get_rxnfc		= nfp_net_get_rxnfc,
 	.set_rxnfc		= nfp_net_set_rxnfc,
+	.get_rx_ring_count	= nfp_net_get_rx_ring_count,
 	.get_rxfh_indir_size	= nfp_net_get_rxfh_indir_size,
 	.get_rxfh_key_size	= nfp_net_get_rxfh_key_size,
 	.get_rxfh		= nfp_net_get_rxfh,

-- 
2.47.3


