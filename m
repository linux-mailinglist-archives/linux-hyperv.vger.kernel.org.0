Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCAE3CAA07
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jul 2021 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbhGOTLo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jul 2021 15:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243994AbhGOTKa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jul 2021 15:10:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2816A613D6;
        Thu, 15 Jul 2021 19:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626376051;
        bh=sNwJPcMC4QHZVtTwEA0KWkXpkqmHuuMfLW28ut1gRlo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YRQ9qY9riX+H9uGE48Q11ANNmQX79yEVzhj5hp7YkisprzIC5SpGEajSSG1GVBapR
         nMjgtIsvcPPdg1XqGZCiyN1Wi7R4NrAL2O3jS+M4Nj6IlpsMqE7zH31rJkdYv3GDnq
         oEdK2m8npftI+EfYlODmgowIoJ8tpqJUbwdj013sP7i4FlKp6zpk4tda5wJqzwEpoK
         y2R6ypvS2HgSw6Vdy10l4kIOyayMrk4X2iKaG0vcxjLjwF6uvckXXKv2oPdWAwlKkH
         1t92NZepjI77mBoqFKqDBE4OFjWDFSawmXSxAjkbL5z4RsSqIpcFGFV0mRIjyLRfFA
         oYyj7ilLzJkMQ==
Date:   Thu, 15 Jul 2021 14:07:29 -0500
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
Message-ID: <20210715190729.GA1986347@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPBwzO7c/rw09IkE@boqun-archlinux>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 16, 2021 at 01:30:52AM +0800, Boqun Feng wrote:
> On Wed, Jul 14, 2021 at 02:33:19PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jul 14, 2021 at 06:27:31PM +0800, Boqun Feng wrote:
> > > Currently we retrieve the PCI domain number of the host bridge from the
> > > bus sysdata (or pci_config_window if PCI_DOMAINS_GENERIC=y). Actually
> > > we have the information at PCI host bridge probing time, and it makes
> > > sense that we store it into pci_host_bridge. One benefit of doing so is
> > > the requirement for supporting PCI on Hyper-V for ARM64, because the
> > > host bridge of Hyper-V doesn't have pci_config_window, whereas ARM64 is
> > > a PCI_DOMAINS_GENERIC=y arch, so we cannot retrieve the PCI domain
> > > number from pci_config_window on ARM64 Hyper-V guest.
> > > 
> > > As the preparation for ARM64 Hyper-V PCI support, we introduce the
> > > domain_nr in pci_host_bridge and a sentinel value to allow drivers to
> > > set domain numbers properly at probing time. Currently
> > > CONFIG_PCI_DOMAINS_GENERIC=y archs are only users of this
> > > newly-introduced field.
> > 
> > Thanks for pushing on this.  PCI_DOMAINS_GENERIC is really not very
> > generic today and it will be good to make it more so.
> > 
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  drivers/pci/probe.c |  6 +++++-
> > >  include/linux/pci.h | 10 ++++++++++
> > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 79177ac37880..60c50d4f156f 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -594,6 +594,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
> > >  	bridge->native_pme = 1;
> > >  	bridge->native_ltr = 1;
> > >  	bridge->native_dpc = 1;
> > > +	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
> > >  
> > >  	device_initialize(&bridge->dev);
> > >  }
> > > @@ -898,7 +899,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> > >  	bus->ops = bridge->ops;
> > >  	bus->number = bus->busn_res.start = bridge->busnr;
> > >  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> > > -	bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> > > +	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
> > > +		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> > > +	else
> > > +		bus->domain_nr = bridge->domain_nr;
> > 
> > The domain_nr in struct pci_bus is really only used by
> > pci_domain_nr().  It seems like it really belongs in the struct
> > pci_host_bridge and probably doesn't need to be duplicated in the
> > struct pci_bus.  But that's probably a project for the future.
> 
> Agreed. Maybe we can define pci_bus_domain_nr() as:
> 
> 	static inline int pci_domain_nr(struct pci_bus *bus)
> 	{
> 		struct device *bridge = bus->bridge;
> 		struct pci_host_bridge *b = container_of(bridge, struct pci_host_bridge, dev);
> 
> 		return b->domain_nr;
> 	}
> 
> but apart from corretness (e.g. should we use get_device() for
> bus->bridge?), it makes more sense if ->domain_nr of pci_host_bridge
> is used (as a way to set domain number at probing time) for most of
> drivers and archs. ;-)

If we're holding a struct pci_bus *, we must have a reference on the
bus, which in turn holds a reference on upstream devices, so there
should be no need for get_device() here.

But yes, I think something like this is where we should be heading.

> > >  #endif
> > >  
> > >  	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 540b377ca8f6..952bb7d46576 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -526,6 +526,15 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
> > >  	return (pdev->error_state != pci_channel_io_normal);
> > >  }
> > >  
> > > +/*
> > > + * PCI Conventional has at most 256 PCI bus segments and PCI Express has at
> > > + * most 65536 "PCI Segments Groups", therefore -1 is not a valid PCI domain
> > 
> > s/Segments/Segment/
> > 
> > Do you have a reference for these limits?  I don't think either
> > Conventional PCI or PCIe actually specifies a hardware limit on the
> > number of domains (I think PCI uses "segment group" to mean the same
> > thing).
> > 
> > "Segment" in the Conventional PCI spec, r3.0, means a bus segment,
> > which connects all the devices on a single bus.  Obviously there's a
> > limit of 256 buses under a single host bridge, but that's different
> > concept than a domain/segment group.
> > 
> > The PCI Firmware spec, r3.3, defines "Segment Group Number" as being
> > in the range 0..65535, but as far as I know, that's just a firmware
> > issue, and it applies equally to Conventional PCI and PCIe.
> > 
> > I think you're right that -1 is a reasonable sentinel; I just don't
> > want to claim a difference here unless there really is one.
> > 
> 
> I think you're right, I got confused on the concepts of "Segment" and
> "Segment Group".
> 
> After digging in specs, I haven't find any difference on the limitation
> between Conventional PCI and PCIe. The PCI Firmware spec, r3.2, refers
> ACPI (3.0 and later) spec for the details of "Segment Group", and in
> ACPI spec v6.3, the description _SEG object says:
> 
> """
> The lower 16 bits of _SEG returned integer is the PCI Segment Group
> number. Other bits are reserved.
> """
> 
> So I'm thinking replacing the comments with:
> 
> Currently in ACPI spec, for each PCI host bridge, PCI Segment Group
> number is limited to a 16-bit value, therefore (int)-1 is not a valid
> PCI domain number, and can be used as a sentinel value indicating
> ->domain_nr is not set by the driver (and CONFIG_PCI_DOMAINS_GENERIC=y
> archs will set it with pci_bus_find_domain_nr()).

Yes, I think that's a better description.

> > > + * number, and can be used as a sentinel value indicating ->domain_nr is not
> > > + * set by the driver (and CONFIG_PCI_DOMAINS_GENERIC=y can set it in generic
> > > + * code).
