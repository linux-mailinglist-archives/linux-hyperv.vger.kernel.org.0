Return-Path: <linux-hyperv+bounces-822-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C7B7E6D0D
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 16:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D3B20A9E
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18AD200A0;
	Thu,  9 Nov 2023 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whUnvyjR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D881DA35
	for <linux-hyperv@vger.kernel.org>; Thu,  9 Nov 2023 15:15:34 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED082683
	for <linux-hyperv@vger.kernel.org>; Thu,  9 Nov 2023 07:15:33 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a90d6ab944so13379907b3.2
        for <linux-hyperv@vger.kernel.org>; Thu, 09 Nov 2023 07:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699542933; x=1700147733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+Bm4VxsIbinzhc5nb4VCCnVH6ntCjSPhYk8v0ZWen8=;
        b=whUnvyjRRgi8Q20u5Qy6Kok1hbnPxHrdOo/gS9leI/fNXZx4thT8TDx9b9HSbqq03c
         U/ts6EH3FSE8va0gJkVfjRTurESSHxRx5tzCllQG0ijyhcNZmnayauUf3j5Fm2GjGj7z
         1TTBLBUsYuHnmIfr/xwPtOx81FNI8/lE6N/vOgjqZWIDyKGj/R6UQ4Zvwr64bW0K6eTF
         PEsIN3Zts9yHwCMZNczyCulGWEbVR+DckwjcLtbxr1pXblIjzrpGPy9llH8qYgnYv4ib
         jzKwaDRbVhFhBi63ZZI/Nn09j2DPLEC76Y83iH6l7q5cbdSM+05bV2PyMdX2SiwbWByQ
         yWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699542933; x=1700147733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+Bm4VxsIbinzhc5nb4VCCnVH6ntCjSPhYk8v0ZWen8=;
        b=NoLvb7Dph8iwPCE31QZ+o/qjdSQPTpIzBnjvfX1hJQGTQCSg48d8tJSGqp9sra6cOm
         AQRtcfyU7wZM4lJbLrUzleiDaCo3YZJa/2hpfUZlg9w+zKSTv5iNusB/73tm2HAZLC6d
         EPlnT3VfJX4sZptk2/IFRXRvtrmXFps+k1v+XRFQIAl5JLWJXLzGSMVeS9/W2hKGPstl
         z0UviS8tA2W6hvyLZMWfXLKWxTUX4pS8mEWXbXbQ61DuMbJYpBDVsQEaK1CZfp0fE8X6
         LT3GVA9vtdqqFT8jtgXzMI3gBByaOpQz9SPUu2hRlHxAfZa79uc2NN9nt7mpJ2XmGjhU
         yaVg==
X-Gm-Message-State: AOJu0Yx0o6xiCaDkHaA5gqHse1Hgt7AFHSXiEZI1J6PqX7ebJXpHIGxl
	JG6uyy9ImHvpMJMWqLgRFmJJ1fr4lgA=
X-Google-Smtp-Source: AGHT+IGa7z7+OfdYCmqIlLzQUeqKBMunW527AUwnYiPUX/rjhI5E9aZBnJn6/1t9X4kg9dH1DU8ZwWG+HkE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2fd2:0:b0:d7e:7a8a:2159 with SMTP id
 v201-20020a252fd2000000b00d7e7a8a2159mr125502ybv.5.1699542932831; Thu, 09 Nov
 2023 07:15:32 -0800 (PST)
Date: Thu, 9 Nov 2023 07:15:31 -0800
In-Reply-To: <ZUyeATu4Fd2xI0+h@chao-email>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231108183003.5981-1-xin3.li@intel.com> <20231108183003.5981-6-xin3.li@intel.com>
 <ZUyeATu4Fd2xI0+h@chao-email>
Message-ID: <ZUz3cPmnqSq7Lol9@google.com>
Subject: Re: [PATCH v1 05/23] KVM: VMX: Initialize FRED VM entry/exit controls
 in vmcs_config
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xin Li <xin3.li@intel.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	vkuznets@redhat.com, peterz@infradead.org, ravi.v.shankar@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 09, 2023, Chao Gao wrote:
> On Wed, Nov 08, 2023 at 10:29:45AM -0800, Xin Li wrote:
> >Setup the global vmcs_config for FRED:
> >1) Add VM_ENTRY_LOAD_IA32_FRED to KVM_OPTIONAL_VMX_VM_ENTRY_CONTROLS to
> >   have a FRED CPU load guest FRED MSRs from VMCS upon VM entry.
> >2) Add SECONDARY_VM_EXIT_SAVE_IA32_FRED to
> >   KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU save
> >   guest FRED MSRs to VMCS during VM exit.
> >3) add SECONDARY_VM_EXIT_LOAD_IA32_FRED to
> >   KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU load
> >   host FRED MSRs from VMCS during VM exit.
> >
> >Also add sanity checks to make sure FRED VM entry/exit controls can be
> >set on a FRED CPU.
> >
> >Tested-by: Shan Kang <shan.kang@intel.com>
> >Signed-off-by: Xin Li <xin3.li@intel.com>
> >---
> > arch/x86/include/asm/vmx.h |  3 +++
> > arch/x86/kvm/vmx/vmx.c     | 19 ++++++++++++++++++-
> > arch/x86/kvm/vmx/vmx.h     |  7 +++++--
> > 3 files changed, 26 insertions(+), 3 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> >index 4d4177ec802c..41796a733bc9 100644
> >--- a/arch/x86/include/asm/vmx.h
> >+++ b/arch/x86/include/asm/vmx.h
> >@@ -106,6 +106,8 @@
> > #define VM_EXIT_PT_CONCEAL_PIP			0x01000000
> > #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
> > #define VM_EXIT_ACTIVATE_SECONDARY_CONTROLS	0x80000000
> >+#define SECONDARY_VM_EXIT_SAVE_IA32_FRED	0x00000001
> >+#define SECONDARY_VM_EXIT_LOAD_IA32_FRED	0x00000002
> > 
> > #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
> > 
> >@@ -119,6 +121,7 @@
> > #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
> > #define VM_ENTRY_PT_CONCEAL_PIP			0x00020000
> > #define VM_ENTRY_LOAD_IA32_RTIT_CTL		0x00040000
> >+#define VM_ENTRY_LOAD_IA32_FRED			0x00800000
> > 
> > #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
> > 
> >diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> >index df769207cbe0..9186f41974ab 100644
> >--- a/arch/x86/kvm/vmx/vmx.c
> >+++ b/arch/x86/kvm/vmx/vmx.c
> >@@ -2694,10 +2694,27 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
> > 		_vmexit_control &= ~x_ctrl;
> > 	}
> > 
> >-	if (_vmexit_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
> >+	if (_vmexit_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
> > 		_secondary_vmexit_control =
> > 			adjust_vmx_controls64(KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS,
> > 					      MSR_IA32_VMX_EXIT_CTLS2);
> >+		if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> >+		    !(_secondary_vmexit_control & SECONDARY_VM_EXIT_SAVE_IA32_FRED &&
> >+		      _secondary_vmexit_control & SECONDARY_VM_EXIT_LOAD_IA32_FRED)) {
> >+			pr_warn_once("FRED enabled but no VMX VM-Exit {SAVE,LOAD}_IA32_FRED controls: %llx\n",
> >+				     _secondary_vmexit_control);
> 
> if there is no VM_EXIT_ACTIVATE_SECONDARY_CONTROLS, shouldn't we also emit this
> warning?
> 
> >+			if (error_on_inconsistent_vmcs_config)
> >+				return -EIO;
> >+		}
> >+	}
> >+
> >+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> >+	    !(_vmentry_control & VM_ENTRY_LOAD_IA32_FRED)) {
> >+		pr_warn_once("FRED enabled but no VMX VM-Entry LOAD_IA32_FRED control: %x\n",
> >+			     _vmentry_control);
> 
> Can we just hide FRED from guests like what KVM does for other features which
> have similar dependencies? see vmx_set_cpu_caps().

Both of these warnings should simply be dropped.  The error_on_inconsistent_vmcs_config
stuff is for inconsistencies within the allowed VMCS fields.  Having a feature
that is supported in bare metal but not virtualized is perfectly legal, if
uncommon.

What *is* needed is for KVM to refuse to virtualize FRED if the entry/exit controls
aren't consistent.  E.g. if at least one control is present, and at least one
control is missing.   I.e. KVM needs a version of vmcs_entry_exit_pairs that can
deal with SECONDAY_VM_EXIT controls.  I'll circle back to this when I give the
series a proper review, which is going to be 3+ weeks. 

