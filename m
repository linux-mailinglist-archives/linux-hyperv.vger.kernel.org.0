Return-Path: <linux-hyperv+bounces-6509-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D2AB1EF57
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Aug 2025 22:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5435A42AE
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Aug 2025 20:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A5822068F;
	Fri,  8 Aug 2025 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izoAwczS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7411F2BBB;
	Fri,  8 Aug 2025 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684366; cv=none; b=P5qOPbuBymuBc3C6LfL7LbT9nVuDS3k52xZ3Mxst/9k8jESLjbFYFOy1/83mS2Rti0ZGblFlBaef2B+fU4PwRD/4894yZw1/grecemVxi+smb1fe8ZdaOYzmY9TonDv5pK8SsLCbtGtoPN2jv36wvJF3cXyhRH7Xkbe3zJJv0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684366; c=relaxed/simple;
	bh=pWKT3K+8gMimKus0ATVq4Jop8KpQJ6hmcDT9wrHbZ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FigjjdjaY4h/6ZDZNVIuGuzR8U+itkWdmKMyAMqx5rZXT27XziOG17wjRiV3Y/EjnjzmzZg5f4ep/H4LCQVGPTVWfxaomtmaGlGERAU3yCzgWWiVZL5tGaWA2G5HbjvkNXzffKpz93b8pTw68XSkXODYmSw60YYp2+WY8k1klA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izoAwczS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C08C4CEED;
	Fri,  8 Aug 2025 20:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754684365;
	bh=pWKT3K+8gMimKus0ATVq4Jop8KpQJ6hmcDT9wrHbZ8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izoAwczSMZFX47afiSPZBAQxHlyNlYQuLrRqGMa5uI7r+s7zciC2B9OWQs8sK3J4G
	 RRWqehMm+S+T+E84v3v5JMtOw3+An+yJWb+FKUmHmFBJe26Nevdp2ubTNCiJa478IO
	 EL8sX7iT2fguwMrYq+oe8Pauxc7lHWPHMsZlfcq+9VeukQIu8gJiDJBzyokzLOTNw9
	 MDEq3Gw4Yc47P7aw/BBCWXnbrciJ8AWKfCn10QVuVUMTITuQgS856tgp1glII6k0dS
	 XV0/LlXf0k4aYDWz6n66r3rf6yrS/NQjdSjN+3ah3V0pTrKvKmCzekEYDwnuMR8ZbS
	 pSemDHlh0UiJA==
Date: Fri, 8 Aug 2025 20:19:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource: hyper-v: Prefer architecture counter when
 running as root partition
Message-ID: <aJZbzDgIHR7_dowJ@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250807165846.1804541-1-wei.liu@kernel.org>
 <SN6PR02MB41578685EF8F664D77DF2156D42CA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41578685EF8F664D77DF2156D42CA@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Aug 07, 2025 at 08:27:32PM +0000, Michael Kelley wrote:
> From: wei.liu@kernel.org <wei.liu@kernel.org> Sent: Thursday, August 7, 2025 9:59 AM
> > 
> > There is no HV_ACCESS_TSC_INVARIANT bit when Linux runs as the root
> > partition. 
> 
> Some clarifying questions here: When you say "there is no
> HV_ACCESS_TSC_INVARIANT bit", does that mean that bit 15 of the
> HV_PARTITION_PRIVILEGE_MASK is just unused and undefined?

The HV_ACCESS_TSC_INVARIANT bit is still defined, but it is always zero
for the root partition. I can modify the commit message and code comment
to clarify that.

> 
> And what is the behavior if the root partition writes to
> HV_X64_MSR_TSC_INVARIANT_CONTROL? In a normal x86 guest,
> HV_X64_MSR_TSC_INVARIANT_CONTROL determines whether
> CPUID 0x80000007/EDX bit 8 is set. What will the root partition see
> for CPUID 0x80000007/EDX bit 8? Whatever the underlying hardware
> provides? See also the comment in ms_hyperv_init_platform().
> 

The root partition sees whatever the underlying hardware provides. It
doesn't need to write write to that MSR.

I think it should be fine to skip the code in ms_hyperv_init_platform().

Thanks,
Wei

> Michael
> 
> > The old logic caused the native TSC clock source to be
> > incorrectly marked as unstable on x86.
> > 
> > The clock source driver runs on both x86 and ARM64. Change it to prefer
> > architectural counter when it runs on Linux root.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> > Cc: Michael Kelley <mhklinux@outlook.com>
> > 
> > Pending further testing.
> > 
> > The preference of architectural counter over Hyper-V Reference TSC for
> > Linux root is confirmed by the hypervisor team.
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c     |  6 +++++-
> >  drivers/clocksource/hyperv_timer.c | 10 +++++++++-
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index fd708180d2d9..1713545dcf4a 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -966,8 +966,12 @@ static void __init ms_hyperv_init_platform(void)
> >  	 * TSC should be marked as unstable only after Hyper-V
> >  	 * clocksource has been initialized. This ensures that the
> >  	 * stability of the sched_clock is not altered.
> > +	 *
> > +	 * The root partition doesn't see HV_ACCESS_TSC_INVARIANT.
> > +	 * No need to check for it.
> >  	 */
> > -	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
> > +	if (!hv_root_partition() &&
> > +	    !(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
> >  		mark_tsc_unstable("running on Hyper-V");
> > 
> >  	hardlockup_detector_disable();
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> > index f6415e726e96..59c3e09f1961 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -534,14 +534,22 @@ static void __init hv_init_tsc_clocksource(void)
> >  	union hv_reference_tsc_msr tsc_msr;
> > 
> >  	/*
> > +	 * When running as a guest partition:
> > +	 *
> >  	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctly
> >  	 * handles frequency and offset changes due to live migration,
> >  	 * pause/resume, and other VM management operations.  So lower the
> >  	 * Hyper-V Reference TSC rating, causing the generic TSC to be used.
> >  	 * TSC_INVARIANT is not offered on ARM64, so the Hyper-V Reference
> >  	 * TSC will be preferred over the virtualized ARM64 arch counter.
> > +	 *
> > +	 * When running as the root partition:
> > +	 *
> > +	 * There is no HV_ACCESS_TSC_INVARIANT feature. Always prefer the
> > +	 * architectural defined counter over the Hyper-V Reference TSC.
> >  	 */
> > -	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> > +	if ((ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) ||
> > +	    hv_root_partition()) {
> >  		hyperv_cs_tsc.rating = 250;
> >  		hyperv_cs_msr.rating = 245;
> >  	}
> > --
> > 2.43.0
> 

