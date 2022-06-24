Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D701558C46
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Jun 2022 02:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiFXAbX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jun 2022 20:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFXAbX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jun 2022 20:31:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD985DC22
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Jun 2022 17:31:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q18so649239pld.13
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Jun 2022 17:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IOiiEzf2Owa8eEtkAWHI6gKx/+L0ogxrj4UywWa0Fvs=;
        b=ZyMkz1B9QFJcuQz/QRPOneAkqYcC+jOpJBpbASB5peQZufT5/r5En2t3mYwdPkd3Lr
         a2ftkjaXiXS4qkOmZ11BBMR5ZtHpcbFG8ikAcILytdEJ1oY/ONBcq0rGRUG5rl9k/1wp
         rlCBJ2fLTN0Eh47nwHLen44taBjN741iYlvffjTKsd4+RawpXhvy55otTUQCobZjc+F4
         8fJIMNnNLTMVBOIi/j3RsAMXyVmOLsjH4dnQ6uqt411oEOyrA/1nkxh5bg0LZ8uJzbiJ
         CXp0WKHGuKk/ENCY4UIH50SiJJ27697p8b3DBegKh5E4YxR/zJkeed3FjUWjWo/17q9M
         hyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IOiiEzf2Owa8eEtkAWHI6gKx/+L0ogxrj4UywWa0Fvs=;
        b=sNVjIduAPC0s4OCrJ7MDYLMeXb1ntQAuRUS+xdhVwCvuCWhvASDaQ84NGUMXReWgFr
         0U+SkthzXBpljRLRwUJR66FR6nvydmAXamgDpKgD9Ot5UhgwO9Yv8Slj+xJIZllYLZ2s
         yGsTCrbTSZhy5rErcspnyPPkknmhGiPK8UpGqC4rkDVS5dMy3CPvZJ80EkEogo5nFlFG
         xzMPZhfDgu30x4AINgErRYqo8Zkxjngd/iQFG6yBXxvsnIEpfUOF0OKNYGj+E/Ll9S/n
         IDNbCyOtOfVnN/g4mvs208UFr7SPBr/gshxRuW/RrE4wUdlviwGygHnQGdGsBO4zMcNn
         tpmA==
X-Gm-Message-State: AJIora9E2lamkqg+Eutl97I0vTgrMmp0mdtElCTWl6jRZoT1W8w7vygb
        Lc+R/NtF1UrmUHAyhOqhphHjlA==
X-Google-Smtp-Source: AGRyM1vcGIva17Yiz9xNolPeazjHi8DWAZr4gphlJGqm2XezqABG60RkTIfMAjrt7dBawSc3HCB4pg==
X-Received: by 2002:a17:90b:1d90:b0:1e8:5a98:d591 with SMTP id pf16-20020a17090b1d9000b001e85a98d591mr712610pjb.126.1656030680952;
        Thu, 23 Jun 2022 17:31:20 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a1f4100b001ec9f9fe028sm2536065pjy.46.2022.06.23.17.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 17:31:20 -0700 (PDT)
Date:   Fri, 24 Jun 2022 00:31:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 00/10] KVM: nVMX: Use vmcs_config for setting up
 nested VMX MSRs
Message-ID: <YrUF1Zj35BYvXrB6@google.com>
References: <20220622164432.194640-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622164432.194640-1-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 22, 2022, Vitaly Kuznetsov wrote:
> vmcs_config is a sanitized version of host VMX MSRs where some controls are
> filtered out (e.g. when Enlightened VMCS is enabled, some know bugs are 
> discovered, some inconsistencies in controls are detected,...) but
> nested_vmx_setup_ctls_msrs() uses raw host MSRs instead. This may end up
> in exposing undesired controls to L1. Switch to using vmcs_config instead.
> 
> RFC part: vmcs_config's sanitization now is a mix of "what can't be enabled"
> and "what KVM doesn't want" and we need to separate these as for nested VMX
> MSRs only the first category makes sense. This gives vmcs_config a slightly
> different meaning "controls which can be (theoretically) used". An alternative
> approach would be to store sanitized host MSRs values separately, sanitize
> them and and use in nested_vmx_setup_ctls_msrs() but currently I don't see
> any benefits. Comments welcome!

I like the idea overall, even though it's a decent amount of churn.  It seems
easier to maintain than separate paths for nested.  The alternative would be to
add common helpers to adjust the baseline configurations, but I don't see any
way to programmatically make that approach more robust.

An idea to further harden things.  Or: an excuse to extend macro shenanigans :-)

If we throw all of the "opt" and "min" lists into macros, e.g. KVM_REQUIRED_*
and KVM_OPTIONAL_*, and then use those to define a KVM_KNOWN_* field, we can
prevent using the mutators to set/clear unknown bits at runtime via BUILD_BUG_ON().
The core builders, e.g. vmx_exec_control(), can still set unknown bits, i.e. set
bits that aren't enumerated to L1, but that's easier to audit and this would catch
regressions for the issues fixed in patches.

It'll required making add_atomic_switch_msr_special() __always_inline (or just
open code it), but that's not a big deal.

E.g. if we have

  #define KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL <blah blah blah>
  #define KVM_OPTIONAL_CPU_BASED_VM_EXEC_CONTROL <blah blah blah>

Then the builders for the controls shadows can do:

diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 286c88e285ea..5eb75822a09e 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -468,6 +468,8 @@ static inline u8 vmx_get_rvi(void)
 }
 
 #define BUILD_CONTROLS_SHADOW(lname, uname, bits)                              \
+#define KVM_KNOWN_ ## uname                                                    \
+       (KVM_REQUIRED_ ## uname | KVM_OPTIONAL_ ## uname)                       \
 static inline void lname##_controls_set(struct vcpu_vmx *vmx, u##bits val)     \
 {                                                                              \
        if (vmx->loaded_vmcs->controls_shadow.lname != val) {                   \
@@ -485,10 +487,12 @@ static inline u##bits lname##_controls_get(struct vcpu_vmx *vmx)          \
 }                                                                              \
 static inline void lname##_controls_setbit(struct vcpu_vmx *vmx, u##bits val)  \
 {                                                                              \
+       BUILD_BUG_ON(!(val & KVM_KNOWN_ ## uname));                             \
        lname##_controls_set(vmx, lname##_controls_get(vmx) | val);             \
 }                                                                              \
 static inline void lname##_controls_clearbit(struct vcpu_vmx *vmx, u##bits val)        \
 {                                                                              \
+       BUILD_BUG_ON(!(val & KVM_KNOWN_ ## uname));                             \
        lname##_controls_set(vmx, lname##_controls_get(vmx) & ~val);            \
 }
 BUILD_CONTROLS_SHADOW(vm_entry, VM_ENTRY_CONTROLS, 32)



Handling the controls that are restricted to CONFIG_X86_64=y will be midly annoying,
but adding a base set isn't too bad, e.g.

#define __KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL <blah blah blah>
#ifdef CONFIG_X86_64
#define KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL (__KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL | \
						CPU_BASED_CR8_LOAD_EXITING |		   \
						CPU_BASED_CR8_STORE_EXITING)
#else
#define KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL __KVM_REQUIRED_CPU_BASED_VM_EXEC_CONTROL
#endif
