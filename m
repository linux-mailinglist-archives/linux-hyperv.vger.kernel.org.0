Return-Path: <linux-hyperv+bounces-5461-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C3AB2F1F
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 07:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F7D188F189
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 05:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E957725522A;
	Mon, 12 May 2025 05:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U2aKtvPl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD93D76;
	Mon, 12 May 2025 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747028958; cv=none; b=Y1NC3F7/LlKx8vjvOk7jhW9vv4iEys9ymJTaFFmmAw0ThvbM6uGOpj6h20rIhCRIXMuuxgLYMfZ89lpz6Ng8gxDuEGqS5e4L+fRnVADwsB0uc821Usn4dpTfntZjPj7WcLQ2XbfENQBCS7YExTWBPoHrjPLXKadEqYt1/SlGWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747028958; c=relaxed/simple;
	bh=/ELXrcoudJ0/yyfZ9iRp8dQcHjwyptbaU7dafrBYkuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf2kFws7FumMBmbkWsFGRoT+HhY3hNiNnOOHxrUrIrXKDbnvdDDD0KjQT5kcT1hGB7XvjZ0K6ri+RihapSlDXer10wD4UtH2c9ps0RFsxAggzT9dwRVQB/nZYfYEQ4bnmqaQVjtWv7Dj5whzY1Meauwm4d7cjkXPEawpgGVvf6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U2aKtvPl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id D838C211D8A9; Sun, 11 May 2025 22:49:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D838C211D8A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747028956;
	bh=Jxd+51vRzUJaBk9FClrIMWuUlqsvY1+gj3Emkrxm0PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2aKtvPloYKu5sN9oXVTT1SytD8loBAWvj/T/nU29Il90ByUfnMLE4irySOSnVJZ/
	 BwUnwdsC/C+8nmageNCbrup7csbX4n/98H5wJaigM/LWwPH3xH+J7FGzhj0FfzknVL
	 T0As4t5+nAHJ8kU9ob8urav8PjEjgnzHCnVrl/0U=
Date: Sun, 11 May 2025 22:49:16 -0700
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
	Peter Zijlstra <peterz@infradead.org>, linux-hyperv@vger.kernel.org,
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
Subject: Re: [PATCH v3 3/4] net: mana: Allow irq_setup() to skip cpus for
 affinity
Message-ID: <20250512054916.GA23493@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785625-4753-1-git-send-email-shradhagupta@linux.microsoft.com>
 <aB4kJNG2duAsP8bK@yury>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB4kJNG2duAsP8bK@yury>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, May 09, 2025 at 11:49:56AM -0400, Yury Norov wrote:
> On Fri, May 09, 2025 at 03:13:45AM -0700, Shradha Gupta wrote:
> > In order to prepare the MANA driver to allocate the MSI-X IRQs
> > dynamically, we need to prepare the irq_setup() to allow skipping
> > affinitizing IRQs to first CPU sibling group.
> > 
> > This would be for cases when number of IRQs is less than or equal
> > to number of online CPUs. In such cases for dynamically added IRQs
> > the first CPU sibling group would already be affinitized with HWC IRQ
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/net/ethernet/microsoft/mana/gdma_main.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 4ffaf7588885..2de42ce43373 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -1288,7 +1288,8 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> >  	r->size = 0;
> >  }
> >  
> > -static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> > +static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> > +		     bool skip_first_cpu)
> >  {
> >  	const struct cpumask *next, *prev = cpu_none_mask;
> >  	cpumask_var_t cpus __free(free_cpumask_var);
> > @@ -1303,9 +1304,20 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> >  		while (weight > 0) {
> >  			cpumask_andnot(cpus, next, prev);
> >  			for_each_cpu(cpu, cpus) {
> > +				/*
> > +				 * if the CPU sibling set is to be skipped we
> > +				 * just move on to the next CPUs without len--
> > +				 */
> > +				if (unlikely(skip_first_cpu)) {
> > +					skip_first_cpu = false;
> > +					goto next_cpumask;
> > +				}
> > +
> >  				if (len-- == 0)
> >  					goto done;
> > +
> >  				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> > +next_cpumask:
> >  				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> >  				--weight;
> >  			}
> > @@ -1403,7 +1415,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  		}
> >  	}
> >  
> > -	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
> > +	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node, false);
> 
> What for the 2nd parameter is parenthesized?

right, it is not needed. will correct it. Thanks Yury.

> 
> >  	if (err)
> >  		goto free_irq;
> >  
> > -- 
> > 2.34.1
> 
> 
> Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

