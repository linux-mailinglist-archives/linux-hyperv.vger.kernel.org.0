Return-Path: <linux-hyperv+bounces-9831-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKfWFdHKyml3AAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9831-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 21:11:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B1136033B
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 21:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5541302DB54
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C623E023E;
	Mon, 30 Mar 2026 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j0O5tOIp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56983E1208;
	Mon, 30 Mar 2026 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897801; cv=none; b=YdVTokjUWku1duo4DYZX0hwdEwo5gIoGJ7ruphQfZNsDjqheW2zm9smOGf72bs+C5UBjLh1rz7Z4hbErP+9F8hy3SninVS+YkXNkD0Ofw08sekNVXxoM4emi2w4p1kO1Xk2NwAzvMu359IMzn01YPsf1VxIUqpK1BgI1QdCOYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897801; c=relaxed/simple;
	bh=hKj2Khk6z1UFkIxi2T+PsGhljz7e/eXHqFn5tDAhTIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7BJnStJx8zpu+qlnT+oZtVb0GKpc+XHUNiHMmw2FziplvAyXdpvSd+9kgiNr+VWBWrgecL0ob04FpGMR5gdTL068Cd5ODZowQzNVBckhSB/QwtPa6SIcXFwN+es7fj7BMpdYNqdyqsm+hVakIUNEIW/5rcxbFpTcjdRT5jHlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j0O5tOIp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 5FE2520B712B; Mon, 30 Mar 2026 12:09:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FE2520B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774897792;
	bh=khibm8huBnKGzHTyYdNQdU0oYmwKpBKE2lEPAxjzUjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0O5tOIpFbzivjvyrT57Ritv8lG5SzRj7BdQqwXrjDN5mnWf85nyQrWHePkm55UhB
	 OVhsDMS77sxf2HjV08GiTtROsMMsu3FnzapBO4+q+tgJ3dSf6q0KjwUEcx+oSu8qau
	 pKnfZvy99d8hOMIOTUlrjqGQ2f174bDQeTlUoZ1g=
Date: Mon, 30 Mar 2026 12:09:52 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
	dipayanroy@linux.microsoft.com, yury.norov@gmail.com,
	kees@kernel.org, ssengar@linux.microsoft.com,
	gargaditya@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: mana: Expose hardware diagnostic info
 via debugfs
Message-ID: <acrKgG0USsGABqYT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260319070926.1459515-1-ernis@linux.microsoft.com>
 <20260323174444.2717da3d@kernel.org>
 <acK56AlPfVW8cDPe@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acK56AlPfVW8cDPe@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9831-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4B1136033B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 09:20:56AM -0700, Erni Sri Satya Vennela wrote:
> On Mon, Mar 23, 2026 at 05:44:44PM -0700, Jakub Kicinski wrote:
> > On Thu, 19 Mar 2026 00:09:13 -0700 Erni Sri Satya Vennela wrote:
> > > Add debugfs entries to expose hardware configuration and diagnostic
> > > information that aids in debugging driver initialization and runtime
> > > operations without adding noise to dmesg.
> > > 
> > > The debugfs directory creation and removal for each PCI device is
> > > integrated into mana_gd_setup() and mana_gd_cleanup_device()
> > > respectively, so that all callers (probe, remove, suspend, resume,
> > > shutdown) share a single code path.
> > > 
> > > Device-level entries (under /sys/kernel/debug/mana/<slot>/):
> > >   - num_msix_usable, max_num_queues: Max resources from hardware
> > >   - gdma_protocol_ver, pf_cap_flags1: VF version negotiation results
> > >   - num_vports, bm_hostmode: Device configuration
> > > 
> > > Per-vPort entries (under /sys/kernel/debug/mana/<slot>/vportN/):
> > >   - port_handle: Hardware vPort handle
> > >   - max_sq, max_rq: Max queues from vPort config
> > >   - indir_table_sz: Indirection table size
> > >   - steer_rx, steer_rss, steer_update_tab, steer_cqe_coalescing:
> > >     Last applied steering configuration parameters
> > 
> > AI says:
> > 
> > > @@ -1918,15 +1930,23 @@ static int mana_gd_setup(struct pci_dev *pdev)
> > >  	struct gdma_context *gc = pci_get_drvdata(pdev);
> > >  	int err;
> > >  
> > > +	if (gc->is_pf)
> > > +		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
> > > +	else
> > > +		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
> > > +							  mana_debugfs_root);
> > 
> > If pdev->slot is NULL (which can happen for VFs in environments like generic
> > VFIO passthrough or nested KVM), will pci_slot_name(pdev->slot) cause a
> > NULL pointer dereference?
> > 
> > Also, could this naming scheme cause name collisions? If multiple PFs are
> > present, they would all try to use "0". Similarly, VFs across different
> > PCI domains or buses might share the same physical slot identifier, leading
> > to -EEXIST errors. Would it be safer to use the unique PCI BDF via
> > pci_name(pdev) instead?
> Yes. that is a better way to handle it. I will use pci_name. We can
> remove if-else and use only one for both the cases.
> > 
> > > @@ -3141,6 +3149,24 @@ static int mana_init_port(struct net_device *ndev)
> > >  	eth_hw_addr_set(ndev, apc->mac_addr);
> > >  	sprintf(vport, "vport%d", port_idx);
> > >  	apc->mana_port_debugfs = debugfs_create_dir(vport, gc->mana_pci_debugfs);
> > > +
> > > +	debugfs_create_u64("port_handle", 0400, apc->mana_port_debugfs,
> > > +			   &apc->port_handle);
> > 
> > When operations like changing the MTU or setting an XDP program trigger a
> > detach/attach cycle, mana_detach() invokes mana_cleanup_port_context(),
> > which recursively removes the apc->mana_port_debugfs directory.
> > During re-attachment, mana_attach() calls mana_init_port(), which
> > recreates the directory and the new files added in this patch. However, the
> > pre-existing current_speed file (created in mana_probe_port()) is not
> > recreated here.
> > 
> > Does this cause the current_speed file to be permanently lost after a
> > detach/attach cycle? Should the creation of current_speed be moved to
> > mana_init_port() so it survives the cycle?
> Yes that is correct.
> 
> Since these issues are pre-existing and not introduced from my patch.
> I'll plan to send them as different patch with fixes tag.
> > -- 
> > pw-bot: cr


Hi Jakub,

Just a quick follow‑up on this. Since these issues were pre‑existing and
not introduced by this patch, would you prefer that I send them as a
separate fix patch, or fold the fixes into the current patch?

Thanks,
Vennela

