Return-Path: <linux-hyperv+bounces-4627-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A80EA695FC
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6525A8A1434
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC581E5206;
	Wed, 19 Mar 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVMIdqIB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D7C257D;
	Wed, 19 Mar 2025 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404176; cv=none; b=J1Swn5yfTMXzlmPoDFqjJO5dtvQx9HLcV8kMTwhuPYpCDOjXj9K1eQmJ3KdcvYUODg0U3vR0t26EYcrlwFn2en5KwgQk2frd+Lg8LlXthR2UYqal7kWSSeWpyPM9cccuKcypQad6skRYXrxn/5vhH8eqcIs/qCAZ29XkpgTpIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404176; c=relaxed/simple;
	bh=iKCIiHI9Se7fL/4P3PMyQSCP9PrppXcJWRXpCMClUpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JRv9rMvjtqZZnkovHXLQ49CCHE+FgKvjlJ1Ihzz55pZUAFBuiDmIB0p2i+VjStfzV5lTLwf7no31ckC3yGy9anuTIu1IZmFO115MbJFxG5t0WVYlKqDfYIHqDlA7hOi54gzhp3szQqkRo1Z8fm4KGRljXmCVT03NHjlfKTxpnzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVMIdqIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1911C4CEE4;
	Wed, 19 Mar 2025 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742404175;
	bh=iKCIiHI9Se7fL/4P3PMyQSCP9PrppXcJWRXpCMClUpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eVMIdqIB9UuKhiW0pG8us2LpVUwratI0xxa0yomDDHx41i3mnIX+qZcRuxb6tf+0W
	 KKNrUnPfUlrateIDY1Hxzk/9q0/3NfikIJGzUZ9fg4gl2sd0BjZeKYd2013vflRrUT
	 vgjeC/Cj7Euckh3MoZG3D5bLA05/ymgGsaN4Te0lQykVqz6Ng0Yw4rXwFFvFMTikh3
	 L4kEZhj59cGSUyagtiRiKiNLFtjDPvuG59poj0DM5FCfJ3Wu+aH0lcMlk25syDoBQ5
	 vFfM9c3CqVvjY4js5dOBoahAOx2IFp3uCxR3GGkD7fLeBlDx7Qg9N1RP8q3upwUiPc
	 VWTOlwKzEhuuw==
Date: Wed, 19 Mar 2025 12:09:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	Wei Huang <wei.huang2@amd.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: Re: [patch V4 09/14] PCI/MSI: Switch msix_capability_init() to
 guard(msi_desc_lock)
Message-ID: <20250319170932.GA1046398@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319105506.564105011@linutronix.de>

On Wed, Mar 19, 2025 at 11:56:54AM +0100, Thomas Gleixner wrote:
> Split the lock protected functionality of msix_capability_init() out into a
> helper function and use guard(msi_desc_lock) to replace the lock/unlock
> pair.
> 
> Simplify the error path in the helper function by utilizing a custom
> cleanup to get rid of the remaining gotos.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V4: Split out from the previous combo patch
> ---
>  drivers/pci/msi/msi.c |   36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -663,35 +663,39 @@ static void msix_mask_all(void __iomem *
>  		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }
>  
> -static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
> -				 int nvec, struct irq_affinity *affd)
> +DEFINE_FREE(free_msi_irqs, struct pci_dev *, if (_T) pci_free_msi_irqs(_T));
> +
> +static int __msix_setup_interrupts(struct pci_dev *__dev, struct msix_entry *entries,
> +				   int nvec, struct irq_affinity_desc *masks)
>  {
> -	struct irq_affinity_desc *masks __free(kfree) =
> -		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
> -	int ret;
> +	struct pci_dev *dev __free(free_msi_irqs) = __dev;
>  
> -	msi_lock_descs(&dev->dev);
> -	ret = msix_setup_msi_descs(dev, entries, nvec, masks);
> +	int ret = msix_setup_msi_descs(dev, entries, nvec, masks);
>  	if (ret)
> -		goto out_free;
> +		return ret;
>  
>  	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
>  	if (ret)
> -		goto out_free;
> +		return ret;
>  
>  	/* Check if all MSI entries honor device restrictions */
>  	ret = msi_verify_entries(dev);
>  	if (ret)
> -		goto out_free;
> +		return ret;
>  
> +	retain_ptr(dev);
>  	msix_update_entries(dev, entries);
> -	goto out_unlock;
> +	return 0;
> +}
> +
> +static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
> +				 int nvec, struct irq_affinity *affd)
> +{
> +	struct irq_affinity_desc *masks __free(kfree) =
> +		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
>  
> -out_free:
> -	pci_free_msi_irqs(dev);
> -out_unlock:
> -	msi_unlock_descs(&dev->dev);
> -	return ret;
> +	guard(msi_descs_lock)(&dev->dev);
> +	return __msix_setup_interrupts(dev, entries, nvec, masks);
>  }
>  
>  /**
> 

