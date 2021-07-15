Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DEC3C96CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jul 2021 06:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhGOEDv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jul 2021 00:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhGOEDv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jul 2021 00:03:51 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A635CC06175F;
        Wed, 14 Jul 2021 21:00:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e14so3899167qkl.9;
        Wed, 14 Jul 2021 21:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6rmQU8jGx9qyfU1QaPi0lk+AKU6KfThL1irBy+Grp3M=;
        b=kbAZJiSxCI+J5bbjEdRXpIrM96GIXkIs94HB8bdkDJfnxiQVAsVtonrl7HlHnnxn10
         5S23XyY+z+lF3qqPJ4iAyP7+plY5yW1P2CbS18vOFEYbtGfMH+ZU5V1D9ivCISbZeILK
         5X0t8MB+UVqn+wxa/mcIF3t0rD9FPNWCPoZWQSwnEiq9+/jQ9MUCjL1tRRNF5WW8PNVZ
         BfQKgmQF8+U1Gpe6d8sfehCfZ9HTiAKQOH9iKV7WByjgb3WYihrk5YOccr7FaiVRMzgo
         ArdAZVHixj852JUyYKPf263d1Z2M3Jtuz4znWlIQu6zNVsidhS223fg7AgfjRHELER4a
         5iZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6rmQU8jGx9qyfU1QaPi0lk+AKU6KfThL1irBy+Grp3M=;
        b=ne8FIlaG8FXZRiV/Ho17it02CGkL26esxRyIrkHDXorJg9/YNE+AStCcNu+E3QS2rt
         X/3hDAkkz6eKRGlFFq4Wsx+DHdcGdSIuMPdpwvxBNHJMrHa3buw5EE6VgnLPa1M4JtcM
         YzYPsiZ4G3RmJ0CVT7VHqL/YbfP1TEWwtKbla9j/8qdrt6vZLDlOHjM+Xy685ma0CwDk
         b1/e83GcsSAQu6SwXwo9iaMErdEMFr+ylSfaIrd1LrMiTrqYeXlzRGEro19jlFwa6rKr
         KJtKRRGRsAZPzmAbQwrSuQwdeUxqDOIlNOMo508Ed6yvdC5YX9iSEPvGgd7K/ZfGkk6/
         y3Rg==
X-Gm-Message-State: AOAM533UdWm9HDspAlco0xIyypRXngLyDCeH+adc++97Vmwxerjrp2y5
        D9Rq329UMye6u2pl/G/J3Fc=
X-Google-Smtp-Source: ABdhPJx06BAR0FJNVGXQ4AOnEF8YxXz85J+lxiWBq3RelI+CV1DaPgQz5DICRdCoL+7G0d2CQIPO7A==
X-Received: by 2002:ae9:eb54:: with SMTP id b81mr1380516qkg.192.1626321657934;
        Wed, 14 Jul 2021 21:00:57 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 8sm825419qkb.105.2021.07.14.21.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 21:00:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7D39E27C0054;
        Thu, 15 Jul 2021 00:00:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 15 Jul 2021 00:00:56 -0400
X-ME-Sender: <xms:97LvYLHaYuyXUyyPMxyEoVUgtVCf2SWJgcqsWztfcbY0KnagWDuEMg>
    <xme:97LvYIU_tNcQh20OYoQKaVL8GwkxfbnbnVk0K0DAw5PVSq-2G9Rzjz-_Rf4abXIPd
    Z8pi1okUvGlKYZ6Xw>
X-ME-Received: <xmr:97LvYNLhzKQLko0Og82ynK7jkku7cccrkCVfisR0zATWrPYauO9TQiBr1XE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudelgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:97LvYJE-mszBMf8KPRMxqYu61NTghuvkTmSsZaqm7_7bXagbS8c5ug>
    <xmx:97LvYBWu0lmNLmV97SWJFkfQF8KWKaZOzVGidBgn9jHqC0UgZNKaaA>
    <xmx:97LvYEOZXbkwT89zGQEBuiOeKYGbWqvjVGbnEyQivWkRDD3NzlXuNw>
    <xmx:-LLvYIMSjQ9oE94tjv9wfJ5f1fok4dSWnULErg_X_8i-uWLjevoh6WuWHso>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jul 2021 00:00:54 -0400 (EDT)
Date:   Thu, 15 Jul 2021 11:59:14 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [EXTERNAL] [RFC v4 5/7] PCI: hv: Use pci_host_bridge::domain_nr
 for PCI domain
Message-ID: <YO+ykuwmfYcY3L0N@boqun-archlinux>
References: <20210714102737.198432-1-boqun.feng@gmail.com>
 <20210714102737.198432-6-boqun.feng@gmail.com>
 <MW4PR21MB2002D9659313C9B642171629C0139@MW4PR21MB2002.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB2002D9659313C9B642171629C0139@MW4PR21MB2002.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 14, 2021 at 05:04:38PM +0000, Sunil Muthuswamy wrote:
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 8d42da5dd1d4..5741b1dd3c14 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -2299,7 +2299,7 @@ static void hv_eject_device_work(struct work_struct *work)
> >  	 * because hbus->bridge->bus may not exist yet.
> >  	 */
> >  	wslot = wslot_to_devfn(hpdev->desc.win_slot.slot);
> > -	pdev = pci_get_domain_bus_and_slot(hbus->sysdata.domain, 0, wslot);
> > +	pdev = pci_get_domain_bus_and_slot(hbus->bridge->domain_nr, 0, wslot);
> >  	if (pdev) {
> >  		pci_lock_rescan_remove();
> >  		pci_stop_and_remove_bus_device(pdev);
> > @@ -3071,6 +3071,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  			 "PCI dom# 0x%hx has collision, using 0x%hx",
> >  			 dom_req, dom);
> > 
> > +	hbus->bridge->domain_nr = dom;
> >  	hbus->sysdata.domain = dom;
> With your other patches everything is moving over to based off of bridge->domain_nr.
> Do we still need to update sysdata.domain?

Yes, we still need it, because x86 is not a CONFIG_PCI_DOMAINS_GENERIC=y
architecture, and this patchset only makes CONFIG_PCI_DOMAINS_GENERIC=y
archs work with bridge->domain_nr. x86 still use the arch-specific
pci_domain_nr(), so we need to set the field in sysdata.

Regards,
Boqun

> 
