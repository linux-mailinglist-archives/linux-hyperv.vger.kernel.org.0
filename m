Return-Path: <linux-hyperv+bounces-21-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97483799E96
	for <lists+linux-hyperv@lfdr.de>; Sun, 10 Sep 2023 16:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A043F1C20821
	for <lists+linux-hyperv@lfdr.de>; Sun, 10 Sep 2023 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C25399;
	Sun, 10 Sep 2023 14:01:42 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723711C3F;
	Sun, 10 Sep 2023 14:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467F1C433C8;
	Sun, 10 Sep 2023 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694354500;
	bh=4feami3dBSptyUGt9mIvJ79AWuoLTMKWWCgPgrZt3z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RfDELed6MzYoBnaSAcTE7etwAsApCxpkWvitqBw5AuZz1FIkZUm4vOQJHTcbApFBq
	 zp4F8GHEhwstnKStqq8WQKsX750DBHHQKXffhpR1fLYbRdU2vk2GdsEz/yy9yIYDDS
	 vur+HGtA+os56SKO+hBwf9C2nlGqEMDU1iTSKMaB4jDDgEQCjJx7ZfeFgfqLH3/WS1
	 bSHM+TdvrVcvMnyTwc61c6rgr4U6JP3WBXakJ5y+2jOlGdT7A9dkxPLvAhb7BU8U5I
	 JTJt8PGUNf9BMuEDJyqeatNI0wHDkJ9GnP42M6Aw75x4q4we0nn8N3QXAkSp9kzDjb
	 2HZghvgwVG+FA==
Date: Sun, 10 Sep 2023 16:01:35 +0200
From: Simon Horman <horms@kernel.org>
To: Sonia Sharma <sosha@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, sosha@microsoft.com, kys@microsoft.com,
	mikelley@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v4 net] net: hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Message-ID: <20230910140135.GC775887@kernel.org>
References: <1694116607-24755-1-git-send-email-sosha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694116607-24755-1-git-send-email-sosha@linux.microsoft.com>

On Thu, Sep 07, 2023 at 12:56:47PM -0700, Sonia Sharma wrote:
> From: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> The switch statement in netvsc_send_completion() is incorrectly validating
> the length of incoming network packets by falling through to the next case.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
> The current code has not caused any known failures. But nonetheless, the
> code should be corrected as a different ordering of the switch cases might
> cause a length check to fail when it should not.
> 
> Fixes: 44144185951a0f ("hv_netvsc: Add validation for untrusted Hyper-V values")

As the current code is correct - it works - I feel that this is more of a
clean-up than a fix. As such I suggest dropping the fixes tag and
retargeting at net-next (which is due to re-open in the coming days).

> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> ---
> Changes in v3:
> * added return statement in default case as pointed by Michael Kelley.
> Changes in v4:
> * added fixes tag
> * modified commit message to explain the issue fixed by patch.
> ---
>  drivers/net/hyperv/netvsc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 82e9796c8f5e..0f7e4d377776 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -851,7 +851,7 @@ static void netvsc_send_completion(struct net_device *ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>  
>  	case NVSP_MSG1_TYPE_SEND_RECV_BUF_COMPLETE:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -860,7 +860,7 @@ static void netvsc_send_completion(struct net_device *ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>  
>  	case NVSP_MSG1_TYPE_SEND_SEND_BUF_COMPLETE:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -869,7 +869,7 @@ static void netvsc_send_completion(struct net_device *ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>  
>  	case NVSP_MSG5_TYPE_SUBCHANNEL:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -878,10 +878,6 @@ static void netvsc_send_completion(struct net_device *ndev,
>  				   msglen);
>  			return;
>  		}
> -		/* Copy the response back */
> -		memcpy(&net_device->channel_init_pkt, nvsp_packet,
> -		       sizeof(struct nvsp_message));
> -		complete(&net_device->channel_init_wait);
>  		break;
>  
>  	case NVSP_MSG1_TYPE_SEND_RNDIS_PKT_COMPLETE:
> @@ -904,13 +900,19 @@ static void netvsc_send_completion(struct net_device *ndev,
>  
>  		netvsc_send_tx_complete(ndev, net_device, incoming_channel,
>  					desc, budget);
> -		break;
> +		return;
>  
>  	default:
>  		netdev_err(ndev,
>  			   "Unknown send completion type %d received!!\n",
>  			   nvsp_packet->hdr.msg_type);
> +		return;
>  	}
> +
> +	/* Copy the response back */
> +	memcpy(&net_device->channel_init_pkt, nvsp_packet,
> +			sizeof(struct nvsp_message));

nit: the indentation of the line above is not correct.

	memcpy(&net_device->channel_init_pkt, nvsp_packet,
	       sizeof(struct nvsp_message));

> +	complete(&net_device->channel_init_wait);
>  }
>  
>  static u32 netvsc_get_next_send_section(struct netvsc_device *net_device)
> -- 
> 2.25.1
> 
> 

