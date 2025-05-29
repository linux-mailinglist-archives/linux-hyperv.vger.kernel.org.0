Return-Path: <linux-hyperv+bounces-5688-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3290FAC76A5
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 05:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAF01BA2A69
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 03:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15D8245025;
	Thu, 29 May 2025 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ICISVxTI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6285319B3EC;
	Thu, 29 May 2025 03:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490374; cv=none; b=g0xfAtRWGruA5oiNhqPuQm+JP0z4QWze+5MxCwggmG+tL1wk2PVolXd8mtrjKBzgxBu8uDrsqwd1QSHX6fmrxwol/oXkp6vrmp2ps3j4Du50d4/0VovfHt6j7bB7+KzAMY8TKuRykssZHFCd1OCsR9JxUdzF04prn8D74BXZdDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490374; c=relaxed/simple;
	bh=h2OJS6jUtBHihzkbq+WzN71ynt5DhARgaDsyRvhkc7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YO0zfXtyKTo0/TiRdv/0W0NctIehib7Lc0XLLaPTr0gKR8Rd0RAmRHj5qdmRLrfkBlfcTKjoaDfJRRTCMTNKay3mIs5RTdxKBZW0RXPiyA/ntgpfUYsPeTaLXipfnH29xgQQYuxc5HSPFaTEEnFD06Gm5Xn30RNZ7Dsh9gdohsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ICISVxTI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 131EC206B740; Wed, 28 May 2025 20:46:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 131EC206B740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748490373;
	bh=eQVDRJwOiG+Jsf6IaAstJtVma1vK/VBPDVLQ0ylBw5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICISVxTIt6+OD9g4tCj//Jgw935MmVoGApw5/yulKjDLjPFs5eY2+nW+1Uf4dURHn
	 fzEnYS042TodASRNX7qmD82X16GgTPRjqYJNavGWwNQWBq0GnOl1iXb2WiFZ7QcDFR
	 +A0CPCUjDzbDJZqa+Vg3mglSR3TkhXqXCSYYAgEc=
Date: Wed, 28 May 2025 20:46:13 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
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
Subject: Re: [PATCH v4 1/5] PCI/MSI: Export pci_msix_prepare_desc() for
 dynamic MSI-X allocations
Message-ID: <20250529034613.GB5898@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1748361477-25244-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1748361477-25244-1-git-send-email-shradhagupta@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, May 27, 2025 at 08:57:57AM -0700, Shradha Gupta wrote:
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
> ---
>  Changes in v3
>  * Improved the patch description by removing abbreviations
> ---
>  drivers/pci/msi/irqdomain.c | 5 +++--
>  include/linux/msi.h         | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
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

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com> 

