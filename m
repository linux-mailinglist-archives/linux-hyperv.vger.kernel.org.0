Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47F93A2F13
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jun 2021 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhFJPN5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Jun 2021 11:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230410AbhFJPN4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Jun 2021 11:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623337919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9NQjB1G9/lkJGQr+IIlD06aGdtYflbI0bOPVJVLu60=;
        b=Gmpa3ReTdK0cNahScqKDy/N6Kv94dS1bFzq2n+O583T+ntr1hvQA83IF6fgZlSQiBCEH3N
        /Mzl1EFzjk6dU6BsoNs4RH2g6mQStYO3bKjnFrXlYl4oMpZ8ORlqjgFQLVOz5XGvLLx0Oc
        2F4cBcnfHJaUJwFKj/aFEIf+gNvCtgw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-qM7AcyWFMOyGcF_q3JmO7A-1; Thu, 10 Jun 2021 11:11:58 -0400
X-MC-Unique: qM7AcyWFMOyGcF_q3JmO7A-1
Received: by mail-wr1-f71.google.com with SMTP id x9-20020a5d49090000b0290118d8746e06so1025383wrq.10
        for <linux-hyperv@vger.kernel.org>; Thu, 10 Jun 2021 08:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V9NQjB1G9/lkJGQr+IIlD06aGdtYflbI0bOPVJVLu60=;
        b=jm6qRgRdwkI0+p/FSVSCMhGI/9C1qZZzDS8EJufb9mnaIxx0K3tKmbmnJYWgW6KggP
         rT08O02QmpUe24pbMW/e9NCVhJkrYVzJ3K/kXqX4H/dn7B2ZHduHZ2+pWSLpG6YkJZTG
         6Sls6PYVj+4w4xeDMtPza8n4u4DKMQjUxW6FlLDW7o8RJAmfzMT9Ubb2ydkzoklHO77P
         RLZiMKtxMxH8fvBMdEWnKIYjnDO9s3j4MOHlA8k6gVMHyfCptLcgwOgxAMGLmbnsAVam
         hDRlOusC7kAtYhwTz8SZOUkSSWrBr4qnOoCimifwFON9KRPWEMjn0mmAZQqRMTJP3Pn1
         aD0Q==
X-Gm-Message-State: AOAM530/vaiyTdVPJ3T+UXwZd/35AI31Opo/2jJcirfHzRksnSz+1qKg
        71/b+ruHtfGPqE62k56dZZWWecRTTbq0blLI4WNMWSBRkoRU3ZhUoHYXBs6BDEfrBZREhCS3q6g
        hcuPrseRV2DhBtbhBDv0cxaUn
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr6069491wrq.240.1623337917376;
        Thu, 10 Jun 2021 08:11:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydGeOkSMz7lcUGKlCE1rQfAX8nLv8WrlSzGQe/yihHRzc6lSlnhdWG42YT2v/ZaIvQl0WxWA==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr6069458wrq.240.1623337917170;
        Thu, 10 Jun 2021 08:11:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id 32sm4714325wrs.5.2021.06.10.08.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:11:56 -0700 (PDT)
Subject: Re: [PATCH v5 3/7] KVM: x86: hyper-v: Move the remote TLB flush logic
 out of vmx
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
References: <cover.1622730232.git.viremana@linux.microsoft.com>
 <4f4e4ca19778437dae502f44363a38e99e3ef5d1.1622730232.git.viremana@linux.microsoft.com>
 <87y2bix8y1.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b74b538-0b28-7a00-0b26-0f926cd8f37e@redhat.com>
Date:   Thu, 10 Jun 2021 17:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87y2bix8y1.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10/06/21 13:20, Vitaly Kuznetsov wrote:

>> +static inline void hv_track_root_tdp(struct kvm_vcpu *vcpu, hpa_t root_tdp)
>> +{
>> +	struct kvm_arch *kvm_arch = &vcpu->kvm->arch;
>> +
>> +	if (kvm_x86_ops.tlb_remote_flush == hv_remote_flush_tlb) {
>> +		spin_lock(&kvm_arch->hv_root_tdp_lock);
>> +		vcpu->arch.hv_root_tdp = root_tdp;
>> +		if (root_tdp != kvm_arch->hv_root_tdp)
>> +			kvm_arch->hv_root_tdp = INVALID_PAGE;
>> +		spin_unlock(&kvm_arch->hv_root_tdp_lock);
>> +	}
>> +}
>> +#else
>> +static inline void hv_track_root_tdp(struct kvm_vcpu *vcpu, hpa_t root_tdp)
>> +{
>> +}
>> +#endif
>> +#endif
> 
> Super-nitpick: I'd suggest adding /* __ARCH_X86_KVM_KVM_ONHYPERV_H__ */
> to the second '#endif' and /* IS_ENABLED(CONFIG_HYPERV) */ to '#else'
> and the first one: files/functions tend to grow and it becomes hard to
> see where the particular '#endif/#else' belongs.

Done, thanks.  I've also changed the #if to just "#ifdef CONFIG_HYPERV", 
since IS_ENABLED is only needed in C statements.

Paolo

>> +
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index d000cddbd734..117fb88cd354 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -52,6 +52,7 @@
>>   #include "cpuid.h"
>>   #include "evmcs.h"
>>   #include "hyperv.h"
>> +#include "kvm_onhyperv.h"
>>   #include "irq.h"
>>   #include "kvm_cache_regs.h"
>>   #include "lapic.h"
>> @@ -474,86 +475,6 @@ static const u32 vmx_uret_msrs_list[] = {
>>   static bool __read_mostly enlightened_vmcs = true;
>>   module_param(enlightened_vmcs, bool, 0444);
>>   
>> -static int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
>> -		void *data)
>> -{
>> -	struct kvm_tlb_range *range = data;
>> -
>> -	return hyperv_fill_flush_guest_mapping_list(flush, range->start_gfn,
>> -			range->pages);
>> -}
>> -
>> -static inline int hv_remote_flush_root_ept(hpa_t root_ept,
>> -					   struct kvm_tlb_range *range)
>> -{
>> -	if (range)
>> -		return hyperv_flush_guest_mapping_range(root_ept,
>> -				kvm_fill_hv_flush_list_func, (void *)range);
>> -	else
>> -		return hyperv_flush_guest_mapping(root_ept);
>> -}
>> -
>> -static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
>> -		struct kvm_tlb_range *range)
>> -{
>> -	struct kvm_vmx *kvm_vmx = to_kvm_vmx(kvm);
>> -	struct kvm_vcpu *vcpu;
>> -	int ret = 0, i, nr_unique_valid_roots;
>> -	hpa_t root;
>> -
>> -	spin_lock(&kvm_vmx->hv_root_ept_lock);
>> -
>> -	if (!VALID_PAGE(kvm_vmx->hv_root_ept)) {
>> -		nr_unique_valid_roots = 0;
>> -
>> -		/*
>> -		 * Flush all valid roots, and see if all vCPUs have converged
>> -		 * on a common root, in which case future flushes can skip the
>> -		 * loop and flush the common root.
>> -		 */
>> -		kvm_for_each_vcpu(i, vcpu, kvm) {
>> -			root = to_vmx(vcpu)->hv_root_ept;
>> -			if (!VALID_PAGE(root) || root == kvm_vmx->hv_root_ept)
>> -				continue;
>> -
>> -			/*
>> -			 * Set the tracked root to the first valid root.  Keep
>> -			 * this root for the entirety of the loop even if more
>> -			 * roots are encountered as a low effort optimization
>> -			 * to avoid flushing the same (first) root again.
>> -			 */
>> -			if (++nr_unique_valid_roots == 1)
>> -				kvm_vmx->hv_root_ept = root;
>> -
>> -			if (!ret)
>> -				ret = hv_remote_flush_root_ept(root, range);
>> -
>> -			/*
>> -			 * Stop processing roots if a failure occurred and
>> -			 * multiple valid roots have already been detected.
>> -			 */
>> -			if (ret && nr_unique_valid_roots > 1)
>> -				break;
>> -		}
>> -
>> -		/*
>> -		 * The optimized flush of a single root can't be used if there
>> -		 * are multiple valid roots (obviously).
>> -		 */
>> -		if (nr_unique_valid_roots > 1)
>> -			kvm_vmx->hv_root_ept = INVALID_PAGE;
>> -	} else {
>> -		ret = hv_remote_flush_root_ept(kvm_vmx->hv_root_ept, range);
>> -	}
>> -
>> -	spin_unlock(&kvm_vmx->hv_root_ept_lock);
>> -	return ret;
>> -}
>> -static int hv_remote_flush_tlb(struct kvm *kvm)
>> -{
>> -	return hv_remote_flush_tlb_with_range(kvm, NULL);
>> -}
>> -
>>   static int hv_enable_direct_tlbflush(struct kvm_vcpu *vcpu)
>>   {
>>   	struct hv_enlightened_vmcs *evmcs;
>> @@ -581,21 +502,6 @@ static int hv_enable_direct_tlbflush(struct kvm_vcpu *vcpu)
>>   
>>   #endif /* IS_ENABLED(CONFIG_HYPERV) */
>>   
>> -static void hv_track_root_ept(struct kvm_vcpu *vcpu, hpa_t root_ept)
>> -{
>> -#if IS_ENABLED(CONFIG_HYPERV)
>> -	struct kvm_vmx *kvm_vmx = to_kvm_vmx(vcpu->kvm);
>> -
>> -	if (kvm_x86_ops.tlb_remote_flush == hv_remote_flush_tlb) {
>> -		spin_lock(&kvm_vmx->hv_root_ept_lock);
>> -		to_vmx(vcpu)->hv_root_ept = root_ept;
>> -		if (root_ept != kvm_vmx->hv_root_ept)
>> -			kvm_vmx->hv_root_ept = INVALID_PAGE;
>> -		spin_unlock(&kvm_vmx->hv_root_ept_lock);
>> -	}
>> -#endif
>> -}
>> -
>>   /*
>>    * Comment's format: document - errata name - stepping - processor name.
>>    * Refer from
>> @@ -3202,7 +3108,7 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
>>   		eptp = construct_eptp(vcpu, root_hpa, root_level);
>>   		vmcs_write64(EPT_POINTER, eptp);
>>   
>> -		hv_track_root_ept(vcpu, root_hpa);
>> +		hv_track_root_tdp(vcpu, root_hpa);
>>   
>>   		if (!enable_unrestricted_guest && !is_paging(vcpu))
>>   			guest_cr3 = to_kvm_vmx(kvm)->ept_identity_map_addr;
>> @@ -6980,9 +6886,6 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
>>   	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
>>   	vmx->pi_desc.sn = 1;
>>   
>> -#if IS_ENABLED(CONFIG_HYPERV)
>> -	vmx->hv_root_ept = INVALID_PAGE;
>> -#endif
>>   	return 0;
>>   
>>   free_vmcs:
>> @@ -6999,10 +6902,6 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
>>   
>>   static int vmx_vm_init(struct kvm *kvm)
>>   {
>> -#if IS_ENABLED(CONFIG_HYPERV)
>> -	spin_lock_init(&to_kvm_vmx(kvm)->hv_root_ept_lock);
>> -#endif
>> -
>>   	if (!ple_gap)
>>   		kvm->arch.pause_in_guest = true;
>>   
>> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
>> index 008cb87ff088..d1363e734a01 100644
>> --- a/arch/x86/kvm/vmx/vmx.h
>> +++ b/arch/x86/kvm/vmx/vmx.h
>> @@ -328,10 +328,6 @@ struct vcpu_vmx {
>>   	/* SGX Launch Control public key hash */
>>   	u64 msr_ia32_sgxlepubkeyhash[4];
>>   
>> -#if IS_ENABLED(CONFIG_HYPERV)
>> -	u64 hv_root_ept;
>> -#endif
>> -
>>   	struct pt_desc pt_desc;
>>   	struct lbr_desc lbr_desc;
>>   
>> @@ -349,11 +345,6 @@ struct kvm_vmx {
>>   	unsigned int tss_addr;
>>   	bool ept_identity_pagetable_done;
>>   	gpa_t ept_identity_map_addr;
>> -
>> -#if IS_ENABLED(CONFIG_HYPERV)
>> -	hpa_t hv_root_ept;
>> -	spinlock_t hv_root_ept_lock;
>> -#endif
>>   };
>>   
>>   bool nested_vmx_allowed(struct kvm_vcpu *vcpu);
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 6eda2834fc05..580f3c6c86f9 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -10279,6 +10279,10 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>>   	vcpu->arch.pending_external_vector = -1;
>>   	vcpu->arch.preempted_in_kernel = false;
>>   
>> +#if IS_ENABLED(CONFIG_HYPERV)
>> +	vcpu->arch.hv_root_tdp = INVALID_PAGE;
>> +#endif
>> +
>>   	r = static_call(kvm_x86_vcpu_create)(vcpu);
>>   	if (r)
>>   		goto free_guest_fpu;
>> @@ -10662,6 +10666,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>   
>>   	kvm->arch.guest_can_read_msr_platform_info = true;
>>   
>> +#if IS_ENABLED(CONFIG_HYPERV)
>> +	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
>> +	kvm->arch.hv_root_tdp = INVALID_PAGE;
>> +#endif
>> +
>>   	INIT_DELAYED_WORK(&kvm->arch.kvmclock_update_work, kvmclock_update_fn);
>>   	INIT_DELAYED_WORK(&kvm->arch.kvmclock_sync_work, kvmclock_sync_fn);
> 

