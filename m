Return-Path: <linux-hyperv+bounces-5683-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849FFAC712F
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 May 2025 20:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65949E7BEE
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 May 2025 18:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A2E213E91;
	Wed, 28 May 2025 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNgJGCuB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96E19D8A3;
	Wed, 28 May 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748458366; cv=none; b=uH/E/sSZiKqVSGGI1tJytVAPjyXF3ZCIvfuBj2lFVmdkWfmR4cXKww/YXTRpD80DZ9kvIAfu93c+SdF/gmerDvqm6U28RtTgoaA8TTb6tQaauYryq47nMyiAd3x+fHhhgbzstM2fcJEtFiw17Pjex/5Q6SoCIN3t29xxrkEUNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748458366; c=relaxed/simple;
	bh=9EiOv825mSRNiFjE0XeMDKrJmcaqsyKHCtJE7v/ZnNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqoL1ALrhGqHR5egzpv0NYXczoPwtpjAf+r7QKDQUV+swAgu/snvVRq913uVuxye9VdPPPVvSBRojGK1QpISV3BMXgiZT9rqAWVl+SMZrWJDf5jMbDmdOlv8TcrcQAqBqj4j3fP9uEVR8ZXoE+wn0xODf5RD62VmD3orTAlwpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNgJGCuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD512C4CEE3;
	Wed, 28 May 2025 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748458365;
	bh=9EiOv825mSRNiFjE0XeMDKrJmcaqsyKHCtJE7v/ZnNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNgJGCuBl9eorQXMLxrnde/P4zuefhUNO0j8n3okpO/Bkrrq/Fvn5S5unVZevBcY6
	 wi4GU1gMtxbVA65CLqSEIpPjW9rzTjDMPddr45KIFgZd+9V4w8j4949xyfBzp5DAOZ
	 V4XEdRYnKi6VLzZA2lYFWRN0U5QhUNs/1Ewyq/HVee/h8e60+KyxPmYPIwa3RzC+1H
	 X159GKNd6MiAFHTZ+BQGy5d0D0ELMUJZcGdjmDd5/rtuZqPD6MhqW1VQT5ptXv5Imi
	 KjceV4iG/0tSKZtNMhm1rcfP40XXNIt/5cEqnFf949Wix9LUyRVRMfEIPCgvMUgykc
	 +ueSg/LsduAbw==
Date: Wed, 28 May 2025 19:52:35 +0100
From: Simon Horman <horms@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
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
	Krzysztof =?utf-8?Q?Wilczy=EF=BF=BD~Dski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4 5/5] net: mana: Allocate MSI-X vectors dynamically
Message-ID: <20250528185235.GJ1484967@horms.kernel.org>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1748361543-25845-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1748361543-25845-1-git-send-email-shradhagupta@linux.microsoft.com>

On Tue, May 27, 2025 at 08:59:03AM -0700, Shradha Gupta wrote:
> Currently, the MANA driver allocates MSI-X vectors statically based on
> MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> up allocating more vectors than it needs. This is because, by this time
> we do not have a HW channel and do not know how many IRQs should be
> allocated.
> 
> To avoid this, we allocate 1 MSI-X vector during the creation of HWC and
> after getting the value supported by hardware, dynamically add the
> remaining MSI-X vectors.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

...

> +static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
> +{
> +	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	struct gdma_irq_context *gic;
> +	int *irqs, *start_irqs, irq;
> +	unsigned int cpu;
> +	int err, i;
> +
> +	cpus_read_lock();
> +
> +	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
> +	if (!irqs) {
>  		err = -ENOMEM;
> -		goto free_irq_array;
> +		goto free_irq_vector;
>  	}
>  
>  	for (i = 0; i < nvec; i++) {
> -		gic = &gc->irq_contexts[i];
> +		gic = kzalloc(sizeof(*gic), GFP_KERNEL);
> +		if (!gic) {
> +			err = -ENOMEM;
> +			goto free_irq;
> +		}
> +
>  		gic->handler = mana_gd_process_eq_events;
>  		INIT_LIST_HEAD(&gic->eq_list);
>  		spin_lock_init(&gic->lock);
> @@ -1418,69 +1498,128 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
>  				 i - 1, pci_name(pdev));
>  
> -		irq = pci_irq_vector(pdev, i);
> -		if (irq < 0) {
> -			err = irq;
> -			goto free_irq;
> +		irqs[i] = pci_irq_vector(pdev, i);
> +		if (irqs[i] < 0) {
> +			err = irqs[i];
> +			goto free_current_gic;
>  		}
>  
> -		if (!i) {
> -			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> -			if (err)
> -				goto free_irq;
> -
> -			/* If number of IRQ is one extra than number of online CPUs,
> -			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> -			 * same CPU.
> -			 * Else we will use different CPUs for IRQ0 and IRQ1.
> -			 * Also we are using cpumask_local_spread instead of
> -			 * cpumask_first for the node, because the node can be
> -			 * mem only.
> -			 */
> -			if (start_irq_index) {
> -				cpu = cpumask_local_spread(i, gc->numa_node);
> -				irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> -			} else {
> -				irqs[start_irq_index] = irq;
> -			}
> -		} else {
> -			irqs[i - start_irq_index] = irq;
> -			err = request_irq(irqs[i - start_irq_index], mana_gd_intr, 0,
> -					  gic->name, gic);
> -			if (err)
> -				goto free_irq;
> -		}
> +		err = request_irq(irqs[i], mana_gd_intr, 0, gic->name, gic);
> +		if (err)
> +			goto free_current_gic;

Jumping to free_current_gic will free start_irqs.
However, start_irqs isn't initialised until a few lines below.

Flagged by Smatch.

> +
> +		xa_store(&gc->irq_contexts, i, gic, GFP_KERNEL);
>  	}
>  
> -	err = irq_setup(irqs, nvec - start_irq_index, gc->numa_node, false);
> +	/* If number of IRQ is one extra than number of online CPUs,
> +	 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> +	 * same CPU.
> +	 * Else we will use different CPUs for IRQ0 and IRQ1.
> +	 * Also we are using cpumask_local_spread instead of
> +	 * cpumask_first for the node, because the node can be
> +	 * mem only.
> +	 */
> +	start_irqs = irqs;
> +	if (nvec > num_online_cpus()) {
> +		cpu = cpumask_local_spread(0, gc->numa_node);
> +		irq_set_affinity_and_hint(irqs[0], cpumask_of(cpu));
> +		irqs++;
> +		nvec -= 1;
> +	}
> +
> +	err = irq_setup(irqs, nvec, gc->numa_node, false);
>  	if (err)
>  		goto free_irq;
>  
> -	gc->max_num_msix = nvec;
> -	gc->num_msix_usable = nvec;
>  	cpus_read_unlock();
> -	kfree(irqs);
> +	kfree(start_irqs);
>  	return 0;
>  
> +free_current_gic:
> +	kfree(gic);
>  free_irq:
> -	for (j = i - 1; j >= 0; j--) {
> -		irq = pci_irq_vector(pdev, j);
> -		gic = &gc->irq_contexts[j];
> +	for (i -= 1; i >= 0; i--) {
> +		irq = pci_irq_vector(pdev, i);
> +		gic = xa_load(&gc->irq_contexts, i);
> +		if (WARN_ON(!gic))
> +			continue;
>  
>  		irq_update_affinity_hint(irq, NULL);
>  		free_irq(irq, gic);
> +		xa_erase(&gc->irq_contexts, i);
> +		kfree(gic);
>  	}
>  
> -	kfree(gc->irq_contexts);
> -	gc->irq_contexts = NULL;
> -free_irq_array:
> -	kfree(irqs);
> +	kfree(start_irqs);
>  free_irq_vector:
>  	cpus_read_unlock();
> -	pci_free_irq_vectors(pdev);
>  	return err;
>  }

...

