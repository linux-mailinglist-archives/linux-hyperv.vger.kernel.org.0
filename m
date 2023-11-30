Return-Path: <linux-hyperv+bounces-1151-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2D47FE6A0
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 03:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 916B5B20DE1
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 02:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BECF10795;
	Thu, 30 Nov 2023 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrzwlTA6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35609D5C;
	Wed, 29 Nov 2023 18:18:34 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cdd4aab5f5so469773b3a.3;
        Wed, 29 Nov 2023 18:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701310713; x=1701915513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBdXLaF+9RHMtk4jpl9AirU8X0PKQ3Gndl66cDuFsMk=;
        b=SrzwlTA6cZ3eFQmWITJ8TY4EWEFQmtd33uaImiJXdgR1Gq/khTcR4745JVpjdBPwV4
         h+1FOUZWoGAGD0oZSEgkleg5vYzsNj/lpS3HYpbRxYd0q+D0FPVIX0Aico4q2SM9AdkH
         2fBpKlIU+HiatTGpcmOEZgxMRBzYLQbBm/VCzS0fKtyBlY3JW24s11H5xaq/3cQ58moU
         pR5nasJ3nikjkZM0DbStsHpC8dqXiL8p8D63gdLHgRWiauEmKkrgldrxlpOVWrWFP+Fc
         wE1RrK2hKJ7pO+LnSdJrynOPGC2/fQ4DlceEG92llLXjrYW8UBDIK/DAVybSF4NMOH/Z
         67pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701310713; x=1701915513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBdXLaF+9RHMtk4jpl9AirU8X0PKQ3Gndl66cDuFsMk=;
        b=U1RHAtOBFKaUQNYgZNYu7y7kkBxx+67QFslp93BoWNadON4Z+IzaD+KV8gd/hzXjB5
         3Bp8n7qDsLSL3YtBTKQ/W0G9Mk3WjFO7CwEKSrddd2ozKomz0e5aj1oH6Tly4Oo5jz4u
         6pYWd/WNoPR44nqWpzSKzeFUv5lny6TUXJiFLl5MShVoiava53Tvr+IyIon0UeWBKhQ0
         Rd8De4c1ZTEf/bedQvifrJkJh1nrl4QEkrOjDJixW4ViNl1VvXVl5pCRB4CaeQnwwySs
         9W5WQUiOWIB+kVWMWKL//6/VOtoHBd6Mqe5+04YuooYCxO/bXN0iVa0gnEU8wd4Ho901
         nH0w==
X-Gm-Message-State: AOJu0YyDhDyH0O2dpKpsKJEFtXlgeZjx8VbiQ6TyvvdQa/M5dVBFse0W
	7b/8qvkwF4sjaaNluCguXyE=
X-Google-Smtp-Source: AGHT+IEMehpYQivGc4qoNrA+X6Mg52wOBuwLRso6HELafHFDgLXNLXWSgIvIoWAEwJXDCbsUjJ9oRg==
X-Received: by 2002:a05:6a00:3988:b0:6be:25c5:4f74 with SMTP id fi8-20020a056a00398800b006be25c54f74mr24484777pfb.13.1701310713470;
        Wed, 29 Nov 2023 18:18:33 -0800 (PST)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id fa21-20020a056a002d1500b006cde4c8d94fsm76727pfb.135.2023.11.29.18.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 18:18:33 -0800 (PST)
Date: Wed, 29 Nov 2023 18:16:17 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Souradeep Chakrabarti <schakrabarti@microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
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
Message-ID: <ZWfwcYPLVo+4V8Ps@yury-ThinkPad>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20231121154841.7fc019c8@kernel.org>
 <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>

On Mon, Nov 27, 2023 at 09:36:38AM +0000, Souradeep Chakrabarti wrote:
> 
> 
> >-----Original Message-----
> >From: Jakub Kicinski <kuba@kernel.org>
> >Sent: Wednesday, November 22, 2023 5:19 AM
> >To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> >Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> ><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> ><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> >pabeni@redhat.com; Long Li <longli@microsoft.com>;
> >sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
> >ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de; linux-
> >hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> >linux-rdma@vger.kernel.org; Souradeep Chakrabarti
> ><schakrabarti@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>
> >Subject: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on
> >HT cores
> >
> >On Tue, 21 Nov 2023 05:54:37 -0800 Souradeep Chakrabarti wrote:
> >> Existing MANA design assigns IRQ to every CPUs, including sibling
> >> hyper-threads in a core. This causes multiple IRQs to work on same CPU
> >> and may reduce the network performance with RSS.
> >>
> >> Improve the performance by adhering the configuration for RSS, which
> >> assigns IRQ on HT cores.
> >
> >Drivers should not have to carry 120 LoC for something as basic as spreading IRQs.
> >Please take a look at include/linux/topology.h and if there's nothing that fits your
> >needs there - add it. That way other drivers can reuse it.
> Because of the current design idea, it is easier to keep things inside
> the mana driver code here. As the idea of IRQ distribution here is :
> 1)Loop through interrupts to assign CPU
> 2)Find non sibling online CPU from local NUMA and assign the IRQs
> on them.
> 3)If number of IRQs is more than number of non-sibling CPU in that
> NUMA node, then assign on sibling CPU of that node.
> 4)Keep doing it till all the online CPUs are used or no more IRQs.
> 5)If all CPUs in that node are used, goto next NUMA node with CPU.
> Keep doing 2 and 3.
> 6) If all CPUs in all NUMA nodes are used, but still there are IRQs
> then wrap over from first local NUMA node and continue
> doing 2, 3 4 till all IRQs are assigned.

Hi Souradeep,

(Thanks Jakub for sharing this thread with me)

If I understand your intention right, you can leverage the existing
cpumask_local_spread().

But I think I've got something better for you. The below series adds
a for_each_numa_cpu() iterator, which may help you doing most of the
job without messing with nodes internals.

https://lore.kernel.org/netdev/ZD3l6FBnUh9vTIGc@yury-ThinkPad/T/

By using it, the pseudocode implementing your algorithm may look
like this:

        unsigned int cpu, hop;
        unsigned int irq = 0;

again:
        cpu = get_cpu();
        node = cpu_to_node(cpu);
        cpumask_copy(cpus, cpu_online_mask);

        for_each_numa_cpu(cpu, hop, node, cpus) {
                /* All siblings are the same for IRQ spreading purpose */
                irq_set_affinity_and_hint(irq, topology_sibling_cpumask());

                /* One IRQ per sibling group */
                cpumask_andnot(cpus, cpus, topology_sibling_cpumask());

                if (++irq == num_irqs)
                        break;
        }

        if (irq < num_irqs)
                goto again;

(Completely not tested, just an idea.)

Thanks,
Yury

