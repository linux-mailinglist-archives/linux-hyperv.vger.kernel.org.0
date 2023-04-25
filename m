Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF0B6ED9AC
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Apr 2023 03:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjDYBOz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Apr 2023 21:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjDYBOr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Apr 2023 21:14:47 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01552AF1C;
        Mon, 24 Apr 2023 18:14:45 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5208be24dcbso3988158a12.1;
        Mon, 24 Apr 2023 18:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682385285; x=1684977285;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIyc/FhGSLGUNO65BKhIHQXYYAfMnELOdho78LsCz0A=;
        b=aSdtzCsbu3M9XxO8oAW5oJ05tXRfWSaRxj54C0Nt6K690dRGcWDVnHOEUIIf0PbnVx
         +zo9Qt8c2KLcfRqEvDhdcliox0EROFglkcdeM+9IAvIDjEROWafTHlbbf2jK1QIYgspI
         YaWhDNql1C9iPdAPAnvpjyiYu6RuIhjD00xylJabDcwBobJ3iah6iWNjFr8AmEs5nOSN
         PlOrlTQrn3qUCQ21rADITr6bP5MorkpK0/K0qhqA1qkHaxed+uE6Xs33tf3aq0EdHCd1
         kueXtMPXQeXcIOIbB4TSwF2OxIE9HkV9709EgvqXQ84LS6ijsxPBavGXJhYmDdb14JKs
         AZTw==
X-Gm-Message-State: AAQBX9egADTLh2kB87cmNSvsvt2qtzxQKVDfINlup4/vcCpRLwEAgr1f
        CD0WOPiVCvj4ZGXKL6oFS3Q=
X-Google-Smtp-Source: AKy350YRScr0fAIw9O5ya3BjZUHQ2tZNhNgGnzAb2IJ2MODhfx22xjjPGTv4bgMhriP7YVN1IGK7vw==
X-Received: by 2002:a17:90a:4597:b0:247:42bf:380e with SMTP id v23-20020a17090a459700b0024742bf380emr15621740pjg.4.1682385285197;
        Mon, 24 Apr 2023 18:14:45 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id y10-20020a63ce0a000000b004ff6b744248sm6958528pgf.48.2023.04.24.18.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 18:14:44 -0700 (PDT)
Date:   Tue, 25 Apr 2023 01:14:43 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V commits for 6.4
Message-ID: <ZEcpgwRj8kDvjfSK@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit 6a8f57ae2eb07ab39a6f0ccad60c760743051026:

  Linux 6.3-rc7 (2023-04-16 15:23:53 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20230424

for you to fetch changes up to a494aef23dfc732945cb42e22246a5c31174e4a5:

  PCI: hv: Replace retarget_msi_interrupt_params with hyperv_pcpu_input_arg (2023-04-21 21:25:23 +0000)

Note that I needed to do a merge with tip/x86/sev because some of
Michael's patches were merged into that branch first. I've written down
the rationale in the merge commit.

This PR can conflict with sysctl-next, because both branches modified
VMBus code. A correct resolution can be found here:

https://lore.kernel.org/linux-next/20230424154742.131094-1-broonie@kernel.org/

Although the resolution is empty, it is correct, because Long rebased
his patch multiple times on both linux-next and linux-hyperv, the patch
ended up containing the same changes as Luis' patch.

----------------------------------------------------------------
hyperv-next for v6.4
 - PCI passthrough for Hyper-V confidential VMs (Michael Kelley)
 - Hyper-V VTL mode support (Saurabh Sengar)
 - Move panic report initialization code earlier (Long Li)
 - Various improvements and bug fixes (Dexuan Cui and Michael Kelley)
----------------------------------------------------------------
Borislav Petkov (AMD) (2):
      crypto: ccp: Get rid of __sev_platform_init_locked()'s local function pointer
      x86/coco: Export cc_vendor

Dexuan Cui (3):
      clocksource: hyper-v: make sure Invariant-TSC is used if it is available
      Drivers: hv: vmbus: Remove the per-CPU post_msg_page
      PCI: hv: Replace retarget_msi_interrupt_params with hyperv_pcpu_input_arg

Dionna Glaze (2):
      virt/coco/sev-guest: Double-buffer messages
      x86/sev: Change snp_guest_issue_request()'s fw_err argument

Long Li (1):
      Drivers: hv: move panic report code from vmbus to hv early init code

Michael Kelley (14):
      x86/ioremap: Add hypervisor callback for private MMIO mapping in coco VM
      x86/hyperv: Reorder code to facilitate future work
      Drivers: hv: Explicitly request decrypted in vmap_pfn() calls
      x86/mm: Handle decryption/re-encryption of bss_decrypted consistently
      init: Call mem_encrypt_init() after Hyper-V hypercall init is done
      x86/hyperv: Change vTOM handling to use standard coco mechanisms
      swiotlb: Remove bounce buffer remapping for Hyper-V
      Drivers: hv: vmbus: Remove second mapping of VMBus monitor pages
      Drivers: hv: vmbus: Remove second way of mapping ring buffers
      hv_netvsc: Remove second mapping of send and recv buffers
      Drivers: hv: Don't remap addresses that are above shared_gpa_boundary
      PCI: hv: Enable PCI pass-thru devices in Confidential VMs
      x86/hyperv: Add callback filter to cpumask_to_vpset()
      x86/hyperv: Exclude lazy TLB mode CPUs from enlightened TLB flushes

Peter Gonda (1):
      crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

Saurabh Sengar (10):
      drivers/clocksource/hyper-v: non ACPI support in hyperv clock
      ACPI: bus: Add stub acpi_sleep_state_supported() in non-ACPI cases
      Drivers: hv: vmbus: Convert acpi_device to more generic platform_device
      dt-bindings: bus: Add Hyper-V VMBus
      Driver: VMBus: Add Devicetree support
      x86/init: Make get/set_rtc_noop() public
      x86/hyperv: Add VTL specific structs and hypercalls
      x86/hyperv: Make hv_get_nmi_reason public
      Drivers: hv: Kconfig: Add HYPERV_VTL_MODE
      x86/hyperv: VTL support for Hyper-V

Thomas Gleixner (1):
      Merge branch 'x86/cc' into x86/sev

Wei Liu (1):
      Merge remote-tracking branch 'tip/x86/sev' into hyperv-next

 .../devicetree/bindings/bus/microsoft,vmbus.yaml   |  54 ++++
 Documentation/virt/coco/sev-guest.rst              |  20 +-
 MAINTAINERS                                        |   1 +
 arch/x86/coco/core.c                               |  53 ++--
 arch/x86/hyperv/Makefile                           |   1 +
 arch/x86/hyperv/hv_apic.c                          |  12 +-
 arch/x86/hyperv/hv_init.c                          |  18 +-
 arch/x86/hyperv/hv_vtl.c                           | 227 +++++++++++++++
 arch/x86/hyperv/ivm.c                              | 148 ++++++----
 arch/x86/hyperv/mmu.c                              |  11 +-
 arch/x86/include/asm/coco.h                        |  24 +-
 arch/x86/include/asm/hyperv-tlfs.h                 |  78 +++++
 arch/x86/include/asm/mem_encrypt.h                 |   1 +
 arch/x86/include/asm/mshyperv.h                    |  31 +-
 arch/x86/include/asm/sev-common.h                  |   4 -
 arch/x86/include/asm/sev.h                         |  10 +-
 arch/x86/include/asm/x86_init.h                    |   6 +
 arch/x86/kernel/apic/io_apic.c                     |  10 +-
 arch/x86/kernel/cpu/mshyperv.c                     |  28 +-
 arch/x86/kernel/sev.c                              |  15 +-
 arch/x86/kernel/x86_init.c                         |   6 +-
 arch/x86/mm/ioremap.c                              |   5 +
 arch/x86/mm/mem_encrypt_amd.c                      |  10 +-
 arch/x86/mm/pat/set_memory.c                       |   3 -
 drivers/clocksource/hyperv_timer.c                 |  21 +-
 drivers/crypto/ccp/sev-dev.c                       |  22 +-
 drivers/hv/Kconfig                                 |  30 +-
 drivers/hv/channel_mgmt.c                          |   2 +-
 drivers/hv/connection.c                            | 113 ++------
 drivers/hv/hv.c                                    |  79 ++---
 drivers/hv/hv_common.c                             | 242 +++++++++++++++-
 drivers/hv/hyperv_vmbus.h                          |   6 -
 drivers/hv/ring_buffer.c                           |  62 ++--
 drivers/hv/vmbus_drv.c                             | 322 ++++++---------------
 drivers/net/hyperv/hyperv_net.h                    |   2 -
 drivers/net/hyperv/netvsc.c                        |  48 +--
 drivers/pci/controller/pci-hyperv.c                | 280 +++++++++++-------
 drivers/virt/coco/sev-guest/sev-guest.c            |  99 ++++---
 include/asm-generic/hyperv-tlfs.h                  |  26 ++
 include/asm-generic/mshyperv.h                     |  26 +-
 include/linux/acpi.h                               |   5 +
 include/linux/swiotlb.h                            |   2 -
 include/uapi/linux/psp-sev.h                       |   7 +
 include/uapi/linux/sev-guest.h                     |  18 +-
 init/main.c                                        |  19 +-
 kernel/dma/swiotlb.c                               |  45 +--
 46 files changed, 1388 insertions(+), 864 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
 create mode 100644 arch/x86/hyperv/hv_vtl.c
