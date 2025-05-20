Return-Path: <linux-hyperv+bounces-5570-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76ECABD61D
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 13:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586E218844AE
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ABB27CB31;
	Tue, 20 May 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qgCXKrlt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C427BF8E;
	Tue, 20 May 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739258; cv=none; b=lvu7r/ChBnL0bRwP23LYe9rxJBiQAwgRm+nJr8A8jXWDyUnBSghTbLS5lmvZOKN3sNnlGwnWVh60nf6UQkZfmvNKbGyWa+RkCkcbHCg2XPJKTkDR3cq6Xg+w5wSZUrmoNIPPkOatTCJQIbtUCG9GU0q65qEmrGKNKOBOr1lt/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739258; c=relaxed/simple;
	bh=tCc+MJnD3R5Ek3jmpM/uvrIPW0xcAGF3XMdQz68T2Nw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OdFJj5ZzgqLp7IA+X/wOa4btQPvtreku1gzz+6dBMphieJ9dNB17IttbpAJIstrjKf3oIIFqn/oyZwQQ1ao9M0cfuGpbtAEr5Js+flAss1XY5cLSxCSAew54zS29De7889Py7yS2YMmzs/s50778w6kBYNsoNP0jEANgcDG3d0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qgCXKrlt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=9qlCiG7D2ZsAj4paWBSRZaR5jcJe7sgFeCkgcBqwK1Y=; b=qgCXKrltXFIZvRhrhPGf3d0YlS
	l1ceVluTwlooEzAxBzkTW4nMGS2Plu/LKKkgjV2YivamYwJr4bJ8BQO5npw82ZLmByPAo8U03DhzX
	cT7rrOFlVUszs6r/6Xyyd1czXIm9n40un0lTsYCD5APBO7UA5/UPDGY1r8HEqO9BA16WaL3+Krxz2
	BnK0p2LPEYsR1SP1fZmjR9lM/YLPE4py/zyZxsISHVvys8jI3a9VZmL7N5tjSfL9LkE0UgcZw7ALv
	cdNmlhjUYAXgUzZ9zm65mOkSVb5GAoHr8NuyV8fNvVCjYuqyMdxWHTG+cvDQp0/AdFgsYzo2xtTX2
	CjnGiJxQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uHKoh-00000000lqn-3EU9;
	Tue, 20 May 2025 11:07:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 51A11300BDD; Tue, 20 May 2025 13:07:27 +0200 (CEST)
Message-ID: <20250520110632.168981626@infradead.org>
User-Agent: quilt/0.66
Date: Tue, 20 May 2025 12:55:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 kys@microsoft.com,
 haiyangz@microsoft.com,
 wei.liu@kernel.org,
 decui@microsoft.com,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 hpa@zytor.com,
 luto@kernel.org,
 linux-hyperv@vger.kernel.org
Subject: [PATCH 2/3] x86/mm: Avoid repeated this_cpu_*() ops in switch_mm_irqs_off()
References: <20250520105542.283166629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Aside from generating slightly better code for not having to use %fs
prefixed ops, the real purpose is to clarify code by switching some to
smp_store_release() later on.

Notably, this_cpu_{read,write}() imply {READ,WRITE}_ONCE().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/tlb.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -51,7 +51,7 @@
 
 /*
  * Bits to mangle the TIF_SPEC_* state into the mm pointer which is
- * stored in cpu_tlb_state.last_user_mm_spec.
+ * stored in cpu_tlbstate.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
 #define LAST_USER_MM_L1D_FLUSH	0x2UL
@@ -782,8 +782,9 @@ static inline void cr4_update_pce_mm(str
 void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 			struct task_struct *tsk)
 {
-	struct mm_struct *prev = this_cpu_read(cpu_tlbstate.loaded_mm);
-	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	struct tlb_state *this_tlbstate = this_cpu_ptr(&cpu_tlbstate);
+	struct mm_struct *prev = READ_ONCE(this_tlbstate->loaded_mm);
+	u16 prev_asid = READ_ONCE(this_tlbstate->loaded_mm_asid);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
 	unsigned long new_lam;
@@ -840,7 +841,7 @@ void switch_mm_irqs_off(struct mm_struct
 	if (prev == next) {
 		/* Not actually switching mm's */
 		VM_WARN_ON(is_dyn_asid(prev_asid) &&
-			   this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
+			   READ_ONCE(this_tlbstate->ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
 		/*
@@ -888,7 +889,7 @@ void switch_mm_irqs_off(struct mm_struct
 		 */
 		smp_mb();
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
-		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
+		if (READ_ONCE(this_tlbstate->ctxs[prev_asid].tlb_gen) ==
 				next_tlb_gen)
 			return;
 
@@ -910,7 +911,7 @@ void switch_mm_irqs_off(struct mm_struct
 		 * and others are sensitive to the window where mm_cpumask(),
 		 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
 		 */
-		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
+		WRITE_ONCE(this_tlbstate->loaded_mm, LOADED_MM_SWITCHING);
 		barrier();
 
 		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
@@ -925,8 +926,8 @@ void switch_mm_irqs_off(struct mm_struct
 	new_lam = mm_lam_cr3_mask(next);
 	if (ns.need_flush) {
 		VM_WARN_ON_ONCE(is_global_asid(ns.asid));
-		this_cpu_write(cpu_tlbstate.ctxs[ns.asid].ctx_id, next->context.ctx_id);
-		this_cpu_write(cpu_tlbstate.ctxs[ns.asid].tlb_gen, next_tlb_gen);
+		WRITE_ONCE(this_tlbstate->ctxs[ns.asid].ctx_id, next->context.ctx_id);
+		WRITE_ONCE(this_tlbstate->ctxs[ns.asid].tlb_gen, next_tlb_gen);
 		load_new_mm_cr3(next->pgd, ns.asid, new_lam, true);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
@@ -940,8 +941,8 @@ void switch_mm_irqs_off(struct mm_struct
 	/* Make sure we write CR3 before loaded_mm. */
 	barrier();
 
-	this_cpu_write(cpu_tlbstate.loaded_mm, next);
-	this_cpu_write(cpu_tlbstate.loaded_mm_asid, ns.asid);
+	WRITE_ONCE(this_tlbstate->loaded_mm, next);
+	WRITE_ONCE(this_tlbstate->loaded_mm_asid, ns.asid);
 	cpu_tlbstate_update_lam(new_lam, mm_untag_mask(next));
 
 	if (next != prev) {



