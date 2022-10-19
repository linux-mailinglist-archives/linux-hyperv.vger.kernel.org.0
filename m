Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7B06052EC
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Oct 2022 00:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJSWWP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Oct 2022 18:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJSWWO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Oct 2022 18:22:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BF61735A9
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Oct 2022 15:22:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so1269940pjf.5
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Oct 2022 15:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lc7nEof8oNxTjR2TgiwAPvjHm//OCLDZ/hnb6eCYs60=;
        b=HGPCbZUrDHdBVHRaWY50SoPN04wgSXoiM3jyszD7bVxUzze4tlx2F2sEVU085BI8Xn
         YAsH3vRWZYDL5RUk3DL9pct18PeCzjEVQqY077njbVmzDUB5xjiBbLSaj6ZE0zTPSjM4
         8wYiNckByKH6HeJt6NMq/UlI8+78sxyCHJ9cDQ+ctOTzCQzztPMG03CIIQLP2YJHSr2N
         uFddX8aDHiUcPAw70YswY/qpyneHOfIQ4fj96yXq8PChcxG+yI3ZpNgsht4PHA+LFexQ
         waXhyXT4ox1DxWQa6U8mDXmZNfaXfn92TtdDe1q+KuzJWwaex1I+w+ohIp7wB/EwzLDf
         xOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc7nEof8oNxTjR2TgiwAPvjHm//OCLDZ/hnb6eCYs60=;
        b=ZybmBmcgTZDSPo/PQVl5SHpBe/1j9VGvG//kMXEXJQ3ytsSYw3dr0KqKhVuiN/2nJq
         gbGCFt/JW+sNNApjsEu7RmrC/lYsnvcIUJfCiMaNsxL8UyKxPfJdZ42Xcl9j0R178Y9C
         hU2xuPq8r0IX+dq/RYVVGoM1oRF5CxbICJGB/O9MkDF0kD1BDr4J3W+FzDd4JIimElZU
         714ou6cqbqajGdnpIDZbdvaNgCkP7rFgvUwAZxTk46ACTvZG9Gu1YVizUAc4867wKW7r
         hInNZk5WD7ta2rlbw/H8wb95qZM8Gt73bEeCmWa2siXFozSHfUnDw9cBvR4z4MxIT81m
         CIzw==
X-Gm-Message-State: ACrzQf3hbjUvMdbFNPwOZRfwUYdYI2TeoVOn7o6kRHihHwZ04GUydxir
        KU19ZUnwhbNvRS2Qy7jLu2sqiA==
X-Google-Smtp-Source: AMsMyM4nva1F0shlU4yDMbuqeLmJzlH65ES6wwFswJNL+VYstN5urGF/pcqOEtXB/lEYdDqw71Tp6w==
X-Received: by 2002:a17:90b:314c:b0:20d:83c1:5297 with SMTP id ip12-20020a17090b314c00b0020d83c15297mr12147095pjb.18.1666218132524;
        Wed, 19 Oct 2022 15:22:12 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c11-20020a624e0b000000b0056170e7299csm11762357pfb.9.2022.10.19.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:22:12 -0700 (PDT)
Date:   Wed, 19 Oct 2022 22:22:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/46] KVM: x86: hyper-v: Fine-grained TLB flush + L2
 TLB flush features
Message-ID: <Y1B4kAIsc8Z0b2P9@google.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004123956.188909-1-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 04, 2022, Vitaly Kuznetsov wrote:
> Changes since v10 (Sean):
> - New patches added:
>   - "x86/hyperv: Move VMCB enlightenment definitions to hyperv-tlfs.h"
>   - "KVM: selftests: Move "struct hv_enlightenments" to x86_64/svm.h"
>   - "KVM: SVM: Add a proper field for Hyper-V VMCB enlightenments"
>   - 'x86/hyperv: KVM: Rename "hv_enlightenments" to "hv_vmcb_enlightenments"'
>   - 'KVM: VMX: Rename "vmx/evmcs.{ch}" to "vmx/hyperv.{ch}"'
>   - "KVM: x86: Move clearing of TLB_FLUSH_CURRENT to kvm_vcpu_flush_tlb_all()"
>   - "KVM: selftests: Drop helpers to read/write page table entries"
>   - "KVM: x86: Make kvm_hv_get_assist_page() return 0/-errno"
> - Removed patches:
>   - "KVM: selftests: Export _vm_get_page_table_entry()"
> - Main differences:
>   - Move Hyper-V TLB flushing out of kvm_service_local_tlb_flush_requests().
>     On SVM, Hyper-V TLB flush FIFO is emptied from svm_flush_tlb_current()
>   - Don't disable IRQs in hv_tlb_flush_enqueue().
>   - Don't call kvm_vcpu_flush_tlb_guest() from kvm_hv_vcpu_flush_tlb() but
>     return -errno instead.
>   - Avoid unneded flushes in !EPT/!NPT cases.
>   - Optimize hv_is_vp_in_sparse_set().
>   - Move TLFS definitions to asm/hyperv-tlfs.h.
>   - Use u64 vals in Hyper-V PV TLB flush selftest + multiple smaler changes
>   - Typos, indentation, renames, ...

Some nits throughout, but nothing major.  Everything could be fixed up when
applying, but if it's not too much trouble I'd prefer a v11, the potential changes
to kvm_hv_hypercall_complete() aren't completely trivial.
