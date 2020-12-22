Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AEA2DCE7F
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Dec 2020 10:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgLQJeD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Dec 2020 04:34:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:43658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgLQJdT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Dec 2020 04:33:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608197508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6gxliSCsh3WKILmxj4RJn4SpdlW/0yI/QevTH0przg=;
        b=kwgvz+7bk8SUbt9TMo5E0AtpcQKuGkGIdhTz/B272guohLREgzNYP6Uy2FZyXZ1hNFXD4C
        ehDwVXEgZ1cNADdlNf25z7q0dWGCZYTw4BBwg1bvjOAkRFRxsHc5o2QdQvPxSnFF6jzzgz
        qLKKeB1GzE4cCsH8sAFFQPrx9N7v4qw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0861FB718;
        Thu, 17 Dec 2020 09:31:48 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 06/15] x86/paravirt: switch time pvops functions to use static_call()
Date:   Thu, 17 Dec 2020 10:31:24 +0100
Message-Id: <20201217093133.1507-7-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217093133.1507-1-jgross@suse.com>
References: <20201217093133.1507-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The time pvops functions are the only ones left which might be
used in 32-bit mode and which return a 64-bit value.

Switch them to use the static_call() mechanism instead of pvops, as
this allows quite some simplification of the pvops implementation.

Due to include hell this requires to split out the time interfaces
into a new header file.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/Kconfig                      |  1 +
 arch/x86/include/asm/mshyperv.h       | 11 --------
 arch/x86/include/asm/paravirt.h       | 14 ----------
 arch/x86/include/asm/paravirt_time.h  | 38 +++++++++++++++++++++++++++
 arch/x86/include/asm/paravirt_types.h |  6 -----
 arch/x86/kernel/cpu/vmware.c          |  5 ++--
 arch/x86/kernel/kvm.c                 |  3 ++-
 arch/x86/kernel/kvmclock.c            |  3 ++-
 arch/x86/kernel/paravirt.c            | 16 ++++++++---
 arch/x86/kernel/tsc.c                 |  3 ++-
 arch/x86/xen/time.c                   | 12 ++++-----
 drivers/clocksource/hyperv_timer.c    |  5 ++--
 drivers/xen/time.c                    |  3 ++-
 kernel/sched/sched.h                  |  1 +
 14 files changed, 71 insertions(+), 50 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt_time.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a8bd298e45b1..ebabd8bf4064 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -769,6 +769,7 @@ if HYPERVISOR_GUEST
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
+	depends on HAVE_STATIC_CALL
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ffc289992d1b..45942d420626 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -56,17 +56,6 @@ typedef int (*hyperv_fill_flush_list_func)(
 #define hv_get_raw_timer() rdtsc_ordered()
 #define hv_get_vector() HYPERVISOR_CALLBACK_VECTOR
 
-/*
- * Reference to pv_ops must be inline so objtool
- * detection of noinstr violations can work correctly.
- */
-static __always_inline void hv_setup_sched_clock(void *sched_clock)
-{
-#ifdef CONFIG_PARAVIRT
-	pv_ops.time.sched_clock = sched_clock;
-#endif
-}
-
 void hyperv_vector_handler(struct pt_regs *regs);
 
 static inline void hv_enable_stimer0_percpu_irq(int irq) {}
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 4abf110e2243..0785a9686e32 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -17,25 +17,11 @@
 #include <linux/cpumask.h>
 #include <asm/frame.h>
 
-static inline unsigned long long paravirt_sched_clock(void)
-{
-	return PVOP_CALL0(unsigned long long, time.sched_clock);
-}
-
-struct static_key;
-extern struct static_key paravirt_steal_enabled;
-extern struct static_key paravirt_steal_rq_enabled;
-
 __visible void __native_queued_spin_unlock(struct qspinlock *lock);
 bool pv_is_native_spin_unlock(void);
 __visible bool __native_vcpu_is_preempted(long cpu);
 bool pv_is_native_vcpu_is_preempted(void);
 
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return PVOP_CALL1(u64, time.steal_clock, cpu);
-}
-
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
diff --git a/arch/x86/include/asm/paravirt_time.h b/arch/x86/include/asm/paravirt_time.h
new file mode 100644
index 000000000000..76cf94b7c899
--- /dev/null
+++ b/arch/x86/include/asm/paravirt_time.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PARAVIRT_TIME_H
+#define _ASM_X86_PARAVIRT_TIME_H
+
+/* Time related para-virtualized functions. */
+
+#ifdef CONFIG_PARAVIRT
+
+#include <linux/types.h>
+#include <linux/jump_label.h>
+#include <linux/static_call.h>
+
+extern struct static_key paravirt_steal_enabled;
+extern struct static_key paravirt_steal_rq_enabled;
+
+u64 dummy_steal_clock(int cpu);
+u64 dummy_sched_clock(void);
+
+DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
+DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
+
+extern bool paravirt_using_native_sched_clock;
+
+void paravirt_set_sched_clock(u64 (*func)(void));
+
+static inline u64 paravirt_sched_clock(void)
+{
+	return static_call(pv_sched_clock)();
+}
+
+static inline u64 paravirt_steal_clock(int cpu)
+{
+	return static_call(pv_steal_clock)(cpu);
+}
+
+#endif /* CONFIG_PARAVIRT */
+
+#endif /* _ASM_X86_PARAVIRT_TIME_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index de87087d3bde..1fff349e4792 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -95,11 +95,6 @@ struct pv_lazy_ops {
 } __no_randomize_layout;
 #endif
 
-struct pv_time_ops {
-	unsigned long long (*sched_clock)(void);
-	unsigned long long (*steal_clock)(int cpu);
-} __no_randomize_layout;
-
 struct pv_cpu_ops {
 	/* hooks for various privileged instructions */
 	void (*io_delay)(void);
@@ -291,7 +286,6 @@ struct pv_lock_ops {
  * what to patch. */
 struct paravirt_patch_template {
 	struct pv_init_ops	init;
-	struct pv_time_ops	time;
 	struct pv_cpu_ops	cpu;
 	struct pv_irq_ops	irq;
 	struct pv_mmu_ops	mmu;
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 924571fe5864..f265426a1c3e 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -34,6 +34,7 @@
 #include <asm/apic.h>
 #include <asm/vmware.h>
 #include <asm/svm.h>
+#include <asm/paravirt_time.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"vmware: " fmt
@@ -336,11 +337,11 @@ static void __init vmware_paravirt_ops_setup(void)
 	vmware_cyc2ns_setup();
 
 	if (vmw_sched_clock)
-		pv_ops.time.sched_clock = vmware_sched_clock;
+		paravirt_set_sched_clock(vmware_sched_clock);
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-		pv_ops.time.steal_clock = vmware_steal_clock;
+		static_call_update(pv_steal_clock, vmware_steal_clock);
 
 		/* We use reboot notifier only to disable steal clock */
 		register_reboot_notifier(&vmware_pv_reboot_nb);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5e78e01ca3b4..2aa1b9e33f61 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -38,6 +38,7 @@
 #include <asm/cpuidle_haltpoll.h>
 #include <asm/ptrace.h>
 #include <asm/svm.h>
+#include <asm/paravirt_time.h>
 
 DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
 
@@ -650,7 +651,7 @@ static void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		has_steal_clock = 1;
-		pv_ops.time.steal_clock = kvm_steal_clock;
+		static_call_update(pv_steal_clock, kvm_steal_clock);
 	}
 
 	if (pv_tlb_flush_supported()) {
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 34b18f6eeb2c..02f60ee16f10 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -22,6 +22,7 @@
 #include <asm/x86_init.h>
 #include <asm/reboot.h>
 #include <asm/kvmclock.h>
+#include <asm/paravirt_time.h>
 
 static int kvmclock __initdata = 1;
 static int kvmclock_vsyscall __initdata = 1;
@@ -107,7 +108,7 @@ static inline void kvm_sched_clock_init(bool stable)
 	if (!stable)
 		clear_sched_clock_stable();
 	kvm_sched_clock_offset = kvm_clock_read();
-	pv_ops.time.sched_clock = kvm_sched_clock_read;
+	paravirt_set_sched_clock(kvm_sched_clock_read);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c60222ab8ab9..9f8aa18aa378 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -31,6 +31,7 @@
 #include <asm/special_insns.h>
 #include <asm/tlb.h>
 #include <asm/io_bitmap.h>
+#include <asm/paravirt_time.h>
 
 /*
  * nop stub, which must not clobber anything *including the stack* to
@@ -167,6 +168,17 @@ static u64 native_steal_clock(int cpu)
 	return 0;
 }
 
+DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
+DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
+
+bool paravirt_using_native_sched_clock = true;
+
+void paravirt_set_sched_clock(u64 (*func)(void))
+{
+	static_call_update(pv_sched_clock, func);
+	paravirt_using_native_sched_clock = (func == native_sched_clock);
+}
+
 /* These are in entry.S */
 extern void native_iret(void);
 
@@ -272,10 +284,6 @@ struct paravirt_patch_template pv_ops = {
 	/* Init ops. */
 	.init.patch		= native_patch,
 
-	/* Time ops. */
-	.time.sched_clock	= native_sched_clock,
-	.time.steal_clock	= native_steal_clock,
-
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f70dffc2771f..d01245b770de 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -28,6 +28,7 @@
 #include <asm/intel-family.h>
 #include <asm/i8259.h>
 #include <asm/uv/uv.h>
+#include <asm/paravirt_time.h>
 
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -254,7 +255,7 @@ unsigned long long sched_clock(void)
 
 bool using_native_sched_clock(void)
 {
-	return pv_ops.time.sched_clock == native_sched_clock;
+	return paravirt_using_native_sched_clock;
 }
 #else
 unsigned long long
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 91f5b330dcc6..17e62f4f69a9 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -18,6 +18,7 @@
 #include <linux/timekeeper_internal.h>
 
 #include <asm/pvclock.h>
+#include <asm/paravirt_time.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
@@ -379,11 +380,6 @@ void xen_timer_resume(void)
 	}
 }
 
-static const struct pv_time_ops xen_time_ops __initconst = {
-	.sched_clock = xen_sched_clock,
-	.steal_clock = xen_steal_clock,
-};
-
 static struct pvclock_vsyscall_time_info *xen_clock __read_mostly;
 static u64 xen_clock_value_saved;
 
@@ -528,7 +524,8 @@ static void __init xen_time_init(void)
 void __init xen_init_time_ops(void)
 {
 	xen_sched_clock_offset = xen_clocksource_read();
-	pv_ops.time = xen_time_ops;
+	static_call_update(pv_steal_clock, xen_steal_clock);
+	paravirt_set_sched_clock(xen_sched_clock);
 
 	x86_init.timers.timer_init = xen_time_init;
 	x86_init.timers.setup_percpu_clockev = x86_init_noop;
@@ -570,7 +567,8 @@ void __init xen_hvm_init_time_ops(void)
 	}
 
 	xen_sched_clock_offset = xen_clocksource_read();
-	pv_ops.time = xen_time_ops;
+	static_call_update(pv_steal_clock, xen_steal_clock);
+	paravirt_set_sched_clock(xen_sched_clock);
 	x86_init.timers.setup_percpu_clockev = xen_time_init;
 	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
 
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index ba04cb381cd3..1ed79993fc50 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -21,6 +21,7 @@
 #include <clocksource/hyperv_timer.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
+#include <asm/paravirt_time.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
 static u64 hv_sched_clock_offset __ro_after_init;
@@ -445,7 +446,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
 	hv_sched_clock_offset = hv_read_reference_counter();
-	hv_setup_sched_clock(read_hv_sched_clock_tsc);
+	paravirt_set_sched_clock(read_hv_sched_clock_tsc);
 
 	return true;
 }
@@ -470,6 +471,6 @@ void __init hv_init_clocksource(void)
 	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 
 	hv_sched_clock_offset = hv_read_reference_counter();
-	hv_setup_sched_clock(read_hv_sched_clock_msr);
+	static_call_update(pv_sched_clock, read_hv_sched_clock_msr);
 }
 EXPORT_SYMBOL_GPL(hv_init_clocksource);
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 108edbcbc040..b35ce88427c9 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 
 #include <asm/paravirt.h>
+#include <asm/paravirt_time.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
@@ -175,7 +176,7 @@ void __init xen_time_setup_guest(void)
 	xen_runstate_remote = !HYPERVISOR_vm_assist(VMASST_CMD_enable,
 					VMASST_TYPE_runstate_update_flag);
 
-	pv_ops.time.steal_clock = xen_steal_clock;
+	static_call_update(pv_steal_clock, xen_steal_clock);
 
 	static_key_slow_inc(&paravirt_steal_enabled);
 	if (xen_runstate_remote)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f5acb6c5ce49..08427b9c11fd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -70,6 +70,7 @@
 
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
+# include <asm/paravirt_time.h>
 #endif
 
 #include "cpupri.h"
-- 
2.26.2

