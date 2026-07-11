Return-Path: <linux-hyperv+bounces-11939-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G71tAkjDUWqyIQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11939-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 06:15:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AB074042D
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 06:15:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=F7EmHu22;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11939-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11939-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E39D4301FFB6
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232B02F39C7;
	Sat, 11 Jul 2026 04:14:45 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC2F29E116;
	Sat, 11 Jul 2026 04:14:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783743284; cv=none; b=cL4a9B75jq0dYdkNDHwDDl2KgP40/DiK0TgANXKY5JC0E3GYxfRmbUI1/Navgll2RMjqnzq/2SdjTLRb1lLSJkr7vPd+7lYCNSg8brBHTl/Sg5RgFASMFZAFO8VgiDiJggYcqkHTq9RQ4Na/UlZyc1BH1mLkOqOy6FEIM4zt0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783743284; c=relaxed/simple;
	bh=Y2ytEviYtuEfInxxVrHmxYK/yDakQ+T4iS/+B5gW8bs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu/MrrXoNAI2CPF2P/O+623TD1cTnO3TK0Qn7H7jIzg+xuNwHo8XTYtKVUpaAVfd+2rwGZ0e8rdHdzO8vwHpuPHf8b9pyWLnrBZAB4pXNMJBj7BsYKzALaRdxmCSE6PPwZaNVT/R2mmME29nQgxJLeOGkekd2b8UJg3Y47MG/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F7EmHu22; arc=none smtp.client-ip=13.77.154.182
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 14CE320B716F;
	Fri, 10 Jul 2026 21:14:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14CE320B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783743273;
	bh=Q7aELUN/m5GYjnuqRTtkZe028YJFzr253JFbIINDFFo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F7EmHu22NHGVGtKBTGf2P2dlqAzLXKnI9utnt+7YMYoWJaM8MK1+DqM699JDIOysZ
	 2beXYCLiU8Gle4mvQzuBAuRZlli+f+OPgT9E3N7QtPjsferspT035NMSmWEh5UkcwG
	 7GlyfJmy1QP5KkPBK5/FkSA74tX8W9R8RyZ22HUY=
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
Subject: [PATCH net-next v12 1/4] net: mana: refactor mana_get_strings() and mana_get_sset_count() to use switch
Date: Fri, 10 Jul 2026 21:10:21 -0700
Message-ID: <20260711041415.3008868-2-dipayanroy@linux.microsoft.com>
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
	TAGGED_FROM(0.00)[bounces-11939-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:from_mime,linux.microsoft.com:dkim,linux.microsoft.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64AB074042D

Refactor mana_get_strings() and mana_get_sset_count() from if/else to
switch statements in preparation for adding ethtool private flags
support which requires handling ETH_SS_PRIV_FLAGS.

No functional change.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 .../ethernet/microsoft/mana/mana_ethtool.c    | 75 ++++++++++++-------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 9e31e2595ae3..482cd16009ab 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -138,53 +138,70 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
 	struct mana_port_context *apc = netdev_priv(ndev);
 	unsigned int num_queues = apc->num_queues;
 
-	if (stringset != ETH_SS_STATS)
+	switch (stringset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(mana_eth_stats) +
+		       ARRAY_SIZE(mana_phy_stats) +
+		       ARRAY_SIZE(mana_hc_stats)  +
+		       num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
+	default:
 		return -EINVAL;
-
-	return ARRAY_SIZE(mana_eth_stats) + ARRAY_SIZE(mana_phy_stats) + ARRAY_SIZE(mana_hc_stats) +
-			num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
+	}
 }
 
-static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
+static void mana_get_strings_stats(struct mana_port_context *apc, u8 **data)
 {
-	struct mana_port_context *apc = netdev_priv(ndev);
 	unsigned int num_queues = apc->num_queues;
 	int i, j;
 
-	if (stringset != ETH_SS_STATS)
-		return;
 	for (i = 0; i < ARRAY_SIZE(mana_eth_stats); i++)
-		ethtool_puts(&data, mana_eth_stats[i].name);
+		ethtool_puts(data, mana_eth_stats[i].name);
 
 	for (i = 0; i < ARRAY_SIZE(mana_hc_stats); i++)
-		ethtool_puts(&data, mana_hc_stats[i].name);
+		ethtool_puts(data, mana_hc_stats[i].name);
 
 	for (i = 0; i < ARRAY_SIZE(mana_phy_stats); i++)
-		ethtool_puts(&data, mana_phy_stats[i].name);
+		ethtool_puts(data, mana_phy_stats[i].name);
 
 	for (i = 0; i < num_queues; i++) {
-		ethtool_sprintf(&data, "rx_%d_packets", i);
-		ethtool_sprintf(&data, "rx_%d_bytes", i);
-		ethtool_sprintf(&data, "rx_%d_xdp_drop", i);
-		ethtool_sprintf(&data, "rx_%d_xdp_tx", i);
-		ethtool_sprintf(&data, "rx_%d_xdp_redirect", i);
-		ethtool_sprintf(&data, "rx_%d_pkt_len0_err", i);
+		ethtool_sprintf(data, "rx_%d_packets", i);
+		ethtool_sprintf(data, "rx_%d_bytes", i);
+		ethtool_sprintf(data, "rx_%d_xdp_drop", i);
+		ethtool_sprintf(data, "rx_%d_xdp_tx", i);
+		ethtool_sprintf(data, "rx_%d_xdp_redirect", i);
+		ethtool_sprintf(data, "rx_%d_pkt_len0_err", i);
 		for (j = 0; j < MANA_RXCOMP_OOB_NUM_PPI - 1; j++)
-			ethtool_sprintf(&data, "rx_%d_coalesced_cqe_%d", i, j + 2);
+			ethtool_sprintf(data,
+					"rx_%d_coalesced_cqe_%d",
+					i,
+					j + 2);
 	}
 
 	for (i = 0; i < num_queues; i++) {
-		ethtool_sprintf(&data, "tx_%d_packets", i);
-		ethtool_sprintf(&data, "tx_%d_bytes", i);
-		ethtool_sprintf(&data, "tx_%d_xdp_xmit", i);
-		ethtool_sprintf(&data, "tx_%d_tso_packets", i);
-		ethtool_sprintf(&data, "tx_%d_tso_bytes", i);
-		ethtool_sprintf(&data, "tx_%d_tso_inner_packets", i);
-		ethtool_sprintf(&data, "tx_%d_tso_inner_bytes", i);
-		ethtool_sprintf(&data, "tx_%d_long_pkt_fmt", i);
-		ethtool_sprintf(&data, "tx_%d_short_pkt_fmt", i);
-		ethtool_sprintf(&data, "tx_%d_csum_partial", i);
-		ethtool_sprintf(&data, "tx_%d_mana_map_err", i);
+		ethtool_sprintf(data, "tx_%d_packets", i);
+		ethtool_sprintf(data, "tx_%d_bytes", i);
+		ethtool_sprintf(data, "tx_%d_xdp_xmit", i);
+		ethtool_sprintf(data, "tx_%d_tso_packets", i);
+		ethtool_sprintf(data, "tx_%d_tso_bytes", i);
+		ethtool_sprintf(data, "tx_%d_tso_inner_packets", i);
+		ethtool_sprintf(data, "tx_%d_tso_inner_bytes", i);
+		ethtool_sprintf(data, "tx_%d_long_pkt_fmt", i);
+		ethtool_sprintf(data, "tx_%d_short_pkt_fmt", i);
+		ethtool_sprintf(data, "tx_%d_csum_partial", i);
+		ethtool_sprintf(data, "tx_%d_mana_map_err", i);
+	}
+}
+
+static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
+{
+	struct mana_port_context *apc = netdev_priv(ndev);
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		mana_get_strings_stats(apc, &data);
+		break;
+	default:
+		break;
 	}
 }
 
-- 
2.43.0


