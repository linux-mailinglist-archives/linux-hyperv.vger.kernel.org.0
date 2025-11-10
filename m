Return-Path: <linux-hyperv+bounces-7485-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C804C47407
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 15:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AAB188C6EA
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E6030F7FA;
	Mon, 10 Nov 2025 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jscf0fTR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406461B6CE9;
	Mon, 10 Nov 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785532; cv=none; b=sMDpx6TkbtmQfe3+v7zCd2+CmS4O417UCwmwv47ZY57n5DjIKeVBL5ZSD4US/lG3OLvpbvvO7Nl78ln/IN0x2St4sC6jcShcILTaRnJb9FjBxnByze5sE5qYVcC+C6iqN5glI8oqLhIF2SkB7A538adUDqqbpul70JSu8Tn4JGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785532; c=relaxed/simple;
	bh=UsKjxAL2LPy2yNLKEDn3n35MVidv0ryfzg45RZ9Rgas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qen55vHV9wBMvUpxAvb2YfyMD7KF3kOhuALS3JVBQ7/w7aAxhOZfceJVAUOSWMBKJl+QkCkjXqQAA15Y2ZxfC/QTk7S47X7cwbU4qY0ysbEUv4R/HLhjXBlSSNWhn9NQrJb728EdnMQN+Pw8efddoKPJYOo3m1R0hbxWHSePEIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jscf0fTR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YvXHkeUUsN5uNR8rQTP501eTfQfHtLbVepXDnEN8LK0=; b=jscf0fTREh9hRe4xppgI9DN8pc
	ITSXzSq6rC/cNY1eKz84xIeDD7O3zQEHV1F8uGdac2NCBTeGD2yBJ7N3yEvrBIWNOCAmyskV8QkiY
	T01G/CNwOy+mEQP5fJk+M3mv+BZExJ81TJVFahoARJ6k5gHk5t2O+A3c34o7V0yVfXW48Odp6sxN6
	Gxbhzg7FmycwJnPL0YhCD97Wj3RQ7xBo1cvjEN36VpIDTTi4MaAO5HDer510dai/WSPLHVttLRNAz
	hGpV5gzQjP8hHDAfRy1K37pqUP01ORg0OSwSWYTXHq2K7lEPS4zj0VcHMsjF/cABziNWqxAqWLcMn
	31eMuDaA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIT2R-0000000HPym-3FUy;
	Mon, 10 Nov 2025 14:38:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C3F1630029E; Mon, 10 Nov 2025 15:38:34 +0100 (CET)
Date: Mon, 10 Nov 2025 15:38:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
Message-ID: <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110050835.1603847-3-namjain@linux.microsoft.com>

On Mon, Nov 10, 2025 at 05:08:35AM +0000, Naman Jain wrote:
> Provide an interface for Virtual Machine Monitor like OpenVMM and its
> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
> Expose devices and support IOCTLs for features like VTL creation,
> VTL0 memory management, context switch, making hypercalls,
> mapping VTL0 address space to VTL2 userspace, getting new VMBus
> messages and channel events in VTL2 etc.

> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 042e8712d8de..dba27e1bcc10 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -249,3 +253,42 @@ int __init hv_vtl_early_init(void)
>  
>  	return 0;
>  }
> +
> +DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
> +
> +noinstr void mshv_vtl_return_hypercall(void)
> +{
> +	asm volatile ("call " STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall));
> +}
> +
> +/*
> + * ASM_CALL_CONSTRAINT is intentionally not used in above asm block before making a call to
> + * __mshv_vtl_return_hypercall, to avoid rbp clobbering before actual VTL return happens.
> + * This however leads to objtool complain about "call without frame pointer save/setup".
> + * To ignore that warning, and inform objtool about this non-standard function,
> + * STACK_FRAME_NON_STANDARD_FP is used.
> + */
> +STACK_FRAME_NON_STANDARD_FP(mshv_vtl_return_hypercall);

> --- /dev/null
> +++ b/arch/x86/hyperv/mshv_vtl_asm.S
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Assembly level code for mshv_vtl VTL transition
> + *
> + * Copyright (c) 2025, Microsoft Corporation.
> + *
> + * Author:
> + *   Naman Jain <namjain@microsoft.com>
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/frame.h>
> +#include "mshv-asm-offsets.h"
> +
> +	.text
> +	.section .noinstr.text, "ax"
> +/*
> + * void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)

Can we please get a few words on the magical context here? Like no NMIs
and #DB traps and the like. Because if any of them were possible this
code would be horribly broken.

> + */
> +SYM_FUNC_START(__mshv_vtl_return_call)
> +	/* Push callee save registers */
> +	pushq %rbp
> +	mov %rsp, %rbp
> +	pushq %r12
> +	pushq %r13
> +	pushq %r14
> +	pushq %r15
> +	pushq %rbx
> +
> +	/* register switch to VTL0 clobbers all registers except rax/rcx */
> +	mov %_ASM_ARG1, %rax
> +
> +	/* grab rbx/rbp/rsi/rdi/r8-r15 */
> +	mov MSHV_VTL_CPU_CONTEXT_rbx(%rax), %rbx
> +	mov MSHV_VTL_CPU_CONTEXT_rbp(%rax), %rbp
> +	mov MSHV_VTL_CPU_CONTEXT_rsi(%rax), %rsi
> +	mov MSHV_VTL_CPU_CONTEXT_rdi(%rax), %rdi
> +	mov MSHV_VTL_CPU_CONTEXT_r8(%rax), %r8
> +	mov MSHV_VTL_CPU_CONTEXT_r9(%rax), %r9
> +	mov MSHV_VTL_CPU_CONTEXT_r10(%rax), %r10
> +	mov MSHV_VTL_CPU_CONTEXT_r11(%rax), %r11
> +	mov MSHV_VTL_CPU_CONTEXT_r12(%rax), %r12
> +	mov MSHV_VTL_CPU_CONTEXT_r13(%rax), %r13
> +	mov MSHV_VTL_CPU_CONTEXT_r14(%rax), %r14
> +	mov MSHV_VTL_CPU_CONTEXT_r15(%rax), %r15
> +
> +	mov MSHV_VTL_CPU_CONTEXT_cr2(%rax), %rdx
> +	mov %rdx, %cr2
> +	mov MSHV_VTL_CPU_CONTEXT_rdx(%rax), %rdx
> +
> +	/* stash host registers on stack */
> +	pushq %rax
> +	pushq %rcx
> +
> +	xor %ecx, %ecx
> +
> +	/* make a hypercall to switch VTL */
> +	call mshv_vtl_return_hypercall

Yuck!

This seems to build for me.

---
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -256,20 +256,6 @@ int __init hv_vtl_early_init(void)
 
 DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
 
-noinstr void mshv_vtl_return_hypercall(void)
-{
-	asm volatile ("call " STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall));
-}
-
-/*
- * ASM_CALL_CONSTRAINT is intentionally not used in above asm block before making a call to
- * __mshv_vtl_return_hypercall, to avoid rbp clobbering before actual VTL return happens.
- * This however leads to objtool complain about "call without frame pointer save/setup".
- * To ignore that warning, and inform objtool about this non-standard function,
- * STACK_FRAME_NON_STANDARD_FP is used.
- */
-STACK_FRAME_NON_STANDARD_FP(mshv_vtl_return_hypercall);
-
 void mshv_vtl_return_call_init(u64 vtl_return_offset)
 {
 	static_call_update(__mshv_vtl_return_hypercall,
--- a/arch/x86/hyperv/mshv_vtl_asm.S
+++ b/arch/x86/hyperv/mshv_vtl_asm.S
@@ -9,6 +9,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/static_call_types.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/frame.h>
@@ -57,7 +58,7 @@ SYM_FUNC_START(__mshv_vtl_return_call)
 	xor %ecx, %ecx
 
 	/* make a hypercall to switch VTL */
-	call mshv_vtl_return_hypercall
+	call STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall)
 
 	/* stash guest registers on stack, restore saved host copies */
 	pushq %rax
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -11,6 +11,10 @@
 #define __has_builtin(x) (0)
 #endif
 
+/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
+#define ___PASTE(a,b) a##b
+#define __PASTE(a,b) ___PASTE(a,b)
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -79,10 +83,6 @@ static inline void __chk_io_ptr(const vo
 # define __builtin_warning(x, y...) (1)
 #endif /* __CHECKER__ */
 
-/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
-#define ___PASTE(a,b) a##b
-#define __PASTE(a,b) ___PASTE(a,b)
-
 #ifdef __KERNEL__
 
 /* Attributes */
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -25,6 +25,8 @@
 #define STATIC_CALL_SITE_INIT 2UL	/* init section */
 #define STATIC_CALL_SITE_FLAGS 3UL
 
+#ifndef __ASSEMBLY__
+
 /*
  * The static call site table needs to be created by external tooling (objtool
  * or a compiler plugin).
@@ -100,4 +102,6 @@ struct static_call_key {
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* _STATIC_CALL_TYPES_H */

