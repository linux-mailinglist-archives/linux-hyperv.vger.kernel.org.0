Return-Path: <linux-hyperv+bounces-2161-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C95F8C87DA
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0385F1F2521E
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5377764CE9;
	Fri, 17 May 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaFquHj2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E05FDDB;
	Fri, 17 May 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955601; cv=none; b=uJeavWl4qPu/oTYmwHEiN/YbT3ziaOIk9N9ExR2RmRRj43HnfXp9pnpC9Z6xNNxW2wnkr33MO7U3U46j/CYKrbhvx549N1OhI3bYwyFg/nVlrZUIY8dGp4EKOvL4CRFXRUsjEf8/Vcx581zQPQrsq0KrgEtqk9//hcmjm2NBgec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955601; c=relaxed/simple;
	bh=I0Mtjx/jDkprh2/rg4I3//FBBgLnzt/nU4tXQMcZ6N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxAJ7h33/a93q5qy5YRW9GDTkNrHYg4LZtNYXUSi7IegfOYC7hkiLdMHHLulbjZkowukcPQL61OgUMw7Ek14zQsiwq+VlUlHmBeMa0PKcGQwqt+iaTvkTThcMKCekCpjUsxeoNcb8g6sDK2Hc6qy+NvjZ37+xUIF7wjD9hwZBAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaFquHj2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955600; x=1747491600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I0Mtjx/jDkprh2/rg4I3//FBBgLnzt/nU4tXQMcZ6N0=;
  b=CaFquHj2MmtYf8ZrEW6/WnD4Stl/RiwEy+u7AO6NG16nrmuEP93xC0je
   VBOI8isnSPWp4NRmJA3pc4Lo9rc3YP5TBHboU53CDaMS2KetMyxQgyEEM
   lEg6bjsyAOSLpkn00XlSJYFC1qyGLosPkp2+CPXbX5uPuYzvTW9i3Gicg
   13HFAd3FtUkon+GJR8s9ksMi72h2Cf8YcloLvd5NMs91M2CV0a7YYL+jF
   gwLxO8ted1FYdfS+c5VjXriVZ2Q32wNR9OaSIfA0L2sCl2pXZ8VS3rFG6
   14d44xxUsMjE9Wjba1rtTmke1h+qSkb6M58ij6/LorfB1dCE0S30UD0U1
   g==;
X-CSE-ConnectionGUID: zaWN5DMXQn6ceZBEHkHWYg==
X-CSE-MsgGUID: yCDnVyWMSw2mVrEicqZyug==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808586"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808586"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:19:55 -0700
X-CSE-ConnectionGUID: LvA/bHabS/ygmoK2DUHgTw==
X-CSE-MsgGUID: 3SSb0ZOZTqC4k3nnoiLN6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="69253345"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 17 May 2024 07:19:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 940C4122; Fri, 17 May 2024 17:19:49 +0300 (EEST)
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
Subject: [PATCH 01/20] x86/tdx: Introduce tdvmcall_trampoline()
Date: Fri, 17 May 2024 17:19:19 +0300
Message-ID: <20240517141938.4177174-2-kirill.shutemov@linux.intel.com>
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

TDCALL calls are centralized into a few megawrappers that take the
struct tdx_module_args as input. Most of the call sites only use a few
arguments, but they have to zero out unused fields in the structure to
avoid data leaks to the VMM. This leads to the compiler generating
inefficient code: dozens of instructions per call site to clear unused
fields of the structure.

This issue can be avoided by using more targeted wrappers.
tdvmcall_trampoline() provides a common base for them.

The function will be used from inline assembly to handle most TDVMCALL
cases.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdcall.S | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 52d9786da308..12185fbd33ba 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -61,3 +61,52 @@ SYM_FUNC_END(__tdcall_ret)
 SYM_FUNC_START(__tdcall_saved_ret)
 	TDX_MODULE_CALL host=0 ret=1 saved=1
 SYM_FUNC_END(__tdcall_saved_ret)
+
+/*
+ * tdvmcall_trampoline() - Wrapper for TDG.VP.VMCALL. Covers common cases: up
+ * to five input and out arguments.
+ *
+ * tdvmcall_trampoline() function ABI is not SYSV ABI compliant. Caller has to
+ * deal with it.
+ *
+ * Input:
+ * RAX	- Type of call, TDX_HYPERCALL_STANDARD for calls defined in GHCI spec
+ * RBX	- 1st argument (R11), leaf ID if RAX is TDX_HYPERCALL_STANDARD
+ * RDI	- 2nd argument (R12)
+ * RSI	- 3rd argument (R13)
+ * RDX	- 4th argument (R14)
+ * RCX	- 5th argument (R15)
+ *
+ * Output:
+ * R10	- TDVMCALL error code
+ * R11	- Output 1
+ * R12	- Output 2
+ * R13	- Output 3
+ * R14	- Output 4
+ * R15	- Output 5
+ */
+.pushsection .noinstr.text, "ax"
+SYM_FUNC_START(tdvmcall_trampoline)
+	movq	%rax, %r10
+	movq    %rbx, %r11
+	movq    %rdi, %r12
+	movq    %rsi, %r13
+	movq    %rdx, %r14
+	movq    %rcx, %r15
+
+	movq	$TDG_VP_VMCALL, %rax
+
+	/* RCX is bitmap of registers exposed to VMM on TDG.VM.VMCALL */
+	movq    $(TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15), %rcx
+
+	tdcall
+
+	/* TDG.VP.VMCALL never fails on correct use. Panic if it fails. */
+	testq   %rax, %rax
+	jnz     .Lpanic
+
+	RET
+.Lpanic:
+	ud2
+SYM_FUNC_END(tdvmcall_trampoline)
+.popsection
-- 
2.43.0


