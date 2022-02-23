Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB24C1BD9
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 20:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiBWTPy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 14:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiBWTPy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 14:15:54 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10123FDB5
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 11:15:25 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 21B633FCA5
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643724;
        bh=7IYTHmQXzsIW766tCpVJPfNTfO+AmvxjDRcTslL8YGA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=awSj6NnOb7dvWb+268pcpkaHl/Hy5SRre0u7RG2tgOhEaBPQvNB7o/xPvraygufJx
         mWLcwMFouA6HzRUlrBUMo0ACHt10trCtoV/EvGX1bekrVeyojmkIQvWb93GPWAfFmu
         0IRuA0zFSnTqswk0VmSdTi/xUVdZNm/dNcyEBCO5magr/9QIlSGlilGgBfJHR8HjFj
         p6Ll0SDMpiF56BsJc/vnPqENXmqi1L+zpQCvCHGnRANoAMIlzpwdtxRpIUi+5bKYVE
         vbdHBxoJkp7Z4RQgHyx9nnWOY+xx+Kg/6pjfLZ7NWED4+6smfX+Ot37HKbJi2GL9iG
         f91cyZUauUc0g==
Received: by mail-ed1-f71.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso14105992edh.1
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 11:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IYTHmQXzsIW766tCpVJPfNTfO+AmvxjDRcTslL8YGA=;
        b=WQ98Y5yZtRA4jBLj1OvXHoHQDRwQvCk3GmJT7n4zL+KLAdYsUBdBHOHco5C5bveFeX
         gWR5crNdnOgO5b62gJvn8Lmwmy71IIOcJkzAjF7ztn8DaQOKvcfaV5ssI1bB5OcQeBT8
         PHoitagADb7w6dqWitKE64T8AoMdiYYM+TP3P43SiqLvdOxiK9H0jYCUhnehrk6jaJLP
         XalbR6s8nw4tjzSzL/L2zM4kKTFtdkBC2f/RHZBP+zDesgqD8K5a83q5teolKJyfwC58
         8aK/oXKvCB7Cz0JIStnrGQRv5HW187huYyTx8qVTUtsS1kWGBGN2ux/vyF7V7VkUr9+j
         WnHQ==
X-Gm-Message-State: AOAM532YaWItQ2vxSVacIavvuKlceRgCIPpFftGv2klH/VPrHmXhtfA1
        9sGUhCbTOUHUiZmVcvA5rM1Gc6o9K8+dyfx2LLeUekQqQ7YvA08YEV9d9Icv7iW6Ssyk5eh0Tc8
        ytmaIK/KXczA32xsCnlP3Vp/10P74U7W0Fr8c06YgzA==
X-Received: by 2002:a17:906:b57:b0:6ce:e31a:524 with SMTP id v23-20020a1709060b5700b006cee31a0524mr898080ejg.290.1645643723450;
        Wed, 23 Feb 2022 11:15:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXaymv6Y03sx5emAtiihVKDslUlZDj5+bUOqZTX2T0tvcmba61MgF/pNNazmHUobDDFmGa2g==
X-Received: by 2002:a17:906:b57:b0:6ce:e31a:524 with SMTP id v23-20020a1709060b5700b006cee31a0524mr898038ejg.290.1645643723190;
        Wed, 23 Feb 2022 11:15:23 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm208368ejl.67.2022.02.23.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:15:22 -0800 (PST)
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
Subject: [PATCH v2 07/11] spi: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:14:37 +0100
Message-Id: <20220223191441.348109-1-krzysztof.kozlowski@canonical.com>
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

Remove also "const" from the definition of spi_device.driver_override,
because it is not correct.  The SPI driver already treats it as
dynamic, not const, memory.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi.c       | 20 ++++----------------
 include/linux/spi/spi.h |  2 +-
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4599b121d744..0c7e2c34f4a3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -74,27 +74,15 @@ static ssize_t driver_override_store(struct device *dev,
 	struct spi_device *spi = to_spi_device(dev);
 	const char *end = memchr(buf, '\n', count);
 	const size_t len = end ? end - buf : count;
-	const char *driver_override, *old;
+	int ret;
 
 	/* We need to keep extra room for a newline when displaying value */
 	if (len >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
-	driver_override = kstrndup(buf, len, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	device_lock(dev);
-	old = spi->driver_override;
-	if (len) {
-		spi->driver_override = driver_override;
-	} else {
-		/* Empty string, disable driver override */
-		spi->driver_override = NULL;
-		kfree(driver_override);
-	}
-	device_unlock(dev);
-	kfree(old);
+	ret = driver_set_override(dev, &spi->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7ab3fed7b804..01224d07aaff 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -184,7 +184,7 @@ struct spi_device {
 	void			*controller_state;
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
-	const char		*driver_override;
+	char			*driver_override;
 	int			cs_gpio;	/* LEGACY: chip select gpio */
 	struct gpio_desc	*cs_gpiod;	/* chip select gpio desc */
 	struct spi_delay	word_delay; /* inter-word delay */
-- 
2.32.0

