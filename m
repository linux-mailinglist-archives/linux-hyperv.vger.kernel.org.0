Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7D4F0BFA
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Apr 2022 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359824AbiDCSkP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 3 Apr 2022 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359799AbiDCSkN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Apr 2022 14:40:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B7D3983C
        for <linux-hyperv@vger.kernel.org>; Sun,  3 Apr 2022 11:38:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h4so11346967wrc.13
        for <linux-hyperv@vger.kernel.org>; Sun, 03 Apr 2022 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rk4GrfXMwJbLvQiVana1UoJ1THyewcmBCMxkYGfguzc=;
        b=FOy7wrkM6AFpKv1C1v3+v3vZInYqslvcX3X0qZ/d/qZkS0mnBH6ZuhAq4vb5nUH4Lv
         5GMSTbQIQBcHsKdzQ4Lz71HkgeMyLLdWshbDnvvD5MBPPHvHWfgyLePsOj/WzE7X8qUD
         0QcqruGEsJf3YHcbPiAc4sYoXUq9axTkirycJkbMbF1q6OwJMcYiz2VNbMfu7jI1cbI6
         Q3TDvNKFVb3cOcOcujS+qKS+g/jn9/EESoIMIPyvIrI+5x3JJX7iOH5ErFJiIJHibCMW
         W1PVtY3ChFmH8A0a5epqg2flWs6AL7ROdi/w/syxuCNWDdJOcY/pI7LFGzCvK4+UrPDL
         yIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rk4GrfXMwJbLvQiVana1UoJ1THyewcmBCMxkYGfguzc=;
        b=SW9OTpOAoUfrICUB3I5DkeDZzlTmqbESEnz0JEm5julvOWktaHijlmWTEssA1Yn8R6
         +PuoIqJxDcilfixS/iqjL+xMpX7Gwt3om8UUMduwrWnaIzaJL/vPEx5Nt10U9AyNqphx
         flhQdQTV1QDgDTdf71MhXPbpyM7oMva6PYGlBFGRDIx/dBbSmMtpx2+tazbVDCi9TeI1
         Rsy7D5sFBLvtrPwC275fB/5MXP2QPsIgF/+AEOr5siZshUmpg0xTcw1szzRB26X3Eufd
         LUwMGPH4AOrGKmPtWcjrt6s0jsLgXhRfbVkYwTZT22W6nJzoDPryWB51x3H0KvHq7eFR
         P24A==
X-Gm-Message-State: AOAM530yw3NbICA3nBDlbAaUm9Owp3CQWPBvqhmlA1GfLOd+bojTvatJ
        pApEGJWKGyCMNj5kj3jB+q7Xyg==
X-Google-Smtp-Source: ABdhPJyZvwA9k272q2kGoUTyh6OGbczqfhv0AAZOQwnD2BrfPprs5f6pgaPH0VCFWILJS6ESKr8tuA==
X-Received: by 2002:a5d:6208:0:b0:203:dde4:c76e with SMTP id y8-20020a5d6208000000b00203dde4c76emr14428098wru.273.1649011096017;
        Sun, 03 Apr 2022 11:38:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm593851wms.13.2022.04.03.11.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 11:38:15 -0700 (PDT)
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
Subject: [PATCH v6 02/12] amba: Use driver_set_override() instead of open-coding
Date:   Sun,  3 Apr 2022 20:37:48 +0200
Message-Id: <20220403183758.192236-3-krzysztof.kozlowski@linaro.org>
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

Use a helper to set driver_override to reduce the amount of duplicated
code.  Make the driver_override field const char, because it is not
modified by the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/amba/bus.c       | 28 ++++------------------------
 include/linux/amba/bus.h |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d3bd14aaabf6..f3d26d698b77 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -94,31 +94,11 @@ static ssize_t driver_override_store(struct device *_dev,
 				     const char *buf, size_t count)
 {
 	struct amba_device *dev = to_amba_device(_dev);
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
-	device_lock(_dev);
-	old = dev->driver_override;
-	if (strlen(driver_override)) {
-		dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		dev->driver_override = NULL;
-	}
-	device_unlock(_dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(_dev, &dev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 6562f543c3e0..93799a72ff82 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -70,7 +70,11 @@ struct amba_device {
 	unsigned int		cid;
 	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
-	char			*driver_override;
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char		*driver_override;
 };
 
 struct amba_driver {
-- 
2.32.0

