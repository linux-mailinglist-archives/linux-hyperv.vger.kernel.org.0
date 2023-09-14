Return-Path: <linux-hyperv+bounces-61-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABB779FAC2
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 07:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B542C1C20971
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 05:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCB5611B;
	Thu, 14 Sep 2023 05:19:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D56108
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 05:19:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734BE1BDC;
	Wed, 13 Sep 2023 22:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694668765; x=1726204765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/UldAmuJEnsflYS2+cyLAQ4E+J1yAKX8pToUnF0eneI=;
  b=TaqSvYNn4Heg6xWEoZQghBw7imXmV6uvN9jLDbnvrSAS14kGbc0sl49L
   wzusu0pNQ5pWIKbeqsLuG+wyoL5lTPdtuYXkn+mxtbRAhPHH6aU8F5wdE
   mp25g8eVOe0QYfKWmARmCrQ35ROiX977LaD8CsY9tZLGsAH/xPpQi/jhP
   NW94FQP2kM9F6EnKUVvLjHV2KIUVby3DOcjLLy82wyP8cKqiLokW7Bky7
   g5hj12MCJIW9o5+yS7WCJ30ptwLJFmq9B7d3UniULqUTs1YZ3yGe1tCVL
   LUXVzwxOepASpAi4Z72pZOuEHIw2cBQJd8AEKICHCkYjppVjK+A9+40Mj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="382661484"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="382661484"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 22:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779488835"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="779488835"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2023 22:17:45 -0700
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
	jiangshanlai@gmail.com
Subject: [PATCH v10 32/38] x86/entry/calling: Allow PUSH_AND_CLEAR_REGS being used beyond actual entry code
Date: Wed, 13 Sep 2023 21:47:59 -0700
Message-Id: <20230914044805.301390-33-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914044805.301390-1-xin3.li@intel.com>
References: <20230914044805.301390-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


