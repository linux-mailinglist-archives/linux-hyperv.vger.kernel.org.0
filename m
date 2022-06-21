Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70221553371
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jun 2022 15:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351533AbiFUNTf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Jun 2022 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351549AbiFUNTL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Jun 2022 09:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 843352E68F
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Jun 2022 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655817429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I/PGdDkeKw0LUYKZjcGaK8QInb90wYgNpPu7PI9aC5E=;
        b=fxr8R4bKd4M15v9fgiN+dhtQRG0Aag5uS5vAudq1fPkvAcXc86nOuRrZ2jzyQFyOwlwVwT
        rNVmyWVG9wfhggBSi6HRX1wLFHarsADqCObmlxT90VqZ47ppOLb2MCrfH2loSm5xKNQCcm
        bt11h8Nyi/z8rLu3dCoCZkiTWChSlv4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-LPR_JUQiNbyTyPYoQGAtmA-1; Tue, 21 Jun 2022 09:17:08 -0400
X-MC-Unique: LPR_JUQiNbyTyPYoQGAtmA-1
Received: by mail-wm1-f71.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so6408322wmj.0
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Jun 2022 06:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I/PGdDkeKw0LUYKZjcGaK8QInb90wYgNpPu7PI9aC5E=;
        b=lklRQBbZtHXtmyFMOfM1v8QglrknnMwB5HjpqmdIfqo9fx/SXSuZ2Ce6xCPBSsbeih
         m/NE0hHmzNp7/wl01XjEA+28gRBoeCrHBKu3+PK5ToqsygPRcio2DrdtH25+p1LJgUr6
         jr9ffRdXOIBc6GCnQOqeSk/x2bMpcHi1og3bCJBJ0KsNmvMqc/1qBwGM+oVTPSKTFX7g
         xz4FaLwmWpK4z22tiy79AB0TvPRufAH4timf/R/zB6ewQT1o9sA1AeCKGkgL2OgCE5mG
         NLH3pin9OMh9zrx2XP9PzB93zQeyPLzSRKik5gu2maq5xg6iGSLUw2IdBUUH8C6WRoHq
         DJ4w==
X-Gm-Message-State: AJIora9a5j1J6uWg7epLLdjBuKSgnFBQZnw2+t+2IHnF66hYJf4FnWdA
        dDGuGmgyygNhn/hoiunSCb4H05PjAxTK4qAKfHShy6Id6zYHj1mS0Ipw68CmFF/UTACla4OgyH+
        c7u7Dum6ARPGp6jQSyRQaNsyp
X-Received: by 2002:adf:fd84:0:b0:21a:3d9d:dfa5 with SMTP id d4-20020adffd84000000b0021a3d9ddfa5mr23083482wrr.345.1655817426870;
        Tue, 21 Jun 2022 06:17:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sNgHOsz/KBWcgpuoJuuCYTvX1R6H2o7ZWT1RGTQOW/4z8Atos06DjShfKYzU9sm5+m7p9pSA==
X-Received: by 2002:adf:fd84:0:b0:21a:3d9d:dfa5 with SMTP id d4-20020adffd84000000b0021a3d9ddfa5mr23083465wrr.345.1655817426627;
        Tue, 21 Jun 2022 06:17:06 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d67c3000000b0021b8cd8a068sm7236417wrw.49.2022.06.21.06.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 06:17:06 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/39] KVM: x86: hyper-v: Don't use
 sparse_set_to_vcpu_mask() in kvm_hv_send_ipi()
In-Reply-To: <17a2e85a-a1f2-99e1-fc69-1baed2275bd5@redhat.com>
References: <20220613133922.2875594-1-vkuznets@redhat.com>
 <20220613133922.2875594-11-vkuznets@redhat.com>
 <17a2e85a-a1f2-99e1-fc69-1baed2275bd5@redhat.com>
Date:   Tue, 21 Jun 2022 15:17:05 +0200
Message-ID: <87zgi640mm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 6/13/22 15:38, Vitaly Kuznetsov wrote:
>> Get rid of on-stack allocation of vcpu_mask and optimize kvm_hv_send_ipi()
>> for a smaller number of vCPUs in the request. When Hyper-V TLB flush
>> is in  use, HvSendSyntheticClusterIpi{,Ex} calls are not commonly used to
>> send IPIs to a large number of vCPUs (and are rarely used in general).
>> 
>> Introduce hv_is_vp_in_sparse_set() to directly check if the specified
>> VP_ID is present in sparse vCPU set.
>> 
>> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>   arch/x86/kvm/hyperv.c | 37 ++++++++++++++++++++++++++-----------
>>   1 file changed, 26 insertions(+), 11 deletions(-)
>
> I'm a bit confused by this patch being in this series.
>
> Just to be clear, PV IPI does *not* support the VP_ID, right? 

Hm, with Hyper-V PV IPI hypercall vCPUs are also addressed by their
VP_IDs, not by their APIC ids so similar to Hyper-V PV TLB flush we need
to convert the supplied set (either flat u64 bitmask of VP_IDs for
non-EX hypercall or a sparse set for -EX).

> And since patch 12 only affects the sparse banks, the patch does not
> have any other dependency.  Is this correct?
>

This patch introduces hv_is_vp_in_sparse_set() with its first user:
kvm_hv_send_ipi_to_many(). Later in the series, hv_is_vp_in_sparse_set()
gets a second user: kvm_hv_flush_tlb() for 'nested' case where we
actually have to traverse all vCPUs checking *nested* VP_IDs (as KVM
doesn't currently keep a convenient L2-VP_ID-to-kvm-vcpu-id mapping.

> Paolo
>
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index f41153c71beb..269a5fcca31b 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -1747,6 +1747,25 @@ static void sparse_set_to_vcpu_mask(struct kvm *kvm, u64 *sparse_banks,
>>   	}
>>   }
>>   
>> +static bool hv_is_vp_in_sparse_set(u32 vp_id, u64 valid_bank_mask, u64 sparse_banks[])
>> +{
>> +	int bank, sbank = 0;
>> +
>> +	if (!test_bit(vp_id / HV_VCPUS_PER_SPARSE_BANK,
>> +		      (unsigned long *)&valid_bank_mask))
>> +		return false;
>> +
>> +	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask,
>> +			 KVM_HV_MAX_SPARSE_VCPU_SET_BITS) {
>> +		if (bank == vp_id / HV_VCPUS_PER_SPARSE_BANK)
>> +			break;
>> +		sbank++;
>> +	}
>> +
>> +	return test_bit(vp_id % HV_VCPUS_PER_SPARSE_BANK,
>> +			(unsigned long *)&sparse_banks[sbank]);
>> +}
>> +
>>   struct kvm_hv_hcall {
>>   	u64 param;
>>   	u64 ingpa;
>> @@ -2029,8 +2048,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>>   		((u64)hc->rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
>>   }
>>   
>> -static void kvm_send_ipi_to_many(struct kvm *kvm, u32 vector,
>> -				 unsigned long *vcpu_bitmap)
>> +static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
>> +				    u64 *sparse_banks, u64 valid_bank_mask)
>>   {
>>   	struct kvm_lapic_irq irq = {
>>   		.delivery_mode = APIC_DM_FIXED,
>> @@ -2040,7 +2059,10 @@ static void kvm_send_ipi_to_many(struct kvm *kvm, u32 vector,
>>   	unsigned long i;
>>   
>>   	kvm_for_each_vcpu(i, vcpu, kvm) {
>> -		if (vcpu_bitmap && !test_bit(i, vcpu_bitmap))
>> +		if (sparse_banks &&
>> +		    !hv_is_vp_in_sparse_set(kvm_hv_get_vpindex(vcpu),
>> +					    valid_bank_mask,
>> +					    sparse_banks))
>>   			continue;
>>   
>>   		/* We fail only when APIC is disabled */
>> @@ -2053,7 +2075,6 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>>   	struct kvm *kvm = vcpu->kvm;
>>   	struct hv_send_ipi_ex send_ipi_ex;
>>   	struct hv_send_ipi send_ipi;
>> -	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
>>   	u64 valid_bank_mask;
>>   	u64 sparse_banks[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
>>   	u32 vector;
>> @@ -2115,13 +2136,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>>   	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
>>   		return HV_STATUS_INVALID_HYPERCALL_INPUT;
>>   
>> -	if (all_cpus) {
>> -		kvm_send_ipi_to_many(kvm, vector, NULL);
>> -	} else {
>> -		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
>> -
>> -		kvm_send_ipi_to_many(kvm, vector, vcpu_mask);
>> -	}
>> +	kvm_hv_send_ipi_to_many(kvm, vector, all_cpus ? NULL : sparse_banks, valid_bank_mask);
>>   
>>   ret_success:
>>   	return HV_STATUS_SUCCESS;
>

-- 
Vitaly

