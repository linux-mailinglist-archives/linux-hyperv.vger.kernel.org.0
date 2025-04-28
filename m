Return-Path: <linux-hyperv+bounces-5196-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAFEA9F706
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 19:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6C317CF31
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6B23370C;
	Mon, 28 Apr 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LXoBnbXi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DBE22423C
	for <linux-hyperv@vger.kernel.org>; Mon, 28 Apr 2025 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860421; cv=none; b=K6u4pzdAHR+jrTj5f4Nq7MVRU4fbRp34Yc0wvCA/bLMTXCH2qaAZP9Eha0vgpRIR8R+QpaHjBf+j+3VWguKfGUs+apO957Vsp1HZrTmros/JX29CNIx88Y1RX7wIWfAU5N3+mMPLO2Yc9tBOoBk6MXS+4Kpw75kDHVcOZEPA9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860421; c=relaxed/simple;
	bh=nWgWzlUJa06MxNgJOwVP/WXg4pkgTp6oaZEytmQAVYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dw+FYFR5y/8BNcRLtatHMCXOtQQCes63oxB8LgAnXW2+AVHewNMQM2aY7OBlqzv/iKitshtgAnZYn94oybAPzUJH+65IeIGyf+BsE13xbSK9+xtv0cXqSYKuoDqH0nHwLinF8fYeSTbK1veSU5CzxkQWuCF5e2PkJDtF68N/4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LXoBnbXi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so4623331a91.3
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Apr 2025 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745860418; x=1746465218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLXoOx9yRCTvvCd0BrHtncY5tgqACMNmODA1lhD+RGg=;
        b=LXoBnbXiKvfGk1QIMY/LcN49Uo6CtG4UWARBfzJTa8FgCkjNxiBqgIp8c1qJjp91qP
         CwpmgLnz5XGv//BNbExWFy8bpgwQngMFsidtowz8F7Ddlx12Qc3YKu77PCl1rMNeCCwP
         lENSSL25aTu/nbAeRIKYJlIPNQJB/zDCxp3evcEHoBngLiARSiIw8tKtCyp32FCv/9Uk
         lVOY21CEQE/SJ2mFJpRzFpYFDNw8bURNlaMxaclIQYYpWLSD3FczTkt0hjreDcF8LORb
         P521/x4rQDqyqNiU95BH9hE2/ydT2oE3KndYxNK+K36eABaj5264p5JT/Ye0qV7bm9Md
         U3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745860418; x=1746465218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLXoOx9yRCTvvCd0BrHtncY5tgqACMNmODA1lhD+RGg=;
        b=k3YNB2VCsrxx4J/2bzH6JSB46Uvjb7Fshe92jArVo1XfPecMRdPtIDVd698i3734RA
         9VJrwrQEWn0DLur597pVhiVFDdW8TwiI7dGLo6nmx0CF9L8sTFn4RJ+BBMzJhlQ3vdZd
         TqNscKbMSjrANXyl8wPU90aXHpt0WNsSdwmEEdI16gcl7xiWtomvIdk5IOTuzpidYPTC
         Ne1kmRbBJVi/OfPxxjAX3/IOjlGbs96Y+ApGouILz6mHAiWP94DFq2QNdJy6POIQ8WTg
         9hzusVBQn91b5jbK+25XwSkZ5ubuZEa9BlxBYxTvitsb3GC7Gu9acPipOCBPIxD1GkrS
         synQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT3x4sxTqjoAxdvgt7aZZ8r6GpoWInrprx0XKbhj76MipohruoeV+pa3nIzT4fFs+MbU545sSsyxIpNF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFP7SSrEmXmjkSDmNeDJclR5VQv8CsYOpg1pDcSOM2T02cFWL
	oClUgPQtkjKDK2ftBJ0mGJHqiqpzJ1hOhkXIdaYoWuU0wBo3QjemYVpZc1DGowLMQAtZCeYTtx7
	YRA==
X-Google-Smtp-Source: AGHT+IE+4L5c7j0EkfxyQmlwMTl0MgYW7wuchNMYU9Od+v/iLDBMMA3J9+5+fhqGN0g7cJa/S4ImSoG6YW8=
X-Received: from pjyr15.prod.google.com ([2002:a17:90a:e18f:b0:309:f831:28e0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2681:b0:2ff:5e4e:864
 with SMTP id 98e67ed59e1d1-30a013995dcmr14048612a91.25.1745860418000; Mon, 28
 Apr 2025 10:13:38 -0700 (PDT)
Date: Mon, 28 Apr 2025 10:13:31 -0700
In-Reply-To: <20250426100134.GB4198@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414111140.586315004@infradead.org> <20250414113754.172767741@infradead.org>
 <7vfbchsyhlsvdl4hszdtmapdghw32nrj2qd652f3pjzg3yb6vn@po3bsa54b6ta>
 <20250415074421.GI5600@noisy.programming.kicks-ass.net> <zgsycf7arbsadpphod643qljqqsk5rbmidrhhrnm2j7qie4gu2@g7pzud43yj4q>
 <20250416083859.GH4031@noisy.programming.kicks-ass.net> <20250426100134.GB4198@noisy.programming.kicks-ass.net>
Message-ID: <aA-3OwNum9gzHLH1@google.com>
Subject: Re: [PATCH 3/6] x86/kvm/emulate: Avoid RET for fastops
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, pawan.kumar.gupta@linux.intel.com, 
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Apr 26, 2025, Peter Zijlstra wrote:
> On Wed, Apr 16, 2025 at 10:38:59AM +0200, Peter Zijlstra wrote:
> 
> > Yeah, I finally got there. I'll go cook up something else.
> 
> Sean, Paolo, can I once again ask how best to test this fastop crud?

Apply the below, build KVM selftests, enable forced emulation in KVM, and then
run fastops_test.  It's well past time we had a selftest for this.  It won't
detect bugs that are specific to 32-bit kernels, e.g. b63f20a778c8 ("x86/retpoline:
Don't clobber RFLAGS during CALL_NOSPEC on i386"), since KVM selftests are 64-bit
only, but for what you're doing, it should suffice.

For 32-bit kernels, it requires a 32-bit QEMU and KVM-Unit-Tests (or maybe even
a full blown 32-bit guest image; I forget how much coverage KUT provides).
Regardless, I don't see any reason to put you through that pain, I can do that
sanity testing.

I'll post a proper patch for the new selftest after testing on AMD.  The test
relies on hardware providing deterministic behavior for undefined output (RFLAGS
and GPRs); I don't know if that holds true on AMD.

To enable forced emulation, set /sys/module/kvm/parameters/force_emulation_prefix
to '1' (for the purposes of this test, the value doesn't matter).  The param is
writable at runtime, so it doesn't matter if kvm.ko is built-in or a module. 

---
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 28 Apr 2025 08:55:44 -0700
Subject: [PATCH] KVM: selftests: Add a test for x86's fastops emulation

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/x86/fastops_test.c  | 165 ++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/fastops_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f62b0a5aba35..411c3d5eb5b1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -66,6 +66,7 @@ TEST_GEN_PROGS_x86 += x86/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86 += x86/dirty_log_page_splitting_test
 TEST_GEN_PROGS_x86 += x86/feature_msrs_test
 TEST_GEN_PROGS_x86 += x86/exit_on_emulation_failure_test
+TEST_GEN_PROGS_x86 += x86/fastops_test
 TEST_GEN_PROGS_x86 += x86/fix_hypercall_test
 TEST_GEN_PROGS_x86 += x86/hwcr_msr_test
 TEST_GEN_PROGS_x86 += x86/hyperv_clock
diff --git a/tools/testing/selftests/kvm/x86/fastops_test.c b/tools/testing/selftests/kvm/x86/fastops_test.c
new file mode 100644
index 000000000000..c3799edb5d0c
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/fastops_test.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+/*
+ * Execute a fastop() instruction, with or without forced emulation.  BT bit 0
+ * to set RFLAGS.CF based on whether or not the input is even or odd, so that
+ * instructions like ADC and SBB are deterministic.
+ */
+#define guest_execute_fastop_1(FEP, insn, type_t, __val, __flags)			\
+do {											\
+	__asm__ __volatile__("bt $0, %[val]\n\t"					\
+			     FEP insn " %[val]\n\t"					\
+			     "pushfq\n\t"						\
+			     "pop %[flags]\n\t"						\
+			     : [val]"+r"(__val), [flags]"=r"(__flags)			\
+			     : : "cc", "memory");					\
+} while (0)
+
+#define guest_test_fastop_1(insn, type_t, __val)					\
+do {											\
+	type_t val = __val, ex_val = __val, input = __val;				\
+	uint64_t flags, ex_flags;							\
+											\
+	guest_execute_fastop_1("", insn, type_t, ex_val, ex_flags);			\
+	guest_execute_fastop_1(KVM_FEP, insn, type_t, val, flags);			\
+											\
+	__GUEST_ASSERT(val == ex_val,							\
+		       "Wanted 0x%lx for '%s 0x%lx', got 0x%lx",			\
+		       (uint64_t)ex_val, insn, (uint64_t)input, (uint64_t)val);		\
+	__GUEST_ASSERT(flags == ex_flags,						\
+			"Wanted flags 0x%lx for '%s 0x%lx', got 0x%lx",			\
+			ex_flags, insn, (uint64_t)input, flags);			\
+} while (0)
+
+#define guest_execute_fastop_2(FEP, insn, type_t, __input, __output, __flags)		\
+do {											\
+	__asm__ __volatile__("bt $0, %[output]\n\t"					\
+			     FEP insn " %[input], %[output]\n\t"			\
+			     "pushfq\n\t"						\
+			     "pop %[flags]\n\t"						\
+			     : [output]"+r"(__output), [flags]"=r"(__flags)		\
+			     : [input]"r"(__input) : "cc", "memory");			\
+} while (0)
+
+#define guest_test_fastop_2(insn, type_t, __val1, __val2)				\
+do {											\
+	type_t input = __val1, input2 = __val2, output = __val2, ex_output = __val2;	\
+	uint64_t flags, ex_flags;							\
+											\
+	guest_execute_fastop_2("", insn, type_t, input, ex_output, ex_flags);		\
+	guest_execute_fastop_2(KVM_FEP, insn, type_t, input, output, flags);		\
+											\
+	__GUEST_ASSERT(output == ex_output,						\
+		       "Wanted 0x%lx for '%s 0x%lx 0x%lx', got 0x%lx",			\
+		       (uint64_t)ex_output, insn, (uint64_t)input,			\
+		       (uint64_t)input2, (uint64_t)output);				\
+	__GUEST_ASSERT(flags == ex_flags,						\
+			"Wanted flags 0x%lx for '%s 0x%lx, 0x%lx', got 0x%lx",		\
+			ex_flags, insn, (uint64_t)input, (uint64_t)input2, flags);	\
+} while (0)
+
+#define guest_execute_fastop_cl(FEP, insn, type_t, __shift, __output, __flags)		\
+do {											\
+	__asm__ __volatile__("bt $0, %[output]\n\t"					\
+			     FEP insn " %%cl, %[output]\n\t"				\
+			     "pushfq\n\t"						\
+			     "pop %[flags]\n\t"						\
+			     : [output]"+r"(__output), [flags]"=r"(__flags)		\
+			     : "c"(__shift) : "cc", "memory");				\
+} while (0)
+
+#define guest_test_fastop_cl(insn, type_t, __val1, __val2)				\
+do {											\
+	type_t output = __val2, ex_output = __val2, input = __val2;			\
+	uint8_t shift = __val1;								\
+	uint64_t flags, ex_flags;							\
+											\
+	guest_execute_fastop_cl("", insn, type_t, shift, ex_output, ex_flags);		\
+	guest_execute_fastop_cl(KVM_FEP, insn, type_t, shift, output, flags);		\
+											\
+	__GUEST_ASSERT(output == ex_output,						\
+		       "Wanted 0x%lx for '%s 0x%x, 0x%lx', got 0x%lx",			\
+		       (uint64_t)ex_output, insn, shift, (uint64_t)input,		\
+		       (uint64_t)output);						\
+	__GUEST_ASSERT(flags == ex_flags,						\
+			"Wanted flags 0x%lx for '%s 0x%x, 0x%lx', got 0x%lx",		\
+			ex_flags, insn, shift, (uint64_t)input, flags);			\
+} while (0)
+
+static const uint64_t vals[] = {
+	0,
+	1,
+	2,
+	4,
+	7,
+	0x5555555555555555,
+	0xaaaaaaaaaaaaaaaa,
+	0xfefefefefefefefe,
+	0xffffffffffffffff,
+};
+
+#define guest_test_fastops(type_t, suffix)						\
+do {											\
+	int i, j;									\
+											\
+	for (i = 0; i < ARRAY_SIZE(vals); i++) {					\
+		guest_test_fastop_1("dec" suffix, type_t, vals[i]);			\
+		guest_test_fastop_1("inc" suffix, type_t, vals[i]);			\
+		guest_test_fastop_1("neg" suffix, type_t, vals[i]);			\
+		guest_test_fastop_1("not" suffix, type_t, vals[i]);			\
+											\
+		for (j = 0; j < ARRAY_SIZE(vals); j++) {				\
+			guest_test_fastop_2("add" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("adc" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("and" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("bsf" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("bsr" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("bt" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("btc" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("btr" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("bts" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("cmp" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("imul" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("or" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("sbb" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("sub" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("test" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_2("xor" suffix, type_t, vals[i], vals[j]);	\
+											\
+			guest_test_fastop_cl("rol" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_cl("ror" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_cl("rcl" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_cl("rcr" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_cl("sar" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_cl("shl" suffix, type_t, vals[i], vals[j]);	\
+			guest_test_fastop_cl("shr" suffix, type_t, vals[i], vals[j]);	\
+		}									\
+	}										\
+} while (0)
+
+static void guest_code(void)
+{
+	guest_test_fastops(uint16_t, "w");
+	guest_test_fastops(uint32_t, "l");
+	guest_test_fastops(uint64_t, "q");
+
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	TEST_REQUIRE(is_forced_emulation_enabled);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	kvm_vm_free(vm);
+}

base-commit: 661b7ddb2d10258b53106d7c39c309806b00a99c
-- 

