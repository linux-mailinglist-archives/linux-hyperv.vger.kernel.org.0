Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD1342D46
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Mar 2021 15:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhCTOY5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 20 Mar 2021 10:24:57 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55085 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhCTOY0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 20 Mar 2021 10:24:26 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MCsgS-1lWSEK1GC0-008p20; Sat, 20 Mar 2021 15:24:24 +0100
Received: by mail-oi1-f180.google.com with SMTP id d12so8048606oiw.12;
        Sat, 20 Mar 2021 07:24:23 -0700 (PDT)
X-Gm-Message-State: AOAM530jlpK61PYnRhLAgUkej1pRP07YE7NFtif0MI+tthMAVhU2DeJV
        3TT0bGOuKugLekIZsfWgtfqYsWThHQ0kE5tj6K0=
X-Google-Smtp-Source: ABdhPJwFux/CWtJN4dtM1TpbyyYUNN266hbwwVFHhGiD4/+JrypfSbnb4Kw3jN9gqUDMobOfJpAmk7MjdcZ0Eq7ynN8=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr4360026oie.67.1616250262889;
 Sat, 20 Mar 2021 07:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210319161956.2838291-2-boqun.feng@gmail.com>
 <20210319211246.GA250618@bjorn-Precision-5520> <87tup6gf3m.wl-maz@kernel.org>
 <CAK8P3a1OGZsGmwGTHaVWBjpr_G4aDvO1mfUGU3o8XyLLgHqXpw@mail.gmail.com> <87sg4qgdrd.wl-maz@kernel.org>
In-Reply-To: <87sg4qgdrd.wl-maz@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 20 Mar 2021 15:24:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2qATr7qAkPqkZW4aifb3rq6CPrrsEX=8XcjTk0j5aW0A@mail.gmail.com>
Message-ID: <CAK8P3a2qATr7qAkPqkZW4aifb3rq6CPrrsEX=8XcjTk0j5aW0A@mail.gmail.com>
Subject: Re: [RFC 1/2] arm64: PCI: Allow use arch-specific pci sysdata
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:l1X1JfvJ5007g7U7VVbAmUywffPsU8+DmIMFcUVUGo95p79luYx
 DZyCknBiy3VNnP6CwtBVGXKKxTA/ipMHE+Y4q8cQenTKaJ8egc+0K1+Kffyd+UqpO6nt7D2
 sHfLCB31EtzXpDoJr+sxrilJ7wloJKKr4tMhwWVU7Jzs8yV01T05NNvxQXxTiDPmRg9SJEM
 /nFAtHshLNIbLTcK3XK6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vkUr1XpaayI=:ftzMyzxZDIQgB2pWcpSAYj
 DGgIEXjR/I4yaxvG/OOBOkmKKQeUyT+gkF0oha5ok9emW73SDITUkK3JLKiAyaKM3TgcgcB/r
 by6qzBsQBN26lqpOIW5TyLQ6sY2aJX0IAigtdStj55RoFFmj/2gXLj5G07rEuzDQ6Q79fNctN
 toeXZ3gTWWdWVjKyFndelRFye1DfAjufNASw6lIgX5ufsWYDewFGW1Ma3IKcfuv0lES8oPdfF
 lxy4nh+uvaueEMhQWeA6zMLFNpioobg8VLAARXzrm2UjcNNPAM2DWyhaCcDzVQa8E+SvrvodT
 4PBEVwsvIdNnfIOwyuG847HYFQuiragC5+hF0bshk8FjeG3Xt5mn47qqSW7qW+AjsVXTdTGGZ
 hcmMRh8wniH5tw8brmKV/IiSWftme4J28DtWWocjxGF1nRzGikYIUnaWFETdX
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Mar 20, 2021 at 2:23 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 20 Mar 2021 13:03:13 +0000,
> Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Mar 20, 2021 at 1:54 PM Marc Zyngier <maz@kernel.org> wrote:
> > > On Fri, 19 Mar 2021 21:12:46 +0000,
> > >
> > > Having an optional callback to host bridges to obtain the MSI domain
> > > may be possible in some cases though (there might be a chicken/egg
> > > problem for some drivers though...).
> >
> > I would expect that the host bridge driver can find the MSI domain
> > at probe time and just add a pointer into the pci_host_bridge
> > structure.
>
> In most cases, it doesn't implement it itself, and I'd be reluctant to
> duplicate information that can already be retrieved from somewhere
> else in a generic way (i.e. no PCI specific).

At the moment, the information is retried through a maze of different
functions, and already duplicated in both the pci_host_bridge and the
pci_bus structures.  If we can change everything to use
CONFIG_GENERIC_MSI_IRQ_DOMAIN, then most of that code
can probably just go away, leaving only the part in the phb.

       Arnd
