Return-Path: <linux-hyperv+bounces-8620-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J9DL7cVfWnpQAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8620-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 21:33:59 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59384BE6FF
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 21:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A9FE304B807
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 20:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C1350A0B;
	Fri, 30 Jan 2026 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="VbMlwAUK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661C346777;
	Fri, 30 Jan 2026 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805186; cv=pass; b=Bojv0pBCjlJ6QfW+LHsIZGfx2aejrOHeBEpmHUDBqZzGxgJ+8js8U4auAq9m0NENDv9ntyPO3JgC35V0ktx0QjuaUB2WaUVhRYyL8vOlyCSxdlS/3mAPx4ZIlkpqeteAcb8SvtNHALOyN1gzMTd9oVvwt0wvYUQ0VFYqbh0KvxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805186; c=relaxed/simple;
	bh=VRVKc0G2xch7CjqnwzOccyZK3693OZYTPuvYIJfLfBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FItAPp4NGCwmsZaEEbeMfep4QkIfYAl4ju4l27Y9hMW0ULOhmsw1cT3RGxjdTgiBBWvHxGE9eUvkb4gzrLgu1kVjZLjk5UKnHo9EUNKIi7FVeDcy1mBQEaDmy1vw5z7Dc16pI23jDm/pHmT/qPyQM3KdiSuDlIjU1BYQjQnu9sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=VbMlwAUK; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769805173; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NNCi1nhFRZomjVKNvh06yLIRpYQ9NFMoGGk5uVBOlOojWSrEHcBTPXqzkUMnO8fHXIZ59SETY8CDRP6LzbsVSaCRT+irjifngyAY+eOroMQNrY9O9KAomXugPBtKVsbcQWrryg0BD5TV6mx93NEVyvuf6kY11g7Z31LVM4EDOZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769805173; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YZFps5ZfMd2sDPHizojRQ3g1pD+Ss1Y7VoRc0RzBwZo=; 
	b=TPc/g9aWi+eLdv7OTLWyRMAmHRh0EhT0VK1U6Xn5KZGzh870Ivu+3krI9/0lbuULEpbvhSxEQ97XI6fOYVPdJt3D61eofeJ9/0B7B10S2WFmrbWkDgFDqG1Nf84K16qOZOxVclMgUIotCrDP+Qw+sdVuQXxWJhxFAhpVIoppiko=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769805173;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=YZFps5ZfMd2sDPHizojRQ3g1pD+Ss1Y7VoRc0RzBwZo=;
	b=VbMlwAUK+TR73GZMzEwKoNOW4eEU6WLU3NKAxvkvnEymYDPdDFLNuwWWe3QGFVrh
	64qbnm0jpb+vm30Y+b0XfuFf5uRr4yWGBDnyK+GInJdrV8qT4XnX/n9JoFy3zFprvdr
	WG8j4HxRgUb0kteZ/F/t/yA5PyIgHaizmPnqUphY=
Received: by mx.zohomail.com with SMTPS id 176980517065989.46198847400456;
	Fri, 30 Jan 2026 12:32:50 -0800 (PST)
Date: Fri, 30 Jan 2026 20:32:45 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aX0Vbfocwa4WgXUw@anirudh-surface.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>
 <aXfStKqKiSSHEmXj@skinsburskii.localdomain>
 <aXo2X4mRioTa3sBl@anirudh-surface.localdomain>
 <aXqXkhhl1xuvjm3P@skinsburskii.localdomain>
 <aXzmMInsNSvFvBF1@anirudh-surface.localdomain>
 <aXz8ldAeoWwGIxdu@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXz8ldAeoWwGIxdu@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8620-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,anirudh-surface.localdomain:mid,anirudhrb.com:dkim]
X-Rspamd-Queue-Id: 59384BE6FF
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 10:46:45AM -0800, Stanislav Kinsburskii wrote:
> On Fri, Jan 30, 2026 at 05:11:12PM +0000, Anirudh Rayabharam wrote:
> > On Wed, Jan 28, 2026 at 03:11:14PM -0800, Stanislav Kinsburskii wrote:
> > > On Wed, Jan 28, 2026 at 04:16:31PM +0000, Anirudh Rayabharam wrote:
> > > > On Mon, Jan 26, 2026 at 12:46:44PM -0800, Stanislav Kinsburskii wrote:
> > > > > On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> > > > > > On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > > hypervisor deposited pages.
> > > > > > > 
> > > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > > management is implemented.
> > > > > > 
> > > > > > Someone might want to stop all guest VMs and do a kexec. Which is valid
> > > > > > and would work without any issue for L1VH.
> > > > > > 
> > > > > 
> > > > > No, it won't work and hypervsisor depostied pages won't be withdrawn.
> > > > 
> > > > All pages that were deposited in the context of a guest partition (i.e.
> > > > with the guest partition ID), would be withdrawn when you kill the VMs,
> > > > right? What other deposited pages would be left?
> > > > 
> > > 
> > > The driver deposits two types of pages: one for the guests (withdrawn
> > > upon gust shutdown) and the other - for the host itself (never
> > > withdrawn).
> > > See hv_call_create_partition, for example: it deposits pages for the
> > > host partition.
> > 
> > Hmm.. I see. Is it not possible to reclaim this memory in module_exit?
> > Also, can't we forcefully kill all running partitions in module_exit and
> > then reclaim memory? Would this help with kernel consistency
> > irrespective of userspace behavior?
> > 
> 
> It would, but this is sloppy and cannot be a long-term solution.
> 
> It is also not reliable. We have no hook to prevent kexec. So if we fail
> to kill the guest or reclaim the memory for any reason, the new kernel
> may still crash.

Actually guests won't be running by the time we reach our module_exit
function during a kexec. Userspace processes would've been killed by
then.

Also, why is this sloppy? Isn't this what module_exit should be
doing anyway? If someone unloads our module we should be trying to
clean everything up (including killing guests) and reclaim memory.

In any case, we can BUG() out if we fail to reclaim the memory. That would
stop the kexec.

This is a better solution since instead of disabling KEXEC outright: our
driver made the best possible efforts to make kexec work.

> 
> There are two long-term solutions:
>  1. Add a way to prevent kexec when there is shared state between the hypervisor and the kernel.

I honestly think we should focus efforts on making kexec work rather
than finding ways to prevent it.

Thanks,
Anirudh

>  2. Hand the shared kernel state over to the new kernel.
> 
> I sent a series for the first one. The second one is not ready yet.
> Anything else is neither robust nor reliable, so I don’t think it makes
> sense to pursue it.
> 
> Thanks,
> Stanislav
> 
> 
> > Thanks,
> > Anirudh.
> > 
> > > 
> > > Thanks,
> > > Stanislav
> > > 
> > > > Thanks,
> > > > Anirudh.
> > > > 
> > > > > Also, kernel consisntency must no depend on use space behavior. 
> > > > > 
> > > > > > Also, I don't think it is reasonable at all that someone needs to
> > > > > > disable basic kernel functionality such as kexec in order to use our
> > > > > > driver.
> > > > > > 
> > > > > 
> > > > > It's a temporary measure until proper page lifecycle management is
> > > > > supported in the driver.
> > > > > Mutual exclusion of the driver and kexec is given and thus should be
> > > > > expclitily stated in the Kconfig.
> > > > > 
> > > > > Thanks,
> > > > > Stanislav
> > > > > 
> > > > > > Thanks,
> > > > > > Anirudh.
> > > > > > 
> > > > > > > 
> > > > > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > > > > ---
> > > > > > >  drivers/hv/Kconfig |    1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > > > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > > > > > --- a/drivers/hv/Kconfig
> > > > > > > +++ b/drivers/hv/Kconfig
> > > > > > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > > > > > >  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > > > > > >  	# no particular order, making it impossible to reassemble larger pages
> > > > > > >  	depends on PAGE_SIZE_4KB
> > > > > > > +	depends on !KEXEC
> > > > > > >  	select EVENTFD
> > > > > > >  	select VIRT_XFER_TO_GUEST_WORK
> > > > > > >  	select HMM_MIRROR
> > > > > > > 
> > > > > > > 

