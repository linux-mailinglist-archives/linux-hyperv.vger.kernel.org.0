Return-Path: <linux-hyperv+bounces-8520-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBa+AqybdmmqSwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8520-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Jan 2026 23:39:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 895EE82B7E
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Jan 2026 23:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9AFD3000FF5
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Jan 2026 22:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E466130594E;
	Sun, 25 Jan 2026 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MayJ5bDs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2D61DDC3F;
	Sun, 25 Jan 2026 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380776; cv=none; b=nAPdbMu2c+bC2vhVHBeg007pOgOS4kz6CS+ISUAVsEZERsPm6jfdrrFKrU5idu6AjKdfqc52L31Bi/mJrOWPQ5ws+cp8MevdsgzAhmskVC3h5ORuYxKhuIeXKtuC3W3MpstPgSPS3aGakZEdhtYQ3FE/W4oHhKOF0aaK+XEqt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380776; c=relaxed/simple;
	bh=jhu9DJqPgTY03ff+1lEYw1IsDzQgd0SKeCR6vIsBbqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyI0rs83i/2H0yrXiG2TXJNYMf8HqMr7BGylSZVRHijfiNqmwlav2E+MIJtKpMOS/igi86yirzHptocnwEsUVKGUXxewWPyfJShWXoBq1LFTShAg+MiKQaiNzQNGJIhULA8ZuT5w/L0cdvtlrPvhl+Iv28+t/V4ECDW5fi5bXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MayJ5bDs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 99EA920B7165;
	Sun, 25 Jan 2026 14:39:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 99EA920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769380768;
	bh=RqynbEU7znR81N7cdEn0g1UYc1Rw1sc7myVfM3x3Zhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MayJ5bDsMmT13pnaOqMYh3+yC2G1jMLcDcddgIEvmWlmW95rNz0AtpUaQc9OFnnGj
	 s6Z48ldFVxgjNo6IQVEvSKi44aZA69zmAL5lUQ4bImsoOXuKWo3EOSFWmih6OIBplf
	 c/jkzbkGRJK5OsJ6U3zrnG8c7QSGnUb7xAw1tUoE=
Date: Sun, 25 Jan 2026 14:39:26 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXabnnCV50Thv9tZ@skinsburskii.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <549041d1-360d-d34c-4e3b-62802346acaa@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <549041d1-360d-d34c-4e3b-62802346acaa@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8520-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 895EE82B7E
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
> On 1/23/26 14:20, Stanislav Kinsburskii wrote:
> > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > runtime and never withdraws them. This creates a fundamental incompatibility
> > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > hypervisor deposited pages.
> > 
> > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > management is implemented.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >   drivers/hv/Kconfig |    1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 7937ac0cbd0f..cfd4501db0fa 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -74,6 +74,7 @@ config MSHV_ROOT
> >   	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> >   	# no particular order, making it impossible to reassemble larger pages
> >   	depends on PAGE_SIZE_4KB
> > +	depends on !KEXEC
> >   	select EVENTFD
> >   	select VIRT_XFER_TO_GUEST_WORK
> >   	select HMM_MIRROR
> > 
> > 
> 
> Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
> implying that crash dump might be involved. Or did you test kdump
> and it was fine?
> 

Yes, it will. Crash kexec depends on normal kexec functionality, so it
will be affected as well.

Thanks,
Stanislav

> Thanks,
> -Mukesh

