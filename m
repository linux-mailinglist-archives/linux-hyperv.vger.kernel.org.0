Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CF83948D3
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 May 2021 00:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhE1WpW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 May 2021 18:45:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55850 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhE1WpS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 May 2021 18:45:18 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1FF7820B8020;
        Fri, 28 May 2021 15:43:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FF7820B8020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622241823;
        bh=/hFVnpx85BS3HTDWl1DLIQkb1oXqfqDpSVc5kdGZhXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VbDGzcyTFV3ZKL84RVgID1kdgK5iR744U5yVMoFLjcBp9TmFUJjXAS0XLBxJMb0pg
         pdhlkLswmSm0VVwsHo3He6fm7xBf2Y5yEHg4HoH7w1bj8shsVzhlX4I4eUEedIIbqj
         +7Z8dLUBDY03wGa+HmAn3R/Rqh7nuoe64i3zC4Yw=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com
Subject: [PATCH 11/19] drivers/hv: set up synic pages for intercept messages
Date:   Fri, 28 May 2021 15:43:31 -0700
Message-Id: <1622241819-21155-12-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Same idea as synic setup in drivers/hv/hv.c:hv_synic_enable_regs()
and hv_synic_disable_regs().
Setting up synic registers in both vmbus driver and mshv would clobber
them, but the vmbus driver will not run in the root partition, so this
is safe.
Move struct hv_message and related definitions to uapi.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/include/uapi/asm/hyperv-tlfs.h | 225 ++++++++++++++++++++++++
 drivers/hv/Makefile                     |   2 +-
 drivers/hv/hv_synic.c                   |  85 +++++++++
 drivers/hv/mshv.h                       |   5 +
 drivers/hv/mshv_main.c                  |  30 +++-
 include/asm-generic/hyperv-tlfs.h       |  81 +--------
 include/linux/mshv.h                    |   1 +
 include/uapi/asm-generic/hyperv-tlfs.h  |  75 ++++++++
 8 files changed, 422 insertions(+), 82 deletions(-)
 create mode 100644 drivers/hv/hv_synic.c

diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
index a42c63001055..4ffa7e1cd185 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -723,4 +723,229 @@ union hv_register_value {
 		pending_virtualization_fault_event;
 };
 
+union hv_x64_vp_execution_state {
+	__u16 as_uint16;
+	struct {
+		__u16 cpl:2;
+		__u16 cr0_pe:1;
+		__u16 cr0_am:1;
+		__u16 efer_lma:1;
+		__u16 debug_active:1;
+		__u16 interruption_pending:1;
+		__u16 vtl:4;
+		__u16 enclave_mode:1;
+		__u16 interrupt_shadow:1;
+		__u16 virtualization_fault_active:1;
+		__u16 reserved:2;
+	} __packed;
+};
+
+/* Values for intercept_access_type field */
+#define HV_INTERCEPT_ACCESS_READ	0
+#define HV_INTERCEPT_ACCESS_WRITE	1
+#define HV_INTERCEPT_ACCESS_EXECUTE	2
+
+struct hv_x64_intercept_message_header {
+	__u32 vp_index;
+	__u8 instruction_length:4;
+	__u8 cr8:4; // only set for exo partitions
+	__u8 intercept_access_type;
+	union hv_x64_vp_execution_state execution_state;
+	struct hv_x64_segment_register cs_segment;
+	__u64 rip;
+	__u64 rflags;
+} __packed;
+
+#define HV_HYPERCALL_INTERCEPT_MAX_XMM_REGISTERS 6
+
+struct hv_x64_hypercall_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u64 rax;
+	__u64 rbx;
+	__u64 rcx;
+	__u64 rdx;
+	__u64 r8;
+	__u64 rsi;
+	__u64 rdi;
+	struct hv_u128 xmmregisters[HV_HYPERCALL_INTERCEPT_MAX_XMM_REGISTERS];
+	struct {
+		__u32 isolated:1;
+		__u32 reserved:31;
+	} __packed;
+} __packed;
+
+union hv_x64_register_access_info {
+	union hv_register_value source_value;
+	__u32 destination_register;
+	__u64 source_address;
+	__u64 destination_address;
+};
+
+struct hv_x64_register_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	struct {
+		__u8 is_memory_op:1;
+		__u8 reserved:7;
+	} __packed;
+	__u8 reserved8;
+	__u16 reserved16;
+	__u32 register_name;
+	union hv_x64_register_access_info access_info;
+} __packed;
+
+union hv_x64_memory_access_info {
+	__u8 as_uint8;
+	struct {
+		__u8 gva_valid:1;
+		__u8 gva_gpa_valid:1;
+		__u8 hypercall_output_pending:1;
+		__u8 tlb_locked_no_overlay:1;
+		__u8 reserved:4;
+	} __packed;
+};
+
+union hv_x64_io_port_access_info {
+	__u8 as_uint8;
+	struct {
+		__u8 access_size:3;
+		__u8 string_op:1;
+		__u8 rep_prefix:1;
+		__u8 reserved:3;
+	} __packed;
+};
+
+union hv_x64_exception_info {
+	__u8 as_uint8;
+	struct {
+		__u8 error_code_valid:1;
+		__u8 software_exception:1;
+		__u8 reserved:6;
+	} __packed;
+};
+
+#define HV_CACHE_TYPE_UNCACHED		0
+#define HV_CACHE_TYPE_WRITE_COMBINING	1
+#define HV_CACHE_TYPE_WRITE_THROUGH	4
+#define HV_CACHE_TYPE_WRITE_PROTECTED	5
+#define HV_CACHE_TYPE_WRITE_BACK	6
+
+struct hv_x64_memory_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u32 cache_type;
+	__u8 instruction_byte_count;
+	union hv_x64_memory_access_info memory_access_info;
+	__u8 tpr_priority;
+	__u8 reserved1;
+	__u64 guest_virtual_address;
+	__u64 guest_physical_address;
+	__u8 instruction_bytes[16];
+} __packed;
+
+struct hv_x64_cpuid_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u64 rax;
+	__u64 rcx;
+	__u64 rdx;
+	__u64 rbx;
+	__u64 default_result_rax;
+	__u64 default_result_rcx;
+	__u64 default_result_rdx;
+	__u64 default_result_rbx;
+} __packed;
+
+struct hv_x64_msr_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u32 msr_number;
+	__u32 reserved;
+	__u64 rdx;
+	__u64 rax;
+} __packed;
+
+struct hv_x64_io_port_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u16 port_number;
+	union hv_x64_io_port_access_info access_info;
+	__u8 instruction_byte_count;
+	__u32 reserved;
+	__u64 rax;
+	__u8 instruction_bytes[16];
+	struct hv_x64_segment_register ds_segment;
+	struct hv_x64_segment_register es_segment;
+	__u64 rcx;
+	__u64 rsi;
+	__u64 rdi;
+} __packed;
+
+struct hv_x64_exception_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u16 exception_vector;
+	union hv_x64_exception_info exception_info;
+	__u8 instruction_byte_count;
+	__u32 error_code;
+	__u64 exception_parameter;
+	__u64 reserved;
+	__u8 instruction_bytes[16];
+	struct hv_x64_segment_register ds_segment;
+	struct hv_x64_segment_register ss_segment;
+	__u64 rax;
+	__u64 rcx;
+	__u64 rdx;
+	__u64 rbx;
+	__u64 rsp;
+	__u64 rbp;
+	__u64 rsi;
+	__u64 rdi;
+	__u64 r8;
+	__u64 r9;
+	__u64 r10;
+	__u64 r11;
+	__u64 r12;
+	__u64 r13;
+	__u64 r14;
+	__u64 r15;
+} __packed;
+
+struct hv_x64_invalid_vp_register_message {
+	__u32 vp_index;
+	__u32 reserved;
+} __packed;
+
+struct hv_x64_unrecoverable_exception_message {
+	struct hv_x64_intercept_message_header header;
+} __packed;
+
+#define HV_UNSUPPORTED_FEATURE_INTERCEPT	1
+#define HV_UNSUPPORTED_FEATURE_TASK_SWITCH_TSS	2
+
+struct hv_x64_unsupported_feature_message {
+	__u32 vp_index;
+	__u32 feature_code;
+	__u64 feature_parameter;
+} __packed;
+
+struct hv_x64_halt_message {
+	struct hv_x64_intercept_message_header header;
+} __packed;
+
+#define HV_X64_PENDING_INTERRUPT	0
+#define HV_X64_PENDING_NMI		2
+#define HV_X64_PENDING_EXCEPTION	3
+
+struct hv_x64_interruption_deliverable_message {
+	struct hv_x64_intercept_message_header header;
+	__u32 deliverable_type; /* pending interruption type */
+	__u32 rsvd;
+} __packed;
+
+struct hv_x64_sipi_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u32 target_vp_index;
+	__u32 interrupt_vector;
+} __packed;
+
+struct hv_x64_apic_eoi_message {
+	__u32 vp_index;
+	__u32 interrupt_vector;
+} __packed;
+
 #endif
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 649748c9c144..a2b698661b5e 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -13,4 +13,4 @@ hv_vmbus-y := vmbus_drv.o \
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
 
-mshv-y                          += mshv_main.o hv_call.o
+mshv-y                          += mshv_main.o hv_call.o hv_synic.o
diff --git a/drivers/hv/hv_synic.c b/drivers/hv/hv_synic.c
new file mode 100644
index 000000000000..8065f3598001
--- /dev/null
+++ b/drivers/hv/hv_synic.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Microsoft Corporation.
+ *
+ * Authors:
+ *   Nuno Das Neves <nudasnev@microsoft.com>
+ *   Lillian Grassin-Drake <ligrassi@microsoft.com>
+ *   Vineeth Remanan Pillai <viremana@linux.microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/mshv.h>
+#include <asm/mshyperv.h>
+
+#include "mshv.h"
+
+int mshv_synic_init(unsigned int cpu)
+{
+	union hv_synic_simp simp;
+	union hv_synic_sint sint;
+	union hv_synic_scontrol sctrl;
+	struct hv_message_page **msg_page =
+			this_cpu_ptr(mshv.synic_message_page);
+
+	/* Setup the Synic's message page */
+	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	simp.simp_enabled = true;
+	*msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
+			     HV_HYP_PAGE_SIZE,
+                             MEMREMAP_WB);
+	if (!msg_page) {
+		pr_err("%s: memremap failed\n", __func__);
+		return -EFAULT;
+	}
+	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+
+	/* Enable intercepts */
+	sint.as_uint64 = 0;
+	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.masked = false;
+#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
+	sint.auto_eoi =	!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
+#else
+	sint.auto_eoi = 0;
+#endif
+	hv_set_register(HV_REGISTER_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
+			sint.as_uint64);
+
+	/* Enable global synic bit */
+	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	sctrl.enable = 1;
+	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+
+	return 0;
+}
+
+int mshv_synic_cleanup(unsigned int cpu)
+{
+	union hv_synic_sint sint;
+	union hv_synic_simp simp;
+	union hv_synic_scontrol sctrl;
+	struct hv_message_page **msg_page =
+			this_cpu_ptr(mshv.synic_message_page);
+
+	/* Disable the interrupt */
+	sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX);
+	sint.masked = true;
+	hv_set_register(HV_REGISTER_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
+			sint.as_uint64);
+
+	/* Disable Synic's message page */
+	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	simp.simp_enabled = false;
+	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	memunmap(*msg_page);
+
+	/* Disable global synic bit */
+	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	sctrl.enable = 0;
+	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+
+	return 0;
+}
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index 9e63d2fabc74..b8fece9fe80d 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -27,6 +27,11 @@
 	((HV_HYP_PAGE_SIZE - sizeof(struct hv_set_vp_registers)) \
 		/ sizeof(struct hv_register_assoc))
 
+extern struct mshv mshv;
+
+int mshv_synic_init(unsigned int cpu);
+int mshv_synic_cleanup(unsigned int cpu);
+
 /*
  * Hyper-V hypercalls
  */
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index a7f3e392d944..a3e6cd15f9ed 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -15,6 +15,8 @@
 #include <linux/file.h>
 #include <linux/anon_inodes.h>
 #include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/cpuhotplug.h>
 #include <linux/mshv.h>
 #include <asm/mshyperv.h>
 
@@ -650,23 +652,47 @@ mshv_dev_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int mshv_cpuhp_online;
+
 static int
 __init mshv_init(void)
 {
 	int ret;
 
 	ret = misc_register(&mshv_dev);
-	if (ret)
+	if (ret) {
 		pr_err("%s: misc device register failed\n", __func__);
+		return ret;
+	}
+
+	mshv.synic_message_page = alloc_percpu(struct hv_message_page *);
+	if (!mshv.synic_message_page) {
+		pr_err("%s: failed to allocate percpu synic page\n", __func__);
+		misc_deregister(&mshv_dev);
+		return -ENOMEM;
+	}
 
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
+				mshv_synic_init,
+				mshv_synic_cleanup);
+	if (ret < 0) {
+		pr_err("%s: failed to setup cpu hotplug state: %i\n",
+		       __func__, ret);
+		return ret;
+	}
+
+	mshv_cpuhp_online = ret;
 	spin_lock_init(&mshv.partitions.lock);
 
-	return ret;
+	return 0;
 }
 
 static void
 __exit mshv_exit(void)
 {
+	cpuhp_remove_state(mshv_cpuhp_online);
+	free_percpu(mshv.synic_message_page);
+
 	misc_deregister(&mshv_dev);
 }
 
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 220b89293130..3a42d6e421b5 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -241,6 +241,8 @@ enum hv_status {
 /* Valid SynIC vectors are 16-255. */
 #define HV_SYNIC_FIRST_VALID_VECTOR	(16)
 
+#define HV_SYNIC_INTERCEPTION_SINT_INDEX 0x00000000
+
 #define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
 #define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
 #define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
@@ -250,84 +252,6 @@ enum hv_status {
 
 #define HV_SYNIC_STIMER_COUNT		(4)
 
-/* Define synthetic interrupt controller message constants. */
-#define HV_MESSAGE_SIZE			(256)
-#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
-#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
-
-/*
- * Define hypervisor message types. Some of the message types
- * are x86/x64 specific, but there's no good way to separate
- * them out into the arch-specific version of hyperv-tlfs.h
- * because C doesn't provide a way to extend enum types.
- * Keeping them all in the arch neutral hyperv-tlfs.h seems
- * the least messy compromise.
- */
-enum hv_message_type {
-	HVMSG_NONE			= 0x00000000,
-
-	/* Memory access messages. */
-	HVMSG_UNMAPPED_GPA		= 0x80000000,
-	HVMSG_GPA_INTERCEPT		= 0x80000001,
-
-	/* Timer notification messages. */
-	HVMSG_TIMER_EXPIRED		= 0x80000010,
-
-	/* Error messages. */
-	HVMSG_INVALID_VP_REGISTER_VALUE	= 0x80000020,
-	HVMSG_UNRECOVERABLE_EXCEPTION	= 0x80000021,
-	HVMSG_UNSUPPORTED_FEATURE	= 0x80000022,
-
-	/* Trace buffer complete messages. */
-	HVMSG_EVENTLOG_BUFFERCOMPLETE	= 0x80000040,
-
-	/* Platform-specific processor intercept messages. */
-	HVMSG_X64_IOPORT_INTERCEPT	= 0x80010000,
-	HVMSG_X64_MSR_INTERCEPT		= 0x80010001,
-	HVMSG_X64_CPUID_INTERCEPT	= 0x80010002,
-	HVMSG_X64_EXCEPTION_INTERCEPT	= 0x80010003,
-	HVMSG_X64_APIC_EOI		= 0x80010004,
-	HVMSG_X64_LEGACY_FP_ERROR	= 0x80010005
-};
-
-/* Define synthetic interrupt controller message flags. */
-union hv_message_flags {
-	__u8 asu8;
-	struct {
-		__u8 msg_pending:1;
-		__u8 reserved:7;
-	} __packed;
-};
-
-/* Define port identifier type. */
-union hv_port_id {
-	__u32 asu32;
-	struct {
-		__u32 id:24;
-		__u32 reserved:8;
-	} __packed u;
-};
-
-/* Define synthetic interrupt controller message header. */
-struct hv_message_header {
-	__u32 message_type;
-	__u8 payload_size;
-	union hv_message_flags message_flags;
-	__u8 reserved[2];
-	union {
-		__u64 sender;
-		union hv_port_id port;
-	};
-} __packed;
-
-/* Define synthetic interrupt controller message format. */
-struct hv_message {
-	struct hv_message_header header;
-	union {
-		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
-	} u;
-} __packed;
-
 /* Define the synthetic interrupt message page layout. */
 struct hv_message_page {
 	struct hv_message sint_message[HV_SYNIC_SINT_COUNT];
@@ -341,7 +265,6 @@ struct hv_timer_message_payload {
 	__u64 delivery_time;	/* When the message was delivered */
 } __packed;
 
-
 /* Define synthetic interrupt controller flag constants. */
 #define HV_EVENT_FLAGS_COUNT		(256 * 8)
 #define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index dfe469f573f9..7709aaa1e064 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -42,6 +42,7 @@ struct mshv_partition {
 };
 
 struct mshv {
+	struct hv_message_page __percpu **synic_message_page;
 	struct {
 		spinlock_t lock;
 		u64 count;
diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
index f49099d1f894..4ecb29fe1a0e 100644
--- a/include/uapi/asm-generic/hyperv-tlfs.h
+++ b/include/uapi/asm-generic/hyperv-tlfs.h
@@ -6,6 +6,81 @@
 #define BIT(X)	(1ULL << (X))
 #endif
 
+/* Define synthetic interrupt controller message constants. */
+#define HV_MESSAGE_SIZE			(256)
+#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
+#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
+
+/* Define hypervisor message types. */
+enum hv_message_type {
+	HVMSG_NONE				= 0x00000000,
+
+	/* Memory access messages. */
+	HVMSG_UNMAPPED_GPA			= 0x80000000,
+	HVMSG_GPA_INTERCEPT			= 0x80000001,
+
+	/* Timer notification messages. */
+	HVMSG_TIMER_EXPIRED			= 0x80000010,
+
+	/* Error messages. */
+	HVMSG_INVALID_VP_REGISTER_VALUE		= 0x80000020,
+	HVMSG_UNRECOVERABLE_EXCEPTION		= 0x80000021,
+	HVMSG_UNSUPPORTED_FEATURE		= 0x80000022,
+
+	/* Trace buffer complete messages. */
+	HVMSG_EVENTLOG_BUFFERCOMPLETE		= 0x80000040,
+
+	/* Platform-specific processor intercept messages. */
+	HVMSG_X64_IO_PORT_INTERCEPT		= 0x80010000,
+	HVMSG_X64_MSR_INTERCEPT			= 0x80010001,
+	HVMSG_X64_CPUID_INTERCEPT		= 0x80010002,
+	HVMSG_X64_EXCEPTION_INTERCEPT		= 0x80010003,
+	HVMSG_X64_APIC_EOI			= 0x80010004,
+	HVMSG_X64_LEGACY_FP_ERROR		= 0x80010005,
+	HVMSG_X64_IOMMU_PRQ			= 0x80010006,
+	HVMSG_X64_HALT				= 0x80010007,
+	HVMSG_X64_INTERRUPTION_DELIVERABLE	= 0x80010008,
+	HVMSG_X64_SIPI_INTERCEPT		= 0x80010009,
+};
+
+/* Define synthetic interrupt controller message flags. */
+union hv_message_flags {
+	__u8 asu8;
+	struct {
+		__u8 msg_pending:1;
+		__u8 reserved:7;
+	} __packed;
+};
+
+/* Define port identifier type. */
+union hv_port_id {
+	__u32 asu32;
+	struct {
+		__u32 id:24;
+		__u32 reserved:8;
+	} __packed u;
+};
+
+/* Define synthetic interrupt controller message header. */
+struct hv_message_header {
+	__u32 message_type;
+	__u8 payload_size;
+	union hv_message_flags message_flags;
+	__u8 reserved[2];
+	union {
+		__u64 sender;
+		union hv_port_id port;
+	};
+} __packed;
+
+/* Define synthetic interrupt controller message format. */
+struct hv_message {
+	struct hv_message_header header;
+	union {
+		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
+	} u;
+} __packed;
+
 /* Userspace-visible partition creation flags */
 #define HV_PARTITION_CREATION_FLAG_SMT_ENABLED_GUEST                BIT(0)
 #define HV_PARTITION_CREATION_FLAG_GPA_LARGE_PAGES_DISABLED         BIT(3)
-- 
2.25.1

