Return-Path: <linux-hyperv+bounces-8658-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAlCOYb0gGkgDQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8658-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 20:01:26 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A77D05F7
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 20:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4143E302C376
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 19:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6794964F;
	Mon,  2 Feb 2026 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="l2QiAFbC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6D93A1D2;
	Mon,  2 Feb 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058883; cv=pass; b=TidCg8GOvprwm6aiLJ1e4hefMJ2RylutmF9npFxoPYzohG//RIyfctWp0qSVyMsT6N9XAR36q96bGMAi37Ez4sB11WqaKNmdW78USNvglRQFBsf8unQB6/1wQn1ZzGCBAUk2+sF0DOIUAHbx3kZkvRJGlDc1EhZccgcVtg6cj+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058883; c=relaxed/simple;
	bh=O1Uny3kK7GK3u78vosBKKU8T56Cm0HtbKRINT1zWCiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zxy21pAhzOMgxAYx3w1smVJ6Sw/RZLfsH2CYxnzUcPr3AvmWrre5l7dqKFl/BT96k9hMDCsvRL+i6wKUpwneo2XB5v3nqJvybZVJUYyGfIsVHlpPBbYewSg/HztMUPvVkbGjOf3uP/YeIVFPfYpTMGJMVIvDTl4/lwtFwl74p5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=l2QiAFbC; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770058869; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZPYdiRxGsKm9rZ8onqNko1J+cRcAxhM1GvmijEX/xz6v6zZODEftpMaeDpb70KdhTrfjoU5D4t+k/s5HAFXkugInyS5KQTe7z9+y48jMwOKFSFB76/93f0mE3qNotzr7T+KnxAeuqbNjB9h9igQ2uwjG+6GcI66cvP6DpAq4qlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770058869; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZzAmkQNQk3KsoRt7JL5Tfq1tVe7+I+Ec5oVk3KAmbP8=; 
	b=GIwqkty04syh+HKyB1Mks5WkDE7zxzLiwi9u4SeCFZb91SQqVFaaWKpQyW7T59q+CSJQ/Crsz0gIrfyLd4cBXtrt0ydLfQSRWVu2e8tV36SPHhy862caEynpYzjkg11YK4PTkcaJ4+Tf1ixseWjdtVGeMbj1q9XJv2jTd76UymM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770058869;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ZzAmkQNQk3KsoRt7JL5Tfq1tVe7+I+Ec5oVk3KAmbP8=;
	b=l2QiAFbCb+HY4QVfzhuY/RpExDvtKj0NnfkaK5Fg+a1Wj26422MvNqtjIOYV5zhx
	BS28ldLV2JaD+iU0CZJD6cAzLEpEyH9hOFiNW9Q/D6fsXY/rOoMSqce7ZOhpnGc9mmL
	dzLYxxFHtBbHCKDrIbkzSf5SiTn4cgzzPQQ3ulTY=
Received: by mx.zohomail.com with SMTPS id 1770058867491934.0626709421043;
	Mon, 2 Feb 2026 11:01:07 -0800 (PST)
Date: Mon, 2 Feb 2026 19:01:01 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aYD0bafU3UYuSvDW@anirudh-surface.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>
 <aXfStKqKiSSHEmXj@skinsburskii.localdomain>
 <aXo2X4mRioTa3sBl@anirudh-surface.localdomain>
 <aXqXkhhl1xuvjm3P@skinsburskii.localdomain>
 <aXzmMInsNSvFvBF1@anirudh-surface.localdomain>
 <aXz8ldAeoWwGIxdu@skinsburskii.localdomain>
 <aX0Vbfocwa4WgXUw@anirudh-surface.localdomain>
 <aYDaaIK0J4SjvnCe@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDaaIK0J4SjvnCe@skinsburskii.localdomain>
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
	TAGGED_FROM(0.00)[bounces-8658-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61A77D05F7
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 09:10:00AM -0800, Stanislav Kinsburskii wrote:
> On Fri, Jan 30, 2026 at 08:32:45PM +0000, Anirudh Rayabharam wrote:
> > On Fri, Jan 30, 2026 at 10:46:45AM -0800, Stanislav Kinsburskii wrote:
> > > On Fri, Jan 30, 2026 at 05:11:12PM +0000, Anirudh Rayabharam wrote:
> > > > On Wed, Jan 28, 2026 at 03:11:14PM -0800, Stanislav Kinsburskii wrote:
> > > > > On Wed, Jan 28, 2026 at 04:16:31PM +0000, Anirudh Rayabharam wrote:
> > > > > > On Mon, Jan 26, 2026 at 12:46:44PM -0800, Stanislav Kinsburskii wrote:
> > > > > > > On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> > > > > > > > On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > > > > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > > > > hypervisor deposited pages.
> > > > > > > > > 
> > > > > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > > > > management is implemented.
> > > > > > > > 
> > > > > > > > Someone might want to stop all guest VMs and do a kexec. Which is valid
> > > > > > > > and would work without any issue for L1VH.
> > > > > > > > 
> > > > > > > 
> > > > > > > No, it won't work and hypervsisor depostied pages won't be withdrawn.
> > > > > > 
> > > > > > All pages that were deposited in the context of a guest partition (i.e.
> > > > > > with the guest partition ID), would be withdrawn when you kill the VMs,
> > > > > > right? What other deposited pages would be left?
> > > > > > 
> > > > > 
> > > > > The driver deposits two types of pages: one for the guests (withdrawn
> > > > > upon gust shutdown) and the other - for the host itself (never
> > > > > withdrawn).
> > > > > See hv_call_create_partition, for example: it deposits pages for the
> > > > > host partition.
> > > > 
> > > > Hmm.. I see. Is it not possible to reclaim this memory in module_exit?
> > > > Also, can't we forcefully kill all running partitions in module_exit and
> > > > then reclaim memory? Would this help with kernel consistency
> > > > irrespective of userspace behavior?
> > > > 
> > > 
> > > It would, but this is sloppy and cannot be a long-term solution.
> > > 
> > > It is also not reliable. We have no hook to prevent kexec. So if we fail
> > > to kill the guest or reclaim the memory for any reason, the new kernel
> > > may still crash.
> > 
> > Actually guests won't be running by the time we reach our module_exit
> > function during a kexec. Userspace processes would've been killed by
> > then.
> > 
> 
> No, they will not: "kexec -e" doesn't kill user processes.
> We must not rely on OS to do graceful shutdown before doing
> kexec.

I see kexec -e is too brutal. Something like systemctl kexec is
more graceful and is probably used more commonly. In this case at least
we could register a reboot notifier and attempt to clean things up.

I think it is better to support kexec to this extent rather than
disabling it entirely.

> 
> > Also, why is this sloppy? Isn't this what module_exit should be
> > doing anyway? If someone unloads our module we should be trying to
> > clean everything up (including killing guests) and reclaim memory.
> > 
> 
> Kexec does not unload modules, but it doesn't really matter even if it
> would.
> There are other means to plug into the reboot flow, but neither of them
> is robust or reliable.
> 
> > In any case, we can BUG() out if we fail to reclaim the memory. That would
> > stop the kexec.
> > 
> 
> By killing the whole system? This is not a good user experience and I
> don't see how can this be justified.

It is justified because, as you said, once we reach that failure we can
no longer guarantee integrity. So BUG() makes sense. This BUG() would
cause the system to go for a full reboot and restore integrity.

> 
> > This is a better solution since instead of disabling KEXEC outright: our
> > driver made the best possible efforts to make kexec work.
> > 
> 
> How an unrealiable feature leading to potential system crashes is better
> that disabling kexec outright?

Because there are ways of using the feature reliably. What if someone
has MSHV_ROOT enabled but never start a VM? (Just because someone has our
driver enabled in the kernel doesn't mean they're using it.) What about crash
dump?

It is far better to support some of these scenarios and be unreliable in
some corner cases rather than disabling the feature completely.

Also, I'm curious if any other driver in the kernel has ever done this
(force disable KEXEC).

> 
> It's a complete opposite story for me: the latter provides a limited,
> but robust functionality, while the former provides an unreliable and
> unpredictable behavior.
> 
> > > 
> > > There are two long-term solutions:
> > >  1. Add a way to prevent kexec when there is shared state between the hypervisor and the kernel.
> > 
> > I honestly think we should focus efforts on making kexec work rather
> > than finding ways to prevent it.
> > 
> 
> There is no argument about it. But until we have it fixed properly, we
> have two options: either disable kexec or stop claiming we have our
> driver up and ready for external customers. Giving the importance of
> this driver for current projects, I believe the better way would be to
> explicitly limit the functionality instead of postponing the
> productization of the driver.

It is okay to claim our driver as ready even if it doesn't support all
kexec cases. If we can support the common cases such as crash dump and
maybe kexec based servicing (pretty sure people do systemctl kexec and
not kexec -e for this with proper teardown) we can claim that our driver
is ready for general use.

Thanks,
Anirudh.


