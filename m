Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B63571905
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiGLLwp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiGLLwV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A58EB5202
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657626712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lJt34wYL23qHhqMiKTsYFaw21Mxmb1U5E0uo3Jh2TRY=;
        b=E5ruJwlMsEIUyJFSBKCeFW7eaNNhCbpfLkr7yy7pA8UBpNJvvIwitSO6ZLaz9OChITsjQR
        cr+a5tc34xJZke0RWQBDBi8QnbNMd9DaIcBjOAJp2Dm61YfiRmVs6LhZYajb1SjiZLRaPB
        YtYFk9m7ay1KKZ9kbkSUqDLutq8hcwU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-HzTOGs2XP627zuu4HmlPPw-1; Tue, 12 Jul 2022 07:51:49 -0400
X-MC-Unique: HzTOGs2XP627zuu4HmlPPw-1
Received: by mail-qv1-f71.google.com with SMTP id p6-20020a0c8c86000000b004731e63c75bso1664794qvb.10
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lJt34wYL23qHhqMiKTsYFaw21Mxmb1U5E0uo3Jh2TRY=;
        b=hVNYbuEXx37eF2Iz+DXhFdCslJKgJgQAO5QSeymwwH4GM6eK85gplCJazELnQa1FH5
         fUfMY0+werzWKo99Mhtcg28Aq5wj335KCEtQlAQ0HRyX/EYC358uMs4n93iWsqUnMcqh
         GN7+a6RWhOhE8RXEaGwG/sKF3gJOxQVlW87DgFFIe6aGBD9mo+87bC53EXoHqJQKOkKZ
         5puhgH1ISSRLIkeIxtWPcVydSuHLJ2/vlRv95jidKvB9YYO03x1H1mlpi2N2UUDId9Du
         L+a4Mka/6k1sPOGQoVpCSkbAcz1BAfW8UY9V4XNQ6IP2hIU38OmSyNQiYLTBeT75cYE1
         voDA==
X-Gm-Message-State: AJIora8aoP39b0Nu439hVpKL2C/DLVKab+UcRJ/nNZzhqGTjuPTKbnDP
        aA55xPP4l6uBBfpusyRu3vAsYRqW7AXPvlhDjQeIg7Qj2nYail0EuY+YBennSMtwkIpsGeJOVZc
        JbhmJNvuWOOdWFWtje0H+v7tH
X-Received: by 2002:ac8:580f:0:b0:31d:403e:9dd2 with SMTP id g15-20020ac8580f000000b0031d403e9dd2mr17810840qtg.245.1657626709034;
        Tue, 12 Jul 2022 04:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sfzW/HS+DgXkouauxFV7OY0AYI78cdEPBP3JoT8e1O8OBxPAfrh2D4NWntWrbLwzxZqv5+sQ==
X-Received: by 2002:ac8:580f:0:b0:31d:403e:9dd2 with SMTP id g15-20020ac8580f000000b0031d403e9dd2mr17810830qtg.245.1657626708795;
        Tue, 12 Jul 2022 04:51:48 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id k143-20020a37a195000000b006b1fe4a103dsm8666859qke.51.2022.07.12.04.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:51:48 -0700 (PDT)
Message-ID: <26e7784ff4ee91a8d41d217dcb5f3e0e0ce6e470.camel@redhat.com>
Subject: Re: [PATCH v3 06/25] KVM: x86: hyper-v: Cache
 HYPERV_CPUID_NESTED_FEATURES CPUID leaf
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:51:44 +0300
In-Reply-To: <20220708144223.610080-7-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-7-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> KVM has to check guest visible HYPERV_CPUID_NESTED_FEATURES.EBX CPUID
> leaf to know with Enlightened VMCS definition to use (original or 2022
> update). Cache the leaf along with other Hyper-V CPUID feature leaves
> to make the check quick.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 2 ++
>  arch/x86/kvm/hyperv.c           | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index de5a149d0971..077ec9cf3169 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -616,6 +616,8 @@ struct kvm_vcpu_hv {
>  		u32 enlightenments_eax; /* HYPERV_CPUID_ENLIGHTMENT_INFO.EAX */
>  		u32 enlightenments_ebx; /* HYPERV_CPUID_ENLIGHTMENT_INFO.EBX */
>  		u32 syndbg_cap_eax; /* HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX */
> +		u32 nested_eax; /* HYPERV_CPUID_NESTED_FEATURES.EAX */
> +		u32 nested_ebx; /* HYPERV_CPUID_NESTED_FEATURES.EBX */
>  	} cpuid_cache;
>  };
>  
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index e08189211d9a..b666902da4d9 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2030,6 +2030,15 @@ void kvm_hv_set_cpuid(struct kvm_vcpu *vcpu)
>  		hv_vcpu->cpuid_cache.syndbg_cap_eax = entry->eax;
>  	else
>  		hv_vcpu->cpuid_cache.syndbg_cap_eax = 0;
> +
> +	entry = kvm_find_cpuid_entry(vcpu, HYPERV_CPUID_NESTED_FEATURES, 0);
> +	if (entry) {
> +		hv_vcpu->cpuid_cache.nested_eax = entry->eax;
> +		hv_vcpu->cpuid_cache.nested_ebx = entry->ebx;
> +	} else {
> +		hv_vcpu->cpuid_cache.nested_eax = 0;
> +		hv_vcpu->cpuid_cache.nested_ebx = 0;
> +	}
>  }
>  
>  int kvm_hv_set_enforce_cpuid(struct kvm_vcpu *vcpu, bool enforce)


Small Nitpick:

If I understand correctly, the kvm_find_cpuid_entry can fail if the userspace didn't provide the
cpuid entry.

Since the code that deals with failback is now repeated 3 times, how about some wrapper function that
will return all zeros for a non present cpuid entry?

That can be done later of course, so

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

