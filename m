Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8281D4F74BD
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 06:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiDGEeD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 00:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbiDGEeC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 00:34:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586331E480C;
        Wed,  6 Apr 2022 21:32:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dr20so8264771ejc.6;
        Wed, 06 Apr 2022 21:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1CuzqFrxMqG3XYIX/bx1pbK4YvXnBuesuH56PsPYPfM=;
        b=NEFNQmYrf1jAQsRLH7fbnE/rwwQPMLwrJALUEiKJkY3Qp0A7Id/Vbffrdt93Z+kGvK
         CzfI7V1BqhCQgt1DMJhnc/B9AoqVVENnVzUivMQbagJpjKhnYMxx+bLHSQpSa2Rztdpj
         Jwn1ePMj7aLSiU/laHPkw/fsQWl6fzEXTJINh1I21YUy9VUyYnFh1cVr2YWhZTcGyddD
         EBxghZmeLRhoBHh6Vtk4/uIR0rGCepNdUBU5wi+mHQHwp0jWFEIDOKuxi/LOfD7ceYf9
         v91nKyKw5w6JpztYvTU8zevgiHCCTzMd94Fq/HP+f0tDj94uc09QtIlM3D6MBKRdPaPL
         tg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1CuzqFrxMqG3XYIX/bx1pbK4YvXnBuesuH56PsPYPfM=;
        b=ocRkHj7VRJBDDPy4Y2+RDjkBTakzAch3wYaRf7fmstQ/GZ51BDzuuRfUiDUq2DdBlp
         6UTSUpIzXf0fVSP/2BzYZh+rXR93W40YJBJ1DCs5n+JXGLTOkYRXhQMVnuDsSH/bxlH0
         mTFgayA3130LcvBMH+3uWO1Ar/LFOVhKKvpxFeIujDcH4f79LahDfSwmt9Na2fi8iWnK
         3WqMlvmPg0rXES1+mrdX/J3yFkNR1EM0IfTCasaWawZSj7qknTrVZGyMUIv1b+qRCUXq
         Sm7yjqVwXjlzglxR07fXQ3RWiYai5OD+Cs/A58JBNMywRYZBWeK++GEzbUvtk07zlxjD
         p/hA==
X-Gm-Message-State: AOAM530Tx9ZvldzgjUsF+JszfQ36OIZShk0JibhVxc487EeTf2+K80Kh
        lhjvt7VtS6xWHMHemEtlQvs=
X-Google-Smtp-Source: ABdhPJx4yR4sFcGTnVPf0+nQFkzMzk01S333bAdQdTNYZQL4Dw/MVO/pK1U9GpoCjtqJWpwMvDSNkw==
X-Received: by 2002:a17:907:7255:b0:6e7:e853:73b8 with SMTP id ds21-20020a170907725500b006e7e85373b8mr11975266ejc.172.1649305920692;
        Wed, 06 Apr 2022 21:32:00 -0700 (PDT)
Received: from anparri.mshome.net (host-87-11-75-174.retail.telecomitalia.it. [87.11.75.174])
        by smtp.gmail.com with ESMTPSA id ke11-20020a17090798eb00b006e7fbf53398sm3531341ejc.129.2022.04.06.21.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 21:32:00 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 0/6] PCI: hv: VMbus requestor and related fixes
Date:   Thu,  7 Apr 2022 06:30:22 +0200
Message-Id: <20220407043028.379534-1-parri.andrea@gmail.com>
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

Changes since RFC [1]:

  - Rebase on hyperv-fixes (although more likely -next material)
  - Fix handling of messages with transaction ID of 0
  - Avoid reading trans_id from the ring buffer
  - Move hv_pci_request_addr_match()&co. to VMbus
  - Introduce primitives to lock and unlock the requestor
  - Improve comments and log messages

The series got bigger (mainly due to a certain re-factoring in VMbus): the
hv_pci changes are in patches #2 and #6.  Let me stress that the "PCI: hv"
patches and the "Drivers: hv: vmbus" patches below are inter-dependent.

[1] https://lkml.kernel.org/r/20220328144244.100228-1-parri.andrea@gmail.com

Thanks,
  Andrea

Andrea Parri (Microsoft) (6):
  Drivers: hv: vmbus: Fix handling of messages with transaction ID of
    zero
  PCI: hv: Use vmbus_requestor to generate transaction IDs for VMbus
    hardening
  Drivers: hv: vmbus: Introduce vmbus_sendpacket_getid()
  Drivers: hv: vmbus: Introduce vmbus_request_addr_match()
  Drivers: hv: vmbus: Introduce {lock,unlock}_requestor()
  PCI: hv: Fix synchronization between channel callback and
    hv_compose_msi_msg()

 drivers/hv/channel.c                | 116 +++++++++++++++++++++-------
 drivers/hv/hyperv_vmbus.h           |   2 +-
 drivers/hv/ring_buffer.c            |  14 +++-
 drivers/pci/controller/pci-hyperv.c |  68 ++++++++++++----
 include/linux/hyperv.h              |  27 +++++++
 5 files changed, 179 insertions(+), 48 deletions(-)

-- 
2.25.1

