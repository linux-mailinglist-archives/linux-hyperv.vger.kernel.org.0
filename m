Return-Path: <linux-hyperv+bounces-8409-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGl5DyICcWmgbAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8409-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 17:43:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D926F5A0E8
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 17:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0E127E016A
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EF348C8D7;
	Wed, 21 Jan 2026 15:56:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699B44105A
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010988; cv=none; b=IJK31VKWBjlSiSis1gVPjNSrbhh9lkAtGUT9iwuFVFICKdw+uW+JcSt/2XOQ+DBwGvLnW665iafaYvK966vFbaTxaT+Zut26mFpfBKPUFr6ka9aZk5TafobOLoHZJZK35Ts3GBe2t07yaQfT9badVyMcgUbdnWhyrMoCfeHp/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010988; c=relaxed/simple;
	bh=IMKgxRU1sol0qv3q4ykIX98inRbeR6UTILUypHJQ1KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gCVvJJcOqKdlG8B+MhcHwqi1DPAc8M0kNNMkdHf/2+jky9M2nqNGR14iKpA54NsfED0CN2jwUK3M8V0MjISaIsl3snirbCvjRS5EotfXYUKnNqbPy2A90Ky98FlVa+OFVXWgTAbpjsbkux0G0RzqzBKfb3O6LG6eoIT/4Xc7+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45c9f47e1e8so14567b6e.0
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 07:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010985; x=1769615785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6idYD0AKGESVEMq5nLW+uYD0VvpAsFD+VjX/8Dx4wWo=;
        b=E/gP4YII12laG9d4EIvJF769QE0qUpjZHYCyhwevS98K0vfODiyweUzqymDzLPXYFf
         D22bAKMcV6YK/MBr5IrTOWFq0TM/RuQdg1cFs2iLeYA7vOoyGGj8AxWSMLoHx2Nh5JmD
         inrukA/9xah+D4Ja4TgdOhHkGaMHvY+nP4RdMRDdYWo4tj45Lli5q4BDjrGUhRD05JIT
         6/RLq/YxVhTVhvnZntWkie17rNKvsgwYSZXK5vpNVBKkIOC7mcTGte6Ya4nq6yafGOxY
         f2c0f5yAKs6A6nJ7LN7zQoxkYKwMyL45HbwzGqQt3/ZKlrFfKuAdOSAC/RBOm/pEXY49
         trCA==
X-Forwarded-Encrypted: i=1; AJvYcCUihcMU9EHWRM7mbgnuUoF+CGJBD/DUzuPIVLvjtkU/DKXwyC36eAYYg6FRF062firOzbAF8vVaJkpCdDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmfd0O5KwDmBXyh6aPG30qEH3KuY+WAaAZpFICEcaP2b1XOB1K
	/D/Hs/4IqETz8vov/5T6uts+Tbbq27lFNl2KVG5fCfStK2C1AMkp3o9R
X-Gm-Gg: AZuq6aJGwNtSC5dVULm6BbhvBxPzgLrLLxRprOnCJ4sGmOr8N5BSr4q6XlVcKgWJ0T9
	JKOnji2/OxnFhmCPHDhGzdUR8LRCjNOSjculEexd+kXGp0JWcMyX7N2Yvb7mq/q87QZ81g3sktL
	mEZgU/gp+zxZ2vermDaaPP4nkWcwm3Lfzc5qOGn0eH9LtBcWBvJYvncFqNTB1UYSHW+mHed9Z+Y
	G3FZqrNI6xSwKQ2pmCBXSPhmQANVXSm/4oLr7JG3qCnb006jeJRGzcdVpTCpy241Uafe8F5Zx3H
	7qwZbgIUbF8plw9LPi8A6SRzbAOSzGkbrLYKGOSnStVn8ppUEg8ROaH3z6wFcq1RCf4T9za7mi+
	GHAGoQ+ueHRRiH9j81O0zqqCqx+f+WH1KSGsXvKFxhINNzniT+cLgU8X40ZQaQ85xat14YPBaY/
	fovw==
X-Received: by 2002:a05:6808:1801:b0:453:50af:c463 with SMTP id 5614622812f47-45c9c14fd86mr6820343b6e.41.1769010984991;
        Wed, 21 Jan 2026 07:56:24 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9e03faa4sm8763844b6e.18.2026.01.21.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:42 -0800
Subject: [PATCH net-next 5/9] net: fbnic: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-5-07655be56bcf@debian.org>
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
In-Reply-To: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641; i=leitao@debian.org;
 h=from:subject:message-id; bh=IMKgxRU1sol0qv3q4ykIX98inRbeR6UTILUypHJQ1KU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPcimRzZNJSf4d1IZxSV2HQSnbvSRZ+5v/wtx
 2BlvP6rC5KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IgAKCRA1o5Of/Hh3
 bRjCEACgNH/DrBH3/TwdObeQBxDKQ7ri1VmY7UxH12naM375gcloF5oYaCC0Pk01M7Ncq72hwni
 gLDjbTsuQydWPhTRSh+jRQNZqUts5/jMyls9SMBdv7gqyKL5fg68fljW6jg9h/YpPbAF0CuSpvA
 SN7HeNH6i1WOl84JyeUA0QCGOknwIIkHSpBJ46s+d1h/RMLx1zlFhSk1FHeTyOjaBnthP1AWnn1
 hkzCGVgZ6hK4rbqjE0t7K0k+HS1X7oWJ3/KOG/f9vjeEwKO4kpSOszKoSBcDZl3YuggjxKJY6qz
 r6Dvx8Iuj3Svowtx2cmQvBUsEm2MMum8aOBkKo+InxoOs3YFrDrkqjkge0d35p8CF+D+ckWsmyR
 fae5k1dxkVjFpMGsltyMCv5KqSwBd3cOXtVf4EzCmhkADGnjfhVG5GE7XS/c2hN8GMMS2E4hyun
 uN0ZY9ze9aISu4y9s6LStKVnwxkwGOOoVvjIQo+iw9RpKPo2wFtl6DdSg3D/Frk4goh40hhBnS8
 viYUzFM/O6c8LzxKV/6uiM1d0+V7UOZxQj4oDT1/4KvisfOkF8lA4IhibwuRGscXVLr7oe0n811
 yETZIMGNqb/cRZLWJYwq3SNJNcFkD0xnzSG9RdO3eoluiG6lMzQsfYnr3jZQluo1wZHI3ECecXY
 3fRz+TAC8y16fZA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8409-lists,linux-hyperv=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D926F5A0E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 61b8005a0db5f..11745a2d8a443 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -825,6 +825,13 @@ static int fbnic_get_cls_rule(struct fbnic_net *fbn, struct ethtool_rxnfc *cmd)
 	return 0;
 }
 
+static u32 fbnic_get_rx_ring_count(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	return fbn->num_rx_queues;
+}
+
 static int fbnic_get_rxnfc(struct net_device *netdev,
 			   struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
@@ -833,10 +840,6 @@ static int fbnic_get_rxnfc(struct net_device *netdev,
 	u32 special = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = fbn->num_rx_queues;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRULE:
 		ret = fbnic_get_cls_rule(fbn, cmd);
 		break;
@@ -1895,6 +1898,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_sset_count			= fbnic_get_sset_count,
 	.get_rxnfc			= fbnic_get_rxnfc,
 	.set_rxnfc			= fbnic_set_rxnfc,
+	.get_rx_ring_count		= fbnic_get_rx_ring_count,
 	.get_rxfh_key_size		= fbnic_get_rxfh_key_size,
 	.get_rxfh_indir_size		= fbnic_get_rxfh_indir_size,
 	.get_rxfh			= fbnic_get_rxfh,

-- 
2.47.3


