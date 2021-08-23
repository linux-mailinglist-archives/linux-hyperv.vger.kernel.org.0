Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CFF3F484F
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Aug 2021 12:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhHWKKu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Aug 2021 06:10:50 -0400
Received: from foss.arm.com ([217.140.110.172]:51056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233390AbhHWKKu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Aug 2021 06:10:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A338811FB;
        Mon, 23 Aug 2021 03:10:07 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 567103F66F;
        Mon, 23 Aug 2021 03:10:05 -0700 (PDT)
Date:   Mon, 23 Aug 2021 11:10:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 0/8] PCI: hv: Support host bridge probing on ARM64
Message-ID: <20210823100959.GA3294@lpieralisi>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210819141758.GA27305@lpieralisi>
 <YR59KJ+SenbQ58cw@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR59KJ+SenbQ58cw@boqun-archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 19, 2021 at 11:47:52PM +0800, Boqun Feng wrote:
> On Thu, Aug 19, 2021 at 03:17:58PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Jul 27, 2021 at 02:06:49AM +0800, Boqun Feng wrote:
> > > Hi,
> > > 
> > > This is the v6 for the preparation of virtual PCI support on Hyper-V
> > > ARM64, Previous versions:
> > > 
> > > v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
> > > v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
> > > v3:	https://lore.kernel.org/lkml/20210609163211.3467449-1-boqun.feng@gmail.com/
> > > v4:	https://lore.kernel.org/lkml/20210714102737.198432-1-boqun.feng@gmail.com/
> > > v5:	https://lore.kernel.org/lkml/20210720134429.511541-1-boqun.feng@gmail.com/
> > > 
> > > Changes since last version:
> > > 
> > > *	Rebase to 5.14-rc3
> > > 
> > > *	Comment fixes as suggested by Bjorn.
> > > 
> > > The basic problem we need to resolve is that ARM64 is an arch with
> > > PCI_DOMAINS_GENERIC=y, so the bus sysdata is pci_config_window. However,
> > > Hyper-V PCI provides a paravirtualized PCI interface, so there is no
> > > actual pci_config_window for a PCI host bridge, so no information can be
> > > retrieve from the pci_config_window of a Hyper-V virtual PCI bus. Also
> > > there is no corresponding ACPI device for the Hyper-V PCI root bridge,
> > > which introduces a special case when trying to find the ACPI device from
> > > the sysdata (see patch #3).
> > > 
> > > With this patchset, we could enable the virtual PCI on Hyper-V ARM64
> > > guest with other code under development.
> > > 
> > > Comments and suggestions are welcome.
> > > 
> > > Regards,
> > > Boqun
> > > 
> > > Arnd Bergmann (1):
> > >   PCI: hv: Generify PCI probing
> > > 
> > > Boqun Feng (7):
> > >   PCI: Introduce domain_nr in pci_host_bridge
> > >   PCI: Support populating MSI domains of root buses via bridges
> > >   arm64: PCI: Restructure pcibios_root_bridge_prepare()
> > >   arm64: PCI: Support root bridge preparation for Hyper-V
> > >   PCI: hv: Set ->domain_nr of pci_host_bridge at probing time
> > >   PCI: hv: Set up MSI domain at bridge probing time
> > >   PCI: hv: Turn on the host bridge probing on ARM64
> > > 
> > >  arch/arm64/kernel/pci.c             | 29 +++++++---
> > >  drivers/pci/controller/pci-hyperv.c | 86 +++++++++++++++++------------
> > >  drivers/pci/probe.c                 | 12 +++-
> > >  include/linux/pci.h                 | 11 ++++
> > >  4 files changed, 93 insertions(+), 45 deletions(-)
> > 
> > If we take this series via the PCI tree we'd need Catalin/Will ACKs on
> > patches 3-4.
> > 
> 
> Got it.
> 
> > I need some time to look into [1] (thanks for that).
> > 
> > Without [1] patch 8 is ugly, that's no news. The question is whether
> > it is worth waiting for a kernel cycle to integrate [1] into this series
> > or not.
> > 
> > Is it really a problem if we postpone this series for another kernel
> > cycle so that we can look into it ?
> > 
> 
> Well, it's definitely better for me that we can have it in 5.15-rc1 ;-),
> because it's a dependency for Hyper-V virtual PCI support on ARM64 and
> we plan to send the rest of work in 5.15 cycle. And I can just base on
> hyperv-next for the rest of the work if this is in 5.15-rc1. But yes,
> it's not really a problem, since this one still needs to work with other
> patches to support virtual PCI on ARM64 Hyper-V.
> 
> In fact, I personally don't think [1] is better than patch 8 (plus patch
> 3 & 4): playing with ->private seems dangerous and not very helpful on
> readiblity, but I agree that we should explore every potential solution,
> and that's why I send [1].

Pulled the current series - now let's work together to improve it, I
will have a look into [1] in the weeks to come and get back to you with
some feedback.

Thanks,
Lorenzo

> Regards,
> Boqun
> 
> > [1] https://lore.kernel.org/lkml/20210811153619.88922-1-boqun.feng@gmail.com/
