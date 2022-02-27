Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9A24C5BB0
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Feb 2022 14:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiB0Nyc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Feb 2022 08:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiB0Ny3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Feb 2022 08:54:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CC7192B8
        for <linux-hyperv@vger.kernel.org>; Sun, 27 Feb 2022 05:53:51 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 21B70407CA
        for <linux-hyperv@vger.kernel.org>; Sun, 27 Feb 2022 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645970029;
        bh=npGNvoQmcQXzOf9MUvG7bOfkjnwx60Xk35PbEgCfPxw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CL4WkDLCi60/NGuds/AFWF3XPOTztfy5Z01ljoqhHoPyMjsJAs0835fNRoSZC1Y9C
         qBIJiPqebtToClkcpohGOj6qLFs7oc7nWVLM+07JQqUvOA18r9eD0nhacbn13N9oVv
         VVmGQwqsxFUW9vQLKJBPcMFEc2KFJhPxa0Lrl7Oc2fqYT3oiknWVpEFOlpq2sSt0Ln
         1lkPSORG83XF+lcYIJTdhOLz/eKlieIpUPeh0XXqjG3yHZKdMVJEbB2NjHKF8Xkhsp
         XnMTzKxE+wE4wVqmoNghjfEDGHmpLkYJj6jlSNOCmr5wXlJ/ZOOEMn1Mnyd97LWevR
         qJy6gFigPYGyQ==
Received: by mail-ed1-f71.google.com with SMTP id h17-20020a05640250d100b004133863d836so4272161edb.0
        for <linux-hyperv@vger.kernel.org>; Sun, 27 Feb 2022 05:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npGNvoQmcQXzOf9MUvG7bOfkjnwx60Xk35PbEgCfPxw=;
        b=hR/LjHhcI7ornC6bwLQQJUtPDUAtzYLBnJfPPzRJTPn2lR20yIVc0eP96aO7PTYnFW
         hhriceF71WXe5SD+vE7fdg1dp2QqUEg89zjUwlrgYOUaUtq0vRX+rtnIzlNmPL8ghjVp
         wSZkzA4HYRjC4+jFYDpMj2KIgE9vn6XKJbJcYMINUvlE0fsHdgeeo4RTwPaTyrTnD1fU
         WFoIdr9CYopEPSci1rsuBs+Nlq6M104fs7MJwHhf53TRLFQZ8H8JyDzxKYpfuvslRHkk
         d3Dhq2imC4syfgvjuXnTEoPa7SD12IFzreYKeZRpL8xHoNYMOsHcvWqiXddmnnhT6Q3b
         Ca1g==
X-Gm-Message-State: AOAM530LbHwMPnnfh9g5LMhVKKRxnhY7Qa9sCMogMTG195AOzq14kiEB
        L9BKFOTRvBmXzsLxcxxvcvGxhs2qOzINTQaebNKrFvZIj6yHUWokjJuYRG/h1qR6/FNglFIbWA8
        wTUCvw4TlH2Eg7Gu0P0MTS11elwb+INox7TP+SWYPaA==
X-Received: by 2002:aa7:d49a:0:b0:410:875c:e21b with SMTP id b26-20020aa7d49a000000b00410875ce21bmr15261492edr.357.1645970017414;
        Sun, 27 Feb 2022 05:53:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzicu7l4IEwzqhlq2xIFoxdFytokSeMFkgjaEtpJW9Dl/uL3ibJtEoSzuA4VDSoAwu8n3nm0A==
X-Received: by 2002:aa7:d49a:0:b0:410:875c:e21b with SMTP id b26-20020aa7d49a000000b00410875ce21bmr15261460edr.357.1645970017251;
        Sun, 27 Feb 2022 05:53:37 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b00412ec3f5f74sm4600760edv.62.2022.02.27.05.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:53:36 -0800 (PST)
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
Subject: [PATCH v3 08/11] vdpa: Use helper for safer setting of driver_override
Date:   Sun, 27 Feb 2022 14:53:26 +0100
Message-Id: <20220227135329.145862-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/vdpa/vdpa.c  | 29 ++++-------------------------
 include/linux/vdpa.h |  4 +++-
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9846c9de4bfa..2d924a89ce28 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -77,32 +77,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct vdpa_device *vdev = dev_to_vdpa(dev);
-	const char *driver_override, *old;
-	char *cp;
+	int ret;
 
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
-	old = vdev->driver_override;
-	if (strlen(driver_override)) {
-		vdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		vdev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
+	ret = driver_set_override(dev, &vdev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 2de442ececae..89ec4e4d4cdc 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -64,7 +64,9 @@ struct vdpa_mgmt_dev;
  * struct vdpa_device - representation of a vDPA device
  * @dev: underlying device
  * @dma_dev: the actual device that is performing DMA
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  * @config: the configuration ops for this device.
  * @cf_mutex: Protects get and set access to configuration layout.
  * @index: device index
-- 
2.32.0

