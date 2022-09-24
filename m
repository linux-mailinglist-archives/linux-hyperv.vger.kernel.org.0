Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54E65E87D1
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Sep 2022 05:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiIXDHu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Sep 2022 23:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiIXDHq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Sep 2022 23:07:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D09414DACD
        for <linux-hyperv@vger.kernel.org>; Fri, 23 Sep 2022 20:07:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso1888655pjd.1
        for <linux-hyperv@vger.kernel.org>; Fri, 23 Sep 2022 20:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IKtN884SGIzThZ/mZCoo1s2thpv1mLuefxTzikoO46k=;
        b=FlAbE9MZWxzGPuu+k1MJIaxHAf5yVuJ3T/UpZFi8DcgSIlQfZbf6V190IbrtVsRrPL
         8sMlEZLhwaFVqHellbBnkUGoZn7u5oJzHePipXuNhquffKhskmvVCfIuTvIsth8aHXoB
         O+9ydyZw79rKs1+rdHr0JmyeJXX/cQLpr7LFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IKtN884SGIzThZ/mZCoo1s2thpv1mLuefxTzikoO46k=;
        b=m8jR4p2Gay+OCHNS/i3VIXfPLmOMKpnOwyMlGAvWvoY2HMuizKc1rwPx7GWSAablLD
         IjQb0mEe87/Z4zymnFo6bFO1OBxRm5VjYnWMhJJVeR3IPWC89NQDj70ZPhQ0gdP4aPZf
         xeu3OWvfXdzUjvYA7PjjaaFYFQ1h3VLA+1aE/TeEyVkzyMG4SYtKk2/4WH9OqaYvzq3O
         8Vtxs/UFmUtf6rJodzbCs/RyMLPQu9OSMhyJvzXpZwhQUklsNnewxfm1+1wfC1TRHX7T
         ytS3H2sj1PvpK8wVKsKQci8Ai5bQUp+D8g6xGz6lfOCE6bU7hXBaMdX1/JV7TqPIu8s7
         MNwQ==
X-Gm-Message-State: ACrzQf3UJw6kA+rAtsr1LLBeVcx+rq2tEIO+Zc+z8uFH1db596Z3Buzx
        RlPeI9V5exMjUV0YVMUFWIa0Pg==
X-Google-Smtp-Source: AMsMyM4xeWiO9hxnieusSOMYxL3CDhWH1EAfQ+hXla91iYRHTUdt0JX80iN1Apg/jZYW55gbb7dsOQ==
X-Received: by 2002:a17:90a:64c8:b0:202:6d4a:90f8 with SMTP id i8-20020a17090a64c800b002026d4a90f8mr13260584pjm.11.1663988864687;
        Fri, 23 Sep 2022 20:07:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q19-20020aa79833000000b00540c3b6f32fsm7128298pfl.49.2022.09.23.20.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 20:07:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "K. Y. Srinivasan" <kys@microsoft.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: Split memcpy of flex-array
Date:   Fri, 23 Sep 2022 20:07:41 -0700
Message-Id: <20220924030741.3345349-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; h=from:subject; bh=7+JpelBNpq5Fw7aAx9OdfzO7liLVsPVR9WciMS4r/NU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjLnR9wwp6bolWrhQnItcWX3Mum1QtC8G4uZsAS92B C8WkhqaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYy50fQAKCRCJcvTf3G3AJpIbD/ 4o9CL5W3GD7T8nYy9vURy0GTTRdPcnwfkEBkvSaBS+6Z047JJXm6JqxYu/4Lj0AMUpOilsKpZIcNXl R6Fro9YcKKMxsPodqIQAc/OFDFje/l3feGhMAHiETi/a5uErOeUJ2MjdCNa5AHSbiaEcB/Es7qj83K DRp14VcgSN5krKbp/6hzYptKDoOt1B0Tf6pGwecGCVT+x/Hphs5UT6pqGhlCsmArMSAI4peTWppE17 fhKWhEmQQDcPquyhachSwTqTdXtCd1XaluRb3veUn6hRKIjC90NamtF8DTyNPMo7LAbnpHj4ydrRR2 FzP5KnEnTTd1xPt3KZ9aAIkZluItICRn/hqfNPCgv5ZsZ0Ynqwn3b9/JWOCOJNxvUwavjeLswrCgmS Lw6nffnf55NJCKMDWgptuaynCK1RMelbVckcZTasi88pRe0zhsRnC5LNad/z8SzY44y7ry5r9Lha5o LFlw3gW16kUMMgUamMJh8SPz+P4JhPTQUUY/yVC6jSsaNbvHicYHFsLBn2XCLveCpBZAYOyNWfYaj4 uYgO8LgNb1aedi4QQ3qaCyVBrjmlPqWqH336vwOA3yaxn8WiippB5r+wH+inl4MwIsG2Dj78qimr1T U4yM40JKYUupXDXYiB5ZUNYZnEV9aC9dcpEQA3ibZ+WuJOfIwgCZjnFc7pCw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

To work around a misbehavior of the compiler's ability to see into
composite flexible array structs (as detailed in the coming memcpy()
hardening series[1]), split the memcpy() of the header and the payload
so no false positive run-time overflow warning will be generated. As it
turns out, this appears to actually reduce the text size:

$ size drivers/hv/vmbus_drv.o.before drivers/hv/vmbus_drv.o
   text    data     bss     dec     hex filename
  22968    5239     232   28439    6f17 drivers/hv/vmbus_drv.o.before
  23032    5239     232   28503    6f57 drivers/hv/vmbus_drv.o

[1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/hv/vmbus_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 23c680d1a0f5..9b111a8262e3 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1131,7 +1131,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 			return;
 
 		INIT_WORK(&ctx->work, vmbus_onmessage_work);
-		memcpy(&ctx->msg, &msg_copy, sizeof(msg->header) + payload_size);
+		ctx->msg.header = msg_copy.header;
+		memcpy(&ctx->msg.payload, msg_copy.u.payload, payload_size);
 
 		/*
 		 * The host can generate a rescind message while we
-- 
2.34.1

