Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F191DAE3D
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2020 11:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETJCF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 May 2020 05:02:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50350 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETJCE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 May 2020 05:02:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id m12so1824294wmc.0;
        Wed, 20 May 2020 02:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K+A7ZHlJqfylmUV+J0DL1EtgFEiLTDOYa/1WHcM4PvE=;
        b=o/qDBgq3Ox5T4j5c8tTCwaPhjQOne0H4JgzrHgezSDYUv5jflRx3xUvKy+7xWjE9DZ
         +52LCNBLHaTiJQycxKKILL3kFaR2WHCakdDUCM53TU07pj7ZLs4UkfsGyuUqUGQ3alnl
         HfXp8FihwXyiYE9ZeTanC/UK6kzC93v5X0hmXr84Y21oODkPk9zcjgbwInph7ORQhwvX
         /SUhT1K6A+h3mily4oA+VWgR5Lj0NicSD/cm4PXATKEgbCV1rhXpD4sFG5pMeUVYY/2p
         ptxhBiUgRfolRNMuu+JePNe4ZEJ8F4LhU4MPZ8TiJvdq3oIPkveHl5qWR+L7uTiyxRJm
         itSQ==
X-Gm-Message-State: AOAM533d16uPw5w/ha8myBXx/+05l4EKJKTWpzy+7ywXZRfGm5iJAEU6
        fvPSpJCIbeuCnqd4nG+gJFA=
X-Google-Smtp-Source: ABdhPJxO3A4+TpSC04YOdihWMoYDnXWycqoRzuKdmNMmc1PdVMtNsOn9csLHFzscvWoyAUa6nXDtDg==
X-Received: by 2002:a1c:e188:: with SMTP id y130mr3957687wmg.105.1589965320923;
        Wed, 20 May 2020 02:02:00 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i11sm2212274wrc.35.2020.05.20.02.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 02:02:00 -0700 (PDT)
Date:   Wed, 20 May 2020 09:01:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] x86/Hyper-V: Support for free page reporting
Message-ID: <20200520090158.4x4lkbssm7ncirn7@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 19, 2020 at 06:37:57PM +0000, Sunil Muthuswamy wrote:
> Linux has support for free page reporting now (36e66c554b5c) for
> virtualized environment. On Hyper-V when virtually backed VMs are
> configured, Hyper-V will advertise cold memory discard capability,
> when supported. This patch adds the support to hook into the free
> page reporting infrastructure and leverage the Hyper-V cold memory
> discard hint hypercall to report/free these pages back to the host.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> First patch mail bounced backed. Sending it again with the email
> addresses fixed.
> ---
>  arch/x86/hyperv/hv_init.c         | 24 ++++++++
>  arch/x86/kernel/cpu/mshyperv.c    |  6 +-
>  drivers/hv/hv_balloon.c           | 93 +++++++++++++++++++++++++++++++
>  include/asm-generic/hyperv-tlfs.h | 29 ++++++++++
>  include/asm-generic/mshyperv.h    |  2 +
>  5 files changed, 152 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 624f5d9b0f79..925e2f7eb82c 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -506,3 +506,27 @@ bool hv_is_hibernation_supported(void)
>  	return acpi_sleep_state_supported(ACPI_STATE_S4);
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> +
> +u64 hv_query_ext_cap(void)
> +{
> +	u64 *cap;
> +	unsigned long flags;
> +	u64 ext_cap = 0;
> +
> +	/*
> +	 * Querying extended capabilities is an extended hypercall. Check if the
> +	 * partition supports extended hypercall, first.
> +	 */
> +	if (!(ms_hyperv.b_features & HV_ENABLE_EXTENDED_HYPERCALLS))
> +		return 0;
> +
> +	local_irq_save(flags);
> +	cap = *(u64 **)this_cpu_ptr(hyperv_pcpu_input_arg);

The cast here is not strictly needed.

> +	if (hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL, cap) ==
> +	    HV_STATUS_SUCCESS)

You're using the input page as the output parameter. Ideally we should
introduce hyperv_pcpu_output_arg page, but that would waste one page per
cpu just for this one call.

So for now I think this setup is fine, but I would like to add the
following comment.

    /*
     * Repurpose the input_arg page to accept output from Hyper-V for
     * now because this is the only call that needs output from the
     * hypervisor. It should be fixed properly by introducing an
     * output_arg page once we have more places that require output.
     */

> +		ext_cap = *cap;
> +
> +	local_irq_restore(flags);
> +	return ext_cap;
> +}
> +EXPORT_SYMBOL_GPL(hv_query_ext_cap);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index ebf34c7bc8bc..2de3f692c8bf 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -224,11 +224,13 @@ static void __init ms_hyperv_init_platform(void)
>  	 * Extract the features and hints
>  	 */
>  	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
> +	ms_hyperv.b_features = cpuid_ebx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>  
> -	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> -		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> +	pr_info("Hyper-V: features 0x%x, additional features: 0x%x, hints 0x%x, misc 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.b_features, ms_hyperv.hints,
> +		ms_hyperv.misc_features);
>  
>  	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
>  	ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 32e3bc0aa665..77be31094556 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -21,6 +21,7 @@
>  #include <linux/memory.h>
>  #include <linux/notifier.h>
>  #include <linux/percpu_counter.h>
> +#include <linux/page_reporting.h>
>  
>  #include <linux/hyperv.h>
>  #include <asm/hyperv-tlfs.h>
> @@ -563,6 +564,10 @@ struct hv_dynmem_device {
>  	 * The negotiated version agreed by host.
>  	 */
>  	__u32 version;
> +
> +#ifdef CONFIG_PAGE_REPORTING
> +	struct page_reporting_dev_info pr_dev_info;
> +#endif
>  };
>  
>  static struct hv_dynmem_device dm_device;
> @@ -1565,6 +1570,83 @@ static void balloon_onchannelcallback(void *context)
>  
>  }
>  
> +#ifdef CONFIG_PAGE_REPORTING
> +static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
> +		    struct scatterlist *sgl, unsigned int nents)
> +{
> +	unsigned long flags;
> +	struct hv_memory_hint *hint;
> +	int i;
> +	u64 status;
> +	struct scatterlist *sg;
> +
> +	WARN_ON(nents > HV_MAX_GPA_PAGE_RANGES);

Should we return -ENOSPC here?

> +	local_irq_save(flags);
> +	hint = *(struct hv_memory_hint **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	if (!hint) {
> +		local_irq_restore(flags);
> +		return -ENOSPC;
> +	}
> +
> +	hint->type = HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD;
> +	hint->reserved = 0;
> +	for (i = 0, sg = sgl; sg; sg = sg_next(sg), i++) {
> +		int order;
> +		union hv_gpa_page_range *range;
> +

Unfortunately I can't find the semantics of this hypercall in TLFS 6, so
I have a few questions here.

> +		order = get_order(sg->length);
> +		range = &hint->ranges[i];
> +		range->address_space = 0;

I guess this means all address spaces?

> +		range->page.largepage = 1;

What effect does this have? What if the page is a 4k page?

> +		range->page.additional_pages = (1ull << (order - 9)) - 1;

What is 9 here? Is there a macro name *ORDER that you can use?

Wei.
