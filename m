Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8777A361B8B
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 10:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbhDPI1K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 04:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240291AbhDPI1J (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 04:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618561605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDfR8iVh8XSN4o8S9XIZ+vsfxmtqUP1R7YuCLZyLUbM=;
        b=f5BpE1EO5amrg6SW2ld+EhkrDGaL64c0ZBhoTLkIsE/2ZeYgEhLVOvpsWCxRBRdr7sBEmc
        jl5J/tWELPrrwwxBStvtQD++ea8pXiMoZU3tbevJmeov0BV/qGjK8+Ef9HdFJg9G9EEcl7
        79Ir+1++gGOtczPzBOMuTxx1MXTKUjw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-dY4jJ7quMLmGQkhPUZXJkQ-1; Fri, 16 Apr 2021 04:26:43 -0400
X-MC-Unique: dY4jJ7quMLmGQkhPUZXJkQ-1
Received: by mail-ed1-f71.google.com with SMTP id d2-20020aa7d6820000b0290384ee872881so2535272edr.10
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Apr 2021 01:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GDfR8iVh8XSN4o8S9XIZ+vsfxmtqUP1R7YuCLZyLUbM=;
        b=FXmvptoKbLCv8hHIRpj8GJdqoCsdthi1kRyN0YgjcgspXHIldQ0CCeMQldfOSMasuX
         AVUk2q3CzBzaeu7SFoSms//YvnZmG468naNSJOBDmDdyvu9ozlix47xo4YjnomZsZV5H
         AwVzb8JDmEkTh0n2XCczOVD6p9Nd2tRXVCFAKKlcsV9/W3fqATK/01nw9S2qKgkbdNWP
         lXIlkYGwza8NYiHFs+4FW1hGkoWqVVTdHF0jOyyxAKRL3bKjiQayNTogza/8yqe6dQUl
         Ef+cnk6VwxSR0pS+kp28JOCMyvNflthNRqqTBaK0hRkI/NjVZvtXkDjQdshMocrHuW5i
         E0+A==
X-Gm-Message-State: AOAM5324drpfUnJJzExeZ1Cx6lFb+uBumD3kyRb2h9SRBbCDn73wWhYU
        HjYUCCRoFDs9b5XNBBMyVZt5ZlxpFtjp0XAeTaMwLQUeA55ppZ7umclT9M4v3r5ca2VDCarT6zq
        rmiHS4L692frCMhoXEHoP6K8H
X-Received: by 2002:a05:6402:7cf:: with SMTP id u15mr2496402edy.297.1618561602412;
        Fri, 16 Apr 2021 01:26:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjCNyDz0otPSAn5rP293qV2aUO2LfE/x9sXa+u6jjL4WGAVGA2gNPkgIpakzrGSlP22der0Q==
X-Received: by 2002:a05:6402:7cf:: with SMTP id u15mr2496382edy.297.1618561602274;
        Fri, 16 Apr 2021 01:26:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w13sm4585188edc.81.2021.04.16.01.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:26:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH v2 1/7] hyperv: Detect Nested virtualization support for
 SVM
In-Reply-To: <9d12558549bc0c6f179b26f5b16c751bdfab3f74.1618492553.git.viremana@linux.microsoft.com>
References: <cover.1618492553.git.viremana@linux.microsoft.com>
 <9d12558549bc0c6f179b26f5b16c751bdfab3f74.1618492553.git.viremana@linux.microsoft.com>
Date:   Fri, 16 Apr 2021 10:26:40 +0200
Message-ID: <871rba8wjj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vineeth Pillai <viremana@linux.microsoft.com> writes:

> Detect nested features exposed by Hyper-V if SVM is enabled.
>

It may make sense to expand this a bit as it is probably unclear how the
change is related to SVM.

Something like:

HYPERV_CPUID_NESTED_FEATURES CPUID leaf can be present on both Intel and
AMD Hyper-V guests. Previously, the code was using
HV_X64_ENLIGHTENED_VMCS_RECOMMENDED feature bit to determine the
availability of nested features leaf and this complies to TLFS:
"Recommend a nested hypervisor using the enlightened VMCS interface. 
Also indicates that additional nested enlightenments may be available
(see leaf 0x4000000A)". Enlightened VMCS, however, is an Intel only
feature so the detection method doesn't work for AMD. Use
HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS.EAX CPUID information ("The
maximum input value for hypervisor CPUID information.") instead, this
works for both AMD and Intel.


> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 3546d3e21787..c6f812851e37 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -252,6 +252,7 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>  
>  static void __init ms_hyperv_init_platform(void)
>  {
> +	int hv_max_functions_eax;
>  	int hv_host_info_eax;
>  	int hv_host_info_ebx;
>  	int hv_host_info_ecx;
> @@ -269,6 +270,8 @@ static void __init ms_hyperv_init_platform(void)
>  	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>  
> +	hv_max_functions_eax = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
> +
>  	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
>  		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
>  		ms_hyperv.misc_features);
> @@ -298,8 +301,7 @@ static void __init ms_hyperv_init_platform(void)
>  	/*
>  	 * Extract host information.
>  	 */
> -	if (cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS) >=
> -	    HYPERV_CPUID_VERSION) {
> +	if (hv_max_functions_eax >= HYPERV_CPUID_VERSION) {
>  		hv_host_info_eax = cpuid_eax(HYPERV_CPUID_VERSION);
>  		hv_host_info_ebx = cpuid_ebx(HYPERV_CPUID_VERSION);
>  		hv_host_info_ecx = cpuid_ecx(HYPERV_CPUID_VERSION);
> @@ -325,9 +327,11 @@ static void __init ms_hyperv_init_platform(void)
>  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>  	}
>  
> -	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
> +	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
>  		ms_hyperv.nested_features =
>  			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
> +		pr_info("Hyper-V: Nested features: 0x%x\n",
> +			ms_hyperv.nested_features);
>  	}
>  
>  	/*

With the commit message expanded,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

