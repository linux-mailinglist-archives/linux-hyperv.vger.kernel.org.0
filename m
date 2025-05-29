Return-Path: <linux-hyperv+bounces-5698-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E511AC7E99
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 15:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDB7168EA6
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE8225A32;
	Thu, 29 May 2025 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eO3z9utI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE640647;
	Thu, 29 May 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524817; cv=none; b=Z3eQ+c52a4nt9MOo5Qj4qYPpmWXEkk8fSUUjSkxI1qSWyvfoKRF8w/DNtdj3/cSdK3ozhky0agkJEearvwtlKvV+qWDOYT+l28w9NuGbRdX9SnsSU1eI9Zw1BApvYLCcvlBbTpp4XoIctEjky50F2XNVHg5NBr0JQ67syrtUPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524817; c=relaxed/simple;
	bh=LzIPn3DhyVATONiE59+tHDUz9hKodqlTe/+z7bnQeQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuYKI6e4j8/X6ymDXETmaASg9q/hXszZ2qiwQVvCJqVeMiVNNVXiZIzammOf2c/NEYX0ZyGSFwehxEd8en6RznI9X9Ft7pIgu09Y8UvgU8YiOTseTY8yfFHjwo3z0pdIvk4Zyn1RKqiU3QjrIloSKVKrxxbQChSaX9JhInPj2bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eO3z9utI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 57FA9203EE1D; Thu, 29 May 2025 06:20:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57FA9203EE1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748524815;
	bh=6CYhEKN+tNQGicdA8uCujCzDYwaEWR9yJMr8ejURV9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eO3z9utI4b23Ttx5L3F/BtcYOMSFFQPEPwK1hpSxWfRVG16wkB93rBeumIfwzz/b/
	 KxavQ+nXehetAhoC6SeZG95qZUxYBgveNH4nP48rDKPGxMCCQ4iHnlHktdGiuvdeKW
	 x9BzNMyybHlssra4fNLAT4RyZlgxsC9zoWKq69Pc=
Date: Thu, 29 May 2025 06:20:15 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
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
	Peter Zijlstra <peterz@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy???~Dski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4 5/5] net: mana: Allocate MSI-X vectors dynamically
Message-ID: <20250529132015.GD27681@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1748361543-25845-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250529034520.GA5898@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529034520.GA5898@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 28, 2025 at 08:45:20PM -0700, Saurabh Singh Sengar wrote:
> On Tue, May 27, 2025 at 08:59:03AM -0700, Shradha Gupta wrote:
> > Currently, the MANA driver allocates MSI-X vectors statically based on
> > MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> > up allocating more vectors than it needs. This is because, by this time
> > we do not have a HW channel and do not know how many IRQs should be
> > allocated.
> > 
> > To avoid this, we allocate 1 MSI-X vector during the creation of HWC and
> > after getting the value supported by hardware, dynamically add the
> > remaining MSI-X vectors.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  Changes in v4:
> >  * added BUG_ON at appropriate places
> >  * moved xa_destroy to mana_gd_remove()
> >  * rearragned the cleanup logic in mana_gd_setup_dyn_irqs()
> >  * simplified processing around start_irq_index in mana_gd_setup_irqs()
> >  * return 0 instead of return err as appropriate
> > ---
> >  Changes in v3:
> >  * implemented irq_contexts as xarrays rather than list
> >  * split the patch to create a perparation patch around irq_setup()
> >  * add log when IRQ allocation/setup for remaining IRQs fails
> > ---
> >  Changes in v2:
> >  * Use string 'MSI-X vectors' instead of 'pci vectors'
> >  * make skip-cpu a bool instead of int
> >  * rearrange the comment arout skip_cpu variable appropriately
> >  * update the capability bit for driver indicating dynamic IRQ allocation
> >  * enforced max line length to 80
> >  * enforced RCT convention
> >  * initialized gic to NULL, for when there is a possibility of gic
> >    not being populated correctly
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 306 +++++++++++++-----
> >  include/net/mana/gdma.h                       |   8 +-
> >  2 files changed, 235 insertions(+), 79 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 763a548c4a2b..98ebecbec9a7 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -6,6 +6,8 @@
> >  #include <linux/pci.h>
> >  #include <linux/utsname.h>
> >  #include <linux/version.h>
> > +#include <linux/msi.h>
> > +#include <linux/irqdomain.h>
> >  
> >  #include <net/mana/mana.h>
> >  
> > @@ -80,8 +82,15 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
> >  		return err ? err : -EPROTO;
> >  	}
> >  
> > -	if (gc->num_msix_usable > resp.max_msix)
> > -		gc->num_msix_usable = resp.max_msix;
> > +	if (!pci_msix_can_alloc_dyn(pdev)) {
> > +		if (gc->num_msix_usable > resp.max_msix)
> > +			gc->num_msix_usable = resp.max_msix;
> > +	} else {
> > +		/* If dynamic allocation is enabled we have already allocated
> > +		 * hwc msi
> > +		 */
> > +		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
> > +	}
> >  
> >  	if (gc->num_msix_usable <= 1)
> >  		return -ENOSPC;
> > @@ -482,7 +491,9 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
> >  	}
> >  
> >  	queue->eq.msix_index = msi_index;
> > -	gic = &gc->irq_contexts[msi_index];
> > +	gic = xa_load(&gc->irq_contexts, msi_index);
> > +	if (WARN_ON(!gic))
> > +		return -EINVAL;
> >  
> >  	spin_lock_irqsave(&gic->lock, flags);
> >  	list_add_rcu(&queue->entry, &gic->eq_list);
> > @@ -507,7 +518,10 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
> >  	if (WARN_ON(msix_index >= gc->num_msix_usable))
> >  		return;
> >  
> > -	gic = &gc->irq_contexts[msix_index];
> > +	gic = xa_load(&gc->irq_contexts, msix_index);
> > +	if (WARN_ON(!gic))
> > +		return;
> > +
> >  	spin_lock_irqsave(&gic->lock, flags);
> >  	list_for_each_entry_rcu(eq, &gic->eq_list, entry) {
> >  		if (queue == eq) {
> > @@ -1366,47 +1380,113 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> >  	return 0;
> >  }
> >  
> > -static int mana_gd_setup_irqs(struct pci_dev *pdev)
> > +static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> >  {
> >  	struct gdma_context *gc = pci_get_drvdata(pdev);
> > -	unsigned int max_queues_per_port;
> >  	struct gdma_irq_context *gic;
> > -	unsigned int max_irqs, cpu;
> > -	int start_irq_index = 1;
> > -	int nvec, *irqs, irq;
> > -	int err, i = 0, j;
> > +	bool skip_first_cpu = false;
> > +	int *irqs, irq, err, i;
> >  
> >  	cpus_read_lock();
> 
> Now that num_online_cpus is moved further down in this new logic,
> do we want to reduce the critical section ?
> 
> I don't think we want kmalloc_array to be protected.
> 
> 
> > -	max_queues_per_port = num_online_cpus();
> > -	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> > -		max_queues_per_port = MANA_MAX_NUM_QUEUES;
> >  
> > -	/* Need 1 interrupt for the Hardware communication Channel (HWC) */
> > -	max_irqs = max_queues_per_port + 1;
> > -
> > -	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> > -	if (nvec < 0) {
> > -		cpus_read_unlock();
> > -		return nvec;
> > -	}
> > -	if (nvec <= num_online_cpus())
> > -		start_irq_index = 0;
> > -
> > -	irqs = kmalloc_array((nvec - start_irq_index), sizeof(int), GFP_KERNEL);
> > +	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
> >  	if (!irqs) {
> >  		err = -ENOMEM;
> >  		goto free_irq_vector;
> >  	}
> >  
> > -	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
> > -				   GFP_KERNEL);
> > -	if (!gc->irq_contexts) {
> > +	/*
> > +	 * While processing the next pci irq vector, we start with index 1,
> > +	 * as IRQ vector at index 0 is already processed for HWC.
> > +	 * However, the population of irqs array starts with index 0, to be
> > +	 * further used in irq_setup()
> > +	 */
> > +	for (i = 1; i <= nvec; i++) {
> > +		gic = kzalloc(sizeof(*gic), GFP_KERNEL);
> > +		if (!gic) {
> > +			err = -ENOMEM;
> > +			goto free_irq;
> > +		}
> > +		gic->handler = mana_gd_process_eq_events;
> > +		INIT_LIST_HEAD(&gic->eq_list);
> > +		spin_lock_init(&gic->lock);
> > +
> > +		snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
> > +			 i - 1, pci_name(pdev));
> > +
> > +		/* one pci vector is already allocated for HWC */
> > +		irqs[i - 1] = pci_irq_vector(pdev, i);
> > +		if (irqs[i - 1] < 0) {
> > +			err = irqs[i - 1];
> > +			goto free_current_gic;
> > +		}
> > +
> > +		err = request_irq(irqs[i - 1], mana_gd_intr, 0, gic->name, gic);
> > +		if (err)
> > +			goto free_current_gic;
> > +
> > +		xa_store(&gc->irq_contexts, i, gic, GFP_KERNEL);
> > +	}
> > +
> > +	/*
> > +	 * When calling irq_setup() for dynamically added IRQs, if number of
> > +	 * CPUs is more than or equal to allocated MSI-X, we need to skip the
> > +	 * first CPU sibling group since they are already affinitized to HWC IRQ
> > +	 */
> > +	if (gc->num_msix_usable <= num_online_cpus())
> > +		skip_first_cpu = true;
> > +
> > +	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
> > +	if (err)
> > +		goto free_irq;
> > +
> > +	cpus_read_unlock();
> > +	kfree(irqs);
> > +	return 0;
> > +
> > +free_current_gic:
> > +	kfree(gic);
> > +free_irq:
> > +	for (i -= 1; i > 0; i--) {
> > +		irq = pci_irq_vector(pdev, i);
> > +		gic = xa_load(&gc->irq_contexts, i);
> > +		if (WARN_ON(!gic))
> > +			continue;
> > +
> > +		irq_update_affinity_hint(irq, NULL);
> > +		free_irq(irq, gic);
> > +		xa_erase(&gc->irq_contexts, i);
> > +		kfree(gic);
> > +	}
> > +	kfree(irqs);
> > +free_irq_vector:
> > +	cpus_read_unlock();
> > +	return err;
> > +}
> > +
> > +static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
> > +{
> > +	struct gdma_context *gc = pci_get_drvdata(pdev);
> > +	struct gdma_irq_context *gic;
> > +	int *irqs, *start_irqs, irq;
> > +	unsigned int cpu;
> > +	int err, i;
> > +
> > +	cpus_read_lock();
> 
> Same here
> 
> > +	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
> > +	if (!irqs) {
> >  		err = -ENOMEM;
> > -		goto free_irq_array;
> > +		goto free_irq_vector;
> >  	}
> >  
> >  	for (i = 0; i < nvec; i++) {
> > -		gic = &gc->irq_contexts[i];
> > +		gic = kzalloc(sizeof(*gic), GFP_KERNEL);
> > +		if (!gic) {
> > +			err = -ENOMEM;
> > +			goto free_irq;
> > +		}
> > +
> >  		gic->handler = mana_gd_process_eq_events;
> >  		INIT_LIST_HEAD(&gic->eq_list);
> >  		spin_lock_init(&gic->lock);
> 
> <snip>
> 
> - Saurabh

Thanks Saurabh, will get these too


