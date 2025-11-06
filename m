Return-Path: <linux-hyperv+bounces-7416-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE81C391AE
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 05:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94F73B61F4
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 04:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96452C11FA;
	Thu,  6 Nov 2025 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IaSWzjtd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD2428695;
	Thu,  6 Nov 2025 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762403831; cv=none; b=K21aoKSwROrOoIaCUWbOj2lzYW1BUnnRrXjYdyg0BMC4jcoQGNE0x497adyQMksf3hugKZYSdAC2KbpNXGkocePXHMvuYkYici1asBOQUzmBUBbZukLSGcIvpNFt1PgH8Amo5STGtM3IxZszP5SlllOA0eDSDhM9N9mcw9w6WGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762403831; c=relaxed/simple;
	bh=r+YxB4Vo0TXJHROyireCe/rGrj78N33CfoSXBHnAdU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMWPnIpwq7QufHkC11scPvJalM3baRtC6aVUJJX3oxSCLglfMRrpxqkaPG9al2ZGx/ajgumGHkzTFpwC/zkXyxu789d2qat9zoBK8LNeIxUlBoLhgzrdZIBQbcwHvwJ+cp77UnHdkeqOOzntDQBcU8408M2Yrl/we/8TxCFFoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IaSWzjtd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 66150211E335; Wed,  5 Nov 2025 20:37:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 66150211E335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762403823;
	bh=WvWOPGCfAQhFnGXyL6CtQeVAoRIJIpIZGv9//L4/okc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaSWzjtdi22KdCMH/lDPY7tZJpqK7w/aLXH6T8ddPOKcTvfaIKwEyKwbWSvk0tlmg
	 4LbrarCkT/jcX/UdEvs5MhxhDIEmKt9qvrGD1iA1n6YKyaDVLPwD4XVlu1/Dc4Eakf
	 kpNLyLzC5oQQKXBcz8GFK+Jans0tLl/TtzNdFtBs=
Date: Wed, 5 Nov 2025 20:37:03 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
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
Message-ID: <20251106043703.GA1096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251027201351.GA8995@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20251029182233.59aea2d3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029182233.59aea2d3@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Oct 29, 2025 at 06:22:33PM -0700, Jakub Kicinski wrote:
> On Mon, 27 Oct 2025 13:13:51 -0700 Dipayaan Roy wrote:
> > Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detected
> > and a device-controlled port reset for all queues can be scheduled to a
> > ordered workqueue. The reset for all queues on stall detection is
> > recomended by hardware team.
> > 
> > The change introduces a single ordered workqueue
> > ("mana_per_port_queue_reset_wq") with WQ_UNBOUND | WQ_MEM_RECLAIM and
> > queues exactly one work_struct per port onto it. This achieves:
> > 
> >   * Global FIFO across all port reset requests (alloc_ordered_workqueue).
> 
> Why does this matter?
> 
As per HW team,it should be processing only one port reset at any point
of time, so we need the serialization.

> >   * Natural per-port de-duplication: the same work_struct cannot be
> >     queued twice while pending/running.
> 
> That's true for all work_structs even without a separate wq.
>
Right, (verbose, will remove). 
> >   * Avoids hogging a per-CPU kworker for long, may-sleep reset paths
> >     (WQ_UNBOUND).
> 
> ?
> 
> >   * Guarantees forward progress during memory pressure
> >     (WQ_MEM_RECLAIM rescuer).
> 
> ? meaning? What scenario are you preventing?
> 
I was trying to explain the usage/benefit of these flags, but seems verbose here.
I will rephrase the better in v3.

> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> > ---
> > Changes in v2:
> >   - Fixed cosmetic changes.
> > ---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 82 +++++++++++++++++++
> >  include/net/mana/gdma.h                       |  6 +-
> >  include/net/mana/mana.h                       | 15 ++++
> >  3 files changed, 102 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index f4fc86f20213..05b7046ae3b5 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -258,6 +258,45 @@ static int mana_get_gso_hs(struct sk_buff *skb)
> >  	return gso_hs;
> >  }
> >  
> > +static void mana_per_port_queue_reset_work_handler(struct work_struct *work)
> > +{
> > +	struct mana_queue_reset_work *reset_queue_work =
> > +			container_of(work, struct mana_queue_reset_work, work);
> > +	struct mana_port_context *apc = reset_queue_work->apc;
> > +	struct net_device *ndev = apc->ndev;
> > +	struct mana_context *ac = apc->ac;
> > +	int err;
> > +
> > +	if (!rtnl_trylock()) {
> 
> Use disable_work_sync() in the remove path and you won't have to do 
> the retry dance, right?
> 
Looks like we might end up the same issue with both cancel_work_sync and
disable_work_sync(), unless the call to them is made out of rtnl_lock/unlock
in mana_remove? If thats the right approach we can drop rtnl_trylock here and
have only rtnl_lock().

> > +		/* Someone else holds RTNL, requeue and exit. */
> > +		queue_work(ac->per_port_queue_reset_wq,
> > +			   &apc->queue_reset_work.work);
> > +		return;
> > +	}
> 
> > +static void mana_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> > +{
> > +	struct mana_port_context *apc = netdev_priv(netdev);
> > +	struct mana_context *ac = apc->ac;
> > +	struct gdma_context *gc = ac->gdma_dev->gdma_context;
> > +
> > +	netdev_warn(netdev, "%s(): called on txq: %u\n", __func__, txqueue);
> 
> I believe that core already prints this sort of thing, please don't
> duplicate.
> 
Ok, will address it in v3.

> > +	/* Already in service, hence tx queue reset is not required.*/
> > +	if (gc->in_service)
> > +		return;
> > +
> > +	/* Note: If there are pending queue reset work for this port(apc),
> > +	 * subsequent request queued up from here are ignored. This is because
> > +	 * we are using the same work instance per port(apc).
> > +	 */
> > +	queue_work(ac->per_port_queue_reset_wq, &apc->queue_reset_work.work);
> > +}
> > +
> >  static int mana_shaper_set(struct net_shaper_binding *binding,
> >  			   const struct net_shaper *shaper,
> >  			   struct netlink_ext_ack *extack)
> > @@ -844,7 +902,9 @@ static const struct net_device_ops mana_devops = {
> >  	.ndo_bpf		= mana_bpf,
> >  	.ndo_xdp_xmit		= mana_xdp_xmit,
> >  	.ndo_change_mtu		= mana_change_mtu,
> > +	.ndo_tx_timeout     = mana_tx_timeout,
> 
> other ndos were aligned with tabs you're using spaces
>
Ok, will address it in v3.

> >  	.net_shaper_ops         = &mana_shaper_ops,
> > +
> >  };
> >  
> >  static void mana_cleanup_port_context(struct mana_port_context *apc)
> > @@ -3218,6 +3278,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
> >  	ndev->min_mtu = ETH_MIN_MTU;
> >  	ndev->needed_headroom = MANA_HEADROOM;
> >  	ndev->dev_port = port_idx;
> > +	ndev->watchdog_timeo = MANA_TXQ_TIMEOUT;
> 
> why you need a define for this is unclear. You can use 15 * HZ here
> directly 
>
Ok, will address it in v3.

> >  	SET_NETDEV_DEV(ndev, gc->dev);
> >  
> >  	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
> > @@ -3255,6 +3316,11 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
> >  
> >  	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs, &apc->speed);
> >  
> > +	/* Initialize the per port queue reset work.*/
> > +	apc->queue_reset_work.apc = apc;
> > +	INIT_WORK(&apc->queue_reset_work.work,
> > +		  mana_per_port_queue_reset_work_handler);
> > +
> >  	return 0;
> >  
> >  free_indir:
> > @@ -3456,6 +3522,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
> >  	if (ac->num_ports > MAX_PORTS_IN_MANA_DEV)
> >  		ac->num_ports = MAX_PORTS_IN_MANA_DEV;
> >  
> > +	ac->per_port_queue_reset_wq =
> > +			alloc_ordered_workqueue("mana_per_port_queue_reset_wq",
> > +						WQ_UNBOUND | WQ_MEM_RECLAIM);
> > +	if (!ac->per_port_queue_reset_wq) {
> > +		dev_err(dev, "Failed to allocate per port queue reset workqueue\n");
> > +		err = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> >  	if (!resuming) {
> >  		for (i = 0; i < ac->num_ports; i++) {
> >  			err = mana_probe_port(ac, i, &ac->ports[i]);
> > @@ -3528,6 +3603,8 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
> >  		 */
> >  		rtnl_lock();
> >  
> > +		cancel_work_sync(&apc->queue_reset_work.work);
> > +
> >  		err = mana_detach(ndev, false);
> >  		if (err)
> >  			netdev_err(ndev, "Failed to detach vPort %d: %d\n",
> > @@ -3547,6 +3624,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
> >  		free_netdev(ndev);
> >  	}
> >  
> > +	if (ac->per_port_queue_reset_wq) {
> > +		destroy_workqueue(ac->per_port_queue_reset_wq);
> > +		ac->per_port_queue_reset_wq = NULL;
> > +	}
> > +
> >  	mana_destroy_eq(ac);
> >  out:
> >  	mana_gd_deregister_device(gd);
> > diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> > index 57df78cfbf82..1f8c536ba3be 100644
> > --- a/include/net/mana/gdma.h
> > +++ b/include/net/mana/gdma.h
> > @@ -591,6 +591,9 @@ enum {
> >  /* Driver can self reset on FPGA Reconfig EQE notification */
> >  #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
> >  
> > +/* Driver detects stalled send queues and recovers them */
> > +#define GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY BIT(18)
> > +
> >  #define GDMA_DRV_CAP_FLAGS1 \
> >  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
> >  	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
> > @@ -599,7 +602,8 @@ enum {
> >  	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
> >  	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
> >  	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
> > -	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
> > +	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
> > +	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY)
> >  
> >  #define GDMA_DRV_CAP_FLAGS2 0
> >  
> > diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> > index 0921485565c0..e0b44ae2226a 100644
> > --- a/include/net/mana/mana.h
> > +++ b/include/net/mana/mana.h
> > @@ -67,6 +67,11 @@ enum TRI_STATE {
> >  
> >  #define MANA_RX_FRAG_ALIGNMENT 64
> >  
> > +/* Timeout value for Txq stall detection & recovery used by ndo_tx_timeout.
> > + * The value is chosen after considering fpga re-config scenarios.
> > + */
> > +#define MANA_TXQ_TIMEOUT (15 * HZ)
> > +
> >  struct mana_stats_rx {
> >  	u64 packets;
> >  	u64 bytes;
> > @@ -475,13 +480,23 @@ struct mana_context {
> >  
> >  	struct mana_eq *eqs;
> >  	struct dentry *mana_eqs_debugfs;
> > +	struct workqueue_struct *per_port_queue_reset_wq;
> >  
> >  	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
> >  };
> >  
> > +struct mana_queue_reset_work {
> > +
> 
> nit spurious empty line
>
Ok, will address it in v3. 
> > +	/* Work structure */
> > +	struct work_struct work;
> > +	/* Pointer to the port context */
> > +	struct mana_port_context *apc;
> 
> This struct is placed in apc, unclear why you need a backpointer
> instead of using container_of()
>
Right, I will address this in v3. 
> > +};
> > +
> >  struct mana_port_context {
> >  	struct mana_context *ac;
> >  	struct net_device *ndev;
> > +	struct mana_queue_reset_work queue_reset_work;
> >  
> >  	u8 mac_addr[ETH_ALEN];
> >  
> 
> -- 
> pw-bot: cr


Thank you for the review comments.
I will work on addressing them in the v3.

Regards
Dipayaan Roy

