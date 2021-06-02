Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0F1399160
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFBRWy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51104 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFBRWy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:54 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id BD38E20B7178;
        Wed,  2 Jun 2021 10:21:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD38E20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654470;
        bh=Pde1Ut8rUrVrlY2iNu9ZuRBELx1Zmx98lF4hbdH+Nc4=;
        h=From:To:Cc:Subject:Date:From;
        b=AOLquUhfvheNDtVrEpfCdeNc4/ToZRS+c8B0q2AaM3wCmcwnUCfTKN165FmFMaW9k
         rmSiy9q1fJPLxtbPPIyD9MffjS0Rm5wr7zpBM34TcKAcFILCQdsWEiWvfmdRM9DsGL
         PQ/Z7ea0YYevqaDecza7emB/APyfvhcH631ILruk=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH 00/17] irqfd and ioeventfd support for mshv
Date:   Wed,  2 Jun 2021 17:20:45 +0000
Message-Id: <cover.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch series adds irqfd and ioeventfd support for VMMs on Hyper-V.
Also adds support for in-kernel MSI irq routing framework. Both these
features are inspired from the kvm implementation and all credits to kvm
developers.

Patches 1-11 are preparatory patches for enabling irqfd/ioeventfd. Hyper-v
features like ports, connections, doorbell etc needs to be enabled to
implement irqfd and ioeventfd feature.

Patches 12-15 implements irqfd and ioeventfd, and 16 and 17 implements the
in-kernel MSI routing framework.

This patchset is rebased on Nuno's root partition ioctl interface series:
https://lkml.org/lkml/2021/5/28/820
---

Vineeth Pillai (17):
  hyperv: Few TLFS definitions
  drivers: hv: vmbus: Use TLFS definition for VMBUS_MESSAGE_SINT
  acpi: export node_to_pxm
  hyperv: Wrapper for setting proximity_domain_info
  mshv: SynIC event ring and event flags support
  mshv: SynIC port and connection hypercalls
  hyperv: Configure SINT for Doorbell
  mshv: Port id management
  mshv: Doorbell handler in hypercall ISR
  mshv: Doorbell register/unregister API
  mshv: HvClearVirtualInterrupt hypercall
  mshv: Add irqfd support for mshv
  mshv: Add ioeventfd support for mshv
  mshv: Notifier framework for EOI for level triggered interrupts
  mshv: Level-triggered interrupt support for irqfd
  mshv: User space controlled MSI irq routing for mshv
  mshv: Use in kernel MSI routing for irqfd

 arch/x86/hyperv/hv_init.c               |  32 +-
 arch/x86/hyperv/hv_proc.c               |  15 +-
 arch/x86/include/asm/hyperv-tlfs.h      |   2 +
 arch/x86/include/asm/mshyperv.h         |   2 +
 arch/x86/include/uapi/asm/hyperv-tlfs.h |   2 +
 drivers/acpi/numa/srat.c                |   1 +
 drivers/hv/Kconfig                      |   1 +
 drivers/hv/Makefile                     |   3 +-
 drivers/hv/hv_call.c                    | 181 ++++++
 drivers/hv/hv_eventfd.c                 | 723 ++++++++++++++++++++++++
 drivers/hv/hv_portid_table.c            |  83 +++
 drivers/hv/hv_synic.c                   | 383 +++++++++++--
 drivers/hv/hyperv_vmbus.h               |   2 +-
 drivers/hv/mshv.h                       |  52 ++
 drivers/hv/mshv_main.c                  |  96 +++-
 drivers/hv/mshv_msi.c                   | 128 +++++
 include/asm-generic/hyperv-tlfs.h       | 106 +++-
 include/asm-generic/mshyperv.h          |  14 +
 include/linux/hyperv.h                  |   9 -
 include/linux/mshv.h                    |  65 ++-
 include/linux/mshv_eventfd.h            |  78 +++
 include/uapi/asm-generic/hyperv-tlfs.h  |  81 +++
 include/uapi/linux/mshv.h               |  48 ++
 23 files changed, 2043 insertions(+), 64 deletions(-)
 create mode 100644 drivers/hv/hv_eventfd.c
 create mode 100644 drivers/hv/hv_portid_table.c
 create mode 100644 drivers/hv/mshv_msi.c
 create mode 100644 include/linux/mshv_eventfd.h

-- 
2.25.1

