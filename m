Return-Path: <linux-hyperv+bounces-8204-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73006D0CC7E
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 Jan 2026 02:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F61303211C
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 Jan 2026 01:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32023AB88;
	Sat, 10 Jan 2026 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf8OEhkE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B902046BA;
	Sat, 10 Jan 2026 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768010172; cv=none; b=SpOPix4r7+SPHJRMhBWS+qWVi02Nkiak2NRC+whVrGKf63xtvIJGa3EAeN46dtyrkgYC4suPM5EYL4UUQP0c/Hnf2l/zesvCyzzwnny7aBk1d6G3Z46G18bJu0Op4zOA7QkzifVMbkIMivFNF8t1vfOahaeMSuYZmGC5Z/N5pu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768010172; c=relaxed/simple;
	bh=rXXujbRvygfxf3ROuA/kqYfnbIKAXbFIuX5lgeH+heo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHi4L4veh+9poUhkorr/uQvHqUKMUheoQUz81bCND5dLPq8vp9ixasAdzoq7+E/jpd/4q9PYTxO2puRBdqsj2kXQ1hze0GaOP+NlGPM0A4On6/xPCiswcklrOaE4YEOdqccH3r3IWBQTA5641Paa4DwQzFQfyGWepIGp1ihXXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf8OEhkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AD8C4CEF1;
	Sat, 10 Jan 2026 01:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768010172;
	bh=rXXujbRvygfxf3ROuA/kqYfnbIKAXbFIuX5lgeH+heo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xf8OEhkEZdQ1q6nF764VpkCUg+f/NFM4ZN9oCENwBwLdM8kpdgE4Ah2MDXrLvMtQY
	 vpYHr3m2JkvhHLR9TrP2XbwiN2Y8y8RVbF7D0CBctnDiG9CPCw5kwuqEPZYl4es2Ky
	 K8RQDQreLKOmiI0FlmjT6niYVFojlvuKCx67VqlJQUdXaGBaGmOZ6wCQXGOLDBAGR1
	 jlUN7gTLC5Azsyj7COeFPX1+CPZ4seqTYil4dgGYov2dHE2KR6CZ9Vpr32IEZx+Ys0
	 rZqHuO3vMk9/C3oggScSOhJ5KZGLg0rJZIzT6iZRpsGdXK9VU8IIsF9bi2kq0/feIw
	 jLb2yaGK1PwbA==
Date: Fri, 9 Jan 2026 17:56:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>,
 Simon Horman <horms@kernel.org>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, Aditya Garg
 <gargaditya@linux.microsoft.com>, Dipayaan Roy
 <dipayanroy@linux.microsoft.com>, Shiraz Saleem
 <shirazsaleem@microsoft.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, paulros@microsoft.com
Subject: Re: [PATCH V2,net-next, 1/2] net: mana: Add support for coalesced
 RX packets on CQE
Message-ID: <20260109175610.0eb69acb@kernel.org>
In-Reply-To: <1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 12:46:46 -0800 Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Our NIC can have up to 4 RX packets on 1 CQE. To support this feature,
> check and process the type CQE_RX_COALESCED_4. The default setting is
> disabled, to avoid possible regression on latency.
> 
> And add ethtool handler to switch this feature. To turn it on, run:
>   ethtool -C <nic> rx-frames 4
> To turn it off:
>   ethtool -C <nic> rx-frames 1

Exposing just rx frame count, and only two values is quite unusual.
Please explain in more detail the coalescing logic of the device.

> @@ -2079,14 +2081,10 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
>  		return;
>  	}
>  
> -	pktlen = oob->ppi[0].pkt_len;
> -
> -	if (pktlen == 0) {
> -		/* data packets should never have packetlength of zero */
> -		netdev_err(ndev, "RX pkt len=0, rq=%u, cq=%u, rxobj=0x%llx\n",
> -			   rxq->gdma_id, cq->gdma_id, rxq->rxobj);
> +nextpkt:
> +	pktlen = oob->ppi[i].pkt_len;
> +	if (pktlen == 0)
>  		return;
> -	}
>  
>  	curr = rxq->buf_index;
>  	rxbuf_oob = &rxq->rx_oobs[curr];
> @@ -2097,12 +2095,15 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
>  	/* Unsuccessful refill will have old_buf == NULL.
>  	 * In this case, mana_rx_skb() will drop the packet.
>  	 */
> -	mana_rx_skb(old_buf, old_fp, oob, rxq);
> +	mana_rx_skb(old_buf, old_fp, oob, rxq, i);
>  
>  drop:
>  	mana_move_wq_tail(rxq->gdma_rq, rxbuf_oob->wqe_inf.wqe_size_in_bu);
>  
>  	mana_post_pkt_rxq(rxq);
> +
> +	if (coalesced && (++i < MANA_RXCOMP_OOB_NUM_PPI))
> +		goto nextpkt;

Please code this up as a loop. Using gotos for control flow other than
to jump to error handling epilogues is a poor coding practice (see the
kernel coding style).

> +static int mana_set_coalesce(struct net_device *ndev,
> +			     struct ethtool_coalesce *ec,
> +			     struct kernel_ethtool_coalesce *kernel_coal,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct mana_port_context *apc = netdev_priv(ndev);
> +	u8 saved_cqe_coalescing_enable;
> +	int err;
> +
> +	if (ec->rx_max_coalesced_frames != 1 &&
> +	    ec->rx_max_coalesced_frames != MANA_RXCOMP_OOB_NUM_PPI) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "rx-frames must be 1 or %u, got %u",
> +				   MANA_RXCOMP_OOB_NUM_PPI,
> +				   ec->rx_max_coalesced_frames);
> +		return -EINVAL;
> +	}
> +
> +	saved_cqe_coalescing_enable = apc->cqe_coalescing_enable;
> +	apc->cqe_coalescing_enable =
> +		ec->rx_max_coalesced_frames == MANA_RXCOMP_OOB_NUM_PPI;
> +
> +	if (!apc->port_is_up)
> +		return 0;
> +
> +	err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> +

unnecessary empty line

> +	if (err) {
> +		netdev_err(ndev, "Set rx-frames to %u failed:%d\n",
> +			   ec->rx_max_coalesced_frames, err);
> +		NL_SET_ERR_MSG_FMT(extack, "Set rx-frames to %u failed",
> +				   ec->rx_max_coalesced_frames);

These messages are both pointless. If HW communication has failed
presumably there will already be an error in the logs. The extack
gives the user no information they wouldn't already have.

> +		apc->cqe_coalescing_enable = saved_cqe_coalescing_enable;
> +	}
> +
> +	return err;
> +}

