Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A65357D6F5
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Jul 2022 00:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiGUWfD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Jul 2022 18:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiGUWfB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Jul 2022 18:35:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1AD972C4
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 15:34:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c6so3112944pla.6
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bfbQhsD5vWiW4wKUHofAh5aINPhABCid3Cx9QRVCm70=;
        b=ne1eX39S8Bl+YdHPzgGo/gO1fjwRmLwSdkEokkhoTxo02uNS6I+M4L/eEUltHI/drU
         x6NTkfWnufF5w1LrG7LyjEt178lc9T/dF2IUV9nuFruTT+yTHZsa7AkMQ3B/Iu8MEcov
         Xx3C5gw5Dy56wLYT1SZdhnotPlaWrm0iwAA+CoteTvtcBApiOu2/opQHZMUO3K3dde9p
         nZMykB4L++stfe+qh6fUhGgfQpn3tPydWnZfdJCBiX1gj0Uqt5KQtxBKjtNyQG4aDY/y
         YwY/Cj4H//gV4Dty7i9/tvTGLRDPhd44nNGwta1IsTpaZJjQvm62skf0KV+zpiVJBTqV
         V3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bfbQhsD5vWiW4wKUHofAh5aINPhABCid3Cx9QRVCm70=;
        b=UTF8beH7on5LLMeR2ajOzEpYbP4ycmY1aKyIuNwFMmT3AqY5ElILeXj6FaIEVcuwue
         UxrXudj5ls5oF/lhFfF991YUoiwCzPlbo7Y/m9VkuEDJIZGQepZbTx33Is1LZylH+fAf
         BsKmAIEuaVyPwqo+YygTaOqVIFfq/F0a7vfCTopANBeT2IC6T4wrQXcNApdUeqe9bdDX
         3RulfVfKkZHzGzYFSfTlGWE34PuioAqfF7cvdZIHv/DoMSxKE2pXaztk5fCBhxlD1JRh
         M7kKytEV3I+oIfkKz/OBeX1ER/ILwPWwQf/Oex6wTCdSOchXoXYOL0jNMyoDO0VV+WWR
         lTmA==
X-Gm-Message-State: AJIora9F+rVGVWLUddER4T6f0hZ5+N8iYHbadAtkLscZitWTrTFqCesJ
        3er7g4A7jbUV6a9rAJ6MkeH8DA==
X-Google-Smtp-Source: AGRyM1sBL2i6waxbr9LLBC5yCmsbdFzr+1eGzZj7detwBF4w2XAvVucgDc4UkEitEF9OEOtYogFVhw==
X-Received: by 2002:a17:90a:feb:b0:1f2:6b7:8c2d with SMTP id 98-20020a17090a0feb00b001f206b78c2dmr651153pjz.147.1658442897658;
        Thu, 21 Jul 2022 15:34:57 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902780200b00168dadc7354sm2218124pll.78.2022.07.21.15.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:34:56 -0700 (PDT)
Date:   Thu, 21 Jul 2022 22:34:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/25] KVM: VMX: Add missing VMEXIT controls to
 vmcs_config
Message-ID: <YtnUjRQn22pSCjq2@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-18-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714091327.1085353-18-vkuznets@redhat.com>
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

On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
> As a preparation to reusing the result of setup_vmcs_config() in
> nested VMX MSR setup, add the VMEXIT controls which KVM doesn't
> use but supports for nVMX to KVM_OPT_VMX_VM_EXIT_CONTROLS and
> filter them out in vmx_vmexit_ctrl().
> 
> No functional change intended.
> 
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 4 ++++
>  arch/x86/kvm/vmx/vmx.h | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d7170990f469..2fb89bdcbbd8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4196,6 +4196,10 @@ static u32 vmx_vmexit_ctrl(void)
>  {
>  	u32 vmexit_ctrl = vmcs_config.vmexit_ctrl;
>  
> +	/* Not used by KVM but supported for nesting. */

I think it's worth expanding the comment to clarify that "supported for nesting"
just means allowing them in vmcs12.  Most controls are fully emulated and so are
never set in vmcs02 even when they're turned on by L1.  Something like?

	/*
	 * Not used by KVM and never set in vmcs01 or vmcs02, but emulated for
	 * nested virtualization and thus allowed to be set in vmcs12.
	 */


> +	vmexit_ctrl &= ~(VM_EXIT_SAVE_IA32_PAT | VM_EXIT_SAVE_IA32_EFER |
> +			 VM_EXIT_SAVE_VMX_PREEMPTION_TIMER);
> +
>  	if (vmx_pt_mode_is_system())
>  		vmexit_ctrl &= ~(VM_EXIT_PT_CONCEAL_PIP |
>  				 VM_EXIT_CLEAR_IA32_RTIT_CTL);
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 89eaab3495a6..e9c392398f1b 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -498,8 +498,11 @@ static inline u8 vmx_get_rvi(void)
>  #endif
>  #define KVM_OPT_VMX_VM_EXIT_CONTROLS				\
>  	      (VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |		\
> +	      VM_EXIT_SAVE_IA32_PAT |				\
>  	      VM_EXIT_LOAD_IA32_PAT |				\
> +	      VM_EXIT_SAVE_IA32_EFER |				\
>  	      VM_EXIT_LOAD_IA32_EFER |				\
> +	      VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |		\
>  	      VM_EXIT_CLEAR_BNDCFGS |				\
>  	      VM_EXIT_PT_CONCEAL_PIP |				\
>  	      VM_EXIT_CLEAR_IA32_RTIT_CTL)
> -- 
> 2.35.3
> 
