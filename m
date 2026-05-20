Return-Path: <linux-hyperv+bounces-11069-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMPcJd4HDmp25gUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11069-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 21:13:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A122A597F90
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 21:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4541032A015C
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143433FC5C7;
	Wed, 20 May 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SdVIuk62"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0183FC5B0;
	Wed, 20 May 2026 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301420; cv=none; b=Okb6EFcDx/5JNPMMzVHI+CVBxUJOJv6qZdPqEEyKdCnYvosjVq+lhXrSL6tG0uaitugeuelBwfPxYoLwu3F0qawcqmuFTRfBP7zxbekhYER+deGZC7ba064lYrQ5q6RxBFd9JOu7JZRdpeQLXOwXmU+KkrZ5VJTBRZNYj9LYLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301420; c=relaxed/simple;
	bh=dyQ17Q/+0Gcxpk6hjMnxXtC1P4RGn7CMUDmoceZeKSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqUbUO2EeHj0S8fksu3btXsw0hKXqut8jn1Pe8+zNip/Kj1jfNUoMj39D6bCo7rDQERQ8zTdU6ir7Vrl2+1CFqiQII6tXTQAhhFnmmWwMt+aTsgyBB+glg0Pv+CKBk21BFdWKACI4+K6D9+ZA0dQxv494mcVqkmdFCQuH3DS7S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SdVIuk62; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id A5A5C20B7167; Wed, 20 May 2026 11:23:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5A5C20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779301411;
	bh=+dONcqQdxeWIh80Fsm8uXDEVtp+MBRB2VTok5PxjOTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdVIuk62h8VEfzbGO4DW4na2uGbdJ+3jBr2i16DPNKCJN3ioGEi89D5VcKEc+tvP9
	 87IZ9NGTnJTybcFjm9ImFh3IOfme+vgkFM7c2NG9Ced31xrMXayXMo73902fNJ1TmD
	 gX1JR9DjY+dhmq0l0cpb7l8NtuPItXzvEYxYHjF4=
Date: Wed, 20 May 2026 11:23:31 -0700
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
Subject: Re: [PATCH net 2/2] net: mana: Skip redundant detach in queue reset
 handler if already detached
Message-ID: <ag38I/b4JNUi2084@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260518194654.735580-3-dipayanroy@linux.microsoft.com>
 <20260519225559.3939235-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519225559.3939235-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11069-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: A122A597F90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 03:55:59PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: mana: Skip redundant detach in queue reset handler if already detached
> 
> This commit adds a check for netif_device_present() in the queue reset
> handler. If the device is already detached, it skips the redundant
> mana_detach() call and proceeds directly to mana_attach().
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 9e7e4bf526bf6..740f3c34db451 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -316,12 +316,19 @@ static void mana_per_port_queue_reset_work_handler(struct work_struct *work)
> [ ... ]
> > +	/* If already detached (indicates detach succeeded but attach failed
> > +	 * previously). Now skip mana detach and just retry mana_attach.
> > +	 */
> > +	if (!netif_device_present(ndev))
> > +		goto attach;
> > +
> >  	err = mana_detach(ndev, false);
> 
> The fix here correctly prevents mana_detach() from running on an already
> detached device. However, do identical issues remain in mana_change_mtu(),
> mana_set_channels(), mana_set_ringparam(), and mana_bpf()?
> 
> If mana_attach() previously failed (for example, due to out of memory),
> the port is left with apc->port_is_up = false, but it preserves
> apc->port_st_save = true, and calls netif_device_detach(ndev).
> 
> If an admin tries to recover the port by retrying a configuration command
> like changing the MTU or attaching XDP, these functions appear to
> unconditionally call mana_detach(ndev, false) without the
> !netif_device_present(ndev) check added here.
> 
> Inside mana_detach(), apc->port_st_save = apc->port_is_up executes. Since
> port_is_up is already false, port_st_save is overwritten to false,
> permanently erasing the intent that the port should be up.
> 
> The subsequent call to mana_attach() would then see port_st_save == false,
> skip mana_alloc_queues(), set port_is_up = false, and successfully call
> netif_device_attach(ndev).
> 
> Would this result in the configuration command returning 0 to userspace
> while the port queues were never allocated, leaving the interface silently
> broken until manually toggled down and up?

Hi Jakub,

I agree that mana_change_mtu() and mana_xdp_set() would also need the same
netif_device_present() guard (or alternatively, an early return
when the port is already detached). I'll investigate and address those in a
follow-up patch to keep this fix minimal, as this patch
specifically fixes the reset handler that runs without user intervention,
unlike the ohers cases mentioned above.

Regards
Dipayaan Roy




