Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B434EBBA
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Mar 2021 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhC3PM0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Mar 2021 11:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232240AbhC3PL5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Mar 2021 11:11:57 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EF6619CF;
        Tue, 30 Mar 2021 15:11:56 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lRG27-004i6i-5P; Tue, 30 Mar 2021 16:11:55 +0100
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
Subject: [PATCH v3 05/14] PCI: xilinx: Convert to MSI domains
Date:   Tue, 30 Mar 2021 16:11:36 +0100
Message-Id: <20210330151145.997953-6-maz@kernel.org>
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
the ancient xilinx host controller driver to MSI domains.

We end-up with the usual two domain structure, the top one being a
generic PCI/MSI domain, the bottom one being xilinx-specific and handling
the actual HW interrupt allocation.

This allows us to fix some of the most appaling MSI programming, where
the message programmed in the device is the virtual IRQ number instead
of the allocated vector number. The allocator is also made safe with
a mutex. This should allow support for MultiMSI, but I decided not to
even try, since I cannot test it.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Bharat Kumar Gogada <bharatku@xilinx.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/Kconfig       |   2 +-
 drivers/pci/controller/pcie-xilinx.c | 242 ++++++++++++---------------
 2 files changed, 106 insertions(+), 138 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 5cc07d28a3a0..60045f7aafc5 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -86,7 +86,7 @@ config PCI_HOST_GENERIC
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
 	depends on OF || COMPILE_TEST
-	select PCI_MSI_ARCH_FALLBACKS
+	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index e127a7b6e535..14001febf59a 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -93,23 +93,23 @@
 /**
  * struct xilinx_pcie_port - PCIe port information
  * @reg_base: IO Mapped Register Base
- * @irq: Interrupt number
  * @dev: Device pointer
+ * @msi_map: Bitmap of allocated MSIs
+ * @map_lock: Mutex protecting the MSI allocation
  * @msi_domain: MSI IRQ domain pointer
  * @leg_domain: Legacy IRQ domain pointer
  * @resources: Bus Resources
  */
 struct xilinx_pcie_port {
 	void __iomem *reg_base;
-	u32 irq;
 	struct device *dev;
+	unsigned long msi_map[BITS_TO_LONGS(XILINX_NUM_MSI_IRQS)];
+	struct mutex map_lock;
 	struct irq_domain *msi_domain;
 	struct irq_domain *leg_domain;
 	struct list_head resources;
 };
 
-static DECLARE_BITMAP(msi_irq_in_use, XILINX_NUM_MSI_IRQS);
-
 static inline u32 pcie_read(struct xilinx_pcie_port *port, u32 reg)
 {
 	return readl(port->reg_base + reg);
@@ -194,145 +194,116 @@ static struct pci_ops xilinx_pcie_ops = {
 
 /* MSI functions */
 
-/**
- * xilinx_pcie_destroy_msi - Free MSI number
- * @irq: IRQ to be freed
- */
-static void xilinx_pcie_destroy_msi(unsigned int irq)
+static void xilinx_msi_top_irq_ack(struct irq_data *d)
 {
-	struct msi_desc *msi;
-	struct xilinx_pcie_port *port;
-	struct irq_data *d = irq_get_irq_data(irq);
-	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-
-	if (!test_bit(hwirq, msi_irq_in_use)) {
-		msi = irq_get_msi_desc(irq);
-		port = msi_desc_to_pci_sysdata(msi);
-		dev_err(port->dev, "Trying to free unused MSI#%d\n", irq);
-	} else {
-		clear_bit(hwirq, msi_irq_in_use);
-	}
+	/*
+	 * xilinx_pcie_intr_handler() will have performed the Ack.
+	 * Eventually, this should be fixed and the Ack be moved in
+	 * the respective callbacks for INTx and MSI.
+	 */
 }
 
-/**
- * xilinx_pcie_assign_msi - Allocate MSI number
- *
- * Return: A valid IRQ on success and error value on failure.
- */
-static int xilinx_pcie_assign_msi(void)
-{
-	int pos;
-
-	pos = find_first_zero_bit(msi_irq_in_use, XILINX_NUM_MSI_IRQS);
-	if (pos < XILINX_NUM_MSI_IRQS)
-		set_bit(pos, msi_irq_in_use);
-	else
-		return -ENOSPC;
+static struct irq_chip xilinx_msi_top_chip = {
+	.name		= "PCIe MSI",
+	.irq_ack	= xilinx_msi_top_irq_ack,
+};
 
-	return pos;
+static int xilinx_msi_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
 }
 
-/**
- * xilinx_msi_teardown_irq - Destroy the MSI
- * @chip: MSI Chip descriptor
- * @irq: MSI IRQ to destroy
- */
-static void xilinx_msi_teardown_irq(struct msi_controller *chip,
-				    unsigned int irq)
+static void xilinx_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	xilinx_pcie_destroy_msi(irq);
-	irq_dispose_mapping(irq);
+	struct xilinx_pcie_port *pcie = irq_data_get_irq_chip_data(data);
+	phys_addr_t pa = ALIGN_DOWN(virt_to_phys(pcie), SZ_4K);
+
+	msg->address_lo = lower_32_bits(pa);
+	msg->address_hi = upper_32_bits(pa);
+	msg->data = data->hwirq;
 }
 
-/**
- * xilinx_pcie_msi_setup_irq - Setup MSI request
- * @chip: MSI chip pointer
- * @pdev: PCIe device pointer
- * @desc: MSI descriptor pointer
- *
- * Return: '0' on success and error value on failure
- */
-static int xilinx_pcie_msi_setup_irq(struct msi_controller *chip,
-				     struct pci_dev *pdev,
-				     struct msi_desc *desc)
+static struct irq_chip xilinx_msi_bottom_chip = {
+	.name			= "Xilinx MSI",
+	.irq_set_affinity 	= xilinx_msi_set_affinity,
+	.irq_compose_msi_msg	= xilinx_compose_msi_msg,
+};
+
+static int xilinx_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *args)
 {
-	struct xilinx_pcie_port *port = pdev->bus->sysdata;
-	unsigned int irq;
-	int hwirq;
-	struct msi_msg msg;
-	phys_addr_t msg_addr;
+	struct xilinx_pcie_port *port = domain->host_data;
+	int hwirq, i;
+
+	mutex_lock(&port->map_lock);
+
+	hwirq = bitmap_find_free_region(port->msi_map, XILINX_NUM_MSI_IRQS, order_base_2(nr_irqs));
+
+	mutex_unlock(&port->map_lock);
 
-	hwirq = xilinx_pcie_assign_msi();
 	if (hwirq < 0)
-		return hwirq;
+		return -ENOSPC;
 
-	irq = irq_create_mapping(port->msi_domain, hwirq);
-	if (!irq)
-		return -EINVAL;
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &xilinx_msi_bottom_chip, domain->host_data,
+				    handle_edge_irq, NULL, NULL);
 
-	irq_set_msi_desc(irq, desc);
+	return 0;
+}
 
-	msg_addr = ALIGN_DOWN(virt_to_phys(port), SZ_4K);
+static void xilinx_msi_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct xilinx_pcie_port *port = domain->host_data;
 
-	msg.address_hi = upper_32_bits(msg_addr);
-	msg.address_lo = lower_32_bits(msg_addr);
-	msg.data = irq;
+	mutex_lock(&port->map_lock);
 
-	pci_write_msi_msg(irq, &msg);
+	bitmap_release_region(port->msi_map, d->hwirq, order_base_2(nr_irqs));
 
-	return 0;
+	mutex_unlock(&port->map_lock);
 }
 
-/* MSI Chip Descriptor */
-static struct msi_controller xilinx_pcie_msi_chip = {
-	.setup_irq = xilinx_pcie_msi_setup_irq,
-	.teardown_irq = xilinx_msi_teardown_irq,
+static const struct irq_domain_ops xilinx_msi_domain_ops = {
+	.alloc	= xilinx_msi_domain_alloc,
+	.free	= xilinx_msi_domain_free,
 };
 
-/* HW Interrupt Chip Descriptor */
-static struct irq_chip xilinx_msi_irq_chip = {
-	.name = "Xilinx PCIe MSI",
-	.irq_enable = pci_msi_unmask_irq,
-	.irq_disable = pci_msi_mask_irq,
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
+static struct msi_domain_info xilinx_msi_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.chip	= &xilinx_msi_top_chip,
 };
 
-/**
- * xilinx_pcie_msi_map - Set the handler for the MSI and mark IRQ as valid
- * @domain: IRQ domain
- * @irq: Virtual IRQ number
- * @hwirq: HW interrupt number
- *
- * Return: Always returns 0.
- */
-static int xilinx_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
-			       irq_hw_number_t hwirq)
+static int xilinx_allocate_msi_domains(struct xilinx_pcie_port *pcie)
 {
-	irq_set_chip_and_handler(irq, &xilinx_msi_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
+	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
+	struct irq_domain *parent;
+
+	parent = irq_domain_create_linear(fwnode, XILINX_NUM_MSI_IRQS,
+					  &xilinx_msi_domain_ops, pcie);
+	if (!parent) {
+		dev_err(pcie->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
+
+	pcie->msi_domain = pci_msi_create_irq_domain(fwnode, &xilinx_msi_info, parent);
+	if (!pcie->msi_domain) {
+		dev_err(pcie->dev, "failed to create MSI domain\n");
+		irq_domain_remove(parent);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
 
-/* IRQ Domain operations */
-static const struct irq_domain_ops msi_domain_ops = {
-	.map = xilinx_pcie_msi_map,
-};
-
-/**
- * xilinx_pcie_enable_msi - Enable MSI support
- * @port: PCIe port information
- */
-static int xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
+static void xilinx_free_msi_domains(struct xilinx_pcie_port *pcie)
 {
-	phys_addr_t msg_addr;
-
-	msg_addr = ALIGN_DOWN(virt_to_phys(port), SZ_4K);
-	pcie_write(port, upper_32_bits(msg_addr), XILINX_PCIE_REG_MSIBASE1);
-	pcie_write(port, lower_32_bits(msg_addr), XILINX_PCIE_REG_MSIBASE2);
+	struct irq_domain *parent = pcie->msi_domain->parent;
 
-	return 0;
+	irq_domain_remove(pcie->msi_domain);
+	irq_domain_remove(parent);
 }
 
 /* INTx Functions */
@@ -414,6 +385,8 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 	}
 
 	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
+		unsigned int irq;
+
 		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
 
 		/* Check whether interrupt valid */
@@ -426,20 +399,19 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
 			val = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
 				XILINX_PCIE_RPIFR2_MSG_DATA;
+			irq = irq_find_mapping(port->msi_domain->parent, val);
 		} else {
 			val = (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT;
-			val = irq_find_mapping(port->leg_domain, val);
+			irq = irq_find_mapping(port->leg_domain, val);
 		}
 
 		/* Clear interrupt FIFO register 1 */
 		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
 			   XILINX_PCIE_REG_RPIFR1);
 
-		/* Handle the interrupt */
-		if (IS_ENABLED(CONFIG_PCI_MSI) ||
-		    !(val & XILINX_PCIE_RPIFR1_MSI_INTR))
-			generic_handle_irq(val);
+		if (irq)
+			generic_handle_irq(irq);
 	}
 
 	if (status & XILINX_PCIE_INTR_SLV_UNSUPP)
@@ -485,12 +457,11 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 {
 	struct device *dev = port->dev;
-	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node;
 	int ret;
 
 	/* Setup INTx */
-	pcie_intc_node = of_get_next_child(node, NULL);
+	pcie_intc_node = of_get_next_child(dev->of_node, NULL);
 	if (!pcie_intc_node) {
 		dev_err(dev, "No PCIe Intc node found\n");
 		return -ENODEV;
@@ -507,18 +478,14 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 
 	/* Setup MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		port->msi_domain = irq_domain_add_linear(node,
-							 XILINX_NUM_MSI_IRQS,
-							 &msi_domain_ops,
-							 &xilinx_pcie_msi_chip);
-		if (!port->msi_domain) {
-			dev_err(dev, "Failed to get a MSI IRQ domain\n");
-			return -ENODEV;
-		}
+		phys_addr_t pa = ALIGN_DOWN(virt_to_phys(port), SZ_4K);
 
-		ret = xilinx_pcie_enable_msi(port);
+		ret = xilinx_allocate_msi_domains(port);
 		if (ret)
 			return ret;
+
+		pcie_write(port, upper_32_bits(pa), XILINX_PCIE_REG_MSIBASE1);
+		pcie_write(port, lower_32_bits(pa), XILINX_PCIE_REG_MSIBASE2);
 	}
 
 	return 0;
@@ -566,6 +533,7 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
 	struct resource regs;
+	unsigned int irq;
 	int err;
 
 	err = of_address_to_resource(node, 0, &regs);
@@ -578,12 +546,12 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
 	if (IS_ERR(port->reg_base))
 		return PTR_ERR(port->reg_base);
 
-	port->irq = irq_of_parse_and_map(node, 0);
-	err = devm_request_irq(dev, port->irq, xilinx_pcie_intr_handler,
+	irq = irq_of_parse_and_map(node, 0);
+	err = devm_request_irq(dev, irq, xilinx_pcie_intr_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       "xilinx-pcie", port);
 	if (err) {
-		dev_err(dev, "unable to request irq %d\n", port->irq);
+		dev_err(dev, "unable to request irq %d\n", irq);
 		return err;
 	}
 
@@ -611,7 +579,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	port = pci_host_bridge_priv(bridge);
-
+	mutex_init(&port->map_lock);
 	port->dev = dev;
 
 	err = xilinx_pcie_parse_dt(port);
@@ -631,11 +599,11 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = port;
 	bridge->ops = &xilinx_pcie_ops;
 
-#ifdef CONFIG_PCI_MSI
-	xilinx_pcie_msi_chip.dev = dev;
-	bridge->msi = &xilinx_pcie_msi_chip;
-#endif
-	return pci_host_probe(bridge);
+	err = pci_host_probe(bridge);
+	if (err)
+		xilinx_free_msi_domains(port);
+
+	return err;
 }
 
 static const struct of_device_id xilinx_pcie_of_match[] = {
-- 
2.29.2

