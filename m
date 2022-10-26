Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C7860EC46
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Oct 2022 01:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiJZXUw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Oct 2022 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiJZXUX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Oct 2022 19:20:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1ABB7F5A
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Oct 2022 16:18:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m2so11600656pjr.3
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Oct 2022 16:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DykrjrmepSXhAB59KHROk5+j8jll4Zt4dqxIX0w+lNU=;
        b=cWXI5Js33TTPrnksxPdTs73nn/8fEQFHd/tYfvNWJmB7nDn8rm9WPYpIT4Ea6hjg7/
         qahAgLtxOLkBB1nRbTbW9nbSbMTOe8WoMcRqMtFVmPkF6h4iSO8JnWMgk5T9B4ASFeMm
         4ZZcBNuZImY6Po2pbhaAKTjWlfAj/8SOmDp4MldvoMmgEPFxT3MLjevXZpS8XtgfjL+L
         p/jns5DZoWXm85vo40XjBkOqAOrfuT6SN5HCaFqGiFjK0LgdcxjbrP3lyiJDHbiRXSUp
         EHQNLk3M+H78toM4aHiTAI1xWa5GWCU1OHJLPw9gOQNGckV12p5q28qYPRo4bcGJp2hf
         W7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DykrjrmepSXhAB59KHROk5+j8jll4Zt4dqxIX0w+lNU=;
        b=MzbSlT/xXOKVVbd3zENmRCoxJi6sThQJiMdEKimOV5LpVJIeUfVj1MxM1RBLZwLLGt
         hasYgUQ7rzuHf/qkD110YaS4vqYanYQ3pTLwqzGiaD7sVw0o/70Db9yRhtHEKV2J1Idl
         zwsqrfCFh/T+q3CrqIA+Iqm7v3tJJVXAEqhbPY/uru3rNJnPQvvRyRkyGaRpYUNXGPHO
         yZ9sfyGGSCaUlCdvtgH72SrDq0xR4nQojStlgvx+4lNWmUQ1Yhq6M2VhIUUbZPStu8+u
         nsxqYFTjp/+eVlMlL6CPIFTFc7CQg1Y6BWueOmTl8wvPTh936g0eAzhWyTv/MiQlPP+k
         ywpQ==
X-Gm-Message-State: ACrzQf2oMpfnd9Gf4XB/B9j3CsfHtrzpUSd4v/txdtz/ZTB46LpC2Y4f
        u43gEo55TcfeuAJ8I0W9L8uLMw==
X-Google-Smtp-Source: AMsMyM55+OpD/5Oo/efaqoQ+RrWpuDXwQTrweNyAB2M78j1sIsaZfV87x6GrK1UjHyii70dCTq/O8A==
X-Received: by 2002:a17:90a:ad05:b0:212:c550:f0e9 with SMTP id r5-20020a17090aad0500b00212c550f0e9mr6932379pjq.246.1666826321864;
        Wed, 26 Oct 2022 16:18:41 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f35-20020a17090a702600b0020087d7e778sm1561918pjk.37.2022.10.26.16.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 16:18:41 -0700 (PDT)
Date:   Wed, 26 Oct 2022 23:18:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: nVMX: Invert 'unsupported by eVMCSv1' check
Message-ID: <Y1nAThjeMlMFFrAi@google.com>
References: <20221018101000.934413-1-vkuznets@redhat.com>
 <20221018101000.934413-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018101000.934413-3-vkuznets@redhat.com>
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

On Tue, Oct 18, 2022, Vitaly Kuznetsov wrote:
> When a new feature gets implemented in KVM, EVMCS1_UNSUPPORTED_* defines
> need to be adjusted to avoid the situation when the feature is exposed
> to the guest but there's no corresponding eVMCS field[s] for it. This
> is not obvious and fragile.

Eh, either way is fragile, the only difference is what goes wrong when it breaks.

At the risk of making this overly verbose, what about requiring developers to
explicitly define whether or not a new control is support?  E.g. keep the
EVMCS1_UNSUPPORTED_* and then add compile-time assertions to verify that every
feature that is REQUIRED | OPTIONAL is SUPPORTED | UNSUPPORTED.

That way the eVMCS "supported" controls don't need to include the ALWAYSON
controls, and anytime someone adds a new control, they'll have to stop and think
about eVMCS.

I think we'll still want (need?) the runtime sanitization, but this might allow
catching at least some cases without needing to wait until a control actually gets
exposed.

E.g. possibly with more macro magic to reduce the boilerplate

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index d8b23c96d627..190932edcc02 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -422,6 +422,10 @@ void nested_evmcs_filter_control_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *
        u32 ctl_high = (u32)(*pdata >> 32);
        u32 unsupported_ctrls;
 
+       BUILD_BUG_ON((EVMCS1_SUPPORTED_PINCTRL | EVMCS1_UNSUPPORTED_PINCTRL) !=
+                    (KVM_REQUIRED_VMX_PIN_BASED_VM_EXEC_CONTROL |
+                     KVM_OPTIONAL_VMX_PIN_BASED_VM_EXEC_CONTROL));
+
        /*
         * Hyper-V 2016 and 2019 try using these features even when eVMCS
         * is enabled but there are no corresponding fields.
diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
index 6f746ef3c038..58d77afe9d57 100644
--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -48,6 +48,11 @@ DECLARE_STATIC_KEY_FALSE(enable_evmcs);
  */
 #define EVMCS1_UNSUPPORTED_PINCTRL (PIN_BASED_POSTED_INTR | \
                                    PIN_BASED_VMX_PREEMPTION_TIMER)
+#define EVMCS1_SUPPORTED_PINCTRL                                       \
+       (PIN_BASED_EXT_INTR_MASK |                                      \
+        PIN_BASED_NMI_EXITING |                                        \
+        PIN_BASED_VIRTUAL_NMIS)
+
 #define EVMCS1_UNSUPPORTED_EXEC_CTRL (CPU_BASED_ACTIVATE_TERTIARY_CONTROLS)
 #define EVMCS1_UNSUPPORTED_2NDEXEC                                     \
        (SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |                         \
