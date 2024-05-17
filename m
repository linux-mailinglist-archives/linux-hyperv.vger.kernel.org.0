Return-Path: <linux-hyperv+bounces-2160-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F38C87D9
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D681C1C22C76
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CC8612EB;
	Fri, 17 May 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMSBqwi4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AAB5FDA5;
	Fri, 17 May 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955600; cv=none; b=iT+oIeDCX/JO3Y4EJdEwpagjR99mDy4ltRpbYiAuxaaUDF1ZG2/ylURHVEmi0ikQ0yBwyWGd0PKh/pwwir4TBt7A9PyHn8fm/+Er6RfSNGW2qkYh/wqTdtsi+7advCVMGZiKZzp/QhhJjS9Zud9KrWIVcFoU/xISTEDzOiBIP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955600; c=relaxed/simple;
	bh=bZilNGVw8GXYGxLxRYDja6LYOeRiibYaLxUxsni4eow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6BK6r1FWMi3wNvLwpfA94GZvra13baL5yDFrDs7GBhgfNsTFsgk0ENZOS9BUupmLcYQHORfjXnjJyMwl1sV8GIxnZNynfcdnbh0+GijzPtjcJmMV9kfrw9oXJ7rsrfeIYm9LP533HFVvwpa1pVHnY/y5t9Lq1R6n+gPZokPzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMSBqwi4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955599; x=1747491599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZilNGVw8GXYGxLxRYDja6LYOeRiibYaLxUxsni4eow=;
  b=lMSBqwi4WfG6ETEkI1JZXZcqlrH6KrSSwSVl+dVwK+bXMBtqqknyK76V
   NIxCdZwnu2RRCPsNTp+4QRBkj2o1YyJ/z59ot7oDnJ4Immn8/J1I4AYdz
   ylt2X+3xE1GIyqTmZK4h066tHwJ36H3Y07TkwVO4uXHswtca7Vl4ozfTX
   a/9+5loPyn9IrN4J/bXPqfKtflhNqkqSLPr58BWuFwZpNHoGZ0I8EgbqE
   75Tkrdb0kj/XSkjHJbevc/GngHyymhQQcW+K6M7ALl2n/jq1RjdJ1PEaU
   hxUa2Jh5AYR1UA0XMn4MePnF6LMoNpKuX1rgtbXE/lnU4WQzVLnEEug7I
   A==;
X-CSE-ConnectionGUID: +XR0d0mKTuy5yGhgdzQSPw==
X-CSE-MsgGUID: maSgJuqORu2llOyduAjwlw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808597"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808597"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:19:55 -0700
X-CSE-ConnectionGUID: 3AIT/8JQT1CLr++1r11kTA==
X-CSE-MsgGUID: jF4VjyVnTNu8IdmSTVuKvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="69253346"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 17 May 2024 07:19:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A91EF9F6; Fri, 17 May 2024 17:19:49 +0300 (EEST)
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
Subject: [PATCH 02/20] x86/tdx: Add macros to generate TDVMCALL wrappers
Date: Fri, 17 May 2024 17:19:20 +0300
Message-ID: <20240517141938.4177174-3-kirill.shutemov@linux.intel.com>
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

Introduce a set of macros that allow to generate wrappers for TDVMCALL
leafs. The macros uses tdvmcall_trmapoline() and provides SYSV-complaint
ABI on top of it.

There are three macros differentiated by number of return parameters.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/shared/tdx.h | 54 +++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 89f7fcade8ae..ddf2cc4a45da 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -76,6 +76,60 @@
 
 #include <linux/compiler_attributes.h>
 
+#define TDVMCALL_0(reason, in_r12, in_r13, in_r14, in_r15)			\
+({										\
+	long __ret;								\
+										\
+	asm(									\
+		"call	tdvmcall_trampoline\n\t"				\
+		"movq	%%r10, %[r10_out]\n\t"					\
+		: [r10_out] "=r" (__ret), ASM_CALL_CONSTRAINT			\
+		: "a" (TDX_HYPERCALL_STANDARD), "b" (reason),			\
+		  "D" (in_r12), "S"(in_r13), "d"(in_r14), "c" (in_r15)		\
+		: "r12", "r13", "r14", "r15"					\
+	);									\
+	__ret;									\
+})
+
+#define TDVMCALL_1(reason, in_r12, in_r13, in_r14, in_r15, out_r11)		\
+({										\
+	long __ret;								\
+										\
+	asm(									\
+		"call	tdvmcall_trampoline\n\t"				\
+		"movq	%%r10, %[r10_out]\n\t"					\
+		"movq	%%r11, %[r11_out]\n\t"					\
+		: [r10_out] "=r" (__ret), [r11_out] "=r" (out_r11),		\
+		  ASM_CALL_CONSTRAINT						\
+		: "a" (TDX_HYPERCALL_STANDARD), "b" (reason),			\
+		  "D" (in_r12), "S"(in_r13), "d"(in_r14), "c" (in_r15)		\
+		: "r10", "r11", "r12", "r13", "r14", "r15"			\
+	);									\
+	__ret;									\
+})
+
+#define TDVMCALL_4(reason, in_r12, in_r13, in_r14, in_r15,			\
+		   out_r12, out_r13, out_r14, out_r15)				\
+({										\
+	long __ret;								\
+										\
+	asm(									\
+		"call	tdvmcall_trampoline\n\t"				\
+		"movq	%%r10, %[r10_out]\n\t"					\
+		"movq	%%r12, %[r12_out]\n\t"					\
+		"movq	%%r13, %[r13_out]\n\t"					\
+		"movq	%%r14, %[r14_out]\n\t"					\
+		"movq	%%r15, %[r15_out]\n\t"					\
+		: [r10_out] "=r" (__ret), ASM_CALL_CONSTRAINT,			\
+		  [r12_out] "=r" (out_r12), [r13_out] "=r" (out_r13),		\
+		  [r14_out] "=r" (out_r14), [r15_out] "=r" (out_r15)		\
+		: "a" (TDX_HYPERCALL_STANDARD), "b" (reason),			\
+		  "D" (in_r12), "S"(in_r13), "d"(in_r14), "c" (in_r15)		\
+		: "r10", "r12", "r13", "r14", "r15"				\
+	);									\
+	__ret;									\
+})
+
 /*
  * Used in __tdcall*() to gather the input/output registers' values of the
  * TDCALL instruction when requesting services from the TDX module. This is a
-- 
2.43.0


