Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5C8506A72
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 13:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351516AbiDSLht (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 07:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349513AbiDSLhc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 07:37:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA84A2DC4
        for <linux-hyperv@vger.kernel.org>; Tue, 19 Apr 2022 04:34:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y20so12114229eju.7
        for <linux-hyperv@vger.kernel.org>; Tue, 19 Apr 2022 04:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RS2KaOerzQuwGLCJlNRvQqdlqz9kGKXmmE/o8hIMxc=;
        b=KQats4yWut+GAInZpgo6wlkPKVDagbM3R0tOSjC/tXzsGfNp7h99Zs58vCptEscTpK
         mbbyQT/so7ThPQX6ZBwVgU/6/OMYPhZ3b8NWVo58v/AWgjGj/c13IinU0JZUxgsLmUbX
         wtYV4iKZ7ZxkIIXJYr27Z/OtYMBaCbJnYhLBGRpddVl1U1LTnJSB6NA88CzMeSaiqqqr
         2PHKBRlsALK1YRRnJegN2W7zECiyg6PKkD33wHtut9O6mBuGtDG4eNOOmh7evJgldNFD
         daON6jPbeCRx5RgbYuUVlqa5xdPtHbcMYVioGRHSRAffliIvrFMlh5w4Z4HpNMVbB8RB
         CtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RS2KaOerzQuwGLCJlNRvQqdlqz9kGKXmmE/o8hIMxc=;
        b=tkTiMiLsVBNz0niPqWWdOUDvm2cJ+zjXPsSjJB9NUv0y6eUqjREzk5aJ598UiaQjbo
         o8flow8glfnlwi1nHQpYhufpw0h4WPC616k0f8iIJjpYNCCUnSDg4g0WOjWw11vgsMli
         gMd1A2Wq+7k/RAa/apIP8bwzRc82Q+vwwYo7UvjWHERlRV830HJL4p5G5W8tnwHqiWfo
         CZ9Z47SY451+lUGcw31WusTrW5F7HguCxksG16eoZkHdP3jGUwE92WFUHnE0lYVzVaTx
         ShEmLTAXsziFD5DESqWxvnpQdzJhoEkpcQJD+WgRshGJbK0zTgh8uGywSp859al3fP1Y
         JCxQ==
X-Gm-Message-State: AOAM53286bZl7RbM/SNrGcWSc2NLKJeavquL0zNDUUwv8odJUihcFIqr
        Xebjl98u6vtF7xACXf/ZOTeVzA==
X-Google-Smtp-Source: ABdhPJzqToh0YQRiewe8EqLT6PK01CMGRMmUim2jYYjkDbBJ++z/iu7RXEodKQaWchfKBfcBWKLKsQ==
X-Received: by 2002:a17:907:6e90:b0:6ef:ef41:ac10 with SMTP id sh16-20020a1709076e9000b006efef41ac10mr750787ejc.187.1650368087470;
        Tue, 19 Apr 2022 04:34:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b006e89869cbf9sm5608802ejb.105.2022.04.19.04.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:34:46 -0700 (PDT)
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
Subject: [PATCH v7 00/12] Fix broken usage of driver_override (and kfree of static memory)
Date:   Tue, 19 Apr 2022 13:34:23 +0200
Message-Id: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

This is a continuation of my old patchset from 2019. [1]
Back then, few drivers set driver_override wrong. I fixed Exynos
in a different way after discussions. QCOM NGD was not fixed
and a new user appeared - IMX SCU.

It seems "char *" in driver_override looks too consty, so we
tend to make a mistake of storing there string literals.

Changes since latest v7
=======================
1. Patch #1: remove out_free label, document clearing override in kerneldoc and
   in code-comments (Andy).
2. Patch #12 (rpmsg): do not duplicate string (Biju).

Changes since latest v6
=======================
1. Patch #1: Don't check for !dev and handle len==0 (Andy).
2. New patch #11 (rpmsg): split constifying of local variable to a new patch.

Changes since latest v5
=======================
1. Patch #11 (rpmsg): split from previous patch 11 - easier to understand the
   need of it.
2. Fix build issue in patch 12 (rpmsg).

Changes since latest v4
=======================
1. Correct commit msgs and comments after Andy's review.
2. Re-order code in new helper (patch #1) (Andy).
3. Add tags.

Changes since latest v3
=======================
1. Wrap comments, extend comment in driver_set_override() about newline.
2. Minor commit msg fixes.
3. Add tags.

Changes since latest v2
=======================
1. Make all driver_override fields as "const char *", just like SPI
   and VDPA. (Mark)
2. Move "count" check to the new helper and add "count" argument. (Michael)
3. Fix typos in docs, patch subject. Extend doc. (Michael, Bjorn)
4. Compare pointers to reduce number of string readings in the helper.
5. Fix clk-imx return value.

Changes since latest v1 (not the old 2019 solution):
====================================================
https://lore.kernel.org/all/708eabb1-7b35-d525-d4c3-451d4a3de84f@rasmusvillemoes.dk/
1. Add helper for setting driver_override.
2. Use the helper.

Dependencies (and stable):
==========================
1. All patches, including last three fixes, depend on the first patch
   introducing the helper.
2. The last three commits - fixes - are probably not backportable
   directly, because of this dependency. I don't know how to express
   this dependency here, since stable-kernel-rules.rst mentions only commits as
   possible dependencies.

[1] https://lore.kernel.org/all/1550484960-2392-3-git-send-email-krzk@kernel.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (12):
  driver: platform: Add helper for safer setting of driver_override
  amba: Use driver_set_override() instead of open-coding
  fsl-mc: Use driver_set_override() instead of open-coding
  hv: Use driver_set_override() instead of open-coding
  PCI: Use driver_set_override() instead of open-coding
  s390/cio: Use driver_set_override() instead of open-coding
  spi: Use helper for safer setting of driver_override
  vdpa: Use helper for safer setting of driver_override
  clk: imx: scu: Fix kfree() of static memory on setting driver_override
  slimbus: qcom-ngd: Fix kfree() of static memory on setting
    driver_override
  rpmsg: Constify local variable in field store macro
  rpmsg: Fix kfree() of static memory on setting driver_override

 drivers/amba/bus.c              | 28 ++-----------
 drivers/base/driver.c           | 69 +++++++++++++++++++++++++++++++++
 drivers/base/platform.c         | 28 ++-----------
 drivers/bus/fsl-mc/fsl-mc-bus.c | 25 ++----------
 drivers/clk/imx/clk-scu.c       |  7 +++-
 drivers/hv/vmbus_drv.c          | 28 ++-----------
 drivers/pci/pci-sysfs.c         | 28 ++-----------
 drivers/rpmsg/rpmsg_core.c      |  3 +-
 drivers/rpmsg/rpmsg_internal.h  | 13 ++++++-
 drivers/rpmsg/rpmsg_ns.c        | 14 ++++++-
 drivers/s390/cio/cio.h          |  6 ++-
 drivers/s390/cio/css.c          | 28 ++-----------
 drivers/slimbus/qcom-ngd-ctrl.c | 13 ++++++-
 drivers/spi/spi.c               | 26 ++-----------
 drivers/vdpa/vdpa.c             | 29 ++------------
 include/linux/amba/bus.h        |  6 ++-
 include/linux/device/driver.h   |  2 +
 include/linux/fsl/mc.h          |  6 ++-
 include/linux/hyperv.h          |  6 ++-
 include/linux/pci.h             |  6 ++-
 include/linux/platform_device.h |  6 ++-
 include/linux/rpmsg.h           |  6 ++-
 include/linux/spi/spi.h         |  2 +
 include/linux/vdpa.h            |  4 +-
 24 files changed, 184 insertions(+), 205 deletions(-)

-- 
2.32.0

