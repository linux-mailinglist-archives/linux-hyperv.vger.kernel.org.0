Return-Path: <linux-hyperv+bounces-8467-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOL6DuRvcmnZkwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8467-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:43:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D96C9E0
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6071301DE39
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 18:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993BA3859D0;
	Thu, 22 Jan 2026 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="D5eBdvVm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5906837FF61;
	Thu, 22 Jan 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107292; cv=none; b=rRVY/8fo+rzYfD3UK7eSdy15/B16UPOlvBAMJgSDPDO5ZJvQfB6YfY/4CdQw/E/vO3XH6szADpZORt/mfEpJx/J7WMgL5HLlturrEFg2QQvHliyEN1DkDxTWKQIMO+x8LfFF8V3w/BdH81MQ7RR3/HjMDZlh7CgUlOuNX04gfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107292; c=relaxed/simple;
	bh=mMx0aIPpyYJ0H01ZGMQAA+ncQnIVJMLNwVGdNwLKfmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPSMifWCWMFmI8k6fqQ9rKdm/9fyjmyxbxU5TzpjLmrro/+nHaCFF5r5wYH38iwM0PsYiArjJ/t1j5cb8uIDd2dYWZyLuTMCblCoxJXYuHyLhVSg1qdfbD+CpDO6e5SkJI+mstvdTHvVowAkz4XG5AxVi/3kNG/37BO+kraCc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=D5eBdvVm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=K5z6kZHNlZ4qDFaNpaW1u+BLQ1VLld41mAaOnnhvfhg=; b=D5eBdvVmdSSe7qBg2iVil6Exai
	ex/rdNB5OyuFEh/xkFCMa9vC9cUr26UJ6IBaCn974eLSaidOzsqDJCnRa6Otf57XSQBsPOOWN/Zr5
	6ayZBUJ8cCNVJ3SWJC4nYqd6NdnYBmho/+pi2pxgBjZDg0bnmaiz/D9lnl7+dT3ZXzHsFEh36ASmC
	9TsAHJR/RjYcR4DI4pMKqrNDWR2J5zwFcg7EPCfkVJdVYtKLqVxnNNSFDepxEqtHzW9E3ez2yo0Fd
	z/zesaTltBJf59ybsNXPJHGvKLShkaZGl2tws5nsAJ5FJwBtVLg/9GC4GEciel7s6zA4FBTBMpLZY
	S0331+ZQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vizcA-00DE17-5a; Thu, 22 Jan 2026 18:41:06 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 10:40:16 -0800
Subject: [PATCH net-next v2 4/9] net: mana: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-grxring_big_v4-v2-4-94dbe4dcaa10@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=leitao@debian.org;
 h=from:subject:message-id; bh=mMx0aIPpyYJ0H01ZGMQAA+ncQnIVJMLNwVGdNwLKfmc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcm8k7ZhZGf3/4AH5Gg6x772N/1BkpYBTWimTH
 2xvENpY9PCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXJvJAAKCRA1o5Of/Hh3
 bd1bEACSRqL2pxbGTSGnFk82oEgpfRBnFsFkkBQkID0vM0ntGMtIba4SGj+ghDsKOeLW56L/ZOP
 RKTpfPQtFeHOdO4y6U9+HsCk1DO3sj6ugmtELYvjg7GQwKO7dsJ+gidXzNAyjEviy7ZFC5lwjuw
 9oX1QJJHPsRhgwe55yfxJ9/Mr97OLTi6y7Mn9ScFWcjPHG1M2gVlrotpVbagC3SBHOskSGRzWgp
 dDBNlLFBJKVMXV9EzTQGlPXobxfMFQDUtp/MA2Tlh3xaKGrAd2fbXHajpnS2736VjIvZ+oj6p75
 0H1i7bY03+S0FTQ6c2QzLAuH2shFAWSSjNBjtb1PbT7vLOhMuXkeaji4QQdETqpKlKsqLdn/LJb
 PKY0YjZ4xR9yCdFxyNuoypBboza0Dkh8UCA8+lYWomCGZ0jwsvUbLl47EzLzhf7WDlr6UdaBzL7
 nXCR3WhXZW2/UUxRXiKQT9fDsUnpQdOLxeqEMwabblO2Hln3ievFNRzRXg1v9xazIZkRG5FtBGd
 /jGUm5YopuuFCfRQO7QGBI3kV05byxVYehc740OvA49uAPFvH7nO/fHYZJDLhWZRFdezBiLpGXG
 6nUYSL6i19l9e3B9cXVybka5o2oXSHLR5+ziC/42P973vPg9V93ewHYFEKXvNDqyV2VJ9nVlSTT
 UYrHqLCZoTBPWLg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-8467-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: C23D96C9E0
X-Rspamd-Action: no action

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Since ETHTOOL_GRXRINGS was the only command handled by mana_get_rxnfc(),
remove the function entirely.

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 0e2f4343ac67f..f2d220b371b5d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -282,18 +282,11 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	}
 }
 
-static int mana_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *cmd,
-			  u32 *rules)
+static u32 mana_get_rx_ring_count(struct net_device *ndev)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
 
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = apc->num_queues;
-		return 0;
-	}
-
-	return -EOPNOTSUPP;
+	return apc->num_queues;
 }
 
 static u32 mana_get_rxfh_key_size(struct net_device *ndev)
@@ -520,7 +513,7 @@ const struct ethtool_ops mana_ethtool_ops = {
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
 	.get_strings		= mana_get_strings,
-	.get_rxnfc		= mana_get_rxnfc,
+	.get_rx_ring_count	= mana_get_rx_ring_count,
 	.get_rxfh_key_size	= mana_get_rxfh_key_size,
 	.get_rxfh_indir_size	= mana_rss_indir_size,
 	.get_rxfh		= mana_get_rxfh,

-- 
2.47.3


