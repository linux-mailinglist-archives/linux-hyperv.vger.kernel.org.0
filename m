Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B024D6EDE
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Mar 2022 14:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiCLNa2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 12 Mar 2022 08:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiCLNa1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 12 Mar 2022 08:30:27 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFA24CD64
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 05:29:22 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 069B940028
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091761;
        bh=LvGhGHRX+cWouXlMRKBzVPzfChdflKFXN6IyahVuGew=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MFk7dBaZg6FuPBEa3uJtrLe/UA10F6rjbUWrIGMwIO1AG7hBOZyXN2Ifk4CemMvaK
         /NegvIySYhaCQGWiNB8LW46XRq0sCSzl1A8mdeApnyzEhg6ns5smnAnMohI0XXtpPQ
         Z5MSrOPFLPK1+Z52PZc1EIwygEZgMB7o2qcHxQ1SfM2AXNy2dJ0c3hXd5RYYFjUdwy
         Pt6E64WoCZlP2OZ/o0ng22diLk7Y0Ghff+2MZ0RUU4xUcmqkTsCSJxjgiRXxC5YntB
         L9P9M9DOoh+UIFGIUwWjyHTcLBsB1qr2XL7Bw8eJqUJS68FMGfuTbEbCis8ECY7EgO
         pvbgLbNnVtHfg==
Received: by mail-wm1-f72.google.com with SMTP id l2-20020a1ced02000000b0038482a47e7eso6896557wmh.5
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 05:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LvGhGHRX+cWouXlMRKBzVPzfChdflKFXN6IyahVuGew=;
        b=7esFpg/6zJ1srJIM5yR1XkZqPA4v5NsubexXFOLJv91iglhgiq2OONtV1gtkNa9fG9
         Wl0ItkophB6yyY2s/1jYucIFjngN/1nYV0PWEA6hI9IvvL8y0392l1DHp0yViC/mXSky
         jWHlIIJfuzlplKWlnKHv05Gzz6sYhdbqKgUXGjJcW+whGDPzqLeKUiwle/7OosntmvQM
         16D+Ah0utFC3XRxlmfKg7EIHdNrRqs4zzYuG8uHgtk3LWV8GqQFjhLnbVPZLiXNbIM/T
         dEKWltnYz9bHl66X2ssLe0V8ZGqi98/KK9z2OwK8pNfYEyMkV/HiEFKSLF9kMoieGpiU
         OaQA==
X-Gm-Message-State: AOAM531rNAnPYB0PGvluvFzzzQD6NlhmvEyjfl1pg1JJJ8rxaKjBAmvk
        ijL9UPRTpagioT+oobtvO7gpObk4QuMWam/+wUnq2KiVa8Jih2UFjHrS2+02HNLoEJVF7ppCywH
        Q6Qkp8+cW6yONcAwJXsrP36bxUZhl6UIK2XcEjwZLeQ==
X-Received: by 2002:adf:c444:0:b0:203:9078:47a7 with SMTP id a4-20020adfc444000000b00203907847a7mr8545388wrg.355.1647091758528;
        Sat, 12 Mar 2022 05:29:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcbUuA5Azax9SMwrH1Yx4BInTaqxjL2pAuKiWGJSR5gaJ62UjEiFqy7nmiSZn+2WWM/iG5SA==
X-Received: by 2002:adf:c444:0:b0:203:9078:47a7 with SMTP id a4-20020adfc444000000b00203907847a7mr8545367wrg.355.1647091758331;
        Sat, 12 Mar 2022 05:29:18 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:17 -0800 (PST)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 03/11] fsl-mc: Use driver_set_override() instead of open-coding
Date:   Sat, 12 Mar 2022 14:28:48 +0100
Message-Id: <20220312132856.65163-4-krzysztof.kozlowski@canonical.com>
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

Use a helper to set driver_override to reduce amount of duplicated code.
Make the driver_override field const char, because it is not modified by
the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 25 ++++---------------------
 include/linux/fsl/mc.h          |  6 ++++--
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..ba01c7f4de92 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -166,31 +166,14 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
-	char *driver_override, *old = mc_dev->driver_override;
-	char *cp;
+	int ret;
 
 	if (WARN_ON(dev->bus != &fsl_mc_bus_type))
 		return -EINVAL;
 
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
-	if (strlen(driver_override)) {
-		mc_dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		mc_dev->driver_override = NULL;
-	}
-
-	kfree(old);
+	ret = driver_set_override(dev, &mc_dev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 7b6c42bfb660..7a87ab9eba99 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -170,7 +170,9 @@ struct fsl_mc_obj_desc {
  * @regions: pointer to array of MMIO region entries
  * @irqs: pointer to array of pointers to interrupts allocated to this device
  * @resource: generic resource associated with this MC object device, if any.
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  *
  * Generic device object for MC object devices that are "attached" to a
  * MC bus.
@@ -204,7 +206,7 @@ struct fsl_mc_device {
 	struct fsl_mc_device_irq **irqs;
 	struct fsl_mc_resource *resource;
 	struct device_link *consumer_link;
-	char   *driver_override;
+	const char *driver_override;
 };
 
 #define to_fsl_mc_device(_dev) \
-- 
2.32.0

