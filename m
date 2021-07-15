Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CCB3CA489
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jul 2021 19:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhGORfc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jul 2021 13:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbhGORfb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jul 2021 13:35:31 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4029EC06175F;
        Thu, 15 Jul 2021 10:32:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id gh6so3230888qvb.3;
        Thu, 15 Jul 2021 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZMhm9Q1ft2ZuJHnsgYob9UiHLcsqHs1PTnUjZmty0Ss=;
        b=de2SvrF1oRHJ1RaUTUgDxztdq/aLJitMAt74d4K3e+TPceDirxz+g7MUVorInP8RCe
         n4Y/Wh8ocWciGZp/lgpKTFdM8CQTP8iquH75D7ETaN4eGuQ8CG2fQga5yawfHzjH46is
         geb98vOpP6lOVVVCq+WvVQfxyNb7mJwi7Fe17kojvJXI+mSKSDoRcinUg1Ywz+Mnh6HL
         ujVKAhBjfkiBuUHKAQx1P3ko4Fyf9zR70NH8PRPybe/xXdgkfHG4LDx8GabXdHjliuGV
         ubFDcwe/v5npezWOmPbfvrGu5rXaoigwILGnDu0HFBtUtFhmzxt/QQ/RmqZkd3redq+p
         vYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZMhm9Q1ft2ZuJHnsgYob9UiHLcsqHs1PTnUjZmty0Ss=;
        b=WsOqVeFAowF5x6FIP8pabpo8DONmOt09qtjW6Zwyl5DL7U5vIdHrkiSsiLyjcspRSb
         Q5ShjYWp9x4T9VtBiBgeasc8iuov8ohxYjwLqFRUMfIG8mcKbJIc5dfCbIDOvvmZ5T5W
         5t9aw97WvWJW8hhzb+LesQnTZ7NWE/nn5U6qGERYooZIJqTF6Wwgc8/aSs8OC8/KUbc3
         zYWmGBu9J60E4wuDWN6D6utuKM7zKL3jjLHZDBWaYumKDN6iIbU6L9oy6g5ySX7GyZAf
         YPKOGrI9ADkymDcB4Wi0p++gnxbcyT+V2NA6yPMnDFwFOzwFsAUjry8X+O51pz5oFhPQ
         4zBw==
X-Gm-Message-State: AOAM533PfjSpjGdtRSbBUNMnjGyU+8CGCkVnh90jZ10FlMj05DzcIvwP
        CkF2T1BsmFutxJL/dSF+ecc=
X-Google-Smtp-Source: ABdhPJzKHeH+osOcaM58zeKsiokt6uEE3J17OoNO8AREwf9A+BMGPyp6zlg0BpheemYCI32KDnDO2A==
X-Received: by 2002:ad4:5343:: with SMTP id v3mr5422776qvs.45.1626370357369;
        Thu, 15 Jul 2021 10:32:37 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p21sm2801615qki.36.2021.07.15.10.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 10:32:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id E4C6E27C005A;
        Thu, 15 Jul 2021 13:32:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Jul 2021 13:32:35 -0400
X-ME-Sender: <xms:M3HwYIAN0PR7g0_40VYCKzYo8y5tH4Iva0qBf2_P-KPi8eUJLyZDlA>
    <xme:M3HwYKjbrOLoP_Ot813QT8wFXwN5DhXR6S5ZXh0bMyoSJieWMTrFfwGDo5TAUOJ9P
    -MHnpnq8L_3qGWvTw>
X-ME-Received: <xmr:M3HwYLnOMvf1qXvbEs6ylWTZYNJJPfEEaEkddjTWZjOJdktyuQruOueeT6G2MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:M3HwYOymyysziTxpCE0cwXUtYcbZH_bdRBVkOWGV0kdZCvY97FdX8g>
    <xmx:M3HwYNTegWM2MP_61k8YLADy8nvalcUicTErG9eMU5Ro45NEL1ix4w>
    <xmx:M3HwYJb01NDLjj17HywZ3Vadhl3oLzDX2pN6CtKJocxkRRC-iyWy_w>
    <xmx:M3HwYPkuKHLTL0P9oBpTbjpRmfWYUsJ-UrGs6XL4J_K1z0cO26FPAagA1VY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jul 2021 13:32:34 -0400 (EDT)
Date:   Fri, 16 Jul 2021 01:30:52 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <YPBwzO7c/rw09IkE@boqun-archlinux>
References: <20210714102737.198432-2-boqun.feng@gmail.com>
 <20210714193319.GA1867593@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714193319.GA1867593@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 14, 2021 at 02:33:19PM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 14, 2021 at 06:27:31PM +0800, Boqun Feng wrote:
> > Currently we retrieve the PCI domain number of the host bridge from the
> > bus sysdata (or pci_config_window if PCI_DOMAINS_GENERIC=y). Actually
> > we have the information at PCI host bridge probing time, and it makes
> > sense that we store it into pci_host_bridge. One benefit of doing so is
> > the requirement for supporting PCI on Hyper-V for ARM64, because the
> > host bridge of Hyper-V doesn't have pci_config_window, whereas ARM64 is
> > a PCI_DOMAINS_GENERIC=y arch, so we cannot retrieve the PCI domain
> > number from pci_config_window on ARM64 Hyper-V guest.
> > 
> > As the preparation for ARM64 Hyper-V PCI support, we introduce the
> > domain_nr in pci_host_bridge and a sentinel value to allow drivers to
> > set domain numbers properly at probing time. Currently
> > CONFIG_PCI_DOMAINS_GENERIC=y archs are only users of this
> > newly-introduced field.
> 
> Thanks for pushing on this.  PCI_DOMAINS_GENERIC is really not very
> generic today and it will be good to make it more so.
> 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  drivers/pci/probe.c |  6 +++++-
> >  include/linux/pci.h | 10 ++++++++++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 79177ac37880..60c50d4f156f 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -594,6 +594,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
> >  	bridge->native_pme = 1;
> >  	bridge->native_ltr = 1;
> >  	bridge->native_dpc = 1;
> > +	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
> >  
> >  	device_initialize(&bridge->dev);
> >  }
> > @@ -898,7 +899,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >  	bus->ops = bridge->ops;
> >  	bus->number = bus->busn_res.start = bridge->busnr;
> >  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> > -	bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> > +	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
> > +		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> > +	else
> > +		bus->domain_nr = bridge->domain_nr;
> 
> The domain_nr in struct pci_bus is really only used by
> pci_domain_nr().  It seems like it really belongs in the struct
> pci_host_bridge and probably doesn't need to be duplicated in the
> struct pci_bus.  But that's probably a project for the future.
> 

Agreed. Maybe we can define pci_bus_domain_nr() as:

	static inline int pci_domain_nr(struct pci_bus *bus)
	{
		struct device *bridge = bus->bridge;
		struct pci_host_bridge *b = container_of(bridge, struct pci_host_bridge, dev);

		return b->domain_nr;
	}

but apart from corretness (e.g. should we use get_device() for
bus->bridge?), it makes more sense if ->domain_nr of pci_host_bridge
is used (as a way to set domain number at probing time) for most of
drivers and archs. ;-)

> >  #endif
> >  
> >  	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 540b377ca8f6..952bb7d46576 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -526,6 +526,15 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
> >  	return (pdev->error_state != pci_channel_io_normal);
> >  }
> >  
> > +/*
> > + * PCI Conventional has at most 256 PCI bus segments and PCI Express has at
> > + * most 65536 "PCI Segments Groups", therefore -1 is not a valid PCI domain
> 
> s/Segments/Segment/
> 
> Do you have a reference for these limits?  I don't think either
> Conventional PCI or PCIe actually specifies a hardware limit on the
> number of domains (I think PCI uses "segment group" to mean the same
> thing).
> 
> "Segment" in the Conventional PCI spec, r3.0, means a bus segment,
> which connects all the devices on a single bus.  Obviously there's a
> limit of 256 buses under a single host bridge, but that's different
> concept than a domain/segment group.
> 
> The PCI Firmware spec, r3.3, defines "Segment Group Number" as being
> in the range 0..65535, but as far as I know, that's just a firmware
> issue, and it applies equally to Conventional PCI and PCIe.
> 
> I think you're right that -1 is a reasonable sentinel; I just don't
> want to claim a difference here unless there really is one.
> 

I think you're right, I got confused on the concepts of "Segment" and
"Segment Group".

After digging in specs, I haven't find any difference on the limitation
between Conventional PCI and PCIe. The PCI Firmware spec, r3.2, refers
ACPI (3.0 and later) spec for the details of "Segment Group", and in
ACPI spec v6.3, the description _SEG object says:

"""
The lower 16 bits of _SEG returned integer is the PCI Segment Group
number. Other bits are reserved.
"""

So I'm thinking replacing the comments with:

Currently in ACPI spec, for each PCI host bridge, PCI Segment Group
number is limited to a 16-bit value, therefore (int)-1 is not a valid
PCI domain number, and can be used as a sentinel value indicating
->domain_nr is not set by the driver (and CONFIG_PCI_DOMAINS_GENERIC=y
archs will set it with pci_bus_find_domain_nr()).

Thoughts?

Regards,
BOqun

> > + * number, and can be used as a sentinel value indicating ->domain_nr is not
> > + * set by the driver (and CONFIG_PCI_DOMAINS_GENERIC=y can set it in generic
> > + * code).
> > + */
> > +#define PCI_DOMAIN_NR_NOT_SET (-1)
> > +
> >  struct pci_host_bridge {
> >  	struct device	dev;
> >  	struct pci_bus	*bus;		/* Root bus */
> > @@ -533,6 +542,7 @@ struct pci_host_bridge {
> >  	struct pci_ops	*child_ops;
> >  	void		*sysdata;
> >  	int		busnr;
> > +	int		domain_nr;
> >  	struct list_head windows;	/* resource_entry */
> >  	struct list_head dma_ranges;	/* dma ranges resource list */
> >  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
> > -- 
> > 2.30.2
> > 
