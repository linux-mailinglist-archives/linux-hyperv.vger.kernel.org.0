Return-Path: <linux-hyperv+bounces-7398-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEF5C272D4
	for <lists+linux-hyperv@lfdr.de>; Sat, 01 Nov 2025 00:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B30F188978B
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 23:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40432AADB;
	Fri, 31 Oct 2025 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn/HqSez"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9652FE589;
	Fri, 31 Oct 2025 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761953175; cv=none; b=nAUu7eDBPejhg6i1fXWw4/DR7cwfepOwE9Z5Ie7bYWJmZJt2/pNPg7ULXDQYUUF9WgfPH2e8gs9pF5KeYrHAMwysaPyDGluHHfwLNoDk8dk0TiCY59FHqI4ZZYZWren8vCJRsEbMwgnwrCzmk9kvZzJtbmBvs1wK0GvJUyvVWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761953175; c=relaxed/simple;
	bh=ZqYwds0sADNzMvSeVgW+LyUJYBSkAX/vctdG2rH2Xyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjffOgl4LyDwJe+wZcrUrJEqJNAyOKkhm8zQxmnsNa9NH9FT7kJRBVB5KKv9QiQv7BehYM7m3zMD0K7waWL2ZzC1vjH4enfHS22sDj19k5u/5/MNJcis3EkzkBS/37JbGi7JXisgga5QLi3CgKD6521bq1n7fBzlZ8rTmb0+Ul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn/HqSez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540E4C4CEE7;
	Fri, 31 Oct 2025 23:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761953173;
	bh=ZqYwds0sADNzMvSeVgW+LyUJYBSkAX/vctdG2rH2Xyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tn/HqSezV0K0CMxaqCJwynVF+/f3ZFf4ysKGofSN+ILlPcSdB4+8pSQXWIB8Pg3R+
	 7dtcmHtKOCONHLp61Cb6NYnpkOd0F+lora2zDFyONiGN2PAX3XgPPOQ2TRhk/fZj1y
	 zVq3N2lDYQK9UKRYAlMHNdZq+x73jTLYsfCkFyrk5oqC7e00ZKfLvztexrlD1IyXwI
	 HRDSaUIrcMmfWY7ZYk4vCpww0LsShsUPDaZMZrRRiFKGg2R0oNX58x9f24mpLgG/le
	 dibLsikaZekaiwuti0vWHT2qp1Vwt/FCgnaZQB75I+G0Vvxq4JjcGcx3o97uTMfOw0
	 V67NjHeDm0j7g==
Date: Fri, 31 Oct 2025 16:26:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, gargaditya@microsoft.com
Subject: Re: [PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
Message-ID: <20251031162611.2a981fdf@kernel.org>
In-Reply-To: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 06:12:35 -0700 Aditya Garg wrote:
> @@ -289,6 +290,21 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	cq = &apc->tx_qp[txq_idx].tx_cq;
>  	tx_stats = &txq->stats;
>  
> +	if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
> +	    skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
> +		/* GSO skb with Hardware SGE limit exceeded is not expected here
> +		 * as they are handled in mana_features_check() callback
> +		 */
> +		if (skb_is_gso(skb))
> +			netdev_warn_once(ndev, "GSO enabled skb exceeds max SGE limit\n");

This could be the same question Simon asked but why do you think you
need this line? Sure you need to linearize non-GSO but why do you care
to warn specifically about GSO?! Looks like defensive programming or
testing leftover..

> +		if (skb_linearize(skb)) {
> +			netdev_warn_once(ndev, "Failed to linearize skb with nr_frags=%d and is_gso=%d\n",
> +					 skb_shinfo(skb)->nr_frags,
> +					 skb_is_gso(skb));

.. in practice including is_gso() here as you do is probably enough for
debug

> +			goto tx_drop_count;
> +		}
> +	}
> +
>  	pkg.tx_oob.s_oob.vcq_num = cq->gdma_id;
>  	pkg.tx_oob.s_oob.vsq_frame = txq->vsq_frame;
>  
> @@ -402,8 +418,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  		}
>  	}
>  
> -	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
> -
>  	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
>  		pkg.wqe_req.sgl = pkg.sgl_array;
>  	} else {
> @@ -438,9 +452,13 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  
>  	if (err) {
>  		(void)skb_dequeue_tail(&txq->pending_skbs);
> +		mana_unmap_skb(skb, apc);
>  		netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);

You have a print right here and in the callee. This condition must
(almost) never happen in practice. It's likely fine to just drop
the packet.

Either way -- this should be a separate patch.

> -		err = NETDEV_TX_BUSY;
> -		goto tx_busy;
> +		if (err == -ENOSPC) {
> +			err = NETDEV_TX_BUSY;
> +			goto tx_busy;
> +		}
> +		goto free_sgl_ptr;
>  	}
>  
>  	err = NETDEV_TX_OK;
> @@ -478,6 +496,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	return NETDEV_TX_OK;
>  }
-- 
pw-bot: cr

