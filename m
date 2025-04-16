Return-Path: <linux-hyperv+bounces-4945-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F23A90B50
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 20:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584CB3AFFDD
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB456223323;
	Wed, 16 Apr 2025 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkc+DPri"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB051FECA1;
	Wed, 16 Apr 2025 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828244; cv=none; b=WK5CUfRc/o0C0TjCzBlsVDSLMC4cAorGeDb71BMXLk7eO4zqQzQ1sfDym1oJj1TAb27wQpahtKD+ylBQKu9Z/7D/0XShKV/SuGgsAgvRd6XKFg4Wn1d/YNDGgsbvgxWp8N9Bq/fmp/6teLOGwRpwji6HJqtZd9X0Mh9ZkE2cqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828244; c=relaxed/simple;
	bh=FtZSOzbuxkOduJR1lakYFkXwUTsnS2uQuQ6BlIYoafM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NanVpM53Qz+h/favyzowllalVOU0aAfGpbazkeEPll+3f/stCBYcfDBkvnbhhVMC9/x5e50ktkVT5aGhiM293su0bLAOPh2ks5D9SxnBMuCEVm5m5GW+c6gw1pQHPt74it6B3M5ggqvzbgjHhfHgUrQ8jEJ7RZ1/bTmd3m0RiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkc+DPri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38A1C4CEE2;
	Wed, 16 Apr 2025 18:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744828244;
	bh=FtZSOzbuxkOduJR1lakYFkXwUTsnS2uQuQ6BlIYoafM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Dkc+DPribskYpXulLARA2qfxHuOKnPJK522qjkDfC/CvWJYDCSqq2JIQVX6SGeAx5
	 Od5OH8ivxowsjOo8w7qwHhHndrJk1olCkfwgOlyEgygqOKc5JjlHhhTXiFOKoLFY00
	 PqjWbZqJl5SktRxWcreUspNGLmdvffIteF3Xc83EbP2DoK09twzCLyF26YckI6HbIH
	 1EvofkN5gdneQ1L6yvndjw3jOjEab8ReFwlNXKZGZdJXOj9RZ1tlH0UG0qrPntj2LZ
	 gHCAf1l2lhuo0zxLHC7oYStPBuB8z/xb4wC0ZkkUe1GajfHarPCLBiDkrx7FS57EIV
	 Qwr4SimLxB3RQ==
Date: Wed, 16 Apr 2025 13:30:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
Subject: Re: [PATCH 1/2] PCI: hv: enable pci_hyperv to allow dynamic vector
 allocation
Message-ID: <20250416183042.GA75515@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744817766-3134-1-git-send-email-shradhagupta@linux.microsoft.com>

[+to Thomas]

On Wed, Apr 16, 2025 at 08:36:06AM -0700, Shradha Gupta wrote:
> For supporting dynamic MSI vector allocation by pci controllers, enabling
> the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
> to prepare the desc is needed. Export pci_msix_prepare_desc() to allow pci
> controllers like pci-hyperv to support dynamic MSI vector allocation.
> Also, add the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and use
> pci_msix_prepare_desc() in pci_hyperv controller

Follow capitalization convention for subject line.  Probably remove
"pci_hyperv" since it already contains "PCI: hv" and add something
about MSI-X.

s/pci/PCI/

s/MSI vector/MSI-X vector/ since the context says you're concerned
with MSI-X.

This requires an ack from Thomas; moved him to "To:" line.

> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Long Li <longli@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 7 +++++--
>  drivers/pci/msi/irqdomain.c         | 5 +++--
>  include/linux/msi.h                 | 2 ++
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ac27bda5ba26..f2fa6bdb6bb8 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -598,7 +598,8 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>  	return cfg->vector;
>  }
>  
> -#define hv_msi_prepare		pci_msi_prepare
> +#define hv_msi_prepare			pci_msi_prepare
> +#define hv_msix_prepare_desc		pci_msix_prepare_desc
>  
>  /**
>   * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
> @@ -727,6 +728,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  #define FLOW_HANDLER		NULL
>  #define FLOW_NAME		NULL
>  #define hv_msi_prepare		NULL
> +#define hv_msix_prepare_desc	NULL
>  
>  struct hv_pci_chip_data {
>  	DECLARE_BITMAP(spi_map, HV_PCI_MSI_SPI_NR);
> @@ -2063,6 +2065,7 @@ static struct irq_chip hv_msi_irq_chip = {
>  static struct msi_domain_ops hv_msi_ops = {
>  	.msi_prepare	= hv_msi_prepare,
>  	.msi_free	= hv_msi_free,
> +	.prepare_desc	= hv_msix_prepare_desc,
>  };
>  
>  /**
> @@ -2084,7 +2087,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
>  	hbus->msi_info.ops = &hv_msi_ops;
>  	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
>  		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
> -		MSI_FLAG_PCI_MSIX);
> +		MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN);
>  	hbus->msi_info.handler = FLOW_HANDLER;
>  	hbus->msi_info.handler_name = FLOW_NAME;
>  	hbus->msi_info.data = hbus;
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index d7ba8795d60f..43129aa6d6c7 100644
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
> index 86e42742fd0f..d5864d5e75c2 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -691,6 +691,8 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
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

