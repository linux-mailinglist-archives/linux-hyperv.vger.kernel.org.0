Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D855F8DE9
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Oct 2022 22:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJIUnv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 9 Oct 2022 16:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJIUnu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 9 Oct 2022 16:43:50 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D581F636;
        Sun,  9 Oct 2022 13:43:48 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id r13so14388076wrj.11;
        Sun, 09 Oct 2022 13:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHn9e4LxEonf5attufjFVBzwY+XLmZBL4RvGkLgqEx0=;
        b=vkFf0a/uauTG3VKOFbStBouobOS+iNwME1adhBW9BUev0/wPyFBPqar9VV7re4ixCu
         y5C3sRHNMIs4EQ/jN747XMLhzN5ZEU23+ybLt5+Wyazml3a68tbO4Qa8lUbOXhNKtqF1
         ERN7FxFFXkffBBRDOZ2Af9yA4qWTxIxpagJZnMM+sw5Jh3eACnZwMCGBZh3MTxTv11KX
         k7HH+LJmglQBZm9w8UvSGdBP1/et2rM+ZbQ8OdekRLF+TUYxVsHn8hlXVNsXSgqRtg7b
         fwlYCOVCtHlfy/apcricFlxjZ9BXbt8nEclTobKvNytU6MXx9uGNfwkXfqM+y6jnQ+bQ
         5lew==
X-Gm-Message-State: ACrzQf1PD/4ZAxkAMjbp1BBZQCGbR3WaBQqn9U2gsXSJNTGweW8ZlnQp
        Tf61YjulLu5gEMbVYEStoEM=
X-Google-Smtp-Source: AMsMyM4rrpiJFoilmWiVjQIDMKceKMaAhefMCUuImbg6/bU8XSmtyT//YDSbAa8hkrsLueQcclHimQ==
X-Received: by 2002:a05:6000:912:b0:230:9113:1a09 with SMTP id bz18-20020a056000091200b0023091131a09mr959804wrb.707.1665348227268;
        Sun, 09 Oct 2022 13:43:47 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p2-20020adfce02000000b0022a3a887ceasm7263042wrn.49.2022.10.09.13.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 13:43:46 -0700 (PDT)
Date:   Sun, 9 Oct 2022 20:43:45 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V next for 6.1
Message-ID: <Y0MygRaW4C+Sy2XS@liuwe-devbox-debian-v2>
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

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20221009

for you to fetch changes up to 154fb14df7a3c81dea82eca7c0c46590f5ffc3d2:

  x86/hyperv: Replace kmap() with kmap_local_page() (2022-10-03 08:49:48 +0000)

----------------------------------------------------------------
hyperv-next for 6.1
 - Remove unnecessary delay while probing for VMBus (Stanislav
   Kinsburskiy)
 - Optimize vmbus_on_event (Saurabh Sengar)
 - Fix a race in Hyper-V DRM driver (Saurabh Sengar)
 - Miscellaneous clean-up patches from various people
----------------------------------------------------------------
Easwar Hariharan (1):
      Drivers: hv: vmbus: Use PCI_VENDOR_ID_MICROSOFT for better discoverability

Jiapeng Chong (1):
      Drivers: hv: vmbus: Fix kernel-doc

Kees Cook (1):
      Drivers: hv: vmbus: Split memcpy of flex-array

Li kunyu (1):
      hyperv: simplify and rename generate_guest_id

Saurabh Sengar (3):
      Drivers: hv: vmbus: Optimize vmbus_on_event
      drm/hyperv: Don't overwrite dirt_needed value set by host
      drm/hyperv: Add ratelimit on error message

Stanislav Kinsburskiy (1):
      Drivers: hv: vmbus: Don't wait for the ACPI device upon initialization

Zhao Liu (1):
      x86/hyperv: Replace kmap() with kmap_local_page()

wangjianli (1):
      scsi: storvsc: remove an extraneous "to" in a comment

 arch/arm64/hyperv/mshyperv.c              |  2 +-
 arch/x86/hyperv/hv_init.c                 |  6 +++---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c   |  2 --
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c |  2 +-
 drivers/hv/connection.c                   | 33 +++++++++++++------------------
 drivers/hv/vmbus_drv.c                    | 20 ++++++++-----------
 drivers/scsi/storvsc_drv.c                | 11 ++++++++++-
 include/asm-generic/mshyperv.h            |  9 +++------
 8 files changed, 40 insertions(+), 45 deletions(-)
