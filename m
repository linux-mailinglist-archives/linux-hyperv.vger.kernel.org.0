Return-Path: <linux-hyperv+bounces-6836-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC5DB54DC9
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 14:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FF1B634B0
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB553093CF;
	Fri, 12 Sep 2025 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrwhzFll"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715D3009F1;
	Fri, 12 Sep 2025 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680135; cv=none; b=J9a7mkPTIvlO8lxPS4jofJMxIMYEDmawNP+nTnAi3ijwqdQnaLiDGwtL9yMfN2FcFr2sw1HoBGJhUVp8IktdqF1S0KnzVR67Xj4+v78032mpvj9SwfNm0JOBpbLRr2pl+kVeKStyTfjBWkJtR56LIBcfsAsNRefKbOGYaAqURpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680135; c=relaxed/simple;
	bh=p830gX6KrZsA/EMfLPYi3m+Z9YLsy7fuGVZR/1xn9+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW4JDWwoLvm8pLwnGWopNHfGaDVsT+qRwin7+KTiFNTsrVrNrpc/Izy+GjFzZ94uGxN7WlNbq7hAE9OEXhOTEQ84vxvWHU8lLs2mhagSm79ZufplWk3Vz9A+5YONuM9SJSSkRsDj5VYgUE9n5aWv8fZHW0mwTQWDrqHEsw6Ywx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrwhzFll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37AEC4CEFC;
	Fri, 12 Sep 2025 12:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757680135;
	bh=p830gX6KrZsA/EMfLPYi3m+Z9YLsy7fuGVZR/1xn9+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrwhzFllMgE7HXfxOzRoap2O3zAjm2C6UWg8j5eEeGhNzmmoqua5Q63o6PQLL17Bs
	 j8qpa8aQ8fRv/RRuE0lq2Dr90b3mo/s89vhlw9A2p6shCadDxHbbuzfeOE2gScV0BZ
	 IYm6IXo9HnWwnBkQE15gFxKUzmunVj2GXx4CAxcXqkar6d8eK2cYiiQ8UAW3GhRPs3
	 KvgDoGPK+6EuFFNZu4h84Qbj+s+SSafvil7KQyUVLqE0nUrMoMMAW78+CcEn+pQoxH
	 /Il8wgj+JWCpO/ywvIVO3XCpOHS0gsXvhn/xOmtH8+Eclh89bdtJqqVGmRqL8bQ4HG
	 YDBApuXS1/2GA==
Date: Fri, 12 Sep 2025 13:28:49 +0100
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	haiyangz@microsoft.com, decui@microsoft.com, kys@microsoft.com,
	wei.liu@kernel.org, edumazet@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, kotaranov@microsoft.com,
	shirazsaleem@microsoft.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Reduce waiting time if HWC not
 responding
Message-ID: <20250912122849.GA30363@horms.kernel.org>
References: <1757537841-5063-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757537841-5063-1-git-send-email-haiyangz@linux.microsoft.com>

On Wed, Sep 10, 2025 at 01:57:21PM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> If HW Channel (HWC) is not responding, reduce the waiting time, so further
> steps will fail quickly.
> This will prevent getting stuck for a long time (30 minutes or more), for
> example, during unloading while HWC is not responding.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/hw_channel.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index ef072e24c46d..ada6c78a2bef 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -881,7 +881,12 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  	if (!wait_for_completion_timeout(&ctx->comp_event,
>  					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
>  		if (hwc->hwc_timeout != 0)
> -			dev_err(hwc->dev, "HWC: Request timed out!\n");
> +			dev_err(hwc->dev, "HWC: Request timed out: %u ms\n",
> +				hwc->hwc_timeout);
> +
> +		/* Reduce further waiting if HWC no response */
> +		if (hwc->hwc_timeout > 1)
> +			hwc->hwc_timeout = 1;

Hi,

Perhaps it is already the case, but I'm wondering if the configured
value of hwc_timeout should be restored at some point.

>  
>  		err = -ETIMEDOUT;
>  		goto out;
> -- 
> 2.34.1
> 
> 

