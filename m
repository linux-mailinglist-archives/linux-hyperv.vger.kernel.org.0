Return-Path: <linux-hyperv+bounces-10397-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBjFGPyt72lyDwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10397-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 20:42:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DF0478C4F
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 20:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 971E7302D5F4
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54D13ED11B;
	Mon, 27 Apr 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="phsTeeRh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C954282F3E;
	Mon, 27 Apr 2026 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315213; cv=none; b=LHYds6PFnmEcJdWJKckRan2xtxcGISmKeJKKI+QQlwNDc6kb4XKtBQrZ3n8RteMap9d84odI8W56SWIYQFtLoug6Ap3z83vTsBq9e+5GARWrtt4C5nz4piwaJhPAQlzhcf+YGoSDdd5qQcCqW7vMIN+8+9IWzpgmcE8WxGWdysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315213; c=relaxed/simple;
	bh=/HusL2LtExbYgbua5UuILHfWISTnSh1CAhqnyumz+Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDIDQuY1W2JfY0eev26fETZqXwSBwxw2HcZMlUNRuTK35m7pCJ7eb7VaSE7k35Fx3BiDf+WrtFVv/GqVrOr6+5p27GyzsBLGx9omynLbfJgNzMgeZzzur9PR5BIj5elNOBAUMkniW876yPf3suTACIpN81e/lALxqLBOomj/4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=phsTeeRh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id C703020B716A; Mon, 27 Apr 2026 11:40:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C703020B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777315212;
	bh=c9RCSoOaBSCbqRUxkmuPRyFNJC5Wn8rmCTPwlSbYIVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phsTeeRh1xzt23RXuaC4Il9OkAxXboOi53tfM/lLVqXxC3Dh78xEcvQZoPZIWhUpY
	 WbTL+ZWNx0DLv7nslT/D45PToInmJ29R9pE6D82j5tzmK+VyHG/eIun94k+tVV+TDz
	 6Qzsjwyrshmzj/mFeVHOy1qs/cdHbKzQmqds7JoU=
Date: Mon, 27 Apr 2026 11:40:12 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	jacob.e.keller@intel.com, dipayanroy@microsoft.com,
	leitao@debian.org, kees@kernel.org, john.fastabend@gmail.com,
	hawk@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Subject: Re: [PATCH net] net: mana: hardening: Validate SHM offset from BAR0
 register to prevent crash due to alignment fault
Message-ID: <ae+tjDl+RPCU6JDq@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260426131555.GA3501894@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426131555.GA3501894@ziepe.ca>
X-Rspamd-Queue-Id: 10DF0478C4F
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-10397-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]

On Sun, Apr 26, 2026 at 10:15:55AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 23, 2026 at 09:16:28AM -0700, Dipayaan Roy wrote:
> > During Function Level Reset recovery, the MANA driver reads
> > hardware BAR0 registers that may temporarily contain garbage values.
> > The SHM (Shared Memory) offset read from GDMA_REG_SHM_OFFSET is used
> > to compute gc->shm_base, which is later dereferenced via readl() in
> > mana_smc_poll_register(). If the hardware returns an unaligned or
> > out-of-range value, the driver must not blindly use it, as this would
> > propagate the hardware error into a kernel crash.
> 
> It is not what we are calling "hardening" if you are hitting actual
> crashes in actual real systems.
> 
> "hardening" is the driver defending against actively malicious
> hardware, operating in ways that will never be seen in real systems,
> attempting to compromise the kernel.
> 
> Drivers working around real world broken/buggy/malfunctioning HW is
> just entirely normal stuff.
>
Hi Jason,

sure, I will drop the hardening label, in v2. 
> > @@ -73,10 +74,25 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
> >  	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
> >  
> >  	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
> > +	if (sriov_base_off >= gc->bar0_size ||
> > +	    !IS_ALIGNED(sriov_base_off, sizeof(u32))) {
> > +		dev_err(gc->dev,
> > +			"SRIOV base offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
> > +			sriov_base_off, (u64)gc->bar0_size);
> > +		return -EPROTO;
> > +	}
> 
> .. and if it is entirely normal and something that happens is EPROTO
> really the right way to deal with this race, or should the driver be
> looping somehow until the device stabilizes??
This is the current flow of the driver:
mana_serv_reset()
	mana_gd_suspend()
	msleep(MANA_SERVICE_PERIOD * 1000); -> 10s
	mana_gd_resume()
		mana_gd_init_registers();  -> read the garbage followed by fault
	mana_serv_rescan(); -> On mana_gd_resume err(EPROTO) full PCI remove + rescan

The 10-second sleep in mana_serv_reset() already happens before
mana_gd_resume() is called, so by the time we read the registers
hardware should have stabilized. If we still see garbage after 10
seconds, it suggests deeper hardware issue where PCI rescan is
recomended from HW. This patch returns -EPROTO on detection
of unaligned / out of range offset and that err code triggers the
mana_serv_rescan().

> 
> Jason

Thanks Jason for the review comments, will post a v2 to drop the
hardening label.

Regards
Dipayaan Roy


