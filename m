Return-Path: <linux-hyperv+bounces-7492-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BF1C4C570
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 09:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6DF18C30F6
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5B304BBD;
	Tue, 11 Nov 2025 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pN/V+5ZT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FC30276E;
	Tue, 11 Nov 2025 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848864; cv=none; b=KHEOblUtz0vnilnBikDjTmmdpFVVjG0uEsTlxKazOu6WZ3fnsTGG3Mwd3wn7jv6Iac5IrhvXQzAMw7r3TemBRVT7TWL7KAJEBPb/SyKgicLtz8mHQvuBVxq2bRWS0vwQq8gSs+qu/b6g4ysX+ITqg4z9l7tSkLuEcpKpBtxvjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848864; c=relaxed/simple;
	bh=mc89PyX6k0lhBB4UkT1+3ClDxgEniubu4F1Fkjs/LuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjNHlYmzfTQp4Vx2xL9IGvXM/eyFEsJUqmrcE4y3PC1o+416UYbDmlUdP/YqhYBiGYCDyjji5e6KehsfRW+q0ccCaU4xZu0sf7gNI/cZ+qqG5oS8N96/9BjBcI1jRJr9Mf/Tn4j0KCf73BA58arTqOQLfIVywjJ1GBISzSDpSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pN/V+5ZT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jevT/XdEeqW2k2hgirlR/LhD3OX3s/gUt6YJDM9AbWs=; b=pN/V+5ZT0Mi0HqM1r9J/UN0lgE
	1KRc0/e9dvDUdV616SzHrmb+U/VI2HyRZpuWn/bVI7VFo7LVUXdLLhbyaJ+ehMLGiVSkZCesqA0/H
	St/nJeCAAPb1AwGAhqf5QywnPVR1JqdDJ5Em4Hbwz1RdmpEls/PUw46xaFF38ldF/v/yfaGDsYFCA
	xpVeVIACyCKfltXOWOqIzXqwyZXEv2qEzy0Zp4ig1a5KDSAKWL7LtO9x45gDz7B6hZvHxRQO+xBGe
	wFJdCZBhz/OsbSKK5jn02lda6V72oqvoh6EhsWgm0XVEjpzvfNSX6yR3rtN4Elm8BzeOv6W3tliqZ
	KrHX/LrQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIie1-0000000CccX-3Vo0;
	Tue, 11 Nov 2025 07:18:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4BBCF300328; Tue, 11 Nov 2025 09:13:52 +0100 (CET)
Date: Tue, 11 Nov 2025 09:13:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
Message-ID: <20251111081352.GD278048@noisy.programming.kicks-ass.net>
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com>
 <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
 <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>

On Tue, Nov 11, 2025 at 12:25:54PM +0530, Naman Jain wrote:

> This would have been the cleanest approach. We discussed this before and
> unfortunately it didn't work. Please find the link to this discussion:
> 
> https://lore.kernel.org/all/9f8007a3-f810-4b60-8942-e721cd6a32c4@linux.microsoft.com/
> 
> To summarize above discussion, I see below compilation error with this from
> objtool. You may have CONFIG_X86_KERNEL_IBT enabled in your workspace, which
> would have masked this.

IBT isn't the problem, the thing is running objtool on vmlinux.o vs the
individual translation units. vmlinux.o will have that symbol, while
your .S file doesn't.

>   AS      arch/x86/hyperv/mshv_vtl_asm.o
> arch/x86/hyperv/mshv_vtl_asm.o: error: objtool: static_call: can't find
> static_call_key symbol: __SCK____mshv_vtl_return_hypercall

Right, and I said you had to do that ADDRESSABLE thing. So I added a
DECLARE_STATIC_CALL() and a static_call() in hv.c, compiled it so .s and
stole the bits.

And then you get something like the below. See symbol 5, that's the
entry we need.

# readelf -sW defconfig-build/arch/x86/hyperv/mshv_vtl_asm.o

Symbol table '.symtab' contains 8 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
     1: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    6 __UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0
     2: 0000000000000000     0 SECTION LOCAL  DEFAULT    4 .noinstr.text
     3: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __SCT____mshv_vtl_return_hypercall
     4: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __x86_return_thunk
     5: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __SCK____mshv_vtl_return_hypercall
     6: 0000000000000010   179 FUNC    GLOBAL DEFAULT    4 __mshv_vtl_return_call
     7: 0000000000000000    16 FUNC    GLOBAL DEFAULT    4 __pfx___mshv_vtl_return_call


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
@@ -96,3 +97,10 @@ SYM_FUNC_START(__mshv_vtl_return_call)
 	pop %rbp
 	RET
 SYM_FUNC_END(__mshv_vtl_return_call)
+
+	.section	.discard.addressable,"aw"
+	.align 8
+	.type	__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0, @object
+	.size	__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0, 8
+__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0:
+	.quad	__SCK____mshv_vtl_return_hypercall
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

