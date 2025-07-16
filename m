Return-Path: <linux-hyperv+bounces-6266-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87C8B071A9
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 11:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C8C1713C4
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D02EACE8;
	Wed, 16 Jul 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri1VwvBt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8B27144B;
	Wed, 16 Jul 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658171; cv=none; b=p/VKeN5eKLHJR0EZvjmqI/ljgkWNvGQqLCMucDP1KuCf/0eSrZXIy4P91D7pSu9wVt1tzmwQVIZvaES2VvkhgLJbnlLawhrLLtMqGHcAxEIAp7j/TKU0LdSKG8wjO1ENQEarRam0oTEZp+c2s6uLIPO4b7iI6ch9hDWT/Mg9NGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658171; c=relaxed/simple;
	bh=Q7MpBxHhLYZtgoKpqrLMIgiJmEI6yYKrcfDI0udeLak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG74rg1+Qkz9k8q52Nn1stnYsWYNzjl7eo2ez2lVPjueicTfSAMyC4v1oKzh0F2HAGnOB1vM05r1OTma2Y6kU9zaID1e7b8afxoieNjiHmDf62SEaIyZIzEU0fzgZp7qvmIpzyPPPbCJFJD22RQH6G+x/7aXI+g8CX11+OxIO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri1VwvBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE42C4CEF0;
	Wed, 16 Jul 2025 09:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752658171;
	bh=Q7MpBxHhLYZtgoKpqrLMIgiJmEI6yYKrcfDI0udeLak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ri1VwvBt4b1jw1HFVI0j6JpA2cT5+8zcWOFB4Je55HaxDf+A0OCAVe0x/hN78k13j
	 o9AYzcsJOHRNJAqcKCJ15m8y9f/vfEAMG9AFVSciJA41/NkMWeiomonFFW6TvpUK72
	 Rp8u8FWgo89DGhZuGx2p0ggiAv5PzbaLne6O3Yh1xwFmYJMuUyYXseztgJ2Szg2kFj
	 0Le9/JbY7uvORHda4VcSCtOSapTTDySOaAu/6dkTsffCnetnMwOqZ+Cm5uJrPHVxFR
	 k8hiTQYnNXw+6QlkKBKSB5EkSy9CA4+sBz26le2wHZR0+n/67wgtj4yaVi7v818AGT
	 FI216dOBpuotg==
Date: Wed, 16 Jul 2025 10:29:27 +0100
From: Simon Horman <horms@kernel.org>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Long Li <longli@microsoft.com>, Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH v3] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF
 before open to prevent IPv6 addrconf
Message-ID: <20250716092927.GO721198@horms.kernel.org>
References: <20250716002607.4927-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716002607.4927-1-litian@redhat.com>

+ Xin Long

On Wed, Jul 16, 2025 at 08:26:05AM +0800, Li Tian wrote:
> Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.
> 
> Commit under Fixes added a new flag change that was not made
> to hv_netvsc resulting in the VF being assinged an IPv6.
> 
> Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
> Suggested-by: Cathy Avery <cavery@redhat.com>
> Signed-off-by: Li Tian <litian@redhat.com>
> ---
> v3:
>   - only fixes commit message.
> v2: https://lore.kernel.org/netdev/20250710024603.10162-1-litian@redhat.com/
>   - instead of replacing flag, add it.
> v1: https://lore.kernel.org/netdev/20250710024603.10162-1-litian@redhat.com/
> ---
>  drivers/net/hyperv/netvsc_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Hi Li Tian,

Thanks for addressing earlier feedback.

I don't think you need to repost because of this, but for future reference:

1. Because this is a fix for a commit that is present in net
   it should be targeted at that tree.

   Subject: [PATCH net vX] ...

2. Please use get_maintainers.pl this.patch to generate the CC list. In
   this case Xin Long (now CCed) should be included as he is the author of the
   patch cited in the Fixes tag.

   b4 can help you with this and other aspects of patch management.

> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index c41a025c66f0..8be9bce66a4e 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2317,8 +2317,11 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
>  	if (!ndev)
>  		return NOTIFY_DONE;
>  
> -	/* set slave flag before open to prevent IPv6 addrconf */
> +	/* Set slave flag and no addrconf flag before open
> +	 * to prevent IPv6 addrconf.
> +	 */
>  	vf_netdev->flags |= IFF_SLAVE;
> +	vf_netdev->priv_flags |= IFF_NO_ADDRCONF;
>  	return NOTIFY_DONE;
>  }
>  
> -- 
> 2.50.0
> 
> 

