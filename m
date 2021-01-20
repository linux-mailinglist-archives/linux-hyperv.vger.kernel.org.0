Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4612FD4E3
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 17:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391172AbhATQEt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jan 2021 11:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391128AbhATQEg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 11:04:36 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FDEC0613D3
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jan 2021 08:03:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id w1so34210852ejf.11
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jan 2021 08:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaBbcFFWtwH73KKkHPV2dAAEp83v3RAFbPyaNgV/jIA=;
        b=on1TzcIQfB0S+jMkItagEJtX8hz1tNnjBcnUtaJWlF9V6USnFvBrmlsf+hgKeuoHzg
         fHXarQilEi/Z1srXltN0diMlHMbSDa0P1lRdEw2fafXT9lYdDcUCNJCdWXc9aXmvvjie
         BRVYlaez6uS7Xpon2IXP3iVJMV1PHrWsQXZ6PAA0SdZLYh31u/j2HbzbttRSevVbCqn+
         nV8DpomSlRxtSnh4hLOliPHOECsNLhUPi2JYLCTO8X+jnNqakzuTardr31/bn0B45K6K
         jm0UELIHadLwshBArvF3Layo+XQsGrbgjxf7OiPKuwCJKVR/XQjK2YcWIJM1l5VjgATz
         ksiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaBbcFFWtwH73KKkHPV2dAAEp83v3RAFbPyaNgV/jIA=;
        b=pMpH7Bkx4F1/aocp3rCHcN7ddGgAifPiADjy5s49/KEg0wh/qZ4dggQ8JjSsTEAUBp
         tS4iZOoXzcO/c1RS54idvKPmq76iuAkKrn/1DrPVmmlaoUyVepN3WLtKAEh/o6naHByE
         trwXUGvoNXYOto12cVAp6dCSiQa6YohyIZLWER8N32FSFsh97kdSwrqHMXvYTMJa7qok
         invqWHy5vbo/2g9gI/QAD8/ewdt+BShmbWh04C+dKi64hy/d3qhqsirrC3Aa2cvNdGUg
         /l3rbCwHwp/fX4S999T0AVQfSNkoUR41jOGar8f8TLlazmeoOSLs4z96LbAFdHffU6uY
         heJA==
X-Gm-Message-State: AOAM532TXdx1XE/fSviF0t0nVHlkg6bB3xaFTOFUtl1H4wYuLYpTGO+M
        Di1K3OMLLlShF1R2N73rpTym9Pcwb/EJtH1r4UVh5w==
X-Google-Smtp-Source: ABdhPJz49BI1HhzhHVlsG76ZtgvDppRgVafvcapbZeJzfe0AK+OqaaTzGsJ0BE7BJebcMbhE517Q3MPcEI8WBx1tDMA=
X-Received: by 2002:a17:906:eb95:: with SMTP id mh21mr6793469ejb.175.1611158633954;
 Wed, 20 Jan 2021 08:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org> <20210120120058.29138-3-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-3-wei.liu@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Jan 2021 11:03:18 -0500
Message-ID: <CA+CK2bDHYxTr_ttbC88u1OvT-=cm5do5RmyoxC+joz=GjK1WtA@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] x86/hyperv: detect if Linux is the root partition
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> For now we can use the privilege flag to check. Stash the value to be
> used later.
>
> Put in a bunch of defines for future use when we want to have more
> fine-grained detection.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v3: move hv_root_partition to mshyperv.c
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 10 ++++++++++
>  arch/x86/include/asm/mshyperv.h    |  2 ++
>  arch/x86/kernel/cpu/mshyperv.c     | 20 ++++++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 6bf42aed387e..204010350604 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -21,6 +21,7 @@
>  #define HYPERV_CPUID_FEATURES                  0x40000003
>  #define HYPERV_CPUID_ENLIGHTMENT_INFO          0x40000004
>  #define HYPERV_CPUID_IMPLEMENT_LIMITS          0x40000005
> +#define HYPERV_CPUID_CPU_MANAGEMENT_FEATURES   0x40000007
>  #define HYPERV_CPUID_NESTED_FEATURES           0x4000000A
>
>  #define HYPERV_CPUID_VIRT_STACK_INTERFACE      0x40000081
> @@ -110,6 +111,15 @@
>  /* Recommend using enlightened VMCS */
>  #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED            BIT(14)
>
> +/*
> + * CPU management features identification.
> + * These are HYPERV_CPUID_CPU_MANAGEMENT_FEATURES.EAX bits.
> + */
> +#define HV_X64_START_LOGICAL_PROCESSOR                 BIT(0)
> +#define HV_X64_CREATE_ROOT_VIRTUAL_PROCESSOR           BIT(1)
> +#define HV_X64_PERFORMANCE_COUNTER_SYNC                        BIT(2)
> +#define HV_X64_RESERVED_IDENTITY_BIT                   BIT(31)
> +
>  /*
>   * Virtual processor will never share a physical core with another virtual
>   * processor, except for virtual processors that are reported as sibling SMT
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ffc289992d1b..ac2b0d110f03 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -237,6 +237,8 @@ int hyperv_fill_flush_guest_mapping_list(
>                 struct hv_guest_mapping_flush_list *flush,
>                 u64 start_gfn, u64 end_gfn);
>
> +extern bool hv_root_partition;
> +
>  #ifdef CONFIG_X86_64
>  void hv_apic_init(void);
>  void __init hv_init_spinlocks(void);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index f628e3dc150f..c376d191a260 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -32,6 +32,10 @@
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>
> +/* Is Linux running as the root partition? */
> +bool hv_root_partition;
> +EXPORT_SYMBOL_GPL(hv_root_partition);
> +
>  struct ms_hyperv_info ms_hyperv;
>  EXPORT_SYMBOL_GPL(ms_hyperv);
>
> @@ -237,6 +241,22 @@ static void __init ms_hyperv_init_platform(void)
>         pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
>                  ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>
> +       /*
> +        * Check CPU management privilege.
> +        *
> +        * To mirror what Windows does we should extract CPU management
> +        * features and use the ReservedIdentityBit to detect if Linux is the
> +        * root partition. But that requires negotiating CPU management
> +        * interface (a process to be finalized).

Is this comment relevant? Do we have to mirror what Windows does?

> +        *
> +        * For now, use the privilege flag as the indicator for running as
> +        * root.
> +        */
> +       if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {
> +               hv_root_partition = true;
> +               pr_info("Hyper-V: running as root partition\n");
> +       }
> +

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

>         /*
>          * Extract host information.
>          */
> --
> 2.20.1
>
