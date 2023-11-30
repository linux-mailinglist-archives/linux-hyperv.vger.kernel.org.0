Return-Path: <linux-hyperv+bounces-1161-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDEE7FEE8A
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 13:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE972281D3B
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B03945949;
	Thu, 30 Nov 2023 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bpt7p/4H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB16BD46;
	Thu, 30 Nov 2023 04:05:12 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 1AF5C20B74C0; Thu, 30 Nov 2023 04:05:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1AF5C20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701345912;
	bh=/rVuqlYYpLzwGHq/EK9NytP0xWQESkkc0TlDS3zxqY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bpt7p/4HhHDo6dYClHRLdHCut/FjhKTk6mGeZB+9C5QBTqhDefLDJZszOOxWnf74K
	 khFcWy3czqcJIXDdbr6llkD8Ic6HzwBpTBpnCLFwf3UXFQ2bOstrSz+QR8JwTmoGnO
	 jGgGYdAqsWiKEO2EKytfiLc+FYSb9ihaSt+rwXXc=
Date: Thu, 30 Nov 2023 04:05:12 -0800
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Message-ID: <20231130120512.GA15408@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20231121154841.7fc019c8@kernel.org>
 <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <ZWfwcYPLVo+4V8Ps@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWfwcYPLVo+4V8Ps@yury-ThinkPad>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Nov 29, 2023 at 06:16:17PM -0800, Yury Norov wrote:
> On Mon, Nov 27, 2023 at 09:36:38AM +0000, Souradeep Chakrabarti wrote:
> > 
> > 
> > >-----Original Message-----
> > >From: Jakub Kicinski <kuba@kernel.org>
> > >Sent: Wednesday, November 22, 2023 5:19 AM
> > >To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > >Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > ><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > ><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> > >pabeni@redhat.com; Long Li <longli@microsoft.com>;
> > >sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
> > >ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de; linux-
> > >hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > >linux-rdma@vger.kernel.org; Souradeep Chakrabarti
> > ><schakrabarti@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>
> > >Subject: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on
> > >HT cores
> > >
> > >On Tue, 21 Nov 2023 05:54:37 -0800 Souradeep Chakrabarti wrote:
> > >> Existing MANA design assigns IRQ to every CPUs, including sibling
> > >> hyper-threads in a core. This causes multiple IRQs to work on same CPU
> > >> and may reduce the network performance with RSS.
> > >>
> > >> Improve the performance by adhering the configuration for RSS, which
> > >> assigns IRQ on HT cores.
> > >
> > >Drivers should not have to carry 120 LoC for something as basic as spreading IRQs.
> > >Please take a look at include/linux/topology.h and if there's nothing that fits your
> > >needs there - add it. That way other drivers can reuse it.
> > Because of the current design idea, it is easier to keep things inside
> > the mana driver code here. As the idea of IRQ distribution here is :
> > 1)Loop through interrupts to assign CPU
> > 2)Find non sibling online CPU from local NUMA and assign the IRQs
> > on them.
> > 3)If number of IRQs is more than number of non-sibling CPU in that
> > NUMA node, then assign on sibling CPU of that node.
> > 4)Keep doing it till all the online CPUs are used or no more IRQs.
> > 5)If all CPUs in that node are used, goto next NUMA node with CPU.
> > Keep doing 2 and 3.
> > 6) If all CPUs in all NUMA nodes are used, but still there are IRQs
> > then wrap over from first local NUMA node and continue
> > doing 2, 3 4 till all IRQs are assigned.
> 
> Hi Souradeep,
> 
> (Thanks Jakub for sharing this thread with me)
> 
> If I understand your intention right, you can leverage the existing
> cpumask_local_spread().
> 
> But I think I've got something better for you. The below series adds
> a for_each_numa_cpu() iterator, which may help you doing most of the
> job without messing with nodes internals.
> 
> https://lore.kernel.org/netdev/ZD3l6FBnUh9vTIGc@yury-ThinkPad/T/
>
Thanks Yur and Jakub. I was trying to find this patch, but unable to find it on that thread.
Also in net-next I am unable to find it. Can you please tell, if it has been committed?
If not can you please point me out the correct patch for this macro. It will be
really helpful.
> By using it, the pseudocode implementing your algorithm may look
> like this:
> 
>         unsigned int cpu, hop;
>         unsigned int irq = 0;
> 
> again:
>         cpu = get_cpu();
>         node = cpu_to_node(cpu);
>         cpumask_copy(cpus, cpu_online_mask);
> 
>         for_each_numa_cpu(cpu, hop, node, cpus) {
>                 /* All siblings are the same for IRQ spreading purpose */
>                 irq_set_affinity_and_hint(irq, topology_sibling_cpumask());
> 
>                 /* One IRQ per sibling group */
>                 cpumask_andnot(cpus, cpus, topology_sibling_cpumask());
> 
>                 if (++irq == num_irqs)
>                         break;
>         }
> 
>         if (irq < num_irqs)
>                 goto again;
> 
> (Completely not tested, just an idea.)
>
I have done similar kind of change for our driver, but constraint here is that total number of IRQs
can be equal to the total number of online CPUs, in some setup. It is either equal
to the number of online CPUs or maximum 64 IRQs if online CPUs are more than that.
So my proposed change is following:

+static int irq_setup(int *irqs, int nvec, int start_numa_node)
+{
+       cpumask_var_t node_cpumask;
+       int i, cpu, err = 0;
+       unsigned int  next_node;
+       cpumask_t visited_cpus;
+       unsigned int start_node = start_numa_node;
+       i = 0;
+       if (!alloc_cpumask_var(&node_cpumask, GFP_KERNEL)) {
+               err = -ENOMEM;
+               goto free_mask;
+       }
+       cpumask_andnot(&visited_cpus, &visited_cpus, &visited_cpus);
+       start_node = 1;
+       for_each_next_node_with_cpus(start_node, next_node) {
+               cpumask_copy(node_cpumask, cpumask_of_node(next_node));
+               for_each_cpu(cpu, node_cpumask) {
+                       cpumask_andnot(node_cpumask, node_cpumask,
+                                      topology_sibling_cpumask(cpu));
+                       irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu));
+                       if(++i == nvec)
+                               goto free_mask;
+                       cpumask_set_cpu(cpu, &visited_cpus);
+                       if (cpumask_empty(node_cpumask) && cpumask_weight(&visited_cpus) <
+                           nr_cpus_node(next_node)) {
+                               cpumask_copy(node_cpumask, cpumask_of_node(next_node));
+                               cpumask_andnot(node_cpumask, node_cpumask, &visited_cpus);
+                               cpu = cpumask_first(node_cpumask);
+                       }
+               }
+               if (next_online_node(next_node) == MAX_NUMNODES)
+                       next_node = first_online_node;
+       }
+free_mask:
+       free_cpumask_var(node_cpumask);
+       return err;
+} 

I can definitely use the for_each_numa_cpu() instead of my proposed for_each_next_node_with_cpus()
macro here and that will make it cleaner.
Thanks for the suggestion.
> Thanks,
> Yury

