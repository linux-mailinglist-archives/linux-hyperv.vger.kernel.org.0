Return-Path: <linux-hyperv+bounces-8469-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFibOWRwcmlpkwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8469-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:45:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 885BC6CA40
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B39BB303FFCF
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5790F36829F;
	Thu, 22 Jan 2026 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bNfNiXPB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44923859CB;
	Thu, 22 Jan 2026 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107318; cv=none; b=mXEir8V7z3tWpRQXfOE2tI5GAEJnZueY1Oz5N/Ju4ScQrT9GjbE2Uu3D585oMogiaon6HqJbMwYhAYXP0+AdELJPpviQ1fzyauGA0Qp42x9pYjXrKfs0ynr1CEIqpGriLP2wxsGsOqb2sZEl7SrouMhu9V7wkY7vh2XUGAg5cq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107318; c=relaxed/simple;
	bh=xjfGrJ9ogmU02tXh4UwJsiacW3KcvGXHd/h59cpJCJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EkRugySm1EJzmSX/k6LoALIn1YacEpd5OBtJ3SNkjPML/ibrOP1uu7u6f3QSB7OoJE2O1KEsbUEdJQ/VuVQAR87w8VcrRmikLlyMZssw/dy5wVqeiY+Nz4UsgRKrzhzQyE6UzM+6a8l40Bgzdala67VzoztB0F+b9fZOpKoAolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bNfNiXPB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=+Ieldrz0yCTZzK/huBW1mkitT5A3IA5rZUXCCnhdv+8=; b=bNfNiXPBqOd4lHTo+SwidUgz8T
	0uM096VXGUo0YE14qMLTSvNXpw6+k4SEqpmXs5pEEXMw+/vu1TEh0Fsit1iaQssibsDpJWP51H2Kn
	wZVqib+ZW3o2bupfS2PrAx0u7cu9gMJ57VRhMiOZsFMhiKk4A+VGiLJp93AHe/VlJMdZD1V6+Ezze
	DcbGz1CSntKWhMQEo5UED9mgzHXMidSIkgPVOtzUsYzbts7wUTQrpsNJZFqe5lJQPi2RTu69df4Yy
	OvAVY8hlFcZs0e4UBpGfm801N7DKQVcz9b9yhS1eZIViJgCVB133QJc+4LOfyMAWOIZ95dF7bk3IL
	oxhUOIiA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vizcX-00DE2W-Ib; Thu, 22 Jan 2026 18:41:29 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 10:40:20 -0800
Subject: [PATCH net-next v2 8/9] net: sfc: siena: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-grxring_big_v4-v2-8-94dbe4dcaa10@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2810; i=leitao@debian.org;
 h=from:subject:message-id; bh=xjfGrJ9ogmU02tXh4UwJsiacW3KcvGXHd/h59cpJCJU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcm8kwMgayWGZil65b7m91kTJjZMqKDCbx4NDa
 3ny/Yf0Sl6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXJvJAAKCRA1o5Of/Hh3
 bfEsD/9GFdvicyZuKksa/LMwMan8K3l2ul6AbpK+dk0soRUKMkhZOBa8M1Rs+GmAmMVY6kS0A7s
 B6n1MKjcxLSzkX2ZOcexcD3hEzx72woM8b8GU/sDHc97GDRyRnYNUPBWMnkM6Imim4TiUIz5oZa
 xdK2r4vYkFIlAQPvVlSGRZnDWf08/y8Yre4FD61jK3pJZbYCRDG9iMLQnLS9YQ3+x02YOKU8pvz
 WEAhRokUN2USk3qFyUsP8D/ACO/22I4d3fxiYTMCuDZ4dqJgS3uBMrgM7noyQxHdNehe74UGd/d
 CBVOTtTIXJzu5MBsveBv0yN/4u1uUKqXIm1cwFUlSxyHL62IhXtFG8XJTn0kQvHh8mtpN/+KoD+
 A327CRIZDiPv1CwuK8YAjYpGe8LTXjIZSIxPCDKqMYLdmrsumP//6N9lPC4jUXqVxrWe1DZKELI
 jDHDPpkYUVaai3BPUE4l0c0MrUxYi09HLfYAasVJC5csDgF6OcWAfsquYF6sJuOWZeYV21mujtG
 1jRwctHNQZhASgWtpElJI+muqrGM1Tmr2gtIe2WANfPVgdkMm8cJTIsuW0FNYB5ZmiyQvajLkH0
 AiC5zyhgnGryduqWCnB89Qr8/BqUBLwcNAKa/VWjZe1UkDMrdiJHGZbV6XKHqwjbOwliRquKN8r
 yoNTjNDZuw0nCgQ==
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
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8469-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 885BC6CA40
X-Rspamd-Action: no action

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/sfc/siena/ethtool.c        |  1 +
 drivers/net/ethernet/sfc/siena/ethtool_common.c | 11 +++++++----
 drivers/net/ethernet/sfc/siena/ethtool_common.h |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena/ethtool.c b/drivers/net/ethernet/sfc/siena/ethtool.c
index 8c3ebd0617fb1..36feedffe4444 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool.c
@@ -261,6 +261,7 @@ const struct ethtool_ops efx_siena_ethtool_ops = {
 	.reset			= efx_siena_ethtool_reset,
 	.get_rxnfc		= efx_siena_ethtool_get_rxnfc,
 	.set_rxnfc		= efx_siena_ethtool_set_rxnfc,
+	.get_rx_ring_count	= efx_siena_ethtool_get_rx_ring_count,
 	.get_rxfh_indir_size	= efx_siena_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_siena_ethtool_get_rxfh_key_size,
 	.get_rxfh		= efx_siena_ethtool_get_rxfh,
diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.c b/drivers/net/ethernet/sfc/siena/ethtool_common.c
index 47cd16a113cf1..c56e0b54d8541 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool_common.c
@@ -841,6 +841,13 @@ int efx_siena_ethtool_get_rxfh_fields(struct net_device *net_dev,
 	return 0;
 }
 
+u32 efx_siena_ethtool_get_rx_ring_count(struct net_device *net_dev)
+{
+	struct efx_nic *efx = netdev_priv(net_dev);
+
+	return efx->n_rx_channels;
+}
+
 int efx_siena_ethtool_get_rxnfc(struct net_device *net_dev,
 				struct ethtool_rxnfc *info, u32 *rule_locs)
 {
@@ -849,10 +856,6 @@ int efx_siena_ethtool_get_rxnfc(struct net_device *net_dev,
 	s32 rc = 0;
 
 	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = efx->n_rx_channels;
-		return 0;
-
 	case ETHTOOL_GRXCLSRLCNT:
 		info->data = efx_filter_get_rx_id_limit(efx);
 		if (info->data == 0)
diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.h b/drivers/net/ethernet/sfc/siena/ethtool_common.h
index 278d69e920d9f..7b445b0ba38aa 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool_common.h
+++ b/drivers/net/ethernet/sfc/siena/ethtool_common.h
@@ -37,6 +37,7 @@ int efx_siena_ethtool_set_fecparam(struct net_device *net_dev,
 				   struct ethtool_fecparam *fecparam);
 int efx_siena_ethtool_get_rxnfc(struct net_device *net_dev,
 				struct ethtool_rxnfc *info, u32 *rule_locs);
+u32 efx_siena_ethtool_get_rx_ring_count(struct net_device *net_dev);
 int efx_siena_ethtool_set_rxnfc(struct net_device *net_dev,
 				struct ethtool_rxnfc *info);
 u32 efx_siena_ethtool_get_rxfh_indir_size(struct net_device *net_dev);

-- 
2.47.3


