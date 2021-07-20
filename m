Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553033D04CC
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 00:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhGTWJF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 18:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhGTWIu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 18:08:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD333606A5;
        Tue, 20 Jul 2021 22:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626821367;
        bh=S0VBkMptMTBMbjlXlL3v3nxSVJbBzwoRLC13STy72fE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bpN59brQGPUtdQa9dWrAx0mFd04/ZQnXOjeiwi0mGLgC0s8WSRGtoOrLTT115IalN
         /CxuTWu6Y+HVfWNSZ2E1nKFyU9iv8L8ZvR/jZhMyRhNJasW9yBzZU2W0U78QVepML8
         l8Hcqqd3Jum8OUrYlALzHjbY++rg4nl8wtuHXFISMMSoKihhP+Hz2ycuKQV5+2C7Pp
         08mKiYYuDK8sSYHopWnOV2NgTiXoZGGfPtk7mua0V9tf9xzgixbyPqpNYLfC/L81K2
         RbwzSswX/sHzc07Rc6Fq7b0W0N1KbJzzQNrea95cps/QzAxhE9OcwEljwLDZNcXbXY
         YG1vRgnPDrY7A==
Date:   Tue, 20 Jul 2021 17:49:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC v5 1/8] PCI: Introduce domain_nr in pci_host_bridge
Message-ID: <20210720224925.GA137627@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720134429.511541-2-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 20, 2021 at 09:44:22PM +0800, Boqun Feng wrote:
> Currently we retrieve the PCI domain number of the host bridge from the
> bus sysdata (or pci_config_window if PCI_DOMAINS_GENERIC=y). Actually
> we have the information at PCI host bridge probing time, and it makes
> sense that we store it into pci_host_bridge. One benefit of doing so is
> the requirement for supporting PCI on Hyper-V for ARM64, because the
> host bridge of Hyper-V doesn't have pci_config_window, whereas ARM64 is
> a PCI_DOMAINS_GENERIC=y arch, so we cannot retrieve the PCI domain
> number from pci_config_window on ARM64 Hyper-V guest.
> 
> As the preparation for ARM64 Hyper-V PCI support, we introduce the
> domain_nr in pci_host_bridge and a sentinel value to allow drivers to
> set domain numbers properly at probing time. Currently
> CONFIG_PCI_DOMAINS_GENERIC=y archs are only users of this
> newly-introduced field.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Once all the issues are ironed out, Lorenzo should probably merge this
since it's primarily Hyper-V stuff, but I'm OK with this part:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

But fix the comment issue below.

> ---
>  drivers/pci/probe.c |  6 +++++-
>  include/linux/pci.h | 10 ++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 79177ac37880..60c50d4f156f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -594,6 +594,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;
>  	bridge->native_dpc = 1;
> +	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
>  
>  	device_initialize(&bridge->dev);
>  }
> @@ -898,7 +899,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	bus->ops = bridge->ops;
>  	bus->number = bus->busn_res.start = bridge->busnr;
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -	bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> +	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
> +		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> +	else
> +		bus->domain_nr = bridge->domain_nr;
>  #endif
>  
>  	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 540b377ca8f6..2c413a64d168 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -526,6 +526,15 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
>  	return (pdev->error_state != pci_channel_io_normal);
>  }
>  
> +/*
> +* Currently in ACPI spec, for each PCI host bridge, PCI Segment Group number is
> +* limited to a 16-bit value, therefore (int)-1 is not a valid PCI domain number,
> +* and can be used as a sentinel value indicating >domain_nr is not set by the
> +* driver (and CONFIG_PCI_DOMAINS_GENERIC=y archs will set it with
> +* pci_bus_find_domain_nr()).
> +*/

Fix comment indentation (follow style of other comments in this file).

s/>domain_nr/->domain_nr/

> +#define PCI_DOMAIN_NR_NOT_SET (-1)
> +
>  struct pci_host_bridge {
>  	struct device	dev;
>  	struct pci_bus	*bus;		/* Root bus */
> @@ -533,6 +542,7 @@ struct pci_host_bridge {
>  	struct pci_ops	*child_ops;
>  	void		*sysdata;
>  	int		busnr;
> +	int		domain_nr;
>  	struct list_head windows;	/* resource_entry */
>  	struct list_head dma_ranges;	/* dma ranges resource list */
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
> -- 
> 2.30.2
> 
