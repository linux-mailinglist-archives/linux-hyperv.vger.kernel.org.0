Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FBD46C59A
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 22:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhLGVDc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 16:03:32 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36562 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbhLGVDS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 16:03:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9D825CE1E01;
        Tue,  7 Dec 2021 20:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B586C341C3;
        Tue,  7 Dec 2021 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638910783;
        bh=6xre4ERQ0zpMI+yMYHqya0Bv8a/uSKKR8JsDZHNhU4A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aeRzt8BFGmz8vimH6MrP0wP9SdPtvkbfZq/UmC8CKYYNjJasWIz5f+IDpiLt6A0aT
         oWaWypdpOk3kLHyjzDsQeYqrHTpd3iZOnTYeKEAmkMHjU7UnfvkxaMuJDeC/Wc2Hzi
         d/FFX9EV+Kcu4/bql3Cu7G+iZUNrbr932+dfUmbNQpfi4jfYq2+R49cO4nrodAA1Iw
         jVDW4T13NZ4YjdWrzzbDYPYSCQhY6XlsHmoikp3g+pCtfXWnC49HkD/43doiyns1eo
         u+nnrBTWk3+O0gdwhnpWHdlUi5r4O8Da5zgFdzOYEWM9P+fQEy+euPyaO0pLLMA4LT
         ZCokWDHvR/fEg==
Date:   Tue, 7 Dec 2021 14:59:42 -0600
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
Subject: Re: [patch V2 17/23] PCI/MSI: Split out !IRQDOMAIN code
Message-ID: <20211207205942.GA77110@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210224.763574089@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 06, 2021 at 11:27:51PM +0100, Thomas Gleixner wrote:
> Split out the non irqdomain code into its own file.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V2: Add proper includes and fix variable name - Cedric
> ---
>  drivers/pci/msi/Makefile |    5 ++--
>  drivers/pci/msi/legacy.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/msi/msi.c    |   46 -----------------------------------------
>  3 files changed, 55 insertions(+), 48 deletions(-)
> 
> --- a/drivers/pci/msi/Makefile
> +++ b/drivers/pci/msi/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # Makefile for the PCI/MSI
> -obj-$(CONFIG_PCI)		+= pcidev_msi.o
> -obj-$(CONFIG_PCI_MSI)		+= msi.o
> +obj-$(CONFIG_PCI)			+= pcidev_msi.o
> +obj-$(CONFIG_PCI_MSI)			+= msi.o
> +obj-$(CONFIG_PCI_MSI_ARCH_FALLBACKS)	+= legacy.o
> --- /dev/null
> +++ b/drivers/pci/msi/legacy.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Message Signaled Interrupt (MSI).
> + *
> + * Legacy architecture specific setup and teardown mechanism.
> + */
> +#include <linux/msi.h>
> +#include <linux/pci.h>
> +
> +/* Arch hooks */
> +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> +{
> +	return -EINVAL;
> +}
> +
> +void __weak arch_teardown_msi_irq(unsigned int irq)
> +{
> +}
> +
> +int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +{
> +	struct msi_desc *desc;
> +	int ret;
> +
> +	/*
> +	 * If an architecture wants to support multiple MSI, it needs to
> +	 * override arch_setup_msi_irqs()
> +	 */
> +	if (type == PCI_CAP_ID_MSI && nvec > 1)
> +		return 1;
> +
> +	for_each_pci_msi_entry(desc, dev) {
> +		ret = arch_setup_msi_irq(dev, desc);
> +		if (ret)
> +			return ret < 0 ? ret : -ENOSPC;
> +	}
> +
> +	return 0;
> +}
> +
> +void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	struct msi_desc *desc;
> +	int i;
> +
> +	for_each_pci_msi_entry(desc, dev) {
> +		if (desc->irq) {
> +			for (i = 0; i < desc->nvec_used; i++)
> +				arch_teardown_msi_irq(desc->irq + i);
> +		}
> +	}
> +}
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -50,52 +50,6 @@ static void pci_msi_teardown_msi_irqs(st
>  #define pci_msi_teardown_msi_irqs	arch_teardown_msi_irqs
>  #endif
>  
> -#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
> -/* Arch hooks */
> -int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> -{
> -	return -EINVAL;
> -}
> -
> -void __weak arch_teardown_msi_irq(unsigned int irq)
> -{
> -}
> -
> -int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> -{
> -	struct msi_desc *entry;
> -	int ret;
> -
> -	/*
> -	 * If an architecture wants to support multiple MSI, it needs to
> -	 * override arch_setup_msi_irqs()
> -	 */
> -	if (type == PCI_CAP_ID_MSI && nvec > 1)
> -		return 1;
> -
> -	for_each_pci_msi_entry(entry, dev) {
> -		ret = arch_setup_msi_irq(dev, entry);
> -		if (ret < 0)
> -			return ret;
> -		if (ret > 0)
> -			return -ENOSPC;
> -	}
> -
> -	return 0;
> -}
> -
> -void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
> -{
> -	int i;
> -	struct msi_desc *entry;
> -
> -	for_each_pci_msi_entry(entry, dev)
> -		if (entry->irq)
> -			for (i = 0; i < entry->nvec_used; i++)
> -				arch_teardown_msi_irq(entry->irq + i);
> -}
> -#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
> -
>  /*
>   * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
>   * mask all MSI interrupts by clearing the MSI enable bit does not work
> 
