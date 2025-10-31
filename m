Return-Path: <linux-hyperv+bounces-7397-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E4C272C0
	for <lists+linux-hyperv@lfdr.de>; Sat, 01 Nov 2025 00:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647A01B26132
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 23:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9512EA151;
	Fri, 31 Oct 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmIO+NUE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96B1E5213;
	Fri, 31 Oct 2025 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761952646; cv=none; b=RvNXkgAGFVn5YLOPGjuvaDyhuhQzGmd2IMpFJ+T6eZVNDe7MblC8LsP76gegiiTGBGbnBCJV2r5YnVIoGABdhfvx+ecHzJy5AbUDEEjjEzAn2uzVzbeIR8CBqbWbEDdqcYEuHZCRiP3ArmYWGPUum8GjVb5KNMamBcWIaVZHPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761952646; c=relaxed/simple;
	bh=u+RERNFFg9EMVNkhjnKKx/r/Ck28/clNwkMq3bBSFEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDQ4llnQoeQ8lHJ5AY2IZoigIGC1djwvq0CGme1jxuisXrNLMCqnNey/r5AQS5l7wsFZl/S5itYLe+amvGFOJK5MMpVbaNiKE8j9wq7DoBFPjTzn+yNw363SIw5uyTOvS0sN1XemqBHpIlldliQ78t2blp2SULOzs92FHOheu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmIO+NUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D96C4CEE7;
	Fri, 31 Oct 2025 23:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761952645;
	bh=u+RERNFFg9EMVNkhjnKKx/r/Ck28/clNwkMq3bBSFEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OmIO+NUEsVAqb68y8+VEdiNtCHt3pP/6LzU8oo3oHw4ZTMl7Boz+qDwejh1feCe8x
	 22/nTDxNfzYnKIG49TLP8/4uborOLFgHYKzCn2wI4TkQG3CYKixr7kP4QFiTNTMi8b
	 0d6h9jaAJrqgzKLIp+or42dLlDwn+9+l6eSe9FkgWAHjDG7cSV41NfnJgjXnVjYTeg
	 f+ESPrFvRf4igJ8z6Qf31WCzTd8FBhXcivdXYzGqXuiUWQJPfQonn2t0wcwC0Isrj5
	 86gE8R/GQoGQ968OdvrpxLIKu/HGCc2RgkK2NUzTCc1zeZOC8h3mMkI6Qwwva2qltD
	 gqneERgLQQsZg==
Date: Fri, 31 Oct 2025 16:17:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 rosenp@gmail.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: mana: Add standard counter
 rx_missed_errors
Message-ID: <20251031161723.057e4770@kernel.org>
In-Reply-To: <1761734272-32055-3-git-send-email-ernis@linux.microsoft.com>
References: <1761734272-32055-1-git-send-email-ernis@linux.microsoft.com>
	<1761734272-32055-3-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 03:37:52 -0700 Erni Sri Satya Vennela wrote:
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 009e869ef296..48df44889f05 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -494,6 +494,11 @@ static void mana_get_stats64(struct net_device *ndev,
>  
>  	netdev_stats_to_stats64(st, &ndev->stats);
>  
> +	if (apc->ac->hwc_timeout_occurred)
> +		netdev_warn_once(ndev, "HWC timeout occurred\n");

I don't think there's much value in this print.

> +#define MANA_GF_STATS_PERIOD (2 * HZ)
> +
> +static void mana_gf_stats_work_handler(struct work_struct *work)
> +{
> +	struct mana_context *ac =
> +		container_of(to_delayed_work(work), struct mana_context, gf_stats_work);
> +	int err;
> +
> +	err = mana_query_gf_stats(ac);
> +	if (err == -ETIMEDOUT) {
> +		/* HWC timeout detected - reset stats and stop rescheduling */
> +		ac->hwc_timeout_occurred = true;
> +		memset(&ac->hc_stats, 0, sizeof(ac->hc_stats));

Not sure I've seen another device using this approach but I can't
really tell what's the best strategy. The device is unusable if it
can't provide stats..

> +		return;
> +	}
> +	queue_delayed_work(ac->gf_stats_wq, &ac->gf_stats_work, MANA_GF_STATS_PERIOD);
> +}
> +
>  int mana_probe(struct gdma_dev *gd, bool resuming)
>  {
>  	struct gdma_context *gc = gd->gdma_context;
> @@ -3478,6 +3503,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
>  	}
>  
>  	err = add_adev(gd, "eth");
> +	ac->gf_stats_wq = create_singlethread_workqueue("mana_gf_stats");

Why are you creating a workqueue? You can use system queues.

> +	queue_delayed_work(ac->gf_stats_wq, &ac->gf_stats_work, MANA_GF_STATS_PERIOD);

ls wrap long lines at 80 chars.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 3dfd96146424..99e811208683 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -213,8 +213,6 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
>  
>  	if (!apc->port_is_up)
>  		return;
> -	/* we call mana function to update stats from GDMA */
> -	mana_query_gf_stats(apc->ac);

Why delete this? We can get fresh stats for the user in this context.

