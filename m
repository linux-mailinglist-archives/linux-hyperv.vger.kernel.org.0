Return-Path: <linux-hyperv+bounces-2165-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BD28C87E2
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3579F1F25484
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD296BB56;
	Fri, 17 May 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nApBNqp0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA165189;
	Fri, 17 May 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955603; cv=none; b=E5mMhO5ugIjVmi9h1D5OjB+21qq54X4J9osPCeAI3ndzPJlPNXzKlGWvPtPmPnN9gXfw3pDsaanTnQcz4n5XFQ2GLL9s2uZb0YBmdlnf6Jci2KK97JHDut6+ixifYRrKzOEs/h7nDe1v1qs3lhCiFYdFmJvuUSTUuJmwJx/tRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955603; c=relaxed/simple;
	bh=CcujIUVW1JuDql5JHxHA+AIa8M0XntpfPmL9/r3uwTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHuqPEkyN6p+BP1OnwGbgA8U1tMswwKGoB4SVmf7k2ZBhWk81o2dw9uMRYsSEP/tLe7092SslE7G+Zpi/KsskDZZDGX5z4FyvTqOrBTMbTNyhyDXnexyc4oXEY44+gGB/tqMDAg/lGth+PWzRMWOboVXfO2drxcElAO0O7IzKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nApBNqp0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955601; x=1747491601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CcujIUVW1JuDql5JHxHA+AIa8M0XntpfPmL9/r3uwTE=;
  b=nApBNqp0+GlOPdZLvn6cE696oBdlX3yrlq+7lUsSJdUGsPtlXfDhAF9n
   OL3rBrtBe1z1M1mtWSHimm5L9f1NnXniFHB1UJVICWFr1nbmdYlLR79hx
   U9aC09ww6oEKh9DOB5S9xFdZisXRYzdarNA1orIJlkyOKB3UoiKALYThh
   mSWsW6Gd+K9voDtVRgAWPgOGsWd4K1ra/99XOg6DR9lEeRTdm4Bzr9sDM
   adeF3Q3pWmGPgovfqb9VVGL4d1sFwZc7UA3fENnBBB4RP4vTuACCQALMl
   xTm2hPHGqBuRlrcMRPwq5PZ1dFq+hBFYSZSmZ3aIREZpbPNt8TFiPJDZi
   g==;
X-CSE-ConnectionGUID: SOBTzdVRSq2bDFaFWiT/0A==
X-CSE-MsgGUID: Lx/P0NlGRfu3CNklrWwDRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808642"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808642"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:00 -0700
X-CSE-ConnectionGUID: IOisXNc3SImubkKPm9L17Q==
X-CSE-MsgGUID: tE0r8QJERR+mBnF5pQKlxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="69253385"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 17 May 2024 07:19:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4D265AD3; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 13/20] x86/tdx: Rewrite hv_tdx_hypercall() without __tdx_hypercall()
Date: Fri, 17 May 2024 17:19:31 +0300
Message-ID: <20240517141938.4177174-14-kirill.shutemov@linux.intel.com>
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

Rewrite hv_tdx_hypercall() in assembly to remove one more
__tdx_hypercall() user.

tdvmcall_trampoline() cannot be used here as Hyper-V uses R8 and RDX to
pass down parameters which is incompatible with tdvmcall_trampoline()

The rewrite cuts code bloat substantially:

Function                                     old     new   delta
hv_tdx_hypercall                             171      42    -129

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdcall.S | 30 ++++++++++++++++++++++++++++++
 arch/x86/hyperv/ivm.c      | 14 --------------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 269e5789672a..5b60b9c8799f 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -138,3 +138,33 @@ SYM_FUNC_START(tdvmcall_report_fatal_error)
 
 	ud2
 SYM_FUNC_END(tdvmcall_report_fatal_error)
+
+#ifdef CONFIG_HYPERV
+/*
+ * hv_tdx_hypercall() - Issue Hyper-V hypercall
+ *
+ * RDI - Hypercall ID
+ * RSI - Parameter 1
+ * RCX - Parameter 2
+ */
+SYM_FUNC_START(hv_tdx_hypercall)
+	movq	%rdi, %r10
+	movq    %rsi, %rdx
+	movq    %rcx, %r8
+
+	movq	$TDG_VP_VMCALL, %rax
+	movq    $(TDX_R8 | TDX_R10 | TDX_RDX), %rcx
+
+	tdcall
+
+	/* TDG.VP.VMCALL never fails on correct use. Panic if it fails. */
+	testq   %rax, %rax
+	jnz	.Lpanic_hv
+
+	movq	%r11, %rax
+
+	RET
+.Lpanic_hv:
+	ud2
+SYM_FUNC_END(hv_tdx_hypercall)
+#endif
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 18d0892d9fc4..562980e19d68 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -401,20 +401,6 @@ static void hv_tdx_msr_read(u64 msr, u64 *val)
 	if (WARN_ONCE(ret, "Failed to emulate MSR read: %lld\n", ret))
 		*val = 0;
 }
-
-u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
-{
-	struct tdx_module_args args = { };
-
-	args.r10 = control;
-	args.rdx = param1;
-	args.r8  = param2;
-
-	(void)__tdx_hypercall(&args);
-
-	return args.r11;
-}
-
 #else
 static inline void hv_tdx_msr_write(u64 msr, u64 value) {}
 static inline void hv_tdx_msr_read(u64 msr, u64 *value) {}
-- 
2.43.0


