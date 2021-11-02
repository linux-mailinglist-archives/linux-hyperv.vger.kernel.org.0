Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16915442EE9
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Nov 2021 14:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhKBNPs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Nov 2021 09:15:48 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:40743 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhKBNPs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Nov 2021 09:15:48 -0400
Received: by mail-wm1-f53.google.com with SMTP id j128-20020a1c2386000000b003301a98dd62so1872537wmj.5;
        Tue, 02 Nov 2021 06:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FEG94uCi+qFoEnBjX5NCLN8clEw8Q6AaBcymoPqaSdI=;
        b=Th2STZAmIloDNceUGh8c1zoNVDp4zEF0aJeizpaJTATTtcIdDm3GjHtUpra6cwdbJm
         m49+E2vjaLELBkPQmzmi17+/o3LLmK/kVMEJRXTj8BWO7DE0cwzsgMpjYr4hdusjnobK
         VFQ6cjuVwO2pPDAMTKg+g6Pi8lQfg4z7bayCadRnYxN348XbdUQA2qYGBDnCyu/d+X0u
         uj0rrmdXFqf3p5xHRI0EeaZUDUHVrLXHcCs3plvocuJN4Ek1Pp9q6+OIy7RsnHdMB2Cc
         Pjsp8+/WaBGM3v2orn1gIFF7QOSbKnDYtIerXuk7oENWfeHZ1Agor/dkdLIMpnW0hVfI
         d4IA==
X-Gm-Message-State: AOAM533jBwi1/xjMB2H+gd2vXdLfoMYeZh5Cpi4RTPbXEYvt4oIw6ya3
        z9ikpBuKuXOdRgPRx78WbR603NfZPqk=
X-Google-Smtp-Source: ABdhPJyU84qNM4egSKJgXMWg8Z+C/hWBfE7Z01V1hIhfKCeVeZNDtmUsyFSBkG4gl8MXnD4/au7gFQ==
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr7353649wmq.124.1635858792274;
        Tue, 02 Nov 2021 06:13:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c1sm14161503wrt.14.2021.11.02.06.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 06:13:11 -0700 (PDT)
Date:   Tue, 2 Nov 2021 13:13:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V commits for 5.16
Message-ID: <20211102131309.3hknsf66swvkv6hm@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20211102

for you to fetch changes up to 285f68afa8b20f752b0b7194d54980b5e0e27b75:

  x86/hyperv: Protect set_hv_tscchange_cb() against getting preempted (2021-10-28 11:59:13 +0000)

There are two merges from the tip tree: one is because of Tianyu's
patches went in via tip/x86/sev, the other is because a tree-wide
cleanup in tip/x86/cc conflicted with Tianyu's patch.

Instead of requiring you to fix up I thought I'd just do it myself.

Thanks,
Wei.

----------------------------------------------------------------
hyperv-next for 5.16
  - Initial patch set for Hyper-V isolation VM support (Tianyu Lan)
  - Fix a warning on preemption (Vitaly Kuznetsov)
  - A bunch of misc cleanup patches.
----------------------------------------------------------------
Jiapeng Chong (1):
      x86/hyperv: Remove duplicate include

Lv Ruyi (1):
      Drivers: hv : vmbus: Adding NULL pointer check

Michael Kelley (1):
      Drivers: hv: vmbus: Remove unused code to check for subchannels

Tianyu Lan (9):
      x86/sev: Expose sev_es_ghcb_hv_call() for use by HyperV
      x86/hyperv: Initialize GHCB page in Isolation VM
      x86/hyperv: Initialize shared memory boundary in the Isolation VM.
      x86/hyperv: Add new hvcall guest address host visibility support
      Drivers: hv: vmbus: Mark vmbus ring buffer visible to host in Isolation VM
      x86/hyperv: Add Write/Read MSR registers via ghcb page
      x86/hyperv: Add ghcb hvcall support for SNP VM
      Drivers: hv: vmbus: Add SNP support for VMbus channel initiate message
      Drivers: hv: vmbus: Initialize VMbus ring buffer for Isolation VM

Vitaly Kuznetsov (1):
      x86/hyperv: Protect set_hv_tscchange_cb() against getting preempted

Wan Jiabing (1):
      x86/hyperv: Remove duplicated include in hv_init

Wei Liu (2):
      Merge remote-tracking branch 'tip/x86/sev' into hyperv-next
      Merge remote-tracking branch 'tip/x86/cc' into hyperv-next

 arch/Kconfig                                 |   3 +
 arch/powerpc/include/asm/mem_encrypt.h       |   5 -
 arch/powerpc/platforms/pseries/Kconfig       |   1 +
 arch/powerpc/platforms/pseries/Makefile      |   2 +
 arch/powerpc/platforms/pseries/cc_platform.c |  26 +++
 arch/powerpc/platforms/pseries/svm.c         |   5 +-
 arch/s390/include/asm/mem_encrypt.h          |   2 -
 arch/x86/Kconfig                             |   1 +
 arch/x86/hyperv/Makefile                     |   2 +-
 arch/x86/hyperv/hv_init.c                    |  82 ++++++--
 arch/x86/hyperv/ivm.c                        | 289 +++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h           |  17 ++
 arch/x86/include/asm/io.h                    |   8 +
 arch/x86/include/asm/kexec.h                 |   2 +-
 arch/x86/include/asm/mem_encrypt.h           |  12 +-
 arch/x86/include/asm/mshyperv.h              |  70 +++++--
 arch/x86/include/asm/sev.h                   |   6 +
 arch/x86/kernel/Makefile                     |   6 +
 arch/x86/kernel/cc_platform.c                |  69 +++++++
 arch/x86/kernel/cpu/mshyperv.c               |   5 +
 arch/x86/kernel/crash_dump_64.c              |   4 +-
 arch/x86/kernel/head64.c                     |   9 +-
 arch/x86/kernel/kvm.c                        |   3 +-
 arch/x86/kernel/kvmclock.c                   |   4 +-
 arch/x86/kernel/machine_kexec_64.c           |  19 +-
 arch/x86/kernel/pci-swiotlb.c                |   9 +-
 arch/x86/kernel/relocate_kernel_64.S         |   2 +-
 arch/x86/kernel/sev-shared.c                 |  68 ++++---
 arch/x86/kernel/sev.c                        |  40 ++--
 arch/x86/kernel/traps.c                      |   2 +-
 arch/x86/kvm/svm/svm.c                       |   3 +-
 arch/x86/mm/ioremap.c                        |  18 +-
 arch/x86/mm/mem_encrypt.c                    |  55 ++---
 arch/x86/mm/mem_encrypt_identity.c           |  18 +-
 arch/x86/mm/pat/set_memory.c                 |  24 ++-
 arch/x86/platform/efi/efi_64.c               |   9 +-
 arch/x86/realmode/init.c                     |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   4 +-
 drivers/gpu/drm/drm_cache.c                  |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c          |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c          |   6 +-
 drivers/hv/Kconfig                           |   1 +
 drivers/hv/channel.c                         |  72 ++++---
 drivers/hv/channel_mgmt.c                    |  34 ----
 drivers/hv/connection.c                      | 101 +++++++++-
 drivers/hv/hv.c                              |  82 ++++++--
 drivers/hv/hv_common.c                       |  12 ++
 drivers/hv/hyperv_vmbus.h                    |   2 +
 drivers/hv/ring_buffer.c                     |  57 ++++--
 drivers/iommu/amd/init.c                     |   7 +-
 drivers/iommu/amd/iommu.c                    |   3 +-
 drivers/iommu/amd/iommu_v2.c                 |   3 +-
 drivers/iommu/iommu.c                        |   3 +-
 drivers/net/hyperv/hyperv_net.h              |   5 +-
 drivers/net/hyperv/netvsc.c                  |  15 +-
 drivers/uio/uio_hv_generic.c                 |  18 +-
 fs/proc/vmcore.c                             |   6 +-
 include/asm-generic/hyperv-tlfs.h            |   1 +
 include/asm-generic/mshyperv.h               |  20 +-
 include/linux/cc_platform.h                  |  88 ++++++++
 include/linux/hyperv.h                       |  25 +--
 include/linux/mem_encrypt.h                  |   4 -
 kernel/dma/swiotlb.c                         |   4 +-
 63 files changed, 1150 insertions(+), 339 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
 create mode 100644 arch/x86/hyperv/ivm.c
 create mode 100644 arch/x86/kernel/cc_platform.c
 create mode 100644 include/linux/cc_platform.h
