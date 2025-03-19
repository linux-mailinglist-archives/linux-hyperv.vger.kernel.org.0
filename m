Return-Path: <linux-hyperv+bounces-4626-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB03EA695FA
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 18:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2A742101E
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796C61E5B7E;
	Wed, 19 Mar 2025 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5ozAr6Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449931E5216;
	Wed, 19 Mar 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404162; cv=none; b=hpIRUj2WDSXgl0ND5i5I40jdERHzpKJfN5d5LZ1F+FYU+Rb6q/oSGXNV0VLxmjRmAB/ldQxEMl3pRkaXAa4dFILzY8edaE/kwicNW27MBX/EcF2ROsZS/qFNspEnOoHqb1nGp4DJYjzG019TnTCP+e0hGKfU6CYjvFf1ZRp09Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404162; c=relaxed/simple;
	bh=0KapdxWYIVA9oI/dMvVnTzRMkBA6bZTMHvq4x/lzftE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kxnxiy/WjJFZxTJ3Lh/z9tJGTXI4W+tI6d+EVoEOilSTqZUPdXNwaTvV1HFFeFXMkzw7WeGfawCy+lljjG9DoAzXU0s9RfQyPHfaoNlhrhuXW6gEvHGZrxDhu+lzsBQeTwzwXFz/knDkkwk8Nps+PAwhI38Zk31/wNwUwvRGLQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5ozAr6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8790AC4CEE4;
	Wed, 19 Mar 2025 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742404161;
	bh=0KapdxWYIVA9oI/dMvVnTzRMkBA6bZTMHvq4x/lzftE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C5ozAr6Yp5/3pwDyh6Rk5j4BOxii/CMaA6f+M7pc+phpsGTBX5XTM2+Yo66nba1JH
	 khmR0HZzbGpp2tWOQPwqxxyqHEMucAxXUFHjFnpAoHcrqsdJb4oPNqkFvOxFeAfRFt
	 8431Js/pkYkAJVjBEbLDQKy8fNsxKnoXN1NR7jfGNwWpbJjFGlFoMfir0E4WTa5Zvp
	 z4uzOJ1fgRRHDb+dm87jpOpVTMxie5Jmad77zBjvleu9wpopGaCq/AUTcNlZIE7K+j
	 dlZ0C4luNs4iSt9pvEegMkAGChLnhJO0eun9dHVeF4ZuIWxYnl22rSoXI8gBxhoqxo
	 BXQ5pw+ccgh4w==
Date: Wed, 19 Mar 2025 12:09:19 -0500
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
Subject: Re: [patch V4 08/14] PCI/MSI: Switch msi_capability_init() to
 guard(msi_desc_lock)
Message-ID: <20250319170919.GA1046309@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319105506.504992208@linutronix.de>

On Wed, Mar 19, 2025 at 11:56:53AM +0100, Thomas Gleixner wrote:
> Split the lock protected functionality of msi_capability_init() out into a
> helper function and use guard(msi_desc_lock) to replace the lock/unlock
> pair.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V4: Split out from the previous combo patch
> ---
>  drivers/pci/msi/msi.c |   68 ++++++++++++++++++++++++++------------------------
>  1 file changed, 36 insertions(+), 32 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -336,38 +336,13 @@ static int msi_verify_entries(struct pci
>  	return !entry ? 0 : -EIO;
>  }
>  
> -/**
> - * msi_capability_init - configure device's MSI capability structure
> - * @dev: pointer to the pci_dev data structure of MSI device function
> - * @nvec: number of interrupts to allocate
> - * @affd: description of automatic IRQ affinity assignments (may be %NULL)
> - *
> - * Setup the MSI capability structure of the device with the requested
> - * number of interrupts.  A return value of zero indicates the successful
> - * setup of an entry with the new MSI IRQ.  A negative return value indicates
> - * an error, and a positive return value indicates the number of interrupts
> - * which could have been allocated.
> - */
> -static int msi_capability_init(struct pci_dev *dev, int nvec,
> -			       struct irq_affinity *affd)
> +static int __msi_capability_init(struct pci_dev *dev, int nvec, struct irq_affinity_desc *masks)
>  {
> +	int ret = msi_setup_msi_desc(dev, nvec, masks);
>  	struct msi_desc *entry, desc;
> -	int ret;
> -
> -	/* Reject multi-MSI early on irq domain enabled architectures */
> -	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
> -		return 1;
> -
> -	/* Disable MSI during setup in the hardware to erase stale state */
> -	pci_msi_set_enable(dev, 0);
>  
> -	struct irq_affinity_desc *masks __free(kfree) =
> -		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
> -
> -	msi_lock_descs(&dev->dev);
> -	ret = msi_setup_msi_desc(dev, nvec, masks);
>  	if (ret)
> -		goto unlock;
> +		return ret;
>  
>  	/* All MSIs are unmasked by default; mask them all */
>  	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
> @@ -395,16 +370,45 @@ static int msi_capability_init(struct pc
>  
>  	pcibios_free_irq(dev);
>  	dev->irq = entry->irq;
> -	goto unlock;
> -
> +	return 0;
>  err:
>  	pci_msi_unmask(&desc, msi_multi_mask(&desc));
>  	pci_free_msi_irqs(dev);
> -unlock:
> -	msi_unlock_descs(&dev->dev);
>  	return ret;
>  }
>  
> +/**
> + * msi_capability_init - configure device's MSI capability structure
> + * @dev: pointer to the pci_dev data structure of MSI device function
> + * @nvec: number of interrupts to allocate
> + * @affd: description of automatic IRQ affinity assignments (may be %NULL)
> + *
> + * Setup the MSI capability structure of the device with the requested
> + * number of interrupts.  A return value of zero indicates the successful
> + * setup of an entry with the new MSI IRQ.  A negative return value indicates
> + * an error, and a positive return value indicates the number of interrupts
> + * which could have been allocated.
> + */
> +static int msi_capability_init(struct pci_dev *dev, int nvec,
> +			       struct irq_affinity *affd)
> +{
> +	/* Reject multi-MSI early on irq domain enabled architectures */
> +	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
> +		return 1;
> +
> +	/*
> +	 * Disable MSI during setup in the hardware, but mark it enabled
> +	 * so that setup code can evaluate it.
> +	 */
> +	pci_msi_set_enable(dev, 0);
> +
> +	struct irq_affinity_desc *masks __free(kfree) =
> +		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
> +
> +	guard(msi_descs_lock)(&dev->dev);
> +	return __msi_capability_init(dev, nvec, masks);
> +}
> +
>  int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  			   struct irq_affinity *affd)
>  {
> 

