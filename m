Return-Path: <linux-hyperv+bounces-5569-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ECFABD60C
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 13:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4F18A1C0D
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CEC27AC47;
	Tue, 20 May 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dHENCf1U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170427BF86;
	Tue, 20 May 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739257; cv=none; b=CTH9X/iDwwfrL7hyWDdOxIzT+GrNazHpvRIS4isyz92KEWyz89FsDZouLWaCUVgc2860pOobcLSjU/6Nhl4ljPqKSbLHL1YY5UMHcnKOFseh+HTpYHEFRfPKmuKqvYO1R2WFfxbZuggXImCvi/QAy3snrAsyBE94uWq7Dl0C8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739257; c=relaxed/simple;
	bh=YPrh6LM3icOIY6IfyHITSL5dNozv4D5cParZvvhNWwQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lUfxuXFdHBcd0fBt/Ck0TyOSmX4qTREEwqbLvYhCifYHQQH13wXLm7izgtTa7qYtkM6fTZOxoNs4i0Rj+mU4qmdri9gw4mI9G7OxGKbR5QWKOo3E0G2Uh1UlCIfW+BkxRkDY4ELx0jH78z2li5GT3VscFOTovepKDDNLqajAhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dHENCf1U; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=J+ixRKeK3AjeN5jLv2n9xyfjGOXeDLkzWStpWpGskeU=; b=dHENCf1UtodUN6G4lUKdMY+SIc
	lVXXbnJUN42dhQcJmutI4BUbFM6LaYsGJMiD8YfmaVa4VDd59tcXIXcr7wUFj5iB+EJ0hS6UnYtAA
	Izv88OSuPt1RMnHWe0cC4xKFuI2k4RT3akfGhy2tZUVz8ySl8G0r+s76xpwftiWuu2/Mv4+tJv/Qr
	P4GaMxlRXhwKWRNy1oWKuC014VYT49Qv5EqN7PVLAHm/8NcX+NPkcQ3Zj+JA7SdXK/CpaIaumSQZH
	77nbdKLoRxHFcqBIMWBvf8GMEqXauqW8FBFvKpKfbSMg4scVxMFyYOFIdAkXuvZUU6Mvw/E1paFiF
	WMF5NTEw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHKoh-00000003BbN-3KZH;
	Tue, 20 May 2025 11:07:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 55BDB300F1A; Tue, 20 May 2025 13:07:27 +0200 (CEST)
Message-ID: <20250520110632.280908218@infradead.org>
User-Agent: quilt/0.66
Date: Tue, 20 May 2025 12:55:45 +0200
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
Subject: [PATCH 3/3] x86/mm: Clarify should_flush_tlb() ordering
References: <20250520105542.283166629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The ordering in should_flush_tlb() is entirely non-obvious and is only
correct because x86 is TSO. Clarify the situation by replacing two
WRITE_ONCE()s with smp_store_release(), which on x86 is cosmetic.

Additionally, clarify the comment on should_flush_tlb().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/tlb.c |   30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -910,8 +910,10 @@ void switch_mm_irqs_off(struct mm_struct
 		 * Indicate that CR3 is about to change. nmi_uaccess_okay()
 		 * and others are sensitive to the window where mm_cpumask(),
 		 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
+		 *
+		 * Also, see should_flush_tlb().
 		 */
-		WRITE_ONCE(this_tlbstate->loaded_mm, LOADED_MM_SWITCHING);
+		smp_store_release(&this_tlbstate->loaded_mm, LOADED_MM_SWITCHING);
 		barrier();
 
 		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
@@ -938,10 +940,11 @@ void switch_mm_irqs_off(struct mm_struct
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
 
-	/* Make sure we write CR3 before loaded_mm. */
-	barrier();
-
-	WRITE_ONCE(this_tlbstate->loaded_mm, next);
+	/*
+	 * Make sure we write CR3 before loaded_mm.
+	 * See nmi_uaccess_okay() and should_flush_tlb().
+	 */
+	smp_store_release(&this_tlbstate->loaded_mm, next);
 	WRITE_ONCE(this_tlbstate->loaded_mm_asid, ns.asid);
 	cpu_tlbstate_update_lam(new_lam, mm_untag_mask(next));
 
@@ -1280,9 +1283,20 @@ static bool should_flush_tlb(int cpu, vo
 	struct flush_tlb_info *info = data;
 
 	/*
-	 * Order the 'loaded_mm' and 'is_lazy' against their
-	 * write ordering in switch_mm_irqs_off(). Ensure
-	 * 'is_lazy' is at least as new as 'loaded_mm'.
+	 * switch_mm_irqs_off()				should_flush_tlb()
+	 *   WRITE_ONCE(is_lazy, false);		  loaded_mm = READ_ONCE(loaded_mm);
+	 *   smp_store_release(loaded_mm, SWITCHING);     smp_rmb();
+	 *   mov-cr3
+	 *   smp_store_release(loaded_mm, next)
+	 *                                                if (READ_ONCE(is_lazy))
+	 *                                                  return false;
+	 *
+	 * Where smp_rmb() matches against either smp_store_release() to
+	 * ensure that if we observe loaded_mm to be either SWITCHING or next
+	 * we must also observe is_lazy == false.
+	 *
+	 * If this were not so, it would be possible to falsely return false
+	 * and miss sending an invalidation IPI.
 	 */
 	smp_rmb();
 



