Return-Path: <linux-hyperv+bounces-9002-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBeyOo0XoGmzfgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9002-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 10:51:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C2E1A3C12
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 10:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C78EF300844D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BF8314B94;
	Thu, 26 Feb 2026 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y32nwXxT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B021885A5
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099463; cv=none; b=L+54DN0SZDlpKrVAOyfBFmC9v+3YUYdMIb68W8pZWSW9KEdagLt2QZob3mwGz8tgNCM8SsoSaxK/Cep++Uiuu2ojMw+vYxRheSSmQMFNgiYViU9Q5Nxh/THv+lpafthitqUHe+09dLjoGdrfVDiV1xSmN7sgftN7mt7BA/ICbQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099463; c=relaxed/simple;
	bh=uxteyQ3fL17gew0uasQskuQXwAnlJW6j4RzRyg/Wkfw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DupZK4ykGuxCMsuM5aZdXRLoHJ1kes38KSfVPXxs20hdXMi8NJGPa7iP9/7Az4vm3j/kYqQsQD7eF2nBOkpU2OIhSp1mNB956rfUwjcgIjFk8HERj7MfARAr6oTztHJjiZJeHotGEnerguCncthRmKrNTXshlMkGVhLs2pdK7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y32nwXxT; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-65faa6716b4so917103a12.2
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 01:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772099460; x=1772704260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r9siQRAI82XGd/XT7KGSnYfEQ1ezHfSjxlnQISpmf08=;
        b=Y32nwXxTUza9y17nVfFPdp3G8TzTZNSEJyLQlzdxN8CC8ieGGQscVkb0SiGPhoEpIn
         OacudqyFXkSwjv+pG1FJGZS56zg2n9zgcIkQTn348ErCbeymIcRBCThDlFNtV5mQxWRv
         6TortUQryen5UxAcsBY/W2rQE1GevbCgkdGy7V9OGi3+UPLxmuC8//Dcs++aEQa8k4n4
         oeCuY2POTw+75ygdS7j0vWIQaKkbqki5uxSe3ytC59ezqQCZ20SwDFoNdhbQefMagDLS
         6n5V4qF7xQLltM5qAw7dfN9RfAUBUr5xCY5MayWpi49hfqGGzU4ZgQ/oPVUaWILJ55+I
         ScOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772099460; x=1772704260;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9siQRAI82XGd/XT7KGSnYfEQ1ezHfSjxlnQISpmf08=;
        b=EnrTFL3dLfYewHsfmWVqs0oKMkblsEY+L1Dg2EWgZfh9rJd5ZlliDOfk0HcZXJpdTU
         ViczE1SICQAq2nDxtqxRNxXmK9iJzyAU535n3Z66CL7A92kEYRhncina9j8oFumV/EKM
         NkZgeQlOEwc5ZGgye4mSsxGVRJh5N3Kwu+vBwK94mJXqg9Lm23zSDghxf/lmEJu+j5cn
         H1EtCEHc0cSZYlvC374fVwwdcSfv+fIzzsTrU0g1i1aMVDOuORe1vd1NjBSwHhKG5iPQ
         FTmoUlPR5dSkSgHOVLiELICZU460FHbfbxa7OLK6Milfbj2cJDH7kvPxKYu/UYwqlVpY
         /tnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKQFPl/SzwVfX2kFtquTfrnoUsoFixAs0xKUJHkjbOAmPK8MVDNrT4qa00Kq9Wr0ULZgobnXcJvH6xl48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8QrMef7KJrVGplBpBMivdPdotUOEPJehtMAVkWPij8JmKv0k
	EUEocRmaD3g1Qe025yEql9sgsKGwJl35bELM8WJJqcl7Rw04wM62uA3CKIO6ohReNG4z8fHQHQ=
	=
X-Received: from edtn17.prod.google.com ([2002:aa7:db51:0:b0:658:31e3:4242])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:510f:b0:65f:7f90:fb89
 with SMTP id 4fb4d7f45d1cf-65fb6c6ea8dmr913495a12.17.1772099460068; Thu, 26
 Feb 2026 01:51:00 -0800 (PST)
Date: Thu, 26 Feb 2026 10:50:57 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5779; i=ardb@kernel.org;
 h=from:subject; bh=sPCEU5F7szViGGqi8+aB6tyXk98FodC657hmbHdoY/0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXOBeGOn6XeFsKeSUza7VTw7Zlk3pUm006MqvMQy2Gz35
 S1Bhm87SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQaXzP8s3NdqDtf46uXrl9D
 6Zwj9frMNyT3a+5fwsKfzM70yz5HipHh4+lsnjoWXilOlXkebgyPtnWFnz/9xWiWZOd9MyHOw16 MAA==
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226095056.46410-2-ardb+git@google.com>
Subject: [RFT PATCH] x86/hyperv: Use __naked attribute to fix stackless C function
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Mukesh Rathor <mrathor@linux.microsoft.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9002-lists,linux-hyperv=lfdr.de,git];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.microsoft.com,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hv_crash_ctxt.es:url,alien8.de:email,hv_crash_ctxt.ss:url]
X-Rspamd-Queue-Id: 17C2E1A3C12
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

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

Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection into vmcore")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Build tested only.

Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-hyperv@vger.kernel.org

 arch/x86/hyperv/hv_crash.c | 80 ++++++++++----------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index a78e4fed5720..d77766e8d37e 100644
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
@@ -133,49 +150,36 @@ static noinline void hv_crash_clear_kernpt(void)
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
+	asm volatile("movw %%ax, %%ss" : : "a"(hv_crash_ctxt.ss));
+	asm volatile("movq %0, %%rsp" : : "m"(hv_crash_ctxt.rsp));
 
-	asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
-	asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
-	asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
-	asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
+	asm volatile("movw %%ax, %%ds" : : "a"(hv_crash_ctxt.ds));
+	asm volatile("movw %%ax, %%es" : : "a"(hv_crash_ctxt.es));
+	asm volatile("movw %%ax, %%fs" : : "a"(hv_crash_ctxt.fs));
+	asm volatile("movw %%ax, %%gs" : : "a"(hv_crash_ctxt.gs));
 
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
+	asm volatile("pushq	%q0		\n\t"
+		     "leaq	%c1(%%rip), %q0	\n\t"
+		     "pushq	%q0		\n\t"
+		     "lretq			\n\t"
+		     :: "a"(hv_crash_ctxt.cs), "i"(hv_crash_handle));
 }
 /* Tell gcc we are using lretq long jump in the above function intentionally */
 STACK_FRAME_NON_STANDARD(hv_crash_c_entry);
-- 
2.53.0.414.gf7e9f6c205-goog


