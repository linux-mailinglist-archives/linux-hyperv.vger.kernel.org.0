Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1508357D66E
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Jul 2022 00:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiGUWCA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Jul 2022 18:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiGUWBz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Jul 2022 18:01:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4788951C9
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 15:01:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pc13so2787325pjb.4
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qAhQVrDK7MeMMYS/5qRomq3MD/hkNWCuehhNsXzbgQo=;
        b=ZUo+pcqX+m03XBo3VIe2oP3PC5Yx9q6t+LNJ3nlkwp9cqqkDCGsDdFnpYDoIc48AYP
         RqkkWjbXOmdrfftYpEd8+wnFzpskv5xukjy3rWWQvMDxqEuCnvySwhdHqbtma88iwLjK
         3SpNhA0R8aOYCLwNirkO/K0i85tmOH00nJH7kQKc6U6hF9AyKDdlt6E+TQNrDKZSqA3T
         pn8VC9dGIEUcmFuLRq/zQk0bjFViQjK+g5BAKG26MQ61J1OjA0I3ITrAArqXHcNcYWBS
         UrRijBoHciAj9Rvs0YD8MZL+qGxFhu5rlOCT9X796TU392MsF8HmqNnL6jkoeEJGoJZ6
         bbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qAhQVrDK7MeMMYS/5qRomq3MD/hkNWCuehhNsXzbgQo=;
        b=ErqsbU4eg96b9C0LaLgwsy0sLC+YmsVbz8g9+UkopwqxA0DJYDSuF4P6jEOQrV5HLI
         7YAzVTU/5bHNai+58o8RwM4njj5NtWczGSIZTPOLX1uA1mKoFdSqzoMzEX65sqDWGSaH
         UPFkX/sJZcgZF36V+MWL/djUZ24lDHLV8Fsn9jrZ3bushRJz/Nr9B+mZVUJcAjVfJ8Xg
         db0GZjNLlsUDCKMBwCwVbzSlPcF+NYoD6dxIHlpZtoLp6e6jS/uxF6d33Wbws4vlwsth
         Tc4zVs3AsF39rJC44w88HdXpvKaL4oyei9kg7iMhe7z4AE0hNQhCG66KgpH8i3DRJJ2v
         MHeQ==
X-Gm-Message-State: AJIora8arOsCdtiSuQEZD9H+5WiMsinMV71/5jeAl92Svs5h/jViPgxx
        P23Tr5SpBzXbkPhyOgvzcpwn6Q==
X-Google-Smtp-Source: AGRyM1slz+g1gHw3leOJLSaj8QCnE6xdOjrsgDKLP6wzNYPrBWcAXvMsb77K+qY8XFirPvNkvHSmmw==
X-Received: by 2002:a17:902:708a:b0:16d:b34:ed6 with SMTP id z10-20020a170902708a00b0016d0b340ed6mr530303plk.162.1658440913077;
        Thu, 21 Jul 2022 15:01:53 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709027e8200b0016b8b35d725sm2212061pla.95.2022.07.21.15.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:01:52 -0700 (PDT)
Date:   Thu, 21 Jul 2022 22:01:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/25] KVM: VMX: Check
 CPU_BASED_{INTR,NMI}_WINDOW_EXITING in setup_vmcs_config()
Message-ID: <YtnMzYztYVtRVV1B@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-14-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714091327.1085353-14-vkuznets@redhat.com>
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
> CPU_BASED_{INTR,NMI}_WINDOW_EXITING controls are toggled dynamically by
> vmx_enable_{irq,nmi}_window, handle_interrupt_window(), handle_nmi_window()
> but setup_vmcs_config() doesn't check their existence. Add the check and
> filter the controls out in vmx_exec_control().
> 
> Note: KVM explicitly supports CPUs without VIRTUAL_NMIS and all these CPUs
> are supposedly lacking NMI_WINDOW_EXITING too. Adjust cpu_has_virtual_nmis()
> accordingly.
> 
> No functional change intended.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Nit aside,

Reviewed-by: Sean Christopherson <seanjc@google.com>

>  arch/x86/kvm/vmx/capabilities.h | 3 ++-
>  arch/x86/kvm/vmx/vmx.c          | 8 +++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
> index 069d8d298e1d..07e7492fe72a 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -82,7 +82,8 @@ static inline bool cpu_has_vmx_basic_inout(void)
>  
>  static inline bool cpu_has_virtual_nmis(void)
>  {
> -	return vmcs_config.pin_based_exec_ctrl & PIN_BASED_VIRTUAL_NMIS;
> +	return vmcs_config.pin_based_exec_ctrl & PIN_BASED_VIRTUAL_NMIS &&
> +		vmcs_config.cpu_based_exec_ctrl & CPU_BASED_NMI_WINDOW_EXITING;

I prefer to align these, though Paolo always scoffs at me :-)


static inline bool cpu_has_virtual_nmis(void)
{
	return vmcs_config.pin_based_exec_ctrl & PIN_BASED_VIRTUAL_NMIS &&
	       vmcs_config.cpu_based_exec_ctrl & CPU_BASED_NMI_WINDOW_EXITING;
}

>  }
>  
>  static inline bool cpu_has_vmx_preemption_timer(void)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 1aaec4d19e1b..ce54f13d8da1 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2487,10 +2487,12 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  	      CPU_BASED_MWAIT_EXITING |
>  	      CPU_BASED_MONITOR_EXITING |
>  	      CPU_BASED_INVLPG_EXITING |
> -	      CPU_BASED_RDPMC_EXITING;
> +	      CPU_BASED_RDPMC_EXITING |
> +	      CPU_BASED_INTR_WINDOW_EXITING;
>  
>  	opt = CPU_BASED_TPR_SHADOW |
>  	      CPU_BASED_USE_MSR_BITMAPS |
> +	      CPU_BASED_NMI_WINDOW_EXITING |
>  	      CPU_BASED_ACTIVATE_SECONDARY_CONTROLS |
>  	      CPU_BASED_ACTIVATE_TERTIARY_CONTROLS;
>  	if (adjust_vmx_controls(min, opt, MSR_IA32_VMX_PROCBASED_CTLS,
> @@ -4299,6 +4301,10 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
>  {
>  	u32 exec_control = vmcs_config.cpu_based_exec_ctrl;
>  
> +	/* INTR_WINDOW_EXITING and NMI_WINDOW_EXITING are toggled dynamically */
> +	exec_control &= ~(CPU_BASED_INTR_WINDOW_EXITING |
> +			  CPU_BASED_NMI_WINDOW_EXITING);
> +
>  	if (vmx->vcpu.arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)
>  		exec_control &= ~CPU_BASED_MOV_DR_EXITING;
>  
> -- 
> 2.35.3
> 
