Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44603E0E81
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 08:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhHEGlj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 02:41:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46114 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhHEGlj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 02:41:39 -0400
Received: from [192.168.1.87] (unknown [223.178.56.171])
        by linux.microsoft.com (Postfix) with ESMTPSA id C7362209DDB5;
        Wed,  4 Aug 2021 23:41:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C7362209DDB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628145685;
        bh=bxasqC6P0Nvva5TxrwG2pE0QRcDHzuqT0kjeJsO27pQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QwuKrkAVcWbIjWtac1uUOg/R8BefILIXAelMWOhnnv4BzMJuJhQVDwwOn4HEmcRYZ
         EUmEH/94W6TRrHPaHlPacVbZFznSRF2ZaafIhlD9xVNuAsTdHozQurVBeAhrbwoV2U
         VTg0HRqFV9jhf6deaslvhYRh1xNj01Q418Y0Ecb4=
Subject: Re: [PATCH] x86/Hyper-V: Initialize Hyper-V stimer after enabling
 lapic
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
References: <20210804184843.513524-1-ltykernel@gmail.com>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <db8d38c9-e11d-1abe-8617-d8a231cc22e2@linux.microsoft.com>
Date:   Thu, 5 Aug 2021 12:11:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804184843.513524-1-ltykernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 05-08-2021 00:18, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Hyper-V Isolation VM doesn't have PIT/HPET legacy timer and only
> provide stimer. Initialize Hyper-v stimer just after enabling
> lapic to avoid kernel stuck during calibrating TSC due to no
> available timer.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c      | 29 -----------------------------
>  arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6f247e7e07eb..4a643a85d570 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -271,25 +271,6 @@ static struct syscore_ops hv_syscore_ops = {
>  	.resume		= hv_resume,
>  };
>  
> -static void (* __initdata old_setup_percpu_clockev)(void);
> -
> -static void __init hv_stimer_setup_percpu_clockev(void)
> -{
> -	/*
> -	 * Ignore any errors in setting up stimer clockevents
> -	 * as we can run with the LAPIC timer as a fallback.
> -	 */
> -	(void)hv_stimer_alloc(false);
> -
> -	/*
> -	 * Still register the LAPIC timer, because the direct-mode STIMER is
> -	 * not supported by old versions of Hyper-V. This also allows users
> -	 * to switch to LAPIC timer via /sys, if they want to.
> -	 */
> -	if (old_setup_percpu_clockev)
> -		old_setup_percpu_clockev();
> -}
> -
>  static void __init hv_get_partition_id(void)
>  {
>  	struct hv_get_partition_id *output_page;
> @@ -396,16 +377,6 @@ void __init hyperv_init(void)
>  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	}
>  
> -	/*
> -	 * hyperv_init() is called before LAPIC is initialized: see
> -	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
> -	 * apic_bsp_setup() -> setup_local_APIC(). The direct-mode STIMER
> -	 * depends on LAPIC, so hv_stimer_alloc() should be called from
> -	 * x86_init.timers.setup_percpu_clockev.
> -	 */
> -	old_setup_percpu_clockev = x86_init.timers.setup_percpu_clockev;
> -	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
> -
>  	hv_apic_init();
>  
>  	x86_init.pci.arch_init = hv_pci_init;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 6b5835a087a3..dcfbd2770d7f 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -214,6 +214,20 @@ static void __init hv_smp_prepare_boot_cpu(void)
>  #endif
>  }
>  
> +static void (* __initdata old_setup_initr_mode)(void);
> +
> +static void __init hv_setup_initr_mode(void)
> +{
> +	if (old_setup_initr_mode)
> +		old_setup_initr_mode();
> +
> +	/*
> +	 * The direct-mode STIMER depends on LAPIC and so allocate
> +	 * STIMER after calling initr node callback.
> +	 */
> +	(void)hv_stimer_alloc(false);

In my understanding, in previous implementation we were ignoring the return error as there was a fallback handling for LAPIC.
However, I'm not seeing the same here, or am I missing something ?

> +}
> +
>  static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  #ifdef CONFIG_X86_64
> @@ -424,6 +438,7 @@ static void __init ms_hyperv_init_platform(void)
>  	/* Register Hyper-V specific clocksource */
>  	hv_init_clocksource();
>  #endif
> +
>  	/*
>  	 * TSC should be marked as unstable only after Hyper-V
>  	 * clocksource has been initialized. This ensures that the
> @@ -431,6 +446,13 @@ static void __init ms_hyperv_init_platform(void)
>  	 */
>  	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
> +
> +	/*
> +	 * Override initr mode callback in order to allocate STIMER
> +	 * after initalizing LAPIC.
> +	 */
> +	old_setup_initr_mode = x86_init.irqs.intr_mode_init;
> +	x86_init.irqs.intr_mode_init = hv_setup_initr_mode;
>  }
>  
>  static bool __init ms_hyperv_x2apic_available(void)
> 


Regards,

~Praveen.
