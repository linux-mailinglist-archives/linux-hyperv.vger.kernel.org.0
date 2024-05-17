Return-Path: <linux-hyperv+bounces-2159-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79658C87D6
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5A12824AD
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAE55FDDC;
	Fri, 17 May 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7S9Uijp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7BE5D49A;
	Fri, 17 May 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955599; cv=none; b=KCLxiG6BL5K+AUXfx6dmIc29kJOQD2t0iVRMlV4aqAbnDfFjXmDHh35h8rCfFRACSHYhffJ58H8DJ+WUgPqBSdHX5hL9Yru/CpnQwLp9bFu5oIjRR7vmay97Wgh3wrp1X66PVY10GAVvIQvAydJ1FIixFlu6yoKSfpZGnCPRwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955599; c=relaxed/simple;
	bh=V+o4+Ha3FKRn9857krkLJDLMciI8lqvyQSf3/EAKodM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/Hmewgd4TO6ZVIhCJZEV4SO/PVYEyDciB+5tDsSMtzeYrpU758tdcA/e7dGFjI92jxpqN82y7HUahdi5vh+frVTuN1khcWDAgLKTdSKZJ22CgeUIsOGwZeUUVQVPrnFmdRCtKRzwfO5eBSYhWDcmgLY6yEmmk2N/7e6QRUkcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7S9Uijp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955598; x=1747491598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V+o4+Ha3FKRn9857krkLJDLMciI8lqvyQSf3/EAKodM=;
  b=Q7S9UijpiB5R7Sj3pVC/XgAb5fQImZjNteR/qiqeDy+gagxm4i3jLkjb
   IwcSTXQ6D2ZIEnmifOhOipljGOpNcY5LhX29aaqz8jf56FRHoSfh8Qq7o
   HWtXTWJZuP+/4AB7DQzz358qzl+i4gBgh1hk9vcZDh9ZVYVOstC+NfvpN
   KBOW0pA2VvCd5KHwPjW/TL/mnRiYpDJ1emJPXZ+ZY3AZl1LB6xiLOCqGo
   4fdTUp13CIesGxv4DW3tTY7LQCZWBvFdYpLdmmGce8tD/Bzlzl+mYWa5F
   WJIv5gYacOMqYycP8O9jrM+9EByNGnqB6TsGyuKlhxuqIt8hebLvionjO
   Q==;
X-CSE-ConnectionGUID: Dg+ZIbNJQeW/Uvp/tV1QJQ==
X-CSE-MsgGUID: yaH+BUimSmWsUJlfzcsA8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808576"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808576"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:19:55 -0700
X-CSE-ConnectionGUID: /GvqC1X0Samm8onB6nNcgA==
X-CSE-MsgGUID: YvXG09S8RqCsj/kVS9vgrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="69253343"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 17 May 2024 07:19:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B086B97D; Fri, 17 May 2024 17:19:49 +0300 (EEST)
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
Subject: [PATCH 03/20] x86/tdx: Convert port I/O handling to use new TDVMCALL macros
Date: Fri, 17 May 2024 17:19:21 +0300
Message-ID: <20240517141938.4177174-4-kirill.shutemov@linux.intel.com>
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

Use newly introduced TDVMCALL_0() and TDVMCALL_1() instead of
__tdx_hypercall() to handle port I/O in TDX guest.

It cuts handle_io() size in half:

Function                                     old     new   delta
handle_io                                    436     202    -234

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/tdx.c    | 26 +++++++-------------------
 arch/x86/coco/tdx/tdx.c           | 23 +++++++----------------
 arch/x86/include/asm/shared/tdx.h |  4 ++++
 3 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 8451d6a1030c..0ae05edc7d42 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -18,32 +18,20 @@ void __tdx_hypercall_failed(void)
 
 static inline unsigned int tdx_io_in(int size, u16 port)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
-		.r12 = size,
-		.r13 = 0,
-		.r14 = port,
-	};
+	u64 out;
 
-	if (__tdx_hypercall(&args))
+	if (TDVMCALL_1(hcall_func(EXIT_REASON_IO_INSTRUCTION),
+		       size, TDX_PORT_READ, port, 0, out)) {
 		return UINT_MAX;
+	}
 
-	return args.r11;
+	return out;
 }
 
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
-
-	__tdx_hypercall(&args);
+	TDVMCALL_0(hcall_func(EXIT_REASON_IO_INSTRUCTION),
+		   size, TDX_PORT_WRITE, port, value);
 }
 
 static inline u8 tdx_inb(u16 port)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index cadd583d6f62..6e0e5648ebd1 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -21,10 +21,6 @@
 #define EPT_READ	0
 #define EPT_WRITE	1
 
-/* Port I/O direction */
-#define PORT_READ	0
-#define PORT_WRITE	1
-
 /* See Exit Qualification for I/O Instructions in VMX documentation */
 #define VE_IS_IO_IN(e)		((e) & BIT(3))
 #define VE_GET_IO_SIZE(e)	(((e) & GENMASK(2, 0)) + 1)
@@ -612,14 +608,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
 static bool handle_in(struct pt_regs *regs, int size, int port)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
-		.r12 = size,
-		.r13 = PORT_READ,
-		.r14 = port,
-	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask, out;
 	bool success;
 
 	/*
@@ -627,12 +616,14 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 * in TDX Guest-Host-Communication Interface (GHCI) section titled
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
-	success = !__tdx_hypercall(&args);
+	success = !TDVMCALL_1(hcall_func(EXIT_REASON_IO_INSTRUCTION),
+			      size, TDX_PORT_READ, port, 0, out);
 
 	/* Update part of the register affected by the emulated instruction */
+	mask = GENMASK(BITS_PER_BYTE * size, 0);
 	regs->ax &= ~mask;
 	if (success)
-		regs->ax |= args.r11 & mask;
+		regs->ax |= out & mask;
 
 	return success;
 }
@@ -646,8 +637,8 @@ static bool handle_out(struct pt_regs *regs, int size, int port)
 	 * in TDX Guest-Host-Communication Interface (GHCI) section titled
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
-	return !_tdx_hypercall(hcall_func(EXIT_REASON_IO_INSTRUCTION), size,
-			       PORT_WRITE, port, regs->ax & mask);
+	return !TDVMCALL_0(hcall_func(EXIT_REASON_IO_INSTRUCTION),
+			   size, TDX_PORT_WRITE, port, regs->ax & mask);
 }
 
 /*
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index ddf2cc4a45da..46c299dc9cf0 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -72,6 +72,10 @@
 #define TDX_PS_1G	2
 #define TDX_PS_NR	(TDX_PS_1G + 1)
 
+/* Port I/O direction */
+#define TDX_PORT_READ	0
+#define TDX_PORT_WRITE	1
+
 #ifndef __ASSEMBLY__
 
 #include <linux/compiler_attributes.h>
-- 
2.43.0


