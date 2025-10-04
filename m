Return-Path: <linux-hyperv+bounces-7093-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82772BB8C0A
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Oct 2025 11:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3EC3C3CFD
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Oct 2025 09:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68E826B0AE;
	Sat,  4 Oct 2025 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTCkgvrl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16411DF271;
	Sat,  4 Oct 2025 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759570692; cv=none; b=mc3bT6hoFgSxJ1jyUcGB9KmSEdG417t6qdhsULwJw1cLZQ8ObUg1OqJp8nGMdgIaZWBd3m6AClC9Jdm53HzA8mKIud6KDOH+qQ/K+KF1aexViCmnZeP88CAAwdZTuYbpAAxipx8Di4RCLEppsnN+0+sGtq5M3nGqVK4VV5nWdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759570692; c=relaxed/simple;
	bh=8AaVzDBT+1bpRZBYJICFy/qqpG/gyV2sedJWv3ZgPNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZcJBSglpuvTwRk4Y3VBHM6p0xedytMaIUGbAo0q+1RsNKFPtAHkk6DFGqwYjQAp3RUbApOs3rx4luLxlkF8n4yEXmf64xg2oVF+GFjP9BGKWD0E/QX8IhLh9dTH2HqGvXewRN4L+KD+zleSYNMHXQ66wiBSHuIcDEYsZQLc3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTCkgvrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9B0C4CEF1;
	Sat,  4 Oct 2025 09:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759570692;
	bh=8AaVzDBT+1bpRZBYJICFy/qqpG/gyV2sedJWv3ZgPNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTCkgvrl9xw5RjwQhfqko5gOWy8dAHRYCS0qSk6UGgkitfLA+eEkx/ci1Kn3ZUaLX
	 qiJYzGB75OaZAgZJZcXh84wexRJmF8eZKVYU/zId3/wcPxJdLdjXm4m9sGlWTN6Ej9
	 Y0Fn0223gDqdjh+DVlFRflNmunoUtwNA91/5UClkkpEtB4u/nkfI4ftoNdyQyyRGVZ
	 fzJgPXC3dBafQUgbkqG+UDoQnHKcsLlgROir9oFIe2A4bmYByp529erglzZ91xdjUu
	 NKw4meXUSvzBmyXdomB7cvTfPQUEisApMpVKKp+9m1Tb9/ujvEIGqBHLl0IKdm0DV2
	 ZAUE8ELsRbFIg==
Date: Sat, 4 Oct 2025 10:38:05 +0100
From: Simon Horman <horms@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	gargaditya@microsoft.com, ssengar@linux.microsoft.com
Subject: Re: [PATCH net-next] net: mana: Linearize SKB if TX SGEs exceeds
 hardware limit
Message-ID: <20251004093805.GB3060232@horms.kernel.org>
References: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Fri, Oct 03, 2025 at 08:47:24AM -0700, Aditya Garg wrote:
> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
> per TX WQE. In rare configurations where MAX_SKB_FRAGS + 2 exceeds this
> limit, the driver drops the skb. Add a check in mana_start_xmit() to
> detect such cases and linearize the SKB before transmission.
> 
> Return NETDEV_TX_BUSY only for -ENOSPC from mana_gd_post_work_request(),
> send other errors to free_sgl_ptr to free resources and record the tx
> drop.
> 
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 26 +++++++++++++++----
>  include/net/mana/gdma.h                       |  8 +++++-
>  include/net/mana/mana.h                       |  1 +
>  3 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index f4fc86f20213..22605753ca84 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -20,6 +20,7 @@
>  
>  #include <net/mana/mana.h>
>  #include <net/mana/mana_auxiliary.h>
> +#include <linux/skbuff.h>
>  
>  static DEFINE_IDA(mana_adev_ida);
>  
> @@ -289,6 +290,19 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	cq = &apc->tx_qp[txq_idx].tx_cq;
>  	tx_stats = &txq->stats;
>  
> +	BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES != MANA_MAX_TX_WQE_SGL_ENTRIES);
> +	#if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)

Hi Aditya,

I see that Eric has made a more substantial review of this patch,
so please follow his advice.

But I wanted to add something to keep in mind for the future: I if the #if
/ #else used here can be replaced by a simple if() statement, then that
would be preferable.  The advantage being that it improves compile
coverage.  And, as these are all constants, I would expect the compiler to
optimise away any unused code.

N.B: I did not check, so please consider this more of a general statement

> +		if (skb_shinfo(skb)->nr_frags + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES) {
> +			netdev_info_once(ndev,
> +					 "nr_frags %d exceeds max supported sge limit. Attempting skb_linearize\n",
> +					 skb_shinfo(skb)->nr_frags);
> +			if (skb_linearize(skb)) {
> +				netdev_warn_once(ndev, "Failed to linearize skb\n");
> +				goto tx_drop_count;
> +			}
> +		}
> +	#endif
> +
>  	pkg.tx_oob.s_oob.vcq_num = cq->gdma_id;
>  	pkg.tx_oob.s_oob.vsq_frame = txq->vsq_frame;
>  

...

