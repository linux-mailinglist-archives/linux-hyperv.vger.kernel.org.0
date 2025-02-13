Return-Path: <linux-hyperv+bounces-3942-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF6A33D00
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2025 11:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 527167A336A
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2025 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD76E212FAC;
	Thu, 13 Feb 2025 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PK8Sk1/6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484FA212D8D;
	Thu, 13 Feb 2025 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443954; cv=none; b=XLMPN40c+kMNhRe0lKR4cB672F2Lc0gb+4a4kdRjkjo0ynvflxE9pvh2xTl/P50nmDEqept1LSGisibuNVF1gPgCoXPKKjlthjBHwuRhsBnxhtXtKAU5fSggz5z/9IFZRh5+B6sPHjab6AJltJ5Spb7OBJ7udFzX+h+P5S3QupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443954; c=relaxed/simple;
	bh=+yc9GwTQaBYF4es1DfL2R9b92YGC+f4QEaTp9dGajF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4+ScT3NtNKK2evL9Jb9lwNWDCKaO8/0ijx5AwTChjYcOjgXUawhUqRTm6tRCPi0c1YH3aXuGR2vjTjOxQ5oJ6FRlbdNZ7q79anUD9Urdu9nVcOOKuTc/kcLyqx+Un415+3tES/nsAeFVWQ215yekKI/iOsbxHAGa82uBJ44hGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PK8Sk1/6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 8FEF6203F3D5; Thu, 13 Feb 2025 02:52:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FEF6203F3D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739443952;
	bh=EMi9IVSo811Zy7wRLmEH2K6RMEia8GaQ0M9MaZ8sL6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PK8Sk1/6HzWjYkjWoKyqMjlmQUHuUzzGDFzGTbcWr3rnlgjgOEgIy5MFCWQHNlYqq
	 Cxg71ZDvT+zgJy0QtSnC4AfU1q7y/Fhz/8mS7cnC275ICzXmb3gKS4JwTm54i6bRk5
	 SkrC28/eN4jgxOO1NuLP9v35hpPG4RQbufQQq51g=
Date: Thu, 13 Feb 2025 02:52:32 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, bp@alien8.de, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
	kys@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH hyperv-next 0/2] x86/hyperv: VTL mode reboot fixes
Message-ID: <20250213105232.GA32701@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250117210702.1529580-1-romank@linux.microsoft.com>
 <Z6wFnoK-X7i1bd9x@liuwe-devbox-debian-v2>
 <20250212175445.GA19243@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <e39b1947-0ea6-4573-9b71-7c8ea6c96d8c@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39b1947-0ea6-4573-9b71-7c8ea6c96d8c@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 12, 2025 at 02:56:43PM -0800, Roman Kisel wrote:
> 
> 
> On 2/12/2025 9:54 AM, Saurabh Singh Sengar wrote:
> >On Wed, Feb 12, 2025 at 02:21:18AM +0000, Wei Liu wrote:
> [...]
> >>
> >>Saurabh please review these patches. Thanks.
> >
> >Hi Roman,
> Hi Saurabh,
> 
> >
> >Thanks for the patch, few suggestions and queries:
> >
> >1. Please fix the kernel bot warning
> Will do!
> 
> >2. Cc Stable tree is not enough, you need to mention the "Fixes" tag as well
> >    for the commit upto where you want this patch to be backported.
> Understood, thanks!
> 
> >3. In your 2/2 commit, you mention 'triple fault' is the only way to reboot in x86.
> >    Is that accurate ? Do you mean to say OpenHCL/VTL here ?
> >    If this behaviour is specific to OpenHCl and not VTLs in general, is there a way
> >    we can make these changes only for OpenHCL.
> Right, I meant OpenHCL/VTL2, thank you very much! The changes are scoped
> to running in VTLs in general at the moment. I can add a check for the
> VTL == 2 if you'd like me to.
> 
> For VTL1 (aka LVBS), maybe folks would like to do something else,
> do you happen to know? Maybe to report that to the VTL0 guest kernel
> although seems dubious: the higher VTL failed so the lights must be out
> for the lower VTLs? Or kexec?

I am not aware of LVBS plans, and as far as I consider OpenVMM the only current
user of this VTL code. I recommend keeping the code as simple as possible unless
there is a clear use case for additional complexity. It would be helpful to include
these details in a comment so that future users of this file can understand and
modify it as needed.

- Saurabh

> 
> >
> >- Saurabh
> >
> >>
> >>I don't have a strong opinion on them.
> >>
> >>>
> >>>  arch/x86/hyperv/hv_vtl.c | 31 +++++++++++++++++++++++++++++++
> >>>  1 file changed, 31 insertions(+)
> >>>
> >>>
> >>>base-commit: 2e03358be78b65d28b66e17aca9e0c8700b0df78
> >>>-- 
> >>>2.34.1
> >>>
> 
> -- 
> Thank you,
> Roman
> 

