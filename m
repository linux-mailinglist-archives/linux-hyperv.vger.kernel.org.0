Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27D92C2DD5
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Nov 2020 18:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390468AbgKXRHv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 12:07:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39151 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgKXRHu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 12:07:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id e7so5551235wrv.6;
        Tue, 24 Nov 2020 09:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82SVcZtoufloCmFA+eRjPEG1+4hQfFhjOuXcAVoGVao=;
        b=SCHk0MxmnV0x+Okc76ZMiqSm1sn4ybUoMU3vSOSDbkpQo75oi5OixaJkxmwc5R7jf7
         jRDgVaEF6NIzmdrR4eDgagFpVk6gaZzBz0pEtdLIQq+RFwk/ni0umzbAOFRmBc5HH6ya
         fKpd71amHUzD5FFeN96pGI2mvqS0CST4P3R14dAEZIUZM1D7sl1AElLJwMVA0E58SwAM
         IAb5bUMtcSHfANML1cuHNl8wzMPGhgw/5IEV0qlvB6rTycDiX9L6rr8+KdWcYuxBhG4t
         sKNWI1j/BcILWTngAVd+ZBvRonL1agCluhYBMH735WyfHHKqXZ/0fa1gbs+I5QaREwKa
         hoDQ==
X-Gm-Message-State: AOAM531nJwnyxOzKroHbzh6NuaqkHuv2xsebhUnNUmHAeskM3OEWxUt4
        ScxmGUsYt8y9Yf0/eQPsR67oIEZc6+o=
X-Google-Smtp-Source: ABdhPJwVh0JUJFbVVc1Xm8psuvuFn9Sm1sc4OjPxcLjr1Zt2Ff+TFPC2YOtN88UQCO9J4QKSWg6YhA==
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr6358574wrb.228.1606237668188;
        Tue, 24 Nov 2020 09:07:48 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v20sm6419874wmh.44.2020.11.24.09.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:07:47 -0800 (PST)
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
Subject: [PATCH v3 00/17] Introducing Linux root partition support for Microsoft Hypervisor
Date:   Tue, 24 Nov 2020 17:07:27 +0000
Message-Id: <20201124170744.112180-1-wei.liu@kernel.org>
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
boot a Linux guest with Virtio devices since late July.

Being an RFC sereis, this implements only the absolutely necessary
components to get things running.  I will break down this series a bit.

A large portion of this series consists of patches that augment hyperv-tlfs.h.
They should be rather uncontroversial and can be applied right away.

A few key things other than the changes to hyperv-tlfs.h:

1. Linux needs to setup existing Hyper-V facilities differently.
2. Linux needs to make a few hypercalls to bring up APs.
3. Interrupts are remapped by IOMMU, which is controlled by the hypervisor.
   Linux needs to make hypercalls to map and unmap interrupts. This is
   done by introducing a new MSI irqdomain and new irqchips.

This series is now based on 5.10-rc1. And thanks to tglx's overhaul of
the MSI code, our implementation of the MSI irq domain is shorter.

Comments and suggestions are welcome.

Thanks,
Wei.

Cc: sameo@linux.intel.com
Cc: robert.bradford@intel.com
Cc: sebastien.boeuf@intel.com

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
 arch/x86/hyperv/hv_init.c           | 121 +++++-
 arch/x86/hyperv/hv_proc.c           | 215 +++++++++++
 arch/x86/hyperv/irqdomain.c         | 556 ++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h  |  23 ++
 arch/x86/include/asm/io_apic.h      |  21 ++
 arch/x86/include/asm/mshyperv.h     |  13 +-
 arch/x86/kernel/apic/io_apic.c      |  28 +-
 arch/x86/kernel/cpu/mshyperv.c      |  49 +++
 drivers/clocksource/hyperv_timer.c  |   3 +
 drivers/hv/vmbus_drv.c              |   3 +
 drivers/iommu/hyperv-iommu.c        |   3 +-
 drivers/pci/controller/pci-hyperv.c |   2 +-
 include/asm-generic/hyperv-tlfs.h   | 254 ++++++++++++-
 14 files changed, 1257 insertions(+), 38 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_proc.c
 create mode 100644 arch/x86/hyperv/irqdomain.c

-- 
2.20.1

