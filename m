Return-Path: <linux-hyperv+bounces-805-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18D7E5DEE
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 20:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C9C1C20E24
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 19:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D0938F97;
	Wed,  8 Nov 2023 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMrSpenn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB037178;
	Wed,  8 Nov 2023 19:00:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D2211E;
	Wed,  8 Nov 2023 11:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470026; x=1731006026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NQGmW+oXxSwWf91UKmGPw4FUojRiOmEbKecD33BDx8s=;
  b=FMrSpenntVH30An5xopafTniXl/3jP3iRcSaMKO0Mzr1BujQRTiNmLbR
   Dmhlg0wPEZ2X+0DbuizNig7bpFbccpSUBh2RIYSvqsUABwvGgkwYo/l04
   T8TtsAobwNFWcCGlfMdL+0C0f+DUS++1lR5OXxhTRxGQtQ1lgjDv4n0q7
   2nHmqg+tFhNOLIWBX/AsAui4iQDOPzfg8qqpHYH3O2usJJov01ldudbPz
   wIobGzceEHGM9l2Vy8M7xI0VheMCJ1kXEy46FGU9nZQb7nyKiyb6AyN30
   +SnkK8Wnexmlan30lGO4YCTzwZss3bnlz9VStLgpvEKZx3/+Y8QabIMHQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486408"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486408"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892494"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:24 -0800
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
Subject: [PATCH v1 17/23] KVM: nVMX: Add support for VMX FRED controls
Date: Wed,  8 Nov 2023 10:29:57 -0800
Message-ID: <20231108183003.5981-18-xin3.li@intel.com>
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

Add VMX FRED controls to nested VMX controls and set the VMX
nested-exception support bit (bit 58) in the nested IA32_VMX_BASIC MSR
when FRED is enabled.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kvm/vmx/hyperv.c |  7 +++++--
 arch/x86/kvm/vmx/nested.c | 14 ++++++++++----
 arch/x86/kvm/vmx/vmx.c    |  3 +++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index b12ef8fd76c9..28fca62f3887 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -106,7 +106,9 @@
 	 VM_EXIT_CLEAR_IA32_RTIT_CTL |					\
 	 VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
 
-#define EVMCS1_SUPPORTED_VMEXIT_CTRL2 (0ULL)
+#define EVMCS1_SUPPORTED_VMEXIT_CTRL2					\
+	(SECONDARY_VM_EXIT_SAVE_IA32_FRED |				\
+	 SECONDARY_VM_EXIT_LOAD_IA32_FRED)
 
 #define EVMCS1_SUPPORTED_VMENTRY_CTRL					\
 	(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR |				\
@@ -117,7 +119,8 @@
 	 VM_ENTRY_LOAD_IA32_EFER |					\
 	 VM_ENTRY_LOAD_BNDCFGS |					\
 	 VM_ENTRY_PT_CONCEAL_PIP |					\
-	 VM_ENTRY_LOAD_IA32_RTIT_CTL)
+	 VM_ENTRY_LOAD_IA32_RTIT_CTL |					\
+	 VM_ENTRY_LOAD_IA32_FRED)
 
 #define EVMCS1_SUPPORTED_VMFUNC (0)
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index af616c4a3491..b85cd5c0ec98 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1230,10 +1230,12 @@ static bool is_bitwise_subset(u64 superset, u64 subset, u64 mask)
 #define VMX_BASIC_FEATURES_MASK			\
 	(VMX_BASIC_DUAL_MONITOR_TREATMENT |	\
 	 VMX_BASIC_INOUT |			\
-	 VMX_BASIC_TRUE_CTLS)
+	 VMX_BASIC_TRUE_CTLS |			\
+	 VMX_BASIC_NESTED_EXCEPTION)
 
-#define VMX_BASIC_RESERVED_BITS			\
-	(GENMASK_ULL(63, 56) | GENMASK_ULL(47, 45) | BIT_ULL(31))
+#define VMX_BASIC_RESERVED_BITS				\
+	(GENMASK_ULL(63, 59) | GENMASK_ULL(57, 56) |	\
+	 GENMASK_ULL(47, 45) | BIT_ULL(31))
 
 static int vmx_restore_vmx_basic(struct vcpu_vmx *vmx, u64 data)
 {
@@ -6985,7 +6987,8 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
 #ifdef CONFIG_X86_64
 		VM_ENTRY_IA32E_MODE |
 #endif
-		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS;
+		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
+		VM_ENTRY_LOAD_IA32_FRED;
 	msrs->entry_ctls_high |=
 		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
 		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);
@@ -7141,6 +7144,9 @@ static void nested_vmx_setup_basic(struct nested_vmx_msrs *msrs)
 
 	if (cpu_has_vmx_basic_inout())
 		msrs->basic |= VMX_BASIC_INOUT;
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		msrs->basic |= VMX_BASIC_NESTED_EXCEPTION;
 }
 
 static void nested_vmx_setup_cr_fixed(struct nested_vmx_msrs *msrs)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b826dc188fc7..3353fd6615a2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7970,6 +7970,9 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 	cr4_fixed1_update(X86_CR4_UMIP,       ecx, feature_bit(UMIP));
 	cr4_fixed1_update(X86_CR4_LA57,       ecx, feature_bit(LA57));
 
+	entry = kvm_find_cpuid_entry_index(vcpu, 0x7, 1);
+	cr4_fixed1_update(X86_CR4_FRED,       eax, feature_bit(FRED));
+
 #undef cr4_fixed1_update
 }
 
-- 
2.42.0


