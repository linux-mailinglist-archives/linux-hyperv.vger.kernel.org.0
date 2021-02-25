Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11086325207
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Feb 2021 16:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhBYPLr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 Feb 2021 10:11:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230498AbhBYPLl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Feb 2021 10:11:41 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B720A64F16;
        Thu, 25 Feb 2021 15:10:58 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lFII4-00Fscv-TS; Thu, 25 Feb 2021 15:10:57 +0000
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
Subject: [PATCH 02/13] PCI: rcar: Convert to MSI domains
Date:   Thu, 25 Feb 2021 15:10:12 +0000
Message-Id: <20210225151023.3642391-3-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225151023.3642391-1-maz@kernel.org>
References: <20210225151023.3642391-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, bhelgaas@google.com, frank-w@public-files.de, treding@nvidia.com, tglx@linutronix.de, robh@kernel.org, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, ryder.lee@mediatek.com, marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, michal.simek@xilinx.com, paul.walmsley@sifive.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In anticipation of the removal of the msi_controller structure, convert
the Rcar host controller driver to MSI domains.

We end-up with the usual two domain structure, the top one being a
generic PCI/MSI domain, the bottom one being Rcar-specific and handling
the actual HW interrupt allocation.

Also take the opportunity to get rid of the cargo-culted memory allocation
for the MSI capture address. *ANY* sufficiently aligned address should
be good enough, so use the physical address of the msi structure instead.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/Kconfig          |   1 -
 drivers/pci/controller/pcie-rcar-host.c | 342 +++++++++++-------------
 2 files changed, 156 insertions(+), 187 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index e7007e4028fc..ccbf034512d6 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -67,7 +67,6 @@ config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
 	  mode.
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 4d1c4b24e537..2526cd487a39 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -35,18 +35,12 @@
 struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
-	struct msi_controller chip;
-	unsigned long pages;
-	struct mutex lock;
+	struct mutex map_lock;
+	spinlock_t mask_lock;
 	int irq1;
 	int irq2;
 };
 
-static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
-{
-	return container_of(chip, struct rcar_msi, chip);
-}
-
 /* Structure representing the PCIe interface */
 struct rcar_pcie_host {
 	struct rcar_pcie	pcie;
@@ -56,6 +50,11 @@ struct rcar_pcie_host {
 	int			(*phy_init_fn)(struct rcar_pcie_host *host);
 };
 
+static struct rcar_pcie_host *msi_to_host(struct rcar_msi *msi)
+{
+	return container_of(msi, struct rcar_pcie_host, msi);
+}
+
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
 	unsigned int shift = BITS_PER_BYTE * (where & 3);
@@ -292,8 +291,6 @@ static int rcar_pcie_enable(struct rcar_pcie_host *host)
 
 	bridge->sysdata = host;
 	bridge->ops = &rcar_pcie_ops;
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		bridge->msi = &host->msi.chip;
 
 	return pci_host_probe(bridge);
 }
@@ -473,42 +470,6 @@ static int rcar_pcie_phy_init_gen3(struct rcar_pcie_host *host)
 	return err;
 }
 
-static int rcar_msi_alloc(struct rcar_msi *chip)
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
-static int rcar_msi_alloc_region(struct rcar_msi *chip, int no_irqs)
-{
-	int msi;
-
-	mutex_lock(&chip->lock);
-	msi = bitmap_find_free_region(chip->used, INT_PCI_MSI_NR,
-				      order_base_2(no_irqs));
-	mutex_unlock(&chip->lock);
-
-	return msi;
-}
-
-static void rcar_msi_free(struct rcar_msi *chip, unsigned long irq)
-{
-	mutex_lock(&chip->lock);
-	clear_bit(irq, chip->used);
-	mutex_unlock(&chip->lock);
-}
-
 static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 {
 	struct rcar_pcie_host *host = data;
@@ -527,18 +488,13 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 		unsigned int index = find_first_bit(&reg, 32);
 		unsigned int msi_irq;
 
-		/* clear the interrupt */
-		rcar_pci_write_reg(pcie, 1 << index, PCIEMSIFR);
-
-		msi_irq = irq_find_mapping(msi->domain, index);
+		msi_irq = irq_find_mapping(msi->domain->parent, index);
 		if (msi_irq) {
-			if (test_bit(index, msi->used))
-				generic_handle_irq(msi_irq);
-			else
-				dev_info(dev, "unhandled MSI\n");
+			generic_handle_irq(msi_irq);
 		} else {
 			/* Unknown MSI, just clear it */
 			dev_dbg(dev, "unexpected MSI\n");
+			rcar_pci_write_reg(pcie, BIT(index), PCIEMSIFR);
 		}
 
 		/* see if there's any more pending in this vector */
@@ -548,149 +504,170 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int rcar_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
-			      struct msi_desc *desc)
+static void rcar_msi_top_irq_ack(struct irq_data *d)
 {
-	struct rcar_msi *msi = to_rcar_msi(chip);
-	struct rcar_pcie_host *host = container_of(chip, struct rcar_pcie_host,
-						   msi.chip);
-	struct rcar_pcie *pcie = &host->pcie;
-	struct msi_msg msg;
-	unsigned int irq;
-	int hwirq;
+	irq_chip_ack_parent(d);
+}
 
-	hwirq = rcar_msi_alloc(msi);
-	if (hwirq < 0)
-		return hwirq;
+static void rcar_msi_top_irq_mask(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
 
-	irq = irq_find_mapping(msi->domain, hwirq);
-	if (!irq) {
-		rcar_msi_free(msi, hwirq);
-		return -EINVAL;
-	}
+static void rcar_msi_top_irq_unmask(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
 
-	irq_set_msi_desc(irq, desc);
+static struct irq_chip rcar_msi_top_chip = {
+	.name		= "PCIe MSI",
+	.irq_ack	= rcar_msi_top_irq_ack,
+	.irq_mask	= rcar_msi_top_irq_mask,
+	.irq_unmask	= rcar_msi_top_irq_unmask,
+};
+
+static void rcar_msi_irq_ack(struct irq_data *d)
+{
+	struct rcar_msi *msi = irq_data_get_irq_chip_data(d);
+	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
 
-	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
-	msg.data = hwirq;
+	/* clear the interrupt */
+	rcar_pci_write_reg(pcie, BIT(d->hwirq), PCIEMSIFR);
+}
 
-	pci_write_msi_msg(irq, &msg);
+static void rcar_msi_irq_mask(struct irq_data *d)
+{
+	struct rcar_msi *msi = irq_data_get_irq_chip_data(d);
+	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
+	unsigned long flags;
+	u32 value;
 
-	return 0;
+	spin_lock_irqsave(&msi->mask_lock, flags);
+	value = rcar_pci_read_reg(pcie, PCIEMSIIER);
+	value &= ~BIT(d->hwirq);
+	rcar_pci_write_reg(pcie, value, PCIEMSIIER);
+	spin_unlock_irqrestore(&msi->mask_lock, flags);
 }
 
-static int rcar_msi_setup_irqs(struct msi_controller *chip,
-			       struct pci_dev *pdev, int nvec, int type)
+static void rcar_msi_irq_unmask(struct irq_data *d)
 {
-	struct rcar_msi *msi = to_rcar_msi(chip);
-	struct rcar_pcie_host *host = container_of(chip, struct rcar_pcie_host,
-						   msi.chip);
-	struct rcar_pcie *pcie = &host->pcie;
-	struct msi_desc *desc;
-	struct msi_msg msg;
-	unsigned int irq;
-	int hwirq;
-	int i;
+	struct rcar_msi *msi = irq_data_get_irq_chip_data(d);
+	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
+	unsigned long flags;
+	u32 value;
 
-	/* MSI-X interrupts are not supported */
-	if (type == PCI_CAP_ID_MSIX)
-		return -EINVAL;
+	spin_lock_irqsave(&msi->mask_lock, flags);
+	value = rcar_pci_read_reg(pcie, PCIEMSIIER);
+	value |= BIT(d->hwirq);
+	rcar_pci_write_reg(pcie, value, PCIEMSIIER);
+	spin_unlock_irqrestore(&msi->mask_lock, flags);
+}
 
-	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
-	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
+static int rcar_msi_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
 
-	hwirq = rcar_msi_alloc_region(msi, nvec);
-	if (hwirq < 0)
-		return -ENOSPC;
+static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct rcar_msi *msi = irq_data_get_irq_chip_data(data);
+	unsigned long pa = virt_to_phys(msi);
 
-	irq = irq_find_mapping(msi->domain, hwirq);
-	if (!irq)
-		return -ENOSPC;
+	/* Use the msi structure as the PA for the MSI doorbell */
+	msg->address_lo = lower_32_bits(pa);
+	msg->address_hi = upper_32_bits(pa);
+	msg->data = data->hwirq;
+}
 
-	for (i = 0; i < nvec; i++) {
-		/*
-		 * irq_create_mapping() called from rcar_pcie_probe() pre-
-		 * allocates descs,  so there is no need to allocate descs here.
-		 * We can therefore assume that if irq_find_mapping() above
-		 * returns non-zero, then the descs are also successfully
-		 * allocated.
-		 */
-		if (irq_set_msi_desc_off(irq, i, desc)) {
-			/* TODO: clear */
-			return -EINVAL;
-		}
-	}
+static struct irq_chip rcar_msi_bottom_chip = {
+	.name			= "Rcar MSI",
+	.irq_ack		= rcar_msi_irq_ack,
+	.irq_mask		= rcar_msi_irq_mask,
+	.irq_unmask		= rcar_msi_irq_unmask,
+	.irq_set_affinity 	= rcar_msi_set_affinity,
+	.irq_compose_msi_msg	= rcar_compose_msi_msg,
+};
+
+static int rcar_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *args)
+{
+	struct rcar_msi *msi = domain->host_data;
+	unsigned int i;
+	int hwirq;
 
-	desc->nvec_used = nvec;
-	desc->msi_attrib.multiple = order_base_2(nvec);
+	mutex_lock(&msi->map_lock);
 
-	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
-	msg.data = hwirq;
+	hwirq = bitmap_find_free_region(msi->used, INT_PCI_MSI_NR, order_base_2(nr_irqs));
 
-	pci_write_msi_msg(irq, &msg);
+	mutex_unlock(&msi->map_lock);
+
+	if (hwirq < 0)
+		return -ENOSPC;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &rcar_msi_bottom_chip, domain->host_data,
+				    handle_edge_irq, NULL, NULL);
 
 	return 0;
 }
 
-static void rcar_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
+static void rcar_msi_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
 {
-	struct rcar_msi *msi = to_rcar_msi(chip);
-	struct irq_data *d = irq_get_irq_data(irq);
-
-	rcar_msi_free(msi, d->hwirq);
-}
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct rcar_msi *msi = domain->host_data;
 
-static struct irq_chip rcar_msi_irq_chip = {
-	.name = "R-Car PCIe MSI",
-	.irq_enable = pci_msi_unmask_irq,
-	.irq_disable = pci_msi_mask_irq,
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
-};
+	mutex_lock(&msi->map_lock);
 
-static int rcar_msi_map(struct irq_domain *domain, unsigned int irq,
-			irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &rcar_msi_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
+	bitmap_release_region(msi->used, d->hwirq, order_base_2(nr_irqs));
 
-	return 0;
+	mutex_unlock(&msi->map_lock);
 }
 
-static const struct irq_domain_ops msi_domain_ops = {
-	.map = rcar_msi_map,
+static const struct irq_domain_ops rcar_msi_domain_ops = {
+	.alloc	= rcar_msi_domain_alloc,
+	.free	= rcar_msi_domain_free,
 };
 
-static void rcar_pcie_unmap_msi(struct rcar_pcie_host *host)
+static struct msi_domain_info rcar_msi_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_MULTI_PCI_MSI),
+	.chip	= &rcar_msi_top_chip,
+};
+
+static int rcar_allocate_domains(struct rcar_msi *msi)
 {
-	struct rcar_msi *msi = &host->msi;
-	int i, irq;
+	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
+	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
+	struct irq_domain *parent;
 
-	for (i = 0; i < INT_PCI_MSI_NR; i++) {
-		irq = irq_find_mapping(msi->domain, i);
-		if (irq > 0)
-			irq_dispose_mapping(irq);
+	parent = irq_domain_create_linear(fwnode, INT_PCI_MSI_NR,
+					  &rcar_msi_domain_ops, msi);
+	if (!parent) {
+		dev_err(pcie->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
 	}
+	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
 
-	irq_domain_remove(msi->domain);
+	msi->domain = pci_msi_create_irq_domain(fwnode, &rcar_msi_info, parent);
+	if (!msi->domain) {
+		dev_err(pcie->dev, "failed to create MSI domain\n");
+		irq_domain_remove(parent);
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
-static void rcar_pcie_hw_enable_msi(struct rcar_pcie_host *host)
+static void rcar_free_domains(struct rcar_msi *msi)
 {
-	struct rcar_pcie *pcie = &host->pcie;
-	struct rcar_msi *msi = &host->msi;
-	unsigned long base;
-
-	/* setup MSI data target */
-	base = virt_to_phys((void *)msi->pages);
-
-	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
+	struct irq_domain *parent = msi->domain->parent;
 
-	/* enable all MSI interrupts */
-	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
+	irq_domain_remove(msi->domain);
+	irq_domain_remove(parent);
 }
 
 static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
@@ -698,29 +675,20 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 	struct rcar_pcie *pcie = &host->pcie;
 	struct device *dev = pcie->dev;
 	struct rcar_msi *msi = &host->msi;
-	int err, i;
-
-	mutex_init(&msi->lock);
+	unsigned long base;
+	int err;
 
-	msi->chip.dev = dev;
-	msi->chip.setup_irq = rcar_msi_setup_irq;
-	msi->chip.setup_irqs = rcar_msi_setup_irqs;
-	msi->chip.teardown_irq = rcar_msi_teardown_irq;
+	mutex_init(&msi->map_lock);
+	spin_lock_init(&msi->mask_lock);
 
-	msi->domain = irq_domain_add_linear(dev->of_node, INT_PCI_MSI_NR,
-					    &msi_domain_ops, &msi->chip);
-	if (!msi->domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < INT_PCI_MSI_NR; i++)
-		irq_create_mapping(msi->domain, i);
+	err = rcar_allocate_domains(msi);
+	if (err)
+		return err;
 
 	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
 	err = devm_request_irq(dev, msi->irq1, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-			       rcar_msi_irq_chip.name, host);
+			       rcar_msi_bottom_chip.name, host);
 	if (err < 0) {
 		dev_err(dev, "failed to request IRQ: %d\n", err);
 		goto err;
@@ -728,27 +696,31 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 
 	err = devm_request_irq(dev, msi->irq2, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-			       rcar_msi_irq_chip.name, host);
+			       rcar_msi_bottom_chip.name, host);
 	if (err < 0) {
 		dev_err(dev, "failed to request IRQ: %d\n", err);
 		goto err;
 	}
 
-	/* setup MSI data target */
-	msi->pages = __get_free_pages(GFP_KERNEL, 0);
-	rcar_pcie_hw_enable_msi(host);
+	/* disable all MSIs */
+	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
+
+	/* setup MSI data target using the msi structure address */
+	base = virt_to_phys(&host->msi);
+
+	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
+	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
 
 	return 0;
 
 err:
-	rcar_pcie_unmap_msi(host);
+	rcar_free_domains(msi);
 	return err;
 }
 
 static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
 {
 	struct rcar_pcie *pcie = &host->pcie;
-	struct rcar_msi *msi = &host->msi;
 
 	/* Disable all MSI interrupts */
 	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
@@ -756,9 +728,7 @@ static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
 	/* Disable address decoding of the MSI interrupt, MSIFE */
 	rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
 
-	free_pages(msi->pages, 0);
-
-	rcar_pcie_unmap_msi(host);
+	rcar_free_domains(&host->msi);
 }
 
 static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
@@ -1012,7 +982,7 @@ static int __maybe_unused rcar_pcie_resume(struct device *dev)
 
 	/* Enable MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rcar_pcie_hw_enable_msi(host);
+		rcar_pcie_enable_msi(host);
 
 	rcar_pcie_hw_enable(host);
 
-- 
2.29.2

