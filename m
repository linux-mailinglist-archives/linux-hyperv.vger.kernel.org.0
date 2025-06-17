Return-Path: <linux-hyperv+bounces-5940-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3D0ADDF9D
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 01:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CCC3A6EA6
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 23:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59614298993;
	Tue, 17 Jun 2025 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGshCCWs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A22F532C;
	Tue, 17 Jun 2025 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202758; cv=none; b=BHJHwNsEznfBW1aPWCmuoYGP27+diKQyLrz7GL4ld4q5gsf9VzFw52Kay+h349o3jUGhm68B0pyff7alSWoolyGYbOcg7u/gbcK+lUoPNeePhewynLjMa7JOoC2bM1AmVlz8LWwNDUgWlLrkU7kwAeu9C5N4FnTop6hLvlr78qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202758; c=relaxed/simple;
	bh=xt7/Fe7EQ3OwNo1cmh493TU1lPrwQWbplHjQhSs0xXg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IUY4AtrxBpenmIGRHYA+lD3oIx3IX+/XNAIB3RTajdC6WF9HRcIYMrDczx7JV5iFnzA5jc6C2a76ZJLe4AraxcGZeMX7BS/noOnIY5hYTEqnIevcV7IuKJpewC678aTZp1N8kVOdgZGl1OT2//Z3+tqcZV/0+AJbgy1IUuI5EvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGshCCWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF7EC4CEE3;
	Tue, 17 Jun 2025 23:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750202757;
	bh=xt7/Fe7EQ3OwNo1cmh493TU1lPrwQWbplHjQhSs0xXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CGshCCWsG/mKLt3rDhhDhuqXb3Sbgo5/WeCo6yWoUyUty8kTEQtK2E0UYYXijJl5j
	 D6tEEMz5PnjydoODziIVFkiE6BulpRqJ7EAyNkjuK8wGuLX6PBENSmSXt6u4i782yz
	 60cfl1dwS3I5XvpbEDMwP1xUqyEUlaJ8ribNAbu8rgRHzWMQhAO5wEmB8Zmke7HfCQ
	 RUGRp/sSrO8/PkkXIDNUi99HRYJRJAtEUARQ9IVMqfrRL8q0UeMS71JFPBn6MyW+uP
	 HF/jpYFL4UD3jIoDljgqpMle3xiy3+h8fLo8kvKRRMnolNIH6V/0HcdhtAZOkHsdMf
	 S6xihLbRSAKMw==
Date: Tue, 17 Jun 2025 18:25:56 -0500
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
Message-ID: <20250617232556.GA1176283@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617232232.GA1175597@bhelgaas>

On Tue, Jun 17, 2025 at 06:22:34PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 19, 2025 at 11:56:57AM +0100, Thomas Gleixner wrote:
> > The PCI/TPH driver fiddles with the MSI-X control word of an active
> > interrupt completely unserialized against concurrent operations issued
> > from the interrupt core. It also brings the PCI/MSI-X internal cached
> > control word out of sync.
> > 
> > Provide a function, which has the required serialization and keeps the
> > control word cache in sync.
> > 
> > Unfortunately this requires to look up and lock the interrupt descriptor,
> > which should be only done in the interrupt core code. But confining this
> > particular oddity in the PCI/MSI core is the lesser of all evil. A
> > interrupt core implementation would require a larger pile of infrastructure
> > and indirections for dubious value.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Wei Huang <wei.huang2@amd.com>
> > Cc: linux-pci@vger.kernel.org
> > 
> > 
> > 
> > ---
> >  drivers/pci/msi/msi.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h     |    9 +++++++++
> >  2 files changed, 56 insertions(+)
> > 
> > --- a/drivers/pci/msi/msi.c
> > +++ b/drivers/pci/msi/msi.c
> > @@ -910,6 +910,53 @@ void pci_free_msi_irqs(struct pci_dev *d
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_PCIE_TPH
> > +/**
> > + * pci_msix_write_tph_tag - Update the TPH tag for a given MSI-X vector
> > + * @pdev:	The PCIe device to update
> > + * @index:	The MSI-X index to update
> > + * @tag:	The tag to write
> > + *
> > + * Returns: 0 on success, error code on failure
> > + */
> > +int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
> > +{
> > +	struct msi_desc *msi_desc;
> > +	struct irq_desc *irq_desc;
> > +	unsigned int virq;
> > +
> > +	if (!pdev->msix_enabled)
> > +		return -ENXIO;
> > +
> > +	guard(msi_descs_lock)(&pdev->dev);
> > +	virq = msi_get_virq(&pdev->dev, index);
> > +	if (!virq)
> > +		return -ENXIO;
> > +	/*
> > +	 * This is a horrible hack, but short of implementing a PCI
> > +	 * specific interrupt chip callback and a huge pile of
> > +	 * infrastructure, this is the minor nuissance. It provides the
> > +	 * protection against concurrent operations on this entry and keeps
> > +	 * the control word cache in sync.
> > +	 */
> > +	irq_desc = irq_to_desc(virq);
> > +	if (!irq_desc)
> > +		return -ENXIO;
> > +
> > +	guard(raw_spinlock_irq)(&irq_desc->lock);
> > +	msi_desc = irq_data_get_msi_desc(&irq_desc->irq_data);
> > +	if (!msi_desc || msi_desc->pci.msi_attrib.is_virtual)
> > +		return -ENXIO;
> > +
> > +	msi_desc->pci.msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_ST;
> > +	msi_desc->pci.msix_ctrl |= FIELD_PREP(PCI_MSIX_ENTRY_CTRL_ST, tag);
> > +	pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
> > +	/* Flush the write */
> > +	readl(pci_msix_desc_addr(msi_desc));
> > +	return 0;
> > +}
> 
> Looks like this change might add this warning, which I don't claim to
> understand:
> 
>   $ make C=2 drivers/pci/msi/msi.o
>   drivers/pci/msi/msi.c:928:5: warning: context imbalance in 'pci_msix_write_tph_tag' - wrong count at exit
> 
> This appeared in v6.16-rc1 as d5124a9957b2 ("PCI/MSI: Provide a sane
> mechanism for TPH")

Sorry, I guess I just rediscovered this sparse deficiency:

  https://lore.kernel.org/r/20250422174156.GA344533@bhelgaas

Never mind, I'll just try to remember to ignore these warnings.

