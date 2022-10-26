Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5662F60ECA9
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Oct 2022 01:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiJZXeU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Oct 2022 19:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiJZXeT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Oct 2022 19:34:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679F982870
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Oct 2022 16:34:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so4429701pjc.3
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Oct 2022 16:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHqryD6cMC+3zqeZeO7lYyd2QloacqtkfBr0fI6grmc=;
        b=nQ41viT2g0De13xPdgk5ju/55UrOhJOrOAd09W0a1kjOrMdzj8A5pN+IICti6BBJ6l
         068JN8gtfBWCAmxyeCM51MA01qbeun/Ztk93SsGFes0MiOKKqeOssnM1gVJ5eSVKWOuD
         WoPRXyIiYcRXfoz7dOTG6oIhj6kkUVVHVeIDHtqD5aQ9PzVByz40aBo9JeGGVVlFEgXV
         BoBJRkdNJbkkaWme/TyELBSk7uiH8ldd5zHn5R3ni+CLfnjp1JA5tnWyEXzUMwjRe362
         0zPowfJGW1i5hDjdNFyO/VmGDpfrhZbd/HkqodM+ZCHg0SfC4EJ3Emkt2T0/sdtI9sNA
         sNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHqryD6cMC+3zqeZeO7lYyd2QloacqtkfBr0fI6grmc=;
        b=Vksr9biaZdZfj1frgoZTshoFpjmNb43j1TxrN4bs/cDiUQX3MUeHgSxAmeekmyqN+5
         zG+Il++bjOmVpa5NddfDLBD3hlitfen9K+ZxTWffJQzCFhq2/IiEvudEtNqI4H1YUGqv
         RRvg6OzDtSKFVCcdAPZU7rk878pCxOh7iYhLP6pOVsRb+zpbnBt/85YAPd+3+2igeEHw
         0zLMUs8o1lnf1ck51FrdvQ44La4CS9/OsorBUtDoqxHWB3ZVWQT6hmahNYvPTy3u9bwy
         Zmp1z63HaRRrU0+Tt60BQ5NUFCEHd8tdJCmkU2TprXepIy6neZG2eWYBTexCv2N9q4Tr
         xizQ==
X-Gm-Message-State: ACrzQf38PORoQAFpDiWy0TuM5YdHVTT2WV4lU5s5frc3jtZX2w/yVSzw
        wyRhGIBjyQykBjDrsKt7WinpDw==
X-Google-Smtp-Source: AMsMyM6A4viqn0P2RzahNA3q4fXm/zmHo+qmtwMHPSonDJgHT8CbzIAdvPy/G8rEklSHnDhCaAcJ3A==
X-Received: by 2002:a17:902:f78b:b0:17f:9c94:b247 with SMTP id q11-20020a170902f78b00b0017f9c94b247mr44871459pln.137.1666827256789;
        Wed, 26 Oct 2022 16:34:16 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x15-20020a1709027c0f00b00186748fe6ccsm3405981pll.214.2022.10.26.16.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 16:34:16 -0700 (PDT)
Date:   Wed, 26 Oct 2022 23:34:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: VMX: Resurrect vmcs_conf sanitization for
 KVM-on-Hyper-V
Message-ID: <Y1nD9QKqa1A1j7t+@google.com>
References: <20221018101000.934413-1-vkuznets@redhat.com>
 <20221018101000.934413-5-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018101000.934413-5-vkuznets@redhat.com>
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
> @@ -362,6 +364,7 @@ uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu)
>  
>  enum evmcs_revision {
>  	EVMCSv1_LEGACY,
> +	EVMCSv1_STRICT,

"strict" isn't really the right word, this is more like "raw" or "unfiltered",
because unless I'm misunderstanding the intent, this will always track KVM's
bleeding edge, i.e. everything that KVM can possibly enable.

And in that case, we can avoid bikeshedding the name becase bouncing through
evmcs_supported_ctrls is unnecessary, just use the #defines directly.  And then
you can just fold the one (or two) #defines from patch 3 into this path.

> @@ -511,6 +525,52 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
> +/*
> + * KVM on Hyper-V always uses the newest known eVMCSv1 revision, the assumption
> + * is: in case a feature has corresponding fields in eVMCS described and it was
> + * exposed in VMX feature MSRs, KVM is free to use it. Warn if KVM meets a
> + * feature which has no corresponding eVMCS field, this likely means that KVM
> + * needs to be updated.
> + */
> +#define evmcs_check_vmcs_conf32(field, ctrl)					\
> +	{									\
> +		u32 supported, unsupported32;					\
> +										\
> +		supported = evmcs_get_supported_ctls(ctrl, EVMCSv1_STRICT);	\
> +		unsupported32 = vmcs_conf->field & ~supported;			\
> +		if (unsupported32) {						\
> +			pr_warn_once(#field " unsupported with eVMCS: 0x%x\n",	\
> +				     unsupported32);				\
> +			vmcs_conf->field &= supported;				\
> +		}								\
> +	}
> +
> +#define evmcs_check_vmcs_conf64(field, ctrl)					\
> +	{									\
> +		u32 supported;							\
> +		u64 unsupported64;						\

Channeling my inner Morpheus: Stop trying to use macros and use macros!  :-D

---
 arch/x86/kvm/vmx/evmcs.c | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/evmcs.h |  2 ++
 arch/x86/kvm/vmx/vmx.c   |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 337783675731..f7f8eafeecf7 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "kvm/hyper-v: " fmt
+
 #include <linux/errno.h>
 #include <linux/smp.h>
 
@@ -507,6 +509,38 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_HYPERV)
+/*
+ * KVM on Hyper-V always uses the newest known eVMCSv1 revision, the assumption
+ * is: in case a feature has corresponding fields in eVMCS described and it was
+ * exposed in VMX feature MSRs, KVM is free to use it. Warn if KVM meets a
+ * feature which has no corresponding eVMCS field, this likely means that KVM
+ * needs to be updated.
+ */
+#define evmcs_check_vmcs_conf(field, ctrl)				\
+do {									\
+	typeof(vmcs_conf->field) unsupported;				\
+									\
+	unsupported = vmcs_conf->field & EVMCS1_UNSUPPORTED_ ## ctrl;	\
+	if (unsupported) {						\
+		pr_warn_once(#field " unsupported with eVMCS: 0x%llx\n",\
+			     (u64)unsupported);				\
+		vmcs_conf->field &= ~unsupported;			\
+	}								\
+}									\
+while (0)
+
+__init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf)
+{
+	evmcs_check_vmcs_conf(cpu_based_exec_ctrl, EXEC_CTRL);
+	evmcs_check_vmcs_conf(pin_based_exec_ctrl, PINCTRL);
+	evmcs_check_vmcs_conf(cpu_based_2nd_exec_ctrl, 2NDEXEC);
+	evmcs_check_vmcs_conf(cpu_based_3rd_exec_ctrl, 3RDEXEC);
+	evmcs_check_vmcs_conf(vmentry_ctrl, VMENTRY_CTRL);
+	evmcs_check_vmcs_conf(vmexit_ctrl, VMEXIT_CTRL);
+}
+#endif
+
 int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 			uint16_t *vmcs_version)
 {
diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
index 6f746ef3c038..bc795c6e9059 100644
--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -58,6 +58,7 @@ DECLARE_STATIC_KEY_FALSE(enable_evmcs);
 	 SECONDARY_EXEC_SHADOW_VMCS |					\
 	 SECONDARY_EXEC_TSC_SCALING |					\
 	 SECONDARY_EXEC_PAUSE_LOOP_EXITING)
+#define EVMCS1_UNSUPPORTED_3RDEXEC (~0ULL)
 #define EVMCS1_UNSUPPORTED_VMEXIT_CTRL					\
 	(VM_EXIT_SAVE_VMX_PREEMPTION_TIMER)
 #define EVMCS1_UNSUPPORTED_VMENTRY_CTRL (0)
@@ -209,6 +210,7 @@ static inline void evmcs_load(u64 phys_addr)
 	vp_ap->enlighten_vmentry = 1;
 }
 
+__init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf);
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
 static __always_inline void evmcs_write64(unsigned long field, u64 value) {}
 static inline void evmcs_write32(unsigned long field, u32 value) {}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9dba04b6b019..7fd21b1fae1d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2720,6 +2720,11 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	vmcs_conf->vmentry_ctrl        = _vmentry_control;
 	vmcs_conf->misc	= misc_msr;
 
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (enlightened_vmcs)
+		evmcs_sanitize_exec_ctrls(vmcs_conf);
+#endif
+
 	return 0;
 }
 

base-commit: 5b6b6bcc0ef138b55fdd17dc8f9d43dfd26f8bd7
-- 
