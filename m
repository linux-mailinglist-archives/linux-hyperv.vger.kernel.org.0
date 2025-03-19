Return-Path: <linux-hyperv+bounces-4623-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A8CA695E9
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 18:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7986E188CFA8
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486B91E0DD9;
	Wed, 19 Mar 2025 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/FhDhai"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080F1E22E6;
	Wed, 19 Mar 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404101; cv=none; b=PTtUmqFVXGZVLopTbwFkAZIwWXFaIBaweGOyRx6Fn9v6SG+ygjfaVIrKNdpAkAlOkko+srduj5WTggWz1o0Ag2x0gOamEcBDzHqyhOxxpYIVuGBFw2SdiU3vPZtElQ2RdFeMPvnJzjJaxz613zyda/T8JVz6Nyc706xPB9fglAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404101; c=relaxed/simple;
	bh=nnCi2z3+hodZj81KTk+zaAwe0gxzfdo68ycMV8BotV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Sj355QBZYC2tBKTwQV0DoIusRpEkWq8UU1o5smFOTIXeYlTeHX3nUr/1PCWl1gkVXksJyqW0LzSz+0QejdUzm9Oqf+1xaqQT0PKenDmPvsf70x3xH9gOLwnJyM5RLKJQSDv/t1jA6qmtDxn3QXaj6JzjIRz2IXsTkSb9GZgT/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/FhDhai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D48C4CEE4;
	Wed, 19 Mar 2025 17:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742404098;
	bh=nnCi2z3+hodZj81KTk+zaAwe0gxzfdo68ycMV8BotV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U/FhDhaiw+ee08HFCH8h5MKIikEARG9FwNdcM8SBrOj97Z+CjWs2hBgSYUZQSjBYY
	 3DKHg9SC9L/EKBQ+OkJcmeI9kungjWPU0KAyWi4uOcc0lM0gVOdROfG9zdY+l3tSFW
	 kGKamqJm9rqY3vmXS16btHR0kCzPqutbqkUjF35t6JU5tgtIDuUkw0a/eQ6VNfFPyi
	 QzGmDKm/HMTMBIVGFQma1cKtJZzNY/XpuJ48E3I7TzagAKe7HV49kHD2dJu4u2bz5G
	 mM0Fb/6pQyCQ0H/jVweSJXssajgVCSH/W8J7GKFopdPRBa0tVjcoK5yh1EFUkhi36q
	 R9eYL2DTClZ/g==
Date: Wed, 19 Mar 2025 12:08:16 -0500
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
Subject: Re: [patch V4 05/14] PCI/MSI: Use guard(msi_desc_lock) where
 applicable
Message-ID: <20250319170816.GA1046112@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319105506.322536126@linutronix.de>

On Wed, Mar 19, 2025 at 11:56:47AM +0100, Thomas Gleixner wrote:
> Convert the trivial cases of msi_desc_lock/unlock() pairs.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V4: Split out from the previous combo patch
> ---
>  drivers/pci/msi/api.c |    6 ++----
>  drivers/pci/msi/msi.c |   12 ++++++------
>  2 files changed, 8 insertions(+), 10 deletions(-)
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

