Return-Path: <linux-hyperv+bounces-2730-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84CC949588
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 18:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE1BB2FA9C
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170817ADF1;
	Tue,  6 Aug 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="shQ8YTUQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15884AEE0
	for <linux-hyperv@vger.kernel.org>; Tue,  6 Aug 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959963; cv=none; b=L83rWeV47u/ro7iDhvwPL8yXCyOQYvNsr7VjV31dilyvV8s4z4Bm9PUeIbfH24Xf3HdiRyyLVuMKxCMetH722y/Qd0vuVoh+lgYvo/oHC1l/sr4COC9Nzu0Jo7mVsPGWZQQ0LMR1nUQaFlYxkjlbH6Ae1WSQJBCaCvtWhPC/hyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959963; c=relaxed/simple;
	bh=TejO1EWB0XiActpktx1M4fMC8ChDCI8W2BCX6v6iEKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3igmsy2siicuWHAniNTAgE7QgmVxI+Xwv7qOUs5/BFYLBvLA/W+IncFbVqD3Y2McqhjDB+fyTBSE3ev8RIckoiHYwb5sLJLyCSnhM/nDyawJJI/p3lC2P9DfasyLOXLQzmMini+qRt7BLXtj1o1j6pe2+VTLdDM6EBAtfsztHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=shQ8YTUQ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <481149de-1212-4a43-a7cb-52351a0e29ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722959956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRDk8Cv/Zk4rJkepfl5aEaXYgswmB6ciYnad9lfWU90=;
	b=shQ8YTUQIA2Ts+i0SNoI7kYm03WBkomRBwH8g+noo7l1JyoR5tACJSsGn7gFX5WuaRI+/u
	7hbKneZx9ITJGacIljd2bjWJcsuAmk86CHzwcKgS5LTJ+xWkld3qEjHtEGSoXTdC3dsLCZ
	o6SBC5b7+r6WuVwALC7xQL58FDx6ncU=
Date: Tue, 6 Aug 2024 23:59:01 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
To: longli@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Simon Horman <horms@kernel.org>, Konstantin Taranov
 <kotaranov@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
 Erick Archer <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org
References: <1722901088-12115-1-git-send-email-longli@linuxonhyperv.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1722901088-12115-1-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/8/6 7:38, longli@linuxonhyperv.com 写道:
> From: Long Li <longli@microsoft.com>
> 
> After napi_complete_done() is called, another NAPI may be running on
> another CPU and ring the doorbell before the current CPU does. When
> combined with unnecessary rings when there is no need to ARM the CQ, this
> triggers error paths in the hardware.
> 
> Fix this by always ring the doorbell in sequence and avoid unnecessary
> rings.

Trivial problem^_^

s/ring/ringing ?

Zhu Yanjun

> 
> Cc: stable@vger.kernel.org
> Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 24 ++++++++++++-------
>   include/net/mana/mana.h                       |  1 +
>   2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d2f07e179e86..7d08e23c6749 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1788,7 +1788,6 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
>   static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
>   {
>   	struct mana_cq *cq = context;
> -	u8 arm_bit;
>   	int w;
>   
>   	WARN_ON_ONCE(cq->gdma_cq != gdma_queue);
> @@ -1799,16 +1798,23 @@ static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
>   		mana_poll_tx_cq(cq);
>   
>   	w = cq->work_done;
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
> +		/* MANA hardware requires at least one doorbell ring every 8
> +		 * wraparounds of CQ even there is no need to ARM. This driver
> +		 * rings the doorbell as soon as we have execceded 4
> +		 * wraparounds.
> +		 */
> +		mana_gd_ring_cq(gdma_queue, 0);
> +		cq->work_done_since_doorbell = 0;
>   	}
>   
> -	mana_gd_ring_cq(gdma_queue, arm_bit);
> -
>   	return w;
>   }
>   
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 6439fd8b437b..7caa334f4888 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -275,6 +275,7 @@ struct mana_cq {
>   	/* NAPI data */
>   	struct napi_struct napi;
>   	int work_done;
> +	int work_done_since_doorbell;
>   	int budget;
>   };
>   


