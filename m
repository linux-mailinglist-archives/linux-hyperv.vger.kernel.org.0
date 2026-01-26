Return-Path: <linux-hyperv+bounces-8528-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNs3Bn7Td2mFlwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8528-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 21:50:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3BB8D484
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 21:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE6EB305D6C9
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847BC2D8382;
	Mon, 26 Jan 2026 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mbRsZlpt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518BC2D7DFE;
	Mon, 26 Jan 2026 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460407; cv=none; b=qujvxqUP1wz05eDp/2HEL5QTFjbNTFPy+i4osJhNKPUYK2uutwSrJ0pUKbluFvuoJ28UtC88mYjAiatar+Ef6g2ErHQb2ylQvgSdOyrWUsa5rbmxA8pwBwsd8NjDyy+2VuHIK+2onyQXVKEW11A2FtnbmqW6Jnez9cbvFqqx4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460407; c=relaxed/simple;
	bh=/Rt3uFgkEFvsJSuQhBDn6jiR3OsdxS1YKHgUSbmeIA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZ/2qJALWa71omyRuaVCWZOmQ4VXKc+f3kPVm2OJ3gBVECO23y15MX1OYdakhRIjv72kZNTF7kkEg0Rf0H+CAnZC8FdgWqeYXPZAKKdnMeiGKV1R4an+mcqimmj7YW2Efk4oRxwdGgwxIDE3S3r/1UL9qkpzwV+SFisxe23AiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mbRsZlpt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C630320B7165;
	Mon, 26 Jan 2026 12:46:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C630320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769460405;
	bh=iF2f2ql0FFriZuZkNbddybQR7oFP1PFZ4G3/LKW5c9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbRsZlpt0ITUS5IhH+eleS3f+Agfs3ini8ZcXPI04jsSOeyMpwVdaVE+OhCHweR0g
	 YImMU7ZE7C2vLKQtxoGydwvLSWTQwiaqkAOXDXt2xnE1vT1Mwa57ayy1q6XSWuJPLO
	 /Ml4AZfaIMzLFlP2UDO+I6ucISBG9cFK6Cdf8wSg=
Date: Mon, 26 Jan 2026 12:46:44 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXfStKqKiSSHEmXj@skinsburskii.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8528-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 6A3BB8D484
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > runtime and never withdraws them. This creates a fundamental incompatibility
> > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > hypervisor deposited pages.
> > 
> > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > management is implemented.
> 
> Someone might want to stop all guest VMs and do a kexec. Which is valid
> and would work without any issue for L1VH.
> 

No, it won't work and hypervsisor depostied pages won't be withdrawn.
Also, kernel consisntency must no depend on use space behavior. 

> Also, I don't think it is reasonable at all that someone needs to
> disable basic kernel functionality such as kexec in order to use our
> driver.
> 

It's a temporary measure until proper page lifecycle management is
supported in the driver.
Mutual exclusion of the driver and kexec is given and thus should be
expclitily stated in the Kconfig.

Thanks,
Stanislav

> Thanks,
> Anirudh.
> 
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 7937ac0cbd0f..cfd4501db0fa 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -74,6 +74,7 @@ config MSHV_ROOT
> >  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> >  	# no particular order, making it impossible to reassemble larger pages
> >  	depends on PAGE_SIZE_4KB
> > +	depends on !KEXEC
> >  	select EVENTFD
> >  	select VIRT_XFER_TO_GUEST_WORK
> >  	select HMM_MIRROR
> > 
> > 

