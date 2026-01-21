Return-Path: <linux-hyperv+bounces-8405-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEtvD6gIcWmPcQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8405-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 18:11:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF375A568
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36A09A8F4E1
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8746481233;
	Wed, 21 Jan 2026 15:56:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534753D34B5
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010985; cv=none; b=QIiCsBW/MEcPxqoYmzpi5D+azKfJUqXU3VklxzemcWt8ucRjmmJPdVSDhjnR8ysVWpKz7LS4agonGyZz1HMoZo9ZhWkx62Gty3VdKYAvI5bxEvcq00uXJbKOA0rk2Yy6/nbTZNvmkXWQc1R7xSBVjQ8PZyy9vNPz6K4E2vkCbLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010985; c=relaxed/simple;
	bh=GFft51yuC4WzV3G/D8GfSip18W6gE1bf2WP0ZpHcZxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OToa1ip+FfNxjt2xgloF8zgZMGj46i7L6Jqx0LzCX998wwyG4B35KPRlb2We50JCBBicDXeP3EflearXjxu9OYxr9mfQu57EZxhTh0MFXiWNcjz40hcA8JdSmo5EIu7iIvtxxHTJ8ayS3Asbdw1ewTQjUhQjnt4Uyx3l4vNRhII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4041c73ab4dso6989fac.2
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 07:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010982; x=1769615782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=78P/UAV1LWhbyJcJa9mSCIGPHxQe4k7cpmkiJ4BHBmg=;
        b=XBvNNbuXq1/sC1z1uasb9NjcxT4UB2D2fJCvlUttk87RZqOwIFL5Za4QQyZqUOu8SL
         OWLe13WOpXWL3RQ9liodNddcSKaUGRCGQ2wKM/V/UZz0XlwyDfNQCtNXIhMlmliss4BC
         3JPbECUASGNPneoXQE6p7jB1wT2ULyDANh9g80nPdPumBN31HSDCgopnt4x/033cm7ea
         xQmc5QQlEwxjZ+bmuFMriku1JEThZ/n/UN828KcLYSIqCZSMUhTy1FQ+7047PoNpNIXj
         lMx0yxWuXOxggVVf6MM+CHxdb091voXZEB4iaGrhk7ClN5lgmoW+tEMcOuQftlcJrcwO
         naOg==
X-Forwarded-Encrypted: i=1; AJvYcCWcwPZHDoLVzEamHqGwAqF0W5z2SfQL44stkfYR/3YUD9aASU8kqUZlCtQKmKsSLJKIEVFCz50xN2mEz1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvUOM90N8k02EXFFfyk9eL3JaHb1vvemZL9mQBV1iXQI5eXUxj
	AKINAll1Mv4ozNfVuc5lYxpz1qI+wuI9vid1fA29DaGah6QyExkRRVlt
X-Gm-Gg: AZuq6aLNs3ZcWUGq++PhWgRv3AacoXKJYLxgQ5yV08emUnI7Lhm+E4FD2329QCqKtrh
	CyBhJsPUAevGAz2GRDlUrvko8jvcV5XEgH2WEbidPHbWgqwuJm/GGhyfjdHYsZ/01HEHkp4Mfp5
	3O9RpPIRJ/o8sv1Ikm2em89SLQPIgvN53bthiqJuasnaQV0kJNDFCC/VS5wDgLeOTsxKRLguN5G
	6NuxrE+PREtNV0nzrAzEp0MYSaObskrIJcuneHl13Xdjo9EPE57Mzgvc5nEtot4hEzhWq3APWDZ
	sYSZWCtSiyz/1s82p0a+fKlBI6+H/Dwtkopt0KtaYojyqRdBiMDymlP2DK4IfmZUVfBDhLCodg8
	ljUpgphGJIMS7SFLqfleebsMyimIqkOkbWRULLWBxQJOJkhgW0hCVIkrbi5+WPottiFg54xSQXx
	0wqA==
X-Received: by 2002:a05:6870:45a1:b0:3e7:e70f:fd64 with SMTP id 586e51a60fabf-4044cdf9cfemr9891329fac.14.1769010981636;
        Wed, 21 Jan 2026 07:56:21 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bb528d5sm11496023fac.8.2026.01.21.07.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:21 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:39 -0800
Subject: [PATCH net-next 2/9] net: atlantic: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-2-07655be56bcf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; i=leitao@debian.org;
 h=from:subject:message-id; bh=GFft51yuC4WzV3G/D8GfSip18W6gE1bf2WP0ZpHcZxI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPchwxi8H8OguEoWaW+kmoGlddgm3A5pgpqon
 /JUdTObJxmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IQAKCRA1o5Of/Hh3
 bf7pD/41NmC5S3hL+B74vF2Opj+sDa22FIvCQbBe++dUZjtwVsisqSgWxLJ/B2rMO/CA8696S9K
 hx0+mQcLxTHhKYMrqk7KNVkSawjR6lSELsYYLraBScPWN5K+tN3sUYx897DHykjwYSLSI5BaEcS
 rDHG665uApAOYLxbJTcMjt3Ek4WqdiY5ULBKjYfc8tGTsPI4flTPH5Y9Z7PZTsZd9zHznCLptC9
 Q/QZqzBPox9DM4bpgRytV48W/k6MMJXsNE+XbjT7YX6fRn/7vcQK1sgvkKApwC+wzPdTsabII9q
 5t20R2VoaCRSgS3uJRLUqZ4Pu3qYVKxN38jDadJM72RyuL9jzK5HljpGRC7mYk28qeFXIz7KJ31
 YLhm23Dg+nC2ldGSviunTAEaor+YdHx3fgA7oHjmoBuI9Lq6NmPJvUYh3x1izX9vl/PwHQd4ty1
 VbHjE0SmHFoc4ZK8DhMLrKYy3QRUMpoSGc23y93sX2zLs1jEZZx8RfmU9DTZ6hYwSHYoFU6XGgD
 6fw0gqIWkRIQhRmX8zCXb0oDoF3Z+2tuoDdPfGCyypYAGH5GKy+kiV080XJttGzDp6DR+yhtma7
 9Vi8QZaS2b69SuOgveMIT3Z3babc6VSU09iQk/GHNky6QAqFUVKFbIJ8Zht8P+VDtSPhtn9uO2l
 7ESqVrCXTu3ldWA==
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
	TAGGED_FROM(0.00)[bounces-8405-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7AF375A568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index 6fef47ba0a59b..d8b5491c9cb2b 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -500,20 +500,22 @@ static int aq_ethtool_set_rss(struct net_device *netdev,
 	return err;
 }
 
+static u32 aq_ethtool_get_rx_ring_count(struct net_device *ndev)
+{
+	struct aq_nic_s *aq_nic = netdev_priv(ndev);
+	struct aq_nic_cfg_s *cfg = aq_nic_get_cfg(aq_nic);
+
+	return cfg->vecs;
+}
+
 static int aq_ethtool_get_rxnfc(struct net_device *ndev,
 				struct ethtool_rxnfc *cmd,
 				u32 *rule_locs)
 {
 	struct aq_nic_s *aq_nic = netdev_priv(ndev);
-	struct aq_nic_cfg_s *cfg;
 	int err = 0;
 
-	cfg = aq_nic_get_cfg(aq_nic);
-
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = cfg->vecs;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = aq_get_rxnfc_count_all_rules(aq_nic);
 		break;
@@ -1072,6 +1074,7 @@ const struct ethtool_ops aq_ethtool_ops = {
 	.set_rxfh            = aq_ethtool_set_rss,
 	.get_rxnfc           = aq_ethtool_get_rxnfc,
 	.set_rxnfc           = aq_ethtool_set_rxnfc,
+	.get_rx_ring_count   = aq_ethtool_get_rx_ring_count,
 	.get_msglevel        = aq_get_msg_level,
 	.set_msglevel        = aq_set_msg_level,
 	.get_sset_count      = aq_ethtool_get_sset_count,

-- 
2.47.3


