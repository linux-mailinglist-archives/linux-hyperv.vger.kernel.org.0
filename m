Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3197D5B62EB
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Sep 2022 23:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiILVod (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Sep 2022 17:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiILVob (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Sep 2022 17:44:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB362F6
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Sep 2022 14:44:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d8-20020a25bc48000000b00680651cf051so8397779ybk.23
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Sep 2022 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=0Wdj+RXvtzSTWVCBC3E7Qvw8dMmiW0pb/ksTMDuYAvw=;
        b=Ajm7KGtZDxaAtqs155/MmwWxM6UwHlfv1/ltpg+APIwxnT3r1WoPDzMRNnoIeGMDkw
         qba7V8fAUK6z4GU96imY+n5v3zq+Hr5EeWufMvmssnHW6fprfNZ2r+cGy4TBm8sTXwQO
         qndhToQiip1Kl1SPvNUYQ4hZCiZHTXmX3O9JPLYQzdY+ePhKiwI3bDCgI19IivD1bXUg
         9WlsJwSPOhsTAJTaqe+uYOqIihE0wjLV6yYLFI7LB7XC36wBe6i7016KvDjl8vb9pvzL
         R2vnULoJLvkasYdaL+LI+MYrtV3wDegDJeE+xdE6rjWS4uBQyKKJNQgGYJA7A8Ucug5w
         Qp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=0Wdj+RXvtzSTWVCBC3E7Qvw8dMmiW0pb/ksTMDuYAvw=;
        b=fsjt7LGzqH6cm9wdA/x6GXhSrC2K8+Bd8/eM3/0Dz/p6SK5Kgyp/i6DRZLwE1POrR8
         Bp6j1Lyr85sR2WSJeKGoNRijYXUKYZssmgN1BmX9rEgQrq9l6wBq63fD2QHybC6BTBfc
         Q0AVzpoEAY9uxRZDoOZrqud7H79LPVIP2asJgY3mWjqqmMh/jGKz5D71+fVB7GRoyATl
         9Wo/Q4K4P/Ara1X/xDF6NpnRLt5dHAj8Cv2bdoAhv/6uSIsG4HvfGFsiwZD+HvFu7uM8
         e4uj98i3wgQBcYW/djKTZsITx5zqKyCx9DU22Z3mZLS651F9NBNzWoFORN+R0q3JqIA+
         9qng==
X-Gm-Message-State: ACgBeo197fS3ySP2toNXnomtE/7yRPgE/6351/GcOPZ3/Rtjg0SqSsmN
        VsRz7iPK4pOqxr1Eo7bTDL0IGFiXvA==
X-Google-Smtp-Source: AA6agR7FTpMgJFFFhEJanQ9OsNJ/kOQCxwc/V8biQsMWsiREPO/EQAx7Q06z8jzX5tkWKR1sDAcACTfQzw==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:c0c1:0:b0:6a9:4913:95a8 with SMTP id
 c184-20020a25c0c1000000b006a9491395a8mr23166139ybf.168.1663019065938; Mon, 12
 Sep 2022 14:44:25 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:43:53 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912214357.928947-1-nhuck@google.com>
Subject: [PATCH] net: mana: Fix return type of mana_start_xmit
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The ndo_start_xmit field in net_device_ops is expected to be of type
netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).

The mismatched return type breaks forward edge kCFI since the underlying
function definition does not match the function hook definition.

The return type of mana_start_xmit should be changed from int to
netdev_tx_t.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9259a74eca40..dfecef8c08e5 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -128,7 +128,7 @@ static int mana_map_skb(struct sk_buff *skb, struct mana_port_context *apc,
 	return -ENOMEM;
 }
 
-int mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	enum mana_tx_pkt_format pkt_fmt = MANA_SHORT_PKT_FMT;
 	struct mana_port_context *apc = netdev_priv(ndev);
-- 
2.37.2.789.g6183377224-goog

