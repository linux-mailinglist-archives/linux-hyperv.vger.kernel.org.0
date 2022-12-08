Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB53646F21
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Dec 2022 12:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiLHL4E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Dec 2022 06:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiLHLzp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Dec 2022 06:55:45 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93402880F0;
        Thu,  8 Dec 2022 03:55:44 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id co23so1337258wrb.4;
        Thu, 08 Dec 2022 03:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVsC8pWMkNlA7rRNX+sogmPW8WicvnPcurNoKau/kBY=;
        b=UeYCy2lds64yjHP5Vugs3nNW2Zp3l1Cj+bCawg7sIPkG0wxhZYRqva8GYlkgvA4Kcs
         ko6wLHkeYm7aCaRchLcq0fif6vn4/WuNLIiEaOetQnC8/j/P6kzBlWSxUEhCgN+Cf/iV
         GOHf7iAy9KF6QEj/d3JVMDicwK9twgzLtTVVf585894+x9nnkWNNUDqIQGp4yY3i1IL4
         7xHkzAFJtT6aom/eCN8JTYjldj0rs/s03zpVZIqkax77Jc84lbDT0xIfJwTJopnclqUu
         YHzFPxYmtdSM/vB2OHSy3f512wb0Pj3+x7dwh42iIy5gbmIGdCOyGTLze2X1m5hKHlrn
         gnFQ==
X-Gm-Message-State: ANoB5pmmbwIP4eYq4RpuHUs47XbxV36fIJaJZn6NoyvUKqCupfshDKg1
        BqKHjB8YJVpwUc65GnOQ7Pk=
X-Google-Smtp-Source: AA0mqf4GF+71lQxsjFMq+40Hdl6/gdndqyxG6RIyNo2enueqi2voPWL7Lbc/+RQSiyMtEx3XMsizbw==
X-Received: by 2002:a5d:4f8f:0:b0:242:28c6:2373 with SMTP id d15-20020a5d4f8f000000b0024228c62373mr23390030wru.292.1670500543046;
        Thu, 08 Dec 2022 03:55:43 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b003b492753826sm5316605wms.43.2022.12.08.03.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 03:55:42 -0800 (PST)
Date:   Thu, 8 Dec 2022 11:55:41 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V commits for v6.2
Message-ID: <Y5HQvdUqsJeC69X8@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20221208

for you to fetch changes up to 32c97d980e2eef25465d453f2956a9ca68926a3c:

  x86/hyperv: Remove unregister syscore call from Hyper-V cleanup (2022-11-29 17:55:29 +0000)

----------------------------------------------------------------
hyperv-next for v6.2
 - Drop unregister syscore from hyperv_cleanup to avoid hang (Gaurav
   Kohli)
 - Clean up panic path for Hyper-V framebuffer (Guilherme G. Piccoli)
 - Allow IRQ remapping to work without x2apic (Nuno Das Neves)
 - Fix comments (Olaf Hering)
 - Expand hv_vp_assist_page definition (Saurabh Sengar)
 - Improvement to page reporting (Shradha Gupta)
 - Make sure TSC clocksource works when Linux runs as the root partition
   (Stanislav Kinsburskiy)
----------------------------------------------------------------
Gaurav Kohli (1):
      x86/hyperv: Remove unregister syscore call from Hyper-V cleanup

Guilherme G. Piccoli (2):
      video: hyperv_fb: Avoid taking busy spinlock on panic path
      drivers: hv, hyperv_fb: Untangle and refactor Hyper-V panic notifiers

Nuno Das Neves (1):
      iommu/hyper-v: Allow hyperv irq remapping without x2apic

Olaf Hering (2):
      hv: fix comment typo in vmbus_channel/low_latency
      PCI: hv: update comment in x86 specific hv_arch_irq_unmask

Saurabh Sengar (1):
      x86/hyperv: Expand definition of struct hv_vp_assist_page

Shradha Gupta (2):
      mm/page_reporting: Add checks for page_reporting_order param
      hv_balloon: Add support for configurable order free page reporting

Stanislav Kinsburskiy (4):
      clocksource: hyper-v: Introduce a pointer to TSC page
      clocksource: hyper-v: Introduce TSC PFN getter
      clocksource: hyper-v: Use TSC PFN getter to map vvar page
      clocksource: hyper-v: Add TSC page support for root partition

 arch/x86/entry/vdso/vma.c           |   7 ++-
 arch/x86/hyperv/hv_init.c           |   4 +-
 arch/x86/include/asm/hyperv-tlfs.h  |  11 +++-
 arch/x86/kernel/cpu/mshyperv.c      |   6 +++
 drivers/clocksource/hyperv_timer.c  |  61 ++++++++++++++++-----
 drivers/hv/hv_balloon.c             |  94 ++++++++++++++++++++++++--------
 drivers/hv/ring_buffer.c            |  13 +++++
 drivers/hv/vmbus_drv.c              | 105 ++++++++++++++++++++++--------------
 drivers/iommu/Kconfig               |   6 +--
 drivers/iommu/hyperv-iommu.c        |  11 ++--
 drivers/pci/controller/pci-hyperv.c |   6 +--
 drivers/video/fbdev/hyperv_fb.c     |  16 +++++-
 include/clocksource/hyperv_timer.h  |   7 +++
 include/linux/hyperv.h              |   4 +-
 mm/page_reporting.c                 |  50 +++++++++++++++--
 15 files changed, 302 insertions(+), 99 deletions(-)
