Return-Path: <linux-hyperv+bounces-448-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFC47B61DE
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 08:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9D99D2816E6
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 06:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3AED263;
	Tue,  3 Oct 2023 06:58:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DC7D262
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Oct 2023 06:58:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591B2D6B;
	Mon,  2 Oct 2023 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696316153; x=1727852153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eEbBoWC5xFSRvZAlegSoACai1Gg5zcI498qdyjosTZg=;
  b=LCqK0SUNoVZuSlE87IrtuLL7LZs0+0Ox9Yhwsw7/VfVwP5gpiu4dgRI7
   MKCqMvZ2UVJshQSQ9RVMH5Wl6Y0gAzJtD57YXbZ5coSKdQDnmyqXtmDr2
   OYifj7m/SCRxt29TiduKgCbiw76TjCM4/sjG8Jjwb22ZzOXmlCrgaH3t0
   5W2fMf+WBw1drmhtiilXDM7+M56dBG+gkpYunKTXL/PKucgUo1pZqgU9m
   PEsWB8y+wyMt7/ZFBeM+19oSOS/3+V0rnmKe9taBwlEwO/gBO0WEKcLnZ
   QCTHumOgDGnsbWX3RMY5jKT0V232HgOwZQmpkfsZxiWZHHABUAftFp0ru
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="367858374"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="367858374"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081901031"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1081901031"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga005.fm.intel.com with ESMTP; 02 Oct 2023 23:54:53 -0700
From: Xin Li <xin3.li@intel.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	peterz@infradead.org,
	jgross@suse.com,
	ravi.v.shankar@intel.com,
	mhiramat@kernel.org,
	andrew.cooper3@citrix.com,
	jiangshanlai@gmail.com,
	nik.borisov@suse.com
Subject: [PATCH v12 37/37] x86/fred: Invoke FRED initialization code to enable FRED
Date: Mon,  2 Oct 2023 23:24:58 -0700
Message-Id: <20231003062458.23552-38-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003062458.23552-1-xin3.li@intel.com>
References: <20231003062458.23552-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Let cpu_init_exception_handling() call cpu_init_fred_exceptions() to
initialize FRED. However if FRED is unavailable or disabled, it falls
back to set up TSS IST and initialize IDT.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Co-developed-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Changes since v10:
* No need to invalidate SYSCALL and SYSENTER MSRs (Thomas Gleixner).

Changes since v8:
* Move this patch after all required changes are in place (Thomas
  Gleixner).
---
 arch/x86/kernel/cpu/common.c | 22 +++++++++++++++++-----
 arch/x86/kernel/irqinit.c    |  7 ++++++-
 arch/x86/kernel/traps.c      |  5 ++++-
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 69f9bdab19a9..b103cfad0520 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -61,6 +61,7 @@
 #include <asm/microcode.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
+#include <asm/fred.h>
 #include <asm/uv/uv.h>
 #include <asm/ia32.h>
 #include <asm/set_memory.h>
@@ -2119,7 +2120,15 @@ void syscall_init(void)
 	/* The default user and kernel segments */
 	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
 
-	idt_syscall_init();
+	/*
+	 * Except the IA32_STAR MSR, there is NO need to setup SYSCALL and
+	 * SYSENTER MSRs for FRED, because FRED uses the ring 3 FRED
+	 * entrypoint for SYSCALL and SYSENTER, and ERETU is the only legit
+	 * instruction to return to ring 3 (both sysexit and sysret cause
+	 * #UD when FRED is enabled).
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		idt_syscall_init();
 }
 
 #else	/* CONFIG_X86_64 */
@@ -2235,8 +2244,9 @@ void cpu_init_exception_handling(void)
 	/* paranoid_entry() gets the CPU number from the GDT */
 	setup_getcpu(cpu);
 
-	/* IST vectors need TSS to be set up. */
-	tss_setup_ist(tss);
+	/* For IDT mode, IST vectors need to be set in TSS. */
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		tss_setup_ist(tss);
 	tss_setup_io_bitmap(tss);
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
@@ -2245,8 +2255,10 @@ void cpu_init_exception_handling(void)
 	/* GHCB needs to be setup to handle #VC. */
 	setup_ghcb();
 
-	/* Finally load the IDT */
-	load_current_idt();
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		cpu_init_fred_exceptions();
+	else
+		load_current_idt();
 }
 
 /*
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index c683666876f1..f79c5edc0b89 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/i8259.h>
 #include <asm/traps.h>
+#include <asm/fred.h>
 #include <asm/prom.h>
 
 /*
@@ -96,7 +97,11 @@ void __init native_init_IRQ(void)
 	/* Execute any quirks before the call gates are initialised: */
 	x86_init.irqs.pre_vector_init();
 
-	idt_setup_apic_and_irq_gates();
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		fred_complete_exception_setup();
+	else
+		idt_setup_apic_and_irq_gates();
+
 	lapic_assign_system_vectors();
 
 	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs()) {
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 848c85208a57..0ee78a30e14a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1411,7 +1411,10 @@ void __init trap_init(void)
 
 	/* Initialize TSS before setting up traps so ISTs work */
 	cpu_init_exception_handling();
+
 	/* Setup traps as cpu_init() might #GP */
-	idt_setup_traps();
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		idt_setup_traps();
+
 	cpu_init();
 }
-- 
2.34.1


