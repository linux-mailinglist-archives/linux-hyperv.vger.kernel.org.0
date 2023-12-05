Return-Path: <linux-hyperv+bounces-1202-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B16A80516D
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 12:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314B328142C
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA584C63F;
	Tue,  5 Dec 2023 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OxTUsQE/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7359F11F;
	Tue,  5 Dec 2023 03:01:39 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id D05B820B74C0; Tue,  5 Dec 2023 03:01:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D05B820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701774098;
	bh=GsHAagPrkVzK5MMXoA+rCitnNZnBfvTsUscahErxJ+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxTUsQE/l55VpHHuoETMIIiTQ9P3eXzRuFvbMIpJMFnvPXyRQZALjqshXPtlSwsrf
	 lmqw9kPm3C0+TGRLbAGMVJayOcG2eoSKJEM76jK8iTE7jm8/9v7gUbKtI2XwHskYUL
	 1voMo98zUfGMlmXN0U0M4y+KUx0j/TZt61LZVG4k=
Date: Tue, 5 Dec 2023 03:01:38 -0800
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	sch^Crabarti@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH V4 net-next] net: mana: Assigning IRQ affinity on HT cores
Message-ID: <20231205110138.GA31232@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1701679841-9359-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZW3om2dfA4U0lhVY@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW3om2dfA4U0lhVY@yury-ThinkPad>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Dec 04, 2023 at 06:56:27AM -0800, Yury Norov wrote:
> On Mon, Dec 04, 2023 at 12:50:41AM -0800, Souradeep Chakrabarti wrote:
> > Existing MANA design assigns IRQ to every CPU, including sibling
> > hyper-threads. This may cause multiple IRQs to be active simultaneously
> > in the same core and may reduce the network performance with RSS.
> > 
> > Improve the performance by assigning IRQ to non sibling CPUs in local
> > NUMA node.
> > 
> > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > ---
> > V3 -> V4:
> > * Used for_each_numa_hop_mask() macro and simplified the code.
> > Thanks to Yury Norov for the suggestion.
> 
> We've got a special tag for this:
> 
> Suggested-by: Yury Norov <yury.norov@gmali.com>
> 
> > * Added code to assign hwc irq separately in mana_gd_setup_irqs.
> > 
> > V2 -> V3:
> > * Created a helper function to get the next NUMA with CPU.
> > * Added some error checks for unsuccessful memory allocation.
> > * Fixed some comments on the code.
> > 
> > V1 -> V2:
> > * Simplified the code by removing filter_mask_list and using avail_cpus.
> > * Addressed infinite loop issue when there are numa nodes with no CPUs.
> > * Addressed uses of local numa node instead of 0 to start.
> > * Removed uses of BUG_ON.
> > * Placed cpus_read_lock in parent function to avoid num_online_cpus
> >   to get changed before function finishes the affinity assignment.
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 70 +++++++++++++++++--
> >  1 file changed, 63 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 6367de0c2c2e..2194a53cce10 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -1243,15 +1243,57 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> >  	r->size = 0;
> >  }
> >  
> > +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> > +{
> > +	int i = 0, cpu, err = 0;
> > +	const struct cpumask *node_cpumask;
> > +	unsigned int  next_node = start_numa_node;
> > +	cpumask_var_t visited_cpus, node_cpumask_temp;
> > +
> > +	if (!zalloc_cpumask_var(&visited_cpus, GFP_KERNEL)) {
> > +		err = ENOMEM;
> > +		return err;
> > +	}
> > +	if (!zalloc_cpumask_var(&node_cpumask_temp, GFP_KERNEL)) {
> > +		err = -ENOMEM;
> > +		return err;
> > +	}
> 
> Can you add a bit more of vertical spacing?
> 
> > +	rcu_read_lock();
> > +	for_each_numa_hop_mask(node_cpumask, next_node) {
> > +		cpumask_copy(node_cpumask_temp, node_cpumask);
> > +		for_each_cpu(cpu, node_cpumask_temp) {
> > +			cpumask_andnot(node_cpumask_temp, node_cpumask_temp,
> > +				       topology_sibling_cpumask(cpu));
> > +			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu));
> > +			if (++i == nvec)
> > +				goto free_mask;
> > +			cpumask_set_cpu(cpu, visited_cpus);
> > +			if (cpumask_empty(node_cpumask_temp)) {
> > +				cpumask_copy(node_cpumask_temp, node_cpumask);
> > +				cpumask_andnot(node_cpumask_temp, node_cpumask_temp,
> > +					       visited_cpus);
> > +				cpu = 0;
> > +			}
> 
> It feels like you can calculate number of sibling groups in a hop in
> advance, so that you'll know how many IRQs you want to assign per each
> hop, and avoid resetting the node_cpumask_temp and spinning in inner
> loop for more than once...
> 
> Can you print your topology, and describe how you want to spread IRQs
> on it, and how your existing code does spread them?
>
The topology of one system is
> numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
node 0 size: 459521 MB
node 0 free: 456316 MB
node 1 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118
119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143
144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168
169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
node 1 size: 459617 MB
node 1 free: 456864 MB
node distances:
node   0   1
  0:  10  21
  1:  21  10
and I want to spread the IRQs in numa0 node first with 
CPU0 - IRQ0
CPU2 - IRQ1
CPU4 - IRQ2
CPU6 - IRQ3
---
---
---
CPU94 - IRQ47
then
CPU1 - IRQ48
CPU3 - IRQ49
CPU32 - IRQ64

In a topology where NUMA0 has 20 cores and NUMA1 has 20 cores, with total 80 CPUS, there I want
CPU0 - IRQ0
CPU2 - IRQ1
CPU4 - IRQ2
---
---
---
CPU38 - IRQ19
Then
CPU1 - IRQ20
CPU3 - IRQ21
---
---
CPU39 - IRQ39
Node1
CPU40 - IRQ40
CPU42 - IRQ41
CPU44 - IRQ42
---
CPU78 - IRQ58
CPU41 - IRQ59
CPU43 - IRQ60
---
---
CPU49 - IRQ64
 

Exisitng code : 
https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/microsoft/mana/gdma_main.c#L1246

This uses cpumask_local_spread, so in a system where node has 64 cores, it spreads all 64+1 IRQs on
33 cores, rather than spreading it only on HT cores.

> Please add performance results in the commit message.
> 
> I feel like this may be a useful code for other kernel folks, and if
> so, we'd invest in it for more and make it a generic API, similar to
> cpumaks_local_spread()...
> 
> > +		}
> > +	}
> > +free_mask:
> > +	rcu_read_unlock();
> > +	free_cpumask_var(visited_cpus);
> > +	free_cpumask_var(node_cpumask_temp);
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
> > +	int nvec, *irqs, irq;
> >  	int err, i = 0, j;
> >  
> > +	cpus_read_lock();
> > +	max_queues_per_port = num_online_cpus();
> >  	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> >  		max_queues_per_port = MANA_MAX_NUM_QUEUES;
> >  
> > @@ -1261,6 +1303,11 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> >  	if (nvec < 0)
> >  		return nvec;
> > +	irqs = kmalloc_array(max_queues_per_port, sizeof(int), GFP_KERNEL);
> > +	if (!irqs) {
> > +		err = -ENOMEM;
> > +		goto free_irq_vector;
> > +	}
> >  
> >  	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
> >  				   GFP_KERNEL);
> > @@ -1287,21 +1334,28 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  			goto free_irq;
> >  		}
> >  
> > -		err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> > +		if (!i) {
> > +			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> > +			cpu = cpumask_local_spread(i, gc->numa_node);
> 
> If i == 0, you can simplify it because you just need the 1st CPU from
> a given node.
> 
> > +			irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> > +		} else {
> > +			irqs[i - 1] = irq;
> > +			err = request_irq(irqs[i - 1], mana_gd_intr, 0, gic->name, gic);
> > +		}
> >  		if (err)
> >  			goto free_irq;
> > -
> > -		cpu = cpumask_local_spread(i, gc->numa_node);
> > -		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> >  	}
> >  
> > +	err = irq_setup(irqs, max_queues_per_port, gc->numa_node);
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
> > @@ -1314,8 +1368,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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

