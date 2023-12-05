Return-Path: <linux-hyperv+bounces-1246-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F95780621F
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 23:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C9C2821EA
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6375D3FE52;
	Tue,  5 Dec 2023 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmAOzcEd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D5EA5;
	Tue,  5 Dec 2023 14:52:09 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db8892a5f96so3384750276.2;
        Tue, 05 Dec 2023 14:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701816729; x=1702421529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcNn42U4c+vJgC2cbv3DXpQ3FnywuQCxcKqtmybhfIA=;
        b=XmAOzcEdJn3ApDtLYzKNGBxrNdI0o4qqhvkOjNTB+XFVaYhxY7ePQs817G5pqgA+TC
         lkimuK4P98hhhpADg77OmhCcvwDixAuHrfa3eKoFAhRoog3hrHKCDUzvwUMsOJVEyWFK
         6n36HdUbZfe6H+HXuRJpt45oPeRnd8eFzGNc9vxPPsXdJSWqy6+Pe+qvwaDC0BCkn9WE
         btaUDR0eY9COltPQfd7uswmJF/Ii9z/VISdR4qSpbdFh7+d0EymobCavBacUEKc8AntL
         UEQijOw0tQkwi8jlLp+hRwMpU3JEFXPBseIG4yNKFnTDvrebTnN+tVQPO4NU4x/1v43N
         CCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701816729; x=1702421529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcNn42U4c+vJgC2cbv3DXpQ3FnywuQCxcKqtmybhfIA=;
        b=KSAlc0knte1YOfJCPW9ZB9n7hGRg7e2sPMg3CKpY0cCn5Fa4OWNP61LA2JLf5TdX9U
         S9QBsHR6gZHnAnRMjSRNH9N6dHv5p7fHynjNH0taGPC80NFEApEeKXHHYyhtCi8HeGwr
         RutPYNREZJHFuYm2BLj+WTVvyQsgDTySpfaEEcaws02sHJZx91RxQhefi74GxdKJQyo0
         VHtCi/ngprIRHQxHHqQSDTs1VDIghGMeMup0epeQMPOMP4Ixwxvu14h5JZT21bBkImF7
         OmO+MXnBCT96eUeDVvm6tE5+LJOzwDGZSTkhOy9Ghv3Un8g9kqHg+pMuIuvFo9EdxIBV
         ibvg==
X-Gm-Message-State: AOJu0YyasbrkANq2GHyCRs8q/+rzwaFsO9i93sujwxIUwpxpMKkJpXZu
	5jZO12c3LaT70A3mx4s4z00=
X-Google-Smtp-Source: AGHT+IHaW8qTDikFMkii/fJOLeKRbKogygQnmaBfNRKT/1Eyhn+SprmKZI/XCNw9CGfSf6a0Azx7dg==
X-Received: by 2002:a25:26ce:0:b0:db7:dacf:61f5 with SMTP id m197-20020a2526ce000000b00db7dacf61f5mr5016860ybm.71.1701816728667;
        Tue, 05 Dec 2023 14:52:08 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:f586:28cf:78eb:e395])
        by smtp.gmail.com with ESMTPSA id g80-20020a25db53000000b00d9c7bf8f32fsm3456417ybf.42.2023.12.05.14.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 14:52:07 -0800 (PST)
Date: Tue, 5 Dec 2023 14:52:06 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	sch^Crabarti@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH V4 net-next] net: mana: Assigning IRQ affinity on HT cores
Message-ID: <ZW+plvYrNvdcSFCB@yury-ThinkPad>
References: <1701679841-9359-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZW3om2dfA4U0lhVY@yury-ThinkPad>
 <20231205110138.GA31232@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205110138.GA31232@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, Dec 05, 2023 at 03:01:38AM -0800, Souradeep Chakrabarti wrote:
> > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > index 6367de0c2c2e..2194a53cce10 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > @@ -1243,15 +1243,57 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> > >  	r->size = 0;
> > >  }
> > >  
> > > +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> > > +{
> > > +	int i = 0, cpu, err = 0;
> > > +	const struct cpumask *node_cpumask;
> > > +	unsigned int  next_node = start_numa_node;
> > > +	cpumask_var_t visited_cpus, node_cpumask_temp;
> > > +
> > > +	if (!zalloc_cpumask_var(&visited_cpus, GFP_KERNEL)) {
> > > +		err = ENOMEM;
> > > +		return err;
> > > +	}
> > > +	if (!zalloc_cpumask_var(&node_cpumask_temp, GFP_KERNEL)) {
> > > +		err = -ENOMEM;
> > > +		return err;
> > > +	}
> > 
> > Can you add a bit more of vertical spacing?
> > 
> > > +	rcu_read_lock();
> > > +	for_each_numa_hop_mask(node_cpumask, next_node) {
> > > +		cpumask_copy(node_cpumask_temp, node_cpumask);
> > > +		for_each_cpu(cpu, node_cpumask_temp) {
> > > +			cpumask_andnot(node_cpumask_temp, node_cpumask_temp,
> > > +				       topology_sibling_cpumask(cpu));
> > > +			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu));
> > > +			if (++i == nvec)
> > > +				goto free_mask;
> > > +			cpumask_set_cpu(cpu, visited_cpus);
> > > +			if (cpumask_empty(node_cpumask_temp)) {
> > > +				cpumask_copy(node_cpumask_temp, node_cpumask);
> > > +				cpumask_andnot(node_cpumask_temp, node_cpumask_temp,
> > > +					       visited_cpus);
> > > +				cpu = 0;
> > > +			}
> > 
> > It feels like you can calculate number of sibling groups in a hop in
> > advance, so that you'll know how many IRQs you want to assign per each
> > hop, and avoid resetting the node_cpumask_temp and spinning in inner
> > loop for more than once...
> > 
> > Can you print your topology, and describe how you want to spread IRQs
> > on it, and how your existing code does spread them?
> >
> The topology of one system is
> > numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
> 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
> 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
> node 0 size: 459521 MB
> node 0 free: 456316 MB
> node 1 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118
> 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143
> 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168
> 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
> node 1 size: 459617 MB
> node 1 free: 456864 MB
> node distances:
> node   0   1
>   0:  10  21
>   1:  21  10
> and I want to spread the IRQs in numa0 node first with 
> CPU0 - IRQ0
> CPU2 - IRQ1
> CPU4 - IRQ2
> CPU6 - IRQ3
> ---
> ---
> ---
> CPU94 - IRQ47
> then
> CPU1 - IRQ48
> CPU3 - IRQ49
> CPU32 - IRQ64
> 
> In a topology where NUMA0 has 20 cores and NUMA1 has 20 cores, with total 80 CPUS, there I want
> CPU0 - IRQ0
> CPU2 - IRQ1
> CPU4 - IRQ2
> ---
> ---
> ---
> CPU38 - IRQ19
> Then
> CPU1 - IRQ20
> CPU3 - IRQ21
> ---
> ---
> CPU39 - IRQ39
> Node1
> CPU40 - IRQ40
> CPU42 - IRQ41
> CPU44 - IRQ42
> ---
> CPU78 - IRQ58
> CPU41 - IRQ59
> CPU43 - IRQ60
> ---
> ---
> CPU49 - IRQ64
>  
> 
> Exisitng code : 
> https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/microsoft/mana/gdma_main.c#L1246
> 
> This uses cpumask_local_spread, so in a system where node has 64 cores, it spreads all 64+1 IRQs on
> 33 cores, rather than spreading it only on HT cores.

So from what you said, it looks like you're trying to implement the
following heuristics:

1. No more than one IRQ per CPU, if possible;
2. NUMA locality is the second priority;
3. Sibling dislocality is the last priority;

Can you confirm that?

If the above correct, your code is quite close to what you want except
that for every new hop (outer loop) you have to clear CPUs belonging to
previous hop, which is in you case the same as visited_cpus mask.

But I think you can do it even better if just account the number of
assigned IRQs. That way you can get rid of the most of housekeeping
code.

const struct cpumask *next, *prev = cpu_none_mask;

for_each_numa_hop_mask(next, node) {
        cpumask_and_not(curr, next, prev);

        for (w = cpumask_weight(curr), cnt = 0; cnt < w; cnt++)
                cpumask_copy(cpus, curr);
                for_each_cpu(cpu, cpus) {
                        if (i++ == nvec)
                                goto done;

                        cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
                        irq_set_affinity_and_hint(irqs[i], topology_sibling_cpumask(cpu)); // [*]
                }
        }
        prev = next;
}

[*] I already mentioned that in v3, and also asking here: if you're saying
that wrt IRQs distribution, all CPUs belonging to the same sibling group
are the same, why don't you assign all the group to the IRQ. It gives the
system flexibility to balance workload better.

Let's consider this topology:

Node            0               1
Core        0       1       2       3
CPU       0   1   2   3   4   5   6   7

The code above should create the following mapping for the IRQs:
IRQ     Nodes   Cores   CPUs
0       1       0       0-1
1       1       1       2-3
2       1       0       0-1
3       1       1       2-3
4       2       2       4-5
5       2       3       6-7
6       2       2       4-5
7       2       3       6-7

This is pretty close to what I proposed in v3, except that it flips
priorities of NUMA locality vs sibling dislocality. My original
suggestion is simpler in implementation and aligns with my natural
feeling of 'fair' IRQ distribution.

Can you make sure that your heuristics are the best wrt performance?

Regarding the rest of the discussion, I think that for_each_numa_hop_mask() 
together with some basic cpumaks operations results quite a readable
and maintainable code, and we don't need any more generic API to
support this type of distribution tasks.

What do you think guys?

Thanks,
Yury

