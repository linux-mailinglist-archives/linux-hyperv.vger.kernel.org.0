Return-Path: <linux-hyperv+bounces-1190-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B198037B1
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 15:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496541F21209
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01A328DD7;
	Mon,  4 Dec 2023 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpaj7DMM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23BA1;
	Mon,  4 Dec 2023 06:56:29 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d6b9143782so28028837b3.0;
        Mon, 04 Dec 2023 06:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701701789; x=1702306589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Utp+O7GRH/D7eVJWmR5yRRgItcVJjKaGlGf4GPfFyM8=;
        b=Wpaj7DMM/lv40OJeJqZ9AcJAZBeNI+HYz10khwH+8E9YGFrioYjcNRclQvtjnTg2jh
         nFmUvzslpnzuQhPY3vm9z7PxbUIsPZ091yzdl2aRuIBQv+5DHNboB2S40/3roKx30bup
         Efp2LNPe7ozj7uWtkYAdmVe4DsSEQmKg3wOGHiJeinJoTeojnoC+V5VqE/vsJv3MCkn2
         ZM9ZLg9VZOYeMyfueTibA2eeUurfQxbjHs50D+UnNibDP7IkuXbWL7XNTVa6wrHwO+sZ
         QWi0/qzqoXoe2QIQCdvAQEuyxPCf/UChKPKTL4DpToFWWG/EXjq7ywcp0GhSGSsOE8af
         II/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701789; x=1702306589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Utp+O7GRH/D7eVJWmR5yRRgItcVJjKaGlGf4GPfFyM8=;
        b=smeM8qA9XVYlU7fbdifkVPqIxqfiFnNk25rS2DctMTDJZ3S7PAF+t7tUhglu+yaASZ
         Wp+rqcF87l4d6ZxxNiewfrFk5CMYL2CvhB/o7f7NKkLE4BxnSI8tg5/aEdg0Ji93XkHN
         F87QUIY2xplpURyNRuCcoS8n1isHx9I+VYt22O46b+j4OqUlpmXwg//kIiXTUxvKaP19
         UIHTHVKwjXq5ipyhvIHUTolW2a/3WrVLZOVBYs6TuCGPkcfqqUyZtLZwevvAcZdaYc6F
         HTZOt+e29vXR2jbtNbXSdqFmGlNQeInQL5zJwvzQBqLRNysLkiOHxPT09TQgRoGh9tF7
         O/qQ==
X-Gm-Message-State: AOJu0Yx+4YdAfBk1aX0WigIzvrt4BTGPYN7K3hvb/ezty4PyUsM5RehB
	zEF7ApizlNq8x9myJdbMD0E=
X-Google-Smtp-Source: AGHT+IF+bQywTgvuHQE83tWnJVM0Plx7zMuSqkbDT1L6Wa0s0IjIzrNA3VhWCDFOGkjjPW8UPNyqvw==
X-Received: by 2002:a81:ae4a:0:b0:5d7:1940:7d62 with SMTP id g10-20020a81ae4a000000b005d719407d62mr2854310ywk.57.1701701788662;
        Mon, 04 Dec 2023 06:56:28 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:3c76:612b:b76f:61a6])
        by smtp.gmail.com with ESMTPSA id b1-20020a0dd901000000b005d855644914sm1001428ywe.58.2023.12.04.06.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:56:28 -0800 (PST)
Date: Mon, 4 Dec 2023 06:56:27 -0800
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
Message-ID: <ZW3om2dfA4U0lhVY@yury-ThinkPad>
References: <1701679841-9359-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701679841-9359-1-git-send-email-schakrabarti@linux.microsoft.com>

On Mon, Dec 04, 2023 at 12:50:41AM -0800, Souradeep Chakrabarti wrote:
> Existing MANA design assigns IRQ to every CPU, including sibling
> hyper-threads. This may cause multiple IRQs to be active simultaneously
> in the same core and may reduce the network performance with RSS.
> 
> Improve the performance by assigning IRQ to non sibling CPUs in local
> NUMA node.
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V3 -> V4:
> * Used for_each_numa_hop_mask() macro and simplified the code.
> Thanks to Yury Norov for the suggestion.

We've got a special tag for this:

Suggested-by: Yury Norov <yury.norov@gmali.com>

> * Added code to assign hwc irq separately in mana_gd_setup_irqs.
> 
> V2 -> V3:
> * Created a helper function to get the next NUMA with CPU.
> * Added some error checks for unsuccessful memory allocation.
> * Fixed some comments on the code.
> 
> V1 -> V2:
> * Simplified the code by removing filter_mask_list and using avail_cpus.
> * Addressed infinite loop issue when there are numa nodes with no CPUs.
> * Addressed uses of local numa node instead of 0 to start.
> * Removed uses of BUG_ON.
> * Placed cpus_read_lock in parent function to avoid num_online_cpus
>   to get changed before function finishes the affinity assignment.
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 70 +++++++++++++++++--
>  1 file changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 6367de0c2c2e..2194a53cce10 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1243,15 +1243,57 @@ void mana_gd_free_res_map(struct gdma_resource *r)
>  	r->size = 0;
>  }
>  
> +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> +{
> +	int i = 0, cpu, err = 0;
> +	const struct cpumask *node_cpumask;
> +	unsigned int  next_node = start_numa_node;
> +	cpumask_var_t visited_cpus, node_cpumask_temp;
> +
> +	if (!zalloc_cpumask_var(&visited_cpus, GFP_KERNEL)) {
> +		err = ENOMEM;
> +		return err;
> +	}
> +	if (!zalloc_cpumask_var(&node_cpumask_temp, GFP_KERNEL)) {
> +		err = -ENOMEM;
> +		return err;
> +	}

Can you add a bit more of vertical spacing?

> +	rcu_read_lock();
> +	for_each_numa_hop_mask(node_cpumask, next_node) {
> +		cpumask_copy(node_cpumask_temp, node_cpumask);
> +		for_each_cpu(cpu, node_cpumask_temp) {
> +			cpumask_andnot(node_cpumask_temp, node_cpumask_temp,
> +				       topology_sibling_cpumask(cpu));
> +			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu));
> +			if (++i == nvec)
> +				goto free_mask;
> +			cpumask_set_cpu(cpu, visited_cpus);
> +			if (cpumask_empty(node_cpumask_temp)) {
> +				cpumask_copy(node_cpumask_temp, node_cpumask);
> +				cpumask_andnot(node_cpumask_temp, node_cpumask_temp,
> +					       visited_cpus);
> +				cpu = 0;
> +			}

It feels like you can calculate number of sibling groups in a hop in
advance, so that you'll know how many IRQs you want to assign per each
hop, and avoid resetting the node_cpumask_temp and spinning in inner
loop for more than once...

Can you print your topology, and describe how you want to spread IRQs
on it, and how your existing code does spread them?

Please add performance results in the commit message.

I feel like this may be a useful code for other kernel folks, and if
so, we'd invest in it for more and make it a generic API, similar to
cpumaks_local_spread()...

> +		}
> +	}
> +free_mask:
> +	rcu_read_unlock();
> +	free_cpumask_var(visited_cpus);
> +	free_cpumask_var(node_cpumask_temp);
> +	return err;
> +}
> +
>  static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  {
> -	unsigned int max_queues_per_port = num_online_cpus();
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	unsigned int max_queues_per_port;
>  	struct gdma_irq_context *gic;
>  	unsigned int max_irqs, cpu;
> -	int nvec, irq;
> +	int nvec, *irqs, irq;
>  	int err, i = 0, j;
>  
> +	cpus_read_lock();
> +	max_queues_per_port = num_online_cpus();
>  	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
>  		max_queues_per_port = MANA_MAX_NUM_QUEUES;
>  
> @@ -1261,6 +1303,11 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
>  	if (nvec < 0)
>  		return nvec;
> +	irqs = kmalloc_array(max_queues_per_port, sizeof(int), GFP_KERNEL);
> +	if (!irqs) {
> +		err = -ENOMEM;
> +		goto free_irq_vector;
> +	}
>  
>  	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
>  				   GFP_KERNEL);
> @@ -1287,21 +1334,28 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  			goto free_irq;
>  		}
>  
> -		err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> +		if (!i) {
> +			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> +			cpu = cpumask_local_spread(i, gc->numa_node);

If i == 0, you can simplify it because you just need the 1st CPU from
a given node.

> +			irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> +		} else {
> +			irqs[i - 1] = irq;
> +			err = request_irq(irqs[i - 1], mana_gd_intr, 0, gic->name, gic);
> +		}
>  		if (err)
>  			goto free_irq;
> -
> -		cpu = cpumask_local_spread(i, gc->numa_node);
> -		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
>  	}
>  
> +	err = irq_setup(irqs, max_queues_per_port, gc->numa_node);
> +	if (err)
> +		goto free_irq;
>  	err = mana_gd_alloc_res_map(nvec, &gc->msix_resource);
>  	if (err)
>  		goto free_irq;
>  
>  	gc->max_num_msix = nvec;
>  	gc->num_msix_usable = nvec;
> -
> +	cpus_read_unlock();
>  	return 0;
>  
>  free_irq:
> @@ -1314,8 +1368,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  	}
>  
>  	kfree(gc->irq_contexts);
> +	kfree(irqs);
>  	gc->irq_contexts = NULL;
>  free_irq_vector:
> +	cpus_read_unlock();
>  	pci_free_irq_vectors(pdev);
>  	return err;
>  }
> -- 
> 2.34.1

