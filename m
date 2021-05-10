Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB0A379038
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 May 2021 16:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhEJOJE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 May 2021 10:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243049AbhEJOEO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 May 2021 10:04:14 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A09C0611AB;
        Mon, 10 May 2021 06:45:48 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id y12so11894900qtx.11;
        Mon, 10 May 2021 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7gTa/KU61SCbpawixr56ADN3pbVcG3JzGmoebhrvpHw=;
        b=aEisdBkO8Ejg+1aLd4Ky8GD3gyudMa4hmww6eAy6V1IU9vWdAEoeI+YDNHyNqd6ffL
         NPd7ugA8EAIEC2ksc9TgNLhP/kn1im//7/QmSEYU+5cBc8f3AGYR69JT4bMHxGgTix0d
         Xjwhf7prn26/bUQkjOY2JPiU4BjEzm3utPnYFUK3XdqJypgJs1WUfHxaiXsRZP4YkICI
         ucS9BqBGHK2gvEfhUABhqu9tZ2z5sxqHCeEt8jAb5VM1gYCDkJPeROw5OSa2M1DuxrF/
         AO33LCCCoLbb2MD9FNVfpFZO9yZxUz9AuiLPZfbPsgUmVGsvF9TtjL3+8eSdCWg9aoUa
         Sxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gTa/KU61SCbpawixr56ADN3pbVcG3JzGmoebhrvpHw=;
        b=MuD1ku2z1WH2zL7Pg9h0qXCCPe66xwfau0CPjzQk/hahhPTjSnmwWFlmtYn9grHGVL
         ODqvAMeGlcsbBDta2KmpWMBXpR7sz2fsAktPfdM0fFkJCo9dKPyaOzBWN50pMrrYtS6e
         1PZw7U7apa7o0gwKd0VJ3xxKCGFq+ReStChHvu9ZmgDcP3Jz5cQqo38MjobbaXRQk8F+
         iQVmOhUrbaVTPHQ+ZNhpfWsaFZEJFY2b8HNTqa3SumOmQMmsCP06NamQS93ZUTG6D7Im
         JQZl6J16lFyB3zWFE7TMgTjGahu9h3v9HZebt4FPaUNsI80uwq8gNdLASOhASEb8/wgS
         7XWQ==
X-Gm-Message-State: AOAM532DTVelmPkcSjYRO3ZaiKg5f5hF6HBrqfAjYAUSAXQR0hh9lCjp
        yZYprWaCiWlqTsHHrqrjW4w=
X-Google-Smtp-Source: ABdhPJxgDG01K5Wuy2Yemuvp4LqfaEyDNljtjpiUJQDvwef5QrL2uAnbsAY1zhBmbHjffOs7Qf8KUQ==
X-Received: by 2002:ac8:5751:: with SMTP id 17mr5781697qtx.389.1620654347496;
        Mon, 10 May 2021 06:45:47 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 28sm6499608qkr.36.2021.05.10.06.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 06:45:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id EF69B27C0054;
        Mon, 10 May 2021 09:45:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 10 May 2021 09:45:45 -0400
X-ME-Sender: <xms:BzmZYEx2giazz1RApWzdF9h29AbZi4T_NKXKY2e0tNnucYWuR-JaaQ>
    <xme:BzmZYITC2tlDSOeq6NTuZQb02ew9q3nVQW3qxfhlLstzsAIpIekA3k6-1_lakhxi6
    5FmWkqun5JKds8SSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegkedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepffeiteevgefgueduuedvtefgvddvtdegkeeuvdehfeeuvefhleehhfejffeu
    tdeknecuffhomhgrihhnpehoshguvghvrdhorhhgnecukfhppedufedurddutdejrdduge
    ejrdduvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghe
    dtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhes
    fhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:BzmZYGXC9w20ZqKxWk1wi1h6Gar17smPpKFaVMDpZFDxd9acTdXR9g>
    <xmx:BzmZYCjvI5vaHf9q8CKINDZnWA582gBGlh8ckMFlXvIWBOR43XiqwQ>
    <xmx:BzmZYGCITryQS7ec-lgkQsfZtZNPyKHdGWPzeDSgHx_CzoiHwsxQAg>
    <xmx:CTmZYBYpMiIsQKFQq4Na7TihMz17uoOUiaizfFUketxUBHWajH5N9jqzk-GN99fs>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 10 May 2021 09:45:43 -0400 (EDT)
Date:   Mon, 10 May 2021 21:44:29 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
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
Message-ID: <YJk4vdJnOxHvlFLT@boqun-archlinux>
References: <20210503144635.2297386-1-boqun.feng@gmail.com>
 <20210503144635.2297386-2-boqun.feng@gmail.com>
 <YJDYrn7Nt+xyHbyr@kernel.org>
 <20210506105245.GA26351@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506105245.GA26351@lpieralisi>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

[Copy Rob]

On Thu, May 06, 2021 at 11:52:45AM +0100, Lorenzo Pieralisi wrote:
> On Tue, May 04, 2021 at 08:16:30AM +0300, Mike Rapoport wrote:
> > On Mon, May 03, 2021 at 10:46:29PM +0800, Boqun Feng wrote:
> > > Currently we retrieve the PCI domain number of the host bridge from the
> > > bus sysdata (or pci_config_window if PCI_DOMAINS_GENERIC=y). Actually
> > > we have the information at PCI host bridge probing time, and it makes
> > > sense that we store it into pci_host_bridge. One benefit of doing so is
> > > the requirement for supporting PCI on Hyper-V for ARM64, because the
> > > host bridge of Hyper-V doesnt' have pci_config_window, whereas ARM64 is
> > > a PCI_DOMAINS_GENERIC=y arch, so we cannot retrieve the PCI domain
> > > number from pci_config_window on ARM64 Hyper-V guest.
> > > 
> > > As the preparation for ARM64 Hyper-V PCI support, we introduce the
> > > domain_nr in pci_host_bridge, and set it properly at probing time, then
> > > for PCI_DOMAINS_GENERIC=y archs, bus domain numbers are set by the
> > > bridge domain_nr.
> > > 
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  arch/arm/kernel/bios32.c              |  2 ++
> > >  arch/arm/mach-dove/pcie.c             |  2 ++
> > >  arch/arm/mach-mv78xx0/pcie.c          |  2 ++
> > >  arch/arm/mach-orion5x/pci.c           |  2 ++
> > >  arch/arm64/kernel/pci.c               |  3 +--
> > >  arch/mips/pci/pci-legacy.c            |  2 ++
> > >  arch/mips/pci/pci-xtalk-bridge.c      |  2 ++
> > >  drivers/pci/controller/pci-ftpci100.c |  2 ++
> > >  drivers/pci/controller/pci-mvebu.c    |  2 ++
> > >  drivers/pci/pci.c                     |  4 ++--
> > >  drivers/pci/probe.c                   |  7 ++++++-
> > >  include/linux/pci.h                   | 11 ++++++++---
> > >  12 files changed, 33 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> > > index e7ef2b5bea9c..4942cd681e41 100644
> > > --- a/arch/arm/kernel/bios32.c
> > > +++ b/arch/arm/kernel/bios32.c
> > > @@ -471,6 +471,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
> > >  				bridge->sysdata = sys;
> > >  				bridge->busnr = sys->busnr;
> > >  				bridge->ops = hw->ops;
> > > +				if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> > > +					bridge->domain_nr = pci_bus_find_domain_nr(sys, parent);
> > >  
> > >  				ret = pci_scan_root_bus_bridge(bridge);
> > >  			}
> > > diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
> > > index ee91ac6b5ebf..92eb8484b49b 100644
> > > --- a/arch/arm/mach-dove/pcie.c
> > > +++ b/arch/arm/mach-dove/pcie.c
> > > @@ -167,6 +167,8 @@ dove_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
> > >  	bridge->sysdata = sys;
> > >  	bridge->busnr = sys->busnr;
> > >  	bridge->ops = &pcie_ops;
> > > +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> > > +		bridge->domain_nr = pci_bus_find_domain_nr(sys, NULL);
> > 
> > The check for CONFIG_PCI_DOMAINS_GENERIC is excessive because there is a
> > stub for pci_bus_find_domain_nr().
> > 
> > I'm not an expert in PCI, but maybe the repeated assignment of
> > bridge->domain_nr can live in the generic code, say, in
> > pci_scan_root_bus_bridge(). E.g. it will set the domain_nr when it is zero.
> > 
> > >  
> 
> Yes, this churn should be avoided. We need a sentinel value to detect
> whether the domain_nr is invalid (0 is a valid domain) so generic code
> (ie pci_scan_root_bus_bridge() and friends) has to call generic
> functions to get it (pci_bus_find_domain_nr()).
> 

Agreed. Thank you all for the inputs.

According to [1], "PCI Conventional" has at most 256 PCI bus segments
and "PCI Express" has at most 65536 "PCI Segments Groups", so any value
outside [0, 65536] can be used as a sentinel. I'm planning to use -1
like:

	#define PCI_DOMAIN_NR_NOT_SET (-1)

	(in pci_alloc_host_bridge())
	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;

	(in pci_register_host_bridge())
	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
		bridge->domain_nr = pci_bus_find_domain_nr(...);

Thoughts?

Regards,
Boqun

[1]: https://wiki.osdev.org/PCI_Express

> We can implement it as a flag or function pointer in the struct
> pci_host_bridge, if the flag or function pointer is not set the
> generic pci_bus_find_domain_nr() should be called.
> 
> Lorenzo
