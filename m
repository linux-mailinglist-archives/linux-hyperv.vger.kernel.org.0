Return-Path: <linux-hyperv+bounces-2174-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F118C87F5
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D391F26196
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482747580C;
	Fri, 17 May 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3he+NxE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F874262;
	Fri, 17 May 2024 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955609; cv=none; b=dZRfq297E8cN0Epx5nlEPUQbavUa8y693w16PZlsBY29wsgpB6qygFNEVEnC+jPV2K6ajEraJ0lmOoqQU5E9wUvMZH8S/y8oefUdMW4+8oQGbKGiZPvxya00dEE227PiLDRBe8IZ5ay1HyDHa8jGiS5NB9f5MtuJRkCDI57GJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955609; c=relaxed/simple;
	bh=WocfCtclpVmI7/9b65p2gbJIFvpIqrPqyDYD9iiubjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sfr1A+AjdoaFvKVmGNx64+w6CEhLtvNI9r1yFPxEsGWBKD1ha1R4UEHa8rwPzey1IJ/tIGnV+nxXgp0kw3TO/4NZlk9GOu/6aO6NeWmeQSVQGhZtzuv+r9JpI0jSVKkKM8CNb0DJ0AFV888dO8WroQ7nYc/jJE/YNmEkOg/sceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3he+NxE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955608; x=1747491608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WocfCtclpVmI7/9b65p2gbJIFvpIqrPqyDYD9iiubjI=;
  b=W3he+NxEBxI8dMWdlWlAkrrvvArPUVDnqmXpo/OZeCOnd4rRp0u+luex
   EAaYD8sdNl2AY8WgaLc3O8CnNI0IyoZIxRSY/V7Y07IWe+VNzwqmW8G9i
   3lPySQr7c/mjmTVcRzGv5/19MKnAkdmLWtJ1EL75uaP9SEjbTtO2dE4b/
   MzRPrszhlvdOMj7s8Zg5ycV/iXu7WJ0hABWINb14Qw1VQdC31tPlEk/FZ
   B3bcGpEK4svcqDeMT3vmFzsQf4uSBCH4XDV2LJbBwyjVrZSez/xSi/d8F
   kycp1wwxQdv/YwDN1RP37UPEi7dJlP3SWTeii1uEpDFF1S5IKAll5Ov0X
   Q==;
X-CSE-ConnectionGUID: ie+0S6v0QNOILJTs6vjGUA==
X-CSE-MsgGUID: 0BTd5nDxQoiCVQX7w6xz/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808764"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808764"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:05 -0700
X-CSE-ConnectionGUID: gYjuXclTQtSwzEcwcK8DUw==
X-CSE-MsgGUID: WJVtLYOmRje/oWByI/JzNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31944632"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 07:20:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8D7701140; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 18/20] x86/tdx: Convert VP_VEINFO_GET tdcall to use new TDCALL_5() macro
Date: Fri, 17 May 2024 17:19:36 +0300
Message-ID: <20240517141938.4177174-19-kirill.shutemov@linux.intel.com>
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

Use newly introduced TDCALL_5() instead of tdcall() to issue
VP_VEINFO_GET tdcall.

It cuts code bloat substantially:

Function                                     old     new   delta
tdx_get_ve_info                              253     116    -137

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 6559f3842f67..42436a43bb49 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -615,32 +615,15 @@ __init bool tdx_early_handle_ve(struct pt_regs *regs)
 
 void tdx_get_ve_info(struct ve_info *ve)
 {
-	struct tdx_module_args args = {};
+	u64 instr_info, ret;
 
-	/*
-	 * Called during #VE handling to retrieve the #VE info from the
-	 * TDX module.
-	 *
-	 * This has to be called early in #VE handling.  A "nested" #VE which
-	 * occurs before this will raise a #DF and is not recoverable.
-	 *
-	 * The call retrieves the #VE info from the TDX module, which also
-	 * clears the "#VE valid" flag. This must be done before anything else
-	 * because any #VE that occurs while the valid flag is set will lead to
-	 * #DF.
-	 *
-	 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
-	 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
-	 */
-	tdcall(TDG_VP_VEINFO_GET, &args);
+	ret = TDCALL_5(TDG_VP_VEINFO_GET, 0, 0, 0, 0,
+		 ve->exit_reason, ve->exit_qual, ve->gla, ve->gpa, instr_info);
 
-	/* Transfer the output parameters */
-	ve->exit_reason = args.rcx;
-	ve->exit_qual   = args.rdx;
-	ve->gla         = args.r8;
-	ve->gpa         = args.r9;
-	ve->instr_len   = lower_32_bits(args.r10);
-	ve->instr_info  = upper_32_bits(args.r10);
+	BUG_ON(ret);
+
+	ve->instr_len   = lower_32_bits(instr_info);
+	ve->instr_info  = upper_32_bits(instr_info);
 }
 
 /*
-- 
2.43.0


