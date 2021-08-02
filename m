Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B569C3DE2D6
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Aug 2021 01:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhHBXFa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Aug 2021 19:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhHBXF3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Aug 2021 19:05:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81F5660D07;
        Mon,  2 Aug 2021 23:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627945519;
        bh=WUIcSBQjSgJB67+np/uRZK+3HKPV7Ij1i4amc4Hm1bU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FiY6NWvHhG9xX44PQGg0eaU6mL/wf2FLhT7l5+qlEXztPvht1b16J/6cnwMX88aO5
         MJG9lyK2U6G0OgiuFLOPd2JaLXTiNW5UG4ePAIdNiZyFjKU65iegHG+JxxXjw2fqnB
         DWeZTvuqHyWe/qrYqetgU9TyHGaSf4xX4RFFUR6oxfGtNutU8oZrTNr4kvKcYhDNSZ
         4suu6Wk0rfplZTni+mBnbmwwoG4jzTuI2WMBtP8eHn/wE89OWE5Fh2b9LnePIEBSht
         Y1cc3vKzvAEcde3nJqz9VBCzw2OsHwyM9ztVmcumOXP1m4pG/uSYlr+6KpyY1oZzsE
         BZK4DkAHE1TXw==
Date:   Mon, 2 Aug 2021 18:05:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <20210802230518.GA1473900@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQepiKkFoJHC0gsK@boqun-archlinux>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 02, 2021 at 04:15:04PM +0800, Boqun Feng wrote:
> On Tue, Jul 27, 2021 at 02:06:49AM +0800, Boqun Feng wrote:
> > Hi,
> > 
> > This is the v6 for the preparation of virtual PCI support on Hyper-V
> > ARM64, Previous versions:
> > 
> > v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
> > v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
> > v3:	https://lore.kernel.org/lkml/20210609163211.3467449-1-boqun.feng@gmail.com/
> > v4:	https://lore.kernel.org/lkml/20210714102737.198432-1-boqun.feng@gmail.com/
> > v5:	https://lore.kernel.org/lkml/20210720134429.511541-1-boqun.feng@gmail.com/
> > 
> > Changes since last version:
> > 
> > *	Rebase to 5.14-rc3
> > 
> > *	Comment fixes as suggested by Bjorn.
> > 
> > The basic problem we need to resolve is that ARM64 is an arch with
> > PCI_DOMAINS_GENERIC=y, so the bus sysdata is pci_config_window. However,
> > Hyper-V PCI provides a paravirtualized PCI interface, so there is no
> > actual pci_config_window for a PCI host bridge, so no information can be
> > retrieve from the pci_config_window of a Hyper-V virtual PCI bus. Also
> > there is no corresponding ACPI device for the Hyper-V PCI root bridge,
> > which introduces a special case when trying to find the ACPI device from
> > the sysdata (see patch #3).
> > 
> > With this patchset, we could enable the virtual PCI on Hyper-V ARM64
> > guest with other code under development.
> > 
> > Comments and suggestions are welcome.
> 
> Ping ;-)

Lorenzo normally takes care of the native drivers (including Hyper-V),
so I don't want to get in his way.  If he's too busy and doesn't get a
chance, poke me again after -rc6 or so and I'll pick it up.

> > Arnd Bergmann (1):
> >   PCI: hv: Generify PCI probing
> > 
> > Boqun Feng (7):
> >   PCI: Introduce domain_nr in pci_host_bridge
> >   PCI: Support populating MSI domains of root buses via bridges
> >   arm64: PCI: Restructure pcibios_root_bridge_prepare()
> >   arm64: PCI: Support root bridge preparation for Hyper-V
> >   PCI: hv: Set ->domain_nr of pci_host_bridge at probing time
> >   PCI: hv: Set up MSI domain at bridge probing time
> >   PCI: hv: Turn on the host bridge probing on ARM64
> > 
> >  arch/arm64/kernel/pci.c             | 29 +++++++---
> >  drivers/pci/controller/pci-hyperv.c | 86 +++++++++++++++++------------
> >  drivers/pci/probe.c                 | 12 +++-
> >  include/linux/pci.h                 | 11 ++++
> >  4 files changed, 93 insertions(+), 45 deletions(-)
> > 
> > -- 
> > 2.32.0
> > 
