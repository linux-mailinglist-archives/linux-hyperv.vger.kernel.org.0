Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC010279F17
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Sep 2020 08:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgI0Gyf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Sep 2020 02:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgI0Gyf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Sep 2020 02:54:35 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601189672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLXv0DKfSOLJ4aixYebn4viaLF/QMh4USeFAZRpOEdg=;
        b=SqUx+7SCIhGevSbO8DZqCIuIqBANKs7/7/y6uapjEJhWldbOwfntvMt//yHKocFLXPQYJl
        xb7lZXt/Ubel8lHYHDXj6xrSI+7SW5AAkKkw5bsoXz+m7xt0bWQEOnrTfaHYRpnNBMzxvf
        3B2Up0kZABZRSIaBPYzFmmjAaUQ+Mkw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-q9w-eBj5OyGq24EvN9Fjsw-1; Sun, 27 Sep 2020 02:54:31 -0400
X-MC-Unique: q9w-eBj5OyGq24EvN9Fjsw-1
Received: by mail-wr1-f72.google.com with SMTP id d9so3208561wrv.16
        for <linux-hyperv@vger.kernel.org>; Sat, 26 Sep 2020 23:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cLXv0DKfSOLJ4aixYebn4viaLF/QMh4USeFAZRpOEdg=;
        b=KGCH6NBllkR7NIhmW5N6IqEXRgV9paoPb09wd5MGH3RlqH93Wks10yKHL6sErDQIYJ
         SrQyfsUOVFh7s2edNFhXPhKVHfMf7fD55nZgMrqrph7cZk8iCRzsq9oAFlUh4uHYYfAl
         WacxyqEkll2S9d0DgFO3Y/glYdWRuc5mK1f/GUDjN7ke1nWnhDO3jvb+Q4ZxxxDiuLGX
         QD6SVU5S/TK72dvMl68Rga9RXRKkmQ8ElE0kYUCgkr+Qfyo70QDwTxvdsKsqUCLN+0fT
         w4FLNLXtIAos+LY0ROL9/Bgxab8gZtES3oegupcAkxyV6ECwUv0wAvE0diXWqtQDGiQn
         kKFg==
X-Gm-Message-State: AOAM530OSQ7Tajvz+FcimGqboAu2NJmsgi7WdCoIcoSILlnv5BqHZomO
        wjhP14rdRcXAtmkPVS0nGrDS9MxdCf6cOpdGDsJupnWPxbOutyeOSsOpfvcsxoxp0ZbVe8aRmor
        oCJl0D+LgPhVowrptAmtt5UYS
X-Received: by 2002:a1c:7514:: with SMTP id o20mr5504925wmc.76.1601189668702;
        Sat, 26 Sep 2020 23:54:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPC00lWu0vUKx40yVBk2ftsrestYUPzewXaLzXmUYjf8kVKdthT3RKr7iOh/zNpTpuygb9Dw==
X-Received: by 2002:a1c:7514:: with SMTP id o20mr5504904wmc.76.1601189668396;
        Sat, 26 Sep 2020 23:54:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fc81:b99a:aac0:e256? ([2001:b07:6468:f312:fc81:b99a:aac0:e256])
        by smtp.gmail.com with ESMTPSA id b187sm4374497wmb.8.2020.09.26.23.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2020 23:54:27 -0700 (PDT)
Subject: Re: [PATCH] x86/hyperv: Remove aliases with X64 in their name
To:     joseph.salisbury@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        mikelley@microsoft.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1601130386-11111-1-git-send-email-jsalisbury@linux.microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70053462-38a3-e425-5f97-35a349ab96ab@redhat.com>
Date:   Sun, 27 Sep 2020 08:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601130386-11111-1-git-send-email-jsalisbury@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 26/09/20 16:26, Joseph Salisbury wrote:
> From: Joseph Salisbury <joseph.salisbury@microsoft.com>
> 
> In the architecture independent version of hyperv-tlfs.h, commit c55a844f46f958b
> removed the "X64" in the symbol names so they would make sense for both x86 and
> ARM64.  That commit added aliases with the "X64" in the x86 version of hyperv-tlfs.h 
> so that existing x86 code would continue to compile.
> 
> As a cleanup, update the x86 code to use the symbols without the "X64", then remove 
> the aliases.  There's no functional change.
> 
> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c          |  8 ++++----
>  arch/x86/hyperv/hv_spinlock.c      |  2 +-
>  arch/x86/include/asm/hyperv-tlfs.h | 33 ------------------------------
>  arch/x86/kernel/cpu/mshyperv.c     |  8 ++++----
>  arch/x86/kvm/hyperv.c              | 20 +++++++++---------
>  5 files changed, 19 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6035df1b49e1..e04d90af4c27 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -148,9 +148,9 @@ static inline bool hv_reenlightenment_available(void)
>  	 * Check for required features and priviliges to make TSC frequency
>  	 * change notifications work.
>  	 */
> -	return ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
> +	return ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
>  		ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE &&
> -		ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT;
> +		ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT;
>  }
>  
>  DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_reenlightenment)
> @@ -330,8 +330,8 @@ void __init hyperv_init(void)
>  		return;
>  
>  	/* Absolutely required MSRs */
> -	required_msrs = HV_X64_MSR_HYPERCALL_AVAILABLE |
> -		HV_X64_MSR_VP_INDEX_AVAILABLE;
> +	required_msrs = HV_MSR_HYPERCALL_AVAILABLE |
> +		HV_MSR_VP_INDEX_AVAILABLE;
>  
>  	if ((ms_hyperv.features & required_msrs) != required_msrs)
>  		return;
> diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
> index 07f21a06392f..f3270c1fc48c 100644
> --- a/arch/x86/hyperv/hv_spinlock.c
> +++ b/arch/x86/hyperv/hv_spinlock.c
> @@ -66,7 +66,7 @@ void __init hv_init_spinlocks(void)
>  {
>  	if (!hv_pvspin || !apic ||
>  	    !(ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) ||
> -	    !(ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)) {
> +	    !(ms_hyperv.features & HV_MSR_GUEST_IDLE_AVAILABLE)) {
>  		pr_info("PV spinlocks disabled\n");
>  		return;
>  	}
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 7a4d2062385c..0ed20e8bba9e 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -27,39 +27,6 @@
>  #define HYPERV_CPUID_MIN			0x40000005
>  #define HYPERV_CPUID_MAX			0x4000ffff
>  
> -/*
> - * Aliases for Group A features that have X64 in the name.
> - * On x86/x64 these are HYPERV_CPUID_FEATURES.EAX bits.
> - */
> -
> -#define HV_X64_MSR_VP_RUNTIME_AVAILABLE		\
> -		HV_MSR_VP_RUNTIME_AVAILABLE
> -#define HV_X64_MSR_SYNIC_AVAILABLE		\
> -		HV_MSR_SYNIC_AVAILABLE
> -#define HV_X64_MSR_APIC_ACCESS_AVAILABLE	\
> -		HV_MSR_APIC_ACCESS_AVAILABLE
> -#define HV_X64_MSR_HYPERCALL_AVAILABLE		\
> -		HV_MSR_HYPERCALL_AVAILABLE
> -#define HV_X64_MSR_VP_INDEX_AVAILABLE		\
> -		HV_MSR_VP_INDEX_AVAILABLE
> -#define HV_X64_MSR_RESET_AVAILABLE		\
> -		HV_MSR_RESET_AVAILABLE
> -#define HV_X64_MSR_GUEST_IDLE_AVAILABLE		\
> -		HV_MSR_GUEST_IDLE_AVAILABLE
> -#define HV_X64_ACCESS_FREQUENCY_MSRS		\
> -		HV_ACCESS_FREQUENCY_MSRS
> -#define HV_X64_ACCESS_REENLIGHTENMENT		\
> -		HV_ACCESS_REENLIGHTENMENT
> -#define HV_X64_ACCESS_TSC_INVARIANT		\
> -		HV_ACCESS_TSC_INVARIANT
> -
> -/*
> - * Aliases for Group B features that have X64 in the name.
> - * On x86/x64 these are HYPERV_CPUID_FEATURES.EBX bits.
> - */
> -#define HV_X64_POST_MESSAGES		HV_POST_MESSAGES
> -#define HV_X64_SIGNAL_EVENTS		HV_SIGNAL_EVENTS
> -
>  /*
>   * Group D Features.  The bit assignments are custom to each architecture.
>   * On x86/x64 these are HYPERV_CPUID_FEATURES.EDX bits.
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 31125448b174..9834a43cd0fa 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -248,7 +248,7 @@ static void __init ms_hyperv_init_platform(void)
>  			hv_host_info_edx >> 24, hv_host_info_edx & 0xFFFFFF);
>  	}
>  
> -	if (ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
> +	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
>  	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
>  		x86_platform.calibrate_tsc = hv_get_tsc_khz;
>  		x86_platform.calibrate_cpu = hv_get_tsc_khz;
> @@ -270,7 +270,7 @@ static void __init ms_hyperv_init_platform(void)
>  		crash_kexec_post_notifiers = true;
>  
>  #ifdef CONFIG_X86_LOCAL_APIC
> -	if (ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
> +	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
>  	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
>  		/*
>  		 * Get the APIC frequency.
> @@ -296,7 +296,7 @@ static void __init ms_hyperv_init_platform(void)
>  	machine_ops.shutdown = hv_machine_shutdown;
>  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
>  #endif
> -	if (ms_hyperv.features & HV_X64_ACCESS_TSC_INVARIANT) {
> +	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
>  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
>  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>  	} else {
> @@ -330,7 +330,7 @@ static void __init ms_hyperv_init_platform(void)
>  	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_hyperv_callback);
>  
>  	/* Setup the IDT for reenlightenment notifications */
> -	if (ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT) {
> +	if (ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT) {
>  		alloc_intr_gate(HYPERV_REENLIGHTENMENT_VECTOR,
>  				asm_sysvec_hyperv_reenlightenment);
>  	}
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 1d330564eed8..8c1e8334eff0 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2000,20 +2000,20 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  			break;
>  
>  		case HYPERV_CPUID_FEATURES:
> -			ent->eax |= HV_X64_MSR_VP_RUNTIME_AVAILABLE;
> +			ent->eax |= HV_MSR_VP_RUNTIME_AVAILABLE;
>  			ent->eax |= HV_MSR_TIME_REF_COUNT_AVAILABLE;
> -			ent->eax |= HV_X64_MSR_SYNIC_AVAILABLE;
> +			ent->eax |= HV_MSR_SYNIC_AVAILABLE;
>  			ent->eax |= HV_MSR_SYNTIMER_AVAILABLE;
> -			ent->eax |= HV_X64_MSR_APIC_ACCESS_AVAILABLE;
> -			ent->eax |= HV_X64_MSR_HYPERCALL_AVAILABLE;
> -			ent->eax |= HV_X64_MSR_VP_INDEX_AVAILABLE;
> -			ent->eax |= HV_X64_MSR_RESET_AVAILABLE;
> +			ent->eax |= HV_MSR_APIC_ACCESS_AVAILABLE;
> +			ent->eax |= HV_MSR_HYPERCALL_AVAILABLE;
> +			ent->eax |= HV_MSR_VP_INDEX_AVAILABLE;
> +			ent->eax |= HV_MSR_RESET_AVAILABLE;
>  			ent->eax |= HV_MSR_REFERENCE_TSC_AVAILABLE;
> -			ent->eax |= HV_X64_ACCESS_FREQUENCY_MSRS;
> -			ent->eax |= HV_X64_ACCESS_REENLIGHTENMENT;
> +			ent->eax |= HV_ACCESS_FREQUENCY_MSRS;
> +			ent->eax |= HV_ACCESS_REENLIGHTENMENT;
>  
> -			ent->ebx |= HV_X64_POST_MESSAGES;
> -			ent->ebx |= HV_X64_SIGNAL_EVENTS;
> +			ent->ebx |= HV_POST_MESSAGES;
> +			ent->ebx |= HV_SIGNAL_EVENTS;
>  
>  			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
>  			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

