Return-Path: <linux-hyperv+bounces-9047-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBcRCWsdomlMzgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9047-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 23:40:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 774A91BEBFA
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 23:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16A12307E855
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 22:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DF83603EC;
	Fri, 27 Feb 2026 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q67Z6G2f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C332C237E;
	Fri, 27 Feb 2026 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232040; cv=none; b=KYatm5wny4TON3kIQvri2m0ID2y/orlwJ/ZkAtqvwuZTaPxLMFE4+X2dGjzk6MfUdHq9vNeo6NtaS5fyTR/fe6JTpgql5obTQeq1wsAgK71qT4IjsHxjbqYwgWcfQZvfaXdeYDkiHmXqEYR9svo+7wanb9sPpZexmJ63Ctesl5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232040; c=relaxed/simple;
	bh=M9wddYcn54W71GpFvHOQNiwkejJ7pXehVbPN08manXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhtvRms9pD4BM41+aCSjaDqrV+fwXGFj/PtsLcXPTL18nIGMhISxu3pv/5iT/bRcYSKemxvx+k4ICiKW5SaLwcksD5S11hrAVsJ8huF8DoJe4ungtnfWqIopm/kvBogRXRwma9r5vxVc10FrfNY8hvzIyTbB6Rdx9XmpELY4B84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q67Z6G2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B37C116C6;
	Fri, 27 Feb 2026 22:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772232040;
	bh=M9wddYcn54W71GpFvHOQNiwkejJ7pXehVbPN08manXI=;
	h=From:To:Cc:Subject:Date:From;
	b=q67Z6G2fvQoqgtiVpcU8YNLjEuUzpVEqyHyFhzfBUSiit7DGgh5fj1qDcCNFXU9nr
	 zX1Lh9QLn+cSaglnfT5NLzOyYNVwH3wURQdeciDsehrCEqEJRkgZmy2YQpRRIvCR9u
	 xJJFvLMkX8x2e1/Kwdtqy7yVayyhyCDOH8Q/OotjKDbt7IOFcV8wMkGiO6hJQ0pnit
	 4Ak/aQFYWY+o3AX8gPnOF34/yT65jGH9MmMm4NSJr9etnIWTBS9f30YrbxRrdJPxBB
	 Tq3UZ+LdGefY4EzpGnthWkqKdOuv2Y8EismANQ/NaVxxF49PZy1X1CVI65UFiJlEt+
	 CSDWKcJediFvQ==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v2] x86/hyperv: Use __naked attribute to fix stackless C function
Date: Fri, 27 Feb 2026 23:40:31 +0100
Message-ID: <20260227224030.299993-2-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.microsoft.com,gmail.com,citrix.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9047-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hv_crash_ctxt.gs:url,hv_crash_ctxt.es:url,hv_crash_ctxt.ss:url]
X-Rspamd-Queue-Id: 774A91BEBFA
X-Rspamd-Action: no action

hv_crash_c_entry() is a C function that is entered without a stack,
and this is only allowed for functions that have the __naked attribute,
which informs the compiler that it must not emit the usual prologue and
epilogue or emit any other kind of instrumentation that relies on a
stack frame.

So split up the function, and set the __naked attribute on the initial
part that sets up the stack, GDT, IDT and other pieces that are needed
for ordinary C execution. Given that function calls are not permitted
either, use the existing long return coded in an asm() block to call the
second part of the function, which is an ordinary function that is
permitted to call other functions as usual.

Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: linux-hyperv@vger.kernel.org
Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection into vmcore")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: apply some asm tweaks suggested by Uros and Andrew

 arch/x86/hyperv/hv_crash.c | 79 ++++++++++----------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index 92da1b4f2e73..1c0965eb346e 100644
--- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -107,14 +107,12 @@ static void __noreturn hv_panic_timeout_reboot(void)
 		cpu_relax();
 }
 
-/* This cannot be inlined as it needs stack */
-static noinline __noclone void hv_crash_restore_tss(void)
+static void hv_crash_restore_tss(void)
 {
 	load_TR_desc();
 }
 
-/* This cannot be inlined as it needs stack */
-static noinline void hv_crash_clear_kernpt(void)
+static void hv_crash_clear_kernpt(void)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -125,6 +123,25 @@ static noinline void hv_crash_clear_kernpt(void)
 	native_p4d_clear(p4d);
 }
 
+
+static void __noreturn hv_crash_handle(void)
+{
+	hv_crash_restore_tss();
+	hv_crash_clear_kernpt();
+
+	/* we are now fully in devirtualized normal kernel mode */
+	__crash_kexec(NULL);
+
+	hv_panic_timeout_reboot();
+}
+
+/*
+ * __naked functions do not permit function calls, not even to __always_inline
+ * functions that only contain asm() blocks themselves. So use a macro instead.
+ */
+#define hv_wrmsr(msr, val) \
+	asm("wrmsr" :: "c"(msr), "a"((u32)val), "d"((u32)(val >> 32)) : "memory")
+
 /*
  * This is the C entry point from the asm glue code after the disable hypercall.
  * We enter here in IA32-e long mode, ie, full 64bit mode running on kernel
@@ -133,49 +150,35 @@ static noinline void hv_crash_clear_kernpt(void)
  * available. We restore kernel GDT, and rest of the context, and continue
  * to kexec.
  */
-static asmlinkage void __noreturn hv_crash_c_entry(void)
+static void __naked hv_crash_c_entry(void)
 {
-	struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
-
 	/* first thing, restore kernel gdt */
-	native_load_gdt(&ctxt->gdtr);
+	asm volatile("lgdt %0" : : "m" (hv_crash_ctxt.gdtr));
 
-	asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
-	asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
+	asm volatile("movw %0, %%ss" : : "m"(hv_crash_ctxt.ss));
+	asm volatile("movq %0, %%rsp" : : "m"(hv_crash_ctxt.rsp));
 
-	asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
-	asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
-	asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
-	asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
+	asm volatile("movw %0, %%ds" : : "m"(hv_crash_ctxt.ds));
+	asm volatile("movw %0, %%es" : : "m"(hv_crash_ctxt.es));
+	asm volatile("movw %0, %%fs" : : "m"(hv_crash_ctxt.fs));
+	asm volatile("movw %0, %%gs" : : "m"(hv_crash_ctxt.gs));
 
-	native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
-	asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
+	hv_wrmsr(MSR_IA32_CR_PAT, hv_crash_ctxt.pat);
+	asm volatile("movq %0, %%cr0" : : "r"(hv_crash_ctxt.cr0));
 
-	asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
-	asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
-	asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
+	asm volatile("movq %0, %%cr8" : : "r"(hv_crash_ctxt.cr8));
+	asm volatile("movq %0, %%cr4" : : "r"(hv_crash_ctxt.cr4));
+	asm volatile("movq %0, %%cr2" : : "r"(hv_crash_ctxt.cr4));
 
-	native_load_idt(&ctxt->idtr);
-	native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
-	native_wrmsrq(MSR_EFER, ctxt->efer);
+	asm volatile("lidt %0" : : "m" (hv_crash_ctxt.idtr));
+	hv_wrmsr(MSR_GS_BASE, hv_crash_ctxt.gsbase);
+	hv_wrmsr(MSR_EFER, hv_crash_ctxt.efer);
 
 	/* restore the original kernel CS now via far return */
-	asm volatile("movzwq %0, %%rax\n\t"
-		     "pushq %%rax\n\t"
-		     "pushq $1f\n\t"
-		     "lretq\n\t"
-		     "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
-
-	/* We are in asmlinkage without stack frame, hence make C function
-	 * calls which will buy stack frames.
-	 */
-	hv_crash_restore_tss();
-	hv_crash_clear_kernpt();
-
-	/* we are now fully in devirtualized normal kernel mode */
-	__crash_kexec(NULL);
-
-	hv_panic_timeout_reboot();
+	asm volatile("pushq %q0\n\t"
+		     "pushq %q1\n\t"
+		     "lretq"
+		     :: "r"(hv_crash_ctxt.cs), "r"(hv_crash_handle));
 }
 /* Tell gcc we are using lretq long jump in the above function intentionally */
 STACK_FRAME_NON_STANDARD(hv_crash_c_entry);
-- 
2.47.3


