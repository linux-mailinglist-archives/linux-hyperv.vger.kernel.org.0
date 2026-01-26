Return-Path: <linux-hyperv+bounces-8527-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBn4LL7Sd2mFlwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8527-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 21:46:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E528D411
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 21:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86C483067F4C
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEB82D7D3A;
	Mon, 26 Jan 2026 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YTsZYck2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02672C0F7A;
	Mon, 26 Jan 2026 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460242; cv=none; b=lCQhRYtGZqMP1kMvpDhaYij7hxZWZjCYtey6kE3FkAP6In6t0hxdSRzMMiYwrzi8TR1QXs4TjA1aFKsvem2EsEIeZy0B/ouvJ/JgAMwm6WEs+kMLmjU7ZDhuI6Z8NsgxPTcfL7/Jtcs9Ag8zqe5TUdMJWUvwEDJpACKJPPtM6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460242; c=relaxed/simple;
	bh=KJifgS6Un6nYJOlB76tLABc4jql7pp4CYmoD+q4+PIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cydcwc8GnTn3q9TlRK/C+UiIGE4z1876um+r7JBR1NfUzC4key/IE/ZZPh1fC3wr0VegGKhSKlSUDrZhmTLV8Cd4ibPsAc+X7m/0l+P4fj0xC32PDJ/AZ/xM/cWNFHcU0KEacfXJgNJj2zYPxyUI5tnAEIPgqa53hNIKlMK1nTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YTsZYck2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5CE6F20B7165;
	Mon, 26 Jan 2026 12:44:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5CE6F20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769460240;
	bh=OVGYVuhHQ8t+OHRSN86G8kgfO7KHmh9NSl0bMJeBm4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTsZYck2h548fJGfXjwr5YU75tzUAFoMN02BTWd0PeZX4LKuimDt0iCylxNuWy/Sq
	 st8mdzVVbipDIjAFYURODTRiFmCwmXCKtqs1Saua21yztyBkPzuR/N1jgQ7IfnQ31T
	 M1+3S4Yl+DKl/gR3P2OPypiCB0Fhyo05p65ehZzQ=
Date: Mon, 26 Jan 2026 12:43:58 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXfSDm-4BjPPZMNu@skinsburskii.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <549041d1-360d-d34c-4e3b-62802346acaa@linux.microsoft.com>
 <aXabnnCV50Thv9tZ@skinsburskii.localdomain>
 <890506f6-9b91-5d59-8c98-086cf5d206bb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890506f6-9b91-5d59-8c98-086cf5d206bb@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8527-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 01E528D411
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:20:09PM -0800, Mukesh R wrote:
> On 1/25/26 14:39, Stanislav Kinsburskii wrote:
> > On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
> > > On 1/23/26 14:20, Stanislav Kinsburskii wrote:
> > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > hypervisor deposited pages.
> > > > 
> > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > management is implemented.
> > > > 
> > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > ---
> > > >    drivers/hv/Kconfig |    1 +
> > > >    1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > > --- a/drivers/hv/Kconfig
> > > > +++ b/drivers/hv/Kconfig
> > > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > > >    	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > > >    	# no particular order, making it impossible to reassemble larger pages
> > > >    	depends on PAGE_SIZE_4KB
> > > > +	depends on !KEXEC
> > > >    	select EVENTFD
> > > >    	select VIRT_XFER_TO_GUEST_WORK
> > > >    	select HMM_MIRROR
> > > > 
> > > > 
> > > 
> > > Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
> > > implying that crash dump might be involved. Or did you test kdump
> > > and it was fine?
> > > 
> > 
> > Yes, it will. Crash kexec depends on normal kexec functionality, so it
> > will be affected as well.
> 
> So not sure I understand the reason for this patch. We can just block
> kexec if there are any VMs running, right? Doing this would mean any
> further developement would be without a ver important and major feature,
> right?

This is an option. But until it's implemented and merged, a user mshv
driver gets into a situation where kexec is broken in a non-obvious way.
The system may crash at any time after kexec, depending on whether the
new kernel touches the pages deposited to hypervisor or not. This is a
bad user experience.
Therefor it should be explicitly forbidden as it's essentially not
supported yet.

Thanks,
Stanislav

> 
> > Thanks,
> > Stanislav
> > 
> > > Thanks,
> > > -Mukesh

