Return-Path: <linux-hyperv+bounces-8577-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cq5gOvSWeml+8QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8577-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 00:08:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5C8A9D75
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 00:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17441301549D
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 23:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BABA2FE59A;
	Wed, 28 Jan 2026 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GFhdef5J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D1F2BEFE5;
	Wed, 28 Jan 2026 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769641714; cv=none; b=XfTe0xr00ooeq7AYcbpqr5W2Hyo++WfuALWwMrTV8awpSiam/wrqwqApJ4YTR6rBJddoDV5JGhboMisob84p/QEU+AcrnytgNcqI5Cq6z8iz1gVZncSGie3VozCe9pMi/MtVs3yzFeLbFJcqgJ5VZTC/d3Pm0/71Mx34X+xu1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769641714; c=relaxed/simple;
	bh=9XsTAMrCTCeQgGFeun+0kZGknrNX8PlyFSYI17Jbf+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7E3uHe2ybcji2nlSmnbhNLbplX/3VyzTR4GN0C3XxYFahFtePW0+pXdbqjb0aYu7D5yTdBaqQhBs4lLHNPYeXoUJiYjeidQaHWJ2PV0t7RdFZ4Sw1Y4ij3CkcWhUpBca9ZQLJMktq4NEZ/11WVnJlj4bv1maT52L6j8FS2UgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GFhdef5J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3AFB720B7165;
	Wed, 28 Jan 2026 15:08:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AFB720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769641712;
	bh=KwmfvvTx+ms6GBgJvDk/C7e+/ezLBs2/jXPinD3QST8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFhdef5JYjZHQvX5ZnI7HH5d4pCEhrzxey09G0dZQkc9GRBeTD331WentzX0VwUrt
	 d40ChKiO0s7U8GZ/Iao+9xNmrUxiEwTiElb8GmKKwiViUlcDsZHy3iiY4BaA/LJyXC
	 5Ucsah3M8VEFnMNoz5QUsmad0UcIfFf3l7mjAUF8=
Date: Wed, 28 Jan 2026 15:08:30 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXqW7v-lnAT_gr0s@skinsburskii.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <549041d1-360d-d34c-4e3b-62802346acaa@linux.microsoft.com>
 <aXabnnCV50Thv9tZ@skinsburskii.localdomain>
 <890506f6-9b91-5d59-8c98-086cf5d206bb@linux.microsoft.com>
 <aXfSDm-4BjPPZMNu@skinsburskii.localdomain>
 <2b42997d-7cc0-56ba-e1ca-a8640ce71ea9@linux.microsoft.com>
 <aXgFFz7YuJJQabyp@skinsburskii.localdomain>
 <257ad7f1-5dc0-2644-41c3-960c396caa38@linux.microsoft.com>
 <aXj6FXahxZU8QFq0@skinsburskii.localdomain>
 <4bcd7b66-6e3b-8f53-b688-ce0272123839@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bcd7b66-6e3b-8f53-b688-ce0272123839@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8577-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1E5C8A9D75
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:56:02AM -0800, Mukesh R wrote:
> On 1/27/26 09:47, Stanislav Kinsburskii wrote:
> > On Mon, Jan 26, 2026 at 05:39:49PM -0800, Mukesh R wrote:
> > > On 1/26/26 16:21, Stanislav Kinsburskii wrote:
> > > > On Mon, Jan 26, 2026 at 03:07:18PM -0800, Mukesh R wrote:
> > > > > On 1/26/26 12:43, Stanislav Kinsburskii wrote:
> > > > > > On Mon, Jan 26, 2026 at 12:20:09PM -0800, Mukesh R wrote:
> > > > > > > On 1/25/26 14:39, Stanislav Kinsburskii wrote:
> > > > > > > > On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
> > > > > > > > > On 1/23/26 14:20, Stanislav Kinsburskii wrote:
> > > > > > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > > > > > hypervisor deposited pages.
> > > > > > > > > > 
> > > > > > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > > > > > management is implemented.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > > > > > > > ---
> > > > > > > > > >       drivers/hv/Kconfig |    1 +
> > > > > > > > > >       1 file changed, 1 insertion(+)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > > > > > > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > > > > > > > > --- a/drivers/hv/Kconfig
> > > > > > > > > > +++ b/drivers/hv/Kconfig
> > > > > > > > > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > > > > > > > > >       	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > > > > > > > > >       	# no particular order, making it impossible to reassemble larger pages
> > > > > > > > > >       	depends on PAGE_SIZE_4KB
> > > > > > > > > > +	depends on !KEXEC
> > > > > > > > > >       	select EVENTFD
> > > > > > > > > >       	select VIRT_XFER_TO_GUEST_WORK
> > > > > > > > > >       	select HMM_MIRROR
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
> > > > > > > > > implying that crash dump might be involved. Or did you test kdump
> > > > > > > > > and it was fine?
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Yes, it will. Crash kexec depends on normal kexec functionality, so it
> > > > > > > > will be affected as well.
> > > > > > > 
> > > > > > > So not sure I understand the reason for this patch. We can just block
> > > > > > > kexec if there are any VMs running, right? Doing this would mean any
> > > > > > > further developement would be without a ver important and major feature,
> > > > > > > right?
> > > > > > 
> > > > > > This is an option. But until it's implemented and merged, a user mshv
> > > > > > driver gets into a situation where kexec is broken in a non-obvious way.
> > > > > > The system may crash at any time after kexec, depending on whether the
> > > > > > new kernel touches the pages deposited to hypervisor or not. This is a
> > > > > > bad user experience.
> > > > > 
> > > > > I understand that. But with this we cannot collect core and debug any
> > > > > crashes. I was thinking there would be a quick way to prohibit kexec
> > > > > for update via notifier or some other quick hack. Did you already
> > > > > explore that and didn't find anything, hence this?
> > > > > 
> > > > 
> > > > This quick hack you mention isn't quick in the upstream kernel as there
> > > > is no hook to interrupt kexec process except the live update one.
> > > 
> > > That's the one we want to interrupt and block right? crash kexec
> > > is ok and should be allowed. We can document we don't support kexec
> > > for update for now.
> > > 
> > > > I sent an RFC for that one but given todays conversation details is
> > > > won't be accepted as is.
> > > 
> > > Are you taking about this?
> > > 
> > >          "mshv: Add kexec safety for deposited pages"
> > > 
> > 
> > Yes.
> > 
> > > > Making mshv mutually exclusive with kexec is the only viable option for
> > > > now given time constraints.
> > > > It is intended to be replaced with proper page lifecycle management in
> > > > the future.
> > > 
> > > Yeah, that could take a long time and imo we cannot just disable KEXEC
> > > completely. What we want is just block kexec for updates from some
> > > mshv file for now, we an print during boot that kexec for updates is
> > > not supported on mshv. Hope that makes sense.
> > > 
> > 
> > The trade-off here is between disabling kexec support and having the
> > kernel crash after kexec in a non-obvious way. This affects both regular
> > kexec and crash kexec.
> 
> crash kexec on baremetal is not affected, hence disabling that
> doesn't make sense as we can't debug crashes then on bm.
> 

Bare metal support is not currently relevant, as it is not available.
This is the upstream kernel, and this driver will be accessible to
third-party customers beginning with kernel 6.19 for running their
kernels in Azure L1VH, so consistency is required.

Thanks,
Stanislav

> Let me think and explore a bit, and if I come up with something, I'll
> send a patch here. If nothing, then we can do this as last resort.
> 
> Thanks,
> -Mukesh
> 
> 
> > It?s a pity we can?t apply a quick hack to disable only regular kexec.
> > However, since crash kexec would hit the same issues, until we have a
> > proper state transition for deposted pages, the best workaround for now
> > is to reset the hypervisor state on every kexec, which needs design,
> > work, and testing.
> > 
> > Disabling kexec is the only consistent way to handle this in the
> > upstream kernel at the moment.
> > 
> > Thanks, Stanislav
> > 
> > 
> > > Thanks,
> > > -Mukesh
> > > 
> > > 
> > > 
> > > > Thanks,
> > > > Stanislav
> > > > 
> > > > > Thanks,
> > > > > -Mukesh
> > > > > 
> > > > > > Therefor it should be explicitly forbidden as it's essentially not
> > > > > > supported yet.
> > > > > > 
> > > > > > Thanks,
> > > > > > Stanislav
> > > > > > 
> > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > Stanislav
> > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > -Mukesh

