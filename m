Return-Path: <linux-hyperv+bounces-5190-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5017A9E7BC
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 07:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D607A6A27
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 05:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BC81A5BBA;
	Mon, 28 Apr 2025 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LQF4LCPc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B86211C;
	Mon, 28 Apr 2025 05:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745817774; cv=none; b=ZOiU5ecO1FdIQWUP3UeMXmKvP1KzDxLm90aVSN0TZEQ/D/m1ol4A6CSdzZn8U7ADq1EwCjVtMlJrqirHDtvCJgDOliprO17CjPzw5LcNFREj4Gidq1jCZzy+2aKEwKTJ+qt70tM/DVwSZjs0qiTKAXEoIguoEmkW9mz57B40SLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745817774; c=relaxed/simple;
	bh=jtSfhfb2ioHRWbZWT+63t8YNhpIBQ0ZhuuyyvWSeItU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irSXyeqWFYq7Xginagk2wMLXinOoWTyhtoHVzLVUa1SNR5utabb3zCwKdA0e1HC3ROfKKkclY2w2BsJJLzxw2ZJZwfBpbXbkhQaZxdkXHc9hdNNLpEL3jQvWe6OEv75FRt9dApo9M/4zBZt7PTyg5n1LDbu2BPBc3Rx3VgpC7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LQF4LCPc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 76598204E7CD; Sun, 27 Apr 2025 22:22:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76598204E7CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745817772;
	bh=D2m/5uVeF+LrzPXcvVJrndC9Z3eMXkYAhDUqE9KBCms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQF4LCPcjReWNzV+bzz1eNshSYLiTWAb4Bv7KVnG7soq9x3lFuOzujz6HJzvw2Lap
	 2Q6CS1WFf4WY5QuuzXjaH9h/WUC1HhQ7ldCXjmqql8bA/UJrywf+EyqyF+dA63w1I7
	 VWUpC+XWaUvlyyIrfpHHFEjak/SlPV8R+rGK+124=
Date: Sun, 27 Apr 2025 22:22:52 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy??ski <kw@linux.com>,
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
Message-ID: <20250428052252.GA31705@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1745578437-14878-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250425163748.GA546623@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425163748.GA546623@bhelgaas>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Apr 25, 2025 at 11:37:48AM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 25, 2025 at 03:53:57AM -0700, Shradha Gupta wrote:
> > For supporting dynamic MSI-X vector allocation by PCI controllers, enabling
> > the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
> > to prepare the desc is also needed.
> > 
> > Export pci_msix_prepare_desc() to allow PCI controllers to support dynamic
> > MSI-X vector allocation.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Thanks for the update and for splitting this from the hv driver
> update.  Will watch for Thomas's ack here.
> 
> For future postings, you might consider limiting the "To:" line to
> people you expect to actually act on the patch, and moving the rest to
> "Cc:".

Thanks Bjorn, Noted.
> 
> > ---
> >  drivers/pci/msi/irqdomain.c | 5 +++--
> >  include/linux/msi.h         | 2 ++
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> > index d7ba8795d60f..43129aa6d6c7 100644
> > --- a/drivers/pci/msi/irqdomain.c
> > +++ b/drivers/pci/msi/irqdomain.c
> > @@ -222,13 +222,14 @@ static void pci_irq_unmask_msix(struct irq_data *data)
> >  	pci_msix_unmask(irq_data_get_msi_desc(data));
> >  }
> >  
> > -static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> > -				  struct msi_desc *desc)
> > +void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> > +			   struct msi_desc *desc)
> >  {
> >  	/* Don't fiddle with preallocated MSI descriptors */
> >  	if (!desc->pci.mask_base)
> >  		msix_prepare_msi_desc(to_pci_dev(desc->dev), desc);
> >  }
> > +EXPORT_SYMBOL_GPL(pci_msix_prepare_desc);
> >  
> >  static const struct msi_domain_template pci_msix_template = {
> >  	.chip = {
> > diff --git a/include/linux/msi.h b/include/linux/msi.h
> > index 86e42742fd0f..d5864d5e75c2 100644
> > --- a/include/linux/msi.h
> > +++ b/include/linux/msi.h
> > @@ -691,6 +691,8 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
> >  					     struct irq_domain *parent);
> >  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
> >  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
> > +void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> > +			   struct msi_desc *desc);
> >  #else /* CONFIG_PCI_MSI */
> >  static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
> >  {
> > -- 
> > 2.34.1
> > 

