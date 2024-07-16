Return-Path: <linux-hyperv+bounces-2571-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B47B9932032
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jul 2024 07:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543701F22BCA
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jul 2024 05:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B6F17C91;
	Tue, 16 Jul 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Kfz2fJX8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D103A17BAA;
	Tue, 16 Jul 2024 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721109160; cv=none; b=ZsOvzRvWNeclzzEnPlewS3X2d5jEkSgtKjENneyRso8BN576tQHUO8ScrGDqZzYKvkAD/uyu4xkbZLBPmn3DQOpCq2z3ZOvM46UImdTLAtMh5081fy3oNV6KKVm/Hhnl8Db+EdHrqbNiW/s4a1rg81zup/GbeuaY9u7LAnB716M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721109160; c=relaxed/simple;
	bh=lxA/bOoTsrzGF5ZrrKJOhVVAsW6vWLK5zIiPznI1C88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N50j0B7AiR+RtBhAP1debn8JEBzHpxhE6CW+qTMuI5EhAztihR4O92GPbbKzoRNV811LrMvtB2tCwLyvyeTqmd0mk0n3NMQ+pH1zxpUa8zzKykFOgw766Xks+g/1tJMIt0CnjuuxRqroFap0CSS0KEjCltJwqEGKDwUbEMyg1oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Kfz2fJX8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 5AB2820B7165; Mon, 15 Jul 2024 22:52:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AB2820B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721109158;
	bh=0Ma31MmB44D6lO+VmB474XyxCD3bBumrQiidhEUKV88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kfz2fJX8n5tY4xcbOx8uFBhU5ckHsjNwX7GZIQKFg1GNpQGUHmB2B+6FvZO3EgDlp
	 5a/bcv96jpLylmbIYWeWR2OolcZcaVN8yJxe4kEOE64dsz+396W618Q/wgrAd/rlIw
	 7lx5XUb3QeoShbBkIJDw0BV8evL3D9nCu8AJkuLg=
Date: Mon, 15 Jul 2024 22:52:38 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH net-next] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240716055238.GC16469@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1721014820-2507-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240715064551.6036d46b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715064551.6036d46b@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jul 15, 2024 at 06:45:51AM -0700, Jakub Kicinski wrote:
> On Sun, 14 Jul 2024 20:40:20 -0700 Shradha Gupta wrote:
> > +	if (ring->rx_jumbo_pending) {
> > +		netdev_err(ndev, "%s: rx_jumbo_pending not supported\n", __func__);
> > +		return -EINVAL;
> > +	}
> > +	if (ring->rx_mini_pending) {
> > +		netdev_err(ndev, "%s: rx_mini_pending not supported\n", __func__);
> > +		return -EINVAL;
> > +	}
> 
> I think that core already checks this
> 
> > +	if (!apc)
> > +		return -EINVAL;
> 
> Provably impossible, apc is netdev + sizeof(netdev) so it'd have to
> wrap a 64b integer to be NULL :|
> 
> > +	old_tx = apc->tx_queue_size;
> > +	old_rx = apc->rx_queue_size;
> > +	new_tx = clamp_t(u32, ring->tx_pending, MIN_TX_BUFFERS_PER_QUEUE, MAX_TX_BUFFERS_PER_QUEUE);
> > +	new_rx = clamp_t(u32, ring->rx_pending, MIN_RX_BUFFERS_PER_QUEUE, MAX_RX_BUFFERS_PER_QUEUE);
> > +
> > +	if (new_tx == old_tx && new_rx == old_rx)
> > +		return 0;
> 
> Pretty sure core will also not call you if there's no change.
> If it does please update core instead of catching this in the driver.

Thanks for the comments Jakub. I'll verify these and make the relevant changes in the next version

> 
> Please keep in mind that net-next will be closed for the duration
> of the merge window.
Noted, Thanks.

> -- 
> pw-bot: cr

