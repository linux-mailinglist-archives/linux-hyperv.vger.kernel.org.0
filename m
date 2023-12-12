Return-Path: <linux-hyperv+bounces-1318-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F51680E423
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 07:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBA2B217AB
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 06:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFB1F9C4;
	Tue, 12 Dec 2023 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iqJE/uNx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE40EA1;
	Mon, 11 Dec 2023 22:03:42 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 1FA7A20B74C0; Mon, 11 Dec 2023 22:03:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FA7A20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702361022;
	bh=hx1+thlCTOb6QRHlrdBHJnO7+AxZwUlT544NfeaPGRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqJE/uNxjAsQMBeeD90Q8CIovDZz74GDXWCDdkLHKi3KwsbFvb+6O8FQO6nyF8tJa
	 kjJrDlFG4Mo3ycLQCcf4Z24dxY1Abhklo40uGZwia8y7/oMKR6Si4ruaOYjZBlIjKi
	 YYVAfZf3gbUPqqgN+wtbcyqo8i1THT19WPzPFoeY=
Date: Mon, 11 Dec 2023 22:03:42 -0800
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
Message-ID: <20231212060342.GA16802@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
 <ZXOQb+3R0YAT/rAm@yury-ThinkPad>
 <20231211065323.GB4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZXcV9pXmg+GE2BCF@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXcV9pXmg+GE2BCF@yury-ThinkPad>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Dec 11, 2023 at 06:00:22AM -0800, Yury Norov wrote:
> On Sun, Dec 10, 2023 at 10:53:23PM -0800, Souradeep Chakrabarti wrote:
> > On Fri, Dec 08, 2023 at 01:53:51PM -0800, Yury Norov wrote:
> > > Few more nits
> > > 
> > > On Fri, Dec 08, 2023 at 06:03:40AM -0800, Yury Norov wrote:
> > > > On Fri, Dec 08, 2023 at 02:02:34AM -0800, Souradeep Chakrabarti wrote:
> > > > > Existing MANA design assigns IRQ to every CPU, including sibling
> > > > > hyper-threads. This may cause multiple IRQs to be active simultaneously
> > > > > in the same core and may reduce the network performance with RSS.
> > > > 
> > > > Can you add an IRQ distribution diagram to compare before/after
> > > > behavior, similarly to what I did in the other email?
> > > > 
> > > > > Improve the performance by assigning IRQ to non sibling CPUs in local
> > > > > NUMA node. The performance improvement we are getting using ntttcp with
> > > > > following patch is around 15 percent with existing design and approximately
> > > > > 11 percent, when trying to assign one IRQ in each core across NUMA nodes,
> > > > > if enough cores are present.
> > > > 
> > > > How did you measure it? In the other email you said you used perf, can
> > > > you show your procedure in details?
> > > > 
> > > > > Suggested-by: Yury Norov <yury.norov@gmali.com>
> > > > > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > > > > ---
> > > > 
> > > > [...]
> > > > 
> > > > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 92 +++++++++++++++++--
> > > > >  1 file changed, 83 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > index 6367de0c2c2e..18e8908c5d29 100644
> > > > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > @@ -1243,15 +1243,56 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> > > > >  	r->size = 0;
> > > > >  }
> > > > >  
> > > > > +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> > > > > +{
> > > > > +	int w, cnt, cpu, err = 0, i = 0;
> > > > > +	int next_node = start_numa_node;
> > > > 
> > > > What for this?
> > > > 
> > > > > +	const struct cpumask *next, *prev = cpu_none_mask;
> > > > > +	cpumask_var_t curr, cpus;
> > > > > +
> > > > > +	if (!zalloc_cpumask_var(&curr, GFP_KERNEL)) {
> > > 
> > > alloc_cpumask_var() here and below, because you initialize them by
> > > copying
> > I have used zalloc here as prev gets initialized after the first hop, before that
> > it may contain unwanted values, which may impact cpumask_andnot(curr, next, prev).
> > Regarding curr I will change it to alloc_cpumask_var().
> > Please let me know if that sounds right.
> 
> What? prev is initialized at declaration:
Yes, I will remove the zalloc and will change it to alloc in V6.
Thanks for pointing.
>         
>         const struct cpumask *next, *prev = cpu_none_mask;

