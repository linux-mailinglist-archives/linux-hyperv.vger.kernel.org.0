Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E2748F042
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jan 2022 20:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbiANTCv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jan 2022 14:02:51 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:41491 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiANTCu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jan 2022 14:02:50 -0500
Received: by mail-wm1-f42.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so7415132wme.0;
        Fri, 14 Jan 2022 11:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7xbkH8ySgVRyb++h+vOq7/NEH2+ZignL/wqeBWgwOVo=;
        b=PfVDOVHw8o+41roaWtM7QHdeC8eTB3GuQKmRIhkpiX35yfy+7DqQM8CiF32bDlSyjd
         gDqDCC/v08Sh0Uhp9GlFnTGpL/uNW1mfsooKbgafMAL0r/Pi2Hd73Bkd8mO96aKw1YX0
         fzUVofHQSv1HuMY29rRP8a0LYhltgaSv8S7MdipUbTUP4VbDTVFH+JCZ9tNYfadHvSxR
         5gAXaZwhQkU52/3wdrcxs7P0LvVt3hKRb+T9qs0MXjQIhYfYdv73955tlppvXKs/mXra
         dw3g8HPUhh3UICl/yCysai5NuCZ1OP9mI8tV/QbYN7BvnE6QaW6Mg8qgBTjCtcdz/EAt
         /rVg==
X-Gm-Message-State: AOAM5326pTTtyk/7/QCpF4Q8te8BdXYyhw4qZ61QOSiSq6ArlQlERtO2
        FBR/H/K6FGKbY5FYh4p3b0E=
X-Google-Smtp-Source: ABdhPJwJNAQcgBz8MtdcvxZ/phfILeb3P29zYDYjzf2ihnp9C7hcinKrG7sVFEIxzLQADumHQGa7Vg==
X-Received: by 2002:a7b:cb83:: with SMTP id m3mr9595791wmi.150.1642186968887;
        Fri, 14 Jan 2022 11:02:48 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o38sm6759742wms.11.2022.01.14.11.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 11:02:48 -0800 (PST)
Date:   Fri, 14 Jan 2022 19:02:46 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V next for 5.17
Message-ID: <20220114190246.4uvu7oehhugxcwki@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220114

for you to fetch changes up to 4eea5332d67d8ae6ba5717ec0f4e671fdbd222e7:

  scsi: storvsc: Fix storvsc_queuecommand() memory leak (2022-01-10 12:33:47 +0000)

If you see a conflict with net-next, here is a resolution:
https://lore.kernel.org/linux-next/20211220185139.034d8e15@canb.auug.org.au/

Thanks,
Wei.

----------------------------------------------------------------
hyperv-next for 5.17
  - More patches for Hyper-V isolation VM support (Tianyu Lan)
  - Bug fixes and clean-up patches from various people
----------------------------------------------------------------
Juan Vazquez (2):
      Drivers: hv: vmbus: Initialize request offers message for Isolation VM
      scsi: storvsc: Fix storvsc_queuecommand() memory leak

Michael Kelley (2):
      Drivers: hv: Fix definition of hypercall input & output arg variables
      x86/hyperv: Fix definition of hv_ghcb_pg variable

Tianyu Lan (5):
      swiotlb: Add swiotlb bounce buffer remap function for HV IVM
      x86/hyper-v: Add hyperv Isolation VM check in the cc_platform_has()
      hyper-v: Enable swiotlb bounce buffer for Isolation VM
      scsi: storvsc: Add Isolation VM support for storvsc driver
      net: netvsc: Add Isolation VM support for netvsc driver

Vitaly Kuznetsov (1):
      x86/hyperv: Properly deal with empty cpumasks in hyperv_flush_tlb_multi()

Wei Liu (1):
      swiotlb: Add CONFIG_HAS_IOMEM check around swiotlb_mem_remap()

YueHaibing (1):
      scsi: storvsc: Fix unsigned comparison to zero

 arch/x86/hyperv/hv_init.c         |  14 +++-
 arch/x86/hyperv/ivm.c             |  28 ++++++++
 arch/x86/hyperv/mmu.c             |  19 +++---
 arch/x86/include/asm/mshyperv.h   |   2 +-
 arch/x86/kernel/cc_platform.c     |   8 +++
 arch/x86/kernel/cpu/mshyperv.c    |  15 ++++-
 drivers/hv/channel_mgmt.c         |   2 +-
 drivers/hv/hv_common.c            |  15 ++++-
 drivers/hv/vmbus_drv.c            |   4 ++
 drivers/net/hyperv/hyperv_net.h   |   5 ++
 drivers/net/hyperv/netvsc.c       | 136 +++++++++++++++++++++++++++++++++++++-
 drivers/net/hyperv/netvsc_drv.c   |   1 +
 drivers/net/hyperv/rndis_filter.c |   2 +
 drivers/scsi/storvsc_drv.c        |  54 +++++++++------
 include/asm-generic/mshyperv.h    |   6 +-
 include/linux/hyperv.h            |   6 ++
 include/linux/swiotlb.h           |   6 ++
 kernel/dma/swiotlb.c              |  50 +++++++++++++-
 18 files changed, 328 insertions(+), 45 deletions(-)
