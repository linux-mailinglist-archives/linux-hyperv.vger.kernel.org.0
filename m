Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841B42EC4F5
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 21:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbhAFUeh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 15:34:37 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:53454 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbhAFUeg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 15:34:36 -0500
Received: by mail-wm1-f50.google.com with SMTP id k10so3448379wmi.3;
        Wed, 06 Jan 2021 12:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mhlu1tTfXO6P+FCugagf3OwfYcUHlDCcg/eJOpRPSrE=;
        b=mTCNT9Qj+ZJyZQnGgLwGSWsOs2IEjY7w36xTgQLuIpOlwmwvJjyIcxNrjok06e+rPK
         EUrmAx4Jh0bugcQnyA9wZDfvTukz6SgTvSBORN6Z2NsCv3NTLskAK4uLc8tV0SC7Eg3S
         PgfdCCgEvy/H3cpNMUe7Gc2mOzrKn6z4PNPzEa7uMwGe8uwcN9jP2amdJ789nO/kbZ04
         aL0P8KKv8aTAU4nLOM/Kqneyt8JfgW0ufSFz7d5+32IicST7/TSn6+ArxRUb8waJhkLF
         b+9V4+ubGASqFk0DcMUdfke+ip8mz2oyVxXawaV9h3S2tyMv+b/LlncfN2N3T1BUulgW
         WGgA==
X-Gm-Message-State: AOAM530OZOD61pSYyxYLWuFbflebBngG/XOm8whhX8H+X5879+7mzUyD
        Pn5HLJiI9uQ46fqpbzjmc0O5CAhbzFY=
X-Google-Smtp-Source: ABdhPJxJSV5vs03ACfKiggc7zSy+VVNSNbEjICgke3R+iSI0E5wXlaSM2XRRWEQI5R10Bm12ZSQXwQ==
X-Received: by 2002:a1c:1bc6:: with SMTP id b189mr5075372wmb.71.1609965234086;
        Wed, 06 Jan 2021 12:33:54 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:33:53 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, sameo@linux.intel.com,
        robert.bradford@intel.com, sebastien.boeuf@intel.com
Subject: [PATCH v4 00/17] Introducing Linux root partition support for Microsoft Hypervisor
Date:   Wed,  6 Jan 2021 20:33:33 +0000
Message-Id: <20210106203350.14568-1-wei.liu@kernel.org>
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
   done by introducing a new MSI irqdomain and new irqchips.

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

Changes since v3:
1. Fix compilation errors.
2. Adapt to upstream changes.

Changes since v2:
1. Address more comments from Vitaly.
2. Fix and test 32bit build.

Changes since v1:
1. Simplify MSI IRQ domain implementation.
2. Address Vitaly's comments.

Wei Liu (17):
  asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT to
    HV_CPU_MANAGEMENT
  x86/hyperv: detect if Linux is the root partition
  Drivers: hv: vmbus: skip VMBus initialization if Linux is root
  iommu/hyperv: don't setup IRQ remapping when running as root
  clocksource/hyperv: use MSR-based access if running as root
  x86/hyperv: allocate output arg pages if required
  x86/hyperv: extract partition ID from Microsoft Hypervisor if
    necessary
  x86/hyperv: handling hypercall page setup for root
  x86/hyperv: provide a bunch of helper functions
  x86/hyperv: implement and use hv_smp_prepare_cpus
  asm-generic/hyperv: update hv_msi_entry
  asm-generic/hyperv: update hv_interrupt_entry
  asm-generic/hyperv: introduce hv_device_id and auxiliary structures
  asm-generic/hyperv: import data structures for mapping device
    interrupts
  x86/hyperv: implement an MSI domain for root partition
  x86/ioapic: export a few functions and data structures via io_apic.h
  x86/hyperv: handle IO-APIC when running as root

 arch/x86/hyperv/Makefile            |   4 +-
 arch/x86/hyperv/hv_init.c           | 120 +++++-
 arch/x86/hyperv/hv_proc.c           | 225 +++++++++++
 arch/x86/hyperv/irqdomain.c         | 559 ++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h  |  23 ++
 arch/x86/include/asm/io_apic.h      |  22 ++
 arch/x86/include/asm/mshyperv.h     |  16 +-
 arch/x86/kernel/apic/io_apic.c      |  25 +-
 arch/x86/kernel/cpu/mshyperv.c      |  49 +++
 drivers/clocksource/hyperv_timer.c  |   3 +
 drivers/hv/vmbus_drv.c              |   3 +
 drivers/iommu/hyperv-iommu.c        |   3 +-
 drivers/pci/controller/pci-hyperv.c |   2 +-
 include/asm-generic/hyperv-tlfs.h   | 254 ++++++++++++-
 14 files changed, 1272 insertions(+), 36 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_proc.c
 create mode 100644 arch/x86/hyperv/irqdomain.c


base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
-- 
2.20.1

