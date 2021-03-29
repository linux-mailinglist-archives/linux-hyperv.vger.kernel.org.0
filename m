Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BB334D26E
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Mar 2021 16:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhC2Odt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Mar 2021 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhC2Od2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Mar 2021 10:33:28 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9D3C061574;
        Mon, 29 Mar 2021 07:33:28 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l6so1219718qtq.2;
        Mon, 29 Mar 2021 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=INa95GQbP5UUybr8uCp1E9rgvS5/GtEKon5OyS4S3Jo=;
        b=cdRobD61oBkZLm/kXpJy7rVCQDfwCcCijbVbvwbHBD73ukF3xVkwHV9xnk0BcknK0L
         ALbQxpOZXuEm4jx6ChP6rD5vxUuLfnMrXdvy7UGGLfGXWswa589epzdSYRBIyGw8AmPm
         jEsdtUYKY1ba56Xn9EEYx8F2QArP0dkEpx+dlLObu8ZFwojEATIlZNbVN0GWzhAX1CTQ
         Ncyhktz/ZZTXqotgdp7yG2Fgrr62tc/S8mVGIPW2fpNYHTNaCukty/+lVGKAytzUTAci
         dgNMLeWAlYReEilJYKobhoZb1ry8cih+qwbgl1jEGvxdQBJAm3+LoWIfYjDsKVRPJNPk
         5gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=INa95GQbP5UUybr8uCp1E9rgvS5/GtEKon5OyS4S3Jo=;
        b=ukIsy7SwbBtof7xWmzf/6VJmsczXq3lV5fK18MI8wbAOFLkHyZfpXxaSlHjd49zUgZ
         IA9oDBc3qaKm/fBEkh4L0fN8oTmxfhmbc0I2QCSq+vleO/I46W4Lh3ot5rshiBKc0o86
         G3CMVCybHemWr5pJ9WloTHesEzHEwMctBq1BnueJZxy0wcrtQNg5yl4McBS4v+4NopoR
         mz26QwSWIjsLInTzyfgTo5DuLelRNNoaqV8wIrokwnth7zeK2CHF6hpGDlHrAlOjv9Nl
         f57dtn/S5pGxX6nYZ8KlT3de0EPxPj7xktdK/Pc5oHWNjRCSN9ak4ytm3yJDovlQIsLv
         BqeA==
X-Gm-Message-State: AOAM532wvdplZ0I4jej5JEI80LDulohLR+spS2Zv6f7RHEgicBVx+cjh
        uuF36z7A1ZDDrzHZP9Ic6Pk=
X-Google-Smtp-Source: ABdhPJx+DEpXAFikZxvq5usQQQaEYJoD5Kit8EUdaJvvG8RWW1UZaatz16ZLj0tVOdQFmjq+GzgEeA==
X-Received: by 2002:aed:3001:: with SMTP id 1mr22944377qte.344.1617028407282;
        Mon, 29 Mar 2021 07:33:27 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id s17sm10471864qta.44.2021.03.29.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:33:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id D105727C005B;
        Mon, 29 Mar 2021 10:33:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Mar 2021 10:33:25 -0400
X-ME-Sender: <xms:NOVhYPbaMZ-swDWGIg7WABQo6mojR47LEGsJmwlLnoHYI_gv15QqUA>
    <xme:NOVhYOW_MCq0HTnW9ywX3jNPdRlDm2Gv5YLaIfm7achoBBGG2xa4S7IuFBCrcVZt-
    ZioBCKTrzcOAEWWkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehkedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudefuddruddtjedrud
    egjedruddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvge
    ehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhm
    sehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:NOVhYO1nauFy1ic7pTSgwzZGPAp5qtNJptVQE6tudn23Rn7Pj11RBQ>
    <xmx:NOVhYNYa1KnMRWI1_mYKcWUMd4Hzp_PJnJsPtFbLHX13AVqAzYzE5g>
    <xmx:NOVhYJq6sj_JlQGEIWSY4ei02z3yFFq_kv_xpliRLJsyabhVp7TPqQ>
    <xmx:NeVhYHgpe9LllCeYWaW8DEVGf1K8wpr_3IaaHbzcVDWfqNFGY8m7xSxdQNuVyXmv>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 186A51080054;
        Mon, 29 Mar 2021 10:33:24 -0400 (EDT)
Date:   Mon, 29 Mar 2021 22:32:35 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [RFC 1/2] arm64: PCI: Allow use arch-specific pci sysdata
Message-ID: <YGHlA2pXHgyu13T0@boqun-archlinux>
References: <20210319161956.2838291-2-boqun.feng@gmail.com>
 <20210319211246.GA250618@bjorn-Precision-5520>
 <CAK8P3a3qj=9KEN=X2uGCq0TrOGpyPw1Gwipmn=Gqx4LAfqUEDQ@mail.gmail.com>
 <CAK8P3a07wedojBU6xDKotiOsPR8k2XEXMB1SvJSRpeG++URA5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a07wedojBU6xDKotiOsPR8k2XEXMB1SvJSRpeG++URA5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Arnd,

On Sat, Mar 20, 2021 at 05:09:10PM +0100, Arnd Bergmann wrote:
> On Sat, Mar 20, 2021 at 1:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >      I actually still have a (not really tested) patch series to clean up
> > the pci host bridge registration, and this should make this a lot easier
> > to add on top.
> >
> > I should dig that out of my backlog and post for review.
> 
> I've uploaded my series to
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> pci-probe-rework-20210320
> 
> The purpose of this series is mostly to simplify what variations of
> host probe methods exist, towards using pci_host_probe() as the
> only method. It does provide some simplifications based on that
> that, including a way to universally have access to the pci_host_bridge
> pointer during the probe function.
> 

Thanks for the suggestion and code. I spend some time to catch up. Yes,
Bjorn and you are correct, the better way is having a 'domain_nr' in the
'pci_host_bridge' and making sure every driver fill that correctly
before probe. I definitly will use this approach.

However, I may start small: I plan to introduce 'domain_nr' and only
fill the field at probe time for PCI_DOMAINS_GENERIC=y archs, and leave
other archs and driver alone. (honestly, I was shocked by the number of
pci_scan_root_bus_bridge() and pci_host_probe() that I need to adjust if
I really want to unify the 'domain_nr' handling for every arch and
driver ;-)). This will fulfil my requirement for Hyper-V PCI controller
on ARM64. And later on, we can switch each arch to this approach one by
one and keep the rest still working.

Thoughts?

Regards,
Boqun

>          Arnd
