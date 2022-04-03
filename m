Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C34A4F0C21
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Apr 2022 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355171AbiDCSl2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 3 Apr 2022 14:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376335AbiDCSlP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Apr 2022 14:41:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720961B780
        for <linux-hyperv@vger.kernel.org>; Sun,  3 Apr 2022 11:38:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r11-20020a1c440b000000b0038ccb70e239so815743wma.3
        for <linux-hyperv@vger.kernel.org>; Sun, 03 Apr 2022 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibpfD7Stpc4SjKvYaB/H7uRmvQIg2a/DOTBSRfVQ9Vc=;
        b=jdVVmHC1IJIqgXMutaed/G3PGD26wk719AI/PW9kxK3ySfevwIP6RdoAD1A7CW6azt
         0KTthlCdasmIa97/PS2sabtNr0wdH1fMA320c8Iuhz5DQSX6Fq18qNgUXDtUvtts3Eau
         HzvcKrxCatQP/CRPOv7F8wezTuemE/BaelY4GSlMz/L9inDUMiF5EewAPsZMeXmsAZaU
         KZb4RUobGx7F1jdlGeL0fw0W7Vw471qwjjDElYuGXSwqZBMh6buNT/9ntN5uWvpxxSmr
         MNverMP8cz5L+kVZ2e8dHb7vLrwtPu84uOlrotbcNVeBmm7nVUtvuumF/XJVAv/kTG4H
         o8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibpfD7Stpc4SjKvYaB/H7uRmvQIg2a/DOTBSRfVQ9Vc=;
        b=mjcpJvySguVG1r6BIQf2rIuduvcLvQu8kGDVojbpPNkPPFqLnm9HiqRErluJegZ0x3
         gOg9v8hjh6o5VVRm79a8lkumCQh+XbSIXsKSXNM8gCLBSpGXflHnG1mczXa9KAcaJhBc
         KsQaolHfcs1bbGzighRZkIySnxtw7pOZ5jT/ec97y7tSbSSP51/w2bzCUqvfQuLeAv7T
         s4NQQ0Nue283FZkpEUwemoey/LTCyuKaJ4BOBAknd2X0iP8cMCzrEL0FFIQMYT9CAZOY
         gD6og9X6wI/I0+2dhfYfPnCd+a/bbtm5VkpIHpiqT4MQxru401g4yWLZjsu1YmTIpeaa
         mnIA==
X-Gm-Message-State: AOAM533/2a1qJnNMnBIiyumspb6EA0MsbEONviBhGil/sWbNMPsIA131
        XnP6E5mldAv3wJIX10qigOgAVw==
X-Google-Smtp-Source: ABdhPJx3vCnnYYTVJBodVHG1+VBLJ7McXIjsKHK5pv9AMbUcFE1k+EFeK78ttVOKwP/bMzrZ3vfORQ==
X-Received: by 2002:a05:600c:34ce:b0:38c:a579:944a with SMTP id d14-20020a05600c34ce00b0038ca579944amr16519132wmq.113.1649011114192;
        Sun, 03 Apr 2022 11:38:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm593851wms.13.2022.04.03.11.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 11:38:33 -0700 (PDT)
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
Subject: [PATCH v6 12/12] rpmsg: Fix kfree() of static memory on setting driver_override
Date:   Sun,  3 Apr 2022 20:37:58 +0200
Message-Id: <20220403183758.192236-13-krzysztof.kozlowski@linaro.org>
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

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/rpmsg_internal.h | 13 +++++++++++--
 drivers/rpmsg/rpmsg_ns.c       | 14 ++++++++++++--
 include/linux/rpmsg.h          |  6 ++++--
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index d4b23fd019a8..1a2fb8edf5d3 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -94,10 +94,19 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
  */
 static inline int rpmsg_ctrldev_register_device(struct rpmsg_device *rpdev)
 {
+	int ret;
+
 	strcpy(rpdev->id.name, "rpmsg_ctrl");
-	rpdev->driver_override = "rpmsg_ctrl";
+	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
+				  "rpmsg_ctrl", strlen("rpmsg_ctrl"));
+	if (ret)
+		return ret;
+
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		kfree(rpdev->driver_override);
 
-	return rpmsg_register_device(rpdev);
+	return ret;
 }
 
 #endif
diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index 762ff1ae279f..95a51543f5ad 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -20,12 +20,22 @@
  */
 int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
 {
+	int ret;
+
 	strcpy(rpdev->id.name, "rpmsg_ns");
-	rpdev->driver_override = "rpmsg_ns";
+	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
+				  "rpmsg_ns", strlen("rpmsg_ns"));
+	if (ret)
+		return ret;
+
 	rpdev->src = RPMSG_NS_ADDR;
 	rpdev->dst = RPMSG_NS_ADDR;
 
-	return rpmsg_register_device(rpdev);
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		kfree(rpdev->driver_override);
+
+	return ret;
 }
 EXPORT_SYMBOL(rpmsg_ns_register_device);
 
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 02fa9116cd60..20c8cd1cde21 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -41,7 +41,9 @@ struct rpmsg_channel_info {
  * rpmsg_device - device that belong to the rpmsg bus
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  * @src: local address
  * @dst: destination address
  * @ept: the rpmsg endpoint of this channel
@@ -51,7 +53,7 @@ struct rpmsg_channel_info {
 struct rpmsg_device {
 	struct device dev;
 	struct rpmsg_device_id id;
-	char *driver_override;
+	const char *driver_override;
 	u32 src;
 	u32 dst;
 	struct rpmsg_endpoint *ept;
-- 
2.32.0

