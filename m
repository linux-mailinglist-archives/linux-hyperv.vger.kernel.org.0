Return-Path: <linux-hyperv+bounces-2419-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47B9088F2
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 12:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54589292334
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 10:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE039195FEA;
	Fri, 14 Jun 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UePSgDT7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4E195B16;
	Fri, 14 Jun 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359163; cv=none; b=V0FagFbiVzVkVet2nfdQMGmLVv/1dJ9NErOrLfu7W9lrV1rUk+5O133ENP8FVfItlKATppkKYuDQPJKz7TmBAB+rc9TDFH+CoUU4dDNLvkWKk1sv89oFZoZ51OEgJq+Nz2VhS8f+79KD1GOJJ9bz9JH49rOfDPT8v3KScEuQ7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359163; c=relaxed/simple;
	bh=8RuKShLb68S6LRpGQ6wdyLdANMeeZ1vPWV/tN3LwSRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsvZlwJfIlChFhaqSJ45YqYSzoeGDm4piZFDAqWZPEF94kozQllkpTGT1iDJAXyhuMBAwgn92kBof0AKOrPEOduuorfX9O9yp19RpyKuw9O3rMGievLLlCuxwxBcBbAHrv6lbxewNG/KJwwvSm58WZnLdTdECFAEhKP8TCrVYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UePSgDT7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359163; x=1749895163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8RuKShLb68S6LRpGQ6wdyLdANMeeZ1vPWV/tN3LwSRk=;
  b=UePSgDT7dD3cd8S62GAmpN7cpSt4nF4WPoled4mlvckK/KueomDEm8Kx
   SrWRGQN3WRNqrhw2fNjpy2COjzyngA8rBdTJszQgEwWQhmBmwMx177I3I
   Mgkz6MUg8tCPfhWMR105t3A9qHe5RUwfKPnDMPbBq5hRMB6nvCDQkzAGG
   NhnPWlE/ZK7pAVhwvTjcVSq8uhd/+Cj6ZIqmpH2qVeknpOvjjttc96y6v
   LMXeKeRAUJcXoDu9gYH82v3oZXaeNcTwlQR9VHijkUe88Vn/ajYszAHB2
   9LgFN5M+KdaSiru53QuNP4cGTVt+XOaDle2SyYSKGn14WAgL6oLK42MEl
   g==;
X-CSE-ConnectionGUID: 5Klll1/iRxSUgSjTIbAspg==
X-CSE-MsgGUID: tVJlN25pSKGSFHTgql1ZTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="12072359"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="12072359"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:59:22 -0700
X-CSE-ConnectionGUID: jfPlNtGASBuzJVT4swnS5Q==
X-CSE-MsgGUID: yiNLfgBrRRerhwW68UKSTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44995838"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jun 2024 02:59:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C3D6529A8; Fri, 14 Jun 2024 12:59:08 +0300 (EEST)
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
Subject: [PATCHv12 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
Date: Fri, 14 Jun 2024 12:58:51 +0300
Message-ID: <20240614095904.1345461-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
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
cannot handle.

Therefore, make sure the CR4.MCE setting is preserved over kexec too and
avoid raising any #VEs.

The change doesn't affect non-TDX-guest environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 8b8922de3765..042c9a0334e9 100644
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
@@ -145,14 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest, if it was enabled before.
+	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
+	 *
+	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
+	 * PAE is always set in the original CR4.
 	 */
-	movl	$X86_CR4_PAE, %eax
-	testq	$X86_CR4_LA57, %r13
-	jz	.Lno_la57
-	orl	$X86_CR4_LA57, %eax
-.Lno_la57:
-
-	movq	%rax, %cr4
+	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
+	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
+	movq	%r13, %cr4
 
 	/* Flush the TLB (needed?) */
 	movq	%r9, %cr3
-- 
2.43.0


