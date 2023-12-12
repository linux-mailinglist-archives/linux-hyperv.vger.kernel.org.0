Return-Path: <linux-hyperv+bounces-1320-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758FB80EA8A
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 12:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5C61F21B2A
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 11:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66295D4AD;
	Tue, 12 Dec 2023 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kpIwpmR9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 951AEEB;
	Tue, 12 Dec 2023 03:38:57 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 02E4520B74C0; Tue, 12 Dec 2023 03:38:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 02E4520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702381137;
	bh=WS1f3+n5rqfny6SDXg/YEJWd+skx1iiQQljAUqp4vgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpIwpmR9urFDwNBuUCLM7Oz6n6TwHSW4Oqin6l5yJ2dogdnxp4WAkc6UZTi0QQhvn
	 0tmvUxw7HhnRa1zW5D52hvSaLwEpQN/yn2KmRDCpmsCDbeSQHEqjda6WjU2JGwjKYI
	 sK8/SIYdtzBS+duibGfeVgFVLLg4vT8SpQcqsN74=
Date: Tue, 12 Dec 2023 03:38:56 -0800
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
Message-ID: <20231212113856.GA17123@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
 <20231211063726.GA4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZXcrHc5QGPTZtXKf@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXcrHc5QGPTZtXKf@yury-ThinkPad>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Dec 11, 2023 at 07:30:46AM -0800, Yury Norov wrote:
> On Sun, Dec 10, 2023 at 10:37:26PM -0800, Souradeep Chakrabarti wrote:
> > On Fri, Dec 08, 2023 at 06:03:39AM -0800, Yury Norov wrote:
> > > On Fri, Dec 08, 2023 at 02:02:34AM -0800, Souradeep Chakrabarti wrote:
> > > > Existing MANA design assigns IRQ to every CPU, including sibling
> > > > hyper-threads. This may cause multiple IRQs to be active simultaneously
> > > > in the same core and may reduce the network performance with RSS.
> > > 
> > > Can you add an IRQ distribution diagram to compare before/after
> > > behavior, similarly to what I did in the other email?
> > > 
> > Let's consider this topology:
> 
> Not here - in commit message, please.
Okay, will do that.
> 
> > 
> > Node            0               1
> > Core        0       1       2       3
> > CPU       0   1   2   3   4   5   6   7
> > 
> >  Before  
> >  IRQ     Nodes   Cores   CPUs
> >  0       1       0       0
> >  1       1       1       2
> >  2       1       0       1
> >  3       1       1       3
> >  4       2       2       4
> >  5       2       3       6
> >  6       2       2       5
> >  7       2       3       7
> >  
> >  Now
> >  IRQ     Nodes   Cores   CPUs
> >  0       1       0       0-1
> >  1       1       1       2-3
> >  2       1       0       0-1
> >  3       1       1       2-3
> >  4       2       2       4-5
> >  5       2       3       6-7
> >  6       2       2       4-5
> >  7       2       3       6-7
> 
> If you decided to take my wording, please give credits.
> 
Will take care of that :).
> > > > Improve the performance by assigning IRQ to non sibling CPUs in local
> > > > NUMA node. The performance improvement we are getting using ntttcp with
> > > > following patch is around 15 percent with existing design and approximately
> > > > 11 percent, when trying to assign one IRQ in each core across NUMA nodes,
> > > > if enough cores are present.
> > > 
> > > How did you measure it? In the other email you said you used perf, can
> > > you show your procedure in details?
> > I have used ntttcp for performance analysis, by perf I had meant performance
> > analysis. I have used ntttcp with following parameters
> > ntttcp -r -m 64 <receiver> 
> > 
> > ntttcp -s <receiver side ip address>  -m 64 <sender>
> > Both the VMs are in same Azure subnet and private IP address is used.
> > MTU and tcp buffer is set accordingly and number of channels are set using ethtool
> > accordingly for best performance. Also irqbalance was disabled.
> > https://github.com/microsoft/ntttcp-for-linux
> > https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-bandwidth-testing?tabs=linux
> 
> OK. Can you also print the before/after outputs of ntttcp that demonstrate
> +15%?
> 
With affinity spread like each core only 1 irq and spreading accross multiple NUMA node>
8 ./ntttcp -r -m 16
NTTTCP for Linux 1.4.0
---------------------------------------------------------
08:05:20 INFO: 17 threads created
08:05:28 INFO: Network activity progressing...
08:06:28 INFO: Test run completed.
08:06:28 INFO: Test cycle finished.
08:06:28 INFO: #####  Totals:  #####
08:06:28 INFO: test duration    :60.00 seconds
08:06:28 INFO: total bytes      :630292053310
08:06:28 INFO:   throughput     :84.04Gbps
08:06:28 INFO:   retrans segs   :4
08:06:28 INFO: cpu cores        :192
08:06:28 INFO:   cpu speed      :3799.725MHz
08:06:28 INFO:   user           :0.05%
08:06:28 INFO:   system         :1.60%
08:06:28 INFO:   idle           :96.41%
08:06:28 INFO:   iowait         :0.00%
08:06:28 INFO:   softirq        :1.94%
08:06:28 INFO:   cycles/byte    :2.50
08:06:28 INFO: cpu busy (all)   :534.41%

With our new proposal

./ntttcp -r -m 16
NTTTCP for Linux 1.4.0
---------------------------------------------------------
08:08:51 INFO: 17 threads created
08:08:56 INFO: Network activity progressing...
08:09:56 INFO: Test run completed.
08:09:56 INFO: Test cycle finished.
08:09:56 INFO: #####  Totals:  #####
08:09:56 INFO: test duration    :60.00 seconds
08:09:56 INFO: total bytes      :741966608384
08:09:56 INFO:   throughput     :98.93Gbps
08:09:56 INFO:   retrans segs   :6
08:09:56 INFO: cpu cores        :192
08:09:56 INFO:   cpu speed      :3799.791MHz
08:09:56 INFO:   user           :0.06%
08:09:56 INFO:   system         :1.81%
08:09:56 INFO:   idle           :96.18%
08:09:56 INFO:   iowait         :0.00%
08:09:56 INFO:   softirq        :1.95%
08:09:56 INFO:   cycles/byte    :2.25
08:09:56 INFO: cpu busy (all)   :569.22%
---------------------------------------------------------

> > > > Suggested-by: Yury Norov <yury.norov@gmali.com>
> > > > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > > > ---
> > > 
> > > [...]
> > > 
> > > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 92 +++++++++++++++++--
> > > >  1 file changed, 83 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > index 6367de0c2c2e..18e8908c5d29 100644
> > > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > @@ -1243,15 +1243,56 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> > > >  	r->size = 0;
> > > >  }
> > > >  
> > > > +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> 
> Is it intentional that irqs and nvec are signed? If not, please make
> them unsigned.
Will do it in next version.
> 
> > > > +{
> > > > +	int w, cnt, cpu, err = 0, i = 0;
> > > > +	int next_node = start_numa_node;
> > > 
> > > What for this?
> > This is the local numa node, from where to start hopping.
> > Please see how we are calling irq_setup(). We are passing the array of allocated irqs, total
> > number of irqs allocated, and the local numa node to the device.
> 
> I'll ask again: you copy parameter (start_numa_node) to a local
> variable (next_node), and never use start_numa_node after that.
> 
> You can just use the parameter, and avoid creating local variable at
> all, so what for the latter exist?
> 
> The naming is confusing. I think just 'node' is OK here.
Thanks, I wll not use the extra variable next_node.
> 
> > > > +	const struct cpumask *next, *prev = cpu_none_mask;
> > > > +	cpumask_var_t curr, cpus;
> > > > +
> > > > +	if (!zalloc_cpumask_var(&curr, GFP_KERNEL)) {
> > > > +		err = -ENOMEM;
> > > > +		return err;
> > > > +	}
> > > > +	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL)) {
> > > 
> > >                 free(curr);
> > Will fix it in next version. Thanks for pointing.
> 
> And also drop 'err' - just 'return -ENOMEM'.
> 
Will fix it in next revision.
> > > 
> > > > +		err = -ENOMEM;
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	rcu_read_lock();
> > > > +	for_each_numa_hop_mask(next, next_node) {
> > > > +		cpumask_andnot(curr, next, prev);
> > > > +		for (w = cpumask_weight(curr), cnt = 0; cnt < w; ) {
> > > > +			cpumask_copy(cpus, curr);
> > > > +			for_each_cpu(cpu, cpus) {
> > > > +				irq_set_affinity_and_hint(irqs[i], topology_sibling_cpumask(cpu));
> > > > +				if (++i == nvec)
> > > > +					goto done;
> > > 
> > > Think what if you're passed with irq_setup(NULL, 0, 0).
> > > That's why I suggested to place this check at the beginning.
> > > 
> > irq_setup() is a helper function for mana_gd_setup_irqs(), which already takes
> > care of no NULL pointer for irqs, and 0 number of interrupts can not be passed.
> > 
> > nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> > if (nvec < 0)
> > 	return nvec;
> 
> I know that. But still it's a bug. The common convention is that if a
> 0-length array is passed to a function, it should not dereference the
> pointer.
> 
I will add one if check in the begining of irq_setup() to verify the pointer
and the nvec number.
> ...
> 
> > > > @@ -1287,21 +1336,44 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> > > >  			goto free_irq;
> > > >  		}
> > > >  
> > > > -		err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> > > > -		if (err)
> > > > -			goto free_irq;
> > > > -
> > > > -		cpu = cpumask_local_spread(i, gc->numa_node);
> > > > -		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> > > > +		if (!i) {
> > > > +			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> > > > +			if (err)
> > > > +				goto free_irq;
> > > > +
> > > > +			/* If number of IRQ is one extra than number of online CPUs,
> > > > +			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> > > > +			 * same CPU.
> > > > +			 * Else we will use different CPUs for IRQ0 and IRQ1.
> > > > +			 * Also we are using cpumask_local_spread instead of
> > > > +			 * cpumask_first for the node, because the node can be
> > > > +			 * mem only.
> > > > +			 */
> > > > +			if (start_irq_index) {
> > > > +				cpu = cpumask_local_spread(i, gc->numa_node);
> > > 
> > > I already mentioned that: if i == 0, you don't need to spread, just
> > > pick 1st cpu from node.
> > The reason I have picked cpumask_local_spread here, is that, the gc->numa_node 
> > can be a memory only node, in that case we need to jump to next node to get the CPU.
> > Which cpumask_local_spread() using sched_numa_find_nth_cpu() takes care off.
> 
> OK, makes sense.
> 
> What if you need to distribute more IRQs than the number of CPUs? In
> that case you'd call the function many times. But because you return
> 0, user has no chance catch that. I think you should handle it inside
> the helper, or do like this:
> 
>         while (nvec) {
>                 distributed = irq_setup(irqs, nvec, node);
>                 if (distributed < 0)
>                         break;
> 
>                 irq += distributed;
>                 nvec -= distributed;
>         }
We can not have irqs more greater than 1 of num of online CPUs, as we are
setting it inside cpu_read_lock() with num_online_cpus().
We can have minimum 2 IRQs and max number_online_cpus() +1 or 64, which is
maximum supported IRQs per port.

1295         cpus_read_lock();
1296         max_queues_per_port = num_online_cpus();
1297         if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
1298                 max_queues_per_port = MANA_MAX_NUM_QUEUES;
1299
1300         /* Need 1 interrupt for the Hardware communication Channel (HWC) */
1301         max_irqs = max_queues_per_port + 1;
1302
1303         nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
1304         if (nvec < 0)
1305                 return nvec;
> 
> Thanks,
> Yury

