Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F6569CF46
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Feb 2023 15:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjBTOXj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Feb 2023 09:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjBTOXi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Feb 2023 09:23:38 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B99E3C3F;
        Mon, 20 Feb 2023 06:23:37 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id r7so1230614wrz.6;
        Mon, 20 Feb 2023 06:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UWNMxDMeHE0TebZowkoBIFZYFHiATXlwqsb06ZfgVg=;
        b=Fg0DoVWXKoHq/AmT7R0ojXUhmSPe3mfNYBH9x8bcjaAYNXi10JzxcgRApqbbCQs/4S
         398bYwig6zUoeZklbUR1VP1C7xT9Q53FtqYFXFBVd9fXq1UGEDhOy49B2IzSoGMBrqR5
         ri/Zrb6VtSgREEhPAVmH4i7eewyOozPeSTHEbFRQKHK64uGdpZyTYGk1H9XuT9ZCAC8G
         CC0O5J5w6Z5jGV9PbNcYDC2BNOA6QNmvLiDYAwaBpDC5PHWirFbvHeHV3kd1ILn6Ro87
         TIpHLEpLV0WHqLaYn6VY/bxmJzAwCitmKqee1aCxJUyteH+hGIqtADFEIDrF0F7huUsX
         YmsA==
X-Gm-Message-State: AO0yUKUl7v+90wRs1Ssjp7+i3vcw4mXKRuy+zIvk1QeS9Y5tKgyiVjZD
        s0lMOrhdcd4wKCzWe1DsX78=
X-Google-Smtp-Source: AK7set/LDFMwxzZl+i5MOxauBVR4yzGzF/L5bcerLNWlMqVHhHX7Ar4VyXZn0MNfInakmDD6hPK85w==
X-Received: by 2002:adf:f5c9:0:b0:2c5:5886:850d with SMTP id k9-20020adff5c9000000b002c55886850dmr758189wrp.5.1676903015738;
        Mon, 20 Feb 2023 06:23:35 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b002be099f78c0sm2145989wrv.69.2023.02.20.06.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 06:23:35 -0800 (PST)
Date:   Mon, 20 Feb 2023 14:23:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V commits for 6.3
Message-ID: <Y/OCT7A/7GHNxgX4@liuwe-devbox-debian-v2>
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

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20230220

for you to fetch changes up to b14033a3e6ba73a5c68974a80b05cba55553ed5b:

  x86/hyperv: Fix hv_get/set_register for nested bringup (2023-02-16 14:32:37 +0000)

----------------------------------------------------------------
hyperv-next for v6.3.
 - Patches that allow Linux to run as the nested root partition for
   Microsoft Hypervisor (Jinank Jain and Nuno Das Neves).
 - One patch to clean up the return type of callback functions (Dawei
   Li).
----------------------------------------------------------------
Dawei Li (1):
      Drivers: hv: Make remove callback of hyperv driver void returned

Jinank Jain (4):
      x86/hyperv: Add support for detecting nested hypervisor
      Drivers: hv: Setup synic registers in case of nested root partition
      x86/hyperv: Add an interface to do nested hypercalls
      Drivers: hv: Enable vmbus driver for nested root partition

Nuno Das Neves (1):
      x86/hyperv: Fix hv_get/set_register for nested bringup

 arch/x86/include/asm/hyperv-tlfs.h      | 17 ++++++-
 arch/x86/include/asm/mshyperv.h         | 78 +++++++++++++++++++++------------
 arch/x86/kernel/cpu/mshyperv.c          | 72 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c |  4 +-
 drivers/hid/hid-hyperv.c                |  4 +-
 drivers/hv/hv.c                         | 18 +++++---
 drivers/hv/hv_balloon.c                 |  4 +-
 drivers/hv/hv_common.c                  |  9 ++--
 drivers/hv/hv_util.c                    |  4 +-
 drivers/hv/vmbus_drv.c                  |  2 +-
 drivers/input/serio/hyperv-keyboard.c   |  4 +-
 drivers/net/hyperv/netvsc_drv.c         |  5 +--
 drivers/pci/controller/pci-hyperv.c     |  8 +---
 drivers/scsi/storvsc_drv.c              |  4 +-
 drivers/uio/uio_hv_generic.c            |  5 +--
 drivers/video/fbdev/hyperv_fb.c         |  5 +--
 include/asm-generic/hyperv-tlfs.h       |  1 +
 include/asm-generic/mshyperv.h          |  1 +
 include/linux/hyperv.h                  |  2 +-
 net/vmw_vsock/hyperv_transport.c        |  4 +-
 20 files changed, 172 insertions(+), 79 deletions(-)
