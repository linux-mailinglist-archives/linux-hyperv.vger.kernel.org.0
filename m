Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080EA52404A
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 May 2022 00:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348764AbiEKWc0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 18:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiEKWcZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 18:32:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3D62A18;
        Wed, 11 May 2022 15:32:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k27so4180020edk.4;
        Wed, 11 May 2022 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rL9q1a1EeCnS72sAyvjARKItZ8kxxTTeGVdvVhBpEkQ=;
        b=I84mYgaqMn3/HHXjspIHPNSz0fiSYhIrS1/hW5nAV5jByjcVzW2lpGByw9DBQ5GZKS
         bnOiwe4MoO33cHXCl3IYfh3ZgRgNpN56PR+P+Qx8DlNdk/b1EESeOWh9FOLUiKCbZ7aD
         xk3X6N4IXfOPAx9VxECn1jP4sVOj/ufTMycGkboHetx+fCzW41bBYLOhGaeGtFtnLwO2
         H1evJSAa1QwgKEFuOgkox/tw32lmZSt4cbWpY6vna74Rt3VDZaUsKSm0AJ2vyhAZY7cB
         w7mb0Otpzs7rcFMEU/VkS2ytYkqZj0vTfqzTs9MNOxjlTyO97hH3i3LydDm66iUibq/k
         fD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rL9q1a1EeCnS72sAyvjARKItZ8kxxTTeGVdvVhBpEkQ=;
        b=wyFUz+S+dKsVdsFlZp2p4b/IVVs1GgkRYrXfF+Je7nIDBAkXjwosHFhIZG83H+TP/O
         FaEZIE2ptKt7aCHf/L9z9UH8CROW5WYjFTVOSsgP9PyR9cpHJ+eR7eBhP+T76FqRMMTz
         RCoc4lk+0JIaDSt5S7RVFQ4y4Z+wBvhNmQ/4SqasVk5GURNyaHVVteRC/Xj3nHPWxyih
         GBCbHqk6D7p3FQae1fPYKPFA4H6Pu2n56EXaBIajznZOncTdwcYSxlFWJmDtFmHOK/k2
         Q6yOwjzNNogDyLhx3wAP65CJtHSi5uFM/yWi7FgLWdwFSGNbRawr3/qoP+AnTYtTsYGk
         Aqtw==
X-Gm-Message-State: AOAM531ZLclms8c4Zjs3JXDTUlvr0SHL8IVCrEA5+uCO5JQYEsFjcxMM
        19rahYhiOOPxmS2CpBkuewAkYmuwmGU=
X-Google-Smtp-Source: ABdhPJz1X8XoNDPt8R0juMrba4PxJQPDZf5jjyy4BuqH4w+BlYcyN5Tp9et9hEXfuoCKrYqtKahRaA==
X-Received: by 2002:aa7:c0c4:0:b0:425:c776:6f17 with SMTP id j4-20020aa7c0c4000000b00425c7766f17mr31121586edp.131.1652308342427;
        Wed, 11 May 2022 15:32:22 -0700 (PDT)
Received: from anparri.mshome.net (host-79-30-69-23.retail.telecomitalia.it. [79.30.69.23])
        by smtp.gmail.com with ESMTPSA id f1-20020a1709064dc100b006fa84a0af2asm1468456ejw.16.2022.05.11.15.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:32:21 -0700 (PDT)
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
Subject: [PATCH v2 0/2] PCI: hv: Hardening changes
Date:   Thu, 12 May 2022 00:32:05 +0200
Message-Id: <20220511223207.3386-1-parri.andrea@gmail.com>
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

Changes since v1[1]:
  - Add validation in q_resource_requirements()

Patch #2 depends on changes in hyperv-next.  (Acknowledging that hyperv
is entering EOM, for review.)

Thanks,
  Andrea

[1] https://lkml.kernel.org/r/20220504125039.2598-1-parri.andrea@gmail.com

Andrea Parri (Microsoft) (2):
  PCI: hv: Add validation for untrusted Hyper-V values
  PCI: hv: Fix synchronization between channel callback and
    hv_pci_bus_exit()

 drivers/pci/controller/pci-hyperv.c | 59 +++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 16 deletions(-)

-- 
2.25.1

