Return-Path: <linux-hyperv+bounces-6571-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A967B2EFDB
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Aug 2025 09:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B036847D8
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Aug 2025 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59272DCBE6;
	Thu, 21 Aug 2025 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H24I/bOU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43547188906;
	Thu, 21 Aug 2025 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761651; cv=none; b=j8XReZX5xHogJdJOPEPa8I+U20UAutV1YOFZaz191jDiMf+QNCqR0ySN/XomgkHroEBshgf18FWKKmbry2Zu1TorNO897DhVa+eyFVGzuEta8TKiUI++po1X1lSj+jeAI6BpAGxnfD20MG6KIA1AfWxxQUcb9pENxgHU5+9OpG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761651; c=relaxed/simple;
	bh=FkBskIXxnAkE6u/U6FSqICJQNjrdPTu+Fo0xXBDlzoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJajpjPFyYm7qd6ig2CUI/uvdd9fHOB854ieahOXs43iKc1JvQapiusckupgq7RNRkIpMfWdyuTo4G1xyZteWc+SMIFw0xYqMerFfFKvjurctQJ8yMT8jmctA2o/yrB4/TBhXSIyIx9Dg0b+dHo5Joax5NMhYmqrNk12KePBXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H24I/bOU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E0ECC211829A; Thu, 21 Aug 2025 00:34:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0ECC211829A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755761643;
	bh=73TFog0aRzR0yJ41VdLysL6YezkxB5RmmPyqUTH84yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H24I/bOUCYuWPovnnBliSrO5EXtJFmDUQdGVcnSSk/ym0OVbf4iuYsbjcOy4EKopq
	 XsfI1FFdK9pNrfeGMZKAUlds2/5ZNZ0454RlzfEkFoTB0ZDVkqlmjj7aLX95zdDuvu
	 IjPmZ6Mnmj4l1KtAh73SHD6YUTLoCVs8hsDOTN90=
Date: Thu, 21 Aug 2025 00:34:03 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Nam Cao <namcao@linutronix.de>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Marc Zyngier <maz@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] x86/hyperv: Switch to
 msi_create_parent_irq_domain()
Message-ID: <20250821073403.GA29749@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <cover.1752868165.git.namcao@linutronix.de>
 <45df1cc0088057cbf60cb84d8e9f9ff09f12f670.1752868165.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45df1cc0088057cbf60cb84d8e9f9ff09f12f670.1752868165.git.namcao@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jul 18, 2025 at 09:57:50PM +0200, Nam Cao wrote:
> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().
> 
> While doing the conversion, I noticed that hv_irq_compose_msi_msg() is
> doing more than it is supposed to (composing message content). The
> interrupt allocation bits should be moved into hv_msi_domain_alloc().
> However, I have no hardware to test this change, therefore I leave a TODO
> note.

Hi Nam,

JFYI, I am working on a patch to optimize the hv_irq_compose_msi_msg()
callback to prevent potential busy looping due to 
PCI_CREATE_INTERRUPT_MESSAGE hypercall. I think I can handle this TODO
in that patch

Thanks,
Shradha
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  arch/x86/hyperv/irqdomain.c | 111 ++++++++++++++++++++++++------------
>  drivers/hv/Kconfig          |   1 +
>  2 files changed, 77 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 090f5ac9f492..c3ba12b1bc07 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -11,6 +11,7 @@
>  #include <linux/pci.h>
>  #include <linux/irq.h>
>  #include <linux/export.h>
> +#include <linux/irqchip/irq-msi-lib.h>
>  #include <asm/mshyperv.h>
>  
>  static int hv_map_interrupt(union hv_device_id device_id, bool level,
> @@ -289,59 +290,99 @@ static void hv_teardown_msi_irq(struct pci_dev *dev, struct irq_data *irqd)
>  	(void)hv_unmap_msi_interrupt(dev, &old_entry);
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
> index 57623ca7f350..9afffedce290 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -10,6 +10,7 @@ config HYPERV
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select OF_EARLY_FLATTREE if OF
>  	select SYSFB if EFI && !HYPERV_VTL_MODE
> +	select IRQ_MSI_LIB if X86
>  	help
>  	  Select this option to run Linux as a Hyper-V client operating
>  	  system.
> -- 
> 2.49.0
> 

