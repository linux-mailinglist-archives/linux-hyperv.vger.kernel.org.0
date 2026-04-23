Return-Path: <linux-hyperv+bounces-10331-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCa8FKMU6mmVtgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10331-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:46:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 389284523CA
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA1D13007297
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC53EDAA6;
	Thu, 23 Apr 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f47tU/Hz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939B21D6DB5;
	Thu, 23 Apr 2026 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948202; cv=none; b=VTHTth1G5Vl1xZUJGlqTF+Vyh1LuVs8biUOwWcnpBZfo9UmKI/Vb9COUIazINiBcG+blDxzq1tW6ApsLH3jaun5B0z4WdjpnsenBrqmtxtr3gnXkH6vd0ZBoOlT5s1sG7MtxsIM5tMZN/96bTJMTeBqnrx/9KXqJEn22IWbidas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948202; c=relaxed/simple;
	bh=eAdPjGUyJz01icU8R0rlCiMxidI+ThwnPQ3HGdEb5xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQgzP723zxoHe5ogBSafpUMlejzZwqaIiMdCWDoWRNo5Ab7lEStHOxs6uQo6LE1BSeOMtCU4wWN8gGOf0OdxNZNghLIhXUTpBeWqVELrJpuSynjwF95klGIRVj+FJ7W1CdDs4VPJA8+gXoytQs3nKV1eIrXqA4pvL8VFJ/pfsR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f47tU/Hz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id D497220B7168;
	Thu, 23 Apr 2026 05:43:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D497220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948200;
	bh=aVyNCeXYZ0oAOSkaW+ZPREQaMs9A0VJFYF7viH8T5Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f47tU/Hz8pUgeCWHR4nk3hAOYdY/CrdV6Wxs13qz7+o6zxJeVLErfv+FKEjgxS16J
	 7DaIBAtMEJ8BnFAzdnI/eEGQ9EFe1MRZxVxWyzN6cVW47hJjMKBgbS7SRviMNvKNnD
	 ZTMw3hZZRAFeSuwFnSEbvdvjcAdvmR69NYxEltQg=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	vdso@mailbox.org,
	ssengar@linux.microsoft.com
Subject: [PATCH v2 07/15] arm64: hyperv: Add support for mshv_vtl_return_call
Date: Thu, 23 Apr 2026 12:41:57 +0000
Message-ID: <20260423124206.2410879-8-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423124206.2410879-1-namjain@linux.microsoft.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org,mailbox.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-10331-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:server fail];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,linux.microsoft.com:dkim,linux.microsoft.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 389284523CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the arm64 variant of mshv_vtl_return_call() to support the MSHV_VTL
driver on arm64. This function enables the transition between Virtual
Trust Levels (VTLs) in MSHV_VTL when the kernel acts as a paravisor.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Roman Kisel <vdso@mailbox.org>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/arm64/hyperv/Makefile        |   1 +
 arch/arm64/hyperv/hv_vtl.c        | 158 ++++++++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h |  13 +++
 arch/x86/include/asm/mshyperv.h   |   2 -
 drivers/hv/mshv_vtl.h             |   3 +
 include/asm-generic/mshyperv.h    |   2 +
 6 files changed, 177 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/hyperv/hv_vtl.c

diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
index 87c31c001da9..9701a837a6e1 100644
--- a/arch/arm64/hyperv/Makefile
+++ b/arch/arm64/hyperv/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y		:= hv_core.o mshyperv.o
+obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
new file mode 100644
index 000000000000..59cbeb74e7b9
--- /dev/null
+++ b/arch/arm64/hyperv/hv_vtl.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026, Microsoft, Inc.
+ *
+ * Authors:
+ *     Roman Kisel <romank@linux.microsoft.com>
+ *     Naman Jain <namjain@linux.microsoft.com>
+ */
+
+#include <asm/mshyperv.h>
+#include <asm/neon.h>
+#include <linux/export.h>
+
+void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
+{
+	struct user_fpsimd_state fpsimd_state;
+	u64 base_ptr = (u64)vtl0->x;
+
+	/*
+	 * Obtain the CPU FPSIMD registers for VTL context switch.
+	 * This saves the current task's FP/NEON state and allows us to
+	 * safely load VTL0's FP/NEON context for the hypercall.
+	 */
+	kernel_neon_begin(&fpsimd_state);
+
+	/*
+	 * VTL switch for ARM64 platform - managing VTL0's CPU context.
+	 * We explicitly use the stack to save the base pointer, and use x16
+	 * as our working register for accessing the context structure.
+	 *
+	 * Register Handling:
+	 * - X0-X17: Saved/restored (general-purpose, shared for VTL communication)
+	 * - X18: NOT touched - hypervisor-managed per-VTL (platform register)
+	 * - X19-X30: Saved/restored (part of VTL0's execution context)
+	 * - Q0-Q31: Saved/restored (128-bit NEON/floating-point registers, shared)
+	 * - SP: Not in structure, hypervisor-managed per-VTL
+	 *
+	 * X29 (FP) and X30 (LR) are in the structure and must be saved/restored
+	 * as part of VTL0's complete execution state.
+	 */
+	asm __volatile__ (
+		/* Save base pointer to stack explicitly, then load into x16 */
+		"str %0, [sp, #-16]!\n\t"     /* Push base pointer onto stack */
+		"mov x16, %0\n\t"             /* Load base pointer into x16 */
+		/* Volatile registers (Windows ARM64 ABI: x0-x17) */
+		"ldp x0, x1, [x16]\n\t"
+		"ldp x2, x3, [x16, #(2*8)]\n\t"
+		"ldp x4, x5, [x16, #(4*8)]\n\t"
+		"ldp x6, x7, [x16, #(6*8)]\n\t"
+		"ldp x8, x9, [x16, #(8*8)]\n\t"
+		"ldp x10, x11, [x16, #(10*8)]\n\t"
+		"ldp x12, x13, [x16, #(12*8)]\n\t"
+		"ldp x14, x15, [x16, #(14*8)]\n\t"
+		/* x16 will be loaded last, after saving base pointer */
+		"ldr x17, [x16, #(17*8)]\n\t"
+		/* x18 is hypervisor-managed per-VTL - DO NOT LOAD */
+
+		/* General-purpose registers: x19-x30 */
+		"ldp x19, x20, [x16, #(19*8)]\n\t"
+		"ldp x21, x22, [x16, #(21*8)]\n\t"
+		"ldp x23, x24, [x16, #(23*8)]\n\t"
+		"ldp x25, x26, [x16, #(25*8)]\n\t"
+		"ldp x27, x28, [x16, #(27*8)]\n\t"
+
+		/* Frame pointer and link register */
+		"ldp x29, x30, [x16, #(29*8)]\n\t"
+
+		/* Shared NEON/FP registers: Q0-Q31 (128-bit) */
+		"ldp q0, q1, [x16, #(32*8)]\n\t"
+		"ldp q2, q3, [x16, #(32*8 + 2*16)]\n\t"
+		"ldp q4, q5, [x16, #(32*8 + 4*16)]\n\t"
+		"ldp q6, q7, [x16, #(32*8 + 6*16)]\n\t"
+		"ldp q8, q9, [x16, #(32*8 + 8*16)]\n\t"
+		"ldp q10, q11, [x16, #(32*8 + 10*16)]\n\t"
+		"ldp q12, q13, [x16, #(32*8 + 12*16)]\n\t"
+		"ldp q14, q15, [x16, #(32*8 + 14*16)]\n\t"
+		"ldp q16, q17, [x16, #(32*8 + 16*16)]\n\t"
+		"ldp q18, q19, [x16, #(32*8 + 18*16)]\n\t"
+		"ldp q20, q21, [x16, #(32*8 + 20*16)]\n\t"
+		"ldp q22, q23, [x16, #(32*8 + 22*16)]\n\t"
+		"ldp q24, q25, [x16, #(32*8 + 24*16)]\n\t"
+		"ldp q26, q27, [x16, #(32*8 + 26*16)]\n\t"
+		"ldp q28, q29, [x16, #(32*8 + 28*16)]\n\t"
+		"ldp q30, q31, [x16, #(32*8 + 30*16)]\n\t"
+
+		/* Now load x16 itself */
+		"ldr x16, [x16, #(16*8)]\n\t"
+
+		/* Return to the lower VTL */
+		"hvc #3\n\t"
+
+		/* Save context after return - reload base pointer from stack */
+		"stp x16, x17, [sp, #-16]!\n\t" /* Save x16, x17 temporarily */
+		"ldr x16, [sp, #16]\n\t"        /* Reload base pointer (skip saved x16,x17) */
+
+		/* Volatile registers */
+		"stp x0, x1, [x16]\n\t"
+		"stp x2, x3, [x16, #(2*8)]\n\t"
+		"stp x4, x5, [x16, #(4*8)]\n\t"
+		"stp x6, x7, [x16, #(6*8)]\n\t"
+		"stp x8, x9, [x16, #(8*8)]\n\t"
+		"stp x10, x11, [x16, #(10*8)]\n\t"
+		"stp x12, x13, [x16, #(12*8)]\n\t"
+		"stp x14, x15, [x16, #(14*8)]\n\t"
+		"ldp x0, x1, [sp], #16\n\t"      /* Recover saved x16, x17 */
+		"stp x0, x1, [x16, #(16*8)]\n\t"
+		/* x18 is hypervisor-managed - DO NOT SAVE */
+
+		/* General-purpose registers: x19-x30 */
+		"stp x19, x20, [x16, #(19*8)]\n\t"
+		"stp x21, x22, [x16, #(21*8)]\n\t"
+		"stp x23, x24, [x16, #(23*8)]\n\t"
+		"stp x25, x26, [x16, #(25*8)]\n\t"
+		"stp x27, x28, [x16, #(27*8)]\n\t"
+		"stp x29, x30, [x16, #(29*8)]\n\t"  /* Frame pointer and link register */
+
+		/* Shared NEON/FP registers: Q0-Q31 (128-bit) */
+		"stp q0, q1, [x16, #(32*8)]\n\t"
+		"stp q2, q3, [x16, #(32*8 + 2*16)]\n\t"
+		"stp q4, q5, [x16, #(32*8 + 4*16)]\n\t"
+		"stp q6, q7, [x16, #(32*8 + 6*16)]\n\t"
+		"stp q8, q9, [x16, #(32*8 + 8*16)]\n\t"
+		"stp q10, q11, [x16, #(32*8 + 10*16)]\n\t"
+		"stp q12, q13, [x16, #(32*8 + 12*16)]\n\t"
+		"stp q14, q15, [x16, #(32*8 + 14*16)]\n\t"
+		"stp q16, q17, [x16, #(32*8 + 16*16)]\n\t"
+		"stp q18, q19, [x16, #(32*8 + 18*16)]\n\t"
+		"stp q20, q21, [x16, #(32*8 + 20*16)]\n\t"
+		"stp q22, q23, [x16, #(32*8 + 22*16)]\n\t"
+		"stp q24, q25, [x16, #(32*8 + 24*16)]\n\t"
+		"stp q26, q27, [x16, #(32*8 + 26*16)]\n\t"
+		"stp q28, q29, [x16, #(32*8 + 28*16)]\n\t"
+		"stp q30, q31, [x16, #(32*8 + 30*16)]\n\t"
+
+		/* Clean up stack - pop base pointer */
+		"add sp, sp, #16\n\t"
+
+		: /* No outputs */
+		: /* Input */ "r"(base_ptr)
+		: /* Clobber list - x16 used as base, x18 is hypervisor-managed (not touched) */
+		"memory", "cc",
+		"x0", "x1", "x2", "x3", "x4", "x5",
+		"x6", "x7", "x8", "x9", "x10", "x11", "x12", "x13",
+		"x14", "x15", "x16", "x17", "x19", "x20", "x21",
+		"x22", "x23", "x24", "x25", "x26", "x27", "x28",
+		"x29", "x30",
+		"v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
+		"v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15",
+		"v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+		"v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
+
+	/*
+	 * Restore the task's FP/SIMD state and return CPU FPSIMD registers
+	 * back to normal kernel use.
+	 */
+	kernel_neon_end(&fpsimd_state);
+}
+EXPORT_SYMBOL(mshv_vtl_return_call);
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 585b23a26f1b..9eb0e5999f29 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -60,6 +60,18 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
 				ARM_SMCCC_SMC_64,		\
 				ARM_SMCCC_OWNER_VENDOR_HYP,	\
 				HV_SMCCC_FUNC_NUMBER)
+
+struct mshv_vtl_cpu_context {
+/*
+ * x18 is managed by the hypervisor. It won't be reloaded from this array.
+ * It is included here for convenience in array indexing.
+ * 'rsvd' field serves as alignment padding so q[] starts at offset 32*8=256.
+ */
+	__u64 x[31];
+	__u64 rsvd;
+	__uint128_t q[32];
+};
+
 #ifdef CONFIG_HYPERV_VTL_MODE
 /*
  * Get/Set the register. If the function returns `1`, that must be done via
@@ -69,6 +81,7 @@ static inline int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, b
 {
 	return 1;
 }
+
 #endif
 
 #include <asm-generic/mshyperv.h>
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 08278547b84c..b4d80c9a673a 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -286,7 +286,6 @@ struct mshv_vtl_cpu_context {
 #ifdef CONFIG_HYPERV_VTL_MODE
 void __init hv_vtl_init_platform(void);
 int __init hv_vtl_early_init(void);
-void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
 void mshv_vtl_return_call_init(u64 vtl_return_offset);
 void mshv_vtl_return_hypercall(void);
 void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
@@ -294,7 +293,6 @@ int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, bool shared);
 #else
 static inline void __init hv_vtl_init_platform(void) {}
 static inline int __init hv_vtl_early_init(void) { return 0; }
-static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
 static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
 static inline void mshv_vtl_return_hypercall(void) {}
 static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
diff --git a/drivers/hv/mshv_vtl.h b/drivers/hv/mshv_vtl.h
index a6eea52f7aa2..103f07371f3f 100644
--- a/drivers/hv/mshv_vtl.h
+++ b/drivers/hv/mshv_vtl.h
@@ -22,4 +22,7 @@ struct mshv_vtl_run {
 	char vtl_ret_actions[MSHV_MAX_RUN_MSG_SIZE];
 };
 
+static_assert(sizeof(struct mshv_vtl_cpu_context) <= 1024,
+	      "struct mshv_vtl_cpu_context exceeds reserved space in struct mshv_vtl_run");
+
 #endif /* _MSHV_VTL_H */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index db183c8cfb95..8cdf2a9fbdfb 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -396,8 +396,10 @@ static inline int hv_deposit_memory(u64 partition_id, u64 status)
 
 #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
 u8 __init get_vtl(void);
+void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
 #else
 static inline u8 get_vtl(void) { return 0; }
+static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
 #endif
 
 #endif
-- 
2.43.0


