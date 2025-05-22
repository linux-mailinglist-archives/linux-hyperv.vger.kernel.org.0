Return-Path: <linux-hyperv+bounces-5617-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228C3AC085B
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 May 2025 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2347EA25CCD
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 May 2025 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A801286D53;
	Thu, 22 May 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s+R/gFze"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F3E286899;
	Thu, 22 May 2025 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905472; cv=none; b=uzBMCQi8RO6+Npy5dStGiPXgeYU5YxXryQUgAfAIh3amFeIoJ2lw/7Ga0ZshWA4DvRpPrvqJjoqYKnqZJP+r6r8V79CKTY3uKVXYPgONeWhQyLeSP2n7be45S5DHL3AQp++E47m0Tb4dpEMt6DtV8mE0lXKdF3ZDrdzHz5mA6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905472; c=relaxed/simple;
	bh=u31APRfzDx1o7zqGbXeBCALzW8frmyRJ272T/G6Cd4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvLD7nnNJPeqRWdb9yXvcB23MPM5PzijWg4EEDjxkCKzdd1v/U9zUS4fVp6OJSl7ahZtyUcjKGiUIAzFfWhYGZ5oWfLtBVr1JM41kfCVm4mkzTSPngvj36NcKqO3t7PxZaRwCKPNdx0aTufutZLGBulEaeipzRxEKNpAm+jB7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s+R/gFze; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 96AB4211CF80; Thu, 22 May 2025 02:17:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 96AB4211CF80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747905469;
	bh=i3nEz26Q8SpOVHOcOEJdVg8abGKvI0bRKzmPw5hK8Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s+R/gFzeaqsOxoo6b7TfYa26R6Yy0v+dZpub3ezFOpi63jsf7aB4hOgK2FlzkQU98
	 V3A2kB/41USLEsYjs31mKplo+YpzFJbz+ILBqy4a3O68kaTVa3Krn7PxvqWM64bCRD
	 nJ/EheFVy4hKlZNOHwgcnBjDceJYgObwlIDiLPgA=
Date: Thu, 22 May 2025 02:17:49 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
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
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy???~Dski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v3 4/4] net: mana: Allocate MSI-X vectors dynamically
Message-ID: <20250522091749.GA13266@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785637-4881-1-git-send-email-shradhagupta@linux.microsoft.com>
 <BN7PR02MB414863E6F4E36CF14F71F80BD49EA@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB414863E6F4E36CF14F71F80BD49EA@BN7PR02MB4148.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 21, 2025 at 04:27:04PM +0000, Michael Kelley wrote:
> From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Friday, May 9, 2025 3:14 AM
> > 
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
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 248 +++++++++++++++---
> >  include/net/mana/gdma.h                       |   8 +-
> >  2 files changed, 211 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 2de42ce43373..f07cebffc30d 100644
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
> > +	if (!gic)
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
> > +	if (!gic)
> > +		return;
> 
> If xa_load() doesn't return a valid gic, it seems like that would warrant a
> WARN_ON(), like the above case where the msix_index is out of range.
>

That makes sense, I will add this change
 
> > +
> >  	spin_lock_irqsave(&gic->lock, flags);
> >  	list_for_each_entry_rcu(eq, &gic->eq_list, entry) {
> >  		if (queue == eq) {
> > @@ -1329,29 +1343,96 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
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
> > +	bool skip_first_cpu = false;
> >  	int err, i = 0, j;
> 
> Initializing "i" to 0 is superfluous.  The "for" loop below does it.
>

noted
 
> > +	int *irqs, irq;
> > 
> >  	cpus_read_lock();
> > -	max_queues_per_port = num_online_cpus();
> > -	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> > -		max_queues_per_port = MANA_MAX_NUM_QUEUES;
> > 
> > -	/* Need 1 interrupt for the Hardware communication Channel (HWC) */
> > -	max_irqs = max_queues_per_port + 1;
> > +	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
> > +	if (!irqs) {
> > +		err = -ENOMEM;
> > +		goto free_irq_vector;
> > +	}
> > 
> > -	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> > -	if (nvec < 0) {
> > -		cpus_read_unlock();
> > -		return nvec;
> > +	for (i = 0; i < nvec; i++) {
> > +		gic = kcalloc(1, sizeof(struct gdma_irq_context), GFP_KERNEL);
> 
> kcalloc() with a constant 1 first argument is a bit unusual. Just use kzalloc() since
> there's no array here?
> 

sure, will make this change

> > +		if (!gic) {
> > +			err = -ENOMEM;
> > +			goto free_irq;
> > +		}
> > +		gic->handler = mana_gd_process_eq_events;
> > +		INIT_LIST_HEAD(&gic->eq_list);
> > +		spin_lock_init(&gic->lock);
> > +
> > +		snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
> > +			 i, pci_name(pdev));
> > +
> > +		/* one pci vector is already allocated for HWC */
> > +		irqs[i] = pci_irq_vector(pdev, i + 1);
> > +		if (irqs[i] < 0) {
> > +			err = irqs[i];
> > +			goto free_current_gic;
> > +		}
> > +
> > +		err = request_irq(irqs[i], mana_gd_intr, 0, gic->name, gic);
> > +		if (err)
> > +			goto free_current_gic;
> > +
> > +		xa_store(&gc->irq_contexts, i + 1, gic, GFP_KERNEL);
> >  	}
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
> 
> In the error case, this label is reached with "i" in two possible
> states. Case 1: It might be the index of the entry that failed due to
> the "goto free_current_gic" statements.  Case 2: It might be the
> index of one entry past all the successfully requested irqs, when the
> failure occurs on irq_setup() and the code does "goto free_irq".
> 
> > +	for (j = i; j >= 0; j--) {
> 
> So the "for" loop starts with "j" set to an index that doesn't
> exist (in Case 2 above), or an index that is only partially
> complete (Case 1 above).
> 
> And actually, local variable "j" isn't needed for this loop.
> It could just count down using "i".
> 
> > +		irq = pci_irq_vector(pdev, j);
> 
> This seems to be looking up the wrong irq vector. In the main
> loop earlier, the index to pci_irq_vector() is "i + 1" but there's
> no "+ 1" here.
> 
> > +		gic = xa_load(&gc->irq_contexts, j);
> > +		if (!gic)
> > +			continue;
> 
> So evidently it is expected that this xa_load() will fail
> the first time through this "j" loop.  In Case 1, the xa_store()
> was never done, and in Case 2, the index starts out one
> too big.
> 
> > +
> > +		irq_update_affinity_hint(irq, NULL);
> > +		free_irq(irq, gic);
> > +		xa_erase(&gc->irq_contexts, j);
> > +		kfree(gic);
> > +	}
> 
> Except for the wrong index to pci_irq_vector(), I think this works,
> but it's a bit bizarre. More natural would be to initialize "j" to
> "i - 1" so that the first iteration through the loop isn't degenerate.
> In that case, all the calls to xa_load() should succeed, and you
> might put a WARN_ON() if there's a failure.
>

Okay, I think I get your point. Let me try to make this error handling
more intuitive and straight forward.
 
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
> > +	int start_irq_index = 1;
> > +	unsigned int cpu;
> > +	int *irqs, irq;
> > +	int err, i = 0, j;
> 
> Initializing "i" to 0 is superfluous.
> 

Noted

> > +
> > +	cpus_read_lock();
> > +
> >  	if (nvec <= num_online_cpus())
> >  		start_irq_index = 0;
> > 
> > @@ -1361,15 +1442,13 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  		goto free_irq_vector;
> >  	}
> > 
> > -	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
> > -				   GFP_KERNEL);
> > -	if (!gc->irq_contexts) {
> > -		err = -ENOMEM;
> > -		goto free_irq_array;
> > -	}
> > -
> >  	for (i = 0; i < nvec; i++) {
> > -		gic = &gc->irq_contexts[i];
> > +		gic = kcalloc(1, sizeof(struct gdma_irq_context), GFP_KERNEL);
> 
> kcalloc() with a constant 1 first argument is a bit unusual. Just use kzalloc() since
> there's no array here?
>

noted
 
> > +		if (!gic) {
> > +			err = -ENOMEM;
> > +			goto free_irq;
> > +		}
> > +
> >  		gic->handler = mana_gd_process_eq_events;
> >  		INIT_LIST_HEAD(&gic->eq_list);
> >  		spin_lock_init(&gic->lock);
> > @@ -1384,13 +1463,13 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  		irq = pci_irq_vector(pdev, i);
> >  		if (irq < 0) {
> >  			err = irq;
> > -			goto free_irq;
> > +			goto free_current_gic;
> >  		}
> > 
> >  		if (!i) {
> >  			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> >  			if (err)
> > -				goto free_irq;
> > +				goto free_current_gic;
> > 
> >  			/* If number of IRQ is one extra than number of online CPUs,
> >  			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> > @@ -1408,39 +1487,110 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  			}
> >  		} else {
> >  			irqs[i - start_irq_index] = irq;
> > -			err = request_irq(irqs[i - start_irq_index], mana_gd_intr, 0,
> > -					  gic->name, gic);
> > +			err = request_irq(irqs[i - start_irq_index],
> > +					  mana_gd_intr, 0, gic->name, gic);
> >  			if (err)
> > -				goto free_irq;
> > +				goto free_current_gic;
> >  		}
> > +
> > +		xa_store(&gc->irq_contexts, i, gic, GFP_KERNEL);
> >  	}
> 
> FWIW, I think all this logic around "start_irq_index" could be simplified,
> though I haven't worked through the details. If it would simplify the code,
> it would be fine to allocate the "irqs" array with one extra entry that is unused
> if IRQ0 and IRQ1 use the same CPUs.
>

Sure, let me try that
 
> > 
> >  	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node, false);
> >  	if (err)
> >  		goto free_irq;
> > 
> > -	gc->max_num_msix = nvec;
> > -	gc->num_msix_usable = nvec;
> >  	cpus_read_unlock();
> >  	kfree(irqs);
> >  	return 0;
> > 
> > +free_current_gic:
> > +	kfree(gic);
> >  free_irq:
> >  	for (j = i - 1; j >= 0; j--) {
> 
> In this case j is initialized to i - 1, which is what I expected in 
> the previous case.
> 
> Again, this loop could just countdown using "i" instead of
> introducing "j".
> 
> >  		irq = pci_irq_vector(pdev, j);
> > -		gic = &gc->irq_contexts[j];
> > +		gic = xa_load(&gc->irq_contexts, j);
> > +		if (!gic)
> > +			continue;
> 
> Failure to get a valid gic should never happen, so perhaps a WARN_ON()
> is appropriate.
>

noted
 
> > 
> >  		irq_update_affinity_hint(irq, NULL);
> >  		free_irq(irq, gic);
> > +		xa_erase(&gc->irq_contexts, j);
> > +		kfree(gic);
> >  	}
> > 
> > -	kfree(gc->irq_contexts);
> > -	gc->irq_contexts = NULL;
> > -free_irq_array:
> >  	kfree(irqs);
> >  free_irq_vector:
> > +	xa_destroy(&gc->irq_contexts);
> 
> This seems like the wrong place to be doing xa_destroy(). It leads
> to inconsistencies. For example, if mana_gd_setup_hwc_irqs()
> fails, it may have failed before calling mana_gd_setup_irqs(), in
> which case the xa_destroy() is not done. Or if the failure occurred here
> in mana_gd_setup_irqs(), then xa_destroy() will have been done.
> Ideally, the xa_destroy() for error cases could be done in
> mana_gd_probe() where the xa_init() is done so that the calls match
> up, and of course in mana_gd_remove() when the device goes away
> entirely.
>

I agree, I'll fix this
 
> >  	cpus_read_unlock();
> > -	pci_free_irq_vectors(pdev);
> > +	return err;
> > +}
> > +
> > +static int mana_gd_setup_hwc_irqs(struct pci_dev *pdev)
> > +{
> > +	struct gdma_context *gc = pci_get_drvdata(pdev);
> > +	unsigned int max_irqs, min_irqs;
> > +	int max_queues_per_port;
> > +	int nvec, err;
> > +
> > +	if (pci_msix_can_alloc_dyn(pdev)) {
> > +		max_irqs = 1;
> > +		min_irqs = 1;
> > +	} else {
> > +		max_queues_per_port = num_online_cpus();
> > +		if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> > +			max_queues_per_port = MANA_MAX_NUM_QUEUES;
> > +		/* Need 1 interrupt for HWC */
> > +		max_irqs = max_queues_per_port + 1;
> 
> This code is simply being copied from existing code, but it would be nicer to
> code it as:
> 
> 		max_irqs = min(num_online_cpus(), MANA_MAX_NUM_QUEUES) + 1; 
> 
> Explicitly using the "min" function reduces the cognitive effort to parse
> the "if" statement and figure out that it is picking the minimum of the two
> values. And the local variable max_queues_per_port can be dropped, but
> keep the comment :-)
> 

noted

> > +		min_irqs = 2;
> > +	}
> > +
> > +	nvec = pci_alloc_irq_vectors(pdev, min_irqs, max_irqs, PCI_IRQ_MSIX);
> > +	if (nvec < 0)
> > +		return nvec;
> > +
> > +	err = mana_gd_setup_irqs(pdev, nvec);
> > +	if (err) {
> > +		pci_free_irq_vectors(pdev);
> > +		return err;
> > +	}
> > +
> > +	gc->num_msix_usable = nvec;
> > +	gc->max_num_msix = nvec;
> > +
> > +	return err;
> 
> "err" should always be zero at this point, so could do "return 0"
>

noted
 
> > +}
> > +
> > +static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev)
> > +{
> > +	struct gdma_context *gc = pci_get_drvdata(pdev);
> > +	int max_irqs, i, err = 0;
> > +	struct msi_map irq_map;
> > +
> > +	if (!pci_msix_can_alloc_dyn(pdev))
> > +		/* remain irqs are already allocated with HWC IRQ */
> > +		return 0;
> > +
> > +	/* allocate only remaining IRQs*/
> > +	max_irqs = gc->num_msix_usable - 1;
> > +
> > +	for (i = 1; i <= max_irqs; i++) {
> > +		irq_map = pci_msix_alloc_irq_at(pdev, i, NULL);
> > +		if (!irq_map.virq) {
> > +			err = irq_map.index;
> > +			/* caller will handle cleaning up all allocated
> > +			 * irqs, after HWC is destroyed
> > +			 */
> > +			return err;
> > +		}
> > +	}
> > +
> > +	err = mana_gd_setup_dyn_irqs(pdev, max_irqs);
> > +	if (err)
> > +		return err;
> > +
> > +	gc->max_num_msix = gc->max_num_msix + max_irqs;
> > +
> >  	return err;
> 
> Again, err must always be zero here.
> 
> >  }
> > 
> > @@ -1458,19 +1608,22 @@ static void mana_gd_remove_irqs(struct pci_dev *pdev)
> >  		if (irq < 0)
> >  			continue;
> > 
> > -		gic = &gc->irq_contexts[i];
> > +		gic = xa_load(&gc->irq_contexts, i);
> > +		if (!gic)
> > +			continue;
> > 
> >  		/* Need to clear the hint before free_irq */
> >  		irq_update_affinity_hint(irq, NULL);
> >  		free_irq(irq, gic);
> > +		xa_erase(&gc->irq_contexts, i);
> > +		kfree(gic);
> >  	}
> > 
> >  	pci_free_irq_vectors(pdev);
> > 
> >  	gc->max_num_msix = 0;
> >  	gc->num_msix_usable = 0;
> > -	kfree(gc->irq_contexts);
> > -	gc->irq_contexts = NULL;
> > +	xa_destroy(&gc->irq_contexts);
> 
> As noted above, I'm doubtful about this being the right place to do
> xa_destroy().
> 
> >  }
> > 
> >  static int mana_gd_setup(struct pci_dev *pdev)
> > @@ -1481,9 +1634,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
> >  	mana_gd_init_registers(pdev);
> >  	mana_smc_init(&gc->shm_channel, gc->dev, gc->shm_base);
> > 
> > -	err = mana_gd_setup_irqs(pdev);
> > +	err = mana_gd_setup_hwc_irqs(pdev);
> >  	if (err) {
> > -		dev_err(gc->dev, "Failed to setup IRQs: %d\n", err);
> > +		dev_err(gc->dev, "Failed to setup IRQs for HWC creation: %d\n",
> > +			err);
> >  		return err;
> >  	}
> > 
> > @@ -1499,6 +1653,12 @@ static int mana_gd_setup(struct pci_dev *pdev)
> >  	if (err)
> >  		goto destroy_hwc;
> > 
> > +	err = mana_gd_setup_remaining_irqs(pdev);
> > +	if (err) {
> > +		dev_err(gc->dev, "Failed to setup remaining IRQs: %d", err);
> > +		goto destroy_hwc;
> > +	}
> > +
> >  	err = mana_gd_detect_devices(pdev);
> >  	if (err)
> >  		goto destroy_hwc;
> > @@ -1575,6 +1735,7 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct
> > pci_device_id *ent)
> >  	gc->is_pf = mana_is_pf(pdev->device);
> >  	gc->bar0_va = bar0_va;
> >  	gc->dev = &pdev->dev;
> > +	xa_init(&gc->irq_contexts);
> > 
> >  	if (gc->is_pf)
> >  		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
> > diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> > index 228603bf03f2..f20d1d1ea5e8 100644
> > --- a/include/net/mana/gdma.h
> > +++ b/include/net/mana/gdma.h
> > @@ -373,7 +373,7 @@ struct gdma_context {
> >  	unsigned int		max_num_queues;
> >  	unsigned int		max_num_msix;
> >  	unsigned int		num_msix_usable;
> > -	struct gdma_irq_context	*irq_contexts;
> > +	struct xarray		irq_contexts;
> > 
> >  	/* L2 MTU */
> >  	u16 adapter_mtu;
> > @@ -558,12 +558,16 @@ enum {
> >  /* Driver can handle holes (zeros) in the device list */
> >  #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
> > 
> > +/* Driver supports dynamic MSI-X vector allocation */
> > +#define GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT BIT(13)
> > +
> >  #define GDMA_DRV_CAP_FLAGS1 \
> >  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
> >  	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
> >  	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
> >  	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
> > -	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
> > +	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
> > +	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT)
> > 
> >  #define GDMA_DRV_CAP_FLAGS2 0
> > 
> > --
> > 2.34.1
> > 
> 

Thanks for all the comments Michael, I will have them all incorporated
in the next version.


