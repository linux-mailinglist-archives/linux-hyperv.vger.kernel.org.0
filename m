Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF2561349
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Jun 2022 09:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiF3Hct (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 Jun 2022 03:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiF3Hcr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 Jun 2022 03:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C80C5396B5
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jun 2022 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656574366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kqEEUMLIpCgFyqW1I7pVlBIg/VcqZRs+Rv7NEYalj0g=;
        b=KHN7USks71fDX5lnvOozSUT06zwwbte75bsTsRAtD18qEy3qcrjcoQQUa8ZritBOTANHKm
        0cbnt8MPHf5hs3j3KjMuWU91c2LFtbi7f9gHHdjtySVUl7AiDKnZXWi1dPGWgJWfEA4cci
        LkeGTsPbv+oH3f+DpTd/fO8KSfleGtI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-kc0GLwklPOS84okMsVYcDg-1; Thu, 30 Jun 2022 03:32:42 -0400
X-MC-Unique: kc0GLwklPOS84okMsVYcDg-1
Received: by mail-wm1-f72.google.com with SMTP id r132-20020a1c448a000000b003a02a3f0beeso1021023wma.3
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jun 2022 00:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kqEEUMLIpCgFyqW1I7pVlBIg/VcqZRs+Rv7NEYalj0g=;
        b=W7dsBYUzdpbFkTBhJj3xJjaoq3duHXJmaahUGIiQWoeXXca9egz7cwE2up9lvE7FIO
         egI/UvKvSbT98qBuXEt+xNn4lhdrP9nQa7PygYZPHazfvLgiTc5tCCBwdez2ckzd/0b0
         Emwlp/XCQUkInz5nksxkHKitQvLFDVRvp90430Xmxw3m4iYnmzQOFsCpvHv1S5BPz1rA
         iTS9hmft4dhQKpWGNjzleMdfgZWPX8oESY+YRfkryryfbZ0TJ7RAo87GvXcjjmUU7lIc
         UkSBjiyqvrlMXXFRja4A/HFWCneb1OSgMaby9pDA0Y/t1buEiU0hUWsHzkpkcff0RgEl
         yYkg==
X-Gm-Message-State: AJIora94QtIB0cYVlcZxjUNxAJwBhS3lOGqb+UKtEUxYHnshgM8alGv5
        usS/NHYk37exBauC378dWs9L6SNXA8JdPs9TFQ4UVysck8AJ5Yh0alt/xEJQ2x0zQEXepVMR1bx
        MmKWiHTA2Iuipufg/1s2tc4Ss
X-Received: by 2002:a5d:43c7:0:b0:21d:1e01:e9ac with SMTP id v7-20020a5d43c7000000b0021d1e01e9acmr6691766wrr.187.1656574361274;
        Thu, 30 Jun 2022 00:32:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uugW08aJHQzNn79zj+aesKxAUlGlhNhpOSU/8IbtFyE4VGJLptXuhE0UbQzVn4tFe8gz809w==
X-Received: by 2002:a5d:43c7:0:b0:21d:1e01:e9ac with SMTP id v7-20020a5d43c7000000b0021d1e01e9acmr6691743wrr.187.1656574361002;
        Thu, 30 Jun 2022 00:32:41 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b0039c454067ddsm5775414wmr.15.2022.06.30.00.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 00:32:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/28] KVM: VMX: Tweak the special handling of
 SECONDARY_EXEC_ENCLS_EXITING in setup_vmcs_config()
In-Reply-To: <CALMp9eS_iAijAk4pdK1tjLbRp3XH-PhR1mX4gaSXztWPXJpfkA@mail.gmail.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-17-vkuznets@redhat.com>
 <CALMp9eS_iAijAk4pdK1tjLbRp3XH-PhR1mX4gaSXztWPXJpfkA@mail.gmail.com>
Date:   Thu, 30 Jun 2022 09:32:39 +0200
Message-ID: <87wncysj1k.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> SECONDARY_EXEC_ENCLS_EXITING is conditionally added to the 'optional'
>> checklist in setup_vmcs_config() but there's little value in doing so.
>> First, as the control is optional, we can always check for its
>> presence, no harm done. Second, the only real value cpu_has_sgx() check
>> gives is that on the CPUs which support SECONDARY_EXEC_ENCLS_EXITING but
>> don't support SGX, the control is not getting enabled. It's highly unlikely
>> such CPUs exist but it's possible that some hypervisors expose broken vCPU
>> models.
>>
>> Preserve cpu_has_sgx() check but filter the result of adjust_vmx_controls()
>> instead of the input.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/vmx.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 89a3bbafa5af..e32d91006b80 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -2528,9 +2528,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>                         SECONDARY_EXEC_PT_CONCEAL_VMX |
>>                         SECONDARY_EXEC_ENABLE_VMFUNC |
>>                         SECONDARY_EXEC_BUS_LOCK_DETECTION |
>> -                       SECONDARY_EXEC_NOTIFY_VM_EXITING;
>> -               if (cpu_has_sgx())
>> -                       opt2 |= SECONDARY_EXEC_ENCLS_EXITING;
>> +                       SECONDARY_EXEC_NOTIFY_VM_EXITING |
>> +                       SECONDARY_EXEC_ENCLS_EXITING;
>> +
>>                 if (adjust_vmx_controls(min2, opt2,
>>                                         MSR_IA32_VMX_PROCBASED_CTLS2,
>>                                         &_cpu_based_2nd_exec_control) < 0)
>> @@ -2577,6 +2577,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>                 vmx_cap->vpid = 0;
>>         }
>>
>> +       if (!cpu_has_sgx())
>> +               _cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_ENCLS_EXITING;
>
> NYC, but why is there a leading underscore here?

No idea to be honest, this goes way back to 2007 when
setup_vmcs_config() was introduced:

commit 1c3d14fe0ab75337a3f6c06b6bc18bcbc2b3d0bc
Author: Yang, Sheng <sheng.yang@intel.com>
Date:   Sun Jul 29 11:07:42 2007 +0300

    KVM: VMX: Improve the method of writing vmcs control

>
>>         if (_cpu_based_exec_control & CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
>>                 u64 opt3 = TERTIARY_EXEC_IPI_VIRT;
>>
>> --
>> 2.35.3
>>
> Reviewed-by: Jim Mattson <jmattson@google.com>
>

Thanks!

-- 
Vitaly

