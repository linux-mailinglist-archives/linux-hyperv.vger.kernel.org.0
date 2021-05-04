Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748B9372564
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 May 2021 07:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhEDFRi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 May 2021 01:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhEDFRh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 May 2021 01:17:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEB0A6103E;
        Tue,  4 May 2021 05:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620105403;
        bh=urK9tC404nMnqBhYCMWCz0e6HylWZMJLaJqYtkyTfHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBTTk+8zKz/SqyLXrtQSR+TZLRE2ldlnM3WZ/2EAJSQ5SRDR/ag33MO2+nDvCW3HT
         MJgQa6e0cOD8ODXd+emyjK9FyivtDpqpmkY0WCprtrUcqUEX0pIelWRgKxQbsrHAe4
         aXtHRg5SU4G6FWeXMLx7PhCpKWfyYLMUPLB6+oqfy/3OChcpSEDbvBMAWaGA6419Ee
         dmIwMvpdp5wHDm3OUKaKGAU1Wl4qYHujCs/MqBcnnUGIVhS4B6slRidQL9WgvECmdv
         QbrVozr+5FHan6jqF8VcKakho8z2Sqf8FvbdtL+oSnvuEyTAFmDdoYjL+RdAtVytZh
         EORvVcLvauKZA==
Date:   Tue, 4 May 2021 08:16:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [RFC v2 1/7] PCI: Introduce pci_host_bridge::domain_nr
Message-ID: <YJDYrn7Nt+xyHbyr@kernel.org>
References: <20210503144635.2297386-1-boqun.feng@gmail.com>
 <20210503144635.2297386-2-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503144635.2297386-2-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 03, 2021 at 10:46:29PM +0800, Boqun Feng wrote:
> Currently we retrieve the PCI domain number of the host bridge from the
> bus sysdata (or pci_config_window if PCI_DOMAINS_GENERIC=y). Actually
> we have the information at PCI host bridge probing time, and it makes
> sense that we store it into pci_host_bridge. One benefit of doing so is
> the requirement for supporting PCI on Hyper-V for ARM64, because the
> host bridge of Hyper-V doesnt' have pci_config_window, whereas ARM64 is
> a PCI_DOMAINS_GENERIC=y arch, so we cannot retrieve the PCI domain
> number from pci_config_window on ARM64 Hyper-V guest.
> 
> As the preparation for ARM64 Hyper-V PCI support, we introduce the
> domain_nr in pci_host_bridge, and set it properly at probing time, then
> for PCI_DOMAINS_GENERIC=y archs, bus domain numbers are set by the
> bridge domain_nr.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  arch/arm/kernel/bios32.c              |  2 ++
>  arch/arm/mach-dove/pcie.c             |  2 ++
>  arch/arm/mach-mv78xx0/pcie.c          |  2 ++
>  arch/arm/mach-orion5x/pci.c           |  2 ++
>  arch/arm64/kernel/pci.c               |  3 +--
>  arch/mips/pci/pci-legacy.c            |  2 ++
>  arch/mips/pci/pci-xtalk-bridge.c      |  2 ++
>  drivers/pci/controller/pci-ftpci100.c |  2 ++
>  drivers/pci/controller/pci-mvebu.c    |  2 ++
>  drivers/pci/pci.c                     |  4 ++--
>  drivers/pci/probe.c                   |  7 ++++++-
>  include/linux/pci.h                   | 11 ++++++++---
>  12 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index e7ef2b5bea9c..4942cd681e41 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -471,6 +471,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  				bridge->sysdata = sys;
>  				bridge->busnr = sys->busnr;
>  				bridge->ops = hw->ops;
> +				if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> +					bridge->domain_nr = pci_bus_find_domain_nr(sys, parent);
>  
>  				ret = pci_scan_root_bus_bridge(bridge);
>  			}
> diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
> index ee91ac6b5ebf..92eb8484b49b 100644
> --- a/arch/arm/mach-dove/pcie.c
> +++ b/arch/arm/mach-dove/pcie.c
> @@ -167,6 +167,8 @@ dove_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
>  	bridge->sysdata = sys;
>  	bridge->busnr = sys->busnr;
>  	bridge->ops = &pcie_ops;
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> +		bridge->domain_nr = pci_bus_find_domain_nr(sys, NULL);

The check for CONFIG_PCI_DOMAINS_GENERIC is excessive because there is a
stub for pci_bus_find_domain_nr().

I'm not an expert in PCI, but maybe the repeated assignment of
bridge->domain_nr can live in the generic code, say, in
pci_scan_root_bus_bridge(). E.g. it will set the domain_nr when it is zero.

>  
>  	return pci_scan_root_bus_bridge(bridge);
>  }
> diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
> index 636d84b40466..6703d394bcde 100644
> --- a/arch/arm/mach-mv78xx0/pcie.c
> +++ b/arch/arm/mach-mv78xx0/pcie.c
> @@ -208,6 +208,8 @@ static int __init mv78xx0_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
>  	bridge->sysdata = sys;
>  	bridge->busnr = sys->busnr;
>  	bridge->ops = &pcie_ops;
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> +		bridge->domain_nr = pci_bus_find_domain_nr(sys, NULL);
>  
>  	return pci_scan_root_bus_bridge(bridge);
>  }
> diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
> index 76951bfbacf5..6257fbd4e705 100644
> --- a/arch/arm/mach-orion5x/pci.c
> +++ b/arch/arm/mach-orion5x/pci.c
> @@ -563,6 +563,8 @@ int __init orion5x_pci_sys_scan_bus(int nr, struct pci_host_bridge *bridge)
>  	bridge->dev.parent = NULL;
>  	bridge->sysdata = sys;
>  	bridge->busnr = sys->busnr;
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> +		bridge->domain_nr = pci_bus_find_domain_nr(sys, NULL);
>  
>  	if (nr == 0) {
>  		bridge->ops = &pcie_ops;
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2d7c60..e9a6eeb6a694 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -71,9 +71,8 @@ struct acpi_pci_generic_root_info {
>  	struct pci_config_window	*cfg;	/* config space mapping */
>  };
>  
> -int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> +int acpi_pci_bus_find_domain_nr(struct pci_config_window *cfg)
>  {
> -	struct pci_config_window *cfg = bus->sysdata;
>  	struct acpi_device *adev = to_acpi_device(cfg->parent);
>  	struct acpi_pci_root *root = acpi_driver_data(adev);
>  
> diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> index 39052de915f3..84ad482be22d 100644
> --- a/arch/mips/pci/pci-legacy.c
> +++ b/arch/mips/pci/pci-legacy.c
> @@ -97,6 +97,8 @@ static void pcibios_scanbus(struct pci_controller *hose)
>  	bridge->ops = hose->pci_ops;
>  	bridge->swizzle_irq = pci_common_swizzle;
>  	bridge->map_irq = pcibios_map_irq;
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> +		bridge->domain_nr = pci_bus_find_domain_nr(hose, NULL);
>  	ret = pci_scan_root_bus_bridge(bridge);
>  	if (ret) {
>  		pci_free_host_bridge(bridge);
> diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
> index 50f7d42cca5a..23355ab720be 100644
> --- a/arch/mips/pci/pci-xtalk-bridge.c
> +++ b/arch/mips/pci/pci-xtalk-bridge.c
> @@ -712,6 +712,8 @@ static int bridge_probe(struct platform_device *pdev)
>  	host->ops = &bridge_pci_ops;
>  	host->map_irq = bridge_map_irq;
>  	host->swizzle_irq = pci_common_swizzle;
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> +		host->domain_nr = pci_bus_find_domain_nr(bc, dev);
>  
>  	err = pci_scan_root_bus_bridge(host);
>  	if (err < 0)
> diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
> index da3cd216da00..cf6eec7f90e1 100644
> --- a/drivers/pci/controller/pci-ftpci100.c
> +++ b/drivers/pci/controller/pci-ftpci100.c
> @@ -439,6 +439,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
>  	host->ops = &faraday_pci_ops;
>  	p = pci_host_bridge_priv(host);
>  	host->sysdata = p;
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> +		host->domain_nr = pci_bus_find_domain_nr(p, dev);
>  	p->dev = dev;
>  
>  	/* Retrieve and enable optional clocks */
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index ed13e81cd691..b329ed2f0956 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1122,6 +1122,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  	bridge->sysdata = pcie;
>  	bridge->ops = &mvebu_pcie_ops;
>  	bridge->align_resource = mvebu_pcie_align_resource;
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> +		bridge->domain_nr = pci_bus_find_domain_nr(pcie, dev);
>  
>  	return mvebu_pci_host_probe(bridge);
>  }
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 16a17215f633..a249dbf78c34 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6505,10 +6505,10 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
>  	return domain;
>  }
>  
> -int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
> +int pci_bus_find_domain_nr(void *sysdata, struct device *parent)
>  {
>  	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
> -			       acpi_pci_bus_find_domain_nr(bus);
> +			       acpi_pci_bus_find_domain_nr(sysdata);
>  }
>  #endif
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..5e71cc5e1b6c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -899,7 +899,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	bus->ops = bridge->ops;
>  	bus->number = bus->busn_res.start = bridge->busnr;
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -	bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> +	bus->domain_nr = bridge->domain_nr;
>  #endif
>  
>  	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
> @@ -2974,6 +2974,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  	bridge->sysdata = sysdata;
>  	bridge->busnr = bus;
>  	bridge->ops = ops;
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> +		bridge->domain_nr = pci_bus_find_domain_nr(sysdata, parent);
>  
>  	error = pci_register_host_bridge(bridge);
>  	if (error < 0)
> @@ -2992,6 +2994,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  	struct pci_bus *bus, *child;
>  	int ret;
>  
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> +		bridge->domain_nr = pci_bus_find_domain_nr(bridge->sysdata, bridge->dev.parent);
> +
>  	ret = pci_scan_root_bus_bridge(bridge);
>  	if (ret < 0) {
>  		dev_err(bridge->dev.parent, "Scanning root bridge failed");
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97b77..5bbd8417d219 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -534,6 +534,7 @@ struct pci_host_bridge {
>  	struct pci_ops	*child_ops;
>  	void		*sysdata;
>  	int		busnr;
> +	int		domain_nr;
>  	struct list_head windows;	/* resource_entry */
>  	struct list_head dma_ranges;	/* dma ranges resource list */
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
> @@ -1637,13 +1638,17 @@ static inline int pci_domain_nr(struct pci_bus *bus)
>  {
>  	return bus->domain_nr;
>  }
> +struct pci_config_window;
>  #ifdef CONFIG_ACPI
> -int acpi_pci_bus_find_domain_nr(struct pci_bus *bus);
> +int acpi_pci_bus_find_domain_nr(struct pci_config_window *cfg);
>  #else
> -static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> +static inline int acpi_pci_bus_find_domain_nr(struct pci_config_window *cfg)
>  { return 0; }
>  #endif
> -int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
> +int pci_bus_find_domain_nr(void *sysdata, struct device *parent);
> +#else
> +static inline int pci_bus_find_domain_nr(void *sysdata, struct device *parent)
> +{ return 0; }
>  #endif
>  
>  /* Some architectures require additional setup to direct VGA traffic */
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
