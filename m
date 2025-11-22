Return-Path: <linux-hyperv+bounces-7778-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA71EC7C907
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Nov 2025 08:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778313A7C0D
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Nov 2025 07:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563712D9792;
	Sat, 22 Nov 2025 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nBaWpsjq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF2D1F37A1;
	Sat, 22 Nov 2025 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763795029; cv=none; b=loJz1umLr8pNsYxzxB6fIpu0MjEVqAv62nbhlbhwfDKUJpZtG5pt3J4QNZPUp3Pw9EAQPqQuE+QacDTsCOHe2zsWCuK8H47q0wZCKlWtHlNJotYdNDl96JDcMfH/dorRFE1cKyV41TIoH7ZOI+lHJC7JiyGl2Xn9fx9pCG8aS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763795029; c=relaxed/simple;
	bh=4DNT74O83rpfg9lpILaihFi/E0iM7wiCeukShvcIIg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEfTX1sio0N3WKFBP6zJFxWSPM6lERM0sr1bhvArJ3rpye9QutjTrQvSVaRRXANLSCcZRW8Avk/Hs9p6a2ov9RlLJ1h2EliC+B73h+GZySnKmBe17Ck964VTeUjqgZLOIexv6/ULDTPOyu4pY9bClH6YqsUkgqyE43sXduyyNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nBaWpsjq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 16F02212070F; Fri, 21 Nov 2025 23:03:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16F02212070F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763795027;
	bh=r0cvwqhSVkvElalGOoVJsrZPJjG6Fo0xBbUMg8aw8IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBaWpsjqbZXBFaHz0wfI7oUgaRmYz9WRJNG4Dii25WhxE4GjcdXVyOlL3Eym5UZsN
	 IFMwh26FZYO3wFZDna3Jt3lp7Zz6EACdBQvbM3sP9bty4LipJfHqKz2Evx18iebSY2
	 TJb5kDtHaCPXGII7/sLELxmAikgfcFPktWpOlfso=
Date: Fri, 21 Nov 2025 23:03:47 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
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
Message-ID: <20251122070347.GA14726@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251110103541.GA30450@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <aRNsHUjW3PybGXCK@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRNsHUjW3PybGXCK@horms.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Nov 11, 2025 at 05:02:21PM +0000, Simon Horman wrote:
> On Mon, Nov 10, 2025 at 02:35:41AM -0800, Dipayaan Roy wrote:
> > Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detected
> > and a device-controlled port reset for all queues can be scheduled to a
> > ordered workqueue. The reset for all queues on stall detection is
> > recomended by hardware team.
> > 
> > The change introduces a single ordered workqueue
> > ("mana_per_port_queue_reset_wq") with WQ_UNBOUND | WQ_MEM_RECLAIM and
> > queues exactly one work_struct per port onto it.
> 
> I see that this goes some way to addressing Jakub's feedback
> on the commit message in his review of v2. But I this paragraph
> isn't adding much in it's current form. It seems to me some
> explanation of why why WQ_UNBOUND and WQ_MEM_RECLAIM are used is
> appropriate.
> 
> [1] https://lore.kernel.org/all/20251029182233.59aea2d3@kernel.org/
>
Sure, I can add short explanation on the flag usage.
 
> > Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> > ---
> > Changes in v3:
> >   -Fixed commit meesage, removed rtnl_trylock and added
> >    disable_work_sync, fixed mana_queue_reset_work, and few
> >    cosmetics.
> > Changes in v2:
> >   -Fixed cosmetic changes.
> > ---
> > ---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 78 ++++++++++++++++++-
> >  include/net/mana/gdma.h                       |  7 +-
> >  include/net/mana/mana.h                       |  7 ++
> >  3 files changed, 90 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index cccd5b63cee6..636df3b066c5 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -298,6 +298,42 @@ static int mana_get_gso_hs(struct sk_buff *skb)
> >  	return gso_hs;
> >  }
> >  
> > +static void mana_per_port_queue_reset_work_handler(struct work_struct *work)
> > +{
> > +	struct mana_queue_reset_work *reset_queue_work =
> > +			container_of(work, struct mana_queue_reset_work, work);
> > +
> > +	struct mana_port_context *apc = container_of(reset_queue_work,
> > +						     struct mana_port_context,
> > +						     queue_reset_work);
> > +	struct net_device *ndev = apc->ndev;
> > +	int err;
> > +
> > +	rtnl_lock();
> > +
> > +	/* Pre-allocate buffers to prevent failure in mana_attach later */
> > +	err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
> > +	if (err) {
> > +		netdev_err(ndev, "Insufficient memory for reset post tx stall detection\n");
> > +		goto out;
> > +	}
> > +
> > +	err = mana_detach(ndev, false);
> > +	if (err) {
> > +		netdev_err(ndev, "mana_detach failed: %d\n", err);
> > +		goto dealloc_pre_rxbufs;
> > +	}
> > +
> > +	err = mana_attach(ndev);
> > +	if (err)
> > +		netdev_err(ndev, "mana_attach failed: %d\n", err);
> > +
> > +dealloc_pre_rxbufs:
> > +	mana_pre_dealloc_rxbufs(apc);
> > +out:
> > +	rtnl_unlock();
> > +}
> > +
> >  netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> >  {
> >  	enum mana_tx_pkt_format pkt_fmt = MANA_SHORT_PKT_FMT;
> > @@ -802,6 +838,23 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
> >  	return err;
> >  }
> >  
> > +static void mana_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> > +{
> > +	struct mana_port_context *apc = netdev_priv(netdev);
> > +	struct mana_context *ac = apc->ac;
> > +	struct gdma_context *gc = ac->gdma_dev->gdma_context;
> > +
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
> > @@ -884,7 +937,9 @@ static const struct net_device_ops mana_devops = {
> >  	.ndo_bpf		= mana_bpf,
> >  	.ndo_xdp_xmit		= mana_xdp_xmit,
> >  	.ndo_change_mtu		= mana_change_mtu,
> > -	.net_shaper_ops         = &mana_shaper_ops,
> > +	.ndo_tx_timeout		= mana_tx_timeout,
> > +	.net_shaper_ops		= &mana_shaper_ops,
> > +
> >  };
> >  
> >  static void mana_cleanup_port_context(struct mana_port_context *apc)
> > @@ -3244,6 +3299,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
> >  	ndev->min_mtu = ETH_MIN_MTU;
> >  	ndev->needed_headroom = MANA_HEADROOM;
> >  	ndev->dev_port = port_idx;
> > +	ndev->watchdog_timeo = 15 * HZ;
> >  	SET_NETDEV_DEV(ndev, gc->dev);
> >  
> >  	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
> > @@ -3283,6 +3339,10 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
> >  
> >  	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs, &apc->speed);
> >  
> > +	/* Initialize the per port queue reset work.*/
> > +	INIT_WORK(&apc->queue_reset_work.work,
> > +		  mana_per_port_queue_reset_work_handler);
> > +
> 
> I think it would make more sense to move this to before the call to
> register_netdev(), which is a few lines above this hunk.
> 
> I suppose that because a watchdog timeout is involved, it won't happen in
> practice, but in theory could fire ndo_tx_timeout before INIT_WORK is
> called, resulting in access to the work queue before it is initialised.
>
Sure, will address this in next version. 
> >  	return 0;
> >  
> >  free_indir:
> > @@ -3488,6 +3548,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
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
> 
> It is not strictly related to this patch, but the lines above the hunk
> below look like this:
> 
> 		apc = netdev_priv(ndev);
> 		if (!ndev) {
> 			if (i == 0)
> 				dev_err(dev, "No net device to remove\n");
> 
> If ndev is null then the call to netdev_priv() will result in a
> NULL pointer dereference. So I think it should be moved
> to after the check for !ndev.
> 
Thanks for pointing this, I will fix this along with my next version.
> > @@ -3557,6 +3626,8 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
> >  			goto out;
> >  		}
> >  
> > +		disable_work_sync(&apc->queue_reset_work.work);
> > +
> >  		/* All cleanup actions should stay after rtnl_lock(), otherwise
> >  		 * other functions may access partially cleaned up data.
> >  		 */
> 
> Comments on code flagged by Claude Code with
> https://github.com/masoncl/review-prompts/

Thanks Simon for the review. I will send the rebased next version with all the
comments addressed.


Regards


