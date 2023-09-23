Return-Path: <linux-hyperv+bounces-244-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE8C7ABFD6
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D0B4A2810FF
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Sep 2023 10:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908A10A14;
	Sat, 23 Sep 2023 10:12:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F410A08
	for <linux-hyperv@vger.kernel.org>; Sat, 23 Sep 2023 10:12:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE194E5D;
	Sat, 23 Sep 2023 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695463917; x=1726999917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/UldAmuJEnsflYS2+cyLAQ4E+J1yAKX8pToUnF0eneI=;
  b=cSgCws86QNPsjOO5vVLxydRsfm5uymPrqcLO/cLPHAOLmoAx1dwP2l9Y
   cRK1fqM3UKAxPhRwY7EfH7LC858sWA7bfExQRUyDK/OCDFeWZcg0j/G5F
   zDjspyIy0nyBnLjn+l2xynn+FEFmrxiCE+GutdSnUObZ4686/pgJB7Tei
   5+vw520MNuKuDRykFe3HZVb6+pVNwTXJ3czCMn5TOhj+nh/Bog6zrzwja
   YUhhLJOaiSljHU1N9iaS1atRAa0itFA6yfKCeu4PNCLPqwtSuyuOVMp4h
   lvZLaTdnpI9a0Ua5QXlrqcyocZTfygd+0rFtpiygg1jgkcviRh1dRXcr7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447492461"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="447492461"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 03:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="813388214"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="813388214"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2023 03:11:51 -0700
From: Xin Li <xin3.li@intel.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	peterz@infradead.org,
	jgross@suse.com,
	ravi.v.shankar@intel.com,
	mhiramat@kernel.org,
	andrew.cooper3@citrix.com,
	jiangshanlai@gmail.com,
	nik.borisov@suse.com
Subject: [PATCH v11 32/37] x86/entry/calling: Allow PUSH_AND_CLEAR_REGS being used beyond actual entry code
Date: Sat, 23 Sep 2023 02:42:07 -0700
Message-Id: <20230923094212.26520-33-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923094212.26520-1-xin3.li@intel.com>
References: <20230923094212.26520-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

PUSH_AND_CLEAR_REGS could be used besides actual entry code; in that case
%rbp shouldn't be cleared (otherwise the frame pointer is destroyed) and
UNWIND_HINT shouldn't be added.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/entry/calling.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index f6907627172b..eb57c023d5df 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -65,7 +65,7 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-.macro PUSH_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0
+.macro PUSH_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0 unwind_hint=1
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
@@ -87,14 +87,17 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%r13		/* pt_regs->r13 */
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
+
+	.if \unwind_hint
 	UNWIND_HINT_REGS
+	.endif
 
 	.if \save_ret
 	pushq	%rsi		/* return address on top of stack */
 	.endif
 .endm
 
-.macro CLEAR_REGS
+.macro CLEAR_REGS clear_bp=1
 	/*
 	 * Sanitize registers of values that a speculation attack might
 	 * otherwise want to exploit. The lower registers are likely clobbered
@@ -109,7 +112,9 @@ For 32-bit we have the following conventions - kernel is built with
 	xorl	%r10d, %r10d	/* nospec r10 */
 	xorl	%r11d, %r11d	/* nospec r11 */
 	xorl	%ebx,  %ebx	/* nospec rbx */
+	.if \clear_bp
 	xorl	%ebp,  %ebp	/* nospec rbp */
+	.endif
 	xorl	%r12d, %r12d	/* nospec r12 */
 	xorl	%r13d, %r13d	/* nospec r13 */
 	xorl	%r14d, %r14d	/* nospec r14 */
@@ -117,9 +122,9 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0
-	PUSH_REGS rdx=\rdx, rcx=\rcx, rax=\rax, save_ret=\save_ret
-	CLEAR_REGS
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0 clear_bp=1 unwind_hint=1
+	PUSH_REGS rdx=\rdx, rcx=\rcx, rax=\rax, save_ret=\save_ret unwind_hint=\unwind_hint
+	CLEAR_REGS clear_bp=\clear_bp
 .endm
 
 .macro POP_REGS pop_rdi=1
-- 
2.34.1


