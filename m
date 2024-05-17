Return-Path: <linux-hyperv+bounces-2169-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CB98C87EA
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA681F259BB
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5CB71748;
	Fri, 17 May 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6ihWJEF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C26BB50;
	Fri, 17 May 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955605; cv=none; b=tQ4t/W6qwINhk7d/jgDwU9UljvReheAEtJIScvkG/mY2sI5CfOys5f82yn7ADBMWldj9YeBMsWOQL8oLmH9yjOEThX3NpQpm3bwRUv5AYhmVbAIcsybr0S0TQPoHxtclU1n/NyP6x4fSrrLcfmet6AtcNc4OgpNmOiahy31IElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955605; c=relaxed/simple;
	bh=LfJF40bu9175MoXsqPC9Kp+73oOf88kFkC5j1mad8BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwHWwW6tmcmFZFgHCpDtA2BXQ7y0o22N+/tYHHj/WthPMSt+NQSPEkEOv6MkryaKW5w0RG+OPiE+KllcKZvA4gV6TuL+NV1Dy6m5IoOqaJ/hnme80IgckN6mrK16Lex6+q5/5hu6pyvt5NLNS3sM7/pAJNdY2hv5Zqi/Qmm5NoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6ihWJEF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955603; x=1747491603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LfJF40bu9175MoXsqPC9Kp+73oOf88kFkC5j1mad8BY=;
  b=F6ihWJEFuz0/oUxuOQgh6i9X4pHTaF6t9gM3m7CkZUHlbwWtVCG8ywCs
   5DJtq6QIQwM4QVrlmDTs+BffbYk9O8TtcP9re0GYG9RKp8WzKqV6HgT6H
   o5gLu1ItaNoqcBhhgb9TcmWhw9Qk90MhaQ9/+sJTOW0GYH6m7DF6XpXDw
   h+oCWdKhLqrYLCpkORgCJAcm7Gjz6nuQUAoP33YOLStfXFCEiq0RK2KGS
   EZ/Ci8S4qOemyuhDljoXdCefsx5jn8YDahnFqWTY3zEV17sWqWNxwv2GA
   BuSGWH38aJDD0Ucgp+r9LKRA7hwVZl0gJcNvOpm04TUS/SF23dzDWUXJV
   Q==;
X-CSE-ConnectionGUID: ka3kU7SRSPOBdWTd/mG+Bg==
X-CSE-MsgGUID: VMliNjHeSb+qXaGmzQK80w==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808664"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808664"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:01 -0700
X-CSE-ConnectionGUID: YAzxi36sQCyTHCwxlOrAoA==
X-CSE-MsgGUID: hcJwi3EFQf+FLkPXCWj8Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31944620"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 07:19:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 32777E27; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 11/20] x86/tdx: Rewrite tdx_panic() without __tdx_hypercall()
Date: Fri, 17 May 2024 17:19:29 +0300
Message-ID: <20240517141938.4177174-12-kirill.shutemov@linux.intel.com>
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

tdx_panic() uses REPORT_FATAL_ERROR hypercall to deliver panic message
in ealy boot. Rewrite it without using __tdx_hypercall().

REPORT_FATAL_ERROR hypercall is special. It uses pretty much all
available registers to pass down the error message. TDVMCALL macros are
not usable here.

Implement the hypercall directly in assembly.

It cuts code bloat substantially:

Function                                     old     new   delta
tdx_panic                                    222      59    -163

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdcall.S | 28 ++++++++++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c    | 31 +++----------------------------
 arch/x86/include/asm/tdx.h |  2 ++
 tools/objtool/noreturns.h  |  1 +
 4 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 12185fbd33ba..269e5789672a 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -110,3 +110,31 @@ SYM_FUNC_START(tdvmcall_trampoline)
 	ud2
 SYM_FUNC_END(tdvmcall_trampoline)
 .popsection
+
+SYM_FUNC_START(tdvmcall_report_fatal_error)
+	movq	$TDX_HYPERCALL_STANDARD, %r10
+	movq	$TDVMCALL_REPORT_FATAL_ERROR, %r11
+	movq	%rdi, %r12
+	movq	$0, %r13
+
+	movq	%rsi, %rcx
+
+	/* Order according to the GHCI */
+	movq	0*8(%rcx), %r14
+	movq	1*8(%rcx), %r15
+	movq	2*8(%rcx), %rbx
+	movq	3*8(%rcx), %rdi
+	movq	4*8(%rcx), %rsi
+	movq	5*8(%rcx), %r8
+	movq	6*8(%rcx), %r9
+	movq	7*8(%rcx), %rdx
+
+	movq	$TDG_VP_VMCALL, %rax
+	movq	$(TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
+		  TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15), \
+		%rcx
+
+	tdcall
+
+	ud2
+SYM_FUNC_END(tdvmcall_report_fatal_error)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3f0be1d3cccb..b7299e668564 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -157,37 +157,12 @@ EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
 static void __noreturn tdx_panic(const char *msg)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = TDVMCALL_REPORT_FATAL_ERROR,
-		.r12 = 0, /* Error code: 0 is Panic */
-	};
-	union {
-		/* Define register order according to the GHCI */
-		struct { u64 r14, r15, rbx, rdi, rsi, r8, r9, rdx; };
-
-		char str[64];
-	} message;
+	char str[64];
 
 	/* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
-	strtomem_pad(message.str, msg, '\0');
+	strtomem_pad(str, msg, '\0');
 
-	args.r8  = message.r8;
-	args.r9  = message.r9;
-	args.r14 = message.r14;
-	args.r15 = message.r15;
-	args.rdi = message.rdi;
-	args.rsi = message.rsi;
-	args.rbx = message.rbx;
-	args.rdx = message.rdx;
-
-	/*
-	 * This hypercall should never return and it is not safe
-	 * to keep the guest running. Call it forever if it
-	 * happens to return.
-	 */
-	while (1)
-		__tdx_hypercall(&args);
+	tdvmcall_report_fatal_error(0, str);
 }
 
 /*
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index eba178996d84..f67e5e6b66ad 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -54,6 +54,8 @@ struct ve_info {
 
 void __init tdx_early_init(void);
 
+void __noreturn tdvmcall_report_fatal_error(u64 error_code, const char str[64]);
+
 void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 7ebf29c91184..0670cacf0734 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -39,6 +39,7 @@ NORETURN(sev_es_terminate)
 NORETURN(snp_abort)
 NORETURN(start_kernel)
 NORETURN(stop_this_cpu)
+NORETURN(tdvmcall_report_fatal_error)
 NORETURN(usercopy_abort)
 NORETURN(x86_64_start_kernel)
 NORETURN(x86_64_start_reservations)
-- 
2.43.0


