Return-Path: <linux-hyperv+bounces-6516-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D55B239F3
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Aug 2025 22:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D212A7BEF
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Aug 2025 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275F93594F;
	Tue, 12 Aug 2025 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PKBYSynD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C52F0693;
	Tue, 12 Aug 2025 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030617; cv=none; b=rFTL6Oqq7HUaMnJKxOJ/gZofcyZpaPrS5cbMOG+zYvgwXMF89AJake5PHE7WdwnhrO+xfE+XW95ss4P93gYKQOBf40va4oOjqut/4Wm8mmjCTnSfzLSEkaa1MiCrDh7Pho0dSG5cr2szi68lnRBkwY61RNOuAQS9WWWr3W4pc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030617; c=relaxed/simple;
	bh=lIpmLMAiZ52nvcInx8bvEbyXOzEr2wlgUxL4u7rKJSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXpzusDJZbCv8u8SzMZwbiOJIkFQaBch6VYGDn9/vMOlDw15WVkg9ku7yaxo7SHrl27p63Xl5ejfwPXA+uYQZpeD1Jfw2FVAP8qb14RRqgHQ3BivIHZ+4dP15bHeiNs4j/JitVAn9d/iEbonTsV+E6WkLQUAaNf//oyUeVrOIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PKBYSynD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.217.112] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id B2CF12119397;
	Tue, 12 Aug 2025 13:30:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2CF12119397
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755030610;
	bh=+dHVx0X/rHhwboPhpxe6uj0DRnhjEIQ93tWrA66yv4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PKBYSynDYXtU/TJg3NA96rNjFkJZ+BiZm3j0+wonLvW9BUELLe1TbHZF02STc9V9F
	 XHHVR+ZKShNMz9eiockA85kJQLyUGBf7abLJCelacEzn7JkaTxi80R+aCZuLNzgMCh
	 KuDhH3p6pHlLfarL2AJSbGHfYUWDEPrK94voDwsA=
Message-ID: <2c1fcdbb-5b50-4a41-9adf-f3b815624f81@linux.microsoft.com>
Date: Tue, 12 Aug 2025 13:30:03 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: hyper-v: Skip unnecessary checks for the
 root partition
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: mhklinux@outlook.com, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20250812194846.2647201-1-wei.liu@kernel.org>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250812194846.2647201-1-wei.liu@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/2025 2:48 PM, Wei Liu wrote:
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
>  	 */
> -	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> +	if ((ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) ||
> +	    hv_root_partition()) {
>  		hyperv_cs_tsc.rating = 250;
>  		hyperv_cs_msr.rating = 245;
>  	}

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

