Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB6C3E47D6
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Aug 2021 16:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhHIOoC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 Aug 2021 10:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbhHIOmo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 Aug 2021 10:42:44 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311FEC0617A4;
        Mon,  9 Aug 2021 07:38:58 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id s184so27880402ios.2;
        Mon, 09 Aug 2021 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZJFa7d2MMspvNHYHeb9vzFdsiru50qHv4RgXeKQT0og=;
        b=IqozBY6P6n0YzqrBK7p9SAteUFAqjxnyGIHv/kYcKrr7nh9bL7VPCKSImSd2ExBqAD
         WzClQLbIPTw/VyD/METBhkisqtqZL6E+PGlEho0TyWVqevTjI76YGCP7pJYPDkcP2Kx6
         BWkVdJhjWjqsqWnxMaYRFal57J3B7DpnlOiDrlbb/pVQZONG710/ZiDCNcqyGBJEOwIp
         TTkNSRLHE2iQT0Eb+i+SmbKimGdkg+TYvgl4MFVD4fRSPU9BgubVJ8pXmhoVnfJF+wy8
         gDuTphWzFAGamMS7H4d5d5DRTPqFgNu4WdAgdpSc03egz7LLEV23beRgQhi5chCx6Ll1
         K/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZJFa7d2MMspvNHYHeb9vzFdsiru50qHv4RgXeKQT0og=;
        b=OFBkFnfHvt+kdjYBRSRTA0DV8TJrnqEi3uAUpcByzS3DKC/5m1LXT7KuBqw2/9EB5Z
         VyZ11eYDpO9Khzef6uxobNC7nB0mPA9mzp6XXRfNSArTsyQnd8A85HjhOZtOaQ00KbQt
         AR42LUuLK2fM987zl2hCniCW6+wc0EnuZwictPzBC5Rn+ACAidsjHUIFBCnDb346/9vz
         7Fr0AEb3HuLUSCvpIeMdMoeq3kH4wfFDb1cw5RgOIFPzAtEDZBit/Txcq4mFHXErmOP/
         tARC0b7zgAx/Fs74h/adBN4k6pJO39MOtwOOuglpodDEm17fQzrXppKLJHQYYlU1YYiT
         ITwQ==
X-Gm-Message-State: AOAM530Uc1IuJbUMoN4QiC5KpSH7NTiY0FI23MFtb6LhYTwPaz6lU2sc
        Cj+rugYtt7vGyWpXZoUKhMs=
X-Google-Smtp-Source: ABdhPJz6AaDqIPar7LvgnhtcoluXCQeKSt2vZi3mKbto+SViQe/qpvzlij4OcoX6HW4KgxE8Djvsnw==
X-Received: by 2002:a02:2348:: with SMTP id u69mr22677803jau.141.1628519937572;
        Mon, 09 Aug 2021 07:38:57 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z22sm10866290ioe.52.2021.08.09.07.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 07:38:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id E03FD27C0054;
        Mon,  9 Aug 2021 10:38:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 09 Aug 2021 10:38:55 -0400
X-ME-Sender: <xms:_j0RYZXs62PWFpDnUpmAIUJNpQtGDCOVG8X7lbSEWqPWPVz1Dto4eg>
    <xme:_j0RYZm1UxnUbaFs0_wcq8fTHR1r7bqkI0CG3PFFMZeWE4jB9aDjz13iPl_rKnpVd
    Ld8WMEAiQ0Y1lC2kQ>
X-ME-Received: <xmr:_j0RYVYgOAzkpPs3dCNEajXWw5C1EF8yGgTIojhGjwv9wIvPa2wkcmYnvbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:_j0RYcV0HknFo072PK0YHeBsIBByQvk5pozwCnR8Wcf_oqlhCze6Tw>
    <xmx:_j0RYTl6wDZhk6s5gZwk9t04FaAfmBMLYrrX3mSs6IwG9D12aSQ1rQ>
    <xmx:_j0RYZfcNdkqtUX0X19id6cCl88mUknSV_zjev27n5RsNTeeg2lRXg>
    <xmx:_z0RYScwR4jOSbLZJfrO42CST2x9L60ReYGjhm1DsFu74juc7DJl2s2hG1I>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 10:38:53 -0400 (EDT)
Date:   Mon, 9 Aug 2021 22:38:48 +0800
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
Message-ID: <YRE9+LaAjAW3SUvc@boqun-archlinux>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210726180657.142727-9-boqun.feng@gmail.com>
 <20210803171451.GA15466@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803171451.GA15466@lpieralisi>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 03, 2021 at 06:14:51PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jul 27, 2021 at 02:06:57AM +0800, Boqun Feng wrote:
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
> 
> This is ugly. HV does not need pci_config_window at all right
> (other than arm64 pcibios_root_bridge_prepare()) ?
> 

Right.

> The issue is that in HV you have to have *some* sysdata != NULL, it is
> just some data to retrieve the hv_pcibus_device.
> 
> Mmaybe we can rework ARM64 ACPI code to store the acpi_device in struct
> pci_host_bridge->private instead of retrieving it from pci_config_window
> so that we decouple HV from the ARM64 back-end.
> 
> HV would just set struct pci_host_bridge->private == NULL.
> 

Works for me, but please note that pci_sysdata is an x86-specific
structure, so we still need to define a fake pci_sysdata inside
pci-hyperv.c, like:

	#ifndef CONFIG_X86
	struct pci_sysdata { };
	#end

> I need to think about this a bit, I don't think it should block
> this series though but it would be nicer.

After a quick look into the code, seems that what we need to do is to
add an additional parameter for acpi_pci_root_create() and introduce a
slightly different version of pci_create_root_bus(). A question is:
should we only do this for ARM64, or should we also do this for
other acpi_pci_root_create() users (x86 and ia64)? Another question
comes to my mind is, while we are at it, is there anything else that we
want to move from sysdata to ->private? These questions are out of scope
of this patchset, I think. Maybe it's better that we address them in the
future, and I can send out separate RFC patches to start the discussion.
Does that sound like a plan to you?

Regards,
Boqun

> 
> Lorenzo
> 
> > +#endif
> >  	struct pci_host_bridge *bridge;
> >  	struct fwnode_handle *fwnode;
> >  	/* Protocol version negotiated with the host */
> > @@ -3075,7 +3080,9 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  			 dom_req, dom);
> >  
> >  	hbus->bridge->domain_nr = dom;
> > +#ifdef CONFIG_X86
> >  	hbus->sysdata.domain = dom;
> > +#endif
> >  
> >  	hbus->hdev = hdev;
> >  	INIT_LIST_HEAD(&hbus->children);
> > -- 
> > 2.32.0
> > 
