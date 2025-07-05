Return-Path: <linux-hyperv+bounces-6108-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18D8AF9F6A
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Jul 2025 11:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A936566ABA
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Jul 2025 09:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892181E25ED;
	Sat,  5 Jul 2025 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/WLde/v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dah4F2Z7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FFB2E3704;
	Sat,  5 Jul 2025 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751708829; cv=none; b=WA+jqDgE+Jmuk5qmnu1/E2j2ffwUdHZDyXoYH7AYWqEmSNsLnZwInn+QQc2o3kXt5EcEMdnYBycoW834soxSm9xgSm1A4iwRbd3XSMl5h0wA181TrZQIAOZ6WO3uMbOUFGEU9onsH8Tag0gm3NwqfLJnGlEVHzORX1e61TsXvpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751708829; c=relaxed/simple;
	bh=lRYmnaghuqzL/kVxi1vZDETz6WC4612GuFAiFXqwYzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHdOv35dqdmHWPRucZHjfiLHmxfXNQGpn7poh6VXsjmYKI5YF18YmLNYQHg9WtRJfTtKBP4dApY9sssop/0hVIP+FaVMH8TvmJTw6GcGOdAzKnsRdABA/TZWMLrnrlD2w/QEkeUPTlNgKS3iy+mB0yOlNk9X5wPGbXHirjhZU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/WLde/v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dah4F2Z7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 5 Jul 2025 11:46:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751708819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GdwreS4DcLMun11pZJHKkn7AUAHPItwneYmFyP/CaMI=;
	b=V/WLde/v9ygZFKX4EuPG7S5BY70JbyIDbq6cCmeZSOvG1qyIi3wibtCn52HYSWdX7HC2tm
	b2wuBQ42rVlVRuByE2zYg5kJmJTHPcsqERtsTFPXhZSQcPSdZjgUiq7LT2j5Q6ae43Bjm0
	tTYwe/Lj9CDuhTrwTIyergRL8OvaknuXk7Bt4AQOXJps++yEAyIr7y++Sj2xydEt5ypaz6
	lSqXnFws5GdRbf7u/HacxmrHbjshtSpR9dvse4USnFSoGXvN6sP6iSkiUux/sMURT/qdx1
	CDR4gjMOw+tW183bxg6LnBBwNBEfXPBfk+DW39w9hew9EKlcXo4Zmm3st0rOWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751708819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GdwreS4DcLMun11pZJHKkn7AUAHPItwneYmFyP/CaMI=;
	b=Dah4F2Z7oY9mGBLzEtdKWgA9C0YaK9+zhIzsIGl+bZjH5u8evvxGxgVpkfg8TFU7JmIduR
	1X90hDfVLcMFnsDw==
From: Nam Cao <namcao@linutronix.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 14/16] PCI: hv: Switch to msi_create_parent_irq_domain()
Message-ID: <20250705094655.sEu3KWbJ@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
 <SN6PR02MB41571145B5ECA505CDA6BD90D44DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41571145B5ECA505CDA6BD90D44DA@SN6PR02MB4157.namprd02.prod.outlook.com>

On Sat, Jul 05, 2025 at 03:51:48AM +0000, Michael Kelley wrote:
> From: Nam Cao <namcao@linutronix.de> Sent: Thursday, June 26, 2025 7:48 AM
> > 
> > Move away from the legacy MSI domain setup, switch to use
> > msi_create_parent_irq_domain().
> 
> With the additional tweak to this patch that you supplied separately,
> everything in my testing on both x86 and arm64 seems to work OK. So
> that's all good.
> 
> On arm64, I did notice the following IRQ domain information from
> /sys/kernel/debug/irq/domains:
> 
> # cat HV-PCI-MSIX-1e03\:00\:00.0-12
> name:   HV-PCI-MSIX-1e03:00:00.0-12
>  size:   0
>  mapped: 7
>  flags:  0x00000213
>             IRQ_DOMAIN_FLAG_HIERARCHY
>             IRQ_DOMAIN_NAME_ALLOCATED
>             IRQ_DOMAIN_FLAG_MSI
>             IRQ_DOMAIN_FLAG_MSI_DEVICE
>  parent: 5D202AA8-1E03-4F0F-A786-390A0D2749E9-3
>     name:   5D202AA8-1E03-4F0F-A786-390A0D2749E9-3
>      size:   0
>      mapped: 7
>      flags:  0x00000103
>                 IRQ_DOMAIN_FLAG_HIERARCHY
>                 IRQ_DOMAIN_NAME_ALLOCATED
>                 IRQ_DOMAIN_FLAG_MSI_PARENT
>      parent: hv_vpci_arm64
>         name:   hv_vpci_arm64
>          size:   956
>          mapped: 31
>          flags:  0x00000003
>                     IRQ_DOMAIN_FLAG_HIERARCHY
>                     IRQ_DOMAIN_NAME_ALLOCATED
>          parent: irqchip@0x00000000ffff0000-1
>             name:   irqchip@0x00000000ffff0000-1
>              size:   0
>              mapped: 47
>              flags:  0x00000003
>                         IRQ_DOMAIN_FLAG_HIERARCHY
>                         IRQ_DOMAIN_NAME_ALLOCATED
> 
> The 5D202AA8-1E03-4F0F-A786-390A0D2749E9-3 domain has
> IRQ_DOMAIN_FLAG_MSI_PARENT set. But the hv_vpci_arm64
> and irqchip@... domains do not.  Is that a problem?  On x86,
> the output is this, with IRQ_DOMAIN_FLAG_MSI_PARENT set
> in the next level up VECTOR domain:

That looks normal. IRQ_DOMAIN_FLAG_MSI_PARENT is set for domains which
provide MSI parent domain capability, which happens to be the case for x86
vector.

> # cat HV-PCI-MSIX-6b71\:00\:02.0-12
> name:   HV-PCI-MSIX-6b71:00:02.0-12
>  size:   0
>  mapped: 17
>  flags:  0x00000213
>             IRQ_DOMAIN_FLAG_HIERARCHY
>             IRQ_DOMAIN_NAME_ALLOCATED
>             IRQ_DOMAIN_FLAG_MSI
>             IRQ_DOMAIN_FLAG_MSI_DEVICE
>  parent: 8564CB14-6B71-477C-B189-F175118E6FF0-3
>     name:   8564CB14-6B71-477C-B189-F175118E6FF0-3
>      size:   0
>      mapped: 17
>      flags:  0x00000103
>                 IRQ_DOMAIN_FLAG_HIERARCHY
>                 IRQ_DOMAIN_NAME_ALLOCATED
>                 IRQ_DOMAIN_FLAG_MSI_PARENT
>      parent: VECTOR
>         name:   VECTOR
>          size:   0
>          mapped: 67
>          flags:  0x00000103
>                     IRQ_DOMAIN_FLAG_HIERARCHY
>                     IRQ_DOMAIN_NAME_ALLOCATED
>                     IRQ_DOMAIN_FLAG_MSI_PARENT
> 
> Finally, I've noted a couple of code review comments below. These
> comments may reflect my lack of fully understanding the MSI
> IRQ handling, in which case, please set me straight. Thanks,
> 
> Michael
> 
> > 
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > ---
> > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Cc: linux-hyperv@vger.kernel.org
> > ---
> >  drivers/pci/Kconfig                 |  1 +
> >  drivers/pci/controller/pci-hyperv.c | 98 +++++++++++++++++++++++------
> >  2 files changed, 80 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 9c0e4aaf4e8cb..9a249c65aedcd 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -223,6 +223,7 @@ config PCI_HYPERV
> >  	tristate "Hyper-V PCI Frontend"
> >  	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && SYSFS
> >  	select PCI_HYPERV_INTERFACE
> > +	select IRQ_MSI_LIB
> >  	help
> >  	  The PCI device frontend driver allows the kernel to import arbitrary
> >  	  PCI devices from a PCI backend to support PCI driver domains.
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index ef5d655a0052c..3a24fadddb83b 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -44,6 +44,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/semaphore.h>
> >  #include <linux/irq.h>
> > +#include <linux/irqchip/irq-msi-lib.h>
> >  #include <linux/msi.h>
> >  #include <linux/hyperv.h>
> >  #include <linux/refcount.h>
> > @@ -508,7 +509,6 @@ struct hv_pcibus_device {
> >  	struct list_head children;
> >  	struct list_head dr_list;
> > 
> > -	struct msi_domain_info msi_info;
> >  	struct irq_domain *irq_domain;
> > 
> >  	struct workqueue_struct *wq;
> > @@ -1687,7 +1687,7 @@ static void hv_msi_free(struct irq_domain *domain, struct msi_domain_info *info,
> >  	struct msi_desc *msi = irq_data_get_msi_desc(irq_data);
> > 
> >  	pdev = msi_desc_to_pci_dev(msi);
> > -	hbus = info->data;
> > +	hbus = domain->host_data;
> >  	int_desc = irq_data_get_irq_chip_data(irq_data);
> >  	if (!int_desc)
> >  		return;
> > @@ -1705,7 +1705,6 @@ static void hv_msi_free(struct irq_domain *domain, struct msi_domain_info *info,
> > 
> >  static void hv_irq_mask(struct irq_data *data)
> >  {
> > -	pci_msi_mask_irq(data);
> >  	if (data->parent_data->chip->irq_mask)
> >  		irq_chip_mask_parent(data);
> >  }
> > @@ -1716,7 +1715,6 @@ static void hv_irq_unmask(struct irq_data *data)
> > 
> >  	if (data->parent_data->chip->irq_unmask)
> >  		irq_chip_unmask_parent(data);
> > -	pci_msi_unmask_irq(data);
> >  }
> > 
> >  struct compose_comp_ctxt {
> > @@ -2101,6 +2099,44 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> >  	msg->data = 0;
> >  }
> > 
> > +static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> > +				      struct irq_domain *real_parent, struct msi_domain_info *info)
> > +{
> > +	struct irq_chip *chip = info->chip;
> > +
> > +	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> > +		return false;
> > +
> > +	info->ops->msi_prepare = hv_msi_prepare;
> > +
> > +	chip->irq_set_affinity = irq_chip_set_affinity_parent;
> > +
> > +	if (IS_ENABLED(CONFIG_X86))
> > +		chip->flags |= IRQCHIP_MOVE_DEFERRED;
> > +
> > +	return true;
> > +}
> > +
> > +#define HV_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
> > +				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
> > +				    MSI_FLAG_PCI_MSI_MASK_PARENT)
> > +#define HV_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI	| \
> > +				     MSI_FLAG_PCI_MSIX			| \
> > +				     MSI_GENERIC_FLAGS_MASK)
> > +
> > +static const struct msi_parent_ops hv_pcie_msi_parent_ops = {
> > +	.required_flags		= HV_PCIE_MSI_FLAGS_REQUIRED,
> > +	.supported_flags	= HV_PCIE_MSI_FLAGS_SUPPORTED,
> > +	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
> > +#ifdef CONFIG_X86
> > +	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
> > +#elif defined(CONFIG_ARM64)
> > +	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
> > +#endif
> > +	.prefix			= "HV-",
> > +	.init_dev_msi_info	= hv_pcie_init_dev_msi_info,
> > +};
> > +
> >  /* HW Interrupt Chip Descriptor */
> >  static struct irq_chip hv_msi_irq_chip = {
> >  	.name			= "Hyper-V PCIe MSI",
> > @@ -2108,7 +2144,6 @@ static struct irq_chip hv_msi_irq_chip = {
> >  	.irq_set_affinity	= irq_chip_set_affinity_parent,
> >  #ifdef CONFIG_X86
> >  	.irq_ack		= irq_chip_ack_parent,
> > -	.flags			= IRQCHIP_MOVE_DEFERRED,
> >  #elif defined(CONFIG_ARM64)
> >  	.irq_eoi		= irq_chip_eoi_parent,
> >  #endif
> 
> Would it work to drop the #ifdef's and always set both .irq_ack and
> .irq_eoi on x86 and on ARM64?  Is which one gets called controlled by the
> child HV-PCI-MSIX- ... domain, based on the .chip_flags?
>
> I'm trying to reduce the #ifdef clutter. I
> tested without the #ifdefs on both x86 and arm64, and
> everything works, but I know that doesn't prove that it's
> OK.

Nothing is wrong with that, as far as I can tell.

> If the #ifdefs can go away, then I'd like to see a tweak to the way
> .chip_flags is set. Rather than do an #ifdef inline for struct
> msi_parent_ops hv_pcie_msi_parent_ops, add a #define
> HV_MSI_CHIP_FLAGS in the existing #ifdef X86 and #ifdef ARM64
> sections respectively near the top of this source file, and then
> use HV_MSI_CHIP_FLAGS in struct msi_parent_ops
> hv_pcie_msi_parent_ops.  As much as is reasonable, I'd like to
> not clutter the code with #ifdef X86 #elseif ARM64, but instead
> group all the differences under the existing #ifdefs near the top.
> There are some places where this isn't practical, but this seems
> like a place that is practical.

Yes, that would be better. I will do it in v2.

> > @@ -2116,9 +2151,37 @@ static struct irq_chip hv_msi_irq_chip = {
> >  	.irq_unmask		= hv_irq_unmask,
> >  };
> > 
> > -static struct msi_domain_ops hv_msi_ops = {
> > -	.msi_prepare	= hv_msi_prepare,
> > -	.msi_free	= hv_msi_free,
> > +static int hv_pcie_domain_alloc(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs,
> > +			       void *arg)
> > +{
> > +	/* TODO: move the content of hv_compose_msi_msg() in here */
> 
> Could you elaborate on this TODO? Is the idea to loop through all the IRQs and
> generate the MSI message for each one? What is the advantage to doing it here?
> I noticed in Patch 3 of the series, the Aardvark controller has
> advk_msi_irq_compose_msi_msg(), but you had not moved it into the domain
> allocation path.

Sorry for being unclear. hv_compose_msi_msg() should not be moved here
entirely. Let me elaborate this in v2.

What I meant is that, hv_compose_msi_msg() is doing more than what this
callback is supposed to do (composing message). It works, but it is not
correct. Interrupt allocation is the responsibility of
irq_domain_ops::alloc(). Allocating and populating int_desc should be in
hv_pcie_domain_alloc() instead.

irq_domain_ops's .alloc() and .free() should be asymmetric.

> 
> Also, is there some point in the time in the future where the "TODO" is likely to
> become a "MUST DO"?

There's nothing planned that would make this non-functional, as far as I
know.

Thanks so much for examining the patch,
Nam

