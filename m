Return-Path: <linux-hyperv+bounces-11161-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGydAM3kEGqOfAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11161-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 01:20:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 583F35BB705
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 01:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D69AD302261B
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 23:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ECD392812;
	Fri, 22 May 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cQgaLdXI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBFA349CE0;
	Fri, 22 May 2026 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491806; cv=none; b=ux/hzjsDiLIg8R3ifLHoMUO71ssdDa8cLYI0E1Cj/m7wXupujbduCForTZvku4MhKw1eF5jM8Fep65T1Av9OJiGMKCUPPOGaB0Fso6dYwB7eQBapi4ULD7s4BGi/4/D5yXZ3D4egNsV5pVa4W3jrAcpfQ0e8ak2lC3fUlFmCI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491806; c=relaxed/simple;
	bh=StHrlVUUmzb+0tfAA8jqXT51fFPejI83n3WwwobANrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB9cO5smyBmbvzQ6FLS+VZ+LUYYZZ/QDmx5HynAMB+hwcsc2jV2o6UH11ntzGah3cF3wjcM7pKdUZ+zz7/s8czmvPL1qp/XtmfHN+LnfHoOh3p9gDCBD4Lfj8PqYPUZNAwcAHaGw5cRHZAkz52V7vs++6UbHuBVROXEbzXm5uIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cQgaLdXI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 86F2520B7167; Fri, 22 May 2026 16:16:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86F2520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779491790;
	bh=y1lc4L9BFBDBlfLkybR1gQIiJ0WLDpMWxH052ZQxeiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQgaLdXIsOnU/PkHFd4EeXtvQ/avsIF6H39eMhb3kkiGz0w7/GDTmNu97uFcmc8tZ
	 hQrLZVVYA+PYF9xpwrE/WfG8d0zRXtkaNnbf94K6gjTyDtPftA9JvW5wcsl2ydmNVU
	 RZ/VAieUBalnH+z+T5riH3i2hexQ63JHzlSBv0kg=
Date: Fri, 22 May 2026 16:16:30 -0700
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
Message-ID: <ahDjzv9gXR2xiRBW@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260518194654.735580-1-dipayanroy@linux.microsoft.com>
 <20260518194654.735580-3-dipayanroy@linux.microsoft.com>
 <20260520171703.689c5462@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520171703.689c5462@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11161-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 583F35BB705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 05:17:03PM -0700, Jakub Kicinski wrote:
> On Mon, 18 May 2026 12:43:51 -0700 Dipayaan Roy wrote:
> > +	/* If already detached (indicates detach succeeded but attach failed
> > +	 * previously). Now skip mana detach and just retry mana_attach.
> > +	 */
> > +	if (!netif_device_present(ndev))
> > +		goto attach;
> > +
> >  	err = mana_detach(ndev, false);
> >  	if (err) {
> >  		netdev_err(ndev, "mana_detach failed: %d\n", err);
> >  		goto dealloc_pre_rxbufs;
> >  	}
> >  
> > +attach:
> 
> goto's are acceptable for error unwinding, not to jump around 
> a function seemingly to avoid indenting something. Please use
> normal constructs or perhaps move the netif_device_present()
> into mana_detach() as an early exit condition? 
>

Hi Jakub,

Thanks for the suggestions, Moving netif_device_present() into mana_detach
as an early exit, is a better option and will cover all cases. I will send
v2 with the suggestion.

Regards
Dipayaan Roy
 
> >  	err = mana_attach(ndev);

