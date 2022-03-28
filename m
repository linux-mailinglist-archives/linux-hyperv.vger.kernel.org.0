Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D6D4E99F5
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Mar 2022 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243993AbiC1Oou (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Mar 2022 10:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiC1Oot (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Mar 2022 10:44:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5011E25DB;
        Mon, 28 Mar 2022 07:43:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h4so9428398edr.3;
        Mon, 28 Mar 2022 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPi1GcB8yM8cAT7S1c5FqNzXBFyXnmjwGCRKYtVbIgU=;
        b=jBRgWqZtMl62v6uxmvgMEgXQ4ksA7zVl2ES3A6kUcaZsWofPtgQANFKoPT/MrS9AM1
         GETRSbQrjIvEXA+ff/Z4GQF2kB9pFwWFuhhmUto5pX0Gbz+c3//n6mPsxDuCVgBjC8RZ
         tojfIl2/m8it5it/iMvlEdCK6ESLjR/535EOQqjMIFr+UVahlP69gmNstume9L5gndiW
         8meRAsGkPbLhH54HY9kNbq0ap6RFP7FkF2Iwf1dHw5KXpGLb7DELGXKFsEwTT2yhvXgQ
         9HkyfXCNrZwqqI20S66XZeA76rpokcCgdlLubyRXSfgVA0+1TW3WGIzqRl0MCwNk/ObS
         rd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPi1GcB8yM8cAT7S1c5FqNzXBFyXnmjwGCRKYtVbIgU=;
        b=ZEexo8HUEbUBbQsTMxENpSFeRQnZmQF3yixpQ4wjwMeI5/zSMoAgLY93p+eWNsn/1B
         XtZ4VdSa6k16swRY+u4depOkaG2w7kNRRWaToXbFVHXmLwQtBb61HqYH6E325E6aVPfJ
         nhn35HMfoDf/oBO0qHVIgaGdfGTF2zRlmcynvy8SZCdgSAIV0BKsj1LoE/ifbBQUQN+f
         1kqn567CHczHkaMs1SooH1tYP39CNmahrYgXdLs49/WLHH5ioKRSdKQ8PHn1yygbed6M
         nDnzcNXyiQM6dkvTFELU3Y6Fw7ak2VR6zBzj2CkWJZ1yRBErrSQdRh0U7N89sa81Bq2h
         8QnA==
X-Gm-Message-State: AOAM533dNHyawFG6L4PblC8yGg1q5zibvdFSx8fG5gUXK9pdwbOxLJkq
        Qn824M/GsOINvLvSeGHEmpI=
X-Google-Smtp-Source: ABdhPJzO42mbNXXKGAICSLGJyjwnTYM/5BJCuYvLvg5nnTt809l3gVR4O2xXPw/CY0rLQqxYdovBAA==
X-Received: by 2002:aa7:d751:0:b0:419:2558:a78b with SMTP id a17-20020aa7d751000000b004192558a78bmr16689820eds.6.1648478586661;
        Mon, 28 Mar 2022 07:43:06 -0700 (PDT)
Received: from anparri.mshome.net (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7c842000000b0041314b98872sm7008983edt.22.2022.03.28.07.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:43:06 -0700 (PDT)
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
Subject: [RFC PATCH 0/4] PCI: hv: Miscellaneous changes
Date:   Mon, 28 Mar 2022 16:42:40 +0200
Message-Id: <20220328144244.100228-1-parri.andrea@gmail.com>
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

A re-work of [1] to use vmbus_requestor.

Thanks,
  Andrea

[1] https://lkml.kernel.org/r/20220318174848.290621-1-parri.andrea@gmail.com

Andrea Parri (Microsoft) (4):
  Drivers: hv: vmbus: Remove special code for unsolicited messages
  PCI: hv: Use vmbus_requestor to generate transaction IDs for VMbus
    hardening
  Drivers: hv: vmbus: Introduce vmbus_sendpacket_getid()
  PCI: hv: Fix synchronization between channel callback and
    hv_compose_msi_msg()

 drivers/hv/channel.c                |  51 ++++++++-----
 drivers/hv/hyperv_vmbus.h           |   2 +-
 drivers/hv/ring_buffer.c            |   4 +-
 drivers/pci/controller/pci-hyperv.c | 109 +++++++++++++++++++++++++---
 include/linux/hyperv.h              |   7 ++
 5 files changed, 141 insertions(+), 32 deletions(-)

-- 
2.25.1

