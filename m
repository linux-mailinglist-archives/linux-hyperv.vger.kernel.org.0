Return-Path: <linux-hyperv+bounces-1414-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C4882A771
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jan 2024 07:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C251F232DE
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jan 2024 06:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B9B2105;
	Thu, 11 Jan 2024 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F4ppTMFL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9456C5382;
	Thu, 11 Jan 2024 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 7A36A209C43A; Wed, 10 Jan 2024 22:13:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A36A209C43A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704953599;
	bh=Vx6uwJdgmYeQ9YCQC3Gj9uTpE/Inxmh3nP0kQERH+Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4ppTMFLicty7Ad4PVvjI+E3NO/r6Mx6EgTdjLUiDZxrRcX4ztiUXZlY76P9z3EEg
	 1gnXNyMrQ3FnE4aSOYMK8WKwXEy3RN6o4TpI6SANKlk4H8UwCSKirPUch22vAsvXjr
	 6c4N1IcWWNeQLsTlBakVSokhRjGDSJ0Svpo1x6FQ=
Date: Wed, 10 Jan 2024 22:13:19 -0800
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"schakrabarti@microsoft.com" <schakrabarti@microsoft.com>,
	"paulros@microsoft.com" <paulros@microsoft.com>
Subject: Re: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs
 per CPUs
Message-ID: <20240111061319.GC5436@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
 <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZZ3Wsxq8rHShTUdA@yury-ThinkPad>
 <SN6PR02MB415704D36B82D5793CC4558FD4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415704D36B82D5793CC4558FD4692@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jan 10, 2024 at 12:27:54AM +0000, Michael Kelley wrote:
> From: Yury Norov <yury.norov@gmail.com> Sent: Tuesday, January 9, 2024 3:29 PM
> > 
> > Hi Michael,
> > 
> > So, I'm just a guy who helped to formulate the heuristics in an
> > itemized form, and implement them using the existing kernel API.
> > I have no access to MANA machines and I ran no performance tests
> > myself.
> 
> Agreed. :-)   Given the heritage of the patch, I should have clarified
> that my question was directed to Souradeep.  Regardless, your work
> on the cpumask manipulation made everything better and clearer.
> 
> > 
> > On Tue, Jan 09, 2024 at 07:22:38PM +0000, Michael Kelley wrote:
> > > From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent:
> > Tuesday, January 9, 2024 2:51 AM
> > > >
> > > > From: Yury Norov <yury.norov@gmail.com>
> > > >
> > > > Souradeep investigated that the driver performs faster if IRQs are
> > > > spread on CPUs with the following heuristics:
> > > >
> > > > 1. No more than one IRQ per CPU, if possible;
> > > > 2. NUMA locality is the second priority;
> > > > 3. Sibling dislocality is the last priority.
> > > >
> > > > Let's consider this topology:
> > > >
> > > > Node            0               1
> > > > Core        0       1       2       3
> > > > CPU       0   1   2   3   4   5   6   7
> > > >
> > > > The most performant IRQ distribution based on the above topology
> > > > and heuristics may look like this:
> > > >
> > > > IRQ     Nodes   Cores   CPUs
> > > > 0       1       0       0-1
> > > > 1       1       1       2-3
> > > > 2       1       0       0-1
> > > > 3       1       1       2-3
> > > > 4       2       2       4-5
> > > > 5       2       3       6-7
> > > > 6       2       2       4-5
> > > > 7       2       3       6-7
> > >
> > > I didn't pay attention to the detailed discussion of this issue
> > > over the past 2 to 3 weeks during the holidays in the U.S., but
> > > the above doesn't align with the original problem as I understood
> > > it.  I thought the original problem was to avoid putting IRQs on
> > > both hyper-threads in the same core, and that the perf
> > > improvements are based on that configuration.  At least that's
> > > what the commit message for Patch 4/4 in this series says.
> > 
> > Yes, and the original distribution suggested by Souradeep looks very
> > similar:
> > 
> >   IRQ     Nodes   Cores   CPUs
> >   0       1       0       0
> >   1       1       1       2
> >   2       1       0       1
> >   3       1       1       3
> >   4       2       2       4
> >   5       2       3       6
> >   6       2       2       5
> >   7       2       3       7
> > 
> > I just added a bit more flexibility, so that kernel may pick any
> > sibling for the IRQ. As I understand, both approaches have similar
> > performance. Probably my fine-tune added another half-percent...
> > 
> > Souradeep, can you please share the exact numbers on this?
> > 
> > > The above chart results in 8 IRQs being assigned to the 8 CPUs,
> > > probably with 1 IRQ per CPU.   At least on x86, if the affinity
> > > mask for an IRQ contains multiple CPUs, matrix_find_best_cpu()
> > > should balance the IRQ assignments between the CPUs in the mask.
> > > So the original problem is still present because both hyper-threads
> > > in a core are likely to have an IRQ assigned.
> > 
> > That's what I think, if the topology makes us to put IRQs in the
> > same sibling group, the best thing we can to is to rely on existing
> > balancing mechanisms in a hope that they will do their job well.
> > 
> > > Of course, this example has 8 IRQs and 8 CPUs, so assigning an
> > > IRQ to every hyper-thread may be the only choice.  If that's the
> > > case, maybe this just isn't a good example to illustrate the
> > > original problem and solution.
> > 
> > Yeah... This example illustrates the order of IRQ distribution.
> > I really doubt that if we distribute IRQs like in the above example,
> > there would be any difference in performance. But I think it's quite
> > a good illustration. I could write the title for the table like this:
> > 
> >         The order of IRQ distribution for the best performance
> >         based on [...] may look like this.
> > 
> > > But even with a better example
> > > where the # of IRQs is <= half the # of CPUs in a NUMA node,
> > > I don't think the code below accomplishes the original intent.
> > >
> > > Maybe I've missed something along the way in getting to this
> > > version of the patch.  Please feel free to set me straight. :-)
> > 
> > Hmm. So if the number of IRQs is the half # of CPUs in the nodes,
> > which is 2 in the example above, the distribution will look like
> > this:
> > 
> >   IRQ     Nodes   Cores   CPUs
> >   0       1       0       0-1
> >   1       1       1       2-3
> > 
> > And each IRQ belongs to a different sibling group. This follows
> > the rules above.
> > 
> > I think of it like we assign an IRQ to a group of 2 CPUs, so from
> > the heuristic #1 perspective, each CPU is assigned with 1/2 of the
> > IRQ.
> > 
> > If I add one more IRQ, then according to the heuristics, NUMA locality
> > trumps sibling dislocality, so we'd assign IRO to the same node on any
> > core. My algorithm assigns it to the core #0:
> > 
> >   2       1       0       0-1
> > 
> > This doubles # of IRQs for the CPUs 0 and 1: from 1/2 to 1.
> > 
> > The next IRQ should be assigned to the same node again, and we've got
> > the only choice:
> > 
> > 
> >   3       1       1       2-3
> > 
> > Starting from IRQ #5, the node #1 is full - each CPU is assigned with
> > exactly one IRQ, and the heuristic #1 makes us to switch to the other
> > node; and then do the same thing:
> > 
> >   4       2       2       4-5
> >   5       2       3       6-7
> >   6       2       2       4-5
> >   7       2       3       6-7
> > 
> > So I think the algorithm is correct... Really hope the above makes
> > sense. :) If so, I can add it to the commit message for patch #3.
> 
> Thinking about it further, I agree with you.  If we want NUMA
> locality to trump avoiding hyper-threads in the same core, then
> I'm good with the algorithm.   If I think of the "weight" variable
> in your function as the "number of IRQs to assign to CPUs in
> this NUMA hop", then it makes sense to decrement it by 1
> each time irq_set_affinity_and_hint() is called.  I was confused
> by likely removing multiple cpus from the "cpus" cpumask
> juxtaposed with decrementing "weight" by only 1, and by my
> preconception that to get the perf benefit we wanted to avoid
> hyper-threads in the same core.
> 
> > 
> > Nevertheless... Souradeep, in addition to the performance numbers, can
> > you share your topology and actual IRQ distribution that gains 15%? I
> > think it should be added to the patch #4 commit message.
> 
> Yes -- this is the key thing for me.  What is the configuration that
> shows the 15% performance gain?  Patch 3/4 and Patch 4/4 in the
> series need to be consistent in describing when there's a performance
> benefit and when there's no significant difference.   In Patch 4/4,
> the mana driver creates IRQs equal to the # of CPUs, up to
> MANA_MAX_NUM_QUEUES, which is 64.  So the new algorithm
> still assigns IRQs to both hyper-threads in cores in the local NUMA
> node (unless the node is bigger than 64 CPUs, which I don't think
> happens in Azure today).  For the first hop from the local NUMA
> node, IRQs might get assigned to only one hyper-thread in a core
> if the total CPU count in the VM is more than 64.
The test topology was used to check the performance between
cpu_local_spread() and the new approach is :
Case 1
IRQ     Nodes  Cores CPUs
0       1      0     0-1
1       1      1     2-3
2       1      2     4-5
3       1      3     6-7

and with existing cpu_local_spread()
Case 2
IRQ    Nodes  Cores CPUs
0      1      0     0
1      1      0     1
2      1      1     2
3      1      1     3

Total 4 channels were used, which was set up by ethtool.
case 1 with ntttcp has given 15 percent better performance, than
case 2. During the test irqbalance was disabled as well.

Also you are right, with 64CPU system this approach will spread
the irqs like the cpu_local_spread() but in the future we will offer
MANA nodes, with more than 64 CPUs. There it this new design will 
give better performance.

I will add this performance benefit details in commit message of
next version.
> 
> Michael

