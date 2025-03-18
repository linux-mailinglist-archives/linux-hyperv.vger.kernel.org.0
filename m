Return-Path: <linux-hyperv+bounces-4594-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFAAA67DFE
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 21:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215E8423BAB
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F320B20D;
	Tue, 18 Mar 2025 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEZ+jD05"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F017A30D;
	Tue, 18 Mar 2025 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329459; cv=none; b=SQh1KrTCzHJQw14lzvEyRRKuEXOJTpeH+gPVtkjhFMiPhmHwHoU0VYwUqRpqrcbb4Z3YwAT7h35XBW5xdI2blEAflXxImvHllC2Mr4PgC+ExaFvlISMyoaUKaU6N9Hzkigo1rKxlrtSGfl6H/fjIHc6db2UXLVj4negVa/FZujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329459; c=relaxed/simple;
	bh=gDD5uj92n/KTWCwpkdaHT9ddiDTZCOIsEGMAyb98bik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dQ3QsIxHUNrwAXb1Dy2PkjNS9T9XZaJpWJw1YxJhUgXSgT5EcaONr94DKXneqlTidusipOm2siMyLBBIFpYy6KtyoRhumnZl+E16GibCL2UONpr+aN5glcdFii99trZrBVEWJFh0gBlt7eFzaO9MfHi03zgLqSGGQC5l1ERMOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEZ+jD05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE192C4CEDD;
	Tue, 18 Mar 2025 20:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742329458;
	bh=gDD5uj92n/KTWCwpkdaHT9ddiDTZCOIsEGMAyb98bik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lEZ+jD0581UoR31Vg2kaNKEsmWfBiZ4sE3jwW+tiDbk6mmsVWJmKfUPkfSIwZ5dgV
	 jSCEd5hmr9W6XS7AJ8Iyu6pT084nxk6kklmMMBT7LvewZH/IEPmZSA1tXZwHKkamxJ
	 BR1yjSjS15EgkwzN4J6fRghD96oHtlNoiagI2fqBJPtqDslnvyqnrpP/Z7B2t1+nkA
	 kc6RpLLx1H5xyhah/sU7DSmWAmzlFA3cidbdc/YNYOiSSnePx1TEROjnKZrU/Yl452
	 +ue3WpkN9xbqLjfpUYpgDna8Pw6yHHMOCHO19DgXOUNcc0Ascmeb4y93dXOgNrcLvu
	 Hxoy7ywAmGxFQ==
Date: Tue, 18 Mar 2025 15:24:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	linux-hyperv@vger.kernel.org, Wei Huang <wei.huang2@amd.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: Re: [patch V3 05/10] PCI/MSI: Switch to MSI descriptor locking to
 guard()
Message-ID: <20250318202416.GA1012281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317092946.014189955@linutronix.de>

On Mon, Mar 17, 2025 at 02:29:27PM +0100, Thomas Gleixner wrote:
> Convert the code to use the new guard(msi_descs_lock).
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

To help connect these together, I might mention "msi_descs_lock"
specifically in the subject line of the earlier patch:

  genirq/msi: Use lock guards for MSI descriptor locking

The msi_capability_init() -> __msi_capability_init() rework is a big
chunk compared to the rest of this patch.  Same for
msix_setup_interrupts() -> __msix_setup_interrupts().

I think I see the point (basically move the body to the new "__"
functions and put the guard() in the original functions before calling
the new ones).

> ---
> V3: Use__free in __msix_setup_interrupts() - PeterZ
> V2: Remove the gotos - Jonathan
> ---
>  drivers/pci/msi/api.c |    6 --
>  drivers/pci/msi/msi.c |  124 +++++++++++++++++++++++++-------------------------
>  2 files changed, 64 insertions(+), 66 deletions(-)
> 
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -53,10 +53,9 @@ void pci_disable_msi(struct pci_dev *dev
>  	if (!pci_msi_enabled() || !dev || !dev->msi_enabled)
>  		return;
>  
> -	msi_lock_descs(&dev->dev);
> +	guard(msi_descs_lock)(&dev->dev);
>  	pci_msi_shutdown(dev);
>  	pci_free_msi_irqs(dev);
> -	msi_unlock_descs(&dev->dev);
>  }
>  EXPORT_SYMBOL(pci_disable_msi);
>  
> @@ -196,10 +195,9 @@ void pci_disable_msix(struct pci_dev *de
>  	if (!pci_msi_enabled() || !dev || !dev->msix_enabled)
>  		return;
>  
> -	msi_lock_descs(&dev->dev);
> +	guard(msi_descs_lock)(&dev->dev);
>  	pci_msix_shutdown(dev);
>  	pci_free_msi_irqs(dev);
> -	msi_unlock_descs(&dev->dev);
>  }
>  EXPORT_SYMBOL(pci_disable_msix);
>  
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -336,41 +336,11 @@ static int msi_verify_entries(struct pci
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
> -	struct irq_affinity_desc *masks = NULL;
> +	int ret = msi_setup_msi_desc(dev, nvec, masks);
>  	struct msi_desc *entry, desc;
> -	int ret;
> -
> -	/* Reject multi-MSI early on irq domain enabled architectures */
> -	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
> -		return 1;
> -
> -	/*
> -	 * Disable MSI during setup in the hardware, but mark it enabled
> -	 * so that setup code can evaluate it.
> -	 */
> -	pci_msi_set_enable(dev, 0);
> -	dev->msi_enabled = 1;
> -
> -	if (affd)
> -		masks = irq_create_affinity_masks(nvec, affd);
>  
> -	msi_lock_descs(&dev->dev);
> -	ret = msi_setup_msi_desc(dev, nvec, masks);
>  	if (ret)
>  		goto fail;
>  
> @@ -399,19 +369,48 @@ static int msi_capability_init(struct pc
>  
>  	pcibios_free_irq(dev);
>  	dev->irq = entry->irq;
> -	goto unlock;
> -
> +	return 0;
>  err:
>  	pci_msi_unmask(&desc, msi_multi_mask(&desc));
>  	pci_free_msi_irqs(dev);
>  fail:
>  	dev->msi_enabled = 0;
> -unlock:
> -	msi_unlock_descs(&dev->dev);
> -	kfree(masks);
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
> +	dev->msi_enabled = 1;
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
> @@ -666,38 +665,39 @@ static void msix_mask_all(void __iomem *
>  		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }
>  
> -static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
> -				 int nvec, struct irq_affinity *affd)
> -{
> -	struct irq_affinity_desc *masks = NULL;
> -	int ret;
> +DEFINE_FREE(free_msi_irqs, struct pci_dev *, if (_T) pci_free_msi_irqs(_T));
>  
> -	if (affd)
> -		masks = irq_create_affinity_masks(nvec, affd);
> +static int __msix_setup_interrupts(struct pci_dev *__dev, struct msix_entry *entries,
> +				   int nvec, struct irq_affinity_desc *masks)
> +{
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
>  
> -out_free:
> -	pci_free_msi_irqs(dev);
> -out_unlock:
> -	msi_unlock_descs(&dev->dev);
> -	kfree(masks);
> -	return ret;
> +static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
> +				 int nvec, struct irq_affinity *affd)
> +{
> +	struct irq_affinity_desc *masks __free(kfree) =
> +		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
> +
> +	guard(msi_descs_lock)(&dev->dev);
> +	return __msix_setup_interrupts(dev, entries, nvec, masks);
>  }
>  
>  /**
> @@ -871,13 +871,13 @@ void __pci_restore_msix_state(struct pci
>  
>  	write_msg = arch_restore_msi_irqs(dev);
>  
> -	msi_lock_descs(&dev->dev);
> -	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
> -		if (write_msg)
> -			__pci_write_msi_msg(entry, &entry->msg);
> -		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
> +	scoped_guard (msi_descs_lock, &dev->dev) {
> +		msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
> +			if (write_msg)
> +				__pci_write_msi_msg(entry, &entry->msg);
> +			pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
> +		}
>  	}
> -	msi_unlock_descs(&dev->dev);
>  
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  }
> 

