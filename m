Return-Path: <linux-hyperv+bounces-2921-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF938965775
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Aug 2024 08:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E1D284A6E
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Aug 2024 06:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715B91514ED;
	Fri, 30 Aug 2024 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AIv9nXQw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12E614F9F4;
	Fri, 30 Aug 2024 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998437; cv=none; b=sooWfdVWpeLi1FzmLLfpgnx017y18XUmU5wQCgbpLYAwwJHzqlkqzchev5j0jzXvFNyrB+r6hSVBZIDGZeT4jlw26bQQs3M97Dg2RK/ydkkSH4ZVGl98NgJYrBghXQ5YZvBBZ+JV6xEnzONvt3w1HtPcEjl6FlgoHzfjhnCwWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998437; c=relaxed/simple;
	bh=p37CJIbeVvxUnXIiq+2XX77bD1ppgbxyfDuu2ZWeuzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itp5xKVcjc7eyOX9EBKI1Q0s0AyTgi2/5RGisY+Fcsws+2lN8iao1XP0IcK+PoM30C2IpAp6ukz7PP1IynDUlUSgGPEx/Gl7NVSrAeRLgcr2lr++3/Yle8K76Y8+1MUIHUimS85iZjkMVCPZHiORs9yHIDYy4dPP8WqEYrI9RoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AIv9nXQw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 5A83020B7165; Thu, 29 Aug 2024 23:13:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A83020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724998435;
	bh=xCOyMDJIpLS4T3O8nkaE9qmCOU+j9U5LKWcYQs6GEfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIv9nXQwENmbAc6VrQ9aTwjjGRZCCYPLMNWX6HzghLrifLjjvI7Zvndn/8E+JVN2y
	 J3OBZ8OPSOyOchOajM86xk1S3XS/vpls8V9RwPA2U1KlTBbtSq3eyH0+JSF3XgmCM/
	 +9bTB5pno5ZSXaS1Pq+YIxQMNKVGcIZJWoHdp3uQ=
Date: Thu, 29 Aug 2024 23:13:55 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, longli@microsoft.com,
	ssengar@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH V3 net] net: mana: Fix error handling in
 mana_create_txq/rxq's NAPI cleanup
Message-ID: <20240830061355.GA2986@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1724920610-15546-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724920610-15546-1-git-send-email-schakrabarti@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 29, 2024 at 01:36:50AM -0700, Souradeep Chakrabarti wrote:
> Currently napi_disable() gets called during rxq and txq cleanup,
> even before napi is enabled and hrtimer is initialized. It causes
> kernel panic.
> 
> ? page_fault_oops+0x136/0x2b0
>   ? page_counter_cancel+0x2e/0x80
>   ? do_user_addr_fault+0x2f2/0x640
>   ? refill_obj_stock+0xc4/0x110
>   ? exc_page_fault+0x71/0x160
>   ? asm_exc_page_fault+0x27/0x30
>   ? __mmdrop+0x10/0x180
>   ? __mmdrop+0xec/0x180
>   ? hrtimer_active+0xd/0x50
>   hrtimer_try_to_cancel+0x2c/0xf0
>   hrtimer_cancel+0x15/0x30
>   napi_disable+0x65/0x90
>   mana_destroy_rxq+0x4c/0x2f0
>   mana_create_rxq.isra.0+0x56c/0x6d0
>   ? mana_uncfg_vport+0x50/0x50
>   mana_alloc_queues+0x21b/0x320
>   ? skb_dequeue+0x5f/0x80
> 
> Cc: stable@vger.kernel.org
> Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
> V3 -> V2:
> Instead of using napi internal attribute, using an atomic
> attribute to verify napi is initialized for a particular txq / rxq.
> 
> V2 -> V1:
> Addressed the comment on cleaning up napi for the queues,
> where queue creation was successful.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 30 ++++++++++++-------
>  include/net/mana/mana.h                       |  4 +++
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 39f56973746d..bd303c89cfa6 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1872,10 +1872,12 @@ static void mana_destroy_txq(struct mana_port_context *apc)
>  
>  	for (i = 0; i < apc->num_queues; i++) {
>  		napi = &apc->tx_qp[i].tx_cq.napi;
> -		napi_synchronize(napi);
> -		napi_disable(napi);
> -		netif_napi_del(napi);
> -
> +		if (atomic_read(&apc->tx_qp[i].txq.napi_initialized)) {
> +			napi_synchronize(napi);
> +			napi_disable(napi);
> +			netif_napi_del(napi);
> +			atomic_set(&apc->tx_qp[i].txq.napi_initialized, 0);
> +		}
>  		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
>  
>  		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
> @@ -1931,6 +1933,7 @@ static int mana_create_txq(struct mana_port_context *apc,
>  		txq->ndev = net;
>  		txq->net_txq = netdev_get_tx_queue(net, i);
>  		txq->vp_offset = apc->tx_vp_offset;
> +		atomic_set(&txq->napi_initialized, 0);
>  		skb_queue_head_init(&txq->pending_skbs);
>  
>  		memset(&spec, 0, sizeof(spec));
> @@ -1997,6 +2000,7 @@ static int mana_create_txq(struct mana_port_context *apc,
>  
>  		netif_napi_add_tx(net, &cq->napi, mana_poll);
>  		napi_enable(&cq->napi);
> +		atomic_set(&txq->napi_initialized, 1);
>  
>  		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
>  	}
> @@ -2023,14 +2027,18 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
>  
>  	napi = &rxq->rx_cq.napi;
>  
> -	if (validate_state)
> -		napi_synchronize(napi);
> +	if (atomic_read(&rxq->napi_initialized)) {
>  
> -	napi_disable(napi);
> +		if (validate_state)
> +			napi_synchronize(napi);

Is this validate_state flag still needed? The new napi_initialized
variable will make sure the napi_synchronize() is called only for rxqs
that have napi_enabled.

Regards,
Shradha.

>  
> -	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> +		napi_disable(napi);
>  
> -	netif_napi_del(napi);
> +		netif_napi_del(napi);
> +		atomic_set(&rxq->napi_initialized, 0);
> +	}
> +
> +	xdp_rxq_info_unreg(&rxq->xdp_rxq);
>  
>  	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
>  
> @@ -2199,6 +2207,7 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
>  	rxq->num_rx_buf = RX_BUFFERS_PER_QUEUE;
>  	rxq->rxq_idx = rxq_idx;
>  	rxq->rxobj = INVALID_MANA_HANDLE;
> +	atomic_set(&rxq->napi_initialized, 0);
>  
>  	mana_get_rxbuf_cfg(ndev->mtu, &rxq->datasize, &rxq->alloc_size,
>  			   &rxq->headroom);
> @@ -2286,6 +2295,8 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
>  
>  	napi_enable(&cq->napi);
>  
> +	atomic_set(&rxq->napi_initialized, 1);
> +
>  	mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
>  out:
>  	if (!err)
> @@ -2336,7 +2347,6 @@ static void mana_destroy_vport(struct mana_port_context *apc)
>  		rxq = apc->rxqs[rxq_idx];
>  		if (!rxq)
>  			continue;
> -
>  		mana_destroy_rxq(apc, rxq, true);
>  		apc->rxqs[rxq_idx] = NULL;
>  	}
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 7caa334f4888..be75abd63dc8 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -98,6 +98,8 @@ struct mana_txq {
>  
>  	atomic_t pending_sends;
>  
> +	atomic_t napi_initialized;
> +
>  	struct mana_stats_tx stats;
>  };
>  
> @@ -335,6 +337,8 @@ struct mana_rxq {
>  	bool xdp_flush;
>  	int xdp_rc; /* XDP redirect return code */
>  
> +	atomic_t napi_initialized;
> +
>  	struct page_pool *page_pool;
>  
>  	/* MUST BE THE LAST MEMBER:
> -- 
> 2.34.1
> 
> 

