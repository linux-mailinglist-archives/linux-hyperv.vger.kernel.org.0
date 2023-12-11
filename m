Return-Path: <linux-hyperv+bounces-1308-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8477B80C16D
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Dec 2023 07:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C7D1C2084E
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Dec 2023 06:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321F41D69A;
	Mon, 11 Dec 2023 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QCT+HK0W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0330495;
	Sun, 10 Dec 2023 22:37:27 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 6431220B74C0; Sun, 10 Dec 2023 22:37:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6431220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702276646;
	bh=plvwsq/k0bUEpqQI6kSEXAfkzMO9ufErkwbSyDLrpro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCT+HK0WSXxvxXDdsu/zd+ld9FUITryrxN2I5Z9hNlGE35pZ4vvppuFLwgx3WEiQl
	 r55nPqP7tFwaoYlYWi5Abi3+0mAITnNoh5jeYFmriCA5tM1xp/dLDV3dwLs1m1uEST
	 OnGHIuAPqD98a/CJnitIldsExxy0rGQ0qhjwCtGA=
Date: Sun, 10 Dec 2023 22:37:26 -0800
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
Message-ID: <20231211063726.GA4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Dec 08, 2023 at 06:03:39AM -0800, Yury Norov wrote:
> On Fri, Dec 08, 2023 at 02:02:34AM -0800, Souradeep Chakrabarti wrote:
> > Existing MANA design assigns IRQ to every CPU, including sibling
> > hyper-threads. This may cause multiple IRQs to be active simultaneously
> > in the same core and may reduce the network performance with RSS.
> 
> Can you add an IRQ distribution diagram to compare before/after
> behavior, similarly to what I did in the other email?
> 
Let's consider this topology:

Node            0               1
Core        0       1       2       3
CPU       0   1   2   3   4   5   6   7

 Before  
 IRQ     Nodes   Cores   CPUs
 0       1       0       0
 1       1       1       2
 2       1       0       1
 3       1       1       3
 4       2       2       4
 5       2       3       6
 6       2       2       5
 7       2       3       7
 
 Now
 IRQ     Nodes   Cores   CPUs
 0       1       0       0-1
 1       1       1       2-3
 2       1       0       0-1
 3       1       1       2-3
 4       2       2       4-5
 5       2       3       6-7
 6       2       2       4-5
 7       2       3       6-7
> > Improve the performance by assigning IRQ to non sibling CPUs in local
> > NUMA node. The performance improvement we are getting using ntttcp with
> > following patch is around 15 percent with existing design and approximately
> > 11 percent, when trying to assign one IRQ in each core across NUMA nodes,
> > if enough cores are present.
> 
> How did you measure it? In the other email you said you used perf, can
> you show your procedure in details?
I have used ntttcp for performance analysis, by perf I had meant performance
analysis. I have used ntttcp with following parameters
ntttcp -r -m 64 <receiver> 

ntttcp -s <receiver side ip address>  -m 64 <sender>
Both the VMs are in same Azure subnet and private IP address is used.
MTU and tcp buffer is set accordingly and number of channels are set using ethtool
accordingly for best performance. Also irqbalance was disabled.
https://github.com/microsoft/ntttcp-for-linux
https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-bandwidth-testing?tabs=linux

> 
> > Suggested-by: Yury Norov <yury.norov@gmali.com>
> > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > ---
> 
> [...]
> 
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 92 +++++++++++++++++--
> >  1 file changed, 83 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 6367de0c2c2e..18e8908c5d29 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -1243,15 +1243,56 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> >  	r->size = 0;
> >  }
> >  
> > +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> > +{
> > +	int w, cnt, cpu, err = 0, i = 0;
> > +	int next_node = start_numa_node;
> 
> What for this?
This is the local numa node, from where to start hopping.
Please see how we are calling irq_setup(). We are passing the array of allocated irqs, total
number of irqs allocated, and the local numa node to the device.
> 
> > +	const struct cpumask *next, *prev = cpu_none_mask;
> > +	cpumask_var_t curr, cpus;
> > +
> > +	if (!zalloc_cpumask_var(&curr, GFP_KERNEL)) {
> > +		err = -ENOMEM;
> > +		return err;
> > +	}
> > +	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL)) {
> 
>                 free(curr);
Will fix it in next version. Thanks for pointing.
> 
> > +		err = -ENOMEM;
> > +		return err;
> > +	}
> > +
> > +	rcu_read_lock();
> > +	for_each_numa_hop_mask(next, next_node) {
> > +		cpumask_andnot(curr, next, prev);
> > +		for (w = cpumask_weight(curr), cnt = 0; cnt < w; ) {
> > +			cpumask_copy(cpus, curr);
> > +			for_each_cpu(cpu, cpus) {
> > +				irq_set_affinity_and_hint(irqs[i], topology_sibling_cpumask(cpu));
> > +				if (++i == nvec)
> > +					goto done;
> 
> Think what if you're passed with irq_setup(NULL, 0, 0).
> That's why I suggested to place this check at the beginning.
> 
irq_setup() is a helper function for mana_gd_setup_irqs(), which already takes
care of no NULL pointer for irqs, and 0 number of interrupts can not be passed.

nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
if (nvec < 0)
	return nvec;
> 
> > +				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> > +				++cnt;
> > +			}
> > +		}
> > +		prev = next;
> > +	}
> > +done:
> > +	rcu_read_unlock();
> > +	free_cpumask_var(curr);
> > +	free_cpumask_var(cpus);
> > +	return err;
> > +}
> > +
> >  static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  {
> > -	unsigned int max_queues_per_port = num_online_cpus();
> >  	struct gdma_context *gc = pci_get_drvdata(pdev);
> > +	unsigned int max_queues_per_port;
> >  	struct gdma_irq_context *gic;
> >  	unsigned int max_irqs, cpu;
> > -	int nvec, irq;
> > +	int start_irq_index = 1;
> > +	int nvec, *irqs, irq;
> >  	int err, i = 0, j;
> >  
> > +	cpus_read_lock();
> > +	max_queues_per_port = num_online_cpus();
> >  	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> >  		max_queues_per_port = MANA_MAX_NUM_QUEUES;
> >  
> > @@ -1261,6 +1302,14 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> >  	if (nvec < 0)
> >  		return nvec;
> > +	if (nvec <= num_online_cpus())
> > +		start_irq_index = 0;
> > +
> > +	irqs = kmalloc_array((nvec - start_irq_index), sizeof(int), GFP_KERNEL);
> > +	if (!irqs) {
> > +		err = -ENOMEM;
> > +		goto free_irq_vector;
> > +	}
> >  
> >  	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
> >  				   GFP_KERNEL);
> > @@ -1287,21 +1336,44 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  			goto free_irq;
> >  		}
> >  
> > -		err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> > -		if (err)
> > -			goto free_irq;
> > -
> > -		cpu = cpumask_local_spread(i, gc->numa_node);
> > -		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> > +		if (!i) {
> > +			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> > +			if (err)
> > +				goto free_irq;
> > +
> > +			/* If number of IRQ is one extra than number of online CPUs,
> > +			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> > +			 * same CPU.
> > +			 * Else we will use different CPUs for IRQ0 and IRQ1.
> > +			 * Also we are using cpumask_local_spread instead of
> > +			 * cpumask_first for the node, because the node can be
> > +			 * mem only.
> > +			 */
> > +			if (start_irq_index) {
> > +				cpu = cpumask_local_spread(i, gc->numa_node);
> 
> I already mentioned that: if i == 0, you don't need to spread, just
> pick 1st cpu from node.
The reason I have picked cpumask_local_spread here, is that, the gc->numa_node 
can be a memory only node, in that case we need to jump to next node to get the CPU.
Which cpumask_local_spread() using sched_numa_find_nth_cpu() takes care off.
> 
> > +				irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> > +			} else {
> > +				irqs[start_irq_index] = irq;
> > +			}
> > +		} else {
> > +			irqs[i - start_irq_index] = irq;
> > +			err = request_irq(irqs[i - start_irq_index], mana_gd_intr, 0,
> > +					  gic->name, gic);
> > +			if (err)
> > +				goto free_irq;
> > +		}
> >  	}
> >  
> > +	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
> > +	if (err)
> > +		goto free_irq;
> >  	err = mana_gd_alloc_res_map(nvec, &gc->msix_resource);
> >  	if (err)
> >  		goto free_irq;
> >  
> >  	gc->max_num_msix = nvec;
> >  	gc->num_msix_usable = nvec;
> > -
> > +	cpus_read_unlock();
> >  	return 0;
> >  
> >  free_irq:
> > @@ -1314,8 +1386,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  	}
> >  
> >  	kfree(gc->irq_contexts);
> > +	kfree(irqs);
> >  	gc->irq_contexts = NULL;
> >  free_irq_vector:
> > +	cpus_read_unlock();
> >  	pci_free_irq_vectors(pdev);
> >  	return err;
> >  }
> > -- 
> > 2.34.1

