Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29106571923
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 13:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiGLLzN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 07:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiGLLyo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 07:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06F3065F8
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657626880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dBB+ggTvG8bgWymIqeqLY8MHAoWQRWK8mCj36wPOc5Q=;
        b=S5IzjSrZK2rweLo0Jb/MaoS7zhR6Bk5YfAvmFnzcil0a+0Q4dafIxWtnkdHSfr3h4jGCST
        PMRNK/M8OKMtgq8pVRC3VOBZZQtJfIcCbRhVdPbKBGpJw9UwWJg5ZVO7eeCDAX/lGZrxgk
        /cLVe5ypD+m/8+BPWo2YVE//6I7UHus=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-v2qdTY8DM0e4UL0-JXT78Q-1; Tue, 12 Jul 2022 07:54:39 -0400
X-MC-Unique: v2qdTY8DM0e4UL0-JXT78Q-1
Received: by mail-qk1-f200.google.com with SMTP id de4-20020a05620a370400b006a9711bd9f8so7553973qkb.9
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 04:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dBB+ggTvG8bgWymIqeqLY8MHAoWQRWK8mCj36wPOc5Q=;
        b=3WL2eLenXV+1ezGViH98i5xnb8E5traDjxssHn/Hwx8G5Gqd+gszXHdpGna+9EIZgL
         GpX3sxQUtn1yoH44D29Bs6iExbgP6cnYw4COd1pQss0k7vXXqmuLIeo+88M1B3+/cR+A
         Fk1nQrT6BcoEw5BgHyihMQRi8AyMUz71PbV8F9eCHzbw8CjvwwmWRC2clZLoEpyPMYTg
         3Vj70EYCwt44sHPVMTjTMmcTImJ1KugKYqbYIIZwlnWhv8NuleC0WuipMrchCc1yr+gG
         0HJ6JRoMU2Oemc2QZ16GzjK8btiiFlEGI8IoYY0mY6l5jk0hyZFVGeJVXZftSUrFxV9n
         l8jQ==
X-Gm-Message-State: AJIora8cNfB9A5uHWLwxYNu2WTGmGgWMLMJy4Q0truvVz9io/hosDrOz
        MN293W3ZtXwKD4IAJ4Kbt0nejJDUpVTSnfkh8jhej8LNoK+L4C+rGn851kubqgDnlBlckQJgOMD
        FMa0H3wPKuRnGP0S/c6DCQc/+
X-Received: by 2002:ac8:5d49:0:b0:31e:b4ca:d7a1 with SMTP id g9-20020ac85d49000000b0031eb4cad7a1mr7963203qtx.183.1657626878495;
        Tue, 12 Jul 2022 04:54:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uy+F/s1E/ZaMXoJvWX9h7t+5AW9zAkUqz0BI9C066QS/bt2M1+1+lYEM8i39vLh6pXsFtAtA==
X-Received: by 2002:ac8:5d49:0:b0:31e:b4ca:d7a1 with SMTP id g9-20020ac85d49000000b0031eb4cad7a1mr7963188qtx.183.1657626878309;
        Tue, 12 Jul 2022 04:54:38 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id dt8-20020a05620a478800b006a91da2fc8dsm6242414qkb.0.2022.07.12.04.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:54:37 -0700 (PDT)
Message-ID: <f1d030d7db4aaf3075fe625799b99ae335fc9f60.camel@redhat.com>
Subject: Re: [PATCH v3 11/25] KVM: VMX: Get rid of eVMCS specific VMX
 controls sanitization
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:54:34 +0300
In-Reply-To: <20220708144223.610080-12-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-12-vkuznets@redhat.com>
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

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> With the updated eVMCSv1 definition, there's no known 'problematic'
> controls which are exposed in VMX control MSRs but are not present in
> eVMCSv1. Get rid of VMX control MSRs filtering for KVM on Hyper-V.

If I understand correctly we are taking about running KVM as a nested guest of Hyper-V here:

Don't we need to check the new CPUID bit and only then use the new fields of eVMCS,
aka check that the 'cpu' supports the updated eVMCS version?

Best regards,
	Maxim Levitsky



> 
> Note: VMX control MSRs filtering for Hyper-V on KVM
> (nested_evmcs_filter_control_msr()) stays as even the updated eVMCSv1
> definition doesn't have all the features implemented by KVM and some
> fields are still missing. Moreover, nested_evmcs_filter_control_msr()
> has to support the original eVMCSv1 version when VMM wishes so.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/evmcs.c | 13 -------------
>  arch/x86/kvm/vmx/evmcs.h |  1 -
>  arch/x86/kvm/vmx/vmx.c   |  5 -----
>  3 files changed, 19 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
> index 52a53debd806..b5cfbf7d487b 100644
> --- a/arch/x86/kvm/vmx/evmcs.c
> +++ b/arch/x86/kvm/vmx/evmcs.c
> @@ -320,19 +320,6 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
>  };
>  const unsigned int nr_evmcs_1_fields = ARRAY_SIZE(vmcs_field_to_evmcs_1);
>  
> -#if IS_ENABLED(CONFIG_HYPERV)
> -__init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf)
> -{
> -       vmcs_conf->cpu_based_exec_ctrl &= ~EVMCS1_UNSUPPORTED_EXEC_CTRL;
> -       vmcs_conf->pin_based_exec_ctrl &= ~EVMCS1_UNSUPPORTED_PINCTRL;
> -       vmcs_conf->cpu_based_2nd_exec_ctrl &= ~EVMCS1_UNSUPPORTED_2NDEXEC;
> -       vmcs_conf->cpu_based_3rd_exec_ctrl = 0;
> -
> -       vmcs_conf->vmexit_ctrl &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
> -       vmcs_conf->vmentry_ctrl &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
> -}
> -#endif
> -
>  bool nested_enlightened_vmentry(struct kvm_vcpu *vcpu, u64 *evmcs_gpa)
>  {
>         struct hv_vp_assist_page assist_page;
> diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
> index 4b809c79ae63..0feac101cce4 100644
> --- a/arch/x86/kvm/vmx/evmcs.h
> +++ b/arch/x86/kvm/vmx/evmcs.h
> @@ -203,7 +203,6 @@ static inline void evmcs_load(u64 phys_addr)
>         vp_ap->enlighten_vmentry = 1;
>  }
>  
> -__init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf);
>  #else /* !IS_ENABLED(CONFIG_HYPERV) */
>  static __always_inline void evmcs_write64(unsigned long field, u64 value) {}
>  static inline void evmcs_write32(unsigned long field, u32 value) {}
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b4915d841357..dd905ad72637 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2689,11 +2689,6 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>         vmcs_conf->vmexit_ctrl         = _vmexit_control;
>         vmcs_conf->vmentry_ctrl        = _vmentry_control;
>  
> -#if IS_ENABLED(CONFIG_HYPERV)
> -       if (enlightened_vmcs)
> -               evmcs_sanitize_exec_ctrls(vmcs_conf);
> -#endif
> -
>         return 0;
>  }
>  


