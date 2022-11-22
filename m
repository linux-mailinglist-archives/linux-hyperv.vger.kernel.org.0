Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29982634081
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Nov 2022 16:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiKVPo7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Nov 2022 10:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiKVPo6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Nov 2022 10:44:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B736F1275D
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Nov 2022 07:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669131840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xWL302xeQNaUeD1XBBbHjOQmICjs58t7c74x1CuLrlw=;
        b=UVvTU98oth9ZRvLUMmePRuiGGsHZXOQrnehKYJX6K4NentrwNJTUDvIjkqcYwRVOrDhyaD
        M5hT9BxYhUHchBwBOgk3XBY6AaH0Cx1LPUHloT05TfIAKYx9twOvaomIEWpi8oAG8gCotF
        GcZEA00dWF+uHhxbRGeRYv6rCtPUjtk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-nTI9f7rcMmOnIccGcabhLg-1; Tue, 22 Nov 2022 10:43:59 -0500
X-MC-Unique: nTI9f7rcMmOnIccGcabhLg-1
Received: by mail-ej1-f72.google.com with SMTP id ga41-20020a1709070c2900b007aef14e8fd7so8557645ejc.21
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Nov 2022 07:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWL302xeQNaUeD1XBBbHjOQmICjs58t7c74x1CuLrlw=;
        b=CpqDdvQRHI5YeA/8QowSi95XzAoP1kGLz4tL0KZuvVtKK39I8IG2wG3CDdSsyrHkxA
         in3iWrjt+fs/dJCZb6aX0shFPm7vXu5MFgPlf5rvpz3LWDAsweWvCz2XVpEj1wv0tZoX
         yTQ6nhduO+ThTfNs/MI8hVqbymRhUL/nvIN1IYWxh4Exnoik+63XTyjRWK3607z0rjp5
         bOS8/IzlcqB/+RZpyu56KkMpTdGLlOwctxTNIXmb9GbHG7RY1jRGSGi7FZavthG9zNWk
         At8n9dS2Rp8LU9FAWjrB2w6cQRnEnLSpVTroJtJ8VCuiu0+X+Pyl4G9FL9CegaLYNbZf
         vxBQ==
X-Gm-Message-State: ANoB5pltzZMzBKB65IBJAY23qXVYB0iJ8gGNdcJyoU7x0wNh00dS3zjF
        dPMkQSDyeZ6xOYaL4uamRJ7d34jOwevfMPv6+n/pMh+wpn/025K32f359DG5MYu2Jiv5EbmYiB+
        1HEN/Eq6rN9AToNGnpIMnORSf
X-Received: by 2002:a05:6402:2024:b0:468:f633:9484 with SMTP id ay4-20020a056402202400b00468f6339484mr20729280edb.200.1669131838108;
        Tue, 22 Nov 2022 07:43:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6HyiTcH1qadnX+DoTbSf5WrVcbc+T6q+Jo/GX4nTI50Ag4+RR58bqywik7IbUTzuQOnoDUzg==
X-Received: by 2002:a05:6402:2024:b0:468:f633:9484 with SMTP id ay4-20020a056402202400b00468f6339484mr20729262edb.200.1669131837911;
        Tue, 22 Nov 2022 07:43:57 -0800 (PST)
Received: from ovpn-194-185.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id fy21-20020a170906b7d500b0077d6f628e14sm6125586ejb.83.2022.11.22.07.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 07:43:57 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] KVM: x86: Hyper-V invariant TSC control feature
In-Reply-To: <Y0nA0DCeh4IPmWMX@google.com>
References: <20221013095849.705943-1-vkuznets@redhat.com>
 <Y0nA0DCeh4IPmWMX@google.com>
Date:   Tue, 22 Nov 2022 16:43:56 +0100
Message-ID: <87o7szouyr.fsf@ovpn-194-185.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Oct 13, 2022, Vitaly Kuznetsov wrote:
>> Normally, genuine Hyper-V doesn't expose architectural invariant TSC
>> (CPUID.80000007H:EDX[8]) to its guests by default. A special PV MSR
>> (HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x40000118) and corresponding CPUID
>> feature bit (CPUID.0x40000003.EAX[15]) were introduced. When bit 0 of the
>> PV MSR is set, invariant TSC bit starts to show up in CPUID. When the 
>> feature is exposed to Hyper-V guests, reenlightenment becomes unneeded.
>> 
>> Note: strictly speaking, KVM doesn't have to have the feature as exposing
>> raw invariant TSC bit (CPUID.80000007H:EDX[8]) also seems to work for
>> modern Windows versions. The feature is, however, tiny and straitforward
>> and gives additional flexibility so why not.
>> 
>> Vitaly Kuznetsov (7):
>>   x86/hyperv: Add HV_EXPOSE_INVARIANT_TSC define
>>   KVM: x86: Add a KVM-only leaf for CPUID_8000_0007_EDX
>>   KVM: x86: Hyper-V invariant TSC control
>>   KVM: selftests: Rename 'msr->available' to 'msr->fault_exepected' in
>>     hyperv_features test
>>   KVM: selftests: Convert hyperv_features test to using
>>     KVM_X86_CPU_FEATURE()
>>   KVM: selftests: Test that values written to Hyper-V MSRs are preserved
>>   KVM: selftests: Test Hyper-V invariant TSC control
>
> For the series, in case Paolo ends up grabbing this:
>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
>

I completely forgot about this one! Any chance it can still be queueed
for 6.2? Thanks!

-- 
Vitaly

