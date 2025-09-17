Return-Path: <linux-hyperv+bounces-6915-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB5DB80481
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 16:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18051896AD7
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FF332B4AA;
	Wed, 17 Sep 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uZ18W80B";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uZ18W80B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6357D32E744
	for <linux-hyperv@vger.kernel.org>; Wed, 17 Sep 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120754; cv=none; b=YrBjvasqY5+LKmpbu3EBQTtpYaqxQR9F4m/OsvHenU355W6MfPg6Npl5AnFqYzKwz5mvesxUHn9nC74gaZfqiE3bJSBYpAxqLVVENxQwtzDeJ01kZ8Aq4dlHr1StTzc5RITwKIhX+V9Omkguzo9vjSJE95HGA+vV9g5s6SQmsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120754; c=relaxed/simple;
	bh=SFn+uq5l0tdqUCgH2kix2URqfP/Q8Djv9ohN+9eMZg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPqpK0Vp17k2zShm5aDuZ34Xq9W1osT5VX0L2NG/NmmO2BFo3TU1qZN4mlkZFihTYHp3DedjgRB8fyF6PkekNB7v6pokmb8qGSjpbHIaO4YZZO7qr2Q9bOCjSwUfLh7+YELTRHIL8eAMAkGO6EE0K5azR32xvN2pLo3YfgmqrmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uZ18W80B; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uZ18W80B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F097228CA;
	Wed, 17 Sep 2025 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lnxctw4TkqNTc4ChtuCQgho9vGAJsGLt5RRgPYgHX4k=;
	b=uZ18W80B+W3BVzorEzzeTfLdkBOVkMzqlN7fThzkWL+TxyaFP/9Nz3hsOlVdZ29qrfjYsX
	rA2QE8GVWlAPvzxaexHjLxN404ysPyizlIj40Usp9tYaLoN3GtuHFTUFf022powaBhDjQJ
	XrrimtZFI6o6tiKY0C7TGMBQRAo0vAY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uZ18W80B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lnxctw4TkqNTc4ChtuCQgho9vGAJsGLt5RRgPYgHX4k=;
	b=uZ18W80B+W3BVzorEzzeTfLdkBOVkMzqlN7fThzkWL+TxyaFP/9Nz3hsOlVdZ29qrfjYsX
	rA2QE8GVWlAPvzxaexHjLxN404ysPyizlIj40Usp9tYaLoN3GtuHFTUFf022powaBhDjQJ
	XrrimtZFI6o6tiKY0C7TGMBQRAo0vAY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEE021368D;
	Wed, 17 Sep 2025 14:52:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 83fyLC3Lymi/EgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:52:29 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 01/21] x86/paravirt: Remove not needed includes of paravirt.h
Date: Wed, 17 Sep 2025 16:52:00 +0200
Message-ID: <20250917145220.31064-2-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917145220.31064-1-jgross@suse.com>
References: <20250917145220.31064-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,microsoft.com,infradead.org,gmail.com,oracle.com,lists.xenproject.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7F097228CA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51

In some places asm/paravirt.h is included without really being needed.

Remove the related #include statements.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S             | 1 -
 arch/x86/entry/vsyscall/vsyscall_64.c | 1 -
 arch/x86/hyperv/hv_spinlock.c         | 1 -
 arch/x86/include/asm/apic.h           | 4 ----
 arch/x86/include/asm/highmem.h        | 1 -
 arch/x86/include/asm/mmu_context.h    | 1 -
 arch/x86/include/asm/mshyperv.h       | 1 -
 arch/x86/include/asm/pgtable_32.h     | 1 -
 arch/x86/include/asm/spinlock.h       | 1 -
 arch/x86/include/asm/tlbflush.h       | 4 ----
 arch/x86/kernel/apm_32.c              | 1 -
 arch/x86/kernel/callthunks.c          | 1 -
 arch/x86/kernel/cpu/bugs.c            | 1 -
 arch/x86/kernel/vsmp_64.c             | 1 -
 arch/x86/kernel/x86_init.c            | 1 -
 arch/x86/lib/cache-smp.c              | 1 -
 arch/x86/mm/init.c                    | 1 -
 arch/x86/xen/spinlock.c               | 1 -
 18 files changed, 24 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ed04a968cc7d..7a82305405af 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -30,7 +30,6 @@
 #include <asm/hw_irq.h>
 #include <asm/page_types.h>
 #include <asm/irqflags.h>
-#include <asm/paravirt.h>
 #include <asm/percpu.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index c9103a6fa06e..53e50b506471 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -37,7 +37,6 @@
 #include <asm/unistd.h>
 #include <asm/fixmap.h>
 #include <asm/traps.h>
-#include <asm/paravirt.h>
 
 #define CREATE_TRACE_POINTS
 #include "vsyscall_trace.h"
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 81b006601370..2a3c2afb0154 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -13,7 +13,6 @@
 #include <linux/spinlock.h>
 
 #include <asm/mshyperv.h>
-#include <asm/paravirt.h>
 #include <asm/apic.h>
 #include <asm/msr.h>
 
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 07ba4935e873..e1de090e51dd 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -90,10 +90,6 @@ static inline bool apic_from_smp_config(void)
 /*
  * Basic functions accessing APICs.
  */
-#ifdef CONFIG_PARAVIRT
-#include <asm/paravirt.h>
-#endif
-
 static inline void native_apic_mem_write(u32 reg, u32 v)
 {
 	volatile u32 *addr = (volatile u32 *)(APIC_BASE + reg);
diff --git a/arch/x86/include/asm/highmem.h b/arch/x86/include/asm/highmem.h
index 585bdadba47d..decfaaf52326 100644
--- a/arch/x86/include/asm/highmem.h
+++ b/arch/x86/include/asm/highmem.h
@@ -24,7 +24,6 @@
 #include <linux/interrupt.h>
 #include <linux/threads.h>
 #include <asm/tlbflush.h>
-#include <asm/paravirt.h>
 #include <asm/fixmap.h>
 #include <asm/pgtable_areas.h>
 
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 73bf3b1b44e8..ee15657d25b3 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -9,7 +9,6 @@
 #include <trace/events/tlb.h>
 
 #include <asm/tlbflush.h>
-#include <asm/paravirt.h>
 #include <asm/debugreg.h>
 #include <asm/gsseg.h>
 #include <asm/desc.h>
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index abc4659f5809..a9ab46fcb6a1 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -7,7 +7,6 @@
 #include <linux/msi.h>
 #include <linux/io.h>
 #include <asm/nospec-branch.h>
-#include <asm/paravirt.h>
 #include <asm/msr.h>
 #include <hyperv/hvhdk.h>
 
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index b612cc57a4d3..acea0cfa2460 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -16,7 +16,6 @@
 #ifndef __ASSEMBLER__
 #include <asm/processor.h>
 #include <linux/threads.h>
-#include <asm/paravirt.h>
 
 #include <linux/bitops.h>
 #include <linux/list.h>
diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 5b6bc7016c22..934632b78d09 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -7,7 +7,6 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 #include <linux/compiler.h>
-#include <asm/paravirt.h>
 #include <asm/bitops.h>
 
 /*
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 00daedfefc1b..238a6b807da5 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -300,10 +300,6 @@ static inline void mm_clear_asid_transition(struct mm_struct *mm) { }
 static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
 #endif /* CONFIG_BROADCAST_TLB_FLUSH */
 
-#ifdef CONFIG_PARAVIRT
-#include <asm/paravirt.h>
-#endif
-
 #define flush_tlb_mm(mm)						\
 		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
 
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index b37ab1095707..3175d7c134e9 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -229,7 +229,6 @@
 #include <linux/uaccess.h>
 #include <asm/desc.h>
 #include <asm/olpc.h>
-#include <asm/paravirt.h>
 #include <asm/reboot.h>
 #include <asm/nospec-branch.h>
 #include <asm/ibt.h>
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index a951333c5995..e37728f70322 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -15,7 +15,6 @@
 #include <asm/insn.h>
 #include <asm/kexec.h>
 #include <asm/nospec-branch.h>
-#include <asm/paravirt.h>
 #include <asm/sections.h>
 #include <asm/switch_to.h>
 #include <asm/sync_core.h>
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 36dcfc5105be..d278d37c9690 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -25,7 +25,6 @@
 #include <asm/fpu/api.h>
 #include <asm/msr.h>
 #include <asm/vmx.h>
-#include <asm/paravirt.h>
 #include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 73511332bb67..25625e3fc183 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -18,7 +18,6 @@
 #include <asm/apic.h>
 #include <asm/pci-direct.h>
 #include <asm/io.h>
-#include <asm/paravirt.h>
 #include <asm/setup.h>
 
 #define TOPOLOGY_REGISTER_OFFSET 0x10
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 0a2bbd674a6d..02ca90378bf9 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -12,7 +12,6 @@
 
 #include <asm/acpi.h>
 #include <asm/bios_ebda.h>
-#include <asm/paravirt.h>
 #include <asm/pci_x86.h>
 #include <asm/mpspec.h>
 #include <asm/setup.h>
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index c5c60d07308c..ae5a5dfd33c7 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <asm/paravirt.h>
 #include <linux/smp.h>
 #include <linux/export.h>
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index bb57e93b4caf..f52ebcac50d9 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -27,7 +27,6 @@
 #include <asm/pti.h>
 #include <asm/text-patching.h>
 #include <asm/memtype.h>
-#include <asm/paravirt.h>
 #include <asm/mmu_context.h>
 
 /*
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 8e4efe0fb6f9..fe56646d6919 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <linux/atomic.h>
 
-#include <asm/paravirt.h>
 #include <asm/qspinlock.h>
 
 #include <xen/events.h>
-- 
2.51.0


