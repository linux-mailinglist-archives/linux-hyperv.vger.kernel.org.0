Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614F7519FF5
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 May 2022 14:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349997AbiEDMyh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 May 2022 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347676AbiEDMyg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 May 2022 08:54:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB412AE12;
        Wed,  4 May 2022 05:51:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gh6so2731065ejb.0;
        Wed, 04 May 2022 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OVs9PQbdqSVwYUyn1eHpAQyyObHHdQe8U1ZByfJLKYo=;
        b=JvFpobakMaOwToTfa0WFh7TqVSQBEnPNaf7RyfhzTJ4xtg/yFFpNwXSM7PwApMYyXG
         9iF2Y8qZ7lGHGp6qmahFFMsG3vIMqDDezz06wJtK6ibBjTnraBdpp16c28xnkrfsxWWh
         ot/oia1LZNrsLz54lNwN4JR39IGM5Thrcjps1Cfggl5smjs+uh9+rybTeBEbrnxVRN0i
         46H8PP5IK+Mqq/bDH8b62gj5+p0EVM6bLAedBFewd3YxOyjpz/Sn5IrtzHRjHFb+AHFy
         3gsXlYvxQjOfjoVs1Ic4uVOEPYO3phsrVt+QD/3DcasuKZlnB0kRFOfI3Q84rLmhfj3u
         rAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OVs9PQbdqSVwYUyn1eHpAQyyObHHdQe8U1ZByfJLKYo=;
        b=zyFtSZAQG67BHAI0Rl92EfDmrMke2/yd1vy5udBDw2zlPaVyTHfCLS7yZC1LWAd78S
         4A2IxmoGSVnm0TUkvypCc1zxT3UWm8BKV/T1cPOLRKJ4ecgcxbj2j9klF6F2hWM/xMDx
         wlTRFfQYyEbYXbqINLviPIFWsR0PVW3cZIZXuYJRpGS8vzJUvzTDwxQONL5lrDzexmYv
         SVXtf8Ren8XCThasMf91rXIuyZYPqGSrlmXWRch7Dpf0a+D8e3bMc48SnapDjC9RHJ5u
         LAtRuzaHMd1/ZNQTXjouv0PUlRkCBuunbJg6F5HUjbRQgHjcw4jfMzSBlK2LHM4ULolq
         Kd5A==
X-Gm-Message-State: AOAM533O2aJJNXcoi8vAAgAYZLF5jttAJLuO5j0S2K0VOnA1k3/5plDE
        MX/VI5YksMoi/al4BXP5qOc=
X-Google-Smtp-Source: ABdhPJx6KpDz4eyJX8FZO2WPpal1le48Zup40H6dhU3yFTLqSFZ3930Z92kpUB8r3ypSvbG9hviPoA==
X-Received: by 2002:a17:906:3104:b0:6ce:6b85:ecc9 with SMTP id 4-20020a170906310400b006ce6b85ecc9mr19147877ejx.339.1651668659051;
        Wed, 04 May 2022 05:50:59 -0700 (PDT)
Received: from anparri.mshome.net (host-2-117-178-169.business.telecomitalia.it. [2.117.178.169])
        by smtp.gmail.com with ESMTPSA id hz7-20020a1709072ce700b006f3ef214dc9sm5743045ejc.47.2022.05.04.05.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:50:58 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 0/2] PCI: hv: (More) Hardening changes
Date:   Wed,  4 May 2022 14:50:37 +0200
Message-Id: <20220504125039.2598-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Patch #2 depends on changes in hyperv-next.  (No urgency here: will
resend/rebase after 5.19-rc1 if desired, just let me know...)

Thanks,
  Andrea

Andrea Parri (Microsoft) (2):
  PCI: hv: Add validation for untrusted Hyper-V values
  PCI: hv: Fix synchronization between channel callback and
    hv_pci_bus_exit()

 drivers/pci/controller/pci-hyperv.c | 53 +++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 14 deletions(-)

-- 
2.25.1

