Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086B124F278
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Aug 2020 08:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgHXGVI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Aug 2020 02:21:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgHXGVI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Aug 2020 02:21:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1123AC3F;
        Mon, 24 Aug 2020 06:21:36 +0000 (UTC)
Subject: Re: [patch RFC 26/38] x86/xen: Wrap XEN MSI management into irqdomain
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>,
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
References: <20200821002424.119492231@linutronix.de>
 <20200821002947.868727656@linutronix.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8860c7bc-67ab-ce64-0340-1458d2483a39@suse.com>
Date:   Mon, 24 Aug 2020 08:21:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821002947.868727656@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 21.08.20 02:24, Thomas Gleixner wrote:
> To allow utilizing the irq domain pointer in struct device it is necessary
> to make XEN/MSI irq domain compatible.
> 
> While the right solution would be to truly convert XEN to irq domains, this
> is an exercise which is not possible for mere mortals with limited XENology.
> 
> Provide a plain irqdomain wrapper around XEN. While this is blatant
> violation of the irqdomain design, it's the only solution for a XEN igorant
> person to make progress on the issue which triggered this change.
> 
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> Cc:linux-pci@vger.kernel.org
> Cc:xen-devel@lists.xenproject.org

Acked-by: Juergen Gross <jgross@suse.com>

Looking into https://www.kernel.org/doc/Documentation/IRQ-domain.txt (is
this still valid?) I believe Xen should be able to use the "No Map"
approach, as Xen only ever uses software IRQs (at least those are the
only ones visible to any driver). The (virtualized) hardware interrupts
are Xen events after all.

So maybe morphing Xen into supporting irqdomains in a sane way isn't
that complicated. Maybe I'm missing the main complexities, though.


Juergen

> ---
> Note: This is completely untested, but it compiles so it must be perfect.
> ---
>   arch/x86/pci/xen.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -406,6 +406,63 @@ static void xen_teardown_msi_irq(unsigne
>   	WARN_ON_ONCE(1);
>   }
>   
> +static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
> +				     struct device *dev,  int nvec)
> +{
> +	int type;
> +
> +	if (WARN_ON_ONCE(!dev_is_pci(dev)))
> +		return -EINVAL;
> +
> +	if (first_msi_entry(dev)->msi_attrib.is_msix)
> +		type = PCI_CAP_ID_MSIX;
> +	else
> +		type = PCI_CAP_ID_MSI;
> +
> +	return x86_msi.setup_msi_irqs(to_pci_dev(dev), nvec, type);
> +}
> +
> +static void xen_msi_domain_free_irqs(struct irq_domain *domain,
> +				     struct device *dev)
> +{
> +	if (WARN_ON_ONCE(!dev_is_pci(dev)))
> +		return;
> +
> +	x86_msi.teardown_msi_irqs(to_pci_dev(dev));
> +}
> +
> +static struct msi_domain_ops xen_pci_msi_domain_ops = {
> +	.domain_alloc_irqs	= xen_msi_domain_alloc_irqs,
> +	.domain_free_irqs	= xen_msi_domain_free_irqs,
> +};
> +
> +static struct msi_domain_info xen_pci_msi_domain_info = {
> +	.ops			= &xen_pci_msi_domain_ops,
> +};
> +
> +/*
> + * This irq domain is a blatant violation of the irq domain design, but
> + * distangling XEN into real irq domains is not a job for mere mortals with
> + * limited XENology. But it's the least dangerous way for a mere mortal to
> + * get rid of the arch_*_msi_irqs() hackery in order to store the irq
> + * domain pointer in struct device. This irq domain wrappery allows to do
> + * that without breaking XEN terminally.
> + */
> +static __init struct irq_domain *xen_create_pci_msi_domain(void)
> +{
> +	struct irq_domain *d = NULL;
> +	struct fwnode_handle *fn;
> +
> +	fn = irq_domain_alloc_named_fwnode("XEN-MSI");
> +	if (fn)
> +		d = msi_create_irq_domain(fn, &xen_pci_msi_domain_info, NULL);
> +
> +	/* FIXME: No idea how to survive if this fails */
> +	BUG_ON(!d);
> +
> +	return d;
> +}
> +
>   static __init void xen_setup_pci_msi(void)
>   {
>   	if (xen_initial_domain()) {
> @@ -426,6 +483,12 @@ static __init void xen_setup_pci_msi(voi
>   	}
>   
>   	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
> +
> +	/*
> +	 * Override the PCI/MSI irq domain init function. No point
> +	 * in allocating the native domain and never use it.
> +	 */
> +	x86_init.irqs.create_pci_msi_domain = xen_create_pci_msi_domain;
>   }
>   
>   #else /* CONFIG_PCI_MSI */
> 

