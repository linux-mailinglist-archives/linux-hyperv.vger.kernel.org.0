Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E51E60F20E
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Oct 2022 10:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiJ0ISV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Oct 2022 04:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiJ0ISU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Oct 2022 04:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEE9EEAB4
        for <linux-hyperv@vger.kernel.org>; Thu, 27 Oct 2022 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666858699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+zjgwfHgHFBXNtS1dcXbFjT5C6bNkpnBbMlxremMWY=;
        b=MUD+cnXr1io+bYdM9O2s0fJAlr36/AHyR4VkbQzkAMj8CRI77Dsllkjy95KbPbEkq4kA4Z
        hB+Mscw/e5p/FCu/E+9aiF/KvpWAIODSR4641AIm18G4rMcayBloBQa3QcTaJFxnLms7KA
        ckb0yr5e9Zi5otQ+HC2ocajC5P2b7XY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-241-SDf7iMLAPMmoZ209koIJog-1; Thu, 27 Oct 2022 04:18:17 -0400
X-MC-Unique: SDf7iMLAPMmoZ209koIJog-1
Received: by mail-wm1-f70.google.com with SMTP id 3-20020a05600c020300b003c5eefe54adso260288wmi.9
        for <linux-hyperv@vger.kernel.org>; Thu, 27 Oct 2022 01:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+zjgwfHgHFBXNtS1dcXbFjT5C6bNkpnBbMlxremMWY=;
        b=efKYlZvvMxfmfk5RwATzaoT0Xu8+elTqNAkksX3olwfwEQxTYIPRuKgoFf069Nnucg
         9ojoSx4ZxqNOa/LY7QQX5i3kTPpzos5tWPSfHfCSxHvQhumWk8jvSTkHc802sUB25ymt
         FJFJZaWKd04OChmCBHlS7dgm1JZ+iPrUx6wBXEUfE07oB7DYGmWn8LX7ou5xzLYUO9mL
         AnVWKoFXsdksuh/swfMfddwEj68aiN9NUY+fMHlAMm7iclAjEYnsL9G1S2O256iUoqFl
         dxPS99JOMOb64+4z2aRgxlu8v67mTCOL1uZrRYwxxDDVlx98O9jz2B9tA+0v0dG1+P3X
         sFyg==
X-Gm-Message-State: ACrzQf19rYtF7W1DzQOcM7bWST+F9TSh2S/OzNBObhL/eqWbbteIV4gB
        Xy/mZO/eL6LjFO6BAkbiDZ+jUo4iXAMKWGzYWTp2Z0YmlsLnbJ1NPZRof4kw9Z+mH/N8kkiiYRM
        pzfrr58U88GazU5JWcYwSv22y
X-Received: by 2002:adf:ebcf:0:b0:22c:9eb4:d6f6 with SMTP id v15-20020adfebcf000000b0022c9eb4d6f6mr31409126wrn.251.1666858696587;
        Thu, 27 Oct 2022 01:18:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4CgeyUAU3EZlndfaRTAGP3JWCxEXgwxeBo73X8Vdko0Rf33SSC2AqFidTXI1tyqPqoddOuig==
X-Received: by 2002:adf:ebcf:0:b0:22c:9eb4:d6f6 with SMTP id v15-20020adfebcf000000b0022c9eb4d6f6mr31409114wrn.251.1666858696314;
        Thu, 27 Oct 2022 01:18:16 -0700 (PDT)
Received: from ovpn-194-52.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c1c8100b003b4fe03c881sm4208779wms.48.2022.10.27.01.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 01:18:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 13/46] KVM: x86: Prepare kvm_hv_flush_tlb() to
 handle L2's GPAs
In-Reply-To: <Y1m0HCMgwJen/NnU@google.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
 <20221021153521.1216911-14-vkuznets@redhat.com>
 <Y1m0HCMgwJen/NnU@google.com>
Date:   Thu, 27 Oct 2022 10:18:14 +0200
Message-ID: <87ilk5u1bt.fsf@ovpn-194-52.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Oct 21, 2022, Vitaly Kuznetsov wrote:
>> To handle L2 TLB flush requests, KVM needs to translate the specified
>> L2 GPA to L1 GPA to read hypercall arguments from there.
>> 
>> No functional change as KVM doesn't handle VMCALL/VMMCALL from L2 yet.
>> 
>> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/hyperv.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index fca9c51891f5..df1efb821eb0 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -23,6 +23,7 @@
>>  #include "ioapic.h"
>>  #include "cpuid.h"
>>  #include "hyperv.h"
>> +#include "mmu.h"
>>  #include "xen.h"
>>  
>>  #include <linux/cpu.h>
>> @@ -1908,6 +1909,12 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>>  	 */
>>  	BUILD_BUG_ON(KVM_HV_MAX_SPARSE_VCPU_SET_BITS > 64);
>>  
>> +	if (!hc->fast && is_guest_mode(vcpu)) {
>
> Please add a comment explaining why only "slow" hypercalls need to translate the
> GPA from L2=>L1.
>
> With a comment (and assuming this isn't a bug),

This is intended,

For "slow" hypercalls 'hc->ingpa' is the GPA (or an 'nGPA' -- thus the
patch) in guest memory where hypercall parameters are placed, kvm reads
them with kvm_read_guest() later. For "fast" hypercalls 'ingpa' is a
misnomer as it is not an address but the first parameter (in the 'tlb
flush' case it's 'address space id' which we currently don't
analyze). We may want to add a union in 'struct kvm_hv_hcall' to make
this explicit.

The comment I'm thinking of would be:

"
/*
 * 'Slow' hypercall's first parameter is the address in guest's memory where
 * hypercall parameters are placed. This is either a GPA or a nested GPA when
 * KVM is handling the call from L2 ('direct' TLB flush), translate the address
 * here so the memory can be uniformly read with kvm_read_guest().
 */
"

>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
>

-- 
Vitaly

