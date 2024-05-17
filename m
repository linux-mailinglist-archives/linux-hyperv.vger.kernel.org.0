Return-Path: <linux-hyperv+bounces-2167-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4BE8C87E6
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1621F2592A
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F8F5FDA5;
	Fri, 17 May 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeYX4kLf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425246BB5C;
	Fri, 17 May 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955604; cv=none; b=J/CtXoHMPrXyQY5qGCwJ5Bz0GMIIE07T934r6Bf1TQ9/oKnyn7N/lkyaKzIvSzEPP/qDrpqIHs7HtjPnxaRn8K9uYkPPb5d2Np9l2QtWdyLCnorTIfTfi90dPCymLzbYDx3NVHHDeLV+ZPixQnr2aJLpE3W77Sm8VhJSryK+oZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955604; c=relaxed/simple;
	bh=/CzwNXVaKGEQ3E9bwjs3O7QSiO6r7/AsWG/VCkB8/H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8lJNI2GENWEid1g0bC0FBK3qrY4f239LKOqBMiqHXO+90J8k1V+8+kGwZE2a4EIdjOXECrMKg1zv2TZITBkSV6Ai/NFJh2ZDdUyagaC/gWJQ4Jjj6LCfvW1yN1t1VnM0dcs+TMGwPaYVXOXxpd2yiBMzBYmouVpzadk1MjmoWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeYX4kLf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955603; x=1747491603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CzwNXVaKGEQ3E9bwjs3O7QSiO6r7/AsWG/VCkB8/H8=;
  b=GeYX4kLfsL0UwjJEYow6qfzUGE11Ss/1A8u0vQijmQ495EDPRFD8Aqj5
   kIGxp24XyI/neMdz/oTblSvCwIYtLJJiu54hU6bVbwiZo+xuJTWuQViSo
   zV2S1YK7HeYz9McVaByO6uvIhfx7mrteGgfDEH3ywFFsshNg68rU1bdMa
   s3BrIXQBRQiHZRDbFMELcUcw2KF/G5XmeZqrs9POQeBxe8TverPnxi2aL
   YuznDNSfDg8JsI4SHlpOm+dhgIfxC5Mls4fYUEo96uEcyQv0gX0l0qKTj
   +Ecu2tYV7jPv41XHgos8at78XtAvtvbD0AqBLTnnyil1Jg/9btjWYT2Dk
   w==;
X-CSE-ConnectionGUID: DweLtl8/S/CHnxpctj+VsA==
X-CSE-MsgGUID: +I+bi5KdREiNlwC0CJdCzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808692"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808692"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:01 -0700
X-CSE-ConnectionGUID: O4NnF3dCRe+gATw4xDL+bg==
X-CSE-MsgGUID: Ps04XFBGQCydR14R0EDIpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="69253384"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 17 May 2024 07:19:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1B2CED7B; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 09/20] x86/tdx: Convert MAP_GPA hypercall to use new TDVMCALL macros
Date: Fri, 17 May 2024 17:19:27 +0300
Message-ID: <20240517141938.4177174-10-kirill.shutemov@linux.intel.com>
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

Use newly introduced TDVMCALL_1() instead of __tdx_hypercall() to issue
MAP_GPA hypercall.

It cuts code bloat substantially:

Function                                     old     new   delta
tdx_enc_status_changed                       352     242    -110
tdx_kexec_finish                             645     530    -115
tdx_enc_status_change_prepare                326     181    -145
Total: Before=5553, After=5183, chg -6.66%

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index df3e10d899b3..7c874a50a319 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -797,15 +797,10 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	}
 
 	while (retry_count < max_retries_per_page) {
-		struct tdx_module_args args = {
-			.r10 = TDX_HYPERCALL_STANDARD,
-			.r11 = TDVMCALL_MAP_GPA,
-			.r12 = start,
-			.r13 = end - start };
-
-		u64 map_fail_paddr;
-		u64 ret = __tdx_hypercall(&args);
+		u64 map_fail_paddr, ret;
 
+		ret = TDVMCALL_1(TDVMCALL_MAP_GPA,
+				 start, end - start, 0, 0, map_fail_paddr);
 		if (ret != TDVMCALL_STATUS_RETRY)
 			return !ret;
 		/*
@@ -813,7 +808,6 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 		 * region starting at the GPA specified in R11. R11 comes
 		 * from the untrusted VMM. Sanity check it.
 		 */
-		map_fail_paddr = args.r11;
 		if (map_fail_paddr < start || map_fail_paddr >= end)
 			return false;
 
-- 
2.43.0


