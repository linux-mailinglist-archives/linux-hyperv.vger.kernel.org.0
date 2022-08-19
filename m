Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF73599DF0
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Aug 2022 17:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349507AbiHSPHZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Aug 2022 11:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349587AbiHSPHZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Aug 2022 11:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B12EF5CCB
        for <linux-hyperv@vger.kernel.org>; Fri, 19 Aug 2022 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660921643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bCazOt/ABEyx6tcL3bVyPlDjCJvGwGf6FzkajqTSuZY=;
        b=cPXhhCffdA/jYHe1TdqUsTE7HBMMZznQp1GK7zPbGZbbF/eVsMFfBCU40jOk0gMpKeFm8v
        ZYsgXqN4ulHdcRSUliu7qWj76wpl7tZaE1xt7Bk2N9DRWun49epQXTPwpQdB/VtM38/VHj
        l9KHfiFLSQ6zjnjTcatct3qoRlpzELM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-34-RUSSPcfKNPmgZ5A9bKnzuA-1; Fri, 19 Aug 2022 11:07:20 -0400
X-MC-Unique: RUSSPcfKNPmgZ5A9bKnzuA-1
Received: by mail-ed1-f71.google.com with SMTP id t13-20020a056402524d00b0043db1fbefdeso2943039edd.2
        for <linux-hyperv@vger.kernel.org>; Fri, 19 Aug 2022 08:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=bCazOt/ABEyx6tcL3bVyPlDjCJvGwGf6FzkajqTSuZY=;
        b=zYqweFISl20QbalAxybyJAJ/B9ymkw4zD1fOm2lYfDbJgFAUr2ciKWleLbq6iS9oGp
         oN/PEkRKvKNIOsTfjPF0SA7ZjKTkeRzAg49BcAuvrB+UmXsutoU3tsDxq9aCFQ1Rx7Cs
         OjHSEqp51BYAPyjdRUSgj0gtKKto0zt/X7OK7vxcM5xB1dTE2sWhlg12Bt5Kmk2+c3vQ
         gmeOE8vp9ajQAAYkaZud6invfOp6EwOvAQU3LKa4N5Tdv6ke5nzaidL73DsMp+LDcvVP
         Qhvz+PS6YrgvxkYcs3gNviVqm+VWzFGXqnJ2mPMch6FTP5zFha32SGYJkR1K9UHsLNGN
         1xVg==
X-Gm-Message-State: ACgBeo0z3LdOqY1KJGxBUgygT74sCZ8eMZLUIXHLgTcW3UOsD8Vi3vy1
        eiqHsw0wOwDbDws5DgbvzFG7Q6KeoxCyauZ3sFPCfPihGTqC/y5mmhtNFUOUKcc08Vdej24vDzJ
        D+9fimvBSmEFiUHajyBzlmaTg
X-Received: by 2002:a05:6402:331a:b0:445:f60e:48cd with SMTP id e26-20020a056402331a00b00445f60e48cdmr6509949eda.201.1660921639475;
        Fri, 19 Aug 2022 08:07:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR49vW3ArrSqHKuYMyNSKS4mQPJwS8C0/wsaM1PyYhEGcpfhFu8aYkDylokQz0Q4rE4QZyt3gw==
X-Received: by 2002:a05:6402:331a:b0:445:f60e:48cd with SMTP id e26-20020a056402331a00b00445f60e48cdmr6509928eda.201.1660921639286;
        Fri, 19 Aug 2022 08:07:19 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7dc02000000b0043a7c24a669sm3166096edu.91.2022.08.19.08.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 08:07:18 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/26] KVM: VMX: nVMX: Support TSC scaling and
 PERF_GLOBAL_CTRL with enlightened VMCS
In-Reply-To: <Yv+i/wuObvLf7QZE@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-10-vkuznets@redhat.com>
 <Yv50vWGoLQ9n+6MO@google.com> <87zgg0smqr.fsf@redhat.com>
 <Yv+i/wuObvLf7QZE@google.com>
Date:   Fri, 19 Aug 2022 17:07:17 +0200
Message-ID: <87lerks256.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Aug 19, 2022, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Tue, Aug 02, 2022, Vitaly Kuznetsov wrote:
>> >> diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
>> >> index f886a8ff0342..4b809c79ae63 100644
>> >> --- a/arch/x86/kvm/vmx/evmcs.h
>> >> +++ b/arch/x86/kvm/vmx/evmcs.h
>> >> @@ -37,16 +37,9 @@ DECLARE_STATIC_KEY_FALSE(enable_evmcs);
>> >>   *	EPTP_LIST_ADDRESS               = 0x00002024,
>> >>   *	VMREAD_BITMAP                   = 0x00002026,
>> >>   *	VMWRITE_BITMAP                  = 0x00002028,
>> >> - *
>> >> - *	TSC_MULTIPLIER                  = 0x00002032,
>> >>   *	PLE_GAP                         = 0x00004020,
>> >>   *	PLE_WINDOW                      = 0x00004022,
>> >>   *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
>> >> - *      GUEST_IA32_PERF_GLOBAL_CTRL     = 0x00002808,
>> >> - *      HOST_IA32_PERF_GLOBAL_CTRL      = 0x00002c04,
>> >> - *
>> >> - * Currently unsupported in KVM:
>> >> - *	GUEST_IA32_RTIT_CTL		= 0x00002814,
>> >
>> > Almost forgot: is deleting this chunk of the comment intentional?
>> >
>> 
>> Intentional or not (I forgot :-), GUEST_IA32_RTIT_CTL is supported/used
>> by KVM since
>> 
>> commit f99e3daf94ff35dd4a878d32ff66e1fd35223ad6
>> Author: Chao Peng <chao.p.peng@linux.intel.com>
>> Date:   Wed Oct 24 16:05:10 2018 +0800
>> 
>>     KVM: x86: Add Intel PT virtualization work mode
>> 
>> ...
>>  
>> commit bf8c55d8dc094c85a3f98cd302a4dddb720dd63f
>> Author: Chao Peng <chao.p.peng@linux.intel.com>
>> Date:   Wed Oct 24 16:05:14 2018 +0800
>> 
>>     KVM: x86: Implement Intel PT MSRs read/write emulation
>> 
>> but there's no corresponding field in eVMCS. It would probably be better
>> to remove "Currently unsupported in KVM:" line leaving
>> 
>> "GUEST_IA32_RTIT_CTL             = 0x00002814" 
>> 
>> in place. 
>
> GUEST_IA32_RTIT_CTL isn't supported for nested VMX though, which is how I
> interpreted the "Currently unsupported in KVM:".  Would it be accurate to extend
> that part of the comment to "Currently unsupported in KVM for nested VMX:"?

Yea, sounds good to me. 

FWIW, there are other controls which are currently missing in KVM,
e.g. 'guest_ia32_lbr_ctl' (VMX field 0x2816) and we have no 'macro
shenanigans' to catch the moment when support for these gets introduced
in KVM. When this happens, we need to extend VMCS-to-eVMCS mapping
(vmcs_field_to_evmcs_1) to support KVM-on-Hyper-V case and, when the
corresponding field gets added to 'struct vmcs12',
copy_enlightened_to_vmcs12()/copy_vmcs12_to_enlightened(). The whole
process is manual and thus error prone...

-- 
Vitaly

