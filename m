Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F05A35819F
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Apr 2021 13:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhDHLW0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Apr 2021 07:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhDHLW0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Apr 2021 07:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617880935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ssiNnsZ6XfvMIOQx/UIjvpGkHgwAq/U6xUsW4ZtB1bQ=;
        b=BL9WZilNHw+Y3pUuUT8vVP5XYSvR9c+MKS2WXFOWOcGkLsl5AiUHSfDe6HNfNx8krhNfZf
        26U4Q3MbyJbabECEuSwcKcXmRqbRshSbUAWHramm2Q2Qqa7V4gOjNfIq5ArOFYe3qP/zE5
        o5JiFMK6P2Kd+/dzyjJTdzU0FTMlHFY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-QwMJhrhCPyuV_SHUuMO-uw-1; Thu, 08 Apr 2021 07:22:13 -0400
X-MC-Unique: QwMJhrhCPyuV_SHUuMO-uw-1
Received: by mail-ed1-f71.google.com with SMTP id l11so871298edb.2
        for <linux-hyperv@vger.kernel.org>; Thu, 08 Apr 2021 04:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ssiNnsZ6XfvMIOQx/UIjvpGkHgwAq/U6xUsW4ZtB1bQ=;
        b=IIL2ZycJc2yv3O4yI/rziFPtESC1G+UEgenB1tCbtEjm/Hf19fxxDi3fARK2widRYV
         JAjAWEQerUdrJ8Xz3iIRdQr3sh0pn3jui+FMOenEffdqN+111s6jL44FuqpKaoMHVp3x
         itaUml/9erXtxX3/SPTVXd5i6ougu68KRbiFy3oXZU9Nty88BvK/GuPf6BJCqFfPhMzh
         gthJ2h9+wMgFvpxqFazPYURyHW8u3i0x/MFeUVAFGUWVBQNkebdOKOeosmaZ2u4xOBBn
         GFseX42+nTOqIdqQxRGj96FVCtW5T5hzhp4ZLC8lVM+UQ/r+jLmX6S3BJ/eq0RA4ihzr
         01aQ==
X-Gm-Message-State: AOAM533qYCzbnhFR605vCkOlBYHbzDY4fjqxBoGYojhMTpKQPnkehBYy
        ooMliq3L1kwjKRonWc8bFP/YR16TscMOh8Xh0zU42BgBfkr2q5n+jjPAUjCaM9KvfprV/mTsi+c
        ez4h/pjuI+ds7ci3TxqaZod6++b2urrE2ZryHHlwKgMO228EVnqy0UWXIy8rxzWbBs4RZJc314m
        aQ
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr10604291edu.100.1617880932495;
        Thu, 08 Apr 2021 04:22:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5kZWFZe+2WZ6vDjqnSa/1c+6hqr71F8KhJ2yK/Q8ALfWlMlWLdAjtlCLTrF3PKtkjitUOqQ==
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr10604262edu.100.1617880932324;
        Thu, 08 Apr 2021 04:22:12 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m14sm17251529edd.63.2021.04.08.04.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:22:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 6/7] KVM: SVM: hyper-v: Enlightened MSR-Bitmap support
In-Reply-To: <5cf935068a9539146e033276b6d9a6c9b1e42119.1617804573.git.viremana@linux.microsoft.com>
References: <cover.1617804573.git.viremana@linux.microsoft.com>
 <5cf935068a9539146e033276b6d9a6c9b1e42119.1617804573.git.viremana@linux.microsoft.com>
Date:   Thu, 08 Apr 2021 13:22:10 +0200
Message-ID: <87czv5aun1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vineeth Pillai <viremana@linux.microsoft.com> writes:

> Enlightened MSR-Bitmap as per TLFS:
>
>  "The L1 hypervisor may collaborate with the L0 hypervisor to make MSR
>   accesses more efficient. It can enable enlightened MSR bitmaps by setting
>   the corresponding field in the enlightened VMCS to 1. When enabled, L0
>   hypervisor does not monitor the MSR bitmaps for changes. Instead, the L1
>   hypervisor must invalidate the corresponding clean field after making
>   changes to one of the MSR bitmaps."
>
> Enable this for SVM.
>
> Related VMX changes:
> commit ceef7d10dfb6 ("KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support")
>
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>  arch/x86/kvm/svm/svm.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 6287cab61f15..3562a247b7e8 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -646,6 +646,27 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
>  	return !!test_bit(bit_write,  &tmp);
>  }
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
> +static inline void hv_vmcb_dirty_nested_enlightenments(struct kvm_vcpu *vcpu)
> +{
> +	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
> +
> +	/*
> +	 * vmcb can be NULL if called during early vcpu init.
> +	 * And its okay not to mark vmcb dirty during vcpu init
> +	 * as we mark it dirty unconditionally towards end of vcpu
> +	 * init phase.
> +	 */
> +	if (vmcb && vmcb_is_clean(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS) &&
> +	    vmcb->hv_enlightenments.hv_enlightenments_control.msr_bitmap)
> +		vmcb_mark_dirty(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS);

vmcb_is_clean() check seems to be superfluous, vmcb_mark_dirty() does no
harm if the bit was already cleared.

> +}
> +#else
> +static inline void hv_vmcb_dirty_nested_enlightenments(struct kvm_vcpu *vcpu)
> +{
> +}
> +#endif
> +
>  static void set_msr_interception_bitmap(struct kvm_vcpu *vcpu, u32 *msrpm,
>  					u32 msr, int read, int write)
>  {
> @@ -677,6 +698,9 @@ static void set_msr_interception_bitmap(struct kvm_vcpu *vcpu, u32 *msrpm,
>  	write ? clear_bit(bit_write, &tmp) : set_bit(bit_write, &tmp);
>  
>  	msrpm[offset] = tmp;
> +
> +	hv_vmcb_dirty_nested_enlightenments(vcpu);
> +
>  }
>  
>  void set_msr_interception(struct kvm_vcpu *vcpu, u32 *msrpm, u32 msr,
> @@ -1135,6 +1159,9 @@ static void hv_init_vmcb(struct vmcb *vmcb)
>  	if (npt_enabled &&
>  	    ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB)
>  		hve->hv_enlightenments_control.enlightened_npt_tlb = 1;
> +
> +	if (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)
> +		hve->hv_enlightenments_control.msr_bitmap = 1;
>  }
>  #else
>  static inline void hv_init_vmcb(struct vmcb *vmcb)

-- 
Vitaly

