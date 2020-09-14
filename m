Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B6F269413
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 19:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgINRuq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 13:50:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34461 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgINL2N (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 07:28:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id l15so5675997wmh.1;
        Mon, 14 Sep 2020 04:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LqxAE6W5SExzzq+BC3tYOi/+57EB9w0HNwMulHCILP0=;
        b=AaowA1CzSRcjDX9FqTpwxMLIWWORzOT/nZ6Km/bwRYjYntmlijiP0K/1NuMJQ1fMwn
         mdlMcCFTjHf7lyix1R/2JJ9MIdpQ3ELQxHVThKwOAelzK4Tx00h7ybzlILUwu4OEhUIW
         EUUHTG0dK4LbFif92ynjenn0qo7beOJE6WDWpInQatB7hEVkpVQZRPyYZt+q9ybW3Ncx
         9v3FhwR8wM6SrU3cyG4wyPJXZ6Icsyy3DXosbZMt3+0b16AKOytRKl/d4Y54qP2lxZYH
         OgR65Hy3ANx29rCSEpV0ZRTDFOLQNtcZ/W/Sp8yq+N9uJ0vik1nEhGRZZFztIo9KL2ux
         5fuA==
X-Gm-Message-State: AOAM531BpmJ7vkgrHJdHnX/0QUvitU3H9e27r1VwhnOCwubSV3vJt7+L
        tn1O/ZAA/wEOEFvqI2ttiDBTdwz2+Lk=
X-Google-Smtp-Source: ABdhPJw+00/JLZUMpd/ezfCIr7+71JwtPUy+QEt1v5Ue/jcKXwLuHub7ZjmQF4XzB4TX1QB/m3Kd2g==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr13904242wmf.47.1600082891294;
        Mon, 14 Sep 2020 04:28:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s12sm12024606wmd.20.2020.09.14.04.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:28:10 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH RFC v1 00/18] Introducing Linux root partition support for Microsoft Hypervisor
Date:   Mon, 14 Sep 2020 11:27:44 +0000
Message-Id: <20200914112802.80611-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all

Here we propose this patch series to make Linux run as the root partition [0]
on Microsoft Hypervisor [1].

Microsoft wants to create a complete virtualization stack with Linux and
Microsoft Hypervisor. There will be a subsequent patch series to provide a
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

#3 is perhaps the thing that we feel least confident about. We drew inspiration
from the Xen code in Linux. We are of course open to criticism and sugguestions
on how to make it better / acceptable to upstream.

We're aware of tglx's series to change some of the MSI code, so we may need to
change some of the code after that series is upstreamed. But it wouldn't hurt
to throw this out as soon as possible for feedback.

Comments and suggestions are welcome.

Thanks,
Wei.

[0] Just think of it like Xen's Dom0.
[1] Hyper-V is more well-known, but it really refers to the whole stack
    including the hypervisor and other components that run in Windows kernel
    and userspace.
[3] https://github.com/cloud-hypervisor/

Cc: x86@kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
Cc: Nuno Das Neves <nudasnev@microsoft.com>
Cc: Vineeth Pillai <viremana@linux.microsoft.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>

Wei Liu (18):
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
  x86/apic/msi: export pci_msi_get_hwirq
  x86/hyperv: implement MSI domain for root partition
  x86/ioapic: export a few functions and data structures via io_apic.h
  x86/hyperv: handle IO-APIC when running as root

 arch/x86/hyperv/Makefile            |   4 +-
 arch/x86/hyperv/hv_init.c           | 126 +++++-
 arch/x86/hyperv/hv_proc.c           | 209 ++++++++++
 arch/x86/hyperv/irqdomain.c         | 580 ++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h  |  23 ++
 arch/x86/include/asm/io_apic.h      |  20 +
 arch/x86/include/asm/mshyperv.h     |  13 +-
 arch/x86/include/asm/msi.h          |   3 +
 arch/x86/kernel/apic/io_apic.c      |  28 +-
 arch/x86/kernel/apic/msi.c          |   3 +-
 arch/x86/kernel/cpu/mshyperv.c      |  43 +++
 drivers/clocksource/hyperv_timer.c  |   3 +
 drivers/hv/vmbus_drv.c              |   3 +
 drivers/iommu/hyperv-iommu.c        |   3 +-
 drivers/pci/controller/pci-hyperv.c |   2 +-
 include/asm-generic/hyperv-tlfs.h   | 243 +++++++++++-
 16 files changed, 1268 insertions(+), 38 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_proc.c
 create mode 100644 arch/x86/hyperv/irqdomain.c

-- 
2.20.1

