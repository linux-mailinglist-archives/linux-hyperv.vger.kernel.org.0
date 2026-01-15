Return-Path: <linux-hyperv+bounces-8309-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C35BD22CD2
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 08:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20E4E300CACE
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 07:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93774313520;
	Thu, 15 Jan 2026 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVI+rOxJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB772236EB;
	Thu, 15 Jan 2026 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768461911; cv=none; b=TnNBFqfRiFucuipQSrkvLNZFxD4FdmYhMA0qn4RIxH5EojKN0a3p9GROz6pQ1DFINzDuJd9tV+7Fvx6CgUy4liPKdKJViDskgZysKQd0iR0j2NV4ew1M56hxB2TwrwUXYrHMGUliqHnRY1giClonwiwumcXbULdqS6YRLARnycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768461911; c=relaxed/simple;
	bh=uME2rQ/uG6dlrn2JyRS9pqjqO/BF0yo40+3I4lfaohI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqQQPlwGa66xtEXzm6fohvQ4IA/zNgJXV6hXiufc0WnZVRDLhj44u0Z1PRIBYzRy/0uEOGpKM3hnJwd/A0IFf7wjyhc+M3vn/r/CcHt278+HRt/+j0FAXkcQCkpFL18IElF1FMPMtaeg6V1X5lWP2UQPltvPy0vUgPZ4o9hkSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVI+rOxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD555C116D0;
	Thu, 15 Jan 2026 07:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768461911;
	bh=uME2rQ/uG6dlrn2JyRS9pqjqO/BF0yo40+3I4lfaohI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVI+rOxJG8p2PHKAfeOo88PH2u+XNHx8ABpWFoBtuEFgfAUkK2ry0K08WUwel/QYn
	 n61CyDtX6soI8USvzds/vxxJD+dmeTV50Nan3FuqgNza2KWqGAQ6/xMFQ13/pXfGRG
	 5zceen4pXIybb9s8cUC9iZakZU/+78WMfB65E+AXZPjjVEV2fuPlurJxVXABdnnDSX
	 iGIZUhbsApBtFmNzcyNDhnC1qMg5S1tO360jMkvQ3xqeMWcK/5npfSp58q+ivcySxt
	 3/abfW7BcjCjHc5NBQ/pEgYzxtpTNb82V2w089SHAUOlTSiv+RLFiKs+z1q9TydnN5
	 1u47U8uzBkxzw==
Date: Thu, 15 Jan 2026 07:25:09 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v1] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Message-ID: <20260115072509.GF3557088@liuwe-devbox-debian-v2.local>
References: <20260102220208.862818-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102220208.862818-1-mrathor@linux.microsoft.com>

On Fri, Jan 02, 2026 at 02:02:08PM -0800, Mukesh Rathor wrote:
> MSVC compiler, used to compile the Microsoft Hyper-V hypervisor currently,
> has an assert intrinsic that uses interrupt vector 0x29 to create an
> exception. This will cause hypervisor to then crash and collect core. As
> such, if this interrupt number is assigned to a device by linux and the
> device generates it, hypervisor will crash. There are two other such
> vectors hard coded in the hypervisor, 0x2C and 0x2D for debug purposes.
> Fortunately, the three vectors are part of the kernel driver space and
> that makes it feasible to reserve them early so they are not assigned
> later.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
> 
> v1: Add ifndef CONFIG_X86_FRED (thanks hpa)
> 
>  arch/x86/kernel/cpu/mshyperv.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 579fb2c64cfd..8ef4ca6733ac 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -478,6 +478,27 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  }
>  EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>  
> +#ifndef CONFIG_X86_FRED

I briefly looked up FRED and checked the code. I understand that once it
is enabled, Linux kernel doesn't setup the IDT anymore (code in
arch/x86/kernel/traps.c).

My question is, do we need to do anything when FRED is enabled?

Wei

> +/*
> + * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
> + * will crash or hang or break into debugger.
> + */
> +static void hv_reserve_irq_vectors(void)
> +{
> +	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
> +	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
> +	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
> +
> +	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
> +		BUG();
> +
> +	pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECTOR,
> +		HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);
> +}
> +#endif          /* CONFIG_X86_FRED */
> +
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax, eax;
> @@ -510,6 +531,11 @@ static void __init ms_hyperv_init_platform(void)
>  
>  	hv_identify_partition_type();
>  
> +#ifndef CONFIG_X86_FRED
> +	if (hv_root_partition())
> +		hv_reserve_irq_vectors();
> +#endif  /* CONFIG_X86_FRED */
> +
>  	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
>  		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
>  
> -- 
> 2.51.2.vfs.0.1
> 

