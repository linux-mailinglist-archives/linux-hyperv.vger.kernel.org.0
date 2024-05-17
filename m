Return-Path: <linux-hyperv+bounces-2162-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62608C87DB
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071B51C22C73
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A219651A4;
	Fri, 17 May 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfZGWAD/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D56024B;
	Fri, 17 May 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955601; cv=none; b=o0ZDC8bDokFascb4zrOm7da/Uegea7KaK/yZB40esYc/YGUDSy2WOMPN6+VDyDCsl7w0cT/9EEO1ydPOdvza52vipRVkPMoDtKOfc0g1hlPkw4B4re1M8qm1gH8GkSdgMzKwuTeDq6c4tjpYHeily9R8rBBnBjRkSAzD5mkUnkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955601; c=relaxed/simple;
	bh=C22Kxw6sw8vKzGrlwtwyA3njMblbtBv6zILkHx7dXVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hh6WGZhrbnPpV0Ci2b9o+wOEnk1QZDIcwgjQk65V4CDi07mcaVCU5Yc/QR7i0yde0Dib4cBamLRNivpIr8sSN+JbvvgoOYruifduGZfQDEcTYtSNj+wLv7EGF2bSQFuqQJQqiTN8iz6z0qv0P8TnWpg4nl57uPYQR9jMAWU7rQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfZGWAD/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955600; x=1747491600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C22Kxw6sw8vKzGrlwtwyA3njMblbtBv6zILkHx7dXVQ=;
  b=cfZGWAD/+kpV83pHG0qYw/YTYX39kFo/PUuNakrmYGaXLFnLW/wF97Od
   qNn2rT7aR/9z+al1eZWd9gG8pyXHZRgiDRQ5uj55/VfJlKB5YaqzU+Gn4
   95JTAH+Vzp/QepdaCU0Nioy2eN5GCoWczhlHnJEyAqr9Q89pPkVuuUdBI
   fHlHDf5/B43x/x1DQoC3Q8fuI9HAoVBHIrWus6kkc7lod6tr+re6j32uq
   dbiCP0dPfG8ytL0hDx3Ir4QLmAmQE1XX9/FkGhz7MtOg4i0rGIeaBD7oL
   ZXFvkabk82RMJxdgbFtlnPi+KiB7JajSG1W0EhQRG0GUCyW3ITYLBOyMo
   g==;
X-CSE-ConnectionGUID: yjNnK90jSGKtMY4N4OHp1w==
X-CSE-MsgGUID: JBD6cxc9TFq6hou8nCvk0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808611"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808611"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:00 -0700
X-CSE-ConnectionGUID: eaFtlg1vR2Cyl5mlkS8bqA==
X-CSE-MsgGUID: kCX6iRTtR7iVkWQawvVEgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="69253380"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 17 May 2024 07:19:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DEBC4C4D; Fri, 17 May 2024 17:19:49 +0300 (EEST)
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
Subject: [PATCH 06/20] x86/tdx: Convert MSR write handling to use new TDVMCALL_0()
Date: Fri, 17 May 2024 17:19:24 +0300
Message-ID: <20240517141938.4177174-7-kirill.shutemov@linux.intel.com>
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

Use newly introduced TDVMCALL_0() instead of __tdx_hypercall() to handle
MSR write emulation.

It cuts code bloat substantially:

Function                                     old     new   delta
tdx_handle_virt_exception                   1947    1819    -128

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 9 ++-------
 arch/x86/hyperv/ivm.c   | 9 ++-------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 32c519d096de..f59a2b3500db 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -399,19 +399,14 @@ static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 
 static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_MSR_WRITE),
-		.r12 = regs->cx,
-		.r13 = (u64)regs->dx << 32 | regs->ax,
-	};
+	u64 val = (u64)regs->dx << 32 | regs->ax;
 
 	/*
 	 * Emulate the MSR write via hypercall. More info about ABI
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI) section titled "TDG.VP.VMCALL<Instruction.WRMSR>".
 	 */
-	if (__tdx_hypercall(&args))
+	if (TDVMCALL_0(hcall_func(EXIT_REASON_MSR_WRITE), regs->cx, val, 0, 0))
 		return -EIO;
 
 	return ve_instr_len(ve);
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 3e2cbfb2203d..18d0892d9fc4 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -385,14 +385,9 @@ static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
 #ifdef CONFIG_INTEL_TDX_GUEST
 static void hv_tdx_msr_write(u64 msr, u64 val)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = EXIT_REASON_MSR_WRITE,
-		.r12 = msr,
-		.r13 = val,
-	};
+	u64 ret;
 
-	u64 ret = __tdx_hypercall(&args);
+	ret = TDVMCALL_0(hcall_func(EXIT_REASON_MSR_WRITE), msr, val, 0, 0);
 
 	WARN_ONCE(ret, "Failed to emulate MSR write: %lld\n", ret);
 }
-- 
2.43.0


