Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D924C1B9B
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 20:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244211AbiBWTOr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 14:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244199AbiBWTOc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 14:14:32 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6059B3FDB5
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 11:14:03 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6AC923FCAD
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 19:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643632;
        bh=7G3yQO1ggdyvs1MDXGTTghLlHGfX3RftlATUX++IZLE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=i4mEMPHG5gmu+2JySNK3tcAvkOpHUAoK5pM0I+2hWtXJgSvVRVXaG+aLa8gfCnCdo
         Ic9W/G280Cx9UBJUMWgIhScu2TAyjNsDBayN9nt3qbXn0kHezigqkrcPLNO8+UmUMB
         oAayp5LI9fVvC93H6UrKouzGy4HwBOddfzHf2tNYJXUsACmvSy/Agib7X4fZJZiUjP
         HejoAkVtBHFQb47U7lcoMwO1FNbtb6NsicR/BQd/kDj9XWHh74UlU4PeYOaBsC772c
         mqRZXI5pc/T5llJ/NUXCfNjRwWFjqJYtNTpmnW52AHQAe+O8Xwo44ThYzxN8is4MQM
         PqmYFsz1pBI6Q==
Received: by mail-ej1-f69.google.com with SMTP id hc39-20020a17090716a700b006ce88cf89dfso7486060ejc.10
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 11:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7G3yQO1ggdyvs1MDXGTTghLlHGfX3RftlATUX++IZLE=;
        b=N/KPHDDgy+uP/go/Ns/EL/whwUSOjyRuWbFaPiGrlmmxabcNr04DMzPV//IC5OQOme
         ZBP9vrClvS0IutOl8KxX6fiV80tZ8lV36FwttJ34835B4Xj3zzA3fn9MUV3u5ABVq8t8
         8TwRfYLOftG2h/uZV4Q//+2TE6C6L2Zlhmr5scKNqzqOquspa5zuqV23PtgJzg5Gu9Pj
         XlsdGPLRfri1sFB78kxTFysX7etU+zFXtn8psnF0WI20D4/mNjcn27vzE1NPCk3V0e0K
         dox/k7bl7a+n5Be/KgTAbAJqLkdSEG8LMhkMQ++ZR1FGSLPUWVn7lcxqBPNcP3KKim2Y
         chgQ==
X-Gm-Message-State: AOAM5322h+NmGWPkc9OempBuHcvLoLD3Db7YklyQwVu/1VMzvSl5yXkv
        WTOMO56WUpLhtIISM8tfhpVi+yH+OIu3NofpNeBTacvbvpfVVg5CHX/BhRgAzO299MzrcK2Mwk0
        MyU14+9sLGQ5aVTjtIjVFJ59qRNnuR+I7EevbtTJPhw==
X-Received: by 2002:a17:907:3e1d:b0:6d1:cb2e:a5f7 with SMTP id hp29-20020a1709073e1d00b006d1cb2ea5f7mr912412ejc.34.1645643627834;
        Wed, 23 Feb 2022 11:13:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGBRIhr5hXOOi9m1HuHlbXHVVNJ7NbK5fFuNrM/4KQXFCcM1cXqPM7bQRPgfLpUUwT4AX8Nw==
X-Received: by 2002:a17:907:3e1d:b0:6d1:cb2e:a5f7 with SMTP id hp29-20020a1709073e1d00b006d1cb2ea5f7mr912389ejc.34.1645643627533;
        Wed, 23 Feb 2022 11:13:47 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id q5sm212611ejc.115.2022.02.23.11.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:13:47 -0800 (PST)
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
Subject: [PATCH v2 00/11] Fix broken usage of driver_override (and kfree of static memory)
Date:   Wed, 23 Feb 2022 20:12:59 +0100
Message-Id: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
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

Hi,

This is a continuation of my old patchset from 2019. [1]
Back then, few drivers set driver_override wrong. I fixed Exynos
in a different way after discussions. QCOM NGD was not fixed
and a new user appeared - IMX SCU.

It seems "char *" in driver_override looks too consty, so we
tend to make a mistake of storing there string literals.

Changes of latest since v1 (not the old 2019 solution):
=======================================================
https://lore.kernel.org/all/708eabb1-7b35-d525-d4c3-451d4a3de84f@rasmusvillemoes.dk/
1. Add helper for setting driver_override.
2. Use the helper.

Dependencies (and stable):
==========================
1. All patches, including last three fixes, depend on first patch
   introducing the helper.
2. The last three commits - fixes - are probably not backportable
   directly, because of this dependency. I don't know how to express
   it here, since stable-kernel-rules.rst mentions only commits as
   possible dependencies.

[1] https://lore.kernel.org/all/1550484960-2392-3-git-send-email-krzk@kernel.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (11):
  driver: platform: add and use helper for safer setting of
    driver_override
  amba: use helper for safer setting of driver_override
  fsl-mc: use helper for safer setting of driver_override
  hv: vmbus: use helper for safer setting of driver_override
  pci: use helper for safer setting of driver_override
  s390: cio: use helper for safer setting of driver_override
  spi: use helper for safer setting of driver_override
  vdpa: use helper for safer setting of driver_override
  clk: imx: scu: fix kfree() of static memory on setting driver_override
  slimbus: qcom-ngd: fix kfree() of static memory on setting
    driver_override
  rpmsg: fix kfree() of static memory on setting driver_override

 drivers/amba/bus.c              | 24 +++---------------
 drivers/base/driver.c           | 44 +++++++++++++++++++++++++++++++++
 drivers/base/platform.c         | 24 +++---------------
 drivers/bus/fsl-mc/fsl-mc-bus.c | 22 +++--------------
 drivers/clk/imx/clk-scu.c       |  7 +++++-
 drivers/hv/vmbus_drv.c          | 24 +++---------------
 drivers/pci/pci-sysfs.c         | 24 +++---------------
 drivers/rpmsg/rpmsg_internal.h  | 13 ++++++++--
 drivers/rpmsg/rpmsg_ns.c        | 14 +++++++++--
 drivers/s390/cio/css.c          | 24 +++---------------
 drivers/slimbus/qcom-ngd-ctrl.c | 12 ++++++++-
 drivers/spi/spi.c               | 20 +++------------
 drivers/vdpa/vdpa.c             | 25 +++----------------
 include/linux/device/driver.h   |  1 +
 include/linux/platform_device.h |  6 ++++-
 include/linux/spi/spi.h         |  2 +-
 16 files changed, 123 insertions(+), 163 deletions(-)

-- 
2.32.0

