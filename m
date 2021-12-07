Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A655D46C5E7
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 22:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhLGVGT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 16:06:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53224 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhLGVGN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 16:06:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEC16B81E7D;
        Tue,  7 Dec 2021 21:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF0FC341C1;
        Tue,  7 Dec 2021 21:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638910959;
        bh=xQoYzuJZBtazlb9l9/rEZFpq4l8ZITO51ml+vNgPc6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e153nty81BUAPS50lzOeG3i/XMpm26Pk8TGxhpDoheH+aGOAhJjiCObFncc/cOH46
         OXARkgcqJJlGa0F/Bsl/N/Hr8iyx5YBElDJEc4KBNNajc4emj6cdjk7cQoxzm32rM6
         wS8QDvcYSbelmRSilLFSFpzwM4nEMGo1OciLG1fy1ib0RAXNhpEhAgwC7XOVLwtEMg
         hUh+UVjgpZDPJcdCSkYndl3E5r7GBkkzKgk8s3NaLe/CmCRfbyieQFOca/oFRIERXj
         HKyqHP6oyciLgO6YSOX23lsQkoLBX7Z1J+QJANGpc3FC3xvrJLcihkCi836KsOw4gQ
         4SgZq/E6VBAOQ==
Date:   Tue, 7 Dec 2021 15:02:38 -0600
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
Subject: Re: [patch V2 23/23] PCI/MSI: Move descriptor counting on allocation
 fail to the legacy code
Message-ID: <20211207210238.GA77554@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210225.101336873@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 06, 2021 at 11:28:00PM +0100, Thomas Gleixner wrote:
> The irqdomain code already returns the information. Move the loop to the
> legacy code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/legacy.c |   20 +++++++++++++++++++-
>  drivers/pci/msi/msi.c    |   19 +------------------
>  2 files changed, 20 insertions(+), 19 deletions(-)
> 
> --- a/drivers/pci/msi/legacy.c
> +++ b/drivers/pci/msi/legacy.c
> @@ -50,9 +50,27 @@ void __weak arch_teardown_msi_irqs(struc
>  	}
>  }
>  
> +static int pci_msi_setup_check_result(struct pci_dev *dev, int type, int ret)
> +{
> +	struct msi_desc *entry;
> +	int avail = 0;
> +
> +	if (type != PCI_CAP_ID_MSIX || ret >= 0)
> +		return ret;
> +
> +	/* Scan the MSI descriptors for successfully allocated ones. */
> +	for_each_pci_msi_entry(entry, dev) {
> +		if (entry->irq != 0)
> +			avail++;
> +	}
> +	return avail ? avail : ret;
> +}
> +
>  int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
> -	return arch_setup_msi_irqs(dev, nvec, type);
> +	int ret = arch_setup_msi_irqs(dev, nvec, type);
> +
> +	return pci_msi_setup_check_result(dev, type, ret);
>  }
>  
>  void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -609,7 +609,7 @@ static int msix_capability_init(struct p
>  
>  	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
>  	if (ret)
> -		goto out_avail;
> +		goto out_free;
>  
>  	/* Check if all MSI entries honor device restrictions */
>  	ret = msi_verify_entries(dev);
> @@ -634,23 +634,6 @@ static int msix_capability_init(struct p
>  	pcibios_free_irq(dev);
>  	return 0;
>  
> -out_avail:
> -	if (ret < 0) {
> -		/*
> -		 * If we had some success, report the number of IRQs
> -		 * we succeeded in setting up.
> -		 */
> -		struct msi_desc *entry;
> -		int avail = 0;
> -
> -		for_each_pci_msi_entry(entry, dev) {
> -			if (entry->irq != 0)
> -				avail++;
> -		}
> -		if (avail != 0)
> -			ret = avail;
> -	}
> -
>  out_free:
>  	free_msi_irqs(dev);
>  
> 
