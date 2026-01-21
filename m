Return-Path: <linux-hyperv+bounces-8406-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGxcILEScWlEcgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8406-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 18:53:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBB45ACBE
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 18:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10E937CE0E4
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 16:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50148A2B6;
	Wed, 21 Jan 2026 15:56:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0544105A
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010986; cv=none; b=am7CYrudmnwgRylYONhMdQFMeStlF8BE9oCEi3F6XXyzmgd1Uxc2n6J8AjGxBmuBD6hkyacuLrc/YhfP82rL1M4QZs3tRr0oSOWqHwwNemDgQ4QcHdCUQjKuwS0NEXatM4WBH/pHXQ1FbY/CofxDziPp8006DUdZ75yh7Anx/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010986; c=relaxed/simple;
	bh=bJbfYoi9ePT6GJvQe190QXenIvJlnJbG5gCYyHOYLyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cysjT6BTeArPUEDRYBahIOen5GLAn41eA7KsuuUarj5OT5aQmrrGdqtfP4LjDaR5jdKAR6xA8SPATvrL8wNice/wKklwEVnzlo/v28pmtOyLy9Se5O+GJykWor/bRDmS1jzHvf+pmI3BwZKB5Mr+C2QyPBbQJ7NTqcj6BjvvIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7cfd48df0afso4380755a34.1
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 07:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010980; x=1769615780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0dc9BpwHRAb/FF2L8Jh14J11cIizVUqlWjJq5crcpt8=;
        b=INlJeeFUh6jPAURZr+C2T3IOk2kH+pKKDwB+D6mx6lS4yNyXK7naJacDTUhcTYm7vV
         Uo0cmBma9OYRl63SmnCIT/ZIyL6Xl4jumfumr1+CRY3rXSJgOKHYIoPzzt402CD28OwE
         NsZid0HcYLs1H43Dz8JG1Y8jqSkaIrTWUjm5MEavMV9gzwQxzuwJN+8dp75bF+t7nAZz
         No2Zx1V0lpWIB8kOZg6/HTSQG4irRSOtNqd/cikppEFjlPG+SygmlVb+ubz/M65oi5SV
         s3pVbll7mvxbvS8h/uf1Kt+i7CtP9emWllcrqzH3tHruPqO7QdU36nqk0l+imoINYcy8
         MKbw==
X-Forwarded-Encrypted: i=1; AJvYcCUI1THeIuuzyILtJpwoY3AWiwfhq6U2VZ9/+JXHHefgXziaMRgKjgQEy0aqhqwx96g400NrkVz5ZBM2TDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzpllQFGMx6zSnYZD7DQYdIYssGTO7Eiz9geXg2y9n2K+QW8u9
	TMIOUrJtOsbnD5CgNQk77HMha8A5X3o8lK5nKIA2Cb0MrjFRW5wHD65e
X-Gm-Gg: AZuq6aKD/XEs44G4XuBeCNGJbTqa2T8w7dItLhDD2WruZYMgFBnqI6Xqd30QHLMrMqj
	lDms12/6XbSmpIFeyCN7WikTFJGK+qUclAcRUtLED3OLvFhTSE9+ycfcClVhywgnU1d4YFoZNFD
	ulp503/crNVgWetzXu+kp5jeBrOXrbshZHRFw5xdETmQje7LlORHm9e0mw92VtAU908fldbnDgX
	n05x3v3f0D+9RnbChDAtxzlO3Tvfp7w3bCxM7JVFPLRlMIzxxsS2MYx9Xep4/e9RS4MW9PCt5I8
	+KyLcQOdVqENK/szwOVsGDgxiYcko+Va20Bi6f0gT8A6WI6VdiX+46UvVXWsKJ0IJw805RH8Ux2
	y1VFpq3bFZUpeEyaCVqb3lVUQammryQKn1O4j755iO+KgCs5CvquGiSxkYgnN93SOV9oZCOh8GH
	nhFQ==
X-Received: by 2002:a05:6830:34a3:b0:7cf:da36:4c7e with SMTP id 46e09a7af769-7cfded34418mr11426838a34.8.1769010980605;
        Wed, 21 Jan 2026 07:56:20 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2b5a74sm10537443a34.29.2026.01.21.07.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:20 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:38 -0800
Subject: [PATCH net-next 1/9] net: benet: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-1-07655be56bcf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=leitao@debian.org;
 h=from:subject:message-id; bh=bJbfYoi9ePT6GJvQe190QXenIvJlnJbG5gCYyHOYLyw=;
 b=owEBbAKT/ZANAwAIATWjk5/8eHdtAcsmYgBpcPchCHxqClAg62HFeFAbMUPfCD84HYKp+kg8Y
 i/NEdAJ4MWJAjIEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IQAKCRA1o5Of/Hh3
 bbMSD/YiyXHZnrDbsbyzXsekkJF8wGQm8LZpBCwBjpqlmXQJrnLP0W0wE13XKmuWQhINTucgY3l
 PLMJW6H0Rv+97H/qPjnapi09wOKxEJysm6NkE3uq3qitja+AdkOsgnBUd7R10UYGND+Yd43LQAO
 bUYb5VeMFLVU7SNfdOIKO0ktpnbuUFXKXRlFEL0w+5q+EOpJShFdb8l65n+SCKgK/4m1uyBPLZj
 xpZ9LOf4hl45EsABkRQIXGc71tBlqtpvcyzo0lltZHa0FNpTEu9e93bmRGK8GmFLqlSFu3Vh6su
 KLRcTkll/+NlBneEbd3uqlHMVPBFMkQ64C6Cs28/69w+DzcvXwnQxJfS8ATSui5GtibOsp3yM61
 bZuApi8NGJCBQ+gBaKgnqfu2qXZyZdyENmAZ6/S7bRbB5ZWUmC1rwCn1ZvTkOoXPp4J7ehwKgaO
 m756KVYP65F4DbsAoEc0LaaiFORa7OxJ3rhk4bztDt+8Av7/sUFwlhSfC4dmujMkSIiM/1noxWR
 5K5MqZYwQlxWzz7wd2hjSDbGC1bYtTXOazDO7a8jCACSdoDwEty0/sIiDu4yzto73wKAwoNCPZr
 mdQYldtkShmobp6SldWy1h2ELbmREQkeuvxCClQAAFYNBxMHg78eNSNOLgLe7EnFkmLvFAQablG
 d06e/Vh/5IkuC
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
	TAGGED_FROM(0.00)[bounces-8406-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4CBB45ACBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


