Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848FC24F207
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Aug 2020 06:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHXE7J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Aug 2020 00:59:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:39712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgHXE7J (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Aug 2020 00:59:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B36BAD2E;
        Mon, 24 Aug 2020 04:59:36 +0000 (UTC)
Subject: Re: [patch RFC 24/38] x86/xen: Consolidate XEN-MSI init
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
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
        xen-devel@lists.xenproject.org,
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
 <20200821002947.667887608@linutronix.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <5caec213-8f56-9f12-34db-a29de8326f95@suse.com>
Date:   Mon, 24 Aug 2020 06:59:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821002947.667887608@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 21.08.20 02:24, Thomas Gleixner wrote:
> X86 cannot store the irq domain pointer in struct device without breaking
> XEN because the irq domain pointer takes precedence over arch_*_msi_irqs()
> fallbacks.
> 
> To achieve this XEN MSI interrupt management needs to be wrapped into an
> irq domain.
> 
> Move the x86_msi ops setup into a single function to prepare for this.
> 
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> ---
>   arch/x86/pci/xen.c |   51 ++++++++++++++++++++++++++++++++-------------------
>   1 file changed, 32 insertions(+), 19 deletions(-)
> 
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -371,7 +371,10 @@ static void xen_initdom_restore_msi_irqs
>   		WARN(ret && ret != -ENOSYS, "restore_msi -> %d\n", ret);
>   	}
>   }
> -#endif
> +#else /* CONFIG_XEN_DOM0 */
> +#define xen_initdom_setup_msi_irqs	NULL
> +#define xen_initdom_restore_msi_irqs	NULL
> +#endif /* !CONFIG_XEN_DOM0 */
>   
>   static void xen_teardown_msi_irqs(struct pci_dev *dev)
>   {
> @@ -403,7 +406,31 @@ static void xen_teardown_msi_irq(unsigne
>   	WARN_ON_ONCE(1);
>   }
>   
> -#endif
> +static __init void xen_setup_pci_msi(void)
> +{
> +	if (xen_initial_domain()) {
> +		x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
> +		x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
> +		x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
> +		pci_msi_ignore_mask = 1;

This is wrong, as a PVH initial domain shouldn't do the pv settings.

The "if (xen_initial_domain())" should be inside the pv case, like:

if (xen_pv_domain()) {
	if (xen_initial_domain()) {
		...
	} else {
		...
	}
} else if (xen_hvm_domain()) {
	...

Juergen
