Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9B59963A
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Aug 2022 09:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347149AbiHSHm3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Aug 2022 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347146AbiHSHm2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Aug 2022 03:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9973FCCE2A
        for <linux-hyperv@vger.kernel.org>; Fri, 19 Aug 2022 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660894946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7BU0NBgcPwvMpt86ttJZWI4g3XAVpmUhw+WmsruDrgM=;
        b=M4+AsEIXJ3g8YdG28lrIZdwjPoBUzD+WWxRvModwUOc+8ut1Wx64iCNAww9SSb15hQzrbo
        eWNfw/D0oo4uxzd70FzEEVOldjsFH58DRIQ/vnuhkUqIOffDmkY1ALJONLIBNfqR/BEBl3
        HhxapyeUAV0jL5efOq3IgIJ7iOFeB1E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-tYeTjtokPe6sGB5oULUPFQ-1; Fri, 19 Aug 2022 03:42:23 -0400
X-MC-Unique: tYeTjtokPe6sGB5oULUPFQ-1
Received: by mail-ed1-f72.google.com with SMTP id w17-20020a056402269100b0043da2189b71so2355633edd.6
        for <linux-hyperv@vger.kernel.org>; Fri, 19 Aug 2022 00:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=7BU0NBgcPwvMpt86ttJZWI4g3XAVpmUhw+WmsruDrgM=;
        b=Uq9sSZsmqNR7OZWZJ3VFKynzQoMRL92D2lNQKGJQktqv0H/81uoIzUuLwls4nS2KAC
         cCWFjVSuCe8civ7TeXgEZHW9ju+LO24ullZGXPANC6GTwMsIqjVQNqcGZtROvlHWgSRE
         F1laD/gBisC9NeITW2HYuuv1/30Vv7bI2uVSQLj0ejoosJcUrVDL69r1ZfjwlrJXdPg7
         b9AXeT4C30IqV4d28e/2p2uLzO59mfbVJznFoB2m5JK2zf0wRzGe5/g8B9HOMr50an37
         l8Q2e+PVLom+eNWZ8R7ocEK4JGW2m6Whye1IAezcPkqQ2O4Q3V/J3a3EOoeadiAUOCwj
         1ooA==
X-Gm-Message-State: ACgBeo0gCH6eXnhUEAgyofn3ro4kqR8VhbSrvKDFEx7SJ+9M+j6zua5J
        aGYW61UVvtLJWY1FQqZfbgcAh6BZfGA7RFqtHGSQEaA3DYPYS6JY8J9MwnD4+UXlJxvQnwPNv1C
        2vPclxdOfLAvjqBGA0tDrNWC5
X-Received: by 2002:a05:6402:510a:b0:43d:ab25:7d68 with SMTP id m10-20020a056402510a00b0043dab257d68mr5038493edd.102.1660894942485;
        Fri, 19 Aug 2022 00:42:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR67XQIhNJjNTGL7G9Zsj1eHRrSxDAKaWyqDLtY6JVbFAVDwTNGYQgZ5YsaDFAM5m6i3SREV8A==
X-Received: by 2002:a05:6402:510a:b0:43d:ab25:7d68 with SMTP id m10-20020a056402510a00b0043dab257d68mr5038482edd.102.1660894942290;
        Fri, 19 Aug 2022 00:42:22 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w8-20020a50fa88000000b0043a7134b381sm2564438edr.11.2022.08.19.00.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 00:42:21 -0700 (PDT)
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
In-Reply-To: <Yv50vWGoLQ9n+6MO@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-10-vkuznets@redhat.com>
 <Yv50vWGoLQ9n+6MO@google.com>
Date:   Fri, 19 Aug 2022 09:42:20 +0200
Message-ID: <87zgg0smqr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Aug 02, 2022, Vitaly Kuznetsov wrote:
>> diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
>> index f886a8ff0342..4b809c79ae63 100644
>> --- a/arch/x86/kvm/vmx/evmcs.h
>> +++ b/arch/x86/kvm/vmx/evmcs.h
>> @@ -37,16 +37,9 @@ DECLARE_STATIC_KEY_FALSE(enable_evmcs);
>>   *	EPTP_LIST_ADDRESS               = 0x00002024,
>>   *	VMREAD_BITMAP                   = 0x00002026,
>>   *	VMWRITE_BITMAP                  = 0x00002028,
>> - *
>> - *	TSC_MULTIPLIER                  = 0x00002032,
>>   *	PLE_GAP                         = 0x00004020,
>>   *	PLE_WINDOW                      = 0x00004022,
>>   *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
>> - *      GUEST_IA32_PERF_GLOBAL_CTRL     = 0x00002808,
>> - *      HOST_IA32_PERF_GLOBAL_CTRL      = 0x00002c04,
>> - *
>> - * Currently unsupported in KVM:
>> - *	GUEST_IA32_RTIT_CTL		= 0x00002814,
>
> Almost forgot: is deleting this chunk of the comment intentional?
>

Intentional or not (I forgot :-), GUEST_IA32_RTIT_CTL is supported/used
by KVM since

commit f99e3daf94ff35dd4a878d32ff66e1fd35223ad6
Author: Chao Peng <chao.p.peng@linux.intel.com>
Date:   Wed Oct 24 16:05:10 2018 +0800

    KVM: x86: Add Intel PT virtualization work mode

...
 
commit bf8c55d8dc094c85a3f98cd302a4dddb720dd63f
Author: Chao Peng <chao.p.peng@linux.intel.com>
Date:   Wed Oct 24 16:05:14 2018 +0800

    KVM: x86: Implement Intel PT MSRs read/write emulation

but there's no corresponding field in eVMCS. It would probably be better
to remove "Currently unsupported in KVM:" line leaving

"GUEST_IA32_RTIT_CTL             = 0x00002814" 

in place. 

-- 
Vitaly

