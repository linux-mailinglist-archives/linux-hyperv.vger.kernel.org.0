Return-Path: <linux-hyperv+bounces-2176-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C498C87F9
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A0D1F26692
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553E676F1B;
	Fri, 17 May 2024 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRopIITK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6974C14;
	Fri, 17 May 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955610; cv=none; b=jc2IhbaknSenjxcrYapFjH7Au44hfz/10fn+du9zYm4CXIIr1rBiLIPS6AkretpeF2+b9zvvd1klwlLDmLNrRYDylCw0+F5/xa/ZTXzBpBwVoKndIj8JnR+FwxbFeIMUTUFMtN5/Ncv1JgoX7qAw1SVAdMhiBnRNVz8GK++OvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955610; c=relaxed/simple;
	bh=C3SOvLF3a7cbP+wZzmvHsHcoeWpug9aDQsg/WGa80aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIIkRhK3e3SJJBYZO49HEzHXJYic6Jw+Ubn5oiogkOd9jApnPtCmcQQUcD4fhbY/v8xOHksHfAiqRY6rxvMiiMn1x/5wahzCtHDzlyypWD2cUP1rY5grVSdJa86c6OZxGEX1riWiD5irCjlqOeLiuwaIeNA9aMRtrAWmk++XIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRopIITK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955609; x=1747491609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C3SOvLF3a7cbP+wZzmvHsHcoeWpug9aDQsg/WGa80aU=;
  b=jRopIITKB0S4lvnnH9F1Zp8x0bVm+r29Tl9x+tbEQGU9BbEVJ4kK4aGI
   HKyisarX4G6YUKLzMoasKO1EQdzYicEYh2vGfTaQKGtOK8zzIsSNoLSNi
   mvExHr3qro6slp1+DGnMx+iLbTqzb+Lf+7x1stdJD85GUqPXITCe/do9S
   1H/efnWYYsZl9Zxdzoi4w67wlokuxNy/EcI+QUUXv3WZdlHO8cl3xlL+n
   VnhNmX9HjQQWi8Xm20vegd9lJYRjntyVwnhb1XCNBk+EsSDllHMVPzecn
   iW9yy9o/JSnNCHM1RGbw5DpqAP8TQ0lI80fP/YckwPpCF/SBE43n+TDRh
   w==;
X-CSE-ConnectionGUID: nTMIvi+OSo6mB3yavzPZsg==
X-CSE-MsgGUID: OS1miaUbTB23Q/x1TUjsng==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808776"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808776"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:05 -0700
X-CSE-ConnectionGUID: Epx+dGTEQkK5Jo4YWkd2lg==
X-CSE-MsgGUID: R+1g+lUET1K9XNzHKwBZqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31944631"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 07:20:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 84A4010A3; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 17/20] x86/tdx: Convert VM_RD/VM_WR tdcalls to use new TDCALL macros
Date: Fri, 17 May 2024 17:19:35 +0300
Message-ID: <20240517141938.4177174-18-kirill.shutemov@linux.intel.com>
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

Use newly introduced TDCALL instead of tdcall() to issue VM_RD/VM_WR
tdcalls

It increase code slightly:

Function                                     old     new   delta
tdx_early_init                               744     776     +32

but combined with VP_INFO changes the total effect on tdx_early_init()
is code reduction.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e1849878f3bc..6559f3842f67 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -76,27 +76,13 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
 /* Read TD-scoped metadata */
 static inline u64 tdg_vm_rd(u64 field, u64 *value)
 {
-	struct tdx_module_args args = {
-		.rdx = field,
-	};
-	u64 ret;
-
-	ret = __tdcall_ret(TDG_VM_RD, &args);
-	*value = args.r8;
-
-	return ret;
+	return TDCALL_1(TDG_VM_RD, 0, field, 0, 0, value);
 }
 
 /* Write TD-scoped metadata */
 static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
 {
-	struct tdx_module_args args = {
-		.rdx = field,
-		.r8 = value,
-		.r9 = mask,
-	};
-
-	return __tdcall(TDG_VM_WR, &args);
+	return TDCALL_1(TDG_VM_WR, 0, field, value, mask, value);
 }
 
 /**
-- 
2.43.0


