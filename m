Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5188668E45D
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 00:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBGXYv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 18:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBGXYt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 18:24:49 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CFCE3E638;
        Tue,  7 Feb 2023 15:24:49 -0800 (PST)
Received: from [192.168.0.5] (unknown [71.212.161.12])
        by linux.microsoft.com (Postfix) with ESMTPSA id 265A720C7E37;
        Tue,  7 Feb 2023 15:24:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 265A720C7E37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675812288;
        bh=I4eU/B+eUpOQ0C++6dTTklvwVlqpMxmEoE1l46hJVAE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OhoyWI+iHqIqZRDG22xZytDnxw8yk6e/6xVmPzuSvgq0C2dneicU+5uLuCKvqsh2E
         yZO1ZDNEXNnYJOrQsyLb4Em0R4m+6b+nSU7vaW1kUWu/DXHt0e6g8lgRq8KGR0bbry
         FT0fDbDBWLhkfb/4+uYSZSKyZvSeIjbQ+Nd/EKgk=
Message-ID: <b8a0e0b7-26dc-cc80-b0f4-104d37ea427d@linux.microsoft.com>
Date:   Tue, 7 Feb 2023 15:24:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/hyperv: Pass on the lpj value from host to guest
Content-Language: en-US
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <167571656510.2157946.174424531449774007.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <167571656510.2157946.174424531449774007.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/6/2023 12:49 PM, Stanislav Kinsburskii wrote:
> From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> 
> And have it preset.
> This change allows to significantly reduce time to bring up guest SMP
> configuration as well as make sure the guest won't get inaccurate
> calibration results due to "noisy neighbour" situation.
> 
> Below are the numbers for 16 VCPU guest before the patch (~1300 msec)
> 
> [    0.562938] x86: Booting SMP configuration:
> ...
> [    1.859447] smp: Brought up 1 node, 16 CPUs
> 
> and after the patch (~130 msec):
> 
> [    0.445079] x86: Booting SMP configuration:
> ...
> [    0.575035] smp: Brought up 1 node, 16 CPUs
> 
> This change is inspired by commit 0293615f3fb9 ("x86: KVM guest: use
> paravirt function to calculate cpu khz").
> 
> Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Haiyang Zhang <haiyangz@microsoft.com>
> CC: Wei Liu <wei.liu@kernel.org>
> CC: Dexuan Cui <decui@microsoft.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: x86@kernel.org
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: linux-hyperv@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kernel/cpu/mshyperv.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index dedec2f23ad1..0282b2e96cc2 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -320,6 +320,21 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>  }
>  #endif
>  
> +static void __init __maybe_unused hv_preset_lpj(void)
> +{
> +	unsigned long khz;
> +	u64 lpj;
> +
> +	if (!x86_platform.calibrate_tsc)
> +		return;
> +
> +	khz = x86_platform.calibrate_tsc();
> +
> +	lpj = ((u64)khz * 1000);
> +	do_div(lpj, HZ);
> +	preset_lpj = lpj;
> +}
> +
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax;
> @@ -521,6 +536,12 @@ static void __init ms_hyperv_init_platform(void)
>  
>  	/* Register Hyper-V specific clocksource */
>  	hv_init_clocksource();
> +
> +	/*
> +	 * Preset lpj to make calibrate_delay a no-op, which is turn helps to
> +	 * speed up secondary cores initialization.
> +	 */
> +	hv_preset_lpj();
>  #endif
>  	/*
>  	 * TSC should be marked as unstable only after Hyper-V
> 

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
