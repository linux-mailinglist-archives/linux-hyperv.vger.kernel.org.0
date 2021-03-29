Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132E334D29E
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Mar 2021 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhC2On5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Mar 2021 10:43:57 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38029 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhC2Ona (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Mar 2021 10:43:30 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M2ON6-1lUjvz0RAs-003uUs; Mon, 29 Mar 2021 16:43:29 +0200
Received: by mail-ot1-f53.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so12487477otq.8;
        Mon, 29 Mar 2021 07:43:28 -0700 (PDT)
X-Gm-Message-State: AOAM532uvMY8EljE21lapH2/7LldKK6uwegznfqCJeFfRcOsqfIrfai9
        nYs6gxwuHOntfqhAMfwla034NbfxCcMuZ0SnAzc=
X-Google-Smtp-Source: ABdhPJwDfuQ1VWw4ZjwyDlIbIK6oWZGKKq9pe4zrUVJQjeo5yIF0hBfXTzB1YBAQ6P/q5VRxHXE0N4eyuriJEuvTPrk=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr23284514otq.305.1617029007643;
 Mon, 29 Mar 2021 07:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210319161956.2838291-2-boqun.feng@gmail.com>
 <20210319211246.GA250618@bjorn-Precision-5520> <CAK8P3a3qj=9KEN=X2uGCq0TrOGpyPw1Gwipmn=Gqx4LAfqUEDQ@mail.gmail.com>
 <CAK8P3a07wedojBU6xDKotiOsPR8k2XEXMB1SvJSRpeG++URA5Q@mail.gmail.com> <YGHlA2pXHgyu13T0@boqun-archlinux>
In-Reply-To: <YGHlA2pXHgyu13T0@boqun-archlinux>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Mar 2021 16:43:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3rgu-zU=Ef_Dnmm-kB2rjb4JfRhvCmnLTH6R_ZZ6kHSQ@mail.gmail.com>
Message-ID: <CAK8P3a3rgu-zU=Ef_Dnmm-kB2rjb4JfRhvCmnLTH6R_ZZ6kHSQ@mail.gmail.com>
Subject: Re: [RFC 1/2] arm64: PCI: Allow use arch-specific pci sysdata
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5A1A5wrK/okZsusFyhca8SHl4IQCUEcTfSjTlpUyjej6pwhKNdW
 10cCfNwEWX+2gmOsqZ+ZWZH+wLOHyVUYJA2ptiRcd/t8OHMCZJVA4i9yTQd+ORhZu2PtBf4
 c8x6bubymkTOv9onnJRCLvN++3Be2SaZdJuNptsazTeMADVeC2qUw/RDR9EW7wwu/7ZLSql
 ojQTY/3BT252KJfULtJoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RzqnA1thXO4=:JHt4+LllJsEHbMzrL3GfDF
 bePDhE8ExdJwsmOwGZHfVsjIVnNAHmnWJ7S0A9M/d1wU6si2AQAmg0fC6m+7rw6DeVC3PYLgt
 7WwZ07VAT+iOrQw7qF9lNcYY1g7GbERwYa6F0H4jBFA1qUYp0Kxim7EERZbtlbDT17HhMxWbN
 D/CJXXOyjUcm1iOkFhdFWBx9UIbCg6wGUPEhAJI4Xciqu8TNyYaVn7t0iVdv6fT8V8nPl7vzA
 eZwiX6dSHq5oK+r2hIqnSg1SctYWylRvkOtK2li1dcfPbalau3SHAwBg4cvIJi/Gyjvt4YVGT
 Jh5txkvy0REN71UTmaM/likkGjFjWDklL9DcB4V+Oa9R0vTfis+0JQ87eVSfX3bkcERNZnKHW
 yJIZE68XrY43sKoMrou++WpyTJAovvbnaAdYbaJTZsXKhiwQVTL8yoelj7REIK+4GW739aagK
 ALU0xS9IBcRaDPn6zr2wi6NHnlO3Dota2gx/bZ26T1t+fOOiyIDP3BvxHyupJwVY67gYt4uDc
 uwnDORgMgB951vzAtQ/JdXCOwzfsUhHBD47PxcYWWqtf0TEV/mRDKrsvyHMKHpYWKiWLiUHs3
 S6OO+6Nj7O0aGn5IxJv7mKjNGPek3Tjym9
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 29, 2021 at 4:32 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Hi Arnd,
>
> On Sat, Mar 20, 2021 at 05:09:10PM +0100, Arnd Bergmann wrote:
> > On Sat, Mar 20, 2021 at 1:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >      I actually still have a (not really tested) patch series to clean up
> > > the pci host bridge registration, and this should make this a lot easier
> > > to add on top.
> > >
> > > I should dig that out of my backlog and post for review.
> >
> > I've uploaded my series to
> > https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> > pci-probe-rework-20210320
> >
> > The purpose of this series is mostly to simplify what variations of
> > host probe methods exist, towards using pci_host_probe() as the
> > only method. It does provide some simplifications based on that
> > that, including a way to universally have access to the pci_host_bridge
> > pointer during the probe function.
> >
>
> Thanks for the suggestion and code. I spend some time to catch up. Yes,
> Bjorn and you are correct, the better way is having a 'domain_nr' in the
> 'pci_host_bridge' and making sure every driver fill that correctly
> before probe. I definitly will use this approach.
>
> However, I may start small: I plan to introduce 'domain_nr' and only
> fill the field at probe time for PCI_DOMAINS_GENERIC=y archs, and leave
> other archs and driver alone. (honestly, I was shocked by the number of
> pci_scan_root_bus_bridge() and pci_host_probe() that I need to adjust if
> I really want to unify the 'domain_nr' handling for every arch and
> driver ;-)). This will fulfil my requirement for Hyper-V PCI controller
> on ARM64. And later on, we can switch each arch to this approach one by
> one and keep the rest still working.
>
> Thoughts?

That sounds reasonable to me, yes. I would also suggest you look
at my hyperv patch from the branch I mentioned [1] and try to integrate
that first. I suspect this makes it easier to do the domain rework and
possibly other changes on top.

       Arnd

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?h=pci-probe-rework-20210320&id=44db8df9d729d
