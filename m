Return-Path: <linux-hyperv+bounces-7498-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA37C4F2B2
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 18:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325B018912DF
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859DF377EAD;
	Tue, 11 Nov 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5x3C+2y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5406B377E99;
	Tue, 11 Nov 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880548; cv=none; b=mJzUeyMVgzzvYjYzj3AXZE+OOSb5QVtDPtW28KhLkEy9V+UBInzXRuTg5H4AMhgUhL9B7mUI5rnYRJqWBGPb+CCeH/dj8clbja+pnT1Lpt7wPXtubuo9N+K38HUPoka+oSSXiHrpSEAONIRAiPSStayq7ItdU9l1CtXiYT0JLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880548; c=relaxed/simple;
	bh=aC8mFVsiXSKQII7rj8zfxhDyGl3N32KQM4gxk2P9u9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD8PXiUtOTwue+Xng7uETUAkEyD4fPgsuCMXZiCKTISKhhAwxnxnMWtQRjBULzeR9qcUhJ8weyesySSqf67q74Cy36A7J1mCctocatjllYNRCRi2Vk9DREhQ4w1xXl+w3x7unW9DePo2Un2zPpsxIqEbdMkBwD5mCwX8Q3ZgBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5x3C+2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F8CC19423;
	Tue, 11 Nov 2025 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762880547;
	bh=aC8mFVsiXSKQII7rj8zfxhDyGl3N32KQM4gxk2P9u9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5x3C+2y1jD+A5cP+v5i8GCa6B/a+dIXL20RXE6Md41ka7o8g8EYVMKUW2N7yPjy9
	 7G7zmmBQB/8i+T5SuWuIN+UUCnUsiz+NMNOcCH4QkYL3gynmSRBRhYV0LGTTh2TWAK
	 3FFbsjD3yluks9jj5/kf9reZD3Y0eqzQIZZXHxvaqaQO5vj9lOCO1FAGbEwAVuoR7R
	 LmZZXXDi7VoS7uVVjQCe7deT98bskfftEn8obU2om9HrNFtah24cZ8whp9gvMV/D+F
	 kMHGyKCi+a1xYFj653hZ0qei3xqUYp6GO/hnUXRqZSaE03oYDJgDcimzFmPlP1yRyb
	 6tGBIpxK9fFwg==
Date: Tue, 11 Nov 2025 17:02:21 +0000
From: Simon Horman <horms@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com
Subject: Re: [PATCH net-next, v3] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <aRNsHUjW3PybGXCK@horms.kernel.org>
References: <20251110103541.GA30450@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110103541.GA30450@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Nov 10, 2025 at 02:35:41AM -0800, Dipayaan Roy wrote:
> Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detected
> and a device-controlled port reset for all queues can be scheduled to a
> ordered workqueue. The reset for all queues on stall detection is
> recomended by hardware team.
> 
> The change introduces a single ordered workqueue
> ("mana_per_port_queue_reset_wq") with WQ_UNBOUND | WQ_MEM_RECLAIM and
> queues exactly one work_struct per port onto it.

I see that this goes some way to addressing Jakub's feedback
on the commit message in his review of v2. But I this paragraph
isn't adding much in it's current form. It seems to me some
explanation of why why WQ_UNBOUND and WQ_MEM_RECLAIM are used is
appropriate.

[1] https://lore.kernel.org/all/20251029182233.59aea2d3@kernel.org/

> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
> Changes in v3:
>   -Fixed commit meesage, removed rtnl_trylock and added
>    disable_work_sync, fixed mana_queue_reset_work, and few
>    cosmetics.
> Changes in v2:
>   -Fixed cosmetic changes.
> ---
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 78 ++++++++++++++++++-
>  include/net/mana/gdma.h                       |  7 +-
>  include/net/mana/mana.h                       |  7 ++
>  3 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index cccd5b63cee6..636df3b066c5 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -298,6 +298,42 @@ static int mana_get_gso_hs(struct sk_buff *skb)
>  	return gso_hs;
>  }
>  
> +static void mana_per_port_queue_reset_work_handler(struct work_struct *work)
> +{
> +	struct mana_queue_reset_work *reset_queue_work =
> +			container_of(work, struct mana_queue_reset_work, work);
> +
> +	struct mana_port_context *apc = container_of(reset_queue_work,
> +						     struct mana_port_context,
> +						     queue_reset_work);
> +	struct net_device *ndev = apc->ndev;
> +	int err;
> +
> +	rtnl_lock();
> +
> +	/* Pre-allocate buffers to prevent failure in mana_attach later */
> +	err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
> +	if (err) {
> +		netdev_err(ndev, "Insufficient memory for reset post tx stall detection\n");
> +		goto out;
> +	}
> +
> +	err = mana_detach(ndev, false);
> +	if (err) {
> +		netdev_err(ndev, "mana_detach failed: %d\n", err);
> +		goto dealloc_pre_rxbufs;
> +	}
> +
> +	err = mana_attach(ndev);
> +	if (err)
> +		netdev_err(ndev, "mana_attach failed: %d\n", err);
> +
> +dealloc_pre_rxbufs:
> +	mana_pre_dealloc_rxbufs(apc);
> +out:
> +	rtnl_unlock();
> +}
> +
>  netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	enum mana_tx_pkt_format pkt_fmt = MANA_SHORT_PKT_FMT;
> @@ -802,6 +838,23 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
>  	return err;
>  }
>  
> +static void mana_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> +{
> +	struct mana_port_context *apc = netdev_priv(netdev);
> +	struct mana_context *ac = apc->ac;
> +	struct gdma_context *gc = ac->gdma_dev->gdma_context;
> +
> +	/* Already in service, hence tx queue reset is not required.*/
> +	if (gc->in_service)
> +		return;
> +
> +	/* Note: If there are pending queue reset work for this port(apc),
> +	 * subsequent request queued up from here are ignored. This is because
> +	 * we are using the same work instance per port(apc).
> +	 */
> +	queue_work(ac->per_port_queue_reset_wq, &apc->queue_reset_work.work);
> +}
> +
>  static int mana_shaper_set(struct net_shaper_binding *binding,
>  			   const struct net_shaper *shaper,
>  			   struct netlink_ext_ack *extack)
> @@ -884,7 +937,9 @@ static const struct net_device_ops mana_devops = {
>  	.ndo_bpf		= mana_bpf,
>  	.ndo_xdp_xmit		= mana_xdp_xmit,
>  	.ndo_change_mtu		= mana_change_mtu,
> -	.net_shaper_ops         = &mana_shaper_ops,
> +	.ndo_tx_timeout		= mana_tx_timeout,
> +	.net_shaper_ops		= &mana_shaper_ops,
> +
>  };
>  
>  static void mana_cleanup_port_context(struct mana_port_context *apc)
> @@ -3244,6 +3299,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  	ndev->min_mtu = ETH_MIN_MTU;
>  	ndev->needed_headroom = MANA_HEADROOM;
>  	ndev->dev_port = port_idx;
> +	ndev->watchdog_timeo = 15 * HZ;
>  	SET_NETDEV_DEV(ndev, gc->dev);
>  
>  	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
> @@ -3283,6 +3339,10 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  
>  	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs, &apc->speed);
>  
> +	/* Initialize the per port queue reset work.*/
> +	INIT_WORK(&apc->queue_reset_work.work,
> +		  mana_per_port_queue_reset_work_handler);
> +

I think it would make more sense to move this to before the call to
register_netdev(), which is a few lines above this hunk.

I suppose that because a watchdog timeout is involved, it won't happen in
practice, but in theory could fire ndo_tx_timeout before INIT_WORK is
called, resulting in access to the work queue before it is initialised.

>  	return 0;
>  
>  free_indir:
> @@ -3488,6 +3548,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
>  	if (ac->num_ports > MAX_PORTS_IN_MANA_DEV)
>  		ac->num_ports = MAX_PORTS_IN_MANA_DEV;
>  
> +	ac->per_port_queue_reset_wq =
> +			alloc_ordered_workqueue("mana_per_port_queue_reset_wq",
> +						WQ_UNBOUND | WQ_MEM_RECLAIM);
> +	if (!ac->per_port_queue_reset_wq) {
> +		dev_err(dev, "Failed to allocate per port queue reset workqueue\n");
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
>  	if (!resuming) {
>  		for (i = 0; i < ac->num_ports; i++) {
>  			err = mana_probe_port(ac, i, &ac->ports[i]);

It is not strictly related to this patch, but the lines above the hunk
below look like this:

		apc = netdev_priv(ndev);
		if (!ndev) {
			if (i == 0)
				dev_err(dev, "No net device to remove\n");

If ndev is null then the call to netdev_priv() will result in a
NULL pointer dereference. So I think it should be moved
to after the check for !ndev.

> @@ -3557,6 +3626,8 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  			goto out;
>  		}
>  
> +		disable_work_sync(&apc->queue_reset_work.work);
> +
>  		/* All cleanup actions should stay after rtnl_lock(), otherwise
>  		 * other functions may access partially cleaned up data.
>  		 */

Comments on code flagged by Claude Code with
https://github.com/masoncl/review-prompts/

