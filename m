Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525D2344EC9
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 19:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCVSqi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 14:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhCVSq1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 14:46:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B64F619A0;
        Mon, 22 Mar 2021 18:46:26 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lOPZH-0038p5-J7; Mon, 22 Mar 2021 18:46:23 +0000
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
        Michael Kelley <mikelley@microsoft.com>,
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
        linux-renesas-soc@vger.kernel.org, kernel-team@android.com
Subject: [PATCH v2 00/15] PCI/MSI: Getting rid of msi_controller, and other cleanups
Date:   Mon, 22 Mar 2021 18:45:59 +0000
Message-Id: <20210322184614.802565-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, bhelgaas@google.com, frank-w@public-files.de, treding@nvidia.com, tglx@linutronix.de, robh@kernel.org, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, mikelley@microsoft.com, wei.liu@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, ryder.lee@mediatek.com, marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, michal.simek@xilinx.com, paul.walmsley@sifive.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is a respin of the series described at [1].

* From v1:
  - Extracted the changes dealing with the MSI capture address
    for rcar and xilinx and moved them to separate patches
  - Changed the rcar code to cope with c4e0fec2f7ee ("PCI: rcar: Always
    allocate MSI addresses in 32bit space")
  - Fixed rcar resume code
  - Reworked commit messages
  - Rebased onto v5.12-rc4
  - Collected Acks, and TBs, with thanks.

[1] https://lore.kernel.org/r/20210225151023.3642391-1-maz@kernel.org

Marc Zyngier (13):
  PCI: tegra: Convert to MSI domains
  PCI: rcar: Don't allocate extra memory for the MSI capture address
  PCI: rcar: Convert to MSI domains
  PCI: xilinx: Don't allocate extra memory for the MSI capture address
  PCI: xilinx: Convert to MSI domains
  PCI: hv: Drop msi_controller structure
  PCI/MSI: Drop use of msi_controller from core code
  PCI/MSI: Kill msi_controller structure
  PCI/MSI: Kill default_teardown_msi_irqs()
  PCI/MSI: Let PCI host bridges declare their reliance on MSI domains
  PCI/MSI: Make pci_host_common_probe() declare its reliance on MSI
    domains
  PCI/MSI: Document the various ways of ending up with NO_MSI
  PCI: Refactor HT advertising of NO_MSI flag

Thomas Gleixner (2):
  PCI/MSI: Let PCI host bridges declare their lack of MSI handling
  PCI: mediatek: Advertise lack of MSI handling

 drivers/pci/controller/Kconfig           |   4 +-
 drivers/pci/controller/pci-host-common.c |   1 +
 drivers/pci/controller/pci-hyperv.c      |   4 -
 drivers/pci/controller/pci-tegra.c       | 343 ++++++++++++----------
 drivers/pci/controller/pcie-mediatek.c   |   4 +
 drivers/pci/controller/pcie-rcar-host.c  | 356 +++++++++++------------
 drivers/pci/controller/pcie-xilinx.c     | 238 ++++++---------
 drivers/pci/msi.c                        |  46 +--
 drivers/pci/probe.c                      |   4 +-
 drivers/pci/quirks.c                     |  15 +-
 include/linux/msi.h                      |  17 +-
 include/linux/pci.h                      |   4 +-
 12 files changed, 477 insertions(+), 559 deletions(-)

-- 
2.29.2

