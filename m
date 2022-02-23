Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14EE4C1BAA
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 20:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbiBWTOv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 14:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244258AbiBWTOs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 14:14:48 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545293F8BA
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 11:14:13 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2BD6B407C7
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 19:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643652;
        bh=rf7a9EFQwPOyocENu81tYUT+5dnJvDmCZPPvLR/17AA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jnbXwRecqkUm9u4RdFAzYSNjpvIVRyztve/CeK/5IYnbAW5WmNjKfPWJzYoRyLN0b
         RCsfSpKLE7XBQRJHCYb007CMZ5OtWg1Y/E7+zBWg2HDU3Pqopgf4teYl5sIWO9CF5c
         GOhUcJHEgVeUPYynEwF5d2WUiEqXs0LyLMBkLsoEiKSBH3C+Bdqj+NMj4SRpLB1R8C
         /n2WVgACkYe0QXnV+nd+tDYfG9c33xkG0/oGLXiQ3Xkz74yrzSD+5+BhUoc8SI4X74
         P/GVPhOOG5HAP00B1iA3PV/nKciOj6lVtjwYeIG308nctqZrEXgOsEJDiXMludYap3
         OvrV6LMyU6sGw==
Received: by mail-ej1-f72.google.com with SMTP id qf24-20020a1709077f1800b006ce8c140d3dso7494646ejc.18
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 11:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rf7a9EFQwPOyocENu81tYUT+5dnJvDmCZPPvLR/17AA=;
        b=aQHaT6Ixzq2B4De2HzCUDCllbcmMeHV/9xtXSzT3Lucx49WVJy6bHuCS9gV+AlJQbq
         /yz7Xkyuv8YJfewGrTe1lblWdpdqI3J6btU6iE985p4+iSLIYS3oX7phUl/YNvd1a94b
         +m89sHfNT8HPtdjGrMBGVAmitAaDfapthPuk4hjh590ZXvgZdXF7MXVMhl9H4rEr4taE
         AuwXl6OSR/5I1htcsGtBy++Tb5xCLsY9rOADjMMR2yleT3t67bielKA0uBpMSvzeJzzM
         A9S8RtAND28bac4k0/CXU4FMlsU3tkFvjruM3WiR25YB68F9J3zkjlnPlLhgN3EXBorO
         it9g==
X-Gm-Message-State: AOAM533SpGflE/dVhF/469zaNWVVgnM2W3fq+D2uyr3i6j+DdvsZkwq4
        16nIJmBtiX8BBx91T6Xkq5ov8vEQJVWQLkGEuKuEJVon8dPIu0Fmz1KGck6mZOixURTZIlSwIRz
        HqCtuTm764uf4Ekd3lz5UUITQ2wJV8Jt4yjg5eeIcPQ==
X-Received: by 2002:a17:906:e244:b0:6cd:24e3:ab8b with SMTP id gq4-20020a170906e24400b006cd24e3ab8bmr856438ejb.633.1645643640107;
        Wed, 23 Feb 2022 11:14:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXgfLS9GHyX1kCvT/o1Mu24QLFIsYnwLPgsBOYcxKH/GiFu7jQtQB6sjAsK4TU39w3xnST4g==
X-Received: by 2002:a17:906:e244:b0:6cd:24e3:ab8b with SMTP id gq4-20020a170906e24400b006cd24e3ab8bmr856416ejb.633.1645643639914;
        Wed, 23 Feb 2022 11:13:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id q5sm212611ejc.115.2022.02.23.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:13:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
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
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 05/11] pci: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:13:04 +0100
Message-Id: <20220223191310.347669-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Use a helper for seting driver_override to reduce amount of duplicated
code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/pci/pci-sysfs.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 602f0fb0b007..16a163d4623e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -567,31 +567,15 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	char *driver_override, *old, *cp;
+	int ret;
 
 	/* We need to keep extra room for a newline */
 	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
+	ret = driver_set_override(dev, &pdev->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

