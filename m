Return-Path: <linux-hyperv+bounces-2164-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 887598C87E0
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CD9B23311
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1686BB45;
	Fri, 17 May 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYyUwNdA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7D657C6;
	Fri, 17 May 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955603; cv=none; b=gpiZoxg60uZyYa3ehZLkj6h1Q5vUrTXMFnpH40YCQHLUA4MHQFJ+/vI58V9xfgQ43oEI861gSPSdNbpcZww4egBZ/Qb+j5gbFO/u7dQ5URAttjHl/KcWQct1a4uUJ4resPdE9+W7037SBL7dyXGaWY5IHmTIiAruFLFW4Laz8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955603; c=relaxed/simple;
	bh=tHoxgIZyyik8ZVUSPgSNSEV0q6AJ2EgF7vlCRqN3mxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbyIbm4Fg58vA36b8IfsR5mFgbFPjJhJBPysKCzwZARRZRBHWGjnAPtihmswGvLkAS+eGsASR8zsrxeY75u/12dy3GCJ+oQq2VHQfpP9EX1OoYOq6Bvn6hAmnTxNF2DbkgfzCsAlsqFcn7x5EZtHkuEuNGFjTs9utlrN/dlJdIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYyUwNdA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955602; x=1747491602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tHoxgIZyyik8ZVUSPgSNSEV0q6AJ2EgF7vlCRqN3mxE=;
  b=EYyUwNdAoyjDI0w7glAiWiRowI1D6xRHpZZKIpCAYQ7h7TS4r5IvyVAY
   vUZFXukfB9cVZqvznMGvC6w+Hbr4J2Nf0FYTlgbgq9/DBgY+XXpDtJcfS
   1hsqOubVbryDFFG4d6WtJn8iTnjvGXoX2Oz3fl5ZTPRjrWSwZassklLL8
   cOeKk80PSJ6rMhyfs/Dz1VJOoaoAI/8ERl3XoBQ0jVtbHzh6nmM9uU2JU
   Ox3pGvVmm1V1DFHqf/MqcW4hm1yxE5jZCbxnzl2tH8OCPE7PgK+Va+860
   ZwqfJEDupNHo/SVEAdHQXnngZ6T7+qiDS4arhNfm8tk0F/Nm7bX+jgwhH
   A==;
X-CSE-ConnectionGUID: K31UD5VdQSuGlpc2zf8SVw==
X-CSE-MsgGUID: mzBs00YySEKi7HZ9DpCmbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808631"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808631"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:00 -0700
X-CSE-ConnectionGUID: uDULCkgOSQu2dl08FomWMA==
X-CSE-MsgGUID: W/Vz89qaTeKWBaSMYfnBdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31944618"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 07:19:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 26C60D7E; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 10/20] x86/tdx: Convert GET_QUOTE hypercall to use new TDVMCALL macros
Date: Fri, 17 May 2024 17:19:28 +0300
Message-ID: <20240517141938.4177174-11-kirill.shutemov@linux.intel.com>
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

Use newly introduced TDVMCALL_0() instead of __tdx_hypercall() to issue
GET_QUOTE hypercall.

It cuts code bloat substantially:

Function                                     old     new   delta
tdx_hcall_get_quote                          188      76    -112

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7c874a50a319..3f0be1d3cccb 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -150,7 +150,8 @@ EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
 u64 tdx_hcall_get_quote(u8 *buf, size_t size)
 {
 	/* Since buf is a shared memory, set the shared (decrypted) bits */
-	return _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(buf)), size, 0, 0);
+	return TDVMCALL_0(TDVMCALL_GET_QUOTE,
+			  cc_mkdec(virt_to_phys(buf)), size, 0, 0);
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
-- 
2.43.0


