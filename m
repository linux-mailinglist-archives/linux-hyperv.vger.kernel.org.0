Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5966C536DC4
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 May 2022 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbiE1QaH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 May 2022 12:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbiE1QaG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 May 2022 12:30:06 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE20A12AAC;
        Sat, 28 May 2022 09:30:04 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id l188-20020a1c25c5000000b003978df8a1e2so2173948wml.1;
        Sat, 28 May 2022 09:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=n2j0NQuXTr3/UzYzmLJXJBWH2KDlRsWiyk09n6SroQA=;
        b=KnLKNM15j+kSLGUS5/imiesbqLM4hbfhsUTwZasPrIjIpKmnobLt7MdaZZSIqnsf+5
         4sSWKOaP5YK7TwRp43I8gEa1foSvzpX6VNmrigTcqvoZsYehprSaHl8oy/YvesIDV4VV
         VpK0Re7Pe323Xab//WIsWfiVwwxIj7TYaVusBhEbS1zSf3Vj26F4jgigYbZ5ZZCJ6+bd
         6UzrJ52oBFOfOMt/rgMg5jb27nN2mFgrV2+8TeweYm8C19rqgjE+CGuaXlSSKPulnd6l
         0hkpR+D1yA4b43eG/xOby1i26gCEu0cLv3qn8Qhni+D6FPTLHcjlkPu7PoVMCDrGIuvl
         9T6g==
X-Gm-Message-State: AOAM530YMf8qJynpOV+ENyFmm6/QAdikGePxT4N637Avoer67Dpf5egY
        m8pfCLH3SlwR6lngZr9TWWE=
X-Google-Smtp-Source: ABdhPJyYAoJtuZ6Vyark2oPrPA4ZOu3ScR68ym2u8fGkiyptAKT2OAYB4ZLztN/uvm19nlXeZ84P2w==
X-Received: by 2002:a05:600c:154d:b0:394:8582:58f3 with SMTP id f13-20020a05600c154d00b00394858258f3mr11864933wmg.90.1653755403230;
        Sat, 28 May 2022 09:30:03 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k7-20020a1ca107000000b00394708a3d7dsm5371820wme.15.2022.05.28.09.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 09:30:02 -0700 (PDT)
Date:   Sat, 28 May 2022 16:30:01 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V next for 5.19
Message-ID: <20220528163001.43ripr5agsesyq7o@liuwe-devbox-debian-v2>
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

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220528

for you to fetch changes up to d27423bf048dcb5e15f04286d001c66685e30c29:

  hv_balloon: Fix balloon_probe() and balloon_remove() error handling (2022-05-26 10:04:57 +0000)

----------------------------------------------------------------
hyperv-next for 5.19
 - Harden hv_sock driver (Andrea Parri)
 - Harden Hyper-V PCI driver (Andrea Parri)
 - Fix multi-MSI for Hyper-V PCI driver (Jeffrey Hugo)
 - Fix Hyper-V PCI to reduce boot time (Dexuan Cui)
 - Remove code for long EOL'ed Hyper-V versions (Michael Kelley, Saurabh Sengar)
 - Fix balloon driver error handling (Shradha Gupta)
 - Fix a typo in vmbus driver (Julia Lawall)
 - Ignore vmbus IMC device (Michael Kelley)
 - Add a new error message to Hyper-V DRM driver (Saurabh Sengar)

----------------------------------------------------------------
Andrea Parri (Microsoft) (13):
      Drivers: hv: vmbus: Fix handling of messages with transaction ID of zero
      PCI: hv: Use vmbus_requestor to generate transaction IDs for VMbus hardening
      Drivers: hv: vmbus: Introduce vmbus_sendpacket_getid()
      Drivers: hv: vmbus: Introduce vmbus_request_addr_match()
      Drivers: hv: vmbus: Introduce {lock,unlock}_requestor()
      PCI: hv: Fix synchronization between channel callback and hv_compose_msi_msg()
      hv_sock: Check hv_pkt_iter_first_raw()'s return value
      hv_sock: Copy packets sent by Hyper-V out of the ring buffer
      hv_sock: Add validation for untrusted Hyper-V values
      Drivers: hv: vmbus: Accept hv_sock offers in isolated guests
      Drivers: hv: vmbus: Refactor the ring-buffer iterator functions
      PCI: hv: Add validation for untrusted Hyper-V values
      PCI: hv: Fix synchronization between channel callback and hv_pci_bus_exit()

Dexuan Cui (1):
      PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot time

Jeffrey Hugo (4):
      PCI: hv: Fix multi-MSI to allow more than one MSI vector
      PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI
      PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()
      PCI: hv: Fix interrupt mapping for multi-MSI

Julia Lawall (1):
      Drivers: hv: vmbus: fix typo in comment

Michael Kelley (6):
      Drivers: hv: vmbus: Add VMbus IMC device to unsupported list
      x86/hyperv: Disable hardlockup detector by default in Hyper-V guests
      Drivers: hv: vmbus: Remove support for Hyper-V 2008 and Hyper-V 2008R2/Win7
      scsi: storvsc: Remove support for Hyper-V 2008 and 2008R2/Win7
      video: hyperv_fb: Remove support for Hyper-V 2008 and 2008R2/Win7
      drm/hyperv: Remove support for Hyper-V 2008 and 2008R2/Win7

Saurabh Sengar (2):
      drm/hyperv: Add error message for fb size greater than allocated
      scsi: storvsc: Removing Pre Win8 related logic

Shradha Gupta (1):
      hv_balloon: Fix balloon_probe() and balloon_remove() error handling

 arch/x86/kernel/cpu/mshyperv.c              |   2 +
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |   5 +-
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c   |  23 +--
 drivers/hv/channel.c                        | 116 +++++++++----
 drivers/hv/channel_mgmt.c                   |  40 +++--
 drivers/hv/connection.c                     |   6 +-
 drivers/hv/hv_balloon.c                     |  21 ++-
 drivers/hv/hyperv_vmbus.h                   |   2 +-
 drivers/hv/ring_buffer.c                    |  46 +++---
 drivers/hv/vmbus_drv.c                      |  60 ++-----
 drivers/pci/controller/pci-hyperv.c         | 243 +++++++++++++++++++++-------
 drivers/scsi/storvsc_drv.c                  | 191 ++++++----------------
 drivers/video/fbdev/hyperv_fb.c             |  23 +--
 include/linux/hyperv.h                      |  97 ++++++-----
 net/vmw_vsock/hyperv_transport.c            |  21 ++-
 15 files changed, 477 insertions(+), 419 deletions(-)
