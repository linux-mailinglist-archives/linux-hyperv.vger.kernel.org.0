Return-Path: <linux-hyperv+bounces-1405-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B88295C7
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 10:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50C2283859
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08933B787;
	Wed, 10 Jan 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BuAxzrXT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B863B199;
	Wed, 10 Jan 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id D83FA20B3CC1; Wed, 10 Jan 2024 01:08:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D83FA20B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704877699;
	bh=VGPAJ+VlAmIxbqE8tAHckUZUwj1fM6R7OZbw7bjWzS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuAxzrXTnPC0ZeAKe/PvtdnWrbkAIpLsexS72rloAJrewEhopaweCME4r5BwZRptA
	 gYFE9eMieWSfoUvTFmvUM29QV5ovH8/8qZGpPWGr9JqI6kWok81hDPXl5piWT+99zO
	 XA9NZ17spy7tGGiVBmZRsQXbWwICS7wJJeqHeDiw=
Date: Wed, 10 Jan 2024 01:08:19 -0800
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs
 per CPUs
Message-ID: <20240110090819.GA5436@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
 <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <MW1PEPF0000E6910254736DF77F99E04DD4CA6A2@MW1PEPF0000E691.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW1PEPF0000E6910254736DF77F99E04DD4CA6A2@MW1PEPF0000E691.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 09, 2024 at 08:20:31PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Tuesday, January 9, 2024 2:23 PM
> > To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>; KY Srinivasan
> > <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> > wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; Long Li <longli@microsoft.com>; yury.norov@gmail.com;
> > leon@kernel.org; cai.huoqing@linux.dev; ssengar@linux.microsoft.com;
> > vkuznets@redhat.com; tglx@linutronix.de; linux-hyperv@vger.kernel.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > rdma@vger.kernel.org
> > Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Paul Rosswurm
> > <paulros@microsoft.com>
> > Subject: RE: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs per
> > CPUs
> > 
> > [Some people who received this message don't often get email from
> > mhklinux@outlook.com. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent:
> > Tuesday, January 9, 2024 2:51 AM
> > >
> > > From: Yury Norov <yury.norov@gmail.com>
> > >
> > > Souradeep investigated that the driver performs faster if IRQs are
> > > spread on CPUs with the following heuristics:
> > >
> > > 1. No more than one IRQ per CPU, if possible;
> > > 2. NUMA locality is the second priority;
> > > 3. Sibling dislocality is the last priority.
> > >
> > > Let's consider this topology:
> > >
> > > Node            0               1
> > > Core        0       1       2       3
> > > CPU       0   1   2   3   4   5   6   7
> > >
> > > The most performant IRQ distribution based on the above topology
> > > and heuristics may look like this:
> > >
> > > IRQ     Nodes   Cores   CPUs
> > > 0       1       0       0-1
> > > 1       1       1       2-3
> > > 2       1       0       0-1
> > > 3       1       1       2-3
> > > 4       2       2       4-5
> > > 5       2       3       6-7
> > > 6       2       2       4-5
> > > 7       2       3       6-7
> > 
> > I didn't pay attention to the detailed discussion of this issue
> > over the past 2 to 3 weeks during the holidays in the U.S., but
> > the above doesn't align with the original problem as I understood
> > it.  I thought the original problem was to avoid putting IRQs on
> > both hyper-threads in the same core, and that the perf
> > improvements are based on that configuration.  At least that's
> > what the commit message for Patch 4/4 in this series says.
> > 
> > The above chart results in 8 IRQs being assigned to the 8 CPUs,
> > probably with 1 IRQ per CPU.   At least on x86, if the affinity
> > mask for an IRQ contains multiple CPUs, matrix_find_best_cpu()
> > should balance the IRQ assignments between the CPUs in the mask.
> > So the original problem is still present because both hyper-threads
> > in a core are likely to have an IRQ assigned.
> > 
> > Of course, this example has 8 IRQs and 8 CPUs, so assigning an
> > IRQ to every hyper-thread may be the only choice.  If that's the
> > case, maybe this just isn't a good example to illustrate the
> > original problem and solution.  But even with a better example
> > where the # of IRQs is <= half the # of CPUs in a NUMA node,
> > I don't think the code below accomplishes the original intent.
> > 
> > Maybe I've missed something along the way in getting to this
> > version of the patch.  Please feel free to set me straight. :-)
> > 
> > Michael
> 
> I have the same question as Michael. Also, I'm asking Souradeep
> in another channel: So, the algorithm still uses up all current 
> NUMA node before moving on to the next NUMA node, right?
> 
> Except each IRQ is affinitized to 2 CPUs. 
> For example, a system with 2 IRQs:
> IRQ     Nodes   Cores  CPUs
> 0       1       0      0-1
> 1       1       1      2-3
>  
> Is this performing better than the algorithm in earlier patches? like below:
> IRQ     Nodes   Cores  CPUs
> 0       1       0      0
> 1       1       1      2
> 
The details for this approach has been shared by Yury later in this thread.
The main intention with this approach is kernel may pick any
sibling for the IRQ.
> Thanks,
> - Haiyang

