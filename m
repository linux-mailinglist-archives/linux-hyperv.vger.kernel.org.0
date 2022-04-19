Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79265506A96
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351418AbiDSLh4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 07:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351440AbiDSLhm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 07:37:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A9213F8C
        for <linux-hyperv@vger.kernel.org>; Tue, 19 Apr 2022 04:34:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b24so20828976edu.10
        for <linux-hyperv@vger.kernel.org>; Tue, 19 Apr 2022 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38ZdSROX5+RqupZAHBAG40n0Dr6hAO3z18g5N59SQU4=;
        b=lAgBbkTU8D6YEYE8EnVc7TQgg9yEr1TplNJ63UCkyqf8OgNnbEGMYGuI0ZRt1YnUYR
         kRpzUg0XO57gjImkecp7vfOrmW6v8xsYuT+ykmV5SUJcz29qohXYrmCJTI7S2t2WEnmY
         zWSSpz6b3AQM0jiHTyP0UQ4lX9NEWkolxtvviMwY/VFI7K7PqkqfewJxRLZ92G+WDd3a
         5+GPbuJLW9kL+l3TS2YvThY8XMvPqVq5exMhf16lR6dG9IJgDOBsGaYXv2G92fSmcLh/
         4fD229aWI/XNs7a02eGlv4mhOk4HHJqOdvHLlkD/PJA4giJ3K9/qVmo8vebRSosWnhPy
         b8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38ZdSROX5+RqupZAHBAG40n0Dr6hAO3z18g5N59SQU4=;
        b=VPY0yyCIRqh1YIOkhOYxl7SXtka6IDqWevLR5E+aJRSBVACr6fPtdvo6a3z90kFyUd
         84fEWwgRSMBqO0aSFzjUk5//ZujvCW80gtvSAhv6YSTNBSKFxNVsqGYPHLWqn2C3DKEN
         8Voz/ZW4HMUPP71oWNTFzorHdq+H1a4mPB2J9ONRlhKW8OCOTk72ib0JyaWjSIYv7eOW
         tVBmtBD7MqwF5CttycCg8WsBEa0jIj7SeVJXnGXDgpYgQ3/OE2HRQCdixyFYIbzcKgF7
         hTHxt0ql3+Gpqi1VqZhvg7hl7fYp20Xm0XJKD9EfFqCYbKuwT6Mib6QJ0LEL9iGZpc3f
         LAJw==
X-Gm-Message-State: AOAM531+CpszD9ZnkLLLbeEx9SgvWxWTIXOR2rZh1Sm9fhuLlFm7uFvL
        0si0/umYoVSNOybjnO/L1ke67Q==
X-Google-Smtp-Source: ABdhPJwnUhzb/0NAh+XYKj3k5xldAGjfpt63mghhlCD2VxFrpw9UxcHdu27TYmnA97GWmVv6IQjoNw==
X-Received: by 2002:a05:6402:3713:b0:41d:96f6:8a09 with SMTP id ek19-20020a056402371300b0041d96f68a09mr16881762edb.136.1650368096901;
        Tue, 19 Apr 2022 04:34:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b006e89869cbf9sm5608802ejb.105.2022.04.19.04.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:34:56 -0700 (PDT)
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
Subject: [PATCH v7 06/12] s390/cio: Use driver_set_override() instead of open-coding
Date:   Tue, 19 Apr 2022 13:34:29 +0200
Message-Id: <20220419113435.246203-7-krzysztof.kozlowski@linaro.org>
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
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>
---
 drivers/s390/cio/cio.h |  6 +++++-
 drivers/s390/cio/css.c | 28 ++++------------------------
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 1cb9daf9c645..fa8df50bb49e 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -103,7 +103,11 @@ struct subchannel {
 	struct work_struct todo_work;
 	struct schib_config config;
 	u64 dma_mask;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 } __attribute__ ((aligned(8)));
 
 DECLARE_PER_CPU_ALIGNED(struct irb, cio_irb);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index fa8293335077..913b6ddd040b 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -338,31 +338,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct subchannel *sch = to_subchannel(dev);
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
-	old = sch->driver_override;
-	if (strlen(driver_override)) {
-		sch->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		sch->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &sch->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

