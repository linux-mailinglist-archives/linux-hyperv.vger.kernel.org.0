Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007AA3C230C
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 13:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhGILq3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 07:46:29 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:40908 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGILq3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 07:46:29 -0400
Received: by mail-wm1-f41.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so8906493wmq.5;
        Fri, 09 Jul 2021 04:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TUZPMZ4hjZI406B6oLsgIr41PzVsb92Ly0yg+RmaVNw=;
        b=VreKst34LPa2TDS/74gPgnQutozHz2tnLuaYz6IvnDN9fzM/A2ZbjIel/P0Z8sX2ql
         0jDTuYNiA8vVDhud4BI4FwaRqeWCHDO5inHAqpFMlOI2xyDBAMDkvLmRZopMiexRo7/V
         DH3FOvZF8Q3aTgKO9KOn5e3hOR1rkiIjW9F3pwHWuQWyoMHc9OM1lZ8IGMtL9DRuDigR
         r3Lb0M6cS2oS26ey+rj+1sGJ7Z81WJ7BPtEQ7HPXe8yL3xdL1MX4foU8KVVTxHadz1CK
         2w2lKt5sk0tbEjWac/Cuhc7sUPxK145lr8aH1ELbiksoifH1xtmB/G1wacYPIVFB0QAy
         01Dw==
X-Gm-Message-State: AOAM530n50DIzDPLLVma0zmigxl0knmAOXCz8jCojwsVgQnNWcZbPJjH
        fFx0mAxgdchLWWZCJTpishhGoEnBbLw=
X-Google-Smtp-Source: ABdhPJwYe0JLlVWlLExBQqOITL6nm2S+sUw2zS7k+ZGTUIWG/WwdI+MpUrsQiHAZOz9sUQGzfZ+UpQ==
X-Received: by 2002:a1c:3505:: with SMTP id c5mr11135674wma.53.1625831023671;
        Fri, 09 Jul 2021 04:43:43 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z12sm4896849wrs.39.2021.07.09.04.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:43:42 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        Wei Liu <wei.liu@kernel.org>
Subject: [RFC v1 0/8] MSHV: add PV-IOMMU driver
Date:   Fri,  9 Jul 2021 11:43:31 +0000
Message-Id: <20210709114339.3467637-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all

Device passthrough is a critial feature for a virtualization stack. When
designing this feature for MSHV support on Linux, one important
considration is to not deviate from Linux's default VFIO stack. VFIO
relies on an IOMMU or IOMMUs in the system to manipulate DMA mappings.

In this series an IOMMU driver is implemented using a set of hypercall
interfaces provided by the Microsoft Hypervisor. At this stage only DMA
remapping is implemented. Interrupt remapping will come later.

With this series I'm able to passthrough an NVMe drive to a guest with VFIO on
a modified version of Cloud Hypervisor. From users' point of view, nothing
needs changing. Cloud Hypervisor and Rust-VMM changes, which depend on the new
kernel UAPIs from this series, will be upstreamed too.

This series is built on top of Nuno and Vineeth's patches [0][1].

The meat is in the patch named "mshv: add paravirtualized IOMMU
support".

The in-kernel device framework and the VFIO bridge device are heavily
inspired by KVM's code. I pondered whether it would be worth refactoring
the code in KVM but decided against that route for two reasons: 1. it
allowed faster prototyping and 2. I was not sure if that's something KVM
community would agree to.

For the VT-D changes, what we're after is to build the RMRR regions list
so that reserved regions are respected. Instead of doing a bad job
myself, I decided to piggy-back on Intel's own code. AMD support is to
be added until we have an AMD system.

Comments are welcome.

Thanks,
Wei.

[0] https://lore.kernel.org/linux-hyperv/1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com/
[1] https://lore.kernel.org/linux-hyperv/cover.1622654100.git.viremana@linux.microsoft.com/

Wei Liu (8):
  x86/hyperv: export hv_build_pci_dev_id
  asm-generic/hyperv: add device domain definitions
  intel/vt-d: make DMAR table parsing code more flexible
  intel/vt-d: export intel_iommu_get_resv_regions
  mshv: add paravirtualized IOMMU support
  mshv: command line option to skip devices in PV-IOMMU
  mshv: implement in-kernel device framework
  mshv: add vfio bridge device

 Documentation/virt/mshv/api.rst     |  12 +
 arch/x86/hyperv/irqdomain.c         |   3 +-
 arch/x86/include/asm/mshyperv.h     |   1 +
 drivers/hv/Kconfig                  |   4 +
 drivers/hv/Makefile                 |   2 +-
 drivers/hv/mshv_main.c              | 186 ++++++++
 drivers/hv/vfio.c                   | 244 ++++++++++
 drivers/hv/vfio.h                   |  18 +
 drivers/iommu/Kconfig               |  14 +
 drivers/iommu/hyperv-iommu.c        | 673 ++++++++++++++++++++++++++++
 drivers/iommu/intel/dmar.c          |  38 +-
 drivers/iommu/intel/iommu.c         |   7 +-
 drivers/iommu/intel/irq_remapping.c |   2 +-
 include/asm-generic/hyperv-tlfs.h   | 144 ++++++
 include/linux/dmar.h                |   2 +-
 include/linux/intel-iommu.h         |   4 +
 include/linux/mshv.h                |  57 +++
 include/uapi/linux/mshv.h           |  36 ++
 18 files changed, 1429 insertions(+), 18 deletions(-)
 create mode 100644 drivers/hv/vfio.c
 create mode 100644 drivers/hv/vfio.h

-- 
2.30.2

