Return-Path: <linux-hyperv+bounces-1165-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35C7FF7A0
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF397B20DF2
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7031655C16;
	Thu, 30 Nov 2023 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgdFwdYG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D48C10DE;
	Thu, 30 Nov 2023 08:59:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cd97c135e8so1071149b3a.0;
        Thu, 30 Nov 2023 08:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701363585; x=1701968385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAYdXqqsd0UZpe+Ix+NlYwVkkMCmmAMpVekHNYKU0ks=;
        b=kgdFwdYGcw55nNAsZfVZ0bhA6MMKewrulG2wgHbHr5/OTnHhhB1ehKXkNBczJlkEP7
         9ezDUFT1CghNd+U4jXhNLxm42LbI6rMtQ8mfhBdyFHY1/cGNo6giphPZiKZrXYPbyi5r
         ETaWf2tshQvb8cao3EL9i+1pZmKbxgOgfP0azEWn8Oxxrbu68z8tuoQdHlhDTixyFguN
         NIj7IVuyd466XV69nOavHWpVEIkRPkRhnXeZHkKziK4+EzLaaAwx9qh977hq8KB5oody
         lXZX2B/6dDVABDzDXv1xpahOuBmvo/2jjj0mg+9uG0cdmZjL7p+UdFuqxvM6ffLJPQcI
         CP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363585; x=1701968385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAYdXqqsd0UZpe+Ix+NlYwVkkMCmmAMpVekHNYKU0ks=;
        b=JI0ntHVfxCcACqoyIrRULtyndwCvqApKS8VcAcuAI+4TWEmom6sBL4ckCJOtRmQKDs
         LnrJg+6VLOjY5CIWKObPMxAx+NTZpxKbFkGqJpLMUHHDU/TxB6iuOaRv8wf523TUb22n
         YKVaiq/wMhZaeFkNsFx87n5nMGLGqXxxAS7U0CoO9kWdApMOZWrQ6FC7h6NSAUVIFqip
         26VUC76FcOM2DZb771WVgFmXaItoT4t9B9Jmv2qMsc7Pslk2eJcoCw5lC4L3SazksBnq
         c428t7vTAwFgzxiv1hQqTtRUO94qnAET69it7s2BryV/utQsBfl6LLJlMN+CyNUJtqPK
         CkXg==
X-Gm-Message-State: AOJu0YyBJec1JrCS3OdyFgiZa+G/HOKdBh6BWfLDjTbjlfN2IS/2DHBl
	brvVh3f0OkF7ujgIhIXrxHM=
X-Google-Smtp-Source: AGHT+IHomonAzl8HfiXtCf0z64PtPB9V6+UgNJjqLqygi2X/AvQRHoOYdU1ZFAZK8ihyBfB0orJgsw==
X-Received: by 2002:a05:6a00:984:b0:6cd:8870:bd1f with SMTP id u4-20020a056a00098400b006cd8870bd1fmr17370227pfg.0.1701363584858;
        Thu, 30 Nov 2023 08:59:44 -0800 (PST)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id g12-20020aa79dcc000000b006cde7044871sm1446057pfq.195.2023.11.30.08.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:59:44 -0800 (PST)
Date: Thu, 30 Nov 2023 08:57:27 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
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
Message-ID: <ZWi+94B+N03pItJl@yury-ThinkPad>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20231121154841.7fc019c8@kernel.org>
 <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <ZWfwcYPLVo+4V8Ps@yury-ThinkPad>
 <20231130120512.GA15408@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130120512.GA15408@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, Nov 30, 2023 at 04:05:12AM -0800, Souradeep Chakrabarti wrote:
> On Wed, Nov 29, 2023 at 06:16:17PM -0800, Yury Norov wrote:
> > On Mon, Nov 27, 2023 at 09:36:38AM +0000, Souradeep Chakrabarti wrote:
> > > 
> > > 
> > > >-----Original Message-----
> > > >From: Jakub Kicinski <kuba@kernel.org>
> > > >Sent: Wednesday, November 22, 2023 5:19 AM
> > > >To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > > >Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > > ><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > > ><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> > > >pabeni@redhat.com; Long Li <longli@microsoft.com>;
> > > >sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
> > > >ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de; linux-
> > > >hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > >linux-rdma@vger.kernel.org; Souradeep Chakrabarti
> > > ><schakrabarti@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>
> > > >Subject: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on
> > > >HT cores
> > > >
> > > >On Tue, 21 Nov 2023 05:54:37 -0800 Souradeep Chakrabarti wrote:
> > > >> Existing MANA design assigns IRQ to every CPUs, including sibling
> > > >> hyper-threads in a core. This causes multiple IRQs to work on same CPU
> > > >> and may reduce the network performance with RSS.
> > > >>
> > > >> Improve the performance by adhering the configuration for RSS, which
> > > >> assigns IRQ on HT cores.
> > > >
> > > >Drivers should not have to carry 120 LoC for something as basic as spreading IRQs.
> > > >Please take a look at include/linux/topology.h and if there's nothing that fits your
> > > >needs there - add it. That way other drivers can reuse it.
> > > Because of the current design idea, it is easier to keep things inside
> > > the mana driver code here. As the idea of IRQ distribution here is :
> > > 1)Loop through interrupts to assign CPU
> > > 2)Find non sibling online CPU from local NUMA and assign the IRQs
> > > on them.
> > > 3)If number of IRQs is more than number of non-sibling CPU in that
> > > NUMA node, then assign on sibling CPU of that node.
> > > 4)Keep doing it till all the online CPUs are used or no more IRQs.
> > > 5)If all CPUs in that node are used, goto next NUMA node with CPU.
> > > Keep doing 2 and 3.
> > > 6) If all CPUs in all NUMA nodes are used, but still there are IRQs
> > > then wrap over from first local NUMA node and continue
> > > doing 2, 3 4 till all IRQs are assigned.
> > 
> > Hi Souradeep,
> > 
> > (Thanks Jakub for sharing this thread with me)
> > 
> > If I understand your intention right, you can leverage the existing
> > cpumask_local_spread().
> > 
> > But I think I've got something better for you. The below series adds
> > a for_each_numa_cpu() iterator, which may help you doing most of the
> > job without messing with nodes internals.
> > 
> > https://lore.kernel.org/netdev/ZD3l6FBnUh9vTIGc@yury-ThinkPad/T/
> >
> Thanks Yur and Jakub. I was trying to find this patch, but unable to find it on that thread.
> Also in net-next I am unable to find it. Can you please tell, if it has been committed?
> If not can you please point me out the correct patch for this macro. It will be
> really helpful.

Try this branch. I just rebased it on top of bitmap-for-next,
but didn't re-test. You may need to exclude the "sched: drop
for_each_numa_hop_mask()" patch.

https://github.com/norov/linux/commits/for_each_numa_cpu

> > By using it, the pseudocode implementing your algorithm may look
> > like this:
> > 
> >         unsigned int cpu, hop;
> >         unsigned int irq = 0;
> > 
> > again:
> >         cpu = get_cpu();
> >         node = cpu_to_node(cpu);
> >         cpumask_copy(cpus, cpu_online_mask);
> > 
> >         for_each_numa_cpu(cpu, hop, node, cpus) {
> >                 /* All siblings are the same for IRQ spreading purpose */
> >                 irq_set_affinity_and_hint(irq, topology_sibling_cpumask());
> > 
> >                 /* One IRQ per sibling group */
> >                 cpumask_andnot(cpus, cpus, topology_sibling_cpumask());
> > 
> >                 if (++irq == num_irqs)
> >                         break;
> >         }
> > 
> >         if (irq < num_irqs)
> >                 goto again;
> > 
> > (Completely not tested, just an idea.)
> >
> I have done similar kind of change for our driver, but constraint here is that total number of IRQs
> can be equal to the total number of online CPUs, in some setup. It is either equal
> to the number of online CPUs or maximum 64 IRQs if online CPUs are more than that.

Not sure I understand you. If you're talking about my proposal,
there's seemingly no constraints on number of CPUs/IRQs.

> So my proposed change is following:
> 
> +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> +{
> +       cpumask_var_t node_cpumask;
> +       int i, cpu, err = 0;
> +       unsigned int  next_node;
> +       cpumask_t visited_cpus;
> +       unsigned int start_node = start_numa_node;
> +       i = 0;
> +       if (!alloc_cpumask_var(&node_cpumask, GFP_KERNEL)) {
> +               err = -ENOMEM;
> +               goto free_mask;
> +       }
> +       cpumask_andnot(&visited_cpus, &visited_cpus, &visited_cpus);
> +       start_node = 1;
> +       for_each_next_node_with_cpus(start_node, next_node) {

If your goal is to maximize locality, this doesn't seem to be correct.
for_each_next_node_with_cpus() is based on next_node(), and so enumerates
nodes in a numerically increasing order. On real machines, it's possible
that numerically adjacent node is not the topologically nearest.

To approach that, for every node kernel maintains a list of equally distant
nodes grouped into hops. You may likely want to use for_each_numa_hop_mask
iterator, which iterated over hops in increasing distance order, instead of
NUMA node numbers.

But I would like to see for_each_numa_cpu() finally merged as a simpler and
nicer alternative.

> +               cpumask_copy(node_cpumask, cpumask_of_node(next_node));
> +               for_each_cpu(cpu, node_cpumask) {
> +                       cpumask_andnot(node_cpumask, node_cpumask,
> +                                      topology_sibling_cpumask(cpu));
> +                       irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu));
> +                       if(++i == nvec)
> +                               goto free_mask;
> +                       cpumask_set_cpu(cpu, &visited_cpus);
> +                       if (cpumask_empty(node_cpumask) && cpumask_weight(&visited_cpus) <
> +                           nr_cpus_node(next_node)) {
> +                               cpumask_copy(node_cpumask, cpumask_of_node(next_node));
> +                               cpumask_andnot(node_cpumask, node_cpumask, &visited_cpus);
> +                               cpu = cpumask_first(node_cpumask);
> +                       }
> +               }
> +               if (next_online_node(next_node) == MAX_NUMNODES)
> +                       next_node = first_online_node;
> +       }
> +free_mask:
> +       free_cpumask_var(node_cpumask);
> +       return err;
> +} 
> 
> I can definitely use the for_each_numa_cpu() instead of my proposed for_each_next_node_with_cpus()
> macro here and that will make it cleaner.
> Thanks for the suggestion.

Sure.

Can you please share performance measurements for a solution you'll
finally choose? Would be interesting to compare different approaches.

Thanks,
Yury

