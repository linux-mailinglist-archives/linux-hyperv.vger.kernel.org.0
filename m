Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28735E5EA0
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Sep 2022 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiIVJb4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 05:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIVJbz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 05:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D817CD1C5
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663839113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ybr30fZlUaDoYeaIa2plwZCg6mJWBOhhUXmFI2EBX4M=;
        b=GZJm31ulU9qRqPBoEe9Udm7xUB7XECvc16gl0YrWmVhyZTtXRIMKBB8SxDR+4Yz3ofDlTy
        wQnfkv64Ag9v0LhgkDBuMm265UqqI1yRO0rAOJGVtzqzm1YTTFbOS7lds5ZFrwc0sEZYki
        9DpKH83ExIziPbYlpGEWZqOjERZ9JAc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-364-y2YW6t09NfawkTxkBm4x5w-1; Thu, 22 Sep 2022 05:31:52 -0400
X-MC-Unique: y2YW6t09NfawkTxkBm4x5w-1
Received: by mail-wr1-f71.google.com with SMTP id l5-20020adfa385000000b0022a482f8285so3057928wrb.5
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 02:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=ybr30fZlUaDoYeaIa2plwZCg6mJWBOhhUXmFI2EBX4M=;
        b=ZI0M5wmoolgPcbz7ZeQ2tUqAPmsh7JZt6PCbG7vtxl6DW1CIUzEWOgOUIfhT3CwqSE
         Bt/Je8QO5Vh/WcRY9dXV5OTFy3dB+zMUAKPoH52ubqsFYOkNE2kWDnTrC9mPFdf26Yt7
         TzkI9mbPs8ZBkoKIVBPXCV/ZMrxRaoI6BKPKGFLdwsRlT95BIuqgDegd9plEjMLvLTMX
         JFircz9deia52XeWA9lkrfOlDrnW4sshg3C5LmWBa5xOpR+mdIYG4d3MWYxB7WEUzWlL
         0I2UPj3vaRDY5OMBqR9gt1xy9BnCkzCkWJ8f2Wov4Qndzr3+jBpTObnLPJS1yls/mUvd
         TI+A==
X-Gm-Message-State: ACrzQf20aUqM5aqJX1t7a4Du0fywRNut0Ls/E3+uvgE64a8MlxH7G15c
        7ALUEqdXWZACwwvwn/WlybDy0ulS8w2gZD7LvHTpnlgFOC8hM98aai/RROkpnrY0ETCo847iVIZ
        qHK1aS6nc0JnLItZhG+xvKVh4
X-Received: by 2002:a5d:58da:0:b0:22a:c3cb:e3cb with SMTP id o26-20020a5d58da000000b0022ac3cbe3cbmr1419599wrf.34.1663839111198;
        Thu, 22 Sep 2022 02:31:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM78NQ7fwohH1SuTimErCoGoVCo7k9Iba3RybxqQVWr2qdfj2Ej25Kl7QG6g24EzWCBG/KqDow==
X-Received: by 2002:a5d:58da:0:b0:22a:c3cb:e3cb with SMTP id o26-20020a5d58da000000b0022ac3cbe3cbmr1419586wrf.34.1663839110913;
        Thu, 22 Sep 2022 02:31:50 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b003b4a68645e9sm5672064wmq.34.2022.09.22.02.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:31:50 -0700 (PDT)
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
In-Reply-To: <Yys6b1ZqYbw9Umyu@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-3-vkuznets@redhat.com>
 <Yys6b1ZqYbw9Umyu@google.com>
Date:   Thu, 22 Sep 2022 11:31:48 +0200
Message-ID: <877d1voiuz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index f62d5799fcd7..86504a8bfd9a 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -3418,11 +3418,17 @@ static inline void kvm_vcpu_flush_tlb_current(struct kvm_vcpu *vcpu)
>>   */
>>  void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu)
>>  {
>> -	if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu))
>> +	if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu)) {
>>  		kvm_vcpu_flush_tlb_current(vcpu);
>> +		kvm_clear_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
>
> This isn't correct, flush_tlb_current() flushes "host" TLB entries, i.e. guest-physical
> mappings in Intel terminology, where flush_tlb_guest() and (IIUC) Hyper-V's paravirt
> TLB flush both flesh "guest" TLB entries, i.e. linear and combined
> mappings.

(Honestly, I was waiting for this comment when I first brought this, I
even put it in a separate patch with a provokative "KVM: x86:
KVM_REQ_TLB_FLUSH_CURRENT is a superset of KVM_REQ_HV_TLB_FLUSH too"
name but AFAIR the only comment I got was "please merge with the patch
which clears KVM_REQ_TLB_FLUSH_GUEST" so started thinking this was the
right thing to do :) Jokes aside,

This small optimization was done for nSVM case. When switching from L1
to L2 and vice versa, the code does nested_svm_transition_tlb_flush()
which is

	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);

On AMD, both KVM_REQ_TLB_FLUSH_CURRENT and KVM_REQ_TLB_FLUSH_GUEST are
the same thing (.flush_tlb_current == .flush_tlb_guest ==
svm_flush_tlb_current()) flushing the whole ASID so processing Hyper-V
TLB flush requests is ceratainly redundant.

Now let's get to VMX and the point of my confusion (and thanks in
advance for educating me!):
AFAIU, when EPT is in use:
 KVM_REQ_TLB_FLUSH_CURRENT == invept
 KVM_REQ_TLB_FLUSH_GUEST = invvpid

For "normal" mappings (which are mapped on both stages) this is the same
thing as they're 'tagged' with both VPID and 'EPT root'. The question is
what's left. Given your comment, do I understand correctly that in case
of an invalid mapping in the guest (GVA doesn't resolve to a GPA), this
will only be tagged with VPID but not with 'EPT root' (as the CPU never
reached to the second translation stage)? We certainly can't ignore
these. Another (probably pure theoretical question) is what are the
mappings which are tagged with 'EPT root' but don't have a VPID tag? Are
these the mapping which happen when e.g. vCPU has paging disabled? These
are probably unrelated to Hyper-V TLB flushing.

To preserve the 'small' optimization, we can probably move 
 kvm_clear_request(KVM_REQ_HV_TLB_FLUSH, vcpu);

to nested_svm_transition_tlb_flush() or, in case this sounds too
hackish, we can drop it for now and add it to the (already overfull)
bucket of the "optimize nested_svm_transition_tlb_flush()".

-- 
Vitaly

