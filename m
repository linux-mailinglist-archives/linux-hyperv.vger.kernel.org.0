Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22BA611622
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Oct 2022 17:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJ1PjI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Oct 2022 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJ1Piw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Oct 2022 11:38:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592741EEA2F
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Oct 2022 08:37:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d24so5162183pls.4
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Oct 2022 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eiqBfvbdDwTczEbRcWCEJAlwChtlxKvOlsrmYnYTyYM=;
        b=eW1gfL76x0LYJJO0JYJIlhrtiPoCOEjBBxJhU7NsC5yNYhbhuz1PnaiHybH1fCCnxh
         X0G9C14Xt68ydVZ70g5dpiVEXs/UnTgJ7OkzUwKPa/mR/4Lct8TgWadhFugi/ZBCaqwW
         gqPoHZJpOGMliF3+DEa+B8LhW5kLBjf4RwOo5c4d/5Vbcs7MtokVk6DjoKSMqOi6ifNn
         okT2sFcvAaigJTJRmYQAhT4AEcSOw91RsSGH/XIszZvIKzSLoV4uX9C2yhJnTspD0SSt
         m6ONUN998ccPowBoPGva9cfB2XkZ0piA+30u9ET30zHPll4cLIIVK9OBXLARX49Buou6
         KPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiqBfvbdDwTczEbRcWCEJAlwChtlxKvOlsrmYnYTyYM=;
        b=adIGgZLIrx76/CXecem69xgolJl+s4CJ2gorSLcnJyfKrsooC248GxZyY0b20r4HEq
         jJIkeZfLrNkrA9C2GaUbBP73wNkrSyYIzZ7ChfCnGvWJ98SW1eyyw/qgnUkDBSmobT+H
         x8kP4YmygS4u+/zDRnW/+caEl7uO9203wD3ACv3P11R0MoCS6Kb87ugY0tq5YpIpsWmR
         Pce0tFZeFio1opZeUg8JnczOWA3sjR3pMH9rCEYetl5l2QnAz4kwgioJq03+PFTn3u4C
         xLsfUd7ThFvU3zhfFbBfPdX/8+gmB2qnVKxSSIUepwK7J3ZUFsP3RKiw9XzAP7pDUkHU
         pi+g==
X-Gm-Message-State: ACrzQf3/giXXOKIBceipw4nBBfwAC9iKRMtDocDPuK5CBbNGLXbI+zEp
        wbjsFAzAz+b/3z/jYV8SaMRHVmXsfm+D0w==
X-Google-Smtp-Source: AMsMyM4dLAUCnxWIaXu2uvEo+AT8heskLe9k4nj7ioC5AZBgSvZpdJze1T9Ot17PiRggI6mqs22Eqg==
X-Received: by 2002:a17:903:1d1:b0:17f:6494:f8c3 with SMTP id e17-20020a17090301d100b0017f6494f8c3mr55086201plh.157.1666971474555;
        Fri, 28 Oct 2022 08:37:54 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090a318a00b002130ad34d24sm4471753pjb.4.2022.10.28.08.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:37:54 -0700 (PDT)
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     kys@microsoft.com
Cc:     wei.lui@kernel.org, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] MAINTAINERS: remove sthemmin
Date:   Fri, 28 Oct 2022 08:37:42 -0700
Message-Id: <20221028153741.25470-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Leaving Microsoft, the Hyper-V drivers have lots of other maintainers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bb30c0d1cb4..aee66010bad6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9504,7 +9504,6 @@ F:	drivers/media/i2c/hi847.c
 Hyper-V/Azure CORE AND DRIVERS
 M:	"K. Y. Srinivasan" <kys@microsoft.com>
 M:	Haiyang Zhang <haiyangz@microsoft.com>
-M:	Stephen Hemminger <sthemmin@microsoft.com>
 M:	Wei Liu <wei.liu@kernel.org>
 M:	Dexuan Cui <decui@microsoft.com>
 L:	linux-hyperv@vger.kernel.org
-- 
2.35.1

