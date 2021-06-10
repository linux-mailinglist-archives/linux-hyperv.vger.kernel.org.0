Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44FB3A302E
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jun 2021 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFJQJj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Jun 2021 12:09:39 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:38656 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJQJj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Jun 2021 12:09:39 -0400
Received: by mail-io1-f53.google.com with SMTP id b25so27585628iot.5;
        Thu, 10 Jun 2021 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kaZZOzSfE1U5InL076uxyCd5lJ1IWiQoV9yIjLnIADw=;
        b=qbAbRmanGuulXPWSE0XZvvrwSNUznnKaCIHS1SS8ovq2dtMtjFtSsRHZL20EeoS6Ds
         uR4gsgN0er8NXBRSx2QOhfaDkCoud5d0ktBOhYHvBt77KF3+J2KIX/e+TMcpJOZYUwiN
         MyT+C6ERLDQ/mF7l/jFboZXQg0MTNujEjAGa8iM51V8ih0rHp9bgQAWn2hXmbZLVFqen
         FxOn6xdei4ha/w4FObg80KnoQbPpk+qSE57I2Hi/m0cwmsSsxtAx8OPM4xYeh3blSJq5
         TZaLjE98g4ToNJXdhi0Jpd+sSWPuXIlGqEJA7KCbjFKOxnLRYFa+CnZpHnEV8bmM0MvG
         z6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kaZZOzSfE1U5InL076uxyCd5lJ1IWiQoV9yIjLnIADw=;
        b=H13Q4Rzm0WBbpabcpZLQT++9Ya4qIE5PlANOenFYPDM8dpWFe+FgLXWsLBa2zrInib
         ntOVVPWVA1GPTPwzg+iVtC++E1oz4ARen8wVUwvpC/AKLloQ5n5n2Q+HJlhxz0w4dMr8
         gn8C/35t+Kh6iwlH9K7LkLnff74obipkGhj6SrbKjAePY/bORScm/OwTJSVZH4R5ZPjb
         8SK6z6LhOs/3eXu1TZ93Ce3ee0w41efq95ECCVp+D1zJ3ej1yxnGq4aiaW/C9WYJVavz
         iN710rx+M53HsSYWltM92r7UMNpYPcpEWMt1UClxjUgxF4UXh3hOturmmTBk1ijlUWtm
         ku6g==
X-Gm-Message-State: AOAM533dbV/CheazrnSMcDey1+HovAxmBtwGVIQdjgH3K/1j7JyQN4KQ
        xG13HmdcgQeR6kXMgoaiMaE=
X-Google-Smtp-Source: ABdhPJxigYlkk+pjqfHrmEMr5uTSCmwPjamxfNT0l33BZoCn7VfgR6LOdlUu9NUC6+N8LT/CPnQYkg==
X-Received: by 2002:a5e:8510:: with SMTP id i16mr4466522ioj.40.1623341189938;
        Thu, 10 Jun 2021 09:06:29 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id i6sm2205768ilq.57.2021.06.10.09.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:06:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5D89127C0054;
        Thu, 10 Jun 2021 12:06:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 10 Jun 2021 12:06:28 -0400
X-ME-Sender: <xms:gjjCYKNvzRNcyy9DyLKGHimonsauZ0fhAuESqa-ZhLMyJG-0ZK5fAw>
    <xme:gjjCYI8W_4wz7aYJyyrsftg9zOy2e2xI3xMS7VXBeuBL0FZ94_nmsdj4pDwllXrpT
    c7Oi0H9GbcQZ0Hq3g>
X-ME-Received: <xmr:gjjCYBRtFfz-q22horoIMZu2lLWRvOip2KYxeGRbA2vbqRArp1m16-o0q0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedufedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdejvdeutdfgfeffgeehkeevteffffekkefgffetieetteeghfefgfetteeg
    gfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpihhnfhhrrgguvggrugdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvg
X-ME-Proxy: <xmx:gjjCYKvVcsCSZmN_93-Wgpcrv0o1q-YivwUUs5OQYo7y61Pjz8FLPg>
    <xmx:gjjCYCdgxJwc5sKyOzzFUn_NYihVsaW2qwfRtLaKFi19BngMKb76wA>
    <xmx:gjjCYO2W2iREyc-1lKfidSTQfJPRTkFE2KkLSbRleIBJKH1p02rHuA>
    <xmx:gzjCYJCKebPZ6crTqBVroPNLY7F2SQtpJEREaEEeXw_bBr17eBP0owHYHWs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jun 2021 12:06:26 -0400 (EDT)
Date:   Fri, 11 Jun 2021 00:06:21 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marc Zyngier <maz@misterjones.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: Re: [RFC v3 0/7] PCI: hv: Support host bridge probing on ARM64
Message-ID: <YMI4fWkHzrD3GKTW@boqun-archlinux>
References: <20210609163211.3467449-1-boqun.feng@gmail.com>
 <CAMj1kXGwa28T5Cr_64OC4rqE3qhwWQz+BJPwjdr54G-pVf9+pA@mail.gmail.com>
 <2283b22ae7832db348bd9b3eff3aab16@misterjones.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2283b22ae7832db348bd9b3eff3aab16@misterjones.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 10, 2021 at 04:42:45PM +0100, Marc Zyngier wrote:
> On 2021-06-10 16:01, Ard Biesheuvel wrote:
> > On Wed, 9 Jun 2021 at 18:32, Boqun Feng <boqun.feng@gmail.com> wrote:
> > > 
> > > Hi Bjorn, Arnd and Marc,
> > > 
> > 
> > Instead of cc'ing Arnd, you cc'ed me (Ard)
> 
> And I don't know if you intended to Cc me, but you definitely didn't.
> 

Weird.. seems my sending script got somewhere wrong. Apologies for you
both, and Arnd.. I did intend to Cc you and Arnd.

How do you want this to proceed? I could do a resend right now, or I
could wait for a few days (and see others' feedback) and send a V4 next
week. Sorry again ;-(

Regards,
Boqun

> Thanks,
> 
>         M.
> 
> > 
> > > This is the v3 for the preparation of virtual PCI support on Hyper-V
> > > ARM64. Previous versions:
> > > 
> > > v1:     https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
> > > v2:     https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
> > > 
> > > Changes since last version:
> > > 
> > > *       Use a sentinel value approach instead of calling
> > >         pci_bus_find_domain_nr() for every CONFIG_PCI_DOMAIN_GENERIC=y
> > >         arch as per suggestion from
> > > 
> > > *       Improve the commit log and comments for patch #6.
> > > 
> > > *       Rebase to the latest mainline.
> > > 
> > > The basic problem we need to resolve is that ARM64 is an arch with
> > > PCI_DOMAINS_GENERIC=y, so the bus sysdata is pci_config_window.
> > > However,
> > > Hyper-V PCI provides a paravirtualized PCI interface, so there is no
> > > actual pci_config_window for a PCI host bridge, so no information
> > > can be
> > > retrieve from the pci_config_window of a Hyper-V virtual PCI bus. Also
> > > there is no corresponding ACPI device for the Hyper-V PCI root bridge.
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
> > > Boqun Feng (6):
> > >   PCI: Introduce domain_nr in pci_host_bridge
> > >   PCI: Allow msi domain set-up at host probing time
> > >   PCI: hv: Use pci_host_bridge::domain_nr for PCI domain
> > >   PCI: hv: Set up msi domain at bridge probing time
> > >   arm64: PCI: Support root bridge preparation for Hyper-V PCI
> > >   PCI: hv: Turn on the host bridge probing on ARM64
> > > 
> > >  arch/arm64/kernel/pci.c             |  7 ++-
> > >  drivers/pci/controller/pci-hyperv.c | 87
> > > +++++++++++++++++------------
> > >  drivers/pci/probe.c                 |  9 ++-
> > >  include/linux/pci.h                 | 10 ++++
> > >  4 files changed, 73 insertions(+), 40 deletions(-)
> > > 
> > > --
> > > 2.30.2
> > > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> -- 
> Who you jivin' with that Cosmik Debris?
