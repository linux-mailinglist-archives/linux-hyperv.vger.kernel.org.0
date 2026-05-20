Return-Path: <linux-hyperv+bounces-11068-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EJSIJ8GDmqy5gUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11068-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 21:08:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99550597D16
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 21:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29C6F323E5C7
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4C3F9267;
	Wed, 20 May 2026 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="njSup9zs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0F3A6B6D;
	Wed, 20 May 2026 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300701; cv=none; b=csz8FvVdASEmVy93vW6A2Oic/rlwds1k+Gk4bVHey1bRqklACM7K9BwtXYS+QQdgxSYd567PTmqleN0Q8Z5qgR4tYTGdZoAHayD/n+ZsuAOPZdervzKsJgyl5Vqd9UVfpX3xwNh42WQK3wbyjMY1W2ElE0wAuoiEzVARV+CzAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300701; c=relaxed/simple;
	bh=ReI7Pe1k2azsgNrEH63iUCivw8znTCYb+QNRCjEgjIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VllHL7sn2uofsk0A2JsI7ukOU9HXDOxDGQA0qheG2vdsRJciGRtj1Z+aqrjdrwjH6YCu/Zk+RRKdTadBo4UbnroO2KrefqwtNEsIq6Hrn2bOnDcUZPAdqgf/XdA6xq0wKkxvUcC/F18z64FwsTmRFV0VXE/mO8LCjbM+DHUN5Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=njSup9zs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 59A3D20B7168; Wed, 20 May 2026 11:11:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59A3D20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779300693;
	bh=XfQvxMfI6M+Oo70/NIQBu2bKqGiJTjH2WuohEgBfMOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njSup9zsmcuXswBqk9kKeBxXe8+Tef4n3n6ki/hOJVKKtlxuW10NC0MeqJya4TJPr
	 PXP0GCmnluc4tjP9pMAg2v+gdgDWzxivbh/pyd3Zg0hOOet44+nyfT0cmvopslIjPn
	 OZwNqkKxfitaA/lk+vZW3JVozEpeJy/1i1T7zOoY=
Date: Wed, 20 May 2026 11:11:33 -0700
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
Subject: Re: [PATCH net 1/2] net: mana: Add NULL guards in teardown path to
 prevent panic on attach failure
Message-ID: <ag35VVYd0BOSYbrK@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260518194654.735580-2-dipayanroy@linux.microsoft.com>
 <20260519225556.3939204-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519225556.3939204-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11068-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 99550597D16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 03:55:56PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: mana: Add NULL guards in teardown path to prevent panic on attach failure
>     
> When queue allocation fails partway through, the error cleanup frees
> and NULLs apc->tx_qp and apc->rxqs. The patch adds NULL guards for these
> pointers in teardown paths such as mana_destroy_vport(), mana_fence_rqs(),
> and mana_dealloc_queues() to prevent NULL pointer dereferences.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 9afc786b297a8..9e7e4bf526bf6 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> [ ... ]
> > @@ -2858,13 +2861,16 @@ static void mana_destroy_vport(struct mana_port_context *apc)
> >  	struct mana_rxq *rxq;
> >  	u32 rxq_idx;
> >  
> > -	for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
> > -		rxq = apc->rxqs[rxq_idx];
> > -		if (!rxq)
> > -			continue;
> > +	if (apc->rxqs) {
> >  
> > -		mana_destroy_rxq(apc, rxq, true);
> > -		apc->rxqs[rxq_idx] = NULL;
> > +		for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
> > +			rxq = apc->rxqs[rxq_idx];
> > +			if (!rxq)
> > +				continue;
> > +
> > +			mana_destroy_rxq(apc, rxq, true);
> > +			apc->rxqs[rxq_idx] = NULL;
> > +		}
> >  	}
> 
> If the teardown path frees apc->rxqs and sets it to NULL on attach failure,
> how does the interface recover if the user subsequently brings it back up?
> 
> When mana_open() is invoked, it directly calls mana_alloc_queues(). Inside
> mana_alloc_queues() -> mana_add_rx_queues(), the code does:
> 
>     apc->rxqs[i] = rxq;
> 
> If apc->rxqs was left as NULL during the teardown, will this cause a NULL
> pointer dereference on the next interface bring-up?
> 
> [ ... ]
Hi Jakub,

The only path that recovers from this state is mana_attach(), which
calls mana_init_port() -> mana_init_port_context() to re-allocate
apc->rxqs before calling mana_alloc_queues().

When mana_open is invoked prior to it the rxqs would be already setup by
mana_probe_port -> mana_init_port -> mana_init_port_context.

> > @@ -3287,33 +3294,38 @@ static int mana_dealloc_queues(struct net_device *ndev)
> >  	 * number of queues.
> >  	 */
> >  
> > -	for (i = 0; i < apc->num_queues; i++) {
> > -		txq = &apc->tx_qp[i].txq;
> > -		tsleep = 1000;
> > -		while (atomic_read(&txq->pending_sends) > 0 &&
> > -		       time_before(jiffies, timeout)) {
> > -			usleep_range(tsleep, tsleep + 1000);
> > -			tsleep <<= 1;
> > -		}
> > -		if (atomic_read(&txq->pending_sends)) {
> > -			err = pcie_flr(to_pci_dev(gd->gdma_context->dev));
> > -			if (err) {
> > -				netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
> > -					   err, atomic_read(&txq->pending_sends),
> > -					   txq->gdma_txq_id);
> > +	if (apc->tx_qp) {
> 
> In the error path where queue creation fails partway through, will
> mana_destroy_txq() be called?
> 
> If mana_destroy_txq() unconditionally iterates over all apc->num_queues:
> 
>     for (i = 0; i < apc->num_queues; i++) {
>         ...
>         mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
>         ...
> 
> Will it pass 0 or INVALID_MANA_HANDLE to mana_destroy_wq_obj() for queues
> that were never fully initialized?
> 
> Does mana_destroy_wq_obj() send a MANA_DESTROY_WQ_OBJ command to the hardware
> with these uninitialized handles, and could handle 0 corrupt the firmware
> state?
>
This is a known  exisiting issue in the cleaup path for partial tx
setups and was also mentioned in the a recent patch where the rx partial
init clean-up path was fixed. My colleague Aditya is already working on a
patch to fix this and all other issues in the tx cleanup path.
 
> > +		for (i = 0; i < apc->num_queues; i++) {
> > +			txq = &apc->tx_qp[i].txq;
> > +			tsleep = 1000;
> > +			while (atomic_read(&txq->pending_sends) > 0 &&
> > +			       time_before(jiffies, timeout)) {
> > +				usleep_range(tsleep, tsleep + 1000);
> > +				tsleep <<= 1;
> > +			}
> > +			if (atomic_read(&txq->pending_sends)) {
> > +				err =
> > +				    pcie_flr(to_pci_dev(gd->gdma_context->dev));
> 
> If pcie_flr() is triggered here, the PCI Function Level Reset wipes the
> internal GDMA state.
> 
> Further down in this function, mana_disable_vport_rx(), mana_fence_rqs(),
> and mana_destroy_vport() are called. Will these functions attempt to send
> commands to the now-destroyed GDMA admin queue via mana_send_request() and
> wait for completions?
> 
> Could this lead to cascading timeouts since the hardware was just reset and
> cannot process admin commands?
> 
This is pre-existing behavior/issue the pcie_flr() path and the
subsequent calls to mana_disable_vport_rx()/mana_fence_rqs()/mana_destroy_vport()
are unchanged by this patch. My patch only adds a NULL guard for
apc->tx_qp to skip this entire TX drain block when tx_qp is already
freed. But this point seems to be valid issue, I will investigate this
further and I will send a different patch set for this as follow up work.


> > +				if (err) {
> > +					netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
> > +						   err,
> > +					    atomic_read(&txq->pending_sends),
> > +					    txq->gdma_txq_id);
> > +				}
> > +				break;
> >  			}
> > -			break;
> >  		}
> -- 
> pw-bot: cr

Regards
Dipayaan Roy


