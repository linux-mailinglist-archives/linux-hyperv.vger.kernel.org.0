Return-Path: <linux-hyperv+bounces-808-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A457E5DF4
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 20:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569151C20B66
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A938FAD;
	Wed,  8 Nov 2023 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ycn0Ro25"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CB374CA;
	Wed,  8 Nov 2023 19:00:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA72213C;
	Wed,  8 Nov 2023 11:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470029; x=1731006029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f/CpZWB+KHZLSvqt26TggdKx4NNWrmqcMmgPoU9+LJM=;
  b=Ycn0Ro25JI8o5xAG9w+wR0NrFzDdkBzImNyZXz/bk4btqnPPUt1pvyVC
   kNGJKIb/weUCRa09u1HJGatN//Kt/gkmN/4FuMKJknIg0dhU4GuX38H/w
   S1VtDj1iCSBG2WMUvxsSFzWD3yuAW9e9dI0CfzJb4MbgX8tbRKkK0VLW8
   qtehg2+cJJWCk+/5oRg8X/Ucczf53njUbRE0vxMuPjFvi3J+DWPfTewvI
   P8WX4Vm0E7CUd4St1KLyhv1QJhXXOjErRnyKRzk6Lcpsi0svJC+7n8LZV
   vpmjkEx5ysBC1AgBconP6rUSvoSkkdm7wrxM21yOj2cS2FjGcSud/CDfX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486456"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486456"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892515"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:27 -0800
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
Subject: [PATCH v1 21/23] KVM: selftests: Run debug_regs test with FRED enabled
Date: Wed,  8 Nov 2023 10:30:01 -0800
Message-ID: <20231108183003.5981-22-xin3.li@intel.com>
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

Run another round of debug_regs test with FRED enabled if FRED is
available.

Signed-off-by: Xin Li <xin3.li@intel.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  4 ++
 .../testing/selftests/kvm/x86_64/debug_regs.c | 50 ++++++++++++++-----
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 25bc61dac5fb..165d21fd1577 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -47,6 +47,7 @@ extern bool host_cpu_is_amd;
 #define X86_CR4_SMEP		(1ul << 20)
 #define X86_CR4_SMAP		(1ul << 21)
 #define X86_CR4_PKE		(1ul << 22)
+#define X86_CR4_FRED		(1ul << 32)
 
 struct xstate_header {
 	u64				xstate_bv;
@@ -163,6 +164,9 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_SPEC_CTRL		KVM_X86_CPU_FEATURE(0x7, 0, EDX, 26)
 #define	X86_FEATURE_ARCH_CAPABILITIES	KVM_X86_CPU_FEATURE(0x7, 0, EDX, 29)
 #define	X86_FEATURE_PKS			KVM_X86_CPU_FEATURE(0x7, 0, ECX, 31)
+#define	X86_FEATURE_FRED		KVM_X86_CPU_FEATURE(0x7, 1, EAX, 17)
+#define	X86_FEATURE_LKGS		KVM_X86_CPU_FEATURE(0x7, 1, EAX, 18)
+#define	X86_FEATURE_WRMSRNS		KVM_X86_CPU_FEATURE(0x7, 1, EAX, 19)
 #define	X86_FEATURE_XTILECFG		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 17)
 #define	X86_FEATURE_XTILEDATA		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 18)
 #define	X86_FEATURE_XSAVES		KVM_X86_CPU_FEATURE(0xD, 1, EAX, 3)
diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index f6b295e0b2d2..69055e764f15 100644
--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -20,7 +20,7 @@ uint32_t guest_value;
 
 extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
 
-static void guest_code(void)
+static void guest_test_code(void)
 {
 	/* Create a pending interrupt on current vCPU */
 	x2apic_enable();
@@ -61,6 +61,15 @@ static void guest_code(void)
 
 	/* DR6.BD test */
 	asm volatile("bd_start: mov %%dr0, %%rax" : : : "rax");
+}
+
+static void guest_code(void)
+{
+	guest_test_code();
+
+	if (get_cr4() & X86_CR4_FRED)
+		guest_test_code();
+
 	GUEST_DONE();
 }
 
@@ -75,19 +84,15 @@ static void vcpu_skip_insn(struct kvm_vcpu *vcpu, int insn_len)
 	vcpu_regs_set(vcpu, &regs);
 }
 
-int main(void)
+void run_test(struct kvm_vcpu *vcpu)
 {
 	struct kvm_guest_debug debug;
+	struct kvm_run *run = vcpu->run;
 	unsigned long long target_dr6, target_rip;
-	struct kvm_vcpu *vcpu;
-	struct kvm_run *run;
-	struct kvm_vm *vm;
-	struct ucall uc;
-	uint64_t cmd;
 	int i;
 	/* Instruction lengths starting at ss_start */
 	int ss_size[6] = {
-		1,		/* sti*/
+		1,		/* sti */
 		2,		/* xor */
 		2,		/* cpuid */
 		5,		/* mov */
@@ -95,11 +100,6 @@ int main(void)
 		1,		/* cli */
 	};
 
-	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SET_GUEST_DEBUG));
-
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-	run = vcpu->run;
-
 	/* Test software BPs - int3 */
 	memset(&debug, 0, sizeof(debug));
 	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
@@ -202,6 +202,30 @@ int main(void)
 	/* Disable all debug controls, run to the end */
 	memset(&debug, 0, sizeof(debug));
 	vcpu_guest_debug_set(vcpu, &debug);
+}
+
+int main(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	uint64_t cmd;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SET_GUEST_DEBUG));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	run_test(vcpu);
+
+	if (kvm_cpu_has(X86_FEATURE_FRED)) {
+		struct kvm_sregs sregs;
+
+		vcpu_sregs_get(vcpu, &sregs);
+		sregs.cr4 |= X86_CR4_FRED;
+		vcpu_sregs_set(vcpu, &sregs);
+
+		run_test(vcpu);
+	}
 
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
-- 
2.42.0


