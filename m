Return-Path: <linux-hyperv+bounces-2173-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6DA8C87F2
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB601C23A95
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58156745F0;
	Fri, 17 May 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbWaeQgy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23D73165;
	Fri, 17 May 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955608; cv=none; b=SpXKmZae8tv3E1SxxYYoSf/VpbA//wOvSDLDCihe4hetei/ziCuj+1EwnSpFLZI+56kOz+kChrtjMagYDFNAz7OQcrMeh7vIvzsfCizTRjB26/hsPQfUl/PwzvBmVt+Yy54w5+uAmubiQPr5jmvmGxacUvTF7ql83tZRcIR1s3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955608; c=relaxed/simple;
	bh=mpeI7dxGBjXJkH2OOGSAH6mbSJNyYYKdgngapiZV/lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qthxnX5NUiDf0gBofzMRZhWHAFsPz525zxNKz8yvv9Yz7vIRaP+c0azvqR/6+8PHodxBpXHN8xeqTH3PeUc6CKabt3agDNal2z5RNQpxl5UtMpWRwG3mvnUh2cAUGV2RTUGQ8AwR7qIeyeDHjuMKftpOY9hla25VCd0B6FSKrXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbWaeQgy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955607; x=1747491607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mpeI7dxGBjXJkH2OOGSAH6mbSJNyYYKdgngapiZV/lM=;
  b=FbWaeQgyXb6f9UJWMqeDMueYJbo0BW2fiXikr/E8Zh/zhHn7JAeum2iG
   PQaqUV/V+qTbN58bL8VMwS8kZOw8TU6/wyoaF0ZGXAzECQ7ADD+Sv65Jj
   RS1ZEdvNi8IN0dQd1q7k7Pwe1hsp3howTqdvMuFgLaMy3g0zTyIGQukMC
   CxBq932OOl5ZVFv2Ra2CI2FjHajcQ78eGCbU316ICSqnhiXRXr4zl+Zg6
   2gJTgvqK4XwUkl5/tkbTX8K2pbwzVOwIwME3f8fPi+wE7/azz/uzQLu0T
   //rPl9vXKPR902kKXYlwTxBbI6mMuzOYnH1sVxqOh1OKaQY55eaw+TAtt
   g==;
X-CSE-ConnectionGUID: C2Hwg27xR5KrPOTjBaezhA==
X-CSE-MsgGUID: NOcnVgdHS362lSNKt+W4NQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808741"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808741"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:05 -0700
X-CSE-ConnectionGUID: E0nY6EjER3W1Z8B9VDY4QQ==
X-CSE-MsgGUID: XFBXlvQ6QW2hjlEr2xFsAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31944628"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 07:20:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 756D11084; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 16/20] x86/tdx: Convert VP_INFO tdcall to use new TDCALL_5() macro
Date: Fri, 17 May 2024 17:19:34 +0300
Message-ID: <20240517141938.4177174-17-kirill.shutemov@linux.intel.com>
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

Use newly introduced TDCALL_5() instead of tdcall() to issue VP_INFO
tdcall.

It cuts code bloat slightly:

Function                                     old     new   delta
tdx_early_init                               780     744     -36

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e7ffe1cd6d32..e1849878f3bc 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -247,20 +247,22 @@ static void enable_cpu_topology_enumeration(void)
 	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_ENUM_TOPOLOGY, TD_CTLS_ENUM_TOPOLOGY);
 }
 
+static void tdg_vp_info(u64 *gpa_width, u64 *attributes)
+{
+	u64 dummy, ret;
+
+	ret = TDCALL_5(TDG_VP_INFO, 0, 0, 0, 0, *gpa_width, *attributes, dummy,
+		       dummy, dummy);
+	BUG_ON(ret);
+
+	*gpa_width &= GENMASK(5, 0);
+}
+
 static void tdx_setup(u64 *cc_mask)
 {
-	struct tdx_module_args args = {};
-	unsigned int gpa_width;
-	u64 td_attr;
+	u64 gpa_width, td_attr;
 
-	/*
-	 * TDINFO TDX module call is used to get the TD execution environment
-	 * information like GPA width, number of available vcpus, debug mode
-	 * information, etc. More details about the ABI can be found in TDX
-	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
-	 * [TDG.VP.INFO].
-	 */
-	tdcall(TDG_VP_INFO, &args);
+	tdg_vp_info(&gpa_width, &td_attr);
 
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
@@ -269,11 +271,8 @@ static void tdx_setup(u64 *cc_mask)
 	 * The GPA width that comes out of this call is critical. TDX guests
 	 * can not meaningfully run without it.
 	 */
-	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
-	td_attr = args.rdx;
-
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
 	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
 
-- 
2.43.0


