Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC05587CAC
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Aug 2022 14:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiHBMxF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Aug 2022 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiHBMxD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Aug 2022 08:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB456DFC5
        for <linux-hyperv@vger.kernel.org>; Tue,  2 Aug 2022 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659444781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ikm4kV/UdS8r7b2LACfyNidZ5DHXkyUZcz44yJZqUQ=;
        b=H48DgtWvVHEXw1/gjBdYkrA9Jk6FWxjU/5BQ0pS2nfhRTPyzc8prdLaV7oDEW+iod+Sa36
        WRTGeDywXumacUVi5mp9vz1jhXUyYGfril9z++8RbKatv9S59fU1YaTgewqQ4rC2Zeg09b
        0TPae/n8DuCHLCEmBpICwAWe1kt+7R8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-0lLGs7i2NbGfm2DejzK7yQ-1; Tue, 02 Aug 2022 08:52:58 -0400
X-MC-Unique: 0lLGs7i2NbGfm2DejzK7yQ-1
Received: by mail-wm1-f71.google.com with SMTP id r10-20020a05600c284a00b003a2ff6c9d6aso9484676wmb.4
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Aug 2022 05:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5ikm4kV/UdS8r7b2LACfyNidZ5DHXkyUZcz44yJZqUQ=;
        b=Rr1JV5NmbbSVcCD7shBohieLPaDZzUJIhsUNiz+uH8ebgXkZWZxOB6EA9fCaOLriuw
         AjkjcUROo+u9OArbtzczZSXe4SCY+XYUWKLLhZhPD0NQmDUtOtwFimaL0m2OUe9/hO7V
         LWTs8a1RsRmDW2ACbpZQKWo4tawgTkiZVD2nHiAR4iC2rPl2JvnYTJ+IKlI5Nqax0g22
         xmVECzmfgEUW2CFEyP0DyiKNMOPO97EhDHdJzPjToiTl+0QsEPvpFc1Bc75I6L6EoX43
         T5qrXWSPfyLqVrKQ1jRlv4vuzVxkFvlp4NOdwOVNGa/eENEwwvWCjtufMdWKCGAXjL/S
         zAYQ==
X-Gm-Message-State: ACgBeo0PXQbS7M6QokTx5i3pyJKRyBeLSkZTBYH/WP2AFthM3x0VcRLo
        /Ztax5tLIEPUTSYZbSQ1SRz2hrZWckshAHbp0m/D7wXy8qS9yegmeoNdoOLgXfrMyDgeeePJf4c
        2RB4YHpp+GgsvGpAmgi+vOZMK
X-Received: by 2002:adf:efc3:0:b0:21f:15aa:1b40 with SMTP id i3-20020adfefc3000000b0021f15aa1b40mr11167755wrp.159.1659444777641;
        Tue, 02 Aug 2022 05:52:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR53vslDjhAhACNp2Z0SdysXb8V4ku9F/Q9BfjcKTCX8Mhagp7O22Wv6hJv6kZKMItFdg5F7vg==
X-Received: by 2002:adf:efc3:0:b0:21f:15aa:1b40 with SMTP id i3-20020adfefc3000000b0021f15aa1b40mr11167735wrp.159.1659444777341;
        Tue, 02 Aug 2022 05:52:57 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ba4-20020a0560001c0400b002205f0890eesm8621527wrb.77.2022.08.02.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:52:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/25] KVM: VMX: Tweak the special handling of
 SECONDARY_EXEC_ENCLS_EXITING in setup_vmcs_config()
In-Reply-To: <YtnPEem7q1i+4VBN@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-15-vkuznets@redhat.com>
 <YtnPEem7q1i+4VBN@google.com>
Date:   Tue, 02 Aug 2022 14:52:55 +0200
Message-ID: <87o7x224ew.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
>> SECONDARY_EXEC_ENCLS_EXITING is conditionally added to the 'optional'
>> checklist in setup_vmcs_config() but there's little value in doing so.
>> First, as the control is optional, we can always check for its
>> presence, no harm done. Second, the only real value cpu_has_sgx() check
>> gives is that on the CPUs which support SECONDARY_EXEC_ENCLS_EXITING but
>> don't support SGX, the control is not getting enabled. It's highly unlikely
>> such CPUs exist but it's possible that some hypervisors expose broken vCPU
>> models.
>
> It's not just broken vCPU models, SGX can be "soft-disabled" on bare metal, e.g. if
> software writes MCE control MSRs or there's an uncorrectable #MC (may not be the
> case on all platforms).  This is architectural behavior and needs to be handled in
> KVM.  Obviously if SGX gets disabled after KVM is loaded then we're out of luck, but
> having the ENCL-exiting control without SGX being enabled is 100% valid.
>
> As for why KVM bothers with the check, it's to work around a suspected hardware
> or XuCode bug (I'm still a bit shocked that's public now :-) ) where SGX got
> _hard_ disabled across S3 on some CPUs and made the fields magically disappear.
> The workaround was to soft-disable SGX in BIOS so that KVM wouldn't attempt to
> enable the ENCLS-exiting control

Oh, thanks for this insight, I had no idea! I'll adjust my commit
message accordingly.

>
>> Preserve cpu_has_sgx() check but filter the result of adjust_vmx_controls()
>> instead of the input.
>> 
>> Reviewed-by: Jim Mattson <jmattson@google.com>
>> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/vmx.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index ce54f13d8da1..566be73c6509 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -2528,9 +2528,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>  			SECONDARY_EXEC_PT_CONCEAL_VMX |
>>  			SECONDARY_EXEC_ENABLE_VMFUNC |
>>  			SECONDARY_EXEC_BUS_LOCK_DETECTION |
>> -			SECONDARY_EXEC_NOTIFY_VM_EXITING;
>> -		if (cpu_has_sgx())
>> -			opt2 |= SECONDARY_EXEC_ENCLS_EXITING;
>> +			SECONDARY_EXEC_NOTIFY_VM_EXITING |
>> +			SECONDARY_EXEC_ENCLS_EXITING;
>> +
>>  		if (adjust_vmx_controls(min2, opt2,
>>  					MSR_IA32_VMX_PROCBASED_CTLS2,
>>  					&_cpu_based_2nd_exec_control) < 0)
>> @@ -2577,6 +2577,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>  		vmx_cap->vpid = 0;
>>  	}
>>  
>> +	if (!cpu_has_sgx())
>> +		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_ENCLS_EXITING;
>> +
>>  	if (_cpu_based_exec_control & CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
>>  		u64 opt3 = TERTIARY_EXEC_IPI_VIRT;
>>  
>> -- 
>> 2.35.3
>> 
>

-- 
Vitaly

