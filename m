Return-Path: <linux-hyperv+bounces-2227-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43F8D17A6
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 11:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAA91C230FF
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27C916C451;
	Tue, 28 May 2024 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBFl0l/W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5BD16B74D;
	Tue, 28 May 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890141; cv=none; b=uXrKm8PVAn+IJA+i/LW1YXChvgEhUknGAO8HNfdHIDjNYyONIVDIANiFl1yQPTlhrYXdD2AhPtRfi4KHL2XCLC83B4kpkK8r47WHyuOyCoCphfQTw7Wvfi9sIGVmm2TzZwpL4LunrByZAvsqyddiWjj6gbvw4SyPdejhI5T3sbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890141; c=relaxed/simple;
	bh=1Ao/ikZ8S7fcfs7AyRNlbTyq1f0/sctVD29fhkb/V7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ab5MapXvlaM17hhKbAXjJnjVxHUIW5gTDokcWYYiizKZBV0HEQEqW/wAUQlAhToVCeUjCqUITNMhMB9ddhD0ZfNGRuCRG5Vaj7O0VSzenO1v/p8WFl8cmisWSxefQXw5voWliBwtqnHncyjQEaXqmAGxEab+TPOu3HSaxA/cXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBFl0l/W; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716890140; x=1748426140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Ao/ikZ8S7fcfs7AyRNlbTyq1f0/sctVD29fhkb/V7c=;
  b=eBFl0l/WS18t9xCXVqQAEYlUDfPIv/Ll7s5wjxioUOc6peawjTJV0mx5
   i/h3su09BiraA5UKh1y7F5EUzLqLbjE4iCjMcWLoNIcOvUObDQvN3A1II
   FjF5bnLDqG5wxPTZHWX9ChpLE3a+XWKVObZsw9/Q8mD35WSGeQqQub+L+
   bF2qnO4OhUsiavwW9dsT0GC3l812jMypJJz91IjYAm3+2Z/OkRXLMXnpn
   G7DkpLNYSYI7bkYG5YxSysFIJOnNrTcujSSZo6JBIlLBMpvIGj964KomV
   5MCPDxtqmrhsne88bBW/GR3ahMlycH5GfodeyJxW+kjYqGy2xjmIPGxfl
   A==;
X-CSE-ConnectionGUID: H6w9qNvIStuh5emAzU2g8Q==
X-CSE-MsgGUID: uS3HfT5dQGS89G/hAni7YA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13097705"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13097705"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:55:40 -0700
X-CSE-ConnectionGUID: Fk5CfntVT8itV++npyuEuA==
X-CSE-MsgGUID: wXWsGwUUR2Sm0VUPlqM7FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34951732"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 02:55:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 832934E7; Tue, 28 May 2024 12:55:26 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHv11 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
Date: Tue, 28 May 2024 12:55:09 +0300
Message-ID: <20240528095522.509667-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
that bit is cleared during CR4 register reprogramming during boot or
kexec flows, a #VE exception will be raised which the guest kernel
cannot handle it.

Therefore, make sure the CR4.MCE setting is preserved over kexec too and
avoid raising any #VEs.

The change doesn't affect non-TDX-guest environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 085eef5c3904..b668a6be4f6f 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,8 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/stringify.h>
+#include <asm/alternative.h>
 #include <asm/page_types.h>
 #include <asm/kexec.h>
 #include <asm/processor-flags.h>
@@ -143,15 +145,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 
 	/*
 	 * Set cr4 to a known state:
-	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest, if it was enabled before.
+	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
+	 *  - physical address extension enabled
 	 */
-	movl	$X86_CR4_PAE, %eax
-	testq	$X86_CR4_LA57, %r13
-	jz	.Lno_la57
-	orl	$X86_CR4_LA57, %eax
-.Lno_la57:
+	movl	$X86_CR4_LA57, %eax
+	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
 
+	/* R13 contains the original CR4 value, read in relocate_kernel() */
+	andl	%r13d, %eax
+	orl	$X86_CR4_PAE, %eax
 	movq	%rax, %cr4
 
 	jmp 1f
-- 
2.43.0


