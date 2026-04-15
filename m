Return-Path: <linux-hyperv+bounces-10172-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJKFJpc432nAQQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10172-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 09:04:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C94B8401321
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 09:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8663A301A90E
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 07:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA0739021D;
	Wed, 15 Apr 2026 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b5EMbtMU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFB6296BD2;
	Wed, 15 Apr 2026 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776236692; cv=none; b=buYNYpzgzqp9XYLujlhaiSnd2sC1VamlrljJ5yVPlumg8LvaYzGH8FF5Js6YOi9EdsfEdJgB0rX3J+KR3byuwRiHwtGB0wEGPaLFlXKqmv6h0EGypO5F6dpkWmHanbrZi842UfcWUKgcJGSYDM82RZvGoD2DNrzzPAZudmbJgIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776236692; c=relaxed/simple;
	bh=h6jbL43JVw2PgM6UEaVTDkIyCWLY9mHAPYeKqDJmxKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Almop9NVVm43MHJeTe8xl9gDdrv+SF478mtCtyq3nnlVxakEh561LtjrqEJUtdcHJQEK5iOkA8YXkZG1EhZS1mY//h9pxp8luqi5jy1zwJd4W74DAwrgMzpq54uQ8ud0c/lpE1QJop76jujOjcEzOBBibf1D7oqVvcK+HV2MwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b5EMbtMU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id AEEC920B7128; Wed, 15 Apr 2026 00:04:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEEC920B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776236691;
	bh=uYck4DdEmNbmUydY4pSIYMd6QIGrusKz3HcPwwEHtQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5EMbtMUI8Yu04TUVItL6bkZwJoXrVDTA98VEYtnbMWlIjmg6Aa3uKyW2KP9BXMEi
	 nDmLGQz4W2Z33vH45KeKmbFngabiHTgNnMBj6sfBgI0hq/csJf6rBVafqFU8pbmodS
	 dMAEU6qZJaMLHTglrtVZNXNik0CepWX8sz36NROQ=
Date: Wed, 15 Apr 2026 00:04:51 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com, kees@kernel.org,
	kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
	stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/4] net: mana: Don't overwrite port probe error
 with add_adev result
Message-ID: <ad84k4qaMd9wnYwd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260413050843.605789-4-ernis@linux.microsoft.com>
 <20260414153503.769476-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414153503.769476-1-horms@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10172-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: C94B8401321
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 04:35:03PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: mana: Don't overwrite port probe error with add_adev result
> 
> This commit ensures that if mana_probe_port() or mana_attach() fails, the
> error is not overwritten by the result of add_adev(). By preserving the
> error, it triggers mana_remove() cleanup instead of leaving ports partially
> initialized.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 9d095a6fb56c7..4d42cbfb3f15b 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -3634,10 +3634,9 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
> >  	if (!resuming) {
> >  		for (i = 0; i < ac->num_ports; i++) {
> >  			err = mana_probe_port(ac, i, &ac->ports[i]);
> > -			/* we log the port for which the probe failed and stop
> > -			 * probes for subsequent ports.
> > -			 * Note that we keep running ports, for which the probes
> > -			 * were successful, unless add_adev fails too
> > +			/* Log the port for which the probe failed, stop probing
> > +			 * subsequent ports, and skip add_adev.
> > +			 * Already-probed ports remain functional.
> >  			 */
> 
> Are these comments accurate regarding ports remaining functional?
> 
> Since this patch preserves the error code, execution falls through to the end
> of mana_probe() where it checks if err is set and calls mana_remove().
> mana_remove() will iterate over the successfully allocated ports, completely
> detach them, unregister their net_devices, and destroy event queues.
> 
> It appears no ports remain functional because the device is completely torn
> down.
>
I will update the patch with the updated comment message. 
> [ ... ]
> 
> > @@ -3651,10 +3650,9 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
> >  			enable_work(&apc->queue_reset_work);
> >  			err = mana_attach(ac->ports[i]);
> >  			rtnl_unlock();
> > -			/* we log the port for which the attach failed and stop
> > -			 * attach for subsequent ports
> > -			 * Note that we keep running ports, for which the attach
> > -			 * were successful, unless add_adev fails too
> > +			/* Log the port for which the attach failed, stop
> > +			 * attaching subsequent ports, and skip add_adev.
> > +			 * Already-attached ports remain functional.
> >  			 */
> >  			if (err) {
> >  				dev_err(dev, "Attach Failed for port %d\n", i);
> > @@ -3663,7 +3661,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
> 
> Does propagating this error during PM resume introduce a NULL pointer
> dereference?
> 
> If PM resume fails here (resuming == true), the preserved error code causes
> mana_probe() to call mana_remove(), which tears down the device and sets
> gd->gdma_context = NULL.
> 
> However, a failed resume callback does not automatically unbind the driver.
> When the device is eventually unbound later, mana_remove() is invoked again:
> 
> drivers/net/ethernet/microsoft/mana/mana_en.c:mana_remove() {
>     struct gdma_context *gc = gd->gdma_context;
>     struct device *dev = gc->dev;
>     ...
> }
> 
> In the second invocation, gd->gdma_context is NULL, meaning gc is NULL,
> which could lead to a kernel panic when dereferencing gc->dev.

Thankyou for pointing it out, Simon.
Since this is a pre-existing bug, I will create a different patch for
this change and make it as part of this patchset.

- Vennela

