Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91E83DD1CB
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Aug 2021 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhHBIPU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Aug 2021 04:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhHBIPU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Aug 2021 04:15:20 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3DDC06175F;
        Mon,  2 Aug 2021 01:15:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r18so19355972iot.4;
        Mon, 02 Aug 2021 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yZzOEJoG01OdviKzQL9CoqGl0G9gKy9wuTb1LdQVNcA=;
        b=ZI6WOs07dXAhAXWzNujDpaPNh1+aA4d9LgZhhzn2WdykjHBA9Cqc4/XQFIXb2tK4O/
         kDLVCytL7u6kQCVH95acut5Yo/zQ1ZPO9eJJTd3GaWwbTB/Ps0ViTZz7EppP1Gk+KD80
         /SJ9OQqi3UcpDQuE8BNTpY+jafjSF5C2UcpL0rEWBTo3XGD71hv+R55iB9DgFOe27KDd
         edYAlM/YQGdFxD5gQYRpzo8a+TZW/Gdxdxv9+dfjv7vHeiR3/E8pv2Z4Phuis3d/GFdz
         n1B+22ay+Nw6uE2JeGvrEs6JSfDg64b6z9FXj7X2oxH7xatMV4R2vmEMVaImJibz7QRN
         ue2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZzOEJoG01OdviKzQL9CoqGl0G9gKy9wuTb1LdQVNcA=;
        b=LBKV/yguyxADBffKE62+0RtM22+U2lhLQfENYg9ndTxdLUHgRv+4WrRuURH20MAuFy
         1UhPypeZvgHKUHILAj5i63UFXytPOqNMf4M+lnrnt7fNaYG7q4MIpcKyp8dQ0ESKBrQD
         wAUCSLsMyTsvxfgFLu+JkCzs8jrrzVOkZByb/WJyoANHAshDehIvxQQCP1kKdQkGuRKl
         pouY1zs7NMCsb+d8uByvJZhrdMhREr1LMEfibM6fiV98+V6L9vBR41RtLfgGx31QAAEK
         3urSY6etDbBEh3ymrHOqeW6W4LJnNoG45uUz8pHWAOU3aPmYOyAn2dwQcSasqdRTXqBs
         GwUg==
X-Gm-Message-State: AOAM533OvQoqVjFpb9CCMJMF7x2wa5qDsXghetD3dwrYHBMdzzP5z1sZ
        Rnul1lIoVVugCaVqTh66Qrs=
X-Google-Smtp-Source: ABdhPJz7xctX5kapv3LIUkK4MkWqZo7AXPw5ay5d1B/HrwLUR7Vz/ecPUJBX0LhaulHfBzDf34/BlA==
X-Received: by 2002:a6b:8b43:: with SMTP id n64mr1592407iod.142.1627892111005;
        Mon, 02 Aug 2021 01:15:11 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h15sm5021904ils.46.2021.08.02.01.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 01:15:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5E57027C0054;
        Mon,  2 Aug 2021 04:15:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 02 Aug 2021 04:15:09 -0400
X-ME-Sender: <xms:i6kHYeh24LQMawHAwt3eJKXguno0Bzk8k42kNykyI2qvPI2lNSQjbg>
    <xme:i6kHYfAsPcQBHc7GtxttzII5EuUBnGmKR_uxK4hA8ZvMlUhSqMVOLXYqgAX_fCJkR
    4NSgjQZNWrj7MW17g>
X-ME-Received: <xmr:i6kHYWEaDAnDywyo5lJUw_dOKm8Hu9ztuR5ZlvksriFZ0WZmPkj8WhBnJOFOCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddriedugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:i6kHYXTNKW6TX9XtENdNQ1wuceOsCs6NnH44lNfQ-ODPTTfCp7Vcbw>
    <xmx:i6kHYbx2lrE0HoxvaP51WCzZJFXMzUB2EHp_m6XyRo7_jdXY_Dv2HQ>
    <xmx:i6kHYV4S9Mkg3bpeoi0Y1mA0YAztdMMpGmTi-xG1nopVhsAoUWxBKA>
    <xmx:jakHYcpYy0YNrxuHW8tOXCApJW0Ip1DjEOQgME_Fo7xzoVs9gLJBQ0d1HuQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Aug 2021 04:15:07 -0400 (EDT)
Date:   Mon, 2 Aug 2021 16:15:04 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <YQepiKkFoJHC0gsK@boqun-archlinux>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726180657.142727-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 27, 2021 at 02:06:49AM +0800, Boqun Feng wrote:
> Hi,
> 
> This is the v6 for the preparation of virtual PCI support on Hyper-V
> ARM64, Previous versions:
> 
> v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
> v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
> v3:	https://lore.kernel.org/lkml/20210609163211.3467449-1-boqun.feng@gmail.com/
> v4:	https://lore.kernel.org/lkml/20210714102737.198432-1-boqun.feng@gmail.com/
> v5:	https://lore.kernel.org/lkml/20210720134429.511541-1-boqun.feng@gmail.com/
> 
> Changes since last version:
> 
> *	Rebase to 5.14-rc3
> 
> *	Comment fixes as suggested by Bjorn.
> 
> The basic problem we need to resolve is that ARM64 is an arch with
> PCI_DOMAINS_GENERIC=y, so the bus sysdata is pci_config_window. However,
> Hyper-V PCI provides a paravirtualized PCI interface, so there is no
> actual pci_config_window for a PCI host bridge, so no information can be
> retrieve from the pci_config_window of a Hyper-V virtual PCI bus. Also
> there is no corresponding ACPI device for the Hyper-V PCI root bridge,
> which introduces a special case when trying to find the ACPI device from
> the sysdata (see patch #3).
> 
> With this patchset, we could enable the virtual PCI on Hyper-V ARM64
> guest with other code under development.
> 
> Comments and suggestions are welcome.
> 

Ping ;-)

Regards,
Boqun

> Regards,
> Boqun
> 
> Arnd Bergmann (1):
>   PCI: hv: Generify PCI probing
> 
> Boqun Feng (7):
>   PCI: Introduce domain_nr in pci_host_bridge
>   PCI: Support populating MSI domains of root buses via bridges
>   arm64: PCI: Restructure pcibios_root_bridge_prepare()
>   arm64: PCI: Support root bridge preparation for Hyper-V
>   PCI: hv: Set ->domain_nr of pci_host_bridge at probing time
>   PCI: hv: Set up MSI domain at bridge probing time
>   PCI: hv: Turn on the host bridge probing on ARM64
> 
>  arch/arm64/kernel/pci.c             | 29 +++++++---
>  drivers/pci/controller/pci-hyperv.c | 86 +++++++++++++++++------------
>  drivers/pci/probe.c                 | 12 +++-
>  include/linux/pci.h                 | 11 ++++
>  4 files changed, 93 insertions(+), 45 deletions(-)
> 
> -- 
> 2.32.0
> 
