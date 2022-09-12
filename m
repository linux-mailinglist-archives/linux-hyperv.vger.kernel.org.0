Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10545B6355
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Sep 2022 00:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiILWNy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Sep 2022 18:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiILWNs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Sep 2022 18:13:48 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6BA4DF1C;
        Mon, 12 Sep 2022 15:13:46 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id r67-20020a1c4446000000b003b494ffc00bso588948wma.0;
        Mon, 12 Sep 2022 15:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=53k+bdZ+X7Y3lP2YSbFqb82M1FElYXnYPN9ESB2zHCs=;
        b=BL3WhpEPWZOS7nhCZ6UHI9alLzVcJgN2WlD/tWDeIrhxfZaOBaqQx10STlXe4GlMiW
         RxzvAkwRCxuXWpqPTT87EljhIejGM0bx6cxRDutpLMDH2vhq/7hY/+lL0vC+UcAGwTKa
         2eAZo+be81ZKubIGCKEmb9DvpU+nQearp1BYCNeDc1yxmRsotfbeqQslZ6jd9klX6NAe
         aWaNZEIhjLW6UVAQ6GJmhKmInw8/2zXAQMSLP+dLVEGND2gcyJpflRM530pLdcgt8vCJ
         rxHObXxVKXaQ3rw3ujzdb9GVYONofAUsWJsFDBxIP3JxwHQY6eM7YhBb3Qewj2hx5nGn
         S4/w==
X-Gm-Message-State: ACgBeo1u/2iApAd+BlMB2H37nrdZ9zMA3d+yDH+xeKLWB+jhCFEwsgxW
        OqzYywsRRILfIy04KJDfUG5mvvoCdYA=
X-Google-Smtp-Source: AA6agR4VuId6uc5NtUhf/Y06HnI6680gSlJbZb4vHBFu4fzgNctgWGiDiYjEJ4Vv8md7SCpd8pTJkg==
X-Received: by 2002:a1c:4b0d:0:b0:3b4:76ae:f7a5 with SMTP id y13-20020a1c4b0d000000b003b476aef7a5mr302526wma.23.1663020825069;
        Mon, 12 Sep 2022 15:13:45 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id cl2-20020a5d5f02000000b0022a9246c853sm3542531wrb.41.2022.09.12.15.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:13:44 -0700 (PDT)
Date:   Mon, 12 Sep 2022 22:13:38 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, sthemmin@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for 6.0-rc6
Message-ID: <Yx+vEggYHHyBdb5r@liuwe-devbox-debian-v2>
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

Hi Linus,

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220912

for you to fetch changes up to f0880e2cb7e1f8039a048fdd01ce45ab77247221:

  Drivers: hv: Never allocate anything besides framebuffer from framebuffer memory region (2022-09-05 17:02:15 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.0-rc6
 - Fix an error handling issue in DRM driver (Christophe JAILLET)
 - Fix some issues in framebuffer driver (Vitaly Kuznetsov)
 - Two typo fixes (Jason Wang, Shaomin Deng)
 - Drop unnecessary casting in kvp tool (Zhou Jie)
----------------------------------------------------------------
Christophe JAILLET (1):
      drm/hyperv: Fix an error handling path in hyperv_vmbus_probe()

Jason Wang (1):
      tools: hv: Remove an extraneous "the"

Shaomin Deng (1):
      Drivers: hv: remove duplicate word in a comment

Vitaly Kuznetsov (3):
      PCI: Move PCI_VENDOR_ID_MICROSOFT/PCI_DEVICE_ID_HYPERV_VIDEO definitions to pci_ids.h
      Drivers: hv: Always reserve framebuffer region for Gen1 VMs
      Drivers: hv: Never allocate anything besides framebuffer from framebuffer memory region

Zhou jie (1):
      tools: hv: kvp: remove unnecessary (void*) conversions

 drivers/gpu/drm/hyperv/hyperv_drm_drv.c         | 10 ++---
 drivers/hv/hv_fcopy.c                           |  2 +-
 drivers/hv/vmbus_drv.c                          | 56 ++++++++++++++++++-------
 drivers/net/ethernet/microsoft/mana/gdma_main.c |  4 --
 drivers/video/fbdev/hyperv_fb.c                 |  4 --
 include/linux/pci_ids.h                         |  3 ++
 tools/hv/hv_kvp_daemon.c                        |  6 +--
 7 files changed, 52 insertions(+), 33 deletions(-)
