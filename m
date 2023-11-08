Return-Path: <linux-hyperv+bounces-753-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4698C7E55EF
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 13:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA46281154
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A380171CB;
	Wed,  8 Nov 2023 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyalZMIp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C69171A7
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 12:11:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26FE1BCC
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 04:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699445500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MIdn2h0+jJPp8jBzgPADOJIJ5C90kwwjTJ/BpUddmP4=;
	b=PyalZMIp+vz9kMnnYsnSDyzON8ktq+3topFOazTpQEc1spoQdbOxKgF119DU/1OOBzNMXL
	5Her3gW19bK+8xSUV6ox0uKCHVOqPX3m4hLktSA+2od84Pcp+DbfzjZY0w9GHzH6iQIf27
	f3ahLsBcF0Wn/yl8QUvvIpfSNYu4J00=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-LkpjuOPQOl6rXSM7PS1kyg-1; Wed, 08 Nov 2023 07:11:39 -0500
X-MC-Unique: LkpjuOPQOl6rXSM7PS1kyg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5411d71889aso5907436a12.2
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Nov 2023 04:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699445498; x=1700050298;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIdn2h0+jJPp8jBzgPADOJIJ5C90kwwjTJ/BpUddmP4=;
        b=MMLQe0ElgYyf13l3G0s6IT6+zh5d+Hz0fYG3ul4U3ApZ6xudnmfTlW4vkKRGZBNQJ7
         ZUk06hdtQqS9PpxbTWU/EGyHWsaUMcv0tqkPKbyGa5Vpq1fA5CufqcVjbIfKhCfOLP37
         1TFmYrDB8MHNnPu+3UbN5J5LfkYXlocnN9BnkXrbMrXa2V573REDyww335KGojWqsPDS
         yHcz2N1iZtLM1Pkbwv+O/qUftX28LxYOy822B7TT1HwakiPqs9unJJYmSVvvxzRwgz3t
         CqmoXCVWhn0T+gHsZNy/r192Ors5C106dtmWlqmEoVoOSDv/ST5i8JjtkHhekakQ95c+
         kiCw==
X-Gm-Message-State: AOJu0YzjO4ukvzLGIAjl2KqzRgJPWscWFRxLZhzumZCckwCinL3fsj2w
	uu4xZeVH7UonS1pjvkfPLB6C46ajlpCqMd2rUf7kOTRp5ql4isHHCD/bo8iBcUY/3W1JiRsKXK1
	RkwrPDicRoZ5BinRFJcCSkZ5b
X-Received: by 2002:a50:8ad4:0:b0:543:75cb:214e with SMTP id k20-20020a508ad4000000b0054375cb214emr1444387edk.11.1699445498603;
        Wed, 08 Nov 2023 04:11:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhfSx+o999aMLvnnKbti3Y56a0aT17wE5jt2fKKmerXI0YOYY3lL9EANH3nWHOeXnsV7ySbw==
X-Received: by 2002:a50:8ad4:0:b0:543:75cb:214e with SMTP id k20-20020a508ad4000000b0054375cb214emr1444360edk.11.1699445498234;
        Wed, 08 Nov 2023 04:11:38 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id u14-20020a50c04e000000b005412c0ba2f9sm6729328edd.13.2023.11.08.04.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 04:11:37 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Alexander Graf <graf@amazon.com>, Nicolas Saenz Julienne
 <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 pbonzini@redhat.com, seanjc@google.com, anelkz@amazon.com,
 dwmw@amazon.co.uk, jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [RFC 03/33] KVM: x86: hyper-v: Introduce XMM output support
In-Reply-To: <82c5a8c8-2c3c-43dc-95c2-4d465fe63985@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
 <20231108111806.92604-4-nsaenz@amazon.com>
 <82c5a8c8-2c3c-43dc-95c2-4d465fe63985@amazon.com>
Date: Wed, 08 Nov 2023 13:11:36 +0100
Message-ID: <87o7g4e96v.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Graf <graf@amazon.com> writes:

> On 08.11.23 12:17, Nicolas Saenz Julienne wrote:
>> Prepare infrastructure to be able to return data through the XMM
>> registers when Hyper-V hypercalls are issues in fast mode. The XMM
>> registers are exposed to user-space through KVM_EXIT_HYPERV_HCALL and
>> restored on successful hypercall completion.
>>
>> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
>> ---
>>   arch/x86/include/asm/hyperv-tlfs.h |  2 +-
>>   arch/x86/kvm/hyperv.c              | 33 +++++++++++++++++++++++++++++-
>>   include/uapi/linux/kvm.h           |  6 ++++++
>>   3 files changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> index 2ff26f53cd62..af594aa65307 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -49,7 +49,7 @@
>>   /* Support for physical CPU dynamic partitioning events is available*/
>>   #define HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE	BIT(3)
>>   /*
>> - * Support for passing hypercall input parameter block via XMM
>> + * Support for passing hypercall input and output parameter block via XMM
>>    * registers is available
>>    */
>>   #define HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE		BIT(4)
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index 238afd7335e4..e1bc861ab3b0 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -1815,6 +1815,7 @@ struct kvm_hv_hcall {
>>   	u16 rep_idx;
>>   	bool fast;
>>   	bool rep;
>> +	bool xmm_dirty;
>>   	sse128_t xmm[HV_HYPERCALL_MAX_XMM_REGISTERS];
>>   
>>   	/*
>> @@ -2346,9 +2347,33 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
>>   	return ret;
>>   }
>>   
>> +static void kvm_hv_write_xmm(struct kvm_hyperv_xmm_reg *xmm)
>> +{
>> +	int reg;
>> +
>> +	kvm_fpu_get();
>> +	for (reg = 0; reg < HV_HYPERCALL_MAX_XMM_REGISTERS; reg++) {
>> +		const sse128_t data = sse128(xmm[reg].low, xmm[reg].high);
>> +		_kvm_write_sse_reg(reg, &data);
>> +	}
>> +	kvm_fpu_put();
>> +}
>> +
>> +static bool kvm_hv_is_xmm_output_hcall(u16 code)
>> +{
>> +	return false;
>> +}
>> +
>>   static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
>>   {
>> -	return kvm_hv_hypercall_complete(vcpu, vcpu->run->hyperv.u.hcall.result);
>> +	bool fast = !!(vcpu->run->hyperv.u.hcall.input & HV_HYPERCALL_FAST_BIT);
>> +	u16 code = vcpu->run->hyperv.u.hcall.input & 0xffff;
>> +	u64 result = vcpu->run->hyperv.u.hcall.result;
>> +
>> +	if (kvm_hv_is_xmm_output_hcall(code) && hv_result_success(result) && fast)
>> +		kvm_hv_write_xmm(vcpu->run->hyperv.u.hcall.xmm);
>> +
>> +	return kvm_hv_hypercall_complete(vcpu, result);
>>   }
>>   
>>   static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>> @@ -2623,6 +2648,9 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>>   		break;
>>   	}
>>   
>> +	if ((ret & HV_HYPERCALL_RESULT_MASK) == HV_STATUS_SUCCESS && hc.xmm_dirty)
>> +		kvm_hv_write_xmm((struct kvm_hyperv_xmm_reg*)hc.xmm);
>> +
>>   hypercall_complete:
>>   	return kvm_hv_hypercall_complete(vcpu, ret);
>>   
>> @@ -2632,6 +2660,8 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>>   	vcpu->run->hyperv.u.hcall.input = hc.param;
>>   	vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
>>   	vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
>> +	if (hc.fast)
>> +		memcpy(vcpu->run->hyperv.u.hcall.xmm, hc.xmm, sizeof(hc.xmm));
>>   	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
>>   	return 0;
>>   }
>> @@ -2780,6 +2810,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>>   			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
>>   
>>   			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
>> +			ent->edx |= HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
>
>
> Shouldn't this be guarded by an ENABLE_CAP to make sure old user space 
> that doesn't know about xmm outputs is still able to run with newer kernels?
>

No, we don't do CAPs for new Hyper-V features anymore since we have
KVM_GET_SUPPORTED_HV_CPUID. Userspace is not supposed to simply copy
its output into guest visible CPUIDs, it must only enable features it
knows. Even 'hv_passthrough' option in QEMU doesn't pass unknown
features through.

>
>>   			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
>>   			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
>>   
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index d7a01766bf21..5ce06a1eee2b 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -192,6 +192,11 @@ struct kvm_s390_cmma_log {
>>   	__u64 values;
>>   };
>>   
>> +struct kvm_hyperv_xmm_reg {
>> +	__u64 low;
>> +	__u64 high;
>> +};
>> +
>>   struct kvm_hyperv_exit {
>>   #define KVM_EXIT_HYPERV_SYNIC          1
>>   #define KVM_EXIT_HYPERV_HCALL          2
>> @@ -210,6 +215,7 @@ struct kvm_hyperv_exit {
>>   			__u64 input;
>>   			__u64 result;
>>   			__u64 params[2];
>> +			struct kvm_hyperv_xmm_reg xmm[6];
>
>
> Would this change the size of struct kvm_hyperv_exit? And if so, 
> wouldn't that potentially be a UABI breakage?
>

Yes. 'struct kvm_hyperv_exit' has 'type' field which determines which
particular type of the union (synic/hcall/syndbg) is used. The easiest
would probably be to introduce a new type (hcall_with_xmm or something
like that). 

>
> Alex
>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>

-- 
Vitaly


