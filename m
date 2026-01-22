Return-Path: <linux-hyperv+bounces-8470-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B62gOalvcmnZkwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8470-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:42:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB7A6C9B3
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC92C301DD9D
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F536AB5C;
	Thu, 22 Jan 2026 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MjVJRlKC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D81385EDB;
	Thu, 22 Jan 2026 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107318; cv=none; b=hxbARCQY/INwbihn+QYDktMae/cIRKktdXOe0zWmRo2GZ8Mf6BIU9/BXJTihfu/Dvv20rIy7FYVhYrBR+iwHB8LK9YrTGO2abTZ9yPE9q7ul5pkn+F3rXgs/OU1xXUNTE/+gCvJ8uRzPRCIR5GcTWRz+p3+w+B2eW1durt0bABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107318; c=relaxed/simple;
	bh=kqzS/7eXjKQG4xiemTDsmFZRs2ALv2BsjFw/ViIR5ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qcyv3WEWcelBCu8NcI75g0Bdf0owZcRfaoI5o32NbI9cLrAqQrNd7LUesAxLKWXCiUhAp6Wdf5Gp8kAMkp/HmLxaqv0aeFrz1PRev04hA/AcHj9SIAMlQZ0KZTi7s69wEsInaK4P4YAY5i+wmbe6eVbcILMbJLqWQoDNUWsvoXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MjVJRlKC; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=BvlsW4lqNl+1+09mnU3bYFr4itCF0ttr+C2yEDPsR5w=; b=MjVJRlKCGyZitSaGfubXNbCTR3
	JQWhQS/Jh0GMybhRRgIm6m1Wu0Fz7CUvg/mhRi82OWRUNIxyLNKEMmtLOxS5bMaxliitPSZJgtK7y
	DfzYT8idPV731aAGA/Hr8umsp0k3syVU3MSWhTk8YXXoN/OtA7leMGJ05vrBFRWo+lk+Wr+QXE4T2
	tZAnUdXWjrGlar7zyyQrNgND3JUwMjybc8zRWq1lFC73BznNynj9CsQ4qq8d/n8S7bXjmRMq2qGZX
	ZayB+D6jKt/Z8JjuOipgN2wXMSknQbLVlP9Qm59bot7C/Lh+SGsQ+BG+HYT2ufonsXtxDw4zoHVgJ
	bYqw5Nbw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vizcd-00DE2u-5u; Thu, 22 Jan 2026 18:41:35 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 10:40:21 -0800
Subject: [PATCH net-next v2 9/9] net: sfc: falcon: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-grxring_big_v4-v2-9-94dbe4dcaa10@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=leitao@debian.org;
 h=from:subject:message-id; bh=kqzS/7eXjKQG4xiemTDsmFZRs2ALv2BsjFw/ViIR5ug=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcm8lVobBKIKaWbL7Kss5QdFLbdCw83xm1pGqR
 Jhg6DdcOk2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXJvJQAKCRA1o5Of/Hh3
 bVgsEACbbq3yhlNMWTg6qovyWCNCsnQeGJQ1kp70ENZUKf6zzrXDEkDuUw87rbiYVXUFYdzRsEd
 oYipnvd5VN554x5zlGhZ0xkoy/aBtMYQLos6kNRW7Qf44a/Ugw1DAMXg3+65OIeio+NsMGlvu92
 FbzQIEj3XjSfNvZFhd+GvwRgpMxmqKzuQi2U1N7Zn3Wh2ForP8Hwcvd1t9jpq85Nb5oZCjXsxSW
 +b//phb6v0+GEInAZsQrfxM3YHrxXKVuC1e3NXd0SY8QtdKGD4dioZerHtZ4RH1yxcOAt0+6KFp
 q+2stGci5wPFkzwx39Q9nMn9v1C1GLdCxSzMO54/tQS2v/D3RSJ1Kf5Ivbp1bqYH8NVBmIV4koY
 GYMNi+C8i0jGCi/Vw59LxF4EwQV4TcDpFeOhPla/5EcgwzmnfA7NE4h8Vps20pzIMhvwX2aW1AX
 go7lj6/vaCbuuMe3ES5fUaTps6xJ+Sdm4KH4UihpC8/XKQ7RH3/HcqZoCFg9v5aHPFP3z0K3zff
 Cu0BCDRt8Ef7/gnZnvpnwdbxAhDd3rbRWAjqxf4HeRFwiXTH3x6A8dWxQw/+qQLms/zt8Pacl+5
 KW3+u6qol2KvXxlwoHsIX9wB2zCNMB0lsyJ5Ij048rRYEozpSZmqOg/awmvTaGL8WeSJsI+miIE
 ULO2KvsOGmHv0Qw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
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
	TAGGED_FROM(0.00)[bounces-8470-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EB7A6C9B3
X-Rspamd-Action: no action

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/sfc/falcon/ethtool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index 27d1cd6f24ca1..0493640315454 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -974,6 +974,13 @@ ef4_ethtool_get_rxfh_fields(struct net_device *net_dev,
 	return 0;
 }
 
+static u32 ef4_ethtool_get_rx_ring_count(struct net_device *net_dev)
+{
+	struct ef4_nic *efx = netdev_priv(net_dev);
+
+	return efx->n_rx_channels;
+}
+
 static int
 ef4_ethtool_get_rxnfc(struct net_device *net_dev,
 		      struct ethtool_rxnfc *info, u32 *rule_locs)
@@ -981,10 +988,6 @@ ef4_ethtool_get_rxnfc(struct net_device *net_dev,
 	struct ef4_nic *efx = netdev_priv(net_dev);
 
 	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = efx->n_rx_channels;
-		return 0;
-
 	case ETHTOOL_GRXCLSRLCNT:
 		info->data = ef4_filter_get_rx_id_limit(efx);
 		if (info->data == 0)
@@ -1348,6 +1351,7 @@ const struct ethtool_ops ef4_ethtool_ops = {
 	.reset			= ef4_ethtool_reset,
 	.get_rxnfc		= ef4_ethtool_get_rxnfc,
 	.set_rxnfc		= ef4_ethtool_set_rxnfc,
+	.get_rx_ring_count	= ef4_ethtool_get_rx_ring_count,
 	.get_rxfh_indir_size	= ef4_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= ef4_ethtool_get_rxfh,
 	.set_rxfh		= ef4_ethtool_set_rxfh,

-- 
2.47.3


