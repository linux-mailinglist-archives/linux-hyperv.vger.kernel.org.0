Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F004F0BF7
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Apr 2022 20:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352867AbiDCSk1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 3 Apr 2022 14:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356291AbiDCSkY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Apr 2022 14:40:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9074739832
        for <linux-hyperv@vger.kernel.org>; Sun,  3 Apr 2022 11:38:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v30so3556354wra.8
        for <linux-hyperv@vger.kernel.org>; Sun, 03 Apr 2022 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHITSW/sgmw/Csyhuirx5ijnYnrGvi4Rk0KXIhii9OU=;
        b=wXR8rp03DHc5wiUfBVAB5Nuh3XfnaYvUKqmtsWXgN+spI327pZeGN4sfFkdlAQO76M
         2Cq4PgoxUbVzR/c9uRlXxz3+QdKUn/21Wzs/zg2COGsRcw1TRvCt0E5f9P+PkVHqjkIF
         5Z76p+imRzuTlBLLDQ4l3jK+NlPnSdBryKK85hZDKBO3WnYbq5zwPHKx5DfZjuhQ9frO
         S3PY5QFr5UDBVY0KyfpgE5rFn2xr2i2goIgkSwFjKbQy5Q6+DDtCUKaI752vs/DB6ull
         LkXlxwq1hvPpFZCtBRdrxC90gtIPXgjfEPN4yaWbYrGQdjQBBZpMFI1q0uaCqYVzm0pN
         yxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHITSW/sgmw/Csyhuirx5ijnYnrGvi4Rk0KXIhii9OU=;
        b=jBumiSVsozXrclTDDIy3y8Flw2nWSeYN03PTyqyWvgSo5pwZG2CtcisL1yROUHIA4I
         wxhMnm+FgPzZ+mLcd5100+fD/v6eVzUrklfKf73ajqHUOSsm81b7vbJ2zqCTpyXMrnY0
         jFAcTXg4FIMpGxOaMSh9qEgdAGAkgoNAd0I8yn+fgCSc/T8pSgtQMHLXZDdW+D83js/a
         yP/yFjj8n1wZIQ3GbWdDIa6+LFZ7Msajn/PE6Cy5WU515UcgSAGmCZ7QUgZRtHsW3j1l
         Wg0aI8XJ8w/9Bs4Jo7f3SdbJDTQpiQUs+UJkJCHQVpwVgvySpFnpeMgI3mpJXqEog16N
         kGAg==
X-Gm-Message-State: AOAM533OpfLDTq4WOaZAMPdQ2/XXm4K2MPyoVsMYYqdC74jm1yg1x9oc
        w9z8zePV5uVU/CX7XmYv3qhMhg==
X-Google-Smtp-Source: ABdhPJwOqH/2Zj0N+LpYA2eXErN8ibqekikwBYmO9ZTvoOA6luonqgG5M3X9CKaUCELKOTnyoNhzag==
X-Received: by 2002:adf:90cf:0:b0:205:fdb4:92d1 with SMTP id i73-20020adf90cf000000b00205fdb492d1mr8369733wri.468.1649011102158;
        Sun, 03 Apr 2022 11:38:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm593851wms.13.2022.04.03.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 11:38:21 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 05/12] PCI: Use driver_set_override() instead of open-coding
Date:   Sun,  3 Apr 2022 20:37:51 +0200
Message-Id: <20220403183758.192236-6-krzysztof.kozlowski@linaro.org>
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

Use a helper to set driver_override to the reduce amount of duplicated
code.  Make the driver_override field const char, because it is not
modified by the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pci/pci-sysfs.c | 28 ++++------------------------
 include/linux/pci.h     |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c263ffc5884a..fc804e08e3cb 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -567,31 +567,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	char *driver_override, *old, *cp;
-
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
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
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60adf42460ab..844d38f589cf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -516,7 +516,11 @@ struct pci_dev {
 	u16		acs_cap;	/* ACS Capability offset */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
-	char		*driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char	*driver_override;
 
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
 
-- 
2.32.0

