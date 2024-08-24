Return-Path: <linux-hyperv+bounces-2849-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474D295DB54
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 05:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014F5286029
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 03:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB65A376E9;
	Sat, 24 Aug 2024 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NgQM4Zu1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724324C69;
	Sat, 24 Aug 2024 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724471542; cv=none; b=YEDFazI817/MahyInwMZQt2FyXivnaRXlEytYNT65/MXpzafr1qS5iwzQz71MZyCxxlYCDjsFR3gCoiTxT1g3iL9lLZnrYWQ32KCTcrHVa+D5lMBnAY53EkQsMk8CpbzbP8jXQ23X6l2MmcJedL0V9nLyw1qJO5bbheuIgrzxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724471542; c=relaxed/simple;
	bh=+cUPmCtL5SLaiGrE3t6YFg192RyP3dTAjv2RxQHhsRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXf9NpNlQid/xYKXKOAJoV4O2gyMz7nRKNCzvGykYDd6Ogc/D71M7IXsNQvOGXgnJuQ6dM+vzIlFBhpVVfF/dpnUAsxyLFGN+T+BGsCsjeA6Om6uSNNPcgmRcikR1sdW37NFNi3elvAUYI2QDTPsp5UtzCW3YVY1mX31o21n47I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NgQM4Zu1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 0715620B7165; Fri, 23 Aug 2024 20:52:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0715620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724471541;
	bh=CvorAYdT+pqBFXtEXDQL2Stu5RaEZ6BNnDW0WZxBpPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgQM4Zu1MNVY9yAsQjBSJivlN6616szblwcaA16IUEzrh8218ADjH3cbsB0ObLGjq
	 TjEbF8+l2jYBDVMUXWEb31SbDLoLqJL00KAf68dqZvLvRKxKhk0FfOKJOqTM4QZnnG
	 IEgRxdNFy2quCgpWjyyt2S0YeQkrHDWGdSL9bH1g=
Date: Fri, 23 Aug 2024 20:52:20 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	yury.norov@gmail.com, leon@kernel.org, cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, schakrabarti@microsoft.com
Subject: Re: [PATCH V2 net] net: mana: Fix error handling in
 mana_create_txq/rxq's NAPI cleanup
Message-ID: <20240824035220.GA26288@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1724406269-10868-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724406269-10868-1-git-send-email-schakrabarti@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Aug 23, 2024 at 02:44:29AM -0700, Souradeep Chakrabarti wrote:
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
> Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V2 -> V1:
> Addressed the comment on cleaning up napi for the queues,
> where queue creation was successful.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 22 +++++++++++--------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 39f56973746d..7448085fd49e 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1872,10 +1872,11 @@ static void mana_destroy_txq(struct mana_port_context *apc)
>  
>  	for (i = 0; i < apc->num_queues; i++) {
>  		napi = &apc->tx_qp[i].tx_cq.napi;
> -		napi_synchronize(napi);
> -		napi_disable(napi);
> -		netif_napi_del(napi);
> -
> +		if (napi->dev == apc->ndev) {
> +			napi_synchronize(napi);
> +			napi_disable(napi);
> +			netif_napi_del(napi);
> +		}
>  		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
>  
>  		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
> @@ -2023,14 +2024,17 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
>  
>  	napi = &rxq->rx_cq.napi;
>  
> -	if (validate_state)
> -		napi_synchronize(napi);
> +	if (napi->dev == apc->ndev) {
>  
> -	napi_disable(napi);
> +		if (validate_state)
> +			napi_synchronize(napi);
>  
> -	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> +		napi_disable(napi);
>  
> -	netif_napi_del(napi);
> +		netif_napi_del(napi);
> +	}
> +
> +	xdp_rxq_info_unreg(&rxq->xdp_rxq);
>  
>  	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);

Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>  
> -- 
> 2.34.1
> 
> 

