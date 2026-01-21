Return-Path: <linux-hyperv+bounces-8412-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMUgMJb8cGmgbAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8412-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 17:19:34 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EAC59CA7
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 17:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88A3A70A55D
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F574921B7;
	Wed, 21 Jan 2026 15:56:33 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695E492199
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010992; cv=none; b=KLZh7it6uyxUoBpcDGFlrX6fjEYBjq092FSjn6uk4eW0BLoBTNljQuFGY+3OLjzpC3fVpzq00J85pzf3gamr0UBidHIpoyxSofkDcY6ITXI/E4m+fu/z3qm4LOih34cGNJI4ezk2NBo2rgQkigRpWXxHssvX7lS9jSp3+7JyNNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010992; c=relaxed/simple;
	bh=xjfGrJ9ogmU02tXh4UwJsiacW3KcvGXHd/h59cpJCJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JMxuX7XkAlTjPYpt100DFkPEDtzEhNceZ/JdlpI6aqXed3go5Gsdqv6MEMl3zpwH0Ik//FRPbKUbrCyr2jVM4QUkQs3627M5GQ2zW5PdCXG+h3fMosKSG3zKdXISgbnQ3ZiD3wiuX8FqQZI9eGq+WN1gXjIGJVvf3BS9OkHpAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45c86087949so7230b6e.2
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 07:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010988; x=1769615788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Ieldrz0yCTZzK/huBW1mkitT5A3IA5rZUXCCnhdv+8=;
        b=p1gsk1xx06uqWU6FP79O82aWZ+O3bOgfPN0zPQKSHAa/9O1fmUCQO8X5dCAJY2AYV9
         A31ttG0kgK84LXSc+wylrfl5yxd2edzv1pd6SsrctuJonLjMNGLI8RXb4or0N+Xo9uZC
         e8cP+lUvc08tHdyR3mG4OyMir45TJBpF7hBAnQetsbqiNsEj4ft4rZiVy40qn+9bG4ej
         E6qScUQiXCxJ7d/jUYMqg+sFsaDl1ILGDttKNVULRF+gagi3ktZeyQRMOG0xdlUiaA/J
         PRtxLMQaJU1nOkcxCsxpTlBGCx4ZyQGoBIFqllaqgKeXkBOAjK6ihjiaj/uleTYDhbQD
         62og==
X-Forwarded-Encrypted: i=1; AJvYcCXLwIhKLdLcUCsEqt/Q6ZIw8H3B8y2RUGYeqAN7jFu8eTI+JCW1WdHW04X165OpDk01qvy/eho/fAZDoCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45c/BAkzJsrL4UwCiabuuP8lgLJhKsxW5M/e+I/P2ZcvVszWc
	AkXnHYC+h8b6E7fCC6Nw4nZukFE+zKRP7ExRA3fb9AnGnUr36f5AJ8zg
X-Gm-Gg: AZuq6aIA8IF50dLF03nLIQEb8+16AUEVFGinU+e3WEHEqfizK7nmhl4q+tIlCEAW9X2
	f+erKDxsmU9noCzSxV9KIzNC1G2sgGp6flWk/u9q7jrpz7sM0dUVQ1oYjo3xAFBD+Zd3LK8CVpa
	qwvyTR3UnbUTHoVgXttP4hAwD8tHakv/vDRW8p49nsXmWjJYWP8N6FsXo0FshxDQJr7gQcBMDyb
	D4oNKk7aEJ44TmnOXEsWdtiUhPePL0SPUVKEXxYOezelsZ8tXNfWbHes7kAQ3AJr3xQ4WgR6KVR
	kfH0dZDVALPKrcPzBghWXx0FC27rxwmozR/iv8W7LbCbF+MQBlzGCj0PzVUkeQkbj+etCSLYwaK
	xf5cc8Ipn3TGLvTmKnLccCcUPyU47gUCJIuampSZPQVpadd1wplQBC28n9gB2R3FUTk3rEyyhkb
	yF6g==
X-Received: by 2002:a05:6808:4f60:b0:450:b43b:3142 with SMTP id 5614622812f47-45c9d929969mr7203814b6e.67.1769010988269;
        Wed, 21 Jan 2026 07:56:28 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bb545b9sm11333368fac.9.2026.01.21.07.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:27 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:45 -0800
Subject: [PATCH net-next 8/9] net: sfc: siena: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-8-07655be56bcf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2810; i=leitao@debian.org;
 h=from:subject:message-id; bh=xjfGrJ9ogmU02tXh4UwJsiacW3KcvGXHd/h59cpJCJU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPciGOYn92BaHKmt39fyKEVo/6aqUOA9Owk6p
 ALiwAeiGYiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IgAKCRA1o5Of/Hh3
 bc4MD/9ApFcQWd4wCB0+XaKw9CUrjtiZ1/9w1xeC9mclcB8VU1LWhvZi6l93u+gdbsGC3CVvxOb
 KWMuwCUfv2vCmHtCO1tgnOfoBbhNo810fO2p/s9+d9UXFzFzYqac2Vlq4jxziJt1zmdReIEqq5A
 XGvZhBUFypdT+SSuRv49IHaqa2V/uhij6GsqG9yQ3z8qfFdmBfVpROwLpegk7fN8Jq3CE+DGrJW
 0z+/AB3dmcPipLHEYC0ackpMW5obztm4RaYWfa+OTpUF/xMKuZncQbyIbMOJIrjT4lBtp4f+kZi
 JUAwSf3S+JGca00Zg6tSWAwCDYZLEHZiT4HLyZh2i0buOK+VaheoCG0XINc9R72iPUKfaHvSt/l
 m/74NmveJRxiC9JY8Hq3ifpjSYO2FgKxkJyUBk1Df2ZMG3mgos3mDJALwsb7hwLwDER4bSEc3ef
 3s6t0LOuhtHWySesMhP/KNzpMjsXIT/IX2gN6rQJvfNin3tTf2TwhUJPMpEAhOJo0QRDW/ZRiZG
 nUScCW8hoG4+3Fg8EryXKxCyeOjKjlAinPwFSybRFrwK+dbG7TLD7fQ9rThlgct2c9AFhIP4Z3q
 C5RdMmMgaJZ9S6ojA0iQpxdEYKif6POwplsweLpL46MyBow2BGMDbxOiWysh5Ztj0H9r/aAFEar
 3sJgShl9z7rgdvQ==
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
	TAGGED_FROM(0.00)[bounces-8412-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 82EAC59CA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


