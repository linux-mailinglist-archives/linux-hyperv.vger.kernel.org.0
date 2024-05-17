Return-Path: <linux-hyperv+bounces-2170-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974F98C87EC
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A030B1C23575
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293971B52;
	Fri, 17 May 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrZe/1x1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048C6E610;
	Fri, 17 May 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955606; cv=none; b=RFsbFDq0omYF/YVdD+Q8RnYDhbbPah0Xlb725UEh3SoDIucVFlmnAp6m+JW1E+kfwzZwpyx8LMktPkwNkGp+1i8SkZnMwdx9Mae7A9ZrYY2mZAkgE68OM8xoSPu4DuXnP3VobgP2+0RbDGmqdc+lpVuJ42sg2StLsfCu9UTCA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955606; c=relaxed/simple;
	bh=k2swUgV0BCGyXi52V0yVB3FayPL92XVdPDIburVHsSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rguFlhnr9zjdNmfXzw2zRgKXXqQUEUdLiGooldbsVB3KY/rLGyLBlI9yz8RsdbJ0Q7DqRpJnbR58cbX3sGJS6AQcFcrLBetoj2f0ye+eY9how9D3SLyIOTqygB1A1orZWNpCb2iNh7FxwQElPguWH7/h6fubypGuSYwC0SRKNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrZe/1x1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955605; x=1747491605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k2swUgV0BCGyXi52V0yVB3FayPL92XVdPDIburVHsSw=;
  b=XrZe/1x1Rl1HpJRcGtYx8fHH3EHH3GTCzuEUi2gVawORFRbtuXmhlh9M
   Kj94M1iu0HJ8mlwRaOjGaLav5Z9GU5fPinIYV8LdwaWgUfnw3Eh5RbUVC
   ZmFuH3h6MhTPTbXXbRV2h8SCgX4k7epENAErhEJMlGiVZtcRCuBBD7GnC
   EIhk3EJL1DdjUMs/RQVEdbU0qYonzWeHXUOT2NfvXLVJMUGNlSrxkTt2/
   7UwrWHHji5ytS6aaDNOxvxqxsdASAzCRjvAfesIMsPHTx5CLaUWJ5PMbB
   WF6tRwUJs8Kl8pavclsjIpEQ3gY4/e8vlY03uBG+A50aMaazmP/UNIRJr
   g==;
X-CSE-ConnectionGUID: f8DPN3N/Q86QsVpeQaxgJg==
X-CSE-MsgGUID: zGaDOI8/ScOwoo2+62OIUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808713"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808713"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:01 -0700
X-CSE-ConnectionGUID: uVe0gu2iR3agrMF4Qt0k3w==
X-CSE-MsgGUID: q1iY+mGRSqK697dMyL56+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31944621"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 07:19:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 42E2AEB0; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 12/20] x86/tdx: Rewrite tdx_kvm_hypercall() without __tdx_hypercall()
Date: Fri, 17 May 2024 17:19:30 +0300
Message-ID: <20240517141938.4177174-13-kirill.shutemov@linux.intel.com>
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

tdx_kvm_hypercall() issues KVM hypercall. Rewrite it without using
__tdx_hypercall(). Use tdvmcall_trampoline() instead.

It cuts code bloat substantially:

Function                                     old     new   delta
tdx_kvm_hypercall                            160      53    -107

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b7299e668564..e7ffe1cd6d32 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -49,15 +49,15 @@ noinstr void __noreturn __tdx_hypercall_failed(void)
 long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 		       unsigned long p3, unsigned long p4)
 {
-	struct tdx_module_args args = {
-		.r10 = nr,
-		.r11 = p1,
-		.r12 = p2,
-		.r13 = p3,
-		.r14 = p4,
-	};
+	long ret;
 
-	return __tdx_hypercall(&args);
+	asm("call	tdvmcall_trampoline\n\t"
+	    "movq	%%r10, %0\n\t"
+	    : "=r" (ret)
+	    : "a" (nr), "b" (p1), "D" (p2), "S"(p3), "d"(p4), "c" (0)
+	    : "r12", "r13", "r14", "r15");
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
 #endif
-- 
2.43.0


