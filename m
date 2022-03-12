Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4794D6F0C
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Mar 2022 14:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiCLNa5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 12 Mar 2022 08:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiCLNaw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 12 Mar 2022 08:30:52 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2EA8C7E4
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 05:29:43 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7FED63F312
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091782;
        bh=x+DOMuEjhXppqlmSDNC0RKdzUzslcBqDhsGS9OsoQS4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BcsfsdTGa3fSV2VfmBtYMOghWZv8wZs1F5PalQVkohlgh6JeMsb8M2UUhVerFPwYg
         RP27svW0qyngsVIQYBb0iUMDmpA9r87r32CqqsgkntJer7zIHgwDTx9eyqFBaDUA+D
         2s3nCrx5xHcrUFxJ5KU60W/Ab6SQARMvNQzuOccUhThI/o5zhZyIOnui+Jcy2xtglt
         OP7dVnVjXIoi1c1BDHF0X9DeUvvtyuKIt1F5hN6EeleEizlcQtCqOudi5I5dlwJqDW
         rTN4XxsicoujntwjE9Cm7ghnlo50JW6hYafbLBg9wO48oxxeyQlar3pmlQSG+rfmVC
         Mg29tzSKKWSUw==
Received: by mail-ej1-f69.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so6329047ejk.16
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 05:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+DOMuEjhXppqlmSDNC0RKdzUzslcBqDhsGS9OsoQS4=;
        b=AXBQSy1jZVrYGQ1XOFtjSgWzwxN0CDfh9o673aLeQufPX3K89qQM34FZ5dJkmH9ntV
         NjAeTFQtwGpiI/u0aiZcptfdNjPO7OncsjHfI+m6dEixQNdARl94LMFMQBrJC4kuyDSj
         6b2WYXBW9CwX6fzvK4c2D1UHtnDpYmKmtsSNmpV/+xtUXYpRX5Qmfn9qa60hiWx9i0xr
         eaEx8BNwztxKibSh8XBdLrJiX8xZCJRakci2zYy7I21djb3Ss+Q1A61UIxK80luyIvMV
         hfsywX4KRLfssUmYFRjr4pXXzr4JjG6XusOnLVi5H6SuH5aoY9Pl+VsjFkfFa7OxpKzF
         LnZw==
X-Gm-Message-State: AOAM530CscU/0CV6o40/e7izaiPs1KZqnU1mBwz/mul2VvRFySf3YwzN
        TkPGjquE5EioXnemxWqN3I2T38Fz6+qWFGyXLbIZqhkxMtkPfVQCHFqxG2TcdxKkZNxzHEESMIw
        W4kjOlv5vJrAQpbycp780Aa2X7nJudEPPSVTvBCbXhQ==
X-Received: by 2002:adf:f44d:0:b0:1f0:49bb:fead with SMTP id f13-20020adff44d000000b001f049bbfeadmr10583597wrp.586.1647091771129;
        Sat, 12 Mar 2022 05:29:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5ufiLsjNXlLmSXpd1ewfKV/mq0TKGVtl9zvcWEFJmoAu7ZXtJo6A/7/mnNUpXOXLfNGXp5w==
X-Received: by 2002:adf:f44d:0:b0:1f0:49bb:fead with SMTP id f13-20020adff44d000000b001f049bbfeadmr10583570wrp.586.1647091770954;
        Sat, 12 Mar 2022 05:29:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:30 -0800 (PST)
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
Subject: [PATCH v4 09/11] clk: imx: scu: Fix kfree() of static memory on setting driver_override
Date:   Sat, 12 Mar 2022 14:28:54 +0100
Message-Id: <20220312132856.65163-10-krzysztof.kozlowski@canonical.com>
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

Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clk/imx/clk-scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 083da31dc3ea..4b2268b7d0d0 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -683,7 +683,12 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 		return ERR_PTR(ret);
 	}
 
-	pdev->driver_override = "imx-scu-clk";
+	ret = driver_set_override(&pdev->dev, &pdev->driver_override,
+				  "imx-scu-clk", strlen("imx-scu-clk"));
+	if (ret) {
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
 
 	ret = imx_clk_scu_attach_pd(&pdev->dev, rsrc_id);
 	if (ret)
-- 
2.32.0

