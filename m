Return-Path: <linux-hyperv+bounces-4624-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD5DA695EF
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 18:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735AB3BE404
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544031EB5EA;
	Wed, 19 Mar 2025 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G14mmUJ/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB3B1D54D6;
	Wed, 19 Mar 2025 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404132; cv=none; b=BJTeW/fZCoIVvV12ejsV+3wKyipRlzMfqMaqHUR1Lhg0k+vvPmN6BcgXQ/wsStu6gAw/CiyIEtMzwZpUv4ftidPZZthi4RCORW2lecbhegZ+PlXgfUWRyfT8owCyifnyKphRJa0KSeAoEb3Ifyumx+3OPSsEbN+bKP3ow3WFuj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404132; c=relaxed/simple;
	bh=O6TJ8nTFLxfO+EIOy74huVY72QVXAHjgorq6WvP7OZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e3a/B6xLf8QiPVUJOo6TK8zW70F3zoVTGs/wmbFdYtR0CUUbUUyp5naTmsbpJZwzZmXvCmMzGPeklAQfKZsio8fI5S3sX/iziY+KfUqd+kuC0wWZCR0poSOSe28ihERo+OuFghk9GufyIkLrElqacHvXVcKMTXmQ/eZi40rORdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G14mmUJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F66EC4CEE4;
	Wed, 19 Mar 2025 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742404131;
	bh=O6TJ8nTFLxfO+EIOy74huVY72QVXAHjgorq6WvP7OZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G14mmUJ/nChPPHKxQxEumayTysEjDK4VzLIDJwjAV8sswXcJgnv2mSv3zdLkbxPtq
	 w+O31Fp2lZLQicQcNw3HOa4cNRBcslPyIUfSV2qEPsO1LkIwzqD/hIcUvHCEH2Cub/
	 /uSWP5l5YwNq7E9E+kY37RC9/P9y/TpBmOZDtcjyH3DU5+QWpfj0E1rieYXu6JMCZv
	 XKkPi1QU+86pjawweim+MaUUgn9DyWlHXyEDD00Mjxe7QMbny6OYNNOdtLzSE5Wi8Q
	 tEUY5JaBKSBxjDHXHEwaRj5bkycFzwWGOo7CJHf8xhmBdSXLfN1l5+5t0XNWqFnOoR
	 sLw7U2gRuowsA==
Date: Wed, 19 Mar 2025 12:08:48 -0500
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
Subject: Re: [patch V4 06/14] PCI/MSI: Set pci_dev::msi_enabled late
Message-ID: <20250319170848.GA1046210@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319105506.383222333@linutronix.de>

On Wed, Mar 19, 2025 at 11:56:49AM +0100, Thomas Gleixner wrote:
> The comment claiming that pci_dev::msi_enabled has to be set across setup
> is a leftover from ancient code versions. Nothing in the setup code
> requires the flag to be set anymore.
> 
> Set it in the success path and remove the extra goto label.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V4: New patch
> ---
>  drivers/pci/msi/msi.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -359,12 +359,8 @@ static int msi_capability_init(struct pc
>  	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
>  		return 1;
>  
> -	/*
> -	 * Disable MSI during setup in the hardware, but mark it enabled
> -	 * so that setup code can evaluate it.
> -	 */
> +	/* Disable MSI during setup in the hardware to erase stale state */
>  	pci_msi_set_enable(dev, 0);
> -	dev->msi_enabled = 1;
>  
>  	if (affd)
>  		masks = irq_create_affinity_masks(nvec, affd);
> @@ -372,7 +368,7 @@ static int msi_capability_init(struct pc
>  	msi_lock_descs(&dev->dev);
>  	ret = msi_setup_msi_desc(dev, nvec, masks);
>  	if (ret)
> -		goto fail;
> +		goto unlock;
>  
>  	/* All MSIs are unmasked by default; mask them all */
>  	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
> @@ -394,6 +390,7 @@ static int msi_capability_init(struct pc
>  		goto err;
>  
>  	/* Set MSI enabled bits	*/
> +	dev->msi_enabled = 1;
>  	pci_intx_for_msi(dev, 0);
>  	pci_msi_set_enable(dev, 1);
>  
> @@ -404,8 +401,6 @@ static int msi_capability_init(struct pc
>  err:
>  	pci_msi_unmask(&desc, msi_multi_mask(&desc));
>  	pci_free_msi_irqs(dev);
> -fail:
> -	dev->msi_enabled = 0;
>  unlock:
>  	msi_unlock_descs(&dev->dev);
>  	kfree(masks);
> 

