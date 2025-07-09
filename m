Return-Path: <linux-hyperv+bounces-6170-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC278AFF570
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 01:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFCB5A5021
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 23:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9EE2641F8;
	Wed,  9 Jul 2025 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gny0k8va"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D748633F;
	Wed,  9 Jul 2025 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752104418; cv=none; b=evlEZIqjef4jK3PGOsjwdp0CE2EA+qM3zVYH35yaAyLbFHFF/0lGujuldBZEiibBo+OWxZqpsb5LZ1cRK2mi2xtSVw8Y2wVaYJ2lp/8krZdPK0odc731LSniw3+og0JCQ2AM/OkiMDYQfGqETOtxozT75rxu4nxbvjZDq0xQHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752104418; c=relaxed/simple;
	bh=QGQ+IStDpzGT5TB54YyUkR1VFMdLKKuUTEtsSXqf0ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHtMjXHgvWktxgD2bhm5UMm1jzqgWNAwwkLIPQ1EtGpSpafK+PLMRVxhj8xLucU+BDl5VO+vmbZQd8xV2zNU6gPSVHoNtZ6zYXBelV9hEa+I7obfK6bkqOdyWD4+CTMVSD56OiP5o5MatNhmb8PzOXfirv5Bi+S6i7adtDbFLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gny0k8va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFBDC4CEEF;
	Wed,  9 Jul 2025 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752104417;
	bh=QGQ+IStDpzGT5TB54YyUkR1VFMdLKKuUTEtsSXqf0ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gny0k8va9L2bC65dGRlL80H01KFvP+jcfHCjykFQ8pg+kfl/lHc2lfCoUujQJvuHt
	 PfzkyPe2GzX2iC82RK7DVeAnz6kVGdfEO2ngQ0DVZ/lcFGMZp9RfBH+6RqtuTj/64A
	 JH2QkxLce61L19EaDLRtvELenec0u7msn/lm61mfHVu7l2v9wVC0bakfBQwNuKK5JB
	 ihhQOVhwmKOloqM1zSJcJe7rTzRIIWpHcyKbkNB0BNfNBtg3FxkhtQwFVfOPOEZeiM
	 AOSt6dzUXHO9vBK9p+Nwft6YsPSSTahAp3zES+CLJtoIqIoLqdesm3XB15773Ua3WX
	 2fRyThAg/RY4Q==
Date: Wed, 9 Jul 2025 23:40:15 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, Marc Zyngier <maz@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, nunodasneves@linux.microsoft.com
Subject: Re: [PATCH v2 2/2] x86/hyperv: Switch to
 msi_create_parent_irq_domain()
Message-ID: <aG7932u1SvvAYh2l@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <cover.1751277765.git.namcao@linutronix.de>
 <5c0ada725449176dfeeb1f7aa98c324066c39d2c.1751277765.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0ada725449176dfeeb1f7aa98c324066c39d2c.1751277765.git.namcao@linutronix.de>

CC Nuno who is also touching on this file.

Nam, thanks for this patch. 

Nuno's patches fix a few bugs with the current implementation. I expect
those patches to have contextual conflicts with this patch. I would like
to commit Nuno's patches first since those are bug fixes, and then
circle back to this one.

Nuno, can you please review this patch?

On Mon, Jun 30, 2025 at 12:26:15PM +0200, Nam Cao wrote:
> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().
> 
> While doing the conversion, I noticed that hv_irq_compose_msi_msg() is
> doing more than it is supposed to (composing message content). The
> interrupt allocation bits should be moved into hv_msi_domain_alloc().
> However, I have no hardware to test this change, therefore I leave a TODO
> note.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  arch/x86/hyperv/irqdomain.c | 111 ++++++++++++++++++++++++------------
>  drivers/hv/Kconfig          |   1 +
>  2 files changed, 77 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 31f0d29cbc5e3..9b3b65ffbd2e2 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/pci.h>
>  #include <linux/irq.h>
> +#include <linux/irqchip/irq-msi-lib.h>
>  #include <asm/mshyperv.h>
>  
>  static int hv_map_interrupt(union hv_device_id device_id, bool level,
> @@ -276,59 +277,99 @@ static void hv_teardown_msi_irq(struct pci_dev *dev, struct irq_data *irqd)
>  		hv_status_err(status, "\n");
>  }
>  
> -static void hv_msi_free_irq(struct irq_domain *domain,
> -			    struct msi_domain_info *info, unsigned int virq)
> -{
> -	struct irq_data *irqd = irq_get_irq_data(virq);
> -	struct msi_desc *desc;
> -
> -	if (!irqd)
> -		return;
> -
> -	desc = irq_data_get_msi_desc(irqd);
> -	if (!desc || !desc->irq || WARN_ON_ONCE(!dev_is_pci(desc->dev)))
> -		return;
> -
> -	hv_teardown_msi_irq(to_pci_dev(desc->dev), irqd);
> -}
> -
>  /*
>   * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
>   * which implement the MSI or MSI-X Capability Structure.
>   */
>  static struct irq_chip hv_pci_msi_controller = {
>  	.name			= "HV-PCI-MSI",
> -	.irq_unmask		= pci_msi_unmask_irq,
> -	.irq_mask		= pci_msi_mask_irq,
>  	.irq_ack		= irq_chip_ack_parent,
> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
> -	.irq_set_affinity	= msi_domain_set_affinity,
> -	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>  };
>  
> -static struct msi_domain_ops pci_msi_domain_ops = {
> -	.msi_free		= hv_msi_free_irq,
> -	.msi_prepare		= pci_msi_prepare,
> +static bool hv_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> +				 struct irq_domain *real_parent, struct msi_domain_info *info)
> +{
> +	struct irq_chip *chip = info->chip;
> +
> +	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> +		return false;
> +
> +	chip->flags |= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED;
> +
> +	info->ops->msi_prepare = pci_msi_prepare;
> +
> +	return true;
> +}
> +
> +#define HV_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX)
> +#define HV_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS)
> +
> +static struct msi_parent_ops hv_msi_parent_ops = {
> +	.supported_flags	= HV_MSI_FLAGS_SUPPORTED,
> +	.required_flags		= HV_MSI_FLAGS_REQUIRED,
> +	.bus_select_token	= DOMAIN_BUS_NEXUS,
> +	.bus_select_mask	= MATCH_PCI_MSI,
> +	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
> +	.prefix			= "HV-",
> +	.init_dev_msi_info	= hv_init_dev_msi_info,
>  };
>  
> -static struct msi_domain_info hv_pci_msi_domain_info = {
> -	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -			  MSI_FLAG_PCI_MSIX,
> -	.ops		= &pci_msi_domain_ops,
> -	.chip		= &hv_pci_msi_controller,
> -	.handler	= handle_edge_irq,
> -	.handler_name	= "edge",
> +static int hv_msi_domain_alloc(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs,
> +			       void *arg)
> +{
> +	/*
> +	 * TODO: The allocation bits of hv_irq_compose_msi_msg(), i.e. everything except
> +	 * entry_to_msi_msg() should be in here.
> +	 */
> +
> +	int ret;
> +
> +	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, arg);
> +	if (ret)
> +		return ret;
> +
> +	for (int i = 0; i < nr_irqs; ++i) {
> +		irq_domain_set_info(d, virq + i, 0, &hv_pci_msi_controller, NULL,
> +				    handle_edge_irq, NULL, "edge");
> +	}
> +	return 0;
> +}
> +
> +static void hv_msi_domain_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
> +{
> +	for (int i = 0; i < nr_irqs; ++i) {
> +		struct irq_data *irqd = irq_domain_get_irq_data(d, virq);
> +		struct msi_desc *desc;
> +
> +		desc = irq_data_get_msi_desc(irqd);
> +		if (!desc || !desc->irq || WARN_ON_ONCE(!dev_is_pci(desc->dev)))
> +			continue;
> +
> +		hv_teardown_msi_irq(to_pci_dev(desc->dev), irqd);
> +	}
> +	irq_domain_free_irqs_top(d, virq, nr_irqs);
> +}
> +
> +static const struct irq_domain_ops hv_msi_domain_ops = {
> +	.select	= msi_lib_irq_domain_select,
> +	.alloc	= hv_msi_domain_alloc,
> +	.free	= hv_msi_domain_free,
>  };
>  
>  struct irq_domain * __init hv_create_pci_msi_domain(void)
>  {
>  	struct irq_domain *d = NULL;
> -	struct fwnode_handle *fn;
>  
> -	fn = irq_domain_alloc_named_fwnode("HV-PCI-MSI");
> -	if (fn)
> -		d = pci_msi_create_irq_domain(fn, &hv_pci_msi_domain_info, x86_vector_domain);
> +	struct irq_domain_info info = {
> +		.fwnode		= irq_domain_alloc_named_fwnode("HV-PCI-MSI"),
> +		.ops		= &hv_msi_domain_ops,
> +		.parent		= x86_vector_domain,
> +	};
> +
> +	if (info.fwnode)
> +		d = msi_create_parent_irq_domain(&info, &hv_msi_parent_ops);
>  
>  	/* No point in going further if we can't get an irq domain */
>  	BUG_ON(!d);
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 1cd188b73b743..e62a0f8b34198 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -10,6 +10,7 @@ config HYPERV
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select OF_EARLY_FLATTREE if OF
>  	select SYSFB if !HYPERV_VTL_MODE
> +	select IRQ_MSI_LIB if X86
>  	help
>  	  Select this option to run Linux as a Hyper-V client operating
>  	  system.
> -- 
> 2.39.5
> 

