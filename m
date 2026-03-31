Return-Path: <linux-hyperv+bounces-9862-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBkVDykNzGnGNgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9862-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 20:06:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C607A36FB0D
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 20:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F21013054D61
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 18:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D62E426694;
	Tue, 31 Mar 2026 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nx9hYoRZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA653C872F;
	Tue, 31 Mar 2026 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980136; cv=none; b=dZFSO94Ntt3UMJqAaUwIjfu4eE9/+x+jvx1FcJh4zmKuTuq1LZyz8sg0uF5ebB1E3TxVRQVizDQP4qsaIkQ07OMAl/2dyd49mxR8J0kI98EII2wXmHZECziQTNasl17X5BEJT0kCQAd6/WP9xah9w7IFzDL+1fOLhZGUeKvkZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980136; c=relaxed/simple;
	bh=0nBWpO+HxGsxynwXDV4l2w5pAFihpKeApb3uU8jET50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxm6+j1ZIK84BrK9FXv/4Zj+yHe+SSdDavQb4WI7gTdI2hOxHquU7zI15H6CRd90PqC006o8hNj/Qy3/Db4JJTF8zwadqU7/naCgTt0XPNOv+qo1WCsZuAO3YD2TIAB3YwuHSoSDhQy49ZoDJtQEAgUdNznGq8yUL5j4STfC55M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nx9hYoRZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id B20B220B712B; Tue, 31 Mar 2026 11:02:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B20B220B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774980135;
	bh=9A/iz/dgD7STMPSJlpJwG6Y88xGERpU89yFJ7z9ypNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nx9hYoRZh0oZ/qV9bOtNiVA+zl0+eMQx9Ppf1OkxrbcfrJHdbpQripBBedOWvd4Yq
	 iAfzWGcEEfHFCDbzO5es1pPXwAnd8lVRbPzdRjYE6cM1uHws4VdmxNS7nMQ7uhSRh+
	 u4vN5L5HaE0UW7+TtBoEM/av2PyBAxh9FYQpXkRE=
Date: Tue, 31 Mar 2026 11:02:15 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	ssengar@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com, shirazsaleem@microsoft.com,
	kees@kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: hardening: Reject zero
 max_num_queues from MANA_QUERY_VPORT_CONFIG
Message-ID: <acwMJ+ERDG9ZeDSA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260326174815.2012137-1-ernis@linux.microsoft.com>
 <f0bc585f-b1d2-46e6-b0eb-801881862692@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0bc585f-b1d2-46e6-b0eb-801881862692@redhat.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9862-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: C607A36FB0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 > +
> > +	if (*max_sq == 0 || *max_rq == 0) {
> > +		netdev_err(apc->ndev, "Invalid max queues from vPort config\n");
> > +		return -EPROTO;
> 
> AI review says:
> 
> Will returning -EPROTO here expose a pre-existing resource leak in the
> driver's teardown path?
> If mana_query_vport_cfg() returns an error, mana_init_port() fails and
> mana_probe_port() frees the ndev, leaving ac->ports[i] as NULL. In
> mana_probe(), the port initialization loop breaks upon this error, but
> the err variable is then overwritten:
> 
> mana_probe() {
>     ...
>     for (i = 0; i < ac->num_ports; i++) {
>         err = mana_probe_port(ac, i, &ac->ports[i]);
>         if (err) {
>             dev_err(dev, "Probe Failed for port %d\n", i);
>             break;
>         }
>     }
> 
>     err = add_adev(gd, "eth");
>     ...
> }
> 
> If add_adev() succeeds, mana_probe() completes successfully instead of
> failing, masking the earlier error while leaving ac->ports[0] as NULL.
> Later, when the driver is unloaded or if add_adev() fails and triggers
> immediate cleanup, mana_remove() is called. It iterates over ac->ports
> and, upon encountering the NULL device, immediately executes goto out:
> 
> mana_remove() {
>     ...
>     for (i = 0; i < ac->num_ports; i++) {
>         ndev = ac->ports[i];
>         if (!ndev) {
>             if (i == 0)
>                 ...
>             goto out;
>         }
>         ...
>     }
> 
>     mana_destroy_eq(ac);
> out:
>     ...
> }
> 
> Because the out label in mana_remove() is located after the
> mana_destroy_eq(ac) call, jumping there completely skips destroying the
> event queues allocated earlier by mana_create_eq(ac).
> In a Confidential Virtual Machine context, could an untrusted hypervisor
> repeatedly return invalid configs to continuously leak guest memory and
> hardware queues?

Thankyou for the review.
Since these issues are pre-existing, I will send it in a separate
patchset.
The patchset will also include the issues reported in:
[PATCH net-next] net: mana: hardening: Validate adapter_mtu from
MANA_QUERY_DEV_CONFIG

- Vennela

