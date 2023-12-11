Return-Path: <linux-hyperv+bounces-1311-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A980CF8E
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Dec 2023 16:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37E11F215CB
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Dec 2023 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D134B5BC;
	Mon, 11 Dec 2023 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCUeV7Kz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74799E5;
	Mon, 11 Dec 2023 07:30:49 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db4422fff15so3624794276.1;
        Mon, 11 Dec 2023 07:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702308648; x=1702913448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJli/Fl4nQv2y3bmONq0d38NoKPmHuZ4V9AFdDvJZ+M=;
        b=mCUeV7KzaOPJ5y+Q25Xdn67U+Lr4fhNbBjF2k2cth2D6BAezIbdwOLdbx6R55gyu6V
         qLDhwybSBOd6UfYBJujtyn4wuX7mJ9fU9DExExGefnw/TymEx1HtKeydzFmaB5W3+eUL
         cQ++UhnmZwvJLzGt5RtG4leUysIwStkJX6qVMpIZtUQ3MK3uW+3hO6k1MNTLBLQuRlxk
         CjaknEswwtZWMftAQrJp0R5TmVZGtokehPz4GN9H3VsRWXwt6T9N11yaH4XHfEwu9XOf
         r+zZBW2f0j1aKio3uWg4Pzg8xq4xw6h/z/7mdWT/8pAzIVWMa98gnfxbVC49j2sgTYiA
         29uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308648; x=1702913448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJli/Fl4nQv2y3bmONq0d38NoKPmHuZ4V9AFdDvJZ+M=;
        b=o/xNmYjyfVP11J9b9uyfdfeUeHu/C8hAGwow+UcvA2StTMSvqjTBEpifhtFFD/mpfn
         tCiLj1qVcB7sRdFSaLpYLGXhMezrnB8tQrBgkJcECz4RhKkmNlGMTHKa47Afg7eNynx5
         dCdZUU3R/i9xYMwG5cbItUTCMC5MLNJIr1VucP5f92l4V33n1QJr0rH4AG94car2JqcJ
         580RJiHeGJoNT10kPJpz5Mb0E/+KrqkgYu2qXikon67pQ5FRm3Qzi/3Bx6gWRuBi78p1
         dZqAWn7iumwveei/OKhsIeSS6M5O3Cyf/FMDwsQs8SPtiDPoW8rbUw51deNz7nsLip06
         wUqg==
X-Gm-Message-State: AOJu0YxMPIWbi62xG0Fc1H3Kt1PwFQv6tLSH3Vr25b2/bEwdxCsQ+cSt
	M4BP7mfaqbVV73c7fH9eu/E=
X-Google-Smtp-Source: AGHT+IEJtgcUac+Z3n31MvZ7wAHTIEJmsqKX5zPJpOSYLbbdmRzecf65IMrJ+9fZl7eV4jXjOkuvSw==
X-Received: by 2002:a25:cacf:0:b0:dbc:514f:d76 with SMTP id a198-20020a25cacf000000b00dbc514f0d76mr2515227ybg.101.1702308648363;
        Mon, 11 Dec 2023 07:30:48 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:f798:e824:429f:84b0])
        by smtp.gmail.com with ESMTPSA id k15-20020a5b0a0f000000b00db54cf1383esm2558799ybq.10.2023.12.11.07.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:30:47 -0800 (PST)
Date: Mon, 11 Dec 2023 07:30:46 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	schakrabarti@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH V5 net-next] net: mana: Assigning IRQ affinity on HT cores
Message-ID: <ZXcrHc5QGPTZtXKf@yury-ThinkPad>
References: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
 <20231211063726.GA4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211063726.GA4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Sun, Dec 10, 2023 at 10:37:26PM -0800, Souradeep Chakrabarti wrote:
> On Fri, Dec 08, 2023 at 06:03:39AM -0800, Yury Norov wrote:
> > On Fri, Dec 08, 2023 at 02:02:34AM -0800, Souradeep Chakrabarti wrote:
> > > Existing MANA design assigns IRQ to every CPU, including sibling
> > > hyper-threads. This may cause multiple IRQs to be active simultaneously
> > > in the same core and may reduce the network performance with RSS.
> > 
> > Can you add an IRQ distribution diagram to compare before/after
> > behavior, similarly to what I did in the other email?
> > 
> Let's consider this topology:

Not here - in commit message, please.

> 
> Node            0               1
> Core        0       1       2       3
> CPU       0   1   2   3   4   5   6   7
> 
>  Before  
>  IRQ     Nodes   Cores   CPUs
>  0       1       0       0
>  1       1       1       2
>  2       1       0       1
>  3       1       1       3
>  4       2       2       4
>  5       2       3       6
>  6       2       2       5
>  7       2       3       7
>  
>  Now
>  IRQ     Nodes   Cores   CPUs
>  0       1       0       0-1
>  1       1       1       2-3
>  2       1       0       0-1
>  3       1       1       2-3
>  4       2       2       4-5
>  5       2       3       6-7
>  6       2       2       4-5
>  7       2       3       6-7

If you decided to take my wording, please give credits.

> > > Improve the performance by assigning IRQ to non sibling CPUs in local
> > > NUMA node. The performance improvement we are getting using ntttcp with
> > > following patch is around 15 percent with existing design and approximately
> > > 11 percent, when trying to assign one IRQ in each core across NUMA nodes,
> > > if enough cores are present.
> > 
> > How did you measure it? In the other email you said you used perf, can
> > you show your procedure in details?
> I have used ntttcp for performance analysis, by perf I had meant performance
> analysis. I have used ntttcp with following parameters
> ntttcp -r -m 64 <receiver> 
> 
> ntttcp -s <receiver side ip address>  -m 64 <sender>
> Both the VMs are in same Azure subnet and private IP address is used.
> MTU and tcp buffer is set accordingly and number of channels are set using ethtool
> accordingly for best performance. Also irqbalance was disabled.
> https://github.com/microsoft/ntttcp-for-linux
> https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-bandwidth-testing?tabs=linux

OK. Can you also print the before/after outputs of ntttcp that demonstrate
+15%?

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

Is it intentional that irqs and nvec are signed? If not, please make
them unsigned.

> > > +{
> > > +	int w, cnt, cpu, err = 0, i = 0;
> > > +	int next_node = start_numa_node;
> > 
> > What for this?
> This is the local numa node, from where to start hopping.
> Please see how we are calling irq_setup(). We are passing the array of allocated irqs, total
> number of irqs allocated, and the local numa node to the device.

I'll ask again: you copy parameter (start_numa_node) to a local
variable (next_node), and never use start_numa_node after that.

You can just use the parameter, and avoid creating local variable at
all, so what for the latter exist?

The naming is confusing. I think just 'node' is OK here.

> > > +	const struct cpumask *next, *prev = cpu_none_mask;
> > > +	cpumask_var_t curr, cpus;
> > > +
> > > +	if (!zalloc_cpumask_var(&curr, GFP_KERNEL)) {
> > > +		err = -ENOMEM;
> > > +		return err;
> > > +	}
> > > +	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL)) {
> > 
> >                 free(curr);
> Will fix it in next version. Thanks for pointing.

And also drop 'err' - just 'return -ENOMEM'.

> > 
> > > +		err = -ENOMEM;
> > > +		return err;
> > > +	}
> > > +
> > > +	rcu_read_lock();
> > > +	for_each_numa_hop_mask(next, next_node) {
> > > +		cpumask_andnot(curr, next, prev);
> > > +		for (w = cpumask_weight(curr), cnt = 0; cnt < w; ) {
> > > +			cpumask_copy(cpus, curr);
> > > +			for_each_cpu(cpu, cpus) {
> > > +				irq_set_affinity_and_hint(irqs[i], topology_sibling_cpumask(cpu));
> > > +				if (++i == nvec)
> > > +					goto done;
> > 
> > Think what if you're passed with irq_setup(NULL, 0, 0).
> > That's why I suggested to place this check at the beginning.
> > 
> irq_setup() is a helper function for mana_gd_setup_irqs(), which already takes
> care of no NULL pointer for irqs, and 0 number of interrupts can not be passed.
> 
> nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> if (nvec < 0)
> 	return nvec;

I know that. But still it's a bug. The common convention is that if a
0-length array is passed to a function, it should not dereference the
pointer.

...

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
> The reason I have picked cpumask_local_spread here, is that, the gc->numa_node 
> can be a memory only node, in that case we need to jump to next node to get the CPU.
> Which cpumask_local_spread() using sched_numa_find_nth_cpu() takes care off.

OK, makes sense.

What if you need to distribute more IRQs than the number of CPUs? In
that case you'd call the function many times. But because you return
0, user has no chance catch that. I think you should handle it inside
the helper, or do like this:

        while (nvec) {
                distributed = irq_setup(irqs, nvec, node);
                if (distributed < 0)
                        break;

                irq += distributed;
                nvec -= distributed;
        }

Thanks,
Yury

