Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E13440D8
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 13:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCVMYA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 08:24:00 -0400
Received: from foss.arm.com ([217.140.110.172]:58544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhCVMXV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 08:23:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 827931063;
        Mon, 22 Mar 2021 05:23:20 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 812573F718;
        Mon, 22 Mar 2021 05:23:17 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:23:15 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Frank Wunderlich <frank-w@public-files.de>,
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
Subject: Re: [PATCH 03/13] PCI: xilinx: Convert to MSI domains
Message-ID: <20210322122315.GB11469@e121166-lin.cambridge.arm.com>
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225151023.3642391-4-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 25, 2021 at 03:10:13PM +0000, Marc Zyngier wrote:
> In anticipation of the removal of the msi_controller structure, convert
> the ancient xilinx host controller driver to MSI domains.
> 
> We end-up with the usual two domain structure, the top one being a
> generic PCI/MSI domain, the bottom one being xilinx-specific and handling
> the actual HW interrupt allocation.
> 
> This allows us to fix some of the most appaling MSI programming, where
> the message programmed in the device is the virtual IRQ number instead
> of the allocated vector number. The allocator is also made safe with
> a mutex. This should allow support for MultiMSI, but I decided not to
> even try, since I cannot test it.
> 
> Also take the opportunity to get rid of the cargo-culted memory allocation
> for the MSI capture address. *ANY* sufficiently aligned address should
> be good enough, so use the physical address of the xilinx_pcie_host
> structure instead.

I'd agree with Bjorn that the MSI doorbell change is better split into
a separate patch, I can do it myself at merge if you agree.

Thanks,
Lorenzo

> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/Kconfig       |   2 +-
>  drivers/pci/controller/pcie-xilinx.c | 238 +++++++++++----------------
>  2 files changed, 96 insertions(+), 144 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index ccbf034512d6..049c60016904 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -95,7 +95,7 @@ config PCI_HOST_GENERIC
>  config PCIE_XILINX
>  	bool "Xilinx AXI PCIe host bridge support"
>  	depends on OF || COMPILE_TEST
> -	select PCI_MSI_ARCH_FALLBACKS
> +	depends on PCI_MSI_IRQ_DOMAIN
>  	help
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index fa5baeb82653..ad9abf405167 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -93,25 +93,23 @@
>  /**
>   * struct xilinx_pcie_port - PCIe port information
>   * @reg_base: IO Mapped Register Base
> - * @irq: Interrupt number
> - * @msi_pages: MSI pages
>   * @dev: Device pointer
> + * @msi_map: Bitmap of allocated MSIs
> + * @map_lock: Mutex protecting the MSI allocation
>   * @msi_domain: MSI IRQ domain pointer
>   * @leg_domain: Legacy IRQ domain pointer
>   * @resources: Bus Resources
>   */
>  struct xilinx_pcie_port {
>  	void __iomem *reg_base;
> -	u32 irq;
> -	unsigned long msi_pages;
>  	struct device *dev;
> +	unsigned long msi_map[BITS_TO_LONGS(XILINX_NUM_MSI_IRQS)];
> +	struct mutex map_lock;
>  	struct irq_domain *msi_domain;
>  	struct irq_domain *leg_domain;
>  	struct list_head resources;
>  };
>  
> -static DECLARE_BITMAP(msi_irq_in_use, XILINX_NUM_MSI_IRQS);
> -
>  static inline u32 pcie_read(struct xilinx_pcie_port *port, u32 reg)
>  {
>  	return readl(port->reg_base + reg);
> @@ -196,151 +194,108 @@ static struct pci_ops xilinx_pcie_ops = {
>  
>  /* MSI functions */
>  
> -/**
> - * xilinx_pcie_destroy_msi - Free MSI number
> - * @irq: IRQ to be freed
> - */
> -static void xilinx_pcie_destroy_msi(unsigned int irq)
> +static struct irq_chip xilinx_msi_top_chip = {
> +	.name		= "PCIe MSI",
> +};
> +
> +static int xilinx_msi_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
>  {
> -	struct msi_desc *msi;
> -	struct xilinx_pcie_port *port;
> -	struct irq_data *d = irq_get_irq_data(irq);
> -	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> -
> -	if (!test_bit(hwirq, msi_irq_in_use)) {
> -		msi = irq_get_msi_desc(irq);
> -		port = msi_desc_to_pci_sysdata(msi);
> -		dev_err(port->dev, "Trying to free unused MSI#%d\n", irq);
> -	} else {
> -		clear_bit(hwirq, msi_irq_in_use);
> -	}
> +	return -EINVAL;
>  }
>  
> -/**
> - * xilinx_pcie_assign_msi - Allocate MSI number
> - *
> - * Return: A valid IRQ on success and error value on failure.
> - */
> -static int xilinx_pcie_assign_msi(void)
> +static void xilinx_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
> -	int pos;
> +	struct xilinx_pcie_port *pcie = irq_data_get_irq_chip_data(data);
> +	phys_addr_t pa = virt_to_phys(pcie);
>  
> -	pos = find_first_zero_bit(msi_irq_in_use, XILINX_NUM_MSI_IRQS);
> -	if (pos < XILINX_NUM_MSI_IRQS)
> -		set_bit(pos, msi_irq_in_use);
> -	else
> -		return -ENOSPC;
> -
> -	return pos;
> +	msg->address_lo = lower_32_bits(pa);
> +	msg->address_hi = upper_32_bits(pa);
> +	msg->data = data->hwirq;
>  }
>  
> -/**
> - * xilinx_msi_teardown_irq - Destroy the MSI
> - * @chip: MSI Chip descriptor
> - * @irq: MSI IRQ to destroy
> - */
> -static void xilinx_msi_teardown_irq(struct msi_controller *chip,
> -				    unsigned int irq)
> -{
> -	xilinx_pcie_destroy_msi(irq);
> -	irq_dispose_mapping(irq);
> -}
> +static struct irq_chip xilinx_msi_bottom_chip = {
> +	.name			= "Xilinx MSI",
> +	.irq_set_affinity 	= xilinx_msi_set_affinity,
> +	.irq_compose_msi_msg	= xilinx_compose_msi_msg,
> +};
>  
> -/**
> - * xilinx_pcie_msi_setup_irq - Setup MSI request
> - * @chip: MSI chip pointer
> - * @pdev: PCIe device pointer
> - * @desc: MSI descriptor pointer
> - *
> - * Return: '0' on success and error value on failure
> - */
> -static int xilinx_pcie_msi_setup_irq(struct msi_controller *chip,
> -				     struct pci_dev *pdev,
> -				     struct msi_desc *desc)
> +static int xilinx_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				  unsigned int nr_irqs, void *args)
>  {
> -	struct xilinx_pcie_port *port = pdev->bus->sysdata;
> -	unsigned int irq;
> -	int hwirq;
> -	struct msi_msg msg;
> -	phys_addr_t msg_addr;
> +	struct xilinx_pcie_port *port = domain->host_data;
> +	int hwirq, i;
>  
> -	hwirq = xilinx_pcie_assign_msi();
> -	if (hwirq < 0)
> -		return hwirq;
> -
> -	irq = irq_create_mapping(port->msi_domain, hwirq);
> -	if (!irq)
> -		return -EINVAL;
> +	mutex_lock(&port->map_lock);
>  
> -	irq_set_msi_desc(irq, desc);
> +	hwirq = bitmap_find_free_region(port->msi_map, XILINX_NUM_MSI_IRQS, order_base_2(nr_irqs));
>  
> -	msg_addr = virt_to_phys((void *)port->msi_pages);
> +	mutex_unlock(&port->map_lock);
>  
> -	msg.address_hi = 0;
> -	msg.address_lo = msg_addr;
> -	msg.data = irq;
> +	if (hwirq < 0)
> +		return -ENOSPC;
>  
> -	pci_write_msi_msg(irq, &msg);
> +	for (i = 0; i < nr_irqs; i++)
> +		irq_domain_set_info(domain, virq + i, hwirq + i,
> +				    &xilinx_msi_bottom_chip, domain->host_data,
> +				    handle_edge_irq, NULL, NULL);
>  
>  	return 0;
>  }
>  
> -/* MSI Chip Descriptor */
> -static struct msi_controller xilinx_pcie_msi_chip = {
> -	.setup_irq = xilinx_pcie_msi_setup_irq,
> -	.teardown_irq = xilinx_msi_teardown_irq,
> -};
> +static void xilinx_msi_domain_free(struct irq_domain *domain, unsigned int virq,
> +				  unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct xilinx_pcie_port *port = domain->host_data;
>  
> -/* HW Interrupt Chip Descriptor */
> -static struct irq_chip xilinx_msi_irq_chip = {
> -	.name = "Xilinx PCIe MSI",
> -	.irq_enable = pci_msi_unmask_irq,
> -	.irq_disable = pci_msi_mask_irq,
> -	.irq_mask = pci_msi_mask_irq,
> -	.irq_unmask = pci_msi_unmask_irq,
> -};
> +	mutex_lock(&port->map_lock);
>  
> -/**
> - * xilinx_pcie_msi_map - Set the handler for the MSI and mark IRQ as valid
> - * @domain: IRQ domain
> - * @irq: Virtual IRQ number
> - * @hwirq: HW interrupt number
> - *
> - * Return: Always returns 0.
> - */
> -static int xilinx_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> -			       irq_hw_number_t hwirq)
> -{
> -	irq_set_chip_and_handler(irq, &xilinx_msi_irq_chip, handle_simple_irq);
> -	irq_set_chip_data(irq, domain->host_data);
> +	bitmap_release_region(port->msi_map, d->hwirq, order_base_2(nr_irqs));
>  
> -	return 0;
> +	mutex_unlock(&port->map_lock);
>  }
>  
> -/* IRQ Domain operations */
> -static const struct irq_domain_ops msi_domain_ops = {
> -	.map = xilinx_pcie_msi_map,
> +static const struct irq_domain_ops xilinx_msi_domain_ops = {
> +	.alloc	= xilinx_msi_domain_alloc,
> +	.free	= xilinx_msi_domain_free,
>  };
>  
> -/**
> - * xilinx_pcie_enable_msi - Enable MSI support
> - * @port: PCIe port information
> - */
> -static int xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
> +static struct msi_domain_info xilinx_msi_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
> +	.chip	= &xilinx_msi_top_chip,
> +};
> +
> +static int xilinx_allocate_msi_domains(struct xilinx_pcie_port *pcie)
>  {
> -	phys_addr_t msg_addr;
> +	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
> +	struct irq_domain *parent;
>  
> -	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
> -	if (!port->msi_pages)
> +	parent = irq_domain_create_linear(fwnode, XILINX_NUM_MSI_IRQS,
> +					  &xilinx_msi_domain_ops, pcie);
> +	if (!parent) {
> +		dev_err(pcie->dev, "failed to create IRQ domain\n");
>  		return -ENOMEM;
> +	}
> +	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
>  
> -	msg_addr = virt_to_phys((void *)port->msi_pages);
> -	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
> -	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
> +	pcie->msi_domain = pci_msi_create_irq_domain(fwnode, &xilinx_msi_info, parent);
> +	if (!pcie->msi_domain) {
> +		dev_err(pcie->dev, "failed to create MSI domain\n");
> +		irq_domain_remove(parent);
> +		return -ENOMEM;
> +	}
>  
>  	return 0;
>  }
>  
> +static void xilinx_free_msi_domains(struct xilinx_pcie_port *pcie)
> +{
> +	struct irq_domain *parent = pcie->msi_domain->parent;
> +
> +	irq_domain_remove(pcie->msi_domain);
> +	irq_domain_remove(parent);
> +}
> +
>  /* INTx Functions */
>  
>  /**
> @@ -420,6 +375,8 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>  	}
>  
>  	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
> +		unsigned int irq;
> +
>  		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
>  
>  		/* Check whether interrupt valid */
> @@ -432,20 +389,19 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>  		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
>  			val = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
>  				XILINX_PCIE_RPIFR2_MSG_DATA;
> +			irq = irq_find_mapping(port->msi_domain->parent, val);
>  		} else {
>  			val = (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
>  				XILINX_PCIE_RPIFR1_INTR_SHIFT;
> -			val = irq_find_mapping(port->leg_domain, val);
> +			irq = irq_find_mapping(port->leg_domain, val);
>  		}
>  
>  		/* Clear interrupt FIFO register 1 */
>  		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
>  			   XILINX_PCIE_REG_RPIFR1);
>  
> -		/* Handle the interrupt */
> -		if (IS_ENABLED(CONFIG_PCI_MSI) ||
> -		    !(val & XILINX_PCIE_RPIFR1_MSI_INTR))
> -			generic_handle_irq(val);
> +		if (irq)
> +			generic_handle_irq(irq);
>  	}
>  
>  	if (status & XILINX_PCIE_INTR_SLV_UNSUPP)
> @@ -491,12 +447,11 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>  static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  {
>  	struct device *dev = port->dev;
> -	struct device_node *node = dev->of_node;
>  	struct device_node *pcie_intc_node;
>  	int ret;
>  
>  	/* Setup INTx */
> -	pcie_intc_node = of_get_next_child(node, NULL);
> +	pcie_intc_node = of_get_next_child(dev->of_node, NULL);
>  	if (!pcie_intc_node) {
>  		dev_err(dev, "No PCIe Intc node found\n");
>  		return -ENODEV;
> @@ -513,18 +468,14 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  
>  	/* Setup MSI */
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		port->msi_domain = irq_domain_add_linear(node,
> -							 XILINX_NUM_MSI_IRQS,
> -							 &msi_domain_ops,
> -							 &xilinx_pcie_msi_chip);
> -		if (!port->msi_domain) {
> -			dev_err(dev, "Failed to get a MSI IRQ domain\n");
> -			return -ENODEV;
> -		}
> +		phys_addr_t pa = virt_to_phys(port);
>  
> -		ret = xilinx_pcie_enable_msi(port);
> +		ret = xilinx_allocate_msi_domains(port);
>  		if (ret)
>  			return ret;
> +
> +		pcie_write(port, upper_32_bits(pa), XILINX_PCIE_REG_MSIBASE1);
> +		pcie_write(port, lower_32_bits(pa), XILINX_PCIE_REG_MSIBASE2);
>  	}
>  
>  	return 0;
> @@ -572,6 +523,7 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
>  	struct device *dev = port->dev;
>  	struct device_node *node = dev->of_node;
>  	struct resource regs;
> +	unsigned int irq;
>  	int err;
>  
>  	err = of_address_to_resource(node, 0, &regs);
> @@ -584,12 +536,12 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
>  	if (IS_ERR(port->reg_base))
>  		return PTR_ERR(port->reg_base);
>  
> -	port->irq = irq_of_parse_and_map(node, 0);
> -	err = devm_request_irq(dev, port->irq, xilinx_pcie_intr_handler,
> +	irq = irq_of_parse_and_map(node, 0);
> +	err = devm_request_irq(dev, irq, xilinx_pcie_intr_handler,
>  			       IRQF_SHARED | IRQF_NO_THREAD,
>  			       "xilinx-pcie", port);
>  	if (err) {
> -		dev_err(dev, "unable to request irq %d\n", port->irq);
> +		dev_err(dev, "unable to request irq %d\n", irq);
>  		return err;
>  	}
>  
> @@ -617,7 +569,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	port = pci_host_bridge_priv(bridge);
> -
> +	mutex_init(&port->map_lock);
>  	port->dev = dev;
>  
>  	err = xilinx_pcie_parse_dt(port);
> @@ -637,11 +589,11 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>  	bridge->sysdata = port;
>  	bridge->ops = &xilinx_pcie_ops;
>  
> -#ifdef CONFIG_PCI_MSI
> -	xilinx_pcie_msi_chip.dev = dev;
> -	bridge->msi = &xilinx_pcie_msi_chip;
> -#endif
> -	return pci_host_probe(bridge);
> +	err = pci_host_probe(bridge);
> +	if (err)
> +		xilinx_free_msi_domains(port);
> +
> +	return err;
>  }
>  
>  static const struct of_device_id xilinx_pcie_of_match[] = {
> -- 
> 2.29.2
> 
