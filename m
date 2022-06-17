Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A885554F914
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jun 2022 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382650AbiFQOWl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Jun 2022 10:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382687AbiFQOWj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Jun 2022 10:22:39 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4005F1097;
        Fri, 17 Jun 2022 07:22:36 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id o8so5991900wro.3;
        Fri, 17 Jun 2022 07:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=c8VmtpTRYG5fhkhWdPkEXbN1LxbOk6olcANxFq8csnQ=;
        b=ybyOK7AZaWu7i7rfGrUnoTlebrZAGhO1PfUJCbZM3ItbZAL6gKOT/AJHYAAldBBLNj
         Fc8Bfx65/75qVBhPz0ihFLpJ8j+ujR0sapX9CBIC9amp2XIPiz9PiiO/Rk538WTicCMD
         SfeYEL557T6kOtq98d19efs48B5KzTYeSYL4CWNMxI6+SyGbXYRTIfJpqBxryooB6FtD
         LATu3R2X+t/FEGsREnjAJOLi3KB6q7PNBDVc3X6gKvVvt4IxPxJiQvtkmk9Q52p/pIhU
         n8hMOtd7jnBORf129DWR00IyhJWD0UL7pAAJrjZnbDf20o0juewrSMcg1nSxjsVeMhd/
         Jk8A==
X-Gm-Message-State: AJIora+/2U7LEynKNfTkNUbJyH9Eb7/1XpQq6K66EaNOuaxYEvejCNY7
        wfSeHrxN1osAOKlj1768WX88TwDt0gI=
X-Google-Smtp-Source: AGRyM1svLN+L856cKvC0yfI0oeQW01EZyuX42LKqkUuD4s1Qyo3rOUCVkk+zmey1GaU8/hWqKhZkQw==
X-Received: by 2002:adf:c64c:0:b0:21a:7a3:54a4 with SMTP id u12-20020adfc64c000000b0021a07a354a4mr9694977wrg.163.1655475754694;
        Fri, 17 Jun 2022 07:22:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b0039c747a1e8fsm10482373wmi.7.2022.06.17.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:22:34 -0700 (PDT)
Date:   Fri, 17 Jun 2022 14:22:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 5.19-rc3
Message-ID: <20220617142232.urp25kc2oi3yorqw@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220617

for you to fetch changes up to 49d6a3c062a1026a5ba957c46f3603c372288ab6:

  x86/Hyper-V: Add SEV negotiate protocol support in Isolation VM (2022-06-15 18:27:40 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.19-rc3
 - Fix hv_init_clocksource annotation (Masahiro Yamada)
 - Two bug fixes for vmbus driver (Saurabh Sengar)
 - Fix SEV negotiation (Tianyu Lan)
 - Fix comments in code (Xiang Wang)
 - One minor fix to HID driver (Michael Kelley)
----------------------------------------------------------------
Masahiro Yamada (1):
      clocksource: hyper-v: unexport __init-annotated hv_init_clocksource()

Michael Kelley (1):
      HID: hyperv: Correctly access fields declared as __le16

Saurabh Sengar (2):
      Drivers: hv: vmbus: Don't assign VMbus channel interrupts to isolated CPUs
      Drivers: hv: vmbus: Release cpu lock in error case

Tianyu Lan (1):
      x86/Hyper-V: Add SEV negotiate protocol support in Isolation VM

Xiang wangx (1):
      Drivers: hv: Fix syntax errors in comments

 arch/x86/hyperv/hv_init.c          |  6 +++
 arch/x86/hyperv/ivm.c              | 84 +++++++++++++++++++++++++++++++++++---
 arch/x86/include/asm/mshyperv.h    |  4 ++
 drivers/clocksource/hyperv_timer.c |  1 -
 drivers/hid/hid-hyperv.c           |  5 ++-
 drivers/hv/channel_mgmt.c          | 18 +++++---
 drivers/hv/hv_kvp.c                |  2 +-
 drivers/hv/vmbus_drv.c             |  4 ++
 8 files changed, 109 insertions(+), 15 deletions(-)
