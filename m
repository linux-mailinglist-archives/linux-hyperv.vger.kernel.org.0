Return-Path: <linux-hyperv+bounces-4944-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD04A909E8
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 19:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE4518953DC
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA61209673;
	Wed, 16 Apr 2025 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzlb+s0R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D4317A304;
	Wed, 16 Apr 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824130; cv=none; b=idStycrfwxRLmLVUbdHzyvTG+7HAFm1hhsHmx1xklfYhJ51LokQPECeoFMMX9pWE7WlKjxoAfVaMuBbM025SfHK68wUY3tpjCb++QKWsmfw01UdxzsEX1ySOKfSR7Inkc33yBL/QQjOd7b036uSqUGrcOcyKd7TU8i5eU9QagCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824130; c=relaxed/simple;
	bh=6Sn255yQfUIGa0IOLutvzrkTFiRL6R6L0MgZwWeheFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZRGm3PJH7Rhc3xvOwSasYuhYSginbBYUFqQmKJ788CyQmW6CcNqa5Rm9XId6R8fTMB9DzXEYhPKOCAdOhVZCapGFMmt0YRhma8iwRBMxYYfOm27HceGoXnhvqkq24+211hRzv5jm5dnbH7LY1/Z1yCANfJYDtdnO8rvbZIJ8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzlb+s0R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2295d78b433so74433895ad.2;
        Wed, 16 Apr 2025 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824128; x=1745428928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd91NMAthTnzIHbc2rUnb57dl6f+hm147S2BA0xzICk=;
        b=Vzlb+s0RKUU/JKEm5UmKm6zuXyMnFNDaiybrYfPf31RgcP+RBpwfCBsE+/W0Ac7ITw
         7FX5nt2gkhAA4WugHrrS9exkKlWHu5yXedh2xo/wy94/PzbSAwnc/UStWyxr/WwyxFHu
         VSp1e+jz2GpslaXIslowSswPngn6uudKt9c7b0CqE9x7tlxNfAu2lB5IPC7xrX2dV1EW
         /XHOEIKw4nE0P99ghDkmkfD4YAtzOzY19ryuJKXM5IjfcToiazhbnmhK+9s4ziuXkXKf
         H8WlXixWHpYX7iAtXx23HPzwY1tM1+v6oyxBAQRzCI0eboBKuHIWMzaxsg0lnkeo5Ajb
         mjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824128; x=1745428928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd91NMAthTnzIHbc2rUnb57dl6f+hm147S2BA0xzICk=;
        b=HBbZMuDb3Nn34VyzxFVoYJDJGvVFTL8PI27p/qLzgO2mRQYcM6yBBeZfJZPRixVIdr
         9l3ao6Q/kZBit3je6nA4WJvLqAR6uojzcL67VwmqX3GzhcVc6Xen84nn9IskdkG8F9++
         QaTY60GnE49DgZ+HwggSV3r2+r6+JlnfU94czIcvBeCLK2f6TUePPPsYiKU2YEO9G/pz
         FPV/ACvJBd5BKdVQsNACTjjkyTBLbhaC6lp+c4AehQ04l0aqPtzXc4poxxvmppKDg4g5
         WuMXy2BY2+ExtGo4lex35OJCbzZvV1McqYC0HXM5O2EPunsLfkXC3dCaArAtyLynVgsP
         6qtA==
X-Forwarded-Encrypted: i=1; AJvYcCUt1g4zG3ci7kPJf2YIgO/HzJlmZl4P9sH1f4hJsph4irUnHamEZTS1JtpcyPzD3vt5M8DhCf3u/4nXLxs=@vger.kernel.org, AJvYcCVWqE8KTRZoUR0R5cuO2UWDOi6NPfm5j4dJC3b718omfeXu9T8+2FegLs7gLgso7fRb1q+O4l2lQtWUZA==@vger.kernel.org, AJvYcCXh+5+nqTpfT2yMLaLzYKrtNAg0/O7tHaIQ40vck/W4ukU+2G9kpV/mHBuLD+0kMvbXs0+eYIgpI5TS@vger.kernel.org, AJvYcCXz6ZuR21Up2TRIfta8brzbvbJo4T5c1YD4PpH0QcdAtQ5axPR0MgG0qZCT6DjB6GzZbXTZHTc5@vger.kernel.org
X-Gm-Message-State: AOJu0YzvUMMAFFF8mjaiR/Z17C3aF88tPklF1wJIh5Kytq9Vkrh3tdKr
	+7mCx30MY7Qx767AUL2HWwNsHj9GxX4mXabt5x3KylF1Xf7RZYhD
X-Gm-Gg: ASbGncuawhuQ30Ddw6MAfC2kXDdR/UCIfMWE6fxdygCp7vFiL1cmwonDNky4kL+759m
	RMqmHNf/ZFjlPc6vGAiaWIrCySueQdYIR3+ehsB5UPjRhxruI6iEPuTpA7SzTgNhlKf3JKWtexv
	pxYMxXqRN6hXKYg20qeT6dM9vGPo8F7YSgAAhET52onQQ0HOXbpSIQCc4SPUELUMQwqwUUg//KO
	KZ6OzxZCXRDixHhwFzo3l+oiQLnfD6znh4v36IjzwF8u0aMV0u36yWeJ2uqPDoh+o/9H9Z4jh6l
	DlVSUOAIaNTNrwLOczh2gZ8cmV4WrS1HQ8ItuM/A
X-Google-Smtp-Source: AGHT+IGpJD28uA2f80ACZDcunj8bJZafnSOWNjutV9JtTbJkTqQgogEvDoBn4+W6C4xMTYr0QQayQA==
X-Received: by 2002:a17:903:98f:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-22c358ddbc3mr55508995ad.12.1744824127865;
        Wed, 16 Apr 2025 10:22:07 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1e8f1sm16859005ad.100.2025.04.16.10.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:22:07 -0700 (PDT)
Date: Wed, 16 Apr 2025 13:22:04 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
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
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH 2/2] net: mana: Allow MANA driver to allocate PCI vector
 dynamically
Message-ID: <Z__nPAIE5kdFQRe8@yury>
References: <1744817747-2920-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1744817781-3243-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744817781-3243-1-git-send-email-shradhagupta@linux.microsoft.com>

On Wed, Apr 16, 2025 at 08:36:21AM -0700, Shradha Gupta wrote:
> Currently, the MANA driver allocates pci vector statically based on
> MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> up allocating more vectors than it needs.
> This is because, by this time we do not have a HW channel and do not know
> how many IRQs should be allocated.
> To avoid this, we allocate 1 IRQ vector during the creation of HWC and
> after getting the value supported by hardware, dynamically add the
> remaining vectors.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 306 ++++++++++++++----
>  include/net/mana/gdma.h                       |   5 +-
>  2 files changed, 250 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 4ffaf7588885..3e3b5854b736 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -6,6 +6,9 @@
>  #include <linux/pci.h>
>  #include <linux/utsname.h>
>  #include <linux/version.h>
> +#include <linux/msi.h>
> +#include <linux/irqdomain.h>
> +#include <linux/list.h>
>  
>  #include <net/mana/mana.h>
>  
> @@ -80,8 +83,15 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  		return err ? err : -EPROTO;
>  	}
>  
> -	if (gc->num_msix_usable > resp.max_msix)
> -		gc->num_msix_usable = resp.max_msix;
> +	if (!pci_msix_can_alloc_dyn(pdev)) {
> +		if (gc->num_msix_usable > resp.max_msix)
> +			gc->num_msix_usable = resp.max_msix;
> +	} else {
> +		/* If dynamic allocation is enabled we have already allocated
> +		 * hwc msi
> +		 */
> +		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
> +	}
>  
>  	if (gc->num_msix_usable <= 1)
>  		return -ENOSPC;
> @@ -465,9 +475,10 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
>  	struct gdma_irq_context *gic;
>  	struct gdma_context *gc;
>  	unsigned int msi_index;
> -	unsigned long flags;
> +	struct list_head *pos;
> +	unsigned long flags, flag_irq;
>  	struct device *dev;
> -	int err = 0;
> +	int err = 0, count;
>  
>  	gc = gd->gdma_context;
>  	dev = gc->dev;
> @@ -482,7 +493,22 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
>  	}
>  
>  	queue->eq.msix_index = msi_index;
> -	gic = &gc->irq_contexts[msi_index];
> +
> +	/* get the msi_index value from the list*/
> +	count = 0;
> +	spin_lock_irqsave(&gc->irq_ctxs_lock, flag_irq);
> +	list_for_each(pos, &gc->irq_contexts) {
> +		if (count == msi_index) {
> +			gic = list_entry(pos, struct gdma_irq_context, gic_list);
> +			break;
> +		}
> +
> +		count++;
> +	}
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flag_irq);
> +
> +	if (!gic)
> +		return -1;
>  
>  	spin_lock_irqsave(&gic->lock, flags);
>  	list_add_rcu(&queue->entry, &gic->eq_list);
> @@ -497,8 +523,10 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
>  	struct gdma_irq_context *gic;
>  	struct gdma_context *gc;
>  	unsigned int msix_index;
> -	unsigned long flags;
> +	struct list_head *pos;
> +	unsigned long flags, flag_irq;
>  	struct gdma_queue *eq;
> +	int count;
>  
>  	gc = gd->gdma_context;
>  
> @@ -507,7 +535,22 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
>  	if (WARN_ON(msix_index >= gc->num_msix_usable))
>  		return;
>  
> -	gic = &gc->irq_contexts[msix_index];
> +	/* get the msi_index value from the list*/
> +	count = 0;
> +	spin_lock_irqsave(&gc->irq_ctxs_lock, flag_irq);
> +	list_for_each(pos, &gc->irq_contexts) {
> +		if (count == msix_index) {
> +			gic = list_entry(pos, struct gdma_irq_context, gic_list);
> +			break;
> +		}
> +
> +		count++;
> +	}
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flag_irq);
> +
> +	if (!gic)
> +		return;
> +
>  	spin_lock_irqsave(&gic->lock, flags);
>  	list_for_each_entry_rcu(eq, &gic->eq_list, entry) {
>  		if (queue == eq) {
> @@ -1288,11 +1331,11 @@ void mana_gd_free_res_map(struct gdma_resource *r)
>  	r->size = 0;
>  }
>  
> -static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> +static int irq_setup(unsigned int *irqs, unsigned int len, int node, int skip_cpu)
>  {
>  	const struct cpumask *next, *prev = cpu_none_mask;
>  	cpumask_var_t cpus __free(free_cpumask_var);
> -	int cpu, weight;
> +	int cpu, weight, i = 0;
>  
>  	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
>  		return -ENOMEM;
> @@ -1303,9 +1346,21 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node)
>  		while (weight > 0) {
>  			cpumask_andnot(cpus, next, prev);
>  			for_each_cpu(cpu, cpus) {
> +				/* If the call is made for irqs which are dynamically
> +				 * added and the num of vcpus is more or equal to
> +				 * allocated msix, we need to skip the first
> +				 * set of cpus, since they are already affinitized

Can you replace the 'set of cpus' with a 'sibling group'?

> +				 * to HWC IRQ
> +				 */

This comment should not be here. This is a helper function. User may
want to skip 1st CPU for whatever reason. Please put the comment in
mana_gd_setup_dyn_irqs().

> +				if (skip_cpu && !i) {
> +					i = 1;
> +					goto next_cpumask;
> +				}

The 'skip_cpu' variable should be a boolean, and has more a specific
name. And you don't need the local 'i' to implement your logic:

        			if (unlikely(skip_first_cpu)) {
                                        skip_first_cpu = false;
        				goto next_sibling;
        			}

>  				if (len-- == 0)
>  					goto done;

This check should go before the one you're adding here.

> +
>  				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> +next_cpumask:
>  				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
>  				--weight;
>  			}
> @@ -1317,29 +1372,92 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node)
>  	return 0;
>  }
>  
> -static int mana_gd_setup_irqs(struct pci_dev *pdev)
> +static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  {
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
> -	unsigned int max_queues_per_port;
>  	struct gdma_irq_context *gic;
> -	unsigned int max_irqs, cpu;
> -	int start_irq_index = 1;
> -	int nvec, *irqs, irq;
> +	int *irqs, irq, skip_first_cpu = 0;
> +	unsigned long flags;
>  	int err, i = 0, j;
>  
>  	cpus_read_lock();
> -	max_queues_per_port = num_online_cpus();
> -	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> -		max_queues_per_port = MANA_MAX_NUM_QUEUES;
> +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> +	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
> +	if (!irqs) {
> +		err = -ENOMEM;
> +		goto free_irq_vector;
> +	}
>  
> -	/* Need 1 interrupt for the Hardware communication Channel (HWC) */
> -	max_irqs = max_queues_per_port + 1;
> +	for (i = 0; i < nvec; i++) {
> +		gic = kcalloc(1, sizeof(struct gdma_irq_context), GFP_KERNEL);
> +		if (!gic) {
> +			err = -ENOMEM;
> +			goto free_irq;
> +		}
> +		gic->handler = mana_gd_process_eq_events;
> +		INIT_LIST_HEAD(&gic->eq_list);
> +		spin_lock_init(&gic->lock);
>  
> -	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> -	if (nvec < 0) {
> -		cpus_read_unlock();
> -		return nvec;
> +		snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
> +			 i, pci_name(pdev));
> +
> +		/* one pci vector is already allocated for HWC */
> +		irqs[i] = pci_irq_vector(pdev, i + 1);
> +		if (irqs[i] < 0) {
> +			err = irqs[i];
> +			goto free_current_gic;
> +		}
> +
> +		err = request_irq(irqs[i], mana_gd_intr, 0, gic->name, gic);
> +		if (err)
> +			goto free_current_gic;
> +
> +		list_add_tail(&gic->gic_list, &gc->irq_contexts);
> +	}
> +
> +	if (gc->num_msix_usable <= num_online_cpus())
> +		skip_first_cpu = 1;
> +
> +	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
> +	if (err)
> +		goto free_irq;
> +
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> +	cpus_read_unlock();
> +	kfree(irqs);
> +	return 0;
> +
> +free_current_gic:
> +	kfree(gic);
> +free_irq:
> +	for (j = i - 1; j >= 0; j--) {
> +		irq = pci_irq_vector(pdev, j + 1);
> +		gic = list_last_entry(&gc->irq_contexts, struct gdma_irq_context, gic_list);
> +		irq_update_affinity_hint(irq, NULL);
> +		free_irq(irq, gic);
> +		list_del(&gic->gic_list);
> +		kfree(gic);
>  	}
> +	kfree(irqs);
> +free_irq_vector:
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> +	cpus_read_unlock();
> +	return err;
> +}
> +
> +static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
> +{
> +	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	struct gdma_irq_context *gic;
> +	int start_irq_index = 1;
> +	unsigned long flags;
> +	unsigned int cpu;
> +	int *irqs, irq;
> +	int err, i = 0, j;
> +
> +	cpus_read_lock();
> +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> +
>  	if (nvec <= num_online_cpus())
>  		start_irq_index = 0;
>  
> @@ -1349,15 +1467,12 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  		goto free_irq_vector;
>  	}
>  
> -	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
> -				   GFP_KERNEL);
> -	if (!gc->irq_contexts) {
> -		err = -ENOMEM;
> -		goto free_irq_array;
> -	}
> -
>  	for (i = 0; i < nvec; i++) {
> -		gic = &gc->irq_contexts[i];
> +		gic = kcalloc(1, sizeof(struct gdma_irq_context), GFP_KERNEL);
> +		if (!gic) {
> +			err = -ENOMEM;
> +			goto free_irq;
> +		}
>  		gic->handler = mana_gd_process_eq_events;
>  		INIT_LIST_HEAD(&gic->eq_list);
>  		spin_lock_init(&gic->lock);
> @@ -1372,22 +1487,14 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  		irq = pci_irq_vector(pdev, i);
>  		if (irq < 0) {
>  			err = irq;
> -			goto free_irq;
> +			goto free_current_gic;
>  		}
>  
>  		if (!i) {
>  			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
>  			if (err)
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
> +				goto free_current_gic;
> +
>  			if (start_irq_index) {
>  				cpu = cpumask_local_spread(i, gc->numa_node);
>  				irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> @@ -1399,36 +1506,104 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  			err = request_irq(irqs[i - start_irq_index], mana_gd_intr, 0,
>  					  gic->name, gic);
>  			if (err)
> -				goto free_irq;
> +				goto free_current_gic;
>  		}
> +
> +		list_add_tail(&gic->gic_list, &gc->irq_contexts);
>  	}
>  
> -	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
> +	err = irq_setup(irqs, nvec - start_irq_index, gc->numa_node, 0);
>  	if (err)
>  		goto free_irq;
>  
> -	gc->max_num_msix = nvec;
> -	gc->num_msix_usable = nvec;
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
>  	cpus_read_unlock();
>  	kfree(irqs);
>  	return 0;
>  
> +free_current_gic:
> +	kfree(gic);
>  free_irq:
>  	for (j = i - 1; j >= 0; j--) {
>  		irq = pci_irq_vector(pdev, j);
> -		gic = &gc->irq_contexts[j];
> -
> +		gic = list_last_entry(&gc->irq_contexts, struct gdma_irq_context, gic_list);
>  		irq_update_affinity_hint(irq, NULL);
>  		free_irq(irq, gic);
> +		list_del(&gic->gic_list);
> +		kfree(gic);
>  	}
> -
> -	kfree(gc->irq_contexts);
> -	gc->irq_contexts = NULL;
> -free_irq_array:
>  	kfree(irqs);
>  free_irq_vector:
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
>  	cpus_read_unlock();
> -	pci_free_irq_vectors(pdev);
> +	return err;
> +}
> +
> +static int mana_gd_setup_hwc_irqs(struct pci_dev *pdev)
> +{
> +	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	unsigned int max_irqs, min_irqs;
> +	int max_queues_per_port;
> +	int nvec, err;
> +
> +	if (pci_msix_can_alloc_dyn(pdev)) {
> +		max_irqs = 1;
> +		min_irqs = 1;
> +	} else {
> +		max_queues_per_port = num_online_cpus();
> +		if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> +			max_queues_per_port = MANA_MAX_NUM_QUEUES;
> +		/* Need 1 interrupt for the Hardware communication Channel (HWC) */
> +		max_irqs = max_queues_per_port + 1;
> +		min_irqs = 2;
> +	}
> +
> +	nvec = pci_alloc_irq_vectors(pdev, min_irqs, max_irqs, PCI_IRQ_MSIX);
> +	if (nvec < 0)
> +		return nvec;
> +
> +	err = mana_gd_setup_irqs(pdev, nvec);
> +	if (err) {
> +		pci_free_irq_vectors(pdev);
> +		return err;
> +	}
> +
> +	gc->num_msix_usable = nvec;
> +	gc->max_num_msix = nvec;
> +
> +	return err;
> +}
> +
> +static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev)
> +{
> +	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	int max_irqs, i, err = 0;
> +	struct msi_map irq_map;
> +
> +	if (!pci_msix_can_alloc_dyn(pdev))
> +		/* remain irqs are already allocated with HWC IRQ */
> +		return 0;
> +
> +	/* allocate only remaining IRQs*/
> +	max_irqs = gc->num_msix_usable - 1;
> +
> +	for (i = 1; i <= max_irqs; i++) {
> +		irq_map = pci_msix_alloc_irq_at(pdev, i, NULL);
> +		if (!irq_map.virq) {
> +			err = irq_map.index;
> +			/* caller will handle cleaning up all allocated
> +			 * irqs, after HWC is destroyed
> +			 */
> +			return err;
> +		}
> +	}
> +
> +	err = mana_gd_setup_dyn_irqs(pdev, max_irqs);
> +	if (err)
> +		return err;
> +
> +	gc->max_num_msix = gc->max_num_msix + max_irqs;
> +
>  	return err;
>  }
>  
> @@ -1436,29 +1611,34 @@ static void mana_gd_remove_irqs(struct pci_dev *pdev)
>  {
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
>  	struct gdma_irq_context *gic;
> -	int irq, i;
> +	struct list_head *pos, *n;
> +	unsigned long flags;
> +	int irq, i = 0;
>  
>  	if (gc->max_num_msix < 1)
>  		return;
>  
> -	for (i = 0; i < gc->max_num_msix; i++) {
> +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> +	list_for_each_safe(pos, n, &gc->irq_contexts) {
>  		irq = pci_irq_vector(pdev, i);
>  		if (irq < 0)
>  			continue;
>  
> -		gic = &gc->irq_contexts[i];
> +		gic = list_entry(pos, struct gdma_irq_context, gic_list);
>  
>  		/* Need to clear the hint before free_irq */
>  		irq_update_affinity_hint(irq, NULL);
>  		free_irq(irq, gic);
> +		list_del(pos);
> +		kfree(gic);
> +		i++;
>  	}
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
>  
>  	pci_free_irq_vectors(pdev);
>  
>  	gc->max_num_msix = 0;
>  	gc->num_msix_usable = 0;
> -	kfree(gc->irq_contexts);
> -	gc->irq_contexts = NULL;
>  }
>  
>  static int mana_gd_setup(struct pci_dev *pdev)
> @@ -1469,9 +1649,9 @@ static int mana_gd_setup(struct pci_dev *pdev)
>  	mana_gd_init_registers(pdev);
>  	mana_smc_init(&gc->shm_channel, gc->dev, gc->shm_base);
>  
> -	err = mana_gd_setup_irqs(pdev);
> +	err = mana_gd_setup_hwc_irqs(pdev);
>  	if (err) {
> -		dev_err(gc->dev, "Failed to setup IRQs: %d\n", err);
> +		dev_err(gc->dev, "Failed to setup IRQs for HWC creation: %d\n", err);
>  		return err;
>  	}
>  
> @@ -1487,6 +1667,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
>  	if (err)
>  		goto destroy_hwc;
>  
> +	err = mana_gd_setup_remaining_irqs(pdev);
> +	if (err)
> +		goto destroy_hwc;
> +
>  	err = mana_gd_detect_devices(pdev);
>  	if (err)
>  		goto destroy_hwc;
> @@ -1563,6 +1747,8 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	gc->is_pf = mana_is_pf(pdev->device);
>  	gc->bar0_va = bar0_va;
>  	gc->dev = &pdev->dev;
> +	INIT_LIST_HEAD(&gc->irq_contexts);
> +	spin_lock_init(&gc->irq_ctxs_lock);
>  
>  	if (gc->is_pf)
>  		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 228603bf03f2..eae38d7302fe 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -363,6 +363,7 @@ struct gdma_irq_context {
>  	spinlock_t lock;
>  	struct list_head eq_list;
>  	char name[MANA_IRQ_NAME_SZ];
> +	struct list_head gic_list;
>  };
>  
>  struct gdma_context {
> @@ -373,7 +374,9 @@ struct gdma_context {
>  	unsigned int		max_num_queues;
>  	unsigned int		max_num_msix;
>  	unsigned int		num_msix_usable;
> -	struct gdma_irq_context	*irq_contexts;
> +	struct list_head	irq_contexts;
> +	/* Protect the irq_contexts list */
> +	spinlock_t		irq_ctxs_lock;
>  
>  	/* L2 MTU */
>  	u16 adapter_mtu;
> -- 
> 2.34.1

