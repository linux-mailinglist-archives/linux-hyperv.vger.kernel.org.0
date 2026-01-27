Return-Path: <linux-hyperv+bounces-8548-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OrSfJx/6eGlfuQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8548-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 18:47:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8435989E0
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 18:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B5753001078
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 17:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D027B35F;
	Tue, 27 Jan 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iJRc/NQb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFF81A9F9B;
	Tue, 27 Jan 2026 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536026; cv=none; b=BUPGhGHmVb8jyC8LYXdnb+PhP+ncwIF/dpQsY4pPw6N9GEn/r2CyeNJbqD0iE6i1g3DgMdlJQGQs1ptg6pJkfQTYmv/DaCwFFyBEyDsbm3KZvuc/KlSK2hUzrQOoWdWVdPVxWAt9WvxCA5rUmgNqXlOHGKyPVOU0TcCs5kxZLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536026; c=relaxed/simple;
	bh=EYobg1EIS1i0gBCT6Uuan9+JkqNhHsAp7qFNldHx/qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3EYiYcMnjphsOVV0ltL/IGr07kiYbc1NUW9dVl9gkNPEv7hNnIfw1jpb1s462lBJfb0Km4Ejx+/lcVRrWFBm87TRPqs5k5UCKFNoNMJCEYE7kC7wjJveM8mGie3bPYqmztjMj37gZOY7kGSo1SpwncYTBu4YcOdR3YdWgJTgYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iJRc/NQb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id BF4DF20B7165;
	Tue, 27 Jan 2026 09:47:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF4DF20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769536024;
	bh=OIaiBSFdpW5WtE03veURky3VhO0cvG4QrEmlhgmAjV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJRc/NQbp8L+R+0exQgBuMZfiLMpzAfDpc2ZY89kliv31Ak0/eeMAUATMj9f06J8F
	 ljnmnw0u7+2hMCyp10Xm7D5OHaq1Yp57/WH1qwaEaNnHXVMqntVhMOScLSktJNicqy
	 lQ4J7PaK4JNZEm03gbj9u1dZsnn8bzodeHbjRiUM=
Date: Tue, 27 Jan 2026 09:47:01 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXj6FXahxZU8QFq0@skinsburskii.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <549041d1-360d-d34c-4e3b-62802346acaa@linux.microsoft.com>
 <aXabnnCV50Thv9tZ@skinsburskii.localdomain>
 <890506f6-9b91-5d59-8c98-086cf5d206bb@linux.microsoft.com>
 <aXfSDm-4BjPPZMNu@skinsburskii.localdomain>
 <2b42997d-7cc0-56ba-e1ca-a8640ce71ea9@linux.microsoft.com>
 <aXgFFz7YuJJQabyp@skinsburskii.localdomain>
 <257ad7f1-5dc0-2644-41c3-960c396caa38@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <257ad7f1-5dc0-2644-41c3-960c396caa38@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8548-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8435989E0
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:39:49PM -0800, Mukesh R wrote:
> On 1/26/26 16:21, Stanislav Kinsburskii wrote:
> > On Mon, Jan 26, 2026 at 03:07:18PM -0800, Mukesh R wrote:
> > > On 1/26/26 12:43, Stanislav Kinsburskii wrote:
> > > > On Mon, Jan 26, 2026 at 12:20:09PM -0800, Mukesh R wrote:
> > > > > On 1/25/26 14:39, Stanislav Kinsburskii wrote:
> > > > > > On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
> > > > > > > On 1/23/26 14:20, Stanislav Kinsburskii wrote:
> > > > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > > > hypervisor deposited pages.
> > > > > > > > 
> > > > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > > > management is implemented.
> > > > > > > > 
> > > > > > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > > > > > ---
> > > > > > > >      drivers/hv/Kconfig |    1 +
> > > > > > > >      1 file changed, 1 insertion(+)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > > > > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > > > > > > --- a/drivers/hv/Kconfig
> > > > > > > > +++ b/drivers/hv/Kconfig
> > > > > > > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > > > > > > >      	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > > > > > > >      	# no particular order, making it impossible to reassemble larger pages
> > > > > > > >      	depends on PAGE_SIZE_4KB
> > > > > > > > +	depends on !KEXEC
> > > > > > > >      	select EVENTFD
> > > > > > > >      	select VIRT_XFER_TO_GUEST_WORK
> > > > > > > >      	select HMM_MIRROR
> > > > > > > > 
> > > > > > > > 
> > > > > > > 
> > > > > > > Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
> > > > > > > implying that crash dump might be involved. Or did you test kdump
> > > > > > > and it was fine?
> > > > > > > 
> > > > > > 
> > > > > > Yes, it will. Crash kexec depends on normal kexec functionality, so it
> > > > > > will be affected as well.
> > > > > 
> > > > > So not sure I understand the reason for this patch. We can just block
> > > > > kexec if there are any VMs running, right? Doing this would mean any
> > > > > further developement would be without a ver important and major feature,
> > > > > right?
> > > > 
> > > > This is an option. But until it's implemented and merged, a user mshv
> > > > driver gets into a situation where kexec is broken in a non-obvious way.
> > > > The system may crash at any time after kexec, depending on whether the
> > > > new kernel touches the pages deposited to hypervisor or not. This is a
> > > > bad user experience.
> > > 
> > > I understand that. But with this we cannot collect core and debug any
> > > crashes. I was thinking there would be a quick way to prohibit kexec
> > > for update via notifier or some other quick hack. Did you already
> > > explore that and didn't find anything, hence this?
> > > 
> > 
> > This quick hack you mention isn't quick in the upstream kernel as there
> > is no hook to interrupt kexec process except the live update one.
> 
> That's the one we want to interrupt and block right? crash kexec
> is ok and should be allowed. We can document we don't support kexec
> for update for now.
> 
> > I sent an RFC for that one but given todays conversation details is
> > won't be accepted as is.
> 
> Are you taking about this?
> 
>         "mshv: Add kexec safety for deposited pages"
> 

Yes.

> > Making mshv mutually exclusive with kexec is the only viable option for
> > now given time constraints.
> > It is intended to be replaced with proper page lifecycle management in
> > the future.
> 
> Yeah, that could take a long time and imo we cannot just disable KEXEC
> completely. What we want is just block kexec for updates from some
> mshv file for now, we an print during boot that kexec for updates is
> not supported on mshv. Hope that makes sense.
> 

The trade-off here is between disabling kexec support and having the
kernel crash after kexec in a non-obvious way. This affects both regular
kexec and crash kexec.

It’s a pity we can’t apply a quick hack to disable only regular kexec.
However, since crash kexec would hit the same issues, until we have a
proper state transition for deposted pages, the best workaround for now
is to reset the hypervisor state on every kexec, which needs design,
work, and testing.

Disabling kexec is the only consistent way to handle this in the
upstream kernel at the moment.

Thanks, Stanislav


> Thanks,
> -Mukesh
> 
> 
> 
> > Thanks,
> > Stanislav
> > 
> > > Thanks,
> > > -Mukesh
> > > 
> > > > Therefor it should be explicitly forbidden as it's essentially not
> > > > supported yet.
> > > > 
> > > > Thanks,
> > > > Stanislav
> > > > 
> > > > > 
> > > > > > Thanks,
> > > > > > Stanislav
> > > > > > 
> > > > > > > Thanks,
> > > > > > > -Mukesh

