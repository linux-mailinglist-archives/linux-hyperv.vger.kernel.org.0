Return-Path: <linux-hyperv+bounces-5694-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE1AC7E7B
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 15:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FBD4E7C94
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 13:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499B21DE8AD;
	Thu, 29 May 2025 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="isufujcA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937D4647;
	Thu, 29 May 2025 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524525; cv=none; b=L9NbPNKAypb+HqKV9dC7Bz2Jsqee2ntvNXnXTD8KN+y5IAqDgx+4XCWV8WjhRNQAhZ4ipkwg2UgReFE3gTepGFipwLehoa2pWalXaJr/3SbRBChQxfoUi6KnPwbZqjo09dv1cnxRETLIAjvs5cqxmxV/xDg6DwRVc8UoO2aE9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524525; c=relaxed/simple;
	bh=+aU5coUTqdWc4L2KpPHN9OKmnhKhXyOVMxJInCN/ebk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN8T/+tu6tK1s6v2zfyRcBPeSU7yInYJG80VntWGM4HRO6tQCX4WKlc/Q0eGpFEYcFcm2bixZ3FH7WZwWBVG0GFWjdXugZ4DUQ8ptdF/dJdTi18vPbHs6WymvxNWNk7vQIM7AW7pbAvLxZoKngiZ9UYTtrUPaie6WaiX07Qn8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=isufujcA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E6D682078611; Thu, 29 May 2025 06:15:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6D682078611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748524522;
	bh=Ezqk5Ddjq2iKkVzyKUvJjsCMCcife5igRAcu3O9LX2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isufujcARZKa+Tr14FliUe/xB/VXxC27m1DAqmnuRWKLOm2Ltgy1mZ0cGbFwcGGyU
	 CeK09cu9hOkaT2ru0eM9004OXeAe/E755bELXTHgo3EFO2Gpf2v+4BBDo8U0+On3rq
	 MZl0wrfeUcVcIg9nivDlyfHFM9TTy7SiFqLxk7Yk=
Date: Thu, 29 May 2025 06:15:22 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
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
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy???~Dski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4 3/5] net: mana: explain irq_setup() algorithm
Message-ID: <20250529131522.GA27681@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1748361505-25513-1-git-send-email-shradhagupta@linux.microsoft.com>
 <aDYOFzQrfDFcti-u@yury>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDYOFzQrfDFcti-u@yury>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, May 27, 2025 at 03:10:15PM -0400, Yury Norov wrote:
> So now git will think that you're the author of the patch.
> 
> If author and sender are different people, the first line in commit
> message body should state that. In this case, it should be:
> 
> From: Yury Norov <yury.norov@gmail.com>
> 
> Please consider this one example
> 
> https://patchew.org/linux/20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr/20250326-fixed-type-genmasks-v8-6-24afed16ca00@wanadoo.fr/
> 
> Thanks,
> Yury
>

Understood, Thank you Yury. I'll make this change in the next version

Regards,
Shradha. 
> On Tue, May 27, 2025 at 08:58:25AM -0700, Shradha Gupta wrote:
> > Commit 91bfe210e196 ("net: mana: add a function to spread IRQs per CPUs")
> > added the irq_setup() function that distributes IRQs on CPUs according
> > to a tricky heuristic. The corresponding commit message explains the
> > heuristic.
> > 
> > Duplicate it in the source code to make available for readers without
> > digging git in history. Also, add more detailed explanation about how
> > the heuristics is implemented.
> > 
> > Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 4ffaf7588885..f9e8d4d1ba3a 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -1288,6 +1288,47 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> >  	r->size = 0;
> >  }
> >  
> > +/*
> > + * Spread on CPUs with the following heuristics:
> > + *
> > + * 1. No more than one IRQ per CPU, if possible;
> > + * 2. NUMA locality is the second priority;
> > + * 3. Sibling dislocality is the last priority.
> > + *
> > + * Let's consider this topology:
> > + *
> > + * Node            0               1
> > + * Core        0       1       2       3
> > + * CPU       0   1   2   3   4   5   6   7
> > + *
> > + * The most performant IRQ distribution based on the above topology
> > + * and heuristics may look like this:
> > + *
> > + * IRQ     Nodes   Cores   CPUs
> > + * 0       1       0       0-1
> > + * 1       1       1       2-3
> > + * 2       1       0       0-1
> > + * 3       1       1       2-3
> > + * 4       2       2       4-5
> > + * 5       2       3       6-7
> > + * 6       2       2       4-5
> > + * 7       2       3       6-7
> > + *
> > + * The heuristics is implemented as follows.
> > + *
> > + * The outer for_each() loop resets the 'weight' to the actual number
> > + * of CPUs in the hop. Then inner for_each() loop decrements it by the
> > + * number of sibling groups (cores) while assigning first set of IRQs
> > + * to each group. IRQs 0 and 1 above are distributed this way.
> > + *
> > + * Now, because NUMA locality is more important, we should walk the
> > + * same set of siblings and assign 2nd set of IRQs (2 and 3), and it's
> > + * implemented by the medium while() loop. We do like this unless the
> > + * number of IRQs assigned on this hop will not become equal to number
> > + * of CPUs in the hop (weight == 0). Then we switch to the next hop and
> > + * do the same thing.
> > + */
> > +
> >  static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> >  {
> >  	const struct cpumask *next, *prev = cpu_none_mask;
> > -- 
> > 2.34.1

