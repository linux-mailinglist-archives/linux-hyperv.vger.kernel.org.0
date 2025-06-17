Return-Path: <linux-hyperv+bounces-5939-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19315ADDF95
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 01:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFBE189D188
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 23:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CEB2980B0;
	Tue, 17 Jun 2025 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJJMEIcd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9D1F5847;
	Tue, 17 Jun 2025 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202555; cv=none; b=taTbaZNZW9eo0ymlFJW8f9DavnL5YWJp333FAMqzI7gNs13JJfybTOQKFh1h8fKJRysCku5P1CCoGd5FNrnMjONFROZdZ/sth8tJVBKbwKhPNtGa5bCGKrWdOb06I29shhA7No9YzXsaKCfneoZP8Uxh929ekQ1dSMqenpCaggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202555; c=relaxed/simple;
	bh=u1htMHCfOn54kD/o5h2nrr3o2cCWVjR8jS9t5mNwAAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lpm3saFSITDavIsI93fAwP/oVx98UhBCeXVl3MjeZvnKQgE+eBKBAmEVL3sk9epEOtcCAougAMjoszRee/zQ9mRA1EiRIqdla5ZYOzE2prMZCu2Bb0f+1MLsza0uFQKo5ITD+7XW128IbHTMAre1gsuyueqJmh/2zVAhK7HjNLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJJMEIcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514D9C4CEE3;
	Tue, 17 Jun 2025 23:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750202554;
	bh=u1htMHCfOn54kD/o5h2nrr3o2cCWVjR8jS9t5mNwAAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CJJMEIcdDL3U6KeionggSaibPhm8G//lLOHIh/M0Sv3ETnJx3ZonmS2DBE4kHPEiB
	 G+qDd5cANB8mxW16MzxHEUPSeXVm3jMXARu8P165BaWknXoG0jcqDfbtkkxlepxqJB
	 rkakRvjbQ4hNzWqYApa0KEdRAPLYCJ1vU3e/PEeO4Jv/DBGEW+FR6Y9UBfWhyL3Kaj
	 OjDt4bLRw059fA+iLK/WGmSiNIKhVGyuC9nOe1LlttWN3VBwEtvw2UId0UoYsHPUaU
	 dZ6KVmI5xSUwU4MeCfgb//aydRZHZzb0PmlsDK7q4MAxVKO+PbNE9DH/FkR147Y1E+
	 ceTnoMgYOBAgA==
Date: Tue, 17 Jun 2025 18:22:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Wei Huang <wei.huang2@amd.com>,
	linux-pci@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: Re: [patch V4 11/14] PCI/MSI: Provide a sane mechanism for TPH
Message-ID: <20250617232232.GA1175597@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319105506.683663807@linutronix.de>

On Wed, Mar 19, 2025 at 11:56:57AM +0100, Thomas Gleixner wrote:
> The PCI/TPH driver fiddles with the MSI-X control word of an active
> interrupt completely unserialized against concurrent operations issued
> from the interrupt core. It also brings the PCI/MSI-X internal cached
> control word out of sync.
> 
> Provide a function, which has the required serialization and keeps the
> control word cache in sync.
> 
> Unfortunately this requires to look up and lock the interrupt descriptor,
> which should be only done in the interrupt core code. But confining this
> particular oddity in the PCI/MSI core is the lesser of all evil. A
> interrupt core implementation would require a larger pile of infrastructure
> and indirections for dubious value.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Wei Huang <wei.huang2@amd.com>
> Cc: linux-pci@vger.kernel.org
> 
> 
> 
> ---
>  drivers/pci/msi/msi.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h     |    9 +++++++++
>  2 files changed, 56 insertions(+)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -910,6 +910,53 @@ void pci_free_msi_irqs(struct pci_dev *d
>  	}
>  }
>  
> +#ifdef CONFIG_PCIE_TPH
> +/**
> + * pci_msix_write_tph_tag - Update the TPH tag for a given MSI-X vector
> + * @pdev:	The PCIe device to update
> + * @index:	The MSI-X index to update
> + * @tag:	The tag to write
> + *
> + * Returns: 0 on success, error code on failure
> + */
> +int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
> +{
> +	struct msi_desc *msi_desc;
> +	struct irq_desc *irq_desc;
> +	unsigned int virq;
> +
> +	if (!pdev->msix_enabled)
> +		return -ENXIO;
> +
> +	guard(msi_descs_lock)(&pdev->dev);
> +	virq = msi_get_virq(&pdev->dev, index);
> +	if (!virq)
> +		return -ENXIO;
> +	/*
> +	 * This is a horrible hack, but short of implementing a PCI
> +	 * specific interrupt chip callback and a huge pile of
> +	 * infrastructure, this is the minor nuissance. It provides the
> +	 * protection against concurrent operations on this entry and keeps
> +	 * the control word cache in sync.
> +	 */
> +	irq_desc = irq_to_desc(virq);
> +	if (!irq_desc)
> +		return -ENXIO;
> +
> +	guard(raw_spinlock_irq)(&irq_desc->lock);
> +	msi_desc = irq_data_get_msi_desc(&irq_desc->irq_data);
> +	if (!msi_desc || msi_desc->pci.msi_attrib.is_virtual)
> +		return -ENXIO;
> +
> +	msi_desc->pci.msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_ST;
> +	msi_desc->pci.msix_ctrl |= FIELD_PREP(PCI_MSIX_ENTRY_CTRL_ST, tag);
> +	pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
> +	/* Flush the write */
> +	readl(pci_msix_desc_addr(msi_desc));
> +	return 0;
> +}

Looks like this change might add this warning, which I don't claim to
understand:

  $ make C=2 drivers/pci/msi/msi.o
  drivers/pci/msi/msi.c:928:5: warning: context imbalance in 'pci_msix_write_tph_tag' - wrong count at exit

This appeared in v6.16-rc1 as d5124a9957b2 ("PCI/MSI: Provide a sane
mechanism for TPH")

