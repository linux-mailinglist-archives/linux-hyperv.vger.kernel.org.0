Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC925217E
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Aug 2020 22:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgHYUDd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Aug 2020 16:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYUDb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Aug 2020 16:03:31 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADB662072D;
        Tue, 25 Aug 2020 20:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598385811;
        bh=bLQ/6Ns9xbbW32dBksiiwUFLCmw1usZgfNu6wzOIRRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l4bpkPmXM7023mZgcud7LiuXiDySo6mIf1kjucmaMFMfdwWuxCgjMXMMeZWTQlTNZ
         S8ccFLX7/o+uLWvZssFvEMAlrztDO4R5uWWMK5/l+J5KEs2v6I2ftwQ6ue1mdzaRhM
         G1nZBjJwkbjF80aF+i2KZjX8PiAMGCDb4+gafrqQ=
Date:   Tue, 25 Aug 2020 15:03:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [patch RFC 13/38] PCI: MSI: Rework pci_msi_domain_calc_hwirq()
Message-ID: <20200825200329.GA1923406@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821002946.594509001@linutronix.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 21, 2020 at 02:24:37AM +0200, Thomas Gleixner wrote:
> Retrieve the PCI device from the msi descriptor instead of doing so at the
> call sites.

I'd like it *better* with "PCI/MSI: " in the subject (to match history
and other patches in this series) and "MSI" here in the commit log,
but nice cleanup and:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Minor comments below.

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-pci@vger.kernel.org
> ---
>  arch/x86/kernel/apic/msi.c |    2 +-
>  drivers/pci/msi.c          |   13 ++++++-------
>  include/linux/msi.h        |    3 +--
>  3 files changed, 8 insertions(+), 10 deletions(-)
> 
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(pci_msi_prepare);
>  
>  void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
>  {
> -	arg->msi_hwirq = pci_msi_domain_calc_hwirq(arg->msi_dev, desc);
> +	arg->msi_hwirq = pci_msi_domain_calc_hwirq(desc);

I guess it's safe to assume that "arg->msi_dev ==
msi_desc_to_pci_dev(desc)"?  I didn't try to verify that.

>  }
>  EXPORT_SYMBOL_GPL(pci_msi_set_desc);
>  
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1346,17 +1346,17 @@ void pci_msi_domain_write_msg(struct irq
>  
>  /**
>   * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
> - * @dev:	Pointer to the PCI device
>   * @desc:	Pointer to the MSI descriptor
>   *
>   * The ID number is only used within the irqdomain.
>   */
> -irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
> -					  struct msi_desc *desc)
> +irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>  {
> +	struct pci_dev *pdev = msi_desc_to_pci_dev(desc);

If you named this "struct pci_dev *dev" (not "pdev"), the diff would
be a little smaller and it would match other usage in the file.

>  	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
> -		pci_dev_id(dev) << 11 |
> -		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
> +		pci_dev_id(pdev) << 11 |
> +		(pci_domain_nr(pdev->bus) & 0xFFFFFFFF) << 27;
>  }
>  
>  static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
> @@ -1406,8 +1406,7 @@ static void pci_msi_domain_set_desc(msi_
>  				    struct msi_desc *desc)
>  {
>  	arg->desc = desc;
> -	arg->hwirq = pci_msi_domain_calc_hwirq(msi_desc_to_pci_dev(desc),
> -					       desc);
> +	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
>  }
>  #else
>  #define pci_msi_domain_set_desc		NULL
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -369,8 +369,7 @@ void pci_msi_domain_write_msg(struct irq
>  struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
>  					     struct msi_domain_info *info,
>  					     struct irq_domain *parent);
> -irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
> -					  struct msi_desc *desc);
> +irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc);
>  int pci_msi_domain_check_cap(struct irq_domain *domain,
>  			     struct msi_domain_info *info, struct device *dev);
>  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
> 
