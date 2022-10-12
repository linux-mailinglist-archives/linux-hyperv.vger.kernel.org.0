Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D5A5FC580
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Oct 2022 14:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJLMlA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Oct 2022 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJLMk7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Oct 2022 08:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57B3C8227
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Oct 2022 05:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665578458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V4PET4IVn842CPc9kqbnyaF1hjwBFJjyklLZTxjKQUA=;
        b=TQs7rpk6rMN9wlqQSe2Pr/FJOHmdP/3HUoM9g5t8deTOapT+wADV0qB2AKFtKgfiII5ORF
        ZFywFToTEN1WBZB2aSMwpezGHbGhfEyF+e45bjsK6Tk4Cs4bzIfd9FgFtUoOYVOS2Ir9PJ
        nFpQ92z1uHt4gPHjKWuzITi6v8eldEA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-2rVd6l5YMzWGqrRQ2bjlbQ-1; Wed, 12 Oct 2022 08:40:57 -0400
X-MC-Unique: 2rVd6l5YMzWGqrRQ2bjlbQ-1
Received: by mail-wm1-f71.google.com with SMTP id 133-20020a1c028b000000b003c5e6b44ebaso1066629wmc.9
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Oct 2022 05:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4PET4IVn842CPc9kqbnyaF1hjwBFJjyklLZTxjKQUA=;
        b=ODDlZ0K5X7/kMpj90x7cGr0KGq8H48YFubf8ueXigc2isokRchjRXtYcesSC71WqSY
         uwVItxu4Kjy9Ay7WH1DdcK6oX5drt4ATe+2gZGjQhA+rhCOcs4w2aklS/KiDpUbjkGOD
         xK38jlbaZS0y0YvuiDQCr0YqBRT6hfL+yocgKJP/lRgJgsQQ3ILPvtWAWd/jdGOA1yia
         Yxkwax9fss5Z2LfkcyEQCOiIKStEAHiO1Gl3LtNxwIbCxAyxBRII44DMXKz+yNx+cD0G
         29XSKPpAPcAVvHC7MDEry/pucaSdgFkL2sAQBauMFWB8BsByAAve1Mvj3bUyvdtdPcsP
         7e9w==
X-Gm-Message-State: ACrzQf11Xm+nZZFmMq7RcmxDeE3bfvr7n3zOVqqMGt7UeE9JiiZzak/C
        Iuj/Z/DeTgZ9C4IcTHmzya4v12PAHR2Iab1FE/z7nzOTnB3lB0wv663DAxxeoqwlir3XvpURcNc
        wcv9gQnlRIizwimmXUOrZ0Yq+
X-Received: by 2002:adf:f301:0:b0:22e:4479:c1ba with SMTP id i1-20020adff301000000b0022e4479c1bamr18010291wro.133.1665578454614;
        Wed, 12 Oct 2022 05:40:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7qIVCyeWKildFEGP/RIqDFvG6GG0zeSXyIH6WUGqkiQOJh0eBqGfO3EEFyhJ9XcwTTzGqZVQ==
X-Received: by 2002:adf:f301:0:b0:22e:4479:c1ba with SMTP id i1-20020adff301000000b0022e4479c1bamr18010278wro.133.1665578454345;
        Wed, 12 Oct 2022 05:40:54 -0700 (PDT)
Received: from ovpn-194-196.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c001100b003c6bbe910fdsm2079979wmc.9.2022.10.12.05.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:40:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] KVM: selftests: Test Hyper-V invariant TSC control
In-Reply-To: <Y0XGuk4vwJBTU9oN@google.com>
References: <20220922143655.3721218-1-vkuznets@redhat.com>
 <20220922143655.3721218-7-vkuznets@redhat.com>
 <Y0XGuk4vwJBTU9oN@google.com>
Date:   Wed, 12 Oct 2022 14:40:52 +0200
Message-ID: <87v8op6wq3.fsf@ovpn-194-196.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Sep 22, 2022, Vitaly Kuznetsov wrote:
>> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> index d4bd18bc580d..18b44450dfb8 100644
>> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> @@ -46,20 +46,33 @@ struct hcall_data {
>>  
>>  static void guest_msr(struct msr_data *msr)
>>  {
>> -	uint64_t ignored;
>> +	uint64_t msr_val = 0;
>>  	uint8_t vector;
>>  
>>  	GUEST_ASSERT(msr->idx);
>>  
>> -	if (!msr->write)
>> -		vector = rdmsr_safe(msr->idx, &ignored);
>> -	else
>> +	if (!msr->write) {
>> +		vector = rdmsr_safe(msr->idx, &msr_val);
>
> This is subtly going to do weird things if the RDMSR faults.  rdmsr_safe()
> overwrites @val with whatever happens to be in EDX:EAX if the RDMSR faults, i.e.
> this may yield garbage instead of '0'.  Arguably rdmsr_safe() is a bad API, but
> at the same time the caller really shouldn't consume the result if RDMSR faults
> (though aligning with the kernel is also valuable).
>
> Aha!  Idea.  Assuming none of the MSRs are write-only, what about adding a prep
> patch to rework this code so that it verifies RDMSR returns what was written when
> a fault didn't occur.
>

There is at least one read-only MSR which comes to mind:
HV_X64_MSR_EOI. Also, some of the MSRs don't preserve the written value,
e.g. HV_X64_MSR_RESET which always reads as '0'.

I do, however, like the additional check that RDMSR returns what was
written to the MSR, we will just need an additional flag in 'struct
msr_data' ('check_written_value' maybe?).

-- 
Vitaly

