Return-Path: <linux-hyperv+bounces-6515-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A912B23988
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Aug 2025 22:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7DE7ADE98
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Aug 2025 20:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32962D061C;
	Tue, 12 Aug 2025 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE/ROOdy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5312D0606;
	Tue, 12 Aug 2025 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028960; cv=none; b=j4BztiyTqKmdxsMduRZK3bwLJ+UcR3ZoT9r7xTanPNK667rHpy2czqo87jfjeU+QVkQovFyJpIqAKQReWv4giuhHD/u4Mk26kjd22y78KYEJEe3I42KkggsP/GpPrirjJ+hch0FnKuYzi8UPNRBTp7g4g/pfl6j0J+3t3hmhg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028960; c=relaxed/simple;
	bh=0RsBwmg31EpE24cEA4dj2/p45i8WLilyQ0OfnZkcq3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/Wlad9azPwSDrev2dEG28x6L32h20kuJzOV6ruX+AuTXSaWBw/lQp7WQ0inLoguMMeiz299IuV6rqjB1HWGKoFPKbtxgOFkO3YVrVpYszrqwaNXWAx4/zzi58JzNT5HU8uPe9HiFKzi5yU/woUeFYvYgxmpSMfjjmOx8LuAcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE/ROOdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C41C4CEF0;
	Tue, 12 Aug 2025 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755028960;
	bh=0RsBwmg31EpE24cEA4dj2/p45i8WLilyQ0OfnZkcq3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YE/ROOdydf6CzYft0e3Ph0rVzrzexhYZIEGIz9dCydKDct+KwkAHX8GP8PsO1Y/oY
	 vriYgbXKdKnMc0Px3ukKCRrchfks9P1QVVYfkIJIeYSGcfOc2PN2i7hTEFSV56AlQP
	 fT+iSqijSoJEEtH+h/zMFAi4sT9ivMTQ63WJcD58V2BzWxOYdccIuyZMjrz+Vlivfa
	 q8zjVUbi2oah6H2cvKfzCY/hu6p5n5/bQu8OegH08JOMZkK6IcZ6rARLjwpNjDLqS+
	 vfJLO0qK/jj6peXTivNp0PbsATDZl/AQ+EMmwWfChRTvrUABAng6myV0fmKaUDrUy1
	 Lf6eQ9WZ2HN0A==
Date: Tue, 12 Aug 2025 20:02:38 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: mhklinux@outlook.com, Wei Liu <wei.liu@kernel.org>,
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
Subject: Re: [PATCH v2] clocksource: hyper-v: Skip unnecessary checks for the
 root partition
Message-ID: <aJud3lUtbtNo9R2K@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250812194846.2647201-1-wei.liu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812194846.2647201-1-wei.liu@kernel.org>

On Tue, Aug 12, 2025 at 07:48:45PM +0000, Wei Liu wrote:
> The HV_ACCESS_TSC_INVARIANT bit is always zero when Linux runs as the
> root partition. The root partition will see directly what the hardware
> provides.
> 
> The old logic in ms_hyperv_init_platform caused the native TSC clock
> source to be incorrectly marked as unstable on x86. Fix it.
> 
> Skip the unnecessary checks in code for the root partition. Add one
> extra comment in code to clarify the behavior.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v2: update the commit message and comments
> ---
>  arch/x86/kernel/cpu/mshyperv.c     | 11 ++++++++++-
>  drivers/clocksource/hyperv_timer.c | 10 +++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index c78f860419d6..25773af116bc 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -565,6 +565,11 @@ static void __init ms_hyperv_init_platform(void)
>  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
>  #endif
>  #endif
> +	/*
> +	 * HV_ACCESS_TSC_INVARIANT is always zero for the root partition. Root
> +	 * partition doesn't need to write to synthetic MSR to enable invariant
> +	 * TSC feature. It sees what the hardware provides.
> +	 */
>  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
>  		/*
>  		 * Writing to synthetic MSR 0x40000118 updates/changes the
> @@ -636,8 +641,12 @@ static void __init ms_hyperv_init_platform(void)
>  	 * TSC should be marked as unstable only after Hyper-V
>  	 * clocksource has been initialized. This ensures that the
>  	 * stability of the sched_clock is not altered.
> +	 *
> +	 * HV_ACCESS_TSC_INVARIANT is always zero for the root partition. No
> +	 * need to check for it.
>  	 */
> -	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
> +	if (!hv_root_partition() &&
> +	    !(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
>  
>  	hardlockup_detector_disable();
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 2edc13ca184e..ca39044a4a60 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -549,14 +549,22 @@ static void __init hv_init_tsc_clocksource(void)
>  	union hv_reference_tsc_msr tsc_msr;
>  
>  	/*
> +	 * When running as a guest partition:
> +	 *
>  	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctly
>  	 * handles frequency and offset changes due to live migration,
>  	 * pause/resume, and other VM management operations.  So lower the
>  	 * Hyper-V Reference TSC rating, causing the generic TSC to be used.
>  	 * TSC_INVARIANT is not offered on ARM64, so the Hyper-V Reference
>  	 * TSC will be preferred over the virtualized ARM64 arch counter.
> +	 *
> +	 * When running as the root partition:
> +	 *
> +	 * There is no HV_ACCESS_TSC_INVARIANT feature. Skip the unnecessary
> +	 * check.

This comment needs to be changed.

	 * There is no HV_ACCESS_TSC_INVARIANT feature. Always lower the
	 * rating of the Hyper-V Reference TSC.

>  	 */
> -	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> +	if ((ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) ||
> +	    hv_root_partition()) {
>  		hyperv_cs_tsc.rating = 250;
>  		hyperv_cs_msr.rating = 245;
>  	}
> -- 
> 2.43.0
> 

