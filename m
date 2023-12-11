Return-Path: <linux-hyperv+bounces-1309-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2FC80C189
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Dec 2023 07:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0728280ACA
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Dec 2023 06:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4DD1F60A;
	Mon, 11 Dec 2023 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KbwpxtwC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1772D6;
	Sun, 10 Dec 2023 22:53:23 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 44E2C20B74C0; Sun, 10 Dec 2023 22:53:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44E2C20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702277603;
	bh=IUIp4qRLj+juSM9lSpE7OLc2jm7lTxH+OyQdVrgOx4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KbwpxtwC9323VClNsiQswbDFe/4uaJJl13iaxLQO8xwCtlBQnV8vVxNCW/XyU6KbF
	 wxhnkFwgvejwsC3SZerZo9v6s5SkFMkHk0f1ln0I0KKyJ90x+ukDlr4QS5pxx6D2Bq
	 BptKAhbmgMKsvRxo6c3Dp1ZPsehoWPu9+jcRewGo=
Date: Sun, 10 Dec 2023 22:53:23 -0800
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	schakrabarti@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH V5 net-next] net: mana: Assigning IRQ affinity on HT cores
Message-ID: <20231211065323.GB4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
 <ZXOQb+3R0YAT/rAm@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXOQb+3R0YAT/rAm@yury-ThinkPad>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Dec 08, 2023 at 01:53:51PM -0800, Yury Norov wrote:
> Few more nits
> 
> On Fri, Dec 08, 2023 at 06:03:40AM -0800, Yury Norov wrote:
> > On Fri, Dec 08, 2023 at 02:02:34AM -0800, Souradeep Chakrabarti wrote:
> > > Existing MANA design assigns IRQ to every CPU, including sibling
> > > hyper-threads. This may cause multiple IRQs to be active simultaneously
> > > in the same core and may reduce the network performance with RSS.
> > 
> > Can you add an IRQ distribution diagram to compare before/after
> > behavior, similarly to what I did in the other email?
> > 
> > > Improve the performance by assigning IRQ to non sibling CPUs in local
> > > NUMA node. The performance improvement we are getting using ntttcp with
> > > following patch is around 15 percent with existing design and approximately
> > > 11 percent, when trying to assign one IRQ in each core across NUMA nodes,
> > > if enough cores are present.
> > 
> > How did you measure it? In the other email you said you used perf, can
> > you show your procedure in details?
> > 
> > > Suggested-by: Yury Norov <yury.norov@gmali.com>
> > > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > > ---
> > 
> > [...]
> > 
> > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 92 +++++++++++++++++--
> > >  1 file changed, 83 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > index 6367de0c2c2e..18e8908c5d29 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > @@ -1243,15 +1243,56 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> > >  	r->size = 0;
> > >  }
> > >  
> > > +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> > > +{
> > > +	int w, cnt, cpu, err = 0, i = 0;
> > > +	int next_node = start_numa_node;
> > 
> > What for this?
> > 
> > > +	const struct cpumask *next, *prev = cpu_none_mask;
> > > +	cpumask_var_t curr, cpus;
> > > +
> > > +	if (!zalloc_cpumask_var(&curr, GFP_KERNEL)) {
> 
> alloc_cpumask_var() here and below, because you initialize them by
> copying
I have used zalloc here as prev gets initialized after the first hop, before that
it may contain unwanted values, which may impact cpumask_andnot(curr, next, prev).
Regarding curr I will change it to alloc_cpumask_var().
Please let me know if that sounds right.
> 
> > > +		err = -ENOMEM;
> > > +		return err;
> > > +	}
> > > +	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL)) {
> > 
> >                 free(curr);
> > 
> > > +		err = -ENOMEM;
> > > +		return err;
> > > +	}
> > > +
> > > +	rcu_read_lock();
> > > +	for_each_numa_hop_mask(next, next_node) {
> > > +		cpumask_andnot(curr, next, prev);
> > > +		for (w = cpumask_weight(curr), cnt = 0; cnt < w; ) {
> 
> OK, if you can't increment inside for-loop, I'd switch it to a
> while-loop:
>                 w = cpumask_weight(curr);
>                 cnt = 0;
> 
Thanks will change it to while loop.
> 		while (cnt < w) {
> 
> > > +			cpumask_copy(cpus, curr);
> > > +			for_each_cpu(cpu, cpus) {
> > > +				irq_set_affinity_and_hint(irqs[i], topology_sibling_cpumask(cpu));
> > > +				if (++i == nvec)
> > > +					goto done;
> > 
> > Think what if you're passed with irq_setup(NULL, 0, 0).
> > That's why I suggested to place this check at the beginning.
> > 
> > 
> > > +				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> > > +				++cnt;
> > > +			}
> > > +		}
> > > +		prev = next;
> > > +	}
> 
> Don't hesitate to add even more vertical spacing. It's like: "take a
> breath folks, this section is done". :)
> 
Sure will add in next version.
> > > +done:
> > > +	rcu_read_unlock();
> > > +	free_cpumask_var(curr);
> > > +	free_cpumask_var(cpus);
> > > +	return err;
> > > +}
> > > +
> > >  static int mana_gd_setup_irqs(struct pci_dev *pdev)
> > >  {
> > > -	unsigned int max_queues_per_port = num_online_cpus();
> > >  	struct gdma_context *gc = pci_get_drvdata(pdev);
> > > +	unsigned int max_queues_per_port;
> > >  	struct gdma_irq_context *gic;
> > >  	unsigned int max_irqs, cpu;
> > > -	int nvec, irq;
> > > +	int start_irq_index = 1;
> > > +	int nvec, *irqs, irq;
> > >  	int err, i = 0, j;
> > >  
> > > +	cpus_read_lock();
> > > +	max_queues_per_port = num_online_cpus();
> > >  	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> > >  		max_queues_per_port = MANA_MAX_NUM_QUEUES;
> > >  
> > > @@ -1261,6 +1302,14 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> > >  	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> > >  	if (nvec < 0)
> > >  		return nvec;
> > > +	if (nvec <= num_online_cpus())
> > > +		start_irq_index = 0;
> > > +
> > > +	irqs = kmalloc_array((nvec - start_irq_index), sizeof(int), GFP_KERNEL);
> > > +	if (!irqs) {
> > > +		err = -ENOMEM;
> > > +		goto free_irq_vector;
> > > +	}
> > >  
> > >  	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
> > >  				   GFP_KERNEL);
> > > @@ -1287,21 +1336,44 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> > >  			goto free_irq;
> > >  		}
> > >  
> > > -		err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> > > -		if (err)
> > > -			goto free_irq;
> > > -
> > > -		cpu = cpumask_local_spread(i, gc->numa_node);
> > > -		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> > > +		if (!i) {
> > > +			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> > > +			if (err)
> > > +				goto free_irq;
> > > +
> > > +			/* If number of IRQ is one extra than number of online CPUs,
> > > +			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> > > +			 * same CPU.
> > > +			 * Else we will use different CPUs for IRQ0 and IRQ1.
> > > +			 * Also we are using cpumask_local_spread instead of
> > > +			 * cpumask_first for the node, because the node can be
> > > +			 * mem only.
> > > +			 */
> > > +			if (start_irq_index) {
> > > +				cpu = cpumask_local_spread(i, gc->numa_node);
> > 
> > I already mentioned that: if i == 0, you don't need to spread, just
> > pick 1st cpu from node.
> > 
> > > +				irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> > > +			} else {
> > > +				irqs[start_irq_index] = irq;
> > > +			}
> > > +		} else {
> > > +			irqs[i - start_irq_index] = irq;
> > > +			err = request_irq(irqs[i - start_irq_index], mana_gd_intr, 0,
> > > +					  gic->name, gic);
> > > +			if (err)
> > > +				goto free_irq;
> > > +		}
> > >  	}
> > >  
> > > +	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
> > > +	if (err)
> > > +		goto free_irq;
> > >  	err = mana_gd_alloc_res_map(nvec, &gc->msix_resource);
> > >  	if (err)
> > >  		goto free_irq;
> > >  
> > >  	gc->max_num_msix = nvec;
> > >  	gc->num_msix_usable = nvec;
> > > -
> > > +	cpus_read_unlock();
> > >  	return 0;
> > >  
> > >  free_irq:
> > > @@ -1314,8 +1386,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> > >  	}
> > >  
> > >  	kfree(gc->irq_contexts);
> > > +	kfree(irqs);
> > >  	gc->irq_contexts = NULL;
> > >  free_irq_vector:
> > > +	cpus_read_unlock();
> > >  	pci_free_irq_vectors(pdev);
> > >  	return err;
> > >  }
> > > -- 
> > > 2.34.1

