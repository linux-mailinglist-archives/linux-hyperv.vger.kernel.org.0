Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364A434EC6B
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Mar 2021 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhC3P3d (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Mar 2021 11:29:33 -0400
Received: from foss.arm.com ([217.140.110.172]:38796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232240AbhC3P3G (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Mar 2021 11:29:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A653C31B;
        Tue, 30 Mar 2021 08:29:05 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 263A73F719;
        Tue, 30 Mar 2021 08:29:02 -0700 (PDT)
Date:   Tue, 30 Mar 2021 16:28:57 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
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
Subject: Re: [PATCH v3 02/14] PCI: rcar: Don't allocate extra memory for the
 MSI capture address
Message-ID: <20210330152857.GA27749@lpieralisi>
References: <20210330151145.997953-1-maz@kernel.org>
 <20210330151145.997953-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330151145.997953-3-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 30, 2021 at 04:11:33PM +0100, Marc Zyngier wrote:
> A long cargo-culted behaviour of PCI drivers is to allocate memory
> to obtain an address that is fed to the controller as the MSI
> capture address (i.e. the MSI doorbell).
> 
> But there is no actual requirement for this address to be RAM.
> All it needs to be is a suitable aligned address that will
> *not* be DMA'd to.
> 
> Since the rcar platform already has a requirement that this
> address should be in the first 4GB of the physical address space,
> use the controller's own base address as the capture address.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

Marek, Yoshihiro,

can you test this patch please and report back ? It is not fundamental
for the rest of the series (ie the rest of the series does not depend on
it) and we can still merge the series without it but it would be good if
you can review and test anyway.

I'd like to merge this series into -next shortly.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index a728e8f9ad3c..ce952403e22c 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -36,7 +36,6 @@ struct rcar_msi {
>  	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>  	struct irq_domain *domain;
>  	struct msi_controller chip;
> -	unsigned long pages;
>  	struct mutex lock;
>  	int irq1;
>  	int irq2;
> @@ -680,14 +679,15 @@ static void rcar_pcie_unmap_msi(struct rcar_pcie_host *host)
>  static void rcar_pcie_hw_enable_msi(struct rcar_pcie_host *host)
>  {
>  	struct rcar_pcie *pcie = &host->pcie;
> -	struct rcar_msi *msi = &host->msi;
> -	unsigned long base;
> +	struct device *dev = pcie->dev;
> +	struct resource res;
>  
> -	/* setup MSI data target */
> -	base = virt_to_phys((void *)msi->pages);
> +	if (WARN_ON(of_address_to_resource(dev->of_node, 0, &res)))
> +		return;
>  
> -	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
> -	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
> +	/* setup MSI data target */
> +	rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE, PCIEMSIALR);
> +	rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
>  
>  	/* enable all MSI interrupts */
>  	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
> @@ -735,7 +735,6 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>  	}
>  
>  	/* setup MSI data target */
> -	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA32, 0);
>  	rcar_pcie_hw_enable_msi(host);
>  
>  	return 0;
> @@ -748,7 +747,6 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>  static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
>  {
>  	struct rcar_pcie *pcie = &host->pcie;
> -	struct rcar_msi *msi = &host->msi;
>  
>  	/* Disable all MSI interrupts */
>  	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
> @@ -756,8 +754,6 @@ static void rcar_pcie_teardown_msi(struct rcar_pcie_host *host)
>  	/* Disable address decoding of the MSI interrupt, MSIFE */
>  	rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
>  
> -	free_pages(msi->pages, 0);
> -
>  	rcar_pcie_unmap_msi(host);
>  }
>  
> -- 
> 2.29.2
> 
