Return-Path: <linux-hyperv+bounces-8407-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDKOKlodcWmodQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8407-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 19:39:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDC05B633
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 19:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87EA538BA8D
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F748AE01;
	Wed, 21 Jan 2026 15:56:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A43342849F
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010986; cv=none; b=o5d8dtspbIseCXlNEI5lz3alS2OpJp8p5zO7pfLchL1f2x78FMhcY1cBkCCK/DkVVJdGlKd4Mf2+owtnQxLwCoN+7ubfVNgJajZFu/g06GbnfipAx9RKk3ZzI2N2Ga8k2a8qOEp8L3pLGMrg2qODITnISM2vWKy2jPItVZq6LG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010986; c=relaxed/simple;
	bh=T8U9YBL53JqT7WigLAduxBIVpfy/A2owaIdOZQB9pK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5VqMfjkd5PyszpAKDg4Uisb18u3NUsm6iEI3srJTY20GSJjRlBXt0k2hF9zMjcbmPjZr0CmJWxL4tEk8atdy7KqJ1/zlikPkKAJJlvzl6oOgu4l/nzlN/pCA08HvBNbKqfhjNPVwbvdSwMTp4CYXyfkZVQXCtoyQVd4RUv58FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d148dd3421so4612a34.0
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 07:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010983; x=1769615783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ek0t028DajpwRbdMOHJ1y71aPEyjkP5BEsLC81+5e0M=;
        b=TLZuD2Ri/Um8B7fyVvl+vC22Lv5SulJ1vuNm2XFLQGJD3C2ym/pvBETfzTzVLNbmj9
         kgqYHEN7ZjGlHb/eI0bNj8vpt+55vOAZGLXI6wyHCOvuc66uCG8hiwwrjKO5ufywlNW+
         a6EdBS+87UAGj5KFv8WYL1roPpYHfa/WOCyhqV7Xq3vvDE6PlnVUnX/ZO5lzxI5J83IZ
         Mix4Zq9O7dlteKagK+BDwEVde+EVPPqkZYtC80EXaEWCHV9jWzQEeClZZovCGB4287DH
         EGcZXJjvLR/yQsrqJVkSTjsyiwxYHq70Zv5XaCivfoiLE6jiwhEa6bZlIAvFLtCN5PTu
         GGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvwXYtY6h4aNq+IskhTGRdNb4+raZIzNVWRZTEG4R1Znpm3yhZ7kJBRa+sr0yl3VILBuYk6nop6yEn7uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBUX7iS3zcl++43Q2mF8SLfGAeAfpboIAS6ATs0DzHEx05Ykb
	Q0SiUeizZDbfsrfHLl/yqreVd1vaYT87mQuO/QDaffo+is+xkFu00poq
X-Gm-Gg: AZuq6aJ9Y9vI+fn237bRIxGAHPT3Gxlte9n4Dpp/g49LrqNA6M95ZV1tQdoEoIyO1ul
	6SudRyLJsffypP5iulOcbMcReMsb0QKrr4vaeWgj6FaCOx1eGJ2WABXz+LJxcntSi6GBKneT7zv
	2t7aYzOdpX5exgb7DAkoeECk4u2/F2INO7TpGi/9bTP3e7A+7ypwSHmpSp5nRXLYtc8xiWCF6Zh
	slOmqQpyYvXNRCCtHanR25ZeKDpVCaMsmf+n3eHloo0idv8b105gd18y0GHY8/o0PXMvbU0aabG
	IjBzcx+3hvMcPx++S6NclAR2FWIc/JqFcXplFvMD2fLfaOqLpCEjR9Bjx1pBC95g6QdhTUjz4fb
	Ukk5Go7wBdNDaBGuzmO3s4804a7TlypS35krgi9KwGM79XtJN26fhr32iEp44jso7Qc8gO9SQ36
	ZVPg==
X-Received: by 2002:a05:6820:458d:b0:65f:6d50:e41a with SMTP id 006d021491bc7-661188d51efmr5368293eaf.15.1769010982826;
        Wed, 21 Jan 2026 07:56:22 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044baf52f3sm10966601fac.2.2026.01.21.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:22 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:40 -0800
Subject: [PATCH net-next 3/9] net: nfp: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-3-07655be56bcf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=leitao@debian.org;
 h=from:subject:message-id; bh=T8U9YBL53JqT7WigLAduxBIVpfy/A2owaIdOZQB9pK8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPch+6e/Eu+iQKP10pTrr3CuNmT6FBdEQqk9M
 xMfYtB4256JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IQAKCRA1o5Of/Hh3
 bQcsD/45AXMgZGsQVC3J9pUfksTc1zQn1m85PMlFNKytYDezn7OrWQabGu98CEQ/ymbdPzZScix
 j3P16XF7hrTPu18ir6yQ1p0vHBYbgHTyZduh/10/ZqD1Wjt5twHKeDSwVrSSKI5m8/ao//PpQ5T
 5g+CoNBuuAHZH0dK/U3jaWUQYhblyFoYJE/6LBDcIGOdAF2fOscjXfXD0lQe2FCYHIms2Mo3qXq
 7yCGgpbIu9v9bVvFoGf5vE38eIb+o5qwcKvu0bNa8/JGWnHaZJFqnXyM0cUaJeSL1g//EsviHx6
 mUxC6Cvt3DQW24HTiV3b+8r2w1wskZeDbix23XbmcCEeipg1XgUvWoSRb7wyxzCvQA23kv82H+l
 6yVwpoSAD1Fe2rH0QS+wkkr5VUakvdufnE/ajUGEs5g+ptYA7S5YeqtVDlONQB1lkX7jXMs/W76
 dIXqBNeNKmqEEL7VuQ/ES1PR52/XYKTXByWcDGbp1WvLB9nVWEWrhrm8XEl4gsoo1rhoDoPcxib
 xKDiUs6sb37qHSZCfF885e6jhUh5IHEPgN+Sr3YEyqhmxi/XYZafLNuSFEuCbHL8q289u3iC4hl
 1T5VTD3cvXEcBZyD0xsUzap9CWNxbqssjWJwp00B3fCYVB0raH/qSKLtHAEi517Zh8fzuclqokw
 cE+RB1zkrcsNTyg==
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
	TAGGED_FROM(0.00)[bounces-8407-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 8FDC05B633
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

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


