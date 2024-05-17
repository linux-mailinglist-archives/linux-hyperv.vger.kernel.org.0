Return-Path: <linux-hyperv+bounces-2166-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBEA8C87E5
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575CBB23501
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EAE6CDC1;
	Fri, 17 May 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5jGO0Pw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C806A353;
	Fri, 17 May 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955604; cv=none; b=Jw4iFfoetF3gKlnVE2adUlbe5sJkx1KGVNrHCyQpoENLlSCWXhRc8RWWyGHOo6SYw9s7Ey2ENCXtDrtATVYgCDoN3/SLw27Gq1UQ9OEBE0eOBR06hPHIe58/lBMWzuCeMpA92HaF6s5WKCgVzVNtjsIBn0vLTKCnynYXd6BJ3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955604; c=relaxed/simple;
	bh=mwZWrFqPlAATgrpluzFmNP8LOZ2SkfC+w1PDY7N0GkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJe13V1JFvkOIBGnPbDnGXl8Lhdub9oYxSBDnfvmJBtpPT30W0QujV97oTb+x6JolY5JsdWlNxok475P57VpMuxUSr0j8BPXRTQxH7oj7dPUQZF9hk/9zbSHrJpoR2ADqs0yWPHXTluVLt7rEUFxW0dbwr6ENgJ6Sm5Jv4JudlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5jGO0Pw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955603; x=1747491603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwZWrFqPlAATgrpluzFmNP8LOZ2SkfC+w1PDY7N0GkI=;
  b=b5jGO0Pwvig4hkqyQ8EH7jMxAQwjZWo2Nb9Lr2kp0M6a4G+Zr7hGD2Tl
   q2dWa5mfSbX6Vl93vNAv3tq5k/BBQ5cunhGVOZryO5JreOffTDKX8reUl
   1KRycxXkTvy7MYnfCVl5BbcVWMe/bZpml2KF/gCG1sOv4kkvJ0qxI6MX7
   L22BWBvOM/EwP1qIXaTCeTxFnkbNYm98kgQ7Hh68/2NfiaP88xcEH3tYy
   Qtq+Mk2Vhx2/YH3QGUmu6Lg5k9VbpvwF7Unhr4nBMynoybNQ+aCvWm+MZ
   euDp8i4dINuWxDITb+9XACNfYwE1WYggKXG8Zi59G+fvaCThWewI0/duU
   A==;
X-CSE-ConnectionGUID: srDpFdgbRD2LdUQDHIQsEw==
X-CSE-MsgGUID: C1vK2izGQJeDCi4sTCX51w==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808661"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808661"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:00 -0700
X-CSE-ConnectionGUID: u/UyLr5SQ0md6MvEb5xcUw==
X-CSE-MsgGUID: Lot0qZVdQp6wzxYOJB6H/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="69253383"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 17 May 2024 07:19:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id EEF7CD0D; Fri, 17 May 2024 17:19:49 +0300 (EEST)
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
Subject: [PATCH 07/20] x86/tdx: Convert CPUID handling to use new TDVMCALL_4()
Date: Fri, 17 May 2024 17:19:25 +0300
Message-ID: <20240517141938.4177174-8-kirill.shutemov@linux.intel.com>
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

Use newly introduced TDVMCALL_4() instead of __tdx_hypercall() to handle
CPUID instruction emulation.

It cuts code bloat substantially:

Function                                     old     new   delta
tdx_handle_virt_exception                   1819    1747     -72

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f59a2b3500db..c436cab355e0 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -414,13 +414,6 @@ static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 
 static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_CPUID),
-		.r12 = regs->ax,
-		.r13 = regs->cx,
-	};
-
 	/*
 	 * Only allow VMM to control range reserved for hypervisor
 	 * communication.
@@ -438,19 +431,10 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 	 * ABI can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
 	 */
-	if (__tdx_hypercall(&args))
+	if (TDVMCALL_4(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0,
+		       regs->ax, regs->bx, regs->cx, regs->dx))
 		return -EIO;
 
-	/*
-	 * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
-	 * EAX, EBX, ECX, EDX registers after the CPUID instruction execution.
-	 * So copy the register contents back to pt_regs.
-	 */
-	regs->ax = args.r12;
-	regs->bx = args.r13;
-	regs->cx = args.r14;
-	regs->dx = args.r15;
-
 	return ve_instr_len(ve);
 }
 
-- 
2.43.0


