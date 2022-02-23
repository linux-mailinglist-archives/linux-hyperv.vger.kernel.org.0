Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97394C1BB3
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 20:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbiBWTOz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 14:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbiBWTOx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 14:14:53 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738FA40E70
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 11:14:25 -0800 (PST)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 327EE4030D
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 19:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643660;
        bh=HpbyTrdXrFaP+pceEvy/NrkKlPBl1rW1ivTy++yPdQg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UlVLzC3za0caucuVhgtoljxOcWXiLA3Ygp35jgwkoYh3ZZfmnqm7tASg1F3mDHw8i
         1EANT8NjjxOZMEwZJpbtI96fASo5RfKNBl2FjW726FMBAb6Wm0kIZugxakjYakV/i2
         5Vj3HqXtFYu6DBYD2iYPqJu/fMNSaC8c+TLLCIxteBeYuIDQJc2WOfflTWnTWDguNm
         k6AbgJ2bWd7LfYMYcX5cfFDkJxF8iA92/VtMVWs3R0g2HIldZsB840XuYgoN+JbrG1
         37KWxIiYkExqGh2ECWXJtnTyCc0SoLrFkjC0i14um9EYr2wQNTxvpN5blsBmuNGfYy
         HdRz9bwEKMeRQ==
Received: by mail-lj1-f199.google.com with SMTP id 20-20020a2e0914000000b0024635d136ddso5899534ljj.22
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 11:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HpbyTrdXrFaP+pceEvy/NrkKlPBl1rW1ivTy++yPdQg=;
        b=Umeic8CU/7jH3GK1r/i4BY72IRpgq8jcLsaSzbEvaA5MfR8HesX7vlf/K+Nj8adQge
         42jQIeOSvmFb9knQmqg01JoQ8iRZBpsiHtR9Rvlm/wlUA3LGmCPaZeJLVZdGLkiC9j8j
         GP62ofC8/a7g3uNua2lEhn5Eh+ecFrzTWUpczg8rUqQdSVm+ZQg1maW9IiU0TyLSsljj
         D3FIds3lzYnQQ8TmmCkXtkjRdoJAmIQDhU+oNWpQ2X/M76usM5N8c2n3K5ziR/xKC3be
         wnXRp/kz3uMda0ixZ8e90AvfzJSkJMQehxU9At4aryUfcZ1zzzzLLCIzxhyVrTTiy35S
         Ngcg==
X-Gm-Message-State: AOAM5318WUoLy3rkcvwVYeCZa2G9fEmyA6JegSqceJNiSlkGKQv217dU
        ky2OB2n8mU4GsimYkumsJ6xAN5RGaUdEey5Xhn0JEP24i7aWC6ir8SI2uOtvznOHfpXBFiolt1P
        nZJ+xVt3SuVELGBEwp8XNxLepdhBQIcLet7kcHbnVFA==
X-Received: by 2002:a05:6402:d05:b0:412:e171:28d9 with SMTP id eb5-20020a0564020d0500b00412e17128d9mr848356edb.169.1645643633259;
        Wed, 23 Feb 2022 11:13:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYG5EE1VK62qsOOiEHtkeJRCih/epa6U/E9Szqr9uJDRTwmiXA+urJE3qxE0O0qjjabVNPNQ==
X-Received: by 2002:a05:6402:d05:b0:412:e171:28d9 with SMTP id eb5-20020a0564020d0500b00412e17128d9mr848325edb.169.1645643633058;
        Wed, 23 Feb 2022 11:13:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id q5sm212611ejc.115.2022.02.23.11.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:13:51 -0800 (PST)
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
Subject: [PATCH v2 02/11] amba: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:13:01 +0100
Message-Id: <20220223191310.347669-3-krzysztof.kozlowski@canonical.com>
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
 drivers/amba/bus.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index e1a5eca3ae3c..12410c05ec70 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -94,31 +94,15 @@ static ssize_t driver_override_store(struct device *_dev,
 				     const char *buf, size_t count)
 {
 	struct amba_device *dev = to_amba_device(_dev);
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
-	device_lock(_dev);
-	old = dev->driver_override;
-	if (strlen(driver_override)) {
-		dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		dev->driver_override = NULL;
-	}
-	device_unlock(_dev);
-
-	kfree(old);
+	ret = driver_set_override(_dev, &dev->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

