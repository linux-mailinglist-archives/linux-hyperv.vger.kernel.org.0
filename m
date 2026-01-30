Return-Path: <linux-hyperv+bounces-8605-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLGuCxLpfGlTPQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8605-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:23:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A7BD03E
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB4E83019134
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCAD347FC4;
	Fri, 30 Jan 2026 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="qjlgHqav"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6469C341660;
	Fri, 30 Jan 2026 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793091; cv=pass; b=Syh03xw7DmGr2TuKCyzczQ59D5ior+fkHBGI5dBKW7KtpM1eiAiVtoubrtxF5FsbcctiP3f8E76BhPbX+GDwWNECeDJleXkjcshPE39DPGQ+x62tLiqehVvNICbnXTCKRVPLukdCX9co9rWUaNqg1P55VU3HY0/1ry/H3WNGXmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793091; c=relaxed/simple;
	bh=n2Ueukbdatja03Cv1vMiiY14U1/qI4sc7D2m18QUgYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er+noONpNvR06PMp1IcDlMz0hp+b7m858i+FlTK+CtC5VLTwumDNPOhrg6bAdA6tdkuNRSjK2TIiaVfWfszZa8Y/hEkAnLLWEz6Y7BoRI0PNZxxdTPDi694MfIYU03TXWwSbTvst+YVDbouNt/QRtkAA3eFTtEGSXc42y1YfdhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=qjlgHqav; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769793079; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OGM4QjcOB82J03PZ8AZDm11Ftuo3eOAgSTOnMQzkk2X572Ra6WQ3GggWLp5Y04FThknPhsOHxaMGHoEXuP0FxfwV6RSm/Sq8jXWsBjyL9U8siOEChsv+CoCOOJya7UkE/fGFZq1PDu6d2+9F+HQH5Yt1Rtdv8+nT+IxB1xxtxI0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769793079; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AJenvCJazmZV7aLrwNioewd1iEwAewVY8c3Yt+ugTVQ=; 
	b=W/3BVdkaRtbrO37wv5Fj/7jxpNsFU3dkK9zYU+MYKuqgb1IW58+lSHJE1K2sBk+LwUXew3NnsuJtwTLGoWAENccDtlizABpsI9uysrca+cC4ddKHR8RUQeEOSrq3OK3bNUJLrdLi1uHAJWBpd3CcFzdqYTY+3+ZCAUdNKK4sv6w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769793079;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=AJenvCJazmZV7aLrwNioewd1iEwAewVY8c3Yt+ugTVQ=;
	b=qjlgHqavMKxj2Ay4mP2xlFlfs2UsDhE/iu3CNodcnH+lP2MXLmQdFSLyGOHVY92L
	YBX6W1rMEmN7cSLkr5b2b32L2uAAU7aRJWEewfkUD3IcwLs+NV1aG8EY9PGdJ3JSbG5
	zr5p5j0hz9T1Q0AEt2rXn/xhbi5UsPkMXVxOawdk=
Received: by mx.zohomail.com with SMTPS id 1769793078493919.2771358618674;
	Fri, 30 Jan 2026 09:11:18 -0800 (PST)
Date: Fri, 30 Jan 2026 17:11:12 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXzmMInsNSvFvBF1@anirudh-surface.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>
 <aXfStKqKiSSHEmXj@skinsburskii.localdomain>
 <aXo2X4mRioTa3sBl@anirudh-surface.localdomain>
 <aXqXkhhl1xuvjm3P@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXqXkhhl1xuvjm3P@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8605-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:dkim,anirudh-surface.localdomain:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C3A7BD03E
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 03:11:14PM -0800, Stanislav Kinsburskii wrote:
> On Wed, Jan 28, 2026 at 04:16:31PM +0000, Anirudh Rayabharam wrote:
> > On Mon, Jan 26, 2026 at 12:46:44PM -0800, Stanislav Kinsburskii wrote:
> > > On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> > > > On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > hypervisor deposited pages.
> > > > > 
> > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > management is implemented.
> > > > 
> > > > Someone might want to stop all guest VMs and do a kexec. Which is valid
> > > > and would work without any issue for L1VH.
> > > > 
> > > 
> > > No, it won't work and hypervsisor depostied pages won't be withdrawn.
> > 
> > All pages that were deposited in the context of a guest partition (i.e.
> > with the guest partition ID), would be withdrawn when you kill the VMs,
> > right? What other deposited pages would be left?
> > 
> 
> The driver deposits two types of pages: one for the guests (withdrawn
> upon gust shutdown) and the other - for the host itself (never
> withdrawn).
> See hv_call_create_partition, for example: it deposits pages for the
> host partition.

Hmm.. I see. Is it not possible to reclaim this memory in module_exit?
Also, can't we forcefully kill all running partitions in module_exit and
then reclaim memory? Would this help with kernel consistency
irrespective of userspace behavior?

Thanks,
Anirudh.

> 
> Thanks,
> Stanislav
> 
> > Thanks,
> > Anirudh.
> > 
> > > Also, kernel consisntency must no depend on use space behavior. 
> > > 
> > > > Also, I don't think it is reasonable at all that someone needs to
> > > > disable basic kernel functionality such as kexec in order to use our
> > > > driver.
> > > > 
> > > 
> > > It's a temporary measure until proper page lifecycle management is
> > > supported in the driver.
> > > Mutual exclusion of the driver and kexec is given and thus should be
> > > expclitily stated in the Kconfig.
> > > 
> > > Thanks,
> > > Stanislav
> > > 
> > > > Thanks,
> > > > Anirudh.
> > > > 
> > > > > 
> > > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > > ---
> > > > >  drivers/hv/Kconfig |    1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > > > --- a/drivers/hv/Kconfig
> > > > > +++ b/drivers/hv/Kconfig
> > > > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > > > >  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > > > >  	# no particular order, making it impossible to reassemble larger pages
> > > > >  	depends on PAGE_SIZE_4KB
> > > > > +	depends on !KEXEC
> > > > >  	select EVENTFD
> > > > >  	select VIRT_XFER_TO_GUEST_WORK
> > > > >  	select HMM_MIRROR
> > > > > 
> > > > > 

