Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B6B3F1911
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Aug 2021 14:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbhHSMVI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Aug 2021 08:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbhHSMVI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Aug 2021 08:21:08 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3163DC061575;
        Thu, 19 Aug 2021 05:20:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q16so7480682ioj.0;
        Thu, 19 Aug 2021 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Do67dFDalPXC/TBAwcwK7Vkc73BP6/f3MSt05MrUV7Y=;
        b=gj28CVr9r8QzT93IRDPL1VID94K/rknU8pKdezfbSb05k2kFh7NSLJdDv7S7lzQFZP
         abgAfMSZA+S5Vywp1gJrx4mGI8d8sYgrSXYimE8nKZqarPSZQcoTUP59VTnvTHup6kdk
         Bq3XVk5/qlBDN1fxth3Ip8b2ZE2IygGBd6YBnD00ZjWh81lyHxan2Cgmqoz6X5/y8/XD
         Zdkhi/+8PGyrLTKPeTvyTBKwTkQRucRvN6a82qPa7E9kQhjg0KlUebKddPU+LiJOu15C
         hUBiBgox4PYStSeOwMRNzgIWlFE7bHX4BGqvFwdIkrbg8hI3wReDSoH6Znrb2RhIYuiX
         ZguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Do67dFDalPXC/TBAwcwK7Vkc73BP6/f3MSt05MrUV7Y=;
        b=dkJe+/AC9S09/lGcUuMVv/eOK/vcRJejYhD1Znj+9E3zxSMSEQsJMkQEZG7erl6BJh
         FBYgpbouZEUkwg5TcTu3LcX/n0mTl/kckwCYRVTjxWYJbcu/YHo8TG0VF+oPZ+VTo+/v
         cfW0DuDL+kY+MzBaFfQA19i+xwh4yUvR5nUoEib5wn3nM6an3kthrsM18pm2DBAyrYWx
         a2Y1Y5yBMU1qi4byMNLdquHCMJ6o0QdVglqMGBRJXboE7+z/ZrkWt9pwEDegPQahCmiu
         RnBwfAgX/KH3ojWQ/K4VwZrfD6DrGHWJW2CxyIbY0FQUkhhuPkoxPsLUQ5L4ayA5q57u
         GyCw==
X-Gm-Message-State: AOAM530OARj6pgSjWDyGmNQUxvhvOOm2zJcih2pE3zIXVM+I9H8VJWOp
        wgYZaVJSFPZTOIOKZwKkq6w=
X-Google-Smtp-Source: ABdhPJxTwiLgcwvR1OgCmYboO65XwnHr8NHGjoLeaH5Rci9AAvqYTz3Fyj8vuhbA0MsCgNZ6ri4kzg==
X-Received: by 2002:a05:6638:521:: with SMTP id j1mr12636185jar.122.1629375631499;
        Thu, 19 Aug 2021 05:20:31 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p18sm1507223iop.47.2021.08.19.05.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 05:20:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 74AD227C0054;
        Thu, 19 Aug 2021 08:20:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 19 Aug 2021 08:20:29 -0400
X-ME-Sender: <xms:i0weYbgP6KQHLHkqjcjHmO4IKfgsMzs28ZtJYPTY3seH2kYnA-GLow>
    <xme:i0weYYAdhAqx5DKOtpuZa6VFy0OO9_1nWRII24nUphulY-USUbiCRA7n_xun4iKpG
    C8yJTB5EGo5eK4zPw>
X-ME-Received: <xmr:i0weYbHnIVbHXsVN-jnbRXsTeD0Xx4iN7MGpYYIqzwLRPGORFTNl3Kewlnh6_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddvfeeg
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:i0weYYQYqHzYZMGd22iSUThIWHUJXLh81qrpvA4ikGUwS3OTMSxhiA>
    <xmx:i0weYYzMjGcgcphn32jqm-2GIpm7E0RqLmnIlP1u0zzt-ywdq98aWw>
    <xmx:i0weYe57rxB-goumohoqGw0_wY76XKKkM24ovq5W2YzmvBlbrNifhg>
    <xmx:jUweYZos-D1IFKpIwIZSQ6myaDo74IgpRPcSRdq7ALOGjU3frLVOBQgl_sY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 08:20:27 -0400 (EDT)
Date:   Thu, 19 Aug 2021 20:19:54 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v6 8/8] PCI: hv: Turn on the host bridge probing on ARM64
Message-ID: <YR5MaiCZrFJ71AwY@boqun-archlinux>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210726180657.142727-9-boqun.feng@gmail.com>
 <20210803171451.GA15466@lpieralisi>
 <YRE9+LaAjAW3SUvc@boqun-archlinux>
 <20210809155343.GA31511@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809155343.GA31511@lpieralisi>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

On Mon, Aug 09, 2021 at 04:53:43PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Aug 09, 2021 at 10:38:48PM +0800, Boqun Feng wrote:
> > On Tue, Aug 03, 2021 at 06:14:51PM +0100, Lorenzo Pieralisi wrote:
> > > On Tue, Jul 27, 2021 at 02:06:57AM +0800, Boqun Feng wrote:
> > > > Now we have everything we need, just provide a proper sysdata type for
> > > > the bus to use on ARM64 and everything else works.
> > > > 
> > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > ---
> > > >  drivers/pci/controller/pci-hyperv.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > > > index e6276aaa4659..62dbe98d1fe1 100644
> > > > --- a/drivers/pci/controller/pci-hyperv.c
> > > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > > @@ -40,6 +40,7 @@
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/pci.h>
> > > > +#include <linux/pci-ecam.h>
> > > >  #include <linux/delay.h>
> > > >  #include <linux/semaphore.h>
> > > >  #include <linux/irqdomain.h>
> > > > @@ -448,7 +449,11 @@ enum hv_pcibus_state {
> > > >  };
> > > >  
> > > >  struct hv_pcibus_device {
> > > > +#ifdef CONFIG_X86
> > > >  	struct pci_sysdata sysdata;
> > > > +#elif defined(CONFIG_ARM64)
> > > > +	struct pci_config_window sysdata;
> > > 
> > > This is ugly. HV does not need pci_config_window at all right
> > > (other than arm64 pcibios_root_bridge_prepare()) ?
> > > 
> > 
> > Right.
> > 
> > > The issue is that in HV you have to have *some* sysdata != NULL, it is
> > > just some data to retrieve the hv_pcibus_device.
> > > 
> > > Mmaybe we can rework ARM64 ACPI code to store the acpi_device in struct
> > > pci_host_bridge->private instead of retrieving it from pci_config_window
> > > so that we decouple HV from the ARM64 back-end.
> > > 
> > > HV would just set struct pci_host_bridge->private == NULL.
> > > 
> > 
> > Works for me, but please note that pci_sysdata is an x86-specific
> > structure, so we still need to define a fake pci_sysdata inside
> > pci-hyperv.c, like:
> > 
> > 	#ifndef CONFIG_X86
> > 	struct pci_sysdata { };
> > 	#end
> > 
> > > I need to think about this a bit, I don't think it should block
> > > this series though but it would be nicer.
> > 
> > After a quick look into the code, seems that what we need to do is to
> > add an additional parameter for acpi_pci_root_create() and introduce a
> > slightly different version of pci_create_root_bus(). A question is:
> > should we only do this for ARM64, or should we also do this for
> > other acpi_pci_root_create() users (x86 and ia64)? Another question
> > comes to my mind is, while we are at it, is there anything else that we
> > want to move from sysdata to ->private? These questions are out of scope
> > of this patchset, I think. Maybe it's better that we address them in the
> > future, and I can send out separate RFC patches to start the discussion.
> > Does that sound like a plan to you?
> 
> Yes it does and we can start from ARM64 - what I really don't like
> is the arch/arm64 dependency with the HV controller driver as I
> described, being forced to have a struct pci_config_window in the
> driver is not really nice or clean IMO.
> 
> Not that I expect any other PCI host bridge driver with ACPI coming
> anytime soon but even if it is not within set (that we can merge) I'd
> like to see the decoupling rework done asap, let me put it this way.
> 

Just want to check whether the following is a good starter for the
decoupling rework?

	https://lore.kernel.org/lkml/20210811153619.88922-1-boqun.feng@gmail.com/

If so, is there any other concern about taking this patchset? ;-)

Regards,
Boqun

> Thanks,
> Lorenzo
> 
> > Regards,
> > Boqun
> > 
> > > 
> > > Lorenzo
> > > 
> > > > +#endif
> > > >  	struct pci_host_bridge *bridge;
> > > >  	struct fwnode_handle *fwnode;
> > > >  	/* Protocol version negotiated with the host */
> > > > @@ -3075,7 +3080,9 @@ static int hv_pci_probe(struct hv_device *hdev,
> > > >  			 dom_req, dom);
> > > >  
> > > >  	hbus->bridge->domain_nr = dom;
> > > > +#ifdef CONFIG_X86
> > > >  	hbus->sysdata.domain = dom;
> > > > +#endif
> > > >  
> > > >  	hbus->hdev = hdev;
> > > >  	INIT_LIST_HEAD(&hbus->children);
> > > > -- 
> > > > 2.32.0
> > > > 
