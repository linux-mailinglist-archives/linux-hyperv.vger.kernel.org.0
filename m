Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449A35E5516
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Sep 2022 23:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiIUVTN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Sep 2022 17:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiIUVTL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Sep 2022 17:19:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3F4A5C76
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 14:19:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d82so7229271pfd.10
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qn2Tyr5BBZtLc4Q3iyya3S9UpHREHtk3JzWAYU0n/Xs=;
        b=lrCrFnJwDqg8lDvVHSiB+LouuHDaJu2gqUZm46RhmQ6BqLAfOIqs39DLUFOH5A02O2
         /Qx9DbpVmcOTFg5n05d9GFQNcSgsYRHmcTyARBaMzZBW/ykLtS0C4r4FDt+rET9IJuI6
         /2/oNlWepPwjg/wX4KiSj6aqQpXn0bxMQ/OTpN2Cjx+/lRL7BWCMhgux3d4JdUYnHs7V
         zbefxEvtHUlFl8/nmUyQ/AWKEKOAzCbjAcbijwUG23yLWyA50QKka/yTpNU8E6f0Z7Mv
         5hHnB/QotfaoVRYtQ9mlTtabSiRs9NXGGU55wRi7wY+ltf9aoHqh9ARlfxX08c2jyo7O
         +nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qn2Tyr5BBZtLc4Q3iyya3S9UpHREHtk3JzWAYU0n/Xs=;
        b=McDFVTQXRgvQkIvdQmOv2CLc0UAsPjpxvEKKPEAC3Gh5aUW6XlCEsR9srVblj1c7uy
         8/zEdociPHZRTxxz48rwabHG4R2i1VPjCO9Pyj79pzFk3LuDOJdTDJUIeo+xF/tP9PBl
         5oBuiXE/PLiN83vjL7OERNO8pdxqJNk/jVNim1koGqxckXx7fTNVwEcwP/XG37f3dXhP
         +bia2oNeBYdo39nt3/q0TBnWk0LhOvOX83MVKXEGb2a1+YzzfyqD0g02S9MtZ0tgSpaC
         hVG6gd85RKVK9DdOMxxH3tFb/dp3nKjc1NdV2KawGzzlmgvMI64l4Uq+gWWDXrNWGOOO
         EDeQ==
X-Gm-Message-State: ACrzQf3HTbgXE4ilgr87wvwSl2Ye5ULOrKaGoEpJHnsqFO7Et1r44Nnr
        HWJc0OZdbEv9Lk092327aE55FA==
X-Google-Smtp-Source: AMsMyM7NDWr1OHvf4/DOTuO46c9LjjzZYkWEszB0swaN+tiWynXVjEvc8rod3Lqug5SO6bxMqtcDMA==
X-Received: by 2002:a63:8542:0:b0:43a:5ca7:c710 with SMTP id u63-20020a638542000000b0043a5ca7c710mr143996pgd.264.1663795150087;
        Wed, 21 Sep 2022 14:19:10 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902680500b00178b717a0a3sm2430996plk.69.2022.09.21.14.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:19:09 -0700 (PDT)
Date:   Wed, 21 Sep 2022 21:19:06 +0000
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
Subject: Re: [PATCH v10 18/39] KVM: x86: hyper-v: Introduce fast
 guest_hv_cpuid_has_l2_tlb_flush() check
Message-ID: <Yyt/ylgNjsgGTQMN@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-19-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921152436.3673454-19-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:
> Introduce a helper to quickly check if KVM needs to handle VMCALL/VMMCALL
> from L2 in L0 to process L2 TLB flush requests.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 1b53dd4cff4d..3fff3a6f4bb9 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -174,6 +174,13 @@ static inline void kvm_hv_vcpu_empty_flush_tlb(struct kvm_vcpu *vcpu)
>  	kfifo_reset_out(&tlb_flush_fifo->entries);
>  }
>  
> +static inline bool guest_hv_cpuid_has_l2_tlb_flush(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> +
> +	return hv_vcpu && (hv_vcpu->cpuid_cache.nested_eax & HV_X64_NESTED_DIRECT_FLUSH);

Nit, IMO this is long enough that it's worth wrapping to fit under the soft char limit.

	return hv_vcpu &&
	       (hv_vcpu->cpuid_cache.nested_eax & HV_X64_NESTED_DIRECT_FLUSH);

> +}
> +
>  static inline bool kvm_hv_is_tlb_flush_hcall(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> -- 
> 2.37.3
> 
