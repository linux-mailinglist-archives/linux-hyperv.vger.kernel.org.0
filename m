Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE1B3D0642
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 02:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhGUASq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 20:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhGUASl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 20:18:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C2C061574;
        Tue, 20 Jul 2021 17:59:17 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id u7so565454ion.3;
        Tue, 20 Jul 2021 17:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N8UGTVobv7pdWmQ2vwYet8vbuI3Cy9tksvCSmZaqifE=;
        b=SQulmDYHjdtCCYxwxLBmOOS/5aZ4SgPfHeYZAeD6ovEI5hYETGcopo4Al9+PNg+VPF
         YjQu0w7tm7bB7hZ4fRXBr+q4up9Ls9lX+Uofp15fOIlyZJQ6Ysv0Ulu4ZKl5LYk42bS7
         W6ulR3pSmXnc4BjNTTdFpfb/omG4u/h5BrK3SeZTPISQYIz2Se3pmZjBGCphC7D8VTY/
         Wggbdy7pjFhXPCSW/ELnHQgaUfRmYMzDwiQqYGUb2jDdWR08u8EPLjw/8z8fcS4Xcox+
         rEqvpcGg7xH8iRcHevxvh4W1pOFIyekg/IDu+PoUdCWGUK383a5yT+m0Y1SKGTABmrzW
         Z45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N8UGTVobv7pdWmQ2vwYet8vbuI3Cy9tksvCSmZaqifE=;
        b=rsT5t3qI4TsqbifWzlTrKt0aiCAkW+3h+N+Bgz8jdDF3Z2KW+9ijFmo0XZ817/Yrq5
         zPCzdt2o7T8oc2wMRY94j4/LsA9dWKUTMDunHoTdr5MHdgU7jCk5KQw2S5xPmVKHRfDM
         CpVouKyvA2r9x5nIS7KBEtXeD589GO0sc3xeiTSrUFPi6fYIOKeiitMlHUuolJP1Hfti
         otrcIk88Da9I+v18MC+7A2DWzbRFVDCM1HXKX6oXbDbDGAkuVJbOgu27QwMG/tpupel3
         YObTZGql05SiiuF5B2pVXlmJTWK8OhuRI5m2ntBzDWaJKoOkIoyupGdJF8sc88+Xpjda
         Kdiw==
X-Gm-Message-State: AOAM532TyI8aFWfNffxBsbglck/Lx4oB/2vKeL8LY4AdNSWhwH7f8+Uq
        L9Y9kaSOcBRKPrr5tFnsTwQ=
X-Google-Smtp-Source: ABdhPJxwSPLKP/YJWc05noTHMfDpJLfw8xDeBwQLUjT3KLB7v054Yh+y2m4rr/uLeeTYnjLeRp8Usg==
X-Received: by 2002:a6b:e207:: with SMTP id z7mr19528253ioc.111.1626829157144;
        Tue, 20 Jul 2021 17:59:17 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id k4sm933090ilu.67.2021.07.20.17.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 17:59:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9F28E27C005A;
        Tue, 20 Jul 2021 20:59:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 20 Jul 2021 20:59:15 -0400
X-ME-Sender: <xms:YnH3YNNNm04uxJ2PPmQUV1itjUEnLMacYQu5MSLSB1sqvPFC6Shjfg>
    <xme:YnH3YP_QhQDtn4n0WcI9d7i11z-amPhN57WpavUpnpe6GzgZY5DFCY9hqH-sPi7E3
    8Oqv0lnZVAimEBCcw>
X-ME-Received: <xmr:YnH3YMRuMzdIwtP8hRJ4oaTDRySyniqjEemd39BrpYtRv5QcHbs24YBNeMSUwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeefgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:YnH3YJut_Q-oIbvHXidl1mwBdN6p_HagK2gnDBKWvOd464jCwtVaoQ>
    <xmx:YnH3YFfxI2rcgl_8fHiwjZj9gwNuIrsNz0rfSKksKZfx81jr-pkSTw>
    <xmx:YnH3YF2IPOtyzbJT-T4d-JbKPgsdeGw6YjM-Vkw72Q9V5T1RMuhwiA>
    <xmx:Y3H3YGCMbtdmD4ccr9tQKuAs_j_iPFWxTQictWJ2vT_JQjWZS8diF44UyE4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 20:59:14 -0400 (EDT)
Date:   Wed, 21 Jul 2021 08:57:17 +0800
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
Subject: Re: [RFC v5 1/8] PCI: Introduce domain_nr in pci_host_bridge
Message-ID: <YPdw7YMXyFoHDhq4@boqun-archlinux>
References: <20210720134429.511541-2-boqun.feng@gmail.com>
 <20210720224925.GA137627@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720224925.GA137627@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 20, 2021 at 05:49:25PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 20, 2021 at 09:44:22PM +0800, Boqun Feng wrote:
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
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Once all the issues are ironed out, Lorenzo should probably merge this
> since it's primarily Hyper-V stuff, but I'm OK with this part:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 

Thanks!

> But fix the comment issue below.
> 

Just send a v5.1 for this patch with the comment fixed and your
Acked-by.

Regards,
Boqun

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
> >  #endif
> >  
> >  	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 540b377ca8f6..2c413a64d168 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -526,6 +526,15 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
> >  	return (pdev->error_state != pci_channel_io_normal);
> >  }
> >  
> > +/*
> > +* Currently in ACPI spec, for each PCI host bridge, PCI Segment Group number is
> > +* limited to a 16-bit value, therefore (int)-1 is not a valid PCI domain number,
> > +* and can be used as a sentinel value indicating >domain_nr is not set by the
> > +* driver (and CONFIG_PCI_DOMAINS_GENERIC=y archs will set it with
> > +* pci_bus_find_domain_nr()).
> > +*/
> 
> Fix comment indentation (follow style of other comments in this file).
> 
> s/>domain_nr/->domain_nr/
> 
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
