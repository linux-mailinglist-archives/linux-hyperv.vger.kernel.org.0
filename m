Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507245E5EED
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Sep 2022 11:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiIVJvS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiIVJvQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 05:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E6BD4ABD
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663840275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17uXSgfBSz8VOl61mGa12Lw4z5xbVJY4l5ZjuYmcfvo=;
        b=ZyY8jjawh1C1JfGG0diBIdexiqG+FBcl9lFD+/lLHcHFuM7OlBzDRU5JWsK91wNI5DD+t6
        5m0/IdPSHLmKpYvzBdx0RDx2bM0Yn8Aao7ulcsWt2M34DJnWlLRXgYZX+BZWWDUJpTiy4j
        4PXzOTpclLVyaDw/lKLub4rlPX16pLs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-365-TDcxwARDO2i48kzjzmaIIw-1; Thu, 22 Sep 2022 05:51:13 -0400
X-MC-Unique: TDcxwARDO2i48kzjzmaIIw-1
Received: by mail-wm1-f71.google.com with SMTP id r7-20020a1c4407000000b003b3309435a9so433357wma.6
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 02:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=17uXSgfBSz8VOl61mGa12Lw4z5xbVJY4l5ZjuYmcfvo=;
        b=NG2wXg4eCQZJEuWwea7mi5VAqgL/WSvSHl7+bWV1eAm5gmzjosVH8Ql8ajVb2zl+2V
         v9aO6gFofFjLPR07YxUUuu18Q3YGpzdHwrXq2/4IAwB9M04RvJhNLaynPTWTeXLc9yXf
         VjSuLvBhBKUDtO0BONiDwkZCIdjnlffuxX5SrY+XYr4VHDfmYWIIojQvcJipspI3xE8g
         HNj1FrWHkWxxxsojlg+vwLzTjST/YcNbdu/xO9bVmQ93Q+3i3qCl15fIkmE/XNtxsEza
         DL8Muj/cPrIjEQI3LRm4B1J8nqshZbm5+I1BxQsdpGzv6eNx0xNIArSzhOPYWlWsIftp
         Grpw==
X-Gm-Message-State: ACrzQf1/0hAbLfil+YFn2an1j4eKUwqnyDMVuBoXqRhyJlXyRlEAyhlX
        l5mM6VQUxOrVdYGF8nA9gRrc++dHQ9lyzlst9Y/xndcegTlOEizW89YOV0Vp+YLk2R2pIbdEzMC
        i6osyUvyyiLbmWLN3zG7h2wmA
X-Received: by 2002:adf:a28e:0:b0:22a:7428:3b04 with SMTP id s14-20020adfa28e000000b0022a74283b04mr1481600wra.75.1663840272507;
        Thu, 22 Sep 2022 02:51:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7zLZL8RAAX4U5+E3rMsNI8F9kayZUCyiTUu7cy/V1gn1HLvX9q9YbarSNcobG7D5s96P9KWw==
X-Received: by 2002:adf:a28e:0:b0:22a:7428:3b04 with SMTP id s14-20020adfa28e000000b0022a74283b04mr1481588wra.75.1663840272256;
        Thu, 22 Sep 2022 02:51:12 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z18-20020adff752000000b0022860e8ae7csm4682086wrp.77.2022.09.22.02.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:51:11 -0700 (PDT)
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
Subject: Re: [PATCH v10 14/39] KVM: nSVM: Keep track of Hyper-V
 hv_vm_id/hv_vp_id
In-Reply-To: <Yyt/Nrh4aoLrNt11@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-15-vkuznets@redhat.com>
 <Yyt/Nrh4aoLrNt11@google.com>
Date:   Thu, 22 Sep 2022 11:51:10 +0200
Message-ID: <87y1ubn3e9.fsf@redhat.com>
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
>> Similar to nSVM, KVM needs to know L2's VM_ID/VP_ID and Partition
>> assist page address to handle L2 TLB flush requests.
>> 
>> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/svm/hyperv.h | 16 ++++++++++++++++
>>  arch/x86/kvm/svm/nested.c |  2 ++
>>  2 files changed, 18 insertions(+)
>> 
>> diff --git a/arch/x86/kvm/svm/hyperv.h b/arch/x86/kvm/svm/hyperv.h
>> index 7d6d97968fb9..8cf702fed7e5 100644
>> --- a/arch/x86/kvm/svm/hyperv.h
>> +++ b/arch/x86/kvm/svm/hyperv.h
>> @@ -9,6 +9,7 @@
>>  #include <asm/mshyperv.h>
>>  
>>  #include "../hyperv.h"
>> +#include "svm.h"
>>  
>>  /*
>>   * Hyper-V uses the software reserved 32 bytes in VMCB
>> @@ -32,4 +33,19 @@ struct hv_enlightenments {
>>   */
>>  #define VMCB_HV_NESTED_ENLIGHTENMENTS VMCB_SW
>>  
>> +static inline void nested_svm_hv_update_vm_vp_ids(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +	struct hv_enlightenments *hve =
>> +		(struct hv_enlightenments *)svm->nested.ctl.reserved_sw;
>
> Eww :-)
>
> I posted a small series to fix the casting[*], and as noted in the cover letter it's
> going to conflict mightily.  Ignoring merge order for the moment, looking at the
> series as a whole, if the Hyper-V definitions are moved to hyperv-tlfs.h, then I'm
> tempted to say there's no need for svm/hyperv.h.
>
> There should never be users of this stuff outside of svm/nested.c, and IMO there's
> not enough stuff to warrant a separate set of files.  nested_svm_hv_update_vp_assist()
> isn't SVM specific and fits better alongside kvm_hv_get_assist_page().
>
> That leaves three functions and ~40 lines of code, which can easily go directly
> into svm/nested.c.
>
> I'm definitely not dead set against having hyperv.{ch}, but unless there's a high
> probability of SVM+Hyper-V getting to eVMCS levels of enlightenment, my vote is
> to put these helpers in svm/nested.c and move then if/when we do end up accumulating
> more SVM+Hyper-V code.

Well, there's more on the TODO list :-) There are even nSVM-only
features like "enlightened TLB" (to split ASID invalidations into two
stages) so I don't want to pollute 'nested.c'. In fact, I was thinking
about renaming vmx/evmcs.{ch} into vmx/hyperv.{ch} as we're doing more
than eVMCS there already. Also, having separate files help with the
newly introduces 'KVM X86 HYPER-V (KVM/hyper-v)' MAINTAINERS entry. Does
this sound like a good enough justification for keeping hyperv.{ch}?

>   
> As for merge order, I don't think there's a need for this series to take a
> dependency on the cleanup, especially if these helpers land in nested.c.  Fixing
> up the casting and s/hv_enlightenments/hv_vmcb_enlightenments is straightforward.
>
> [*] https://lore.kernel.org/all/20220921201607.3156750-1-seanjc@google.com
>

I'll take a look, thanks!

-- 
Vitaly

