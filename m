Return-Path: <linux-hyperv+bounces-5095-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AED0A9B4C9
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 18:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595F91BA0BE9
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D110228DEFC;
	Thu, 24 Apr 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUw/iDT+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290D28DEE0;
	Thu, 24 Apr 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513873; cv=none; b=QrwAKvC0dfGLOx7BQw/xlMUcLKn0hfl8Gdcw+wUF2Rrp+/A0snFM6LTWo8GRh8zA9LXhzm6cgot+YMzzjrVfNkCepIWm+C5fEzevTt8dsevCZd35GhNNJ4m6deD3R0UVZUOrvRddg7YJKOY+Yz/iue+Dbv2FPCL1awoUq/sdt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513873; c=relaxed/simple;
	bh=d79kcU9GfFoXHHLFwRO0mS3MDxIZKtB6Ybwg07CqBHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkQJnMYMbXQ0n5ivz0p+55HNvAtaiV9lgdiSUdQuSEQdg4GDhORN7HVN1U5pj5pOtL1j02j1ZLe7ALCOLxCNFHM5LRdqlhsbSIDw88zlwQou6Dz3J01nU0DKv1hQjWRGMMToNAYEBiEH0yPjbd9DbkRIbDEF+OTc5UkpjMTIvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUw/iDT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA94C4CEE8;
	Thu, 24 Apr 2025 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745513872;
	bh=d79kcU9GfFoXHHLFwRO0mS3MDxIZKtB6Ybwg07CqBHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUw/iDT+6gw5mOAM5j6Vw9sQKNjGnCcO2p1tds/nPvQxhm5QqiPeva6vHDs9PQ9h4
	 QXE/+JHx5hp33jrRTeNto+yvVZlOdnwBVexbS0ps9/BcZu6UB2BURU7jWrCktVt3Yx
	 vWe5TrzysIRNgwm+Zq9fP1WcPAu4YCQJSuiY5lpjOGRBMXds2/kxSK0dg9TJOgUreR
	 H95fBBiMKtPoQ7U/Uhv2WpPXHLgqH5eydc9N4p0cpWZm/YIssotgOIeG/9vUMq0f0T
	 /JOaV1ftzzrlpbq9qJkcazC7BQW7c8AwUEgTxyCdNBx/w0mGJWM9fQGq8FVtdTULzF
	 MqmPC9KUeSl1Q==
Date: Thu, 24 Apr 2025 17:57:43 +0100
From: Simon Horman <horms@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
	Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH 2/2] net: mana: Allow MANA driver to allocate PCI vector
 dynamically
Message-ID: <20250424165743.GJ3042781@horms.kernel.org>
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

Hi Shradha,

Some minor nits from my side.

...

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c

...

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

As this is Networking code, please preserve the arrangement of local
variables in reverse xmas tree order - longest line to shortest.

Edward Cree's tool can be useful in this area:
https://github.com/ecree-solarflare/xmastree

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

Please consider line wrapping to 80 columns or less, as is still preferred
in Networking code.

Likewise elsewhere in this patch.

checkpatch.pl --max-line-length=80
can be helpful here.

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

Reverse xmas tree here too.

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

Does gic need to be initialised to NULL before the list_for_each loop
to ensure that it is always initialised here?

Flagged by Clang 20.1.2 KCFLAGS=-Wsometimes-uninitialized builds, and Smatch

> +	if (!gic)
> +		return;
> +
>  	spin_lock_irqsave(&gic->lock, flags);
>  	list_for_each_entry_rcu(eq, &gic->eq_list, entry) {
>  		if (queue == eq) {

...

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

Reverse xmas tree here too.

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

...

