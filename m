Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF03C8BB8
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 21:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhGNTgP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 15:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhGNTgN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 15:36:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D2FD613C9;
        Wed, 14 Jul 2021 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626291201;
        bh=J7cuURdLRdQBrOKGJxLamHO4xL6uEe+qeY0zn0jhWNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FIJVqhGCPw1I7nZkA/n00LcMBZqsLQeEA6b+4/l8xNU4FkVaQc5fSTAb5+zglNUBM
         VEX3aegs2v3cSlqsV/T6bR/ZiVZipQTcdfS1xrcZCgD27uPjm8AeEKP38N0S1o297H
         +9UVvRkl4AfK4sVoJQbztEMZGHuQhRHkCjO81sMSvMwnsnXCxBTuPAiaCi4CO9bI2d
         +SLE08VfWII42X3hAlimVtA9Awb9ruNyBQOEII8abjxWkLcNAYAYqe77pAsxRZuDRX
         qb84mpplkvuzFheoc1gZRGvfg/+hUE5WWogwmBAIOlB2Y15ocfIXlxUCxitnCxz5HR
         JsCxaMffEbSCA==
Date:   Wed, 14 Jul 2021 14:33:19 -0500
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
Subject: Re: [RFC v4 1/7] PCI: Introduce domain_nr in pci_host_bridge
Message-ID: <20210714193319.GA1867593@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714102737.198432-2-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 14, 2021 at 06:27:31PM +0800, Boqun Feng wrote:
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

Thanks for pushing on this.  PCI_DOMAINS_GENERIC is really not very
generic today and it will be good to make it more so.

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
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

The domain_nr in struct pci_bus is really only used by
pci_domain_nr().  It seems like it really belongs in the struct
pci_host_bridge and probably doesn't need to be duplicated in the
struct pci_bus.  But that's probably a project for the future.

>  #endif
>  
>  	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 540b377ca8f6..952bb7d46576 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -526,6 +526,15 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
>  	return (pdev->error_state != pci_channel_io_normal);
>  }
>  
> +/*
> + * PCI Conventional has at most 256 PCI bus segments and PCI Express has at
> + * most 65536 "PCI Segments Groups", therefore -1 is not a valid PCI domain

s/Segments/Segment/

Do you have a reference for these limits?  I don't think either
Conventional PCI or PCIe actually specifies a hardware limit on the
number of domains (I think PCI uses "segment group" to mean the same
thing).

"Segment" in the Conventional PCI spec, r3.0, means a bus segment,
which connects all the devices on a single bus.  Obviously there's a
limit of 256 buses under a single host bridge, but that's different
concept than a domain/segment group.

The PCI Firmware spec, r3.3, defines "Segment Group Number" as being
in the range 0..65535, but as far as I know, that's just a firmware
issue, and it applies equally to Conventional PCI and PCIe.

I think you're right that -1 is a reasonable sentinel; I just don't
want to claim a difference here unless there really is one.

> + * number, and can be used as a sentinel value indicating ->domain_nr is not
> + * set by the driver (and CONFIG_PCI_DOMAINS_GENERIC=y can set it in generic
> + * code).
> + */
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
