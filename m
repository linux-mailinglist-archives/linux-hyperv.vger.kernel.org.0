Return-Path: <linux-hyperv+bounces-2271-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7999B8D7522
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Jun 2024 13:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E761C20EC3
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Jun 2024 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8A42D60C;
	Sun,  2 Jun 2024 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrA3B1Kv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CBF376E4;
	Sun,  2 Jun 2024 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717329294; cv=none; b=htmVjkUiIyWBJw7XAC6QqWppOIL1VhNhc/QjpKLLZr9t/7LPsViJwvHa4HyCabmsSCzl1HJyXcYK+PxXXoRexFJlM+w1sfVlo/4/cu3RlA/hHUWaXAbbgQPHJl8xP7jV9fxtlZ0jZ3pQ+1w1m62L0lk5MvYXA/TB9vbqBvADXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717329294; c=relaxed/simple;
	bh=VfNDZ/23SEABl6JDOGyoKSiX0Ud8WzTogA0utA/EhAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mB1wzDumOHKZcIhSBu7g5g5dquwOYSAR9ERbyMC349K0g5XxionWGqMcYfHseh54KwOVpPztwmu43mdLATJkr2jnoFRNgn0FxbzSBaDvoKp/+wZxmciJJ+ROPNHPDq5hD1FRpKJWuCTV5G7dgNDU1zMhLFiZHtIQpuwh7sD2kbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrA3B1Kv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717329291; x=1748865291;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VfNDZ/23SEABl6JDOGyoKSiX0Ud8WzTogA0utA/EhAI=;
  b=jrA3B1Kv7ncFFdfZibXaaJiQfiSCSi3G0X53SvfReGktKX0ChJ3JCDcr
   75Syy5q53DQK1b8IDs4I6BHn0hQZbIVOTj9unBRWX57ll3VystvLsEkb+
   jByl4HTqgWHxyPPb/nwXbbkzQVQ9T2X3z3PHihY6bX1Q/NSFkBrVkCRvF
   ozx9/pNBoAtRvMQizZ8kUCvyQre7gifDrIyKqYvUWhrK11FHFKBU2UtCq
   7+nLzeLt5+mWLfpErrRVpu+EVMBZNXQiILm1zsDFI6O6NlZ740t9uX7Hs
   L4g833lNjz7uBM+O6w3hmJV+YDNqUc7Hxg4ntVqdWkG7aXjTcB9etdX9I
   A==;
X-CSE-ConnectionGUID: s5uuKNhuQ2Sh7zyXu/Qw4w==
X-CSE-MsgGUID: ZP7Fp1qQTJKDDUYTGIPmKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="17673222"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="17673222"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 04:54:50 -0700
X-CSE-ConnectionGUID: rb41hFa5Qe6Xx6DqzzTdWA==
X-CSE-MsgGUID: iqdr4n/6TeO4yM9qUX+mKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="41047068"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 02 Jun 2024 04:54:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A2A771CB; Sun, 02 Jun 2024 14:54:45 +0300 (EEST)
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
Subject: [PATCH] x86/tdx: Enhance code generation for TDCALL and SEAMCALL wrappers
Date: Sun,  2 Jun 2024 14:54:43 +0300
Message-ID: <20240602115444.1863364-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sean observed that the compiler is generating inefficient code to clear
the tdx_module_args struct for TDCALL and SEAMCALL wrappers. The
compiler is generating numerous instructions at each call site to clear
the unused fields of the structure.

To address this issue, avoid using C99-initializer and instead
explicitly use string instructions to clear the struct.

With Clang, this change results in a savings of approximately 3K with my
configuration:

add/remove: 0/0 grow/shrink: 0/21 up/down: 0/-3187 (-3187)

With GCC, the savings are less significant at around 300 bytes:

add/remove: 0/0 grow/shrink: 3/22 up/down: 17/-313 (-296)

GCC tends to generate string instructions more frequently to clear the
struct.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/boot/compressed/tdx.c    |  32 ++++---
 arch/x86/coco/tdx/tdx-shared.c    |   3 +-
 arch/x86/coco/tdx/tdx.c           | 150 +++++++++++++++++-------------
 arch/x86/hyperv/ivm.c             |  33 ++++---
 arch/x86/include/asm/shared/tdx.h |  25 +++--
 arch/x86/virt/vmx/tdx/tdx.c       |  28 +++---
 6 files changed, 155 insertions(+), 116 deletions(-)

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
index c1cb90369915..8112b2910ca2 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -49,13 +49,14 @@ noinstr void __noreturn __tdx_hypercall_failed(void)
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
@@ -89,13 +90,14 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
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
@@ -130,11 +132,7 @@ EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
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
@@ -145,6 +143,11 @@ static void __noreturn tdx_panic(const char *msg)
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
@@ -165,10 +168,12 @@ static void __noreturn tdx_panic(const char *msg)
 
 static void tdx_parse_tdinfo(u64 *cc_mask)
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
@@ -252,11 +257,12 @@ static int ve_instr_len(struct ve_info *ve)
 
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
@@ -296,11 +302,12 @@ void __cpuidle tdx_safe_halt(void)
 
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
@@ -317,12 +324,13 @@ static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 
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
@@ -337,12 +345,13 @@ static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 
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
@@ -379,14 +388,15 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 
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
@@ -508,16 +518,17 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
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
@@ -602,7 +613,9 @@ __init bool tdx_early_handle_ve(struct pt_regs *regs)
 
 void tdx_get_ve_info(struct ve_info *ve)
 {
-	struct tdx_module_args args = {};
+	struct tdx_module_args args;
+
+	tdx_arg_init(&args);
 
 	/*
 	 * Called during #VE handling to retrieve the #VE info from the
@@ -745,14 +758,16 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
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
@@ -824,10 +839,8 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 
 void __init tdx_early_init(void)
 {
-	struct tdx_module_args args = {
-		.rdx = TDCS_NOTIFY_ENABLES,
-		.r9 = -1ULL,
-	};
+	struct tdx_module_args args;
+
 	u64 cc_mask;
 	u32 eax, sig[3];
 
@@ -846,6 +859,9 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
+	tdx_arg_init(&args);
+	args.rdx = TDCS_NOTIFY_ENABLES;
+	args.r9 = -1ULL;
 	tdcall(TDG_VM_WR, &args);
 
 	/*
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 768d73de0d09..4a49d09b23ad 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -385,27 +385,31 @@ static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
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
+	tdx_arg_init(&args);
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
@@ -415,8 +419,9 @@ static void hv_tdx_msr_read(u64 msr, u64 *val)
 
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 {
-	struct tdx_module_args args = { };
+	struct tdx_module_args args;
 
+	tdx_arg_init(&args);
 	args.r10 = control;
 	args.rdx = param1;
 	args.r8  = param2;
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fdfd41511b02..0519dd7cbb92 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -89,6 +89,14 @@ struct tdx_module_args {
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
@@ -103,14 +111,15 @@ u64 __tdx_hypercall(struct tdx_module_args *args);
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
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4e2b2e2ac9f9..50d1ff9d874f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -103,7 +103,7 @@ static inline int sc_retry_prerr(sc_func_t func, sc_err_func_t err_func,
  */
 static int try_init_module_global(void)
 {
-	struct tdx_module_args args = {};
+	struct tdx_module_args args;
 	static DEFINE_RAW_SPINLOCK(sysinit_lock);
 	static bool sysinit_done;
 	static int sysinit_ret;
@@ -115,6 +115,8 @@ static int try_init_module_global(void)
 	if (sysinit_done)
 		goto out;
 
+	tdx_arg_init(&args);
+
 	/* RCX is module attributes and all bits are reserved */
 	args.rcx = 0;
 	sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
@@ -146,7 +148,7 @@ static int try_init_module_global(void)
  */
 int tdx_cpu_enable(void)
 {
-	struct tdx_module_args args = {};
+	struct tdx_module_args args;
 	int ret;
 
 	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
@@ -166,6 +168,7 @@ int tdx_cpu_enable(void)
 	if (ret)
 		return ret;
 
+	tdx_arg_init(&args);
 	ret = seamcall_prerr(TDH_SYS_LP_INIT, &args);
 	if (ret)
 		return ret;
@@ -252,7 +255,7 @@ static int build_tdx_memlist(struct list_head *tmb_list)
 
 static int read_sys_metadata_field(u64 field_id, u64 *data)
 {
-	struct tdx_module_args args = {};
+	struct tdx_module_args args;
 	int ret;
 
 	/*
@@ -260,6 +263,7 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 	 *  - RDX (in): the field to read
 	 *  - R8 (out): the field data
 	 */
+	tdx_arg_init(&args);
 	args.rdx = field_id;
 	ret = seamcall_prerr_ret(TDH_SYS_RD, &args);
 	if (ret)
@@ -955,7 +959,7 @@ static int construct_tdmrs(struct list_head *tmb_list,
 
 static int config_tdx_module(struct tdmr_info_list *tdmr_list, u64 global_keyid)
 {
-	struct tdx_module_args args = {};
+	struct tdx_module_args args;
 	u64 *tdmr_pa_array;
 	size_t array_sz;
 	int i, ret;
@@ -977,6 +981,7 @@ static int config_tdx_module(struct tdmr_info_list *tdmr_list, u64 global_keyid)
 	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++)
 		tdmr_pa_array[i] = __pa(tdmr_entry(tdmr_list, i));
 
+	tdx_arg_init(&args);
 	args.rcx = __pa(tdmr_pa_array);
 	args.rdx = tdmr_list->nr_consumed_tdmrs;
 	args.r8 = global_keyid;
@@ -990,8 +995,9 @@ static int config_tdx_module(struct tdmr_info_list *tdmr_list, u64 global_keyid)
 
 static int do_global_key_config(void *unused)
 {
-	struct tdx_module_args args = {};
+	struct tdx_module_args args;
 
+	tdx_arg_init(&args);
 	return seamcall_prerr(TDH_SYS_KEY_CONFIG, &args);
 }
 
@@ -1056,11 +1062,11 @@ static int init_tdmr(struct tdmr_info *tdmr)
 	 * TDMR in each call.
 	 */
 	do {
-		struct tdx_module_args args = {
-			.rcx = tdmr->base,
-		};
+		struct tdx_module_args args;
 		int ret;
 
+		tdx_arg_init(&args);
+		args.rcx = tdmr->base;
 		ret = seamcall_prerr_ret(TDH_SYS_TDMR_INIT, &args);
 		if (ret)
 			return ret;
@@ -1284,15 +1290,15 @@ static bool is_pamt_page(unsigned long phys)
  */
 static bool paddr_is_tdx_private(unsigned long phys)
 {
-	struct tdx_module_args args = {
-		.rcx = phys & PAGE_MASK,
-	};
+	struct tdx_module_args args;
 	u64 sret;
 
 	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
 		return false;
 
 	/* Get page type from the TDX module */
+	tdx_arg_init(&args);
+	args.rcx = phys & PAGE_MASK;
 	sret = __seamcall_ret(TDH_PHYMEM_PAGE_RDMD, &args);
 
 	/*
-- 
2.43.0


