Return-Path: <linux-hyperv+bounces-4625-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40720A695F3
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7209A882423
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883BD1E5B7E;
	Wed, 19 Mar 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHW4AF82"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528021E0DD9;
	Wed, 19 Mar 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404150; cv=none; b=A2vcGhDCepMaNMXcysMWKaRQIDLd7cl265JYvlz7oerZjROvfqMu+UlCQ+cp4mNG8XtCP4qYFc5rIACi+CgyF3Qgo+tOg5Ufkr5SjJPSd0lT87kMH52lBQ6o9sIYbFHTg1sip62Rk97EoXpKejfDrIT181D1m1HqXiWhvhGzlh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404150; c=relaxed/simple;
	bh=4eZQWN7E6zsNrJUeyWKvlxo7Of2VDaRkDQCQjB3bpw0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F4TtpwqiW7Yj7VINm2b0LFGzrqhvMtdqX+NeFNC72Gtvq5f+QRmi83HWsBAn2qw5SXuBs1TqzY5egOiKyNyfPypUcUwHY+LLApDAItbEzbEYsNquvg61M2wFo+QmwkhP5Ntt94muG5RxDOWDZRtsohoVStoNkAE5rPS9KmAFVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHW4AF82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF854C4CEE4;
	Wed, 19 Mar 2025 17:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742404150;
	bh=4eZQWN7E6zsNrJUeyWKvlxo7Of2VDaRkDQCQjB3bpw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vHW4AF82ElwGhCSx85axsadkgO43hpcyLeFrlQvq6a+fuPYcl8RLqd/F7+4QyibY4
	 Edg/0QJzGFnm+1xDijZ1DAZ4vySfGVtBaJQ8ML95ri7vOQczN2wvL3xvP8dRTGqZRd
	 ts4z1XlPLmUMCImhVDGQL/64EbGHwlpq1AP+6+d2WvPQhK9OdpvBGaQ7alIJ00r3n4
	 7LconlkWvjWmzImmGOTH+drgSWa/enljL8+yWCMj9b6qrqf3V4YYzo2AeKkeuAHJYo
	 u9Rw9cQDI5V71Ox2A+jsYEouxgykImd7RhjK0q5CUzgvS6ks07CWV6LNZGjVBs+n/j
	 6niS4iRk8+2WA==
Date: Wed, 19 Mar 2025 12:09:08 -0500
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
Subject: Re: [patch V4 07/14] PCI/MSI: Use __free() for affinity masks
Message-ID: <20250319170908.GA1046257@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319105506.444764312@linutronix.de>

On Wed, Mar 19, 2025 at 11:56:50AM +0100, Thomas Gleixner wrote:
> Let cleanup handle the freeing of the affinity mask. That prepares for
> switching the MSI descriptor locking to a guard().
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V4: Split out of the previous combo patch
> ---
>  drivers/pci/msi/msi.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -351,7 +351,6 @@ static int msi_verify_entries(struct pci
>  static int msi_capability_init(struct pci_dev *dev, int nvec,
>  			       struct irq_affinity *affd)
>  {
> -	struct irq_affinity_desc *masks = NULL;
>  	struct msi_desc *entry, desc;
>  	int ret;
>  
> @@ -362,8 +361,8 @@ static int msi_capability_init(struct pc
>  	/* Disable MSI during setup in the hardware to erase stale state */
>  	pci_msi_set_enable(dev, 0);
>  
> -	if (affd)
> -		masks = irq_create_affinity_masks(nvec, affd);
> +	struct irq_affinity_desc *masks __free(kfree) =
> +		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
>  
>  	msi_lock_descs(&dev->dev);
>  	ret = msi_setup_msi_desc(dev, nvec, masks);
> @@ -403,7 +402,6 @@ static int msi_capability_init(struct pc
>  	pci_free_msi_irqs(dev);
>  unlock:
>  	msi_unlock_descs(&dev->dev);
> -	kfree(masks);
>  	return ret;
>  }
>  
> @@ -664,12 +662,10 @@ static void msix_mask_all(void __iomem *
>  static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
>  				 int nvec, struct irq_affinity *affd)
>  {
> -	struct irq_affinity_desc *masks = NULL;
> +	struct irq_affinity_desc *masks __free(kfree) =
> +		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
>  	int ret;
>  
> -	if (affd)
> -		masks = irq_create_affinity_masks(nvec, affd);
> -
>  	msi_lock_descs(&dev->dev);
>  	ret = msix_setup_msi_descs(dev, entries, nvec, masks);
>  	if (ret)
> @@ -691,7 +687,6 @@ static int msix_setup_interrupts(struct
>  	pci_free_msi_irqs(dev);
>  out_unlock:
>  	msi_unlock_descs(&dev->dev);
> -	kfree(masks);
>  	return ret;
>  }
>  
> 

