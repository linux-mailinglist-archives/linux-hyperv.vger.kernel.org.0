Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F38372C17
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 May 2021 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhEDOgN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 May 2021 10:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhEDOgN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 May 2021 10:36:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0369B613CC;
        Tue,  4 May 2021 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620138918;
        bh=9ZtBEC0XYgFjUhKlLdRO0G8aZQVeAPm5gU3FvbURgNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h0KOgursxmzw4sVUAVaDfHBs66qmCEIiCjxswvd6kqY3cj2hsRNSF3WvAwJTO286S
         qW+XBOWKnJrcwGa20y7JomKYpbrwSzEKeku4IVjJ7edBkbRDFACKjJsWE1lq1YNURh
         jD7exZS37Q3/EbbTz6RnB+MRoGkRdcKuf/dfUoNEqQ5WBeAFOrlkpuoo4n11V80bF0
         CV5XGbUnfdXR+3IZ5BLSQvh6IqAmsDyB3ADLYtI81EeGYXlKWHVBmSJ1VfDjjp3XAt
         lLoSp/muYSrSTE1u++/VRVj6rAlGteww6J6cJcSTizuKaqRyDJKV1LXSHg48RVzJih
         tJhpXKaJwm52Q==
Received: by mail-ej1-f46.google.com with SMTP id y7so13501590ejj.9;
        Tue, 04 May 2021 07:35:17 -0700 (PDT)
X-Gm-Message-State: AOAM5308EBpE77TPt44FmX4dNHQVYFikal7YzAvJFeOnuRIv+aZdye0K
        cCytKyWczM55CGnnHLuSGmAVn1+LlF1nIUP9Qw==
X-Google-Smtp-Source: ABdhPJwrXSHJlK+c9A8BGCApjGExqZKLfC0iqptDV3LyvQikAcUut5OrhYKxptbz6VWBzAfQFR/aPczv/DY3nVrYeYY=
X-Received: by 2002:a17:907:161e:: with SMTP id hb30mr21030769ejc.360.1620138916277;
 Tue, 04 May 2021 07:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210503144635.2297386-1-boqun.feng@gmail.com>
 <20210503144635.2297386-2-boqun.feng@gmail.com> <YJDYrn7Nt+xyHbyr@kernel.org>
In-Reply-To: <YJDYrn7Nt+xyHbyr@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 May 2021 09:34:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLMAyUEZgLjiKmNL2ioTYJwj-TbTWFJmEi7pynKZHXmoQ@mail.gmail.com>
Message-ID: <CAL_JsqLMAyUEZgLjiKmNL2ioTYJwj-TbTWFJmEi7pynKZHXmoQ@mail.gmail.com>
Subject: Re: [RFC v2 1/7] PCI: Introduce pci_host_bridge::domain_nr
To:     Mike Rapoport <rppt@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 4, 2021 at 12:16 AM Mike Rapoport <rppt@kernel.org> wrote:
>
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
> >                               bridge->sysdata = sys;
> >                               bridge->busnr = sys->busnr;
> >                               bridge->ops = hw->ops;
> > +                             if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> > +                                     bridge->domain_nr = pci_bus_find_domain_nr(sys, parent);
> >
> >                               ret = pci_scan_root_bus_bridge(bridge);
> >                       }
> > diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
> > index ee91ac6b5ebf..92eb8484b49b 100644
> > --- a/arch/arm/mach-dove/pcie.c
> > +++ b/arch/arm/mach-dove/pcie.c
> > @@ -167,6 +167,8 @@ dove_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
> >       bridge->sysdata = sys;
> >       bridge->busnr = sys->busnr;
> >       bridge->ops = &pcie_ops;
> > +     if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> > +             bridge->domain_nr = pci_bus_find_domain_nr(sys, NULL);
>
> The check for CONFIG_PCI_DOMAINS_GENERIC is excessive because there is a
> stub for pci_bus_find_domain_nr().
>
> I'm not an expert in PCI, but maybe the repeated assignment of
> bridge->domain_nr can live in the generic code, say, in
> pci_scan_root_bus_bridge(). E.g. it will set the domain_nr when it is zero.

Yes. There's zero reason h/w drivers should care what the domain_nr is.

There's another issue with domains you should be aware of:

https://lore.kernel.org/linux-pci/20210425152155.mstuxndsoqdbdape@pali/

That may need to be fixed first because deferred probing could cause
the domain to increment each time you retry probe.

Rob
