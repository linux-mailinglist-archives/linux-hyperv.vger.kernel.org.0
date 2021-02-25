Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D9C3251FE
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Feb 2021 16:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBYPLj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 Feb 2021 10:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhBYPLi (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Feb 2021 10:11:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8508964F10;
        Thu, 25 Feb 2021 15:10:56 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lFII2-00Fscv-9C; Thu, 25 Feb 2021 15:10:54 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 00/13] PCI: MSI: Getting rid of msi_controller, and other cleanups
Date:   Thu, 25 Feb 2021 15:10:10 +0000
Message-Id: <20210225151023.3642391-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, bhelgaas@google.com, frank-w@public-files.de, treding@nvidia.com, tglx@linutronix.de, robh@kernel.org, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, ryder.lee@mediatek.com, marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, michal.simek@xilinx.com, paul.walmsley@sifive.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The msi_controller data structure was the first attempt at treating
MSIs like any other interrupt. We replaced it a few years ago with the
generic MSI framework, but as it turns out, some older drivers are
still using it.

This series aims at converting these stragglers, drop msi_controller,
and fix some other nits such as having ways for a host bridge to
advertise whether it supports MSIs or not.

A few notes:

- The Tegra patch is the result of back and forth work with Thierry: I
  wrote the initial patch, which didn't work (I didn't have any HW at
  the time). Thierry made it work, and I subsequently fixed a couple
  of bugs/cleanups. I'm responsible for the result, so don't blame
  Thierry for any of it! FWIW, I'm now running a Jetson TX2 with its
  root fs over NVME, and MSIs are OK.

- RCAR is totally untested, though Marek had a go at a previous
  version. More testing required.

- The xilinx stuff is *really* untested. Paul, if you have a RISC-V
  board that uses it, could you please give it a go? Michal, same
  thing for the stuff you have at hand...

- hyperv: I don't have access to such hypervisor, and no way to test
  it. Help welcomed.

- The patches dealing with the advertising of MSI handling are the
  result of a long discussion that took place here[1]. I took the
  liberty to rejig Thomas' initial patches, and add what I needed for
  the MSI domain stuff. Again, blame me if something is wrong, and not
  Thomas.

Feedback welcome.

	M.

[1] https://lore.kernel.org/r/20201031140330.83768-1-linux@fw-web.de

Marc Zyngier (11):
  PCI: tegra: Convert to MSI domains
  PCI: rcar: Convert to MSI domains
  PCI: xilinx: Convert to MSI domains
  PCI: hyperv: Drop msi_controller structure
  PCI: MSI: Drop use of msi_controller from core code
  PCI: MSI: Kill msi_controller structure
  PCI: MSI: Kill default_teardown_msi_irqs()
  PCI: MSI: Let PCI host bridges declare their reliance on MSI domains
  PCI: Make pci_host_common_probe() declare its reliance on MSI domains
  PCI: MSI: Document the various ways of ending up with NO_MSI
  PCI: quirks: Refactor advertising of the NO_MSI flag

Thomas Gleixner (2):
  PCI: MSI: Let PCI host bridges declare their lack of MSI handling
  PCI: mediatek: Advertise lack of MSI handling

 drivers/pci/controller/Kconfig           |   4 +-
 drivers/pci/controller/pci-host-common.c |   1 +
 drivers/pci/controller/pci-hyperv.c      |   4 -
 drivers/pci/controller/pci-tegra.c       | 343 ++++++++++++-----------
 drivers/pci/controller/pcie-mediatek.c   |   4 +
 drivers/pci/controller/pcie-rcar-host.c  | 342 +++++++++++-----------
 drivers/pci/controller/pcie-xilinx.c     | 238 +++++++---------
 drivers/pci/msi.c                        |  46 +--
 drivers/pci/probe.c                      |   4 +-
 drivers/pci/quirks.c                     |  15 +-
 include/linux/msi.h                      |  17 +-
 include/linux/pci.h                      |   4 +-
 12 files changed, 463 insertions(+), 559 deletions(-)

-- 
2.29.2

