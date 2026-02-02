Return-Path: <linux-hyperv+bounces-8644-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF3COPvbgGnMBwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8644-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 18:16:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E116CF74D
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 18:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B9E4300939B
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBC037F8AB;
	Mon,  2 Feb 2026 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lfxiV4Vn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D52E239086;
	Mon,  2 Feb 2026 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052203; cv=none; b=at8AShCRycDutJ0MNTjhreR3Cxx6Rjxqqr2Rm0qZI4RldlS/tFUYlj8YhnElJul9DTB0WJefxnZjyDYeDS/+VDIhHEmveTygNlFmF0hmBLBRIn8LCaYq1FBNI1gvAGbO821WFeNkcvRiudZWEOWMw1EGjSkW0wvn6eeQbA7rUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052203; c=relaxed/simple;
	bh=KoXL8os2RpU0w+okEwKWKEOaHj081bpoETa6CawEdzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUK68zd2nxo4B8t5O0gQa9ip/1hH35gzfGpDOJH8K3VCpRqKXFWjq6ipyYxKMk6LbDrw1RFAeRsBvRURFV5OmRLTZd+LGyIHROTQ2fD+LT40iSgahnbaRteWYHYM19DWChBDEPuStS8jA46u+pGMc9G1ggGaBo0Kh4gTea+wMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lfxiV4Vn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id C065420B7168;
	Mon,  2 Feb 2026 09:10:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C065420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770052202;
	bh=2WQ261SmUGZ3qKnZF4rDRNZu+xfQZMePgeC+hd5gls4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfxiV4VnHlL+YqjsH/Yym0pMsf8tktWjHuCwcy2qVrhSSXAzYGZ9ikBWq954bD7dY
	 9VOn1qbJR2fJUYrAVZ2fBAlbilBpJinw0Prqd4Gr0WBcOhzMHlxzvRwrZy5xDe61Q/
	 DSdFCccMO5CFdKd7Sa8cRbSq9mQTaxPwgUlxtED8=
Date: Mon, 2 Feb 2026 09:10:00 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aYDaaIK0J4SjvnCe@skinsburskii.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>
 <aXfStKqKiSSHEmXj@skinsburskii.localdomain>
 <aXo2X4mRioTa3sBl@anirudh-surface.localdomain>
 <aXqXkhhl1xuvjm3P@skinsburskii.localdomain>
 <aXzmMInsNSvFvBF1@anirudh-surface.localdomain>
 <aXz8ldAeoWwGIxdu@skinsburskii.localdomain>
 <aX0Vbfocwa4WgXUw@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aX0Vbfocwa4WgXUw@anirudh-surface.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8644-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 0E116CF74D
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 08:32:45PM +0000, Anirudh Rayabharam wrote:
> On Fri, Jan 30, 2026 at 10:46:45AM -0800, Stanislav Kinsburskii wrote:
> > On Fri, Jan 30, 2026 at 05:11:12PM +0000, Anirudh Rayabharam wrote:
> > > On Wed, Jan 28, 2026 at 03:11:14PM -0800, Stanislav Kinsburskii wrote:
> > > > On Wed, Jan 28, 2026 at 04:16:31PM +0000, Anirudh Rayabharam wrote:
> > > > > On Mon, Jan 26, 2026 at 12:46:44PM -0800, Stanislav Kinsburskii wrote:
> > > > > > On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> > > > > > > On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > > > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > > > hypervisor deposited pages.
> > > > > > > > 
> > > > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > > > management is implemented.
> > > > > > > 
> > > > > > > Someone might want to stop all guest VMs and do a kexec. Which is valid
> > > > > > > and would work without any issue for L1VH.
> > > > > > > 
> > > > > > 
> > > > > > No, it won't work and hypervsisor depostied pages won't be withdrawn.
> > > > > 
> > > > > All pages that were deposited in the context of a guest partition (i.e.
> > > > > with the guest partition ID), would be withdrawn when you kill the VMs,
> > > > > right? What other deposited pages would be left?
> > > > > 
> > > > 
> > > > The driver deposits two types of pages: one for the guests (withdrawn
> > > > upon gust shutdown) and the other - for the host itself (never
> > > > withdrawn).
> > > > See hv_call_create_partition, for example: it deposits pages for the
> > > > host partition.
> > > 
> > > Hmm.. I see. Is it not possible to reclaim this memory in module_exit?
> > > Also, can't we forcefully kill all running partitions in module_exit and
> > > then reclaim memory? Would this help with kernel consistency
> > > irrespective of userspace behavior?
> > > 
> > 
> > It would, but this is sloppy and cannot be a long-term solution.
> > 
> > It is also not reliable. We have no hook to prevent kexec. So if we fail
> > to kill the guest or reclaim the memory for any reason, the new kernel
> > may still crash.
> 
> Actually guests won't be running by the time we reach our module_exit
> function during a kexec. Userspace processes would've been killed by
> then.
> 

No, they will not: "kexec -e" doesn't kill user processes.
We must not rely on OS to do graceful shutdown before doing
kexec.

> Also, why is this sloppy? Isn't this what module_exit should be
> doing anyway? If someone unloads our module we should be trying to
> clean everything up (including killing guests) and reclaim memory.
> 

Kexec does not unload modules, but it doesn't really matter even if it
would.
There are other means to plug into the reboot flow, but neither of them
is robust or reliable.

> In any case, we can BUG() out if we fail to reclaim the memory. That would
> stop the kexec.
> 

By killing the whole system? This is not a good user experience and I
don't see how can this be justified.

> This is a better solution since instead of disabling KEXEC outright: our
> driver made the best possible efforts to make kexec work.
> 

How an unrealiable feature leading to potential system crashes is better
that disabling kexec outright?

It's a complete opposite story for me: the latter provides a limited,
but robust functionality, while the former provides an unreliable and
unpredictable behavior.

> > 
> > There are two long-term solutions:
> >  1. Add a way to prevent kexec when there is shared state between the hypervisor and the kernel.
> 
> I honestly think we should focus efforts on making kexec work rather
> than finding ways to prevent it.
> 

There is no argument about it. But until we have it fixed properly, we
have two options: either disable kexec or stop claiming we have our
driver up and ready for external customers. Giving the importance of
this driver for current projects, I believe the better way would be to
explicitly limit the functionality instead of postponing the
productization of the driver.

In other words, this is not about our fillings about kexec support: it's
about what we can reliably provide to our customers today.

Thanks,
Stanislav

> Thanks,
> Anirudh
> 
> >  2. Hand the shared kernel state over to the new kernel.
> > 
> > I sent a series for the first one. The second one is not ready yet.
> > Anything else is neither robust nor reliable, so I don’t think it makes
> > sense to pursue it.
> > 
> > Thanks,
> > Stanislav
> > 
> > 
> > > Thanks,
> > > Anirudh.
> > > 
> > > > 
> > > > Thanks,
> > > > Stanislav
> > > > 
> > > > > Thanks,
> > > > > Anirudh.
> > > > > 
> > > > > > Also, kernel consisntency must no depend on use space behavior. 
> > > > > > 
> > > > > > > Also, I don't think it is reasonable at all that someone needs to
> > > > > > > disable basic kernel functionality such as kexec in order to use our
> > > > > > > driver.
> > > > > > > 
> > > > > > 
> > > > > > It's a temporary measure until proper page lifecycle management is
> > > > > > supported in the driver.
> > > > > > Mutual exclusion of the driver and kexec is given and thus should be
> > > > > > expclitily stated in the Kconfig.
> > > > > > 
> > > > > > Thanks,
> > > > > > Stanislav
> > > > > > 
> > > > > > > Thanks,
> > > > > > > Anirudh.
> > > > > > > 
> > > > > > > > 
> > > > > > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > > > > > ---
> > > > > > > >  drivers/hv/Kconfig |    1 +
> > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > > > > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > > > > > > --- a/drivers/hv/Kconfig
> > > > > > > > +++ b/drivers/hv/Kconfig
> > > > > > > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > > > > > > >  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > > > > > > >  	# no particular order, making it impossible to reassemble larger pages
> > > > > > > >  	depends on PAGE_SIZE_4KB
> > > > > > > > +	depends on !KEXEC
> > > > > > > >  	select EVENTFD
> > > > > > > >  	select VIRT_XFER_TO_GUEST_WORK
> > > > > > > >  	select HMM_MIRROR
> > > > > > > > 
> > > > > > > > 

