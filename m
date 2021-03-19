Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53221342777
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 22:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhCSVNL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 17:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230105AbhCSVMs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 17:12:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBEB661927;
        Fri, 19 Mar 2021 21:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616188368;
        bh=LvqwQ0U3pBwYMhuDJzKK5TT8veiZdGKc44vUHs84E5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nTiQhLwd04Pj+QfdqmvpegjREG5scWngH0ChMVIQh9HzyqWUKBqkKlb9I0cS68tFe
         pQ1yIlcPB5EFcMz+Qygy5Czch3W156ebJI/B2EACdrxOI/HZeSvX6k70Hmzp1bbOx9
         b63uaFYmlX8eV28N4EGNyeexBZEQjrvim+qBt8pwSY5lzfi10HidWhKApPohCzFGNQ
         KBr8Sey//GPi85ZHG+/zdN6mV1xWb7uNSxYMWuvhtrOC+cWrwkZc+t8tmfFJATcfGw
         WXZgJRLyVyQRt1dbbNzOgA4+fyvi/cWOAYXT3qlnGKOgRWBIUBtRwScDlTfeEaBAdE
         OJgwZKZ2JuZMQ==
Date:   Fri, 19 Mar 2021 16:12:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC 1/2] arm64: PCI: Allow use arch-specific pci sysdata
Message-ID: <20210319211246.GA250618@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319161956.2838291-2-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

[+cc Arnd (author of 37d6a0a6f470 ("PCI: Add
pci_register_host_bridge() interface"), which I think would make my
idea below possible), Marc (IRQ domains maintainer)]

On Sat, Mar 20, 2021 at 12:19:55AM +0800, Boqun Feng wrote:
> Currently, if an architecture selects CONFIG_PCI_DOMAINS_GENERIC, the
> ->sysdata in bus and bridge will be treated as struct pci_config_window,
> which is created by generic ECAM using the data from acpi.

It might be a mistake that we put the struct pci_config_window
pointer, which is really arch-independent, in the ->sysdata element,
which normally contains a pointer to arch- or host bridge-dependent 
data.

> However, for a virtualized PCI bus, there might be no enough data in of
> or acpi table to create a pci_config_window. This is similar to the case
> where CONFIG_PCI_DOMAINS_GENERIC=n, IOW, architectures use their own
> structure for sysdata, so no apci table lookup is required.
> 
> In order to enable Hyper-V's virtual PCI (which doesn't have acpi table
> entry for PCI) on ARM64 (which selects CONFIG_PCI_DOMAINS_GENERIC), we
> introduce arch-specific pci sysdata (similar to the one for x86) for
> ARM64, and allow the core PCI code to detect the type of sysdata at the
> runtime. The latter is achieved by adding a pci_ops::use_arch_sysdata
> field.
> 
> Originally-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> ---
>  arch/arm64/include/asm/pci.h | 29 +++++++++++++++++++++++++++++
>  arch/arm64/kernel/pci.c      | 15 ++++++++++++---
>  include/linux/pci.h          |  3 +++
>  3 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b33ca260e3c9..dade061a0658 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -22,6 +22,16 @@
>  
>  extern int isa_dma_bridge_buggy;
>  
> +struct pci_sysdata {
> +	int domain;	/* PCI domain */
> +	int node;	/* NUMA Node */
> +#ifdef CONFIG_ACPI
> +	struct acpi_device *companion;	/* ACPI companion device */
> +#endif
> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> +	void *fwnode;			/* IRQ domain for MSI assignment */
> +#endif
> +};

Our PCI domain code is really a mess (mostly my fault) and I hate to
make it even more complicated by adding more switches, e.g.,
->use_arch_sysdata.

I think the design problem is that PCI host bridge drivers should
supply the PCI domain up front instead of having callbacks to extract
it.

We could put "int domain_nr" in struct pci_host_bridge, and the arch
code or host bridge driver (pcibios_init_hw(), *_pcie_probe(), VMD,
HV, etc) could fill in pci_host_bridge.domain_nr before calling
pci_scan_root_bus_bridge() or pci_host_probe().

Then maybe we could get rid of pci_bus_find_domain_nr() and some of
the needlessly arch-specific implementations of pci_domain_nr().
I think we likely could get rid of CONFIG_PCI_DOMAINS_GENERIC, too,
eventually.

>  #ifdef CONFIG_PCI
>  static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>  {
> @@ -31,8 +41,27 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>  
>  static inline int pci_proc_domain(struct pci_bus *bus)
>  {
> +	if (bus->ops->use_arch_sysdata)
> +		return pci_domain_nr(bus);
>  	return 1;

I don't understand this.  pci_proc_domain() returns a boolean and
determines whether the /proc/bus/pci/ directory contains, e.g.,

  /proc/bus/pci/00            or
  /proc/bus/pci/0000:00

On arm64, pci_proc_domain() currently always returns 1, so the
directory contains "0000:00".  After these patches, pci_proc_domain()
returns 0 if CONFIG_PCI_DOMAINS_GENERIC=y and "bus" is in domain 0,
so buses in domain 0 will be "00" instead of "0000:00".

This doesn't make sense to me, but at the very least, this
user-visible change needs to be explained.

>  }
> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> +static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
> +{
> +	struct pci_sysdata *sd = bus->sysdata;
> +
> +	if (bus->ops->use_arch_sysdata)
> +		return sd->fwnode;
> +
> +	/*
> +	 * bus->sysdata is not struct pci_sysdata, fwnode should be able to
> +	 * be queried from of/acpi.
> +	 */
> +	return NULL;
> +}
> +#define pci_root_bus_fwnode	_pci_root_bus_fwnode

Ugh.  pci_root_bus_fwnode() is another callback to find the
irq_domain.  Only one call, from pci_host_bridge_msi_domain(), which
itself is only called from pci_set_bus_msi_domain().  This feels like
another case where we could simplify things by having the host bridge
driver figure out the irq_domain explicitly when it creates the
pci_host_bridge.  It seems like that's where we have the most
information about how to find the irq_domain.

> +#endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
> +
>  #endif  /* CONFIG_PCI */
>  
>  #endif  /* __ASM_PCI_H */
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2d7c60..63d420d57e63 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -74,15 +74,24 @@ struct acpi_pci_generic_root_info {
>  int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
>  {
>  	struct pci_config_window *cfg = bus->sysdata;
> -	struct acpi_device *adev = to_acpi_device(cfg->parent);
> -	struct acpi_pci_root *root = acpi_driver_data(adev);
> +	struct pci_sysdata *sd = bus->sysdata;
> +	struct acpi_device *adev;
> +	struct acpi_pci_root *root;
> +
> +	/* struct pci_sysdata has domain nr in it */
> +	if (bus->ops->use_arch_sysdata)
> +		return sd->domain;
> +
> +	/* or pci_config_window is used as sysdata */
> +	adev = to_acpi_device(cfg->parent);
> +	root = acpi_driver_data(adev);

My comments above are a lot of hand-waving without a very clear way
forward.  Would it simplify things to just add a "struct
pci_config_window *ecam_info" to pci_host_bridge, so we wouldn't have
to overload sysdata?

>  	return root->segment;
>  }
>  
>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  {
> -	if (!acpi_disabled) {
> +	if (!acpi_disabled && bridge->ops->use_arch_sysdata) {
>  		struct pci_config_window *cfg = bridge->bus->sysdata;
>  		struct acpi_device *adev = to_acpi_device(cfg->parent);
>  		struct device *bus_dev = &bridge->bus->dev;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97b77..4036aac40361 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -740,6 +740,9 @@ struct pci_ops {
>  	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
>  	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
>  	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
> +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> +	int use_arch_sysdata;	/* ->sysdata is arch-specific */
> +#endif
>  };
>  
>  /*
> -- 
> 2.30.2
> 
