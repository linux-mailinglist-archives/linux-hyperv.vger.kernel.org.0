Return-Path: <linux-hyperv+bounces-2752-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D037694BBD4
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 13:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D74D281F18
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C304118A6D0;
	Thu,  8 Aug 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fJhunPSN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34774286A6;
	Thu,  8 Aug 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114828; cv=none; b=L1kvwwvJwhrLPp4vxlr/Pamk+ALnq//UmlDAaIfUF4/Vg3wfwGle7XyhU/UFZ1Zh0RjKqNhwPAt5nPy8RYQ/Iav4XK2k+GvOCyMwph3KibmO7fhGChjnzi8lqR/S6w+npOWSs6ZOY6HNhvEjhGIRhB/CVc7hJ5Q4+zRcwYVITao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114828; c=relaxed/simple;
	bh=OR+VhU9mhCyJce7HDHe1Uv/U/dBXIye6qP8H9dbJTn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxPByh0zUidFyjfqLrWj6Q7claLOKE01kRABTCHbTSrcFxneJ4qcFvDMSF2wWJE+24ZIF3LhdxTlWTR2smo2WMcfzfKZiGS8tu0EXESiSdWsQKeWjjmMHdj0VCDdh52/IdV08wKIpau2K3m2QSqklGqa75SVpt+OaJLofmY/dFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fJhunPSN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id BAA1A20B7165; Thu,  8 Aug 2024 04:00:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAA1A20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723114826;
	bh=Q9TBJrSTIxZWyLx3nUhN0aGNn1LRkcSdO2AwzlYwPoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJhunPSNNqAjK+gCkGDTz7UrVynoxZHaHyzpVKaKYe8kN/R8J55Hn/2Y7l7EDut16
	 tFrSjzR3zJrHEWxZFrkjO8foCUQ6La6A5Qtq7kNjWoQUxyM2aytL/81WYZEPKlBfdf
	 g1++8zHNCjFRKBE7DIjJRivbLmouRz52GgjFQDtM=
Date: Thu, 8 Aug 2024 04:00:26 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: longli@microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net] net: mana: Fix doorbell out of order violation
 and avoid unnecessary doorbell rings
Message-ID: <20240808110026.GA25550@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1723072626-32221-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723072626-32221-1-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Aug 07, 2024 at 04:17:06PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> After napi_complete_done() is called when NAPI is polling in the current
> process context, another NAPI may be scheduled and start running in
> softirq on another CPU and may ring the doorbell before the current CPU
> does. When combined with unnecessary rings when there is no need to arm
> the CQ, it triggers error paths in the hardware.
> 
> This patch fixes this by calling napi_complete_done() after doorbell
> rings. It limits the number of unnecessary rings when there is
> no need to arm. MANA hardware specifies that there must be one doorbell
> ring every 8 CQ wraparounds. This driver guarantees one doorbell ring as
> soon as the number of consumed CQEs exceeds 4 CQ wraparounds. In pratical
> workloads, the 4 CQ wraparounds proves to be big enough that it rarely
> exceeds this limit before all the napi weight is consumed.
> 
> To implement this, add a per-CQ counter cq->work_done_since_doorbell,
> and make sure the CQ is armed as soon as passing 4 wraparounds of the CQ.
> 
> Cc: stable@vger.kernel.org
> Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
> 
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> 
> change in v2:
> Added more details to comments to explain the patch
> 
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 24 ++++++++++++-------
>  include/net/mana/mana.h                       |  1 +
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d2f07e179e86..f83211f9e737 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1788,7 +1788,6 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
>  static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
>  {
>  	struct mana_cq *cq = context;
> -	u8 arm_bit;
>  	int w;
>  
>  	WARN_ON_ONCE(cq->gdma_cq != gdma_queue);
> @@ -1799,16 +1798,23 @@ static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
>  		mana_poll_tx_cq(cq);
>  
>  	w = cq->work_done;
> -
> -	if (w < cq->budget &&
> -	    napi_complete_done(&cq->napi, w)) {
> -		arm_bit = SET_ARM_BIT;
> -	} else {
> -		arm_bit = 0;
> +	cq->work_done_since_doorbell += w;
> +
> +	if (w < cq->budget) {
> +		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
> +		cq->work_done_since_doorbell = 0;
> +		napi_complete_done(&cq->napi, w);
> +	} else if (cq->work_done_since_doorbell >
> +		   cq->gdma_cq->queue_size / COMP_ENTRY_SIZE * 4) {

should we define a macro for 4? may be 'CQ_WRAPAROUND_LIMIT'

> +		/* MANA hardware requires at least one doorbell ring every 8
> +		 * wraparounds of CQ even if there is no need to arm the CQ.
> +		 * This driver rings the doorbell as soon as we have exceeded
> +		 * 4 wraparounds.
> +		 */
> +		mana_gd_ring_cq(gdma_queue, 0);
> +		cq->work_done_since_doorbell = 0;
>  	}
>  
> -	mana_gd_ring_cq(gdma_queue, arm_bit);
> -
>  	return w;
>  }
>  
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 6439fd8b437b..7caa334f4888 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -275,6 +275,7 @@ struct mana_cq {
>  	/* NAPI data */
>  	struct napi_struct napi;
>  	int work_done;
> +	int work_done_since_doorbell;
>  	int budget;
>  };
>  
> -- 
> 2.17.1

