Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB103F4B1A
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Aug 2021 14:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbhHWMvC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Aug 2021 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbhHWMu7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Aug 2021 08:50:59 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C12C061575;
        Mon, 23 Aug 2021 05:50:17 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y3so16950337ilm.6;
        Mon, 23 Aug 2021 05:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VPzksKty3A4TUierulaauv6YuTc0B2NCbgGdnxjAqY8=;
        b=ZKn4RmS/glCDdKY7PtRfK3n9BUmbxCmeL6xz5XPoHa7SKRzDKgTPMbwOl43BN1tRwi
         gIuaMXpw9d5M/mpnPn/slke0UCAuo8faZLrtrKFLba3vimWRi9/iKavCjVgBUHg1H1uu
         qfg/HSdqTB70GaWkbEY9Bszapu3g+iRs3766JYAJGyc/W79kps42IazvWTymOoWRPPUi
         mc9SmHunkrpzUzzeuqUABOdfEx7qDAb1UK54514tvIFncLJCUR6dJCGfY1Y+2qIB+Gjn
         2PtBL09brxn1LRm5jLtCN5dJdb9a2SP6NCBhGZjUF1b0FGyz6ICta1wMyi17jFgGo5UO
         pEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VPzksKty3A4TUierulaauv6YuTc0B2NCbgGdnxjAqY8=;
        b=eNoYEJjmkm+uvEEYvSRyEVooQQwQthB7owaEK/VuOX0/UHqneZawAYS9V0XFu+AP9c
         ztPAcct7xq9hp5W4pAHQAF0f6r6j9JxVe84rq+AY0rSvcTAF+lpvcYoVXv7rqFhXMRs2
         WyvnOcl0ook2ArPLykNwC2AOQh/HxQETrEc+riWh6wUFkRsp79I6Sdc/VBBvVQcKWwwk
         WA706ED2i1MxduYOeLxqmbzCpYtolbPVqnySsrDHc93KRrsoPGGM/QVZ/V14DQB7+5a5
         qrfzKMN7Rk8OMQTtfrvLD4r/XbjnMhs715UjQEXLeOu46/u+uQyecxzdwjGV5A+vgHH0
         rVag==
X-Gm-Message-State: AOAM533wrVYar2lJB3wRW1md2NrTEKhMVmqkOYHffVkssK4je0PGHOnh
        j9mxir41UVlu/GbwvLXKaNY=
X-Google-Smtp-Source: ABdhPJxysw9OeHyg8gZEzMvPOrCENKKPOAm+O8dwpLtmCAlWG717JRffa0hVYZ+Oi1BFDl/VieXPNQ==
X-Received: by 2002:a92:7114:: with SMTP id m20mr16671435ilc.114.1629723016794;
        Mon, 23 Aug 2021 05:50:16 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a17sm8619444ios.36.2021.08.23.05.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:50:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1C70D27C0054;
        Mon, 23 Aug 2021 08:50:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 23 Aug 2021 08:50:15 -0400
X-ME-Sender: <xms:hZkjYSDYkGFzyGOdEdzwzXW5-aX2e57weD-8s-ghpxHL2jLgVWiqFw>
    <xme:hZkjYcjhTvIfMGaiOogbG5b-oHXYFuV8-g4u5F1BtJM-zYg7AO3dRsFtHfgQ4lD-x
    CafCcX3IOZFiETf4w>
X-ME-Received: <xmr:hZkjYVkqMJZmRGahGFZJQy1FsPDo-jsOTz9nEQiutLhIvrzRMtgDnuD7s00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddthedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgeegudethfekleduteelfeevffduheejlefhfffgfefgkeeuieeiveejudfg
    hfffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:hZkjYQxqfbVark12O4hKqgXpQlQYCtqwiFJ3Nnduro4Qb0CUX1IqQw>
    <xmx:hZkjYXSzAFswyxKVh43lxYKDkeos4RZ6C-gjVBYoCA3VEKJ-h6-kzg>
    <xmx:hZkjYbY8Xeiuyfw2MxRI2escIomftcIYaAm9ASIGVtpCbPATSyF5NQ>
    <xmx:hpkjYYLSaff2UfOpu-R8sSfmLm5KwzhsrgSRqvY9_KOkaQ0vaYUe_7p7_Zg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 08:50:12 -0400 (EDT)
Date:   Mon, 23 Aug 2021 20:49:29 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Message-ID: <YSOZWTPabTwlzbSP@boqun-archlinux>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210819141758.GA27305@lpieralisi>
 <YR59KJ+SenbQ58cw@boqun-archlinux>
 <20210823100959.GA3294@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823100959.GA3294@lpieralisi>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 23, 2021 at 11:10:00AM +0100, Lorenzo Pieralisi wrote:
> On Thu, Aug 19, 2021 at 11:47:52PM +0800, Boqun Feng wrote:
> > On Thu, Aug 19, 2021 at 03:17:58PM +0100, Lorenzo Pieralisi wrote:
> > > On Tue, Jul 27, 2021 at 02:06:49AM +0800, Boqun Feng wrote:
> > > > Hi,
> > > > 
> > > > This is the v6 for the preparation of virtual PCI support on Hyper-V
> > > > ARM64, Previous versions:
> > > > 
> > > > v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
> > > > v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
> > > > v3:	https://lore.kernel.org/lkml/20210609163211.3467449-1-boqun.feng@gmail.com/
> > > > v4:	https://lore.kernel.org/lkml/20210714102737.198432-1-boqun.feng@gmail.com/
> > > > v5:	https://lore.kernel.org/lkml/20210720134429.511541-1-boqun.feng@gmail.com/
> > > > 
> > > > Changes since last version:
> > > > 
> > > > *	Rebase to 5.14-rc3
> > > > 
> > > > *	Comment fixes as suggested by Bjorn.
> > > > 
> > > > The basic problem we need to resolve is that ARM64 is an arch with
> > > > PCI_DOMAINS_GENERIC=y, so the bus sysdata is pci_config_window. However,
> > > > Hyper-V PCI provides a paravirtualized PCI interface, so there is no
> > > > actual pci_config_window for a PCI host bridge, so no information can be
> > > > retrieve from the pci_config_window of a Hyper-V virtual PCI bus. Also
> > > > there is no corresponding ACPI device for the Hyper-V PCI root bridge,
> > > > which introduces a special case when trying to find the ACPI device from
> > > > the sysdata (see patch #3).
> > > > 
> > > > With this patchset, we could enable the virtual PCI on Hyper-V ARM64
> > > > guest with other code under development.
> > > > 
> > > > Comments and suggestions are welcome.
> > > > 
> > > > Regards,
> > > > Boqun
> > > > 
> > > > Arnd Bergmann (1):
> > > >   PCI: hv: Generify PCI probing
> > > > 
> > > > Boqun Feng (7):
> > > >   PCI: Introduce domain_nr in pci_host_bridge
> > > >   PCI: Support populating MSI domains of root buses via bridges
> > > >   arm64: PCI: Restructure pcibios_root_bridge_prepare()
> > > >   arm64: PCI: Support root bridge preparation for Hyper-V
> > > >   PCI: hv: Set ->domain_nr of pci_host_bridge at probing time
> > > >   PCI: hv: Set up MSI domain at bridge probing time
> > > >   PCI: hv: Turn on the host bridge probing on ARM64
> > > > 
> > > >  arch/arm64/kernel/pci.c             | 29 +++++++---
> > > >  drivers/pci/controller/pci-hyperv.c | 86 +++++++++++++++++------------
> > > >  drivers/pci/probe.c                 | 12 +++-
> > > >  include/linux/pci.h                 | 11 ++++
> > > >  4 files changed, 93 insertions(+), 45 deletions(-)
> > > 
> > > If we take this series via the PCI tree we'd need Catalin/Will ACKs on
> > > patches 3-4.
> > > 
> > 
> > Got it.
> > 
> > > I need some time to look into [1] (thanks for that).
> > > 
> > > Without [1] patch 8 is ugly, that's no news. The question is whether
> > > it is worth waiting for a kernel cycle to integrate [1] into this series
> > > or not.
> > > 
> > > Is it really a problem if we postpone this series for another kernel
> > > cycle so that we can look into it ?
> > > 
> > 
> > Well, it's definitely better for me that we can have it in 5.15-rc1 ;-),
> > because it's a dependency for Hyper-V virtual PCI support on ARM64 and
> > we plan to send the rest of work in 5.15 cycle. And I can just base on
> > hyperv-next for the rest of the work if this is in 5.15-rc1. But yes,
> > it's not really a problem, since this one still needs to work with other
> > patches to support virtual PCI on ARM64 Hyper-V.
> > 
> > In fact, I personally don't think [1] is better than patch 8 (plus patch
> > 3 & 4): playing with ->private seems dangerous and not very helpful on
> > readiblity, but I agree that we should explore every potential solution,
> > and that's why I send [1].
> 
> Pulled the current series - now let's work together to improve it, I
> will have a look into [1] in the weeks to come and get back to you with
> some feedback.
> 

Thanks a lot! Looking forwards to your feedback ;-)

Regards,
Boqun

> Thanks,
> Lorenzo
> 
> > Regards,
> > Boqun
> > 
> > > [1] https://lore.kernel.org/lkml/20210811153619.88922-1-boqun.feng@gmail.com/
