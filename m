Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBFC52A49C
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 May 2022 16:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348773AbiEQOUF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 May 2022 10:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348736AbiEQOUE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 May 2022 10:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 324043465B
        for <linux-hyperv@vger.kernel.org>; Tue, 17 May 2022 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652797201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WYXjJfd1pESNYbrTTSqKIx0/7SN9768efdFnzL3MuFI=;
        b=HMq2GmXYxEaXuM8Ey6vwONEN7AnmKX00NK9IKU2MXeOZF9oZKSQJF8gt82D9V6Bksz37Qq
        g98xBlxuZemk0kGvWN0i7BW+yfR1BjK7oxOqWlyGD1Kw2Zyfh8PalIINPGV8vRmUNVwvOG
        cKlg+USEZ6RTXwq8uTR8KlfkxF5ditA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-4KaXnNZLMkO6NXArvgX2Gg-1; Tue, 17 May 2022 10:19:59 -0400
X-MC-Unique: 4KaXnNZLMkO6NXArvgX2Gg-1
Received: by mail-wm1-f71.google.com with SMTP id r187-20020a1c44c4000000b003970bec7fd9so1179971wma.9
        for <linux-hyperv@vger.kernel.org>; Tue, 17 May 2022 07:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WYXjJfd1pESNYbrTTSqKIx0/7SN9768efdFnzL3MuFI=;
        b=0pLB4p9/mZy9f52qAh3MkThJO2KjP7lSboZAXlgtDyPQYPRAgEo1a4YLwIIIrpeFVa
         ojjKwXGi0t0UAavozcJFs5HNz+0vyrE1XqDV4lxCCDS9noxiwTCvH59dvvt0TkvyQ05g
         8parfxjLvPtd/UKLGQ4dkIasRVkcFKWg5A9k7XrVDVUzc/tY7Spg6NRY4Fa/vXEAfQNm
         FcCvZjuiFLtjij8L/E/h8Qj8j5F29GIxUUtl787oxgoPbqPuKqZJGoUhhw+cAPcWenPh
         LMik4ZsUaBLvKl/ri91VueG2D+ikResu7OLo0Jxi52kclshug2wgxYBLHMZQo8n4ID+m
         OpWQ==
X-Gm-Message-State: AOAM532fEa9G5wiJJN5Fb35/Npi32miQ9PmZSfi3L292B9sM7BmHq3GC
        NOORjJMI5EkHr1xkgsL9/Us0W3OsQrcCwQAngab6srBBM3dij/Xw+Mxh9QGr+1wUPLSasHOxj83
        gSoeNWtv6S5m2m/q8Qc8SOn3H
X-Received: by 2002:adf:dbce:0:b0:20c:f507:8ef9 with SMTP id e14-20020adfdbce000000b0020cf5078ef9mr15547839wrj.29.1652797196157;
        Tue, 17 May 2022 07:19:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm14vhveID3bnS4gZAuVd6DkGKO0v6KagNzfJE1Coe3sRC7u5JOMFT94nzhjZXGCVG8ILlNw==
X-Received: by 2002:adf:dbce:0:b0:20c:f507:8ef9 with SMTP id e14-20020adfdbce000000b0020cf5078ef9mr15547827wrj.29.1652797195922;
        Tue, 17 May 2022 07:19:55 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0a5600b003944821105esm2061670wmq.2.2022.05.17.07.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:19:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/34] KVM: x86: hyper-v: Use preallocated buffer in
 'struct kvm_vcpu_hv' instead of on-stack 'sparse_banks'
In-Reply-To: <YoOrc2hPF/QpJNeo@google.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-12-vkuznets@redhat.com>
 <YoKunaNKDjYx7C21@google.com> <87k0akuv1o.fsf@redhat.com>
 <YoOrc2hPF/QpJNeo@google.com>
Date:   Tue, 17 May 2022 16:19:54 +0200
Message-ID: <87h75outpx.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, May 17, 2022, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Thu, Apr 14, 2022, Vitaly Kuznetsov wrote:
>> >> To make kvm_hv_flush_tlb() ready to handle L2 TLB flush requests, KVM needs
>> >> to allow for all 64 sparse vCPU banks regardless of KVM_MAX_VCPUs as L1
>> >> may use vCPU overcommit for L2. To avoid growing on-stack allocation, make
>> >> 'sparse_banks' part of per-vCPU 'struct kvm_vcpu_hv' which is allocated
>> >> dynamically.
>> >> 
>> >> Note: sparse_set_to_vcpu_mask() keeps using on-stack allocation as it
>> >> won't be used to handle L2 TLB flush requests.
>> >
>> > I think it's worth using stronger language; handling TLB flushes for L2 _can't_
>> > use sparse_set_to_vcpu_mask() because KVM has no idea how to translate an L2
>> > vCPU index to an L1 vCPU.  I found the above mildly confusing because it didn't
>> > call out "vp_bitmap" and so I assumed the note referred to yet another sparse_banks
>> > "allocation".  And while vp_bitmap is related to sparse_banks, it tracks something
>> > entirely different.
>> >
>> > Something like?
>> >
>> > Note: sparse_set_to_vcpu_mask() can never be used to handle L2 requests as
>> > KVM can't translate L2 vCPU indices to L1 vCPUs, i.e. its vp_bitmap array
>> > is still bounded by the number of L1 vCPUs and so can remain an on-stack
>> > allocation.
>> 
>> My brain is probably tainted by looking at all this for some time so I
>> really appreciate such improvements, thanks :)
>> 
>> I wouldn't, however, say "never" ('never say never' :-)): KVM could've
>> kept 2-level reverse mapping up-to-date:
>> 
>> KVM -> L2 VM list -> L2 vCPU ids -> L1 vCPUs which run them
>> 
>> making it possible for KVM to quickly translate between L2 VP IDs and L1
>> vCPUs. I don't do this in the series and just record L2 VM_ID/VP_ID for
>> each L1 vCPU so I have to go over them all for each request. The
>> optimization is, however, possible and we may get to it if really big
>> Windows VMs become a reality.
>
> Out of curiosity, is L1 "required" to provides the L2 => L1 translation/map?
>

To make this "Direct Virtual Flush" feature work? Yes, it is:

...
"
Before enabling it, the L1 hypervisor must configure the following
additional fields of the enlightened VMCS:
- VpId: ID of the virtual processor that the enlightened VMCS controls.
- VmId: ID of the virtual machine that the enlightened VMCS belongs to.
- PartitionAssistPage: Guest physical address of the partition assist
page.
"

-- 
Vitaly

