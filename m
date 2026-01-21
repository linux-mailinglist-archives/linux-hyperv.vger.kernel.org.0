Return-Path: <linux-hyperv+bounces-8410-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BFfHs4QcWlEcgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8410-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 18:45:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF66A5AB7E
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 18:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5633B82EA32
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC8149253B;
	Wed, 21 Jan 2026 15:56:31 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B548C3F0
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010991; cv=none; b=ZczMV63+au1nZqwquFtPP0zVdLi4fs7Nd2o4V67WJsbSSRoP77J1XV5UZMlFbmgcw0xyvK2E3dzRN3HAlOjo5tq6wQufgGYBA3QzweK6wlVTWQtpxZSQbi8vMIUzKt9d1ktXzg05wXEkKS5evHRYQPEUx1bMxODzTwRkL/BkGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010991; c=relaxed/simple;
	bh=pkEoGJuqg0YDIqMIGUKdaE1F45xTi6l/4mTUar5JB5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XCOGPczFb6hqkFm9Vp+NU+rijZ5B8Bzr5U3m6Xi0RRiaoPtleVGaTpvoJpBTu/fucFgeNiVXKNg5Hr73QzUXfzFqfGqrJQaT8o7XjuZU3tX+jm7YqiNQS4cq7vI0Y01cBIdZCARvOAcS01EJAXBiyuIN4YcOxkRBNPHYW9PSu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7cfd9b4e3f8so2284946a34.3
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 07:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010986; x=1769615786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwHTliNXI2EqMwiHbVh6QlzrgN72rnVMTKEWdOsyi80=;
        b=NmTxthxOMQCZV+wiCEMhqy6bSRuJgShb6ccWvVWstrg6sjqaEhRIqAmiYIQA6J17qL
         CLt/jHrHDIsZ+GTB9K8docIjLwnxKI/DPnSCbXob2ZvHx+ADTdY53RURCnVTBYLR/wsb
         MjFnasb5HartS1/SSHKl0PzZkTo88jxVBZdgloaMfW6J8aJ/A5rnla6EHTkgLmeDepGR
         axvJp4TZzBjwRE3noB6bEhI1wIXdAvsjvWvMpyS3lDlAAmS/sdp5wTW3DQjP4JHo9CTJ
         ujem7cSOkvZ9Ogp8zP1fFZBj7oIsFs6mCpHRm1aKfY3Wa186dRMmho/Oa62wLK2aTnWF
         PTHw==
X-Forwarded-Encrypted: i=1; AJvYcCVM8M4GqAZW3QIARraYxZ1Ng3HSAcEibHoVHjU9GlsKAttsnOyeVy4wrG9B0683+OL/KTQx9OwmSdTg1Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCRfCggr9vi6DNDD4EpaB0IEL6l6141vTXHs24MJfJEn97TL6k
	IRgPZoYSxqeJ/OmHHdiCXp731QY+fUTz4C+HTtRQWobEepux5qxFMVdQ
X-Gm-Gg: AZuq6aKDJWvdn4EzRA7gGxTIStTAzAjcRcz3/sJRNYnzZwkdPPNdeM8Blux0U+94OEa
	xOWySpjl40XzL20NfDsTWZWfoMJvUPA9d5Qc0LuX7CesH1tksHEB/gp2quPFaViguU+HVcR0oaI
	CeabPHU8sbNj1k8iKRfqmg+A+yPJgL70dIUf0fv4VkDxdw4OTH4fWJKyi3BG/3LmOl0vAJFjuH8
	/n3p/85ktlR+7KUsjtBTvTdkQFm+Ufi1vC/S5Z8WEtht+Th0HpkaRmvUSuFNUfaJ31kgWBJRpiY
	JsQAhQhWU3dR/FmbJ+vTW051cRcmQ4DpZz81rn08KxSI8b0I16OOrUpdY235olkLyhy9w+F8FFd
	Gql7dR6Vk+Px66S0wQBnxWRpqu30/mE8Sq3KkjvpXUlm9zZn0UErEGt3V9bH9Ztt7xV8yDWnWjr
	S0Tg==
X-Received: by 2002:a05:6830:6f8c:b0:7c7:65f4:1120 with SMTP id 46e09a7af769-7cfdee2b207mr9697792a34.23.1769010986084;
        Wed, 21 Jan 2026 07:56:26 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf101198sm10999966a34.13.2026.01.21.07.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:25 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:43 -0800
Subject: [PATCH net-next 6/9] net: ionic: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-6-07655be56bcf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=leitao@debian.org;
 h=from:subject:message-id; bh=pkEoGJuqg0YDIqMIGUKdaE1F45xTi6l/4mTUar5JB5Y=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPciYhTeDmt3w42UdoGNb2eei7e+myHymvVTE
 hkXk7LP2KSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IgAKCRA1o5Of/Hh3
 balqD/kB8AVVJD8dSqtL+vQ04BXPOWjX5hZlbGqjpp9sRadkhKckdk3ClKhX+XszkZgZ0GkNl5h
 IV8pC9OY+2++QdFCtmItJmuJNtRaTzVZMPM8U8T6JYsWq5R3ERBuMBZhlrPkSO4kZiK1I4aLdda
 jRkDa1DHMI3p2/pbK16NuabhOv3MhKoMoLqUMXu23UedkscxH0BKNSW4OaGOm8t1nUIrj0QLOyC
 LSrrrkGZ112KWIji+faPFspMduraDfLPoiQV2F/8oynQ6UaBvO5ZTClxrLxhiWkpD7TPbioKHrS
 BzSL3sxIHNH/0Xi/FAJVt9fzK4FZM2tJgMNcVL/cp5HJ3quw0LujzdjDhYNyAKq8WTeJ8ck8FQM
 X/u6MGhitcDbh7I9XzDbGyNo07FW6IVyVnVAYq3qTEpq6hZ7mTc9RpAnkYuuk5T4q7iYvK3hJB2
 gkDk8FzsGQNmkY+ycIT1iAeZ9uy17aO2u7dXczuKXa2X3KFaIdJF8S6TafhyQ0dYwiP+S/YhXMf
 vNbUXybcdvK1aJgWxYAnItqgsnXbM8ZZtAjkbNHvtbb4/t/liQEGQKRM+0W5QlK2o1Tfmeh6+yD
 eYHN090qersJOJZUUfBQITn0A7y8bF6lVJQ33tRTFhWHA+nxlS02dB7NE4uGTzLjopILZM/mjwK
 gYeq5ptLK3ai+Qg==
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
	TAGGED_FROM(0.00)[bounces-8410-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: DF66A5AB7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Since ETHTOOL_GRXRINGS was the only command handled by ionic_get_rxnfc(),
remove the function entirely.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 2d9efadb5d2ae..b0a459eeaa640 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -843,23 +843,11 @@ static int ionic_set_channels(struct net_device *netdev,
 	return err;
 }
 
-static int ionic_get_rxnfc(struct net_device *netdev,
-			   struct ethtool_rxnfc *info, u32 *rules)
+static u32 ionic_get_rx_ring_count(struct net_device *netdev)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
-	int err = 0;
-
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = lif->nxqs;
-		break;
-	default:
-		netdev_dbg(netdev, "Command parameter %d is not supported\n",
-			   info->cmd);
-		err = -EOPNOTSUPP;
-	}
 
-	return err;
+	return lif->nxqs;
 }
 
 static u32 ionic_get_rxfh_indir_size(struct net_device *netdev)
@@ -1152,7 +1140,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.get_strings		= ionic_get_strings,
 	.get_ethtool_stats	= ionic_get_stats,
 	.get_sset_count		= ionic_get_sset_count,
-	.get_rxnfc		= ionic_get_rxnfc,
+	.get_rx_ring_count	= ionic_get_rx_ring_count,
 	.get_rxfh_indir_size	= ionic_get_rxfh_indir_size,
 	.get_rxfh_key_size	= ionic_get_rxfh_key_size,
 	.get_rxfh		= ionic_get_rxfh,

-- 
2.47.3


