Return-Path: <linux-hyperv+bounces-3344-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC59D3185
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2024 01:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC1EB205CF
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2024 00:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51CC5258;
	Wed, 20 Nov 2024 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s48q4s0H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1317F7;
	Wed, 20 Nov 2024 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732063875; cv=none; b=fbqbdgKQw6eji74HJ1Y7ECYIV9CBE+ZqjFEko8BhGZtptqbn4KjVabAF7L4q+d2n64lsu1OWeXt5uJ6ga6b+WeHhGHoGgWZR1F967hyagALNrJh4o1V6Jqr0xK2aycATkPIfRTFJa3/qdjRKHpg8mAfHqBmyTkLWL2gLBHZP4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732063875; c=relaxed/simple;
	bh=ITXYUPpUHWy5EmXPbiNjlm1+CVRjgBCuDxFs4QxTYsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm/RhWa/3c6gNS1yjfiEeezVnsgsDkO492b/Cz8BXX+TCmUjnHjn95gOpqmyW7VGVvt+rR8a5Ziadjqdvd6aXsz6CD0jzxZCH8AA+HgPgYk9lVpLVwuKpwcRkn6GLve3fDIfOLJzU+EMK2eJS42crPMWohc2aZb1/cNA+m0xK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s48q4s0H; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C7BE23717FF;
	Tue, 19 Nov 2024 16:51:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C7BE23717FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732063868;
	bh=o+BLXsaJGOxlDDduXKTZxgj0ttDwAYLb8xvpFuc3hl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s48q4s0H8cV4w7FYlfj30eePt1cpoadmyIf8AlLxRPXwxBYFZKAxfb2eCwsG7dpxN
	 +vd7bY5UYrwu9Ur68HgoM/AAGEgNVxyRywDiRZmCOgqHQ3dqRcdOD/aHHyKVnUS7lC
	 kk8BYnqJ9xmhVCud9Ms7f7MB8pJ+MsTKXJ1v5Kr8=
Date: Tue, 19 Nov 2024 16:51:06 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyperv: Set X86_FEATURE_TSC_RELIABLE unconditionally
Message-ID: <20241120005106.GA18115@skinsburskii.>
References: <173143547242.3415.16207372030310222687.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB41575A98314B82C498A3D312D4592@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41575A98314B82C498A3D312D4592@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Nov 12, 2024 at 07:48:06PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, November 12, 2024 10:18 AM
> > 
> > Enable X86_FEATURE_TSC_RELIABLE by default as X86_FEATURE_TSC_RELIABLE is
> > independent from invariant TSC and should have never been gated by the
> > HV_ACCESS_TSC_INVARIANT privilege.
> 
> I think originally X86_FEATURE_TSC_RELIABLE was gated by the Hyper-V
> TSC Invariant feature because otherwise VM live migration may cause
> the TSC value reported by the RDTSC/RDTSCP instruction in the guest
> to abruptly change frequency and value. In such cases, the TSC isn't
> useable by the kernel or user space.
> 
> Enabling the Hyper-V TSC Invariant feature fixes that by using the
> hardware scaling available in more recent processors to automatically
> fixup the TSC value returned by RDTSC/RDTSCP in the guest.
> 
> Is there a practical problem that is fixed by always enabling
> X86_FEATURE_TSC_RELIABLE?
> 

The particular problem is that HV_ACCESS_TSC_INVARIANT is not set for the
nested root, which in turn leads to keeping tsc clocksource watchdog
thread and TSC sycn check timer around.

But the live migration concern you raised is indeed still out there.

Thank you for the input Michael, I'll think more about it.

Stanislav

> Michael
> 
> > 
> > To elaborate, the HV_ACCESS_TSC_INVARIANT privilege allows certain types of
> > guests to opt-in to invariant TSC by writing the
> > HV_X64_MSR_TSC_INVARIANT_CONTROL register. Not all guests will have this
> > privilege and the hypervisor will automatically opt-in certain types of
> > guests (e.g. EXO partitions) to invariant TSC, but this functionality is
> > unrelated to the TSC reliability.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index d18078834ded..14412afcc398 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -515,7 +515,7 @@ static void __init ms_hyperv_init_platform(void)
> >  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
> >  #endif
> >  #endif
> > -	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> > +	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
> >  		/*
> >  		 * Writing to synthetic MSR 0x40000118 updates/changes the
> >  		 * guest visible CPUIDs. Setting bit 0 of this MSR  enables
> > @@ -526,8 +526,8 @@ static void __init ms_hyperv_init_platform(void)
> >  		 * is called.
> >  		 */
> >  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, HV_EXPOSE_INVARIANT_TSC);
> > -		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> > -	}
> > +
> > +	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> > 
> >  	/*
> >  	 * Generation 2 instances don't support reading the NMI status from
> > 
> > 
> 

