Return-Path: <linux-hyperv+bounces-2177-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D58C87FB
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22ACB287451
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C178C69;
	Fri, 17 May 2024 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RURYOxlF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52A7580D;
	Fri, 17 May 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955611; cv=none; b=aKNW583Fp9ekvt2pbSvlZRpGakfl2tUhnLrrlwsK/k6Kwn6gZE1KifQVjv5x1EcVcRehzjvL0Doqdav3Zt+cSDG8BFxgRipQqTQ9qNrN9mtU/XLcDqIzrYTxbkPBtPQUMoOHNdJvr4s5R1jiDXsTdgdhQ/XtQJ44iMT6vP1YIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955611; c=relaxed/simple;
	bh=le6yIb+KkrwbWU/kef10H7UOenEhvxZ9rTsGqSJuqRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUePCu9cjVbAjQucJsmCJ6/JT7UaKzy9zzPyr9qGv1ZhPKwSlsT6YEDB4Ru5fPivW+eVRZzxueEVeSfPSVlBkHKR7gBqW4TM3sxy+R2n40FOxtWf8uBZzbBaybpfa4GceUbYbiKzB01GJax32NcRM6StodyRtiLYU5HMMpG0dj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RURYOxlF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955609; x=1747491609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=le6yIb+KkrwbWU/kef10H7UOenEhvxZ9rTsGqSJuqRQ=;
  b=RURYOxlFawyAhJ4YY7UuHe/LjILJuNLfMOV3pAdn2rfi21NPpi8KAMQg
   aDwdxEsZsdXwWCGrl+sIo8wA8Y7STLXY3w4g4NXgQvaIEPytlUP4T+92Y
   UjTDk6FqNzctXlP3Yxd0/qi8/Mt0bkf/zuyineeCoRgWLULrZ/2SGu/Fy
   PhgGm8v2PNSBpY4JUXVUiyc2tOTE5ync05+faSvDUb/RdB9JkFwp4QUvH
   WEe2jM8vVN9AX0cRkyq+pt6E0+/rfojNGW4tvk+mFKzBYxjVmSEUUH1Dx
   O3MejvTax5r2ud4d6Fbh68UPchDoYaBecPVBOFK1z6mnA9sw3lQbeU/YP
   A==;
X-CSE-ConnectionGUID: aFyu5bW+QCixFcncv4lcJA==
X-CSE-MsgGUID: uhM4qc6VT5mCowsVpz82rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808782"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808782"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:05 -0700
X-CSE-ConnectionGUID: 8b0g7edORxeleq05MX/vxg==
X-CSE-MsgGUID: pFaPFft6R127eW8Oa6P7+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="69253428"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 17 May 2024 07:20:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A86DD125F; Fri, 17 May 2024 17:19:50 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 20/20] x86/tdx: Remove old TDCALL wrappers
Date: Fri, 17 May 2024 17:19:38 +0300
Message-ID: <20240517141938.4177174-21-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240517141938.4177174-1-kirill.shutemov@linux.intel.com>
References: <20240517141938.4177174-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All code has been converted to new TDCALL wrappers.

Drop the old wrappers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/tdx.c    |  6 ----
 arch/x86/coco/tdx/tdcall.S        | 60 ++-----------------------------
 arch/x86/coco/tdx/tdx-shared.c    | 20 -----------
 arch/x86/coco/tdx/tdx.c           | 18 ----------
 arch/x86/include/asm/shared/tdx.h | 43 +---------------------
 arch/x86/virt/vmx/tdx/tdxcall.S   | 29 +++++----------
 tools/objtool/noreturns.h         |  1 -
 7 files changed, 12 insertions(+), 165 deletions(-)

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 0ae05edc7d42..b74084a46f2f 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -10,12 +10,6 @@
 
 #include <asm/shared/tdx.h>
 
-/* Called from __tdx_hypercall() for unrecoverable failure */
-void __tdx_hypercall_failed(void)
-{
-	error("TDVMCALL failed. TDX module bug?");
-}
-
 static inline unsigned int tdx_io_in(int size, u16 port)
 {
 	u64 out;
diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 5b60b9c8799f..407e2b7ae515 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -1,66 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/asm-offsets.h>
 #include <asm/asm.h>
+#include <asm/shared/tdx.h>
 
 #include <linux/linkage.h>
-#include <linux/errno.h>
 
-#include "../../virt/vmx/tdx/tdxcall.S"
-
-.section .noinstr.text, "ax"
-
-/*
- * __tdcall()  - Used by TDX guests to request services from the TDX
- * module (does not include VMM services) using TDCALL instruction.
- *
- * __tdcall() function ABI:
- *
- * @fn   (RDI)	- TDCALL Leaf ID, moved to RAX
- * @args (RSI)	- struct tdx_module_args for input
- *
- * Only RCX/RDX/R8-R11 are used as input registers.
- *
- * Return status of TDCALL via RAX.
- */
-SYM_FUNC_START(__tdcall)
-	TDX_MODULE_CALL host=0
-SYM_FUNC_END(__tdcall)
-
-/*
- * __tdcall_ret() - Used by TDX guests to request services from the TDX
- * module (does not include VMM services) using TDCALL instruction, with
- * saving output registers to the 'struct tdx_module_args' used as input.
- *
- * __tdcall_ret() function ABI:
- *
- * @fn   (RDI)	- TDCALL Leaf ID, moved to RAX
- * @args (RSI)	- struct tdx_module_args for input and output
- *
- * Only RCX/RDX/R8-R11 are used as input/output registers.
- *
- * Return status of TDCALL via RAX.
- */
-SYM_FUNC_START(__tdcall_ret)
-	TDX_MODULE_CALL host=0 ret=1
-SYM_FUNC_END(__tdcall_ret)
-
-/*
- * __tdcall_saved_ret() - Used by TDX guests to request services from the
- * TDX module (including VMM services) using TDCALL instruction, with
- * saving output registers to the 'struct tdx_module_args' used as input.
- *
- * __tdcall_saved_ret() function ABI:
- *
- * @fn   (RDI)	- TDCALL leaf ID, moved to RAX
- * @args (RSI)	- struct tdx_module_args for input/output
- *
- * All registers in @args are used as input/output registers.
- *
- * On successful completion, return the hypercall error code.
- */
-SYM_FUNC_START(__tdcall_saved_ret)
-	TDX_MODULE_CALL host=0 ret=1 saved=1
-SYM_FUNC_END(__tdcall_saved_ret)
+/* TDCALL is supported in Binutils >= 2.36 */
+#define tdcall		.byte 0x66,0x0f,0x01,0xcc
 
 /*
  * tdvmcall_trampoline() - Wrapper for TDG.VP.VMCALL. Covers common cases: up
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index 9104e96eeefd..b181f7d4d3b9 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -69,23 +69,3 @@ bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
 
 	return true;
 }
-
-noinstr u64 __tdx_hypercall(struct tdx_module_args *args)
-{
-	/*
-	 * For TDVMCALL explicitly set RCX to the bitmap of shared registers.
-	 * The caller isn't expected to set @args->rcx anyway.
-	 */
-	args->rcx = TDVMCALL_EXPOSE_REGS_MASK;
-
-	/*
-	 * Failure of __tdcall_saved_ret() indicates a failure of the TDVMCALL
-	 * mechanism itself and that something has gone horribly wrong with
-	 * the TDX module.  __tdx_hypercall_failed() never returns.
-	 */
-	if (__tdcall_saved_ret(TDG_VP_VMCALL, args))
-		__tdx_hypercall_failed();
-
-	/* TDVMCALL leaf return code is in R10 */
-	return args->r10;
-}
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 45be53d5eeb4..7d9306bd67af 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -38,13 +38,6 @@
 
 static atomic_long_t nr_shared;
 
-/* Called from __tdx_hypercall() for unrecoverable failure */
-noinstr void __noreturn __tdx_hypercall_failed(void)
-{
-	instrumentation_begin();
-	panic("TDVMCALL failed. TDX module bug?");
-}
-
 #ifdef CONFIG_KVM_GUEST
 long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 		       unsigned long p3, unsigned long p4)
@@ -62,17 +55,6 @@ long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
 #endif
 
-/*
- * Used for TDX guests to make calls directly to the TD module.  This
- * should only be used for calls that have no legitimate reason to fail
- * or where the kernel can not survive the call failing.
- */
-static inline void tdcall(u64 fn, struct tdx_module_args *args)
-{
-	if (__tdcall_ret(fn, args))
-		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
-}
-
 /* Read TD-scoped metadata */
 static inline u64 tdg_vm_rd(u64 field, u64 *value)
 {
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 70190ebc63ca..cbbc679d64a2 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -55,17 +55,6 @@
 #define TDX_R14		BIT(14)
 #define TDX_R15		BIT(15)
 
-/*
- * These registers are clobbered to hold arguments for each
- * TDVMCALL. They are safe to expose to the VMM.
- * Each bit in this mask represents a register ID. Bit field
- * details can be found in TDX GHCI specification, section
- * titled "TDCALL [TDG.VP.VMCALL] leaf".
- */
-#define TDVMCALL_EXPOSE_REGS_MASK	\
-	(TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
-	 TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15)
-
 /* TDX supported page sizes from the TDX module ABI. */
 #define TDX_PS_4K	0
 #define TDX_PS_2M	1
@@ -193,7 +182,7 @@
 })
 
 /*
- * Used in __tdcall*() to gather the input/output registers' values of the
+ * Used in __seamcall*() to gather the input/output registers' values of the
  * TDCALL instruction when requesting services from the TDX module. This is a
  * software only structure and not part of the TDX module/VMM ABI
  */
@@ -216,36 +205,6 @@ struct tdx_module_args {
 	u64 rsi;
 };
 
-/* Used to communicate with the TDX module */
-u64 __tdcall(u64 fn, struct tdx_module_args *args);
-u64 __tdcall_ret(u64 fn, struct tdx_module_args *args);
-u64 __tdcall_saved_ret(u64 fn, struct tdx_module_args *args);
-
-/* Used to request services from the VMM */
-u64 __tdx_hypercall(struct tdx_module_args *args);
-
-/*
- * Wrapper for standard use of __tdx_hypercall with no output aside from
- * return code.
- */
-static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
-{
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = fn,
-		.r12 = r12,
-		.r13 = r13,
-		.r14 = r14,
-		.r15 = r15,
-	};
-
-	return __tdx_hypercall(&args);
-}
-
-
-/* Called from __tdx_hypercall() for unrecoverable failure */
-void __noreturn __tdx_hypercall_failed(void);
-
 bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
 
 /*
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index 016a2a1ec1d6..7ad2fc6ba9c8 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -4,33 +4,28 @@
 #include <asm/asm.h>
 #include <asm/tdx.h>
 
-/*
- * TDCALL and SEAMCALL are supported in Binutils >= 2.36.
- */
-#define tdcall		.byte 0x66,0x0f,0x01,0xcc
+/* SEAMCALL is supported in Binutils >= 2.36 */
 #define seamcall	.byte 0x66,0x0f,0x01,0xcf
 
 /*
  * TDX_MODULE_CALL - common helper macro for both
  *                 TDCALL and SEAMCALL instructions.
  *
- * TDCALL   - used by TDX guests to make requests to the
- *            TDX module and hypercalls to the VMM.
  * SEAMCALL - used by TDX hosts to make requests to the
  *            TDX module.
  *
  *-------------------------------------------------------------------------
- * TDCALL/SEAMCALL ABI:
+ * SEAMCALL ABI:
  *-------------------------------------------------------------------------
  * Input Registers:
  *
- * RAX                        - TDCALL/SEAMCALL Leaf number.
- * RCX,RDX,RDI,RSI,RBX,R8-R15 - TDCALL/SEAMCALL Leaf specific input registers.
+ * RAX                        - SEAMCALL Leaf number.
+ * RCX,RDX,RDI,RSI,RBX,R8-R15 - SEAMCALL Leaf specific input registers.
  *
  * Output Registers:
  *
- * RAX                        - TDCALL/SEAMCALL instruction error code.
- * RCX,RDX,RDI,RSI,RBX,R8-R15 - TDCALL/SEAMCALL Leaf specific output registers.
+ * RAX                        - SEAMCALL instruction error code.
+ * RCX,RDX,RDI,RSI,RBX,R8-R15 - SEAMCALL Leaf specific output registers.
  *
  *-------------------------------------------------------------------------
  *
@@ -42,7 +37,7 @@
  * also tramples on RDI,RSI.  This isn't strictly true, see for example
  * TDH.EXPORT.MEM.
  */
-.macro TDX_MODULE_CALL host:req ret=0 saved=0
+.macro TDX_MODULE_CALL ret=0 saved=0
 	FRAME_BEGIN
 
 	/* Move Leaf ID to RAX */
@@ -85,7 +80,6 @@
 	movq	TDX_MODULE_rsi(%rsi), %rsi
 .endif	/* \saved */
 
-.if \host
 .Lseamcall\@:
 	seamcall
 	/*
@@ -100,9 +94,6 @@
 	 * it is from the Reserved status code class.
 	 */
 	jc .Lseamcall_vmfailinvalid\@
-.else
-	tdcall
-.endif
 
 .if \ret
 .if \saved
@@ -172,11 +163,9 @@
 	xorl %r15d, %r15d
 	xorl %ebx,  %ebx
 	xorl %edi,  %edi
-.endif	/* \ret && \host */
+.endif	/* \saved && \ret */
 
-.if \host
 .Lout\@:
-.endif
 
 .if \saved
 	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
@@ -190,7 +179,6 @@
 	FRAME_END
 	RET
 
-.if \host
 .Lseamcall_vmfailinvalid\@:
 	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
 	jmp .Lseamcall_fail\@
@@ -215,6 +203,5 @@
 	jmp .Lout\@
 
 	_ASM_EXTABLE_FAULT(.Lseamcall\@, .Lseamcall_trap\@)
-.endif	/* \host */
 
 .endm
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 0670cacf0734..1e82a96ba960 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -11,7 +11,6 @@ NORETURN(__kunit_abort)
 NORETURN(__module_put_and_kthread_exit)
 NORETURN(__reiserfs_panic)
 NORETURN(__stack_chk_fail)
-NORETURN(__tdx_hypercall_failed)
 NORETURN(__ubsan_handle_builtin_unreachable)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
-- 
2.43.0


