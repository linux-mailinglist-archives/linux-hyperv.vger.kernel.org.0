Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E126C3582D8
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Apr 2021 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhDHMGL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Apr 2021 08:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231451AbhDHMGJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Apr 2021 08:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617883558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eWJUzLuz50FUt+ImUQDHaMIAG0aReYXQygXZr8zlKMM=;
        b=Gf4MPxP2O81wXemrdZ8dcGZ5G3i7l3E0B21bYUPuH4SVNqnUprRHELFLU/ZHOftSfk1Xqs
        UUtSjUAW6l/XCSQ8TkJ7ICLwDhv5/HP1xS+VwQ8BVx6M9sFmyJgfo9UowMNhoC9vULDxtD
        w7mLOLdgFGvDxqu3M+l6DamXlsT/7T8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-urVx6TywOkyJHhMlMTuLbg-1; Thu, 08 Apr 2021 08:05:56 -0400
X-MC-Unique: urVx6TywOkyJHhMlMTuLbg-1
Received: by mail-ed1-f70.google.com with SMTP id b8so920012ede.5
        for <linux-hyperv@vger.kernel.org>; Thu, 08 Apr 2021 05:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=eWJUzLuz50FUt+ImUQDHaMIAG0aReYXQygXZr8zlKMM=;
        b=Xm9A/ctJLWe0Q/rq5mFfOuLTVBTNpP6ZhVQSRibaOXbH9foxDmeUtD1MiExZ2p7KLR
         UipoDnp3THLA1BUMJaMgsRwXlxA65hoMVZaWf48jftq9FqDCS1N7/ud/P3A0pFKtQD0u
         juZCOI6EaPgkaRuEf3QAeMJj8oQFlqjZ08IuSr6w3+jwnm+kTBdrFWLFKPe8KasyeDr+
         0wwjWsVichgZWqydx/Nstp7fMKriWm1ApiTJRFLXn2f85nd1Whft5Qd+CqYpQMpKYShf
         KOrw+XVdcAjm+gwe8NA8i5D89+inw39fcmFeu9iosP8Vuc0ivjy5s8229WQQhS50CqPA
         TIIg==
X-Gm-Message-State: AOAM533RMG7e0hmTSBGY4ITywEoJjHi7KMnCGCuGzkr4Sngv09iLdX1h
        3FO2+jhO+KzF00vaTNMDtyo0fBwoTx/ApsOocfdxr/WmmQhLVoNS9fiLeK2RnbMhFx+n4/Tdo9B
        15q2KGfA0UrrxxsrxN+JqYYDg
X-Received: by 2002:aa7:c983:: with SMTP id c3mr10931264edt.185.1617883555600;
        Thu, 08 Apr 2021 05:05:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhkUm5kBzngNh7+NALwEQCBHQoPbgDTqKumZWUBoMFU98rV+GaTwHrgwr7jiW8o/TjTsGC5w==
X-Received: by 2002:aa7:c983:: with SMTP id c3mr10931236edt.185.1617883555399;
        Thu, 08 Apr 2021 05:05:55 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id gq9sm14465571ejb.62.2021.04.08.05.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 05:05:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     Alexander Graf <graf@amazon.com>,
        Evgeny Iakovlev <eyakovl@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 4/4] KVM: hyper-v: Advertise support for fast XMM
 hypercalls
In-Reply-To: <20210407211954.32755-5-sidcha@amazon.de>
References: <20210407211954.32755-1-sidcha@amazon.de>
 <20210407211954.32755-5-sidcha@amazon.de>
Date:   Thu, 08 Apr 2021 14:05:53 +0200
Message-ID: <87blap7zha.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Siddharth Chandrasekaran <sidcha@amazon.de> writes:

> Now that all extant hypercalls that can use XMM registers (based on
> spec) for input/outputs are patched to support them, we can start
> advertising this feature to guests.
>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Evgeny Iakovlev <eyakovl@amazon.de>
> Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 4 ++--
>  arch/x86/kvm/hyperv.c              | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index e6cd3fee562b..1f160ef60509 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -49,10 +49,10 @@
>  /* Support for physical CPU dynamic partitioning events is available*/
>  #define HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE	BIT(3)
>  /*
> - * Support for passing hypercall input parameter block via XMM
> + * Support for passing hypercall input and output parameter block via XMM
>   * registers is available
>   */
> -#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE		BIT(4)
> +#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE		BIT(4) | BIT(15)

TLFS 6.0b states that there are two distinct bits for input and output:

CPUID Leaf 0x40000003.EDX:
Bit 4: support for passing hypercall input via XMM registers is available.
Bit 15: support for returning hypercall output via XMM registers is available.

and HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE is not currently used
anywhere, I'd suggest we just rename 

HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE to HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE
and add HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE (bit 15).

>  /* Support for a virtual guest idle state is available */
>  #define HV_X64_GUEST_IDLE_STATE_AVAILABLE		BIT(5)
>  /* Frequency MSRs available */
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index bf2f86f263f1..dd462c1d641d 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2254,6 +2254,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  			ent->ebx |= HV_POST_MESSAGES;
>  			ent->ebx |= HV_SIGNAL_EVENTS;
>  
> +			ent->edx |= HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE;
>  			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
>  			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;

-- 
Vitaly

