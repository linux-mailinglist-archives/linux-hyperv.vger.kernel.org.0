Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14F82521BC
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Aug 2020 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHYUQi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Aug 2020 16:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYUQh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Aug 2020 16:16:37 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 067E02074D;
        Tue, 25 Aug 2020 20:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598386596;
        bh=D7Rw2PMoe8IDZOMsNEwXYiBG5PbxcS/orkj8Yivovec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ov+X/vU+a12BRBzFUckIxiGJXa6k21v6DegMqYXhC5Zng0n4wC039Oo6Bh3gFLV6x
         5vD3ZwCEzBTgAbeasiFHcdum1DtDxjLMC1uSLEqHlzqHo8MC0nxm4f0VoTgli+T0Qr
         kEY+uzx7LZz3MSVAGwF8UOQyU/JHe/YeVdDsMVuw=
Date:   Tue, 25 Aug 2020 15:16:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
        Russ Anderson <rja@hpe.com>,
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
Subject: Re: [patch RFC 21/38] PCI: MSI: Provide
 pci_dev_has_special_msi_domain() helper
Message-ID: <20200825201634.GA1924972@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821002947.373714034@linutronix.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 21, 2020 at 02:24:45AM +0200, Thomas Gleixner wrote:
> Provide a helper function to check whether a PCI device is handled by a
> non-standard PCI/MSI domain. This will be used to exclude such devices
> which hang of a special bus, e.g. VMD, to be excluded from the irq domain
> override in irq remapping.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

s|PCI: MSI:|PCI/MSI:| in the subject if feasible.

> ---
>  drivers/pci/msi.c   |   22 ++++++++++++++++++++++
>  include/linux/msi.h |    1 +
>  2 files changed, 23 insertions(+)
> 
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1553,4 +1553,26 @@ struct irq_domain *pci_msi_get_device_do
>  					     DOMAIN_BUS_PCI_MSI);
>  	return dom;
>  }
> +
> +/**
> + * pci_dev_has_special_msi_domain - Check whether the device is handled by
> + *				    a non-standard PCI-MSI domain
> + * @pdev:	The PCI device to check.
> + *
> + * Returns: True if the device irqdomain or the bus irqdomain is
> + * non-standard PCI/MSI.
> + */
> +bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
> +{
> +	struct irq_domain *dom = dev_get_msi_domain(&pdev->dev);
> +
> +	if (!dom)
> +		dom = dev_get_msi_domain(&pdev->bus->dev);
> +
> +	if (!dom)
> +		return true;
> +
> +	return dom->bus_token != DOMAIN_BUS_PCI_MSI;
> +}
> +
>  #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -374,6 +374,7 @@ int pci_msi_domain_check_cap(struct irq_
>  			     struct msi_domain_info *info, struct device *dev);
>  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
>  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
> +bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
>  #else
>  static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
>  {
> 
