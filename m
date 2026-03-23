Return-Path: <linux-hyperv+bounces-9693-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDtZOFFNwWmhSAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9693-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 15:25:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 569D12F46DF
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 15:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E312930E2B0C
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 14:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715D83B961F;
	Mon, 23 Mar 2026 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="afEV+9NW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9973B9611;
	Mon, 23 Mar 2026 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274386; cv=none; b=uZVuxsrKrtNyLTG1gcT7l88NnrW3zoFHHw0i/+T3RlyO3fNH9f2qcIPPDXkgP4EIDo7zuUPCWzM5iIZUx9RCp5BjVYaOR/sAAi/+YgkyQ+mBoIJz1AISky2+dxKeA8t7lmRVsLx3ML1tzlwgF4dvTrAj8sp2/3mmMqkoHpuW11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274386; c=relaxed/simple;
	bh=ZJDpME7DHtiVK//m6YaaGGgSG3MS2VqgNCnPo6OGbwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCbdOrsuSoiASJq5Gdq1r7hfskt61o0w7FUy7dcQrKPCDSLGtt3zlKqGeibSYj8IyReC6uAX1Vy8PaAgVQ/R4N2C0QhayXWz+R4r8jx25LhHE99WtkpcvFhcg+gwd4KQNwjIxRkevtq8pdAq/ggFcQMJd6bMYqjjlu5OJXnGuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=afEV+9NW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A19C2BC9E;
	Mon, 23 Mar 2026 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274386;
	bh=ZJDpME7DHtiVK//m6YaaGGgSG3MS2VqgNCnPo6OGbwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=afEV+9NWUBGWXoH4AddEamY4V7sUOpgGyix6WUuXMot4h3q5SlsSkWTholo7w5QC0
	 YeCQJJX3HWFVPglzCC/wtb20GJPWscv58S3rm300+DkORjtud0lugU9HDuovCowHev
	 Iq5uM9Ko9XzXGAv4JoaUDnZWFaPNIs0MjwvcBKAE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	linux-hyperv@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH 6.19 200/220] x86/hyperv: Use __naked attribute to fix stackless C function
Date: Mon, 23 Mar 2026 14:46:17 +0100
Message-ID: <20260323134510.896373557@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9693-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.microsoft.com,gmail.com,kernel.org,vger.kernel.org,citrix.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 569D12F46DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 3fde5281b805370a6c3bd2ef462ebff70a0ea2c6 ]

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

Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com> # asm parts, not hv parts
Reviewed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org
Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection into vmcore")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_crash.c | 82 ++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index a78e4fed57203..1d91051daa3de 100644
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
+	asm volatile("wrmsr" :: "c"(msr), "a"((u32)val), "d"((u32)(val >> 32)) : "memory")
+
 /*
  * This is the C entry point from the asm glue code after the disable hypercall.
  * We enter here in IA32-e long mode, ie, full 64bit mode running on kernel
@@ -133,51 +150,38 @@ static noinline void hv_crash_clear_kernpt(void)
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
+	asm volatile("movw %0, %%ss\n\t"
+		     "movq %1, %%rsp"
+		     :: "m"(hv_crash_ctxt.ss), "m"(hv_crash_ctxt.rsp));
 
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
+	asm volatile("movq %0, %%cr2" : : "r"(hv_crash_ctxt.cr2));
 
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
-/* Tell gcc we are using lretq long jump in the above function intentionally */
+/* Tell objtool we are using lretq long jump in the above function intentionally */
 STACK_FRAME_NON_STANDARD(hv_crash_c_entry);
 
 static void hv_mark_tss_not_busy(void)
-- 
2.51.0




