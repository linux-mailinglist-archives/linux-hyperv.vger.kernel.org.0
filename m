Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4B3F1D3F
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Aug 2021 17:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhHSPtH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Aug 2021 11:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbhHSPtG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Aug 2021 11:49:06 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DCBC061575;
        Thu, 19 Aug 2021 08:48:30 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id f15so6419479ilk.4;
        Thu, 19 Aug 2021 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1XLarHIwSltc8JzGiLc6RNqTtH7ZzdM7gO/rhwWjhvA=;
        b=r/PFK0f5g1h3iNeVtG4snJF+KC48zZHcYCI84FO17uz8H20Aw09ixwoI/EYFXkj4ys
         w0xkg72L8/LKn6+Hsn51N/mlAh58jLtOjsOMd+jK3YOuN4ykgEFQsK4L60oHtFvBo/l3
         mnMPWgAbbgdzGPyVKC57FFMOnwbpN2Gm4F0usY3COQZzLu4l+2MbmyngWsm7NfkKaYtI
         exHtanNjlEpg2ooe6vp6hJfmI90AwwXBdET443Kym3ELr/c0rDYj39+vuRGyrsQUUHwT
         qq8RPsflRY6eQ96bv0Oqmyz8eukNlnV7xkKf8jjfJ5GOrzIXdIkbs0m8kYLWPd+gbrEi
         mXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1XLarHIwSltc8JzGiLc6RNqTtH7ZzdM7gO/rhwWjhvA=;
        b=gLNrQXw0nO6aBi2kHrE9DTdt6VIFxV8c4587ahvXEn0PtZFe+31B/3B1lFGb0e4knA
         wWxn1+b7RlLpM4ZJKOzKy/1UMaUF7/gVa4Vg06gjJR5qeOIK9NtX0/MqYhARSfJpfli8
         pBjDfTr9yeSaZXlO9t/CHvbwZ28SYqHNcWobzNwuPUPvpcY/sQF0baGh6kuzZZBxxHDV
         ld+uxDqKPQsV8lmKdUKiFYTeo32si8yHD7XUSQT3siMlkpFQaqygg/Y5KPoye37kY5pw
         Uc+2+c6LZjJlSyh7bsILjdFgRiDLD2kSJMFMABEcqoHD22WdAcJTwZ/Z722jpHziS+cJ
         KoAQ==
X-Gm-Message-State: AOAM5331CFHhRZUOu31ymImpHVyKCjQG/Si/W/QHul0SaHULWAOqWcWp
        RAvrQKU1GVM3g1XJlgBTIEI=
X-Google-Smtp-Source: ABdhPJxf1Iuq2VjFkgmnwcK558JcDv6YWHuAZODF3dmKo/CLmewJHtCzfHU4BDfB/JOzSkzE4daXSw==
X-Received: by 2002:a92:ad12:: with SMTP id w18mr10056613ilh.3.1629388108869;
        Thu, 19 Aug 2021 08:48:28 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m184sm1815314ioa.17.2021.08.19.08.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:48:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 43C2C27C005C;
        Thu, 19 Aug 2021 11:48:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 19 Aug 2021 11:48:27 -0400
X-ME-Sender: <xms:SX0eYTirq5f75nNnCRU3WRmDHYuGaMeBKLdTfo0aMJJjtdpbaBY-Hg>
    <xme:SX0eYQBTgn_ffv1v9jdb25N42MXLPF-mIRGUZfoL7UlbjS776Bd3Hh4IMwV_k4VYW
    dKKro4teavQKXrfZQ>
X-ME-Received: <xmr:SX0eYTGvb9xo5bewwvZbml7YSrwYvKh4AbgSTTp-eBdfUYgW93FofuRDDIrZ-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddvfeeg
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:SX0eYQQKA3fTHPppQ7--x2LYJ6HpeeVgHti9qCVN6NAwl9Z2vtpIBw>
    <xmx:SX0eYQygPldJyYRlS9d3Q5qgPBP_m0spmjLKEK9nZUMOBubifpMtpQ>
    <xmx:SX0eYW6Ja90A7Bs5hNPqwyITWmobECVEvPQROa6Tsh4tBKo5zCGbHA>
    <xmx:Sn0eYRrQeEEZ4PgP4UH8dcT0BFaORd2OpuFB3gm5ZRrAfei4qRcTbCuekvw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 11:48:25 -0400 (EDT)
Date:   Thu, 19 Aug 2021 23:47:52 +0800
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
Message-ID: <YR59KJ+SenbQ58cw@boqun-archlinux>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210819141758.GA27305@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819141758.GA27305@lpieralisi>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 19, 2021 at 03:17:58PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jul 27, 2021 at 02:06:49AM +0800, Boqun Feng wrote:
> > Hi,
> > 
> > This is the v6 for the preparation of virtual PCI support on Hyper-V
> > ARM64, Previous versions:
> > 
> > v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
> > v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
> > v3:	https://lore.kernel.org/lkml/20210609163211.3467449-1-boqun.feng@gmail.com/
> > v4:	https://lore.kernel.org/lkml/20210714102737.198432-1-boqun.feng@gmail.com/
> > v5:	https://lore.kernel.org/lkml/20210720134429.511541-1-boqun.feng@gmail.com/
> > 
> > Changes since last version:
> > 
> > *	Rebase to 5.14-rc3
> > 
> > *	Comment fixes as suggested by Bjorn.
> > 
> > The basic problem we need to resolve is that ARM64 is an arch with
> > PCI_DOMAINS_GENERIC=y, so the bus sysdata is pci_config_window. However,
> > Hyper-V PCI provides a paravirtualized PCI interface, so there is no
> > actual pci_config_window for a PCI host bridge, so no information can be
> > retrieve from the pci_config_window of a Hyper-V virtual PCI bus. Also
> > there is no corresponding ACPI device for the Hyper-V PCI root bridge,
> > which introduces a special case when trying to find the ACPI device from
> > the sysdata (see patch #3).
> > 
> > With this patchset, we could enable the virtual PCI on Hyper-V ARM64
> > guest with other code under development.
> > 
> > Comments and suggestions are welcome.
> > 
> > Regards,
> > Boqun
> > 
> > Arnd Bergmann (1):
> >   PCI: hv: Generify PCI probing
> > 
> > Boqun Feng (7):
> >   PCI: Introduce domain_nr in pci_host_bridge
> >   PCI: Support populating MSI domains of root buses via bridges
> >   arm64: PCI: Restructure pcibios_root_bridge_prepare()
> >   arm64: PCI: Support root bridge preparation for Hyper-V
> >   PCI: hv: Set ->domain_nr of pci_host_bridge at probing time
> >   PCI: hv: Set up MSI domain at bridge probing time
> >   PCI: hv: Turn on the host bridge probing on ARM64
> > 
> >  arch/arm64/kernel/pci.c             | 29 +++++++---
> >  drivers/pci/controller/pci-hyperv.c | 86 +++++++++++++++++------------
> >  drivers/pci/probe.c                 | 12 +++-
> >  include/linux/pci.h                 | 11 ++++
> >  4 files changed, 93 insertions(+), 45 deletions(-)
> 
> If we take this series via the PCI tree we'd need Catalin/Will ACKs on
> patches 3-4.
> 

Got it.

> I need some time to look into [1] (thanks for that).
> 
> Without [1] patch 8 is ugly, that's no news. The question is whether
> it is worth waiting for a kernel cycle to integrate [1] into this series
> or not.
> 
> Is it really a problem if we postpone this series for another kernel
> cycle so that we can look into it ?
> 

Well, it's definitely better for me that we can have it in 5.15-rc1 ;-),
because it's a dependency for Hyper-V virtual PCI support on ARM64 and
we plan to send the rest of work in 5.15 cycle. And I can just base on
hyperv-next for the rest of the work if this is in 5.15-rc1. But yes,
it's not really a problem, since this one still needs to work with other
patches to support virtual PCI on ARM64 Hyper-V.

In fact, I personally don't think [1] is better than patch 8 (plus patch
3 & 4): playing with ->private seems dangerous and not very helpful on
readiblity, but I agree that we should explore every potential solution,
and that's why I send [1].

Regards,
Boqun

> [1] https://lore.kernel.org/lkml/20210811153619.88922-1-boqun.feng@gmail.com/
