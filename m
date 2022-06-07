Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501D453FA1C
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jun 2022 11:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiFGJrQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jun 2022 05:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbiFGJrO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jun 2022 05:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AFC026A
        for <linux-hyperv@vger.kernel.org>; Tue,  7 Jun 2022 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654595232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G8Dm6AswAqHWHs2oislYG9FYt3ny5v7/sywiO1TXWTo=;
        b=AotquklHJ3IXbPJwRQ7ktSGUDXvyKYmy46GK2uZwMHtTfokP0qNWXSMQHYDVlwZ42MtASD
        NOeabWO2AwteN87SWjcGv3tSmqYPFMOATG9JUZR7ejcUN7oYGOko8N0gBgTyWgiGMQGWFs
        +Z8jTJ0W+dNX+blSxkKjwi0+agL/DSI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-uQtY9ENSPyWmp-IbypkiLA-1; Tue, 07 Jun 2022 05:47:11 -0400
X-MC-Unique: uQtY9ENSPyWmp-IbypkiLA-1
Received: by mail-qv1-f69.google.com with SMTP id e3-20020a056214110300b0045abb0e1760so10500618qvs.3
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Jun 2022 02:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=G8Dm6AswAqHWHs2oislYG9FYt3ny5v7/sywiO1TXWTo=;
        b=BuX7jn65Yn8pXIDPq/PKmFgDVnE/qlMCPwruRDRdzyb2zMFFTjywTVXEFgCbO0acup
         ZuhG+GV570fpJZw9FBhSpuyzix7XVqrvPYyfkiY8o82utMDBdUA/rP+Utzqblpa9QsT5
         gexxywieeuiu2FXgpr96cqV0lcvbf950+OmgztSdRMqkvkoH9dXImjF152RcIJ5PfTsN
         M61/mi/B8Elki0hgqvese/bCkbeGrPVu0oztqNHzAQ/sUKginTvUNPY75Ei69YrGgVqt
         6P1CJmaZVEbZ5FtLx9ZA+hyQBvxVcgTLh3lakoy2aLSHyFKxY5pwwDZoQ5+BNTjhHDcb
         YQbg==
X-Gm-Message-State: AOAM530K7WxeA07k64WFPSq+MuWWOFYaTBoU6p3l+jWSVo9WRhgRm5Kg
        6QYmITGW1KjST8Dek53zKhS67Tm9T6g2dvLLrGZkulyx1YaOdg33CY+pgQcPMPxYeg0uk84Y06b
        RqOJ/N60QJ5VVmwVKxeDHAhQw
X-Received: by 2002:a37:d241:0:b0:6a6:9d18:6fb0 with SMTP id f62-20020a37d241000000b006a69d186fb0mr13924497qkj.548.1654595230126;
        Tue, 07 Jun 2022 02:47:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8c0BWn22LiLBVkXyz8o3pUx/YxBFOU1Wj9F4kx5MZwhik0JG0u+vVHnpWajZcMdhjUdt0mg==
X-Received: by 2002:a37:d241:0:b0:6a6:9d18:6fb0 with SMTP id f62-20020a37d241000000b006a69d186fb0mr13924484qkj.548.1654595229835;
        Tue, 07 Jun 2022 02:47:09 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a424d00b006a69ee117b6sm10082929qko.97.2022.06.07.02.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:47:09 -0700 (PDT)
Message-ID: <6903db23db5f6c7a3bd3126ca77d964aa35d2076.camel@redhat.com>
Subject: Re: [PATCH v6 17/38] KVM: x86: hyper-v: L2 TLB flush
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 07 Jun 2022 12:47:05 +0300
In-Reply-To: <20220606083655.2014609-18-vkuznets@redhat.com>
References: <20220606083655.2014609-1-vkuznets@redhat.com>
         <20220606083655.2014609-18-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 2022-06-06 at 10:36 +0200, Vitaly Kuznetsov wrote:
> Handle L2 TLB flush requests by going through all vCPUs and checking
> whether there are vCPUs running the same VM_ID with a VP_ID specified
> in the requests. Perform synthetic exit to L2 upon finish.
> 
> Note, while checking VM_ID/VP_ID of running vCPUs seem to be a bit
> racy, we count on the fact that KVM flushes the whole L2 VPID upon
> transition. Also, KVM_REQ_HV_TLB_FLUSH request needs to be done upon
> transition between L1 and L2 to make sure all pending requests are
> always processed.
> 
> For the reference, Hyper-V TLFS refers to the feature as "Direct
> Virtual Flush".
> 
> Note, nVMX/nSVM code does not handle VMCALL/VMMCALL from L2 yet.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 84 +++++++++++++++++++++++++++++++++++--------
>  arch/x86/kvm/hyperv.h | 14 ++++----
>  arch/x86/kvm/trace.h  | 21 ++++++-----
>  arch/x86/kvm/x86.c    |  4 +--
>  4 files changed, 91 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 3075e9661696..740190917c1c 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -34,6 +34,7 @@
>  #include <linux/eventfd.h>
>  
>  #include <asm/apicdef.h>
> +#include <asm/mshyperv.h>
>  #include <trace/events/kvm.h>
>  
>  #include "trace.h"
> @@ -1835,9 +1836,10 @@ static int kvm_hv_get_tlb_flush_entries(struct kvm *kvm, struct kvm_hv_hcall *hc
>                                   entries, consumed_xmm_halves, offset);
>  }
>  
> -static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count)
> +static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu,
> +                                struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo,
> +                                u64 *entries, int count)
>  {
> -       struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
>         struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>         u64 entry = KVM_HV_TLB_FLUSHALL_ENTRY;
>         unsigned long flags;
> @@ -1845,9 +1847,6 @@ static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count)
>         if (!hv_vcpu)
>                 return;
>  
> -       /* kvm_hv_flush_tlb() is not ready to handle requests for L2s yet */
> -       tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo[HV_L1_TLB_FLUSH_FIFO];
> -
>         spin_lock_irqsave(&tlb_flush_fifo->write_lock, flags);
>  
>         /*
> @@ -1883,7 +1882,7 @@ void kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
>                 return;
>         }
>  
> -       tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu);
> +       tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
>  
>         count = kfifo_out(&tlb_flush_fifo->entries, entries, KVM_HV_TLB_FLUSH_FIFO_SIZE);
>  
> @@ -1916,6 +1915,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>         struct hv_tlb_flush_ex flush_ex;
>         struct hv_tlb_flush flush;
>         DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
> +       struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
>         /*
>          * Normally, there can be no more than 'KVM_HV_TLB_FLUSH_FIFO_SIZE'
>          * entries on the TLB flush fifo. The last entry, however, needs to be
> @@ -1959,7 +1959,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>                 }
>  
>                 trace_kvm_hv_flush_tlb(flush.processor_mask,
> -                                      flush.address_space, flush.flags);
> +                                      flush.address_space, flush.flags,
> +                                      is_guest_mode(vcpu));
>  
>                 valid_bank_mask = BIT_ULL(0);
>                 sparse_banks[0] = flush.processor_mask;
> @@ -1990,7 +1991,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>                 trace_kvm_hv_flush_tlb_ex(flush_ex.hv_vp_set.valid_bank_mask,
>                                           flush_ex.hv_vp_set.format,
>                                           flush_ex.address_space,
> -                                         flush_ex.flags);
> +                                         flush_ex.flags, is_guest_mode(vcpu));
>  
>                 valid_bank_mask = flush_ex.hv_vp_set.valid_bank_mask;
>                 all_cpus = flush_ex.hv_vp_set.format !=
> @@ -2028,19 +2029,57 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>          * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we can't
>          * analyze it here, flush TLB regardless of the specified address space.
>          */
> -       if (all_cpus) {
> -               kvm_for_each_vcpu(i, v, kvm)
> -                       hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt);
> +       if (all_cpus && !is_guest_mode(vcpu)) {
> +               kvm_for_each_vcpu(i, v, kvm) {
> +                       tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
> +                       hv_tlb_flush_enqueue(v, tlb_flush_fifo,
> +                                            tlb_flush_entries, hc->rep_cnt);
> +               }
>  
>                 kvm_make_all_cpus_request(kvm, KVM_REQ_HV_TLB_FLUSH);
> -       } else {
> +       } else if (!is_guest_mode(vcpu)) {
>                 sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
>  
>                 for_each_set_bit(i, vcpu_mask, KVM_MAX_VCPUS) {
>                         v = kvm_get_vcpu(kvm, i);
>                         if (!v)
>                                 continue;
> -                       hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt);
> +                       tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
> +                       hv_tlb_flush_enqueue(v, tlb_flush_fifo,
> +                                            tlb_flush_entries, hc->rep_cnt);
> +               }
> +
> +               kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
> +       } else {
> +               struct kvm_vcpu_hv *hv_v;
> +
> +               bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
> +
> +               kvm_for_each_vcpu(i, v, kvm) {
> +                       hv_v = to_hv_vcpu(v);
> +
> +                       /*
> +                        * The following check races with nested vCPUs entering/exiting
> +                        * and/or migrating between L1's vCPUs, however the only case when
> +                        * KVM *must* flush the TLB is when the target L2 vCPU keeps
> +                        * running on the same L1 vCPU from the moment of the request until
> +                        * kvm_hv_flush_tlb() returns. TLB is fully flushed in all other
> +                        * cases, e.g. when the target L2 vCPU migrates to a different L1
> +                        * vCPU or when the corresponding L1 vCPU temporary switches to a
> +                        * different L2 vCPU while the request is being processed.
Looks great!

> +                        */
> +                       if (!hv_v || hv_v->nested.vm_id != hv_vcpu->nested.vm_id)
> +                               continue;
> +
> +                       if (!all_cpus &&
> +                           !hv_is_vp_in_sparse_set(hv_v->nested.vp_id, valid_bank_mask,
> +                                                   sparse_banks))
> +                               continue;
> +
> +                       __set_bit(i, vcpu_mask);
> +                       tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, true);
> +                       hv_tlb_flush_enqueue(v, tlb_flush_fifo,
> +                                            tlb_flush_entries, hc->rep_cnt);
>                 }
>  
>                 kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
> @@ -2228,10 +2267,27 @@ static void kvm_hv_hypercall_set_result(struct kvm_vcpu *vcpu, u64 result)
>  
>  static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
>  {
> +       int ret;
> +
>         trace_kvm_hv_hypercall_done(result);
>         kvm_hv_hypercall_set_result(vcpu, result);
>         ++vcpu->stat.hypercalls;
> -       return kvm_skip_emulated_instruction(vcpu);
> +       ret = kvm_skip_emulated_instruction(vcpu);
> +
> +       if (unlikely(hv_result_success(result) && is_guest_mode(vcpu)
> +                    && kvm_hv_is_tlb_flush_hcall(vcpu))) {
> +               struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> +               u32 tlb_lock_count;
> +
> +               if (unlikely(kvm_read_guest(vcpu->kvm, hv_vcpu->nested.pa_page_gpa,
> +                                           &tlb_lock_count, sizeof(tlb_lock_count))))
> +                       kvm_inject_gp(vcpu, 0);
> +
> +               if (tlb_lock_count)
> +                       kvm_x86_ops.nested_ops->hv_inject_synthetic_vmexit_post_tlb_flush(vcpu);
> +       }
> +
> +       return ret;
>  }
>  
>  static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index dc46c5ed5d18..7778b3a5913c 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -148,26 +148,24 @@ int kvm_vm_ioctl_hv_eventfd(struct kvm *kvm, struct kvm_hyperv_eventfd *args);
>  int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>                      struct kvm_cpuid_entry2 __user *entries);
>  
> -static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struct kvm_vcpu *vcpu)
> +static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struct kvm_vcpu *vcpu,
> +                                                                          bool is_guest_mode)
>  {
>         struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> -       int i = !is_guest_mode(vcpu) ? HV_L1_TLB_FLUSH_FIFO :
> -                                      HV_L2_TLB_FLUSH_FIFO;
> -
> -       /* KVM does not handle L2 TLB flush requests yet */
> -       WARN_ON_ONCE(i != HV_L1_TLB_FLUSH_FIFO);
> +       int i = is_guest_mode ? HV_L2_TLB_FLUSH_FIFO :
> +                               HV_L1_TLB_FLUSH_FIFO;
>  
>         return &hv_vcpu->tlb_flush_fifo[i];
>  }
>  
> -static inline void kvm_hv_vcpu_empty_flush_tlb(struct kvm_vcpu *vcpu)
> +static inline void kvm_hv_vcpu_empty_flush_tlb(struct kvm_vcpu *vcpu, bool is_guest_mode)
>  {
>         struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
>  
>         if (!to_hv_vcpu(vcpu) || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
>                 return;
>  
> -       tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu);
> +       tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode);
>  
>         kfifo_reset_out(&tlb_flush_fifo->entries);
>  }
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index fd28dd40b813..f5e5b8f0342c 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -1510,38 +1510,41 @@ TRACE_EVENT(kvm_hv_timer_state,
>   * Tracepoint for kvm_hv_flush_tlb.
>   */
>  TRACE_EVENT(kvm_hv_flush_tlb,
> -       TP_PROTO(u64 processor_mask, u64 address_space, u64 flags),
> -       TP_ARGS(processor_mask, address_space, flags),
> +       TP_PROTO(u64 processor_mask, u64 address_space, u64 flags, bool guest_mode),
> +       TP_ARGS(processor_mask, address_space, flags, guest_mode),
>  
>         TP_STRUCT__entry(
>                 __field(u64, processor_mask)
>                 __field(u64, address_space)
>                 __field(u64, flags)
> +               __field(bool, guest_mode)
>         ),
>  
>         TP_fast_assign(
>                 __entry->processor_mask = processor_mask;
>                 __entry->address_space = address_space;
>                 __entry->flags = flags;
> +               __entry->guest_mode = guest_mode;
>         ),
>  
> -       TP_printk("processor_mask 0x%llx address_space 0x%llx flags 0x%llx",
> +       TP_printk("processor_mask 0x%llx address_space 0x%llx flags 0x%llx %s",
>                   __entry->processor_mask, __entry->address_space,
> -                 __entry->flags)
> +                 __entry->flags, __entry->guest_mode ? "(L2)" : "")
>  );
>  
>  /*
>   * Tracepoint for kvm_hv_flush_tlb_ex.
>   */
>  TRACE_EVENT(kvm_hv_flush_tlb_ex,
> -       TP_PROTO(u64 valid_bank_mask, u64 format, u64 address_space, u64 flags),
> -       TP_ARGS(valid_bank_mask, format, address_space, flags),
> +       TP_PROTO(u64 valid_bank_mask, u64 format, u64 address_space, u64 flags, bool guest_mode),
> +       TP_ARGS(valid_bank_mask, format, address_space, flags, guest_mode),
>  
>         TP_STRUCT__entry(
>                 __field(u64, valid_bank_mask)
>                 __field(u64, format)
>                 __field(u64, address_space)
>                 __field(u64, flags)
> +               __field(bool, guest_mode)
>         ),
>  
>         TP_fast_assign(
> @@ -1549,12 +1552,14 @@ TRACE_EVENT(kvm_hv_flush_tlb_ex,
>                 __entry->format = format;
>                 __entry->address_space = address_space;
>                 __entry->flags = flags;
> +               __entry->guest_mode = guest_mode;
>         ),
>  
>         TP_printk("valid_bank_mask 0x%llx format 0x%llx "
> -                 "address_space 0x%llx flags 0x%llx",
> +                 "address_space 0x%llx flags 0x%llx %s",
>                   __entry->valid_bank_mask, __entry->format,
> -                 __entry->address_space, __entry->flags)
> +                 __entry->address_space, __entry->flags,
> +                 __entry->guest_mode ? "(L2)" : "")
>  );
>  
>  /*
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 805db43c2829..8e945500ef50 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3355,12 +3355,12 @@ void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu)
>  {
>         if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu)) {
>                 kvm_vcpu_flush_tlb_current(vcpu);
> -               kvm_hv_vcpu_empty_flush_tlb(vcpu);
> +               kvm_hv_vcpu_empty_flush_tlb(vcpu, is_guest_mode(vcpu));
>         }
>  
>         if (kvm_check_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu)) {
>                 kvm_vcpu_flush_tlb_guest(vcpu);
> -               kvm_hv_vcpu_empty_flush_tlb(vcpu);
> +               kvm_hv_vcpu_empty_flush_tlb(vcpu, is_guest_mode(vcpu));
>         } else if (kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu)) {
>                 kvm_hv_vcpu_flush_tlb(vcpu);
>         }

Looks good,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regadrds,
	Maxim Levitsky

