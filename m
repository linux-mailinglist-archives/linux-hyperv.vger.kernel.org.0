Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6052D34EBBD
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Mar 2021 17:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhC3PM1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Mar 2021 11:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhC3PLz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Mar 2021 11:11:55 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D24C5619CE;
        Tue, 30 Mar 2021 15:11:54 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lRG25-004i6i-4a; Tue, 30 Mar 2021 16:11:53 +0100
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
Subject: [PATCH v3 03/14] PCI: rcar: Convert to MSI domains
Date:   Tue, 30 Mar 2021 16:11:34 +0100
Message-Id: <20210330151145.997953-4-maz@kernel.org>
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
the Rcar host controller driver to MSI domains.

We end-up with the usual two domain structure, the top one being a
generic PCI/MSI domain, the bottom one being Rcar-specific and handling
the actual HW interrupt allocation.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/Kconfig          |   1 -
 drivers/pci/controller/pcie-rcar-host.c | 352 ++++++++++++------------
 2 files changed, 170 insertions(+), 183 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index be8f9ff512a0..5cc07d28a3a0 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -58,7 +58,6 @@ config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
-	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
 	  mode.
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index ce952403e22c..f7331ad0d6dc 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -35,17 +35,12 @@
 struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
-	struct msi_controller chip;
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
@@ -55,6 +50,11 @@ struct rcar_pcie_host {
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
@@ -291,8 +291,6 @@ static int rcar_pcie_enable(struct rcar_pcie_host *host)
 
 	bridge->sysdata = host;
 	bridge->ops = &rcar_pcie_ops;
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		bridge->msi = &host->msi.chip;
 
 	return pci_host_probe(bridge);
 }
@@ -472,42 +470,6 @@ static int rcar_pcie_phy_init_gen3(struct rcar_pcie_host *host)
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
@@ -526,18 +488,13 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
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
@@ -547,150 +504,170 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
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
 
-	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
-	msg.data = hwirq;
+static void rcar_msi_irq_ack(struct irq_data *d)
+{
+	struct rcar_msi *msi = irq_data_get_irq_chip_data(d);
+	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
 
-	pci_write_msi_msg(irq, &msg);
+	/* clear the interrupt */
+	rcar_pci_write_reg(pcie, BIT(d->hwirq), PCIEMSIFR);
+}
 
-	return 0;
+static void rcar_msi_irq_mask(struct irq_data *d)
+{
+	struct rcar_msi *msi = irq_data_get_irq_chip_data(d);
+	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
+	unsigned long flags;
+	u32 value;
+
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
+
+	spin_lock_irqsave(&msi->mask_lock, flags);
+	value = rcar_pci_read_reg(pcie, PCIEMSIIER);
+	value |= BIT(d->hwirq);
+	rcar_pci_write_reg(pcie, value, PCIEMSIIER);
+	spin_unlock_irqrestore(&msi->mask_lock, flags);
+}
 
-	/* MSI-X interrupts are not supported */
-	if (type == PCI_CAP_ID_MSIX)
-		return -EINVAL;
+static int rcar_msi_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
 
-	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
-	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
+static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct rcar_msi *msi = irq_data_get_irq_chip_data(data);
+	unsigned long pa = virt_to_phys(msi);
 
-	hwirq = rcar_msi_alloc_region(msi, nvec);
-	if (hwirq < 0)
-		return -ENOSPC;
+	/* Use the msi structure as the PA for the MSI doorbell */
+	msg->address_lo = lower_32_bits(pa);
+	msg->address_hi = upper_32_bits(pa);
+	msg->data = data->hwirq;
+}
 
-	irq = irq_find_mapping(msi->domain, hwirq);
-	if (!irq)
-		return -ENOSPC;
+static struct irq_chip rcar_msi_bottom_chip = {
+	.name			= "Rcar MSI",
+	.irq_ack		= rcar_msi_irq_ack,
+	.irq_mask		= rcar_msi_irq_mask,
+	.irq_unmask		= rcar_msi_irq_unmask,
+	.irq_set_affinity 	= rcar_msi_set_affinity,
+	.irq_compose_msi_msg	= rcar_compose_msi_msg,
+};
 
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
+static int rcar_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *args)
+{
+	struct rcar_msi *msi = domain->host_data;
+	unsigned int i;
+	int hwirq;
+
+	mutex_lock(&msi->map_lock);
 
-	desc->nvec_used = nvec;
-	desc->msi_attrib.multiple = order_base_2(nvec);
+	hwirq = bitmap_find_free_region(msi->used, INT_PCI_MSI_NR, order_base_2(nr_irqs));
 
-	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
-	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
-	msg.data = hwirq;
+	mutex_unlock(&msi->map_lock);
+
+	if (hwirq < 0)
+		return -ENOSPC;
 
-	pci_write_msi_msg(irq, &msg);
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
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct rcar_msi *msi = domain->host_data;
 
-	rcar_msi_free(msi, d->hwirq);
-}
-
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
+};
+
+static struct msi_domain_info rcar_msi_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_MULTI_PCI_MSI),
+	.chip	= &rcar_msi_top_chip,
 };
 
-static void rcar_pcie_unmap_msi(struct rcar_pcie_host *host)
+static int rcar_allocate_domains(struct rcar_msi *msi)
 {
-	struct rcar_msi *msi = &host->msi;
-	int i, irq;
+	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
+	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
+	struct irq_domain *parent;
+
+	parent = irq_domain_create_linear(fwnode, INT_PCI_MSI_NR,
+					  &rcar_msi_domain_ops, msi);
+	if (!parent) {
+		dev_err(pcie->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
 
-	for (i = 0; i < INT_PCI_MSI_NR; i++) {
-		irq = irq_find_mapping(msi->domain, i);
-		if (irq > 0)
-			irq_dispose_mapping(irq);
+	msi->domain = pci_msi_create_irq_domain(fwnode, &rcar_msi_info, parent);
+	if (!msi->domain) {
+		dev_err(pcie->dev, "failed to create MSI domain\n");
+		irq_domain_remove(parent);
+		return -ENOMEM;
 	}
 
-	irq_domain_remove(msi->domain);
+	return 0;
 }
 
-static void rcar_pcie_hw_enable_msi(struct rcar_pcie_host *host)
+static void rcar_free_domains(struct rcar_msi *msi)
 {
-	struct rcar_pcie *pcie = &host->pcie;
-	struct device *dev = pcie->dev;
-	struct resource res;
+	struct irq_domain *parent = msi->domain->parent;
 
-	if (WARN_ON(of_address_to_resource(dev->of_node, 0, &res)))
-		return;
-
-	/* setup MSI data target */
-	rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
-
-	/* enable all MSI interrupts */
-	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
+	irq_domain_remove(msi->domain);
+	irq_domain_remove(parent);
 }
 
 static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
@@ -698,29 +675,24 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 	struct rcar_pcie *pcie = &host->pcie;
 	struct device *dev = pcie->dev;
 	struct rcar_msi *msi = &host->msi;
-	int err, i;
-
-	mutex_init(&msi->lock);
+	struct resource res;
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
+	err = of_address_to_resource(dev->of_node, 0, &res);
+	if (err)
+		return err;
 
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
@@ -728,19 +700,26 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 
 	err = devm_request_irq(dev, msi->irq2, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-			       rcar_msi_irq_chip.name, host);
+			       rcar_msi_bottom_chip.name, host);
 	if (err < 0) {
 		dev_err(dev, "failed to request IRQ: %d\n", err);
 		goto err;
 	}
 
-	/* setup MSI data target */
-	rcar_pcie_hw_enable_msi(host);
+	/* disable all MSIs */
+	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
+
+	/*
+	 * Setup MSI data target using RC base address address, which
+	 * is guaranteed to be in the low 32bit range on any RCar HW.
+	 */
+	rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE, PCIEMSIALR);
+	rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
 
 	return 0;
 
 err:
-	rcar_pcie_unmap_msi(host);
+	rcar_free_domains(msi);
 	return err;
 }
 
@@ -754,7 +733,7 @@ static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
 	/* Disable address decoding of the MSI interrupt, MSIFE */
 	rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
 
-	rcar_pcie_unmap_msi(host);
+	rcar_free_domains(&host->msi);
 }
 
 static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
@@ -1007,8 +986,17 @@ static int __maybe_unused rcar_pcie_resume(struct device *dev)
 	dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
 
 	/* Enable MSI */
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rcar_pcie_hw_enable_msi(host);
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		struct resource res;
+		u32 val;
+
+		of_address_to_resource(dev->of_node, 0, &res);
+		rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
+		rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE, PCIEMSIALR);
+
+		bitmap_to_arr32(&val, host->msi.used, INT_PCI_MSI_NR);
+		rcar_pci_write_reg(pcie, val, PCIEMSIIER);
+	}
 
 	rcar_pcie_hw_enable(host);
 
-- 
2.29.2

