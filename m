Return-Path: <linux-hyperv+bounces-10819-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAUsEx4DBGrLCAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10819-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 06:50:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B552D44D
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 06:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 680E9304F2E1
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 04:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87051346AD4;
	Wed, 13 May 2026 04:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EsVf3TWh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55155299923;
	Wed, 13 May 2026 04:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647776; cv=none; b=FbdU50hqR0UqEHYNp0wGxSEbPmFqMpMft+2RvR+HcF/5frgcZMjL1U/V8Q7tK6PMXxhyWL6G9l/wjtduMAb/U8wb25Gvx4pNi/5dC4PuUCPp6aUqcTBKYNeWMXQMyWuyWfTagMkgUCIeHsmUJVgLzQCW2TaFA5S54azTTW/a134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647776; c=relaxed/simple;
	bh=dT77H9ORPste/t0zfSTlk15UTBP295wtZR/6wSlJ3A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Js5k1N1SmkjNRvqMXxqNOx8SxsYmks8zLw/fbEiX5X8+xVgBPQHk7nzyjT26O3uWaRConUKlVjZevex6lWmqJg3gtkzCv9g2CPBegEvUGx+GHhfL9ILVPdjZG54J/O/a4g9/hmXfPsbsT2TeOgLXdemspw0tQDsx6U8GGrUJ480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EsVf3TWh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 7EC0D20B7166; Tue, 12 May 2026 21:49:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7EC0D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778647771;
	bh=Omuq11ywLwTC5q3IVHAFOC9whRswGzaRH2gtVx0YPH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsVf3TWhP3f3icGssZBLG13b1+ZhIUVGdz8weHlOEC0XuepUUsVQTT3inEn8BIRgM
	 3OnM9nYc854GL6hcpJh2yhN+75lpV5KV3JplTvixMIKFV18Ni9QfxF60I6zdHnDbve
	 c87pcYaFriR1kQvueonMyzS/0ZKapiU8t0xLIf+c=
Date: Tue, 12 May 2026 21:49:31 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com, yury.norov@gmail.com, kees@kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v8] net: mana: Expose hardware diagnostic info
 via debugfs
Message-ID: <agQC2/HG6FsCgFZn@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260506055128.291494-1-ernis@linux.microsoft.com>
 <20260508220114.3342627-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508220114.3342627-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 9B2B552D44D
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10819-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:01:14PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: mana: Expose hardware diagnostic info via debugfs
> 
> Add debugfs entries to expose hardware configuration and diagnostic
> information that aids in debugging driver initialization and runtime
> operations without adding noise to dmesg.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> [ ... ]
> > @@ -2231,13 +2239,18 @@ int mana_gd_resume(struct pci_dev *pdev)
> >  
> >  	err = mana_probe(&gc->mana, true);
> >  	if (err)
> > -		return err;
> > +		goto cleanup_gd;
> >  
> >  	err = mana_rdma_probe(&gc->mana_ib);
> >  	if (err)
> > -		return err;
> > +		goto cleanup_mana;
> >  
> >  	return 0;
> > +cleanup_mana:
> > +	mana_remove(&gc->mana, true);
> > +cleanup_gd:
> > +	mana_gd_cleanup_device(pdev);
> > +	return err;
> >  }
> 
> Since mana_remove() called with true for suspending skips
> unregister_netdevice(), the network devices remain registered in the system.
> 
> If mana_gd_cleanup_device() is then called, which destroys the hardware
> channel and clears gc->hwc.driver_data, could this lead to a NULL pointer
> dereference if userspace later interacts with the still-registered devices?

Sorry for delayed response.

This is a valid concern. I will update it to mana_remove(&gc->mana, false) in
the next version.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> [ ... ]
> > @@ -3161,6 +3169,23 @@ static int mana_init_port(struct net_device *ndev)
> >  	eth_hw_addr_set(ndev, apc->mac_addr);
> >  	sprintf(vport, "vport%d", port_idx);
> >  	apc->mana_port_debugfs = debugfs_create_dir(vport, gc->mana_pci_debugfs);
> > +
> > +	debugfs_create_u64("port_handle", 0400, apc->mana_port_debugfs,
> > +			   &apc->port_handle);
> 
> When the device suspends, mana_gd_suspend() calls mana_gd_cleanup_device(),
> which recursively removes the entire debugfs directory tree.
> 
> During resume, the parent debugfs directory is recreated, but mana_probe()
> skips calling mana_init_port() for existing ports.
> 
> Does this mean the per-vPort debugfs entries are permanently lost after a
> suspend and resume cycle?
> 
This is false positive.
The per-vPort debugfs entries are recreated during resume. The flow is:

Suspend: mana_gd_cleanup_device() removes the entire debugfs tree.

Resume: mana_gd_setup() recreates the top-level mana_pci_debugfs
directory. Then mana_probe(gd, true) takes the resuming=true path,
which calls mana_attach() for each port. mana_attach() calls
mana_init_port(), which recreates the vportN directory and all
per-vPort debugfs files (port_handle, max_sq, max_rq, steer_*,
current_speed).

So the per-vPort entries are not permanently lost, they survive the
suspend/resume cycle.
> [ ... ]
> > @@ -3800,6 +3830,9 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
> >  
> >  	mana_gd_deregister_device(gd);
> >  
> > +	debugfs_lookup_and_remove("bm_hostmode", gc->mana_pci_debugfs);
> > +	debugfs_lookup_and_remove("num_vports", gc->mana_pci_debugfs);
> > +
> >  	if (suspending)
> >  		return;
> 
> Earlier in mana_remove(), free_netdev() is called, which frees the port
> context structure (apc) allocated via netdev_priv(ndev).
> 
> Since the per-vPort debugfs files created in mana_init_port() directly
> reference memory within apc, and apc->mana_port_debugfs is not explicitly
> removed here, does this leave the debugfs files accessible but pointing to
> freed memory until the parent directory is finally removed in
> mana_gd_cleanup_device()?

This is a false positive.
The per-vPort debugfs files are removed before free_netdev() frees apc.

In mana_remove(gd, false), the sequence for each port is:

mana_detach(ndev, false) -> mana_cleanup_port_context(apc)
-> debugfs_remove(apc->mana_port_debugfs).
This removes the entire vportN directory and all its child files, since
debugfs_remove() is recursive (simple_recursive_removal()).
free_netdev(ndev) which frees apc.
Because step 1 removes all debugfs files referencing apc fields before
step 2 frees the memory, there is no window where the files point to
freed memory.

