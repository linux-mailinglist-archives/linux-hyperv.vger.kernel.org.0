Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BAF5B6B33
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Sep 2022 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiIMJxC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Sep 2022 05:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIMJxC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Sep 2022 05:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5425AC6A
        for <linux-hyperv@vger.kernel.org>; Tue, 13 Sep 2022 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663062778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+b3p8jJeOUzB9Y7KKCEYhhWbXEO9sDNunqO8TSV3bM=;
        b=g+1McP0JrkCwAU1s+QDDAbPdAj9mkPi0zKU0LgTRG9CXskC3DH2dybQYlfjIPS9ScyfKxP
        FIWWDUl8UtJlT2s1R04kmi4TALCr2XoGp0ORp+zQRljvSqskiZRPYf8k6HlMOzHP2gM12K
        5GuonWKl3lxznJjdRiDd8kO236GafZg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-427-qsmRMP8rNkKjnPDvGwrZzQ-1; Tue, 13 Sep 2022 05:52:57 -0400
X-MC-Unique: qsmRMP8rNkKjnPDvGwrZzQ-1
Received: by mail-wr1-f71.google.com with SMTP id r18-20020adfa152000000b0022abc6c0673so1059512wrr.6
        for <linux-hyperv@vger.kernel.org>; Tue, 13 Sep 2022 02:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=H+b3p8jJeOUzB9Y7KKCEYhhWbXEO9sDNunqO8TSV3bM=;
        b=qsXZCDqhU8RJfeHS3zRHrYE8aazB3J0jUYseM2H7rJg07HqS1+xf1n46UIgAUN7sHg
         thHRyMqahG1g5NrjWIgZY4eKQIJ4tX80t+RjvbShRLlHTfPLfGNTQ2nigf8Ox0z/HXyQ
         w0GoCSs1PgCNGNWrZPtUNK47JJSZEMe3X1Xh61ZTDarvzHZLxKktUMnXrjqEwtu73Lxh
         Lp7zSPNIZn9ytxw3pRVtUFWOMhdhYv8wDKjkB+pnxIaRzAOXGJnpbpAGSUDYVlJRhiL1
         qYHTuMmfsadZKLtKAkOKYAUR0vZRf00Zqsd6OcUmE5XK5x8V/S9tjVuN6t0ogBH/GOTN
         ohLA==
X-Gm-Message-State: ACgBeo1VwqNXMXhZ5HDQD2J8YJcQjIq8vytG2vDlnSdapF/aErd4ILj/
        PMfVmlKpUmfIWHLL22GSd3+Q17dwEFpYckrg/k4W7VzUNWAz63F5w0raserVOqKCZAS38BDyySo
        bNCCVRoJ/zdvcJJf4f+qPVxv6
X-Received: by 2002:a7b:cbd2:0:b0:3b4:33d1:d938 with SMTP id n18-20020a7bcbd2000000b003b433d1d938mr1688000wmi.123.1663062775985;
        Tue, 13 Sep 2022 02:52:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zvkBVGOCRYEBRc8uffdd7P4Et7K4jKKL5qQNyq1mHNhsM3qay0zjBhaFU0U/N0i61OSqVEA==
X-Received: by 2002:a7b:cbd2:0:b0:3b4:33d1:d938 with SMTP id n18-20020a7bcbd2000000b003b433d1d938mr1687990wmi.123.1663062775806;
        Tue, 13 Sep 2022 02:52:55 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b002285f73f11dsm12303111wrq.81.2022.09.13.02.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 02:52:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: selftests: Rename 'msr->availble' to
 'msr->should_not_gp' in hyperv_features test
In-Reply-To: <Yx87WXMXGzLxrT0f@google.com>
References: <20220831085009.1627523-1-vkuznets@redhat.com>
 <20220831085009.1627523-3-vkuznets@redhat.com>
 <Yx87WXMXGzLxrT0f@google.com>
Date:   Tue, 13 Sep 2022 11:52:54 +0200
Message-ID: <874jxbr47d.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Aug 31, 2022, Vitaly Kuznetsov wrote:
>> It may not be clear what 'msr->availble' means. The test actually
>> checks that accessing the particular MSR doesn't cause #GP, rename
>> the varialble accordingly.
>> 
>> Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  .../selftests/kvm/x86_64/hyperv_features.c    | 92 +++++++++----------
>>  1 file changed, 46 insertions(+), 46 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> index 79ab0152d281..4ec4776662a4 100644
>> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
>> @@ -33,7 +33,7 @@ static inline uint8_t hypercall(u64 control, vm_vaddr_t input_address,
>>  
>>  struct msr_data {
>>  	uint32_t idx;
>> -	bool available;
>> +	bool should_not_gp;
>
> I agree that "available" is a bit inscrutable, but "should_not_gp" is also odd.
>

I think Max suggested it to reduce the code churn and I silently agreed.

> What about inverting it to?
>
> 	bool gp_expected;
>
> or maybe even just
>
> 	bool fault_expected;
>
> and letting the assert define which vector is expected.
>

This also works, will change.

-- 
Vitaly

