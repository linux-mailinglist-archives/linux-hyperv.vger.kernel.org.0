Return-Path: <linux-hyperv+bounces-2195-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262A58C9B5B
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22B32813C1
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47254F5ED;
	Mon, 20 May 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gp5pLlaY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F153393;
	Mon, 20 May 2024 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201178; cv=none; b=eVeenmQ8o0i4So0shQjysD07JT116PxHUEIH9UI4/u9rEN4XoYC/maZEmtN2gA6fIcr0Vz3OHG/nn8FfLq79hoeXFIPbgkRwxqemaPcHbz7+BzJvnc7NKOtUelTPW3FBodvgcVf8vAmEViglTwlW8NM/JyGBvmL9/HqSyNZzTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201178; c=relaxed/simple;
	bh=0Hdic5RHbirr9hz/8h75QOTEX+N5EQdQiwaTcDyfSLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ1mp0ansYJHQ2oagaSHrXyMQGc62SSlVcKMPP9vOsQp9wT9BdW9ZIV6Aco8nVe8BlogNUcsI/50feMeKFOJegNmt+5J4RWOXc3fD9E0RY1DQdVzRpZ3lqqFMNSowmX4KNBAm4jrBHhzZqL+x+wYwyZSx/6YUVNosFoDcgffsKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gp5pLlaY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716201177; x=1747737177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Hdic5RHbirr9hz/8h75QOTEX+N5EQdQiwaTcDyfSLM=;
  b=Gp5pLlaYrTm+rP2rDzdwGGo4tY3w63U/+k1daolyTnFHaN5Cb9pL1eLY
   Drb9eAYn+J4wOOmhRCN/JnhjYtxt747cecMogSF0fqLBR6yTQrO2yBo0x
   4eztxnckrvb6+zTzGxLtTiGr8vGldCb0U70Vh17UyqyJa5exf/7JQcNCi
   Asq5renlGpZedPH+7IPrHXQX6eLgZmuLZ6CjE+9vt/DiQZBk30yFcpUaQ
   Qfx+JNaO/2ADITnapOZL1bZd5PyZM80amrirJ9Iop6c46SFAw0OaAYjJo
   u9d8RMY3s1wdKdczGnixG6WK/BzCjhwQmpr86QQGxppaJCnEzNLkUpRMw
   Q==;
X-CSE-ConnectionGUID: OQrc2/pKTb+RjPPfzFKkuA==
X-CSE-MsgGUID: zkzU84p8T62AGJS/CWA/Xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="34836006"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="34836006"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 03:32:57 -0700
X-CSE-ConnectionGUID: VTyPAUkJTzqkfxOCmFtoag==
X-CSE-MsgGUID: csLfqqpcSvqtWoOtTtxH8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32623237"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 20 May 2024 03:32:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 119C02AD; Mon, 20 May 2024 13:32:51 +0300 (EEST)
Date: Mon, 20 May 2024 13:32:51 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 01/20] x86/tdx: Introduce tdvmcall_trampoline()
Message-ID: <itsl2xhcrwotxrjpm7msfzc7mp73wk47pnwgyfcvbrioj3p3hn@2e7c4p4gtwh4>
References: <20240517141938.4177174-1-kirill.shutemov@linux.intel.com>
 <20240517141938.4177174-2-kirill.shutemov@linux.intel.com>
 <395850c4-f8a3-46ed-9b0c-b1f47386610c@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <395850c4-f8a3-46ed-9b0c-b1f47386610c@intel.com>

On Fri, May 17, 2024 at 08:21:37AM -0700, Dave Hansen wrote:
> On 5/17/24 07:19, Kirill A. Shutemov wrote:
> > TDCALL calls are centralized into a few megawrappers that take the
> > struct tdx_module_args as input. Most of the call sites only use a few
> > arguments, but they have to zero out unused fields in the structure to
> > avoid data leaks to the VMM. This leads to the compiler generating
> > inefficient code: dozens of instructions per call site to clear unused
> > fields of the structure.
> 
> I agree that this is what the silly compiler does in practice.  But my
> first preference for fixing it would just be an out-of-line memset() or
> a pretty bare REP;MOV.
> 
> In other words, I think this as the foundational justification for the
> rest of the series leaves a little to be desired.

See the patch below. Is it what you had in mind?

This patch saves ~2K of code, comparing to ~3K for my patchset:

add/remove: 0/0 grow/shrink: 1/17 up/down: 8/-2266 (-2258)

But it is considerably simpler.

 arch/x86/boot/compressed/tdx.c    |  32 ++++----
 arch/x86/coco/tdx/tdx-shared.c    |   3 +-
 arch/x86/coco/tdx/tdx.c           | 159 +++++++++++++++++++++-----------------
 arch/x86/hyperv/ivm.c             |  32 ++++----
 arch/x86/include/asm/shared/tdx.h |  25 ++++--
 5 files changed, 142 insertions(+), 109 deletions(-)

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 8451d6a1030c..a6784a9153e4 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -18,13 +18,14 @@ void __tdx_hypercall_failed(void)
 
 static inline unsigned int tdx_io_in(int size, u16 port)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
-		.r12 = size,
-		.r13 = 0,
-		.r14 = port,
-	};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION);
+	args.r12 = size;
+	args.r13 = 0;
+	args.r14 = port;
 
 	if (__tdx_hypercall(&args))
 		return UINT_MAX;
@@ -34,14 +35,15 @@ static inline unsigned int tdx_io_in(int size, u16 port)
 
 static inline void tdx_io_out(int size, u16 port, u32 value)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
-		.r12 = size,
-		.r13 = 1,
-		.r14 = port,
-		.r15 = value,
-	};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION);
+	args.r12 = size;
+	args.r13 = 1;
+	args.r14 = port;
+	args.r15 = value;
 
 	__tdx_hypercall(&args);
 }
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index 1655aa56a0a5..b8d1b3d940d2 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -5,7 +5,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 				    enum pg_level pg_level)
 {
 	unsigned long accept_size = page_level_size(pg_level);
-	struct tdx_module_args args = {};
+	struct tdx_module_args args;
 	u8 page_size;
 
 	if (!IS_ALIGNED(start, accept_size))
@@ -34,6 +34,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 		return 0;
 	}
 
+	tdx_arg_init(&args);
 	args.rcx = start | page_size;
 	if (__tdcall(TDG_MEM_PAGE_ACCEPT, &args))
 		return 0;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index cadd583d6f62..e8bb8afe04a9 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -53,13 +53,14 @@ noinstr void __noreturn __tdx_hypercall_failed(void)
 long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 		       unsigned long p3, unsigned long p4)
 {
-	struct tdx_module_args args = {
-		.r10 = nr,
-		.r11 = p1,
-		.r12 = p2,
-		.r13 = p3,
-		.r14 = p4,
-	};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
+	args.r10 = nr;
+	args.r11 = p1;
+	args.r12 = p2;
+	args.r13 = p3;
+	args.r14 = p4;
 
 	return __tdx_hypercall(&args);
 }
@@ -80,11 +81,12 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
 /* Read TD-scoped metadata */
 static inline u64 tdg_vm_rd(u64 field, u64 *value)
 {
-	struct tdx_module_args args = {
-		.rdx = field,
-	};
+	struct tdx_module_args args;
 	u64 ret;
 
+	tdx_arg_init(&args);
+	args.rdx = field,
+
 	ret = __tdcall_ret(TDG_VM_RD, &args);
 	*value = args.r8;
 
@@ -94,11 +96,12 @@ static inline u64 tdg_vm_rd(u64 field, u64 *value)
 /* Write TD-scoped metadata */
 static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
 {
-	struct tdx_module_args args = {
-		.rdx = field,
-		.r8 = value,
-		.r9 = mask,
-	};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
+	args.rdx = field;
+	args.r8 = value;
+	args.r9 = mask;
 
 	return __tdcall(TDG_VM_WR, &args);
 }
@@ -119,13 +122,14 @@ static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
  */
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 {
-	struct tdx_module_args args = {
-		.rcx = virt_to_phys(tdreport),
-		.rdx = virt_to_phys(reportdata),
-		.r8 = TDREPORT_SUBTYPE_0,
-	};
+	struct tdx_module_args args;
 	u64 ret;
 
+	tdx_arg_init(&args);
+	args.rcx = virt_to_phys(tdreport);
+	args.rdx = virt_to_phys(reportdata);
+	args.r8 = TDREPORT_SUBTYPE_0;
+
 	ret = __tdcall(TDG_MR_REPORT, &args);
 	if (ret) {
 		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
@@ -160,11 +164,7 @@ EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
 static void __noreturn tdx_panic(const char *msg)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = TDVMCALL_REPORT_FATAL_ERROR,
-		.r12 = 0, /* Error code: 0 is Panic */
-	};
+	struct tdx_module_args args;
 	union {
 		/* Define register order according to the GHCI */
 		struct { u64 r14, r15, rbx, rdi, rsi, r8, r9, rdx; };
@@ -175,6 +175,11 @@ static void __noreturn tdx_panic(const char *msg)
 	/* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
 	strtomem_pad(message.str, msg, '\0');
 
+	tdx_arg_init(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = TDVMCALL_REPORT_FATAL_ERROR;
+	args.r12 = 0; /* Error code: 0 is Panic */
+
 	args.r8  = message.r8;
 	args.r9  = message.r9;
 	args.r14 = message.r14;
@@ -277,10 +282,12 @@ static void enable_cpu_topology_enumeration(void)
 
 static void tdx_setup(u64 *cc_mask)
 {
-	struct tdx_module_args args = {};
+	struct tdx_module_args args;
 	unsigned int gpa_width;
 	u64 td_attr;
 
+	tdx_arg_init(&args);
+
 	/*
 	 * TDINFO TDX module call is used to get the TD execution environment
 	 * information like GPA width, number of available vcpus, debug mode
@@ -356,11 +363,12 @@ static int ve_instr_len(struct ve_info *ve)
 
 static u64 __cpuidle __halt(const bool irq_disabled)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_HLT),
-		.r12 = irq_disabled,
-	};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = hcall_func(EXIT_REASON_HLT);
+	args.r12 = irq_disabled;
 
 	/*
 	 * Emulate HLT operation via hypercall. More info about ABI
@@ -400,11 +408,12 @@ void __cpuidle tdx_safe_halt(void)
 
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_MSR_READ),
-		.r12 = regs->cx,
-	};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = hcall_func(EXIT_REASON_MSR_READ);
+	args.r12 = regs->cx;
 
 	/*
 	 * Emulate the MSR read via hypercall. More info about ABI
@@ -421,12 +430,13 @@ static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 
 static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_MSR_WRITE),
-		.r12 = regs->cx,
-		.r13 = (u64)regs->dx << 32 | regs->ax,
-	};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = hcall_func(EXIT_REASON_MSR_WRITE);
+	args.r12 = regs->cx;
+	args.r13 = (u64)regs->dx << 32 | regs->ax;
 
 	/*
 	 * Emulate the MSR write via hypercall. More info about ABI
@@ -441,12 +451,13 @@ static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 
 static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_CPUID),
-		.r12 = regs->ax,
-		.r13 = regs->cx,
-	};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = hcall_func(EXIT_REASON_CPUID);
+	args.r12 = regs->ax;
+	args.r13 = regs->cx;
 
 	/*
 	 * Only allow VMM to control range reserved for hypervisor
@@ -483,14 +494,15 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 
 static bool mmio_read(int size, unsigned long addr, unsigned long *val)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_EPT_VIOLATION),
-		.r12 = size,
-		.r13 = EPT_READ,
-		.r14 = addr,
-		.r15 = *val,
-	};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = hcall_func(EXIT_REASON_EPT_VIOLATION);
+	args.r12 = size;
+	args.r13 = EPT_READ;
+	args.r14 = addr;
+	args.r15 = *val;
 
 	if (__tdx_hypercall(&args))
 		return false;
@@ -612,16 +624,17 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
 static bool handle_in(struct pt_regs *regs, int size, int port)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
-		.r12 = size,
-		.r13 = PORT_READ,
-		.r14 = port,
-	};
+	struct tdx_module_args args;
 	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
 	bool success;
 
+	tdx_arg_init(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION);
+	args.r12 = size;
+	args.r13 = PORT_READ;
+	args.r14 = port;
+
 	/*
 	 * Emulate the I/O read via hypercall. More info about ABI can be found
 	 * in TDX Guest-Host-Communication Interface (GHCI) section titled
@@ -706,7 +719,9 @@ __init bool tdx_early_handle_ve(struct pt_regs *regs)
 
 void tdx_get_ve_info(struct ve_info *ve)
 {
-	struct tdx_module_args args = {};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
 
 	/*
 	 * Called during #VE handling to retrieve the #VE info from the
@@ -849,14 +864,16 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	}
 
 	while (retry_count < max_retries_per_page) {
-		struct tdx_module_args args = {
-			.r10 = TDX_HYPERCALL_STANDARD,
-			.r11 = TDVMCALL_MAP_GPA,
-			.r12 = start,
-			.r13 = end - start };
-
+		struct tdx_module_args args;
 		u64 map_fail_paddr;
-		u64 ret = __tdx_hypercall(&args);
+		u64 ret;
+
+		tdx_arg_init(&args);
+		args.r10 = TDX_HYPERCALL_STANDARD;
+		args.r11 = TDVMCALL_MAP_GPA;
+		args.r12 = start;
+		args.r13 = end - start;
+		ret = __tdx_hypercall(&args);
 
 		if (ret != TDVMCALL_STATUS_RETRY)
 			return !ret;
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index b4a851d27c7c..38560b006cdf 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -385,27 +385,30 @@ static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
 #ifdef CONFIG_INTEL_TDX_GUEST
 static void hv_tdx_msr_write(u64 msr, u64 val)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = EXIT_REASON_MSR_WRITE,
-		.r12 = msr,
-		.r13 = val,
-	};
+	struct tdx_module_args args;
+	u64 ret;
 
-	u64 ret = __tdx_hypercall(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = EXIT_REASON_MSR_WRITE;
+	args.r12 = msr;
+	args.r13 = val;
+
+	ret = __tdx_hypercall(&args);
 
 	WARN_ONCE(ret, "Failed to emulate MSR write: %lld\n", ret);
 }
 
 static void hv_tdx_msr_read(u64 msr, u64 *val)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = EXIT_REASON_MSR_READ,
-		.r12 = msr,
-	};
+	struct tdx_module_args args;
+	u64 ret;
 
-	u64 ret = __tdx_hypercall(&args);
+	tdx_arg_init(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = EXIT_REASON_MSR_READ;
+	args.r12 = msr;
+
+	ret = __tdx_hypercall(&args);
 
 	if (WARN_ONCE(ret, "Failed to emulate MSR read: %lld\n", ret))
 		*val = 0;
@@ -415,8 +418,9 @@ static void hv_tdx_msr_read(u64 msr, u64 *val)
 
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 {
-	struct tdx_module_args args = { };
+	struct tdx_module_args args;
 
+	tdx_arg_init(&args);
 	args.r10 = control;
 	args.rdx = param1;
 	args.r8  = param2;
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 89f7fcade8ae..fc3082f050dc 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -100,6 +100,14 @@ struct tdx_module_args {
 	u64 rsi;
 };
 
+static __always_inline void tdx_arg_init(struct tdx_module_args *args)
+{
+	asm ("rep stosb"
+	     : "+D" (args)
+	     : "c" (sizeof(*args)), "a" (0)
+	     : "memory");
+}
+
 /* Used to communicate with the TDX module */
 u64 __tdcall(u64 fn, struct tdx_module_args *args);
 u64 __tdcall_ret(u64 fn, struct tdx_module_args *args);
@@ -114,14 +122,15 @@ u64 __tdx_hypercall(struct tdx_module_args *args);
  */
 static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = fn,
-		.r12 = r12,
-		.r13 = r13,
-		.r14 = r14,
-		.r15 = r15,
-	};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = fn;
+	args.r12 = r12;
+	args.r13 = r13;
+	args.r14 = r14;
+	args.r15 = r15;
 
 	return __tdx_hypercall(&args);
 }
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

