Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AA0342CF3
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Mar 2021 14:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCTNDn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 20 Mar 2021 09:03:43 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37419 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhCTNDd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 20 Mar 2021 09:03:33 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Ml76o-1m6XOB1yuq-00lUPh; Sat, 20 Mar 2021 14:03:31 +0100
Received: by mail-ot1-f42.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso11238121otq.3;
        Sat, 20 Mar 2021 06:03:31 -0700 (PDT)
X-Gm-Message-State: AOAM533eY9bSmoTrnYCktJEkRqgZS9McvdNKl39zckxoW/ys4RBdNbB+
        77o51YYwzI+8RjjRfJU29sIR1CoCEEvd+1cSh7U=
X-Google-Smtp-Source: ABdhPJw4zwmmsaNKkM4+UrHsd7cqgbKPxiSKwfQNVG5CgM2NbMVXP2bS8xIlYgIDSXo8OuDgdznZ0wY5TDkTqICahtg=
X-Received: by 2002:a9d:316:: with SMTP id 22mr680626otv.210.1616245409946;
 Sat, 20 Mar 2021 06:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210319161956.2838291-2-boqun.feng@gmail.com>
 <20210319211246.GA250618@bjorn-Precision-5520> <87tup6gf3m.wl-maz@kernel.org>
In-Reply-To: <87tup6gf3m.wl-maz@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 20 Mar 2021 14:03:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1OGZsGmwGTHaVWBjpr_G4aDvO1mfUGU3o8XyLLgHqXpw@mail.gmail.com>
Message-ID: <CAK8P3a1OGZsGmwGTHaVWBjpr_G4aDvO1mfUGU3o8XyLLgHqXpw@mail.gmail.com>
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
X-Provags-ID: V03:K1:jQkD8EZZiXJG0Ypa2SFEOUJN7IyHtWyLXTAgYl/PzevvEcaicoE
 W1seO2Bmw/9Om+F7WZ2aPBQfHWvY3iJvlJoFh+GbbKunCrmXS9n3LMIKG+2kq1cMxxCyvfz
 KkP4KIyXa2lwrNQQtEm1qkt/WMid2BjUAmw2KS9fgRwS9/KdiokDU+MjiEfP6P1MbqQ0aQy
 23p+MdVW9CgXBoQ+uSnIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gPSBLDs7PeQ=:aj/UnjetFVZlShr7BPYNPB
 RtBthhnoz35YAwpa3jg7uxBbQWZDNsybR4Yj+44jQyWHue22275kkmHQ7t7xAC4WHipS5cR14
 jvTkM+FQz2ZjL1y+m8fW6JLooUbEEEf2JOBS6Afhs8255kE1TzTOyVOY2TPaGd/JimL1OTudF
 8rq2gJN+4wI3/226ug4uKT3oDDqaWNmaAhK2/Z/6iRNxvY5/gVtaz8ea+KUrBjOYkbwx/l2Q/
 8750UVHJOFzwsK/gRBPaPCnH0FATYLYEfPMkgycvQFCX52qn4lJX6Np29mPRBeZ3Gl9D/taM7
 hCISmUKDGEGuV8B49HLs+Cf5tnPm5arYG3Od3+BkXwpf/PdggvfHp2jiBr0O2RJJ3CymlMd2o
 s7E6LebuUpRjLUZVWSNNERrK4rv37oGin2gCPD731OQ0uzh/Yn+dAfohTN6DyWUdFYqRZInqk
 hb/PzcHZQshkPVOJyFa2UtBxBlBJH8IdHiP9OUGzL1gjLKYsOQKwEr/1emdUCFYnzsiqyV0HR
 s+iCXKX8ZgED+x6SzfIlT/pBZnxm96P/tyoSyIYyKWfc2pVmq31fOkIy6rxT3/MIg==
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Mar 20, 2021 at 1:54 PM Marc Zyngier <maz@kernel.org> wrote:
> On Fri, 19 Mar 2021 21:12:46 +0000,

> >
> > Ugh.  pci_root_bus_fwnode() is another callback to find the
> > irq_domain.  Only one call, from pci_host_bridge_msi_domain(), which
> > itself is only called from pci_set_bus_msi_domain().  This feels like
> > another case where we could simplify things by having the host bridge
> > driver figure out the irq_domain explicitly when it creates the
> > pci_host_bridge.  It seems like that's where we have the most
> > information about how to find the irq_domain.
>
> Urgh. This is a perfect copy paste of the x86 horror, warts and all.
> I can't say I'm thrilled (another way to say "Gawd, Noes! Never!").
>
> One thing I am sure of is that I do not want to add more custom
> indirection to build the MSI topology. We barely got rid of the
> msi_controller structure, and this is the same thing by another
> name. Probably worse, actually.
>
> In this case, I don't see the point in going via a fwnode indirection
> given that there is no firmware tables the first place.
>
> As for finding the irq domain from the host bridge, that's not doable
> in most cases on arm64, as it is pretty likely that the host bridge
> knows nothing about MSIs when they are implemented in the GIC (see my
> recent msi_controller removal series that has a few patches about
> that).
>
> Having an optional callback to host bridges to obtain the MSI domain
> may be possible in some cases though (there might be a chicken/egg
> problem for some drivers though...).

I would expect that the host bridge driver can find the MSI domain
at probe time and just add a pointer into the pci_host_bridge
structure.

        Arnd
