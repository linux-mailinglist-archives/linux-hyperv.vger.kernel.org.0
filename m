Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D4873FED8
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jun 2023 16:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjF0Oqr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jun 2023 10:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjF0Op6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jun 2023 10:45:58 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1548835A6;
        Tue, 27 Jun 2023 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rUzmkjTakIf1l5Hdr1TLtSGZWZezFJIK9Clkpx3VPN4=;
  b=YU2muZyAimuOaNCN/40I/rQBJ4UKO7cZzX4Ns4xfMNxcNtf60stG8vLV
   OUQT7SM9PQDqEiNQb+GJRV7tsNdaMhbSut5FfSyOzxaZDsiUfbnN8/yiX
   zL2fR+ESjZuSBV6CTlVOC54xtEJBTZW28IAqKnqEDsce1t7x/6m+mZ0e+
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="114936345"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:43:53 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     "K. Y. Srinivasan" <kys@microsoft.com>
Cc:     kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/24] net: mana: use vmalloc_array and vcalloc
Date:   Tue, 27 Jun 2023 16:43:37 +0200
Message-Id: <20230627144339.144478-23-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230627144339.144478-1-Julia.Lawall@inria.fr>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Use vmalloc_array and vcalloc to protect against
multiplication overflows.

The changes were done using the following Coccinelle
semantic patch:

// <smpl>
@initialize:ocaml@
@@

let rename alloc =
  match alloc with
    "vmalloc" -> "vmalloc_array"
  | "vzalloc" -> "vcalloc"
  | _ -> failwith "unknown"

@@
    size_t e1,e2;
    constant C1, C2;
    expression E1, E2, COUNT, x1, x2, x3;
    typedef u8;
    typedef __u8;
    type t = {u8,__u8,char,unsigned char};
    identifier alloc = {vmalloc,vzalloc};
    fresh identifier realloc = script:ocaml(alloc) { rename alloc };
@@

(
      alloc(x1*x2*x3)
|
      alloc(C1 * C2)
|
      alloc((sizeof(t)) * (COUNT), ...)
|
-     alloc((e1) * (e2))
+     realloc(e1, e2)
|
-     alloc((e1) * (COUNT))
+     realloc(COUNT, e1)
|
-     alloc((E1) * (E2))
+     realloc(E1, E2)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
v2: Use vmalloc_array and vcalloc instead of array_size.
This also leaves a multiplication of a constant by a sizeof
as is.  Two patches are thus dropped from the series.

 drivers/net/ethernet/microsoft/mana/hw_channel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -627,7 +627,7 @@ static int mana_hwc_establish_channel(st
 	if (WARN_ON(cq->id >= gc->max_num_cqs))
 		return -EPROTO;
 
-	gc->cq_table = vzalloc(gc->max_num_cqs * sizeof(struct gdma_queue *));
+	gc->cq_table = vcalloc(gc->max_num_cqs, sizeof(struct gdma_queue *));
 	if (!gc->cq_table)
 		return -ENOMEM;
 

