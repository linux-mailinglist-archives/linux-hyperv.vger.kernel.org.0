Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A675B55C466
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jun 2022 14:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbiF0QG2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Jun 2022 12:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiF0QG2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Jun 2022 12:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CF9EB1CF
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Jun 2022 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656345986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Et0fBT88jZFdIetfnOLa7eYQfFaPq0dKwFkCGFAcX7M=;
        b=NrtvoVi5e71lfXGt+dTQLNCIgNJ5lxN41IaYn+fSMqsFDwyajDWmdbilou9iabauOhvypH
        TMiDDgMulG2F7v6fbXa6HifaIxyrQmXL0+OdstGusDzEkmFClgvTLriQCi1FiZDlvLXuCc
        xtA9pirFcdk0dr8ZJejfmC+gnRqGdlc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-or1z3WDRM-KHkkpJVsdSAg-1; Mon, 27 Jun 2022 12:06:24 -0400
X-MC-Unique: or1z3WDRM-KHkkpJVsdSAg-1
Received: by mail-wm1-f72.google.com with SMTP id e24-20020a05600c219800b003a0471b1904so2539158wme.1
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Jun 2022 09:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Et0fBT88jZFdIetfnOLa7eYQfFaPq0dKwFkCGFAcX7M=;
        b=SNX7T5Rbolwwl9ojZDtAv4pZ3tQ9sJX8M0KIFEAvI5XZufKP3m0iJddNlSzo33Tx+t
         VAVq0mbG7Y014jAwBevCv5/2/CVlEUAwEL4oCuU/gsG0JOWHK6HWC4j30gb8PAtJNyG0
         cKciF8gS+16EzP9Yy7p/Za3rxOaYJzF627rHlNlDJljXKob7Hj6MW0vMOn+kXhVFhfbc
         iVDfePn+r9W2szE+J87KpYmZXRPgsiX3WL3lyjM0MjWFrb0sTkidHdamryi8yGa5gSl6
         jUa9s1u+H+1y8mfv9IOoi89+/zcLPTgKFhaqQ0M3ezIBWeQcbXpvNIFrUmIGMtjaWzKi
         1YqQ==
X-Gm-Message-State: AJIora/1GPjwYk+rVe7sMFkifKBmG/U3uZyq22ktnSOy++B2wDb68M0G
        ZB8En22U322vx9myQDmYCpITixIfzwaDZtMY8F+tdNdg+sCGR2baVtZgirPnyOnp/L0BkfvONAF
        z9vJ6LfYhvwpjySXdAIdWvCs4
X-Received: by 2002:a05:600c:4f08:b0:39c:9437:da06 with SMTP id l8-20020a05600c4f0800b0039c9437da06mr15904992wmq.181.1656345983637;
        Mon, 27 Jun 2022 09:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v+tzLlkmyLWgs6sbrQRofFBaYY7XIFbbta3ZJQIjl0O65OYMJ11jwxkV5OFeVW9JYuXDa+jw==
X-Received: by 2002:a05:600c:4f08:b0:39c:9437:da06 with SMTP id l8-20020a05600c4f0800b0039c9437da06mr15904963wmq.181.1656345983407;
        Mon, 27 Jun 2022 09:06:23 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z22-20020a05600c221600b003a0499df21asm5169981wml.25.2022.06.27.09.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:06:22 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 00/10] KVM: nVMX: Use vmcs_config for setting up
 nested VMX MSRs
In-Reply-To: <YrUF1Zj35BYvXrB6@google.com>
References: <20220622164432.194640-1-vkuznets@redhat.com>
 <YrUF1Zj35BYvXrB6@google.com>
Date:   Mon, 27 Jun 2022 18:06:21 +0200
Message-ID: <87tu86um4i.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 22, 2022, Vitaly Kuznetsov wrote:
>> vmcs_config is a sanitized version of host VMX MSRs where some controls are
>> filtered out (e.g. when Enlightened VMCS is enabled, some know bugs are 
>> discovered, some inconsistencies in controls are detected,...) but
>> nested_vmx_setup_ctls_msrs() uses raw host MSRs instead. This may end up
>> in exposing undesired controls to L1. Switch to using vmcs_config instead.
>> 
>> RFC part: vmcs_config's sanitization now is a mix of "what can't be enabled"
>> and "what KVM doesn't want" and we need to separate these as for nested VMX
>> MSRs only the first category makes sense. This gives vmcs_config a slightly
>> different meaning "controls which can be (theoretically) used". An alternative
>> approach would be to store sanitized host MSRs values separately, sanitize
>> them and and use in nested_vmx_setup_ctls_msrs() but currently I don't see
>> any benefits. Comments welcome!
>
> I like the idea overall, even though it's a decent amount of churn.  It seems
> easier to maintain than separate paths for nested.  The alternative would be to
> add common helpers to adjust the baseline configurations, but I don't see any
> way to programmatically make that approach more robust.
>
> An idea to further harden things.  Or: an excuse to extend macro shenanigans :-)
>
> If we throw all of the "opt" and "min" lists into macros, e.g. KVM_REQUIRED_*
> and KVM_OPTIONAL_*, and then use those to define a KVM_KNOWN_* field, we can
> prevent using the mutators to set/clear unknown bits at runtime via BUILD_BUG_ON().
> The core builders, e.g. vmx_exec_control(), can still set unknown bits, i.e. set
> bits that aren't enumerated to L1, but that's easier to audit and this would catch
> regressions for the issues fixed in patches.
>
> It'll required making add_atomic_switch_msr_special() __always_inline (or just
> open code it), but that's not a big deal.
>
> E.g. if we have
>
>   #define KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL <blah blah blah>
>   #define KVM_OPTIONAL_CPU_BASED_VM_EXEC_CONTROL <blah blah blah>
>
> Then the builders for the controls shadows can do:
>
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 286c88e285ea..5eb75822a09e 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -468,6 +468,8 @@ static inline u8 vmx_get_rvi(void)
>  }
>  
>  #define BUILD_CONTROLS_SHADOW(lname, uname, bits)                              \
> +#define KVM_KNOWN_ ## uname                                                    \
> +       (KVM_REQUIRED_ ## uname | KVM_OPTIONAL_ ## uname)                       \

I'm certainly not a macro jedi and I failed to make this compile as gcc
hates when I put '#define's in macros but I made a simpler version with
(presumeably) the same outcome. v1 is out, thanks for the suggestion!

>  static inline void lname##_controls_set(struct vcpu_vmx *vmx, u##bits val)     \
>  {                                                                              \
>         if (vmx->loaded_vmcs->controls_shadow.lname != val) {                   \
> @@ -485,10 +487,12 @@ static inline u##bits lname##_controls_get(struct vcpu_vmx *vmx)          \
>  }                                                                              \
>  static inline void lname##_controls_setbit(struct vcpu_vmx *vmx, u##bits val)  \
>  {                                                                              \
> +       BUILD_BUG_ON(!(val & KVM_KNOWN_ ## uname));                             \
>         lname##_controls_set(vmx, lname##_controls_get(vmx) | val);             \
>  }                                                                              \
>  static inline void lname##_controls_clearbit(struct vcpu_vmx *vmx, u##bits val)        \
>  {                                                                              \
> +       BUILD_BUG_ON(!(val & KVM_KNOWN_ ## uname));                             \
>         lname##_controls_set(vmx, lname##_controls_get(vmx) & ~val);            \
>  }
>  BUILD_CONTROLS_SHADOW(vm_entry, VM_ENTRY_CONTROLS, 32)
>
>
>
> Handling the controls that are restricted to CONFIG_X86_64=y will be midly annoying,
> but adding a base set isn't too bad, e.g.
>
> #define __KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL <blah blah blah>
> #ifdef CONFIG_X86_64
> #define KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL (__KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL | \
> 						CPU_BASED_CR8_LOAD_EXITING |		   \
> 						CPU_BASED_CR8_STORE_EXITING)
> #else
> #define KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL __KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL
> #endif
>

-- 
Vitaly

