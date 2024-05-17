Return-Path: <linux-hyperv+bounces-2163-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5673D8C87DF
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3A91F253AF
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B436A347;
	Fri, 17 May 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MnYNdrRH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1061694;
	Fri, 17 May 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955602; cv=none; b=nnL6UdK1q/7aklS9OL+1uR4dmQtV9UrWEIWlOBA7FeMlO1d4yhGIPHmIUqHA491BoMntE7+X7rZSruBvhnv01EWqVIpCO4dsYiuVfV6D48KG6KiR60yFNW7v7gpxfYJverHBq4sDSwtNGgUBzHmWPT/MJZe/xVyoJ8f7Pdv9agA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955602; c=relaxed/simple;
	bh=9o7OkNWhk4M5OjqgrrOwQuKgzxn4CUBaIjbPSPykHS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cetbAIkq8hnowhAg1LKDlRd1LWRBBBjMn1dWEVODXhp+BhVpq5kiljbbIHe8bgzAQ5+hRouF+TLn7Wfj/TdxxGHF7fZZB1NehILu/Efgk9J678VrG2OoPq2ETlHjsi03H2c4YsZuqPRfBFdB56Qdcyr0sx4E5COlJ/xFyyapH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MnYNdrRH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955601; x=1747491601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9o7OkNWhk4M5OjqgrrOwQuKgzxn4CUBaIjbPSPykHS4=;
  b=MnYNdrRHV1Y7iKeb+qMPtn8O4YaqY2bW+JuP+7QRW8aAKWs3XWe7U34i
   dngtM7wQMWpAdXdn/oNaTOCEymGX4XpO3FOW2jJDXuGGmvbUog/ejvGjm
   lXfvVGKm0S5tVDdHHLFlmTVV48rcxweUmBmBuBRYCoqhEr7MTK8eDYZfm
   3cBfWEFMLs5PssmcNhUgiyihci886pYJXNr/OZfooYVW2EfCe0sitimHC
   TChlr+9/g3w2VM8AaLPPkmNHXx3DQr7+O7QLKkCMyShkmhTE/xm2kWE9O
   kGylq0WV94KZ7PdbItNQgcTScWIgg1IGOFXRW9Y1A7MpvQSex/Krogil3
   w==;
X-CSE-ConnectionGUID: +pNCB1DYQdiQIVK7aZD9Mg==
X-CSE-MsgGUID: 2ifYq6vCTqahhvFy5Es+Tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808620"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808620"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:00 -0700
X-CSE-ConnectionGUID: ttjwq58OTeayZh8UADZ9+Q==
X-CSE-MsgGUID: GVV75GydQySnzWchBoQHbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31944615"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 07:19:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CE720C04; Fri, 17 May 2024 17:19:49 +0300 (EEST)
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
Subject: [PATCH 05/20] x86/tdx: Convert MSR read handling to use new TDVMCALL_1()
Date: Fri, 17 May 2024 17:19:23 +0300
Message-ID: <20240517141938.4177174-6-kirill.shutemov@linux.intel.com>
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

Use newly introduced TDVMCALL_1() instead of __tdx_hypercall() to handle
MSR read emulation.

It cuts code bloat substantially:

Function                                     old     new   delta
tdx_handle_virt_exception                   2052    1947    -105

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 15 +++++++--------
 arch/x86/hyperv/ivm.c   | 10 ++--------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index dce7d6f9f895..32c519d096de 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -379,22 +379,21 @@ void __cpuidle tdx_safe_halt(void)
 
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_MSR_READ),
-		.r12 = regs->cx,
-	};
+	u64 val;
 
 	/*
 	 * Emulate the MSR read via hypercall. More info about ABI
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI), section titled "TDG.VP.VMCALL<Instruction.RDMSR>".
 	 */
-	if (__tdx_hypercall(&args))
+	if (TDVMCALL_1(hcall_func(EXIT_REASON_MSR_READ),
+		       regs->cx, 0, 0, 0, val)) {
 		return -EIO;
+	}
+
+	regs->ax = lower_32_bits(val);
+	regs->dx = upper_32_bits(val);
 
-	regs->ax = lower_32_bits(args.r11);
-	regs->dx = upper_32_bits(args.r11);
 	return ve_instr_len(ve);
 }
 
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index b4a851d27c7c..3e2cbfb2203d 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -399,18 +399,12 @@ static void hv_tdx_msr_write(u64 msr, u64 val)
 
 static void hv_tdx_msr_read(u64 msr, u64 *val)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = EXIT_REASON_MSR_READ,
-		.r12 = msr,
-	};
+	u64 ret;
 
-	u64 ret = __tdx_hypercall(&args);
+	ret = TDVMCALL_1(hcall_func(EXIT_REASON_MSR_READ), msr, 0, 0, 0, *val);
 
 	if (WARN_ONCE(ret, "Failed to emulate MSR read: %lld\n", ret))
 		*val = 0;
-	else
-		*val = args.r11;
 }
 
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
-- 
2.43.0


