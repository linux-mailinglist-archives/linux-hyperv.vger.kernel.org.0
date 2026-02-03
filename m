Return-Path: <linux-hyperv+bounces-8674-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOlvLaMXgmmZPAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8674-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 16:43:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20852DB6D7
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 16:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 379AF3023DCF
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A353B8D42;
	Tue,  3 Feb 2026 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HVvrgrTb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8D37E310;
	Tue,  3 Feb 2026 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133246; cv=none; b=PpJS/0JctVwA+flcc5uOvYfnoTbUEfvpcAluJPxr9SSs3lIZ8mmTaTOTWPjN7sc0nqrvzA/u5gFMgD1PHhAcJnNAqHmCISK3tsYu1J736397uBpjH0kQpaPfF613wHuCCPBDdAOsMUt8rnAoyqqksS/Ul8ZsxQEgQ6nDPI9/Mjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133246; c=relaxed/simple;
	bh=Fq8eYorfFr8ZVIgBj3A44fWCAbF9CrOlv8fGfvuiogk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2XOeZtqqrjyucXWpuOKL795zl5PyBljed8bGkc7YoXnfDwoXiXKFnX0u8EkpLERtpU3FjTjxbmzmGYOUlbL2YYlFNorJ73PlNB2ZaHZknLkSdXdPM0VXZ8pC55YbXgkZkt+Un/+fWpaI7FUd8B/KeogGjO/Bn9duiZCy0af3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HVvrgrTb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 83B0220B7167;
	Tue,  3 Feb 2026 07:40:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83B0220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770133238;
	bh=Jkuwk6BsHAJY1/gKIdZz/zfcbs79s36byN1wIARDCos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVvrgrTbwEvMmB8uxZ8vwcYfTKQ/4sy5fJo3ma23HMGPaBFyw6k3iP5v+bmiZMolx
	 1/rWQWh8QIIfob7Td2gZd9D5ThVJ4afXnzYcuw6Yfy7IH1W9L6T0DcpcYqg926BkAJ
	 soQOUv8x3lZfyJ2RhLtfMNRlhOyXppieo90VxyDM=
Date: Tue, 3 Feb 2026 07:40:36 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aYIW9PhzqmyET8IL@skinsburskii.localdomain>
References: <aXfStKqKiSSHEmXj@skinsburskii.localdomain>
 <aXo2X4mRioTa3sBl@anirudh-surface.localdomain>
 <aXqXkhhl1xuvjm3P@skinsburskii.localdomain>
 <aXzmMInsNSvFvBF1@anirudh-surface.localdomain>
 <aXz8ldAeoWwGIxdu@skinsburskii.localdomain>
 <aX0Vbfocwa4WgXUw@anirudh-surface.localdomain>
 <aYDaaIK0J4SjvnCe@skinsburskii.localdomain>
 <aYD0bafU3UYuSvDW@anirudh-surface.localdomain>
 <aYD4gw-1qKYHcnXI@skinsburskii.localdomain>
 <wnh3ghsxxml32sldkm4qzlzre7nebor3oqtj6i7mlhqj2gwzys@o5w5rpzrhhc4>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wnh3ghsxxml32sldkm4qzlzre7nebor3oqtj6i7mlhqj2gwzys@o5w5rpzrhhc4>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8674-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 20852DB6D7
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:34:28AM +0530, Anirudh Rayabharam wrote:
> On Mon, Feb 02, 2026 at 11:18:27AM -0800, Stanislav Kinsburskii wrote:
> > On Mon, Feb 02, 2026 at 07:01:01PM +0000, Anirudh Rayabharam wrote:
> > > On Mon, Feb 02, 2026 at 09:10:00AM -0800, Stanislav Kinsburskii wrote:
> > > > On Fri, Jan 30, 2026 at 08:32:45PM +0000, Anirudh Rayabharam wrote:
> > > > > On Fri, Jan 30, 2026 at 10:46:45AM -0800, Stanislav Kinsburskii wrote:
> > > > > > On Fri, Jan 30, 2026 at 05:11:12PM +0000, Anirudh Rayabharam wrote:
> > > > > > > On Wed, Jan 28, 2026 at 03:11:14PM -0800, Stanislav Kinsburskii wrote:
> > > > > > > > On Wed, Jan 28, 2026 at 04:16:31PM +0000, Anirudh Rayabharam wrote:
> > > > > > > > > On Mon, Jan 26, 2026 at 12:46:44PM -0800, Stanislav Kinsburskii wrote:
> > > > > > > > > > On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> > > > > > > > > > > On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > > > > > > > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > > > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > > > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > > > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > > > > > > > hypervisor deposited pages.
> > > > > > > > > > > > 
> > > > > > > > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > > > > > > > management is implemented.
> > > > > > > > > > > 
> > > > > > > > > > > Someone might want to stop all guest VMs and do a kexec. Which is valid
> > > > > > > > > > > and would work without any issue for L1VH.
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > No, it won't work and hypervsisor depostied pages won't be withdrawn.
> > > > > > > > > 
> > > > > > > > > All pages that were deposited in the context of a guest partition (i.e.
> > > > > > > > > with the guest partition ID), would be withdrawn when you kill the VMs,
> > > > > > > > > right? What other deposited pages would be left?
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > The driver deposits two types of pages: one for the guests (withdrawn
> > > > > > > > upon gust shutdown) and the other - for the host itself (never
> > > > > > > > withdrawn).
> > > > > > > > See hv_call_create_partition, for example: it deposits pages for the
> > > > > > > > host partition.
> > > > > > > 
> > > > > > > Hmm.. I see. Is it not possible to reclaim this memory in module_exit?
> > > > > > > Also, can't we forcefully kill all running partitions in module_exit and
> > > > > > > then reclaim memory? Would this help with kernel consistency
> > > > > > > irrespective of userspace behavior?
> > > > > > > 
> > > > > > 
> > > > > > It would, but this is sloppy and cannot be a long-term solution.
> > > > > > 
> > > > > > It is also not reliable. We have no hook to prevent kexec. So if we fail
> > > > > > to kill the guest or reclaim the memory for any reason, the new kernel
> > > > > > may still crash.
> > > > > 
> > > > > Actually guests won't be running by the time we reach our module_exit
> > > > > function during a kexec. Userspace processes would've been killed by
> > > > > then.
> > > > > 
> > > > 
> > > > No, they will not: "kexec -e" doesn't kill user processes.
> > > > We must not rely on OS to do graceful shutdown before doing
> > > > kexec.
> > > 
> > > I see kexec -e is too brutal. Something like systemctl kexec is
> > > more graceful and is probably used more commonly. In this case at least
> > > we could register a reboot notifier and attempt to clean things up.
> > > 
> > > I think it is better to support kexec to this extent rather than
> > > disabling it entirely.
> > > 
> > 
> > You do understand that once our kernel is released to third parties, we
> > can’t control how they will use kexec, right?
> 
> Yes, we can't. But that's okay. It is fine for us to say that only some
> kexec scenarios are supported and some aren't (iff you're creating VMs
> using MSHV; if you're not creating VMs all of kexec is supported).
> 

Well, I disagree here. If we say the kernel supports MSHV, we must
provide a robust solution. A partially working solution is not
acceptable. It makes us look careless and can damage our reputation as a
team (and as a company).

> > 
> > This is a valid and existing option. We have to account for it. Yet
> > again, L1VH will be used by arbitrary third parties out there, not just
> > by us.
> > 
> > We can’t say the kernel supports MSHV until we close these gaps. We must
> 
> We can. It is okay say some scenarios are supported and some aren't.
> 
> All kexecs are supported if they never create VMs using MSHV. If they do
> create VMs using MSHV and we implement cleanup in a reboot notifier at
> least systemctl kexec and crashdump kexec would which are probably the
> most common uses of kexec. It's okay to say that this is all we support
> as of now.
> 

I'm repeating myself, but I'll try to put it differently.
There won't be any kernel core collected if a page was deposited. You're
arguing for a lost cause here. Once a page is allocated and deposited,
the crash kernel will try to write it into the core.

> Also, what makes you think customers would even be interested in enabling
> our module in their kernel configs if it takes away kexec?
> 

It's simple: L1VH isn't a host, so I can spin up new VMs instead of
servicing the existing ones.

Why do you think there won’t be customers interested in using MSHV in
L1VH without kexec support?

Thanks,
Stanislav

> Thanks,
> Anirudh.
> 
> > not depend on user space to keep the kernel safe.
> > 
> > Do you agree?
> > 
> > Thanks,
> > Stanislav
> > 
> > > > 
> > > > > Also, why is this sloppy? Isn't this what module_exit should be
> > > > > doing anyway? If someone unloads our module we should be trying to
> > > > > clean everything up (including killing guests) and reclaim memory.
> > > > > 
> > > > 
> > > > Kexec does not unload modules, but it doesn't really matter even if it
> > > > would.
> > > > There are other means to plug into the reboot flow, but neither of them
> > > > is robust or reliable.
> > > > 
> > > > > In any case, we can BUG() out if we fail to reclaim the memory. That would
> > > > > stop the kexec.
> > > > > 
> > > > 
> > > > By killing the whole system? This is not a good user experience and I
> > > > don't see how can this be justified.
> > > 
> > > It is justified because, as you said, once we reach that failure we can
> > > no longer guarantee integrity. So BUG() makes sense. This BUG() would
> > > cause the system to go for a full reboot and restore integrity.
> > > 
> > > > 
> > > > > This is a better solution since instead of disabling KEXEC outright: our
> > > > > driver made the best possible efforts to make kexec work.
> > > > > 
> > > > 
> > > > How an unrealiable feature leading to potential system crashes is better
> > > > that disabling kexec outright?
> > > 
> > > Because there are ways of using the feature reliably. What if someone
> > > has MSHV_ROOT enabled but never start a VM? (Just because someone has our
> > > driver enabled in the kernel doesn't mean they're using it.) What about crash
> > > dump?
> > > 
> > > It is far better to support some of these scenarios and be unreliable in
> > > some corner cases rather than disabling the feature completely.
> > > 
> > > Also, I'm curious if any other driver in the kernel has ever done this
> > > (force disable KEXEC).
> > > 
> > > > 
> > > > It's a complete opposite story for me: the latter provides a limited,
> > > > but robust functionality, while the former provides an unreliable and
> > > > unpredictable behavior.
> > > > 
> > > > > > 
> > > > > > There are two long-term solutions:
> > > > > >  1. Add a way to prevent kexec when there is shared state between the hypervisor and the kernel.
> > > > > 
> > > > > I honestly think we should focus efforts on making kexec work rather
> > > > > than finding ways to prevent it.
> > > > > 
> > > > 
> > > > There is no argument about it. But until we have it fixed properly, we
> > > > have two options: either disable kexec or stop claiming we have our
> > > > driver up and ready for external customers. Giving the importance of
> > > > this driver for current projects, I believe the better way would be to
> > > > explicitly limit the functionality instead of postponing the
> > > > productization of the driver.
> > > 
> > > It is okay to claim our driver as ready even if it doesn't support all
> > > kexec cases. If we can support the common cases such as crash dump and
> > > maybe kexec based servicing (pretty sure people do systemctl kexec and
> > > not kexec -e for this with proper teardown) we can claim that our driver
> > > is ready for general use.
> > > 
> > > Thanks,
> > > Anirudh.

