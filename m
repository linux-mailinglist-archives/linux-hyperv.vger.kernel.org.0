Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6EBECBFF
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 Nov 2019 00:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfKAXmv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Nov 2019 19:42:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45062 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKAXmu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Nov 2019 19:42:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so7381404pgj.12
        for <linux-hyperv@vger.kernel.org>; Fri, 01 Nov 2019 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/xI7v6t9KW/j9S/vkLXd2vnLzFY9fGY3Sg1im+Bn+ts=;
        b=uTMu4MjyFXaa2PA5xKDjpnsQcM4JWEFa7xc+c8K48nL13nvXgaID9Z6Y8x3oFEzTNY
         VyzGyDWHgUnTTfT8O5haNp7IrjZArrP6r1c5vFccRi0/GsL4NnnOsRSfnIw9Wp1c1/TP
         wtoLk2c4jOcwDXbH8/qt3KUdIGT8JkzSAvhBc9O+ULoZd+NSrlFpBHD2zwGHntYgWjV6
         x/E1D6xKpPY8iQzL2FjFcasSII6izmKevNG/7zjzpgTfVfnPb4Jpn3niB3WtQoVlJuxJ
         IgPAm1iWE0X3VXAl3tdYDFaUV/fsfqcnI3jfJ4otF6hJqfwuBfK/r6CDOUN+Y1h9DxTW
         o5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/xI7v6t9KW/j9S/vkLXd2vnLzFY9fGY3Sg1im+Bn+ts=;
        b=s1qq6cM+3KWcsBjvdnvVA1Pk8ZxdyvH6b7vUQdw/n9Gn8BXgkgit5WsojhEQ9aaxQV
         LspxEWFIpTy8XyJi+W3jWWRw9UPUD4o/NyeTBiklxxkozRNdpO12FCgKjXF5bnj5fbNG
         T9+KDD6Mui9PRtabbvfse/hnqqNp0z5y4ilH8ObrdwSfjSJY2S3lulR1giJ3BDyOzdbS
         7t9rFLXJRjTMp47tEDru1DUH1SRXIevNgZMr/kohoj9mtQ/BQoetNwJwzdFY8wKlQMuB
         jSsRCfErsz46CurQ79Jf7ZPhKeMSspUE+MYHsU7LPm9UyWphzv1DnAXjsA0KPseF+KcR
         TYrQ==
X-Gm-Message-State: APjAAAXkY5ZzM2b4/BwR2Lm7yEHpKPTdMUrMSSapEb1v9Cc+GPtZmPry
        wvpYyBDAebYm/zW8IAH3+8ndJQ==
X-Google-Smtp-Source: APXvYqysp0PYAcm7c6UcAr7WD3VsuEbErVzJFXRAHklNERTqjp718YCYdSNKcHOTP+tL1RW5MTWU+g==
X-Received: by 2002:a17:90a:ba17:: with SMTP id s23mr10739651pjr.78.1572651768282;
        Fri, 01 Nov 2019 16:42:48 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id c19sm7948128pfn.44.2019.11.01.16.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 16:42:47 -0700 (PDT)
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     davem@davemloft.net, haiyangz@microsoft.com, kys@microsoft.com,
        sashal@kernel.org
Cc:     netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH net-next 1/2] hv_netvsc: flag software created hash value
Date:   Fri,  1 Nov 2019 16:42:37 -0700
Message-Id: <20191101234238.23921-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101234238.23921-1-stephen@networkplumber.org>
References: <20191101234238.23921-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stephen Hemminger <sthemmin@microsoft.com>

When the driver needs to create a hash value because it
was not done at higher level, then the hash should be marked
as a software not hardware hash.

Fixes: f72860afa2e3 ("hv_netvsc: Exclude non-TCP port numbers from vRSS hashing")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 39dddcd8b3cb..fa56fcde9f8b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -285,9 +285,9 @@ static inline u32 netvsc_get_hash(
 		else if (flow.basic.n_proto == htons(ETH_P_IPV6))
 			hash = jhash2((u32 *)&flow.addrs.v6addrs, 8, hashrnd);
 		else
-			hash = 0;
+			return 0;
 
-		skb_set_hash(skb, hash, PKT_HASH_TYPE_L3);
+		__skb_set_sw_hash(skb, hash, false);
 	}
 
 	return hash;
@@ -795,8 +795,7 @@ static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
 	    skb->protocol == htons(ETH_P_IP))
 		netvsc_comp_ipcsum(skb);
 
-	/* Do L4 checksum offload if enabled and present.
-	 */
+	/* Do L4 checksum offload if enabled and present. */
 	if (csum_info && (net->features & NETIF_F_RXCSUM)) {
 		if (csum_info->receive.tcp_checksum_succeeded ||
 		    csum_info->receive.udp_checksum_succeeded)
-- 
2.20.1

