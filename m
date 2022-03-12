Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D5D4D6EFD
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Mar 2022 14:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiCLNau (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 12 Mar 2022 08:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiCLNar (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 12 Mar 2022 08:30:47 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A107B199D73
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 05:29:35 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6147E3FFDD
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091774;
        bh=wjZwot9f8/6VteNlj7+yTRpLXeLfeCZvZ3XmJn6m/ng=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ogGpGtb/e9I2e1GqSFxKV8RzxOuOTRko+89JpYq13a/reedfN8tYcDS9K03UkwE+k
         +Rz5UmYEPBme/HDb8Lasx+9qZUGdJzEy4mK+konLERQffIUoqxWin9X3QlhPgXqRSv
         8cPzdzXNVP648Sjkb4YdkbRWksSfOHwOoZAUIvkS5JIV21HwQ76lOBunvFMXycxzT2
         70oTELU90wOSvSqXCvuUzquf47ToBGgx1T1LWyy/32nv+6yj79kxrdCXiXngjggKH8
         Bjon1jdcrLG07N4DgBaFnqQhGW7FO+94Ym/z9ywoqRpbwfncHv32D9KXRVhFPJeGv0
         O6J5VHYqS3S4w==
Received: by mail-wm1-f70.google.com with SMTP id o21-20020a05600c511500b003818c4b98b5so3547529wms.0
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 05:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjZwot9f8/6VteNlj7+yTRpLXeLfeCZvZ3XmJn6m/ng=;
        b=EiZk7ESs0uaSLvH/lOsA+zCTiJB0+OmtCcS9bqByrIdYZmvuvk/I4lnIm89mb2W7nl
         nQYvx7SiyBl96SBUhflTdPh0StddF+IiokPNUbqgxbJQMYGSzv6iEnf/W34qoGnY0gbd
         8WJHY2yNGDvxG2LcfLspC+VOQRT1ugfuIIOMmj8VZXVLVt7a9Nc6wQpz+5FxqLV1SxJt
         RrcpYmKd2hEVD/do5LXOhaAcOG2c0d4NMybOv1j27Jt6rIsk/AYexOcN65h19R6U53Lp
         E++oWU2puoMFNtLkxp9A24l5TjXp7blL+ul2O9rrxvbsi7JUcX5v0IsJx3FGm7rTdyFu
         3Oig==
X-Gm-Message-State: AOAM5306+BHI0sPtWpYVo/l5Lp8OTmFlnL5Q2SFpkBAnDC1duVp88uJT
        r/tbsAzGKAqddnXOMd4lbNjuJD3eqsQXazq/MYwci4jybAJl1zJ2n6dStXQOq025R+51afZAe22
        LkruQGkdkyQ6KDPKjpaWcsWz6pEDWpFOGSixDXZd/fA==
X-Received: by 2002:a05:6000:1d89:b0:1ed:b6d5:cbda with SMTP id bk9-20020a0560001d8900b001edb6d5cbdamr10364661wrb.514.1647091772817;
        Sat, 12 Mar 2022 05:29:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyelFNDw+KjZ7SCVNW/uSQN6y5Cx82RSy4B7GdAXYbkw1fNE1IGPsgLOaQGJqZ3rrBpRaBuDg==
X-Received: by 2002:a05:6000:1d89:b0:1ed:b6d5:cbda with SMTP id bk9-20020a0560001d8900b001edb6d5cbdamr10364629wrb.514.1647091772632;
        Sat, 12 Mar 2022 05:29:32 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
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
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v4 10/11] slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override
Date:   Sat, 12 Mar 2022 14:28:55 +0100
Message-Id: <20220312132856.65163-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 7040293c2ee8..e5d9fdb81eb0 100644
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

