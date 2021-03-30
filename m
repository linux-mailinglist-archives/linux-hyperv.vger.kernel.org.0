Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988E034EBB2
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Mar 2021 17:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhC3PMX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Mar 2021 11:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232064AbhC3PLx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Mar 2021 11:11:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4DCC619D1;
        Tue, 30 Mar 2021 15:11:52 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lRG23-004i6i-4W; Tue, 30 Mar 2021 16:11:51 +0100
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
Subject: [PATCH v3 01/14] PCI: tegra: Convert to MSI domains
Date:   Tue, 30 Mar 2021 16:11:32 +0100
Message-Id: <20210330151145.997953-2-maz@kernel.org>
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

In anticipation of the removal of the msi_controller structure, convert
the Tegra host controller driver to MSI domains.

We end-up with the usual two domain structure, the top one being a
generic PCI/MSI domain, the bottom one being Tegra-specific and handling
the actual HW interrupt allocation.

While at it, convert the normal interrupt handler to a chained handler,
handle the controller's MSI IRQ edge triggered, support multiple MSIs
per device and use the AFI_MSI_EN_VEC* registers to provide MSI masking.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
[treding@nvidia.com: fix, clean up and address TODOs from Marc's draft]
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/Kconfig     |   1 -
 drivers/pci/controller/pci-tegra.c | 343 ++++++++++++++++-------------
 2 files changed, 185 insertions(+), 159 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 5aa8977d7b0f..be8f9ff512a0 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -41,7 +41,6 @@ config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 8fcabed7c6a6..eaba7b2fab4a 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -78,23 +79,8 @@
 #define AFI_MSI_FPCI_BAR_ST	0x64
 #define AFI_MSI_AXI_BAR_ST	0x68
 
-#define AFI_MSI_VEC0		0x6c
-#define AFI_MSI_VEC1		0x70
-#define AFI_MSI_VEC2		0x74
-#define AFI_MSI_VEC3		0x78
-#define AFI_MSI_VEC4		0x7c
-#define AFI_MSI_VEC5		0x80
-#define AFI_MSI_VEC6		0x84
-#define AFI_MSI_VEC7		0x88
-
-#define AFI_MSI_EN_VEC0		0x8c
-#define AFI_MSI_EN_VEC1		0x90
-#define AFI_MSI_EN_VEC2		0x94
-#define AFI_MSI_EN_VEC3		0x98
-#define AFI_MSI_EN_VEC4		0x9c
-#define AFI_MSI_EN_VEC5		0xa0
-#define AFI_MSI_EN_VEC6		0xa4
-#define AFI_MSI_EN_VEC7		0xa8
+#define AFI_MSI_VEC(x)		(0x6c + ((x) * 4))
+#define AFI_MSI_EN_VEC(x)	(0x8c + ((x) * 4))
 
 #define AFI_CONFIGURATION		0xac
 #define  AFI_CONFIGURATION_EN_FPCI		(1 << 0)
@@ -280,10 +266,10 @@
 #define LINK_RETRAIN_TIMEOUT 100000 /* in usec */
 
 struct tegra_msi {
-	struct msi_controller chip;
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
-	struct mutex lock;
+	struct mutex map_lock;
+	spinlock_t mask_lock;
 	void *virt;
 	dma_addr_t phys;
 	int irq;
@@ -333,11 +319,6 @@ struct tegra_pcie_soc {
 	} ectl;
 };
 
-static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
-{
-	return container_of(chip, struct tegra_msi, chip);
-}
-
 struct tegra_pcie {
 	struct device *dev;
 
@@ -372,6 +353,11 @@ struct tegra_pcie {
 	struct dentry *debugfs;
 };
 
+static inline struct tegra_pcie *msi_to_pcie(struct tegra_msi *msi)
+{
+	return container_of(msi, struct tegra_pcie, msi);
+}
+
 struct tegra_pcie_port {
 	struct tegra_pcie *pcie;
 	struct device_node *np;
@@ -1432,7 +1418,6 @@ static void tegra_pcie_phys_put(struct tegra_pcie *pcie)
 	}
 }
 
-
 static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -1509,6 +1494,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 phys_put:
 	if (soc->program_uphy)
 		tegra_pcie_phys_put(pcie);
+
 	return err;
 }
 
@@ -1551,161 +1537,227 @@ static void tegra_pcie_pme_turnoff(struct tegra_pcie_port *port)
 	afi_writel(pcie, val, AFI_PCIE_PME);
 }
 
-static int tegra_msi_alloc(struct tegra_msi *chip)
-{
-	int msi;
-
-	mutex_lock(&chip->lock);
-
-	msi = find_first_zero_bit(chip->used, INT_PCI_MSI_NR);
-	if (msi < INT_PCI_MSI_NR)
-		set_bit(msi, chip->used);
-	else
-		msi = -ENOSPC;
-
-	mutex_unlock(&chip->lock);
-
-	return msi;
-}
-
-static void tegra_msi_free(struct tegra_msi *chip, unsigned long irq)
+static void tegra_pcie_msi_irq(struct irq_desc *desc)
 {
-	struct device *dev = chip->chip.dev;
-
-	mutex_lock(&chip->lock);
-
-	if (!test_bit(irq, chip->used))
-		dev_err(dev, "trying to free unused MSI#%lu\n", irq);
-	else
-		clear_bit(irq, chip->used);
-
-	mutex_unlock(&chip->lock);
-}
-
-static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
-{
-	struct tegra_pcie *pcie = data;
-	struct device *dev = pcie->dev;
+	struct tegra_pcie *pcie = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct tegra_msi *msi = &pcie->msi;
-	unsigned int i, processed = 0;
+	struct device *dev = pcie->dev;
+	unsigned int i;
+
+	chained_irq_enter(chip, desc);
 
 	for (i = 0; i < 8; i++) {
-		unsigned long reg = afi_readl(pcie, AFI_MSI_VEC0 + i * 4);
+		unsigned long reg = afi_readl(pcie, AFI_MSI_VEC(i));
 
 		while (reg) {
 			unsigned int offset = find_first_bit(&reg, 32);
 			unsigned int index = i * 32 + offset;
 			unsigned int irq;
 
-			/* clear the interrupt */
-			afi_writel(pcie, 1 << offset, AFI_MSI_VEC0 + i * 4);
-
-			irq = irq_find_mapping(msi->domain, index);
+			irq = irq_find_mapping(msi->domain->parent, index);
 			if (irq) {
-				if (test_bit(index, msi->used))
-					generic_handle_irq(irq);
-				else
-					dev_info(dev, "unhandled MSI\n");
+				generic_handle_irq(irq);
 			} else {
 				/*
 				 * that's weird who triggered this?
 				 * just clear it
 				 */
 				dev_info(dev, "unexpected MSI\n");
+				afi_writel(pcie, BIT(index % 32), AFI_MSI_VEC(index));
 			}
 
 			/* see if there's any more pending in this vector */
-			reg = afi_readl(pcie, AFI_MSI_VEC0 + i * 4);
-
-			processed++;
+			reg = afi_readl(pcie, AFI_MSI_VEC(i));
 		}
 	}
 
-	return processed > 0 ? IRQ_HANDLED : IRQ_NONE;
+	chained_irq_exit(chip, desc);
 }
 
-static int tegra_msi_setup_irq(struct msi_controller *chip,
-			       struct pci_dev *pdev, struct msi_desc *desc)
+static void tegra_msi_top_irq_ack(struct irq_data *d)
 {
-	struct tegra_msi *msi = to_tegra_msi(chip);
-	struct msi_msg msg;
-	unsigned int irq;
-	int hwirq;
+	irq_chip_ack_parent(d);
+}
 
-	hwirq = tegra_msi_alloc(msi);
-	if (hwirq < 0)
-		return hwirq;
+static void tegra_msi_top_irq_mask(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
 
-	irq = irq_create_mapping(msi->domain, hwirq);
-	if (!irq) {
-		tegra_msi_free(msi, hwirq);
-		return -EINVAL;
-	}
+static void tegra_msi_top_irq_unmask(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip tegra_msi_top_chip = {
+	.name		= "tegra PCIe MSI",
+	.irq_ack	= tegra_msi_top_irq_ack,
+	.irq_mask	= tegra_msi_top_irq_mask,
+	.irq_unmask	= tegra_msi_top_irq_unmask,
+};
 
-	irq_set_msi_desc(irq, desc);
+static void tegra_msi_irq_ack(struct irq_data *d)
+{
+	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
+	struct tegra_pcie *pcie = msi_to_pcie(msi);
+	unsigned int index = d->hwirq / 32;
 
-	msg.address_lo = lower_32_bits(msi->phys);
-	msg.address_hi = upper_32_bits(msi->phys);
-	msg.data = hwirq;
+	/* clear the interrupt */
+	afi_writel(pcie, BIT(d->hwirq % 32), AFI_MSI_VEC(index));
+}
 
-	pci_write_msi_msg(irq, &msg);
+static void tegra_msi_irq_mask(struct irq_data *d)
+{
+	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
+	struct tegra_pcie *pcie = msi_to_pcie(msi);
+	unsigned int index = d->hwirq / 32;
+	unsigned long flags;
+	u32 value;
 
-	return 0;
+	spin_lock_irqsave(&msi->mask_lock, flags);
+	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
+	value &= ~BIT(d->hwirq % 32);
+	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
+	spin_unlock_irqrestore(&msi->mask_lock, flags);
+}
+
+static void tegra_msi_irq_unmask(struct irq_data *d)
+{
+	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
+	struct tegra_pcie *pcie = msi_to_pcie(msi);
+	unsigned int index = d->hwirq / 32;
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&msi->mask_lock, flags);
+	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
+	value |= BIT(d->hwirq % 32);
+	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
+	spin_unlock_irqrestore(&msi->mask_lock, flags);
+}
+
+static int tegra_msi_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
 }
 
-static void tegra_msi_teardown_irq(struct msi_controller *chip,
-				   unsigned int irq)
+static void tegra_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct tegra_msi *msi = to_tegra_msi(chip);
-	struct irq_data *d = irq_get_irq_data(irq);
-	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	struct tegra_msi *msi = irq_data_get_irq_chip_data(data);
 
-	irq_dispose_mapping(irq);
-	tegra_msi_free(msi, hwirq);
+	msg->address_lo = lower_32_bits(msi->phys);
+	msg->address_hi = upper_32_bits(msi->phys);
+	msg->data = data->hwirq;
 }
 
-static struct irq_chip tegra_msi_irq_chip = {
-	.name = "Tegra PCIe MSI",
-	.irq_enable = pci_msi_unmask_irq,
-	.irq_disable = pci_msi_mask_irq,
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
+static struct irq_chip tegra_msi_bottom_chip = {
+	.name			= "Tegra MSI",
+	.irq_ack		= tegra_msi_irq_ack,
+	.irq_mask		= tegra_msi_irq_mask,
+	.irq_unmask		= tegra_msi_irq_unmask,
+	.irq_set_affinity 	= tegra_msi_set_affinity,
+	.irq_compose_msi_msg	= tegra_compose_msi_msg,
 };
 
-static int tegra_msi_map(struct irq_domain *domain, unsigned int irq,
-			 irq_hw_number_t hwirq)
+static int tegra_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *args)
 {
-	irq_set_chip_and_handler(irq, &tegra_msi_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
+	struct tegra_msi *msi = domain->host_data;
+	unsigned int i;
+	int hwirq;
+
+	mutex_lock(&msi->map_lock);
+
+	hwirq = bitmap_find_free_region(msi->used, INT_PCI_MSI_NR, order_base_2(nr_irqs));
+
+	mutex_unlock(&msi->map_lock);
+
+	if (hwirq < 0)
+		return -ENOSPC;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &tegra_msi_bottom_chip, domain->host_data,
+				    handle_edge_irq, NULL, NULL);
 
 	tegra_cpuidle_pcie_irqs_in_use();
 
 	return 0;
 }
 
-static const struct irq_domain_ops msi_domain_ops = {
-	.map = tegra_msi_map,
+static void tegra_msi_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct tegra_msi *msi = domain->host_data;
+
+	mutex_lock(&msi->map_lock);
+
+	bitmap_release_region(msi->used, d->hwirq, order_base_2(nr_irqs));
+
+	mutex_unlock(&msi->map_lock);
+}
+
+static const struct irq_domain_ops tegra_msi_domain_ops = {
+	.alloc = tegra_msi_domain_alloc,
+	.free = tegra_msi_domain_free,
+};
+
+static struct msi_domain_info tegra_msi_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX),
+	.chip	= &tegra_msi_top_chip,
 };
 
+static int tegra_allocate_domains(struct tegra_msi *msi)
+{
+	struct tegra_pcie *pcie = msi_to_pcie(msi);
+	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
+	struct irq_domain *parent;
+
+	parent = irq_domain_create_linear(fwnode, INT_PCI_MSI_NR,
+					  &tegra_msi_domain_ops, msi);
+	if (!parent) {
+		dev_err(pcie->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
+
+	msi->domain = pci_msi_create_irq_domain(fwnode, &tegra_msi_info, parent);
+	if (!msi->domain) {
+		dev_err(pcie->dev, "failed to create MSI domain\n");
+		irq_domain_remove(parent);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void tegra_free_domains(struct tegra_msi *msi)
+{
+	struct irq_domain *parent = msi->domain->parent;
+
+	irq_domain_remove(msi->domain);
+	irq_domain_remove(parent);
+}
+
 static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 {
-	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 	struct platform_device *pdev = to_platform_device(pcie->dev);
 	struct tegra_msi *msi = &pcie->msi;
 	struct device *dev = pcie->dev;
 	int err;
 
-	mutex_init(&msi->lock);
-
-	msi->chip.dev = dev;
-	msi->chip.setup_irq = tegra_msi_setup_irq;
-	msi->chip.teardown_irq = tegra_msi_teardown_irq;
+	mutex_init(&msi->map_lock);
+	spin_lock_init(&msi->mask_lock);
 
-	msi->domain = irq_domain_add_linear(dev->of_node, INT_PCI_MSI_NR,
-					    &msi_domain_ops, &msi->chip);
-	if (!msi->domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		err = tegra_allocate_domains(msi);
+		if (err)
+			return err;
 	}
 
 	err = platform_get_irq_byname(pdev, "msi");
@@ -1714,12 +1766,7 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 
 	msi->irq = err;
 
-	err = request_irq(msi->irq, tegra_pcie_msi_irq, IRQF_NO_THREAD,
-			  tegra_msi_irq_chip.name, pcie);
-	if (err < 0) {
-		dev_err(dev, "failed to request IRQ: %d\n", err);
-		goto free_irq_domain;
-	}
+	irq_set_chained_handler_and_data(msi->irq, tegra_pcie_msi_irq, pcie);
 
 	/* Though the PCIe controller can address >32-bit address space, to
 	 * facilitate endpoints that support only 32-bit MSI target address,
@@ -1740,14 +1787,14 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 		goto free_irq;
 	}
 
-	host->msi = &msi->chip;
-
 	return 0;
 
 free_irq:
-	free_irq(msi->irq, pcie);
+	irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
 free_irq_domain:
-	irq_domain_remove(msi->domain);
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		tegra_free_domains(msi);
+
 	return err;
 }
 
@@ -1762,16 +1809,6 @@ static void tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 	/* this register is in 4K increments */
 	afi_writel(pcie, 1, AFI_MSI_BAR_SZ);
 
-	/* enable all MSI vectors */
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC0);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC1);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC2);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC3);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC4);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC5);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC6);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC7);
-
 	/* and unmask the MSI interrupt */
 	reg = afi_readl(pcie, AFI_INTR_MASK);
 	reg |= AFI_INTR_MASK_MSI_MASK;
@@ -1786,16 +1823,16 @@ static void tegra_pcie_msi_teardown(struct tegra_pcie *pcie)
 	dma_free_attrs(pcie->dev, PAGE_SIZE, msi->virt, msi->phys,
 		       DMA_ATTR_NO_KERNEL_MAPPING);
 
-	if (msi->irq > 0)
-		free_irq(msi->irq, pcie);
-
 	for (i = 0; i < INT_PCI_MSI_NR; i++) {
 		irq = irq_find_mapping(msi->domain, i);
 		if (irq > 0)
-			irq_dispose_mapping(irq);
+			irq_domain_free_irqs(irq, 1);
 	}
 
-	irq_domain_remove(msi->domain);
+	irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		tegra_free_domains(msi);
 }
 
 static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
@@ -1807,16 +1844,6 @@ static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
 	value &= ~AFI_INTR_MASK_MSI_MASK;
 	afi_writel(pcie, value, AFI_INTR_MASK);
 
-	/* disable all MSI vectors */
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC0);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC1);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC2);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC3);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC4);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC5);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC6);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC7);
-
 	return 0;
 }
 
-- 
2.29.2

