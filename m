Return-Path: <linux-hyperv+bounces-799-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759097E5DD5
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 20:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305DC1F21EB0
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 19:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4DA374E4;
	Wed,  8 Nov 2023 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eX3fdQK8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32E36B0F;
	Wed,  8 Nov 2023 19:00:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52DB2115;
	Wed,  8 Nov 2023 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470020; x=1731006020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IRPQ5ioteqwh4CfCqIjfG/Rnvw8uAQhRAapN4CI6IQw=;
  b=eX3fdQK8JsApP9z8bxI4pPxxR05RM8YyOiRfWXbjw2rJEqxlm7zRdp9W
   pQbg8cgk1w2aSDFDt5Y4anHI8VTAaBNkINTyhDQb/1mE+LlI8/TzxAfab
   GcHEJgtZTmsFsgDJ74D8FrD7720XbMkvK2pNziOaqqiYfvo7KQ+c6+ZAo
   06tssZmc1nDnA3IQAvb7maZv28mcRfP0B7eIOzcT/aDpfeX3JaRsUWD0y
   uQYc0Y3h7d7v+D7RTtTxkal8uOfy9RKjxXpDSuDPe0UHamVYQhigFf+/4
   HixVkH5BZq+xFt5qkdY89sd433ufE0dX1ansoz59eZeHG/a+AhtPv+QvK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486267"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486267"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892433"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:18 -0800
From: Xin Li <xin3.li@intel.com>
To: kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	corbet@lwn.net,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	vkuznets@redhat.com,
	peterz@infradead.org,
	ravi.v.shankar@intel.com
Subject: [PATCH v1 06/23] KVM: VMX: Defer enabling FRED MSRs save/load until after set CPUID
Date: Wed,  8 Nov 2023 10:29:46 -0800
Message-ID: <20231108183003.5981-7-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear FRED VM entry/exit controls when initializing a vCPU, and set
these controls only if FRED is enumerated after set CPUID.

FRED VM entry/exit controls need to be set to establish context
sufficient to support FRED event delivery immediately after VM entry
and exit.  However it is not required to save/load FRED MSRs for
a non-FRED guest, which aren't supposed to access FRED MSRs.

A non-FRED guest should get #GP upon accessing FRED MSRs, otherwise
it corrupts host FRED MSRs.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9186f41974ab..5d4786812664 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4423,6 +4423,9 @@ static u32 vmx_vmentry_ctrl(void)
 	if (cpu_has_perf_global_ctrl_bug())
 		vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
 
+	/* Whether to load guest FRED MSRs is deferred until after set CPUID */
+	vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_FRED;
+
 	return vmentry_ctrl;
 }
 
@@ -4458,7 +4461,13 @@ static u32 vmx_vmexit_ctrl(void)
 
 static u64 vmx_secondary_vmexit_ctrl(void)
 {
-	return vmcs_config.secondary_vmexit_ctrl;
+	u64 secondary_vmexit_ctrl = vmcs_config.secondary_vmexit_ctrl;
+
+	/* Whether to save/load FRED MSRs is deferred until after set CPUID */
+	secondary_vmexit_ctrl &= ~(SECONDARY_VM_EXIT_SAVE_IA32_FRED |
+				   SECONDARY_VM_EXIT_LOAD_IA32_FRED);
+
+	return secondary_vmexit_ctrl;
 }
 
 static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
@@ -7785,10 +7794,33 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
 		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
 }
 
+static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) ||
+	    !guest_cpuid_has(vcpu, X86_FEATURE_FRED))
+		return;
+
+	/* Enable loading guest FRED MSRs from VMCS */
+	vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
+
+	/*
+	 * Enable saving guest FRED MSRs into VMCS and loading host FRED MSRs
+	 * from VMCS.
+	 */
+	vm_exit_controls_setbit(vmx, VM_EXIT_ACTIVATE_SECONDARY_CONTROLS);
+	secondary_vm_exit_controls_setbit(vmx,
+					  SECONDARY_VM_EXIT_SAVE_IA32_FRED |
+					  SECONDARY_VM_EXIT_LOAD_IA32_FRED);
+}
+
 static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	vmx_vcpu_config_fred_after_set_cpuid(vcpu);
+
 	/*
 	 * XSAVES is effectively enabled if and only if XSAVE is also exposed
 	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
-- 
2.42.0


