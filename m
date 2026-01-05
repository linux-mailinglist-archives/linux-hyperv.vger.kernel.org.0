Return-Path: <linux-hyperv+bounces-8144-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C73CF344B
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 12:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEB563005336
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88470338595;
	Mon,  5 Jan 2026 11:06:42 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5955338585
	for <linux-hyperv@vger.kernel.org>; Mon,  5 Jan 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611202; cv=none; b=QHsJii58wmD3UX8IBvVhOIiOrh5RsOrrN6Wb6ELItNCC2jIUXRo3JAUurmj6AtXYAIhHg/vcgcyBOPny8fzYSLSo/+hU73n8NVlAS/eJiNfhrJJZD4CTshPVgFCnxOtOXcLLGEYM+1cptOFieuxO6XhoHu/jMbq6bzXP19j/Enk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611202; c=relaxed/simple;
	bh=dkD5KlgQoSvkjYmidTAM5IYbGdY3rK7+tJl+NK801mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0Y//AL1TgFWffUkYd2dx6G1IzsfmJZvbk8tzqcytgak1FOKHx53bh9RENLKT2Zflaw64mEa1pFVTkLMVR5/Sr12i+fMiOu3DeFvP4JB4nwC2+H1HWDssx6cdKI0dzMbT5loQ2YrZWq6dOlShtHITVf2NZGknkBXKzG/sZtyZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B25F336E8;
	Mon,  5 Jan 2026 11:06:39 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66B9B13964;
	Mon,  5 Jan 2026 11:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3MN7Fz6bW2k+WgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 05 Jan 2026 11:06:38 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	xen-devel@lists.xenproject.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v5 12/21] x86/paravirt: Move paravirt_sched_clock() related code into tsc.c
Date: Mon,  5 Jan 2026 12:05:11 +0100
Message-ID: <20260105110520.21356-13-jgross@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)]
X-Rspamd-Queue-Id: 2B25F336E8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action

The only user of paravirt_sched_clock() is in tsc.c, so move the code
from paravirt.c and paravirt.h to tsc.c.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h    | 12 ------------
 arch/x86/include/asm/timer.h       |  1 +
 arch/x86/kernel/kvmclock.c         |  1 +
 arch/x86/kernel/paravirt.c         |  7 -------
 arch/x86/kernel/tsc.c              | 10 +++++++++-
 arch/x86/xen/time.c                |  1 +
 drivers/clocksource/hyperv_timer.c |  2 ++
 7 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 766a7cee3d64..b69e75a5c872 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -14,20 +14,8 @@
 #ifndef __ASSEMBLER__
 #include <linux/types.h>
 #include <linux/cpumask.h>
-#include <linux/static_call_types.h>
 #include <asm/frame.h>
 
-u64 dummy_sched_clock(void);
-
-DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
-
-void paravirt_set_sched_clock(u64 (*func)(void));
-
-static __always_inline u64 paravirt_sched_clock(void)
-{
-	return static_call(pv_sched_clock)();
-}
-
 __visible void __native_queued_spin_unlock(struct qspinlock *lock);
 bool pv_is_native_spin_unlock(void);
 __visible bool __native_vcpu_is_preempted(long cpu);
diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index 23baf8c9b34c..fda18bcb19b4 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -12,6 +12,7 @@ extern void recalibrate_cpu_khz(void);
 extern int no_timer_check;
 
 extern bool using_native_sched_clock(void);
+void paravirt_set_sched_clock(u64 (*func)(void));
 
 /*
  * We use the full linear equation: f(x) = a + b*x, in order to allow
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ca0a49eeac4a..b5991d53fc0e 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -19,6 +19,7 @@
 #include <linux/cc_platform.h>
 
 #include <asm/hypervisor.h>
+#include <asm/timer.h>
 #include <asm/x86_init.h>
 #include <asm/kvmclock.h>
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 42991d471bf3..4e37db8073f9 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -60,13 +60,6 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
 
-DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
-
-void paravirt_set_sched_clock(u64 (*func)(void))
-{
-	static_call_update(pv_sched_clock, func);
-}
-
 static noinstr void pv_native_safe_halt(void)
 {
 	native_safe_halt();
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7d3e13e14eab..d5d0b500d13e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -267,19 +267,27 @@ u64 native_sched_clock_from_tsc(u64 tsc)
 /* We need to define a real function for sched_clock, to override the
    weak default version */
 #ifdef CONFIG_PARAVIRT
+DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
+
 noinstr u64 sched_clock_noinstr(void)
 {
-	return paravirt_sched_clock();
+	return static_call(pv_sched_clock)();
 }
 
 bool using_native_sched_clock(void)
 {
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
+
+void paravirt_set_sched_clock(u64 (*func)(void))
+{
+	static_call_update(pv_sched_clock, func);
+}
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
 
 bool using_native_sched_clock(void) { return true; }
+void paravirt_set_sched_clock(u64 (*func)(void)) { }
 #endif
 
 notrace u64 sched_clock(void)
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index e4754b2fa900..6f9f665bb7ae 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -19,6 +19,7 @@
 #include <linux/sched/cputime.h>
 
 #include <asm/pvclock.h>
+#include <asm/timer.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/cpuid.h>
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 10356d4ec55c..e9f5034a1bc8 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -535,6 +535,8 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
 }
 #elif defined CONFIG_PARAVIRT
+#include <asm/timer.h>
+
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
 {
 	/* We're on x86/x64 *and* using PV ops */
-- 
2.51.0


