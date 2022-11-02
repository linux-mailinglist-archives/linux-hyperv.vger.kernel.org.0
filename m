Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8E46163A6
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 14:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiKBNRI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 09:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKBNQp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 09:16:45 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 220772AC6D;
        Wed,  2 Nov 2022 06:16:22 -0700 (PDT)
Received: from anrayabh-desk (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0E404205DA23;
        Wed,  2 Nov 2022 06:16:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E404205DA23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667394981;
        bh=NI5EroiAh9xA6O3pYot6k/iQ3uEpTCm+lukZT8/YEhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FP/hFYEBvMRMvKB4mk/8o4dX5MgYKwHHh5CoHs91U092EmCXgEonYE56CtPPLadUR
         HPMd/MikYbLm6kL2EwFOgaS3PEqpOVlADkfLn9FAKJGcxKb/BIWGLKno0GP/H4YXkb
         c9cEb0ZT9/hp7DUb8mosJ/BcIuAawgYkGMijKHco=
Date:   Wed, 2 Nov 2022 18:46:14 +0530
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] drivers/clocksource/hyper-v: Introduce TSC MSR
 register structure
Message-ID: <Y2Jtnsh1Dcjwlrlz@anrayabh-desk>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166732386986.9827.12356845572628674464.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166732386986.9827.12356845572628674464.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Please update the patch title since this doesn't introduce the TSC MSR
register structure.

Thanks,
Anirudh.

On Tue, Nov 01, 2022 at 05:31:09PM +0000, Stanislav Kinsburskii wrote:
> From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> 
> And rework the code to use it instead of the physical address.
> This is a cleanup and precursor patch for upcoming support for TSC page
> mapping into hyper-v root partition.
> 
> Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Haiyang Zhang <haiyangz@microsoft.com>
> CC: Wei Liu <wei.liu@kernel.org>
> CC: Dexuan Cui <decui@microsoft.com>
> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: linux-hyperv@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/clocksource/hyperv_timer.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index c4dbf40a3d3e..d447bc99a399 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -367,6 +367,12 @@ static union {
>  } tsc_pg __aligned(PAGE_SIZE);
>  
>  static struct ms_hyperv_tsc_page *tsc_page = &tsc_pg.page;
> +static unsigned long tsc_pfn;
> +
> +static unsigned long hv_get_tsc_pfn(void)
> +{
> +	return tsc_pfn;
> +}
>  
>  struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
>  {
> @@ -408,13 +414,12 @@ static void suspend_hv_clock_tsc(struct clocksource *arg)
>  
>  static void resume_hv_clock_tsc(struct clocksource *arg)
>  {
> -	phys_addr_t phys_addr = virt_to_phys(tsc_page);
>  	union hv_reference_tsc_msr tsc_msr;
>  
>  	/* Re-enable the TSC page */
>  	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
>  	tsc_msr.enable = 1;
> -	tsc_msr.pfn = __phys_to_pfn(phys_addr);
> +	tsc_msr.pfn = tsc_pfn;
>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>  
> @@ -498,7 +503,6 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
>  static bool __init hv_init_tsc_clocksource(void)
>  {
>  	union hv_reference_tsc_msr tsc_msr;
> -	phys_addr_t	phys_addr;
>  
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
> @@ -523,7 +527,7 @@ static bool __init hv_init_tsc_clocksource(void)
>  	}
>  
>  	hv_read_reference_counter = read_hv_clock_tsc;
> -	phys_addr = virt_to_phys(hv_get_tsc_page());
> +	tsc_pfn = __phys_to_pfn(virt_to_phys(tsc_page));
>  
>  	/*
>  	 * The Hyper-V TLFS specifies to preserve the value of reserved
> @@ -534,7 +538,7 @@ static bool __init hv_init_tsc_clocksource(void)
>  	 */
>  	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
>  	tsc_msr.enable = 1;
> -	tsc_msr.pfn = __phys_to_pfn(phys_addr);
> +	tsc_msr.pfn = tsc_pfn;
>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
>  
>  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
> 
