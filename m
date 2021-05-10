Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AAB377CE3
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 May 2021 09:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhEJHHM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 May 2021 03:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhEJHHM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 May 2021 03:07:12 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2906AC061573;
        Mon, 10 May 2021 00:06:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x8so14450158qkl.2;
        Mon, 10 May 2021 00:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fzTT8AwhXbeiIYIpohTCJBhuBfkrqXpqL4kJl6Kq54k=;
        b=DT1uy1DD9S7nDKl3io2POX2p5LuML0vt3UgrOTE5L7JX6FteKVmgGE19npte0LBxcQ
         q6M6Bul+wVvNGgGK3J+xiPGp96Q8OORbvTnKC3jWvZU5OWwQPloapOqMZTg96RnjbBkM
         9jHTO+gvJHNEPiDSAyrwiUnRSkho5uS+MhGf5bK9SGpQTQSrOgwXlTw4Exa7gfnSM1TP
         QpGnbeH51qT0Wwaiib7j4f01uLAc09HkXMMx+e9BNm5Odsw/bQy1BnQZTRkn61Qovb/V
         +3kLufDufVZcAN3PYQtYCbRVOW8kvEjXP2WHv10Q2VavDIBwkCXP2DKh4d7v+cmga9tc
         fXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fzTT8AwhXbeiIYIpohTCJBhuBfkrqXpqL4kJl6Kq54k=;
        b=GUsZdBeEWXZYj3/ZCLwhCzyaGsX+Lsl47VdIe/hvn58LmVaERtCtREByJG5YjknKtP
         svS2R0lFHiud34ykRT9jOHhpgIbd5zD5RhiqsSIYJ6j15oeD02X2TTAZTg38vVp8lP3g
         JZJ+VpSylJFepJk4K9D83jXDDUU70f7GrH0UTMbd2do8E268HGOJaE45FFX1LeOpzgSf
         OzMqoObk8n+q36cV9pYsSVDtgwR+yjjlXevZSQVsoUjDI1Dfpiayk0b5pjv55SJqws5B
         810DM58QmRkvT9eDGT0mwsSumRRpGRcT2XuiB3rtEo1DgmyJw2HxkwgxdBxeDGKti6V1
         eUTw==
X-Gm-Message-State: AOAM531Lk1VsMrnTZejx3lohDYR5yPlkRDZb9IymDhuAH1WgQPSK+WG8
        b9VjdB7wV5iPSxCtTo39QY0=
X-Google-Smtp-Source: ABdhPJxhQXzrpH8zO78pv7hLAsgTKinweWYxNRxTYL8Ec6U/DGsZ0Z+qzfVKb84OjWeQTXV7ce05kw==
X-Received: by 2002:a37:ea12:: with SMTP id t18mr20335056qkj.41.1620630367365;
        Mon, 10 May 2021 00:06:07 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o10sm9380679qki.72.2021.05.10.00.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 00:06:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2FD3327C0054;
        Mon, 10 May 2021 03:06:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 10 May 2021 03:06:06 -0400
X-ME-Sender: <xms:WduYYCPyKmVFRBfzbpmwJZf9VW408336aud5sUbW2f3yMFXDrLoZRg>
    <xme:WduYYA-nDoOy1_0fqJ_QsuoJW0RCEB1IiJiygmgbvBeRs20iQRDBgwlutN4MsV02U
    srHQFtxrdNarAIhfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegjedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfeg
    vdegjeenucfkphepudefuddruddtjedruddrvdehgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:WduYYJTziPKQfS4AcD30vffX5FbrfCKA9RgbBTIXRfav1KKlzksNng>
    <xmx:WduYYCsaenidAbAa3f6GOPVgTtRA_eWifGgAOBz-HCk_TSi2dLm1Ew>
    <xmx:WduYYKeKZ6Vmiqalz6JzNbobaslsVnXxiW9ZwIHOSfQ3lHTAf-8jgQ>
    <xmx:XtuYYNxNDCRpEem104w5eqp9Qu37C-1biqCLTe8klqUYv0DsCQ1g7PNtLzevKXvn>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 10 May 2021 03:06:01 -0400 (EDT)
Date:   Mon, 10 May 2021 15:04:49 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mike Rapoport <rppt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [RFC v2 6/7] PCI: arm64: Allow pci_config_window::parent to be
 NULL
Message-ID: <YJjbEeyXq+0vPusM@boqun-archlinux>
References: <20210503144635.2297386-7-boqun.feng@gmail.com>
 <20210506222530.GA1441653@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506222530.GA1441653@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 06, 2021 at 05:25:30PM -0500, Bjorn Helgaas wrote:
> Make your subject something like this so it matches previous practice:
> 
>   arm64: PCI: ...
> 

Got it.

> The "::" notation probably comes from C++, but doesn't really apply in
> C.  In C, we would say "cfg.parent" or "cfg->parent".
> 
> But pci_config_window and cfg->parent are probably too low-level for
> the subject anyway.  Seems like it should mention Hyper-V, for
> instance.
> 

I'm going to make the title something like:

   arm64: PCI: Support root bridge preparation for Hyper-V PCI

works for you? Also I will add comment inside the function as
explanation.

> On Mon, May 03, 2021 at 10:46:34PM +0800, Boqun Feng wrote:
> > This is purely a hack, for ARM64 Hyper-V guest, there is no
> > corresponding ACPI device for the root bridge, so the best we can
> > provide is an all-zeroed pci_config_window, and in this case make
> > pcibios_root_bridge_prepare() act as the ACPI device is NULL.
> 
> Why is there no ACPI device?  Is this a needless arch dependency?  Or
> is this related to using DT instead of ACPI?
> 

For Hyper-V virtual PCI host bridges, neither DT or ACPI is used to
describe them, a hypervisor-specific mechanism (VMBus) is used to
enumerate PCI host bridges. So actually on x86, Hyper-V PCI host
bridge's ACPI companion is set as NULL.

> The cover letter hints that this might be related to
> PCI_DOMAINS_GENERIC=y, but that doesn't sound like a very convincing
> reason (and the cover letter can provide an overview, but the commit
> logs of individual patches shouldn't assume knowledge of the cover
> letter).
> 

Ok, I will add a better explanation in the commit log in the next
version. Thanks!

Regards,
Boqun

> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  arch/arm64/kernel/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index e9a6eeb6a694..f159df903ccb 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -83,7 +83,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> >  {
> >  	if (!acpi_disabled) {
> >  		struct pci_config_window *cfg = bridge->bus->sysdata;
> > -		struct acpi_device *adev = to_acpi_device(cfg->parent);
> > +		struct acpi_device *adev = cfg->parent ? to_acpi_device(cfg->parent) : NULL;
> >  		struct device *bus_dev = &bridge->bus->dev;
> >  
> >  		ACPI_COMPANION_SET(&bridge->dev, adev);
> > -- 
> > 2.30.2
> > 
