Return-Path: <linux-hyperv+bounces-8462-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMH+Ij9vcmlpkwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8462-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:41:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9A6C92F
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88D003007F51
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 18:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315183859E0;
	Thu, 22 Jan 2026 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="WodppWPD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6299E38170B;
	Thu, 22 Jan 2026 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107259; cv=none; b=PMml0A+tv6HT9vfLuXShEFjMZ4jNyaSrCOWCT5t0Yfn5BOMYJRm1W1Egse3FPcbBXBS6TqfVIhYgggRkC8CkZi2+H24KEv7UaztWzsjGh/fnV35BG512SG3JWsG1LGJ0JiJ+ohKd69jI0uA2tWbIQshRDWlbfk9tjle3XfKm2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107259; c=relaxed/simple;
	bh=bJbfYoi9ePT6GJvQe190QXenIvJlnJbG5gCYyHOYLyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uW5qMuRdPp1VuqNrdG4wzbmHyoCvKPRK6LUWdegHLbPTEWiETwhrondFMin3Z01Gl0K+eaeIMeDhQcBCSrZjUGzD/HcQLEjQKM6TBUN2Hka/2nK7DJ3q74qXH+yK2IiscubKdCP3zRON1WcwR/M4FIQG1prqebgJFYV/PCg054M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=WodppWPD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=0dc9BpwHRAb/FF2L8Jh14J11cIizVUqlWjJq5crcpt8=; b=WodppWPDGvQoSvmTSV/LYo/1x1
	oPYD2IuzgCuw4P69kDavqHdfvpctFPByvZtA234oczQckfVfcKJI3d+2gN+yUVXerCG/Z6UHOyxai
	Fw6jnDFEkyR64oosT3ZgUXdw9FYeBKbzmXATf6pXTb67luUmUdj4fBMJBvhrB+8T7V+ECI4Wya0mR
	/9lzHsXI69rzbQSFVESY9f3w3r+4qqFyLaZUuXcN9Mym0zXSLlTOjb8DvvmvQlIk+YQdVvMMfKvwy
	PMr3vw7QjIewDdxrXqkOO+Sz5kDyBsUw47APZHrJbYcIXcwHV69gzIYaBdFHT3x+JwGhaGx4mlnE8
	fd9cPYkg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vizbt-00DE0H-1f; Thu, 22 Jan 2026 18:40:49 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 10:40:13 -0800
Subject: [PATCH net-next v2 1/9] net: benet: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-grxring_big_v4-v2-1-94dbe4dcaa10@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=leitao@debian.org;
 h=from:subject:message-id; bh=bJbfYoi9ePT6GJvQe190QXenIvJlnJbG5gCYyHOYLyw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcm8k2+B4mcM/copQUAEtONk0z4PoFFju/fIp1
 /wqToeN7ZaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXJvJAAKCRA1o5Of/Hh3
 bd/kEACG4XJSOpexSFU2ks+thmqBCYwrNy4E+RWz1hvm9+j1KaUGS4KMNmPZMa0l2IpFbRWzzSU
 EYZYQjLapSLNta3vKOlDK4BtOVDe6UFxJ5Qh1DgyMRquZ9RwPm4R9Pzkahl/xBywg3J2dLSNJy6
 xchXSZqo7P5MlcA88oNElxEOGA7sp8YlOXYgxYFCjd8NlXXg8uO0Zk3n5VElkW5NNSfVUFpFl9g
 2UYcV37k58ah+igyBLyuU06caavBJOjyhp9nCLj0vpmAuYZtgQBplvobd52hgM6uj/a/0XOEFd4
 09wEzImFn79Rg/sC6Uc47LLsdjc64ynJzg3mYin9sRdwzHSkgW2oSjHCkYSuZFb3bfUb8eDnTrr
 KSUz5/S9q1EVS2Vt+hG1sm3AI3zmRBkTPT0RIw6sfi1BICUWun7cs51BlwwhcW1leaX8dtTHrDI
 dWHAo4lYAKx7iPMH/QxtHOzZOk/eV8If+RdfpHXYKfkDoarHnAkgJXmr7fhAF8CN9+3FY7z+6iN
 HIfqsWjbKl11/xKZArJO2CP2O1V5gQ1ZNXaRUNu+3zBL4O2W+Md4Pvm6GMu8+pgHifx5wy87Diq
 oX68R37KzFmytpFG1jyp3Kzkre8NjvWKsGbKh9hL/o4frmCkSN3f7jmNooYShtCFpm33hDR8tNl
 GJgX1GRHvteCskA==
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	TAGGED_FROM(0.00)[bounces-8462-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 11F9A6C92F
X-Rspamd-Action: no action

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Since ETHTOOL_GRXRINGS was the only command handled by be_get_rxnfc(),
remove the function entirely.

Since the be_multi_rxq() check in be_get_rxnfc() previously blocked RSS
configuration on single-queue setups (via ethtool core validation), add
an equivalent check to be_set_rxfh() to preserve this behavior, as
suggested by Jakub.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/emulex/benet/be_ethtool.c | 37 ++++++++++----------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index f55f1fd5d90fd..87dbbd5b7f4e6 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -1073,6 +1073,13 @@ static void be_set_msg_level(struct net_device *netdev, u32 level)
 	adapter->msg_enable = level;
 }
 
+static u32 be_get_rx_ring_count(struct net_device *netdev)
+{
+	struct be_adapter *adapter = netdev_priv(netdev);
+
+	return adapter->num_rx_qs;
+}
+
 static int be_get_rxfh_fields(struct net_device *netdev,
 			      struct ethtool_rxfh_fields *cmd)
 {
@@ -1117,28 +1124,6 @@ static int be_get_rxfh_fields(struct net_device *netdev,
 	return 0;
 }
 
-static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
-			u32 *rule_locs)
-{
-	struct be_adapter *adapter = netdev_priv(netdev);
-
-	if (!be_multi_rxq(adapter)) {
-		dev_info(&adapter->pdev->dev,
-			 "ethtool::get_rxnfc: RX flow hashing is disabled\n");
-		return -EINVAL;
-	}
-
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_qs;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int be_set_rxfh_fields(struct net_device *netdev,
 			      const struct ethtool_rxfh_fields *cmd,
 			      struct netlink_ext_ack *extack)
@@ -1293,6 +1278,12 @@ static int be_set_rxfh(struct net_device *netdev,
 	u8 *hkey = rxfh->key;
 	u8 rsstable[RSS_INDIR_TABLE_LEN];
 
+	if (!be_multi_rxq(adapter)) {
+		dev_info(&adapter->pdev->dev,
+			 "ethtool::set_rxfh: RX flow hashing is disabled\n");
+		return -EINVAL;
+	}
+
 	/* We do not allow change in unsupported parameters */
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
@@ -1441,7 +1432,7 @@ const struct ethtool_ops be_ethtool_ops = {
 	.get_ethtool_stats = be_get_ethtool_stats,
 	.flash_device = be_do_flash,
 	.self_test = be_self_test,
-	.get_rxnfc = be_get_rxnfc,
+	.get_rx_ring_count = be_get_rx_ring_count,
 	.get_rxfh_fields = be_get_rxfh_fields,
 	.set_rxfh_fields = be_set_rxfh_fields,
 	.get_rxfh_indir_size = be_get_rxfh_indir_size,

-- 
2.47.3


