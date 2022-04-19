Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD676506A85
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 13:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351546AbiDSLhz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 07:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351418AbiDSLhi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 07:37:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72CBE32
        for <linux-hyperv@vger.kernel.org>; Tue, 19 Apr 2022 04:34:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y20so12114740eju.7
        for <linux-hyperv@vger.kernel.org>; Tue, 19 Apr 2022 04:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Keg7xeXtq8amo+bPOPiY0urtb62UU+nYY2PydP0Pktc=;
        b=DTuv34MQ33JHfqETATQCEFdNozHmI35rAUQVc6olY52FJAiDXlsoudP958Slrb5wG1
         DSPsGtDvlTAOkorBlo5mTDEsuc4ydyQ5Yf8AxUenxXPtL5w79pnDU8388VAXjO9mEVD+
         vEeppQOWxBuT/F1c/tirPFrwshVkv0IzHeXlVS3TRoe5HUqVwgpCDZbGYEjlScL0+6Vr
         hyS9XdBBr+bjvGu2LzcODR5O9YGPdmzXSE/BE4YQKhkbj4iyXXTmW7nwSDUIvjxekh2b
         pFhW9CQNJbOpAdevGaap0fwJd6ED38/k91U2fka9puKnEErIFBBucAn4aACWqEK20wY+
         fNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Keg7xeXtq8amo+bPOPiY0urtb62UU+nYY2PydP0Pktc=;
        b=UBe6TObfYCWTnkBq3WtWb53D3CZhzJbRc1uChad4HF3Gy30De2a9uhkzRUfoRuHFez
         WBKGs6wf8GlS5HggAYpEN8rlBnkKqJ7cck1hFt1/PUV0jcJCmynRt+tZNHEzsfOJ8+OB
         miZlw9hvgZV0HV/opjVRpmnerVdQbZMNqKvAdnVoD1aVsDnPAyC4fgHSnvWD5hTgMbhT
         6t9q7YveITjGe8BbqJ1GxAxw6Fh94JeF2dqgeAovcr3dyOQsyiht7+gj3wHN/SzAKW2F
         uGONmXqTMYluKY2HJGwyiICxJOsZfkXgMXTHSCj0eoI0YwScwhAPCH7PuQ6kmBx4zkWU
         yUOQ==
X-Gm-Message-State: AOAM532VDmAWA6iHaptnwrVT4PWqXaSuwWqPEQF6y/Qdo0R8RMuOS8E7
        qU5fy5hLhA89vAbJX7bVKw4I/A==
X-Google-Smtp-Source: ABdhPJyVt0cgXUYUeGSEzHKPEQtYs3Qh+dbqLbNajfqREgpBOjCU9zh7evNxJ42COX+bjxL2ovpv7Q==
X-Received: by 2002:a17:906:d552:b0:6ef:c5a2:7e01 with SMTP id cr18-20020a170906d55200b006efc5a27e01mr5528474ejc.568.1650368093944;
        Tue, 19 Apr 2022 04:34:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b006e89869cbf9sm5608802ejb.105.2022.04.19.04.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:34:53 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v7 04/12] hv: Use driver_set_override() instead of open-coding
Date:   Tue, 19 Apr 2022 13:34:27 +0200
Message-Id: <20220419113435.246203-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 28 ++++------------------------
 include/linux/hyperv.h |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 14de17087864..607e40aba18e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -575,31 +575,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
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
-	old = hv_dev->driver_override;
-	if (strlen(driver_override)) {
-		hv_dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		hv_dev->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &hv_dev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index fe2e0179ed51..12e2336b23b7 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1257,7 +1257,11 @@ struct hv_device {
 	u16 device_id;
 
 	struct device device;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
-- 
2.32.0

