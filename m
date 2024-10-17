Return-Path: <linux-hyperv+bounces-3150-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2D9A2752
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Oct 2024 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FD99B2A8A4
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Oct 2024 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BEF1DED70;
	Thu, 17 Oct 2024 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfvWlQxl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1D1DED58;
	Thu, 17 Oct 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179879; cv=none; b=iUeXvtM7CFSUncsbagfZ4TUj4FECmEVcKkB7eGy25Qwtculkl5VxwaMYbhkcPPtbwYDCcNRdsSNUGv3h1GXOPTzoSJe+iG5DUrEn+1NhZdtq7VKdwq0Wiy5jbpWMYN57fCpaKZJ4eYBSFOyG0OXRKUpsvCD3MYTksHmuUuwECdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179879; c=relaxed/simple;
	bh=H/WlUb69oaYSW2WFy03JE5lcNIzLGLsQCemNi3ZnmaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfU3qK3QKFNwPZzAOAXbVdkzaoc/c5/cOgnC0JH8YXhMQIzm7NakTn0IN2z98agv1Vs5S2/Xcm/i82YrgneCh26cwIGB54KnXQMwHitZxcw7HzRyi8PWD1m3G6Jks2Kp8QWZWfrwUGPTKe9es53SBAeNWGADZj5FKe1uQMvh8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfvWlQxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19EEC4CEC3;
	Thu, 17 Oct 2024 15:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179878;
	bh=H/WlUb69oaYSW2WFy03JE5lcNIzLGLsQCemNi3ZnmaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfvWlQxlnQukgvMdFy/P1UrJxtK89LTdB03AhAnjVil4VDv2MAZhLY4D3ScnLXd1D
	 gE6uTJ6EwjCpi6evZkIhApQfCQgj9sDe5/TU5XlNQzid+hJw/NR4mtioijT+e7AIhS
	 2EHuWxPWtkKb8NEHnJ1r3T88QH6nVL9uyaPVat6Jikz7I/dC4Nwr/htv8QrutlCa4N
	 i1/Jd/6y+lBgfdQMu1tZsaLuCtCfzut3VsiqxMRbBSU4yxRVgzzoFaewHmal66eMn8
	 31NqR8975kSHZTaNOPVrWvv9/uJqKKx2KVn4OxVXQ7trWEVt7ut+I3VB9uAD2CDZSn
	 8ulEJE8n5buXA==
Date: Thu, 17 Oct 2024 16:44:33 +0100
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, stephen@networkplumber.org,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net,v2] hv_netvsc: Fix VF namespace also in synthetic NIC
 NETDEV_REGISTER event
Message-ID: <20241017154433.GV1697@kernel.org>
References: <1729093437-28674-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729093437-28674-1-git-send-email-haiyangz@microsoft.com>

On Wed, Oct 16, 2024 at 08:43:57AM -0700, Haiyang Zhang wrote:
> The existing code moves VF to the same namespace as the synthetic NIC
> during netvsc_register_vf(). But, if the synthetic device is moved to a
> new namespace after the VF registration, the VF won't be moved together.
> 
> To make the behavior more consistent, add a namespace check for synthetic
> NIC's NETDEV_REGISTER event (generated during its move), and move the VF
> if it is not in the same namespace.
> 
> Cc: stable@vger.kernel.org
> Fixes: c0a41b887ce6 ("hv_netvsc: move VF to same namespace as netvsc device")
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v2: Move my fix to synthetic NIC's NETDEV_REGISTER event as suggested by Stephen.
> 
> ---
>  drivers/net/hyperv/netvsc_drv.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 153b97f8ec0d..54e98356ee93 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2798,6 +2798,30 @@ static struct  hv_driver netvsc_drv = {
>  	},
>  };
>  
> +/* Set VF's namespace same as the synthetic NIC */
> +static void netvsc_event_set_vf_ns(struct net_device *ndev)
> +{
> +	struct net_device_context *ndev_ctx = netdev_priv(ndev);
> +	struct net_device *vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
> +	int ret;

In Networking code it is preferred to arrange local variables in reverse
xmas tree order - longest line to shortest.

I believe that could be achieved as follows (completely untested!):

	struct net_device_context *ndev_ctx = netdev_priv(ndev);
	struct net_device *vf_netdev;
	int ret;

	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
	if (!vf_netdev)
		return;

With that addressed please feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

> +
> +	if (!vf_netdev)
> +		return;
> +
> +	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
> +		ret = dev_change_net_namespace(vf_netdev, dev_net(ndev),
> +					       "eth%d");
> +		if (ret)
> +			netdev_err(vf_netdev,
> +				   "Cannot move to same namespace as %s: %d\n",
> +				   ndev->name, ret);
> +		else
> +			netdev_info(vf_netdev,
> +				    "Moved VF to namespace with: %s\n",
> +				    ndev->name);
> +	}
> +}
> +
>  /*
>   * On Hyper-V, every VF interface is matched with a corresponding
>   * synthetic interface. The synthetic interface is presented first
> @@ -2810,6 +2834,11 @@ static int netvsc_netdev_event(struct notifier_block *this,
>  	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
>  	int ret = 0;
>  
> +	if (event_dev->netdev_ops == &device_ops && event == NETDEV_REGISTER) {
> +		netvsc_event_set_vf_ns(event_dev);
> +		return NOTIFY_DONE;
> +	}
> +
>  	ret = check_dev_is_matching_vf(event_dev);
>  	if (ret != 0)
>  		return NOTIFY_DONE;

-- 
pw-bot: changes-requested

