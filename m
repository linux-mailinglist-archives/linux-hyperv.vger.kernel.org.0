Return-Path: <linux-hyperv+bounces-7402-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E969FC2CA28
	for <lists+linux-hyperv@lfdr.de>; Mon, 03 Nov 2025 16:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7351893C24
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Nov 2025 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B9F318146;
	Mon,  3 Nov 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3Aq3XRH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6C3112BD;
	Mon,  3 Nov 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181925; cv=none; b=eOMcfp5l+2Igm37NvGejtbv+1NpO7Fdy/cI/kkZzgCZQlFIeWzQ5igVGBa4G0t1oe1336hEi8IbilierYAQBGZXjTxl4Ab3/V27DLS4Z18Ea48IAVdxQIZbi4jegvuHv5Ug4Sc4M0Jod1uZY1jPEstolJsaeYWmTEfHLzJRHHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181925; c=relaxed/simple;
	bh=assirJLyUowDfFa7kE1YCP3FONPTzejJ9QbVSRO7hmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgPyT96ICT620jPUddb+Z8WUVq6bx8pyZw/GX0+8da1cUhiwLp1qiexCgaLiQEy6x9Q/0MGAFgCpNtnYfyxMrG/iJF/BR2v3Mlx9cjSqfhmLzq43Wkja1BHPppoSml1SJ9OWDWBdp/Q4jBIHKQL0sBVBfhbALCoNNyi/71Z0QTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3Aq3XRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F75EC4CEE7;
	Mon,  3 Nov 2025 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181925;
	bh=assirJLyUowDfFa7kE1YCP3FONPTzejJ9QbVSRO7hmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3Aq3XRH4FIiOr1ca7vksnvcqMT2DxCali/3rU18MibxJ85utRKsxdBOYb9EzU40r
	 xqJtMN8cpcFuO0b4Dn3cRam2oug440FP4XgmXKtrlbxdhKlkrPJwTSrS9RJlekJS1y
	 vE0aEX8wVSNH/anfrG7cZYrDjbekNqr9A2hq4JI/fFIof+O1C1OPlB08HlkYuwgyD9
	 b1AhgTX+lC9OWxjwogLjeIqdAkPxnR/ejBDzpFZXDoQu9OIsoCMq3UGCo4otyPO0Wf
	 DGGnGzWS9urm+sBqvyqfWTJ9stDEiyyA7n4VEE6P/puMYPnrlwgzRQs8p0t32bzEtE
	 TYQkW0iQbuROQ==
Date: Mon, 3 Nov 2025 14:58:39 +0000
From: Simon Horman <horms@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, gargaditya@microsoft.com
Subject: Re: [PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
Message-ID: <aQjDHy5qSGYADPS7@horms.kernel.org>
References: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <aQMqLN0FRmNU3_ke@horms.kernel.org>
 <347c723b-d47c-49c2-9a3b-b49d967f875b@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347c723b-d47c-49c2-9a3b-b49d967f875b@linux.microsoft.com>

On Fri, Oct 31, 2025 at 06:50:10PM +0530, Aditya Garg wrote:
> On 30-10-2025 14:34, Simon Horman wrote:
> > On Wed, Oct 29, 2025 at 06:12:35AM -0700, Aditya Garg wrote:
> > > The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
> > > per TX WQE. Exceeding this limit can cause TX failures.
> > > Add ndo_features_check() callback to validate SKB layout before
> > > transmission. For GSO SKBs that would exceed the hardware SGE limit, clear
> > > NETIF_F_GSO_MASK to enforce software segmentation in the stack.
> > > Add a fallback in mana_start_xmit() to linearize non-GSO SKBs that still
> > > exceed the SGE limit.
> > > 
> > > Return NETDEV_TX_BUSY only for -ENOSPC from mana_gd_post_work_request(),
> > > send other errors to free_sgl_ptr to free resources and record the tx
> > > drop.
> > > 
> > > Co-developed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> > > Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> > > Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> > 
> > ...
> > 
> > > @@ -289,6 +290,21 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> > >   	cq = &apc->tx_qp[txq_idx].tx_cq;
> > >   	tx_stats = &txq->stats;
> > > +	if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
> > > +	    skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
> > > +		/* GSO skb with Hardware SGE limit exceeded is not expected here
> > > +		 * as they are handled in mana_features_check() callback
> > > +		 */
> > 
> > Hi,
> > 
> > I'm curious to know if we actually need this code.
> > Are there cases where the mana_features_check() doesn't
> > handle things and the kernel will reach this line?
> > 
> > > +		if (skb_is_gso(skb))
> > > +			netdev_warn_once(ndev, "GSO enabled skb exceeds max SGE limit\n");
> > > +		if (skb_linearize(skb)) {
> > > +			netdev_warn_once(ndev, "Failed to linearize skb with nr_frags=%d and is_gso=%d\n",
> > > +					 skb_shinfo(skb)->nr_frags,
> > > +					 skb_is_gso(skb));
> > > +			goto tx_drop_count;
> > > +		}
> > > +	}
> > > +
> > >   	pkg.tx_oob.s_oob.vcq_num = cq->gdma_id;
> > >   	pkg.tx_oob.s_oob.vsq_frame = txq->vsq_frame;
> > 
> > ...
> 
> Hi Simon,
> As it was previously discussed and agreed on with Eric, this is for Non-GSO
> skbs which could have possibly nr_frags greater than hardware limit.
> 
> Quoting Eric's comment from v1 thread: https://lore.kernel.org/netdev/CANn89iKwHWdUaeAsdSuZUXG-W8XwyM2oppQL9spKkex0p9-Azw@mail.gmail.com/
> "I think that for non GSO, the linearization attempt is fine.
> 
> Note that this is extremely unlikely for non malicious users,
> and MTU being usually small (9K or less),
> the allocation will be much smaller than a GSO packet."

Thanks for the clarification, that makes sense to me.

FTR, Jakub's question (elsewhere) is different to mine.

