Return-Path: <linux-hyperv+bounces-7378-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFC5C1E035
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Oct 2025 02:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77E3B4E0132
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Oct 2025 01:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7902652AC;
	Thu, 30 Oct 2025 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npm9wP8c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1BD21ABA2;
	Thu, 30 Oct 2025 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761787355; cv=none; b=q27dtO3ucNfNUsiJMnmTWUo0btdc8b81IKVuT+GWM8ZboJqxX7UtCEs1n6aeE66Bh6aIPZ6k+QUcc5kuBvUonNgw5TEzZ/thgp0kHs22TACd5GIAu6/ENQO+OJcPwqF63YF/fOaxAqfqykZI0ZcUYg734YQZQ/HJ8/BelXP1HRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761787355; c=relaxed/simple;
	bh=hwWIVNDINLrcMPah8wKmlGu4j7PKpcL9aDTmoLMMtJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gwi6zV+/jHTjneuMtRBOXMRRBIYRUjyqVhssKXoQk7e/L0qnxkOSbublabr1j4vRu4AWSmt305H75zp/8XKRAcW0iDaWL/zbSRkiwM5JbPvNrfeeRaupdpftAZmm4dr56wTVIzsXyzEVBKEWCd5uTCaBZ85/6QL3rub6RrbOBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npm9wP8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCFAC4CEF7;
	Thu, 30 Oct 2025 01:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761787354;
	bh=hwWIVNDINLrcMPah8wKmlGu4j7PKpcL9aDTmoLMMtJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=npm9wP8cAH1K08YjvHKsZ2S9uQZ3dxVGWtz8IZXIAx7HYRva5G6V01fKojMSynSHv
	 g09Bp7/Z07wlXBqzmug+N1XDMiC7KbhO9N6LIpV3b6xz+zbtbanDKJYShTb7qNiWgy
	 s11xukMZtRZmWA2SH/0MTREBNnZwZEFGGQ8b4V71wtlyb06052+GDf5V8McbfKzyVy
	 GAFtaKKG7Yikpv2JuqRWcU5GcNZvEYhGC6QO5w21Bi/WQdYww5yxX1W85gM+p7Q0lU
	 LE2o93brWDfT80Z6ZHU+/AnDfCjYeJlEyWkuWhVxddRwh/j35eU1tY8kAK4OOlnV1n
	 ASLE9hZiHJM7Q==
Date: Wed, 29 Oct 2025 18:22:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 dipayanroy@microsoft.com
Subject: Re: [PATCH net-next v2] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <20251029182233.59aea2d3@kernel.org>
In-Reply-To: <20251027201351.GA8995@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251027201351.GA8995@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 13:13:51 -0700 Dipayaan Roy wrote:
> Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detected
> and a device-controlled port reset for all queues can be scheduled to a
> ordered workqueue. The reset for all queues on stall detection is
> recomended by hardware team.
> 
> The change introduces a single ordered workqueue
> ("mana_per_port_queue_reset_wq") with WQ_UNBOUND | WQ_MEM_RECLAIM and
> queues exactly one work_struct per port onto it. This achieves:
> 
>   * Global FIFO across all port reset requests (alloc_ordered_workqueue).

Why does this matter?

>   * Natural per-port de-duplication: the same work_struct cannot be
>     queued twice while pending/running.

That's true for all work_structs even without a separate wq.

>   * Avoids hogging a per-CPU kworker for long, may-sleep reset paths
>     (WQ_UNBOUND).

?

>   * Guarantees forward progress during memory pressure
>     (WQ_MEM_RECLAIM rescuer).

? meaning? What scenario are you preventing?

> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
> Changes in v2:
>   - Fixed cosmetic changes.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 82 +++++++++++++++++++
>  include/net/mana/gdma.h                       |  6 +-
>  include/net/mana/mana.h                       | 15 ++++
>  3 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index f4fc86f20213..05b7046ae3b5 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -258,6 +258,45 @@ static int mana_get_gso_hs(struct sk_buff *skb)
>  	return gso_hs;
>  }
>  
> +static void mana_per_port_queue_reset_work_handler(struct work_struct *work)
> +{
> +	struct mana_queue_reset_work *reset_queue_work =
> +			container_of(work, struct mana_queue_reset_work, work);
> +	struct mana_port_context *apc = reset_queue_work->apc;
> +	struct net_device *ndev = apc->ndev;
> +	struct mana_context *ac = apc->ac;
> +	int err;
> +
> +	if (!rtnl_trylock()) {

Use disable_work_sync() in the remove path and you won't have to do 
the retry dance, right?

> +		/* Someone else holds RTNL, requeue and exit. */
> +		queue_work(ac->per_port_queue_reset_wq,
> +			   &apc->queue_reset_work.work);
> +		return;
> +	}

> +static void mana_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> +{
> +	struct mana_port_context *apc = netdev_priv(netdev);
> +	struct mana_context *ac = apc->ac;
> +	struct gdma_context *gc = ac->gdma_dev->gdma_context;
> +
> +	netdev_warn(netdev, "%s(): called on txq: %u\n", __func__, txqueue);

I believe that core already prints this sort of thing, please don't
duplicate.

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
> @@ -844,7 +902,9 @@ static const struct net_device_ops mana_devops = {
>  	.ndo_bpf		= mana_bpf,
>  	.ndo_xdp_xmit		= mana_xdp_xmit,
>  	.ndo_change_mtu		= mana_change_mtu,
> +	.ndo_tx_timeout     = mana_tx_timeout,

other ndos were aligned with tabs you're using spaces

>  	.net_shaper_ops         = &mana_shaper_ops,
> +
>  };
>  
>  static void mana_cleanup_port_context(struct mana_port_context *apc)
> @@ -3218,6 +3278,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  	ndev->min_mtu = ETH_MIN_MTU;
>  	ndev->needed_headroom = MANA_HEADROOM;
>  	ndev->dev_port = port_idx;
> +	ndev->watchdog_timeo = MANA_TXQ_TIMEOUT;

why you need a define for this is unclear. You can use 15 * HZ here
directly 

>  	SET_NETDEV_DEV(ndev, gc->dev);
>  
>  	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
> @@ -3255,6 +3316,11 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  
>  	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs, &apc->speed);
>  
> +	/* Initialize the per port queue reset work.*/
> +	apc->queue_reset_work.apc = apc;
> +	INIT_WORK(&apc->queue_reset_work.work,
> +		  mana_per_port_queue_reset_work_handler);
> +
>  	return 0;
>  
>  free_indir:
> @@ -3456,6 +3522,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
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
> @@ -3528,6 +3603,8 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  		 */
>  		rtnl_lock();
>  
> +		cancel_work_sync(&apc->queue_reset_work.work);
> +
>  		err = mana_detach(ndev, false);
>  		if (err)
>  			netdev_err(ndev, "Failed to detach vPort %d: %d\n",
> @@ -3547,6 +3624,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  		free_netdev(ndev);
>  	}
>  
> +	if (ac->per_port_queue_reset_wq) {
> +		destroy_workqueue(ac->per_port_queue_reset_wq);
> +		ac->per_port_queue_reset_wq = NULL;
> +	}
> +
>  	mana_destroy_eq(ac);
>  out:
>  	mana_gd_deregister_device(gd);
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 57df78cfbf82..1f8c536ba3be 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -591,6 +591,9 @@ enum {
>  /* Driver can self reset on FPGA Reconfig EQE notification */
>  #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
>  
> +/* Driver detects stalled send queues and recovers them */
> +#define GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY BIT(18)
> +
>  #define GDMA_DRV_CAP_FLAGS1 \
>  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
>  	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
> @@ -599,7 +602,8 @@ enum {
>  	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
>  	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
>  	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
> -	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
> +	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
> +	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY)
>  
>  #define GDMA_DRV_CAP_FLAGS2 0
>  
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 0921485565c0..e0b44ae2226a 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -67,6 +67,11 @@ enum TRI_STATE {
>  
>  #define MANA_RX_FRAG_ALIGNMENT 64
>  
> +/* Timeout value for Txq stall detection & recovery used by ndo_tx_timeout.
> + * The value is chosen after considering fpga re-config scenarios.
> + */
> +#define MANA_TXQ_TIMEOUT (15 * HZ)
> +
>  struct mana_stats_rx {
>  	u64 packets;
>  	u64 bytes;
> @@ -475,13 +480,23 @@ struct mana_context {
>  
>  	struct mana_eq *eqs;
>  	struct dentry *mana_eqs_debugfs;
> +	struct workqueue_struct *per_port_queue_reset_wq;
>  
>  	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
>  };
>  
> +struct mana_queue_reset_work {
> +

nit spurious empty line

> +	/* Work structure */
> +	struct work_struct work;
> +	/* Pointer to the port context */
> +	struct mana_port_context *apc;

This struct is placed in apc, unclear why you need a backpointer
instead of using container_of()

> +};
> +
>  struct mana_port_context {
>  	struct mana_context *ac;
>  	struct net_device *ndev;
> +	struct mana_queue_reset_work queue_reset_work;
>  
>  	u8 mac_addr[ETH_ALEN];
>  

-- 
pw-bot: cr

