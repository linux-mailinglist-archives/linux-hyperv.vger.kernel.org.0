Return-Path: <linux-hyperv+bounces-857-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046307E8F56
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Nov 2023 10:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B321C2030E
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Nov 2023 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395895235;
	Sun, 12 Nov 2023 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umeAOQNv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175505228;
	Sun, 12 Nov 2023 09:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17725C433C7;
	Sun, 12 Nov 2023 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699782085;
	bh=QbWO5jczDTWfiCBuWGRjNrmWNSsp8db3vx0cMyEInsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umeAOQNvYTTSjOARLRDC8O83rwJGdTlNbnWGhFv+AtM1FcY6KDGpu0ebt34mXyMgs
	 mzx0rO291VsLcpjMPdY/+qqpyqcHiwVs4driFi4ruXjHDBpqdNxdN5x8odw4LgZ9el
	 fAov68D2HIVZOwkG774JqCWgLv+hs4uA90uvqXzRa/fP023WJEH1imsbh8e4KzmJ6L
	 +AVidXc0e1g+uBfpun3DIuvUPzzxkHSHSmjdtn6AXbxcCD719eeFnIGQPofdh1WPE3
	 EIipNt01pq8UELRHjoKHEcBADsVRNSUSeM5S0Jy+TbrU3pKVX5K8BkYRXVenpiGCI7
	 yQivqWp6ApWqw==
Date: Sun, 12 Nov 2023 09:41:15 +0000
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net,v4, 2/3] hv_netvsc: Fix race of
 register_netdevice_notifier and VF register
Message-ID: <20231112094115.GE705326@kernel.org>
References: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
 <1699627140-28003-3-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699627140-28003-3-git-send-email-haiyangz@microsoft.com>

On Fri, Nov 10, 2023 at 06:38:59AM -0800, Haiyang Zhang wrote:
> If VF NIC is registered earlier, NETDEV_REGISTER event is replayed,
> but NETDEV_POST_INIT is not.
> 
> Move register_netdevice_notifier() earlier, so the call back
> function is set before probing.
> 
> Cc: stable@vger.kernel.org
> Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> ---
> v3:
>   Divide it into two patches, suggested by Jakub Kicinski.
> v2:
>   Fix rtnl_unlock() in error handling as found by Wojciech Drewek.
> ---
>  drivers/net/hyperv/netvsc_drv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 5e528a76f5f5..1d1491da303b 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2793,11 +2793,14 @@ static int __init netvsc_drv_init(void)
>  	}
>  	netvsc_ring_bytes = ring_size * PAGE_SIZE;
>  
> +	register_netdevice_notifier(&netvsc_netdev_notifier);
> +
>  	ret = vmbus_driver_register(&netvsc_drv);
> -	if (ret)
> +	if (ret) {
> +		unregister_netdevice_notifier(&netvsc_netdev_notifier);
>  		return ret;
> +	}
>  
> -	register_netdevice_notifier(&netvsc_netdev_notifier);
>  	return 0;
>  }

Hi Haiyang Zhang,

functionally this change looks good to me, thanks!

I'm wondering if we could improve things slightly by using a more idiomatic
form for the error path. Something like the following (completely untested!).

My reasoning is that this way things are less likely go to wrong if more
error conditions are added to this function later.

	...

	register_netdevice_notifier(&netvsc_netdev_notifier);

	ret = vmbus_driver_register(&netvsc_drv);
	if (ret)
		goto err_unregister_netdevice_notifier;

	return 0;

err_unregister_netdevice_notifier:
	unregister_netdevice_notifier(&netvsc_netdev_notifier);
	return ret;
}


