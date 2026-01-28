Return-Path: <linux-hyperv+bounces-8563-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPjVAWc+emlB4wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8563-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 17:50:47 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61377A633F
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 17:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2204B3230150
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 16:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680063112DB;
	Wed, 28 Jan 2026 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="B1odQAXh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D530F7FA;
	Wed, 28 Jan 2026 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617014; cv=pass; b=iu6LM+4bQ6TDmep0ehq2inWf1e7q+/vgsByebkCAYqDSkCo5hLjGQujtBIfcEv4Teh0MpMGAZTqCjep+0hbjBWJ4i1h/5eAHCi6fe7NLr0coJ3fMR7RXVPzLc+2iH8YEG/3U1sQ1b7OD4z8RWuoHS0T/nfMPHLTMyNqBGF8IocA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617014; c=relaxed/simple;
	bh=/wuVYwi7s0O8zwXGCPAHdXllatt/4FyTREtTRjgZc5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoW5zjoW7DTAgGiqooAbH1A/6XdWg/EKIXZDpdWrAvGHFQxUePLQND6yLCZptznrclcI/m/wiXi6yIGgGNiyQBQq50loPRiw5OVgSxvk0aSgYQFRc5922Mdd+3ecUiXXgh1ZaK93tOwikCDo8bg6uHP8zfT4xObfHWxthpvxkD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=B1odQAXh; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769617002; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EWdIQ+Y+fNOiL4opFblwpM1oVDthLOcbxc6/GFiC8QyAdN+LWc3a+XZqCRcLbpc7K9G1ZMNI8AMX+T5BpUAb5ZXjuMbtnQEs5OOj2tty09edf/5Qg6eUweaHMPSBfgx1Q3yWom10ZVSEP+Fm8ErdfLbq8wKDlVMn9bGbNkiQOV8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769617002; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0QawbTxuXnc3bO/oeGvHR8vV16XTXUszsuyQFERjUVc=; 
	b=WO7BUbLj8axEsVCbwA/6Q9MaCPND677Lo5QwDxGHaVsZEuJ0+b0EC5+6Nb5PMEDNykOXbmuK/fUr+ZS18SliinMi/JAfrUvl2BKRNFXrO6qfoXvBDmP/NXgbr3BLuJd7K7GYorTOYYGtua2lz51K6Y6gLoHGseBGLUsQs6QOWDM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769617002;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=0QawbTxuXnc3bO/oeGvHR8vV16XTXUszsuyQFERjUVc=;
	b=B1odQAXheh/z5v4Hu/lumQv3RjlfB+4/cY68gnCWv0zRPaomf3IWPvYjVHUwGMqJ
	q81WSZ/qHEF7qX0bAXKDdBaWgsui2+CvcKsLdj0B8YHSBwfJ8SpQ/9otRxXUYNNExbT
	2rJtbclAaJiYiVIZzn3ubLlE9mr72rer69hthzuc=
Received: by mx.zohomail.com with SMTPS id 17696169983261006.4672516716466;
	Wed, 28 Jan 2026 08:16:38 -0800 (PST)
Date: Wed, 28 Jan 2026 16:16:31 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXo2X4mRioTa3sBl@anirudh-surface.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>
 <aXfStKqKiSSHEmXj@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXfStKqKiSSHEmXj@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8563-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudh-surface.localdomain:mid,anirudhrb.com:dkim]
X-Rspamd-Queue-Id: 61377A633F
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:46:44PM -0800, Stanislav Kinsburskii wrote:
> On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> > On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > hypervisor deposited pages.
> > > 
> > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > management is implemented.
> > 
> > Someone might want to stop all guest VMs and do a kexec. Which is valid
> > and would work without any issue for L1VH.
> > 
> 
> No, it won't work and hypervsisor depostied pages won't be withdrawn.

All pages that were deposited in the context of a guest partition (i.e.
with the guest partition ID), would be withdrawn when you kill the VMs,
right? What other deposited pages would be left?

Thanks,
Anirudh.

> Also, kernel consisntency must no depend on use space behavior. 
> 
> > Also, I don't think it is reasonable at all that someone needs to
> > disable basic kernel functionality such as kexec in order to use our
> > driver.
> > 
> 
> It's a temporary measure until proper page lifecycle management is
> supported in the driver.
> Mutual exclusion of the driver and kexec is given and thus should be
> expclitily stated in the Kconfig.
> 
> Thanks,
> Stanislav
> 
> > Thanks,
> > Anirudh.
> > 
> > > 
> > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > ---
> > >  drivers/hv/Kconfig |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > --- a/drivers/hv/Kconfig
> > > +++ b/drivers/hv/Kconfig
> > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > >  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > >  	# no particular order, making it impossible to reassemble larger pages
> > >  	depends on PAGE_SIZE_4KB
> > > +	depends on !KEXEC
> > >  	select EVENTFD
> > >  	select VIRT_XFER_TO_GUEST_WORK
> > >  	select HMM_MIRROR
> > > 
> > > 

