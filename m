Return-Path: <linux-hyperv+bounces-4947-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BC3A9153D
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 09:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E714466D5
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 07:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C62223316;
	Thu, 17 Apr 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SVxF1lQV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2732122257F;
	Thu, 17 Apr 2025 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874986; cv=none; b=qIaY3UmjNn47FS/DVsxLN9u8spK3YL/Mi54BVWfojN4VjYUtNzQ1GdDY9fWg8jGVMJraUDX2ZZ5jOjxRLO0d2p74i2Lcq8nhLM4MElJSAhdOMwyTlch9d8cQBQmD+Z6xO3CToKe6hLT9rSl+AWaVVktP2SuophdxcEIkn/YAj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874986; c=relaxed/simple;
	bh=PuciJA/1VzUYYWM/dSmMyX1p0tlv0mS1Tnp3ikG3nB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl5+yZ+f09/dwTf7jlL/o7xSCRuLODnaP9Bk33VfOQcHbA/HZhaNc4vMa1/+eyAlqvNWFDgSy3H2ynKZIYPifesU7AZxrCit/XsryanSRDZpEwt9R2IuPv86FqKHRMAY7X8k2voEzde+agkWuFBf3U6PCFq1b2HoNCeLZJIF3f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SVxF1lQV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 8B5E321199C7; Thu, 17 Apr 2025 00:29:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B5E321199C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744874983;
	bh=Ih6u1qmnMix4sMgOGDS8Es/QJXFN+XfxYG1bS+em/K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVxF1lQVXD490/CYtPiLIT3l37PsSpkYbY0Hljk0wsasUb0hRGqEjqnWxo+9y12/H
	 I9BSMicrSexTIDoMf8Fw6bD6+siZxvuoaVR1GaN6Zn4la8N9Ic28MMehPb4ntzwmeY
	 jBzHo0Wztw3H96U/M/yPsBJo7pmBgpTO0NowG+fQ=
Date: Thu, 17 Apr 2025 00:29:43 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy??ski <kw@linux.com>,
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
Message-ID: <20250417072943.GA20244@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744817766-3134-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250416183042.GA75515@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416183042.GA75515@bhelgaas>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Apr 16, 2025 at 01:30:42PM -0500, Bjorn Helgaas wrote:
> [+to Thomas]
> 
> On Wed, Apr 16, 2025 at 08:36:06AM -0700, Shradha Gupta wrote:
> > For supporting dynamic MSI vector allocation by pci controllers, enabling
> > the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
> > to prepare the desc is needed. Export pci_msix_prepare_desc() to allow pci
> > controllers like pci-hyperv to support dynamic MSI vector allocation.
> > Also, add the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and use
> > pci_msix_prepare_desc() in pci_hyperv controller
> 
> Follow capitalization convention for subject line.  Probably remove
> "pci_hyperv" since it already contains "PCI: hv" and add something
> about MSI-X.
> 
> s/pci/PCI/
> 
> s/MSI vector/MSI-X vector/ since the context says you're concerned
> with MSI-X.
> 
> This requires an ack from Thomas; moved him to "To:" line.
>
Thanks Bjorn. I will work on addressing these.

Regards,
Shradha. 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Reviewed-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 7 +++++--
> >  drivers/pci/msi/irqdomain.c         | 5 +++--
> >  include/linux/msi.h                 | 2 ++
> >  3 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index ac27bda5ba26..f2fa6bdb6bb8 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -598,7 +598,8 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
> >  	return cfg->vector;
> >  }
> >  
> > -#define hv_msi_prepare		pci_msi_prepare
> > +#define hv_msi_prepare			pci_msi_prepare
> > +#define hv_msix_prepare_desc		pci_msix_prepare_desc
> >  
> >  /**
> >   * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
> > @@ -727,6 +728,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
> >  #define FLOW_HANDLER		NULL
> >  #define FLOW_NAME		NULL
> >  #define hv_msi_prepare		NULL
> > +#define hv_msix_prepare_desc	NULL
> >  
> >  struct hv_pci_chip_data {
> >  	DECLARE_BITMAP(spi_map, HV_PCI_MSI_SPI_NR);
> > @@ -2063,6 +2065,7 @@ static struct irq_chip hv_msi_irq_chip = {
> >  static struct msi_domain_ops hv_msi_ops = {
> >  	.msi_prepare	= hv_msi_prepare,
> >  	.msi_free	= hv_msi_free,
> > +	.prepare_desc	= hv_msix_prepare_desc,
> >  };
> >  
> >  /**
> > @@ -2084,7 +2087,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
> >  	hbus->msi_info.ops = &hv_msi_ops;
> >  	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
> >  		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
> > -		MSI_FLAG_PCI_MSIX);
> > +		MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN);
> >  	hbus->msi_info.handler = FLOW_HANDLER;
> >  	hbus->msi_info.handler_name = FLOW_NAME;
> >  	hbus->msi_info.data = hbus;
> > diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> > index d7ba8795d60f..43129aa6d6c7 100644
> > --- a/drivers/pci/msi/irqdomain.c
> > +++ b/drivers/pci/msi/irqdomain.c
> > @@ -222,13 +222,14 @@ static void pci_irq_unmask_msix(struct irq_data *data)
> >  	pci_msix_unmask(irq_data_get_msi_desc(data));
> >  }
> >  
> > -static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> > -				  struct msi_desc *desc)
> > +void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> > +			   struct msi_desc *desc)
> >  {
> >  	/* Don't fiddle with preallocated MSI descriptors */
> >  	if (!desc->pci.mask_base)
> >  		msix_prepare_msi_desc(to_pci_dev(desc->dev), desc);
> >  }
> > +EXPORT_SYMBOL_GPL(pci_msix_prepare_desc);
> >  
> >  static const struct msi_domain_template pci_msix_template = {
> >  	.chip = {
> > diff --git a/include/linux/msi.h b/include/linux/msi.h
> > index 86e42742fd0f..d5864d5e75c2 100644
> > --- a/include/linux/msi.h
> > +++ b/include/linux/msi.h
> > @@ -691,6 +691,8 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
> >  					     struct irq_domain *parent);
> >  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
> >  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
> > +void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> > +			   struct msi_desc *desc);
> >  #else /* CONFIG_PCI_MSI */
> >  static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
> >  {
> > -- 
> > 2.34.1
> > 

