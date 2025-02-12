Return-Path: <linux-hyperv+bounces-3930-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E7DA32DF7
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 18:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D080D3A7090
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 17:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C359D25C6FE;
	Wed, 12 Feb 2025 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GLpuORcJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEAE2586C6;
	Wed, 12 Feb 2025 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382888; cv=none; b=Z1Yzg9KtsJpITVvt6IZJ/NaHWsZqd6d+m+qRLtk3FKsQKxNn+imIX2qFbwOSVmeBPWl9MBGlXDtp80gJcYp40VJl7cZhJvLbvxdkIiTvMOKR/KpfArjMGPsQf1ziRUieETnFuU+WFcMUyf0TD9XBH9gAyuKs86znBqDvPFH4idI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382888; c=relaxed/simple;
	bh=x9ISrJ7Gdk2XHi0VniGAHfo5QA2NIH+n8e1czOikANU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K35X4KEbhOZtsyhZwEVut8g/q0XVM442EEP9HVKrEqXOcPbBN5C3mUGZl3rOPaJXgkx2IFC4uuqjNNEzj2CPy6bUdLrhK/Re5FlfPXtwb3gOqEGcm1F0ZQQTAcgmoAEZRIk4usAjkHPmcc9HS1yFTO7iXVBhltlxDCMrtC0RmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GLpuORcJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id D2206203F3C3; Wed, 12 Feb 2025 09:54:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2206203F3C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739382885;
	bh=kCDAn1dUHH9zvvIMxLPjNOSM49m/EMWQnwmPYjynmYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLpuORcJWKTVR/06dwvY/iaOgWs2sr8tMEw+4AYtj/BoT4n2pF6i/GisM4vjuXvp6
	 Kydr+Nyu0G94WfGisliIrhLmRlsQGOvklfP0hRCjfSqySX0orATmer+Pj7eGGsauVD
	 HQrAhuAFgvNGK0pi4x4BdfIf6agw3QyO70bt2Cgc=
Date: Wed, 12 Feb 2025 09:54:45 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Roman Kisel <romank@linux.microsoft.com>, bp@alien8.de,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mingo@redhat.com, tglx@linutronix.de, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH hyperv-next 0/2] x86/hyperv: VTL mode reboot fixes
Message-ID: <20250212175445.GA19243@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250117210702.1529580-1-romank@linux.microsoft.com>
 <Z6wFnoK-X7i1bd9x@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6wFnoK-X7i1bd9x@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 12, 2025 at 02:21:18AM +0000, Wei Liu wrote:
> On Fri, Jan 17, 2025 at 01:07:00PM -0800, Roman Kisel wrote:
> > The first patch defines a specialized machine emergency restart
> > callback not to write to the physical address of 0x472 which is
> > what the native_machine_emergency_restart() does unconditionally.
> > 
> > I first wanted to tweak that function[1], and in the course of
> > the discussion it looked as the risks of doing that would
> > outweigh the benefit: the bare-metal systems have likely adopted
> > that behavior as a standard although I could not find any mentions
> > of that magic address in the UEFI+ACPI specification.
> > 
> > The second patch removes the need to always supply "reboot=t"
> > to the kernel command line in the OpenHCL bootloader [2]. There is
> > no other option at the moment; when/if it appears the newly added
> > callback's code can be adjusted as required.
> > 
> > It would be great to apply this to the stable tree if no concerns,
> > should apply cleanly.
> > 
> > [1] https://lore.kernel.org/all/20250109204352.1720337-1-romank@linux.microsoft.com/
> > [2] https://github.com/microsoft/openvmm/blob/7a9d0e0a00461be6e5f3267af9ea54cc7157c900/openhcl/openhcl_boot/src/main.rs#L139
> > 
> > Roman Kisel (2):
> >   x86/hyperv: VTL mode emergency restart callback
> >   x86/hyperv: VTL mode callback for restarting the system
> 
> Saurabh please review these patches. Thanks.

Hi Roman,

Thanks for the patch, few suggestions and queries:

1. Please fix the kernel bot warning
2. Cc Stable tree is not enough, you need to mention the "Fixes" tag as well
   for the commit upto where you want this patch to be backported.
3. In your 2/2 commit, you mention 'triple fault' is the only way to reboot in x86.
   Is that accurate ? Do you mean to say OpenHCL/VTL here ?
   If this behaviour is specific to OpenHCl and not VTLs in general, is there a way
   we can make these changes only for OpenHCL.
   

- Saurabh

> 
> I don't have a strong opinion on them.
> 
> > 
> >  arch/x86/hyperv/hv_vtl.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > 
> > base-commit: 2e03358be78b65d28b66e17aca9e0c8700b0df78
> > -- 
> > 2.34.1
> > 

