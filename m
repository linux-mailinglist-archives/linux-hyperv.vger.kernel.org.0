Return-Path: <linux-hyperv+bounces-6270-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB80B07C84
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 20:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440E65863E0
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E028FA9A;
	Wed, 16 Jul 2025 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ns/uav6y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEB28F957;
	Wed, 16 Jul 2025 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752689416; cv=none; b=luR06dNIF0FT8HntJenuz80GNgy6MOExfA2yrXZSGqoCII70JzWinc+gey0Lq+RoO3R8l6RcZaOpe5KoUYbWcd0AFEg/Dq/fbPFPFCcymj1hAarmp/2i1VSX+0DvVU6WynbiZPYwy2VXhtUmbblzr79sGe90Dn5u17JO6nT+BIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752689416; c=relaxed/simple;
	bh=Ncj6+lrCocmTg10SkbqNYjPO9SQZWn8ZW4Ypaptrcjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CN3T18WX91D9/rIM5KWco2oF44F783KROhNZbaqIm/x7Yi6SzhB1yuHpnzGbQ7YcbqlSBIxZw+2xB9rUDwnqtx4BfqG0jZCK6t+BjwVd2awNesMGsIqdHGgx2QGI0CSWzFIKjV87aIjgkrbbnZnz83a6RGpWd5yZY4kM0NWxUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ns/uav6y; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752689414; x=1784225414;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ncj6+lrCocmTg10SkbqNYjPO9SQZWn8ZW4Ypaptrcjs=;
  b=Ns/uav6yP/gDYBa9MU5C88xbdOBmO4T3zJUWc9bvkqGPpck0eOmwrvdO
   drNYppO6UHWNCIkuN1OpY/a16OwPUbynACivl56S6HopigSj94kvLcRJd
   RIeMdXlZUvSDI39JOLEiu8qa2gfPGaqCk01qaFKxzP5ExSRWIGNbx36pL
   s+ponS7Z5NX3JeUaujsviM3YCSWCM7AR0ahQpY7DR/L+B5vceb9sa5BHH
   o4XTJKJokLZ+rw7KuOsUbmAc4crfh2bgKdZUkO0GXva7ba8UzlVZxXDbp
   P+lIGkvFqFtP1aQhbq97e4mCJYTw7hzqyQWQa9xsYaT6s6g9AEBMbFbte
   w==;
X-CSE-ConnectionGUID: IYxCCTycTi6HoBW2yft00A==
X-CSE-MsgGUID: A3iRrKPcTBSwnukVv2oj6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72401352"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="72401352"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 11:10:13 -0700
X-CSE-ConnectionGUID: lMHOxPCqTEGfF+eh6al9XQ==
X-CSE-MsgGUID: d0wGUeqURg2n+drWX2U07w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="163204134"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.132.131])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 11:10:10 -0700
Date: Wed, 16 Jul 2025 11:10:09 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy?=
 =?UTF-8?Q?=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Karthikeyan Mitran
 <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?UTF-8?Q?Roh=C3=A1r?=
 <pali@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan
 <jim2101024@gmail.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>, Michal Simek <michal.simek@amd.com>,
 Daire McNamara <daire.mcnamara@microchip.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 16/16] PCI: vmd: Switch to
 msi_create_parent_irq_domain()
Message-ID: <20250716111009.000022ff@linux.intel.com>
In-Reply-To: <de3f1d737831b251e9cd2cbf9e4c732a5bbba13a.1750858083.git.namcao@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
	<de3f1d737831b251e9cd2cbf9e4c732a5bbba13a.1750858083.git.namcao@linutronix.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 16:48:06 +0200
Nam Cao <namcao@linutronix.de> wrote:

> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
> Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
> ---
>  drivers/pci/controller/Kconfig |   1 +
>  drivers/pci/controller/vmd.c   | 160
> +++++++++++++++++---------------- 2 files changed, 82 insertions(+),
> 79 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig
> b/drivers/pci/controller/Kconfig index 8f56ffd029ba2..41748d083b933
> 100644 --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -156,6 +156,7 @@ config PCI_IXP4XX
>  config VMD
>  	depends on PCI_MSI && X86_64 && !UML
>  	tristate "Intel Volume Management Device Driver"
> +	select IRQ_MSI_LIB
>  	help
>  	  Adds support for the Intel Volume Management Device (VMD).
> VMD is a secondary PCI host bridge that allows PCI Express root ports,
> diff --git a/drivers/pci/controller/vmd.c
> b/drivers/pci/controller/vmd.c index d9b893bf4e456..38693a9487d9b
> 100644 --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -7,6 +7,7 @@
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/irqchip/irq-msi-lib.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> @@ -174,9 +175,6 @@ static void vmd_compose_msi_msg(struct irq_data
> *data, struct msi_msg *msg) msg->arch_addr_lo.destid_0_7 =
> index_from_irqs(vmd, irq); }
>  
> -/*
> - * We rely on MSI_FLAG_USE_DEF_CHIP_OPS to set the IRQ mask/unmask
> ops.
> - */
>  static void vmd_irq_enable(struct irq_data *data)
>  {
>  	struct vmd_irq *vmdirq = data->chip_data;
> @@ -186,7 +184,11 @@ static void vmd_irq_enable(struct irq_data *data)
>  		list_add_tail_rcu(&vmdirq->node,
> &vmdirq->irq->irq_list); vmdirq->enabled = true;
>  	}
> +}
>  
> +static void vmd_pci_msi_enable(struct irq_data *data)
> +{
> +	vmd_irq_enable(data->parent_data);
>  	data->chip->irq_unmask(data);
>  }
>  
> @@ -194,8 +196,6 @@ static void vmd_irq_disable(struct irq_data *data)
>  {
>  	struct vmd_irq *vmdirq = data->chip_data;
>  
> -	data->chip->irq_mask(data);
> -
>  	scoped_guard(raw_spinlock_irqsave, &list_lock) {
>  		if (vmdirq->enabled) {
>  			list_del_rcu(&vmdirq->node);
> @@ -204,19 +204,17 @@ static void vmd_irq_disable(struct irq_data
> *data) }
>  }
>  
> +static void vmd_pci_msi_disable(struct irq_data *data)
> +{
> +	data->chip->irq_mask(data);
> +	vmd_irq_disable(data->parent_data);
> +}
> +
>  static struct irq_chip vmd_msi_controller = {
>  	.name			= "VMD-MSI",
> -	.irq_enable		= vmd_irq_enable,
> -	.irq_disable		= vmd_irq_disable,
>  	.irq_compose_msi_msg	= vmd_compose_msi_msg,
>  };
>  
> -static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
> -				     msi_alloc_info_t *arg)
> -{
> -	return 0;
> -}
> -
>  /*
>   * XXX: We can be even smarter selecting the best IRQ once we solve
> the
>   * affinity problem.
> @@ -250,100 +248,110 @@ static struct vmd_irq_list
> *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d return
> &vmd->irqs[best]; }
>  
> -static int vmd_msi_init(struct irq_domain *domain, struct
> msi_domain_info *info,
> -			unsigned int virq, irq_hw_number_t hwirq,
> -			msi_alloc_info_t *arg)
> +static void vmd_msi_free(struct irq_domain *domain, unsigned int
> virq, unsigned int nr_irqs); +
> +static int vmd_msi_alloc(struct irq_domain *domain, unsigned int
> virq, unsigned int nr_irqs,
> +			 void *arg)

Is this wrapped in 80 columns? I can see few lines are more than 80.
Disregard this if it is wrapped and it can be my claws mail client
issue.

>  {
> -	struct msi_desc *desc = arg->desc;
> -	struct vmd_dev *vmd =
> vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
> -	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq),
> GFP_KERNEL);
> +	struct msi_desc *desc = ((msi_alloc_info_t *)arg)->desc;
> +	struct vmd_dev *vmd = domain->host_data;
> +	struct vmd_irq *vmdirq;
>  
> -	if (!vmdirq)
> -		return -ENOMEM;
> +	for (int i = 0; i < nr_irqs; ++i) {
> +		vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
> +		if (!vmdirq) {
> +			vmd_msi_free(domain, virq, i);
> +			return -ENOMEM;
> +		}
>  
> -	INIT_LIST_HEAD(&vmdirq->node);
> -	vmdirq->irq = vmd_next_irq(vmd, desc);
> -	vmdirq->virq = virq;
> +		INIT_LIST_HEAD(&vmdirq->node);
> +		vmdirq->irq = vmd_next_irq(vmd, desc);
> +		vmdirq->virq = virq + i;
> +
> +		irq_domain_set_info(domain, virq + i,
> vmdirq->irq->virq, &vmd_msi_controller,
> +				    vmdirq, handle_untracked_irq,
> vmd, NULL);
> +	}
>  
> -	irq_domain_set_info(domain, virq, vmdirq->irq->virq,
> info->chip, vmdirq,
> -			    handle_untracked_irq, vmd, NULL);
>  	return 0;
>  }
>  
> -static void vmd_msi_free(struct irq_domain *domain,
> -			struct msi_domain_info *info, unsigned int
> virq) +static void vmd_msi_free(struct irq_domain *domain, unsigned
> int virq, unsigned int nr_irqs) {
>  	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
>  
> -	synchronize_srcu(&vmdirq->irq->srcu);
> +	for (int i = 0; i < nr_irqs; ++i) {
> +		synchronize_srcu(&vmdirq->irq->srcu);
>  
> -	/* XXX: Potential optimization to rebalance */
> -	scoped_guard(raw_spinlock_irq, &list_lock)
> -		vmdirq->irq->count--;
> +		/* XXX: Potential optimization to rebalance */
> +		scoped_guard(raw_spinlock_irq, &list_lock)
> +			vmdirq->irq->count--;
>  
> -	kfree(vmdirq);
> +		kfree(vmdirq);
> +	}
>  }
>  
> -static int vmd_msi_prepare(struct irq_domain *domain, struct device
> *dev,
> -			   int nvec, msi_alloc_info_t *arg)
> +static const struct irq_domain_ops vmd_msi_domain_ops = {
> +	.alloc		= vmd_msi_alloc,
> +	.free		= vmd_msi_free,
> +};
> +
> +static bool vmd_init_dev_msi_info(struct device *dev, struct
> irq_domain *domain,
> +				  struct irq_domain *real_parent,
> struct msi_domain_info *info) {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
> +	if (WARN_ON_ONCE(info->bus_token !=
> DOMAIN_BUS_PCI_DEVICE_MSIX))
> +		return false;
>  
> -	if (nvec > vmd->msix_count)
> -		return vmd->msix_count;
> +	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent,
> info))
> +		return false;
>  
> -	memset(arg, 0, sizeof(*arg));
> -	return 0;
> +	info->chip->irq_enable		= vmd_pci_msi_enable;
> +	info->chip->irq_disable		= vmd_pci_msi_disable;
> +	return true;
>  }
>  
> -static void vmd_set_desc(msi_alloc_info_t *arg, struct msi_desc
> *desc) -{
> -	arg->desc = desc;
> -}
> +#define VMD_MSI_FLAGS_SUPPORTED
> (MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX) +#define
> VMD_MSI_FLAGS_REQUIRED		(MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_NO_AFFINITY) -static struct msi_domain_ops
> vmd_msi_domain_ops = {
> -	.get_hwirq	= vmd_get_hwirq,
> -	.msi_init	= vmd_msi_init,
> -	.msi_free	= vmd_msi_free,
> -	.msi_prepare	= vmd_msi_prepare,
> -	.set_desc	= vmd_set_desc,
> +static const struct msi_parent_ops vmd_msi_parent_ops = {
> +	.supported_flags	= VMD_MSI_FLAGS_SUPPORTED,
> +	.required_flags		= VMD_MSI_FLAGS_REQUIRED,
> +	.bus_select_token	= DOMAIN_BUS_VMD_MSI,
> +	.bus_select_mask	= MATCH_PCI_MSI,
> +	.prefix			= "VMD-",
> +	.init_dev_msi_info	= vmd_init_dev_msi_info,
>  };
>  
> -static struct msi_domain_info vmd_msi_domain_info = {
> -	.flags		= MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_USE_DEF_CHIP_OPS |
> -			  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX,
> -	.ops		= &vmd_msi_domain_ops,
> -	.chip		= &vmd_msi_controller,
> -};
> -
> -static void vmd_set_msi_remapping(struct vmd_dev *vmd, bool enable)
> -{
> -	u16 reg;
> -
> -	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
> -	reg = enable ? (reg & ~VMCONFIG_MSI_REMAP) :
> -		       (reg | VMCONFIG_MSI_REMAP);
> -	pci_write_config_word(vmd->dev, PCI_REG_VMCONFIG, reg);
> -}
> -
>  static int vmd_create_irq_domain(struct vmd_dev *vmd)
>  {
> -	struct fwnode_handle *fn;
> +	struct irq_domain_info info = {
> +		.size		= vmd->msix_count,
> +		.ops		= &vmd_msi_domain_ops,
> +		.host_data	= vmd,
> +	};
>  
> -	fn = irq_domain_alloc_named_id_fwnode("VMD-MSI",
> vmd->sysdata.domain);
> -	if (!fn)
> +	info.fwnode = irq_domain_alloc_named_id_fwnode("VMD-MSI",
> vmd->sysdata.domain);
> +	if (!info.fwnode)
>  		return -ENODEV;
>  
> -	vmd->irq_domain = pci_msi_create_irq_domain(fn,
> &vmd_msi_domain_info, NULL);
> +	vmd->irq_domain = msi_create_parent_irq_domain(&info,
> &vmd_msi_parent_ops); if (!vmd->irq_domain) {
> -		irq_domain_free_fwnode(fn);
> +		irq_domain_free_fwnode(info.fwnode);
>  		return -ENODEV;
>  	}
>  
>  	return 0;
>  }
>  
> +static void vmd_set_msi_remapping(struct vmd_dev *vmd, bool enable)
> +{
> +	u16 reg;
> +
> +	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
> +	reg = enable ? (reg & ~VMCONFIG_MSI_REMAP) :
> +		       (reg | VMCONFIG_MSI_REMAP);
> +	pci_write_config_word(vmd->dev, PCI_REG_VMCONFIG, reg);
> +}
> +
>  static void vmd_remove_irq_domain(struct vmd_dev *vmd)
>  {
>  	/*
> @@ -874,12 +882,6 @@ static int vmd_enable_domain(struct vmd_dev
> *vmd, unsigned long features) ret = vmd_create_irq_domain(vmd);
>  		if (ret)
>  			return ret;
> -
> -		/*
> -		 * Override the IRQ domain bus token so the domain
> can be
> -		 * distinguished from a regular PCI/MSI domain.
> -		 */
> -		irq_domain_update_bus_token(vmd->irq_domain,
> DOMAIN_BUS_VMD_MSI); } else {
>  		vmd_set_msi_remapping(vmd, false);
>  	}


