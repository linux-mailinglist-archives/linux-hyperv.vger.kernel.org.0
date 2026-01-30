Return-Path: <linux-hyperv+bounces-8606-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGLOOcTofGlTPQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8606-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:22:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 490DEBCFFA
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 879B33042B51
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17872D46B2;
	Fri, 30 Jan 2026 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="vFDX5Sor"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F98734EF00;
	Fri, 30 Jan 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793491; cv=pass; b=hGDfzahlc/kFx2FpjQ5WYBF0jvM0Ikp789u2Twl6hiI+aVBy2Rjlzd9gxvDTnSITKZZn74ua90epujV9eqAj/llrtvpL9vlaq5nA5r149WLjyKpfOxgLgdm5TOnYSoxS7WmO/IeZBh3VhSVlxPyKfkJnpnGPgjZuIt/m4W9XMic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793491; c=relaxed/simple;
	bh=ZaXljxlFMTZuK8s8rX4LXCdxOwX+OM28lofq213hvBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOjhkqM2a7wHC5vEST0OSOMl9/It6tXs84ycV8Xs4lVcTWKaeuqrMbWFpOecIl14ygmMXKNHRh/hlXJVKkAnA+6ppVHHxSTEK+bdqzzin/bbjzdXXh/FzB1fa5J6ePodzLohfkO4dg7UMRw4fO0jHz0jkurHLAoxRdIOsfuLzYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=vFDX5Sor; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769793479; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AJBQOQv8Qg5srozPyKxdtPZTG7tF2uBEqjfsJk/TO71soqZ+mkIOb/1wSKfrKrIo+3VFBsdwHz6sLaufC+Zfj7QhYyPVbZXLwdoY/Ghhb9MYPJmrFrCdCWq+mbUKHlGyj6v+z4jgrI3Nkna9lU+rsqxihPgXi9nvUTtNxWU5Z+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769793479; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2z5tAGAsEOZFyRtZVxUKUqwqUQRqa1UTD6oQYUgTMAw=; 
	b=eN8UVsbzZ/B9EB6VtUq8G8GL+neweCmYqnLZS061sVt4kBK6vybQCxdkYg0Noj2GOZlTw6Oa0jJiE3zv7aD0Lh1gbx/+1gKMZl0keT3x76UQGnNifia/cv9Becg0UgEwoWISyTNfM5hS9WMFlQKBB8ONPcvcfQqpETt8BdPo2q0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769793479;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=2z5tAGAsEOZFyRtZVxUKUqwqUQRqa1UTD6oQYUgTMAw=;
	b=vFDX5SorlPgcEghehy3MZU0HpbSF9zVrsExlU3yu78oL0x5jzNc+WbhopXUC+sK8
	trYfgynDhSvZYM0SGBOClCOgacX1XktYoLpfOTBBYK3B9kPkuck7h4/+PqAvP6beqH8
	AxVL9ZrjgSGobN818Tfr4AFNbu9XjPfMZ87T+oFI=
Received: by mx.zohomail.com with SMTPS id 1769793478002233.28478106379373;
	Fri, 30 Jan 2026 09:17:58 -0800 (PST)
Date: Fri, 30 Jan 2026 17:17:52 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXznwGcuP9rdffYf@anirudh-surface.localdomain>
References: <aXabnnCV50Thv9tZ@skinsburskii.localdomain>
 <890506f6-9b91-5d59-8c98-086cf5d206bb@linux.microsoft.com>
 <aXfSDm-4BjPPZMNu@skinsburskii.localdomain>
 <2b42997d-7cc0-56ba-e1ca-a8640ce71ea9@linux.microsoft.com>
 <aXgFFz7YuJJQabyp@skinsburskii.localdomain>
 <257ad7f1-5dc0-2644-41c3-960c396caa38@linux.microsoft.com>
 <aXj6FXahxZU8QFq0@skinsburskii.localdomain>
 <4bcd7b66-6e3b-8f53-b688-ce0272123839@linux.microsoft.com>
 <aXqW7v-lnAT_gr0s@skinsburskii.localdomain>
 <919446c3-e02f-d532-3ea8-74d0cee38d33@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <919446c3-e02f-d532-3ea8-74d0cee38d33@linux.microsoft.com>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8606-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudh-surface.localdomain:mid]
X-Rspamd-Queue-Id: 490DEBCFFA
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 06:59:31PM -0800, Mukesh R wrote:
> On 1/28/26 15:08, Stanislav Kinsburskii wrote:
> > On Tue, Jan 27, 2026 at 11:56:02AM -0800, Mukesh R wrote:
> > > On 1/27/26 09:47, Stanislav Kinsburskii wrote:
> > > > On Mon, Jan 26, 2026 at 05:39:49PM -0800, Mukesh R wrote:
> > > > > On 1/26/26 16:21, Stanislav Kinsburskii wrote:
> > > > > > On Mon, Jan 26, 2026 at 03:07:18PM -0800, Mukesh R wrote:
> > > > > > > On 1/26/26 12:43, Stanislav Kinsburskii wrote:
> > > > > > > > On Mon, Jan 26, 2026 at 12:20:09PM -0800, Mukesh R wrote:
> > > > > > > > > On 1/25/26 14:39, Stanislav Kinsburskii wrote:
> > > > > > > > > > On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
> > > > > > > > > > > On 1/23/26 14:20, Stanislav Kinsburskii wrote:
> > > > > > > > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > > > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > > > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > > > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > > > > > > > hypervisor deposited pages.
> > > > > > > > > > > > 
> > > > > > > > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > > > > > > > management is implemented.
> > > > > > > > > > > > 
> > > > > > > > > > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >        drivers/hv/Kconfig |    1 +
> > > > > > > > > > > >        1 file changed, 1 insertion(+)
> > > > > > > > > > > > 
> > > > > > > > > > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > > > > > > > > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > > > > > > > > > > --- a/drivers/hv/Kconfig
> > > > > > > > > > > > +++ b/drivers/hv/Kconfig
> > > > > > > > > > > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > > > > > > > > > > >        	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > > > > > > > > > > >        	# no particular order, making it impossible to reassemble larger pages
> > > > > > > > > > > >        	depends on PAGE_SIZE_4KB
> > > > > > > > > > > > +	depends on !KEXEC
> > > > > > > > > > > >        	select EVENTFD
> > > > > > > > > > > >        	select VIRT_XFER_TO_GUEST_WORK
> > > > > > > > > > > >        	select HMM_MIRROR
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
> > > > > > > > > > > implying that crash dump might be involved. Or did you test kdump
> > > > > > > > > > > and it was fine?
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Yes, it will. Crash kexec depends on normal kexec functionality, so it
> > > > > > > > > > will be affected as well.
> > > > > > > > > 
> > > > > > > > > So not sure I understand the reason for this patch. We can just block
> > > > > > > > > kexec if there are any VMs running, right? Doing this would mean any
> > > > > > > > > further developement would be without a ver important and major feature,
> > > > > > > > > right?
> > > > > > > > 
> > > > > > > > This is an option. But until it's implemented and merged, a user mshv
> > > > > > > > driver gets into a situation where kexec is broken in a non-obvious way.
> > > > > > > > The system may crash at any time after kexec, depending on whether the
> > > > > > > > new kernel touches the pages deposited to hypervisor or not. This is a
> > > > > > > > bad user experience.
> > > > > > > 
> > > > > > > I understand that. But with this we cannot collect core and debug any
> > > > > > > crashes. I was thinking there would be a quick way to prohibit kexec
> > > > > > > for update via notifier or some other quick hack. Did you already
> > > > > > > explore that and didn't find anything, hence this?
> > > > > > > 
> > > > > > 
> > > > > > This quick hack you mention isn't quick in the upstream kernel as there
> > > > > > is no hook to interrupt kexec process except the live update one.
> > > > > 
> > > > > That's the one we want to interrupt and block right? crash kexec
> > > > > is ok and should be allowed. We can document we don't support kexec
> > > > > for update for now.
> > > > > 
> > > > > > I sent an RFC for that one but given todays conversation details is
> > > > > > won't be accepted as is.
> > > > > 
> > > > > Are you taking about this?
> > > > > 
> > > > >           "mshv: Add kexec safety for deposited pages"
> > > > > 
> > > > 
> > > > Yes.
> > > > 
> > > > > > Making mshv mutually exclusive with kexec is the only viable option for
> > > > > > now given time constraints.
> > > > > > It is intended to be replaced with proper page lifecycle management in
> > > > > > the future.
> > > > > 
> > > > > Yeah, that could take a long time and imo we cannot just disable KEXEC
> > > > > completely. What we want is just block kexec for updates from some
> > > > > mshv file for now, we an print during boot that kexec for updates is
> > > > > not supported on mshv. Hope that makes sense.
> > > > > 
> > > > 
> > > > The trade-off here is between disabling kexec support and having the
> > > > kernel crash after kexec in a non-obvious way. This affects both regular
> > > > kexec and crash kexec.
> > > 
> > > crash kexec on baremetal is not affected, hence disabling that
> > > doesn't make sense as we can't debug crashes then on bm.
> > > 
> > 
> > Bare metal support is not currently relevant, as it is not available.
> > This is the upstream kernel, and this driver will be accessible to
> > third-party customers beginning with kernel 6.19 for running their
> > kernels in Azure L1VH, so consistency is required.
> 
> Well, without crashdump support, customers will not be running anything
> anywhere.

This is my concern too. I don't think customers will be particularly
happy that kexec doesn't work with our driver.

Thanks,
Anirudh

> 
> Thanks,
> -Mukesh
> 
> > Thanks,
> > Stanislav
> > 
> > > Let me think and explore a bit, and if I come up with something, I'll
> > > send a patch here. If nothing, then we can do this as last resort.
> > > 
> > > Thanks,
> > > -Mukesh
> > > 
> > > 
> > > > It?s a pity we can?t apply a quick hack to disable only regular kexec.
> > > > However, since crash kexec would hit the same issues, until we have a
> > > > proper state transition for deposted pages, the best workaround for now
> > > > is to reset the hypervisor state on every kexec, which needs design,
> > > > work, and testing.
> > > > 
> > > > Disabling kexec is the only consistent way to handle this in the
> > > > upstream kernel at the moment.
> > > > 
> > > > Thanks, Stanislav
> > > > 
> > > > 
> > > > > Thanks,
> > > > > -Mukesh
> > > > > 
> > > > > 
> > > > > 
> > > > > > Thanks,
> > > > > > Stanislav
> > > > > > 
> > > > > > > Thanks,
> > > > > > > -Mukesh
> > > > > > > 
> > > > > > > > Therefor it should be explicitly forbidden as it's essentially not
> > > > > > > > supported yet.
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > Stanislav
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > Thanks,
> > > > > > > > > > Stanislav
> > > > > > > > > > 
> > > > > > > > > > > Thanks,
> > > > > > > > > > > -Mukesh
> 

