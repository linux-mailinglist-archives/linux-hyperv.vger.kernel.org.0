Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FEA330D8F
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Mar 2021 13:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCHM3X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Mar 2021 07:29:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:40308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhCHM2w (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Mar 2021 07:28:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615206530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J66CWuwKwfzFPvCq/m8D63U++K/o7dDSv22aN/eKP7M=;
        b=cIXiUqxf03980MHxBeIJz7vODEC6tQtd6/lUgwJufF8vAwaGi1A80YufivneEt5GZP/2E8
        v70lIPnIEGXuQi2CqELG40DuUwx+olazP2WTKu8piVPTmYHrvFbzH5GBP7rz87skFklWM4
        RZyo17tov8ZR5dCZ9W3sgwYURK9c2HU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F935AD74;
        Mon,  8 Mar 2021 12:28:50 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v5 02/12] x86/paravirt: switch time pvops functions to use static_call()
Date:   Mon,  8 Mar 2021 13:28:34 +0100
Message-Id: <20210308122844.30488-3-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210308122844.30488-1-jgross@suse.com>
References: <20210308122844.30488-1-jgross@suse.com>
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
V5:
- drop no longer needed Hyper-V modification (Michael Kelley)
- switch Arm and Arm64 to static_call(), too (kernel test robot)
---
 arch/arm/include/asm/paravirt.h       | 14 +++++---------
 arch/arm/kernel/paravirt.c            |  9 +++++++--
 arch/arm64/include/asm/paravirt.h     | 14 +++++---------
 arch/arm64/kernel/paravirt.c          | 13 +++++++++----
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
 drivers/xen/time.c                    |  3 ++-
 15 files changed, 66 insertions(+), 51 deletions(-)

diff --git a/arch/arm/include/asm/paravirt.h b/arch/arm/include/asm/paravirt.h
index cdbf02d9c1d4..95d5b0d625cd 100644
--- a/arch/arm/include/asm/paravirt.h
+++ b/arch/arm/include/asm/paravirt.h
@@ -3,23 +3,19 @@
 #define _ASM_ARM_PARAVIRT_H
 
 #ifdef CONFIG_PARAVIRT
+#include <linux/static_call_types.h>
+
 struct static_key;
 extern struct static_key paravirt_steal_enabled;
 extern struct static_key paravirt_steal_rq_enabled;
 
-struct pv_time_ops {
-	unsigned long long (*steal_clock)(int cpu);
-};
-
-struct paravirt_patch_template {
-	struct pv_time_ops time;
-};
+u64 dummy_steal_clock(int cpu);
 
-extern struct paravirt_patch_template pv_ops;
+DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return pv_ops.time.steal_clock(cpu);
+	return static_call(pv_steal_clock)(cpu);
 }
 #endif
 
diff --git a/arch/arm/kernel/paravirt.c b/arch/arm/kernel/paravirt.c
index 4cfed91fe256..7dd9806369fb 100644
--- a/arch/arm/kernel/paravirt.c
+++ b/arch/arm/kernel/paravirt.c
@@ -9,10 +9,15 @@
 #include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/types.h>
+#include <linux/static_call.h>
 #include <asm/paravirt.h>
 
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
-struct paravirt_patch_template pv_ops;
-EXPORT_SYMBOL_GPL(pv_ops);
+static u64 native_steal_clock(int cpu)
+{
+	return 0;
+}
+
+DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/paravirt.h
index cf3a0fd7c1a7..9aa193e0e8f2 100644
--- a/arch/arm64/include/asm/paravirt.h
+++ b/arch/arm64/include/asm/paravirt.h
@@ -3,23 +3,19 @@
 #define _ASM_ARM64_PARAVIRT_H
 
 #ifdef CONFIG_PARAVIRT
+#include <linux/static_call_types.h>
+
 struct static_key;
 extern struct static_key paravirt_steal_enabled;
 extern struct static_key paravirt_steal_rq_enabled;
 
-struct pv_time_ops {
-	unsigned long long (*steal_clock)(int cpu);
-};
-
-struct paravirt_patch_template {
-	struct pv_time_ops time;
-};
+u64 dummy_steal_clock(int cpu);
 
-extern struct paravirt_patch_template pv_ops;
+DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return pv_ops.time.steal_clock(cpu);
+	return static_call(pv_steal_clock)(cpu);
 }
 
 int __init pv_time_init(void);
diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
index c07d7a034941..75fed4460407 100644
--- a/arch/arm64/kernel/paravirt.c
+++ b/arch/arm64/kernel/paravirt.c
@@ -18,6 +18,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/static_call.h>
 
 #include <asm/paravirt.h>
 #include <asm/pvclock-abi.h>
@@ -26,8 +27,12 @@
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
-struct paravirt_patch_template pv_ops;
-EXPORT_SYMBOL_GPL(pv_ops);
+static u64 native_steal_clock(int cpu)
+{
+	return 0;
+}
+
+DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 
 struct pv_time_stolen_time_region {
 	struct pvclock_vcpu_stolen_time *kaddr;
@@ -45,7 +50,7 @@ static int __init parse_no_stealacc(char *arg)
 early_param("no-steal-acc", parse_no_stealacc);
 
 /* return stolen time in ns by asking the hypervisor */
-static u64 pv_steal_clock(int cpu)
+static u64 para_steal_clock(int cpu)
 {
 	struct pv_time_stolen_time_region *reg;
 
@@ -150,7 +155,7 @@ int __init pv_time_init(void)
 	if (ret)
 		return ret;
 
-	pv_ops.time.steal_clock = pv_steal_clock;
+	static_call_update(pv_steal_clock, para_steal_clock);
 
 	static_key_slow_inc(&paravirt_steal_enabled);
 	if (steal_acc)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..107acc403b3b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -777,6 +777,7 @@ if HYPERVISOR_GUEST
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
+	depends on HAVE_STATIC_CALL
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ccf60a809a17..e7be720062a8 100644
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
 
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 108edbcbc040..152dd33bb223 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -7,6 +7,7 @@
 #include <linux/math64.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
+#include <linux/static_call.h>
 
 #include <asm/paravirt.h>
 #include <asm/xen/hypervisor.h>
@@ -175,7 +176,7 @@ void __init xen_time_setup_guest(void)
 	xen_runstate_remote = !HYPERVISOR_vm_assist(VMASST_CMD_enable,
 					VMASST_TYPE_runstate_update_flag);
 
-	pv_ops.time.steal_clock = xen_steal_clock;
+	static_call_update(pv_steal_clock, xen_steal_clock);
 
 	static_key_slow_inc(&paravirt_steal_enabled);
 	if (xen_runstate_remote)
-- 
2.26.2

