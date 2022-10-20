Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1249A60599B
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Oct 2022 10:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiJTIWo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Oct 2022 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiJTIWi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Oct 2022 04:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3329183E2B
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Oct 2022 01:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666254144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXxC5THgAjtEYfgbLwABUhO1u5EsuU0JRYrQfyg0GwE=;
        b=R1Pdy+BjhwRCyyXekrFJbbHc1VsEK9rMt6hsSg5QjxzMtluaCqITfmO7RVtWxDkiRT1Myn
        3f4lCfCr//zPBn6eIaLxY76QhSibnN2QvsvuA/Vw0xPo9U2gBbAdCAFh2cSj0R8eY5L/f+
        4TcQ7yzx/l+n5KoteVRVRV2buVBeJZI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-461-483gq94pMqaT9n905dSQ6Q-1; Thu, 20 Oct 2022 04:22:22 -0400
X-MC-Unique: 483gq94pMqaT9n905dSQ6Q-1
Received: by mail-ej1-f71.google.com with SMTP id jg38-20020a170907972600b007919b3ad75aso4050262ejc.10
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Oct 2022 01:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXxC5THgAjtEYfgbLwABUhO1u5EsuU0JRYrQfyg0GwE=;
        b=Oj2sGa725KgpsUOQFr2QFSKcMcCLDN7IlAYqrCQiGBK/rv5lXJIsC0NBPx1i+Mubxb
         eLzpjVW4GPncD+bYeYgt+ZUYxWJiFewCgysiV+edp8M8Rwpe54KW1/7JyVPJl7AzSmhW
         GNk+nJ98BVZZnNYCEdB8GtdWeKQd7CgGw4OA2PUY36hfTrgZTYuwTryUazWVGr3MhW6b
         0GAh/BSaau0uhF/hjvITL4a4cN+eJK2D5GoSQi3jgOZFmzX/txGGIwcoFEJqPhn4uMX0
         tk9nyW6LFMzaDX9n2CnEpr3jwLwA2Y1Fs3W2o4XRWjqQnZ0JowhRF33bRTwkFpm6SMMO
         FMnw==
X-Gm-Message-State: ACrzQf0yYpk0SMhU/MS/1vWXWsXGfCYnAPscdsuwWYs6C5Z0wKFndCQT
        bQbAy+ZRsZCs4rxG1qSSY6GAoR6rjqJSxjTc8Nt6TqS7++lf6kD+Speub2cDQZqQI/f+4/BPaMS
        yGlPG9vqIBLABUmGSNNY+JiE4
X-Received: by 2002:a17:907:971c:b0:78e:63f:c766 with SMTP id jg28-20020a170907971c00b0078e063fc766mr9957388ejc.330.1666254141384;
        Thu, 20 Oct 2022 01:22:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM77hNuYpdTNzaBxaGl4qanwjEest2MmHQgxj9LIOEFNPTGkaoTFS2OSELTfyljEa7SX2DQbRw==
X-Received: by 2002:a17:907:971c:b0:78e:63f:c766 with SMTP id jg28-20020a170907971c00b0078e063fc766mr9957379ejc.330.1666254141175;
        Thu, 20 Oct 2022 01:22:21 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t14-20020a05640203ce00b00459e3a3f3ddsm11633580edw.79.2022.10.20.01.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 01:22:20 -0700 (PDT)
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
Subject: Re: [PATCH v11 00/46] KVM: x86: hyper-v: Fine-grained TLB flush +
 L2 TLB flush features
In-Reply-To: <Y1B4kAIsc8Z0b2P9@google.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
 <Y1B4kAIsc8Z0b2P9@google.com>
Date:   Thu, 20 Oct 2022 10:22:19 +0200
Message-ID: <87v8oedhvo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Oct 04, 2022, Vitaly Kuznetsov wrote:
>> Changes since v10 (Sean):
>> - New patches added:
>>   - "x86/hyperv: Move VMCB enlightenment definitions to hyperv-tlfs.h"
>>   - "KVM: selftests: Move "struct hv_enlightenments" to x86_64/svm.h"
>>   - "KVM: SVM: Add a proper field for Hyper-V VMCB enlightenments"
>>   - 'x86/hyperv: KVM: Rename "hv_enlightenments" to "hv_vmcb_enlightenments"'
>>   - 'KVM: VMX: Rename "vmx/evmcs.{ch}" to "vmx/hyperv.{ch}"'
>>   - "KVM: x86: Move clearing of TLB_FLUSH_CURRENT to kvm_vcpu_flush_tlb_all()"
>>   - "KVM: selftests: Drop helpers to read/write page table entries"
>>   - "KVM: x86: Make kvm_hv_get_assist_page() return 0/-errno"
>> - Removed patches:
>>   - "KVM: selftests: Export _vm_get_page_table_entry()"
>> - Main differences:
>>   - Move Hyper-V TLB flushing out of kvm_service_local_tlb_flush_requests().
>>     On SVM, Hyper-V TLB flush FIFO is emptied from svm_flush_tlb_current()
>>   - Don't disable IRQs in hv_tlb_flush_enqueue().
>>   - Don't call kvm_vcpu_flush_tlb_guest() from kvm_hv_vcpu_flush_tlb() but
>>     return -errno instead.
>>   - Avoid unneded flushes in !EPT/!NPT cases.
>>   - Optimize hv_is_vp_in_sparse_set().
>>   - Move TLFS definitions to asm/hyperv-tlfs.h.
>>   - Use u64 vals in Hyper-V PV TLB flush selftest + multiple smaler changes
>>   - Typos, indentation, renames, ...
>
> Some nits throughout, but nothing major.  Everything could be fixed up when
> applying, but if it's not too much trouble I'd prefer a v11, the potential changes
> to kvm_hv_hypercall_complete() aren't completely trivial.

Thanks for the review! Let me do v12 to address your comments, I plan to
do it tomorrow.

-- 
Vitaly

