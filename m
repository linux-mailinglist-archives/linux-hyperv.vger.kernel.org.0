Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8F5718DB
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiGLLtS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiGLLtR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9597F1C931
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657626554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhycE2vEwnb9k/UxKYsjDnSNw/br2B5mjJJO+OCBKJk=;
        b=ehznDEmkGM2ONKd+Uo0Q2cYNEmIOn7L4pWRFrjSH8CKPBqZ2+VOipBsrBdDVUJnpaoteTg
        WjS0y7jKt3UYrfamVO59A4CNa03rnvwBExy8hzorTVbVHvQQwQeDLMtfcK9pC8P2mShHF9
        C4uP9QtM9oWBhA87sLLyqtJtNg/MitE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-Vh0l74L7PCiyxZV2anG4uQ-1; Tue, 12 Jul 2022 07:49:13 -0400
X-MC-Unique: Vh0l74L7PCiyxZV2anG4uQ-1
Received: by mail-qt1-f198.google.com with SMTP id j29-20020ac8405d000000b0031e9bb077dfso6731418qtl.15
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MhycE2vEwnb9k/UxKYsjDnSNw/br2B5mjJJO+OCBKJk=;
        b=6p05qTlMOetjgzQ+rJdqiFIrk2JKVQE+NeiUFy7cfo5yB7o9m0EL5lVvFQ9bF3xvi9
         8eoiGrFrkQza3h+AplCTdDnW4mdSgKr3IttQj1HLBpI22nM41fDDLZnZcrWPcS/poXlP
         E3vx86aLmKBzMfKLqFrGqEY+Wsp47wWfmA9i9OnL3LN05uVyBfnloiJ7UpMImCgbj4Uw
         a9kJ8X6WPcjFP3eNw61pN7m9rdWBDL1kkiG/Xf2vN5RXcQ8tQbn9hSWACEQgJR7v5nX6
         02XL8q8cNt36l9ITSO9a6DWWDDed1VwOmJH2Pc3LX2KnnExGhADF534fPwXkkirMVURT
         f7ng==
X-Gm-Message-State: AJIora+xvqD627eDRQjy+L2ePMAONLXXv/INH7HNaT/IS3VXNAag7TaD
        t80NBQ19Fp8HLbHUSD8+rdRQcP24KMtec+4H699dsWVNGwthwe4nniCqM454uZlSkFNmPf5iDDC
        w3gf5lJVHFRtWmp0FlcMDc4CY
X-Received: by 2002:a05:622a:1a1b:b0:31e:b7c8:b6cb with SMTP id f27-20020a05622a1a1b00b0031eb7c8b6cbmr5750535qtb.175.1657626552897;
        Tue, 12 Jul 2022 04:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s34OKcGuKrWbIoEXwTK/WXOI2GkPYpqBLQQTkv+ldrVvzF+HzU3Am9Cir8DCWD7cHNtNoTFQ==
X-Received: by 2002:a05:622a:1a1b:b0:31e:b7c8:b6cb with SMTP id f27-20020a05622a1a1b00b0031eb7c8b6cbmr5750518qtb.175.1657626552708;
        Tue, 12 Jul 2022 04:49:12 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a290600b006a758ce2ae1sm9729262qkp.104.2022.07.12.04.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:49:12 -0700 (PDT)
Message-ID: <6a92c7b3ab9932ebfb459841021f2cc1de03b5e1.camel@redhat.com>
Subject: Re: [PATCH v3 01/25] KVM: x86: hyper-v: Expose access to debug MSRs
 in the partition privilege flags
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:49:08 +0300
In-Reply-To: <20220708144223.610080-2-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-2-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 2022-07-08 at 16:41 +0200, Vitaly Kuznetsov wrote:
> For some features, Hyper-V spec defines two separate CPUID bits: one
> listing whether the feature is supported or not and another one showing
> whether guest partition was granted access to the feature ("partition
> privilege mask"). 'Debug MSRs available' is one of such features. Add
> the missing 'access' bit.
> 
> Fixes: f97f5a56f597 ("x86/kvm/hyper-v: Add support for synthetic debugger interface")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c             | 1 +
>  include/asm-generic/hyperv-tlfs.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index e2e95a6fccfd..e08189211d9a 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2496,6 +2496,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  			ent->eax |= HV_MSR_RESET_AVAILABLE;
>  			ent->eax |= HV_MSR_REFERENCE_TSC_AVAILABLE;
>  			ent->eax |= HV_ACCESS_FREQUENCY_MSRS;
> +			ent->eax |= HV_ACCESS_DEBUG_MSRS;
>  			ent->eax |= HV_ACCESS_REENLIGHTENMENT;
>  
>  			ent->ebx |= HV_POST_MESSAGES;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index fdce7a4cfc6f..1d99dd296a76 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -70,6 +70,8 @@
>  #define HV_MSR_GUEST_IDLE_AVAILABLE		BIT(10)
>  /* Partition local APIC and TSC frequency registers available */
>  #define HV_ACCESS_FREQUENCY_MSRS		BIT(11)
> +/* Debug MSRs available */
> +#define HV_ACCESS_DEBUG_MSRS			BIT(12)
>  /* AccessReenlightenmentControls privilege */
>  #define HV_ACCESS_REENLIGHTENMENT		BIT(13)
>  /* AccessTscInvariantControls privilege */


I guess you mean HV_FEATURE_DEBUG_MSRS_AVAILABLE and the new HV_ACCESS_DEBUG_MSRS

I checked the spec and the bits match, so I guess:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

