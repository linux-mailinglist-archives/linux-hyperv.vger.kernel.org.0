Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5453F9F2
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jun 2022 11:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbiFGJg7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jun 2022 05:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbiFGJgx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jun 2022 05:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 383C8E64E1
        for <linux-hyperv@vger.kernel.org>; Tue,  7 Jun 2022 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654594612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TMMeeMzg716+0kOPZ1kJNvGjEZ2CaNLxMnft4GZfeHg=;
        b=Wn8BIleOlE8loXr25acrY17t+k4TxI46ltlR9stmrcdrq60bktlLyD0K4S0rpGTem4AhLx
        lPyLt9fkrVEnOvSttQqiYyIfEQUDrX5U5TARCQyBPKYP5RiKHuYyzgqcfsEEb3rlIelKlb
        xLo3+Q748okJ9UELqzKDWkGkkYwbEjQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-O7UcgeTPPSWw8SjtOUhAJw-1; Tue, 07 Jun 2022 05:36:43 -0400
X-MC-Unique: O7UcgeTPPSWw8SjtOUhAJw-1
Received: by mail-qt1-f200.google.com with SMTP id g14-20020ac87d0e000000b00304c6e43d12so13337825qtb.0
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Jun 2022 02:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TMMeeMzg716+0kOPZ1kJNvGjEZ2CaNLxMnft4GZfeHg=;
        b=rcQpQoQDp//+udP2b/CAgIXZjB5uw8QIF5Bu9JWPjq1p8dw2xQM5dsbHEfxSm7aAcO
         BkghmuAD0PbbnMkTB6r/xv9JKFms1avhu4IGJKIWFi267lV+tURVzrhtjc1cq55/Hr28
         JgvvjBSRL0emPlxoulGBFR50U442HBipvlFGf0QdpnBy5nlcPcqfNPg7rukQNiBkn2Lv
         TNZ0Ir6JTBAE6hlJfUb2eP8E7EsZ8PrItwbUX660VEgR24Ggd6+4gF0JEgU/Jz6CjvB8
         lq3xYzKiA7FCoyyfNmhCVpu/GX2yaCw07hPdYU9ra8aAfX8Z4ocWGAVrbxqJ2n0S9JxE
         ETEQ==
X-Gm-Message-State: AOAM532gNQQkzUpqougYBtvhelJbOtrLgU4nUWt6gKx7TiDrZ7mINWgC
        xja5RXxAyCGrMAXofCljSWROLeKqHaX657zrX6EOFU1XqqTtNOCx80FPq3RkjwlaGfY7dyeVN12
        20wTQfds039YRCSadfIrhBm3E
X-Received: by 2002:a05:6214:27cc:b0:46b:bc28:7d4f with SMTP id ge12-20020a05621427cc00b0046bbc287d4fmr846715qvb.80.1654594603150;
        Tue, 07 Jun 2022 02:36:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxCcLZX3ofJobo0dvjnhTkv9nwj9+XltzUdXK0HEeglyTnAe0VqZK4gyQ2MmA2ovb/JOXvEg==
X-Received: by 2002:a05:6214:27cc:b0:46b:bc28:7d4f with SMTP id ge12-20020a05621427cc00b0046bbc287d4fmr846702qvb.80.1654594602958;
        Tue, 07 Jun 2022 02:36:42 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id bm13-20020a05620a198d00b006a6d83fc9efsm1031130qkb.21.2022.06.07.02.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:36:42 -0700 (PDT)
Message-ID: <c89186f11fa1eb3563b791ba68cca4a533aa537f.camel@redhat.com>
Subject: Re: [PATCH v6 14/38] KVM: nSVM: Keep track of Hyper-V
 hv_vm_id/hv_vp_id
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
Date:   Tue, 07 Jun 2022 12:36:38 +0300
In-Reply-To: <20220606083655.2014609-15-vkuznets@redhat.com>
References: <20220606083655.2014609-1-vkuznets@redhat.com>
         <20220606083655.2014609-15-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 2022-06-06 at 10:36 +0200, Vitaly Kuznetsov wrote:
> Similar to nSVM, KVM needs to know L2's VM_ID/VP_ID and Partition
> assist page address to handle L2 TLB flush requests.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/svm/hyperv.h | 16 ++++++++++++++++
>  arch/x86/kvm/svm/nested.c |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/hyperv.h b/arch/x86/kvm/svm/hyperv.h
> index 7d6d97968fb9..8cf702fed7e5 100644
> --- a/arch/x86/kvm/svm/hyperv.h
> +++ b/arch/x86/kvm/svm/hyperv.h
> @@ -9,6 +9,7 @@
>  #include <asm/mshyperv.h>
>  
>  #include "../hyperv.h"
> +#include "svm.h"
>  
>  /*
>   * Hyper-V uses the software reserved 32 bytes in VMCB
> @@ -32,4 +33,19 @@ struct hv_enlightenments {
>   */
>  #define VMCB_HV_NESTED_ENLIGHTENMENTS VMCB_SW
>  
> +static inline void nested_svm_hv_update_vm_vp_ids(struct kvm_vcpu *vcpu)
> +{
> +       struct vcpu_svm *svm = to_svm(vcpu);
> +       struct hv_enlightenments *hve =
> +               (struct hv_enlightenments *)svm->nested.ctl.reserved_sw;
> +       struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> +
> +       if (!hv_vcpu)
> +               return;
> +
> +       hv_vcpu->nested.pa_page_gpa = hve->partition_assist_page;
> +       hv_vcpu->nested.vm_id = hve->hv_vm_id;
> +       hv_vcpu->nested.vp_id = hve->hv_vp_id;
> +}
> +
>  #endif /* __ARCH_X86_KVM_SVM_HYPERV_H__ */
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 88da8edbe1e1..e8908cc56e22 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -811,6 +811,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
>         if (kvm_vcpu_apicv_active(vcpu))
>                 kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
>  
> +       nested_svm_hv_update_vm_vp_ids(vcpu);
> +
>         return 0;
>  }
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

