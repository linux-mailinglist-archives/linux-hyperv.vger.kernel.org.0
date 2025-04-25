Return-Path: <linux-hyperv+bounces-5150-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE681A9CE53
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 18:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F827AE226
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CE71A23B6;
	Fri, 25 Apr 2025 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+nCpFkA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5912E1CD;
	Fri, 25 Apr 2025 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599071; cv=none; b=Y/gAK2skuvZvOK70NIzzQdK2w4GgeiGFvInZDjfTM1cXIHYwdrEWxkhTmJCVG8EhkcTT4G4Gv55HVh0ahEaFNgiztxEeVa4kH/jpq/NZMkpTP1VSwfE9YbyOKSsomtSqjd2lDB1KSKgPzSHB93kKtdhxY3H86L/ongvptDDzGTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599071; c=relaxed/simple;
	bh=JT9P8fa6GaPpdB10ha3NV7wedzAJg0y0BNu5ciaRIvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lME8Wmd2h2P361xX3BbEW6chSE4uPbtajHOqUfZ/qO9qDRSBe+XLTnp/FK47UNxXExZr/aHZJKGtjPo1yrrWs9DCPkuTjGwkVNFGzkcC+YorkfuzX7OqUKBsAn8p7LlYjGXFTFiQ5oSVvqiM6luD/yNY9xagXSpVZJQZay7lzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+nCpFkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D656C4CEE4;
	Fri, 25 Apr 2025 16:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745599070;
	bh=JT9P8fa6GaPpdB10ha3NV7wedzAJg0y0BNu5ciaRIvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O+nCpFkATbcbGeFmdfOdNo4pbXvF/sY5KZ9KR00vMVrD9O71xxFpYprlLmX4IwjOu
	 PT8Buxml0q5E+hRhkiATgWy5ej4VPTtWBZvBZZTVraBjrpYEIv6/1+5IRs5JZPf2IE
	 vO3iTB8mZxetOwQ/zejqgoLT1r3mHZZv435ddr65ZgxGMPMT8niOe3dzgWWzzu+L1W
	 4LptpO/qFfTlyVEHn+9onlUMKJ5dmncqMMzrTERQPnfNdruQuEj9C6eSrBEb4Ivw77
	 NmHB+wruXS0t1OE2fgcd4ibRTFyj84jrXiJyLDEXKcJTnOWLy/vVYY2ss++Ll3PmJX
	 hlgh/4Bio29ew==
Date: Fri, 25 Apr 2025 11:37:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v2 1/3] PCI: Export pci_msix_prepare_desc() for dynamic
 MSI-X alloc
Message-ID: <20250425163748.GA546623@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1745578437-14878-1-git-send-email-shradhagupta@linux.microsoft.com>

On Fri, Apr 25, 2025 at 03:53:57AM -0700, Shradha Gupta wrote:
> For supporting dynamic MSI-X vector allocation by PCI controllers, enabling
> the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
> to prepare the desc is also needed.
> 
> Export pci_msix_prepare_desc() to allow PCI controllers to support dynamic
> MSI-X vector allocation.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Thanks for the update and for splitting this from the hv driver
update.  Will watch for Thomas's ack here.

For future postings, you might consider limiting the "To:" line to
people you expect to actually act on the patch, and moving the rest to
"Cc:".

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

