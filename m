Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2904A4F0C2F
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Apr 2022 20:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352311AbiDCSlm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 3 Apr 2022 14:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359871AbiDCSlF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Apr 2022 14:41:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED0C11154
        for <linux-hyperv@vger.kernel.org>; Sun,  3 Apr 2022 11:38:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n35so4631256wms.5
        for <linux-hyperv@vger.kernel.org>; Sun, 03 Apr 2022 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za2ChgFa2MAb73hYI38RRAcoAzGnc/qyPQX8xgHdvQM=;
        b=NL0iTDdwYILas5e8no0oNpCa4PGm56oi2gs6Ima+ni2rAfmat5iF3ezJSbq4RfY5Wy
         seOcJlWOR1FYkb6joSmkvy/3ivMqQNHWCH4ihBK8+2yEHTLQm8HDq18hmNGFuAcd6xHK
         zViUuRxkF2ULgoz+NfPfi7GjvimyfKToTVwwOlZAmY2fKbW6nuo6IjKlJjXYhTluPsNy
         iuNzgI2gotaA7puE+gawJl/6nuoM9g3bhpncBY0pNs0vhaAdS5TsvX9Y/Z2DSOW5pMHr
         kQ/oJGH6Ba+QfJUn5Q8FrDGAfB9Ttl1ntCJmnTJ5uX/vI7MYePpL/Gmi92cw9JhfaNZN
         Yk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za2ChgFa2MAb73hYI38RRAcoAzGnc/qyPQX8xgHdvQM=;
        b=lOjQAQVsOCUDU0bGfWNR+1zWHkPlFlD9J7Te3ngpAliSDFCbc43qHhhjgpBBUEuryV
         3NaNcuf1NEfcs/Boi774Qnj/mrvmGd/SBqYGNV0yFKaswjRD6o8RieTWQB1c1lbWr3vD
         NQ6qVSuotmQQf5Tr/JoU5/CllundLs1CcnHuu/AIYLMtlF31YzBaQMmQNeMj1lxpzmq5
         OreD+/BsVVQQedcJ6Den+X3Iinccbt6l7EhxZzYQs4JFr2dYVupTXXcq66/avBSKMbqP
         mn2ahuVHPk2VAdT54jKcNR8OSKgnrpR0dinyIoPRSr2jTpzlrMDhBrPzkA0VpgAoHIWw
         fMYA==
X-Gm-Message-State: AOAM533/DKhG1OgOF3mUKZO3ibrhFshAVb0oLqZlsiui5VEHlmJCKga1
        JDdozYqYiglXRIRkw3jAiKbVnQ==
X-Google-Smtp-Source: ABdhPJwn4Pop9jbCZKW264sWdvAlfR5X/MDrNqkj1NFdBBgFgDY4WLAE8Xeeikrkp3VburmLaYc0tQ==
X-Received: by 2002:a05:600c:354d:b0:38c:e71a:c230 with SMTP id i13-20020a05600c354d00b0038ce71ac230mr16387449wmq.86.1649011110782;
        Sun, 03 Apr 2022 11:38:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm593851wms.13.2022.04.03.11.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 11:38:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 10/12] slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override
Date:   Sun,  3 Apr 2022 20:37:56 +0200
Message-Id: <20220403183758.192236-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 0f29a08b4c09..0aa8408464ad 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1434,6 +1434,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 	const struct of_device_id *match;
 	struct device_node *node;
 	u32 id;
+	int ret;
 
 	match = of_match_node(qcom_slim_ngd_dt_match, parent->of_node);
 	data = match->data;
@@ -1455,7 +1456,17 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		}
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
-		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
+
+		ret = driver_set_override(&ngd->pdev->dev,
+					  &ngd->pdev->driver_override,
+					  QCOM_SLIM_NGD_DRV_NAME,
+					  strlen(QCOM_SLIM_NGD_DRV_NAME));
+		if (ret) {
+			platform_device_put(ngd->pdev);
+			kfree(ngd);
+			of_node_put(node);
+			return ret;
+		}
 		ngd->pdev->dev.of_node = node;
 		ctrl->ngd = ngd;
 
-- 
2.32.0

