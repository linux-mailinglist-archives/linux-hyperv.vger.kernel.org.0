Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6582356703B
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jul 2022 16:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiGEOFh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jul 2022 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiGEOFP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jul 2022 10:05:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4ADC1C;
        Tue,  5 Jul 2022 06:52:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e12so20667778lfr.6;
        Tue, 05 Jul 2022 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hnG3EXAGSYglCl/wRCeE6XoUd122X8s3VFjj/Cl4BDo=;
        b=f0oPNRCtup46ssQPcrkajodUnXaa38S7aucBwdDILFTG2eeb4ezSSagYCCpSaPXn6q
         pM88V+eJuR+2wDKnqOvmIn2UBQeLj4Dvk+jM/7QzsaH+djXUCf8dVdZrR3Rum0ZxA4Fx
         1+V5jQK4WZ6A6r+Z7pGJ3DHRh/l/I+n6TS11toC5D+NwQqpCXjbGQMtOFJd9gZJEVfoN
         8o6r4MmM6XpKVa4t/W7kzcEgwfUE3Y+OozwbzeYUm+9Cfc1rCiR8kyXeLGCPMRo+QW0N
         dWcQwNP8U6XumHQBe98yfaBeLuhKipyLuPvGkvNRoq32ZtcDVOLho4L9W1jGhun/Kcvn
         3uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hnG3EXAGSYglCl/wRCeE6XoUd122X8s3VFjj/Cl4BDo=;
        b=e9IxXw9yie4rAH2fcd/8xGU4uzcy6Yuw7ffUpPlALqtTj1Ip+P31oYLhqzKTHSnj3G
         hrN2+/5NEgW0s0PoZDYptyxaJzs419tIOBtT+/QmJMFl4Fx1HL+u/1AiibdMwR6Q7fBJ
         5QLcz/ciIeZ1hBXVcsylhl369WtMhIOlSCnu1VIqmBYt2iGenrcaNWY/YH0Ecr474UG/
         YJvudaP0HdbPJHtD9piRhk0O/iUOHsqHeyCY5S43FkmMbzIgfEcuPKSc6Xd1IMGwpP1f
         YUFdm9Y98nn3SC1v+vsnAumO0iU+Dqe30YarDXOsI5fRxLoEMslmPYSiASHm+87PVfca
         NVAQ==
X-Gm-Message-State: AJIora/+HwYkx1vvb34rItGUmI3TE0GEJeKBAXzB36wnyUg4Rkx6XuW5
        SAfw0a2iMcOSoTUEv9XkIYM=
X-Google-Smtp-Source: AGRyM1tzQQEVczY5NcmNDovprbd7u0K8INSqZ44DlUGhkZwwx9elVzmtIOyIVqDnGRJUYz9FEGSPyA==
X-Received: by 2002:a05:6512:b1a:b0:47f:b574:9539 with SMTP id w26-20020a0565120b1a00b0047fb5749539mr21685925lfu.143.1657029167643;
        Tue, 05 Jul 2022 06:52:47 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v19-20020ac258f3000000b00483f8c40c14sm262435lfo.243.2022.07.05.06.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:52:47 -0700 (PDT)
Date:   Tue, 5 Jul 2022 16:52:43 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Samuel Holland <samuel@sholland.org>, Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chris Zankel <chris@zankel.net>,
        Colin Ian King <colin.king@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jan Beulich <jbeulich@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        Juergen Gross <jgross@suse.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sven Schnelle <svens@stackframe.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Wei Liu <wei.liu@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/8] irqchip/mips-gic: Only register IPI domain when
 SMP is enabled
Message-ID: <20220705135243.ydbwfo4kois64elr@mobilestation>
References: <20220701200056.46555-1-samuel@sholland.org>
 <20220701200056.46555-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701200056.46555-2-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Samuel

On Fri, Jul 01, 2022 at 03:00:49PM -0500, Samuel Holland wrote:
> The MIPS GIC irqchip driver may be selected in a uniprocessor
> configuration, but it unconditionally registers an IPI domain.
> 
> Limit the part of the driver dealing with IPIs to only be compiled when
> GENERIC_IRQ_IPI is enabled, which corresponds to an SMP configuration.

Thanks for the patch. Some comment is below.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v3:
>  - New patch to fix build errors in uniprocessor MIPS configs
> 
>  drivers/irqchip/Kconfig        |  3 +-
>  drivers/irqchip/irq-mips-gic.c | 80 +++++++++++++++++++++++-----------
>  2 files changed, 56 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 1f23a6be7d88..d26a4ff7c99f 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -322,7 +322,8 @@ config KEYSTONE_IRQ
>  
>  config MIPS_GIC
>  	bool
> -	select GENERIC_IRQ_IPI
> +	select GENERIC_IRQ_IPI if SMP

> +	select IRQ_DOMAIN_HIERARCHY

It seems to me that the IRQ domains hierarchy is supposed to be
created only if IPI is required. At least that's what the MIPS GIC
driver implies. Thus we can go further and CONFIG_IRQ_DOMAIN_HIERARCHY
ifdef-out the gic_irq_domain_alloc() and gic_irq_domain_free()
methods definition together with the initialization:

 static const struct irq_domain_ops gic_irq_domain_ops = {
 	.xlate = gic_irq_domain_xlate,
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	.alloc = gic_irq_domain_alloc,
 	.free = gic_irq_domain_free,
+#endif
 	.map = gic_irq_domain_map,
};

If the GENERIC_IRQ_IPI config is enabled, CONFIG_IRQ_DOMAIN_HIERARCHY
will be automatically selected (see the config definition in
kernel/irq/Kconfig). If the IRQs hierarchy is needed for some another
functionality like GENERIC_MSI_IRQ_DOMAIN or GPIOs then they will
explicitly enable the IRQ_DOMAIN_HIERARCHY config thus activating the
denoted .alloc and .free methods definitions.

To sum up you can get rid of the IRQ_DOMAIN_HIERARCHY config
force-select from this patch and make the MIPS GIC driver code a bit
more coherent.

@Marc, please correct me if were wrong.

-Serget

>  	select MIPS_CM
>  
>  config INGENIC_IRQ
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index ff89b36267dd..8a9efb6ae587 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -52,13 +52,15 @@ static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
>  
>  static DEFINE_SPINLOCK(gic_lock);
>  static struct irq_domain *gic_irq_domain;
> -static struct irq_domain *gic_ipi_domain;
>  static int gic_shared_intrs;
>  static unsigned int gic_cpu_pin;
>  static unsigned int timer_cpu_pin;
>  static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
> +
> +#ifdef CONFIG_GENERIC_IRQ_IPI
>  static DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
>  static DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
> +#endif /* CONFIG_GENERIC_IRQ_IPI */
>  
>  static struct gic_all_vpes_chip_data {
>  	u32	map;
> @@ -472,9 +474,11 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
>  	u32 map;
>  
>  	if (hwirq >= GIC_SHARED_HWIRQ_BASE) {
> +#ifdef CONFIG_GENERIC_IRQ_IPI
>  		/* verify that shared irqs don't conflict with an IPI irq */
>  		if (test_bit(GIC_HWIRQ_TO_SHARED(hwirq), ipi_resrv))
>  			return -EBUSY;
> +#endif /* CONFIG_GENERIC_IRQ_IPI */
>  
>  		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
>  						    &gic_level_irq_controller,
> @@ -567,6 +571,8 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
>  	.map = gic_irq_domain_map,
>  };
>  
> +#ifdef CONFIG_GENERIC_IRQ_IPI
> +
>  static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
>  				const u32 *intspec, unsigned int intsize,
>  				irq_hw_number_t *out_hwirq,
> @@ -670,6 +676,48 @@ static const struct irq_domain_ops gic_ipi_domain_ops = {
>  	.match = gic_ipi_domain_match,
>  };
>  
> +static int gic_register_ipi_domain(struct device_node *node)
> +{
> +	struct irq_domain *gic_ipi_domain;
> +	unsigned int v[2], num_ipis;
> +
> +	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
> +						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
> +						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
> +						  node, &gic_ipi_domain_ops, NULL);
> +	if (!gic_ipi_domain) {
> +		pr_err("Failed to add IPI domain");
> +		return -ENXIO;
> +	}
> +
> +	irq_domain_update_bus_token(gic_ipi_domain, DOMAIN_BUS_IPI);
> +
> +	if (node &&
> +	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", v, 2)) {
> +		bitmap_set(ipi_resrv, v[0], v[1]);
> +	} else {
> +		/*
> +		 * Reserve 2 interrupts per possible CPU/VP for use as IPIs,
> +		 * meeting the requirements of arch/mips SMP.
> +		 */
> +		num_ipis = 2 * num_possible_cpus();
> +		bitmap_set(ipi_resrv, gic_shared_intrs - num_ipis, num_ipis);
> +	}
> +
> +	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
> +
> +	return 0;
> +}
> +
> +#else /* !CONFIG_GENERIC_IRQ_IPI */
> +
> +static inline int gic_register_ipi_domain(struct device_node *node)
> +{
> +	return 0;
> +}
> +
> +#endif /* !CONFIG_GENERIC_IRQ_IPI */
> +
>  static int gic_cpu_startup(unsigned int cpu)
>  {
>  	/* Enable or disable EIC */
> @@ -688,11 +736,12 @@ static int gic_cpu_startup(unsigned int cpu)
>  static int __init gic_of_init(struct device_node *node,
>  			      struct device_node *parent)
>  {
> -	unsigned int cpu_vec, i, gicconfig, v[2], num_ipis;
> +	unsigned int cpu_vec, i, gicconfig;
>  	unsigned long reserved;
>  	phys_addr_t gic_base;
>  	struct resource res;
>  	size_t gic_len;
> +	int ret;
>  
>  	/* Find the first available CPU vector. */
>  	i = 0;
> @@ -780,30 +829,9 @@ static int __init gic_of_init(struct device_node *node,
>  		return -ENXIO;
>  	}
>  
> -	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
> -						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
> -						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
> -						  node, &gic_ipi_domain_ops, NULL);
> -	if (!gic_ipi_domain) {
> -		pr_err("Failed to add IPI domain");
> -		return -ENXIO;
> -	}
> -
> -	irq_domain_update_bus_token(gic_ipi_domain, DOMAIN_BUS_IPI);
> -
> -	if (node &&
> -	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", v, 2)) {
> -		bitmap_set(ipi_resrv, v[0], v[1]);
> -	} else {
> -		/*
> -		 * Reserve 2 interrupts per possible CPU/VP for use as IPIs,
> -		 * meeting the requirements of arch/mips SMP.
> -		 */
> -		num_ipis = 2 * num_possible_cpus();
> -		bitmap_set(ipi_resrv, gic_shared_intrs - num_ipis, num_ipis);
> -	}
> -
> -	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
> +	ret = gic_register_ipi_domain(node);
> +	if (ret)
> +		return ret;
>  
>  	board_bind_eic_interrupt = &gic_bind_eic_interrupt;
>  
> -- 
> 2.35.1
> 
