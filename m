Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92F237529F
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 May 2021 12:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhEFKxw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 May 2021 06:53:52 -0400
Received: from foss.arm.com ([217.140.110.172]:32996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234508AbhEFKxv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 May 2021 06:53:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89FF4D6E;
        Thu,  6 May 2021 03:52:53 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BD663F73B;
        Thu,  6 May 2021 03:52:50 -0700 (PDT)
Date:   Thu, 6 May 2021 11:52:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
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
Message-ID: <20210506105245.GA26351@lpieralisi>
References: <20210503144635.2297386-1-boqun.feng@gmail.com>
 <20210503144635.2297386-2-boqun.feng@gmail.com>
 <YJDYrn7Nt+xyHbyr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJDYrn7Nt+xyHbyr@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 04, 2021 at 08:16:30AM +0300, Mike Rapoport wrote:
> On Mon, May 03, 2021 at 10:46:29PM +0800, Boqun Feng wrote:
> > Currently we retrieve the PCI domain number of the host bridge from the
> > bus sysdata (or pci_config_window if PCI_DOMAINS_GENERIC=y). Actually
> > we have the information at PCI host bridge probing time, and it makes
> > sense that we store it into pci_host_bridge. One benefit of doing so is
> > the requirement for supporting PCI on Hyper-V for ARM64, because the
> > host bridge of Hyper-V doesnt' have pci_config_window, whereas ARM64 is
> > a PCI_DOMAINS_GENERIC=y arch, so we cannot retrieve the PCI domain
> > number from pci_config_window on ARM64 Hyper-V guest.
> > 
> > As the preparation for ARM64 Hyper-V PCI support, we introduce the
> > domain_nr in pci_host_bridge, and set it properly at probing time, then
> > for PCI_DOMAINS_GENERIC=y archs, bus domain numbers are set by the
> > bridge domain_nr.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  arch/arm/kernel/bios32.c              |  2 ++
> >  arch/arm/mach-dove/pcie.c             |  2 ++
> >  arch/arm/mach-mv78xx0/pcie.c          |  2 ++
> >  arch/arm/mach-orion5x/pci.c           |  2 ++
> >  arch/arm64/kernel/pci.c               |  3 +--
> >  arch/mips/pci/pci-legacy.c            |  2 ++
> >  arch/mips/pci/pci-xtalk-bridge.c      |  2 ++
> >  drivers/pci/controller/pci-ftpci100.c |  2 ++
> >  drivers/pci/controller/pci-mvebu.c    |  2 ++
> >  drivers/pci/pci.c                     |  4 ++--
> >  drivers/pci/probe.c                   |  7 ++++++-
> >  include/linux/pci.h                   | 11 ++++++++---
> >  12 files changed, 33 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> > index e7ef2b5bea9c..4942cd681e41 100644
> > --- a/arch/arm/kernel/bios32.c
> > +++ b/arch/arm/kernel/bios32.c
> > @@ -471,6 +471,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
> >  				bridge->sysdata = sys;
> >  				bridge->busnr = sys->busnr;
> >  				bridge->ops = hw->ops;
> > +				if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> > +					bridge->domain_nr = pci_bus_find_domain_nr(sys, parent);
> >  
> >  				ret = pci_scan_root_bus_bridge(bridge);
> >  			}
> > diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
> > index ee91ac6b5ebf..92eb8484b49b 100644
> > --- a/arch/arm/mach-dove/pcie.c
> > +++ b/arch/arm/mach-dove/pcie.c
> > @@ -167,6 +167,8 @@ dove_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
> >  	bridge->sysdata = sys;
> >  	bridge->busnr = sys->busnr;
> >  	bridge->ops = &pcie_ops;
> > +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> > +		bridge->domain_nr = pci_bus_find_domain_nr(sys, NULL);
> 
> The check for CONFIG_PCI_DOMAINS_GENERIC is excessive because there is a
> stub for pci_bus_find_domain_nr().
> 
> I'm not an expert in PCI, but maybe the repeated assignment of
> bridge->domain_nr can live in the generic code, say, in
> pci_scan_root_bus_bridge(). E.g. it will set the domain_nr when it is zero.
> 
> >  

Yes, this churn should be avoided. We need a sentinel value to detect
whether the domain_nr is invalid (0 is a valid domain) so generic code
(ie pci_scan_root_bus_bridge() and friends) has to call generic
functions to get it (pci_bus_find_domain_nr()).

We can implement it as a flag or function pointer in the struct
pci_host_bridge, if the flag or function pointer is not set the
generic pci_bus_find_domain_nr() should be called.

Lorenzo
