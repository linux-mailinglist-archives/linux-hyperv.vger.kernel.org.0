Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D051A3CFD94
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 17:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbhGTOs4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 10:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbhGTOXk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 10:23:40 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBAC0613E6;
        Tue, 20 Jul 2021 08:01:41 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k16so24267080ios.10;
        Tue, 20 Jul 2021 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rqh2j+Ayr+W6oCbgsaoRs3C9KQ2NwKX2qzDHqghJU8A=;
        b=QDQ2StR3eOJ9DSz/XEED4UdJYEaTc9e1ntF49N/yJK/ddvSKNU+F+Q/k4RimnL0U1l
         Q1mch4xfPqaMnUMOZvar0GwkHY9vwD3hYFeVqaJuP8jq+Bq1WkPSbOmzNBs7W0vWalxc
         Vv4AM9PWqWTsh6JyiCBv4ecyhoxJZ1qPj4gm8hck7zzXH6kDaNaLVya9a4sKurqkSr4j
         fLzdskYvexAWDxhR2pKql2nV4QmlfPVr3C/xlxL+12XbFPoi6vCtXd7nFDGXlhDwwHn/
         ILS+gupaAGCD4w08yIG/0DM6LaCHTISgy0w5alqcqYjdZQ8jx2m1YLIHeRxT47MTN80W
         Z/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rqh2j+Ayr+W6oCbgsaoRs3C9KQ2NwKX2qzDHqghJU8A=;
        b=SnHwr4Rk3MVTDSX7ZX6o4n6MfXj05pamSchIY2qfimGWKF6tMdQuK043j3SsbsrtRw
         k1qlRcySpShk2G2tWE8/1geKsxjqIHiSaUDklXDOPfSREOp1barPVNYmnrB+FFnoabrX
         P2j7wyh9CMqxRgu+wTPMZm60j/GBGbKnMV6+AH28MTZxI89AMAFEjma8JllBhRFD7HKf
         UuNxiVW8J828uYHLjP40byIkJbYd8gebEz6FuECecBuDCnd7crJAbBlOHECBXrmlOw6A
         MqZ1Z43b6EMMZ67QkpjgEEavD0oxBK5B0hpyBJOXV4e+Ar/3nonNQAtQ2Vo07yRODSbG
         VkbA==
X-Gm-Message-State: AOAM533YD38GSM+InLJcyrJnGKw8xQHHnXVqqSFPExGUvvvDDC+K2Wi2
        qN8E/o1X8D3evVtHDcz79Ok=
X-Google-Smtp-Source: ABdhPJxhaXBgFSmd11R8aI9lQGwxuq4ljnVnDeDK96jRlx+t6kKHRJJPyC9TcQlbTm8vyuUHIKj8PQ==
X-Received: by 2002:a05:6602:2155:: with SMTP id y21mr7441790ioy.16.1626793301015;
        Tue, 20 Jul 2021 08:01:41 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h1sm6841841ioz.22.2021.07.20.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 08:01:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4359027C005C;
        Tue, 20 Jul 2021 11:01:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 20 Jul 2021 11:01:39 -0400
X-ME-Sender: <xms:UeX2YL210GXluwnwjWxyN1URnUhIoBRa9nL1ZSvueBHWGDP0dUl5Kg>
    <xme:UeX2YKFLV5U95Zngy1Gcx58XVyFlrXRgqkpUH2K07BZfcp34fHeiwjeO3TQSdnmLi
    yQZseu4zJNJQXtAbw>
X-ME-Received: <xmr:UeX2YL4x6lHIgddQmRoruVSoYxirVAdI2kR1SuXbuN5X1xy0M8fFHVNYttV1RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:UeX2YA1Ocy0Bof4rI44E2fc_HJiPFyebZ97JqpQY9cY-8tdQrmzEXA>
    <xmx:UeX2YOGtd2iHuGCRHtqi3IhWb46duvKVwcY-591lg0bfafzNVY4G1A>
    <xmx:UeX2YB_Lf-sCsx_ymDrbnbseN5VadIpcqCjlxKDcC3RkVqB0-HuhOA>
    <xmx:UuX2YM-qIwq60VaD_Rj1CskuEiIDqGt5oGN4oRKKBZfyRSn2DboQfa8CfZs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 11:01:37 -0400 (EDT)
Date:   Tue, 20 Jul 2021 22:59:41 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC v5 8/8] PCI: hv: Turn on the host bridge probing on ARM64
Message-ID: <YPbk3Ya20z1PDn2H@boqun-archlinux>
References: <20210720134429.511541-1-boqun.feng@gmail.com>
 <20210720134429.511541-9-boqun.feng@gmail.com>
 <87v95582zh.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v95582zh.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 20, 2021 at 03:38:26PM +0100, Marc Zyngier wrote:
> On Tue, 20 Jul 2021 14:44:29 +0100,
> Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> > Now we have everything we need, just provide a proper sysdata type for
> > the bus to use on ARM64 and everything else works.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index e6276aaa4659..62dbe98d1fe1 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-ecam.h>
> >  #include <linux/delay.h>
> >  #include <linux/semaphore.h>
> >  #include <linux/irqdomain.h>
> > @@ -448,7 +449,11 @@ enum hv_pcibus_state {
> >  };
> >  
> >  struct hv_pcibus_device {
> > +#ifdef CONFIG_X86
> >  	struct pci_sysdata sysdata;
> > +#elif defined(CONFIG_ARM64)
> > +	struct pci_config_window sysdata;
> > +#endif
> 
> Am I the only one who find this rather odd? Nothing ever populates
> this data structure on arm64, and its only purpose seems to serve as
> an anchor to retrieve the hbus via container_of().
> 

This field will also be used as the ->sysdata of pci_bus and
pci_host_bridge, and some of the PCI core code touches. Although I made
this field as all zeroed and make sure PCI core can handle (patch #4).

> If that's indeed the case, I'd rather see an arch-specific to_hbus()
> helper that uses another (preexisting) field as the anchor for arm64.
> 

I did a quick look, but I didn't find another field works: the field
needs to be placed inside hv_pcibus_device and the address can be
retrieved via pci_bus. I'm open to any suggestion in case that I missed
something.

Regards,
Boqun

> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
