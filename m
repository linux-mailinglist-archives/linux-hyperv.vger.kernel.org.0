Return-Path: <linux-hyperv+bounces-2175-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1068C87F6
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6E9B23E81
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DCE7581F;
	Fri, 17 May 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkT9baaF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44173514;
	Fri, 17 May 2024 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955609; cv=none; b=qCqmY4mE48CJ2ip35NQ2RHZhBcvvyFJn1Kn4xN/T30CtkaSw17uA7rmDDzlPdPL+7Wx2N9w9pAfcSbqrVEinUxMbgCqC5P/VKsZcBsEWDle5Jjyx4vV500RVsjBL8OL+Q/d9/yEa19p3gWjCgUSsNekTN5WzBwZRzdGhhivcnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955609; c=relaxed/simple;
	bh=+tEVi3m8qovNSY+AQYMMcgzTha+KB60hRspc+QX9Oac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/KLPd4txaThLjarI2npf2Q+UOUcEOVI61oqQXBfFMcaejVvNe4lwA89yg/iiLiA24oRUvCFgmSLAbJbTNWJGAdq7+iOxsf7pYuP8uoYENJrZYacd82uma8iRGIV3bRUuerWnqI8JK+aZ5MXb23Db2tQ0UAdkNLbWtkfez/B3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkT9baaF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955608; x=1747491608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+tEVi3m8qovNSY+AQYMMcgzTha+KB60hRspc+QX9Oac=;
  b=FkT9baaF1BrrZuHMQw93q8He0AX5jBqQz/DlcZZMVYKCP6e0URtBMTjY
   DFPyVGafWCRMWbPBuLbq0LL6P/11Ofh+oeGte3CojTMQqbX/LJKqutAOF
   IqIWkpOki3J7le+579o0cA/WoDeB+zhfTILNk1MpS9CTATKz7AXGX5Pju
   E4v/trbAlAIMmEEeE/E7xjfsi3DpcAu2hBJd0wnTRt1bBCXmftK0664yC
   vUdUipf4TmbIl3y0xMLVMCF8Bbzr+sjudbfm7WUmDCZLtHh1Oa+zhkEuZ
   9x2J9B74l3v3s/9wkaHA/kX8aQlwX8bAbiohHdrz8QBKbEKRLEVMm+Cb8
   g==;
X-CSE-ConnectionGUID: ueQn+DTQR82svELmu6qOHg==
X-CSE-MsgGUID: wUAaKOE4Tv2qZtfldrttQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808754"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808754"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:05 -0700
X-CSE-ConnectionGUID: 0/qU8eDTSq6mSdb2tK0n+Q==
X-CSE-MsgGUID: C1NoCwySQLm2a2euxgmfAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="69253427"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 17 May 2024 07:20:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9AADB1146; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 19/20] x86/tdx: Convert MR_REPORT tdcall to use new TDCALL_0() macro
Date: Fri, 17 May 2024 17:19:37 +0300
Message-ID: <20240517141938.4177174-20-kirill.shutemov@linux.intel.com>
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

Use newly introduced TDCALL_0() instead of tdcall() to issue
MR_REPORT tdcall.

It cuts code bloat substantially:

Function                                     old     new   delta
tdx_mcall_get_report0                        229     111    -118

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 42436a43bb49..45be53d5eeb4 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -101,19 +101,15 @@ static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
  */
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 {
-	struct tdx_module_args args = {
-		.rcx = virt_to_phys(tdreport),
-		.rdx = virt_to_phys(reportdata),
-		.r8 = TDREPORT_SUBTYPE_0,
-	};
 	u64 ret;
 
-	ret = __tdcall(TDG_MR_REPORT, &args);
-	if (ret) {
-		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
-			return -EINVAL;
+	ret = TDCALL_0(TDG_MR_REPORT, virt_to_phys(tdreport),
+		       virt_to_phys(reportdata), TDREPORT_SUBTYPE_0, 0);
+
+	if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+		return -EINVAL;
+	else if (ret)
 		return -EIO;
-	}
 
 	return 0;
 }
-- 
2.43.0


