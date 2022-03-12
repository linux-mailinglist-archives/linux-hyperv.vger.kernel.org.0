Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D984D6F0D
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Mar 2022 14:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiCLNaz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 12 Mar 2022 08:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiCLNat (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 12 Mar 2022 08:30:49 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507B0209A48
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 05:29:41 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 31E3C3F62E
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091780;
        bh=k4Jb1JIbmx97RGU5zYwsibslXr/amA0TPgZk/TYiBU0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=etcl4ZIf+1dzLAo24O5sWFn+ySSFcmyZ1bRwykvDKzOuU9XZKxGHb3ghak7hh1gaV
         prEdn75dYtOv5gHWAi/agKY/3l1jbXe7wlkmEXbXVIVq6ig3wEbr37Ty5VZUb5Mte3
         iGEQmqy3O4sX25P9faXewnFdibWC0ZaDOFHp0hTqE4kj6Djqm94ptoc5zRe5jndurx
         cwUvFP/Vjn5gu90b54gPfZz+nTBidDE/nvDB1JP5cpjfgemZseionsjMHQplJbRmqg
         GlgNQ6MC7bhWuHLR/DnKJKcIJ4/h9KEumn2zYw+FFF8Epudw9ui5d6bidWccc6Z/EL
         aPPWi7QYFvRiA==
Received: by mail-wm1-f71.google.com with SMTP id v125-20020a1cac83000000b0037e3d70e7e1so6910645wme.1
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 05:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4Jb1JIbmx97RGU5zYwsibslXr/amA0TPgZk/TYiBU0=;
        b=Ewb774svR6EDRcAmEDas0q1kdTadaadHa0MqJrnaaAaET6kaiP5azKcPA0kp326AcI
         4MD5eGNjwrFvHXKmwJ0vgu1LOc0cwylW6zeigirEZt69xwRjpGxaczAwupLWImsoRWyL
         KM1Fbn1ynzuviX/Q/aZI2YAx5uP18YhsqY/0DCmHU+kP0iKB0ReCRDgcaMx2QtR3Gi9n
         HAM8auVh8lyxwPd4II1sba5K5S6QxASlT5wvD/a6IN+G35eqA4G27zyQ3HENe1vPeKhd
         cMg6OUvdgnh5rB5Ztu2PdwrdFZCLPg4OX29ARBjo9dkfLzWdqyagXYS1eVzZukiUtFb9
         ZQCQ==
X-Gm-Message-State: AOAM531kwOTpX/eExWZ+XEUet04m3m9N/tZNvU3ZpmetktJNMbWMN/Tc
        COWtexDZrL2E2aYBJcJFcpYgOX57UApF0HXsppNDKxt5kktrQE6LLbZestJPH9Sg8wPxTIQr6aj
        Nl+Esui+TLFmuIavfOID++MytrI+8a+sT2QoFPszgKg==
X-Received: by 2002:a05:600c:205a:b0:380:d03d:9cd5 with SMTP id p26-20020a05600c205a00b00380d03d9cd5mr18973791wmg.89.1647091769339;
        Sat, 12 Mar 2022 05:29:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/UYRzL44sORF2ylmmKXb7vWoxaA4l4bh2hpunrfXO0ZX4FC17dWpWNzj8sLP8bds5v9sX3A==
X-Received: by 2002:a05:600c:205a:b0:380:d03d:9cd5 with SMTP id p26-20020a05600c205a00b00380d03d9cd5mr18973773wmg.89.1647091769175;
        Sat, 12 Mar 2022 05:29:29 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:28 -0800 (PST)
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
Subject: [PATCH v4 08/11] vdpa: Use helper for safer setting of driver_override
Date:   Sat, 12 Mar 2022 14:28:53 +0100
Message-Id: <20220312132856.65163-9-krzysztof.kozlowski@canonical.com>
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/vdpa/vdpa.c  | 29 ++++-------------------------
 include/linux/vdpa.h |  4 +++-
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 1ea525433a5c..2dabed1df35c 100644
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
index 721089bb4c84..37117404660e 100644
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

