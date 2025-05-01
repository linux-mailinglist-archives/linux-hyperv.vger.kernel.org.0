Return-Path: <linux-hyperv+bounces-5284-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B4AA5FE3
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D31B7A2B47
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ADF1F1509;
	Thu,  1 May 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dsEO93aE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF9419F11B;
	Thu,  1 May 2025 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109437; cv=none; b=nd470FGxMXS7FUt1V539AnnbguMsSB2iLtPLEwEmH3dHieEgmIfh2pz2Nc2egEgOgF1U9BpDHLu1NrMHwzKDPEgybnmiAtC9L2zscM8SwPLSkZbydvoSw9siHGG1hjyaTgoTF29Mx7EP7gNs00l2+QuPuyCpIGsf1xM3vOl4sbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109437; c=relaxed/simple;
	bh=OWP52SvKZoaLb1ISFcwwFNNGGLF7Pl3pOJI3hvCqHtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTBNpCGgcFTQJj3jtJPBntkDxutM+g0RdrKZ89vjvXJohnNGrAuqW2+hOcv+Wh8XM9au914wuBfU5tNEDpDG0Kvb9EBxc8AsVwRkldbzE+/n28Noe/ELt36htCUeXJzabgp9xKIuAM/fI01sBNQrZxueeScXIF0ZMezm+5009jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dsEO93aE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 4705B21130BF; Thu,  1 May 2025 07:23:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4705B21130BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746109434;
	bh=AaoLfO+sk1i1be5q9cZMgUwQ1X3mZyxDPZHRRSNqaRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsEO93aEznK03qGDFrh72EGSc1qoqd32xgZ/AJ9aSZPMrjwnmiJvqlseZMFs9HOMl
	 bKmoV80XG3duvQRpVDHRhXCxVIEpoi1wy+utw1WYGz0cCbYA4/O+J+vCtOzUd+gK1g
	 9oEDBfaVNJBon9EtoGU4zf4e/tWq0kWB4rz4qHO8=
Date: Thu, 1 May 2025 07:23:54 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
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
	Krzysztof Wilczy?ski <kw@linux.com>,
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
	Peter Zijlstra <peterz@infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2 3/3] net: mana: Allocate MSI-X vectors dynamically as
 required
Message-ID: <20250501142354.GA6208@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1745578478-15195-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SN6PR02MB4157FF2CA8E37298FC634491D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157FF2CA8E37298FC634491D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, May 01, 2025 at 05:27:49AM +0000, Michael Kelley wrote:
> From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Friday, April 25, 2025 3:55 AM
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
> 
> I have a top-level thought about the data structures used to manage a
> dynamic number of MSI-X vectors. The current code allocates a fixed size
> array of struct gdma_irq_context, with one entry in the array for each
> MSI-X vector. To find the entry for a particular msi_index, the code can
> just index into the array, which is nice and simple.
> 
> The new code uses a linked list of struct gdma_irq_context entries, with
> one entry in the list for each MSI-X vector.  In the dynamic case, you can
> start with one entry in the list, and then add to the list however many
> additional entries the hardware will support.
> 
> But this additional linked list adds significant complexity to the code
> because it must be linearly searched to find the entry for a particular
> msi_index, and there's the messiness of putting entries onto the list
> and taking them off.  A spin lock is required.  Etc., etc.
> 
> Here's an intermediate approach that would be simpler. Allocate a fixed
> size array of pointers to struct gdma_irq_context. The fixed size is the
> maximum number of possible MSI-X vectors for the device, which I
> think is MANA_MAX_NUM_QUEUES, or 64 (correct me if I'm wrong
> about that). Allocate a new struct gdma_irq_context when needed,
> but store the address in the array rather than adding it onto a list.
> Code can then directly index into the array to access the entry.
> 
> Some entries in the array will be unused (and "wasted") if the device
> uses fewer MSI-X vector, but each unused entry is only 8 bytes. The
> max space unused is fewer than 512 bytes (assuming 64 entries in
> the array), which is neglible in the grand scheme of things. With the
> simpler code, and not having the additional list entry embedded in
> each struct gmda_irq_context, you'll get some of that space back
> anyway.
> 
> Maybe there's a reason for the list that I missed in my initial
> review of the code. But if not, it sure seems like the code could
> be simpler, and having some unused 8 bytes entries in the array
> is worth the tradeoff for the simplicity.
> 
> Michael

Hey  Michael,

Thanks for your inputs. We did think of this approach and in fact that
was how this patch was implemented(fixed size array) in the v1 of our
internal reviews. 

However, it came up in those reviews that we want to move away
from the 64(MANA_MAX_NUM_QUEUES) as a hard limit for some new
requirements, atleast for the dynamic IRQ allocation path. And now the
new limit for all hardening purposes would be num_online_cpus().

Using this limit and the fixed array size approach creates problems,
especially in machines with high number of vCPUs. It would lead to
quite a bit of memory/resource wastage.

Hence, we decided to go ahead with this design.

Regards,
Shradha.
> 
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
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
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 323 ++++++++++++++----
> >  include/net/mana/gdma.h                       |  11 +-
> >  2 files changed, 269 insertions(+), 65 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 4ffaf7588885..753b0208e574 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -6,6 +6,9 @@
> >  #include <linux/pci.h>
> >  #include <linux/utsname.h>
> >  #include <linux/version.h>
> > +#include <linux/msi.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/list.h>
> > 
> >  #include <net/mana/mana.h>
> > 
> > @@ -80,8 +83,15 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
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
> > @@ -462,12 +472,13 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
> >  				const struct gdma_queue_spec *spec)
> >  {
> >  	struct gdma_dev *gd = queue->gdma_dev;
> > -	struct gdma_irq_context *gic;
> > +	struct gdma_irq_context *gic = NULL;
> > +	unsigned long flags, flag_irq;
> >  	struct gdma_context *gc;
> >  	unsigned int msi_index;
> > -	unsigned long flags;
> > +	struct list_head *pos;
> >  	struct device *dev;
> > -	int err = 0;
> > +	int err = 0, count;
> > 
> >  	gc = gd->gdma_context;
> >  	dev = gc->dev;
> > @@ -482,7 +493,23 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
> >  	}
> > 
> >  	queue->eq.msix_index = msi_index;
> > -	gic = &gc->irq_contexts[msi_index];
> > +
> > +	/* get the msi_index value from the list*/
> > +	count = 0;
> > +	spin_lock_irqsave(&gc->irq_ctxs_lock, flag_irq);
> > +	list_for_each(pos, &gc->irq_contexts) {
> > +		if (count == msi_index) {
> > +			gic = list_entry(pos, struct gdma_irq_context,
> > +					 gic_list);
> > +			break;
> > +		}
> > +
> > +		count++;
> > +	}
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flag_irq);
> > +
> > +	if (!gic)
> > +		return -1;
> > 
> >  	spin_lock_irqsave(&gic->lock, flags);
> >  	list_add_rcu(&queue->entry, &gic->eq_list);
> > @@ -494,11 +521,13 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
> >  static void mana_gd_deregiser_irq(struct gdma_queue *queue)
> >  {
> >  	struct gdma_dev *gd = queue->gdma_dev;
> > -	struct gdma_irq_context *gic;
> > +	struct gdma_irq_context *gic = NULL;
> > +	unsigned long flags, flag_irq;
> >  	struct gdma_context *gc;
> >  	unsigned int msix_index;
> > -	unsigned long flags;
> > +	struct list_head *pos;
> >  	struct gdma_queue *eq;
> > +	int count;
> > 
> >  	gc = gd->gdma_context;
> > 
> > @@ -507,7 +536,23 @@ static void mana_gd_deregiser_irq(struct gdma_queue
> > *queue)
> >  	if (WARN_ON(msix_index >= gc->num_msix_usable))
> >  		return;
> > 
> > -	gic = &gc->irq_contexts[msix_index];
> > +	/* get the msi_index value from the list*/
> > +	count = 0;
> > +	spin_lock_irqsave(&gc->irq_ctxs_lock, flag_irq);
> > +	list_for_each(pos, &gc->irq_contexts) {
> > +		if (count == msix_index) {
> > +			gic = list_entry(pos, struct gdma_irq_context,
> > +					 gic_list);
> > +			break;
> > +		}
> > +
> > +		count++;
> > +	}
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flag_irq);
> > +
> > +	if (!gic)
> > +		return;
> > +
> >  	spin_lock_irqsave(&gic->lock, flags);
> >  	list_for_each_entry_rcu(eq, &gic->eq_list, entry) {
> >  		if (queue == eq) {
> > @@ -1288,7 +1333,8 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> >  	r->size = 0;
> >  }
> > 
> > -static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> > +static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> > +		     bool skip_first_cpu)
> >  {
> >  	const struct cpumask *next, *prev = cpu_none_mask;
> >  	cpumask_var_t cpus __free(free_cpumask_var);
> > @@ -1303,9 +1349,20 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int
> > node)
> >  		while (weight > 0) {
> >  			cpumask_andnot(cpus, next, prev);
> >  			for_each_cpu(cpu, cpus) {
> > +				/*
> > +				 * if the CPU sibling set is to be skipped we
> > +				 * just move on to the next CPUs without len--
> > +				 */
> > +				if (unlikely(skip_first_cpu)) {
> > +					skip_first_cpu = false;
> > +					goto next_cpumask;
> > +				}
> > +
> >  				if (len-- == 0)
> >  					goto done;
> > +
> >  				irq_set_affinity_and_hint(*irqs++,
> > topology_sibling_cpumask(cpu));
> > +next_cpumask:
> >  				cpumask_andnot(cpus, cpus,
> > topology_sibling_cpumask(cpu));
> >  				--weight;
> >  			}
> > @@ -1317,29 +1374,99 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int
> > node)
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
> > +	unsigned long flags;
> >  	int err, i = 0, j;
> > +	int *irqs, irq;
> > 
> >  	cpus_read_lock();
> > -	max_queues_per_port = num_online_cpus();
> > -	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> > -		max_queues_per_port = MANA_MAX_NUM_QUEUES;
> > +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> > +	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
> > +	if (!irqs) {
> > +		err = -ENOMEM;
> > +		goto free_irq_vector;
> > +	}
> > 
> > -	/* Need 1 interrupt for the Hardware communication Channel (HWC) */
> > -	max_irqs = max_queues_per_port + 1;
> > +	for (i = 0; i < nvec; i++) {
> > +		gic = kcalloc(1, sizeof(struct gdma_irq_context), GFP_KERNEL);
> > +		if (!gic) {
> > +			err = -ENOMEM;
> > +			goto free_irq;
> > +		}
> > +		gic->handler = mana_gd_process_eq_events;
> > +		INIT_LIST_HEAD(&gic->eq_list);
> > +		spin_lock_init(&gic->lock);
> > 
> > -	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> > -	if (nvec < 0) {
> > -		cpus_read_unlock();
> > -		return nvec;
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
> > +		list_add_tail(&gic->gic_list, &gc->irq_contexts);
> >  	}
> > +
> > +	/*
> > +	 * When calling irq_setup() for dynamically added IRQs, if number of
> > +	 * IRQs is more than or equal to allocated MSI-X, we need to skip the
> > +	 * first CPU sibling group since they are already affinitized to HWC IRQ
> > +	 */
> > +	if (gc->num_msix_usable <= num_online_cpus())
> > +		skip_first_cpu = true;
> > +
> > +	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
> > +	if (err)
> > +		goto free_irq;
> > +
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> > +	cpus_read_unlock();
> > +	kfree(irqs);
> > +	return 0;
> > +
> > +free_current_gic:
> > +	kfree(gic);
> > +free_irq:
> > +	for (j = i - 1; j >= 0; j--) {
> > +		irq = pci_irq_vector(pdev, j + 1);
> > +		gic = list_last_entry(&gc->irq_contexts,
> > +				      struct gdma_irq_context, gic_list);
> > +		irq_update_affinity_hint(irq, NULL);
> > +		free_irq(irq, gic);
> > +		list_del(&gic->gic_list);
> > +		kfree(gic);
> > +	}
> > +	kfree(irqs);
> > +free_irq_vector:
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> > +	cpus_read_unlock();
> > +	return err;
> > +}
> > +
> > +static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
> > +{
> > +	struct gdma_context *gc = pci_get_drvdata(pdev);
> > +	struct gdma_irq_context *gic;
> > +	int start_irq_index = 1;
> > +	unsigned long flags;
> > +	unsigned int cpu;
> > +	int *irqs, irq;
> > +	int err, i = 0, j;
> > +
> > +	cpus_read_lock();
> > +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> > +
> >  	if (nvec <= num_online_cpus())
> >  		start_irq_index = 0;
> > 
> > @@ -1349,15 +1476,12 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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
> > +		if (!gic) {
> > +			err = -ENOMEM;
> > +			goto free_irq;
> > +		}
> >  		gic->handler = mana_gd_process_eq_events;
> >  		INIT_LIST_HEAD(&gic->eq_list);
> >  		spin_lock_init(&gic->lock);
> > @@ -1372,22 +1496,14 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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
> > -
> > -			/* If number of IRQ is one extra than number of online CPUs,
> > -			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> > -			 * same CPU.
> > -			 * Else we will use different CPUs for IRQ0 and IRQ1.
> > -			 * Also we are using cpumask_local_spread instead of
> > -			 * cpumask_first for the node, because the node can be
> > -			 * mem only.
> > -			 */
> > +				goto free_current_gic;
> > +
> >  			if (start_irq_index) {
> >  				cpu = cpumask_local_spread(i, gc->numa_node);
> >  				irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> > @@ -1396,39 +1512,108 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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
> > +		list_add_tail(&gic->gic_list, &gc->irq_contexts);
> >  	}
> > 
> > -	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
> > +	err = irq_setup(irqs, nvec - start_irq_index, gc->numa_node, false);
> >  	if (err)
> >  		goto free_irq;
> > 
> > -	gc->max_num_msix = nvec;
> > -	gc->num_msix_usable = nvec;
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> >  	cpus_read_unlock();
> >  	kfree(irqs);
> >  	return 0;
> > 
> > +free_current_gic:
> > +	kfree(gic);
> >  free_irq:
> >  	for (j = i - 1; j >= 0; j--) {
> >  		irq = pci_irq_vector(pdev, j);
> > -		gic = &gc->irq_contexts[j];
> > -
> > +		gic = list_last_entry(&gc->irq_contexts,
> > +				      struct gdma_irq_context, gic_list);
> >  		irq_update_affinity_hint(irq, NULL);
> >  		free_irq(irq, gic);
> > +		list_del(&gic->gic_list);
> > +		kfree(gic);
> >  	}
> > -
> > -	kfree(gc->irq_contexts);
> > -	gc->irq_contexts = NULL;
> > -free_irq_array:
> >  	kfree(irqs);
> >  free_irq_vector:
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
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
> >  }
> > 
> > @@ -1436,29 +1621,34 @@ static void mana_gd_remove_irqs(struct pci_dev *pdev)
> >  {
> >  	struct gdma_context *gc = pci_get_drvdata(pdev);
> >  	struct gdma_irq_context *gic;
> > -	int irq, i;
> > +	struct list_head *pos, *n;
> > +	unsigned long flags;
> > +	int irq, i = 0;
> > 
> >  	if (gc->max_num_msix < 1)
> >  		return;
> > 
> > -	for (i = 0; i < gc->max_num_msix; i++) {
> > +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> > +	list_for_each_safe(pos, n, &gc->irq_contexts) {
> >  		irq = pci_irq_vector(pdev, i);
> >  		if (irq < 0)
> >  			continue;
> > 
> > -		gic = &gc->irq_contexts[i];
> > +		gic = list_entry(pos, struct gdma_irq_context, gic_list);
> > 
> >  		/* Need to clear the hint before free_irq */
> >  		irq_update_affinity_hint(irq, NULL);
> >  		free_irq(irq, gic);
> > +		list_del(pos);
> > +		kfree(gic);
> > +		i++;
> >  	}
> > +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> > 
> >  	pci_free_irq_vectors(pdev);
> > 
> >  	gc->max_num_msix = 0;
> >  	gc->num_msix_usable = 0;
> > -	kfree(gc->irq_contexts);
> > -	gc->irq_contexts = NULL;
> >  }
> > 
> >  static int mana_gd_setup(struct pci_dev *pdev)
> > @@ -1469,9 +1659,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
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
> > @@ -1487,6 +1678,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
> >  	if (err)
> >  		goto destroy_hwc;
> > 
> > +	err = mana_gd_setup_remaining_irqs(pdev);
> > +	if (err)
> > +		goto destroy_hwc;
> > +
> >  	err = mana_gd_detect_devices(pdev);
> >  	if (err)
> >  		goto destroy_hwc;
> > @@ -1563,6 +1758,8 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct
> > pci_device_id *ent)
> >  	gc->is_pf = mana_is_pf(pdev->device);
> >  	gc->bar0_va = bar0_va;
> >  	gc->dev = &pdev->dev;
> > +	INIT_LIST_HEAD(&gc->irq_contexts);
> > +	spin_lock_init(&gc->irq_ctxs_lock);
> > 
> >  	if (gc->is_pf)
> >  		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
> > diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> > index 228603bf03f2..6ef4785c63b4 100644
> > --- a/include/net/mana/gdma.h
> > +++ b/include/net/mana/gdma.h
> > @@ -363,6 +363,7 @@ struct gdma_irq_context {
> >  	spinlock_t lock;
> >  	struct list_head eq_list;
> >  	char name[MANA_IRQ_NAME_SZ];
> > +	struct list_head gic_list;
> >  };
> > 
> >  struct gdma_context {
> > @@ -373,7 +374,9 @@ struct gdma_context {
> >  	unsigned int		max_num_queues;
> >  	unsigned int		max_num_msix;
> >  	unsigned int		num_msix_usable;
> > -	struct gdma_irq_context	*irq_contexts;
> > +	struct list_head	irq_contexts;
> > +	/* Protect the irq_contexts list */
> > +	spinlock_t		irq_ctxs_lock;
> > 
> >  	/* L2 MTU */
> >  	u16 adapter_mtu;
> > @@ -558,12 +561,16 @@ enum {
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

