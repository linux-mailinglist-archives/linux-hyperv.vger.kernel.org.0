Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4F5F309D
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Oct 2022 15:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJCNBZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Oct 2022 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJCNBX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Oct 2022 09:01:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307134AD5A
        for <linux-hyperv@vger.kernel.org>; Mon,  3 Oct 2022 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664802081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cRj6bSlUC53GGB5VwGt/QTv7mNL3dMlu/4FM8+Jr3Ho=;
        b=A8LgLxNfb8RzrORD3ANBZoYg/y4MhhiXQS6vKsO/nVWSz8ZN2ztjHQs1hDMdjG4hRNW8hy
        +dX89UPZks2Hf24ZyDIyojESpNeZTrDuQB4rxmep3kDZdqu35nPC8v2KcGwRF0noKa5aZX
        ICxK56Q/p+7O7wnKRXzw8q8oO4VfL5A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-8kZZtUtXOBWv9hS0sl0ibA-1; Mon, 03 Oct 2022 09:01:10 -0400
X-MC-Unique: 8kZZtUtXOBWv9hS0sl0ibA-1
Received: by mail-ej1-f71.google.com with SMTP id ga36-20020a1709070c2400b007837e12cd7bso3263837ejc.9
        for <linux-hyperv@vger.kernel.org>; Mon, 03 Oct 2022 06:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=cRj6bSlUC53GGB5VwGt/QTv7mNL3dMlu/4FM8+Jr3Ho=;
        b=PnaJhGTW4AIhu0MGHLWITYMme5lrvhx9OLjUsL1ditWFq83rhaIt2XOnCKFef5v+DC
         ecQBn5//IQMDc+zWZM294wfDLwJqEKcGQsVAG6EysZuHjHL8gHOxvbxmq3veDRvTgNQC
         8DnWQBgOKCQaA2g0O2AgkYQNPvH5XpcohLjLSxZlv+AsX6WeU1f8A95gxq++efOjsVA6
         ewBS2VkxJ/958aYdvEk1sIti9vYm67D53xNDI1MkcYFRaM715rPhrfUp5gDWMdD4EOMN
         pC5ORU4EunvHW4pCt28B6HNIY43N3xUZ/HRdjnQNL6YZdNfr1tpbhPxN1NP0YuVkbtL6
         KQtg==
X-Gm-Message-State: ACrzQf2IisS6aiOUMWU3P8UyVcwCJFwAWYBTV3JtHnRVuDjX7HDp+454
        NqgZq7GXJzMlMTckR0PU+AlgsWB6r3XloYtVkJ8R7DcenmS7VOsJL/hqQkJ5IQNsvY8umIXpXOo
        aFWmXe4iJEAZil4QIEZx0gdqY
X-Received: by 2002:aa7:d306:0:b0:459:6e9:6284 with SMTP id p6-20020aa7d306000000b0045906e96284mr3362802edq.70.1664802069270;
        Mon, 03 Oct 2022 06:01:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4LhOt7lq8KC+MtSWbuxFBRAsDpLqs6b02Vk7/jD6P80CM9LRWg42h4L75YMKjHN7LJ+v/WZg==
X-Received: by 2002:aa7:d306:0:b0:459:6e9:6284 with SMTP id p6-20020aa7d306000000b0045906e96284mr3362761edq.70.1664802068878;
        Mon, 03 Oct 2022 06:01:08 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m21-20020a50ef15000000b00458bb36042asm4966689eds.1.2022.10.03.06.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:01:08 -0700 (PDT)
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
Subject: Re: [PATCH v10 30/39] KVM: selftests: Hyper-V PV TLB flush selftest
In-Reply-To: <YyuVtrpQwZGHs4ez@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-31-vkuznets@redhat.com>
 <YyuVtrpQwZGHs4ez@google.com>
Date:   Mon, 03 Oct 2022 15:01:07 +0200
Message-ID: <87wn9h9i3w.fsf@redhat.com>
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

> On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:

...

>> +}
>> +
>> +/* Delay */
>> +static inline void rep_nop(void)
>
> LOL, rep_nop() is a hilariously confusing function name.  "REP NOP" is "PAUSE",
> and for whatever reason the kernel proper use rep_nop() as the function name for
> the wrapper.  My reaction to the MFENCE+rep_nop() below was "how the hell does
> MFENCE+PAUSE guarantee a delay?!?".

Well, at least you got the joke :-)

>
> Anyways, why not do e.g. usleep(1)?  

I was under the impression that all these 'sleep' functions result in a
syscall (and I do see TRIPLE_FAULT when I swap my rep_nop() with usleep())
and here we need to wait in the guest (sender) ...

> And if you really need a udelay() and not a
> usleep(), IMO it's worth adding exactly that instead of throwing NOPs at the CPU.
> E.g. aarch64 KVM selftests already implements udelay(), so adding an x86 variant
> would move us one step closer to being able to use it in common tests.

... so yes, I think we need a delay. The problem with implementing
udelay() is that TSC frequency is unknown. We can get it from kvmclock
but setting up kvmclock pages for all selftests looks like an
overkill. Hyper-V emulation gives us HV_X64_MSR_TSC_FREQUENCY but that's
not generic enough. Alternatively, we can use KVM_GET_TSC_KHZ when
creating a vCPU but we'll need to pass the value to guest code somehow.
AFAIR, we can use CPUID.0x15 and/or MSR_PLATFORM_INFO (0xce) or even
introduce a PV MSR for our purposes -- or am I missing an obvious "easy"
solution?

I'm thinking about being lazy here and implemnting a Hyper-V specific
udelay through HV_X64_MSR_TSC_FREQUENCY (unless you object, of course)
to avoid bloating this series beyond 46 patches it already has.

...

-- 
Vitaly

