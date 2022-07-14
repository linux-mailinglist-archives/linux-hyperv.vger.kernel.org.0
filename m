Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA94574A15
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Jul 2022 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbiGNKFH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 14 Jul 2022 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbiGNKFF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Jul 2022 06:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B90BEE27
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Jul 2022 03:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657793103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZukeJfWxGjsKWF/4S6GKDIHJ91TQp/gFtK06z9SPK0=;
        b=FTfWz+VH6o9Cznzg05eyYCLDqZYc4Dqvy05+FXLndyZGMShAbZtRljKTYHeJWqzMwfFNON
        f5KFbkDZoI+nUVAMi/E/GXleTiZt48SNegv7c0nHBaaaCCCuIEM9gBiCqAcjr+qNu6y9AE
        7W5esVOnbIKijWCblB3Or6eMqfuIZq8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-Rc776RXvOqKJC6rinR5WCg-1; Thu, 14 Jul 2022 06:05:02 -0400
X-MC-Unique: Rc776RXvOqKJC6rinR5WCg-1
Received: by mail-wm1-f72.google.com with SMTP id h65-20020a1c2144000000b003a2cf5b5aabso2411936wmh.8
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Jul 2022 03:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pZukeJfWxGjsKWF/4S6GKDIHJ91TQp/gFtK06z9SPK0=;
        b=7wax5ig56Nouofqbj461GLIBHupdpcTXeebxHNwTewJUHfi7ZJSQcmfgHBU5ButteB
         oSupVt0XilJxk8X4AshffC0C7nfnyG8uvF4LCBCE7lXI4cr5tjJLccZWlHQWwR2RYXm5
         bCa3OuqBi78ReMNwWUrHmHwR2IwI1ksqXFlJaDXbaXB8TgwQTWRpXp2YIMCmKMczBqaE
         mzfbBGPzyXhli9lADIDNptO9Gg1LA8txZr0AHcOqjKsZImQ4ap2raanTJ4LMOIkduN2q
         W/eR3fF1OpyxHV+AvR4iC703D3YZw76wvDYZXC20eLH9ivuYPR2bUxklEdKri5HjBi1B
         tlQA==
X-Gm-Message-State: AJIora9ET2bg13oyhBQphyxyXYXSOfI1r08UPZeFID5H8mKMXQWeS0+D
        eW69aBGlPxSCcPO8n3EtYwDvZ4oQQUiUsVNJV5R973A8EEL6MKN8YC9fYzDUEZZVxbp0VwRtM/S
        J05OORX7g0ydq2bxgYXGZotcH
X-Received: by 2002:a05:600c:4e01:b0:3a3:342:5f55 with SMTP id b1-20020a05600c4e0100b003a303425f55mr1167442wmq.150.1657793100879;
        Thu, 14 Jul 2022 03:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uaYKOw/xVQD+N7QimS7BnLIZAWrepCTmCCq9vI5Z98RdXmLv8WjKO4avlhaezsUHQyS4iMjA==
X-Received: by 2002:a05:600c:4e01:b0:3a3:342:5f55 with SMTP id b1-20020a05600c4e0100b003a303425f55mr1167417wmq.150.1657793100658;
        Thu, 14 Jul 2022 03:05:00 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600c355000b003a2f88b2559sm4687381wmq.44.2022.07.14.03.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:05:00 -0700 (PDT)
Message-ID: <f098f8965176dfe5c65a4faf6769283c14c484a7.camel@redhat.com>
Subject: Re: [PATCH v4 11/25] KVM: VMX: Get rid of eVMCS specific VMX
 controls sanitization
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Jul 2022 13:04:58 +0300
In-Reply-To: <20220714091327.1085353-12-vkuznets@redhat.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
         <20220714091327.1085353-12-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 2022-07-14 at 11:13 +0200, Vitaly Kuznetsov wrote:
> With the updated eVMCSv1 definition, there's no known 'problematic'
> controls which are exposed in VMX control MSRs but are not present in
> eVMCSv1. Get rid of VMX control MSRs filtering for KVM on Hyper-V.

I think it still might be worth it, mentioning at least in the commit message,
that as you said, the all known HyperV versions, either don't expose the 
new fields by not setting bits in the VMX feature controls, 
or support the new eVMCS revision.

But anyway:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

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


