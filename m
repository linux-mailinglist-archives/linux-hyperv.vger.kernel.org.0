Return-Path: <linux-hyperv+bounces-3326-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E21C9C6028
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 19:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5921F218AD
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 18:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B7B20695A;
	Tue, 12 Nov 2024 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fmr2/4Es"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A6F213154;
	Tue, 12 Nov 2024 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435472; cv=none; b=P7IsxynDL0JYRAdnsl8U4aOrhaDV0eldYjvrKuS4/kAZgjpw3xQgg08czXBR2cZe187t4tcApjfpk54vWBUeFK73ZbWVjXwAhOPahMkcbp4FhxiF7JBeVU4Zu1/b0wavkLH86CPnI61wqwIJxA92NP1lFSE28r5H1VoyAQdISBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435472; c=relaxed/simple;
	bh=BR/BpzuLNMVngjfjWXUx9mQxB5t8dbtYD/styFjdNlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzarPAvjxWvXkGa+Hm06kAQ6Rfm7PxPHJ1HjuOPaJ9gzijnvfjACCGt/pxtzqAa6MxKDHBGmiL3leBQ1KUFLfXptV3EtPJPIo7+b8xuQZVdxmmvFpzUn7L7UcC6i8Qmb4vZX4VqeIS/weJGZSjXeNPQ0/oC8fJJJU2HQA0hAgl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Fmr2/4Es; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 350712383EC7;
	Tue, 12 Nov 2024 10:17:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 350712383EC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731435470;
	bh=WlNxYSWDvmbDv43LIYnQKNLWXfGngSKyXNx/SnFV2CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fmr2/4EsX9yXd9kYOgQ5k1wzaSB2VdT0K3Rg1XM7iiIvK5PyVFEyOBS+ZLW+87y2p
	 +RjJuYUQ/3VDMoDs4v+Yzyx2OXfIpjya4/ioCPSCT0xzFeVsU8XUwJokvDAN40qJeH
	 2FI3CanPqHMPxX62l4gtWMIVAiF3dXznkAo/d2JU=
Date: Tue, 12 Nov 2024 10:17:47 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, x86@kernel.org, hpa@zytor.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TFrom: Stanislav Kinsburskii
 <skinsburskii@linux.microsoft.com0
Message-ID: <20241112181747.GA21568@skinsburskii.>
References: <173143538271.3312.9979026785015274168.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173143538271.3312.9979026785015274168.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

Please disregard.

Stanislav

On Tue, Nov 12, 2024 at 06:16:26PM +0000, Stanislav Kinsburskii wrote:
> x86/hyperv: Set X86_FEATURE_TSC_RELIABLE unconditionally
> 
> Enable X86_FEATURE_TSC_RELIABLE by default as X86_FEATURE_TSC_RELIABLE is
> independent from invariant TSC and should have never been gated by the
> HV_ACCESS_TSC_INVARIANT privilege.
> 
> To elaborate, the HV_ACCESS_TSC_INVARIANT privilege allows certain types of
> guests to opt-in to invariant TSC by writing the
> HV_X64_MSR_TSC_INVARIANT_CONTROL register. Not all guests will have this
> privilege and the hypervisor will automatically opt-in certain types of
> guests (e.g. EXO partitions) to invariant TSC, but this functionality is
> unrelated to the TSC reliability.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index d18078834ded..14412afcc398 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -515,7 +515,7 @@ static void __init ms_hyperv_init_platform(void)
>  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
>  #endif
>  #endif
> -	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> +	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
>  		/*
>  		 * Writing to synthetic MSR 0x40000118 updates/changes the
>  		 * guest visible CPUIDs. Setting bit 0 of this MSR  enables
> @@ -526,8 +526,8 @@ static void __init ms_hyperv_init_platform(void)
>  		 * is called.
>  		 */
>  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, HV_EXPOSE_INVARIANT_TSC);
> -		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> -	}
> +
> +	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>  
>  	/*
>  	 * Generation 2 instances don't support reading the NMI status from
> 

