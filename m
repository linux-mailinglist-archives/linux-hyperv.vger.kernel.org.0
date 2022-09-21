Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634CD5BF8D9
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Sep 2022 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiIUISq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Sep 2022 04:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiIUISR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Sep 2022 04:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AB2870AB
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663748278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UB796Vt6XXX5oZ6lyqB/fr2UDx3FHm5YRogO/KgZ0Gc=;
        b=d3t820yXoiqrP34u15TXuopgVgQ0MUYW8PrNqs9QN1ArynxJaBUwiKYy82cpSsVVYbTrpo
        jU7U4JJKqApblC7w93/AkrlDH9ihuhnuImRWQV/l61EsECPwXK8Lpo1wfP+fB+gNpQMLDH
        alFFde6Z2mYWsvQiIYh6Gn/JB+F4+Sc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-119-zjGFm3R8MCGWoA5H28iiuA-1; Wed, 21 Sep 2022 04:17:56 -0400
X-MC-Unique: zjGFm3R8MCGWoA5H28iiuA-1
Received: by mail-wr1-f70.google.com with SMTP id g19-20020adfa493000000b0022a2ee64216so2127073wrb.14
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 01:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=UB796Vt6XXX5oZ6lyqB/fr2UDx3FHm5YRogO/KgZ0Gc=;
        b=az0hFNO2Q9j+u1wIxgX7BDoUD2Z9xrz5H++WmLKomEe8Yd4BmBaRwZKgE8mSF+w2mS
         AFrehxjZ6orlYq1YFDXeE7aT5qQrix1jhVAAakKiLQRjVW4T7CVjoAlF4KgX7xRmfJVj
         k51C6QSIm4ZNmqrBILEA217mwHCPTscxK7bcBlGA1mpPqteeIuZnBWSQ9mQaRSxKpl3k
         fM61RT5DPv80QaBVvQHK4/f2P6r57qMr8HS8TvGCGS0C1JWvo66aVs04Cm4y0C7yhKZY
         2vogCLA3xbup1WqYzHu2bY2HwPBo9qIE0HyIznMIcESw9cu02N/9H8uTBw/n9ER863pw
         6BZw==
X-Gm-Message-State: ACrzQf1TOTLYrr8ZmdDy/5Q/MYeanW9tVQXT5e51zLN4dtPlMfSZZzAv
        Lfu1gXV6PsiEwW+AL+m8sYA0ttQoK/y/nt4TOeL4dQEPPOtZttk43Jd2SMGFvavK1CIhu4KXHaC
        CelT14quwV2V1HyxgHfK7yqle
X-Received: by 2002:a5d:4444:0:b0:22a:2a64:a0fd with SMTP id x4-20020a5d4444000000b0022a2a64a0fdmr16661961wrr.293.1663748275628;
        Wed, 21 Sep 2022 01:17:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM43v7wWRoXSXV6v4Az3dSj1S/kPw0MIiHrhTuij8Z+2yQa1grcSowSXQ8ZmRtHUuPrI50y4HQ==
X-Received: by 2002:a5d:4444:0:b0:22a:2a64:a0fd with SMTP id x4-20020a5d4444000000b0022a2a64a0fdmr16661948wrr.293.1663748275362;
        Wed, 21 Sep 2022 01:17:55 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i15-20020adfaacf000000b00228df23bd51sm1767242wrc.82.2022.09.21.01.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:17:54 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] KVM: x86: Introduce CPUID_8000_0007_EDX
 'scattered' leaf
In-Reply-To: <YypEReJYrI0c7Oii@google.com>
References: <20220916135205.3185973-1-vkuznets@redhat.com>
 <20220916135205.3185973-3-vkuznets@redhat.com>
 <YypEReJYrI0c7Oii@google.com>
Date:   Wed, 21 Sep 2022 10:17:53 +0200
Message-ID: <8735clp2dq.fsf@redhat.com>
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
>> CPUID_8000_0007_EDX may come handy when X86_FEATURE_CONSTANT_TSC
>> needs to be checked.
>> 
>> No functional change intended.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/cpuid.c         | 4 ++++
>>  arch/x86/kvm/reverse_cpuid.h | 9 ++++++++-
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 75dcf7a72605..f68b14053c9b 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -669,6 +669,10 @@ void kvm_set_cpu_caps(void)
>>  	if (!tdp_enabled && IS_ENABLED(CONFIG_X86_64))
>>  		kvm_cpu_cap_set(X86_FEATURE_GBPAGES);
>>  
>> +	kvm_cpu_cap_init_scattered(CPUID_8000_0007_EDX,
>> +		SF(CONSTANT_TSC)
>> +	);
>
> The scattered leaf needs to be used in __do_cpuid_func(), e.g.
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index ffdc28684cb7..c91f23bb3605 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1137,8 +1137,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>                 /* L2 cache and TLB: pass through host info. */
>                 break;
>         case 0x80000007: /* Advanced power management */
> -               /* invariant TSC is CPUID.80000007H:EDX[8] */
> -               entry->edx &= (1 << 8);
> +               cpuid_entry_override(entry, CPUID_8000_0007_EDX);
> +

Ah, missed that part! Will add.

>                 /* mask against host */
>                 entry->edx &= boot_cpu_data.x86_power;
>                 entry->eax = entry->ebx = entry->ecx = 0;
>

-- 
Vitaly

