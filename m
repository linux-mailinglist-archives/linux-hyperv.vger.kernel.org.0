Return-Path: <linux-hyperv+bounces-1052-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B217F9479
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Nov 2023 18:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DE1B20A57
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Nov 2023 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C104D50F;
	Sun, 26 Nov 2023 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+aU8f2I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0146A2;
	Sun, 26 Nov 2023 17:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042C9C433C8;
	Sun, 26 Nov 2023 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701018911;
	bh=guVv+SEh7voPe2lgiNwr2YxQ6n/2ttB7Jl8kD59Z9ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+aU8f2Idan4hvme0PSqL3UB30oSCZAmsROFTkYB/x0oz55+PioQdveGhsSpyB+Gg
	 Ao02FxaGghJ3KJ9k6uMouBvIG+e6m5I9yhuCU6LuLmWqcADv4G8U8eL4aJkNDC+YIQ
	 XTdpCGoRdeH4I8wO8UqaqbCwhVMaWBYwsOawfO8tEhgNcuMfGhJg/uhgMqpa8yrtzh
	 ZhwqGJa8nuLGjvB2npGydeEeoFvI7a4ppFq1Bcimv+M0bu6Ha+Qc4etfv5GmVwf+4a
	 RySa2qmCM4qyuWUPqwNhsyDGpZsf/s6mepEecEp6iJr8e1PdDanUDJI/K1kawrvGQW
	 4xrhLrBAWJLZw==
Date: Sun, 26 Nov 2023 17:15:04 +0000
From: Simon Horman <horms@kernel.org>
To: longli@linuxonhyperv.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch v1 2/4] RDMA/mana_ib: create and process EQ events
Message-ID: <20231126171504.GC84723@kernel.org>
References: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
 <1700709010-22042-3-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700709010-22042-3-git-send-email-longli@linuxonhyperv.com>

On Wed, Nov 22, 2023 at 07:10:08PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Before the software can create an RDMA adapter handle with SoC, it needs to
> create EQs for processing SoC events from RDMA device. Because MSI-X
> vectors are shared between MANA Ethernet device and RDMA device, this
> patch adds support to share EQs on MSI-X vectors and creates management
> EQ for RDMA device.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

...

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c

...

> -static void mana_gd_deregiser_irq(struct gdma_queue *queue)
> +static void mana_gd_deregister_irq(struct gdma_queue *queue)
>  {
>  	struct gdma_dev *gd = queue->gdma_dev;
>  	struct gdma_irq_context *gic;
>  	struct gdma_context *gc;
>  	struct gdma_resource *r;
>  	unsigned int msix_index;
> +	struct gdma_queue *eq;
>  	unsigned long flags;
> +	struct list_head *p;
>  
>  	gc = gd->gdma_context;
>  	r = &gc->msix_resource;
> @@ -505,14 +507,24 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
>  	if (WARN_ON(msix_index >= gc->num_msix_usable))
>  		return;
>  
> +	spin_lock_irqsave(&r->lock, flags);
> +
>  	gic = &gc->irq_contexts[msix_index];
> -	gic->handler = NULL;
> -	gic->arg = NULL;
> +	list_for_each_rcu(p, &gic->eq_list) {
> +		eq = list_entry(p, struct gdma_queue, entry);

Hi Long Li,

Sparse complains a bit about this construction:

 .../gdma_main.c:513:9: error: incompatible types in comparison expression (different address spaces):
 .../gdma_main.c:513:9:    struct list_head [noderef] __rcu *
 .../gdma_main.c:513:9:    struct list_head *
 .../gdma_main.c:513:9: error: incompatible types in comparison expression (different address spaces):
 .../gdma_main.c:513:9:    struct list_head [noderef] __rcu *
 .../gdma_main.c:513:9:    struct list_head *

Perhaps using list_for_each_entry_rcu() is appropriate here.


> +		if (queue == eq) {
> +			list_del(&eq->entry);
> +			synchronize_rcu();
> +			break;
> +		}
> +	}
>  
> -	spin_lock_irqsave(&r->lock, flags);
> -	bitmap_clear(r->map, msix_index, 1);
> -	spin_unlock_irqrestore(&r->lock, flags);
> +	if (list_empty(&gic->eq_list)) {
> +		gic->handler = NULL;
> +		bitmap_clear(r->map, msix_index, 1);
> +	}
>  
> +	spin_unlock_irqrestore(&r->lock, flags);
>  	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
>  }
>  

...

