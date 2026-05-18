Return-Path: <linux-hyperv+bounces-11013-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIZ7A7WFC2paIwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11013-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 23:33:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4DE573E9C
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 23:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4D1A300BCB3
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 21:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92F398918;
	Mon, 18 May 2026 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AMCmSssC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224B5396D19;
	Mon, 18 May 2026 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140014; cv=none; b=AznZQNiFmk6nCFImM6pyXk3u4Lx9XF+UHzb/ExA/7llUXq9IdY+3kCf839k99+iA73T/xv8cYLkgXNbhHr2GQEoSgM5z30uTMz/D2PIZuOXJUzimO5HLxGn8RCTmrBrR8rjVi4Inucj1wDQWIamK0NZX3Sw27u8DAsglGo0tC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140014; c=relaxed/simple;
	bh=jm+8XSYDMvSi0eSTW0hiNffY0O5/GrMLm2X7qEh1GeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UB4vPAipjPLL8W+QRS8qxCZclJ2716/xkEiVLpvBdQU5fM2mMt+Zgs/cvfsclxazuHWsioNaEunQRoTyALQnwI5vjMUm4ATINlOoso+50c7zYeiPTHyFAnW69fFUHzSxVVOAJjLM6+jl39GYVGHSni4+9+uMV7a5uBL1qRHI3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AMCmSssC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 2796120B7166; Mon, 18 May 2026 14:33:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2796120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779140006;
	bh=OzpN7yYP9aHL5n1nKfsdJpLTuSYn6hCedu5lqH42zIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMCmSssCko7dJ3wVbDRNEAWDRlKL/LtcghLRS6ceCmjRe0bHfR+KshONAlQReiXl3
	 Y7KB9U/oPWzZkmYB8UL7Utt2vLSgAshYCaFf/FBk/vIxP2bUnW+UhwjCDupfHJZxAx
	 r+eeEiPqyjnVf7fiMLbKq3/fpgX/EXvFNZ5inb4Q=
Date: Mon, 18 May 2026 14:33:26 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stephen@networkplumber.org, jacob.e.keller@intel.com,
	dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
	yury.norov@gmail.com
Subject: Re: [PATCH v8 2/2] net: mana: force full-page RX buffers via ethtool
 private flag
Message-ID: <aguFpq8+LV+I9oH0@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260508115100.488506-3-dipayanroy@linux.microsoft.com>
 <20260512022133.856196-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512022133.856196-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11013-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 0B4DE573E9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 11, 2026 at 07:21:33PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: mana: force full-page RX buffers via ethtool private flag
> 
> This patch adds an ethtool private flag "full-page-rx" that forces one
> RX buffer per page, bypassing the page_pool fragment path, to address
> a 15-20% throughput regression seen on some 4K PAGE_SIZE ARM64
> platforms under high connection counts.  Toggling the flag triggers
> mana_detach() + mana_attach() to apply the new RX buffer layout.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > index a28ca461c135..dfd222de11d0 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> 
> [ ... ]
> 
> > @@ -590,6 +609,88 @@ static int mana_get_link_ksettings(struct net_device *ndev,
> >  	return 0;
> >  }
> >  
> 
> [ ... ]
> 
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
> > +
> > +	if (changed & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF)) {
> > +		apc->priv_flags = priv_flags;
> > +
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
> 
> [High]
> Can this failure path oops inside the reset work handler?
> 
> When mana_attach() fails after mana_detach() has already torn the vport
> down, apc->tx_qp has been set to NULL by mana_destroy_txq() and apc->rxqs
> has been cleared by mana_cleanup_port_context().  This code then forces
> apc->port_is_up back to true and queues apc->queue_reset_work:
> 
>     apc->port_is_up = true;
>     schedule_port_reset = true;
> 
> When mana_per_port_queue_reset_work_handler runs it calls
> mana_detach(ndev, false), which latches port_st_save = port_is_up = true
> and, because port_st_save is true, invokes mana_dealloc_queues().  The TX
> drain loop there does:
> 
>     txq = &apc->tx_qp[i].txq;
>     atomic_read(&txq->pending_sends);
> 
> with no NULL check on apc->tx_qp, and mana_destroy_vport further down
> iterates apc->rxqs[rxq_idx] while rxqs is NULL.  Would that produce a
> NULL pointer dereference in the workqueue worker whenever mana_attach()
> fails here (for example on an allocation failure in
> mana_init_port_context or mana_create_txq, or a transient HW command
> failure in mana_query_vport_cfg / mana_cfg_vport)?
> 
> The mana_detach() failure path above (goto out) reaches
> mana_dealloc_queues() through the same chain and looks to have the same
> exposure.
Hi Jakub,

Thanks for your comments, I have sent a separate fixes series to the
net tree that fixes the possible NULL pointer derefernce issue and also
makes the reset handler safe for the case where it runs after a failed
attach:
https://lore.kernel.org/all/20260518194654.735580-1-dipayanroy@linux.microsoft.com/


> 
> For comparison, mana_change_mtu() handles a mana_attach() failure by
> returning the error without scheduling a reset.  Would a similar
> treatment here avoid the asynchronous oops, or is there a reason the
> reset must be scheduled in this specific failure case?
> -- 
> pw-bot: cr

The full-page-rx private flag is intended to be driven by a udev rule
that fires automatically during VM provisioning on affected platforms.
If there is a transient failure, the VM fails to provision, requiring manual
intervention.The reset handler retries the attach, giving the port a
chance to recover to default config autonomously without intervention.

Regards
Dipayaan Roy

