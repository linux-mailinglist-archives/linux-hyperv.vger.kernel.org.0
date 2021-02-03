Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4355030DD99
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 16:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhBCPGk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 10:06:40 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38608 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhBCPFU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 10:05:20 -0500
Received: by mail-wm1-f41.google.com with SMTP id y187so5558768wmd.3;
        Wed, 03 Feb 2021 07:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOhVn0mwtTAAGlSYa07ls4DeVje3iNGP2rDMlORrl/M=;
        b=mGEcSEQClIOX3n+aGRpHq0DICvj09rb1vZ+/y+a9ZgMqNN1+UOsB3As5fPposh8Jqy
         4fbylYy6y6/BAOZsEd2xuCE89UEJDjB1nlMxRT92rbSQXilwd8JOyuKp6dvNNf0MekxY
         Aw3UFFBHk0U50PVzsJTI8jGyNz5W04zUWME4rjL9G50hNDM5+oRZfEbGRFmzSnH6ff0M
         Vhes7Tt1l7kedKuC/8DjPHsUeTVuHOKdMHQTDzEtlzmAwrBNsWC16Ev/VlJDRJkME6PA
         B+tsGR+QECPsGWNgt5SgdZizPu1pDyB+gZ0oaIm6l19ooRDHSA9dwpfXdbT58FqCE1oY
         Gi1w==
X-Gm-Message-State: AOAM5303jm0OfZ4PriKA5v6ktj64nR15yh74wKITt/U9MFaZYyYGovMJ
        Ipo7/0pUZ2IJm8mfXTuuPK6t1/VdnVc=
X-Google-Smtp-Source: ABdhPJzNgFQAZPAGMI5JYS3WcQVnTmoYicMhkr5Iif3TCP2BFvvU1ikNAK3KYPQO1OKzeI4mwkL3Og==
X-Received: by 2002:a7b:c3ca:: with SMTP id t10mr2410040wmj.138.1612364677992;
        Wed, 03 Feb 2021 07:04:37 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:37 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        sameo@linux.intel.com, robert.bradford@intel.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v6 00/16] Introducing Linux root partition support for Microsoft Hypervisor
Date:   Wed,  3 Feb 2021 15:04:19 +0000
Message-Id: <20210203150435.27941-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all

Here we propose this patch series to make Linux run as the root partition [0]
on Microsoft Hypervisor [1]. There will be a subsequent patch series to provide a
device node (/dev/mshv) such that userspace programs can create and run virtual
machines. We've also ported Cloud Hypervisor [3] over and have been able to
boot a Linux guest with Virtio devices since late July 2020.

This series implements only the absolutely necessary components to get
things running.  A large portion of this series consists of patches that
augment hyperv-tlfs.h.  They should be rather uncontroversial and can be
applied right away.

A few key things other than the changes to hyperv-tlfs.h:

1. Linux needs to setup existing Hyper-V facilities differently.
2. Linux needs to make a few hypercalls to bring up APs.
3. Interrupts are remapped by IOMMU, which is controlled by the hypervisor.
   Linux needs to make hypercalls to map and unmap interrupts. This is
   done by introducing a new MSI irqdomain and extending the remapping
   domain in hyperv-iommu.

This series is now based on 5.11-rc2.

Comments and suggestions are welcome.

Thanks,
Wei.

[0] Just think of it like Xen's Dom0.
[1] Hyper-V is more well-known, but it really refers to the whole stack
    including the hypervisor and other components that run in Windows kernel
    and userspace.
[3] https://github.com/cloud-hypervisor/

Cc: sameo@linux.intel.com
Cc: robert.bradford@intel.com
Cc: sebastien.boeuf@intel.com

Changes since v5:
1. Address Michael's comments.
2. Further improve and simplify code.
3. Drop a redundant patch and add one new patch for ACPI / NUMA code.

Changes since v4:
1. Rework IO-APIC handling.

Changes since v3:
1. Fix compilation errors.
2. Adapt to upstream changes.

Changes since v2:
1. Address more comments from Vitaly.
2. Fix and test 32bit build.

Changes since v1:
1. Simplify MSI IRQ domain implementation.
2. Address Vitaly's comments.

Wei Liu (16):
  asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT to
    HV_CPU_MANAGEMENT
  x86/hyperv: detect if Linux is the root partition
  Drivers: hv: vmbus: skip VMBus initialization if Linux is root
  clocksource/hyperv: use MSR-based access if running as root
  x86/hyperv: allocate output arg pages if required
  x86/hyperv: extract partition ID from Microsoft Hypervisor if
    necessary
  x86/hyperv: handling hypercall page setup for root
  ACPI / NUMA: add a stub function for node_to_pxm()
  x86/hyperv: provide a bunch of helper functions
  x86/hyperv: implement and use hv_smp_prepare_cpus
  asm-generic/hyperv: update hv_msi_entry
  asm-generic/hyperv: update hv_interrupt_entry
  asm-generic/hyperv: introduce hv_device_id and auxiliary structures
  asm-generic/hyperv: import data structures for mapping device
    interrupts
  x86/hyperv: implement an MSI domain for root partition
  iommu/hyperv: setup an IO-APIC IRQ remapping domain for root partition

 arch/x86/hyperv/Makefile            |   4 +-
 arch/x86/hyperv/hv_init.c           | 107 +++++++-
 arch/x86/hyperv/hv_proc.c           | 219 ++++++++++++++++
 arch/x86/hyperv/irqdomain.c         | 387 ++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h  |  23 ++
 arch/x86/include/asm/mshyperv.h     |  19 +-
 arch/x86/kernel/cpu/mshyperv.c      |  49 ++++
 drivers/clocksource/hyperv_timer.c  |   3 +
 drivers/hv/vmbus_drv.c              |   3 +
 drivers/iommu/hyperv-iommu.c        | 177 ++++++++++++-
 drivers/pci/controller/pci-hyperv.c |   2 +-
 include/acpi/acpi_numa.h            |   4 +
 include/asm-generic/hyperv-tlfs.h   | 254 +++++++++++++++++-
 13 files changed, 1230 insertions(+), 21 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_proc.c
 create mode 100644 arch/x86/hyperv/irqdomain.c


base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
-- 
2.20.1

