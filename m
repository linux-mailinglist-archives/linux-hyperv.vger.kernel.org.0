Return-Path: <linux-hyperv+bounces-2171-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F288C87EE
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BB01F2496C
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C6673511;
	Fri, 17 May 2024 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apwMsSsm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201E6D1BD;
	Fri, 17 May 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955607; cv=none; b=m3RSTYMlp4Oa517TOZaXBrbqTf4fNeDl9ii2V4nPDokmj/nrdj8MNTapf97wnSVBggF8UJ0+28VQNZEujtJGAuO0/pDw5jGoJFd75moxDCIfwrslh29+tosOogrQHHM9mMfDRZfo8PO4jNP6WXhMfMePPRBkfmLSe89B5v5Atck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955607; c=relaxed/simple;
	bh=uZslm5QlIILoGAKr67d4nChGhXyvxobqw1oaGUf7Wmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6rfuwyVwZik6c4PjeqJl0m35WKDvTSJRzTS8I4GQ8+3SkPc7HpP6auXDZocquJzaAB8Z4XsSGKSzOwWAdUhOmjfymW4CqonJyLTwXnlv5jLCvist5CzZhcnhliKygYUfcMGAfvObJrMMrP48nDt5bHAJt+TyHlER2tyILEzO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apwMsSsm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955606; x=1747491606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uZslm5QlIILoGAKr67d4nChGhXyvxobqw1oaGUf7Wmw=;
  b=apwMsSsm67zIN4V3vPRH1K8wRfdy00TacNB4YbTOGPtQOXt6MlIzwKpw
   G6VMRqR8aO6LrO20duZ6fKRhgcCsFX1vS9r1bmUF/KnywBH6If3BRE4J1
   VsnkCvG57NNMGjUXagr0lOKugoKzgYyWFtgvdFuaIR56RIuauKZ9g8QuG
   o7mpKaJb3c9NxyRM//3e9+oR59FLSqey9BuL0h1ak5xNWuWgz/zt5cT4n
   iawDe0uSrmqh/+7jptSUv8pRYC3GX1mEnCxPkoSR0WGCNkUuEuMrRnMCU
   rkBVbo69LaLziZDwla5RQwf3f5cNgb/DSWVw3OYkE7xg19B5iV/qDML/P
   w==;
X-CSE-ConnectionGUID: sBHaPP5iQUGYSMBLK5+cVQ==
X-CSE-MsgGUID: jZGmxltyRDaGh7syT267Sw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808701"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808701"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:01 -0700
X-CSE-ConnectionGUID: pXhzlloYT5qbB8tq6NLaxg==
X-CSE-MsgGUID: uylrdJESTaeGMuYVlF1JCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31944617"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 07:19:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0B7DDD61; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 08/20] x86/tdx: Convert MMIO handling to use new TDVMCALL macros
Date: Fri, 17 May 2024 17:19:26 +0300
Message-ID: <20240517141938.4177174-9-kirill.shutemov@linux.intel.com>
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
__tdx_hypercall() to handle MMIO emulation.

It cuts code bloat substantially:

Function                                     old     new   delta
tdx_handle_virt_exception                   1747    1383    -364

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c436cab355e0..df3e10d899b3 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -438,38 +438,34 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 	return ve_instr_len(ve);
 }
 
-static bool mmio_read(int size, unsigned long addr, unsigned long *val)
+static bool mmio_read(int size, unsigned long gpa, u64 *val)
 {
-	struct tdx_module_args args = {
-		.r10 = TDX_HYPERCALL_STANDARD,
-		.r11 = hcall_func(EXIT_REASON_EPT_VIOLATION),
-		.r12 = size,
-		.r13 = EPT_READ,
-		.r14 = addr,
-		.r15 = *val,
-	};
+	bool ret;
+	u64 out;
 
-	if (__tdx_hypercall(&args))
-		return false;
+	ret = !TDVMCALL_1(hcall_func(EXIT_REASON_EPT_VIOLATION),
+			  size, EPT_READ, gpa, 0, out);
+	if (ret)
+		*val = out;
 
-	*val = args.r11;
-	return true;
+	return ret;
 }
 
-static bool mmio_write(int size, unsigned long addr, unsigned long val)
+static bool mmio_write(int size, u64 gpa, u64 val)
 {
-	return !_tdx_hypercall(hcall_func(EXIT_REASON_EPT_VIOLATION), size,
-			       EPT_WRITE, addr, val);
+	return !TDVMCALL_0(hcall_func(EXIT_REASON_EPT_VIOLATION),
+			 size, EPT_WRITE, gpa, val);
 }
 
 static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
-	unsigned long *reg, val, vaddr;
+	unsigned long *reg, vaddr;
 	char buffer[MAX_INSN_SIZE];
 	enum insn_mmio_type mmio;
 	struct insn insn = {};
 	int size, extend_size;
 	u8 extend_val = 0;
+	u64 val;
 
 	/* Only in-kernel MMIO is supported */
 	if (WARN_ON_ONCE(user_mode(regs)))
-- 
2.43.0


