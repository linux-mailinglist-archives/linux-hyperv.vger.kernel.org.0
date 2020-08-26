Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0102A252955
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHZIk0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 04:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgHZIkZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 04:40:25 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF7CC061574;
        Wed, 26 Aug 2020 01:40:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y65so848276qtd.2;
        Wed, 26 Aug 2020 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zMOE7BVmPyRTv2jz4mqPIGALZmc5cotG47cZLpXd7P0=;
        b=ZaSYnvQy0bZisuDNUS64pc52zd3LStKE6fxdhLmMutAsJpcLtr3O7vWkQ19sGAlveC
         BBOOuFfzOgi1axGeSq9N/yrlUBHzw9kVBY0Zd0ZulXw0csdcWbLp+Oq77HCmgZZXsMxM
         vkVFH+blEU1Q/nIWUCEkVlDTWPGMOOZqHzSn5mU6HYechdmff1rnM1oZJOJLNJX73OJU
         FkU7sslh11sccyp9/XxvpalpzGcjcHUHFzqNTyABV6Yhvs/owq9++Zczca6uuqR6saMU
         jQBkKMUJBtXXfb3e0ZcK4x4l5geDFMLwxqx+y6X2By/HFKUPuNhLbX2i6N2ylwVm0YCQ
         +taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zMOE7BVmPyRTv2jz4mqPIGALZmc5cotG47cZLpXd7P0=;
        b=g1xd6pul8EvFwJvV7hBk4RlUWGwERW9Sk6/hvsmH+zL3+Vj7xSKObkKi94Xoc5rCf/
         cAJaGW6kgCBUWHe3aFWSAVn/k0KmOGYA5v/EnBvUlgOil4uVYTHF4WytHivtNE9Dug55
         tyFVLS8tDSHJNqMS5zm3X8r5nQ150NkCoSJsW8XuFZd/AGitZPi1phtPbs01NeoV+mE6
         2r+KU0suig8ddhHx1ZWfiF4bPjba+rzbMliUw6hrSUAfwTrnHEAFHwqGqmfmz83gvA+B
         pzimL7BOuYrLB77W8xMF794WXTe+4aYpdt8MdvBwJ9cbuRCXf/9vMpvy77lphdfq0Ufx
         w7ng==
X-Gm-Message-State: AOAM531bnxZgEyXs/cW4NC2vrAcIT3lclNV+ymqDgC09fkt+2LNI25Ym
        vmQxxvOelBjQx4ZOvjAq87c=
X-Google-Smtp-Source: ABdhPJz7C4WtYCX7DFVDZ9wXqDcxQZTjOJS5RkidUejP7+S68XGumDHrfNLnPq5K4GdTGkEpaMpliQ==
X-Received: by 2002:ac8:5d43:: with SMTP id g3mr4770683qtx.369.1598431224464;
        Wed, 26 Aug 2020 01:40:24 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y46sm1470153qth.78.2020.08.26.01.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 01:40:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A347427C0054;
        Wed, 26 Aug 2020 04:40:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 26 Aug 2020 04:40:22 -0400
X-ME-Sender: <xms:9R9GX2xKCIeJJilVotELTMVRdOdEtU0GVimu1XaSTnQMyQ2q2QZSNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvvddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhteehtdfhhfduiedvueegvdfgveehvdehueefgedtffehgfffgffgtddt
    gfetjeenucffohhmrghinhepihhorghpihgtrdhpihhnnecukfhppeehvddrudehhedrud
    duuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghe
    dtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhes
    fhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:9R9GXyTU6nzfcRktziV4XRtRPEiLJ9JN-4rgRw0VHw7cAuHIJQguag>
    <xmx:9R9GX4UDJesbN8TYSy0lvivr41ncAik1fvQoKEIfcGNtV5vLtU_I0A>
    <xmx:9R9GX8hpaznz7Pz2KTJ0IZWUwzUA3IckfIUnFyOT0BvfD8HlnFrd5Q>
    <xmx:9h9GX4uHBZvzMVvlKIVX5qICQjtuLHpMLqq45SzvFf5kxurzdPDIXVZy3xk>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id D824830600A9;
        Wed, 26 Aug 2020 04:40:20 -0400 (EDT)
Date:   Wed, 26 Aug 2020 16:40:19 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, linux-hyperv@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch RFC 10/38] x86/ioapic: Consolidate IOAPIC allocation
Message-ID: <20200826084019.GA6174@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200821002424.119492231@linutronix.de>
 <20200821002946.297823391@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200821002946.297823391@linutronix.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Thomas,

I hit a compiler error while I was trying to compile this patchset:

arch/x86/kernel/devicetree.c: In function ‘dt_irqdomain_alloc’:
arch/x86/kernel/devicetree.c:232:6: error: ‘struct irq_alloc_info’ has no member named ‘ioapic_id’; did you mean ‘ioapic’?
  232 |  tmp.ioapic_id = mpc_ioapic_id(mp_irqdomain_ioapic_idx(domain));
      |      ^~~~~~~~~
      |      ioapic
arch/x86/kernel/devicetree.c:233:6: error: ‘struct irq_alloc_info’ has no member named ‘ioapic_pin’; did you mean ‘ioapic’?
  233 |  tmp.ioapic_pin = fwspec->param[0]
      |      ^~~~~~~~~~
      |      ioapic

with CONFIG_OF=y. IIUC, the following changes are needed to fold into
this patch. (At least I can continue to compile the kernel with this
change)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index a0e8fc7d85f1..ddffd80f5c52 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -229,8 +229,8 @@ static int dt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	it = &of_ioapic_type[type_index];
 	ioapic_set_alloc_attr(&tmp, NUMA_NO_NODE, it->trigger, it->polarity);
-	tmp.ioapic_id = mpc_ioapic_id(mp_irqdomain_ioapic_idx(domain));
-	tmp.ioapic_pin = fwspec->param[0];
+	tmp.devid = mpc_ioapic_id(mp_irqdomain_ioapic_idx(domain));
+	tmp.ioapic.pin = fwspec->param[0];
 
 	return mp_irqdomain_alloc(domain, virq, nr_irqs, &tmp);
 }

Regards,
Boqun

On Fri, Aug 21, 2020 at 02:24:34AM +0200, Thomas Gleixner wrote:
> Move the IOAPIC specific fields into their own struct and reuse the common
> devid. Get rid of the #ifdeffery as it does not matter at all whether the
> alloc info is a couple of bytes longer or not.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: linux-hyperv@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Jon Derrick <jonathan.derrick@intel.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/include/asm/hw_irq.h       |   23 ++++++-----
>  arch/x86/kernel/apic/io_apic.c      |   70 ++++++++++++++++++------------------
>  drivers/iommu/amd/iommu.c           |   14 +++----
>  drivers/iommu/hyperv-iommu.c        |    2 -
>  drivers/iommu/intel/irq_remapping.c |   18 ++++-----
>  5 files changed, 64 insertions(+), 63 deletions(-)
> 
> --- a/arch/x86/include/asm/hw_irq.h
> +++ b/arch/x86/include/asm/hw_irq.h
> @@ -44,6 +44,15 @@ enum irq_alloc_type {
>  	X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT,
>  };
>  
> +struct ioapic_alloc_info {
> +	int				pin;
> +	int				node;
> +	u32				trigger : 1;
> +	u32				polarity : 1;
> +	u32				valid : 1;
> +	struct IO_APIC_route_entry	*entry;
> +};
> +
>  /**
>   * irq_alloc_info - X86 specific interrupt allocation info
>   * @type:	X86 specific allocation type
> @@ -53,6 +62,8 @@ enum irq_alloc_type {
>   * @mask:	CPU mask for vector allocation
>   * @desc:	Pointer to msi descriptor
>   * @data:	Allocation specific data
> + *
> + * @ioapic:	IOAPIC specific allocation data
>   */
>  struct irq_alloc_info {
>  	enum irq_alloc_type	type;
> @@ -64,6 +75,7 @@ struct irq_alloc_info {
>  	void			*data;
>  
>  	union {
> +		struct ioapic_alloc_info	ioapic;
>  		int		unused;
>  #ifdef	CONFIG_PCI_MSI
>  		struct {
> @@ -71,17 +83,6 @@ struct irq_alloc_info {
>  			irq_hw_number_t	msi_hwirq;
>  		};
>  #endif
> -#ifdef	CONFIG_X86_IO_APIC
> -		struct {
> -			int		ioapic_id;
> -			int		ioapic_pin;
> -			int		ioapic_node;
> -			u32		ioapic_trigger : 1;
> -			u32		ioapic_polarity : 1;
> -			u32		ioapic_valid : 1;
> -			struct IO_APIC_route_entry *ioapic_entry;
> -		};
> -#endif
>  #ifdef	CONFIG_DMAR_TABLE
>  		struct {
>  			int		dmar_id;
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -860,10 +860,10 @@ void ioapic_set_alloc_attr(struct irq_al
>  {
>  	init_irq_alloc_info(info, NULL);
>  	info->type = X86_IRQ_ALLOC_TYPE_IOAPIC;
> -	info->ioapic_node = node;
> -	info->ioapic_trigger = trigger;
> -	info->ioapic_polarity = polarity;
> -	info->ioapic_valid = 1;
> +	info->ioapic.node = node;
> +	info->ioapic.trigger = trigger;
> +	info->ioapic.polarity = polarity;
> +	info->ioapic.valid = 1;
>  }
>  
>  #ifndef CONFIG_ACPI
> @@ -878,32 +878,32 @@ static void ioapic_copy_alloc_attr(struc
>  
>  	copy_irq_alloc_info(dst, src);
>  	dst->type = X86_IRQ_ALLOC_TYPE_IOAPIC;
> -	dst->ioapic_id = mpc_ioapic_id(ioapic_idx);
> -	dst->ioapic_pin = pin;
> -	dst->ioapic_valid = 1;
> -	if (src && src->ioapic_valid) {
> -		dst->ioapic_node = src->ioapic_node;
> -		dst->ioapic_trigger = src->ioapic_trigger;
> -		dst->ioapic_polarity = src->ioapic_polarity;
> +	dst->devid = mpc_ioapic_id(ioapic_idx);
> +	dst->ioapic.pin = pin;
> +	dst->ioapic.valid = 1;
> +	if (src && src->ioapic.valid) {
> +		dst->ioapic.node = src->ioapic.node;
> +		dst->ioapic.trigger = src->ioapic.trigger;
> +		dst->ioapic.polarity = src->ioapic.polarity;
>  	} else {
> -		dst->ioapic_node = NUMA_NO_NODE;
> +		dst->ioapic.node = NUMA_NO_NODE;
>  		if (acpi_get_override_irq(gsi, &trigger, &polarity) >= 0) {
> -			dst->ioapic_trigger = trigger;
> -			dst->ioapic_polarity = polarity;
> +			dst->ioapic.trigger = trigger;
> +			dst->ioapic.polarity = polarity;
>  		} else {
>  			/*
>  			 * PCI interrupts are always active low level
>  			 * triggered.
>  			 */
> -			dst->ioapic_trigger = IOAPIC_LEVEL;
> -			dst->ioapic_polarity = IOAPIC_POL_LOW;
> +			dst->ioapic.trigger = IOAPIC_LEVEL;
> +			dst->ioapic.polarity = IOAPIC_POL_LOW;
>  		}
>  	}
>  }
>  
>  static int ioapic_alloc_attr_node(struct irq_alloc_info *info)
>  {
> -	return (info && info->ioapic_valid) ? info->ioapic_node : NUMA_NO_NODE;
> +	return (info && info->ioapic.valid) ? info->ioapic.node : NUMA_NO_NODE;
>  }
>  
>  static void mp_register_handler(unsigned int irq, unsigned long trigger)
> @@ -933,14 +933,14 @@ static bool mp_check_pin_attr(int irq, s
>  	 * pin with real trigger and polarity attributes.
>  	 */
>  	if (irq < nr_legacy_irqs() && data->count == 1) {
> -		if (info->ioapic_trigger != data->trigger)
> -			mp_register_handler(irq, info->ioapic_trigger);
> -		data->entry.trigger = data->trigger = info->ioapic_trigger;
> -		data->entry.polarity = data->polarity = info->ioapic_polarity;
> +		if (info->ioapic.trigger != data->trigger)
> +			mp_register_handler(irq, info->ioapic.trigger);
> +		data->entry.trigger = data->trigger = info->ioapic.trigger;
> +		data->entry.polarity = data->polarity = info->ioapic.polarity;
>  	}
>  
> -	return data->trigger == info->ioapic_trigger &&
> -	       data->polarity == info->ioapic_polarity;
> +	return data->trigger == info->ioapic.trigger &&
> +	       data->polarity == info->ioapic.polarity;
>  }
>  
>  static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
> @@ -1002,7 +1002,7 @@ static int alloc_isa_irq_from_domain(str
>  		if (!mp_check_pin_attr(irq, info))
>  			return -EBUSY;
>  		if (__add_pin_to_irq_node(irq_data->chip_data, node, ioapic,
> -					  info->ioapic_pin))
> +					  info->ioapic.pin))
>  			return -ENOMEM;
>  	} else {
>  		info->flags |= X86_IRQ_ALLOC_LEGACY;
> @@ -2092,8 +2092,8 @@ static int mp_alloc_timer_irq(int ioapic
>  		struct irq_alloc_info info;
>  
>  		ioapic_set_alloc_attr(&info, NUMA_NO_NODE, 0, 0);
> -		info.ioapic_id = mpc_ioapic_id(ioapic);
> -		info.ioapic_pin = pin;
> +		info.devid = mpc_ioapic_id(ioapic);
> +		info.ioapic.pin = pin;
>  		mutex_lock(&ioapic_mutex);
>  		irq = alloc_isa_irq_from_domain(domain, 0, ioapic, pin, &info);
>  		mutex_unlock(&ioapic_mutex);
> @@ -2297,7 +2297,7 @@ static int mp_irqdomain_create(int ioapi
>  
>  	init_irq_alloc_info(&info, NULL);
>  	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
> -	info.ioapic_id = mpc_ioapic_id(ioapic);
> +	info.devid = mpc_ioapic_id(ioapic);
>  	parent = irq_remapping_get_irq_domain(&info);
>  	if (!parent)
>  		parent = x86_vector_domain;
> @@ -2932,9 +2932,9 @@ int mp_ioapic_registered(u32 gsi_base)
>  static void mp_irqdomain_get_attr(u32 gsi, struct mp_chip_data *data,
>  				  struct irq_alloc_info *info)
>  {
> -	if (info && info->ioapic_valid) {
> -		data->trigger = info->ioapic_trigger;
> -		data->polarity = info->ioapic_polarity;
> +	if (info && info->ioapic.valid) {
> +		data->trigger = info->ioapic.trigger;
> +		data->polarity = info->ioapic.polarity;
>  	} else if (acpi_get_override_irq(gsi, &data->trigger,
>  					 &data->polarity) < 0) {
>  		/* PCI interrupts are always active low level triggered. */
> @@ -2980,7 +2980,7 @@ int mp_irqdomain_alloc(struct irq_domain
>  		return -EINVAL;
>  
>  	ioapic = mp_irqdomain_ioapic_idx(domain);
> -	pin = info->ioapic_pin;
> +	pin = info->ioapic.pin;
>  	if (irq_find_mapping(domain, (irq_hw_number_t)pin) > 0)
>  		return -EEXIST;
>  
> @@ -2988,7 +2988,7 @@ int mp_irqdomain_alloc(struct irq_domain
>  	if (!data)
>  		return -ENOMEM;
>  
> -	info->ioapic_entry = &data->entry;
> +	info->ioapic.entry = &data->entry;
>  	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
>  	if (ret < 0) {
>  		kfree(data);
> @@ -2996,7 +2996,7 @@ int mp_irqdomain_alloc(struct irq_domain
>  	}
>  
>  	INIT_LIST_HEAD(&data->irq_2_pin);
> -	irq_data->hwirq = info->ioapic_pin;
> +	irq_data->hwirq = info->ioapic.pin;
>  	irq_data->chip = (domain->parent == x86_vector_domain) ?
>  			  &ioapic_chip : &ioapic_ir_chip;
>  	irq_data->chip_data = data;
> @@ -3006,8 +3006,8 @@ int mp_irqdomain_alloc(struct irq_domain
>  	add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin);
>  
>  	local_irq_save(flags);
> -	if (info->ioapic_entry)
> -		mp_setup_entry(cfg, data, info->ioapic_entry);
> +	if (info->ioapic.entry)
> +		mp_setup_entry(cfg, data, info->ioapic.entry);
>  	mp_register_handler(virq, data->trigger);
>  	if (virq < nr_legacy_irqs())
>  		legacy_pic->mask(virq);
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3508,7 +3508,7 @@ static int get_devid(struct irq_alloc_in
>  	switch (info->type) {
>  	case X86_IRQ_ALLOC_TYPE_IOAPIC:
>  	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
> -		return get_ioapic_devid(info->ioapic_id);
> +		return get_ioapic_devid(info->devid);
>  	case X86_IRQ_ALLOC_TYPE_HPET:
>  	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
>  		return get_hpet_devid(info->devid);
> @@ -3586,15 +3586,15 @@ static void irq_remapping_prepare_irte(s
>  	switch (info->type) {
>  	case X86_IRQ_ALLOC_TYPE_IOAPIC:
>  		/* Setup IOAPIC entry */
> -		entry = info->ioapic_entry;
> -		info->ioapic_entry = NULL;
> +		entry = info->ioapic.entry;
> +		info->ioapic.entry = NULL;
>  		memset(entry, 0, sizeof(*entry));
>  		entry->vector        = index;
>  		entry->mask          = 0;
> -		entry->trigger       = info->ioapic_trigger;
> -		entry->polarity      = info->ioapic_polarity;
> +		entry->trigger       = info->ioapic.trigger;
> +		entry->polarity      = info->ioapic.polarity;
>  		/* Mask level triggered irqs. */
> -		if (info->ioapic_trigger)
> +		if (info->ioapic.trigger)
>  			entry->mask = 1;
>  		break;
>  
> @@ -3680,7 +3680,7 @@ static int irq_remapping_alloc(struct ir
>  					iommu->irte_ops->set_allocated(table, i);
>  			}
>  			WARN_ON(table->min_index != 32);
> -			index = info->ioapic_pin;
> +			index = info->ioapic.pin;
>  		} else {
>  			index = -ENOMEM;
>  		}
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -101,7 +101,7 @@ static int hyperv_irq_remapping_alloc(st
>  	 * in the chip_data and hyperv_irq_remapping_activate()/hyperv_ir_set_
>  	 * affinity() set vector and dest_apicid directly into IO-APIC entry.
>  	 */
> -	irq_data->chip_data = info->ioapic_entry;
> +	irq_data->chip_data = info->ioapic.entry;
>  
>  	/*
>  	 * Hypver-V IO APIC irq affinity should be in the scope of
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1113,7 +1113,7 @@ static struct irq_domain *intel_get_irq_
>  
>  	switch (info->type) {
>  	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
> -		return map_ioapic_to_ir(info->ioapic_id);
> +		return map_ioapic_to_ir(info->devid);
>  	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
>  		return map_hpet_to_ir(info->devid);
>  	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
> @@ -1254,16 +1254,16 @@ static void intel_irq_remapping_prepare_
>  	switch (info->type) {
>  	case X86_IRQ_ALLOC_TYPE_IOAPIC:
>  		/* Set source-id of interrupt request */
> -		set_ioapic_sid(irte, info->ioapic_id);
> +		set_ioapic_sid(irte, info->devid);
>  		apic_printk(APIC_VERBOSE, KERN_DEBUG "IOAPIC[%d]: Set IRTE entry (P:%d FPD:%d Dst_Mode:%d Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X Avail:%X Vector:%02X Dest:%08X SID:%04X SQ:%X SVT:%X)\n",
> -			info->ioapic_id, irte->present, irte->fpd,
> +			info->devid, irte->present, irte->fpd,
>  			irte->dst_mode, irte->redir_hint,
>  			irte->trigger_mode, irte->dlvry_mode,
>  			irte->avail, irte->vector, irte->dest_id,
>  			irte->sid, irte->sq, irte->svt);
>  
> -		entry = (struct IR_IO_APIC_route_entry *)info->ioapic_entry;
> -		info->ioapic_entry = NULL;
> +		entry = (struct IR_IO_APIC_route_entry *)info->ioapic.entry;
> +		info->ioapic.entry = NULL;
>  		memset(entry, 0, sizeof(*entry));
>  		entry->index2	= (index >> 15) & 0x1;
>  		entry->zero	= 0;
> @@ -1273,11 +1273,11 @@ static void intel_irq_remapping_prepare_
>  		 * IO-APIC RTE will be configured with virtual vector.
>  		 * irq handler will do the explicit EOI to the io-apic.
>  		 */
> -		entry->vector	= info->ioapic_pin;
> +		entry->vector	= info->ioapic.pin;
>  		entry->mask	= 0;			/* enable IRQ */
> -		entry->trigger	= info->ioapic_trigger;
> -		entry->polarity	= info->ioapic_polarity;
> -		if (info->ioapic_trigger)
> +		entry->trigger	= info->ioapic.trigger;
> +		entry->polarity	= info->ioapic.polarity;
> +		if (info->ioapic.trigger)
>  			entry->mask = 1; /* Mask level triggered irqs. */
>  		break;
>  
> 
