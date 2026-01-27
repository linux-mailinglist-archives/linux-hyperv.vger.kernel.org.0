Return-Path: <linux-hyperv+bounces-8540-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAtQGB8FeGmUnQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8540-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 01:21:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BF68E733
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 01:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A40F301370F
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 00:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32161A23A4;
	Tue, 27 Jan 2026 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nBRxfVn1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DAD18CC13;
	Tue, 27 Jan 2026 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769473307; cv=none; b=fvA1+gJ0VnRFmnvcZ+P/wK4Pksb7U7DcuSrD7aQwo3itTy0v4KaKsIAgF/R+RnxyO5Z49LWLWDU++09ikPxvQsldKM6BxakrB3r54/C+9X8Vvcy/dOnYEj40zYMqsc/XycqUTLa7US0Mxpu3UipsqLPPUeUfRWfBzD7+/YxKEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769473307; c=relaxed/simple;
	bh=BV7gsD3HvmzKXjC4RMsMkRse1E9PHoMMOEA+6p71Mto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzyTmhP4ygR/VYNPOeHpJARcFLxhUyF6KW5O8A+XQ4txaHR4ffntw6hm2QChYJykVouNK28Z62EBkKtvUx/7DSUnHPBU/tDUYwFlsgEs8tIVzVdu3/m4cVU2gi0FgmrLwR7XKb+1vbVNe2f1cuVkheNEvlhXK0UrfqI41R1xlBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nBRxfVn1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id B2BF120B7165;
	Mon, 26 Jan 2026 16:21:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2BF120B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769473305;
	bh=kcx5joyh6i8meOw9oApnZ0Iu4rF/ZMWtoh18XohUr2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBRxfVn1QlraJvvm8iuPkuygcsORiagB0dh7Z6fPUnYMQvzHYyUcL7Z2tKk3DRxVP
	 4egnErzqwSafYF/wqV2HbLq0GE3ccw3mmV9Y8ETNUpYFae0TSnmXR8qQHQmH0LITkg
	 kTHpRVJetXepwWzWl3c0bHmxDvGqPkT50c6mQHVs=
Date: Mon, 26 Jan 2026 16:21:43 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXgFFz7YuJJQabyp@skinsburskii.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <549041d1-360d-d34c-4e3b-62802346acaa@linux.microsoft.com>
 <aXabnnCV50Thv9tZ@skinsburskii.localdomain>
 <890506f6-9b91-5d59-8c98-086cf5d206bb@linux.microsoft.com>
 <aXfSDm-4BjPPZMNu@skinsburskii.localdomain>
 <2b42997d-7cc0-56ba-e1ca-a8640ce71ea9@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b42997d-7cc0-56ba-e1ca-a8640ce71ea9@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8540-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: C8BF68E733
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 03:07:18PM -0800, Mukesh R wrote:
> On 1/26/26 12:43, Stanislav Kinsburskii wrote:
> > On Mon, Jan 26, 2026 at 12:20:09PM -0800, Mukesh R wrote:
> > > On 1/25/26 14:39, Stanislav Kinsburskii wrote:
> > > > On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
> > > > > On 1/23/26 14:20, Stanislav Kinsburskii wrote:
> > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > hypervisor deposited pages.
> > > > > > 
> > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > management is implemented.
> > > > > > 
> > > > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > > > ---
> > > > > >     drivers/hv/Kconfig |    1 +
> > > > > >     1 file changed, 1 insertion(+)
> > > > > > 
> > > > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > > > > --- a/drivers/hv/Kconfig
> > > > > > +++ b/drivers/hv/Kconfig
> > > > > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > > > > >     	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > > > > >     	# no particular order, making it impossible to reassemble larger pages
> > > > > >     	depends on PAGE_SIZE_4KB
> > > > > > +	depends on !KEXEC
> > > > > >     	select EVENTFD
> > > > > >     	select VIRT_XFER_TO_GUEST_WORK
> > > > > >     	select HMM_MIRROR
> > > > > > 
> > > > > > 
> > > > > 
> > > > > Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
> > > > > implying that crash dump might be involved. Or did you test kdump
> > > > > and it was fine?
> > > > > 
> > > > 
> > > > Yes, it will. Crash kexec depends on normal kexec functionality, so it
> > > > will be affected as well.
> > > 
> > > So not sure I understand the reason for this patch. We can just block
> > > kexec if there are any VMs running, right? Doing this would mean any
> > > further developement would be without a ver important and major feature,
> > > right?
> > 
> > This is an option. But until it's implemented and merged, a user mshv
> > driver gets into a situation where kexec is broken in a non-obvious way.
> > The system may crash at any time after kexec, depending on whether the
> > new kernel touches the pages deposited to hypervisor or not. This is a
> > bad user experience.
> 
> I understand that. But with this we cannot collect core and debug any
> crashes. I was thinking there would be a quick way to prohibit kexec
> for update via notifier or some other quick hack. Did you already
> explore that and didn't find anything, hence this?
> 

This quick hack you mention isn't quick in the upstream kernel as there
is no hook to interrupt kexec process except the live update one.
I sent an RFC for that one but given todays conversation details is
won't be accepted as is.
Making mshv mutually exclusive with kexec is the only viable option for
now given time constraints.
It is intended to be replaced with proper page lifecycle management in
the future.

Thanks,
Stanislav

> Thanks,
> -Mukesh
> 
> > Therefor it should be explicitly forbidden as it's essentially not
> > supported yet.
> > 
> > Thanks,
> > Stanislav
> > 
> > > 
> > > > Thanks,
> > > > Stanislav
> > > > 
> > > > > Thanks,
> > > > > -Mukesh

