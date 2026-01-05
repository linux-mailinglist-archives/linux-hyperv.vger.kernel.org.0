Return-Path: <linux-hyperv+bounces-8143-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCDBCF32A3
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 12:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 042593007675
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3AD331A5E;
	Mon,  5 Jan 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D+hNut3y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PQVwouCV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC2331216
	for <linux-hyperv@vger.kernel.org>; Mon,  5 Jan 2026 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611136; cv=none; b=g1wY8uxkkWHegV0si8HfcFZfn5KcV1Xwz3SzPu3MHFoKedISsZLuiFB4wV3ltjRO4OXKRTCoevgzEsJKEDIwRIvdjS/RH+rrfOzt/3h0QHUEeDaBWs2rwKgB8TwfS440wwnfdOQQkv2vwfIeKm2Vf495Sq8hYG5sCiYiB2DQm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611136; c=relaxed/simple;
	bh=Ux4ysb09H5vlIS/UreeJnV6f4z7vo+xlt6988L0RoQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7RjoeVYDedFFF4mBygXsNNJskYz6AMlGgc4C4fwLJ7sA8PAwFGNVBIdy4k/7BHXHMUmurzAbqrVthB7vqBKNSxs+PDxEP+OAxDIsdmzetY/zoJKdJHMVecu0I1Tb+/42OoPynwSeRY2Im2kIRYF/EaZLQdkBgKhEbQ3Mf5RRgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D+hNut3y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PQVwouCV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E1CA5BE34;
	Mon,  5 Jan 2026 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7kz22UVoMzVOoVceTJa5D3QW6nnJWeqh52qRHMmxyM=;
	b=D+hNut3y0sEIHOfNimoEEIzc8JDdM0ipyZKf6Oor1G05pOhArTT2PqQObAwGKyqPvd0eaQ
	zBXF6vXudtWE7VijoF5embZ/WS/e8MHXGPQDYlB7RpCa4fVz/EgXGDfUqy0Ib6h+zqWEtK
	+A3ogIuG8iwllDvNYQZ4ZcpijOKxyws=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7kz22UVoMzVOoVceTJa5D3QW6nnJWeqh52qRHMmxyM=;
	b=PQVwouCVc7nGDB1qdgE830ofCVoKADTLcrFqXrmg3S4GjIR2ZlxCGc0yA2KOklpz6Wcxfq
	FVKxwC+Eq9e9UlSz0mA8FDm5JR2if9kLDGVOWm4WgVerdfDitqlLmYQ+Nx2hiUY4k4ithT
	XDjGJBzSNza1xccmoLx/qct3gm2bzk0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C299213964;
	Mon,  5 Jan 2026 11:05:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Uq/KLfuaW2n0WQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 05 Jan 2026 11:05:31 +0000
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
	Long Li <longli@microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v5 01/21] x86/paravirt: Remove not needed includes of paravirt.h
Date: Mon,  5 Jan 2026 12:05:00 +0100
Message-ID: <20260105110520.21356-2-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105110520.21356-1-jgross@suse.com>
References: <20260105110520.21356-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,microsoft.com,infradead.org,gmail.com,oracle.com,lists.xenproject.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -5.30

In some places asm/paravirt.h is included without really being needed.

Remove the related #include statements.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V3:
- reinstate the include in mmu_context.h (kernel test robot)
V4:
- reinstate the include in arch/x86/kernel/x86_init.c (Boris Petkov)
---
 arch/x86/entry/entry_64.S             | 1 -
 arch/x86/entry/vsyscall/vsyscall_64.c | 1 -
 arch/x86/hyperv/hv_spinlock.c         | 1 -
 arch/x86/include/asm/apic.h           | 4 ----
 arch/x86/include/asm/highmem.h        | 1 -
 arch/x86/include/asm/mshyperv.h       | 1 -
 arch/x86/include/asm/pgtable_32.h     | 1 -
 arch/x86/include/asm/spinlock.h       | 1 -
 arch/x86/include/asm/tlbflush.h       | 4 ----
 arch/x86/kernel/apm_32.c              | 1 -
 arch/x86/kernel/callthunks.c          | 1 -
 arch/x86/kernel/cpu/bugs.c            | 1 -
 arch/x86/kernel/vsmp_64.c             | 1 -
 arch/x86/lib/cache-smp.c              | 1 -
 arch/x86/mm/init.c                    | 1 -
 arch/x86/xen/spinlock.c               | 1 -
 16 files changed, 22 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f9983a1907bf..42447b1e1dff 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -31,7 +31,6 @@
 #include <asm/hw_irq.h>
 #include <asm/page_types.h>
 #include <asm/irqflags.h>
-#include <asm/paravirt.h>
 #include <asm/percpu.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 6e6c0a740837..4bd1e271bb22 100644
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
index a26e66d66444..9cd493d467d4 100644
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
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index eef4c3a5ba28..f64393e853ee 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -8,7 +8,6 @@
 #include <linux/io.h>
 #include <linux/static_call.h>
 #include <asm/nospec-branch.h>
-#include <asm/paravirt.h>
 #include <asm/msr.h>
 #include <hyperv/hvhdk.h>
 #include <asm/fpu/types.h>
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
index d0a2847a4bb0..83f51cab0b1e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -26,7 +26,6 @@
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
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 824664c0ecbd..7d3edd6deb6b 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <asm/paravirt.h>
 #include <linux/smp.h>
 #include <linux/export.h>
 #include <linux/kvm_types.h>
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8bf6ad4b9400..76537d40493c 100644
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


