Return-Path: <linux-hyperv+bounces-2168-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2998F8C87E9
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D6D2861FE
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BD86F08E;
	Fri, 17 May 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4GUPNu0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1E6CDC4;
	Fri, 17 May 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955605; cv=none; b=hzUzhqHYOA2UzLVP4gsWNwEd3Iyq2OK+7CHf+yejWfQX0pwCljJtbId8jDRNc0IAArGx7v48L/lbNWhaujXCSy1JZt2K9OaAnLfU3tKkgor+yLPbGf13u0kh+Cm2rJ6+ZxqugwF1skxuogFpVXMgUMBqDQsAeUTpFiprsUEImq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955605; c=relaxed/simple;
	bh=5axqy4K+6T0Wr5Xr0Pz3IDEsBwfGRubQ1YJfQIDNdKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSs6qSiaIPhBdZ+DPfN9nudkSX1GYFEJ4DmkSyJ9dQVKTEoofloJ+7PJkTkrjOxn2JNs1+I4o7V5YcYbdLPhGWX7L8XYi2X4PPq+xdl1Ryba7KU02YDhHwX8TJwWO/8/zJ940/w+zFEpZ8O8sjl2qxQyX6oi1UvL0fUyIJdJDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4GUPNu0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955604; x=1747491604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5axqy4K+6T0Wr5Xr0Pz3IDEsBwfGRubQ1YJfQIDNdKs=;
  b=P4GUPNu0BJednJpKGFhfTRFAtru9JufVHSoT/9JV99cXb4mtCAIREo0d
   /UnOQglNyLLLZKvT0SIPoel8O1/+oTSwOLx5WvUe8F157GYVROQIQYIkD
   WM5/eJGk542ji1d+9vopfA8nk9NP5sK1H9S9C6N2eYWsE6d2X6aHBqyEW
   5CLcaT8Fhxi19TKhe6xk/CQmdQwYM01thqeP7Q692V3BwG3GyHLWEXGps
   h4kaJ3wpdHhhzdDGjzeJVZ9UXDNfsIt4Zr0OMEVBM/nv4GyDKA/HPxNNk
   NqLJtSqrvSfEBPDLQKf1r6/3RllSEGfCDFpvdMX9BefOdJykaodc6loxR
   w==;
X-CSE-ConnectionGUID: MsyMNdsNSnSIvh0urfQojg==
X-CSE-MsgGUID: 965inIkRSlGSn4nDuu29Yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808690"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808690"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:01 -0700
X-CSE-ConnectionGUID: hRqtC+FOTkyM3zUtVPt6Ww==
X-CSE-MsgGUID: yrpJTMtzTu2OuQ/PlTOepQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31944622"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 07:19:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5E0F6F56; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 14/20] x86/tdx: Add macros to generate TDCALL wrappers
Date: Fri, 17 May 2024 17:19:32 +0300
Message-ID: <20240517141938.4177174-15-kirill.shutemov@linux.intel.com>
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

Introduce a set of macros that allow to generate wrappers for TDCALL
leafs.

There are three macros differentiated by number of return parameters.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/shared/tdx.h | 58 +++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 46c299dc9cf0..70190ebc63ca 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -80,6 +80,64 @@
 
 #include <linux/compiler_attributes.h>
 
+#define TDCALL	".byte	0x66,0x0f,0x01,0xcc\n\t"
+
+#define TDCALL_0(reason, in_rcx, in_rdx, in_r8, in_r9)				\
+({										\
+	long __ret;								\
+										\
+	asm(									\
+		"movq	%[r8_in], %%r8\n\t"					\
+		"movq	%[r9_in], %%r9\n\t"					\
+		TDCALL								\
+		: "=a" (__ret), ASM_CALL_CONSTRAINT				\
+		: "a" (reason), "c" (in_rcx), "d" (in_rdx),			\
+		  [r8_in] "rm" ((u64)in_r8), [r9_in] "rm" ((u64)in_r9)		\
+		: "r8", "r9"							\
+	);									\
+	__ret;									\
+})
+
+#define TDCALL_1(reason, in_rcx, in_rdx, in_r8, in_r9, out_r8)			\
+({										\
+	long __ret;								\
+										\
+	asm(									\
+		"movq	%[r8_in], %%r8\n\t"					\
+		"movq	%[r9_in], %%r9\n\t"					\
+		TDCALL								\
+		"movq	%%r8, %[r8_out]\n\t"					\
+		: "=a" (__ret), ASM_CALL_CONSTRAINT, [r8_out] "=rm" (out_r8)	\
+		: "a" (reason), "c" (in_rcx), "d" (in_rdx),			\
+		  [r8_in] "rm" ((u64)in_r8), [r9_in] "rm" ((u64)in_r9)		\
+		: "r8", "r9"							\
+	);									\
+	__ret;									\
+})
+
+#define TDCALL_5(reason, in_rcx, in_rdx, in_r8, in_r9,				\
+		 out_rcx, out_rdx, out_r8, out_r9, out_r10)			\
+({										\
+	long __ret;								\
+										\
+	asm(									\
+		"movq	%[r8_in], %%r8\n\t"					\
+		"movq	%[r9_in], %%r9\n\t"					\
+		TDCALL								\
+		"movq	%%r8, %[r8_out]\n\t"					\
+		"movq	%%r9, %[r9_out]\n\t"					\
+		"movq	%%r10, %[r10_out]\n\t"					\
+		: "=a" (__ret), ASM_CALL_CONSTRAINT,				\
+		  "=c" (out_rcx), "=d" (out_rdx),				\
+		  [r8_out] "=rm" (out_r8), [r9_out] "=rm" (out_r9),		\
+		  [r10_out] "=rm" (out_r10)					\
+		: "a" (reason), "c" (in_rcx), "d" (in_rdx),			\
+		  [r8_in] "rm" ((u64)in_r8), [r9_in] "rm" ((u64)in_r9)		\
+		: "r8", "r9", "r10"						\
+	);									\
+	__ret;									\
+})
+
 #define TDVMCALL_0(reason, in_r12, in_r13, in_r14, in_r15)			\
 ({										\
 	long __ret;								\
-- 
2.43.0


