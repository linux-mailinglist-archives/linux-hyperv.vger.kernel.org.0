Return-Path: <linux-hyperv+bounces-4499-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F4EA60D9D
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 10:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983327AD08C
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8920F1F2C5F;
	Fri, 14 Mar 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SBb+uOdG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E5F1F1312;
	Fri, 14 Mar 2025 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945383; cv=none; b=hjiZsAuDTG87Q9rj18XnRdhdXrE3ZGKZQexoc6EdkULYzc0Wazu3leaEmiiLWDqOPZlwRP+eoqkpP0kSt8tV32bbJ+EbaleAUrr/w1DVyV0fbhE+T5zj1KZY8GHIItH5lhUeJjE35/ywY2JiKAfBFOwSl16wgkU4aKVTV88Utuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945383; c=relaxed/simple;
	bh=R4mT9q2rzMIVE/drUUY0uzpLhqsl0DONcHAw3C4Taeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afWgrUsiVkjaKWboiZJIXYczV5Ow6rtPcXNGzbhvkxVDUlTu8FTJaUeUCt9l4WWso3+xCaf1fVHwPVbn/6jKDmFV+pcjwHTDQ/ygV+LnRSIvSpgs+vnVMkyCig3Lwx8DfpfRth2Y0E1PBBQoCkXrOvNOb24RfbqE8gyJla/MNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SBb+uOdG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cbezX+qBbHUsO5zjEMJT7t6jnT/CGOrWEFqIPazSuTY=; b=SBb+uOdGeuggwnUHr+5j0q0z0c
	K/HZhYq9r99EMw8McQyqsFapl4Me2BvULr57zR8v8PIq6mwVwCvd3wNPpKmYln8wpVCvcADn8N2gQ
	1wzft5orDrCCL0UukfFnc1uIV+Nnxvm3I4dyMq7ozNjqmw5OTDkBgJw/hhf3pE4f8dyw2h9kknMNu
	xYg1LCRvWw8oxTTHYz33rAxHs3WUBHjZw6P3wM2znXKljwa1o5IWcG5vPa+QzuIMGoLmWqfhhCWM3
	25S/+ocwpe4WjtxfwWQldherP3xlyH6zu9DNPqKFYwFtRC+2Uraha+3Fy8M3woTLMSng6cZIxa0Io
	5QCSX/5Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt1Ys-0000000FLob-2ycV;
	Fri, 14 Mar 2025 09:42:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AD3E9300599; Fri, 14 Mar 2025 10:42:37 +0100 (CET)
Date: Fri, 14 Mar 2025 10:42:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
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
Subject: Re: [patch V2 05/10] PCI/MSI: Switch to MSI descriptor locking to
 guard()
Message-ID: <20250314094237.GX5880@noisy.programming.kicks-ass.net>
References: <20250313130212.450198939@linutronix.de>
 <20250313130321.695027112@linutronix.de>
 <20250313155015.000037f5@huawei.com>
 <87ldt86cjj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldt86cjj.ffs@tglx>

On Thu, Mar 13, 2025 at 06:55:12PM +0100, Thomas Gleixner wrote:
> On Thu, Mar 13 2025 at 15:50, Jonathan Cameron wrote:
> >> +	guard(msi_descs_lock)(&dev->dev);
> >> +	int ret = __msix_setup_interrupts(dev, entries, nvec, masks);
> >> +	if (ret)
> >> +		pci_free_msi_irqs(dev);
> >
> > It's not immediately obvious what this is undoing (i.e. where the alloc
> > is).  I think it is at least mostly the pci_msi_setup_msi_irqs in
> > __msix_setup_interrupts
> 
> It's a universal cleanup for all possible error cases.
> 
> > Why not handle the error in __msix_setup_interrupts and make that function
> > side effect free.  Does require gotos but in a function that isn't
> > doing any cleanup magic so should be fine.
> 
> I had the gotos first and then hated them. But you are right, it's better
> to have them than having the magic clean up at the call site.
> 
> I'll fold the delta patch below.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -671,19 +671,23 @@ static int __msix_setup_interrupts(struc
>  	int ret = msix_setup_msi_descs(dev, entries, nvec, masks);
>  
>  	if (ret)
> -		return ret;
> +		goto fail;
>  
>  	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
>  	if (ret)
> -		return ret;
> +		goto fail;
>  
>  	/* Check if all MSI entries honor device restrictions */
>  	ret = msi_verify_entries(dev);
>  	if (ret)
> -		return ret;
> +		goto fail;
>  
>  	msix_update_entries(dev, entries);
>  	return 0;
> +
> +fail:
> +	pci_free_msi_irqs(dev);
> +	return ret;
>  }

How about something like:

int __msix_setup_interrupts(struct device *_dev,... )
{
	struct device *dev __free(msi_irqs) = _dev;

	int ret = msix_setup_msi_descs(dev, entries, nvec, masks);
	if (ret)
		return ret;

	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
	if (ret)
		return ret;

	/* Check if all MSI entries honor device restrictions */
	ret = msi_verify_entries(dev);
	if (ret)
		return ret;

	retain_ptr(dev);
	msix_update_entries(dev, entries);
	return 0;
}

?

