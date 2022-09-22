Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2732D5E6740
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Sep 2022 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiIVPhO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 11:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiIVPhN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 11:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED535EB107
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663861031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mpy+ZkaV8qU9h3mLap4FWRmJ5KwCWQIoj50k/FL3Cgo=;
        b=Lv1LLcLydKz7NkweFgoflWnqBtQdi2c9acXvatThQ3CgcUWPRqyf4yNPI8g2xUmFhl+UBW
        FKd00XYCLqCeWD6S0cR5FENg6/ONnZoyBEE74ngGrOs7yIvDNXBxOLysiFJ3VXV8FkHiJz
        Kjox5N4+nMm9ISqSzvAx9t/9hhzd8Fg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-2yJzx0JvP5WPKKqni_XbzA-1; Thu, 22 Sep 2022 11:37:08 -0400
X-MC-Unique: 2yJzx0JvP5WPKKqni_XbzA-1
Received: by mail-wr1-f70.google.com with SMTP id g19-20020adfa493000000b0022a2ee64216so3405335wrb.14
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 08:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=Mpy+ZkaV8qU9h3mLap4FWRmJ5KwCWQIoj50k/FL3Cgo=;
        b=JSnIT06QzCWz8gxxqoFmAMUiR1XitbFK4QuVfo64CAx4R6B33ikzFlUpfZzrf6O+Yb
         6cwFvDHl5FP2dbOBk4ApyAJFDoKOK5Iow4f462qHbpRTGi4L3jMRY2QO0aeXZvjYRUEH
         cv/EfpT905fEdGzNOgts/OLvEpMT3sTe5kAWVtOKuG3L3TYYbo989BmyysKUlz7xdzIk
         WJ3PPap8Ddl7yR0KsRS01q8C7OfwfgqbItCIXEoCXPPvtwT8E2lsBa57aId0iPDK8u88
         fIgSMgbTqWJh8yGJKMQA/fB/ccg+qLLIrc3ywtA+IPTFDS7cVAYi2yF3RRrsqw8M56n3
         ErKg==
X-Gm-Message-State: ACrzQf36P6H52p4HU7UYZ/i0A1iMG5FDzygdrgs6gUyMhUBTodlPdri6
        VYj5oZ4PY5ikYB9E2CGCd/bhbyrqSlzMs8t/93zmbgBARGTFL8gL9j8saHggWMVb01IhUX2NCGe
        DDEPo3cuMcbJyp/d6iTmv8uSY
X-Received: by 2002:a05:600c:1f18:b0:3b4:c4ae:f666 with SMTP id bd24-20020a05600c1f1800b003b4c4aef666mr9900246wmb.88.1663861027488;
        Thu, 22 Sep 2022 08:37:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7+bdE8DyU/yd2jYZNWXi0hgLkeGHOQ6+wdsC6U/KYXsesIAen2WzmugHaX3m5/Qn82o8z/QA==
X-Received: by 2002:a05:600c:1f18:b0:3b4:c4ae:f666 with SMTP id bd24-20020a05600c1f1800b003b4c4aef666mr9900223wmb.88.1663861027244;
        Thu, 22 Sep 2022 08:37:07 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6405000000b0022af9555669sm6245246wru.99.2022.09.22.08.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:37:06 -0700 (PDT)
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
Subject: Re: [PATCH v10 02/39] KVM: x86: hyper-v: Resurrect dedicated
 KVM_REQ_HV_TLB_FLUSH flag
In-Reply-To: <Yyx+AJLacVzOdtBr@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-3-vkuznets@redhat.com>
 <Yys6b1ZqYbw9Umyu@google.com> <877d1voiuz.fsf@redhat.com>
 <Yyx+AJLacVzOdtBr@google.com>
Date:   Thu, 22 Sep 2022 17:37:05 +0200
Message-ID: <87sfkjmndq.fsf@redhat.com>
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

> On Thu, Sep 22, 2022, Vitaly Kuznetsov wrote:
>> Now let's get to VMX and the point of my confusion (and thanks in
>> advance for educating me!):
>> AFAIU, when EPT is in use:
>>  KVM_REQ_TLB_FLUSH_CURRENT == invept
>>  KVM_REQ_TLB_FLUSH_GUEST = invvpid
>> 
>> For "normal" mappings (which are mapped on both stages) this is the same
>> thing as they're 'tagged' with both VPID and 'EPT root'. The question is
>> what's left. Given your comment, do I understand correctly that in case
>> of an invalid mapping in the guest (GVA doesn't resolve to a GPA), this
>> will only be tagged with VPID but not with 'EPT root' (as the CPU never
>> reached to the second translation stage)? We certainly can't ignore
>> these. Another (probably pure theoretical question) is what are the
>> mappings which are tagged with 'EPT root' but don't have a VPID tag?
>
> Intel puts mappings into three categories, which for non-root mode equates to:
>
>   linear         == GVA => GPA
>   guest-physical == GPA => HPA
>   combined       == GVA => HPA
>
> and essentially the categories that consume the GVA are tagged with the VPID
> (linear and combined), and categories that consume the GPA are tagged with the
> EPTP address (guest-physical and combined).
>
>> Are these the mapping which happen when e.g. vCPU has paging disabled?
>
> No, these mappings can be created at all times.  Even with CR0.PG=1, the guest
> can generate GPAs without going through a GVA=>GPA translation, e.g. the page tables
> themselves, RTIT (Intel PT) addresses, etc...  And even for combined/full
> translations, the CPU can insert TLB entries for just the GPA=>HPA part.
>
> E.g. when a page is allocated by/for userspace, the kernel will zero the page using
> the kernel's direct map, but userspace will access the page via a different GVA.
> I.e. the guest effectively aliases GPA(x) with GVA(k) and GVA(u).  By inserting
> the GPA(x) => HPA(y) into the TLB, when guest userspace access GVA(u), the CPU
> encounters a TLB miss on GVA(u) => GPA(x), but gets a TLB hit on GPA(x) => HPA(y).
>
> Separating EPT flushes from VPID (and PCID) flushes allows the CPU to retain
> the partial TLB entries, e.g. a host change in the EPT tables will result in the
> guest-physical and combined mappings being invalidated, but linear mappings can
> be kept.
>

Thanks a bunch! For some reason I though it's always the full thing (combined)
which is tagged with both VPID/PCID and EPTP and linear/guest-physical
are just 'corner' cases (but are still combined and tagged). Apparently,
it's not like that.

> I'm 99% certain AMD also caches partial entries, e.g. see the blurb on INVLPGA
> not affecting NPT translations, AMD just doesn't provide a way for the host to
> flush _only_ NPT translations.  Maybe the performance benefits weren't significant
> enough to justify the extra complexity?
>
>> These are probably unrelated to Hyper-V TLB flushing.
>> 
>> To preserve the 'small' optimization, we can probably move 
>>  kvm_clear_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
>> 
>> to nested_svm_transition_tlb_flush() or, in case this sounds too
>> hackish
>
> Move it to svm_flush_tlb_current(), because the justification is that on SVM,
> flushing "current" TLB entries also flushes "guest" TLB entries due to the more
> coarse-grained ASID-based TLB flush.  E.g.
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index dd599afc85f5..a86b41503723 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3737,6 +3737,13 @@ static void svm_flush_tlb_current(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_svm *svm = to_svm(vcpu);
>  
> +       /*
> +        * Unlike VMX, SVM doesn't provide a way to flush only NPT TLB entries.
> +        * A TLB flush for the current ASID flushes both "host" and "guest" TLB
> +        * entries, and thus is a superset of Hyper-V's fine grained flushing.
> +        */
> +       kvm_hv_vcpu_purge_flush_tlb(vcpu);
> +
>         /*
>          * Flush only the current ASID even if the TLB flush was invoked via
>          * kvm_flush_remote_tlbs().  Although flushing remote TLBs requires all
>
>> we can drop it for now and add it to the (already overfull)
>> bucket of the "optimize nested_svm_transition_tlb_flush()".
>
> I think even long term, purging Hyper-V's FIFO in svm_flush_tlb_current() is the
> correct/desired behavior.  This doesn't really have anything to do with nSVM,
> it's all about SVM not providing a way to flush only NPT entries.

True that, silly me forgot that even without any nesting, Hyper-V TLB
flush after svm_flush_tlb_current() makes no sense.

>

-- 
Vitaly

