Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901BE46C4F8
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 21:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbhLGU6S (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 15:58:18 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34068 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241459AbhLGU6S (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 15:58:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3B966CE1E6F;
        Tue,  7 Dec 2021 20:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E222C341C3;
        Tue,  7 Dec 2021 20:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638910483;
        bh=2TCFm6oMcOo2j9kU57EKGsnY8fkR6JvmY5FAYrIs66g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nsS3jKJ7qQGHDYJB47kov7AVBhzyG091DRuFfOsLF+34ALijihn9KZtlp+GJ6IKE8
         kwldgAGONyoShIXShWCqK6l38EuYcxpvxsfxzUOfye0qv3FNym4mEgnKFN3S4deZJn
         MK94vwclzEowmaVdB2cGhf7Z0a7/o3/oMmVUhVyJY2de/L6mR980HgZkZTFIElzJ/+
         epdz+yWDLvAPCET9jF0AcFlWO/tiWh+A6jWW8FLHS0WZbyvHO0pmCIW6QBNlbIsCJM
         H+HIHHhPv17Z3oQSzspeU71bWUAG5BFut+e0szyhVsCnMRESKTLgg/mxRT13eAuaiM
         cbQlCTOqnZvyg==
Date:   Tue, 7 Dec 2021 14:54:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [patch V2 06/23] PCI/MSI: Make pci_msi_domain_write_msg() static
Message-ID: <20211207205441.GA76497@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210224.157070464@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 06, 2021 at 11:27:33PM +0100, Thomas Gleixner wrote:
> There is no point to have this function public as it is set by the PCI core
> anyway when a PCI/MSI irqdomain is created.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# PCI

> ---
>  drivers/irqchip/irq-gic-v2m.c            |    1 -
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c |    1 -
>  drivers/irqchip/irq-gic-v3-mbi.c         |    1 -
>  drivers/pci/msi.c                        |    2 +-
>  include/linux/msi.h                      |    1 -
>  5 files changed, 1 insertion(+), 5 deletions(-)
> 
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -88,7 +88,6 @@ static struct irq_chip gicv2m_msi_irq_ch
>  	.irq_mask		= gicv2m_mask_msi_irq,
>  	.irq_unmask		= gicv2m_unmask_msi_irq,
>  	.irq_eoi		= irq_chip_eoi_parent,
> -	.irq_write_msi_msg	= pci_msi_domain_write_msg,
>  };
>  
>  static struct msi_domain_info gicv2m_msi_domain_info = {
> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> @@ -28,7 +28,6 @@ static struct irq_chip its_msi_irq_chip
>  	.irq_unmask		= its_unmask_msi_irq,
>  	.irq_mask		= its_mask_msi_irq,
>  	.irq_eoi		= irq_chip_eoi_parent,
> -	.irq_write_msi_msg	= pci_msi_domain_write_msg,
>  };
>  
>  static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
> --- a/drivers/irqchip/irq-gic-v3-mbi.c
> +++ b/drivers/irqchip/irq-gic-v3-mbi.c
> @@ -171,7 +171,6 @@ static struct irq_chip mbi_msi_irq_chip
>  	.irq_unmask		= mbi_unmask_msi_irq,
>  	.irq_eoi		= irq_chip_eoi_parent,
>  	.irq_compose_msi_msg	= mbi_compose_msi_msg,
> -	.irq_write_msi_msg	= pci_msi_domain_write_msg,
>  };
>  
>  static struct msi_domain_info mbi_msi_domain_info = {
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1281,7 +1281,7 @@ EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdat
>   * @irq_data:	Pointer to interrupt data of the MSI interrupt
>   * @msg:	Pointer to the message
>   */
> -void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
> +static void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
>  {
>  	struct msi_desc *desc = irq_data_get_msi_desc(irq_data);
>  
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -455,7 +455,6 @@ void *platform_msi_get_host_data(struct
>  #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
>  
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> -void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg);
>  struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
>  					     struct msi_domain_info *info,
>  					     struct irq_domain *parent);
> 
