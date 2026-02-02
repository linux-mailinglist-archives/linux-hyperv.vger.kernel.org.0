Return-Path: <linux-hyperv+bounces-8640-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EhEIJvVgGmFBwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8640-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 17:49:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2931CF25E
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 17:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 451A130869D4
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 16:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B21280CC9;
	Mon,  2 Feb 2026 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Gp2sbsY7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D542C1780;
	Mon,  2 Feb 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050619; cv=none; b=TMa11vejzHVq/LrHg8bO4kOvlSpvGvlW2On+UEPsHZenRkF+J7VzsZMTNzRMzFV2u3nh9jxW1a6SWpK9EoscDKMfksOGMTofTAJ7ZSCFSpmwnQ/bP2+z3yQ8QOJZxbAMLabCdgXeS5lo88iJbnseg3/nwrwsqYxeS0EP0uu0mGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050619; c=relaxed/simple;
	bh=pbZ7a39hF870j8Tf+mq3qRXXL3T7NW8md8aJn5qBZLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxDRnsTU/FymcQyO2g1QDaH/8XP4zWINtbODbEzNxSepoCc3PFQeeRBjS6Ts178xiyGtEAJsEAw38x5T4NIgtgo+vdOCPEt7xtXJtTvcY5emCGmyzjJkBhX5fugSRThjhxlAvpivbq9/QmJSshPvOs4ajKZOyT/gu7tdWFvk7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Gp2sbsY7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 20D1C20B7168;
	Mon,  2 Feb 2026 08:43:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20D1C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770050617;
	bh=1vFBdhxzvQ3DULuCAUqrqzH8i3rSoq0ftwxOqZJjI3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gp2sbsY7cpN9mzM0TZjnVoe4G2xzUF8WMg140R2n/3avjUKuuVeoVxe/QtBZnccLO
	 ydqDMgN01kUlEBUALMMBVJTylqC27Cfy3AtNaXDjSJFZY756i5VekTN8Wq2/ulX0XO
	 bSUp2fw0vPd5ngj1t7fZuNFN5NOT3bO/A1IPF9ps=
Date: Mon, 2 Feb 2026 08:43:37 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aYDUOeXIoOV4qtRk@skinsburskii.localdomain>
References: <2b42997d-7cc0-56ba-e1ca-a8640ce71ea9@linux.microsoft.com>
 <aXgFFz7YuJJQabyp@skinsburskii.localdomain>
 <257ad7f1-5dc0-2644-41c3-960c396caa38@linux.microsoft.com>
 <aXj6FXahxZU8QFq0@skinsburskii.localdomain>
 <4bcd7b66-6e3b-8f53-b688-ce0272123839@linux.microsoft.com>
 <aXqW7v-lnAT_gr0s@skinsburskii.localdomain>
 <919446c3-e02f-d532-3ea8-74d0cee38d33@linux.microsoft.com>
 <aXznwGcuP9rdffYf@anirudh-surface.localdomain>
 <aXz7Y7As4XC9rNeL@skinsburskii.localdomain>
 <2efb7fc8-994f-7cbf-6b7c-a1e645bdf638@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2efb7fc8-994f-7cbf-6b7c-a1e645bdf638@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8640-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: A2931CF25E
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 11:47:48AM -0800, Mukesh R wrote:
> On 1/30/26 10:41, Stanislav Kinsburskii wrote:
> > On Fri, Jan 30, 2026 at 05:17:52PM +0000, Anirudh Rayabharam wrote:
> > > On Thu, Jan 29, 2026 at 06:59:31PM -0800, Mukesh R wrote:
> > > > On 1/28/26 15:08, Stanislav Kinsburskii wrote:
> > > > > On Tue, Jan 27, 2026 at 11:56:02AM -0800, Mukesh R wrote:
> > > > > > On 1/27/26 09:47, Stanislav Kinsburskii wrote:
> > > > > > > On Mon, Jan 26, 2026 at 05:39:49PM -0800, Mukesh R wrote:
> > > > > > > > On 1/26/26 16:21, Stanislav Kinsburskii wrote:
> > > > > > > > > On Mon, Jan 26, 2026 at 03:07:18PM -0800, Mukesh R wrote:
> > > > > > > > > > On 1/26/26 12:43, Stanislav Kinsburskii wrote:
> > > > > > > > > > > On Mon, Jan 26, 2026 at 12:20:09PM -0800, Mukesh R wrote:
> > > > > > > > > > > > On 1/25/26 14:39, Stanislav Kinsburskii wrote:
> > > > > > > > > > > > > On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
> > > > > > > > > > > > > > On 1/23/26 14:20, Stanislav Kinsburskii wrote:
> > > > > > > > > > > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > > > > > > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > > > > > > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > > > > > > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > > > > > > > > > > hypervisor deposited pages.
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > > > > > > > > > > management is implemented.
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >         drivers/hv/Kconfig |    1 +
> > > > > > > > > > > > > > >         1 file changed, 1 insertion(+)
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > > > > > > > > > > > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > > > > > > > > > > > > > --- a/drivers/hv/Kconfig
> > > > > > > > > > > > > > > +++ b/drivers/hv/Kconfig
> > > > > > > > > > > > > > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > > > > > > > > > > > > > >         	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > > > > > > > > > > > > > >         	# no particular order, making it impossible to reassemble larger pages
> > > > > > > > > > > > > > >         	depends on PAGE_SIZE_4KB
> > > > > > > > > > > > > > > +	depends on !KEXEC
> > > > > > > > > > > > > > >         	select EVENTFD
> > > > > > > > > > > > > > >         	select VIRT_XFER_TO_GUEST_WORK
> > > > > > > > > > > > > > >         	select HMM_MIRROR
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
> > > > > > > > > > > > > > implying that crash dump might be involved. Or did you test kdump
> > > > > > > > > > > > > > and it was fine?
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Yes, it will. Crash kexec depends on normal kexec functionality, so it
> > > > > > > > > > > > > will be affected as well.
> > > > > > > > > > > > 
> > > > > > > > > > > > So not sure I understand the reason for this patch. We can just block
> > > > > > > > > > > > kexec if there are any VMs running, right? Doing this would mean any
> > > > > > > > > > > > further developement would be without a ver important and major feature,
> > > > > > > > > > > > right?
> > > > > > > > > > > 
> > > > > > > > > > > This is an option. But until it's implemented and merged, a user mshv
> > > > > > > > > > > driver gets into a situation where kexec is broken in a non-obvious way.
> > > > > > > > > > > The system may crash at any time after kexec, depending on whether the
> > > > > > > > > > > new kernel touches the pages deposited to hypervisor or not. This is a
> > > > > > > > > > > bad user experience.
> > > > > > > > > > 
> > > > > > > > > > I understand that. But with this we cannot collect core and debug any
> > > > > > > > > > crashes. I was thinking there would be a quick way to prohibit kexec
> > > > > > > > > > for update via notifier or some other quick hack. Did you already
> > > > > > > > > > explore that and didn't find anything, hence this?
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > This quick hack you mention isn't quick in the upstream kernel as there
> > > > > > > > > is no hook to interrupt kexec process except the live update one.
> > > > > > > > 
> > > > > > > > That's the one we want to interrupt and block right? crash kexec
> > > > > > > > is ok and should be allowed. We can document we don't support kexec
> > > > > > > > for update for now.
> > > > > > > > 
> > > > > > > > > I sent an RFC for that one but given todays conversation details is
> > > > > > > > > won't be accepted as is.
> > > > > > > > 
> > > > > > > > Are you taking about this?
> > > > > > > > 
> > > > > > > >            "mshv: Add kexec safety for deposited pages"
> > > > > > > > 
> > > > > > > 
> > > > > > > Yes.
> > > > > > > 
> > > > > > > > > Making mshv mutually exclusive with kexec is the only viable option for
> > > > > > > > > now given time constraints.
> > > > > > > > > It is intended to be replaced with proper page lifecycle management in
> > > > > > > > > the future.
> > > > > > > > 
> > > > > > > > Yeah, that could take a long time and imo we cannot just disable KEXEC
> > > > > > > > completely. What we want is just block kexec for updates from some
> > > > > > > > mshv file for now, we an print during boot that kexec for updates is
> > > > > > > > not supported on mshv. Hope that makes sense.
> > > > > > > > 
> > > > > > > 
> > > > > > > The trade-off here is between disabling kexec support and having the
> > > > > > > kernel crash after kexec in a non-obvious way. This affects both regular
> > > > > > > kexec and crash kexec.
> > > > > > 
> > > > > > crash kexec on baremetal is not affected, hence disabling that
> > > > > > doesn't make sense as we can't debug crashes then on bm.
> > > > > > 
> > > > > 
> > > > > Bare metal support is not currently relevant, as it is not available.
> > > > > This is the upstream kernel, and this driver will be accessible to
> > > > > third-party customers beginning with kernel 6.19 for running their
> > > > > kernels in Azure L1VH, so consistency is required.
> > > > 
> > > > Well, without crashdump support, customers will not be running anything
> > > > anywhere.
> > > 
> > > This is my concern too. I don't think customers will be particularly
> > > happy that kexec doesn't work with our driver.
> > > 
> > 
> > I wasn?t clear earlier, so let me restate it. Today, kexec is not
> > supported in L1VH. This is a bug we have not fixed yet. Disabling kexec
> > is not a long-term solution. But it is better to disable it explicitly
> > than to have kernel crashes after kexec.
> 
> I don't think there is disagreement on this. The undesired part is turning
> off KEXEC config completely.
> 

There is no disagreement on this either. If you have a better solution
that can be implemented and merged before next kernel merge window,
please propose it. Otherwise, this patch will remain as is for now.

Thanks,
Stanislav

> Thanks,
> -Mukesh
> 
> 
> > This does not mean the bug should not be fixed. But the upstream kernel
> > has its own policies and merge windows. For kernel 6.19, it is better to
> > have a clear kexec error than random crashes after kexec.
> > 
> > Thanks,
> > Stanislav
> > 
> > > Thanks,
> > > Anirudh
> > > 
> > > > 
> > > > Thanks,
> > > > -Mukesh
> > > > 
> > > > > Thanks,
> > > > > Stanislav
> > > > > 
> > > > > > Let me think and explore a bit, and if I come up with something, I'll
> > > > > > send a patch here. If nothing, then we can do this as last resort.
> > > > > > 
> > > > > > Thanks,
> > > > > > -Mukesh
> > > > > > 
> > > > > > 
> > > > > > > It?s a pity we can?t apply a quick hack to disable only regular kexec.
> > > > > > > However, since crash kexec would hit the same issues, until we have a
> > > > > > > proper state transition for deposted pages, the best workaround for now
> > > > > > > is to reset the hypervisor state on every kexec, which needs design,
> > > > > > > work, and testing.
> > > > > > > 
> > > > > > > Disabling kexec is the only consistent way to handle this in the
> > > > > > > upstream kernel at the moment.
> > > > > > > 
> > > > > > > Thanks, Stanislav
> > > > > > > 
> > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > -Mukesh
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > Stanislav
> > > > > > > > > 
> > > > > > > > > > Thanks,
> > > > > > > > > > -Mukesh
> > > > > > > > > > 
> > > > > > > > > > > Therefor it should be explicitly forbidden as it's essentially not
> > > > > > > > > > > supported yet.
> > > > > > > > > > > 
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Stanislav
> > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > > Thanks,
> > > > > > > > > > > > > Stanislav
> > > > > > > > > > > > > 
> > > > > > > > > > > > > > Thanks,
> > > > > > > > > > > > > > -Mukesh
> > > > 
> 

