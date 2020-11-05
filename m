Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D9F2A8427
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Nov 2020 17:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbgKEQ6X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Nov 2020 11:58:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38919 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEQ6U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Nov 2020 11:58:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id s13so2299367wmh.4;
        Thu, 05 Nov 2020 08:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BCGHjbvSKkPfi0+tsiODgB7Gr2fkgOB8zUQqLAIOe64=;
        b=bsbTqvVQe6qnC1OmjoIaVGZGs9CsqxwJHByMegrbVvH0YtO/3snwCmjSKz9lsk6t7v
         +q+sL/reYoj00JPjpTJ2WzS5vB5eWn8WTI51ZQzpCwZDx8Z2bVd0CbBh39UyRKltH909
         HpXa1u9PMGMnHo4gbEFyaP9ADuk4KTZ0H+iEllVz8Gr8BqSiR7J6ByRnP25aAOKEZY4U
         8o6TDdX0aPc0tPRf0WnTriXXElb77/4Lbd67BzmSkmKJtsB1dQhObfCf0yjwTwdxr+Yh
         FxCY62BBAmtF77euRTGiiFBDS4HjtYkTdc/ykVM7y0p9mZOKbFaRcyga3gghGVE1AL/E
         fL/A==
X-Gm-Message-State: AOAM530Ph1nL21xix9nQQRQ7Z8Q9fFLAOg20IvsE6pP5nZakeTo5x7UO
        uyqQpBnkBNEH2zRxK5Z6mpjWlsHTUPo=
X-Google-Smtp-Source: ABdhPJw0FSrG12ouWhd+ht7off2JBOky265unnWf28Tl9fp98lX+6Y+IuQ48/TxnJzC6MmhvJ00WWQ==
X-Received: by 2002:a1c:205:: with SMTP id 5mr3635964wmc.7.1604595497421;
        Thu, 05 Nov 2020 08:58:17 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:16 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v2 00/17] Introducing Linux root partition support for Microsoft Hypervisor
Date:   Thu,  5 Nov 2020 16:57:57 +0000
Message-Id: <20201105165814.29233-1-wei.liu@kernel.org>
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

 arch/x86/hyperv/Makefile            |   2 +-
 arch/x86/hyperv/hv_init.c           | 118 +++++-
 arch/x86/hyperv/hv_proc.c           | 217 +++++++++++
 arch/x86/hyperv/irqdomain.c         | 556 ++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h  |  23 ++
 arch/x86/include/asm/io_apic.h      |  21 ++
 arch/x86/include/asm/mshyperv.h     |  13 +-
 arch/x86/kernel/apic/io_apic.c      |  28 +-
 arch/x86/kernel/cpu/mshyperv.c      |  43 +++
 drivers/clocksource/hyperv_timer.c  |   3 +
 drivers/hv/vmbus_drv.c              |   3 +
 drivers/iommu/hyperv-iommu.c        |   3 +-
 drivers/pci/controller/pci-hyperv.c |   2 +-
 include/asm-generic/hyperv-tlfs.h   | 254 ++++++++++++-
 14 files changed, 1250 insertions(+), 36 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_proc.c
 create mode 100644 arch/x86/hyperv/irqdomain.c

-- 
2.20.1

