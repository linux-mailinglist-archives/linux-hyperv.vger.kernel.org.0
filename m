Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E838E608
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 May 2021 14:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhEXMCE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 May 2021 08:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232845AbhEXMB6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 May 2021 08:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621857628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3V0D+5HGJhXODEIAf3PixuPKf+j2PO1GcKX5z+lPQc=;
        b=QJb2jl17EzxiD8iy2v8sbQWWLRboPmWx/4yyKk2NmGLNC7dWDox3ECTXPXaGK2XPgzOOqb
        LCUkxVKqi+P++qfoS3jY+ATSQe7EtcarS6RMjyyC0GUIbJJWTGiDXssn56ZuTAAMGbLmEU
        AIs6u7Qh4fXHMJBNWal6hR8ke+uyf6o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-CY5iznfcNzuiY5RRoNziNg-1; Mon, 24 May 2021 08:00:25 -0400
X-MC-Unique: CY5iznfcNzuiY5RRoNziNg-1
Received: by mail-ed1-f69.google.com with SMTP id w1-20020aa7da410000b029038d323eeee3so13475185eds.8
        for <linux-hyperv@vger.kernel.org>; Mon, 24 May 2021 05:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I3V0D+5HGJhXODEIAf3PixuPKf+j2PO1GcKX5z+lPQc=;
        b=MSK2XWDRAQ7HeI4kh8smlJY9bGfOzv0FYNTjGyWWpePZIbA50h4EoQzabc68+x+zBo
         E8mq9z5Syv71Ift3gNdnGiEcrBw0mrBZwTUMamy/vlkEyWNSkpTUnuJhN9Jf+ngM/Ft8
         vNarX7HUnv1imYORMYN6FS2VWmvtWn7+/UQbkvx01E9K2SG5s0JEQCwFmKDNN706X52B
         jM27tfSpzNEjAfrKqdUYu1vRWF1OD0dLs7LOiICEBe2cLI7D/cfpdQozBvyEpa+rLB36
         OPLDJp3kIJSx95rR7D0dsRrMT1Q/qdR2XOyZdW3qqUzMBskgOOIkgdoKjH7qFuiWOj7y
         lcGA==
X-Gm-Message-State: AOAM531hajV2u5oTtoMcjzJ/Pw8ll6aueq/Ty8RT3tfrGXfSa0cDzCSl
        bJzc/ZUTKKDT0hwOCoL+XAE/eKNtKtPOHNHnSTLroqVv0JlW7QoypEm5ZMN870StbOKb13lB+qU
        uWW8+H47K8lkXmbiVHnxyf/u9
X-Received: by 2002:a05:6402:40c1:: with SMTP id z1mr24318012edb.97.1621857624530;
        Mon, 24 May 2021 05:00:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUkyhyrAvsVZLNoFrhItAWzyVi++VuBUrZtAbDURNk3L0hXBXWDHC5wJQxCvuOgTmmDyX6dw==
X-Received: by 2002:a05:6402:40c1:: with SMTP id z1mr24317983edb.97.1621857624354;
        Mon, 24 May 2021 05:00:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k21sm7865882ejp.23.2021.05.24.05.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 05:00:23 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] KVM: hyper-v: Advertise support for fast XMM
 hypercalls
To:     Siddharth Chandrasekaran <sidcha@amazon.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Alexander Graf <graf@amazon.com>,
        Evgeny Iakovlev <eyakovl@amazon.de>,
        Liran Alon <liran@amazon.com>,
        Ioannis Aslanidis <iaslan@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <cover.1618349671.git.sidcha@amazon.de>
 <33a7e27046c15134667ea891feacbe3fe208f66e.1618349671.git.sidcha@amazon.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17a1ab38-10db-4fdf-411e-921738cd94e1@redhat.com>
Date:   Mon, 24 May 2021 14:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <33a7e27046c15134667ea891feacbe3fe208f66e.1618349671.git.sidcha@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 13/04/21 23:50, Siddharth Chandrasekaran wrote:
> Now that kvm_hv_flush_tlb() has been patched to support XMM hypercall
> inputs, we can start advertising this feature to guests.
> 
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Evgeny Iakovlev <eyakovl@amazon.de>
> Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
> ---
>   arch/x86/include/asm/hyperv-tlfs.h | 7 ++++++-
>   arch/x86/kvm/hyperv.c              | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index ee6336a54f92..597ae1142864 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -52,7 +52,7 @@
>    * Support for passing hypercall input parameter block via XMM
>    * registers is available
>    */
> -#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE		BIT(4)
> +#define HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE		BIT(4)
>   /* Support for a virtual guest idle state is available */
>   #define HV_X64_GUEST_IDLE_STATE_AVAILABLE		BIT(5)
>   /* Frequency MSRs available */
> @@ -61,6 +61,11 @@
>   #define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE		BIT(10)
>   /* Support for debug MSRs available */
>   #define HV_FEATURE_DEBUG_MSRS_AVAILABLE			BIT(11)
> +/*
> + * Support for returning hypercall output block via XMM
> + * registers is available
> + */
> +#define HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE		BIT(15)
>   /* stimer Direct Mode is available */
>   #define HV_STIMER_DIRECT_MODE_AVAILABLE			BIT(19)
>   
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index cd6c6f1f06a4..0f6fd7550510 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2235,6 +2235,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>   			ent->ebx |= HV_POST_MESSAGES;
>   			ent->ebx |= HV_SIGNAL_EVENTS;
>   
> +			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
>   			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
>   			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
>   
> 

Queued, thanks.

Paolo

