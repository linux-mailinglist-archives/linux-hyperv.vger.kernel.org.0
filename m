Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D4B342CE3
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Mar 2021 13:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCTMzW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 20 Mar 2021 08:55:22 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCTMzK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 20 Mar 2021 08:55:10 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N6sON-1lkjHX1Upr-018KVg; Sat, 20 Mar 2021 13:55:08 +0100
Received: by mail-ot1-f51.google.com with SMTP id l23-20020a05683004b7b02901b529d1a2fdso11205085otd.8;
        Sat, 20 Mar 2021 05:55:07 -0700 (PDT)
X-Gm-Message-State: AOAM533WbbEcgQWjQosCwsVh8o65iilFHytyV2IXZYZIzH+3ttM7CU5z
        oaHHJ3h4Z14M4EPydV1999HCY/wK6tTNQsVIF/A=
X-Google-Smtp-Source: ABdhPJxfJjFtVcXJVTzNQbZX61NIbImCp304YJaZ1bespXEDPPNSNNKZMiQFU3RpZzf8rAsn4Jwio7QzZOKXntzCFwc=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr4900234otq.251.1616244906923;
 Sat, 20 Mar 2021 05:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210319161956.2838291-2-boqun.feng@gmail.com> <20210319211246.GA250618@bjorn-Precision-5520>
In-Reply-To: <20210319211246.GA250618@bjorn-Precision-5520>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 20 Mar 2021 13:54:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3qj=9KEN=X2uGCq0TrOGpyPw1Gwipmn=Gqx4LAfqUEDQ@mail.gmail.com>
Message-ID: <CAK8P3a3qj=9KEN=X2uGCq0TrOGpyPw1Gwipmn=Gqx4LAfqUEDQ@mail.gmail.com>
Subject: Re: [RFC 1/2] arm64: PCI: Allow use arch-specific pci sysdata
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
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
X-Provags-ID: V03:K1:3nBsTRjKU4DNvoz6P1XhrvpmUe2H2tSo8FW7//VtMMpKIMWFU59
 5LvE5Rx1nrpyksyqctFc2uXS0S/OpKnNXpdurXFpAqI90/1C7+xhQ/zwmogZ+jYulAPORGD
 dNeW6LLglWNElfFjxknk0nkmpPRQ/ot9K2svvsvzKQn/yuCxAzG826H2zES5GgZyf95YYIm
 pakNjUSpBxeJ720qndNSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:j0FktJ2XUn0=:lJoW9JkB4eIpwg7b9EEESz
 X0lb8lWTNq/QGTiQ2WbUktkPsDiYufirJuh+wEMlvpZUm0zNvhqDhk3AKkVJQ+DkDCiDTz9x+
 mGZsJUnFIjxg8ABjCB5aR5UP+Gi0AqgOhs1yxYjczDwjFy2q+UPKWU17gn7fSW1QTfr981uZQ
 MsoGRX4GgTzPwfYYlc59Bbrhyt011UflGqfesTS2Ltp07YjUEJnVqjtcsO6AoY3yfOLx1y1Xg
 J3Wj+qRK2RSZDtjiy0HbbDVxniB9/jkLS43Vo5Dw2sAsRP/eRZH6qg8SLcIti/9zD25Kcgtw3
 RU9FCiK9ibCzm5rrNPAoz9WLVwaLpe7Mxe8t9/iLA6cAbu4YyZavZ5VpQuCOJrI1dbHe4TIsH
 2bn42she0Cqs03K+1ZZZ4EOqsbnF0L7vl6MPXaz09hzHRUgp/mqjhViQqfA8iEy1v+iIbGnj4
 H2zWIvCrXiYjlZS7oEcbxKoDj1E9IzesUe9ia9AcssBIx79NP98lHbTbD1uBVRiwVDBuT1ku9
 hjx2UxqMn8JT79ps6BhvIBpRVIQP7MVqplXXBiVoxAQtOhK333xHJNN18ZTz7P3Yg==
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 19, 2021 at 10:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > However, for a virtualized PCI bus, there might be no enough data in of
> > or acpi table to create a pci_config_window. This is similar to the case
> > where CONFIG_PCI_DOMAINS_GENERIC=n, IOW, architectures use their own
> > structure for sysdata, so no apci table lookup is required.
> >
> > In order to enable Hyper-V's virtual PCI (which doesn't have acpi table
> > entry for PCI) on ARM64 (which selects CONFIG_PCI_DOMAINS_GENERIC), we
> > introduce arch-specific pci sysdata (similar to the one for x86) for
> > ARM64, and allow the core PCI code to detect the type of sysdata at the
> > runtime. The latter is achieved by adding a pci_ops::use_arch_sysdata
> > field.
> >
> > Originally-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> > ---
> >  arch/arm64/include/asm/pci.h | 29 +++++++++++++++++++++++++++++
> >  arch/arm64/kernel/pci.c      | 15 ++++++++++++---
> >  include/linux/pci.h          |  3 +++
> >  3 files changed, 44 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> > index b33ca260e3c9..dade061a0658 100644
> > --- a/arch/arm64/include/asm/pci.h
> > +++ b/arch/arm64/include/asm/pci.h
> > @@ -22,6 +22,16 @@
> >
> >  extern int isa_dma_bridge_buggy;
> >
> > +struct pci_sysdata {
> > +     int domain;     /* PCI domain */
> > +     int node;       /* NUMA Node */
> > +#ifdef CONFIG_ACPI
> > +     struct acpi_device *companion;  /* ACPI companion device */
> > +#endif
> > +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> > +     void *fwnode;                   /* IRQ domain for MSI assignment */
> > +#endif
> > +};
>
> Our PCI domain code is really a mess (mostly my fault) and I hate to
> make it even more complicated by adding more switches, e.g.,
> ->use_arch_sysdata.
>
> I think the design problem is that PCI host bridge drivers should
> supply the PCI domain up front instead of having callbacks to extract
> it.
>
> We could put "int domain_nr" in struct pci_host_bridge, and the arch
> code or host bridge driver (pcibios_init_hw(), *_pcie_probe(), VMD,
> HV, etc) could fill in pci_host_bridge.domain_nr before calling
> pci_scan_root_bus_bridge() or pci_host_probe().
>
> Then maybe we could get rid of pci_bus_find_domain_nr() and some of
> the needlessly arch-specific implementations of pci_domain_nr().
> I think we likely could get rid of CONFIG_PCI_DOMAINS_GENERIC, too,
> eventually.

Agreed. I actually still have a (not really tested) patch series to clean up
the pci host bridge registration, and this should make this a lot easier
to add on top.

I should dig that out of my backlog and post for review.

         Arnd
