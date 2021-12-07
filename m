Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7A846C5CE
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 22:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhLGVFQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 16:05:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52138 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhLGVEq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 16:04:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A39EB81E59;
        Tue,  7 Dec 2021 21:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3297C341D8;
        Tue,  7 Dec 2021 21:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638910872;
        bh=ybqLZ92i+grI5yfbGrTDeuksmJCOFi+gglGxwe9SamU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TMUWYC/mv0B6gIw9DnRHd2zTabDMDtD755n0HABL/tcoqSE7ZcCnd0dDbsDaoGmvK
         qSODOct9cMbGDUGaQMGz23hZcH9TolzNE91WbMR1Is6JY9P7bOVw1YsTR4FzKBLaf9
         Le+C7vjuOPwgxJcdSYAXoABWYbIQoh0hnYJqcmKa/wpN/Q1nRm8km9tdJkdCx2jmEX
         fsf36dBLTPbeG7aB0lTQj2KpKmjk75YkmrWt1HFRo19aRculiS/sfLvaOedfplt04D
         DN4WnjTjinZPEIZIHd2BJZNhCHE1Yq/9m5G9O6M/Xzerap0qhtoeEABEaeo9Bwqnki
         GYfTLw7geSrJg==
Date:   Tue, 7 Dec 2021 15:01:10 -0600
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
Subject: Re: [patch V2 19/23] PCI/MSI: Sanitize MSIX table map handling
Message-ID: <20211207210110.GA77246@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210224.871651518@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 06, 2021 at 11:27:54PM +0100, Thomas Gleixner wrote:
> Unmapping the MSIX base mapping in the loops which allocate/free MSI
> desciptors is daft and in the way of allowing runtime expansion of MSI-X
> descriptors.

s/MSIX/MSI-X/ (subject and first use in commit log)
s/desciptors/descriptors/

> Store the mapping in struct pci_dev and free it after freeing the MSI-X
> descriptors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/msi.c |   18 ++++++++----------
>  include/linux/pci.h   |    1 +
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -241,14 +241,14 @@ static void free_msi_irqs(struct pci_dev
>  	pci_msi_teardown_msi_irqs(dev);
>  
>  	list_for_each_entry_safe(entry, tmp, msi_list, list) {
> -		if (entry->pci.msi_attrib.is_msix) {
> -			if (list_is_last(&entry->list, msi_list))
> -				iounmap(entry->pci.mask_base);
> -		}
> -
>  		list_del(&entry->list);
>  		free_msi_entry(entry);
>  	}
> +
> +	if (dev->msix_base) {
> +		iounmap(dev->msix_base);
> +		dev->msix_base = NULL;
> +	}
>  }
>  
>  static void pci_intx_for_msi(struct pci_dev *dev, int enable)
> @@ -501,10 +501,6 @@ static int msix_setup_entries(struct pci
>  	for (i = 0, curmsk = masks; i < nvec; i++) {
>  		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
>  		if (!entry) {
> -			if (!i)
> -				iounmap(base);
> -			else
> -				free_msi_irqs(dev);
>  			/* No enough memory. Don't try again */
>  			ret = -ENOMEM;
>  			goto out;
> @@ -602,12 +598,14 @@ static int msix_capability_init(struct p
>  		goto out_disable;
>  	}
>  
> +	dev->msix_base = base;
> +
>  	/* Ensure that all table entries are masked. */
>  	msix_mask_all(base, tsize);
>  
>  	ret = msix_setup_entries(dev, base, entries, nvec, affd);
>  	if (ret)
> -		goto out_disable;
> +		goto out_free;
>  
>  	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
>  	if (ret)
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -473,6 +473,7 @@ struct pci_dev {
>  	u8		ptm_granularity;
>  #endif
>  #ifdef CONFIG_PCI_MSI
> +	void __iomem	*msix_base;
>  	const struct attribute_group **msi_irq_groups;
>  #endif
>  	struct pci_vpd	vpd;
> 
