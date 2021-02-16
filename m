Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2417F31C84B
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Feb 2021 10:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhBPJqF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Feb 2021 04:46:05 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43748 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhBPJqE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Feb 2021 04:46:04 -0500
Received: by mail-wr1-f41.google.com with SMTP id n8so12122040wrm.10;
        Tue, 16 Feb 2021 01:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/j2GKgHd5lwNkWfIsEtZ0x73q6B7A1r0jP+Y9v5NQ0o=;
        b=ZFNi5S2Z6MjqouFT1MUzpPr4HvileRFMXsjJolqxsiWEc5ze1t6lXuxt2Ltn8WGjWk
         uwyZeWtEbUWLG2uqIhp0h5hcsyG9IFtLVZtLEG56fR/nhZ3lmQ3oJhXAy5auQYQsNr2r
         G+x+29xiWqn7sq++mE6XhMIWvfN9a8NGYHyq4SIp4UhIq7HRUBEfychKah0t+/Jv5ba/
         cn2vA2lC2IyiHK0zomiAI9AnHATQgP560eODWQ7xmjPwRpiReFL38gBs/rB+iSQt/MM1
         uP6QXkoVQvuhIuCkxv3W0DHRwJqvKGQ/9yBjoAX8ulm4DNtGOihCgCetuns3rdsI/NmJ
         pYEA==
X-Gm-Message-State: AOAM532SZUM0p5spYg/l8zvhQTPSXmGt1mgSgrnPblAwOkJs2XfUVBUm
        lRgejcBH/TO0zykvpSrg/Fw=
X-Google-Smtp-Source: ABdhPJy4DGoU/XtRCf7mlgJ8hcOtb5A4QmpTDi1DcU4AoVq6jw8poZ6SOVPFXWc0nQ8GN/kfgmkQFg==
X-Received: by 2002:a5d:5047:: with SMTP id h7mr21449412wrt.67.1613468721476;
        Tue, 16 Feb 2021 01:45:21 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q24sm2623789wmq.24.2021.02.16.01.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 01:45:21 -0800 (PST)
Date:   Tue, 16 Feb 2021 09:45:19 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: [GIT PULL] Hyper-V commits for 5.12
Message-ID: <20210216094519.mc4o74npzdm32avt@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210216

for you to fetch changes up to 3019270282a175defc02c8331786c73e082cd2a8:

  Revert "Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer" (2021-02-15 10:49:11 +0000)

----------------------------------------------------------------
hyperv-next for 5.12
  - VMBus hardening patches from Andrea Parri and Andres Beltran.
  - Patches to make Linux boot as the root partition on Microsoft Hypervisor
    from Wei Liu.
  - One patch to add a new sysfs interface to support hibernation on Hyper-V
    from Dexuan Cui.
  - Two miscellaneous clean-up patches from Colin and Gustavo.

----------------------------------------------------------------
Andrea Parri (Microsoft) (9):
      Drivers: hv: vmbus: Initialize memory to be sent to the host
      Drivers: hv: vmbus: Reduce number of references to message in vmbus_on_msg_dpc()
      Drivers: hv: vmbus: Copy the hv_message in vmbus_on_msg_dpc()
      Drivers: hv: vmbus: Avoid use-after-free in vmbus_onoffer_rescind()
      Drivers: hv: vmbus: Resolve race condition in vmbus_onoffer_rescind()
      x86/hyperv: Load/save the Isolation Configuration leaf
      Drivers: hv: vmbus: Restrict vmbus_devices on isolated guests
      Drivers: hv: vmbus: Enforce 'VMBus version >= 5.2' on isolated guests
      hv_netvsc: Restrict configurations on isolated guests

Andres Beltran (2):
      Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer
      hv_utils: Add validation for untrusted Hyper-V values

Colin Ian King (1):
      hv_utils: Fix spelling mistake "Hearbeat" -> "Heartbeat"

Dexuan Cui (1):
      Drivers: hv: vmbus: Add /sys/bus/vmbus/hibernation

Gustavo A. R. Silva (1):
      hv: hyperv.h: Replace one-element array with flexible-array in struct icmsg_negotiate

Wei Liu (17):
      asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
      x86/hyperv: detect if Linux is the root partition
      Drivers: hv: vmbus: skip VMBus initialization if Linux is root
      clocksource/hyperv: use MSR-based access if running as root
      x86/hyperv: allocate output arg pages if required
      x86/hyperv: extract partition ID from Microsoft Hypervisor if necessary
      x86/hyperv: handling hypercall page setup for root
      ACPI / NUMA: add a stub function for node_to_pxm()
      x86/hyperv: provide a bunch of helper functions
      x86/hyperv: implement and use hv_smp_prepare_cpus
      asm-generic/hyperv: update hv_msi_entry
      asm-generic/hyperv: update hv_interrupt_entry
      asm-generic/hyperv: introduce hv_device_id and auxiliary structures
      asm-generic/hyperv: import data structures for mapping device interrupts
      x86/hyperv: implement an MSI domain for root partition
      iommu/hyperv: setup an IO-APIC IRQ remapping domain for root partition
      Revert "Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer"

 Documentation/ABI/stable/sysfs-bus-vmbus |   7 +
 arch/x86/hyperv/Makefile                 |   4 +-
 arch/x86/hyperv/hv_init.c                | 122 +++++++++-
 arch/x86/hyperv/hv_proc.c                | 219 ++++++++++++++++++
 arch/x86/hyperv/irqdomain.c              | 385 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h       |  38 +++
 arch/x86/include/asm/mshyperv.h          |  19 +-
 arch/x86/kernel/cpu/mshyperv.c           |  58 +++++
 drivers/clocksource/hyperv_timer.c       |   3 +
 drivers/hv/channel.c                     |   4 +-
 drivers/hv/channel_mgmt.c                |  77 ++++++-
 drivers/hv/connection.c                  |   7 +
 drivers/hv/hv_fcopy.c                    |  36 ++-
 drivers/hv/hv_kvp.c                      | 122 +++++-----
 drivers/hv/hv_snapshot.c                 |  89 ++++---
 drivers/hv/hv_util.c                     | 222 +++++++++++-------
 drivers/hv/vmbus_drv.c                   |  64 +++--
 drivers/iommu/hyperv-iommu.c             | 177 +++++++++++++-
 drivers/net/hyperv/netvsc.c              |  18 +-
 drivers/pci/controller/pci-hyperv.c      |   2 +-
 include/acpi/acpi_numa.h                 |   4 +
 include/asm-generic/hyperv-tlfs.h        | 255 +++++++++++++++++++-
 include/asm-generic/mshyperv.h           |   5 +
 include/linux/hyperv.h                   |  13 +-
 24 files changed, 1717 insertions(+), 233 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_proc.c
 create mode 100644 arch/x86/hyperv/irqdomain.c
