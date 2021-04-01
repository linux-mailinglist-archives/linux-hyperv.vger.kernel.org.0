Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F68351373
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Apr 2021 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhDAK0N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Apr 2021 06:26:13 -0400
Received: from foss.arm.com ([217.140.110.172]:35868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233850AbhDAKUH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Apr 2021 06:20:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8158AD6E;
        Thu,  1 Apr 2021 03:20:06 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36FE73F694;
        Thu,  1 Apr 2021 03:20:03 -0700 (PDT)
Date:   Thu, 1 Apr 2021 11:19:57 +0100
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
Subject: Re: [PATCH v3 03/14] PCI: rcar: Convert to MSI domains
Message-ID: <20210401101957.GA30653@lpieralisi>
References: <20210330151145.997953-1-maz@kernel.org>
 <20210330151145.997953-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330151145.997953-4-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 30, 2021 at 04:11:34PM +0100, Marc Zyngier wrote:

[...]

> +static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct rcar_msi *msi = irq_data_get_irq_chip_data(data);
> +	unsigned long pa = virt_to_phys(msi);
>  
> -	hwirq = rcar_msi_alloc_region(msi, nvec);
> -	if (hwirq < 0)
> -		return -ENOSPC;
> +	/* Use the msi structure as the PA for the MSI doorbell */
> +	msg->address_lo = lower_32_bits(pa);
> +	msg->address_hi = upper_32_bits(pa);

I don't think this change is aligned with the previous patch (is it ?),
the PA address we are using here is different from the one programmed
into the controller registers - either that or I am missing something,
please let me know.

Thanks,
Lorenzo

> +	msg->data = data->hwirq;
> +}
>  
> -	irq = irq_find_mapping(msi->domain, hwirq);
> -	if (!irq)
> -		return -ENOSPC;
> +static struct irq_chip rcar_msi_bottom_chip = {
> +	.name			= "Rcar MSI",
> +	.irq_ack		= rcar_msi_irq_ack,
> +	.irq_mask		= rcar_msi_irq_mask,
> +	.irq_unmask		= rcar_msi_irq_unmask,
> +	.irq_set_affinity 	= rcar_msi_set_affinity,
> +	.irq_compose_msi_msg	= rcar_compose_msi_msg,
> +};
>  
> -	for (i = 0; i < nvec; i++) {
> -		/*
> -		 * irq_create_mapping() called from rcar_pcie_probe() pre-
> -		 * allocates descs,  so there is no need to allocate descs here.
> -		 * We can therefore assume that if irq_find_mapping() above
> -		 * returns non-zero, then the descs are also successfully
> -		 * allocated.
> -		 */
> -		if (irq_set_msi_desc_off(irq, i, desc)) {
> -			/* TODO: clear */
> -			return -EINVAL;
> -		}
> -	}
> +static int rcar_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				  unsigned int nr_irqs, void *args)
> +{
> +	struct rcar_msi *msi = domain->host_data;
> +	unsigned int i;
> +	int hwirq;
> +
> +	mutex_lock(&msi->map_lock);
>  
> -	desc->nvec_used = nvec;
> -	desc->msi_attrib.multiple = order_base_2(nvec);
> +	hwirq = bitmap_find_free_region(msi->used, INT_PCI_MSI_NR, order_base_2(nr_irqs));
>  
> -	msg.address_lo = rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
> -	msg.address_hi = rcar_pci_read_reg(pcie, PCIEMSIAUR);
> -	msg.data = hwirq;
> +	mutex_unlock(&msi->map_lock);
> +
> +	if (hwirq < 0)
> +		return -ENOSPC;
>  
> -	pci_write_msi_msg(irq, &msg);
> +	for (i = 0; i < nr_irqs; i++)
> +		irq_domain_set_info(domain, virq + i, hwirq + i,
> +				    &rcar_msi_bottom_chip, domain->host_data,
> +				    handle_edge_irq, NULL, NULL);
>  
>  	return 0;
>  }
>  
> -static void rcar_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
> +static void rcar_msi_domain_free(struct irq_domain *domain, unsigned int virq,
> +				  unsigned int nr_irqs)
>  {
> -	struct rcar_msi *msi = to_rcar_msi(chip);
> -	struct irq_data *d = irq_get_irq_data(irq);
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct rcar_msi *msi = domain->host_data;
>  
> -	rcar_msi_free(msi, d->hwirq);
> -}
> -
> -static struct irq_chip rcar_msi_irq_chip = {
> -	.name = "R-Car PCIe MSI",
> -	.irq_enable = pci_msi_unmask_irq,
> -	.irq_disable = pci_msi_mask_irq,
> -	.irq_mask = pci_msi_mask_irq,
> -	.irq_unmask = pci_msi_unmask_irq,
> -};
> +	mutex_lock(&msi->map_lock);
>  
> -static int rcar_msi_map(struct irq_domain *domain, unsigned int irq,
> -			irq_hw_number_t hwirq)
> -{
> -	irq_set_chip_and_handler(irq, &rcar_msi_irq_chip, handle_simple_irq);
> -	irq_set_chip_data(irq, domain->host_data);
> +	bitmap_release_region(msi->used, d->hwirq, order_base_2(nr_irqs));
>  
> -	return 0;
> +	mutex_unlock(&msi->map_lock);
>  }
>  
> -static const struct irq_domain_ops msi_domain_ops = {
> -	.map = rcar_msi_map,
> +static const struct irq_domain_ops rcar_msi_domain_ops = {
> +	.alloc	= rcar_msi_domain_alloc,
> +	.free	= rcar_msi_domain_free,
> +};
> +
> +static struct msi_domain_info rcar_msi_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		   MSI_FLAG_MULTI_PCI_MSI),
> +	.chip	= &rcar_msi_top_chip,
>  };
>  
> -static void rcar_pcie_unmap_msi(struct rcar_pcie_host *host)
> +static int rcar_allocate_domains(struct rcar_msi *msi)
>  {
> -	struct rcar_msi *msi = &host->msi;
> -	int i, irq;
> +	struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
> +	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
> +	struct irq_domain *parent;
> +
> +	parent = irq_domain_create_linear(fwnode, INT_PCI_MSI_NR,
> +					  &rcar_msi_domain_ops, msi);
> +	if (!parent) {
> +		dev_err(pcie->dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
>  
> -	for (i = 0; i < INT_PCI_MSI_NR; i++) {
> -		irq = irq_find_mapping(msi->domain, i);
> -		if (irq > 0)
> -			irq_dispose_mapping(irq);
> +	msi->domain = pci_msi_create_irq_domain(fwnode, &rcar_msi_info, parent);
> +	if (!msi->domain) {
> +		dev_err(pcie->dev, "failed to create MSI domain\n");
> +		irq_domain_remove(parent);
> +		return -ENOMEM;
>  	}
>  
> -	irq_domain_remove(msi->domain);
> +	return 0;
>  }
>  
> -static void rcar_pcie_hw_enable_msi(struct rcar_pcie_host *host)
> +static void rcar_free_domains(struct rcar_msi *msi)
>  {
> -	struct rcar_pcie *pcie = &host->pcie;
> -	struct device *dev = pcie->dev;
> -	struct resource res;
> +	struct irq_domain *parent = msi->domain->parent;
>  
> -	if (WARN_ON(of_address_to_resource(dev->of_node, 0, &res)))
> -		return;
> -
> -	/* setup MSI data target */
> -	rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE, PCIEMSIALR);
> -	rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
> -
> -	/* enable all MSI interrupts */
> -	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
> +	irq_domain_remove(msi->domain);
> +	irq_domain_remove(parent);
>  }
>  
>  static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
> @@ -698,29 +675,24 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>  	struct rcar_pcie *pcie = &host->pcie;
>  	struct device *dev = pcie->dev;
>  	struct rcar_msi *msi = &host->msi;
> -	int err, i;
> -
> -	mutex_init(&msi->lock);
> +	struct resource res;
> +	int err;
>  
> -	msi->chip.dev = dev;
> -	msi->chip.setup_irq = rcar_msi_setup_irq;
> -	msi->chip.setup_irqs = rcar_msi_setup_irqs;
> -	msi->chip.teardown_irq = rcar_msi_teardown_irq;
> +	mutex_init(&msi->map_lock);
> +	spin_lock_init(&msi->mask_lock);
>  
> -	msi->domain = irq_domain_add_linear(dev->of_node, INT_PCI_MSI_NR,
> -					    &msi_domain_ops, &msi->chip);
> -	if (!msi->domain) {
> -		dev_err(dev, "failed to create IRQ domain\n");
> -		return -ENOMEM;
> -	}
> +	err = of_address_to_resource(dev->of_node, 0, &res);
> +	if (err)
> +		return err;
>  
> -	for (i = 0; i < INT_PCI_MSI_NR; i++)
> -		irq_create_mapping(msi->domain, i);
> +	err = rcar_allocate_domains(msi);
> +	if (err)
> +		return err;
>  
>  	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
>  	err = devm_request_irq(dev, msi->irq1, rcar_pcie_msi_irq,
>  			       IRQF_SHARED | IRQF_NO_THREAD,
> -			       rcar_msi_irq_chip.name, host);
> +			       rcar_msi_bottom_chip.name, host);
>  	if (err < 0) {
>  		dev_err(dev, "failed to request IRQ: %d\n", err);
>  		goto err;
> @@ -728,19 +700,26 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>  
>  	err = devm_request_irq(dev, msi->irq2, rcar_pcie_msi_irq,
>  			       IRQF_SHARED | IRQF_NO_THREAD,
> -			       rcar_msi_irq_chip.name, host);
> +			       rcar_msi_bottom_chip.name, host);
>  	if (err < 0) {
>  		dev_err(dev, "failed to request IRQ: %d\n", err);
>  		goto err;
>  	}
>  
> -	/* setup MSI data target */
> -	rcar_pcie_hw_enable_msi(host);
> +	/* disable all MSIs */
> +	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
> +
> +	/*
> +	 * Setup MSI data target using RC base address address, which
> +	 * is guaranteed to be in the low 32bit range on any RCar HW.
> +	 */
> +	rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE, PCIEMSIALR);
> +	rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
>  
>  	return 0;
>  
>  err:
> -	rcar_pcie_unmap_msi(host);
> +	rcar_free_domains(msi);
>  	return err;
>  }
>  
> @@ -754,7 +733,7 @@ static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
>  	/* Disable address decoding of the MSI interrupt, MSIFE */
>  	rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
>  
> -	rcar_pcie_unmap_msi(host);
> +	rcar_free_domains(&host->msi);
>  }
>  
>  static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
> @@ -1007,8 +986,17 @@ static int __maybe_unused rcar_pcie_resume(struct device *dev)
>  	dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
>  
>  	/* Enable MSI */
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		rcar_pcie_hw_enable_msi(host);
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		struct resource res;
> +		u32 val;
> +
> +		of_address_to_resource(dev->of_node, 0, &res);
> +		rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
> +		rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE, PCIEMSIALR);
> +
> +		bitmap_to_arr32(&val, host->msi.used, INT_PCI_MSI_NR);
> +		rcar_pci_write_reg(pcie, val, PCIEMSIIER);
> +	}
>  
>  	rcar_pcie_hw_enable(host);
>  
> -- 
> 2.29.2
> 
