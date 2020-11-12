Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FB42B0838
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 16:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgKLPQj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 10:16:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbgKLPQh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 10:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605194195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mgdXZHtHPywKX/a9hS8LUB6+ABxOjrBQbybE/K2MyA4=;
        b=OCmNaisu3wc5+PDXrJPXF0zpWdK9V0q1yQ47xUyap2Pg5UpH2z0Q3tzO6+cLrRQ6pI0Ez5
        XAHUEmexGpQC0hYtPJPu27QEzuVRYNtzCuCoEOywF3X4pT7iqHks/XlachXZ9eXiZ45s6W
        qkeIC81jAst5+M9L8VelzhE00HMOZD8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-a6gVT2TlOX6m0HAzeoNk6Q-1; Thu, 12 Nov 2020 10:16:34 -0500
X-MC-Unique: a6gVT2TlOX6m0HAzeoNk6Q-1
Received: by mail-wr1-f69.google.com with SMTP id w17so2052044wrp.11
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 07:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mgdXZHtHPywKX/a9hS8LUB6+ABxOjrBQbybE/K2MyA4=;
        b=kXks5hAUwVMAyDxx6JeE/5hlnxvv/Qzra3jH3xDqduiy1bo9/Ie2NBCHWqT1nhut4c
         rYArPGCZatuLBoBQ2KTS015VKOHUlgd7AqOXuKepNDTOyYtYnia+dhHS0L66qNgj+Sdg
         aH1VHqDwimDWLlXewlQdcNxH8qx22ciuwT4u4fC8p6TSTdtCmwtYLm4kb2dhgOfHThci
         0za0IFwL4IjxREVUyIlB0J/9BKypChObFa2Tac+W6ZzQjo+N+Kvl0uOzfUkLEGMN31It
         8SQlIgpRQO2FeoIhd+ayRQOju2F+J6qKnVKf4Va/c1D7lyZVZIRcDdNUjUdxVlibSkQL
         Hv7g==
X-Gm-Message-State: AOAM531ThDOrCQ2guP9a6wX72wt37KfJgozIGBQ4o0bkwt2uQP+lgyVC
        A4xyY5Cp/YOTq4MDPprgB1ScCkOYM77/XKbzHojnunFs2gih44c0QFdFhYK2vrPz4kHOmvCeqyG
        ixf/rJ37O1DFxMBkYOnB9uePn
X-Received: by 2002:a05:6000:c7:: with SMTP id q7mr3765127wrx.137.1605194193097;
        Thu, 12 Nov 2020 07:16:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBsGbFGQNrYQltDNU47DH7z1aKIl9Jf7c3fN1KWHUXH5NhMqtMHL3KuLKLxVmtzHwryqqqqQ==
X-Received: by 2002:a05:6000:c7:: with SMTP id q7mr3765087wrx.137.1605194192885;
        Thu, 12 Nov 2020 07:16:32 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y11sm6415716wmj.36.2020.11.12.07.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:16:32 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 02/17] x86/hyperv: detect if Linux is the root partition
In-Reply-To: <20201105165814.29233-3-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-3-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:16:30 +0100
Message-ID: <87lff6y59t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> For now we can use the privilege flag to check. Stash the value to be
> used later.
>
> Put in a bunch of defines for future use when we want to have more
> fine-grained detection.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c          |  4 ++++
>  arch/x86/include/asm/hyperv-tlfs.h | 10 ++++++++++
>  arch/x86/include/asm/mshyperv.h    |  2 ++
>  arch/x86/kernel/cpu/mshyperv.c     | 16 ++++++++++++++++
>  4 files changed, 32 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e04d90af4c27..533fe9e887f2 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -26,6 +26,10 @@
>  #include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
>  
> +/* Is Linux running as the root partition? */
> +bool hv_root_partition;
> +EXPORT_SYMBOL_GPL(hv_root_partition);

(Nitpick and rather a personal preference): I'd prefer
'hv_partition_is_root' for a boolean.

> +
>  void *hv_hypercall_pg;
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>  
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 0ed20e8bba9e..41b628b9fb15 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -21,6 +21,7 @@
>  #define HYPERV_CPUID_FEATURES			0x40000003
>  #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
>  #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
> +#define HYPERV_CPUID_CPU_MANAGEMENT_FEATURES	0x40000007
>  #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
>  
>  #define HYPERV_HYPERVISOR_PRESENT_BIT		0x80000000
> @@ -103,6 +104,15 @@
>  /* Recommend using enlightened VMCS */
>  #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
>  
> +/*
> + * CPU management features identification.
> + * These are HYPERV_CPUID_CPU_MANAGEMENT_FEATURES.EAX bits.
> + */
> +#define HV_X64_START_LOGICAL_PROCESSOR			BIT(0)
> +#define HV_X64_CREATE_ROOT_VIRTUAL_PROCESSOR		BIT(1)
> +#define HV_X64_PERFORMANCE_COUNTER_SYNC			BIT(2)
> +#define HV_X64_RESERVED_IDENTITY_BIT			BIT(31)
> +
>  /*
>   * Virtual processor will never share a physical core with another virtual
>   * processor, except for virtual processors that are reported as sibling SMT
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ffc289992d1b..ac2b0d110f03 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -237,6 +237,8 @@ int hyperv_fill_flush_guest_mapping_list(
>  		struct hv_guest_mapping_flush_list *flush,
>  		u64 start_gfn, u64 end_gfn);
>  
> +extern bool hv_root_partition;

Eventually this is not going to be an x86 only thing I believe?

> +
>  #ifdef CONFIG_X86_64
>  void hv_apic_init(void);
>  void __init hv_init_spinlocks(void);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 05ef1f4550cb..f7633e1e4c82 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -237,6 +237,22 @@ static void __init ms_hyperv_init_platform(void)
>  	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>  
> +	/*
> +	 * Check CPU management privilege.
> +	 *
> +	 * To mirror what Windows does we should extract CPU management
> +	 * features and use the ReservedIdentityBit to detect if Linux is the
> +	 * root partition. But that requires negotiating CPU management
> +	 * interface (a process to be finalized).
> +	 *
> +	 * For now, use the privilege flag as the indicator for running as
> +	 * root.
> +	 */
> +	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {

We may want to cache cpuid_ebx(HYPERV_CPUID_FEATURES) somewhere but we
already had a discussion regading naming for these caches and decided to
wait until TLFS for ARM is out so we don't need to rename again.

> +		hv_root_partition = true;
> +		pr_info("Hyper-V: running as root partition\n");
> +	}
> +
>  	/*
>  	 * Extract host information.
>  	 */

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

