Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E2B5BF925
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Sep 2022 10:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiIUI1N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Sep 2022 04:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIUI0l (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Sep 2022 04:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AB08307A
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663748786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OxqnkQajpn99IzMrg8Y6wdAwq3ivT6h+0crxz9yvN4Q=;
        b=OsRJS1Dost0ccCxe/ywCY/H8g6o2vHf7Q6z19SKMOL46/lWpmT/l3OZEKFCbdptnQBVxeF
        wIr5yOzcWHuPhBTuHo8AbnLxA33tLiNhP9JiwLrcr3PWbpomSD+jNiQbxNPX1KiWLmAlcs
        kyVaCvOxpS/nqqlYv6SvjPHT9nsJRrE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-YMcl1CnIPS64ZiEB5f4o_A-1; Wed, 21 Sep 2022 04:26:22 -0400
X-MC-Unique: YMcl1CnIPS64ZiEB5f4o_A-1
Received: by mail-wr1-f72.google.com with SMTP id d30-20020adfa41e000000b00228c0e80c49so2133575wra.21
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 01:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=OxqnkQajpn99IzMrg8Y6wdAwq3ivT6h+0crxz9yvN4Q=;
        b=drVM9aIRu7vwCBp9EUnP4e66j65jV3j7C7pZQq5ZDVnyn3N/xQk6axyaWA8fG/bZY1
         IjthSL5Wz/uyfkMAaHXQWpSIsyLNTR81mDnPjqxJwurcWRpYfa2tgnE3bDSdA8VqMRz/
         yjeEzvK5x6Yz469RKMVXy1wkydvY68pVyGYEZ68FXV/hvWx0d6a3CHnKvRLQ4HGF+tBD
         EB5WQc4f0B2lvB/4xTItW3qJJD9v4gxH8P/bTs/HjTm6C8EE2xLgyUkhQjz1Xw9Y0p4/
         QhqnKNsBZ2CYE1+jFnhZzlZC4tjV4OiEnVfryII1KA61BG7TnNTzS7XtmXMYGIEhcj7c
         39Lg==
X-Gm-Message-State: ACrzQf2l0Y1Z1Rb/xgdprNcNMa7zDIAHYBoG/F3pOGu95PH4vLR2vG8Z
        XY08VMDdhVjul7O28+/arbEghTCcj1cwXIMS3DvBtoeiQDaQl/aSeaDF5oH0uBldxa8oJuXuB4w
        iynDonaQ3vOlfRC4aBTzAvJf2
X-Received: by 2002:adf:fa88:0:b0:228:6237:d46c with SMTP id h8-20020adffa88000000b002286237d46cmr16685050wrr.571.1663748781592;
        Wed, 21 Sep 2022 01:26:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4lLiUhK7+1eJRdkCycDfmV6RcyYlhEIVQq8hSWwQb9FFpdnaFP2+9wUOZMJLseyc4gL0+GXw==
X-Received: by 2002:adf:fa88:0:b0:228:6237:d46c with SMTP id h8-20020adffa88000000b002286237d46cmr16685030wrr.571.1663748781318;
        Wed, 21 Sep 2022 01:26:21 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bx29-20020a5d5b1d000000b0021f131de6aesm1905707wrb.34.2022.09.21.01.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:26:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] KVM: x86: Hyper-V invariant TSC control
In-Reply-To: <YypGs6BOX7Wvtl/H@google.com>
References: <20220916135205.3185973-1-vkuznets@redhat.com>
 <20220916135205.3185973-4-vkuznets@redhat.com>
 <YypGs6BOX7Wvtl/H@google.com>
Date:   Wed, 21 Sep 2022 10:26:18 +0200
Message-ID: <87zgetnnf9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Sep 16, 2022, Vitaly Kuznetsov wrote:
>> Normally, genuine Hyper-V doesn't expose architectural invariant TSC
>> (CPUID.80000007H:EDX[8]) to its guests by default. A special PV MSR
>> (HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x40000118) and corresponding CPUID
>> feature bit (CPUID.0x40000003.EAX[15]) were introduced. When bit 0 of the
>> PV MSR is set, invariant TSC bit starts to show up in CPUID. When the
>> feature is exposed to Hyper-V guests, reenlightenment becomes unneeded.
>> 
>> Add the feature to KVM. Keep CPUID output intact when the feature
>> wasn't exposed to L1 and implement the required logic for hiding
>> invariant TSC when the feature was exposed and invariant TSC control
>> MSR wasn't written to. Copy genuine Hyper-V behavior and forbid to
>> disable the feature once it was enabled.
>
> ...
>
>> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
>> index da2737f2a956..8be6dc3d76af 100644
>> --- a/arch/x86/kvm/hyperv.h
>> +++ b/arch/x86/kvm/hyperv.h
>> @@ -133,6 +133,21 @@ static inline bool kvm_hv_has_stimer_pending(struct kvm_vcpu *vcpu)
>>  			     HV_SYNIC_STIMER_COUNT);
>>  }
>>  
>> +/*
>> + * With HV_ACCESS_TSC_INVARIANT feature, invariant TSC (CPUID.80000007H:EDX[8])
>> + * is only observed after HV_X64_MSR_TSC_INVARIANT_CONTROL was written to.
>> + */
>> +static inline bool kvm_hv_invtsc_suppressed(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>> +
>> +	if (!hv_vcpu)
>> +		return false;
>> +
>> +	return (hv_vcpu->cpuid_cache.features_eax & HV_ACCESS_TSC_INVARIANT) &&
>> +		!(to_kvm_hv(vcpu->kvm)->hv_invtsc_control & HV_INVARIANT_TSC_EXPOSED);
>
> It's still not obvious to me why KVM shouldn't do:
>
> 	if (!hv_vcpu)
> 		return false;
>
> 	return !(hv_vcpu->cpuid_cache.features_eax & HV_ACCESS_TSC_INVARIANT) ||
> 	       !(to_kvm_hv(vcpu->kvm)->hv_invtsc_control & HV_INVARIANT_TSC_EXPOSED);
>
> I.e. why is invariant TSC _not_ suppressed on Hyper-V by default?

In case we switch to suppressing invtsc (CPUID.80000007H:EDX[8]) by
default, i.e. when HV_ACCESS_TSC_INVARIANT was not set in guest visible
CPUIDs, this is going to be a behavioral change for the already existing
configurations and we certainly don't want that. It was expirementally
proven that at least some Windows versions are perfectly happy when they
see invtsc without this PV feature so I don't see a need to break the
status quo. This PV feature is needed for completeness and to be
compliant with genuine Hyper-V in the long run. When enabling the
feature in QEMU, we may add a warning saying 'invtsc passed without
hv_invtsc' and maybe even switch to error some time in the future but
just like tracking dependencies between different Hyper-V
enlightenments, this is VMM's job, not KVM's. 

-- 
Vitaly

