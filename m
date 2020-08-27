Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7E254081
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Aug 2020 10:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgH0IRe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Aug 2020 04:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgH0IRQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Aug 2020 04:17:16 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86A5D22CAF;
        Thu, 27 Aug 2020 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598516235;
        bh=f0/TTg7ydrldBCfzfcvkuWCMzTaAgtKPEMau/tanrpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TmsP/B8ZI27FXcca++ez4/wY7bzEmEEis+Dyck/1ERZwMR0OuB91mKNhtYQsF0Xbx
         /e0s5LTBumjF95gOBL1dlpZN5H4zC/AJG1WooHCqj6zZkqNGswYFi4R4DmuLUe3yCV
         JdcXgX7JS8A29KaJ8sw9cYHnN3K3LQoA4KkOn7HI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kBD5t-0074EG-T5; Thu, 27 Aug 2020 09:17:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Aug 2020 09:17:13 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
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
Subject: Re: [patch V2 43/46] genirq/msi: Provide and use
 msi_domain_set_default_info_flags()
In-Reply-To: <20200826112334.889315931@linutronix.de>
References: <20200826111628.794979401@linutronix.de>
 <20200826112334.889315931@linutronix.de>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <b80607e87e43730133dd9f619c6464dc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, haiyangz@microsoft.com, jonathan.derrick@intel.com, baolu.lu@linux.intel.com, wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com, steve.wahl@hpe.com, sivanich@hpe.com, rja@hpe.com, linux-pci@vger.kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com, konrad.wilk@oracle.com, xen-devel@lists.xenproject.org, jgross@suse.com, boris.ostrovsky@oracle.com, sstabellini@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, megha.dey@intel.com, jgg@mellanox.com, dave.jiang@intel.com, alex.williamson@redhat.com, jacob.jun.pan@intel.com, baolu.lu@intel.com, kevin.tian@intel.com, dan.j.williams@intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2020-08-26 12:17, Thomas Gleixner wrote:
> MSI interrupts have some common flags which should be set not only for
> PCI/MSI interrupts.
> 
> Move the PCI/MSI flag setting into a common function so it can be 
> reused.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  drivers/pci/msi.c   |    7 +------
>  include/linux/msi.h |    1 +
>  kernel/irq/msi.c    |   24 ++++++++++++++++++++++++
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1469,12 +1469,7 @@ struct irq_domain *pci_msi_create_irq_do
>  	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>  		pci_msi_domain_update_chip_ops(info);
> 
> -	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
> -	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
> -		info->flags |= MSI_FLAG_MUST_REACTIVATE;
> -
> -	/* PCI-MSI is oneshot-safe */
> -	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> +	msi_domain_set_default_info_flags(info);
> 
>  	domain = msi_create_irq_domain(fwnode, info, parent);
>  	if (!domain)
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -410,6 +410,7 @@ int platform_msi_domain_alloc(struct irq
>  void platform_msi_domain_free(struct irq_domain *domain, unsigned int 
> virq,
>  			      unsigned int nvec);
>  void *platform_msi_get_host_data(struct irq_domain *domain);
> +void msi_domain_set_default_info_flags(struct msi_domain_info *info);
>  #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
> 
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -70,6 +70,30 @@ void get_cached_msi_msg(unsigned int irq
>  EXPORT_SYMBOL_GPL(get_cached_msi_msg);
> 
>  #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +void msi_domain_set_default_info_flags(struct msi_domain_info *info)
> +{
> +	/* Required so that a device latches a valid MSI message on startup 
> */
> +	info->flags |= MSI_FLAG_ACTIVATE_EARLY;

As far as I remember the story behind this flag (it's been a while),
it was working around a PCI-specific issue, hence being located in
the PCI code.

Now, the "program the MSI before enabling it" concept makes sense no 
matter
what bus this is on, and I wonder why we are even keeping this flag 
around.
Can't we just drop it together with the check in 
msi_domain_alloc_irqs()?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
