Return-Path: <linux-hyperv+bounces-8677-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP4QHSYngmnPPgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8677-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 17:49:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF6DC404
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 17:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C31623009F80
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2C3395D99;
	Tue,  3 Feb 2026 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="bRbszMbH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9122B594;
	Tue,  3 Feb 2026 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137182; cv=pass; b=AEHzkWygbMq5dJ3NY8u+/0fYhg3Uoj49857RNKgxfWwP/+U+O8ubeNjC7+eWuvjtfE/F0bveqhP7sGmvephXvrJYyjGS+6UqVTBsPbZKf6dna2BKpbkIbOvba5m6qQAlbjQKGrk4P2OhrtCw2zd4YqWuA6O6akbcjGvrbdgzdng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137182; c=relaxed/simple;
	bh=zpxZFKtU4GxlcwUS+nneoyJMCd8bO4BIp53jq+NaSJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFhUHABvDzbxmhYbcXIzpnnHEcbzsTcbppLheRTd+IRRSBIgqVrDYGfm8MTtmBbemQmtjVoFzEID9ZrnQF3/C5vk8SaJvL4qpwwBfT6SbKD3xIualk14B7wNekd/QRurg8tXGHjZlKEVCOiKSq8WnmFe7s0Q1aIOKZOM5kUpci4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=bRbszMbH; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770137173; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UMhNasAwLrhKzVGam/kQASn0MO58kIi/HN5WuKafDFGNF3uOebaq11yJRjgHjohLLz1aeQP7XjXUx8mPf3h+pt1wIstMeP+p8mMr9WtkoX6jh6NWVHoHxYkaIkOAHVHW9olDZ5y+sdtH1wch3t653CzbFc31HGvlphcFCj/cG3Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770137173; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qkw9I6H9px+JnVKyQSF54oHTU77qyqPQHH/Rf4EgTzc=; 
	b=bnJIivb7sPXQMICcsFzZo7Pos7ZRhjWLOfy6WiReLPNuwnc0xkMkixgDGQDIWvCoHpjRjQ7GOYIf6FUkMqaaHFYxUHkxJNaOqAlRiWS7JqB0i3gE22MnwmK75daWHIjcWs30EFJcXnG52FCcPElraPdhpAmnAMG8Xi1yeC7TcGs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770137173;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=Qkw9I6H9px+JnVKyQSF54oHTU77qyqPQHH/Rf4EgTzc=;
	b=bRbszMbHfZ2cG5ZI9zC175YYHJb+CqsKIbrv6vX8cepkHxEANmIpHauQlJX+haYL
	37fv5G/SyaYsAcUELH+LWr6PBclAN0X7NkYfX5a1NjDYY2ZBM4WrElevoNQv4w2qI0R
	6Dteiv56z+AF1w+r4L5zVQfr3Ig9z+cWX6brOmx8=
Received: by mx.zohomail.com with SMTPS id 1770137170034635.2530779877314;
	Tue, 3 Feb 2026 08:46:10 -0800 (PST)
Date: Tue, 3 Feb 2026 16:46:03 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aYImS_vEdR-kxBuQ@anirudh-surface.localdomain>
References: <aXo2X4mRioTa3sBl@anirudh-surface.localdomain>
 <aXqXkhhl1xuvjm3P@skinsburskii.localdomain>
 <aXzmMInsNSvFvBF1@anirudh-surface.localdomain>
 <aXz8ldAeoWwGIxdu@skinsburskii.localdomain>
 <aX0Vbfocwa4WgXUw@anirudh-surface.localdomain>
 <aYDaaIK0J4SjvnCe@skinsburskii.localdomain>
 <aYD0bafU3UYuSvDW@anirudh-surface.localdomain>
 <aYD4gw-1qKYHcnXI@skinsburskii.localdomain>
 <wnh3ghsxxml32sldkm4qzlzre7nebor3oqtj6i7mlhqj2gwzys@o5w5rpzrhhc4>
 <aYIW9PhzqmyET8IL@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYIW9PhzqmyET8IL@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8677-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[anirudhrb.com:+]
X-Rspamd-Queue-Id: ECBF6DC404
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 07:40:36AM -0800, Stanislav Kinsburskii wrote:
> On Tue, Feb 03, 2026 at 10:34:28AM +0530, Anirudh Rayabharam wrote:
> > On Mon, Feb 02, 2026 at 11:18:27AM -0800, Stanislav Kinsburskii wrote:
> > > On Mon, Feb 02, 2026 at 07:01:01PM +0000, Anirudh Rayabharam wrote:
> > > > On Mon, Feb 02, 2026 at 09:10:00AM -0800, Stanislav Kinsburskii wrote:
> > > > > On Fri, Jan 30, 2026 at 08:32:45PM +0000, Anirudh Rayabharam wrote:
> > > > > > On Fri, Jan 30, 2026 at 10:46:45AM -0800, Stanislav Kinsburskii wrote:
> > > > > > > On Fri, Jan 30, 2026 at 05:11:12PM +0000, Anirudh Rayabharam wrote:
> > > > > > > > On Wed, Jan 28, 2026 at 03:11:14PM -0800, Stanislav Kinsburskii wrote:
> > > > > > > > > On Wed, Jan 28, 2026 at 04:16:31PM +0000, Anirudh Rayabharam wrote:
> > > > > > > > > > On Mon, Jan 26, 2026 at 12:46:44PM -0800, Stanislav Kinsburskii wrote:
> > > > > > > > > > > On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> > > > > > > > > > > > On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > > > > > > > > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > > > > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > > > > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > > > > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > > > > > > > > hypervisor deposited pages.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > > > > > > > > management is implemented.
> > > > > > > > > > > > 
> > > > > > > > > > > > Someone might want to stop all guest VMs and do a kexec. Which is valid
> > > > > > > > > > > > and would work without any issue for L1VH.
> > > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > No, it won't work and hypervsisor depostied pages won't be withdrawn.
> > > > > > > > > > 
> > > > > > > > > > All pages that were deposited in the context of a guest partition (i.e.
> > > > > > > > > > with the guest partition ID), would be withdrawn when you kill the VMs,
> > > > > > > > > > right? What other deposited pages would be left?
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > The driver deposits two types of pages: one for the guests (withdrawn
> > > > > > > > > upon gust shutdown) and the other - for the host itself (never
> > > > > > > > > withdrawn).
> > > > > > > > > See hv_call_create_partition, for example: it deposits pages for the
> > > > > > > > > host partition.
> > > > > > > > 
> > > > > > > > Hmm.. I see. Is it not possible to reclaim this memory in module_exit?
> > > > > > > > Also, can't we forcefully kill all running partitions in module_exit and
> > > > > > > > then reclaim memory? Would this help with kernel consistency
> > > > > > > > irrespective of userspace behavior?
> > > > > > > > 
> > > > > > > 
> > > > > > > It would, but this is sloppy and cannot be a long-term solution.
> > > > > > > 
> > > > > > > It is also not reliable. We have no hook to prevent kexec. So if we fail
> > > > > > > to kill the guest or reclaim the memory for any reason, the new kernel
> > > > > > > may still crash.
> > > > > > 
> > > > > > Actually guests won't be running by the time we reach our module_exit
> > > > > > function during a kexec. Userspace processes would've been killed by
> > > > > > then.
> > > > > > 
> > > > > 
> > > > > No, they will not: "kexec -e" doesn't kill user processes.
> > > > > We must not rely on OS to do graceful shutdown before doing
> > > > > kexec.
> > > > 
> > > > I see kexec -e is too brutal. Something like systemctl kexec is
> > > > more graceful and is probably used more commonly. In this case at least
> > > > we could register a reboot notifier and attempt to clean things up.
> > > > 
> > > > I think it is better to support kexec to this extent rather than
> > > > disabling it entirely.
> > > > 
> > > 
> > > You do understand that once our kernel is released to third parties, we
> > > can’t control how they will use kexec, right?
> > 
> > Yes, we can't. But that's okay. It is fine for us to say that only some
> > kexec scenarios are supported and some aren't (iff you're creating VMs
> > using MSHV; if you're not creating VMs all of kexec is supported).
> > 
> 
> Well, I disagree here. If we say the kernel supports MSHV, we must
> provide a robust solution. A partially working solution is not
> acceptable. It makes us look careless and can damage our reputation as a
> team (and as a company).

It won't if we call out upfront what is supported and what is not.

> 
> > > 
> > > This is a valid and existing option. We have to account for it. Yet
> > > again, L1VH will be used by arbitrary third parties out there, not just
> > > by us.
> > > 
> > > We can’t say the kernel supports MSHV until we close these gaps. We must
> > 
> > We can. It is okay say some scenarios are supported and some aren't.
> > 
> > All kexecs are supported if they never create VMs using MSHV. If they do
> > create VMs using MSHV and we implement cleanup in a reboot notifier at
> > least systemctl kexec and crashdump kexec would which are probably the
> > most common uses of kexec. It's okay to say that this is all we support
> > as of now.
> > 
> 
> I'm repeating myself, but I'll try to put it differently.
> There won't be any kernel core collected if a page was deposited. You're
> arguing for a lost cause here. Once a page is allocated and deposited,
> the crash kernel will try to write it into the core.

That's why we have to implement something where we attempt to destroy
partitions and reclaim memory (and BUG() out if that fails; which
hopefully should happen very rarely if at all). This should be *the*
solution we work towards. We don't need a temporary disable kexec
solution.

> 
> > Also, what makes you think customers would even be interested in enabling
> > our module in their kernel configs if it takes away kexec?
> > 
> 
> It's simple: L1VH isn't a host, so I can spin up new VMs instead of
> servicing the existing ones.

And what about the L2 VM state then? They might not be throwaway in all
cases.

> 
> Why do you think there won’t be customers interested in using MSHV in
> L1VH without kexec support?

Because they could already be using kexec for their servicing needs or
whatever. And no we can't just say "don't service these VMs just spin up
new ones".

Also, keep in mind that once L1VH is available in Azure, the distros
that run on it would be the same distros that run on all other Azure
VMs. There won't be special distros with a kernel specifically built for
L1VH. And KEXEC is generally enabled in distros. Distro vendors won't be
happy that they would need to publish a separate version of their image with
MSHV_ROOT enabled and KEXEC disabled because they wouldn't want KEXEC to
be disabled for all Azure VMs. Also, the customers will be confused why
the same distro doesn't work on L1VH.

Thanks,
Anirudh.


