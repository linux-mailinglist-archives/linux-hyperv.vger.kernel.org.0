Return-Path: <linux-hyperv+bounces-11544-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cw6AIY2XJ2oHzQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11544-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 06:33:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF46965C374
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 06:33:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=eS9pLD2O;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11544-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11544-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6EC33050441
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 04:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743363655DB;
	Tue,  9 Jun 2026 04:33:14 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E71A9F90;
	Tue,  9 Jun 2026 04:33:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780979594; cv=none; b=JsCoO0D1hGq1bSVVZ4aVlSJ5P4S4+qt7axXEfhc6LxB52Q77C6Ca+6aOPplEOa+giFwV/mAcpxlrzSRvgsEjUNSAHXzrZgceECbbff7p6Yarhm18nKGjoUoWMruFoK/Smf8iekUudXq5Esj2X/gLH0EJhSOXUgAScK6+a5WYJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780979594; c=relaxed/simple;
	bh=8n2rUa58ndHtThTWZ59/AdSok7/ztYMrngn8BMaCEY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/stz3/wpjGG1PoxIQkVTpIYHsFFn1VI65Wzn00AagUKgq/ZtTJ/o2rVuoLu7N6dDm9eAtZpH3/eCXO6XEn+3twzLE6pKYjPHEvniXjA+rP70lK4U9oy9vkF9k09HheWpL7XOF63WUYo+sQW8O+n7VETJePbwCSOW9zyyh2GYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eS9pLD2O; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 7AC8120B7167; Mon,  8 Jun 2026 21:32:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AC8120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780979569;
	bh=EbqJ/IkzsqoSz7UPJbS0opNH84rgjXe7KslEbNh6Usk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eS9pLD2OlBsevnqnj6DzY/nw3dRmV+Y/GyvmYNdJo6w7yHs+4bf2I5aFLEf5xt8gC
	 ya8ua+iMUKffMq5zX0ZsoQnMSbhK2v8CS4hUSi0DGDcLy0yt+g6vMFNf4PTgDt3BNL
	 4c6nZ+3kLAk2USHYeRPVHTySfTsqMEA+ovIxhjMw=
Date: Mon, 8 Jun 2026 21:32:49 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
	yury.norov@gmail.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next v10 2/2] net: mana: force full-page RX buffers
 via ethtool private flag
Message-ID: <aieXcRe47AKklXKr@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260602202801.1873742-1-dipayanroy@linux.microsoft.com>
 <20260602202801.1873742-3-dipayanroy@linux.microsoft.com>
 <c3b2ab74-754d-4d09-b7a2-d274343d0936@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b2ab74-754d-4d09-b7a2-d274343d0936@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:ernis@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stephen@networkplumber.org,m:dipayanroy@microsoft.com,m:leitao@debian.org,m:kees@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:sdf@fomichev.me,m:yury.norov@gmail.com,m:pavan.chebbi@broadcom.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11544-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,linux.microsoft.com:dkim,linux.microsoft.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF46965C374

On Thu, Jun 04, 2026 at 11:40:30AM -0700, Jacob Keller wrote:
> On 6/2/2026 1:24 PM, Dipayaan Roy wrote:
> > On some ARM64 platforms with 4K PAGE_SIZE, page_pool fragment
> > allocation in the RX refill path can cause 15-20% throughput
> > regression under high connection counts (>16 TCP streams).
> > 
> > Add an ethtool private flag "full-page-rx" that allows the user to
> > force one RX buffer per page, bypassing the page_pool fragment path.
> > This restores line-rate (180+ Gbps) performance on affected platforms.
> > 
> > Usage:
> >   ethtool --set-priv-flags eth0 full-page-rx on
> > 
> > There is no behavioral change by default. The flag must be explicitly
> > enabled by the user or udev rule.
> > 
> > The existing single-buffer-per-page logic for XDP and jumbo frames is
> > consolidated into a new helper mana_use_single_rxbuf_per_page() which
> > is now the single decision point for both the automatic and
> > user-controlled paths.
> > 
> > Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> > ---
> 
> I had one or two minor nits, but nothing that I think really deserves a
> v11. The only real comment is a future "gotcha" that could happen if you
> ever added a second private flag, which seems unlikely and maybe not
> worth dealing with until it matters.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>

Hi Jacob,

Thank you for the review.
I will keep this patch as is, since no plans for any new private flags.

Regards
Dipayaan Roy

> >  drivers/net/ethernet/microsoft/mana/mana_en.c |  22 +++-
> >  .../ethernet/microsoft/mana/mana_ethtool.c    | 103 ++++++++++++++++++
> >  include/net/mana/mana.h                       |   8 ++
> >  3 files changed, 131 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index db14357d3732..447cecfd3f67 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -744,6 +744,25 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
> >  	return va;
> >  }
> >  
> > +static bool
> > +mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
> > +{
> > +	/* On some platforms with 4K PAGE_SIZE, page_pool fragment allocation
> > +	 * in the RX refill path (~2kB buffer) can cause significant throughput
> > +	 * regression under high connection counts. Allow user to force one RX
> > +	 * buffer per page via ethtool private flag to bypass the fragment
> > +	 * path.
> > +	 */
> > +	if (apc->priv_flags & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF))
> > +		return true;
> > +
> > +	/* For xdp and jumbo frames make sure only one packet fits per page. */
> > +	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc))
> > +		return true;
> 
> Technically you could combine all three into one if, but I agree that
> clarity and space for the comment about why the private flag exists
> makes sense.
> 
> > +
> > +	return false;
> > +}
> > +
> >  /* Get RX buffer's data size, alloc size, XDP headroom based on MTU */
> >  static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
> >  			       int mtu, u32 *datasize, u32 *alloc_size,
> > @@ -754,8 +773,7 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
> >  	/* Calculate datasize first (consistent across all cases) */
> >  	*datasize = mtu + ETH_HLEN;
> >  
> > -	/* For xdp and jumbo frames make sure only one packet fits per page */
> > -	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
> > +	if (mana_use_single_rxbuf_per_page(apc, mtu)) {
> >  		if (mana_xdp_get(apc)) {
> >  			*headroom = XDP_PACKET_HEADROOM;
> >  			*alloc_size = PAGE_SIZE;
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > index 7e79681634db..f22bbb325948 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > @@ -133,6 +133,10 @@ static const struct mana_stats_desc mana_phy_stats[] = {
> >  	{ "hc_tc7_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc7_phy) },
> >  };
> >  
> > +static const char mana_priv_flags[MANA_PRIV_FLAG_MAX][ETH_GSTRING_LEN] = {
> > +	[MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF] = "full-page-rx"
> > +};
> > +
> >  static int mana_get_sset_count(struct net_device *ndev, int stringset)
> >  {
> >  	struct mana_port_context *apc = netdev_priv(ndev);
> > @@ -144,6 +148,10 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
> >  		       ARRAY_SIZE(mana_phy_stats) +
> >  		       ARRAY_SIZE(mana_hc_stats)  +
> >  		       num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
> > +
> > +	case ETH_SS_PRIV_FLAGS:
> > +		return MANA_PRIV_FLAG_MAX;
> > +
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -192,6 +200,14 @@ static void mana_get_strings_stats(struct mana_port_context *apc, u8 **data)
> >  	}
> >  }
> >  
> > +static void mana_get_strings_priv_flags(u8 **data)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < MANA_PRIV_FLAG_MAX; i++)
> > +		ethtool_puts(data, mana_priv_flags[i]);
> > +}
> > +
> >  static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
> >  {
> >  	struct mana_port_context *apc = netdev_priv(ndev);
> > @@ -200,6 +216,9 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
> >  	case ETH_SS_STATS:
> >  		mana_get_strings_stats(apc, &data);
> >  		break;
> > +	case ETH_SS_PRIV_FLAGS:
> > +		mana_get_strings_priv_flags(&data);
> > +		break;
> >  	default:
> >  		break;
> >  	}
> > @@ -590,6 +609,88 @@ static int mana_get_link_ksettings(struct net_device *ndev,
> >  	return 0;
> >  }
> >  
> > +static u32 mana_get_priv_flags(struct net_device *ndev)
> > +{
> > +	struct mana_port_context *apc = netdev_priv(ndev);
> > +
> > +	return apc->priv_flags;
> > +}
> > +
> > +static int mana_set_priv_flags(struct net_device *ndev, u32 priv_flags)
> > +{
> > +	struct mana_port_context *apc = netdev_priv(ndev);
> > +	u32 changed = apc->priv_flags ^ priv_flags;
> > +	u32 old_priv_flags = apc->priv_flags;
> > +	bool schedule_port_reset = false;
> > +	int err = 0;
> > +
> > +	if (!changed)
> > +		return 0;
> > +
> > +	/* Reject unknown bits */
> > +	if (priv_flags & ~GENMASK(MANA_PRIV_FLAG_MAX - 1, 0))
> > +		return -EINVAL;
> 
> Good. Explicit rejection ensures that there's no risk of bad value. I
> think this is only required for the legacy ioctl interface, and won't be
> able to have a bit set that isn't in your accepted list. However the
> legacy ioctl interface looks like it doesn't do that double checking, so
> its good to have this.
> 
> > +
> > +	if (changed & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF)) {
> > +		apc->priv_flags = priv_flags;
> > +
> 
> In the (unlikely) event that you need another private flag in the
> future, this bit seems like it shouldn't be inside the if block here. It
> seems like you'd want to either do this at the end or up front. Of
> course it doesn't matter as long as this is the only private flag you have.
> 
> > +		if (!apc->port_is_up) {
> > +			/* Port is down, flag updated to apply on next up
> > +			 * so just return.
> > +			 */
> > +			return 0;
> > +		}
> > +
> > +		/* Pre-allocate buffers to prevent failure in mana_attach
> > +		 * later
> > +		 */
> > +		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
> > +		if (err) {
> > +			netdev_err(ndev,
> > +				   "Insufficient memory for new allocations\n");
> > +			apc->priv_flags = old_priv_flags;
> > +			return err;
> > +		}
> > +
> > +		err = mana_detach(ndev, false);
> > +		if (err) {
> > +			netdev_err(ndev, "mana_detach failed: %d\n", err);
> > +			apc->priv_flags = old_priv_flags;
> > +
> > +			/* Port is in an inconsistent state. Restore
> > +			 * 'port_is_up' so that queue reset work handler
> > +			 * can properly detach and re-attach.
> > +			 */
> > +			apc->port_is_up = true;
> > +			schedule_port_reset = true;
> > +			goto out;
> > +		}
> > +
> > +		err = mana_attach(ndev);
> > +		if (err) {
> > +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> > +			apc->priv_flags = old_priv_flags;
> > +
> > +			/* Restore 'port_is_up' so the reset work handler
> > +			 * can properly detach/attach. Without this,
> > +			 * the handler sees port_is_up=false and skips
> > +			 * queue allocation, leaving the port dead.
> > +			 */
> > +			apc->port_is_up = true;
> > +			schedule_port_reset = true;
> > +		}
> 
> I might have made this bit a separate function, but that comes from
> history of working with older drivers which accumulated a larger number
> of private flags. Given that we frown on adding new ones except in more
> rare cases these days, this is probably fine.
> 
> > +	}
> > +
> > +out:
> > +	mana_pre_dealloc_rxbufs(apc);
> > +
> > +	if (schedule_port_reset)
> > +		queue_work(apc->ac->per_port_queue_reset_wq,
> > +			   &apc->queue_reset_work);
> > +
> > +	return err;
> > +}
> > +
> >  const struct ethtool_ops mana_ethtool_ops = {
> >  	.supported_coalesce_params = ETHTOOL_COALESCE_RX_CQE_FRAMES,
> >  	.get_ethtool_stats	= mana_get_ethtool_stats,
> > @@ -608,4 +709,6 @@ const struct ethtool_ops mana_ethtool_ops = {
> >  	.set_ringparam          = mana_set_ringparam,
> >  	.get_link_ksettings	= mana_get_link_ksettings,
> >  	.get_link		= ethtool_op_get_link,
> > +	.get_priv_flags		= mana_get_priv_flags,
> > +	.set_priv_flags		= mana_set_priv_flags,
> >  };
> > diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> > index d9c27310fd04..26fd5e041a47 100644
> > --- a/include/net/mana/mana.h
> > +++ b/include/net/mana/mana.h
> > @@ -30,6 +30,12 @@ enum TRI_STATE {
> >  	TRI_STATE_TRUE = 1
> >  };
> >  
> > +/* MANA ethtool private flag bit positions */
> > +enum mana_priv_flag_bits {
> > +	MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF = 0,
> > +	MANA_PRIV_FLAG_MAX,
> 
> For cases like this, I find it helpful to add a comment indicating this
> must be the last entry. (and in that case, drop the trailing comma).
> 
> > +};
> > +
> >  /* Number of entries for hardware indirection table must be in power of 2 */
> >  #define MANA_INDIRECT_TABLE_MAX_SIZE 512
> >  #define MANA_INDIRECT_TABLE_DEF_SIZE 64
> > @@ -531,6 +537,8 @@ struct mana_port_context {
> >  	u32 rxbpre_headroom;
> >  	u32 rxbpre_frag_count;
> >  
> > +	u32 priv_flags;
> > +
> >  	struct bpf_prog *bpf_prog;
> >  
> >  	/* Create num_queues EQs, SQs, SQ-CQs, RQs and RQ-CQs, respectively. */
> 

