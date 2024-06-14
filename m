Return-Path: <linux-hyperv+bounces-2420-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C19088F4
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 12:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76E21C25CB2
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81917196C72;
	Fri, 14 Jun 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDERvxc5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE26412F5A0;
	Fri, 14 Jun 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359164; cv=none; b=j0cnwwbJoDKFSWmqPDxP1IJ+RiB6guhab/bH5rPZevOdJ9eCAp0BUFhOfOqCi2VXOvve/xqKS5S2AH/qfAcIzYWhmCGwiF4FtzvOzEQJ2XptCpeinT4uJajQBUyUd2GBH6+Kz14PHXI28qCbLv4StQhivovRAiWFIkVT+FX2b3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359164; c=relaxed/simple;
	bh=TPVYWp6K4eYFN3ECeVkCGPve1U6kGjk/ZQY722Hu1c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YK0Y3XHh8rCFBOKiECm9bkPPI9e1Zh7/QAEW6hhEkBfAcl45zbQvVV1m4cQ3cJj+PjLha53zmQtm9sNJ76vSn7K4jQ8ilS9jy+++yo365ug4mnUEWF/kuLxSwcjo96mAHTfbBop16fFDiu32FlJOzs4OdvqmfHbOhj7Wv4Yu43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDERvxc5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359163; x=1749895163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TPVYWp6K4eYFN3ECeVkCGPve1U6kGjk/ZQY722Hu1c0=;
  b=bDERvxc5MdbAjnv9Og0Vh08cgLJ9q5poVMvSG7ZrPCVgGMvSkrg404LD
   X1XBWfifqu9AXpWdR8FiSzhEDlEUmXKmv060n1SukmJR0z7pA9lbpLwME
   ZhlPElZEX8UTP/fwuyiAgGYbjTflgXBlWt/+Pjugl1tIjw3ByC/LMnBt+
   IrUvGQGPFpPAY2mAYELNhdOlzcQ+QOs5GieNWCP3KjcLa5xsjRmLAuFzz
   beLDVmwkBJzNQihzTpCxHLyqqxZ9G6iSi0iMWAeEHyrAO6ed95FKzXZn4
   rIUCTK0W32GaXgTMSaoP3sbaFlPq3kfNBGvGjrAHK9nYx1n8EHsT/DIgr
   A==;
X-CSE-ConnectionGUID: v0NfnZomRqe6czWNs/GNDw==
X-CSE-MsgGUID: B6M0fEgvRruispo08Cs4Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="12072350"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="12072350"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:59:22 -0700
X-CSE-ConnectionGUID: Yn96X/ZzS26geW8DkbHADA==
X-CSE-MsgGUID: TDAG2v6KTmm206OkgymmAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44995836"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jun 2024 02:59:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B7E102998; Fri, 14 Jun 2024 12:59:08 +0300 (EEST)
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
Subject: [PATCHv12 05/19] x86/relocate_kernel: Use named labels for less confusion
Date: Fri, 14 Jun 2024 12:58:50 +0300
Message-ID: <20240614095904.1345461-6-kirill.shutemov@linux.intel.com>
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

From: Borislav Petkov <bp@alien8.de>

That identity_mapped() functions was loving that "1" label to the point
of completely confusing its readers.

Use named labels in each place for clarity.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 54e620021c7e..8b8922de3765 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -148,9 +148,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 */
 	movl	$X86_CR4_PAE, %eax
 	testq	$X86_CR4_LA57, %r13
-	jz	1f
+	jz	.Lno_la57
 	orl	$X86_CR4_LA57, %eax
-1:
+.Lno_la57:
+
 	movq	%rax, %cr4
 
 	/* Flush the TLB (needed?) */
@@ -162,9 +163,9 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * used by kexec. Flush the caches before copying the kernel.
 	 */
 	testq	%r12, %r12
-	jz 1f
+	jz .Lsme_off
 	wbinvd
-1:
+.Lsme_off:
 
 	movq	%rcx, %r11
 	call	swap_pages
@@ -184,7 +185,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 */
 
 	testq	%r11, %r11
-	jnz 1f
+	jnz .Lrelocate
 	xorl	%eax, %eax
 	xorl	%ebx, %ebx
 	xorl    %ecx, %ecx
@@ -205,7 +206,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	ret
 	int3
 
-1:
+.Lrelocate:
 	popq	%rdx
 	leaq	PAGE_SIZE(%r10), %rsp
 	ANNOTATE_RETPOLINE_SAFE
-- 
2.43.0


