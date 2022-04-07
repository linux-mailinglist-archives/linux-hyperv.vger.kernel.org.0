Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A144F8236
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 16:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242849AbiDGO4E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 10:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344324AbiDGO4D (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 10:56:03 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA941EC616;
        Thu,  7 Apr 2022 07:54:02 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id q20so3732750wmq.1;
        Thu, 07 Apr 2022 07:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2quiVS5lI5pGNZBTe6ox280MwNH8HDfpHT/u6CqkRgw=;
        b=gAnBl+rvIlAkU9wTLEnNidVtiZobjTRlf9wimgDNjjMSZwlqQU9joua7Wf57vPV2Ip
         jvTS534nNCaNprQjMDIXuk86UWOD6X1HWplVQUhns8n206klFAE69lketsdWfsKglKMf
         6ZLixFZF5aJQ4Tf9kDxHgC13jq30Ayv+3uyljTpEbEzjws2pFHXhj3WAhjJRetmr0IAY
         IZ6adGpneXOjqqlJ3DunHiix1VEMSFZiuZ4AfWDvtJhA5dvrHVT/RG8QKxM276y1AM0+
         xNUoKdKZQH2HOfcX/BoJb4bzmzX9eor+3rMgsybtU+NE2VHnyR9RA4X9mjhIrWjJb3j/
         m00Q==
X-Gm-Message-State: AOAM531GccRLzCStfuQDorY4De2PMHKjzX/NC8/PDQeCedO2Z13ykm3s
        ulG0SEg8KcuavmSLYJZNpxS8+QcDUvw=
X-Google-Smtp-Source: ABdhPJxDy17/TTh6YO6BE6Y3WkyWgxgVz/eJY3iQUSot3fbp2xBJvmrxpW+mu86675CUHKgw4Q5FVQ==
X-Received: by 2002:a1c:46c5:0:b0:38e:6a96:1aa0 with SMTP id t188-20020a1c46c5000000b0038e6a961aa0mr12777360wma.186.1649343233891;
        Thu, 07 Apr 2022 07:53:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n65-20020a1c2744000000b003862bfb509bsm7732264wmn.46.2022.04.07.07.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:53:53 -0700 (PDT)
Date:   Thu, 7 Apr 2022 14:53:51 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 5.18-rc2
Message-ID: <20220407145351.n5nnpcp4rqusrqnh@liuwe-devbox-debian-v2>
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

The following changes since commit f443e374ae131c168a065ea1748feac6b2e76613:

  Linux 5.17 (2022-03-20 13:14:17 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220407

for you to fetch changes up to eaa03d34535872d29004cb5cf77dc9dec1ba9a25:

  Drivers: hv: vmbus: Replace smp_store_mb() with virt_store_mb() (2022-04-06 13:31:58 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.18-rc2
  - Correctly propagate coherence information for VMbus devices (Michael
    Kelley)
  - Disable balloon and memory hot-add on ARM64 temporarily (Boqun Feng)
  - Use barrier to prevent reording when reading ring buffer (Michael
    Kelley)
  - Use virt_store_mb in favour of smp_store_mb (Andrea Parri)
  - Fix VMbus device object initialization (Andrea Parri)
  - Deactivate sysctl_record_panic_msg on isolated guest (Andrea Parri)
  - Fix a crash when unloading VMbus module (Guilherme G. Piccoli)
----------------------------------------------------------------
Andrea Parri (Microsoft) (3):
      Drivers: hv: vmbus: Deactivate sysctl_record_panic_msg by default in isolated guests
      Drivers: hv: vmbus: Fix initialization of device object in vmbus_device_register()
      Drivers: hv: vmbus: Replace smp_store_mb() with virt_store_mb()

Boqun Feng (2):
      Drivers: hv: balloon: Support status report for larger page sizes
      Drivers: hv: balloon: Disable balloon and hot-add accordingly

Guilherme G. Piccoli (1):
      Drivers: hv: vmbus: Fix potential crash on module unload

Michael Kelley (3):
      Drivers: hv: vmbus: Propagate VMbus coherence to each VMbus device
      PCI: hv: Propagate coherence from VMbus device to PCI device
      Drivers: hv: vmbus: Prevent load re-ordering when reading ring buffer

 drivers/hv/channel_mgmt.c           |  6 ++--
 drivers/hv/hv_balloon.c             | 49 +++++++++++++++++++++++++---
 drivers/hv/hv_common.c              | 11 +++++++
 drivers/hv/ring_buffer.c            | 11 ++++++-
 drivers/hv/vmbus_drv.c              | 65 ++++++++++++++++++++++++++++++-------
 drivers/pci/controller/pci-hyperv.c |  9 +++++
 include/asm-generic/mshyperv.h      |  1 +
 7 files changed, 132 insertions(+), 20 deletions(-)
