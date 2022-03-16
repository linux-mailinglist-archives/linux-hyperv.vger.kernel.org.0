Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D994DB3ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Mar 2022 16:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347402AbiCPPHz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Mar 2022 11:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356913AbiCPPHu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Mar 2022 11:07:50 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F7E27170
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Mar 2022 08:06:36 -0700 (PDT)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 336793F609
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Mar 2022 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443195;
        bh=YN/pEmxY5lmFXd8VsSTx/x5950RRmwZUldBJe65d5RE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Iz0ekmjFGFa6UXH2ekH9HDTLoVeQndbNh69N1EnxhN9jpKfsrOeH1HIIdNhhup/1I
         +zg9HYTNdozhV33AWdzeh9ouEb5JkGgK5fpQF765L4w3EVWdI1LLg4lPvFkOkY6M4S
         hdngu8bZ2hGLLFXpRzKbC1HuSYb0RsJldVsynVBCEVDwVOXrodcFfoyq1DAzqRYERv
         Qcs+ZVQ01+wK06GZhXk7l6LPH5Q7TvpCoLlewWsVL+6n7hO8deENTPwlfLwRh+ooV7
         sWnIvjzTNICX1PfvNzxTFOJck4bVAby2hARx5sn4X4SQsZgY9MTqn+tKRq5otfRFyY
         aJDaUJ0yslBxQ==
Received: by mail-lf1-f69.google.com with SMTP id w25-20020a05651234d900b0044023ac3f64so859226lfr.0
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Mar 2022 08:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YN/pEmxY5lmFXd8VsSTx/x5950RRmwZUldBJe65d5RE=;
        b=HN0/sZhCu7Ruzw58G1qRwo6K3VLSgN5HOmITH8RVLm72KUWcv7JFw2rydqad56gKuF
         544tuoumvz9Tc8YbfS6jlWJ258BwlfBxqLSHrDvevW/p5N8oEBWsu4FsbN25hpmZyw/z
         iPkSYc+Fuo8o+wR9bCM11Fma3EEv0YiDah+AZ/IPKXDkYSPbYr2fqajuf7KxvhJzGqL5
         JWdv2yHjP7++asUzfsuznraicCchYCSeN6sebwk5j0Q10LB9Ma1YLL3ogXaB2wUp24IU
         BNycvabggXz5zzqndeN+kTY33Z67loxAbKqtyvncsuj4FAbaaNtlyeDNjkDaGxdkti1i
         4PVA==
X-Gm-Message-State: AOAM532DR//EiOKxJ6sARQdeU4CG3H+jvNX2h6hA3kJm9CquHYykI1B6
        HOQsYEXzR7eTP6Vi0SX5kqs5xWpZqLkphKf5kHOghtfQJ3IH7nDkFUQ4YmUvrBLKkl2P61RlzHe
        64AtxQSQJTUbA6Nmxvm0hjbUelIuukioRkC9Hh7raaQ==
X-Received: by 2002:adf:d1e3:0:b0:1f1:f268:aea1 with SMTP id g3-20020adfd1e3000000b001f1f268aea1mr286261wrd.463.1647443184112;
        Wed, 16 Mar 2022 08:06:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK/0iXUCy7W2hGO6fQCeqBcBjEbHGvRHvC+ntVQfT1EKGUSf6rpLBWwFreMjWSWRs9UQG0wA==
X-Received: by 2002:adf:d1e3:0:b0:1f1:f268:aea1 with SMTP id g3-20020adfd1e3000000b001f1f268aea1mr286217wrd.463.1647443183806;
        Wed, 16 Mar 2022 08:06:23 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d59ae000000b00203dcc87d39sm3130155wrr.54.2022.03.16.08.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:06:21 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v5 00/11] Fix broken usage of driver_override (and kfree of static memory)
Date:   Wed, 16 Mar 2022 16:05:22 +0100
Message-Id: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Krzysztof Kozlowski (11):
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
  rpmsg: Fix kfree() of static memory on setting driver_override

 drivers/amba/bus.c              | 28 +++--------------
 drivers/base/driver.c           | 56 +++++++++++++++++++++++++++++++++
 drivers/base/platform.c         | 28 +++--------------
 drivers/bus/fsl-mc/fsl-mc-bus.c | 25 +++------------
 drivers/clk/imx/clk-scu.c       |  7 ++++-
 drivers/hv/vmbus_drv.c          | 28 +++--------------
 drivers/pci/pci-sysfs.c         | 28 +++--------------
 drivers/rpmsg/rpmsg_core.c      |  3 +-
 drivers/rpmsg/rpmsg_internal.h  | 11 +++++--
 drivers/rpmsg/rpmsg_ns.c        | 14 +++++++--
 drivers/s390/cio/cio.h          |  6 +++-
 drivers/s390/cio/css.c          | 28 +++--------------
 drivers/slimbus/qcom-ngd-ctrl.c | 13 +++++++-
 drivers/spi/spi.c               | 26 +++------------
 drivers/vdpa/vdpa.c             | 29 +++--------------
 include/linux/amba/bus.h        |  6 +++-
 include/linux/device/driver.h   |  2 ++
 include/linux/fsl/mc.h          |  6 ++--
 include/linux/hyperv.h          |  6 +++-
 include/linux/pci.h             |  6 +++-
 include/linux/platform_device.h |  6 +++-
 include/linux/rpmsg.h           |  6 ++--
 include/linux/spi/spi.h         |  2 ++
 include/linux/vdpa.h            |  4 ++-
 24 files changed, 169 insertions(+), 205 deletions(-)

-- 
2.32.0

