Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAA64D6ED5
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Mar 2022 14:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiCLNaY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 12 Mar 2022 08:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiCLNaY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 12 Mar 2022 08:30:24 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED7D4CD64
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 05:29:18 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C141D3FA7E
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091755;
        bh=7mOTYavhbaOCHBinVaeIjk1F4Njvbmx0c9zMxK/oqtw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=X2ang2EfvApaduex0oywYTPf0AB+HnSWhFDlzk3WtuH5iQzHwVwsegfoFa1LG0NeR
         Bd+rUECVr0p98HKl8BEhpwcooVArxuG89FSr92+iohYI3+PYWbsYtFll7H+F6+H7VY
         3AtfXOIyHe81E5Uh+OMwL0tJR5xJFhalIe/SBsX1paxtKxQbI0Imc09o4LkwqzAuBv
         qnIr+uUovKZMN2Bvf9jiKBB1495dcksEisXo/GMFCItDB4N6zwjpulMx2Nk3eE2ZIR
         fHfek6Px2VMSz4NRgIJPZ18K9sA379gl3nL+1MxWwtaBnYx8liSnF2TjjNNXF4ynJ2
         dWs2xNkSi9lvg==
Received: by mail-wm1-f72.google.com with SMTP id 26-20020a05600c22da00b00388307f3503so4396790wmg.1
        for <linux-hyperv@vger.kernel.org>; Sat, 12 Mar 2022 05:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mOTYavhbaOCHBinVaeIjk1F4Njvbmx0c9zMxK/oqtw=;
        b=oSWzvyx6gF+wBW8v8bSQbfJ2cd2bnZW7oWZ2E7ztOcx9eKM8G8eNcfsnJGEmbUP2VP
         JjOC41ZQRDSICsqxMI1Xf1jm9duKdcs2hRhli4k5/G6kY+YbgS0mNudg2hHoe8L3hLRS
         SMDRKyCbFVIQTXK080S5kJp3/+axkR6KZf1Mfd0JdfjEzcLnSwvKUwqSH8UK2PKtpmuw
         uWSOgBtWMOftP+YXm0up3pGkve82EPQCFoYdtfjYG3yB+WphD9XtFokW2ATo06F6xAXB
         3NsvkrG8Qcxrdl722zRV8b9Wemhm5/0d//ICjS50bJMeKdGTwHjfeMPJCKNa4lw4xLEA
         HUwQ==
X-Gm-Message-State: AOAM531px7LrWL3lAtNbie3+JdG8J1RQZ71iarQXSaTkKiNawYoaxL7n
        x0GJA1QeVCX+8JQUKUMUMvtV7lNsfI2vfLM61N3xkMZrP7mBF/qSdfumWSiVnQbq/76D18u1JeO
        fqJrLpvIiQ+USh8YiwAt8SRFsREVqu0qiDRl1rwv+lw==
X-Received: by 2002:a5d:4dc4:0:b0:1ef:7aa9:5a8e with SMTP id f4-20020a5d4dc4000000b001ef7aa95a8emr10482297wru.168.1647091755236;
        Sat, 12 Mar 2022 05:29:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXkoKZNYuYe4AkUgBAiVP2OmAVWKev57rMrweGnbvTXkJE3UDv1vBAWJ9Qno8Byea/hz/PPw==
X-Received: by 2002:a5d:4dc4:0:b0:1ef:7aa9:5a8e with SMTP id f4-20020a5d4dc4000000b001ef7aa95a8emr10482245wru.168.1647091754950;
        Sat, 12 Mar 2022 05:29:14 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:14 -0800 (PST)
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
Subject: [PATCH v4 01/11] driver: platform: Add helper for safer setting of driver_override
Date:   Sat, 12 Mar 2022 14:28:46 +0100
Message-Id: <20220312132856.65163-2-krzysztof.kozlowski@canonical.com>
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

Several core drivers and buses expect that driver_override is a
dynamically allocated memory thus later they can kfree() it.

However such assumption is not documented, there were in the past and
there are already users setting it to a string literal. This leads to
kfree() of static memory during device release (e.g. in error paths or
during unbind):

    kernel BUG at ../mm/slub.c:3960!
    Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
    ...
    (kfree) from [<c058da50>] (platform_device_release+0x88/0xb4)
    (platform_device_release) from [<c0585be0>] (device_release+0x2c/0x90)
    (device_release) from [<c0a69050>] (kobject_put+0xec/0x20c)
    (kobject_put) from [<c0f2f120>] (exynos5_clk_probe+0x154/0x18c)
    (exynos5_clk_probe) from [<c058de70>] (platform_drv_probe+0x6c/0xa4)
    (platform_drv_probe) from [<c058b7ac>] (really_probe+0x280/0x414)
    (really_probe) from [<c058baf4>] (driver_probe_device+0x78/0x1c4)
    (driver_probe_device) from [<c0589854>] (bus_for_each_drv+0x74/0xb8)
    (bus_for_each_drv) from [<c058b48c>] (__device_attach+0xd4/0x16c)
    (__device_attach) from [<c058a638>] (bus_probe_device+0x88/0x90)
    (bus_probe_device) from [<c05871fc>] (device_add+0x3dc/0x62c)
    (device_add) from [<c075ff10>] (of_platform_device_create_pdata+0x94/0xbc)
    (of_platform_device_create_pdata) from [<c07600ec>] (of_platform_bus_create+0x1a8/0x4fc)
    (of_platform_bus_create) from [<c0760150>] (of_platform_bus_create+0x20c/0x4fc)
    (of_platform_bus_create) from [<c07605f0>] (of_platform_populate+0x84/0x118)
    (of_platform_populate) from [<c0f3c964>] (of_platform_default_populate_init+0xa0/0xb8)
    (of_platform_default_populate_init) from [<c01031f8>] (do_one_initcall+0x8c/0x404)
    (do_one_initcall) from [<c0f012c0>] (kernel_init_freeable+0x3d0/0x4d8)
    (kernel_init_freeable) from [<c0a7def0>] (kernel_init+0x8/0x114)
    (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)

Provide a helper which clearly documents the usage of driver_override.
This will allow later to reuse the helper and reduce amount of
duplicated code.

Convert the platform driver to use new helper and make the
driver_override field const char (it is not modified by the core).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/base/driver.c           | 56 +++++++++++++++++++++++++++++++++
 drivers/base/platform.c         | 28 +++--------------
 include/linux/device/driver.h   |  2 ++
 include/linux/platform_device.h |  6 +++-
 4 files changed, 67 insertions(+), 25 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 8c0d33e182fd..ba2510117484 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -30,6 +30,62 @@ static struct device *next_device(struct klist_iter *i)
 	return dev;
 }
 
+/**
+ * driver_set_override() - Helper to set or clear driver override.
+ * @dev: Device to change
+ * @override: Address of string to change (e.g. &device->driver_override);
+ *            The contents will be freed and hold newly allocated override.
+ * @s: NUL terminated string, new driver name to force a match, pass empty
+ *     string to clear it
+ * @len: length of @s
+ *
+ * Helper to set or clear driver override in a device, intended for the cases
+ * when the driver_override field is allocated by driver/bus code.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int driver_set_override(struct device *dev, const char **override,
+			const char *s, size_t len)
+{
+	const char *new, *old;
+	char *cp;
+
+	if (!dev || !override || !s)
+		return -EINVAL;
+
+	/*
+	 * The stored value will be used in sysfs show callback (sysfs_emit()),
+	 * which has a length limit of PAGE_SIZE and adds a trailing newline.
+	 * Thus we can store one character less to avoid truncation during sysfs
+	 * show.
+	 */
+	if (len >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	new = kstrndup(s, len, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	cp = strchr(new, '\n');
+	if (cp)
+		*cp = '\0';
+
+	device_lock(dev);
+	old = *override;
+	if (cp != new) {
+		*override = new;
+	} else {
+		kfree(new);
+		*override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(driver_set_override);
+
 /**
  * driver_for_each_device - Iterator for devices bound to a driver.
  * @drv: Driver we're iterating.
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8cc272fd5c99..b684157b7f2f 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1275,31 +1275,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct platform_device *pdev = to_platform_device(dev);
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
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 15e7c5e15d62..700453017e1c 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -151,6 +151,8 @@ extern int __must_check driver_create_file(struct device_driver *driver,
 extern void driver_remove_file(struct device_driver *driver,
 			       const struct driver_attribute *attr);
 
+int driver_set_override(struct device *dev, const char **override,
+			const char *s, size_t len);
 extern int __must_check driver_for_each_device(struct device_driver *drv,
 					       struct device *start,
 					       void *data,
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7c96f169d274..582d83ed9a91 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -31,7 +31,11 @@ struct platform_device {
 	struct resource	*resource;
 
 	const struct platform_device_id	*id_entry;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 
 	/* MFD cell pointer */
 	struct mfd_cell *mfd_cell;
-- 
2.32.0

