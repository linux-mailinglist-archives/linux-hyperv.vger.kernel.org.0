Return-Path: <linux-hyperv+bounces-5914-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95787AD97F1
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Jun 2025 00:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA231BC120E
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 22:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DF28D8FF;
	Fri, 13 Jun 2025 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThKPydiD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1D28D8D1;
	Fri, 13 Jun 2025 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852186; cv=none; b=VUzFAf6Esdeq0PF/9xfeGOYtvPSbbupmg0ceLyrfiU3x+urCy7ziMUILjBoWUBgkDIS+6wypHQw/VbeRDuNew7goKUyX6GUCuR/J0pnHfzrcphZiagVRiSnqIPg9WLEvgmQr9fXsgmmk/IQwmHF0Fu4XU0iEPEnkEv1OgEb8Yfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852186; c=relaxed/simple;
	bh=Cnh1qj3xnGvm2c9rFPL9dCenhTeSuMcmJMoF4BNsEZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dkr/mNbHsSl+xnJgCCM9p+g5rcpdtT4Hk2KeSbfXI5eOKU5BLgt2t7IXtL0pSm6Od/UUrjJwyoqwiNeE3Bv3OUaPortzY8o95lwuNsr+xxIJ4Tyl7KUvkmLWZvRnL74Qs/gNpVwQbem4vq0C2DyyV0y5f5XFFQ4JkUeVyVv2eVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThKPydiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCB1C4CEE3;
	Fri, 13 Jun 2025 22:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749852185;
	bh=Cnh1qj3xnGvm2c9rFPL9dCenhTeSuMcmJMoF4BNsEZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ThKPydiDv0ylaXBgHHJwkq4tkeKNssAJZ1hnaTj/WKjEDwKikiX4KxXRbf8eMwb+S
	 6VAdIsq9HqGlWB+M66KdtHDjawWzkcTLlek49xiyM/LhcYwdW27yk0sQYsHx9v/W9U
	 7RLWceKHQMhuGNaaTC2uunzHPDHYHKQ4tlzT9V/3I2NdG++H5gX4Lhtr9eq3+uVrQa
	 GC9cMq/5+w5nyUSXEoaV8Di5HWP2l/5AEaMYgtWdbsZf45xbC9v2jT4IyIar4rUvLH
	 yC4mUTLdCpoUxreAZoFf/L70V17qbb5ObeOeUa5cCKVxTHcV+c5NHiVreSTH5N3tLF
	 cxvf8gV5MDtbA==
Date: Fri, 13 Jun 2025 17:03:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=EF=BF=BD~Dski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v6 1/5] PCI/MSI: Export pci_msix_prepare_desc() for
 dynamic MSI-X allocations
Message-ID: <20250613220304.GA986661@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1749651001-9436-1-git-send-email-shradhagupta@linux.microsoft.com>

On Wed, Jun 11, 2025 at 07:10:01AM -0700, Shradha Gupta wrote:
> For supporting dynamic MSI-X vector allocation by PCI controllers, enabling
> the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
> to prepare the MSI descriptor is also needed.
> 
> Export pci_msix_prepare_desc() to allow PCI controllers to support dynamic
> MSI-X vector allocation.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

If you need it; I see you already have a branch at
https://github.com/shradhagupta6/linux/tree/shradha_v6.16-rc1

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c | 5 +++--
>  include/linux/msi.h         | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index c05152733993..765312c92d9b 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -222,13 +222,14 @@ static void pci_irq_unmask_msix(struct irq_data *data)
>  	pci_msix_unmask(irq_data_get_msi_desc(data));
>  }
>  
> -static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> -				  struct msi_desc *desc)
> +void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> +			   struct msi_desc *desc)
>  {
>  	/* Don't fiddle with preallocated MSI descriptors */
>  	if (!desc->pci.mask_base)
>  		msix_prepare_msi_desc(to_pci_dev(desc->dev), desc);
>  }
> +EXPORT_SYMBOL_GPL(pci_msix_prepare_desc);
>  
>  static const struct msi_domain_template pci_msix_template = {
>  	.chip = {
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 6863540f4b71..7f254bde5426 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -706,6 +706,8 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
>  					     struct irq_domain *parent);
>  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
>  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
> +void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> +			   struct msi_desc *desc);
>  #else /* CONFIG_PCI_MSI */
>  static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
>  {
> -- 
> 2.34.1
> 

