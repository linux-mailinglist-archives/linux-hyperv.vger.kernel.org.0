Return-Path: <linux-hyperv+bounces-6917-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C97B80547
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 17:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B017718818D6
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865E234AAEA;
	Wed, 17 Sep 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ORDiEYWm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ORDiEYWm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A462EE608
	for <linux-hyperv@vger.kernel.org>; Wed, 17 Sep 2025 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120877; cv=none; b=pnIX2EIbsgtcI4rB6ozWHchgJEIa5m55MxrRr9jrWYId7JD4/7N5S7DD2Fn7WTyVtDTKVbkCGZX3ycuA/vQA+vVNjA1dR3JFCVkx5XtNYvp78+ZPkKDaBLKBdWNZBsOLFT4U8cNeDTf7Wa5owOa+gJOX2vf1mt4S9Tflq4v2OJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120877; c=relaxed/simple;
	bh=Av6YBQKD/jmht62RUX+05tEvmCUPo6T7CC+uNvhUyrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWvXcAj+/B6NAoXk6EINxtake0ELS5L1tfGnMAn1SlyhxaKDanMY0+qXyUakte8W8GwXMmRrgryZz/xAo0xk7zCXta5JK0Hn7DP6yxJl5W0qRNV1TltUNHm4Lc4WaE+fbi8e+0YHzqexUJ0B8oGvgKRW1+ZsSh0CcvZnz5an78A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ORDiEYWm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ORDiEYWm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1BA820750;
	Wed, 17 Sep 2025 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8N8BNr/7G8ZPffjUZylDkTdtOKvkH1xYKfpPdWRSBgI=;
	b=ORDiEYWmAela846ojlOVLwooqr/l77scEgcBOUJ0aSiWHokuZRLUlxjJPjpX4ZD2MMFEwK
	P49ZJ81MPF/fWgauv0Qo4AJBsMaC7YWI4ZSHS8VWZs458lkcWRRCZpLeoPzwhR46fNLxPl
	Ip1sAzpb4AZ5JIvSAelSG9MV+ARGsbE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8N8BNr/7G8ZPffjUZylDkTdtOKvkH1xYKfpPdWRSBgI=;
	b=ORDiEYWmAela846ojlOVLwooqr/l77scEgcBOUJ0aSiWHokuZRLUlxjJPjpX4ZD2MMFEwK
	P49ZJ81MPF/fWgauv0Qo4AJBsMaC7YWI4ZSHS8VWZs458lkcWRRCZpLeoPzwhR46fNLxPl
	Ip1sAzpb4AZ5JIvSAelSG9MV+ARGsbE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DF291368D;
	Wed, 17 Sep 2025 14:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZzqRBaXLymieEwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:54:29 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 21/21] x86/pvlocks: Move paravirt spinlock functions into own header
Date: Wed, 17 Sep 2025 16:52:20 +0200
Message-ID: <20250917145220.31064-22-jgross@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

Instead of having the pv spinlock function definitions in paravirt.h,
move them into the new header paravirt-spinlock.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- use new header instead of qspinlock.h
- use dedicated pv_ops_lock array
- move more paravirt related lock code
---
 arch/x86/hyperv/hv_spinlock.c            |  10 +-
 arch/x86/include/asm/paravirt-spinlock.h | 146 +++++++++++++++++++++++
 arch/x86/include/asm/paravirt.h          |  61 ----------
 arch/x86/include/asm/paravirt_types.h    |  17 ---
 arch/x86/include/asm/qspinlock.h         |  89 ++------------
 arch/x86/kernel/Makefile                 |   2 +-
 arch/x86/kernel/kvm.c                    |  10 +-
 arch/x86/kernel/paravirt-spinlocks.c     |  24 +++-
 arch/x86/kernel/paravirt.c               |  21 ----
 arch/x86/xen/spinlock.c                  |  10 +-
 tools/objtool/check.c                    |   1 +
 11 files changed, 192 insertions(+), 199 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt-spinlock.h

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 2a3c2afb0154..210b494e4de0 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -78,11 +78,11 @@ void __init hv_init_spinlocks(void)
 	pr_info("PV spinlocks enabled\n");
 
 	__pv_init_lock_hash();
-	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_ops.lock.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-	pv_ops.lock.wait = hv_qlock_wait;
-	pv_ops.lock.kick = hv_qlock_kick;
-	pv_ops.lock.vcpu_is_preempted = PV_CALLEE_SAVE(hv_vcpu_is_preempted);
+	pv_ops_lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
+	pv_ops_lock.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	pv_ops_lock.wait = hv_qlock_wait;
+	pv_ops_lock.kick = hv_qlock_kick;
+	pv_ops_lock.vcpu_is_preempted = PV_CALLEE_SAVE(hv_vcpu_is_preempted);
 }
 
 static __init int hv_parse_nopvspin(char *arg)
diff --git a/arch/x86/include/asm/paravirt-spinlock.h b/arch/x86/include/asm/paravirt-spinlock.h
new file mode 100644
index 000000000000..ed3ed343903d
--- /dev/null
+++ b/arch/x86/include/asm/paravirt-spinlock.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_X86_PARAVIRT_SPINLOCK_H
+#define _ASM_X86_PARAVIRT_SPINLOCK_H
+
+#include <asm/paravirt_types.h>
+
+#ifdef CONFIG_SMP
+#include <asm/spinlock_types.h>
+#endif
+
+struct qspinlock;
+
+struct pv_lock_ops {
+	void (*queued_spin_lock_slowpath)(struct qspinlock *lock, u32 val);
+	struct paravirt_callee_save queued_spin_unlock;
+
+	void (*wait)(u8 *ptr, u8 val);
+	void (*kick)(int cpu);
+
+	struct paravirt_callee_save vcpu_is_preempted;
+} __no_randomize_layout;
+
+extern struct pv_lock_ops pv_ops_lock;
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+void __init paravirt_set_cap(void);
+extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __pv_init_lock_hash(void);
+extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
+extern bool nopvspin;
+
+static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
+							 u32 val)
+{
+	PVOP_VCALL2(pv_ops_lock, queued_spin_lock_slowpath, lock, val);
+}
+
+static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
+{
+	PVOP_ALT_VCALLEE1(pv_ops_lock, queued_spin_unlock, lock,
+			  "movb $0, (%%" _ASM_ARG1 ");",
+			  ALT_NOT(X86_FEATURE_PVUNLOCK));
+}
+
+static __always_inline bool pv_vcpu_is_preempted(long cpu)
+{
+	return PVOP_ALT_CALLEE1(bool, pv_ops_lock, vcpu_is_preempted, cpu,
+				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
+				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
+}
+
+#define queued_spin_unlock queued_spin_unlock
+/**
+ * queued_spin_unlock - release a queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ *
+ * A smp_store_release() on the least-significant byte.
+ */
+static inline void native_queued_spin_unlock(struct qspinlock *lock)
+{
+	smp_store_release(&lock->locked, 0);
+}
+
+static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	pv_queued_spin_lock_slowpath(lock, val);
+}
+
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	kcsan_release();
+	pv_queued_spin_unlock(lock);
+}
+
+#define vcpu_is_preempted vcpu_is_preempted
+static inline bool vcpu_is_preempted(long cpu)
+{
+	return pv_vcpu_is_preempted(cpu);
+}
+
+static __always_inline void pv_wait(u8 *ptr, u8 val)
+{
+	PVOP_VCALL2(pv_ops_lock, wait, ptr, val);
+}
+
+static __always_inline void pv_kick(int cpu)
+{
+	PVOP_VCALL1(pv_ops_lock, kick, cpu);
+}
+
+void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
+bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
+
+void __init native_pv_lock_init(void);
+__visible void __native_queued_spin_unlock(struct qspinlock *lock);
+bool pv_is_native_spin_unlock(void);
+__visible bool __native_vcpu_is_preempted(long cpu);
+bool pv_is_native_vcpu_is_preempted(void);
+
+/*
+ * virt_spin_lock_key - disables by default the virt_spin_lock() hijack.
+ *
+ * Native (and PV wanting native due to vCPU pinning) should keep this key
+ * disabled. Native does not touch the key.
+ *
+ * When in a guest then native_pv_lock_init() enables the key first and
+ * KVM/XEN might conditionally disable it later in the boot process again.
+ */
+DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
+
+/*
+ * Shortcut for the queued_spin_lock_slowpath() function that allows
+ * virt to hijack it.
+ *
+ * Returns:
+ *   true - lock has been negotiated, all done;
+ *   false - queued_spin_lock_slowpath() will do its thing.
+ */
+#define virt_spin_lock virt_spin_lock
+static inline bool virt_spin_lock(struct qspinlock *lock)
+{
+	int val;
+
+	if (!static_branch_likely(&virt_spin_lock_key))
+		return false;
+
+	/*
+	 * On hypervisors without PARAVIRT_SPINLOCKS support we fall
+	 * back to a Test-and-Set spinlock, because fair locks have
+	 * horrible lock 'holder' preemption issues.
+	 */
+
+ __retry:
+	val = atomic_read(&lock->val);
+
+	if (val || !atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)) {
+		cpu_relax();
+		goto __retry;
+	}
+
+	return true;
+}
+
+#endif /* _ASM_X86_PARAVIRT_SPINLOCK_H */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index ec274d13bae0..b21072af731d 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -19,15 +19,6 @@
 #include <linux/cpumask.h>
 #include <asm/frame.h>
 
-__visible void __native_queued_spin_unlock(struct qspinlock *lock);
-bool pv_is_native_spin_unlock(void);
-__visible bool __native_vcpu_is_preempted(long cpu);
-bool pv_is_native_vcpu_is_preempted(void);
-
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-void __init paravirt_set_cap(void);
-#endif
-
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
@@ -522,46 +513,7 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 {
 	pv_ops.mmu.set_fixmap(idx, phys, flags);
 }
-#endif
-
-#if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
-
-static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
-							u32 val)
-{
-	PVOP_VCALL2(pv_ops, lock.queued_spin_lock_slowpath, lock, val);
-}
-
-static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
-{
-	PVOP_ALT_VCALLEE1(pv_ops, lock.queued_spin_unlock, lock,
-			  "movb $0, (%%" _ASM_ARG1 ");",
-			  ALT_NOT(X86_FEATURE_PVUNLOCK));
-}
-
-static __always_inline void pv_wait(u8 *ptr, u8 val)
-{
-	PVOP_VCALL2(pv_ops, lock.wait, ptr, val);
-}
-
-static __always_inline void pv_kick(int cpu)
-{
-	PVOP_VCALL1(pv_ops, lock.kick, cpu);
-}
-
-static __always_inline bool pv_vcpu_is_preempted(long cpu)
-{
-	return PVOP_ALT_CALLEE1(bool, pv_ops, lock.vcpu_is_preempted, cpu,
-				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
-				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
-}
 
-void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
-bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
-
-#endif /* SMP && PARAVIRT_SPINLOCKS */
-
-#ifdef CONFIG_PARAVIRT_XXL
 static __always_inline unsigned long arch_local_save_flags(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, pv_ops, irq.save_fl, "pushf; pop %%rax;",
@@ -588,8 +540,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 }
 #endif
 
-void native_pv_lock_init(void) __init;
-
 #else  /* __ASSEMBLER__ */
 
 #ifdef CONFIG_X86_64
@@ -613,12 +563,6 @@ void native_pv_lock_init(void) __init;
 #endif /* __ASSEMBLER__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
-
-#ifndef __ASSEMBLER__
-static inline void native_pv_lock_init(void)
-{
-}
-#endif
 #endif /* !CONFIG_PARAVIRT */
 
 #ifndef __ASSEMBLER__
@@ -634,10 +578,5 @@ static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 }
 #endif
 
-#ifndef CONFIG_PARAVIRT_SPINLOCKS
-static inline void paravirt_set_cap(void)
-{
-}
-#endif
 #endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PARAVIRT_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 01a485f1a7f1..e2b487d35d14 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -184,22 +184,6 @@ struct pv_mmu_ops {
 #endif
 } __no_randomize_layout;
 
-#ifdef CONFIG_SMP
-#include <asm/spinlock_types.h>
-#endif
-
-struct qspinlock;
-
-struct pv_lock_ops {
-	void (*queued_spin_lock_slowpath)(struct qspinlock *lock, u32 val);
-	struct paravirt_callee_save queued_spin_unlock;
-
-	void (*wait)(u8 *ptr, u8 val);
-	void (*kick)(int cpu);
-
-	struct paravirt_callee_save vcpu_is_preempted;
-} __no_randomize_layout;
-
 /* This contains all the paravirt structures: we get a convenient
  * number for each function using the offset which we use to indicate
  * what to patch. */
@@ -207,7 +191,6 @@ struct paravirt_patch_template {
 	struct pv_cpu_ops	cpu;
 	struct pv_irq_ops	irq;
 	struct pv_mmu_ops	mmu;
-	struct pv_lock_ops	lock;
 } __no_randomize_layout;
 
 extern struct paravirt_patch_template pv_ops;
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 68da67df304d..a2668bdf4c84 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -7,6 +7,9 @@
 #include <asm-generic/qspinlock_types.h>
 #include <asm/paravirt.h>
 #include <asm/rmwcc.h>
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt-spinlock.h>
+#endif
 
 #define _Q_PENDING_LOOPS	(1 << 9)
 
@@ -27,89 +30,13 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
 	return val;
 }
 
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
-extern void __pv_init_lock_hash(void);
-extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
-extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
-extern bool nopvspin;
-
-#define	queued_spin_unlock queued_spin_unlock
-/**
- * queued_spin_unlock - release a queued spinlock
- * @lock : Pointer to queued spinlock structure
- *
- * A smp_store_release() on the least-significant byte.
- */
-static inline void native_queued_spin_unlock(struct qspinlock *lock)
-{
-	smp_store_release(&lock->locked, 0);
-}
-
-static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
-{
-	pv_queued_spin_lock_slowpath(lock, val);
-}
-
-static inline void queued_spin_unlock(struct qspinlock *lock)
-{
-	kcsan_release();
-	pv_queued_spin_unlock(lock);
-}
-
-#define vcpu_is_preempted vcpu_is_preempted
-static inline bool vcpu_is_preempted(long cpu)
-{
-	return pv_vcpu_is_preempted(cpu);
-}
+#ifndef CONFIG_PARAVIRT_SPINLOCKS
+static inline void paravirt_set_cap(void) { }
 #endif
 
-#ifdef CONFIG_PARAVIRT
-/*
- * virt_spin_lock_key - disables by default the virt_spin_lock() hijack.
- *
- * Native (and PV wanting native due to vCPU pinning) should keep this key
- * disabled. Native does not touch the key.
- *
- * When in a guest then native_pv_lock_init() enables the key first and
- * KVM/XEN might conditionally disable it later in the boot process again.
- */
-DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
-
-/*
- * Shortcut for the queued_spin_lock_slowpath() function that allows
- * virt to hijack it.
- *
- * Returns:
- *   true - lock has been negotiated, all done;
- *   false - queued_spin_lock_slowpath() will do its thing.
- */
-#define virt_spin_lock virt_spin_lock
-static inline bool virt_spin_lock(struct qspinlock *lock)
-{
-	int val;
-
-	if (!static_branch_likely(&virt_spin_lock_key))
-		return false;
-
-	/*
-	 * On hypervisors without PARAVIRT_SPINLOCKS support we fall
-	 * back to a Test-and-Set spinlock, because fair locks have
-	 * horrible lock 'holder' preemption issues.
-	 */
-
- __retry:
-	val = atomic_read(&lock->val);
-
-	if (val || !atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)) {
-		cpu_relax();
-		goto __retry;
-	}
-
-	return true;
-}
-
-#endif /* CONFIG_PARAVIRT */
+#ifndef CONFIG_PARAVIRT
+static inline void native_pv_lock_init(void) { }
+#endif
 
 #include <asm-generic/qspinlock.h>
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0d2a6d953be9..56d57944fa4b 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -126,7 +126,7 @@ obj-$(CONFIG_DEBUG_NMI_SELFTEST) += nmi_selftest.o
 
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvmclock.o
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o
-obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= paravirt-spinlocks.o
+obj-$(CONFIG_PARAVIRT)		+= paravirt-spinlocks.o
 obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index a23211eaaeed..a94376d04dca 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -825,7 +825,7 @@ static void __init kvm_guest_init(void)
 		has_steal_clock = 1;
 		static_call_update(pv_steal_clock, kvm_steal_clock);
 
-		pv_ops.lock.vcpu_is_preempted =
+		pv_ops_lock.vcpu_is_preempted =
 			PV_CALLEE_SAVE(__kvm_vcpu_is_preempted);
 	}
 
@@ -1105,11 +1105,11 @@ void __init kvm_spinlock_init(void)
 	pr_info("PV spinlocks enabled\n");
 
 	__pv_init_lock_hash();
-	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_ops.lock.queued_spin_unlock =
+	pv_ops_lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
+	pv_ops_lock.queued_spin_unlock =
 		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-	pv_ops.lock.wait = kvm_wait;
-	pv_ops.lock.kick = kvm_kick_cpu;
+	pv_ops_lock.wait = kvm_wait;
+	pv_ops_lock.kick = kvm_kick_cpu;
 
 	/*
 	 * When PV spinlock is enabled which is preferred over
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 9e1ea99ad9df..f9cf6f71395a 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -3,12 +3,20 @@
  * Split spinlock implementation out into its own file, so it can be
  * compiled in a FTRACE-compatible way.
  */
+#include <linux/static_call.h>
 #include <linux/spinlock.h>
 #include <linux/export.h>
 #include <linux/jump_label.h>
 
-#include <asm/paravirt.h>
+DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
+void __init native_pv_lock_init(void)
+{
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		static_branch_enable(&virt_spin_lock_key);
+}
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
 __visible void __native_queued_spin_unlock(struct qspinlock *lock)
 {
 	native_queued_spin_unlock(lock);
@@ -17,7 +25,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__native_queued_spin_unlock);
 
 bool pv_is_native_spin_unlock(void)
 {
-	return pv_ops.lock.queued_spin_unlock.func ==
+	return pv_ops_lock.queued_spin_unlock.func ==
 		__raw_callee_save___native_queued_spin_unlock;
 }
 
@@ -29,7 +37,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__native_vcpu_is_preempted);
 
 bool pv_is_native_vcpu_is_preempted(void)
 {
-	return pv_ops.lock.vcpu_is_preempted.func ==
+	return pv_ops_lock.vcpu_is_preempted.func ==
 		__raw_callee_save___native_vcpu_is_preempted;
 }
 
@@ -41,3 +49,13 @@ void __init paravirt_set_cap(void)
 	if (!pv_is_native_vcpu_is_preempted())
 		setup_force_cpu_cap(X86_FEATURE_VCPUPREEMPT);
 }
+
+struct pv_lock_ops pv_ops_lock = {
+	.queued_spin_lock_slowpath	= native_queued_spin_lock_slowpath,
+	.queued_spin_unlock		= PV_CALLEE_SAVE(__native_queued_spin_unlock),
+	.wait				= paravirt_nop,
+	.kick				= paravirt_nop,
+	.vcpu_is_preempted		= PV_CALLEE_SAVE(__native_vcpu_is_preempted),
+};
+EXPORT_SYMBOL(pv_ops_lock);
+#endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5dfbd3f55792..a6ed52cae003 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -57,14 +57,6 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
 DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 #endif
 
-DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
-
-void __init native_pv_lock_init(void)
-{
-	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		static_branch_enable(&virt_spin_lock_key);
-}
-
 static noinstr void pv_native_safe_halt(void)
 {
 	native_safe_halt();
@@ -221,19 +213,6 @@ struct paravirt_patch_template pv_ops = {
 
 	.mmu.set_fixmap		= native_set_fixmap,
 #endif /* CONFIG_PARAVIRT_XXL */
-
-#if defined(CONFIG_PARAVIRT_SPINLOCKS)
-	/* Lock ops. */
-#ifdef CONFIG_SMP
-	.lock.queued_spin_lock_slowpath	= native_queued_spin_lock_slowpath,
-	.lock.queued_spin_unlock	=
-				PV_CALLEE_SAVE(__native_queued_spin_unlock),
-	.lock.wait			= paravirt_nop,
-	.lock.kick			= paravirt_nop,
-	.lock.vcpu_is_preempted		=
-				PV_CALLEE_SAVE(__native_vcpu_is_preempted),
-#endif /* SMP */
-#endif
 };
 
 #ifdef CONFIG_PARAVIRT_XXL
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index fe56646d6919..83ac24ead289 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -134,10 +134,10 @@ void __init xen_init_spinlocks(void)
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
 
 	__pv_init_lock_hash();
-	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_ops.lock.queued_spin_unlock =
+	pv_ops_lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
+	pv_ops_lock.queued_spin_unlock =
 		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-	pv_ops.lock.wait = xen_qlock_wait;
-	pv_ops.lock.kick = xen_qlock_kick;
-	pv_ops.lock.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
+	pv_ops_lock.wait = xen_qlock_wait;
+	pv_ops_lock.kick = xen_qlock_kick;
+	pv_ops_lock.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ca6ad92618d8..e9e1b5d321e5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -549,6 +549,7 @@ static struct {
 	int idx_off;
 } pv_ops_tables[] = {
 	{ .name = "pv_ops", },
+	{ .name = "pv_ops_lock", },
 	{ .name = NULL, .idx_off = -1 }
 };
 
-- 
2.51.0


