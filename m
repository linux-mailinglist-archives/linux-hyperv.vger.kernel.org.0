Return-Path: <linux-hyperv+bounces-8681-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA1CCspPgmmBSAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8681-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 20:43:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F66CDE372
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 20:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 800BA300E3CF
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 19:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A0035F8AE;
	Tue,  3 Feb 2026 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mwKmoFvB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EA2BA21;
	Tue,  3 Feb 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770147782; cv=none; b=HCBgi1ZTGm3JGMczrkLvW04vWv1wPQhyyIBw42UWRV6QAnZxyG2vDYqusLBXRPSAWJpvPO38PAg/PDGCFo4dTS4mveHASmjbV61o0rnh6xj68vBLYTL9MQWUXStTduBGmdjNsd+TXTblIGASxU5FOUTLdSDwtn21TmXsViEmMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770147782; c=relaxed/simple;
	bh=2T7Ra8gSy2HJoY4l062LyYBT8sxItib4Lo4ifgGf2KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd8WqTBsafkCIlQ5ZacYILwI17PP0QVmOtKJhwcok3Pkqwet/v7ku7/ojZo113C8zuxMZcZblK5GJ1M/NCAeCBdXZlHRM4nltVu30nCBY9cbw1a/iaiK/xuCcfz5IknCpSGqSgQFpuPdob/3i1v/qrkz72ZLLM+pMpOIiYYnm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mwKmoFvB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2FF2320B7167;
	Tue,  3 Feb 2026 11:43:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2FF2320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770147780;
	bh=nDSFEAiFrQuqCr3V/2eq5OkQ/I+e5Wro2q+dAVbG6Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwKmoFvBrX92sPEVe2Nh5vxP3vVq7L6o3UlHQrhdk3hrtW5k+UvO1cZ4S6UQtILLd
	 /aRjjDy4d2mwB7g037EZy1LKQvsueAMPchrlFILNCflol9p2gmtmwbIphuv2z4bVef
	 GCC7Pe7ZNCTVb3DtgMN42CpdISg9CJd9H6lFGZts=
Date: Tue, 3 Feb 2026 11:42:58 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aYJPwp2i47P33xuz@skinsburskii.localdomain>
References: <aXqXkhhl1xuvjm3P@skinsburskii.localdomain>
 <aXzmMInsNSvFvBF1@anirudh-surface.localdomain>
 <aXz8ldAeoWwGIxdu@skinsburskii.localdomain>
 <aX0Vbfocwa4WgXUw@anirudh-surface.localdomain>
 <aYDaaIK0J4SjvnCe@skinsburskii.localdomain>
 <aYD0bafU3UYuSvDW@anirudh-surface.localdomain>
 <aYD4gw-1qKYHcnXI@skinsburskii.localdomain>
 <wnh3ghsxxml32sldkm4qzlzre7nebor3oqtj6i7mlhqj2gwzys@o5w5rpzrhhc4>
 <aYIW9PhzqmyET8IL@skinsburskii.localdomain>
 <aYImS_vEdR-kxBuQ@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYImS_vEdR-kxBuQ@anirudh-surface.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8681-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii.localdomain:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 9F66CDE372
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 04:46:03PM +0000, Anirudh Rayabharam wrote:
> On Tue, Feb 03, 2026 at 07:40:36AM -0800, Stanislav Kinsburskii wrote:
> > On Tue, Feb 03, 2026 at 10:34:28AM +0530, Anirudh Rayabharam wrote:
> > > On Mon, Feb 02, 2026 at 11:18:27AM -0800, Stanislav Kinsburskii wrote:
> > > > On Mon, Feb 02, 2026 at 07:01:01PM +0000, Anirudh Rayabharam wrote:
> > > > > On Mon, Feb 02, 2026 at 09:10:00AM -0800, Stanislav Kinsburskii wrote:
> > > > > > On Fri, Jan 30, 2026 at 08:32:45PM +0000, Anirudh Rayabharam wrote:
> > > > > > > On Fri, Jan 30, 2026 at 10:46:45AM -0800, Stanislav Kinsburskii wrote:
> > > > > > > > On Fri, Jan 30, 2026 at 05:11:12PM +0000, Anirudh Rayabharam wrote:
> > > > > > > > > On Wed, Jan 28, 2026 at 03:11:14PM -0800, Stanislav Kinsburskii wrote:
> > > > > > > > > > On Wed, Jan 28, 2026 at 04:16:31PM +0000, Anirudh Rayabharam wrote:
> > > > > > > > > > > On Mon, Jan 26, 2026 at 12:46:44PM -0800, Stanislav Kinsburskii wrote:
> > > > > > > > > > > > On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> > > > > > > > > > > > > On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > > > > > > > > > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > > > > > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > > > > > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > > > > > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > > > > > > > > > hypervisor deposited pages.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > > > > > > > > > management is implemented.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Someone might want to stop all guest VMs and do a kexec. Which is valid
> > > > > > > > > > > > > and would work without any issue for L1VH.
> > > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > No, it won't work and hypervsisor depostied pages won't be withdrawn.
> > > > > > > > > > > 
> > > > > > > > > > > All pages that were deposited in the context of a guest partition (i.e.
> > > > > > > > > > > with the guest partition ID), would be withdrawn when you kill the VMs,
> > > > > > > > > > > right? What other deposited pages would be left?
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > The driver deposits two types of pages: one for the guests (withdrawn
> > > > > > > > > > upon gust shutdown) and the other - for the host itself (never
> > > > > > > > > > withdrawn).
> > > > > > > > > > See hv_call_create_partition, for example: it deposits pages for the
> > > > > > > > > > host partition.
> > > > > > > > > 
> > > > > > > > > Hmm.. I see. Is it not possible to reclaim this memory in module_exit?
> > > > > > > > > Also, can't we forcefully kill all running partitions in module_exit and
> > > > > > > > > then reclaim memory? Would this help with kernel consistency
> > > > > > > > > irrespective of userspace behavior?
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > It would, but this is sloppy and cannot be a long-term solution.
> > > > > > > > 
> > > > > > > > It is also not reliable. We have no hook to prevent kexec. So if we fail
> > > > > > > > to kill the guest or reclaim the memory for any reason, the new kernel
> > > > > > > > may still crash.
> > > > > > > 
> > > > > > > Actually guests won't be running by the time we reach our module_exit
> > > > > > > function during a kexec. Userspace processes would've been killed by
> > > > > > > then.
> > > > > > > 
> > > > > > 
> > > > > > No, they will not: "kexec -e" doesn't kill user processes.
> > > > > > We must not rely on OS to do graceful shutdown before doing
> > > > > > kexec.
> > > > > 
> > > > > I see kexec -e is too brutal. Something like systemctl kexec is
> > > > > more graceful and is probably used more commonly. In this case at least
> > > > > we could register a reboot notifier and attempt to clean things up.
> > > > > 
> > > > > I think it is better to support kexec to this extent rather than
> > > > > disabling it entirely.
> > > > > 
> > > > 
> > > > You do understand that once our kernel is released to third parties, we
> > > > can’t control how they will use kexec, right?
> > > 
> > > Yes, we can't. But that's okay. It is fine for us to say that only some
> > > kexec scenarios are supported and some aren't (iff you're creating VMs
> > > using MSHV; if you're not creating VMs all of kexec is supported).
> > > 
> > 
> > Well, I disagree here. If we say the kernel supports MSHV, we must
> > provide a robust solution. A partially working solution is not
> > acceptable. It makes us look careless and can damage our reputation as a
> > team (and as a company).
> 
> It won't if we call out upfront what is supported and what is not.
> 
> > 
> > > > 
> > > > This is a valid and existing option. We have to account for it. Yet
> > > > again, L1VH will be used by arbitrary third parties out there, not just
> > > > by us.
> > > > 
> > > > We can’t say the kernel supports MSHV until we close these gaps. We must
> > > 
> > > We can. It is okay say some scenarios are supported and some aren't.
> > > 
> > > All kexecs are supported if they never create VMs using MSHV. If they do
> > > create VMs using MSHV and we implement cleanup in a reboot notifier at
> > > least systemctl kexec and crashdump kexec would which are probably the
> > > most common uses of kexec. It's okay to say that this is all we support
> > > as of now.
> > > 
> > 
> > I'm repeating myself, but I'll try to put it differently.
> > There won't be any kernel core collected if a page was deposited. You're
> > arguing for a lost cause here. Once a page is allocated and deposited,
> > the crash kernel will try to write it into the core.
> 
> That's why we have to implement something where we attempt to destroy
> partitions and reclaim memory (and BUG() out if that fails; which
> hopefully should happen very rarely if at all). This should be *the*
> solution we work towards. We don't need a temporary disable kexec
> solution.
> 

No, the solution is to preserve the shared state and pass it over via KHO.

> > 
> > > Also, what makes you think customers would even be interested in enabling
> > > our module in their kernel configs if it takes away kexec?
> > > 
> > 
> > It's simple: L1VH isn't a host, so I can spin up new VMs instead of
> > servicing the existing ones.
> 
> And what about the L2 VM state then? They might not be throwaway in all
> cases.
> 

L2 guest can (and likely will) be migrated fromt he old L1VH to the new
one.
And this is most likely the current scenario customers are using.

> > 
> > Why do you think there won’t be customers interested in using MSHV in
> > L1VH without kexec support?
> 
> Because they could already be using kexec for their servicing needs or
> whatever. And no we can't just say "don't service these VMs just spin up
> new ones".
> 

Are you speculating or know for sure?

> Also, keep in mind that once L1VH is available in Azure, the distros
> that run on it would be the same distros that run on all other Azure
> VMs. There won't be special distros with a kernel specifically built for
> L1VH. And KEXEC is generally enabled in distros. Distro vendors won't be
> happy that they would need to publish a separate version of their image with
> MSHV_ROOT enabled and KEXEC disabled because they wouldn't want KEXEC to
> be disabled for all Azure VMs. Also, the customers will be confused why
> the same distro doesn't work on L1VH.
> 

I don't think distro happiness is our concern. They already build custom
versions for Azure. They can build another custom version for L1VH if
needed.

Anyway, I don't see the point in continuing this discussion. All points
have been made, and solutions have been proposed.

If you can come up with something better in the next few days, so we at
least have a chance to get it merged in the next merge window, great. If
not, we should explicitly forbid the unsupported feature and move on.

Thanks,
Thanks,
Stanislav

> Thanks,
> Anirudh.

