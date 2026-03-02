Return-Path: <linux-hyperv+bounces-9092-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGfzDx3BpWknFgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9092-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 17:55:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B81DD536
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 17:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CE4C30A0D92
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C18423A89;
	Mon,  2 Mar 2026 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB1I/+E3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D8423162;
	Mon,  2 Mar 2026 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469947; cv=none; b=SObYF21kvOhIyydWLyuHSg2Qk87RfLpIXsG7KamXvWbDO/t9D535+7QH+PIVdY4zz6/95QD/yPYprSb3XqF1JtrkVm+VQR4kQD5l953G/u4XK06+iQ80Vj3bQjctVWzaimjwQjCvvnEs1wxHUGeogUGL2/q3iyMUk10JFSqcx1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469947; c=relaxed/simple;
	bh=tmmMtb8fTzev/MLiqg9QkV4PVClz0kRmzdEPmp/okYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZRVBVao8LrSzQJIeeI9uXX9YoJzdNigKi0yI86o/oJ8evG1nHYolDUKhGpNKQidyuuSEm8NxdRyHFv9KE2HqGEMqk8LZ2evXz/sSV1l8dk/Z55B7ViG58yHfkPR38JsQTNEDzKvByq+CmoDBU+KSN216Oe5CMVWeG0B1t/Bjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB1I/+E3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9536EC19423;
	Mon,  2 Mar 2026 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469946;
	bh=tmmMtb8fTzev/MLiqg9QkV4PVClz0kRmzdEPmp/okYI=;
	h=From:To:Cc:Subject:Date:From;
	b=bB1I/+E3BkuB9d0Ar0LL/RCu//o6aHHeVlBCi5JIHpvO62O8BUs6Sn4N3DKZYCKSq
	 7HwnSnCOjx92mHMC+6btT4CeFtlFDHPg4yDNx2Exnz3bXY5iIs3frf+2wR1aiRoJhu
	 wFfoEplhya0YxruseeyVaHGmibsuJt2D5cd2ma4/8zT2Szs/71fv26f3CcC/gl9voY
	 L7/WSIayEmstrkXZIEHBnKVE4jYtOpmZgt4XoYz5msrByisv25BxCYKr11vcRKoiAB
	 QYgkLa9XRtTcRxXpr4u7PQlRz4xLvLDqa8OXugixKrS4wxwx2yRwcBF/Ab5taOu1KT
	 iYZZ7gRE+q1oQ==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v3] x86/hyperv: Use __naked attribute to fix stackless C function
Date: Mon,  2 Mar 2026 17:45:31 +0100
Message-ID: <20260302164530.50005-2-ardb@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5782; i=ardb@kernel.org; h=from:subject; bh=tmmMtb8fTzev/MLiqg9QkV4PVClz0kRmzdEPmp/okYI=; b=owGbwMvMwCn83sBh/rljoYmMp9WSGDKX7ltlE9ATmKGwly3Llt9LWZjpeLKc+ZKvLApunresl hwp5jPomMrCIMzJICumyLJTOaf7tYvoO32FyhyYOaxMIEMYuDgFYCIWPYwNH1WnH+S2b3h6/V6K a3KDfnXX0c+hQUcdmgOFeS6Y9bE6+M4N7Z4Wu0Vh78Vo5ylRD+4w1jsm/Z4WV/bMRE3ryMy55fO 1zx37VykvfavT6ap0oszMpvMbHt57J7r07j3Z6deX3PT9ng8A
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D51B81DD536
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,citrix.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9092-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,hv_crash_ctxt.gs:url,citrix.com:email]
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

Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com> # asm parts, not hv parts
Reviewed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org
Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection into vmcore")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v3: make hv_wrmsr() 'asm volatile'
    combine SS segment register update with RSP assignment
    fix pre-existing bug cr4 -> cr2
    update comment gcc -> objtool

v2: apply some asm tweaks suggested by Uros and Andrew

 arch/x86/hyperv/hv_crash.c | 82 ++++++++++----------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index 92da1b4f2e73..fdb277bf73d8 100644
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


