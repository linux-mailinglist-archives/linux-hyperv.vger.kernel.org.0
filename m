Return-Path: <linux-hyperv+bounces-3353-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8322A9D8E78
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2024 23:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2099B168DDA
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2024 22:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DFF1C3308;
	Mon, 25 Nov 2024 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RTDRacyq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA2813C80E;
	Mon, 25 Nov 2024 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573501; cv=none; b=rrOtDLDX1TA53X+tE8MHyQ1pM//DjOfkW7nQdJZRGLkOXhg6XAdLY4X8eDn5MzRzPQTMm6Xh0b5oU46G/UmWEdZQ3IL1u6Y276z2JTfx662tKPn1glrJb138eSDZSROu7HEfesKRC4LNY+wHTnLhvZnSL4S8qAbO7QehGT/RGUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573501; c=relaxed/simple;
	bh=afqhdH/45pMsF5C8ZM612zCOoV610zVW1Lz3K8pKfLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gv+tMLYp+xoel0ty9KYCYIeih8jCRK1GBs6CVNxPZqXcRYBwbqONc2GlPtT8HamcMoJp5slwx2UYoINa/DbBJ4XED4gAlR8yWNM4BVsfj55d/NNuZ0JtcS3TL1wtmJaQjkaRypXjHdlwKbz8Bg09K6ebsaQCuq5OLhohcxO1ALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RTDRacyq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [131.107.8.116])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11A8A2054599;
	Mon, 25 Nov 2024 14:24:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11A8A2054599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732573499;
	bh=5TkZkgnvEk/iIKsKGYaK6XUWVYU8tjBHTxQq6VwmxwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTDRacyqgHH8Q6V079+mz/IsaQ7O2q8gEuB4BkKcRK2x5Y6Qv8LyCMh8e8BWxy7hz
	 OMPkEw7QkvH7JEBzJeD2TtT6nNFkqj8ZJfOEMl+3Ua4OVes2YOpnY1lqvXVBwXO2rK
	 TrXfPjnwR1RRtQ6hR3zhr1xebFkCktZQ4RHvqBAs=
Date: Mon, 25 Nov 2024 14:24:57 -0800
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
Message-ID: <20241125222457.GA28630@skinsburskii.>
References: <173143547242.3415.16207372030310222687.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB41575A98314B82C498A3D312D4592@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241120005106.GA18115@skinsburskii.>
 <SN6PR02MB4157121B6CD9F5CAAFB39637D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157121B6CD9F5CAAFB39637D4232@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Nov 22, 2024 at 06:33:12PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, November 19, 2024 4:51 PM
> > 
> > On Tue, Nov 12, 2024 at 07:48:06PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday,
> > November 12, 2024 10:18 AM
> > > >
> > > > Enable X86_FEATURE_TSC_RELIABLE by default as X86_FEATURE_TSC_RELIABLE is
> > > > independent from invariant TSC and should have never been gated by the
> > > > HV_ACCESS_TSC_INVARIANT privilege.
> > >
> > > I think originally X86_FEATURE_TSC_RELIABLE was gated by the Hyper-V
> > > TSC Invariant feature because otherwise VM live migration may cause
> > > the TSC value reported by the RDTSC/RDTSCP instruction in the guest
> > > to abruptly change frequency and value. In such cases, the TSC isn't
> > > useable by the kernel or user space.
> > >
> > > Enabling the Hyper-V TSC Invariant feature fixes that by using the
> > > hardware scaling available in more recent processors to automatically
> > > fixup the TSC value returned by RDTSC/RDTSCP in the guest.
> > >
> > > Is there a practical problem that is fixed by always enabling
> > > X86_FEATURE_TSC_RELIABLE?
> > >
> > 
> > The particular problem is that HV_ACCESS_TSC_INVARIANT is not set for the
> > nested root, which in turn leads to keeping tsc clocksource watchdog
> > thread and TSC sycn check timer around.
> 
> I have trouble keeping all the different TSC "features" conceptually
> separate. :-( The TSC frequency not changing (and the value not
> abruptly jumping?) should already be represented by
> X86_FEATURE_TSC_CONSTANT.  In the kernel, X86_FEATURE_TSC_RELIABLE
> effectively only controls whether the TSC clocksource watchdog is
> enabled, and in spite of the live migration foibles, I don't see a need
> for that watchdog in a Hyper-V VM. So maybe it's OK to always set
> X86_FEATURE_TSC_RELIABLE in a Hyper-V VM, as you have
> proposed.
> 
> The "tsc_reliable" flag is also exposed to user space as part of the
> /proc/cpuinfo "flags" output, so theoretically some user space
> program could change behavior based on that flag. But that seems
> a bit far-fetched. I know there are user space programs that check
> the CPUID INVARIANT_TSC flag to know whether they can use
> the raw RDTSC instruction output to do start/stop timing. The
> Hyper-V TSC Invariant feature makes that work correctly, even
> across live migrations.
> 

It sounds to me that if X86_FEATURE_TSC_CONSTANT is available on Hyper-V, then we
can set X86_FEATURE_TSC_RELIABLE.
Is it what you are saying?

Stanislav

> Michael
> 
> > 
> > But the live migration concern you raised is indeed still out there.
> > 
> > Thank you for the input Michael, I'll think more about it.
> > 
> > Stanislav
> > 
> > > Michael
> > >
> > > >
> > > > To elaborate, the HV_ACCESS_TSC_INVARIANT privilege allows certain types of
> > > > guests to opt-in to invariant TSC by writing the
> > > > HV_X64_MSR_TSC_INVARIANT_CONTROL register. Not all guests will have this
> > > > privilege and the hypervisor will automatically opt-in certain types of
> > > > guests (e.g. EXO partitions) to invariant TSC, but this functionality is
> > > > unrelated to the TSC reliability.
> > > >
> > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > ---
> > > >  arch/x86/kernel/cpu/mshyperv.c |    6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > > > index d18078834ded..14412afcc398 100644
> > > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > > @@ -515,7 +515,7 @@ static void __init ms_hyperv_init_platform(void)
> > > >  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
> > > >  #endif
> > > >  #endif
> > > > -	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> > > > +	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
> > > >  		/*
> > > >  		 * Writing to synthetic MSR 0x40000118 updates/changes the
> > > >  		 * guest visible CPUIDs. Setting bit 0 of this MSR  enables
> > > > @@ -526,8 +526,8 @@ static void __init ms_hyperv_init_platform(void)
> > > >  		 * is called.
> > > >  		 */
> > > >  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL,
> > HV_EXPOSE_INVARIANT_TSC);
> > > > -		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> > > > -	}
> > > > +
> > > > +	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> > > >
> > > >  	/*
> > > >  	 * Generation 2 instances don't support reading the NMI status from
> > > >
> > > >
> > >

