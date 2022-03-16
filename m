Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575C94DB3FE
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Mar 2022 16:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356913AbiCPPH7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Mar 2022 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356920AbiCPPH5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Mar 2022 11:07:57 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623D527170
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Mar 2022 08:06:43 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3BF4A3FFD1
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Mar 2022 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443201;
        bh=JNKVE+3JexqhZeL95jpZ7AxMh5V3BiZd1u/ZcabQDj4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PpXGEeL2KG34bvUzIrHZqfhkMcX3h3wFW+DMKYGll5c7Un6bbHEHN4ru6fk0OGfx3
         gQExBY/PgVszI2zZG2oplWp2/838KjcwKsdNcQjU79vMcMTUf1RWF8f49kwjV09Fg1
         i+8FNEYJ4GQGLfssEy2oXCa/hcCNRTtvglqNBw8sYpswQSYH/LpK5kk3tPzP9EkRmz
         XvN+8ADaNDOIB9fm+qFeSZcGRK3Ojs6Od3Ihr+6BTYqDzP43+Ft4eBGtjauH+pL35W
         y8F33bI0SjF78HOS6yAkqC0/sp8l1IUTh7hbAJEzhO0CQNbpg4mlMSBvD81KiZBQ3Y
         z6aG7cHUstgkw==
Received: by mail-wr1-f70.google.com with SMTP id j44-20020adf912f000000b00203a5a55817so657988wrj.13
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Mar 2022 08:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNKVE+3JexqhZeL95jpZ7AxMh5V3BiZd1u/ZcabQDj4=;
        b=nJ6YxmmnI4Py+9IaXvC8qs+lp7B+8worpYR2rmqGQ5ixEGpCl3HaqUXXzfndhXcpGi
         OHAy41QYGFkQ1AZj+3UuS3JulX0YaDkJTtB2shTBhw3naAuqUC4EWH0t0iFf+/XNBzIu
         J2Uek4ndU8z7GSaW3WQZhcHO1oE/l7a0Kggo4KTTWVnKlhBt7DBXqfnArF7lWkZVBbWh
         NLthfBsgXxBIq18neQCTK3EPSVYfkhGr7ULVQrk3QGYmdslYf+foTUj/12neYfPLDXfe
         TR+iD0yJB0KxVkQfA11q3xj/Qpno24sNxuNnGZxa2f5Oy7oOuDmCZEoo4GTOWAQZrDo3
         l+3Q==
X-Gm-Message-State: AOAM530A/YkbuZzXkJXIqTeWso+OxXTuzRy8X8bAsw0GW3cKpKN52ZWW
        HG6RAmFZLeCLMW3zgvgom2USRp1Dgsyi/k2OSTDjHtOtLiVQfOG8qJ8RVvY9arwsC5M8vB0sVlh
        uk7lBhBAqeuHSKkDvs8CeTqfsaQbROfksM4btWb2RgA==
X-Received: by 2002:adf:e6c7:0:b0:1ed:9f7c:c99e with SMTP id y7-20020adfe6c7000000b001ed9f7cc99emr338972wrm.0.1647443200064;
        Wed, 16 Mar 2022 08:06:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCUhxAKawe3MPuphaitMx3nXTnkxh9V6g1RJgrcVXBEtRF7kgts/Kf4MtPXL4nFMNuuGjZig==
X-Received: by 2002:adf:e6c7:0:b0:1ed:9f7c:c99e with SMTP id y7-20020adfe6c7000000b001ed9f7cc99emr338940wrm.0.1647443199883;
        Wed, 16 Mar 2022 08:06:39 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d59ae000000b00203dcc87d39sm3130155wrr.54.2022.03.16.08.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:06:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v5 05/11] PCI: Use driver_set_override() instead of open-coding
Date:   Wed, 16 Mar 2022 16:05:27 +0100
Message-Id: <20220316150533.421349-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
References: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Use a helper to set driver_override to the reduce amount of duplicated
code.  Make the driver_override field const char, because it is not
modified by the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pci/pci-sysfs.c | 28 ++++------------------------
 include/linux/pci.h     |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 602f0fb0b007..5c42965c32c2 100644
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
index b957eeb89c7a..5ecbb845aa21 100644
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

