Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7323053F8EE
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jun 2022 10:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbiFGI6H (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jun 2022 04:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbiFGI6F (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jun 2022 04:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C41AC1115C
        for <linux-hyperv@vger.kernel.org>; Tue,  7 Jun 2022 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654592266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Im8ECHcYmpO3jURF5NFQ6YSKCiAdvp768cL63zS5OUM=;
        b=U1NHtWIiGI6oc6LhzJ9OfPM+z2lXA6hoilMAM4DWGRL9xtMsZGHgV9MPKKV4CsMpeMn32J
        0wPrRiPSzRsm558oe91DaaBEYPi8ovZIo5n4n2QZG/kmWUnpuFKihf+PfgTSPpm7k6qGNR
        9DzKydqwRbOg31jIKKE1Rqd0IaWTzT8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-4XLxrcFoNMCXOXfbr99zSw-1; Tue, 07 Jun 2022 04:57:45 -0400
X-MC-Unique: 4XLxrcFoNMCXOXfbr99zSw-1
Received: by mail-qk1-f200.google.com with SMTP id bk10-20020a05620a1a0a00b006a6b1d676ebso5722422qkb.0
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Jun 2022 01:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Im8ECHcYmpO3jURF5NFQ6YSKCiAdvp768cL63zS5OUM=;
        b=yEpN0yFSaN6drKxRQ+J/K22n5jU/q/gkIWXxSBOn1bT+kONbAQ3E1RY7e/6jQxtfV3
         1/bA4kJTroa9v7D5aRsSwsgP5CKtEjs5nICTMTcib84uMYph+v6EHhOOuShZzsDHjPXu
         Kyxbp1jQaz0bFTbkMfWP+LHULSujqRWpQ2Dafrmf3FdB9lr9MCrpb9QoMXbLodntX/Ro
         QwzT9k6Q95sTzZ+khB5c7sNAhBoblBWlE8bw4rjroCqbez0Al4zZc2qqnI/kSnJDlIgU
         oHSNih+k3Zpq1meTFxJqMjhTIA24xEDDBoZDys5QZLFNQAmWR01vLhlK6MDGndcAThzC
         /Frg==
X-Gm-Message-State: AOAM531cppk0ebhqelrrFiNaoGJFNJzGV0hqBXUsORcl/Y5zs+HjDmPq
        rI52KDNlRG+jW9v511bVLFVeU6Gpbvvy19GowPDgMdTOg71rIZ7CCRrJai+oDvRCbBrTWXQ0Rtf
        qANsVX7gaRnSpo/YKJxLw+/LH
X-Received: by 2002:a05:620a:2681:b0:67e:909f:d5ac with SMTP id c1-20020a05620a268100b0067e909fd5acmr18674855qkp.125.1654592264957;
        Tue, 07 Jun 2022 01:57:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYaBUuBxe5hdd/nIVxaSj+ZgZz9VmzzhfDUc9+zEwkHxbm0unQbqKnqQA939Ox4FYOY7A95g==
X-Received: by 2002:a05:620a:2681:b0:67e:909f:d5ac with SMTP id c1-20020a05620a268100b0067e909fd5acmr18674844qkp.125.1654592264700;
        Tue, 07 Jun 2022 01:57:44 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a13ec00b0069fc13ce20asm5775934qkl.59.2022.06.07.01.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:57:43 -0700 (PDT)
Message-ID: <4be614689a902303cef1e5e1889564f965e63baa.camel@redhat.com>
Subject: Re: [PATCH v6 03/38] KVM: x86: hyper-v: Introduce TLB flush fifo
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
Date:   Tue, 07 Jun 2022 11:57:40 +0300
In-Reply-To: <20220606083655.2014609-4-vkuznets@redhat.com>
References: <20220606083655.2014609-1-vkuznets@redhat.com>
         <20220606083655.2014609-4-vkuznets@redhat.com>
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
> To allow flushing individual GVAs instead of always flushing the
> whole
> VPID a per-vCPU structure to pass the requests is needed. Use
> standard
> 'kfifo' to queue two types of entries: individual GVA (GFN + up to
> 4095
> following GFNs in the lower 12 bits) and 'flush all'.

Honestly I still don't think I understand why we can't just
raise KVM_REQ_TLB_FLUSH_GUEST when the guest uses this interface
to flush everthing, and then we won't need to touch the ring
at all.

But I am just curious - if there is a reason for that,
then no objections from my side.


> 
> The size of the fifo is arbitrary set to '16'.
> 
> Note, kvm_hv_flush_tlb() only queues 'flush all' entries for now and
> kvm_hv_vcpu_flush_tlb() doesn't actually read the fifo just resets
> the
> queue before doing full TLB flush so the functional change is very
> small but the infrastructure is prepared to handle individual GVA
> flush requests.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 20 +++++++++++++++
>  arch/x86/kvm/hyperv.c           | 45
> +++++++++++++++++++++++++++++++++
>  arch/x86/kvm/hyperv.h           | 16 ++++++++++++
>  arch/x86/kvm/x86.c              |  8 +++---
>  arch/x86/kvm/x86.h              |  1 +
>  5 files changed, 86 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h
> b/arch/x86/include/asm/kvm_host.h
> index 7a6a6f47b603..cf3748be236d 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -25,6 +25,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/irqbypass.h>
>  #include <linux/hyperv.h>
> +#include <linux/kfifo.h>
>  
>  #include <asm/apic.h>
>  #include <asm/pvclock-abi.h>
> @@ -600,6 +601,23 @@ struct kvm_vcpu_hv_synic {
>         bool dont_zero_synic_pages;
>  };
>  
> +/* The maximum number of entries on the TLB flush fifo. */
> +#define KVM_HV_TLB_FLUSH_FIFO_SIZE (16)
> +/*
> + * Note: the following 'magic' entry is made up by KVM to avoid
> putting
> + * anything besides GVA on the TLB flush fifo. It is theoretically
> possible
> + * to observe a request to flush 4095 PFNs starting from
> 0xfffffffffffff000
> + * which will look identical. KVM's action to 'flush everything'
> instead of
> + * flushing these particular addresses is, however, fully legitimate
> as
> + * flushing more than requested is always OK.
> + */
> +#define KVM_HV_TLB_FLUSHALL_ENTRY  ((u64)-1)
> +
> +struct kvm_vcpu_hv_tlb_flush_fifo {
> +       spinlock_t write_lock;
> +       DECLARE_KFIFO(entries, u64, KVM_HV_TLB_FLUSH_FIFO_SIZE);
> +};
> +
>  /* Hyper-V per vcpu emulation context */
>  struct kvm_vcpu_hv {
>         struct kvm_vcpu *vcpu;
> @@ -619,6 +637,8 @@ struct kvm_vcpu_hv {
>                 u32 enlightenments_ebx; /*
> HYPERV_CPUID_ENLIGHTMENT_INFO.EBX */
>                 u32 syndbg_cap_eax; /*
> HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX */
>         } cpuid_cache;
> +
> +       struct kvm_vcpu_hv_tlb_flush_fifo tlb_flush_fifo;
>  };
>  
>  /* Xen HVM per vcpu emulation context */
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index b402ad059eb9..c8b22bf67577 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -29,6 +29,7 @@
>  #include <linux/kvm_host.h>
>  #include <linux/highmem.h>
>  #include <linux/sched/cputime.h>
> +#include <linux/spinlock.h>
>  #include <linux/eventfd.h>
>  
>  #include <asm/apicdef.h>
> @@ -954,6 +955,9 @@ static int kvm_hv_vcpu_init(struct kvm_vcpu
> *vcpu)
>  
>         hv_vcpu->vp_index = vcpu->vcpu_idx;
>  
> +       INIT_KFIFO(hv_vcpu->tlb_flush_fifo.entries);
> +       spin_lock_init(&hv_vcpu->tlb_flush_fifo.write_lock);
> +
>         return 0;
>  }
>  
> @@ -1789,6 +1793,35 @@ static u64 kvm_get_sparse_vp_set(struct kvm
> *kvm, struct kvm_hv_hcall *hc,
>                               var_cnt * sizeof(*sparse_banks));
>  }
>  
> +static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
> +       struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> +       u64 entry = KVM_HV_TLB_FLUSHALL_ENTRY;
> +
> +       if (!hv_vcpu)
> +               return;
> +
> +       tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
> +
> +       kfifo_in_spinlocked(&tlb_flush_fifo->entries, &entry, 1,
> &tlb_flush_fifo->write_lock);
Tiny nitpick: the 'tlb_flush_fifo' isn't really neede here I think,
but probably will be needed in later patches, so feel free to ignore.


> +}
> +
> +void kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
> +       struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> +
> +       kvm_vcpu_flush_tlb_guest(vcpu);
> +
> +       if (!hv_vcpu)
> +               return;
> +
> +       tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
> +
> +       kfifo_reset_out(&tlb_flush_fifo->entries);
Same here.
> +}
> +
>  static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct
> kvm_hv_hcall *hc)
>  {
>         struct kvm *kvm = vcpu->kvm;
> @@ -1797,6 +1830,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu
> *vcpu, struct kvm_hv_hcall *hc)
>         DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
>         u64 valid_bank_mask;
>         u64 sparse_banks[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
> +       struct kvm_vcpu *v;
> +       unsigned long i;
>         bool all_cpus;
>  
>         /*
> @@ -1876,10 +1911,20 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu
> *vcpu, struct kvm_hv_hcall *hc)
>          * analyze it here, flush TLB regardless of the specified
> address space.
>          */
>         if (all_cpus) {
> +               kvm_for_each_vcpu(i, v, kvm)
> +                       hv_tlb_flush_enqueue(v);
> +
>                 kvm_make_all_cpus_request(kvm, KVM_REQ_HV_TLB_FLUSH);
>         } else {
>                 sparse_set_to_vcpu_mask(kvm, sparse_banks,
> valid_bank_mask, vcpu_mask);
>  
> +               for_each_set_bit(i, vcpu_mask, KVM_MAX_VCPUS) {
> +                       v = kvm_get_vcpu(kvm, i);
> +                       if (!v)
> +                               continue;
> +                       hv_tlb_flush_enqueue(v);
> +               }
> +
>                 kvm_make_vcpus_request_mask(kvm,
> KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
>         }
>  
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index da2737f2a956..e5b32266ff7d 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -147,4 +147,20 @@ int kvm_vm_ioctl_hv_eventfd(struct kvm *kvm,
> struct kvm_hyperv_eventfd *args);
>  int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2
> *cpuid,
>                      struct kvm_cpuid_entry2 __user *entries);
>  
> +
> +static inline void kvm_hv_vcpu_empty_flush_tlb(struct kvm_vcpu
> *vcpu)
> +{
> +       struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
> +       struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> +
> +       if (!hv_vcpu || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH,
> vcpu))
> +               return;
> +
> +       tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
> +
> +       kfifo_reset_out(&tlb_flush_fifo->entries);
> +}
> +void kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
> +
> +
>  #endif
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 80cd3eb5e7de..805db43c2829 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3320,7 +3320,7 @@ static void kvm_vcpu_flush_tlb_all(struct
> kvm_vcpu *vcpu)
>         static_call(kvm_x86_flush_tlb_all)(vcpu);
>  }
>  
> -static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
> +void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
>  {
>         ++vcpu->stat.tlb_flush;
>  
> @@ -3355,14 +3355,14 @@ void
> kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu)
>  {
>         if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu)) {
>                 kvm_vcpu_flush_tlb_current(vcpu);
> -               kvm_clear_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
> +               kvm_hv_vcpu_empty_flush_tlb(vcpu);
>         }
>  
>         if (kvm_check_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu)) {
>                 kvm_vcpu_flush_tlb_guest(vcpu);
> -               kvm_clear_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
> +               kvm_hv_vcpu_empty_flush_tlb(vcpu);
>         } else if (kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu)) {
> -               kvm_vcpu_flush_tlb_guest(vcpu);
> +               kvm_hv_vcpu_flush_tlb(vcpu);
>         }
>  }
>  EXPORT_SYMBOL_GPL(kvm_service_local_tlb_flush_requests);
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 501b884b8cc4..9f7989f2c6d4 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -79,6 +79,7 @@ static inline unsigned int
> __shrink_ple_window(unsigned int val,
>  
>  #define MSR_IA32_CR_PAT_DEFAULT  0x0007040600070406ULL
>  
> +void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu);
>  void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu);
>  int kvm_check_nested_events(struct kvm_vcpu *vcpu);
>  

Best regards,
	Maxim Levitsky

