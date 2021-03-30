Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324EC34EBB1
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Mar 2021 17:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhC3PMX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Mar 2021 11:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232226AbhC3PL4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Mar 2021 11:11:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C45619D0;
        Tue, 30 Mar 2021 15:11:55 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lRG26-004i6i-6K; Tue, 30 Mar 2021 16:11:54 +0100
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
Subject: [PATCH v3 04/14] PCI: xilinx: Don't allocate extra memory for the MSI capture address
Date:   Tue, 30 Mar 2021 16:11:35 +0100
Message-Id: <20210330151145.997953-5-maz@kernel.org>
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

Use the physical address of the 'port' data structure as the MSI
capture address, aligned on a 4K boundary.

Tested-by: Bharat Kumar Gogada <bharatku@xilinx.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-xilinx.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index fa5baeb82653..e127a7b6e535 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -94,7 +94,6 @@
  * struct xilinx_pcie_port - PCIe port information
  * @reg_base: IO Mapped Register Base
  * @irq: Interrupt number
- * @msi_pages: MSI pages
  * @dev: Device pointer
  * @msi_domain: MSI IRQ domain pointer
  * @leg_domain: Legacy IRQ domain pointer
@@ -103,7 +102,6 @@
 struct xilinx_pcie_port {
 	void __iomem *reg_base;
 	u32 irq;
-	unsigned long msi_pages;
 	struct device *dev;
 	struct irq_domain *msi_domain;
 	struct irq_domain *leg_domain;
@@ -274,10 +272,10 @@ static int xilinx_pcie_msi_setup_irq(struct msi_controller *chip,
 
 	irq_set_msi_desc(irq, desc);
 
-	msg_addr = virt_to_phys((void *)port->msi_pages);
+	msg_addr = ALIGN_DOWN(virt_to_phys(port), SZ_4K);
 
-	msg.address_hi = 0;
-	msg.address_lo = msg_addr;
+	msg.address_hi = upper_32_bits(msg_addr);
+	msg.address_lo = lower_32_bits(msg_addr);
 	msg.data = irq;
 
 	pci_write_msi_msg(irq, &msg);
@@ -330,13 +328,9 @@ static int xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
 {
 	phys_addr_t msg_addr;
 
-	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
-	if (!port->msi_pages)
-		return -ENOMEM;
-
-	msg_addr = virt_to_phys((void *)port->msi_pages);
-	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
-	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
+	msg_addr = ALIGN_DOWN(virt_to_phys(port), SZ_4K);
+	pcie_write(port, upper_32_bits(msg_addr), XILINX_PCIE_REG_MSIBASE1);
+	pcie_write(port, lower_32_bits(msg_addr), XILINX_PCIE_REG_MSIBASE2);
 
 	return 0;
 }
-- 
2.29.2

