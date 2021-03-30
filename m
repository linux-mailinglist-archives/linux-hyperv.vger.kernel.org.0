Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECCC34EBB4
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Mar 2021 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhC3PMZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Mar 2021 11:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232192AbhC3PLy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Mar 2021 11:11:54 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F61619CB;
        Tue, 30 Mar 2021 15:11:53 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lRG24-004i6i-3Y; Tue, 30 Mar 2021 16:11:52 +0100
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
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, kernel-team@android.com
Subject: [PATCH v3 02/14] PCI: rcar: Don't allocate extra memory for the MSI capture address
Date:   Tue, 30 Mar 2021 16:11:33 +0100
Message-Id: <20210330151145.997953-3-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210330151145.997953-1-maz@kernel.org>
References: <20210330151145.997953-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, bhelgaas@google.com, frank-w@public-files.de, treding@nvidia.com, tglx@linutronix.de, robh@kernel.org, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, mikelley@microsoft.com, wei.liu@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, ryder.lee@mediatek.com, marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, michal.simek@xilinx.com, paul.walmsley@sifive.com, bharatku@xilinx.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A long cargo-culted behaviour of PCI drivers is to allocate memory
to obtain an address that is fed to the controller as the MSI
capture address (i.e. the MSI doorbell).

But there is no actual requirement for this address to be RAM.
All it needs to be is a suitable aligned address that will
*not* be DMA'd to.

Since the rcar platform already has a requirement that this
address should be in the first 4GB of the physical address space,
use the controller's own base address as the capture address.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-rcar-host.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index a728e8f9ad3c..ce952403e22c 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -36,7 +36,6 @@ struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
 	struct msi_controller chip;
-	unsigned long pages;
 	struct mutex lock;
 	int irq1;
 	int irq2;
@@ -680,14 +679,15 @@ static void rcar_pcie_unmap_msi(struct rcar_pcie_host *host)
 static void rcar_pcie_hw_enable_msi(struct rcar_pcie_host *host)
 {
 	struct rcar_pcie *pcie = &host->pcie;
-	struct rcar_msi *msi = &host->msi;
-	unsigned long base;
+	struct device *dev = pcie->dev;
+	struct resource res;
 
-	/* setup MSI data target */
-	base = virt_to_phys((void *)msi->pages);
+	if (WARN_ON(of_address_to_resource(dev->of_node, 0, &res)))
+		return;
 
-	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
+	/* setup MSI data target */
+	rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE, PCIEMSIALR);
+	rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
 
 	/* enable all MSI interrupts */
 	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
@@ -735,7 +735,6 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 	}
 
 	/* setup MSI data target */
-	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA32, 0);
 	rcar_pcie_hw_enable_msi(host);
 
 	return 0;
@@ -748,7 +747,6 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
 {
 	struct rcar_pcie *pcie = &host->pcie;
-	struct rcar_msi *msi = &host->msi;
 
 	/* Disable all MSI interrupts */
 	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
@@ -756,8 +754,6 @@ static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
 	/* Disable address decoding of the MSI interrupt, MSIFE */
 	rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
 
-	free_pages(msi->pages, 0);
-
 	rcar_pcie_unmap_msi(host);
 }
 
-- 
2.29.2

