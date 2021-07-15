Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9313CAABE
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jul 2021 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbhGOTP3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jul 2021 15:15:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:58287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244500AbhGOTOy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jul 2021 15:14:54 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N7yz7-1l0vK14AGB-0151e1; Thu, 15 Jul 2021 21:11:59 +0200
Received: by mail-wm1-f45.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so5384998wmf.5;
        Thu, 15 Jul 2021 12:11:58 -0700 (PDT)
X-Gm-Message-State: AOAM532HhpzjEw7czZATJ2Kl0ipNNnHhWZ4Nc5GAx0+KKGMnaWwKpmSA
        IxqTuo9DZVJ9Ye+oqRtIz3ihtKRcjx09T0DaxFc=
X-Google-Smtp-Source: ABdhPJwxrvakD275HC0xyEZ0wcdgXIdYlVZQXahnZZWDCWwqATldhqGGB1STXVQXD6DYXx87xVKxkHz4d4QEYuuHayk=
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr12240953wmk.84.1626376318669;
 Thu, 15 Jul 2021 12:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210714102737.198432-2-boqun.feng@gmail.com> <20210714193319.GA1867593@bjorn-Precision-5520>
 <YPBwzO7c/rw09IkE@boqun-archlinux>
In-Reply-To: <YPBwzO7c/rw09IkE@boqun-archlinux>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Jul 2021 21:11:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3H38aeO6hUNeLAxV4ypfX+qTaCoRAJWYdP9wbvc9HuVQ@mail.gmail.com>
Message-ID: <CAK8P3a3H38aeO6hUNeLAxV4ypfX+qTaCoRAJWYdP9wbvc9HuVQ@mail.gmail.com>
Subject: Re: [RFC v4 1/7] PCI: Introduce domain_nr in pci_host_bridge
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wJiARtpQ2d8Fu2ZKcUOVJtIO9CHq7gxw1u6fNSHNkPwwAlmw2Bp
 tUmif2k6EcyxoGaIVPni5MEzH+aFUt4RHGQHQosbNpBPivOem+eZe3Go1D6hiI/lVZ80NL1
 oeR3/AV+jwGy+2p8GcQcYv8ECl/t5DELQxLR2YbyrHD+nkqn9FBMB8n1IsPAGVsP42tz+z5
 TijLM9Onx9nmAvSh3OR+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CbUT0UEVYNs=:fNpHAEzE4YTiB7KbGpVUGL
 O8/gdqGbN2912PStkXeNLL/HSBhvR5kT0Vg+MyLAPxr9B2hM0wF2dYOImsaGSh5FnFm1JoKAM
 lomRELH/Ac6UfpEKsa3KSlYCq7SCnLxhnxBkh8jyGswrNvEssIct68ZJanQD4fYy23TCpF4Q3
 C5ou27nIx7/KMcirsbtmKr9ZDWSSGqsIcKVyreH5h4xq39N61zdEwOxmFvPL1PTG9kikbsv9P
 kWLCdYG048liSvuuJDeI7VL6lemDI5hXxL5gtZOWlM+bj3/5c/cmEdc+xfgd7RmmI9Unay2zx
 z7EQpnGz0hz9vCInfhp+o/hric1vS+R+LFIlgQGbrKZHIaTkdNTWknvDaom3UlCTLfoc4hPVD
 Ri2o5BqdB/v5jb96Z63p+hX0FiANcQ6TEKCGdKrb9ayj7nJSjH4FHTEkEAKBEXFzVckxSf0yd
 pjKfn5Qddpo4YijHiFQI3LqK2xh9HelzkPtBVcdq0cxFWTD45587leiC9Wrjp02YPs2gxmYyh
 c/TRUAq8IGLJ6FRnA9LOWReGpCUOFreymWvHI0McTyHpKpTAYv1Qf4zobTp9NFSidr06UrcQJ
 6gHBNC3rQbOp4tyRro7XZo1RKrwbEWWfXpDRlaiWm3BFojLJdW3t9VhTFLL1/GVNmZRK+n+Uz
 NGxinOHyKJFHylizJVI+UOWbEX6Zt15iRv4sIGg2yLuSAb2l4WrBCIk/hGlGiqQzfysSNra40
 WAgokQQgKRZV+54+jQ7K+A4nIOoIWB2h+n0BXaMJT0lcvitHETsyF9yI8ZgovAUOboS6gczLQ
 VhTP2But34VmV+wxvPZwQScS7BYcE9d2NSwUxt2+q1G6SunNpCb7ppCrEpXC8JKkCrr/MlrC+
 5wsRpxVIw5XZRCfOqxsP96IlgGepFODH2sjvhMWYWqX9ZKWZyz5sQ2snMJC8skvIIyBrkyzrk
 kcWGieKFKJDT5JqTKqnOlnbuBk5Dcz0rWraoR6NaLts6s021hmD8u
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 15, 2021 at 7:30 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> On Wed, Jul 14, 2021 at 02:33:19PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jul 14, 2021 at 06:27:31PM +0800, Boqun Feng wrote:
> > >  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> > > -   bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> > > +   if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
> > > +           bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> > > +   else
> > > +           bus->domain_nr = bridge->domain_nr;
> >
> > The domain_nr in struct pci_bus is really only used by
> > pci_domain_nr().  It seems like it really belongs in the struct
> > pci_host_bridge and probably doesn't need to be duplicated in the
> > struct pci_bus.  But that's probably a project for the future.
> >

+1

> Agreed. Maybe we can define pci_bus_domain_nr() as:
>
>         static inline int pci_domain_nr(struct pci_bus *bus)
>         {
>                 struct device *bridge = bus->bridge;
>                 struct pci_host_bridge *b = container_of(bridge, struct pci_host_bridge, dev);
>
>                 return b->domain_nr;
>         }
>
> but apart from corretness (e.g. should we use get_device() for
> bus->bridge?), it makes more sense if ->domain_nr of pci_host_bridge
> is used (as a way to set domain number at probing time) for most of
> drivers and archs. ;-)

It needs to be "pci_find_host_bridge(bus)" instead of bus->bridge
and container_of().

Then again, if we get pci_domain_nr() to be completely generic, I'd
prefer to change most callers to just open-code the bridge->domain_nr
access, as most of them will already have a pointer to the pci_host_bridge
when calling this.

       Arnd
