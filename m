Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7C4DB3F4
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Mar 2022 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356912AbiCPPH5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Mar 2022 11:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351004AbiCPPH4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Mar 2022 11:07:56 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BD627170
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Mar 2022 08:06:41 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E2EA33F1B7
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Mar 2022 15:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443197;
        bh=qe4dhnprNWM6uzn5SGQYSUaT3EAa0OIFZFVGuX4NqAE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PgLhZzJvZM9Q93vnKuw+yR2JWmF7ADjg0cv3fMnPPQMDmov11PhsokIzXO/HTH5rF
         W/zq0vEw6Mnw8onC75AJxqt0DO6A1m46R1dQ8x5WQPBKVQlN4foo9Bz+/Nv0bwG9BZ
         1jmhdngGfUhyhzdfAdRHZMlY4IT0IssOmGzCvj6/1zP9GQhLGI8TBWWDDbmIYy72Kv
         kiJFakwJmzcd8WX92H24m4PbcfCrYyIAW6I2GwArhzjVOUMonnz2P1uMPiirtB8AUf
         Qi/Honyxk0IGmT5p9eqGCumOdDo5Es99xXugCD0t8GS4wNG5g1ytUbpsvRR/3o7p31
         qiuHPBKBg0iDQ==
Received: by mail-wr1-f72.google.com with SMTP id x15-20020a5d6b4f000000b001ee6c0aa287so662808wrw.9
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Mar 2022 08:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qe4dhnprNWM6uzn5SGQYSUaT3EAa0OIFZFVGuX4NqAE=;
        b=0b+N3e6w9MMwU2WRTAyqnajDIgF5vIpUyFo4oSl8D6pHDnfGaK8Rr1lCX9LAkzuA6W
         Ym9lEEC8UI3j/PmyXiRy/hS75bzrkIczjs5VQfQ//W45v8WIaKlG0+7/6Y9EQPzNqgXM
         eVtkWQfslB0A13rBjGSQXbSxO2NPJAcE9BkI81Jjau7Xr6nk9TEWKfGDZxlztv0BC+/z
         PAKYjhzNyGpQFlZ0ID74kQGMm+4b7Qt9KSBh2DsJELP/VoFeegCFwDkFl+OXYojWazVF
         spd0XVQKvRK3fOuRuT4Ho9DiwQmvD7swgniUkMYQhEDfB79CRHzf41BpdFUsHOX0Rgru
         LlIA==
X-Gm-Message-State: AOAM532rElwQrVT+BkH4y+sZrQPXlRdppS9N0OUvaETj7OIFY44M/uhx
        XfF/yJPOeyBT7GRpZFibonUaUrR6PPE90/iNOXl9g/v8qnFKr1FOSoZ8uMHxe4NuWIxYk2lFaT1
        TviJEzasTQZ4AzVXGWBfwNZ6iKmORUV/VeMkqZynYJQ==
X-Received: by 2002:adf:f48d:0:b0:1ed:e2d7:d5e0 with SMTP id l13-20020adff48d000000b001ede2d7d5e0mr339345wro.252.1647443196957;
        Wed, 16 Mar 2022 08:06:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLiBCbgm6QRK3G0rpLKvHnouae5z5SEdfWjFsLkOL7izSJ06dvAGkwNICqtwmEJDwxDDgSbw==
X-Received: by 2002:adf:f48d:0:b0:1ed:e2d7:d5e0 with SMTP id l13-20020adff48d000000b001ede2d7d5e0mr339317wro.252.1647443196762;
        Wed, 16 Mar 2022 08:06:36 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d59ae000000b00203dcc87d39sm3130155wrr.54.2022.03.16.08.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:06:35 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v5 04/11] hv: Use driver_set_override() instead of open-coding
Date:   Wed, 16 Mar 2022 16:05:26 +0100
Message-Id: <20220316150533.421349-5-krzysztof.kozlowski@canonical.com>
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 28 ++++------------------------
 include/linux/hyperv.h |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 60ee8b329f9e..66213ce5579d 100644
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

