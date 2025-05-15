Return-Path: <linux-hyperv+bounces-5522-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2441AB7CBB
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 06:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E451BA3580
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 04:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889461EA7DE;
	Thu, 15 May 2025 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DNEwPbI2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B172D052;
	Thu, 15 May 2025 04:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747284585; cv=none; b=ssPi9kbuEx3H3ZZChmHK1w3jlfu7An5NiHiFs0TkX0xDj5Q471Cwd/xwG77FvWD7r0+mhanN/CM1mi4OcWAZva3Zx/PFXESXbvoAjin2fi5PK7dljYfswEKxZG7x/ZW3HjrNsZCqKWIE6TCYCLr8L0W1pqrh6SsLkpqzy9uW09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747284585; c=relaxed/simple;
	bh=5ex2XPtCgcZjj6nBV/479N8/kyNeH+50ZY5udqoyUbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDsnjrUf/OiF4S2+TghuexuRLICvqBXjw4npFg6S3+iqgi72hP0/qL1SqNxYJbGkX3R8GDwwrtLqWxCxFi8rWP2Jjqeln/MaCbbdohWD4i1wIcyPIXmILutie2ns1Qwrsl1Kz6yxFT9oautCi5Zkj8splkupzYcuYsicykQkl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DNEwPbI2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 2A4BC201DB00; Wed, 14 May 2025 21:49:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A4BC201DB00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747284582;
	bh=G229l3a/ssTXJb4AFEMQgw5XAvni2xdA/B6L+u0ij/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNEwPbI2HDYRbGnrTs3VLTI6m2Dtj+1S4NtqIJGi2K7Vatc+1c6T/OxlhzimDljRo
	 xFvRPzcwt5TOtvzC1wza3XpC3Rom5zbHsJXGUCWTEq10A85UxUyKGkXXJaFQPbvkOB
	 gijQh5tXDg5LDYcgYVjdAn6YOcb0xyLir7ZPmbBc=
Date: Wed, 14 May 2025 21:49:42 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Yury Norov <yury.norov@gmail.com>, Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
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
	Nipun Gupta <nipun.gupta@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [PATCH v3 3/4] net: mana: Allow irq_setup() to skip cpus for
 affinity
Message-ID: <20250515044942.GA5681@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785625-4753-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SN6PR02MB41577E2FAA79E2803C3384B0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aCTK5PjV1n1EYOpi@yury>
 <SN6PR02MB4157AA971E41FE92B1878F9DD491A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157AA971E41FE92B1878F9DD491A@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 14, 2025 at 05:26:45PM +0000, Michael Kelley wrote:
> From: Yury Norov <yury.norov@gmail.com> Sent: Wednesday, May 14, 2025 9:55 AM
> > 
> > On Wed, May 14, 2025 at 04:53:34AM +0000, Michael Kelley wrote:
> > > > -static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> > > > +static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> > > > +		     bool skip_first_cpu)
> > > >  {
> > > >  	const struct cpumask *next, *prev = cpu_none_mask;
> > > >  	cpumask_var_t cpus __free(free_cpumask_var);
> > > > @@ -1303,9 +1304,20 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> > > >  		while (weight > 0) {
> > > >  			cpumask_andnot(cpus, next, prev);
> > > >  			for_each_cpu(cpu, cpus) {
> > > > +				/*
> > > > +				 * if the CPU sibling set is to be skipped we
> > > > +				 * just move on to the next CPUs without len--
> > > > +				 */
> > > > +				if (unlikely(skip_first_cpu)) {
> > > > +					skip_first_cpu = false;
> > > > +					goto next_cpumask;
> > > > +				}
> > > > +
> > > >  				if (len-- == 0)
> > > >  					goto done;
> > > > +
> > > >  				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> > > > +next_cpumask:
> > > >  				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> > > >  				--weight;
> > > >  			}
> > >
> > > With a little bit of reordering of the code, you could avoid the need for the "next_cpumask"
> > > label and goto statement.  "continue" is usually cleaner than a "goto". Here's what I'm thinking:
> > >
> > > 		for_each_cpu(cpu, cpus) {
> > > 			cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> > > 			--weight;
> > 
> > cpumask_andnot() is O(N), and before it was conditional on 'len == 0',
> > so we didn't do that on the very last step. Your version has to do that.
> > Don't know how important that is for real workloads. Shradha maybe can
> > measure it...
> 
> Yes, there's one extra invocation of cpumask_andnot(). But if the
> VM has a small number of CPUs, that extra invocation is negligible.
> If the VM has a large number of CPUs, we're already executing
> cpumask_andnot() many times, so one extra time is also negligible.
> And this whole thing is done only at device initialization time, so
> it's not a hot path.
>

Hi Michael, Yury,

That's right, the overhead is negligible. Tested with some common
workloads. I will change this in the next version.

Shradha.
 
> > 
> > >
> > > 			If (unlikely(skip_first_cpu)) {
> > > 				skip_first_cpu = false;
> > > 				continue;
> > > 			}
> > >
> > > 			If (len-- == 0)
> > > 				goto done;
> > >
> > > 			irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> > > 		}
> > >
> > > I wish there were some comments in irq_setup() explaining the overall intention of
> > > the algorithm. I can see how the goal is to first assign CPUs that are local to the current
> > > NUMA node, and then expand outward to CPUs that are further away. And you want
> > > to *not* assign both siblings in a hyper-threaded core.
> > 
> > I wrote this function, so let me step in.
> > 
> > The intention is described in the corresponding commit message:
> > 
> >   Souradeep investigated that the driver performs faster if IRQs are
> >   spread on CPUs with the following heuristics:
> > 
> >   1. No more than one IRQ per CPU, if possible;
> >   2. NUMA locality is the second priority;
> >   3. Sibling dislocality is the last priority.
> > 
> >   Let's consider this topology:
> > 
> >   Node            0               1
> >   Core        0       1       2       3
> >   CPU       0   1   2   3   4   5   6   7
> > 
> >   The most performant IRQ distribution based on the above topology
> >   and heuristics may look like this:
> > 
> >   IRQ     Nodes   Cores   CPUs
> >   0       1       0       0-1
> >   1       1       1       2-3
> >   2       1       0       0-1
> >   3       1       1       2-3
> >   4       2       2       4-5
> >   5       2       3       6-7
> >   6       2       2       4-5
> >   7       2       3       6-7
> > 
> > > But I can't figure out what
> > > "weight" is trying to accomplish. Maybe this was discussed when the code first
> > > went in, but I can't remember now. :-(
> > 
> > The weight here is to implement the heuristic discovered by Souradeep:
> > NUMA locality is preferred over sibling dislocality.
> > 
> > The outer for_each() loop resets the weight to the actual number of
> > CPUs in the hop. Then inner for_each() loop decrements it by the
> > number of sibling groups (cores) while assigning first IRQ to each
> > group.
> > 
> > Now, because NUMA locality is more important, we should walk the
> > same set of siblings and assign 2nd IRQ, and it's implemented by the
> > medium while() loop. So, we do like this unless the number of IRQs
> > assigned on this hop will not become equal to number of CPUs in the
> > hop (weight == 0). Then we switch to the next hop and do the same
> > thing.
> > 
> > Hope that helps.
> 
> Yes, that helps! So the key to understanding "weight" is that
> NUMA locality is preferred over sibling dislocality.
> 
> This is a great summary!  All or most of it should go as a
> comment describing the function and what it is trying to do.
> 
> Michael

