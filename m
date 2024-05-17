Return-Path: <linux-hyperv+bounces-2172-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701FD8C87F0
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C0FB23B47
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFCE73539;
	Fri, 17 May 2024 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fa+jE+S9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D0271750;
	Fri, 17 May 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955607; cv=none; b=eXq7euzZohIjYNG3hlpiNgglVW3sNLYQzPW/rqjwRsDfo9+JR6bWWOfME0W4I9SD8O4jvdhQJmyq+SYcEagr3lETy4vOTS4nCKfFUVp7R1yCHVxsyPJa5R9e+sI0b0ngHJkh0IvpqGxGxue0bImXBI5maw4YfYrZrbwHM5Fq2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955607; c=relaxed/simple;
	bh=0sOCyuIE9yUNs9m+zPMFvR+dpm6EUDIzGSm4n+Yw9H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN+Z1/MQxsNjmcpqmmKzWMKsSLBZzDG6FtCLucxB2Z2tnffszyZpE1IXB5EuEQHXVKkn3ROvNAT7GW6FNwcFVgDL9ghahPZ4mxOcJF7vkxHC0Sz7Q/q/wr9wGynG2CG+Zjb5yy13gwo98QzowNdO7CHeRqJZ/OdWcBsb3SjBGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fa+jE+S9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955606; x=1747491606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0sOCyuIE9yUNs9m+zPMFvR+dpm6EUDIzGSm4n+Yw9H8=;
  b=fa+jE+S9VKRCFbxq+aimz5+aVgZPokraQl8xD9uVOcQjnXVfoeIj/2hY
   iTtD3w+ImUWYJz8xUHMWdCuUHF/83IlKteBtUWji2uWjMnjAm5XUQZluS
   E2Cc71KsDFM/a/cdd+0QqBbzU/cTs/x9UN+eHC3iCITBafCIBf0iLH03/
   vltlmwdOpr55EkHH1ETNK6XxeDXDj4CRq4IcTxtYT5qXv0Sc0IQwugqRA
   XI+92kINmdGIRtedwQlVWX7Xl7W9gpkWlNsZnuJUQynkvglwyLHLkVcax
   Sh/4ZEwZpYXMaYBzpNNcmQvgI3YcnXIJkrFdJ31skuWmCwwRT1vj2Q7fh
   A==;
X-CSE-ConnectionGUID: +boyJUc8T2OD97z34jwl4w==
X-CSE-MsgGUID: 4xCxoDkkSsmfXGbgmuhBQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808729"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808729"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:20:04 -0700
X-CSE-ConnectionGUID: Yq5WDUTCRuOlXKKW2AH2Qw==
X-CSE-MsgGUID: KD9wOimsS0GmnoCnwUgOkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="69253422"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 17 May 2024 07:20:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 69760F21; Fri, 17 May 2024 17:19:50 +0300 (EEST)
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
Subject: [PATCH 15/20] x86/tdx: Convert PAGE_ACCEPT tdcall to use new TDCALL_0() macro
Date: Fri, 17 May 2024 17:19:33 +0300
Message-ID: <20240517141938.4177174-16-kirill.shutemov@linux.intel.com>
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

Use newly introduced TDCALL_0() instead of __tdcall() to issue
PAGE_ACCEPT tdcall.

It cuts code bloat substantially:

Function                                     old     new   delta
tdx_accept_memory                            592     233    -359

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx-shared.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index 1655aa56a0a5..9104e96eeefd 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -5,8 +5,8 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 				    enum pg_level pg_level)
 {
 	unsigned long accept_size = page_level_size(pg_level);
-	struct tdx_module_args args = {};
 	u8 page_size;
+	u64 ret;
 
 	if (!IS_ALIGNED(start, accept_size))
 		return 0;
@@ -34,8 +34,8 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 		return 0;
 	}
 
-	args.rcx = start | page_size;
-	if (__tdcall(TDG_MEM_PAGE_ACCEPT, &args))
+	ret = TDCALL_0(TDG_MEM_PAGE_ACCEPT, start | page_size, 0, 0, 0);
+	if (ret)
 		return 0;
 
 	return accept_size;
-- 
2.43.0


