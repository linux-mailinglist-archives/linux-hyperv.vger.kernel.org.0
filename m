Return-Path: <linux-hyperv+bounces-5523-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326AAB7CC0
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 06:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A737F3A8B62
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 04:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588E25E823;
	Thu, 15 May 2025 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D0XhA469"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF214B1E49;
	Thu, 15 May 2025 04:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747284681; cv=none; b=KQmKV/3YgVSk2HEdUqK+wS8uuYkVYz0Hv0IYUQZvnmRCA3NNSc+x3BEk+VX4kQc/2pVbdTUIyzqVzc2JCHIMj0YlIeEZF042GpuxQIZ4VsugEf9B+JruRC3hkaimyrYdq1MVzG6DcpH0wDWtHU5M/LrO0Jmgzfl5HAkNkFdd5f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747284681; c=relaxed/simple;
	bh=OwDT9D2s/x+E+dTKnaaPGtdy53NW6+Y5seO74clNOkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWGJ6ABORUqpquK1P8HlJCKcIkJrnDLC9/3jC/jDrkQkLOs5XuDyCwyUB/yII0FRunfYZXUWItTxAT+ea/EA1W3Clou3eaeiQHTGZqJ4X3GT12HVEjHP/+urrjz7p2FBS6N4CUL3a/0ho/YR0SokFMj3/y33VQnm8phezGogSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D0XhA469; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id C35B7201DB25; Wed, 14 May 2025 21:51:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C35B7201DB25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747284679;
	bh=NwCVHk1zwv6ufK+E+alq6OT7sWvQmDej52f9l0dgCjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0XhA469lUmJwmqPdxcpuvAnjK3vhkfnEVz6S1aajXx2cQ25KVoC3ry56wlVADPF8
	 /u8pdBTKTR2iN3TmenQWvMdPsfqvqTk3JT/1GJAeIJrhXWf2+bZ75WbxcJnIP6Rspo
	 irgnJAQdBOW73EG1ygy63FLHztFxIXhczS8VGR0E=
Date: Wed, 14 May 2025 21:51:19 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Dexuan Cui <decui@microsoft.com>,
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
Message-ID: <20250515045119.GB5681@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785625-4753-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SN6PR02MB41577E2FAA79E2803C3384B0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aCTK5PjV1n1EYOpi@yury>
 <SN6PR02MB4157AA971E41FE92B1878F9DD491A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aCTZ0J8F7JkWMlYW@yury>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCTZ0J8F7JkWMlYW@yury>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 14, 2025 at 01:58:40PM -0400, Yury Norov wrote:
> On Wed, May 14, 2025 at 05:26:45PM +0000, Michael Kelley wrote:
> > > Hope that helps.
> > 
> > Yes, that helps! So the key to understanding "weight" is that
> > NUMA locality is preferred over sibling dislocality.
> > 
> > This is a great summary!  All or most of it should go as a
> > comment describing the function and what it is trying to do.
> 
> OK, please consider applying:
> 
> >From abdf5cc6dabd7f433b1d1e66db86333a33a2cd15 Mon Sep 17 00:00:00 2001
> From: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> Date: Wed, 14 May 2025 13:45:26 -0400
> Subject: [PATCH] net: mana: explain irq_setup() algorithm
> 
> Commit 91bfe210e196 ("net: mana: add a function to spread IRQs per CPUs")
> added the irq_setup() function that distributes IRQs on CPUs according
> to a tricky heuristic. The corresponding commit message explains the
> heuristic.
> 
> Duplicate it in the source code to make available for readers without
> digging git in history. Also, add more detailed explanation about how
> the heuristics is implemented.
> 
> Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 4ffaf7588885..f9e8d4d1ba3a 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1288,6 +1288,47 @@ void mana_gd_free_res_map(struct gdma_resource *r)
>  	r->size = 0;
>  }
>  
> +/*
> + * Spread on CPUs with the following heuristics:
> + *
> + * 1. No more than one IRQ per CPU, if possible;
> + * 2. NUMA locality is the second priority;
> + * 3. Sibling dislocality is the last priority.
> + *
> + * Let's consider this topology:
> + *
> + * Node            0               1
> + * Core        0       1       2       3
> + * CPU       0   1   2   3   4   5   6   7
> + *
> + * The most performant IRQ distribution based on the above topology
> + * and heuristics may look like this:
> + *
> + * IRQ     Nodes   Cores   CPUs
> + * 0       1       0       0-1
> + * 1       1       1       2-3
> + * 2       1       0       0-1
> + * 3       1       1       2-3
> + * 4       2       2       4-5
> + * 5       2       3       6-7
> + * 6       2       2       4-5
> + * 7       2       3       6-7
> + *
> + * The heuristics is implemented as follows.
> + *
> + * The outer for_each() loop resets the 'weight' to the actual number
> + * of CPUs in the hop. Then inner for_each() loop decrements it by the
> + * number of sibling groups (cores) while assigning first set of IRQs
> + * to each group. IRQs 0 and 1 above are distributed this way.
> + *
> + * Now, because NUMA locality is more important, we should walk the
> + * same set of siblings and assign 2nd set of IRQs (2 and 3), and it's
> + * implemented by the medium while() loop. We do like this unless the
> + * number of IRQs assigned on this hop will not become equal to number
> + * of CPUs in the hop (weight == 0). Then we switch to the next hop and
> + * do the same thing.
> + */
> +
>  static int irq_setup(unsigned int *irqs, unsigned int len, int node)
>  {
>  	const struct cpumask *next, *prev = cpu_none_mask;

Thank you Yury,

I will include this patch in the patchset with the next version.

> -- 
> 2.43.0

