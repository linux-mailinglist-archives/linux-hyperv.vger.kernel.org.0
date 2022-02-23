Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3EF4C1BDD
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 20:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244298AbiBWTQR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 14:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244068AbiBWTQN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 14:16:13 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E5441FBC
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 11:15:41 -0800 (PST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 358523F1B6
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 19:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643739;
        bh=H2keAgAmU9ZqqGFkafNbZlkvfevlWycDJlQlht8xanA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=euOcq1FFrdyRa+36lUbCJGiOPIEvtmh6m68dbRKnhFFKzplWh/E+fQOSfXVeY3xOH
         2vUMOH6hPtcuR3J2Gj229+9okuR3/9R5wLOpmgl7E/n3D+AE0Wj57iozpeUpOO1Emm
         A7E5Z5UsB/bRv3sqxQgwJ+nbTr44p1adCHIeg3UTEg6UYufUkXVLCxQrPO1MT8I57R
         oQjHmJHnLgMax6CHmPvc9qHYyCzmto2vhikaWlkRkkUb1YGZBLGUm1E+nk4hhp/boD
         G+yv4KAivahNhUCJTyhOG9oFn7hIk6B/P7iaBFp81BPHuNx8yJY/E3bu80PlUOaQ+z
         Pq7qcFkhMtDTg==
Received: by mail-lj1-f197.google.com with SMTP id o1-20020a2eb301000000b0024640251ba9so4876693lja.12
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 11:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2keAgAmU9ZqqGFkafNbZlkvfevlWycDJlQlht8xanA=;
        b=0MQV6t/coILJj9TwWsPk/S1gdxkhV+IwATp81qPgWnPKJ7GJQpyQC5Z6i7n7DlH7cJ
         u2ovTSAjX1vaQsHmduJrcrFG4YC3hN/9ukqyiaXqZaa7mMikjB+YBEriqzXkS++/uswU
         uDOuDIl+LT+KR0+1JgOPwzoEEjhdApdf0Eze0orSstp/QVIVjN9zboqzPaL1HC5ilPUW
         J7drCUwzj8SeeWuGCyS0VDA2DqQ0pcFaSTY5WAcYMVn6KT9Q2SUyl2GUG0RbmweobdOH
         Gx9ag0TqYzOuC/T/zvpN0Ko3r/2ahH22La/QvlQUat5m5CED+2gQiUsV3nj54jL6XWmr
         a+6g==
X-Gm-Message-State: AOAM5334LofDxqDS2/i5e2F1bt7MBRHi119e2LdB9P1O9I/Hn3A+JVhC
        4JbXg/bAmPnHJngz25DCi7yIyqp2OFrdNohDmgQij5Ph5KH7WE6vCV9rkqZshbBGVQMu9uHpQyZ
        FsjgA1w2DMuyjO5zNK9fiN6h/qAXSON7K67BtQ7Iwdw==
X-Received: by 2002:a17:906:684a:b0:6ce:c1b4:b503 with SMTP id a10-20020a170906684a00b006cec1b4b503mr894523ejs.355.1645643725346;
        Wed, 23 Feb 2022 11:15:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpQByhmcToLCr1i/g+5dfeJyrnQroTWuW6ciExOrKYOzQiErT2Fu468xjrk+1eigQXSikm5Q==
X-Received: by 2002:a17:906:684a:b0:6ce:c1b4:b503 with SMTP id a10-20020a170906684a00b006cec1b4b503mr894476ejs.355.1645643725160;
        Wed, 23 Feb 2022 11:15:25 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm208368ejl.67.2022.02.23.11.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:15:24 -0800 (PST)
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
Subject: [PATCH v2 08/11] vdpa: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:14:38 +0100
Message-Id: <20220223191441.348109-2-krzysztof.kozlowski@canonical.com>
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
 drivers/vdpa/vdpa.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9846c9de4bfa..76ce2dcae7cb 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -77,32 +77,15 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct vdpa_device *vdev = dev_to_vdpa(dev);
-	const char *driver_override, *old;
-	char *cp;
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
+	ret = driver_set_override(dev, &vdev->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

