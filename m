Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3975ECF2E
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Sep 2022 23:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiI0VRl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Sep 2022 17:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiI0VRk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Sep 2022 17:17:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3509A1E4581
        for <linux-hyperv@vger.kernel.org>; Tue, 27 Sep 2022 14:17:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c198so10751956pfc.13
        for <linux-hyperv@vger.kernel.org>; Tue, 27 Sep 2022 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=cydRrAXNrnz2QJt3HhI/oDQUhvWbTptDnL6JHpq2qQc=;
        b=ia988LVuGHoaQOtrO3JTaarvPES0PVZQjF+yQ0nipRZxbfbJTvS2jxkCM0uJRn8tse
         AWhfuK6TaHGGqhM3FAR+1X1SUdV2RZu9KrbGFgepq4nqS9AITiMA5bj1DWqnEkHoZx8U
         Cj/lsQb1q/QCjS2znmx56BNCoxBs60er3f7ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=cydRrAXNrnz2QJt3HhI/oDQUhvWbTptDnL6JHpq2qQc=;
        b=PTy/EXz8SUwlyo8TIwMx9xBjc5PTuvP3xi1eRxqbs19Gjk6uJBH0dtYSghCMpvzxtf
         dH+UfWAzH1Nre/u1/F3Da/woo0uMmlcVuamb+TYbUVooM/BbWZcsr6gT432B33ld8IgS
         QP8/4PLIRkntBJepsNBtrbA2LeKxgCyzBuS9UrtGvbonpgsoySUX26WP9NVULIeCWklV
         +exvfL3kHrgThSNdyMhFXrQIQJO5JRUVRwAFFg1JwgB0zFhY6A0CY4hfqH4kYZUURvTB
         9XEbDzbAPeSqhqAWaaP/tF8Xxr+qL1r5SAeoVey5uhgDdFqnOUDSeb0FFmB6SkNBRnwi
         B4FQ==
X-Gm-Message-State: ACrzQf1i9uK70b8H4X++5tGPyLkHwk3JAdkPRG7WgxUVQAhsd9HCtK/t
        /aDLSJDvRzkkntY0dZm/dyG64w==
X-Google-Smtp-Source: AMsMyM6UvPDq6Az5WzE85o+8nP76tiSk8VyDwK6qO6HPO4jdxKcY04RZzjmJdVhjJK1k+dJQbkHrJQ==
X-Received: by 2002:a63:fd41:0:b0:438:7670:589a with SMTP id m1-20020a63fd41000000b004387670589amr25879313pgj.148.1664313458698;
        Tue, 27 Sep 2022 14:17:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b001782580ce9csm1983194plx.249.2022.09.27.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:17:38 -0700 (PDT)
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
Subject: [PATCH v2] Drivers: hv: vmbus: Split memcpy of flex-array
Date:   Tue, 27 Sep 2022 14:17:36 -0700
Message-Id: <20220927211736.3241175-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2152; h=from:subject; bh=XiqD42BdKyYFPsQFvFZgiN4gYsXqcM5zpVjMzTZBEGw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjM2hvQmM6bsQ+jbJ33l/yJApmN3Z4lyCdAL8/RqG6 TtquvhqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzNobwAKCRCJcvTf3G3AJtW1D/ 43JvAeQ5s9E1h+J9RViO3kPVtz/NCuYZdH/+J81jrc2/5zhmshQDgYYYhr7G9/KORTKAN5d3sm+77V BbMU9kLgdyBKQdmSwajxah8jCQii28sDcMqXTPA3HWUf6/Z20m1JFvH4BY7szJgBy7qpOmwwFhlPs5 7cAkt1+u/2vz00NUZhUDY5uPS+Ane1qWS5OKDAvN59kJBVjxmlmB3xDUDIakJ7DGhA2UF6TKjlhbwg gTtpbFjHsAyjkL/hiWFM0OXr8uM+OQXGUbO3Yh9i2Na6U5YaxUsVdP7rMu8ctGztG2jFhXtV4fhCzS BRab8/In/tmLZBqJRODltAVxuUBzMHv20lR3h0P58zG4dlPHkFrnfuZ/m1nzIl8DqERgs6/QJGI6LC YKkLz6HeYlmSfX1BOK4+RXFwU3Tio3XUtvFX/M76RvFkYaRyIiC/X6jKbau8yTg8PRlzb4JvklRR+F JHx9mz06A1VlP5O+0DAjR01n33fPrARIYCIJSVv0urfp4O3TxU2Z72kgrCpAD38/ghYeHFQY2IiTRY ihlxCoAWRx4Qvk3sDy3Bts7ObIr/uipTCDjPQW+9kBZexc9+9bbaVhJKXGzp3dPfGu7W5USpjNetNr Qvgs7TIquSl/3q0c8FDzaD83BI9/muflLEx53YAfnXitnHrOPbf9wVWhDCgQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
so no false positive run-time overflow warning will be generated. This
results in the already inlined memcpy getting unrolled a little more,
which very slightly increases text size:

$ size drivers/hv/vmbus_drv.o.before drivers/hv/vmbus_drv.o
   text    data     bss     dec     hex filename
  22968    5239     232   28439    6f17 drivers/hv/vmbus_drv.o.before
  23032    5239     232   28503    6f57 drivers/hv/vmbus_drv.o

Avoids the run-time false-positive warning:

  memcpy: detected field-spanning write (size 212) of single field "&ctx->msg" at drivers/hv/vmbus_drv.c:1133 (size 16)

[1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: - fix commit log, add tags and exact warning test from Nathan
v1: https://lore.kernel.org/lkml/20220924030741.3345349-1-keescook@chromium.org
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

