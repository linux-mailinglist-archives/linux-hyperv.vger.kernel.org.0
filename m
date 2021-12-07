Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7C46C5DB
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 22:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhLGVFp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 16:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhLGVFb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 16:05:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F66C0698CB;
        Tue,  7 Dec 2021 13:02:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 549D7CE1E04;
        Tue,  7 Dec 2021 21:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EABC341C6;
        Tue,  7 Dec 2021 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638910917;
        bh=Xx5Xlrv9sa2u5A/Kpn/Dg/C1KiusFx7+1t0Q3ZaD6H0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n8AstkO1bzz/peccJoNv+OV8w4azVbrZfSQZ+C6VrByvWmPCcuA2UoeLK7KF47R8L
         vZst3jSGZu4YUxnifcSqUb1O35ur9epBYuG/DP/WQ/icPCZjzW/3TXclIKDXlqCJoX
         tc18Sbi36Aj0D6NsekqSM+82EIrp06HXxtNuS66W7DP7eTGFxuQRp9F7qgu1/oS6Nh
         EiQZ2fSjwcXjKQPTB0uzie9HLe4wME36g/iRUJWHldf2e/7IFERXGSfGEslP0xR4VZ
         V4I9BEz7rWwPqwC+sNYmCoDe+CD/nvsXq9LjxicUETpYVVdLu043m0E8HlLj60v+3X
         HUdygMtqlpOxw==
Date:   Tue, 7 Dec 2021 15:01:56 -0600
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
Subject: Re: [patch V2 21/23] PCI/MSI: Make pci_msi_domain_check_cap() static
Message-ID: <20211207210156.GA77414@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210224.980989243@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 06, 2021 at 11:27:57PM +0100, Thomas Gleixner wrote:
> No users outside of that file.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |    5 +++--
>  include/linux/msi.h         |    2 --
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -79,8 +79,9 @@ static inline bool pci_msi_desc_is_multi
>   *  1 if Multi MSI is requested, but the domain does not support it
>   *  -ENOTSUPP otherwise
>   */
> -int pci_msi_domain_check_cap(struct irq_domain *domain,
> -			     struct msi_domain_info *info, struct device *dev)
> +static int pci_msi_domain_check_cap(struct irq_domain *domain,
> +				    struct msi_domain_info *info,
> +				    struct device *dev)
>  {
>  	struct msi_desc *desc = first_pci_msi_entry(to_pci_dev(dev));
>  
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -439,8 +439,6 @@ void *platform_msi_get_host_data(struct
>  struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
>  					     struct msi_domain_info *info,
>  					     struct irq_domain *parent);
> -int pci_msi_domain_check_cap(struct irq_domain *domain,
> -			     struct msi_domain_info *info, struct device *dev);
>  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
>  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
>  bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
> 
