Return-Path: <linux-hyperv+bounces-7197-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7028FBD1949
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 08:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 869A54EC005
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5AD2848A1;
	Mon, 13 Oct 2025 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l4ugxxpF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD719D071;
	Mon, 13 Oct 2025 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335467; cv=none; b=LAlTrcYIICQzc8ZZ0maOolGToKNUU0Ud5gdrTRYjZuEdgLUnsvJ/9qCxn0LzYj+GOvrztdIQEvPMu446KJW1cEd/EVIbP6tmds0XJpn8s3rsqjbOzF+Q9UI5+eaqDvJ0WgEi5AGhT+5mMqBWRNnQ/IKUN1IXI9OommTWnWC3WQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335467; c=relaxed/simple;
	bh=W82Q5a6sRoBe8LZOJkNe7m5C+FohuTvoXFobLnVxmrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIfaw3MpkITfrJYQV76cX+5zyIO01n8Q9hDukZpIpjZFLGdf12VqWRaC6Sw8VW1Fp13RA1Ol1d69VDMMXYC9InZiEqXf7FzRAIpugpogjRv+FxeDXucRuPSh+Wul13gQ04sAq1Eqyw8tJDkTEK+l/Jm7Cy0zuHi44sPhlowg1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l4ugxxpF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-1AYIP.redmond.corp.microsoft.com (unknown [4.213.232.47])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8B9D6211CF9A;
	Sun, 12 Oct 2025 23:04:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B9D6211CF9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760335459;
	bh=fjwtgmRBnbYP+7Xe15y5eqmoXe6pFfZOphxnvlGIuGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4ugxxpFQyWlza3rPPvpdhzfvE+PAfklBi7K1bA1E4PxeceBI/rptgWR+Tkoddxpl
	 YEnY3hFhHvS1hKxGO5U7bKvGT7tAq0IwXkKNqFBQYIGSon2HJS6+WIBS6v0/Ia0l/1
	 g9SwPF3W+2IXmpRqNlFqI7ij9v0ixO1YD+3+ARkA=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: [PATCH v8 2/2] Drivers: hv: Introduce mshv_vtl driver
Date: Mon, 13 Oct 2025 06:03:53 +0000
Message-ID: <20251013060353.67326-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013060353.67326-1-namjain@linux.microsoft.com>
References: <20251013060353.67326-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide an interface for Virtual Machine Monitor like OpenVMM and its
use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
Expose devices and support IOCTLs for features like VTL creation,
VTL0 memory management, context switch, making hypercalls,
mapping VTL0 address space to VTL2 userspace, getting new VMBus
messages and channel events in VTL2 etc.

Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/hyperv/Makefile           |   10 +-
 arch/x86/hyperv/hv_vtl.c           |   37 +
 arch/x86/hyperv/mshv-asm-offsets.c |   37 +
 arch/x86/hyperv/mshv_vtl_asm.S     |   95 ++
 arch/x86/include/asm/mshyperv.h    |   32 +
 drivers/hv/Kconfig                 |   26 +-
 drivers/hv/Makefile                |    7 +-
 drivers/hv/mshv_vtl.h              |   25 +
 drivers/hv/mshv_vtl_main.c         | 1393 ++++++++++++++++++++++++++++
 include/hyperv/hvgdk_mini.h        |  106 +++
 include/uapi/linux/mshv.h          |   80 ++
 11 files changed, 1845 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/hyperv/mshv-asm-offsets.c
 create mode 100644 arch/x86/hyperv/mshv_vtl_asm.S
 create mode 100644 drivers/hv/mshv_vtl.h
 create mode 100644 drivers/hv/mshv_vtl_main.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index d55f494f471d..aff2303c40e3 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,8 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y			:= hv_init.o mmu.o nested.o irqdomain.o ivm.o
 obj-$(CONFIG_X86_64)	+= hv_apic.o
-obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
+obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o mshv_vtl_asm.o
+
+$(obj)/mshv_vtl_asm.o: $(obj)/mshv-asm-offsets.h
+
+$(obj)/mshv-asm-offsets.h: $(obj)/mshv-asm-offsets.s FORCE
+	$(call filechk,offsets,__MSHV_ASM_OFFSETS_H__)
 
 ifdef CONFIG_X86_64
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
 endif
+
+targets += mshv-asm-offsets.s
+clean-files += mshv-asm-offsets.h
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 042e8712d8de..636e9253b81e 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -9,12 +9,16 @@
 #include <asm/apic.h>
 #include <asm/boot.h>
 #include <asm/desc.h>
+#include <asm/fpu/api.h>
+#include <asm/fpu/types.h>
 #include <asm/i8259.h>
 #include <asm/mshyperv.h>
 #include <asm/msr.h>
 #include <asm/realmode.h>
 #include <asm/reboot.h>
+#include <asm/smap.h>
 #include <../kernel/smpboot.h>
+#include "../../kernel/fpu/legacy.h"
 
 extern struct boot_params boot_params;
 static struct real_mode_header hv_vtl_real_mode_header;
@@ -249,3 +253,36 @@ int __init hv_vtl_early_init(void)
 
 	return 0;
 }
+
+DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
+
+noinstr void mshv_vtl_return_hypercall(void)
+{
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall) :
+		      ASM_CALL_CONSTRAINT);
+}
+
+extern void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
+
+void mshv_vtl_return_call_init(u64 vtl_return_offset)
+{
+	static_call_update(__mshv_vtl_return_hypercall,
+			   (void *)((u8 *)hv_hypercall_pg + vtl_return_offset));
+}
+EXPORT_SYMBOL(mshv_vtl_return_call_init);
+
+void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
+{
+	struct hv_vp_assist_page *hvp;
+
+	hvp = hv_vp_assist_page[smp_processor_id()];
+	hvp->vtl_ret_x64rax = vtl0->rax;
+	hvp->vtl_ret_x64rcx = vtl0->rcx;
+
+	kernel_fpu_begin_mask(0);
+	fxrstor(&vtl0->fx_state);
+	__mshv_vtl_return_call(vtl0);
+	fxsave(&vtl0->fx_state);
+	kernel_fpu_end();
+}
+EXPORT_SYMBOL(mshv_vtl_return_call);
diff --git a/arch/x86/hyperv/mshv-asm-offsets.c b/arch/x86/hyperv/mshv-asm-offsets.c
new file mode 100644
index 000000000000..882c1db6df16
--- /dev/null
+++ b/arch/x86/hyperv/mshv-asm-offsets.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed to extract
+ * and format the required data.
+ *
+ * Copyright (c) 2025, Microsoft Corporation.
+ *
+ * Author:
+ *   Naman Jain <namjain@microsoft.com>
+ */
+#define COMPILE_OFFSETS
+
+#include <linux/kbuild.h>
+#include <asm/mshyperv.h>
+
+static void __used common(void)
+{
+	if (IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
+		OFFSET(MSHV_VTL_CPU_CONTEXT_rax, mshv_vtl_cpu_context, rax);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_rcx, mshv_vtl_cpu_context, rcx);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_rdx, mshv_vtl_cpu_context, rdx);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_rbx, mshv_vtl_cpu_context, rbx);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_rbp, mshv_vtl_cpu_context, rbp);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_rsi, mshv_vtl_cpu_context, rsi);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_rdi, mshv_vtl_cpu_context, rdi);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_r8,  mshv_vtl_cpu_context, r8);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_r9,  mshv_vtl_cpu_context, r9);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_r10, mshv_vtl_cpu_context, r10);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_r11, mshv_vtl_cpu_context, r11);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_r12, mshv_vtl_cpu_context, r12);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_r13, mshv_vtl_cpu_context, r13);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_r14, mshv_vtl_cpu_context, r14);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_r15, mshv_vtl_cpu_context, r15);
+		OFFSET(MSHV_VTL_CPU_CONTEXT_cr2, mshv_vtl_cpu_context, cr2);
+	}
+}
diff --git a/arch/x86/hyperv/mshv_vtl_asm.S b/arch/x86/hyperv/mshv_vtl_asm.S
new file mode 100644
index 000000000000..4085073a5876
--- /dev/null
+++ b/arch/x86/hyperv/mshv_vtl_asm.S
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Assembly level code for mshv_vtl VTL transition
+ *
+ * Copyright (c) 2025, Microsoft Corporation.
+ *
+ * Author:
+ *   Naman Jain <namjain@microsoft.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/frame.h>
+#include "mshv-asm-offsets.h"
+
+	.text
+	.section .noinstr.text, "ax"
+/*
+ * void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
+ */
+SYM_FUNC_START(__mshv_vtl_return_call)
+	/* Push callee save registers */
+	pushq %rbp
+	mov %rsp, %rbp
+	pushq %r12
+	pushq %r13
+	pushq %r14
+	pushq %r15
+	pushq %rbx
+
+	/* register switch to VTL0 clobbers all registers except rax/rcx */
+	mov %_ASM_ARG1, %rax
+
+	/* grab rbx/rbp/rsi/rdi/r8-r15 */
+	mov MSHV_VTL_CPU_CONTEXT_rbx(%rax), %rbx
+	mov MSHV_VTL_CPU_CONTEXT_rbp(%rax), %rbp
+	mov MSHV_VTL_CPU_CONTEXT_rsi(%rax), %rsi
+	mov MSHV_VTL_CPU_CONTEXT_rdi(%rax), %rdi
+	mov MSHV_VTL_CPU_CONTEXT_r8(%rax), %r8
+	mov MSHV_VTL_CPU_CONTEXT_r9(%rax), %r9
+	mov MSHV_VTL_CPU_CONTEXT_r10(%rax), %r10
+	mov MSHV_VTL_CPU_CONTEXT_r11(%rax), %r11
+	mov MSHV_VTL_CPU_CONTEXT_r12(%rax), %r12
+	mov MSHV_VTL_CPU_CONTEXT_r13(%rax), %r13
+	mov MSHV_VTL_CPU_CONTEXT_r14(%rax), %r14
+	mov MSHV_VTL_CPU_CONTEXT_r15(%rax), %r15
+
+	mov MSHV_VTL_CPU_CONTEXT_cr2(%rax), %rdx
+	mov %rdx, %cr2
+	mov MSHV_VTL_CPU_CONTEXT_rdx(%rax), %rdx
+
+	/* stash host registers on stack */
+	pushq %rax
+	pushq %rcx
+
+	xor %ecx, %ecx
+
+	/* make a hypercall to switch VTL */
+	call mshv_vtl_return_hypercall
+
+	/* stash guest registers on stack, restore saved host copies */
+	pushq %rax
+	pushq %rcx
+	mov 16(%rsp), %rcx
+	mov 24(%rsp), %rax
+
+	pop MSHV_VTL_CPU_CONTEXT_rcx(%rax)
+	pop MSHV_VTL_CPU_CONTEXT_rax(%rax)
+	add $16, %rsp
+
+	/* save rbx/rbp/rsi/rdi/r8-r15 */
+	mov %rbx, MSHV_VTL_CPU_CONTEXT_rbx(%rax)
+	mov %rbp, MSHV_VTL_CPU_CONTEXT_rbp(%rax)
+	mov %rsi, MSHV_VTL_CPU_CONTEXT_rsi(%rax)
+	mov %rdi, MSHV_VTL_CPU_CONTEXT_rdi(%rax)
+	mov %r8,  MSHV_VTL_CPU_CONTEXT_r8(%rax)
+	mov %r9,  MSHV_VTL_CPU_CONTEXT_r9(%rax)
+	mov %r10, MSHV_VTL_CPU_CONTEXT_r10(%rax)
+	mov %r11, MSHV_VTL_CPU_CONTEXT_r11(%rax)
+	mov %r12, MSHV_VTL_CPU_CONTEXT_r12(%rax)
+	mov %r13, MSHV_VTL_CPU_CONTEXT_r13(%rax)
+	mov %r14, MSHV_VTL_CPU_CONTEXT_r14(%rax)
+	mov %r15, MSHV_VTL_CPU_CONTEXT_r15(%rax)
+
+	/* pop callee-save registers r12-r15, rbx */
+	pop %rbx
+	pop %r15
+	pop %r14
+	pop %r13
+	pop %r12
+
+	pop %rbp
+	RET
+SYM_FUNC_END(__mshv_vtl_return_call)
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 605abd02158d..254974ccd98c 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -11,6 +11,7 @@
 #include <asm/paravirt.h>
 #include <asm/msr.h>
 #include <hyperv/hvhdk.h>
+#include <asm/fpu/types.h>
 
 /*
  * Hyper-V always provides a single IO-APIC at this MMIO address.
@@ -260,13 +261,44 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
 static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
 #endif /* CONFIG_HYPERV */
 
+struct mshv_vtl_cpu_context {
+	union {
+		struct {
+			u64 rax;
+			u64 rcx;
+			u64 rdx;
+			u64 rbx;
+			u64 cr2;
+			u64 rbp;
+			u64 rsi;
+			u64 rdi;
+			u64 r8;
+			u64 r9;
+			u64 r10;
+			u64 r11;
+			u64 r12;
+			u64 r13;
+			u64 r14;
+			u64 r15;
+		};
+		u64 gp_regs[16];
+	};
+
+	struct fxregs_state fx_state;
+};
 
 #ifdef CONFIG_HYPERV_VTL_MODE
 void __init hv_vtl_init_platform(void);
 int __init hv_vtl_early_init(void);
+void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
+void mshv_vtl_return_call_init(u64 vtl_return_offset);
+void mshv_vtl_return_hypercall(void);
 #else
 static inline void __init hv_vtl_init_platform(void) {}
 static inline int __init hv_vtl_early_init(void) { return 0; }
+static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
+static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
+static inline void mshv_vtl_return_hypercall(void) {}
 #endif
 
 #include <asm-generic/mshyperv.h>
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0b8c391a0342..cca2ae463128 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -17,7 +17,8 @@ config HYPERV
 
 config HYPERV_VTL_MODE
 	bool "Enable Linux to boot in VTL context"
-	depends on (X86_64 || ARM64) && HYPERV
+	depends on (X86_64 && HAVE_STATIC_CALL) || ARM64
+	depends on HYPERV
 	depends on SMP
 	default n
 	help
@@ -82,4 +83,27 @@ config MSHV_ROOT
 
 	  If unsure, say N.
 
+config MSHV_VTL
+	tristate "Microsoft Hyper-V VTL driver"
+	depends on X86_64 && HYPERV_VTL_MODE
+	# Mapping VTL0 memory to a userspace process in VTL2 is supported in OpenHCL.
+	# VTL2 for OpenHCL makes use of Huge Pages to improve performance on VMs,
+	# specially with large memory requirements.
+	depends on TRANSPARENT_HUGEPAGE
+	# MTRRs are controlled by VTL0, and are not specific to individual VTLs.
+	# Therefore, do not attempt to access or modify MTRRs here.
+	depends on !MTRR
+	select CPUMASK_OFFSTACK
+	select VIRT_XFER_TO_GUEST_WORK
+	default n
+	help
+	  Select this option to enable Hyper-V VTL driver support.
+	  This driver provides interfaces for Virtual Machine Manager (VMM) running in VTL2
+	  userspace to create VTLs and partitions, setup and manage VTL0 memory and
+	  allow userspace to make direct hypercalls. This also allows to map VTL0's address
+	  space to a usermode process in VTL2 and supports getting new VMBus messages and channel
+	  events in VTL2.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 1a1677bf4dac..58b8d07639f3 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_HYPERV_VMBUS)	+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
 obj-$(CONFIG_MSHV_ROOT)		+= mshv_root.o
+obj-$(CONFIG_MSHV_VTL)          += mshv_vtl.o
 
 CFLAGS_hv_trace.o = -I$(src)
 CFLAGS_hv_balloon.o = -I$(src)
@@ -14,7 +15,11 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
 	       mshv_root_hv_call.o mshv_portid_table.o
+mshv_vtl-y := mshv_vtl_main.o
 
 # Code that must be built-in
 obj-$(CONFIG_HYPERV) += hv_common.o
-obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o mshv_common.o
+obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
+ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
+	obj-y += mshv_common.o
+endif
diff --git a/drivers/hv/mshv_vtl.h b/drivers/hv/mshv_vtl.h
new file mode 100644
index 000000000000..a6eea52f7aa2
--- /dev/null
+++ b/drivers/hv/mshv_vtl.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _MSHV_VTL_H
+#define _MSHV_VTL_H
+
+#include <linux/mshv.h>
+#include <linux/types.h>
+
+struct mshv_vtl_run {
+	u32 cancel;
+	u32 vtl_ret_action_size;
+	u32 pad[2];
+	char exit_message[MSHV_MAX_RUN_MSG_SIZE];
+	union {
+		struct mshv_vtl_cpu_context cpu_context;
+
+		/*
+		 * Reserving room for the cpu context to grow and to maintain compatibility
+		 * with user mode.
+		 */
+		char reserved[1024];
+	};
+	char vtl_ret_actions[MSHV_MAX_RUN_MSG_SIZE];
+};
+
+#endif /* _MSHV_VTL_H */
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
new file mode 100644
index 000000000000..f486e7fa61e3
--- /dev/null
+++ b/drivers/hv/mshv_vtl_main.c
@@ -0,0 +1,1393 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * Author:
+ *   Roman Kisel <romank@linux.microsoft.com>
+ *   Saurabh Sengar <ssengar@linux.microsoft.com>
+ *   Naman Jain <namjain@linux.microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/anon_inodes.h>
+#include <linux/cpuhotplug.h>
+#include <linux/count_zeros.h>
+#include <linux/entry-virt.h>
+#include <linux/eventfd.h>
+#include <linux/poll.h>
+#include <linux/file.h>
+#include <linux/vmalloc.h>
+#include <asm/debugreg.h>
+#include <asm/mshyperv.h>
+#include <trace/events/ipi.h>
+#include <uapi/asm/mtrr.h>
+#include <uapi/linux/mshv.h>
+#include <hyperv/hvhdk.h>
+
+#include "../../kernel/fpu/legacy.h"
+#include "mshv.h"
+#include "mshv_vtl.h"
+#include "hyperv_vmbus.h"
+
+MODULE_AUTHOR("Microsoft");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Microsoft Hyper-V VTL Driver");
+
+#define MSHV_ENTRY_REASON_LOWER_VTL_CALL     0x1
+#define MSHV_ENTRY_REASON_INTERRUPT          0x2
+#define MSHV_ENTRY_REASON_INTERCEPT          0x3
+
+#define MSHV_REAL_OFF_SHIFT	16
+#define MSHV_PG_OFF_CPU_MASK	(BIT_ULL(MSHV_REAL_OFF_SHIFT) - 1)
+#define MSHV_RUN_PAGE_OFFSET	0
+#define MSHV_REG_PAGE_OFFSET	1
+#define VTL2_VMBUS_SINT_INDEX	7
+
+static struct device *mem_dev;
+
+static struct tasklet_struct msg_dpc;
+static wait_queue_head_t fd_wait_queue;
+static bool has_message;
+static struct eventfd_ctx *flag_eventfds[HV_EVENT_FLAGS_COUNT];
+static DEFINE_MUTEX(flag_lock);
+static bool __read_mostly mshv_has_reg_page;
+
+/* hvcall code is of type u16, allocate a bitmap of size (1 << 16) to accommodate it */
+#define MAX_BITMAP_SIZE ((U16_MAX + 1) / 8)
+
+struct mshv_vtl_hvcall_fd {
+	u8 allow_bitmap[MAX_BITMAP_SIZE];
+	bool allow_map_initialized;
+	/*
+	 * Used to protect hvcall setup in IOCTLs
+	 */
+	struct mutex init_mutex;
+	struct miscdevice *dev;
+};
+
+struct mshv_vtl_poll_file {
+	struct file *file;
+	wait_queue_entry_t wait;
+	wait_queue_head_t *wqh;
+	poll_table pt;
+	int cpu;
+};
+
+struct mshv_vtl {
+	struct device *module_dev;
+	u64 id;
+};
+
+struct mshv_vtl_per_cpu {
+	struct mshv_vtl_run *run;
+	struct page *reg_page;
+};
+
+/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
+union hv_synic_overlay_page_msr {
+	u64 as_uint64;
+	struct {
+		u64 enabled: 1;
+		u64 reserved: 11;
+		u64 pfn: 52;
+	} __packed;
+};
+
+static struct mutex mshv_vtl_poll_file_lock;
+static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
+static union hv_register_vsm_capabilities mshv_vsm_capabilities;
+
+static DEFINE_PER_CPU(struct mshv_vtl_poll_file, mshv_vtl_poll_file);
+static DEFINE_PER_CPU(unsigned long long, num_vtl0_transitions);
+static DEFINE_PER_CPU(struct mshv_vtl_per_cpu, mshv_vtl_per_cpu);
+
+static const union hv_input_vtl input_vtl_zero;
+static const union hv_input_vtl input_vtl_normal = {
+	.use_target_vtl = 1,
+};
+
+static const struct file_operations mshv_vtl_fops;
+
+static long
+mshv_ioctl_create_vtl(void __user *user_arg, struct device *module_dev)
+{
+	struct mshv_vtl *vtl;
+	struct file *file;
+	int fd;
+
+	vtl = kzalloc(sizeof(*vtl), GFP_KERNEL);
+	if (!vtl)
+		return -ENOMEM;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		kfree(vtl);
+		return fd;
+	}
+	file = anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
+				  vtl, O_RDWR);
+	if (IS_ERR(file)) {
+		kfree(vtl);
+		return PTR_ERR(file);
+	}
+	vtl->module_dev = module_dev;
+	fd_install(fd, file);
+
+	return fd;
+}
+
+static long
+mshv_ioctl_check_extension(void __user *user_arg)
+{
+	u32 arg;
+
+	if (copy_from_user(&arg, user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	switch (arg) {
+	case MSHV_CAP_CORE_API_STABLE:
+		return 0;
+	case MSHV_CAP_REGISTER_PAGE:
+		return mshv_has_reg_page;
+	case MSHV_CAP_VTL_RETURN_ACTION:
+		return mshv_vsm_capabilities.return_action_available;
+	case MSHV_CAP_DR6_SHARED:
+		return mshv_vsm_capabilities.dr6_shared;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static long
+mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	struct miscdevice *misc = filp->private_data;
+
+	switch (ioctl) {
+	case MSHV_CHECK_EXTENSION:
+		return mshv_ioctl_check_extension((void __user *)arg);
+	case MSHV_CREATE_VTL:
+		return mshv_ioctl_create_vtl((void __user *)arg, misc->this_device);
+	}
+
+	return -ENOTTY;
+}
+
+static const struct file_operations mshv_dev_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= mshv_dev_ioctl,
+	.llseek		= noop_llseek,
+};
+
+static struct miscdevice mshv_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "mshv",
+	.fops = &mshv_dev_fops,
+	.mode = 0600,
+};
+
+static struct mshv_vtl_run *mshv_vtl_this_run(void)
+{
+	return *this_cpu_ptr(&mshv_vtl_per_cpu.run);
+}
+
+static struct mshv_vtl_run *mshv_vtl_cpu_run(int cpu)
+{
+	return *per_cpu_ptr(&mshv_vtl_per_cpu.run, cpu);
+}
+
+static struct page *mshv_vtl_cpu_reg_page(int cpu)
+{
+	return *per_cpu_ptr(&mshv_vtl_per_cpu.reg_page, cpu);
+}
+
+static void mshv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
+{
+	struct hv_register_assoc reg_assoc = {};
+	union hv_synic_overlay_page_msr overlay = {};
+	struct page *reg_page;
+
+	reg_page = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
+	if (!reg_page) {
+		WARN(1, "failed to allocate register page\n");
+		return;
+	}
+
+	overlay.enabled = 1;
+	overlay.pfn = page_to_hvpfn(reg_page);
+	reg_assoc.name = HV_X64_REGISTER_REG_PAGE;
+	reg_assoc.value.reg64 = overlay.as_uint64;
+
+	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+				     1, input_vtl_zero, &reg_assoc)) {
+		WARN(1, "failed to setup register page\n");
+		__free_page(reg_page);
+		return;
+	}
+
+	per_cpu->reg_page = reg_page;
+	mshv_has_reg_page = true;
+}
+
+static void mshv_vtl_synic_enable_regs(unsigned int cpu)
+{
+	union hv_synic_sint sint;
+
+	sint.as_uint64 = 0;
+	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.masked = false;
+	sint.auto_eoi = hv_recommend_using_aeoi();
+
+	/* Enable intercepts */
+	if (!mshv_vsm_capabilities.intercept_page_available)
+		hv_set_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
+			   sint.as_uint64);
+
+	/* VTL2 Host VSP SINT is (un)masked when the user mode requests that */
+}
+
+static int mshv_vtl_get_vsm_regs(void)
+{
+	struct hv_register_assoc registers[2];
+	int ret, count = 2;
+
+	registers[0].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
+	registers[1].name = HV_REGISTER_VSM_CAPABILITIES;
+
+	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+				       count, input_vtl_zero, registers);
+	if (ret)
+		return ret;
+
+	mshv_vsm_page_offsets.as_uint64 = registers[0].value.reg64;
+	mshv_vsm_capabilities.as_uint64 = registers[1].value.reg64;
+
+	return ret;
+}
+
+static int mshv_vtl_configure_vsm_partition(struct device *dev)
+{
+	union hv_register_vsm_partition_config config;
+	struct hv_register_assoc reg_assoc;
+
+	config.as_uint64 = 0;
+	config.default_vtl_protection_mask = HV_MAP_GPA_PERMISSIONS_MASK;
+	config.enable_vtl_protection = 1;
+	config.zero_memory_on_reset = 1;
+	config.intercept_vp_startup = 1;
+	config.intercept_cpuid_unimplemented = 1;
+
+	if (mshv_vsm_capabilities.intercept_page_available) {
+		dev_dbg(dev, "using intercept page\n");
+		config.intercept_page = 1;
+	}
+
+	reg_assoc.name = HV_REGISTER_VSM_PARTITION_CONFIG;
+	reg_assoc.value.reg64 = config.as_uint64;
+
+	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+				       1, input_vtl_zero, &reg_assoc);
+}
+
+static void mshv_vtl_vmbus_isr(void)
+{
+	struct hv_per_cpu_context *per_cpu;
+	struct hv_message *msg;
+	u32 message_type;
+	union hv_synic_event_flags *event_flags;
+	struct eventfd_ctx *eventfd;
+	u16 i;
+
+	per_cpu = this_cpu_ptr(hv_context.cpu_context);
+	if (smp_processor_id() == 0) {
+		msg = (struct hv_message *)per_cpu->synic_message_page + VTL2_VMBUS_SINT_INDEX;
+		message_type = READ_ONCE(msg->header.message_type);
+		if (message_type != HVMSG_NONE)
+			tasklet_schedule(&msg_dpc);
+	}
+
+	event_flags = (union hv_synic_event_flags *)per_cpu->synic_event_page +
+			VTL2_VMBUS_SINT_INDEX;
+	for_each_set_bit(i, event_flags->flags, HV_EVENT_FLAGS_COUNT) {
+		if (!sync_test_and_clear_bit(i, event_flags->flags))
+			continue;
+		rcu_read_lock();
+		eventfd = READ_ONCE(flag_eventfds[i]);
+		if (eventfd)
+			eventfd_signal(eventfd);
+		rcu_read_unlock();
+	}
+
+	vmbus_isr();
+}
+
+static int mshv_vtl_alloc_context(unsigned int cpu)
+{
+	struct mshv_vtl_per_cpu *per_cpu = this_cpu_ptr(&mshv_vtl_per_cpu);
+
+	per_cpu->run = (struct mshv_vtl_run *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	if (!per_cpu->run)
+		return -ENOMEM;
+
+	if (mshv_vsm_capabilities.intercept_page_available)
+		mshv_vtl_configure_reg_page(per_cpu);
+
+	mshv_vtl_synic_enable_regs(cpu);
+
+	return 0;
+}
+
+static int mshv_vtl_cpuhp_online;
+
+static int hv_vtl_setup_synic(void)
+{
+	int ret;
+
+	/* Use our isr to first filter out packets destined for userspace */
+	hv_setup_vmbus_handler(mshv_vtl_vmbus_isr);
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vtl:online",
+				mshv_vtl_alloc_context, NULL);
+	if (ret < 0) {
+		hv_setup_vmbus_handler(vmbus_isr);
+		return ret;
+	}
+
+	mshv_vtl_cpuhp_online = ret;
+
+	return 0;
+}
+
+static void hv_vtl_remove_synic(void)
+{
+	cpuhp_remove_state(mshv_vtl_cpuhp_online);
+	hv_setup_vmbus_handler(vmbus_isr);
+}
+
+static int vtl_get_vp_register(struct hv_register_assoc *reg)
+{
+	return hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+					1, input_vtl_normal, reg);
+}
+
+static int vtl_set_vp_register(struct hv_register_assoc *reg)
+{
+	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+					1, input_vtl_normal, reg);
+}
+
+static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
+{
+	struct mshv_vtl_ram_disposition vtl0_mem;
+	struct dev_pagemap *pgmap;
+	void *addr;
+
+	if (copy_from_user(&vtl0_mem, arg, sizeof(vtl0_mem)))
+		return -EFAULT;
+	/* vtl0_mem.last_pfn is excluded in the pagemap range for VTL0 as per design */
+	if (vtl0_mem.last_pfn <= vtl0_mem.start_pfn) {
+		dev_err(vtl->module_dev, "range start pfn (%llx) > end pfn (%llx)\n",
+			vtl0_mem.start_pfn, vtl0_mem.last_pfn);
+		return -EFAULT;
+	}
+
+	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
+	if (!pgmap)
+		return -ENOMEM;
+
+	pgmap->ranges[0].start = PFN_PHYS(vtl0_mem.start_pfn);
+	pgmap->ranges[0].end = PFN_PHYS(vtl0_mem.last_pfn) - 1;
+	pgmap->nr_range = 1;
+	pgmap->type = MEMORY_DEVICE_GENERIC;
+
+	/*
+	 * Determine the highest page order that can be used for the given memory range.
+	 * This works best when the range is aligned; i.e. both the start and the length.
+	 */
+	pgmap->vmemmap_shift = count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn);
+	dev_dbg(vtl->module_dev,
+		"Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: %lu\n",
+		vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
+
+	addr = devm_memremap_pages(mem_dev, pgmap);
+	if (IS_ERR(addr)) {
+		dev_err(vtl->module_dev, "devm_memremap_pages error: %ld\n", PTR_ERR(addr));
+		kfree(pgmap);
+		return -EFAULT;
+	}
+
+	/* Don't free pgmap, since it has to stick around until the memory
+	 * is unmapped, which will never happen as there is no scenario
+	 * where VTL0 can be released/shutdown without bringing down VTL2.
+	 */
+	return 0;
+}
+
+static void mshv_vtl_cancel(int cpu)
+{
+	int here = get_cpu();
+
+	if (here != cpu) {
+		if (!xchg_relaxed(&mshv_vtl_cpu_run(cpu)->cancel, 1))
+			smp_send_reschedule(cpu);
+	} else {
+		WRITE_ONCE(mshv_vtl_this_run()->cancel, 1);
+	}
+	put_cpu();
+}
+
+static int mshv_vtl_poll_file_wake(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
+{
+	struct mshv_vtl_poll_file *poll_file = container_of(wait, struct mshv_vtl_poll_file, wait);
+
+	mshv_vtl_cancel(poll_file->cpu);
+
+	return 0;
+}
+
+static void mshv_vtl_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
+{
+	struct mshv_vtl_poll_file *poll_file = container_of(pt, struct mshv_vtl_poll_file, pt);
+
+	WARN_ON(poll_file->wqh);
+	poll_file->wqh = wqh;
+	add_wait_queue(wqh, &poll_file->wait);
+}
+
+static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __user *user_input)
+{
+	struct file *file, *old_file;
+	struct mshv_vtl_poll_file *poll_file;
+	struct mshv_vtl_set_poll_file input;
+
+	if (copy_from_user(&input, user_input, sizeof(input)))
+		return -EFAULT;
+
+	if (input.cpu >= num_possible_cpus() || !cpu_online(input.cpu))
+		return -EINVAL;
+	/*
+	 * CPU Hotplug is not supported in VTL2 in OpenHCL, where this kernel driver exists.
+	 * CPU is expected to remain online after above cpu_online() check.
+	 */
+
+	file = NULL;
+	file = fget(input.fd);
+	if (!file)
+		return -EBADFD;
+
+	poll_file = per_cpu_ptr(&mshv_vtl_poll_file, READ_ONCE(input.cpu));
+	if (!poll_file)
+		return -EINVAL;
+
+	mutex_lock(&mshv_vtl_poll_file_lock);
+
+	if (poll_file->wqh)
+		remove_wait_queue(poll_file->wqh, &poll_file->wait);
+	poll_file->wqh = NULL;
+
+	old_file = poll_file->file;
+	poll_file->file = file;
+	poll_file->cpu = input.cpu;
+
+	if (file) {
+		init_waitqueue_func_entry(&poll_file->wait, mshv_vtl_poll_file_wake);
+		init_poll_funcptr(&poll_file->pt, mshv_vtl_ptable_queue_proc);
+		vfs_poll(file, &poll_file->pt);
+	}
+
+	mutex_unlock(&mshv_vtl_poll_file_lock);
+
+	if (old_file)
+		fput(old_file);
+
+	return 0;
+}
+
+/* Static table mapping register names to their corresponding actions */
+static const struct {
+	enum hv_register_name reg_name;
+	int debug_reg_num;  /* -1 if not a debug register */
+	u32 msr_addr;       /* 0 if not an MSR */
+} reg_table[] = {
+	/* Debug registers */
+	{HV_X64_REGISTER_DR0, 0, 0},
+	{HV_X64_REGISTER_DR1, 1, 0},
+	{HV_X64_REGISTER_DR2, 2, 0},
+	{HV_X64_REGISTER_DR3, 3, 0},
+	{HV_X64_REGISTER_DR6, 6, 0},
+	/* MTRR MSRs */
+	{HV_X64_REGISTER_MSR_MTRR_CAP, -1, MSR_MTRRcap},
+	{HV_X64_REGISTER_MSR_MTRR_DEF_TYPE, -1, MSR_MTRRdefType},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0, -1, MTRRphysBase_MSR(0)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1, -1, MTRRphysBase_MSR(1)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2, -1, MTRRphysBase_MSR(2)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3, -1, MTRRphysBase_MSR(3)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4, -1, MTRRphysBase_MSR(4)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5, -1, MTRRphysBase_MSR(5)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6, -1, MTRRphysBase_MSR(6)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7, -1, MTRRphysBase_MSR(7)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8, -1, MTRRphysBase_MSR(8)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9, -1, MTRRphysBase_MSR(9)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA, -1, MTRRphysBase_MSR(0xa)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB, -1, MTRRphysBase_MSR(0xb)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC, -1, MTRRphysBase_MSR(0xc)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASED, -1, MTRRphysBase_MSR(0xd)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE, -1, MTRRphysBase_MSR(0xe)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF, -1, MTRRphysBase_MSR(0xf)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0, -1, MTRRphysMask_MSR(0)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1, -1, MTRRphysMask_MSR(1)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2, -1, MTRRphysMask_MSR(2)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3, -1, MTRRphysMask_MSR(3)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4, -1, MTRRphysMask_MSR(4)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5, -1, MTRRphysMask_MSR(5)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6, -1, MTRRphysMask_MSR(6)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7, -1, MTRRphysMask_MSR(7)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8, -1, MTRRphysMask_MSR(8)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9, -1, MTRRphysMask_MSR(9)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA, -1, MTRRphysMask_MSR(0xa)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB, -1, MTRRphysMask_MSR(0xb)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC, -1, MTRRphysMask_MSR(0xc)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD, -1, MTRRphysMask_MSR(0xd)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE, -1, MTRRphysMask_MSR(0xe)},
+	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF, -1, MTRRphysMask_MSR(0xf)},
+	{HV_X64_REGISTER_MSR_MTRR_FIX64K00000, -1, MSR_MTRRfix64K_00000},
+	{HV_X64_REGISTER_MSR_MTRR_FIX16K80000, -1, MSR_MTRRfix16K_80000},
+	{HV_X64_REGISTER_MSR_MTRR_FIX16KA0000, -1, MSR_MTRRfix16K_A0000},
+	{HV_X64_REGISTER_MSR_MTRR_FIX4KC0000, -1, MSR_MTRRfix4K_C0000},
+	{HV_X64_REGISTER_MSR_MTRR_FIX4KC8000, -1, MSR_MTRRfix4K_C8000},
+	{HV_X64_REGISTER_MSR_MTRR_FIX4KD0000, -1, MSR_MTRRfix4K_D0000},
+	{HV_X64_REGISTER_MSR_MTRR_FIX4KD8000, -1, MSR_MTRRfix4K_D8000},
+	{HV_X64_REGISTER_MSR_MTRR_FIX4KE0000, -1, MSR_MTRRfix4K_E0000},
+	{HV_X64_REGISTER_MSR_MTRR_FIX4KE8000, -1, MSR_MTRRfix4K_E8000},
+	{HV_X64_REGISTER_MSR_MTRR_FIX4KF0000, -1, MSR_MTRRfix4K_F0000},
+	{HV_X64_REGISTER_MSR_MTRR_FIX4KF8000, -1, MSR_MTRRfix4K_F8000},
+};
+
+static int mshv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set)
+{
+	u64 *reg64;
+	enum hv_register_name gpr_name;
+	int i;
+
+	gpr_name = regs->name;
+	reg64 = &regs->value.reg64;
+
+	/* Search for the register in the table */
+	for (i = 0; i < ARRAY_SIZE(reg_table); i++) {
+		if (reg_table[i].reg_name != gpr_name)
+			continue;
+		if (reg_table[i].debug_reg_num != -1) {
+			/* Handle debug registers */
+			if (gpr_name == HV_X64_REGISTER_DR6 &&
+			    !mshv_vsm_capabilities.dr6_shared)
+				goto hypercall;
+			if (set)
+				native_set_debugreg(reg_table[i].debug_reg_num, *reg64);
+			else
+				*reg64 = native_get_debugreg(reg_table[i].debug_reg_num);
+		} else {
+			/* Handle MSRs */
+			if (set)
+				wrmsrl(reg_table[i].msr_addr, *reg64);
+			else
+				rdmsrl(reg_table[i].msr_addr, *reg64);
+		}
+		return 0;
+	}
+
+hypercall:
+	return 1;
+}
+
+static void mshv_vtl_return(struct mshv_vtl_cpu_context *vtl0)
+{
+	struct hv_vp_assist_page *hvp;
+
+	hvp = hv_vp_assist_page[smp_processor_id()];
+
+	/*
+	 * Process signal event direct set in the run page, if any.
+	 */
+	if (mshv_vsm_capabilities.return_action_available) {
+		u32 offset = READ_ONCE(mshv_vtl_this_run()->vtl_ret_action_size);
+
+		WRITE_ONCE(mshv_vtl_this_run()->vtl_ret_action_size, 0);
+
+		/*
+		 * Hypervisor will take care of clearing out the actions
+		 * set in the assist page.
+		 */
+		memcpy(hvp->vtl_ret_actions,
+		       mshv_vtl_this_run()->vtl_ret_actions,
+		       min_t(u32, offset, sizeof(hvp->vtl_ret_actions)));
+	}
+
+	mshv_vtl_return_call(vtl0);
+}
+
+static bool mshv_vtl_process_intercept(void)
+{
+	struct hv_per_cpu_context *mshv_cpu;
+	void *synic_message_page;
+	struct hv_message *msg;
+	u32 message_type;
+
+	mshv_cpu = this_cpu_ptr(hv_context.cpu_context);
+	synic_message_page = mshv_cpu->synic_message_page;
+	if (unlikely(!synic_message_page))
+		return true;
+
+	msg = (struct hv_message *)synic_message_page + HV_SYNIC_INTERCEPTION_SINT_INDEX;
+	message_type = READ_ONCE(msg->header.message_type);
+	if (message_type == HVMSG_NONE)
+		return true;
+
+	memcpy(mshv_vtl_this_run()->exit_message, msg, sizeof(*msg));
+	vmbus_signal_eom(msg, message_type);
+
+	return false;
+}
+
+static int mshv_vtl_ioctl_return_to_lower_vtl(void)
+{
+	preempt_disable();
+	for (;;) {
+		u32 cancel;
+		unsigned long irq_flags;
+		struct hv_vp_assist_page *hvp;
+		int ret;
+
+		local_irq_save(irq_flags);
+		cancel = READ_ONCE(mshv_vtl_this_run()->cancel);
+		if (cancel)
+			current_thread_info()->flags |= _TIF_SIGPENDING;
+
+		if (unlikely(cancel) || __xfer_to_guest_mode_work_pending()) {
+			local_irq_restore(irq_flags);
+			preempt_enable();
+			ret = xfer_to_guest_mode_handle_work();
+			if (ret)
+				return ret;
+			preempt_disable();
+			continue;
+		}
+
+		mshv_vtl_return(&mshv_vtl_this_run()->cpu_context);
+		local_irq_restore(irq_flags);
+
+		hvp = hv_vp_assist_page[smp_processor_id()];
+		this_cpu_inc(num_vtl0_transitions);
+		switch (hvp->vtl_entry_reason) {
+		case MSHV_ENTRY_REASON_INTERRUPT:
+			if (!mshv_vsm_capabilities.intercept_page_available &&
+			    likely(!mshv_vtl_process_intercept()))
+				goto done;
+			break;
+
+		case MSHV_ENTRY_REASON_INTERCEPT:
+			WARN_ON(!mshv_vsm_capabilities.intercept_page_available);
+			memcpy(mshv_vtl_this_run()->exit_message, hvp->intercept_message,
+			       sizeof(hvp->intercept_message));
+			goto done;
+
+		default:
+			panic("unknown entry reason: %d", hvp->vtl_entry_reason);
+		}
+	}
+
+done:
+	preempt_enable();
+
+	return 0;
+}
+
+static long
+mshv_vtl_ioctl_get_regs(void __user *user_args)
+{
+	struct mshv_vp_registers args;
+	struct hv_register_assoc reg;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	/*  This IOCTL supports processing only one register at a time. */
+	if (args.count != 1)
+		return -EINVAL;
+
+	if (copy_from_user(&reg, (void __user *)args.regs_ptr,
+			   sizeof(reg)))
+		return -EFAULT;
+
+	ret = mshv_vtl_get_set_reg(&reg, false);
+	if (!ret)
+		goto copy_args; /* No need of hypercall */
+	ret = vtl_get_vp_register(&reg);
+	if (ret)
+		return ret;
+
+copy_args:
+	if (copy_to_user((void __user *)args.regs_ptr, &reg, sizeof(reg)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static long
+mshv_vtl_ioctl_set_regs(void __user *user_args)
+{
+	struct mshv_vp_registers args;
+	struct hv_register_assoc reg;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	/*  This IOCTL supports processing only one register at a time. */
+	if (args.count != 1)
+		return -EINVAL;
+
+	if (copy_from_user(&reg, (void __user *)args.regs_ptr, sizeof(reg)))
+		return -EFAULT;
+
+	ret = mshv_vtl_get_set_reg(&reg, true);
+	if (!ret)
+		return ret; /* No need of hypercall */
+	ret = vtl_set_vp_register(&reg);
+
+	return ret;
+}
+
+static long
+mshv_vtl_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	long ret;
+	struct mshv_vtl *vtl = filp->private_data;
+
+	switch (ioctl) {
+	case MSHV_SET_POLL_FILE:
+		ret = mshv_vtl_ioctl_set_poll_file((struct mshv_vtl_set_poll_file __user *)arg);
+		break;
+	case MSHV_GET_VP_REGISTERS:
+		ret = mshv_vtl_ioctl_get_regs((void __user *)arg);
+		break;
+	case MSHV_SET_VP_REGISTERS:
+		ret = mshv_vtl_ioctl_set_regs((void __user *)arg);
+		break;
+	case MSHV_RETURN_TO_LOWER_VTL:
+		ret = mshv_vtl_ioctl_return_to_lower_vtl();
+		break;
+	case MSHV_ADD_VTL0_MEMORY:
+		ret = mshv_vtl_ioctl_add_vtl0_mem(vtl, (void __user *)arg);
+		break;
+	default:
+		dev_err(vtl->module_dev, "invalid vtl ioctl: %#x\n", ioctl);
+		ret = -ENOTTY;
+	}
+
+	return ret;
+}
+
+static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
+{
+	struct page *page;
+	int cpu = vmf->pgoff & MSHV_PG_OFF_CPU_MASK;
+	int real_off = vmf->pgoff >> MSHV_REAL_OFF_SHIFT;
+
+	if (!cpu_online(cpu))
+		return VM_FAULT_SIGBUS;
+	/*
+	 * CPU Hotplug is not supported in VTL2 in OpenHCL, where this kernel driver exists.
+	 * CPU is expected to remain online after above cpu_online() check.
+	 */
+
+	if (real_off == MSHV_RUN_PAGE_OFFSET) {
+		page = virt_to_page(mshv_vtl_cpu_run(cpu));
+	} else if (real_off == MSHV_REG_PAGE_OFFSET) {
+		if (!mshv_has_reg_page)
+			return VM_FAULT_SIGBUS;
+		page = mshv_vtl_cpu_reg_page(cpu);
+	} else {
+		return VM_FAULT_NOPAGE;
+	}
+
+	get_page(page);
+	vmf->page = page;
+
+	return 0;
+}
+
+static const struct vm_operations_struct mshv_vtl_vm_ops = {
+	.fault = mshv_vtl_fault,
+};
+
+static int mshv_vtl_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	vma->vm_ops = &mshv_vtl_vm_ops;
+
+	return 0;
+}
+
+static int mshv_vtl_release(struct inode *inode, struct file *filp)
+{
+	struct mshv_vtl *vtl = filp->private_data;
+
+	kfree(vtl);
+
+	return 0;
+}
+
+static const struct file_operations mshv_vtl_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = mshv_vtl_ioctl,
+	.release = mshv_vtl_release,
+	.mmap = mshv_vtl_mmap,
+};
+
+static void mshv_vtl_synic_mask_vmbus_sint(const u8 *mask)
+{
+	union hv_synic_sint sint;
+
+	sint.as_uint64 = 0;
+	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.masked = (*mask != 0);
+	sint.auto_eoi = hv_recommend_using_aeoi();
+
+	hv_set_msr(HV_MSR_SINT0 + VTL2_VMBUS_SINT_INDEX,
+		   sint.as_uint64);
+
+	if (!sint.masked)
+		pr_debug("%s: Unmasking VTL2 VMBUS SINT on VP %d\n", __func__, smp_processor_id());
+	else
+		pr_debug("%s: Masking VTL2 VMBUS SINT on VP %d\n", __func__, smp_processor_id());
+}
+
+static void mshv_vtl_read_remote(void *buffer)
+{
+	struct hv_per_cpu_context *mshv_cpu = this_cpu_ptr(hv_context.cpu_context);
+	struct hv_message *msg = (struct hv_message *)mshv_cpu->synic_message_page +
+					VTL2_VMBUS_SINT_INDEX;
+	u32 message_type = READ_ONCE(msg->header.message_type);
+
+	WRITE_ONCE(has_message, false);
+	if (message_type == HVMSG_NONE)
+		return;
+
+	memcpy(buffer, msg, sizeof(*msg));
+	vmbus_signal_eom(msg, message_type);
+}
+
+static bool vtl_synic_mask_vmbus_sint_masked = true;
+
+static ssize_t mshv_vtl_sint_read(struct file *filp, char __user *arg, size_t size, loff_t *offset)
+{
+	struct hv_message msg = {};
+	int ret;
+
+	if (size < sizeof(msg))
+		return -EINVAL;
+
+	for (;;) {
+		smp_call_function_single(VMBUS_CONNECT_CPU, mshv_vtl_read_remote, &msg, true);
+		if (msg.header.message_type != HVMSG_NONE)
+			break;
+
+		if (READ_ONCE(vtl_synic_mask_vmbus_sint_masked))
+			return 0; /* EOF */
+
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(fd_wait_queue,
+					       READ_ONCE(has_message) ||
+						READ_ONCE(vtl_synic_mask_vmbus_sint_masked));
+		if (ret)
+			return ret;
+	}
+
+	if (copy_to_user(arg, &msg, sizeof(msg)))
+		return -EFAULT;
+
+	return sizeof(msg);
+}
+
+static __poll_t mshv_vtl_sint_poll(struct file *filp, poll_table *wait)
+{
+	__poll_t mask = 0;
+
+	poll_wait(filp, &fd_wait_queue, wait);
+	if (READ_ONCE(has_message) || READ_ONCE(vtl_synic_mask_vmbus_sint_masked))
+		mask |= EPOLLIN | EPOLLRDNORM;
+
+	return mask;
+}
+
+static void mshv_vtl_sint_on_msg_dpc(unsigned long data)
+{
+	WRITE_ONCE(has_message, true);
+	wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);
+}
+
+static int mshv_vtl_sint_ioctl_post_msg(struct mshv_vtl_sint_post_msg __user *arg)
+{
+	struct mshv_vtl_sint_post_msg message;
+	u8 payload[HV_MESSAGE_PAYLOAD_BYTE_COUNT];
+
+	if (copy_from_user(&message, arg, sizeof(message)))
+		return -EFAULT;
+	if (message.payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT)
+		return -EINVAL;
+	if (copy_from_user(payload, (void __user *)message.payload_ptr,
+			   message.payload_size))
+		return -EFAULT;
+
+	return hv_post_message((union hv_connection_id)message.connection_id,
+			       message.message_type, (void *)payload,
+			       message.payload_size);
+}
+
+static int mshv_vtl_sint_ioctl_signal_event(struct mshv_vtl_signal_event __user *arg)
+{
+	u64 input, status;
+	struct mshv_vtl_signal_event signal_event;
+
+	if (copy_from_user(&signal_event, arg, sizeof(signal_event)))
+		return -EFAULT;
+
+	input = signal_event.connection_id | ((u64)signal_event.flag << 32);
+
+	status = hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, input);
+
+	return hv_result_to_errno(status);
+}
+
+static int mshv_vtl_sint_ioctl_set_eventfd(struct mshv_vtl_set_eventfd __user *arg)
+{
+	struct mshv_vtl_set_eventfd set_eventfd;
+	struct eventfd_ctx *eventfd, *old_eventfd;
+
+	if (copy_from_user(&set_eventfd, arg, sizeof(set_eventfd)))
+		return -EFAULT;
+	if (set_eventfd.flag >= HV_EVENT_FLAGS_COUNT)
+		return -EINVAL;
+
+	eventfd = NULL;
+	if (set_eventfd.fd >= 0) {
+		eventfd = eventfd_ctx_fdget(set_eventfd.fd);
+		if (IS_ERR(eventfd))
+			return PTR_ERR(eventfd);
+	}
+
+	guard(mutex)(&flag_lock);
+	old_eventfd = READ_ONCE(flag_eventfds[set_eventfd.flag]);
+	WRITE_ONCE(flag_eventfds[set_eventfd.flag], eventfd);
+
+	if (old_eventfd) {
+		synchronize_rcu();
+		eventfd_ctx_put(old_eventfd);
+	}
+
+	return 0;
+}
+
+static int mshv_vtl_sint_ioctl_pause_msg_stream(struct mshv_sint_mask __user *arg)
+{
+	static DEFINE_MUTEX(vtl2_vmbus_sint_mask_mutex);
+	struct mshv_sint_mask mask;
+
+	if (copy_from_user(&mask, arg, sizeof(mask)))
+		return -EFAULT;
+	guard(mutex)(&vtl2_vmbus_sint_mask_mutex);
+	on_each_cpu((smp_call_func_t)mshv_vtl_synic_mask_vmbus_sint, &mask.mask, 1);
+	WRITE_ONCE(vtl_synic_mask_vmbus_sint_masked, mask.mask != 0);
+	if (mask.mask)
+		wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);
+
+	return 0;
+}
+
+static long mshv_vtl_sint_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case MSHV_SINT_POST_MESSAGE:
+		return mshv_vtl_sint_ioctl_post_msg((struct mshv_vtl_sint_post_msg __user *)arg);
+	case MSHV_SINT_SIGNAL_EVENT:
+		return mshv_vtl_sint_ioctl_signal_event((struct mshv_vtl_signal_event __user *)arg);
+	case MSHV_SINT_SET_EVENTFD:
+		return mshv_vtl_sint_ioctl_set_eventfd((struct mshv_vtl_set_eventfd __user *)arg);
+	case MSHV_SINT_PAUSE_MESSAGE_STREAM:
+		return mshv_vtl_sint_ioctl_pause_msg_stream((struct mshv_sint_mask __user *)arg);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+static const struct file_operations mshv_vtl_sint_ops = {
+	.owner = THIS_MODULE,
+	.read = mshv_vtl_sint_read,
+	.poll = mshv_vtl_sint_poll,
+	.unlocked_ioctl = mshv_vtl_sint_ioctl,
+};
+
+static struct miscdevice mshv_vtl_sint_dev = {
+	.name = "mshv_sint",
+	.fops = &mshv_vtl_sint_ops,
+	.mode = 0600,
+	.minor = MISC_DYNAMIC_MINOR,
+};
+
+static int mshv_vtl_hvcall_dev_open(struct inode *node, struct file *f)
+{
+	struct miscdevice *dev = f->private_data;
+	struct mshv_vtl_hvcall_fd *fd;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	fd = vzalloc(sizeof(*fd));
+	if (!fd)
+		return -ENOMEM;
+	fd->dev = dev;
+	f->private_data = fd;
+	mutex_init(&fd->init_mutex);
+
+	return 0;
+}
+
+static int mshv_vtl_hvcall_dev_release(struct inode *node, struct file *f)
+{
+	struct mshv_vtl_hvcall_fd *fd;
+
+	fd = f->private_data;
+	if (fd) {
+		vfree(fd);
+		f->private_data = NULL;
+	}
+
+	return 0;
+}
+
+static int mshv_vtl_hvcall_do_setup(struct mshv_vtl_hvcall_fd *fd,
+				    struct mshv_vtl_hvcall_setup __user *hvcall_setup_user)
+{
+	struct mshv_vtl_hvcall_setup hvcall_setup;
+
+	guard(mutex)(&fd->init_mutex);
+
+	if (fd->allow_map_initialized) {
+		dev_err(fd->dev->this_device,
+			"Hypercall allow map has already been set, pid %d\n",
+			current->pid);
+		return -EINVAL;
+	}
+
+	if (copy_from_user(&hvcall_setup, hvcall_setup_user,
+			   sizeof(struct mshv_vtl_hvcall_setup))) {
+		return -EFAULT;
+	}
+	if (hvcall_setup.bitmap_array_size > ARRAY_SIZE(fd->allow_bitmap))
+		return -EINVAL;
+
+	if (copy_from_user(&fd->allow_bitmap,
+			   (void __user *)hvcall_setup.allow_bitmap_ptr,
+			   hvcall_setup.bitmap_array_size)) {
+		return -EFAULT;
+	}
+
+	dev_info(fd->dev->this_device, "Hypercall allow map has been set, pid %d\n",
+		 current->pid);
+	fd->allow_map_initialized = true;
+	return 0;
+}
+
+static bool mshv_vtl_hvcall_is_allowed(struct mshv_vtl_hvcall_fd *fd, u16 call_code)
+{
+	return test_bit(call_code, (unsigned long *)fd->allow_bitmap);
+}
+
+static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
+				struct mshv_vtl_hvcall __user *hvcall_user)
+{
+	struct mshv_vtl_hvcall hvcall;
+	void *in, *out;
+	int ret;
+
+	if (copy_from_user(&hvcall, hvcall_user, sizeof(struct mshv_vtl_hvcall)))
+		return -EFAULT;
+	if (hvcall.input_size > HV_HYP_PAGE_SIZE)
+		return -EINVAL;
+	if (hvcall.output_size > HV_HYP_PAGE_SIZE)
+		return -EINVAL;
+
+	/*
+	 * By default, all hypercalls are not allowed.
+	 * The user mode code has to set up the allow bitmap once.
+	 */
+
+	if (!mshv_vtl_hvcall_is_allowed(fd, hvcall.control & 0xFFFF)) {
+		dev_err(fd->dev->this_device,
+			"Hypercall with control data %#llx isn't allowed\n",
+			hvcall.control);
+		return -EPERM;
+	}
+
+	/*
+	 * This may create a problem for Confidential VM (CVM) usecase where we need to use
+	 * Hyper-V driver allocated per-cpu input and output pages (hyperv_pcpu_input_arg and
+	 * hyperv_pcpu_output_arg) for making a hypervisor call.
+	 *
+	 * TODO: Take care of this when CVM support is added.
+	 */
+	in = (void *)__get_free_page(GFP_KERNEL);
+	out = (void *)__get_free_page(GFP_KERNEL);
+
+	if (copy_from_user(in, (void __user *)hvcall.input_ptr, hvcall.input_size)) {
+		ret = -EFAULT;
+		goto free_pages;
+	}
+
+	hvcall.status = hv_do_hypercall(hvcall.control, in, out);
+
+	if (copy_to_user((void __user *)hvcall.output_ptr, out, hvcall.output_size)) {
+		ret = -EFAULT;
+		goto free_pages;
+	}
+	ret = put_user(hvcall.status, &hvcall_user->status);
+free_pages:
+	free_page((unsigned long)in);
+	free_page((unsigned long)out);
+
+	return ret;
+}
+
+static long mshv_vtl_hvcall_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct mshv_vtl_hvcall_fd *fd = f->private_data;
+
+	switch (cmd) {
+	case MSHV_HVCALL_SETUP:
+		return mshv_vtl_hvcall_do_setup(fd, (struct mshv_vtl_hvcall_setup __user *)arg);
+	case MSHV_HVCALL:
+		return mshv_vtl_hvcall_call(fd, (struct mshv_vtl_hvcall __user *)arg);
+	default:
+		break;
+	}
+
+	return -ENOIOCTLCMD;
+}
+
+static const struct file_operations mshv_vtl_hvcall_dev_file_ops = {
+	.owner = THIS_MODULE,
+	.open = mshv_vtl_hvcall_dev_open,
+	.release = mshv_vtl_hvcall_dev_release,
+	.unlocked_ioctl = mshv_vtl_hvcall_dev_ioctl,
+};
+
+static struct miscdevice mshv_vtl_hvcall_dev = {
+	.name = "mshv_hvcall",
+	.nodename = "mshv_hvcall",
+	.fops = &mshv_vtl_hvcall_dev_file_ops,
+	.mode = 0600,
+	.minor = MISC_DYNAMIC_MINOR,
+};
+
+static int mshv_vtl_low_open(struct inode *inodep, struct file *filp)
+{
+	pid_t pid = task_pid_vnr(current);
+	uid_t uid = current_uid().val;
+	int ret = 0;
+
+	pr_debug("%s: Opening VTL low, task group %d, uid %d\n", __func__, pid, uid);
+
+	if (capable(CAP_SYS_ADMIN)) {
+		filp->private_data = inodep;
+	} else {
+		pr_err("%s: VTL low open failed: CAP_SYS_ADMIN required. task group %d, uid %d",
+		       __func__, pid, uid);
+		ret = -EPERM;
+	}
+
+	return ret;
+}
+
+static bool can_fault(struct vm_fault *vmf, unsigned long size, unsigned long *pfn)
+{
+	unsigned long mask = size - 1;
+	unsigned long start = vmf->address & ~mask;
+	unsigned long end = start + size;
+	bool is_valid;
+
+	is_valid = (vmf->address & mask) == ((vmf->pgoff << PAGE_SHIFT) & mask) &&
+		start >= vmf->vma->vm_start &&
+		end <= vmf->vma->vm_end;
+
+	if (is_valid)
+		*pfn = vmf->pgoff & ~(mask >> PAGE_SHIFT);
+
+	return is_valid;
+}
+
+static vm_fault_t mshv_vtl_low_huge_fault(struct vm_fault *vmf, unsigned int order)
+{
+	unsigned long pfn = vmf->pgoff;
+	vm_fault_t ret = VM_FAULT_FALLBACK;
+
+	switch (order) {
+	case 0:
+		return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+
+	case PMD_ORDER:
+		if (can_fault(vmf, PMD_SIZE, &pfn))
+			ret = vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+		return ret;
+
+	case PUD_ORDER:
+		if (can_fault(vmf, PUD_SIZE, &pfn))
+			ret = vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+		return ret;
+
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+}
+
+static vm_fault_t mshv_vtl_low_fault(struct vm_fault *vmf)
+{
+	return mshv_vtl_low_huge_fault(vmf, 0);
+}
+
+static const struct vm_operations_struct mshv_vtl_low_vm_ops = {
+	.fault = mshv_vtl_low_fault,
+	.huge_fault = mshv_vtl_low_huge_fault,
+};
+
+static int mshv_vtl_low_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	vma->vm_ops = &mshv_vtl_low_vm_ops;
+	vm_flags_set(vma, VM_HUGEPAGE | VM_MIXEDMAP);
+
+	return 0;
+}
+
+static const struct file_operations mshv_vtl_low_file_ops = {
+	.owner		= THIS_MODULE,
+	.open		= mshv_vtl_low_open,
+	.mmap		= mshv_vtl_low_mmap,
+};
+
+static struct miscdevice mshv_vtl_low = {
+	.name = "mshv_vtl_low",
+	.nodename = "mshv_vtl_low",
+	.fops = &mshv_vtl_low_file_ops,
+	.mode = 0600,
+	.minor = MISC_DYNAMIC_MINOR,
+};
+
+static int __init mshv_vtl_init(void)
+{
+	int ret;
+	struct device *dev = mshv_dev.this_device;
+
+	/*
+	 * This creates /dev/mshv which provides functionality to create VTLs and partitions.
+	 */
+	ret = misc_register(&mshv_dev);
+	if (ret) {
+		dev_err(dev, "mshv device register failed: %d\n", ret);
+		goto free_dev;
+	}
+
+	tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
+	init_waitqueue_head(&fd_wait_queue);
+
+	if (mshv_vtl_get_vsm_regs()) {
+		dev_emerg(dev, "Unable to get VSM capabilities !!\n");
+		ret = -ENODEV;
+		goto free_dev;
+	}
+	if (mshv_vtl_configure_vsm_partition(dev)) {
+		dev_emerg(dev, "VSM configuration failed !!\n");
+		ret = -ENODEV;
+		goto free_dev;
+	}
+
+	mshv_vtl_return_call_init(mshv_vsm_page_offsets.vtl_return_offset);
+	ret = hv_vtl_setup_synic();
+	if (ret)
+		goto free_dev;
+
+	/*
+	 * mshv_sint device adds VMBus relay ioctl support.
+	 * This provides a channel for VTL0 to communicate with VTL2.
+	 */
+	ret = misc_register(&mshv_vtl_sint_dev);
+	if (ret)
+		goto free_synic;
+
+	/*
+	 * mshv_hvcall device adds interface to enable userspace for direct hypercalls support.
+	 */
+	ret = misc_register(&mshv_vtl_hvcall_dev);
+	if (ret)
+		goto free_sint;
+
+	/*
+	 * mshv_vtl_low device is used to map VTL0 address space to a user-mode process in VTL2.
+	 * It implements mmap() to allow a user-mode process in VTL2 to map to the address of VTL0.
+	 */
+	ret = misc_register(&mshv_vtl_low);
+	if (ret)
+		goto free_hvcall;
+
+	/*
+	 * "mshv vtl mem dev" device is later used to setup VTL0 memory.
+	 */
+	mem_dev = kzalloc(sizeof(*mem_dev), GFP_KERNEL);
+	if (!mem_dev) {
+		ret = -ENOMEM;
+		goto free_low;
+	}
+
+	mutex_init(&mshv_vtl_poll_file_lock);
+
+	device_initialize(mem_dev);
+	dev_set_name(mem_dev, "mshv vtl mem dev");
+	ret = device_add(mem_dev);
+	if (ret) {
+		dev_err(dev, "mshv vtl mem dev add: %d\n", ret);
+		goto free_mem;
+	}
+
+	return 0;
+
+free_mem:
+	kfree(mem_dev);
+free_low:
+	misc_deregister(&mshv_vtl_low);
+free_hvcall:
+	misc_deregister(&mshv_vtl_hvcall_dev);
+free_sint:
+	misc_deregister(&mshv_vtl_sint_dev);
+free_synic:
+	hv_vtl_remove_synic();
+free_dev:
+	misc_deregister(&mshv_dev);
+
+	return ret;
+}
+
+static void __exit mshv_vtl_exit(void)
+{
+	device_del(mem_dev);
+	kfree(mem_dev);
+	misc_deregister(&mshv_vtl_low);
+	misc_deregister(&mshv_vtl_hvcall_dev);
+	misc_deregister(&mshv_vtl_sint_dev);
+	hv_vtl_remove_synic();
+	misc_deregister(&mshv_dev);
+}
+
+module_init(mshv_vtl_init);
+module_exit(mshv_vtl_exit);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 77abddfc750e..260cb0a80df3 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -880,6 +880,48 @@ struct hv_get_vp_from_apic_id_in {
 	u32 apic_ids[];
 } __packed;
 
+union hv_register_vsm_partition_config {
+	u64 as_uint64;
+	struct {
+		u64 enable_vtl_protection : 1;
+		u64 default_vtl_protection_mask : 4;
+		u64 zero_memory_on_reset : 1;
+		u64 deny_lower_vtl_startup : 1;
+		u64 intercept_acceptance : 1;
+		u64 intercept_enable_vtl_protection : 1;
+		u64 intercept_vp_startup : 1;
+		u64 intercept_cpuid_unimplemented : 1;
+		u64 intercept_unrecoverable_exception : 1;
+		u64 intercept_page : 1;
+		u64 mbz : 51;
+	} __packed;
+};
+
+union hv_register_vsm_capabilities {
+	u64 as_uint64;
+	struct {
+		u64 dr6_shared: 1;
+		u64 mbec_vtl_mask: 16;
+		u64 deny_lower_vtl_startup: 1;
+		u64 supervisor_shadow_stack: 1;
+		u64 hardware_hvpt_available: 1;
+		u64 software_hvpt_available: 1;
+		u64 hardware_hvpt_range_bits: 6;
+		u64 intercept_page_available: 1;
+		u64 return_action_available: 1;
+		u64 reserved: 35;
+	} __packed;
+};
+
+union hv_register_vsm_page_offsets {
+	struct {
+		u64 vtl_call_offset : 12;
+		u64 vtl_return_offset : 12;
+		u64 reserved_mbz : 40;
+	} __packed;
+	u64 as_uint64;
+};
+
 struct hv_nested_enlightenments_control {
 	struct {
 		u32 directhypercall : 1;
@@ -1002,6 +1044,70 @@ enum hv_register_name {
 
 	/* VSM */
 	HV_REGISTER_VSM_VP_STATUS				= 0x000D0003,
+
+	/* Synthetic VSM registers */
+	HV_REGISTER_VSM_CODE_PAGE_OFFSETS	= 0x000D0002,
+	HV_REGISTER_VSM_CAPABILITIES		= 0x000D0006,
+	HV_REGISTER_VSM_PARTITION_CONFIG	= 0x000D0007,
+
+#if defined(CONFIG_X86)
+	/* X64 Debug Registers */
+	HV_X64_REGISTER_DR0	= 0x00050000,
+	HV_X64_REGISTER_DR1	= 0x00050001,
+	HV_X64_REGISTER_DR2	= 0x00050002,
+	HV_X64_REGISTER_DR3	= 0x00050003,
+	HV_X64_REGISTER_DR6	= 0x00050004,
+	HV_X64_REGISTER_DR7	= 0x00050005,
+
+	/* X64 Cache control MSRs */
+	HV_X64_REGISTER_MSR_MTRR_CAP		= 0x0008000D,
+	HV_X64_REGISTER_MSR_MTRR_DEF_TYPE	= 0x0008000E,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0	= 0x00080010,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1	= 0x00080011,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2	= 0x00080012,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3	= 0x00080013,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4	= 0x00080014,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5	= 0x00080015,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6	= 0x00080016,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7	= 0x00080017,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8	= 0x00080018,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9	= 0x00080019,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA	= 0x0008001A,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB	= 0x0008001B,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC	= 0x0008001C,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASED	= 0x0008001D,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE	= 0x0008001E,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF	= 0x0008001F,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0	= 0x00080040,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1	= 0x00080041,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2	= 0x00080042,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3	= 0x00080043,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4	= 0x00080044,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5	= 0x00080045,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6	= 0x00080046,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7	= 0x00080047,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8	= 0x00080048,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9	= 0x00080049,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA	= 0x0008004A,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB	= 0x0008004B,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC	= 0x0008004C,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD	= 0x0008004D,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE	= 0x0008004E,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF	= 0x0008004F,
+	HV_X64_REGISTER_MSR_MTRR_FIX64K00000	= 0x00080070,
+	HV_X64_REGISTER_MSR_MTRR_FIX16K80000	= 0x00080071,
+	HV_X64_REGISTER_MSR_MTRR_FIX16KA0000	= 0x00080072,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KC0000	= 0x00080073,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KC8000	= 0x00080074,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KD0000	= 0x00080075,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KD8000	= 0x00080076,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KE0000	= 0x00080077,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KE8000	= 0x00080078,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KF0000	= 0x00080079,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	= 0x0008007A,
+
+	HV_X64_REGISTER_REG_PAGE	= 0x0009001C,
+#endif
 };
 
 /*
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 876bfe4e4227..ee10e21e1a11 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -288,4 +288,84 @@ struct mshv_get_set_vp_state {
  * #define MSHV_ROOT_HVCALL			_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
  */
 
+/* Structure definitions, macros and IOCTLs for mshv_vtl */
+
+#define MSHV_CAP_CORE_API_STABLE        0x0
+#define MSHV_CAP_REGISTER_PAGE          0x1
+#define MSHV_CAP_VTL_RETURN_ACTION      0x2
+#define MSHV_CAP_DR6_SHARED             0x3
+#define MSHV_MAX_RUN_MSG_SIZE                256
+
+struct mshv_vp_registers {
+	__u32 count;	/* supports only 1 register at a time */
+	__u32 reserved; /* Reserved for alignment or future use */
+	__u64 regs_ptr;	/* pointer to struct hv_register_assoc */
+};
+
+struct mshv_vtl_set_eventfd {
+	__s32 fd;
+	__u32 flag;
+};
+
+struct mshv_vtl_signal_event {
+	__u32 connection_id;
+	__u32 flag;
+};
+
+struct mshv_vtl_sint_post_msg {
+	__u64 message_type;
+	__u32 connection_id;
+	__u32 payload_size; /* Must not exceed HV_MESSAGE_PAYLOAD_BYTE_COUNT */
+	__u64 payload_ptr; /* pointer to message payload (bytes) */
+};
+
+struct mshv_vtl_ram_disposition {
+	__u64 start_pfn;
+	__u64 last_pfn;
+};
+
+struct mshv_vtl_set_poll_file {
+	__u32 cpu;
+	__u32 fd;
+};
+
+struct mshv_vtl_hvcall_setup {
+	__u64 bitmap_array_size; /* stores number of bytes */
+	__u64 allow_bitmap_ptr;
+};
+
+struct mshv_vtl_hvcall {
+	__u64 control;      /* Hypercall control code */
+	__u64 input_size;   /* Size of the input data */
+	__u64 input_ptr;    /* Pointer to the input struct */
+	__u64 status;       /* Status of the hypercall (output) */
+	__u64 output_size;  /* Size of the output data */
+	__u64 output_ptr;   /* Pointer to the output struct */
+};
+
+struct mshv_sint_mask {
+	__u8 mask;
+	__u8 reserved[7];
+};
+
+/* /dev/mshv device IOCTL */
+#define MSHV_CHECK_EXTENSION    _IOW(MSHV_IOCTL, 0x00, __u32)
+
+/* vtl device */
+#define MSHV_CREATE_VTL			_IOR(MSHV_IOCTL, 0x1D, char)
+#define MSHV_ADD_VTL0_MEMORY	_IOW(MSHV_IOCTL, 0x21, struct mshv_vtl_ram_disposition)
+#define MSHV_SET_POLL_FILE		_IOW(MSHV_IOCTL, 0x25, struct mshv_vtl_set_poll_file)
+#define MSHV_RETURN_TO_LOWER_VTL	_IO(MSHV_IOCTL, 0x27)
+#define MSHV_GET_VP_REGISTERS		_IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
+#define MSHV_SET_VP_REGISTERS		_IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
+
+/* VMBus device IOCTLs */
+#define MSHV_SINT_SIGNAL_EVENT    _IOW(MSHV_IOCTL, 0x22, struct mshv_vtl_signal_event)
+#define MSHV_SINT_POST_MESSAGE    _IOW(MSHV_IOCTL, 0x23, struct mshv_vtl_sint_post_msg)
+#define MSHV_SINT_SET_EVENTFD     _IOW(MSHV_IOCTL, 0x24, struct mshv_vtl_set_eventfd)
+#define MSHV_SINT_PAUSE_MESSAGE_STREAM     _IOW(MSHV_IOCTL, 0x25, struct mshv_sint_mask)
+
+/* hv_hvcall device */
+#define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_hvcall_setup)
+#define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl_hvcall)
 #endif
-- 
2.43.0


