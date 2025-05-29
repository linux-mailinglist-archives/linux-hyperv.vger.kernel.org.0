Return-Path: <linux-hyperv+bounces-5697-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29A9AC7E8D
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 15:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8E91890F53
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707F2253FD;
	Thu, 29 May 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e/Aip7/d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF5E647;
	Thu, 29 May 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524718; cv=none; b=Koua3w1FlH9IE2dsKLSWHYOdP6kH+UkQexhAw4ojFkCoke8GKUQ5B2mR/nmExfYeqXQQURKfLhXLCFFQQqnZTpOPdl83eCazMOXR0+Z/CTcPj6QHnw5SaLFuMk5v5NU4VVGXnWRUpHl0Y6n9DHxYF98+RupRG1/c7qWhQO1X5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524718; c=relaxed/simple;
	bh=dDR19bDC5JZUugujEx5B1RMPL8I48K99kOI0S/WVucA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBmdjjNz81s0G2kgrQYxWN+Uw0pPvE7E2Gm4qhr45I1IWxOFme5KjjqZB4kBUbtSjDvu5QGgLNutRq0j53IU8aB2XYjvEOvySS2pCqmokyOAPEahrNlklB6iL3qeSgafi5Xwz6KfEwbK4AvibhuvdpwVlPtRdJjJI7f09SMtIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e/Aip7/d; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id DC0722078620; Thu, 29 May 2025 06:18:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC0722078620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748524716;
	bh=0YIx+soRnsPMWQGXYcEonREXvzQfM2YauXJU2m6gWKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/Aip7/dtNM7L0sG6qd1E3tSQY9Ihw52xBFbCJFTNqPoUFBdEKWzVGbowRjkfFkdo
	 kyafS+8ThKIeByLNGsTjxlR50BkZibsHpkT5fW7diINAKUlE77lyeS8hPg8wsGDbAy
	 Th6uipLzeRnHtLXhRiyE/lUs7WVYI0BruM1ZzgY0=
Date: Thu, 29 May 2025 06:18:36 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [PATCH v4 5/5] net: mana: Allocate MSI-X vectors dynamically
Message-ID: <20250529131836.GC27681@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1748361543-25845-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250528185235.GJ1484967@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528185235.GJ1484967@horms.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 28, 2025 at 07:52:35PM +0100, Simon Horman wrote:
> On Tue, May 27, 2025 at 08:59:03AM -0700, Shradha Gupta wrote:
> > Currently, the MANA driver allocates MSI-X vectors statically based on
> > MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> > up allocating more vectors than it needs. This is because, by this time
> > we do not have a HW channel and do not know how many IRQs should be
> > allocated.
> > 
> > To avoid this, we allocate 1 MSI-X vector during the creation of HWC and
> > after getting the value supported by hardware, dynamically add the
> > remaining MSI-X vectors.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> ...
> 
> > +static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
> > +{
> > +	struct gdma_context *gc = pci_get_drvdata(pdev);
> > +	struct gdma_irq_context *gic;
> > +	int *irqs, *start_irqs, irq;
> > +	unsigned int cpu;
> > +	int err, i;
> > +
> > +	cpus_read_lock();
> > +
> > +	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
> > +	if (!irqs) {
> >  		err = -ENOMEM;
> > -		goto free_irq_array;
> > +		goto free_irq_vector;
> >  	}
> >  
> >  	for (i = 0; i < nvec; i++) {
> > -		gic = &gc->irq_contexts[i];
> > +		gic = kzalloc(sizeof(*gic), GFP_KERNEL);
> > +		if (!gic) {
> > +			err = -ENOMEM;
> > +			goto free_irq;
> > +		}
> > +
> >  		gic->handler = mana_gd_process_eq_events;
> >  		INIT_LIST_HEAD(&gic->eq_list);
> >  		spin_lock_init(&gic->lock);
> > @@ -1418,69 +1498,128 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> >  			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
> >  				 i - 1, pci_name(pdev));
> >  
> > -		irq = pci_irq_vector(pdev, i);
> > -		if (irq < 0) {
> > -			err = irq;
> > -			goto free_irq;
> > +		irqs[i] = pci_irq_vector(pdev, i);
> > +		if (irqs[i] < 0) {
> > +			err = irqs[i];
> > +			goto free_current_gic;
> >  		}
> >  
> > -		if (!i) {
> > -			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> > -			if (err)
> > -				goto free_irq;
> > -
> > -			/* If number of IRQ is one extra than number of online CPUs,
> > -			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> > -			 * same CPU.
> > -			 * Else we will use different CPUs for IRQ0 and IRQ1.
> > -			 * Also we are using cpumask_local_spread instead of
> > -			 * cpumask_first for the node, because the node can be
> > -			 * mem only.
> > -			 */
> > -			if (start_irq_index) {
> > -				cpu = cpumask_local_spread(i, gc->numa_node);
> > -				irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> > -			} else {
> > -				irqs[start_irq_index] = irq;
> > -			}
> > -		} else {
> > -			irqs[i - start_irq_index] = irq;
> > -			err = request_irq(irqs[i - start_irq_index], mana_gd_intr, 0,
> > -					  gic->name, gic);
> > -			if (err)
> > -				goto free_irq;
> > -		}
> > +		err = request_irq(irqs[i], mana_gd_intr, 0, gic->name, gic);
> > +		if (err)
> > +			goto free_current_gic;
> 
> Jumping to free_current_gic will free start_irqs.
> However, start_irqs isn't initialised until a few lines below.
> 
> Flagged by Smatch.
> 

Thanks Simon, I'll get this in next version

> > +
> > +		xa_store(&gc->irq_contexts, i, gic, GFP_KERNEL);
> >  	}
> >  
> > -	err = irq_setup(irqs, nvec - start_irq_index, gc->numa_node, false);
> > +	/* If number of IRQ is one extra than number of online CPUs,
> > +	 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> > +	 * same CPU.
> > +	 * Else we will use different CPUs for IRQ0 and IRQ1.
> > +	 * Also we are using cpumask_local_spread instead of
> > +	 * cpumask_first for the node, because the node can be
> > +	 * mem only.
> > +	 */
> > +	start_irqs = irqs;
> > +	if (nvec > num_online_cpus()) {
> > +		cpu = cpumask_local_spread(0, gc->numa_node);
> > +		irq_set_affinity_and_hint(irqs[0], cpumask_of(cpu));
> > +		irqs++;
> > +		nvec -= 1;
> > +	}
> > +
> > +	err = irq_setup(irqs, nvec, gc->numa_node, false);
> >  	if (err)
> >  		goto free_irq;
> >  
> > -	gc->max_num_msix = nvec;
> > -	gc->num_msix_usable = nvec;
> >  	cpus_read_unlock();
> > -	kfree(irqs);
> > +	kfree(start_irqs);
> >  	return 0;
> >  
> > +free_current_gic:
> > +	kfree(gic);
> >  free_irq:
> > -	for (j = i - 1; j >= 0; j--) {
> > -		irq = pci_irq_vector(pdev, j);
> > -		gic = &gc->irq_contexts[j];
> > +	for (i -= 1; i >= 0; i--) {
> > +		irq = pci_irq_vector(pdev, i);
> > +		gic = xa_load(&gc->irq_contexts, i);
> > +		if (WARN_ON(!gic))
> > +			continue;
> >  
> >  		irq_update_affinity_hint(irq, NULL);
> >  		free_irq(irq, gic);
> > +		xa_erase(&gc->irq_contexts, i);
> > +		kfree(gic);
> >  	}
> >  
> > -	kfree(gc->irq_contexts);
> > -	gc->irq_contexts = NULL;
> > -free_irq_array:
> > -	kfree(irqs);
> > +	kfree(start_irqs);
> >  free_irq_vector:
> >  	cpus_read_unlock();
> > -	pci_free_irq_vectors(pdev);
> >  	return err;
> >  }
> 
> ...

