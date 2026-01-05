Return-Path: <linux-hyperv+bounces-8146-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 250CCCF360D
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 12:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7B6D3018325
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 11:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BE1335076;
	Mon,  5 Jan 2026 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA5rotvD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A57335060;
	Mon,  5 Jan 2026 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613776; cv=none; b=d+zY6p2zNr/eiWqEimVj9deTVOZHwXTjGYyXaQXrmGqMRGvTCf2zfZS++PrBCw4N4yFTE/dXO5Dy2bSdlidRVZMWKpgVucgwU1UFicSv9Gpn1ae8XfoQIC04u5KSD/vFpPSWwo77MSNWFAuesa45JoTQixNxqq83CB0Vyhtklkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613776; c=relaxed/simple;
	bh=yWu645PPDBjG4J1fJYBg5tusEONb7bKGLU7c13nDQJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTwXILZMeBWuTegz2yOlVGGJSR31gnswTzjyRmRaoNMhxVIEknYn8IOXZQRFcgm76XiR3z4P61h5w+XbMPC6tzlVQKEX5XOJ8gVXyePJgTgrBiMrBxzna2cPHcfkISHm83j1yCB98Ve0BvQuABzN9275FkjjLV8hsSetsXupumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA5rotvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB68C19421;
	Mon,  5 Jan 2026 11:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767613775;
	bh=yWu645PPDBjG4J1fJYBg5tusEONb7bKGLU7c13nDQJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bA5rotvDlyCaLm7EtL2iBPGJw/Au9k0G72MCu+EKs6p5iLzStc6XznizNcA8iQ6gV
	 otTYllFnOWjne9l0Qs8D4fqOTWOBUg58fsvi0d4QVGhlSAdE0DmZMIXcwmUb6wQohE
	 tlo+jPFzHYjExWA65Ik5GX7b+BHnYbN0PrS6+mhHW/wuP/pyOU01pQkm3pGWctuw7O
	 qvFRuoKEHfG8sqj/7DFsjPba3EgP8I+1SToDrmWieg/ak9RtjY+12r+KuCjIESz63+
	 ng0ogXey35ODFl1s572WpnSrfBVQdaz5liQ+iJF6kHfo3IAhJS7M08Hi7uAYn7mz8K
	 jKspppuY0ls3g==
Date: Mon, 5 Jan 2026 11:49:29 +0000
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	paulros@microsoft.com
Subject: Re: [PATCH RFC 1/2] net: mana: Add support for coalesced RX packets
 on CQE
Message-ID: <20260105114929.GA330625@horms.kernel.org>
References: <1765900682-22114-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1765900682-22114-1-git-send-email-haiyangz@linux.microsoft.com>

On Tue, Dec 16, 2025 at 07:57:54AM -0800, Haiyang Zhang wrote:
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
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

...

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 0e2f4343ac67..1b9ed5c9bbff 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -397,6 +397,58 @@ static void mana_get_channels(struct net_device *ndev,
>  	channel->combined_count = apc->num_queues;
>  }
>  
> +static int mana_get_coalesce(struct net_device *ndev,
> +			     struct ethtool_coalesce *ec,
> +			     struct kernel_ethtool_coalesce *kernel_coal,
> +			     struct netlink_ext_ack *extack)

...

> +	if (err) {
> +		netdev_err(ndev, "Set rx-frames to %u failed:%d\n",
> +			   ec->rx_max_coalesced_frames, err);
> +		NL_SET_ERR_MSG_FMT(extack, "Set rx-frames to %u failed:%d\n",
> +				   ec->rx_max_coalesced_frames, err);

nit: I don't think the trailing '\n' is necessary here.

     Flagged by coccinelle.

> +
> +		apc->cqe_coalescing_enable = saved_cqe_coalescing_enable;
> +	}
> +
> +	return err;
> +}

...

