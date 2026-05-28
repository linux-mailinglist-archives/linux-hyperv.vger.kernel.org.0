Return-Path: <linux-hyperv+bounces-11314-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDQdOC+yGGr9mAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11314-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 23:22:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0585FA5C6
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 23:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C659D3022651
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9AA3546ED;
	Thu, 28 May 2026 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oxljY1ec"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B781DE4E0;
	Thu, 28 May 2026 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003019; cv=none; b=YJTZU3UTn/czx4Z3zKV/SlOkFVrg9jg8ioOP1odSMT3mpmhRx/ZvVakYT9JBeaLBWzkgVd0wQmu7UHqnPI4scQuY6xkjlLwn9O/ToIXIm5n+dXM7lz72xp0kDFi/RGynTh1Znop91rgKn0Tn+Q5g6nYEFS3f0zOG0yapo5HCKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003019; c=relaxed/simple;
	bh=38pz4NqruQ7wBjK5yjTDkm05+8lX2/2u1B/6m6gJGgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niudkmdGsailxAGATU4h6mnPwmN+IRKF5yktjELfz6UFgiMpRvaHFUSaRWBf/dMQYDocETstpiIyzjhfZW073PtxCIqLgwKbRN4yWHggwL/gYC+kjwJ0chMcMBj5I8Mw+IbxGnnJbN7mR+qGpOhp16+D52BcwPUDhN4eHiR63TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oxljY1ec; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 83E7720B7167; Thu, 28 May 2026 14:16:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83E7720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780003006;
	bh=6aJz6dNdMp8mRGp620K9ImecYGAxbYnYGNREUZ85Vi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxljY1ecC3PgUOdISZHneEszcepJkzRMDyBU3ugDN/m8yMvRUOSRb9VXFfujRu+9c
	 8s8EsKjQyc2YmYOeQuuwIsNaMGMd5u+SwbOkXbz9lqvdqGLBvYwjgMOo0g7tDmUtKS
	 zWhMom1/5vCe/kLKeBgYd9p/FfoTU+ZFEEQhE9xY=
Date: Thu, 28 May 2026 14:16:46 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, leon@kernel.org,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stephen@networkplumber.org, jacob.e.keller@intel.com,
	dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
	yury.norov@gmail.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH net v3 2/2] net: mana: Skip redundant detach on
 already-detached port
Message-ID: <ahiwvsIJv1hdX0kT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260525081129.1230035-1-dipayanroy@linux.microsoft.com>
 <20260525081129.1230035-3-dipayanroy@linux.microsoft.com>
 <3665f7c1-9c97-44ac-8b6a-e6c31ad96730@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3665f7c1-9c97-44ac-8b6a-e6c31ad96730@redhat.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11314-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EC0585FA5C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 11:30:39AM +0200, Paolo Abeni wrote:
> On 5/25/26 10:08 AM, Dipayaan Roy wrote:
> > When mana_per_port_queue_reset_work_handler() runs after a previous
> > detach succeeded but attach failed, the port is left in a detached
> > state with apc->tx_qp and apc->rxqs already freed. Calling
> > mana_detach() again unconditionally leads to NULL pointer dereferences
> > during queue teardown.
> > 
> > Add an early exit in mana_detach() when the port is already in
> > detached state (!netif_device_present) for non-close callers, making
> > it safe to call idempotently. This allows the queue reset handler and
> > other recovery paths to simply retry mana_attach() without redundant
> > teardown.
> > 
> > Fixes: 3b194343c250 ("net: mana: Implement ndo_tx_timeout and serialize queue resets per port.")
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> > ---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 0582803907a8..1e1ad2795c3c 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -3350,6 +3350,12 @@ int mana_detach(struct net_device *ndev, bool from_close)
> >  
> >  	ASSERT_RTNL();
> >  
> > +	/* If already detached (indicates detach succeeded but attach failed
> > +	 * previously). Now skip mana detach and just retry mana_attach.
> > +	 */
> > +	if (!from_close && !netif_device_present(ndev))
> > +		return 0;
> > +
> >  	apc->port_st_save = apc->port_is_up;
> >  	apc->port_is_up = false;
> 
> sashiko(gemini) notes the above can lead to different race:
> 
> ---
> Can this early return cause state machine corruption by bypassing the
> updates
> to apc->port_st_save?
> Consider this sequence:
> 1. queue_reset_work runs, mana_detach() succeeds (apc->port_st_save = true,
>    apc->port_is_up = false), but mana_attach() fails.
> 2. The admin brings the interface down (ip link set dev eth0 down), skipping
>    mana_close() since apc->port_is_up is false.
> 3. The admin changes the MTU, triggering mana_change_mtu() which calls
>    mana_detach() followed by mana_attach().
> 4. mana_detach() hits this new early return, preserving
>    apc->port_st_save == true.
> When mana_attach() runs, it sees apc->port_st_save == true and allocates
> queues, setting apc->vport_use_count = 1 and apc->port_is_up = true, even
> though the interface is administratively down.
> If the admin then brings the interface up, mana_open() will unconditionally
> call mana_alloc_queues(). That function calls mana_cfg_vport(), which will
> return -EBUSY because apc->vport_use_count is already 1.
> This leaves mana_open() failing and the interface down. Since the interface
> is already down, trying to bring it down again is a no-op, meaning
> mana_close() is never called to clean up the orphaned queues.
> Does this sequence permanently brick the port until the driver is reloaded?
> ---
> 
> I think you need to be more restrictive in the early return check.
> 
> /P
>
Hi Paolo,

Thank you for the comments,
I think the scenario pointed out by sashiko does not seems valid,
as it mentioned in step 2 and 3 admin changing MTU after bringing
interface down. This is becasue netif_set_mtu_ext() in dev.c checks
netif_device_present and returns -ENODEV before calling
ndo_change_mtu. So mana_change_mtu() is never reachable when the
device is in the !present state.

https://elixir.bootlin.com/linux/v7.0/source/net/core/dev.c#L9906 

Please let me know if the above check is good enough?

Regards
Dipayaan Roy

 

