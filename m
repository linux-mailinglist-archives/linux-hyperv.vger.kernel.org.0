Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FDB46C4FC
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 21:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhLGU6j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 15:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhLGU6i (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 15:58:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE94C061574;
        Tue,  7 Dec 2021 12:55:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 73B61CE1E01;
        Tue,  7 Dec 2021 20:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A28BC341CA;
        Tue,  7 Dec 2021 20:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638910503;
        bh=Fa6UchSERsdNVXky6PNS2vCw8nCpV4RsTu7TPsjmB4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dvUfGzkAJKzccQlv0HtPexRzXLWw3+BexhSfcjdhY9OELj9M9shyPr2oxlHYgishh
         t4D2z7Bdr+ncSq9kKTlJ1eWwQvEyIE70QCOcHPfTkykUuEbmkImTsvOBxAh+YrDT2N
         e2tXRjJ7AyPRQqOviSDYGDRtTGTym9+e84h6CsKaxpAqC8y47ShWjPbJ5Wc+6tQEDN
         O+w8x6jcjhb24uXwmpRRwPhRkrIfIv7GvPutd6orOK9sOuf81nkdYTyVSsRwR7X0hy
         UTGVn2mumg3zTPmrl6DdJIgD9FUL38mTDmd4Yy4CHa5XbrINFDsrU5l0x2T6JYzzJO
         QyWBUWsq4OuoA==
Date:   Tue, 7 Dec 2021 14:55:02 -0600
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
Subject: Re: [patch V2 07/23] PCI/MSI: Remove msi_desc_to_pci_sysdata()
Message-ID: <20211207205502.GA76553@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210224.210768199@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 06, 2021 at 11:27:34PM +0100, Thomas Gleixner wrote:
> Last user is gone long ago.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi.c   |    8 --------
>  include/linux/msi.h |    5 -----
>  2 files changed, 13 deletions(-)
> 
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1267,14 +1267,6 @@ struct pci_dev *msi_desc_to_pci_dev(stru
>  }
>  EXPORT_SYMBOL(msi_desc_to_pci_dev);
>  
> -void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
> -{
> -	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
> -
> -	return dev->bus->sysdata;
> -}
> -EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
> -
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>  /**
>   * pci_msi_domain_write_msg - Helper to write MSI message to PCI config space
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -218,13 +218,8 @@ static inline void msi_desc_set_iommu_co
>  	for_each_msi_entry((desc), &(pdev)->dev)
>  
>  struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
> -void *msi_desc_to_pci_sysdata(struct msi_desc *desc);
>  void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
>  #else /* CONFIG_PCI_MSI */
> -static inline void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
> -{
> -	return NULL;
> -}
>  static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
>  {
>  }
> 
