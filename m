Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428AA2FDA96
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 21:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbhATUPr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jan 2021 15:15:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:59160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731298AbhATOA6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 09:00:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611150962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPBshvehzp6blrUnnUW76rGI6e9WlnGmkT7jZvn/5h4=;
        b=uOewyFTuTYGcYqxaS0f68MyKay0eqqN+HXVU32cgfoN5DndxAGzsBwPYX4CD6fN0eTpUcR
        /VUme5cGWuqQmclhE5Inn0NwniOKuwJXX92yJG2xnqXDL4txCiknH035LivyF1x+J+r1ps
        3w2LJEjyzXQ9RfDjMg2CU4hqw5bP95Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1D49B699;
        Wed, 20 Jan 2021 13:56:01 +0000 (UTC)
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
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v4 07/15] x86/paravirt: switch time pvops functions to use static_call()
Date:   Wed, 20 Jan 2021 14:55:47 +0100
Message-Id: <20210120135555.32594-8-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210120135555.32594-1-jgross@suse.com>
References: <20210120135555.32594-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The time pvops functions are the only ones left which might be
used in 32-bit mode and which return a 64-bit value.

Switch them to use the static_call() mechanism instead of pvops, as
this allows quite some simplification of the pvops implementation.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4:
- drop paravirt_time.h again
- don't move Hyper-V code (Michael Kelley)
---
 arch/x86/Kconfig                      |  1 +
 arch/x86/include/asm/mshyperv.h       |  2 +-
 arch/x86/include/asm/paravirt.h       | 17 ++++++++++++++---
 arch/x86/include/asm/paravirt_types.h |  6 ------
 arch/x86/kernel/cpu/vmware.c          |  5 +++--
 arch/x86/kernel/kvm.c                 |  2 +-
 arch/x86/kernel/kvmclock.c            |  2 +-
 arch/x86/kernel/paravirt.c            | 16 ++++++++++++----
 arch/x86/kernel/tsc.c                 |  2 +-
 arch/x86/xen/time.c                   | 11 ++++-------
 drivers/clocksource/hyperv_timer.c    |  5 +++--
 drivers/xen/time.c                    |  2 +-
 12 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 21f851179ff0..7ccd4a80788c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -771,6 +771,7 @@ if HYPERVISOR_GUEST
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
+	depends on HAVE_STATIC_CALL
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 30f76b966857..b4ee331d29a7 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -63,7 +63,7 @@ typedef int (*hyperv_fill_flush_list_func)(
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
 {
 #ifdef CONFIG_PARAVIRT
-	pv_ops.time.sched_clock = sched_clock;
+	paravirt_set_sched_clock(sched_clock);
 #endif
 }
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 4abf110e2243..1e45b46fae84 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -15,11 +15,22 @@
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
+#include <linux/static_call_types.h>
 #include <asm/frame.h>
 
-static inline unsigned long long paravirt_sched_clock(void)
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
 {
-	return PVOP_CALL0(unsigned long long, time.sched_clock);
+	return static_call(pv_sched_clock)();
 }
 
 struct static_key;
@@ -33,7 +44,7 @@ bool pv_is_native_vcpu_is_preempted(void);
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return PVOP_CALL1(u64, time.steal_clock, cpu);
+	return static_call(pv_steal_clock)(cpu);
 }
 
 /* The paravirtualized I/O functions */
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
index c6ede3b3d302..84fb8e3f3d1b 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -27,6 +27,7 @@
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
 #include <linux/reboot.h>
+#include <linux/static_call.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
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
index 5e78e01ca3b4..351ba99f6009 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -650,7 +650,7 @@ static void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		has_steal_clock = 1;
-		pv_ops.time.steal_clock = kvm_steal_clock;
+		static_call_update(pv_steal_clock, kvm_steal_clock);
 	}
 
 	if (pv_tlb_flush_supported()) {
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index aa593743acf6..01e7c1839ace 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -106,7 +106,7 @@ static inline void kvm_sched_clock_init(bool stable)
 	if (!stable)
 		clear_sched_clock_stable();
 	kvm_sched_clock_offset = kvm_clock_read();
-	pv_ops.time.sched_clock = kvm_sched_clock_read;
+	paravirt_set_sched_clock(kvm_sched_clock_read);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c60222ab8ab9..44e5b0fe28cb 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -14,6 +14,7 @@
 #include <linux/highmem.h>
 #include <linux/kprobes.h>
 #include <linux/pgtable.h>
+#include <linux/static_call.h>
 
 #include <asm/bug.h>
 #include <asm/paravirt.h>
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
index f70dffc2771f..b6f7853d8077 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -254,7 +254,7 @@ unsigned long long sched_clock(void)
 
 bool using_native_sched_clock(void)
 {
-	return pv_ops.time.sched_clock == native_sched_clock;
+	return paravirt_using_native_sched_clock;
 }
 #else
 unsigned long long
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 91f5b330dcc6..01930e182e99 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -379,11 +379,6 @@ void xen_timer_resume(void)
 	}
 }
 
-static const struct pv_time_ops xen_time_ops __initconst = {
-	.sched_clock = xen_sched_clock,
-	.steal_clock = xen_steal_clock,
-};
-
 static struct pvclock_vsyscall_time_info *xen_clock __read_mostly;
 static u64 xen_clock_value_saved;
 
@@ -528,7 +523,8 @@ static void __init xen_time_init(void)
 void __init xen_init_time_ops(void)
 {
 	xen_sched_clock_offset = xen_clocksource_read();
-	pv_ops.time = xen_time_ops;
+	static_call_update(pv_steal_clock, xen_steal_clock);
+	paravirt_set_sched_clock(xen_sched_clock);
 
 	x86_init.timers.timer_init = xen_time_init;
 	x86_init.timers.setup_percpu_clockev = x86_init_noop;
@@ -570,7 +566,8 @@ void __init xen_hvm_init_time_ops(void)
 	}
 
 	xen_sched_clock_offset = xen_clocksource_read();
-	pv_ops.time = xen_time_ops;
+	static_call_update(pv_steal_clock, xen_steal_clock);
+	paravirt_set_sched_clock(xen_sched_clock);
 	x86_init.timers.setup_percpu_clockev = xen_time_init;
 	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
 
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index ba04cb381cd3..bf3bf20bc6bd 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -18,6 +18,7 @@
 #include <linux/sched_clock.h>
 #include <linux/mm.h>
 #include <linux/cpuhotplug.h>
+#include <linux/static_call.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
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
index 108edbcbc040..199c016834ed 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -175,7 +175,7 @@ void __init xen_time_setup_guest(void)
 	xen_runstate_remote = !HYPERVISOR_vm_assist(VMASST_CMD_enable,
 					VMASST_TYPE_runstate_update_flag);
 
-	pv_ops.time.steal_clock = xen_steal_clock;
+	static_call_update(pv_steal_clock, xen_steal_clock);
 
 	static_key_slow_inc(&paravirt_steal_enabled);
 	if (xen_runstate_remote)
-- 
2.26.2

