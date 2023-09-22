Return-Path: <linux-hyperv+bounces-190-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60967AB962
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 20:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id ABF921F23526
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942E45F58;
	Fri, 22 Sep 2023 18:39:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E745F70
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 18:38:50 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A93C7139;
	Fri, 22 Sep 2023 11:38:44 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 84423212C7EA;
	Fri, 22 Sep 2023 11:38:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 84423212C7EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695407922;
	bh=/JDjMfJlm0vIK5YBfQhLXNBCve2eVHdX3JIZn9iOG8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXUdwY8wq+OnkCSR4D8QMdpo5vhITgVLFQBbg/4VcoT/Enr0MNJfDvgBw8NZV4ujL
	 7TRkEENumod8eu9RwbGxzoSpnpkAqVZDvj8uZiDutHp7ruFX8EAXAuNmZEGBfbLRmR
	 z+7jwBIeZVlKbjU7wIxEUCr9FE34V6r9+Q8RN0ms=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: patches@lists.linux.dev,
	mikelley@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	gregkh@linuxfoundation.org,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com,
	ssengar@linux.microsoft.com,
	mukeshrathor@microsoft.com,
	stanislav.kinsburskiy@gmail.com,
	jinankjain@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	will@kernel.org,
	catalin.marinas@arm.com
Subject: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to VMMs running on Hyper-V
Date: Fri, 22 Sep 2023 11:38:35 -0700
Message-Id: <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add mshv, mshv_root, and mshv_vtl modules:

Module mshv is the parent module to the other two. It provides /dev/mshv,
plus some common hypercall helper code. When one of the child modules is
loaded, it is registered with the mshv module, which then provides entry
point(s) to the child module via the IOCTLs defined in uapi/linux/mshv.h.

E.g. When the mshv_root module is loaded, it registers itself, and the
MSHV_CREATE_PARTITION IOCTL becomes available in /dev/mshv. That is used to
get a partition fd managed by mshv_root.

Similarly for mshv_vtl module, there is MSHV_CREATE_VTL, which creates
an fd representing the lower vtl, managed by mshv_vtl.

Module mshv_root provides APIs for creating and managing child partitions.
It defines abstractions for partitions (vms), vps (vcpus), and other things
related to running a guest. It exposes the userspace interfaces for a VMM
to manage the guest.

Module mshv_vtl provides VTL (Virtual Trust Level) support for VMMs. In
this scenario, the host kernel and VMM run in a higher trust level than the
guest, but within the same partition. This provides better isolation and
performance.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/Kconfig             |   49 +
 drivers/hv/Makefile            |   20 +
 drivers/hv/hv_call.c           |  113 ++
 drivers/hv/hv_common.c         |    4 +
 drivers/hv/mshv.h              |  123 ++
 drivers/hv/mshv_eventfd.c      |  761 +++++++++++++
 drivers/hv/mshv_eventfd.h      |   80 ++
 drivers/hv/mshv_main.c         |  208 ++++
 drivers/hv/mshv_msi.c          |  129 +++
 drivers/hv/mshv_portid_table.c |   84 ++
 drivers/hv/mshv_root.h         |  193 ++++
 drivers/hv/mshv_root_hv_call.c | 1015 +++++++++++++++++
 drivers/hv/mshv_root_main.c    | 1920 ++++++++++++++++++++++++++++++++
 drivers/hv/mshv_synic.c        |  688 ++++++++++++
 drivers/hv/mshv_vtl.h          |   52 +
 drivers/hv/mshv_vtl_main.c     | 1517 +++++++++++++++++++++++++
 drivers/hv/xfer_to_guest.c     |   28 +
 include/uapi/linux/mshv.h      |  306 +++++
 18 files changed, 7290 insertions(+)
 create mode 100644 drivers/hv/hv_call.c
 create mode 100644 drivers/hv/mshv.h
 create mode 100644 drivers/hv/mshv_eventfd.c
 create mode 100644 drivers/hv/mshv_eventfd.h
 create mode 100644 drivers/hv/mshv_main.c
 create mode 100644 drivers/hv/mshv_msi.c
 create mode 100644 drivers/hv/mshv_portid_table.c
 create mode 100644 drivers/hv/mshv_root.h
 create mode 100644 drivers/hv/mshv_root_hv_call.c
 create mode 100644 drivers/hv/mshv_root_main.c
 create mode 100644 drivers/hv/mshv_synic.c
 create mode 100644 drivers/hv/mshv_vtl.h
 create mode 100644 drivers/hv/mshv_vtl_main.c
 create mode 100644 drivers/hv/xfer_to_guest.c
 create mode 100644 include/uapi/linux/mshv.h

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 00242107d62e..f9d9b8883ba4 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -54,4 +54,53 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+config MSHV
+	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
+	depends on X86_64 && HYPERV
+	select EVENTFD
+	select MSHV_XFER_TO_GUEST_WORK
+	help
+	  Select this option to enable core functionality for managing guest
+	  virtual machines running under the Microsoft Hypervisor.
+
+	  The interfaces are provided via a device named /dev/mshv.
+
+	  To compile this as a module, choose M here.
+
+	  If unsure, say N.
+
+config MSHV_ROOT
+	tristate "Microsoft Hyper-V root partition APIs driver"
+	depends on MSHV
+	help
+	  Select this option to provide /dev/mshv interfaces specific to
+	  running as the root partition on Microsoft Hypervisor.
+
+	  To compile this as a module, choose M here.
+
+	  If unsure, say N.
+
+config MSHV_VTL
+	tristate "Microsoft Hyper-V VTL driver"
+	depends on MSHV
+	select HYPERV_VTL_MODE
+	help
+	  Select this option to enable Hyper-V VTL driver.
+	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
+	  enlightenments offered to host and guest partitions which enables
+	  the creation and management of new security boundaries within
+	  operating system software.
+
+	  VSM achieves and maintains isolation through Virtual Trust Levels
+	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
+	  being more privileged than lower levels. VTL0 is the least privileged
+	  level, and currently only other level supported is VTL2.
+
+	  To compile this as a module, choose M here.
+
+	  If unsure, say N.
+
+config MSHV_XFER_TO_GUEST_WORK
+	bool
+
 endmenu
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index d76df5c8c2a9..da7aa7542b05 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -2,10 +2,30 @@
 obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
+obj-$(CONFIG_MSHV)			+= mshv.o
+obj-$(CONFIG_MSHV_VTL)		+= mshv_vtl.o
+obj-$(CONFIG_MSHV_ROOT)		+= mshv_root.o
 
 CFLAGS_hv_trace.o = -I$(src)
 CFLAGS_hv_balloon.o = -I$(src)
 
+CFLAGS_mshv_main.o			= -DHV_HYPERV_DEFS
+CFLAGS_hv_call.o			= -DHV_HYPERV_DEFS
+CFLAGS_mshv_root_main.o		= -DHV_HYPERV_DEFS
+CFLAGS_mshv_root_hv_call.o	= -DHV_HYPERV_DEFS
+CFLAGS_mshv_synic.o			= -DHV_HYPERV_DEFS
+CFLAGS_mshv_portid_table.o	= -DHV_HYPERV_DEFS
+CFLAGS_mshv_eventfd.o		= -DHV_HYPERV_DEFS
+CFLAGS_mshv_msi.o			= -DHV_HYPERV_DEFS
+CFLAGS_mshv_vtl_main.o		= -DHV_HYPERV_DEFS
+
+mshv-y				+= mshv_main.o
+mshv_root-y			:= mshv_root_main.o mshv_synic.o mshv_portid_table.o \
+						mshv_eventfd.o mshv_msi.o mshv_root_hv_call.o hv_call.o
+mshv_vtl-y			:= mshv_vtl_main.o hv_call.o
+
+obj-$(CONFIG_MSHV_XFER_TO_GUEST_WORK) += xfer_to_guest.o
+
 hv_vmbus-y := vmbus_drv.o \
 		 hv.o connection.o channel.o \
 		 channel_mgmt.o ring_buffer.o hv_trace.o
diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
new file mode 100644
index 000000000000..65362d901851
--- /dev/null
+++ b/drivers/hv/hv_call.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * Hypercall helper functions shared between mshv modules.
+ *
+ * Authors:
+ *   Nuno Das Neves <nunodasneves@linux.microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <asm/mshyperv.h>
+
+#define HV_GET_REGISTER_BATCH_SIZE	\
+	(HV_HYP_PAGE_SIZE / sizeof(union hv_register_value))
+#define HV_SET_REGISTER_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_registers)) \
+		/ sizeof(struct hv_register_assoc))
+
+int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+			     union hv_input_vtl input_vtl,
+			     struct hv_register_assoc *registers)
+{
+	struct hv_input_get_vp_registers *input_page;
+	union hv_register_value *output_page;
+	u16 completed = 0;
+	unsigned long remaining = count;
+	int rep_count, i;
+	u64 status = HV_STATUS_SUCCESS;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	input_page->partition_id = partition_id;
+	input_page->vp_index = vp_index;
+	input_page->input_vtl.as_uint8 = input_vtl.as_uint8;
+	input_page->rsvd_z8 = 0;
+	input_page->rsvd_z16 = 0;
+
+	while (remaining) {
+		rep_count = min(remaining, HV_GET_REGISTER_BATCH_SIZE);
+		for (i = 0; i < rep_count; ++i)
+			input_page->names[i] = registers[i].name;
+
+		status = hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS, rep_count,
+					     0, input_page, output_page);
+		if (!hv_result_success(status)) {
+			pr_err("%s: completed %li out of %u, %s\n",
+			       __func__,
+			       count - remaining, count,
+			       hv_status_to_string(status));
+			break;
+		}
+		completed = hv_repcomp(status);
+		for (i = 0; i < completed; ++i)
+			registers[i].value = output_page[i];
+
+		registers += completed;
+		remaining -= completed;
+	}
+	local_irq_restore(flags);
+
+	return hv_status_to_errno(status);
+}
+
+int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+			     union hv_input_vtl input_vtl,
+			     struct hv_register_assoc *registers)
+{
+	struct hv_input_set_vp_registers *input_page;
+	u16 completed = 0;
+	unsigned long remaining = count;
+	int rep_count;
+	u64 status = HV_STATUS_SUCCESS;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	input_page->partition_id = partition_id;
+	input_page->vp_index = vp_index;
+	input_page->input_vtl.as_uint8 = input_vtl.as_uint8;
+	input_page->rsvd_z8 = 0;
+	input_page->rsvd_z16 = 0;
+
+	while (remaining) {
+		rep_count = min(remaining, HV_SET_REGISTER_BATCH_SIZE);
+		memcpy(input_page->elements, registers,
+		       sizeof(struct hv_register_assoc) * rep_count);
+
+		status = hv_do_rep_hypercall(HVCALL_SET_VP_REGISTERS, rep_count,
+					     0, input_page, NULL);
+		if (!hv_result_success(status)) {
+			pr_err("%s: completed %li out of %u, %s\n",
+			       __func__,
+			       count - remaining, count,
+			       hv_status_to_string(status));
+			break;
+		}
+		completed = hv_repcomp(status);
+		registers += completed;
+		remaining -= completed;
+	}
+
+	local_irq_restore(flags);
+
+	return hv_status_to_errno(status);
+}
+
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 092b0c727db9..251d8de3180d 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -63,7 +63,11 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
  */
 static inline bool hv_output_arg_exists(void)
 {
+#ifdef CONFIG_MSHV_VTL
+	return true;
+#else
 	return hv_root_partition ? true : false;
+#endif
 }
 
 static void hv_kmsg_dump_unregister(void);
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
new file mode 100644
index 000000000000..bac3208a31ce
--- /dev/null
+++ b/drivers/hv/mshv.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ */
+
+#ifndef _MSHV_H_
+#define _MSHV_H_
+
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/semaphore.h>
+#include <linux/sched.h>
+#include <linux/srcu.h>
+#include <linux/wait.h>
+#include <uapi/linux/mshv.h>
+
+/*
+ * Hyper-V hypercalls
+ */
+
+int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+			     union hv_input_vtl input_vtl,
+			     struct hv_register_assoc *registers);
+int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+			     union hv_input_vtl input_vtl,
+			     struct hv_register_assoc *registers);
+
+/* Below hv_call_ helpers are currently only used by mshv_root module */
+int hv_call_withdraw_memory(u64 count, int node, u64 partition_id);
+int hv_call_create_partition(u64 flags,
+			     struct hv_partition_creation_properties creation_properties,
+			     union hv_partition_isolation_properties isolation_properties,
+			     u64 *partition_id);
+int hv_call_initialize_partition(u64 partition_id);
+int hv_call_finalize_partition(u64 partition_id);
+int hv_call_delete_partition(u64 partition_id);
+int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
+			  u32 flags, struct page **pages);
+int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
+			    u32 flags);
+int hv_call_get_gpa_access_states(u64 partition_id, u32 count,
+				  u64 gpa_base_pfn, u64 state_flags,
+				  int *written_total,
+				  union hv_gpa_page_access_state *states);
+int hv_call_install_intercept(u64 partition_id, u32 access_type,
+			      enum hv_intercept_type intercept_type,
+			      union hv_intercept_parameters intercept_parameter);
+int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector, u64 dest_addr,
+				     union hv_interrupt_control control);
+int hv_call_clear_virtual_interrupt(u64 partition_id);
+
+#ifdef HV_SUPPORTS_VP_STATE
+int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
+			 enum hv_get_set_vp_state_type type,
+			 struct hv_vp_state_data_xsave xsave,
+			 /* Choose between pages and ret_output */
+			 u64 page_count, struct page **pages,
+			 union hv_output_get_vp_state *ret_output);
+int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
+			 enum hv_get_set_vp_state_type type,
+			 struct hv_vp_state_data_xsave xsave,
+			 /* Choose between pages and bytes */
+			 u64 page_count, struct page **pages,
+			 u32 num_bytes, u8 *bytes);
+#endif
+
+int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+			      struct page **state_page);
+int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type);
+int hv_call_get_partition_property(u64 partition_id, u64 property_code,
+				   u64 *property_value);
+int hv_call_set_partition_property(u64 partition_id, u64 property_code,
+				   u64 property_value,
+				   void (*completion_handler)(void * /* data */,
+							      u64 * /* status */),
+				   void *completion_data);
+int hv_call_translate_virtual_address(u32 vp_index, u64 partition_id, u64 flags,
+				      u64 gva, u64 *gpa,
+				      union hv_translate_gva_result *result);
+int hv_call_get_vp_cpuid_values(u32 vp_index, u64 partition_id,
+				union hv_get_vp_cpuid_values_flags values_flags,
+				struct hv_cpuid_leaf_info *info,
+				union hv_output_get_vp_cpuid_values *result);
+int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
+			u64 connection_partition_id, struct hv_port_info *port_info,
+			u8 port_vtl, u8 min_connection_vtl, int node);
+int hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id);
+int hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
+			 u64 connection_partition_id,
+			 union hv_connection_id connection_id,
+			 struct hv_connection_info *connection_info,
+			 u8 connection_vtl, int node);
+int hv_call_disconnect_port(u64 connection_partition_id,
+			    union hv_connection_id connection_id);
+int hv_call_notify_port_ring_empty(u32 sint_index);
+#ifdef HV_SUPPORTS_REGISTER_INTERCEPT
+int hv_call_register_intercept_result(u32 vp_index, u64 partition_id,
+				      enum hv_intercept_type intercept_type,
+				      union hv_register_intercept_result_parameters *params);
+#endif
+int hv_call_signal_event_direct(u32 vp_index,
+				u64 partition_id,
+				u8 vtl,
+				u8 sint,
+				u16 flag_number,
+				u8 *newly_signaled);
+int hv_call_post_message_direct(u32 vp_index,
+				u64 partition_id,
+				u8 vtl,
+				u32 sint_index,
+				u8 *message);
+
+struct mshv_partition *mshv_partition_find(u64 partition_id) __must_hold(RCU);
+
+int mshv_xfer_to_guest_mode_handle_work(unsigned long ti_work);
+
+typedef long (*mshv_create_func_t)(void __user *user_arg);
+typedef long (*mshv_check_ext_func_t)(u32 arg);
+int mshv_setup_vtl_func(const mshv_create_func_t create_vtl,
+			const mshv_check_ext_func_t check_ext);
+int mshv_set_create_partition_func(const mshv_create_func_t func);
+
+#endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
new file mode 100644
index 000000000000..3462b57f1a5a
--- /dev/null
+++ b/drivers/hv/mshv_eventfd.c
@@ -0,0 +1,761 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * eventfd support for mshv
+ *
+ * Heavily inspired from KVM implementation of irqfd/ioeventfd. The basic
+ * framework code is taken from the kvm implementation.
+ *
+ * All credits to kvm developers.
+ */
+
+#include <linux/syscalls.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/file.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/eventfd.h>
+
+#include "mshv_eventfd.h"
+#include "mshv.h"
+#include "mshv_root.h"
+
+static struct workqueue_struct *irqfd_cleanup_wq;
+
+void
+mshv_register_irq_ack_notifier(struct mshv_partition *partition,
+			       struct mshv_irq_ack_notifier *mian)
+{
+	mutex_lock(&partition->irq_lock);
+	hlist_add_head_rcu(&mian->link, &partition->irq_ack_notifier_list);
+	mutex_unlock(&partition->irq_lock);
+}
+
+void
+mshv_unregister_irq_ack_notifier(struct mshv_partition *partition,
+				 struct mshv_irq_ack_notifier *mian)
+{
+	mutex_lock(&partition->irq_lock);
+	hlist_del_init_rcu(&mian->link);
+	mutex_unlock(&partition->irq_lock);
+	synchronize_rcu();
+}
+
+bool
+mshv_notify_acked_gsi(struct mshv_partition *partition, int gsi)
+{
+	struct mshv_irq_ack_notifier *mian;
+	bool acked = false;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(mian, &partition->irq_ack_notifier_list,
+				 link) {
+		if (mian->gsi == gsi) {
+			mian->irq_acked(mian);
+			acked = true;
+		}
+	}
+	rcu_read_unlock();
+
+	return acked;
+}
+
+static inline bool hv_should_clear_interrupt(enum hv_interrupt_type type)
+{
+	return type == HV_X64_INTERRUPT_TYPE_EXTINT;
+}
+
+static void
+irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
+{
+	struct mshv_kernel_irqfd_resampler *resampler;
+	struct mshv_partition *partition;
+	struct mshv_kernel_irqfd *irqfd;
+	int idx;
+
+	resampler = container_of(mian, struct mshv_kernel_irqfd_resampler,
+				 notifier);
+	partition = resampler->partition;
+
+	idx = srcu_read_lock(&partition->irq_srcu);
+
+	hlist_for_each_entry_rcu(irqfd, &resampler->irqfds_list, resampler_hnode) {
+		if (hv_should_clear_interrupt(irqfd->lapic_irq.control.interrupt_type))
+			hv_call_clear_virtual_interrupt(partition->id);
+
+		eventfd_signal(irqfd->resamplefd, 1);
+	}
+
+	srcu_read_unlock(&partition->irq_srcu, idx);
+}
+
+static void
+irqfd_assert(struct work_struct *work)
+{
+	struct mshv_kernel_irqfd *irqfd = container_of(work,
+						       struct mshv_kernel_irqfd,
+						       assert);
+	struct mshv_lapic_irq *irq = &irqfd->lapic_irq;
+
+	hv_call_assert_virtual_interrupt(irqfd->partition->id,
+					 irq->vector, irq->apic_id,
+					 irq->control);
+}
+
+static void
+irqfd_inject(struct mshv_kernel_irqfd *irqfd)
+{
+	struct mshv_partition *partition = irqfd->partition;
+	struct mshv_lapic_irq *irq = &irqfd->lapic_irq;
+	unsigned int seq;
+	int idx;
+
+	WARN_ON(irqfd->resampler &&
+		!irq->control.level_triggered);
+
+	idx = srcu_read_lock(&partition->irq_srcu);
+	if (irqfd->msi_entry.gsi) {
+		if (!irqfd->msi_entry.entry_valid) {
+			pr_warn("Invalid routing info for gsi %u",
+				irqfd->msi_entry.gsi);
+			srcu_read_unlock(&partition->irq_srcu, idx);
+			return;
+		}
+
+		do {
+			seq = read_seqcount_begin(&irqfd->msi_entry_sc);
+		} while (read_seqcount_retry(&irqfd->msi_entry_sc, seq));
+	}
+
+	srcu_read_unlock(&partition->irq_srcu, idx);
+
+	schedule_work(&irqfd->assert);
+}
+
+static void
+irqfd_resampler_shutdown(struct mshv_kernel_irqfd *irqfd)
+{
+	struct mshv_kernel_irqfd_resampler *resampler = irqfd->resampler;
+	struct mshv_partition *partition = resampler->partition;
+
+	mutex_lock(&partition->irqfds.resampler_lock);
+
+	hlist_del_rcu(&irqfd->resampler_hnode);
+	synchronize_srcu(&partition->irq_srcu);
+
+	if (hlist_empty(&resampler->irqfds_list)) {
+		hlist_del(&resampler->hnode);
+		mshv_unregister_irq_ack_notifier(partition, &resampler->notifier);
+		kfree(resampler);
+	}
+
+	mutex_unlock(&partition->irqfds.resampler_lock);
+}
+
+/*
+ * Race-free decouple logic (ordering is critical)
+ */
+static void
+irqfd_shutdown(struct work_struct *work)
+{
+	struct mshv_kernel_irqfd *irqfd = container_of(work,
+						       struct mshv_kernel_irqfd,
+						       shutdown);
+
+	/*
+	 * Synchronize with the wait-queue and unhook ourselves to prevent
+	 * further events.
+	 */
+	remove_wait_queue(irqfd->wqh, &irqfd->wait);
+
+	if (irqfd->resampler) {
+		irqfd_resampler_shutdown(irqfd);
+		eventfd_ctx_put(irqfd->resamplefd);
+	}
+
+	/*
+	 * We know no new events will be scheduled at this point, so block
+	 * until all previously outstanding events have completed
+	 */
+	flush_work(&irqfd->assert);
+
+	/*
+	 * It is now safe to release the object's resources
+	 */
+	eventfd_ctx_put(irqfd->eventfd);
+	kfree(irqfd);
+}
+
+/* assumes partition->irqfds.lock is held */
+static bool
+irqfd_is_active(struct mshv_kernel_irqfd *irqfd)
+{
+	return !hlist_unhashed(&irqfd->hnode);
+}
+
+/*
+ * Mark the irqfd as inactive and schedule it for removal
+ *
+ * assumes partition->irqfds.lock is held
+ */
+static void
+irqfd_deactivate(struct mshv_kernel_irqfd *irqfd)
+{
+	WARN_ON(!irqfd_is_active(irqfd));
+
+	hlist_del(&irqfd->hnode);
+
+	queue_work(irqfd_cleanup_wq, &irqfd->shutdown);
+}
+
+/*
+ * Called with wqh->lock held and interrupts disabled
+ */
+static int
+irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
+	     int sync, void *key)
+{
+	struct mshv_kernel_irqfd *irqfd = container_of(wait,
+						       struct mshv_kernel_irqfd,
+						       wait);
+	unsigned long flags = (unsigned long)key;
+	int idx;
+	unsigned int seq;
+	struct mshv_partition *partition = irqfd->partition;
+	int ret = 0;
+
+	if (flags & POLLIN) {
+		u64 cnt;
+
+		eventfd_ctx_do_read(irqfd->eventfd, &cnt);
+		idx = srcu_read_lock(&partition->irq_srcu);
+		do {
+			seq = read_seqcount_begin(&irqfd->msi_entry_sc);
+		} while (read_seqcount_retry(&irqfd->msi_entry_sc, seq));
+
+		/* An event has been signaled, inject an interrupt */
+		irqfd_inject(irqfd);
+		srcu_read_unlock(&partition->irq_srcu, idx);
+
+		ret = 1;
+	}
+
+	if (flags & POLLHUP) {
+		/* The eventfd is closing, detach from Partition */
+		unsigned long flags;
+
+		spin_lock_irqsave(&partition->irqfds.lock, flags);
+
+		/*
+		 * We must check if someone deactivated the irqfd before
+		 * we could acquire the irqfds.lock since the item is
+		 * deactivated from the mshv side before it is unhooked from
+		 * the wait-queue.  If it is already deactivated, we can
+		 * simply return knowing the other side will cleanup for us.
+		 * We cannot race against the irqfd going away since the
+		 * other side is required to acquire wqh->lock, which we hold
+		 */
+		if (irqfd_is_active(irqfd))
+			irqfd_deactivate(irqfd);
+
+		spin_unlock_irqrestore(&partition->irqfds.lock, flags);
+	}
+
+	return ret;
+}
+
+/* Must be called under irqfds.lock */
+static void irqfd_update(struct mshv_partition *partition,
+			 struct mshv_kernel_irqfd *irqfd)
+{
+	write_seqcount_begin(&irqfd->msi_entry_sc);
+	irqfd->msi_entry = mshv_msi_map_gsi(partition, irqfd->gsi);
+	mshv_set_msi_irq(&irqfd->msi_entry, &irqfd->lapic_irq);
+	write_seqcount_end(&irqfd->msi_entry_sc);
+}
+
+void mshv_irqfd_routing_update(struct mshv_partition *partition)
+{
+	struct mshv_kernel_irqfd *irqfd;
+
+	spin_lock_irq(&partition->irqfds.lock);
+	hlist_for_each_entry(irqfd, &partition->irqfds.items, hnode)
+		irqfd_update(partition, irqfd);
+	spin_unlock_irq(&partition->irqfds.lock);
+}
+
+static void
+irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
+			poll_table *pt)
+{
+	struct mshv_kernel_irqfd *irqfd = container_of(pt,
+						       struct mshv_kernel_irqfd,
+						       pt);
+
+	irqfd->wqh = wqh;
+	add_wait_queue_priority(wqh, &irqfd->wait);
+}
+
+static int
+mshv_irqfd_assign(struct mshv_partition *partition,
+		  struct mshv_irqfd *args)
+{
+	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
+	struct mshv_kernel_irqfd *irqfd, *tmp;
+	unsigned int events;
+	struct fd f;
+	int ret;
+	int idx;
+
+	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
+	if (!irqfd)
+		return -ENOMEM;
+
+	irqfd->partition = partition;
+	irqfd->gsi = args->gsi;
+	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
+	INIT_WORK(&irqfd->assert, irqfd_assert);
+	seqcount_spinlock_init(&irqfd->msi_entry_sc,
+			       &partition->irqfds.lock);
+
+	f = fdget(args->fd);
+	if (!f.file) {
+		ret = -EBADF;
+		goto out;
+	}
+
+	eventfd = eventfd_ctx_fileget(f.file);
+	if (IS_ERR(eventfd)) {
+		ret = PTR_ERR(eventfd);
+		goto fail;
+	}
+
+	irqfd->eventfd = eventfd;
+
+	if (args->flags & MSHV_IRQFD_FLAG_RESAMPLE) {
+		struct mshv_kernel_irqfd_resampler *resampler;
+
+		resamplefd = eventfd_ctx_fdget(args->resamplefd);
+		if (IS_ERR(resamplefd)) {
+			ret = PTR_ERR(resamplefd);
+			goto fail;
+		}
+
+		irqfd->resamplefd = resamplefd;
+
+		mutex_lock(&partition->irqfds.resampler_lock);
+
+		hlist_for_each_entry(resampler,
+				     &partition->irqfds.resampler_list, hnode) {
+			if (resampler->notifier.gsi == irqfd->gsi) {
+				irqfd->resampler = resampler;
+				break;
+			}
+		}
+
+		if (!irqfd->resampler) {
+			resampler = kzalloc(sizeof(*resampler),
+					    GFP_KERNEL_ACCOUNT);
+			if (!resampler) {
+				ret = -ENOMEM;
+				mutex_unlock(&partition->irqfds.resampler_lock);
+				goto fail;
+			}
+
+			resampler->partition = partition;
+			INIT_HLIST_HEAD(&resampler->irqfds_list);
+			resampler->notifier.gsi = irqfd->gsi;
+			resampler->notifier.irq_acked = irqfd_resampler_ack;
+
+			hlist_add_head(&resampler->hnode, &partition->irqfds.resampler_list);
+			mshv_register_irq_ack_notifier(partition,
+						       &resampler->notifier);
+			irqfd->resampler = resampler;
+		}
+
+		hlist_add_head_rcu(&irqfd->resampler_hnode, &irqfd->resampler->irqfds_list);
+
+		mutex_unlock(&partition->irqfds.resampler_lock);
+	}
+
+	/*
+	 * Install our own custom wake-up handling so we are notified via
+	 * a callback whenever someone signals the underlying eventfd
+	 */
+	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
+	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
+
+	spin_lock_irq(&partition->irqfds.lock);
+	if (args->flags & MSHV_IRQFD_FLAG_RESAMPLE &&
+	    !irqfd->lapic_irq.control.level_triggered) {
+		/*
+		 * Resample Fd must be for level triggered interrupt
+		 * Otherwise return with failure
+		 */
+		spin_unlock_irq(&partition->irqfds.lock);
+		ret = -EINVAL;
+		goto fail;
+	}
+	ret = 0;
+	hlist_for_each_entry(tmp, &partition->irqfds.items, hnode) {
+		if (irqfd->eventfd != tmp->eventfd)
+			continue;
+		/* This fd is used for another irq already. */
+		ret = -EBUSY;
+		spin_unlock_irq(&partition->irqfds.lock);
+		goto fail;
+	}
+
+	idx = srcu_read_lock(&partition->irq_srcu);
+	irqfd_update(partition, irqfd);
+	hlist_add_head(&irqfd->hnode, &partition->irqfds.items);
+	spin_unlock_irq(&partition->irqfds.lock);
+
+	/*
+	 * Check if there was an event already pending on the eventfd
+	 * before we registered, and trigger it as if we didn't miss it.
+	 */
+	events = vfs_poll(f.file, &irqfd->pt);
+
+	if (events & POLLIN)
+		irqfd_inject(irqfd);
+
+	srcu_read_unlock(&partition->irq_srcu, idx);
+	/*
+	 * do not drop the file until the irqfd is fully initialized, otherwise
+	 * we might race against the POLLHUP
+	 */
+	fdput(f);
+
+	return 0;
+
+fail:
+	if (irqfd->resampler)
+		irqfd_resampler_shutdown(irqfd);
+
+	if (resamplefd && !IS_ERR(resamplefd))
+		eventfd_ctx_put(resamplefd);
+
+	if (eventfd && !IS_ERR(eventfd))
+		eventfd_ctx_put(eventfd);
+
+	fdput(f);
+
+out:
+	kfree(irqfd);
+	return ret;
+}
+
+/*
+ * shutdown any irqfd's that match fd+gsi
+ */
+static int
+mshv_irqfd_deassign(struct mshv_partition *partition,
+		    struct mshv_irqfd *args)
+{
+	struct mshv_kernel_irqfd *irqfd;
+	struct hlist_node *n;
+	struct eventfd_ctx *eventfd;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	hlist_for_each_entry_safe(irqfd, n, &partition->irqfds.items, hnode) {
+		if (irqfd->eventfd == eventfd && irqfd->gsi == args->gsi)
+			irqfd_deactivate(irqfd);
+	}
+
+	eventfd_ctx_put(eventfd);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed
+	 * so that we guarantee there will not be any more interrupts on this
+	 * gsi once this deassign function returns.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+
+	return 0;
+}
+
+int
+mshv_irqfd(struct mshv_partition *partition, struct mshv_irqfd *args)
+{
+	if (args->flags & MSHV_IRQFD_FLAG_DEASSIGN)
+		return mshv_irqfd_deassign(partition, args);
+
+	return mshv_irqfd_assign(partition, args);
+}
+
+/*
+ * This function is called as the mshv VM fd is being released.
+ * Shutdown all irqfds that still remain open
+ */
+static void
+mshv_irqfd_release(struct mshv_partition *partition)
+{
+	struct mshv_kernel_irqfd *irqfd;
+	struct hlist_node *n;
+
+	spin_lock_irq(&partition->irqfds.lock);
+
+	hlist_for_each_entry_safe(irqfd, n, &partition->irqfds.items, hnode)
+		irqfd_deactivate(irqfd);
+
+	spin_unlock_irq(&partition->irqfds.lock);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed
+	 * since we do not take a mshv_partition* reference.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+}
+
+int mshv_irqfd_wq_init(void)
+{
+	irqfd_cleanup_wq = alloc_workqueue("mshv-irqfd-cleanup", 0, 0);
+	if (!irqfd_cleanup_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void mshv_irqfd_wq_cleanup(void)
+{
+	destroy_workqueue(irqfd_cleanup_wq);
+}
+
+/*
+ * --------------------------------------------------------------------
+ * ioeventfd: translate a MMIO memory write to an eventfd signal.
+ *
+ * userspace can register a MMIO address with an eventfd for receiving
+ * notification when the memory has been touched.
+ *
+ * TODO: Implement eventfd for PIO as well.
+ * --------------------------------------------------------------------
+ */
+
+static void
+ioeventfd_release(struct kernel_mshv_ioeventfd *p, u64 partition_id)
+{
+	if (p->doorbell_id > 0)
+		mshv_unregister_doorbell(partition_id, p->doorbell_id);
+	eventfd_ctx_put(p->eventfd);
+	kfree(p);
+}
+
+/* MMIO writes trigger an event if the addr/val match */
+static void
+ioeventfd_mmio_write(int doorbell_id, void *data)
+{
+	struct mshv_partition *partition = (struct mshv_partition *)data;
+	struct kernel_mshv_ioeventfd *p;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(p, &partition->ioeventfds.items, hnode) {
+		if (p->doorbell_id == doorbell_id) {
+			eventfd_signal(p->eventfd, 1);
+			break;
+		}
+	}
+	rcu_read_unlock();
+}
+
+static bool
+ioeventfd_check_collision(struct mshv_partition *partition,
+			  struct kernel_mshv_ioeventfd *p)
+	__must_hold(&partition->mutex)
+{
+	struct kernel_mshv_ioeventfd *_p;
+
+	hlist_for_each_entry(_p, &partition->ioeventfds.items, hnode)
+		if (_p->addr == p->addr && _p->length == p->length &&
+		    (_p->wildcard || p->wildcard ||
+		     _p->datamatch == p->datamatch))
+			return true;
+
+	return false;
+}
+
+static int
+mshv_assign_ioeventfd(struct mshv_partition *partition,
+		      struct mshv_ioeventfd *args)
+	__must_hold(&partition->mutex)
+{
+	struct kernel_mshv_ioeventfd *p;
+	struct eventfd_ctx *eventfd;
+	u64 doorbell_flags = 0;
+	int ret;
+
+	/* This mutex is currently protecting ioeventfd.items list */
+	WARN_ON_ONCE(!mutex_is_locked(&partition->mutex));
+
+	if (args->flags & MSHV_IOEVENTFD_FLAG_PIO)
+		return -EOPNOTSUPP;
+
+	/* must be natural-word sized */
+	switch (args->len) {
+	case 0:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_ANY;
+		break;
+	case 1:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_BYTE;
+		break;
+	case 2:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_WORD;
+		break;
+	case 4:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_DWORD;
+		break;
+	case 8:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_QWORD;
+		break;
+	default:
+		pr_warn("ioeventfd: invalid length specified\n");
+		return -EINVAL;
+	}
+
+	/* check for range overflow */
+	if (args->addr + args->len < args->addr)
+		return -EINVAL;
+
+	/* check for extra flags that we don't understand */
+	if (args->flags & ~MSHV_IOEVENTFD_VALID_FLAG_MASK)
+		return -EINVAL;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	p->addr    = args->addr;
+	p->length  = args->len;
+	p->eventfd = eventfd;
+
+	/* The datamatch feature is optional, otherwise this is a wildcard */
+	if (args->flags & MSHV_IOEVENTFD_FLAG_DATAMATCH) {
+		p->datamatch = args->datamatch;
+	} else {
+		p->wildcard = true;
+		doorbell_flags |= HV_DOORBELL_FLAG_TRIGGER_ANY_VALUE;
+	}
+
+	if (ioeventfd_check_collision(partition, p)) {
+		ret = -EEXIST;
+		goto unlock_fail;
+	}
+
+	ret = mshv_register_doorbell(partition->id, ioeventfd_mmio_write,
+				     (void *)partition, p->addr,
+				     p->datamatch, doorbell_flags);
+	if (ret < 0) {
+		pr_err("Failed to register ioeventfd doorbell!\n");
+		goto unlock_fail;
+	}
+
+	p->doorbell_id = ret;
+
+	hlist_add_head_rcu(&p->hnode, &partition->ioeventfds.items);
+
+	return 0;
+
+unlock_fail:
+	kfree(p);
+
+fail:
+	eventfd_ctx_put(eventfd);
+
+	return ret;
+}
+
+static int
+mshv_deassign_ioeventfd(struct mshv_partition *partition,
+			struct mshv_ioeventfd *args)
+	__must_hold(&partition->mutex)
+{
+	struct kernel_mshv_ioeventfd *p;
+	struct eventfd_ctx *eventfd;
+	struct hlist_node *n;
+	int ret = -ENOENT;
+
+	/* This mutex is currently protecting ioeventfd.items list */
+	WARN_ON_ONCE(!mutex_is_locked(&partition->mutex));
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	hlist_for_each_entry_safe(p, n, &partition->ioeventfds.items, hnode) {
+		bool wildcard = !(args->flags & MSHV_IOEVENTFD_FLAG_DATAMATCH);
+
+		if (p->eventfd != eventfd  ||
+		    p->addr != args->addr  ||
+		    p->length != args->len ||
+		    p->wildcard != wildcard)
+			continue;
+
+		if (!p->wildcard && p->datamatch != args->datamatch)
+			continue;
+
+		hlist_del_rcu(&p->hnode);
+		synchronize_rcu();
+		ioeventfd_release(p, partition->id);
+		ret = 0;
+		break;
+	}
+
+	eventfd_ctx_put(eventfd);
+
+	return ret;
+}
+
+int
+mshv_ioeventfd(struct mshv_partition *partition,
+	       struct mshv_ioeventfd *args)
+	__must_hold(&partition->mutex)
+{
+	/* PIO not yet implemented */
+	if (args->flags & MSHV_IOEVENTFD_FLAG_PIO)
+		return -EOPNOTSUPP;
+
+	if (args->flags & MSHV_IOEVENTFD_FLAG_DEASSIGN)
+		return mshv_deassign_ioeventfd(partition, args);
+
+	return mshv_assign_ioeventfd(partition, args);
+}
+
+void
+mshv_eventfd_init(struct mshv_partition *partition)
+{
+	spin_lock_init(&partition->irqfds.lock);
+	INIT_HLIST_HEAD(&partition->irqfds.items);
+
+	INIT_HLIST_HEAD(&partition->irqfds.resampler_list);
+	mutex_init(&partition->irqfds.resampler_lock);
+
+	INIT_HLIST_HEAD(&partition->ioeventfds.items);
+}
+
+void
+mshv_eventfd_release(struct mshv_partition *partition)
+{
+	struct hlist_head items;
+	struct hlist_node *n;
+	struct kernel_mshv_ioeventfd *p;
+
+	hlist_move_list(&partition->ioeventfds.items, &items);
+	synchronize_rcu();
+
+	hlist_for_each_entry_safe(p, n, &items, hnode) {
+		hlist_del(&p->hnode);
+		ioeventfd_release(p, partition->id);
+	}
+
+	mshv_irqfd_release(partition);
+}
diff --git a/drivers/hv/mshv_eventfd.h b/drivers/hv/mshv_eventfd.h
new file mode 100644
index 000000000000..72a3a39d63f9
--- /dev/null
+++ b/drivers/hv/mshv_eventfd.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * irqfd: Allows an fd to be used to inject an interrupt to the guest.
+ * ioeventfd: Allow an fd to be used to receive a signal from the guest.
+ * All credit goes to kvm developers.
+ */
+
+#ifndef __LINUX_MSHV_EVENTFD_H
+#define __LINUX_MSHV_EVENTFD_H
+
+#include <linux/poll.h>
+
+#include "mshv.h"
+#include "mshv_root.h"
+
+void mshv_eventfd_init(struct mshv_partition *partition);
+void mshv_eventfd_release(struct mshv_partition *partition);
+
+void mshv_register_irq_ack_notifier(struct mshv_partition *partition,
+				    struct mshv_irq_ack_notifier *mian);
+void mshv_unregister_irq_ack_notifier(struct mshv_partition *partition,
+				      struct mshv_irq_ack_notifier *mian);
+bool mshv_notify_acked_gsi(struct mshv_partition *partition, int gsi);
+
+struct mshv_kernel_irqfd_resampler {
+	struct mshv_partition *partition;
+	/*
+	 * List of irqfds sharing this gsi.
+	 * Protected by irqfds.resampler_lock
+	 * and irq_srcu.
+	 */
+	struct hlist_head irqfds_list;
+	struct mshv_irq_ack_notifier notifier;
+	/*
+	 * Entry in the list of partition->irqfd.resampler_list.
+	 * Protected by irqfds.resampler_lock
+	 *
+	 */
+	struct hlist_node hnode;
+};
+
+struct mshv_kernel_irqfd {
+	struct mshv_partition                *partition;
+	struct eventfd_ctx                   *eventfd;
+	struct mshv_kernel_msi_routing_entry msi_entry;
+	seqcount_spinlock_t                  msi_entry_sc;
+	u32                                  gsi;
+	struct mshv_lapic_irq                lapic_irq;
+	struct hlist_node                    hnode;
+	poll_table                           pt;
+	wait_queue_head_t                    *wqh;
+	wait_queue_entry_t                   wait;
+	struct work_struct                   assert;
+	struct work_struct                   shutdown;
+
+	/* Resampler related */
+	struct mshv_kernel_irqfd_resampler   *resampler;
+	struct eventfd_ctx                   *resamplefd;
+	struct hlist_node                    resampler_hnode;
+};
+
+int mshv_irqfd(struct mshv_partition *partition,
+	       struct mshv_irqfd *args);
+
+int mshv_irqfd_wq_init(void);
+void mshv_irqfd_wq_cleanup(void);
+
+struct kernel_mshv_ioeventfd {
+	struct hlist_node    hnode;
+	u64                  addr;
+	int                  length;
+	struct eventfd_ctx  *eventfd;
+	u64                  datamatch;
+	int                  doorbell_id;
+	bool                 wildcard;
+};
+
+int mshv_ioeventfd(struct mshv_partition *kvm, struct mshv_ioeventfd *args);
+
+#endif /* __LINUX_MSHV_EVENTFD_H */
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
new file mode 100644
index 000000000000..d0882936a8cc
--- /dev/null
+++ b/drivers/hv/mshv_main.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * The /dev/mshv device.
+ * This is the core module mshv_root and mshv_vtl depend on.
+ *
+ * Authors:
+ *   Nuno Das Neves <nudasnev@microsoft.com>
+ *   Lillian Grassin-Drake <ligrassi@microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/cpuhotplug.h>
+#include <linux/random.h>
+#include <linux/nospec.h>
+#include <asm/mshyperv.h>
+
+#include "mshv_eventfd.h"
+#include "mshv.h"
+
+MODULE_AUTHOR("Microsoft");
+MODULE_LICENSE("GPL");
+
+static long mshv_ioctl_dummy(void __user *user_arg)
+{
+	return -ENOTTY;
+}
+
+static long mshv_check_ext_dummy(u32 arg)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct mshv {
+	struct mutex		mutex;
+	mshv_create_func_t	create_vtl;
+	mshv_create_func_t	create_partition;
+	mshv_check_ext_func_t	check_extension;
+} mshv = {
+	.create_vtl		= mshv_ioctl_dummy,
+	.create_partition	= mshv_ioctl_dummy,
+	.check_extension	= mshv_check_ext_dummy,
+};
+
+static int mshv_register_dev(void);
+static void mshv_deregister_dev(void);
+
+int mshv_setup_vtl_func(const mshv_create_func_t create_vtl,
+			const mshv_check_ext_func_t check_ext)
+{
+	int ret;
+
+	mutex_lock(&mshv.mutex);
+	if (create_vtl && check_ext) {
+		ret = mshv_register_dev();
+		if (ret)
+			goto unlock;
+		mshv.create_vtl = create_vtl;
+		mshv.check_extension = check_ext;
+	} else {
+		mshv.create_vtl = mshv_ioctl_dummy;
+		mshv.check_extension = mshv_check_ext_dummy;
+		mshv_deregister_dev();
+		ret = 0;
+	}
+
+unlock:
+	mutex_unlock(&mshv.mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mshv_setup_vtl_func);
+
+int mshv_set_create_partition_func(const mshv_create_func_t func)
+{
+	int ret;
+
+	mutex_lock(&mshv.mutex);
+	if (func) {
+		ret = mshv_register_dev();
+		if (ret)
+			goto unlock;
+		mshv.create_partition = func;
+	} else {
+		mshv.create_partition = mshv_ioctl_dummy;
+		mshv_deregister_dev();
+		ret = 0;
+	}
+	mshv.check_extension = mshv_check_ext_dummy;
+
+unlock:
+	mutex_unlock(&mshv.mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mshv_set_create_partition_func);
+
+static int mshv_dev_open(struct inode *inode, struct file *filp);
+static int mshv_dev_release(struct inode *inode, struct file *filp);
+static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
+
+static const struct file_operations mshv_dev_fops = {
+	.owner = THIS_MODULE,
+	.open = mshv_dev_open,
+	.release = mshv_dev_release,
+	.unlocked_ioctl = mshv_dev_ioctl,
+	.llseek = noop_llseek,
+};
+
+static struct miscdevice mshv_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "mshv",
+	.fops = &mshv_dev_fops,
+	.mode = 0600,
+};
+
+static int mshv_register_dev(void)
+{
+	int ret;
+
+	if (mshv_dev.this_device &&
+	    device_is_registered(mshv_dev.this_device)) {
+		pr_err("%s: mshv device already registered\n", __func__);
+		return -ENODEV;
+	}
+
+	ret = misc_register(&mshv_dev);
+	if (ret)
+		pr_err("%s: mshv device register failed\n", __func__);
+
+	return ret;
+}
+
+static void mshv_deregister_dev(void)
+{
+	misc_deregister(&mshv_dev);
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
+	}
+
+	return mshv.check_extension(arg);
+}
+
+static long
+mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	switch (ioctl) {
+	case MSHV_CHECK_EXTENSION:
+		return mshv_ioctl_check_extension((void __user *)arg);
+	case MSHV_CREATE_PARTITION:
+		return mshv.create_partition((void __user *)arg);
+	case MSHV_CREATE_VTL:
+		return mshv.create_vtl((void __user *)arg);
+	}
+
+	return -ENOTTY;
+}
+
+static int
+mshv_dev_open(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int
+mshv_dev_release(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int
+__init mshv_init(void)
+{
+	if (!hv_is_hyperv_initialized())
+		return -ENODEV;
+
+	mutex_init(&mshv.mutex);
+
+	return 0;
+}
+
+static void
+__exit mshv_exit(void)
+{
+}
+
+module_init(mshv_init);
+module_exit(mshv_exit);
diff --git a/drivers/hv/mshv_msi.c b/drivers/hv/mshv_msi.c
new file mode 100644
index 000000000000..c89770df5bd0
--- /dev/null
+++ b/drivers/hv/mshv_msi.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * Authors:
+ *   Vineeth Remanan Pillai <viremana@linux.microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <asm/mshyperv.h>
+
+#include "mshv_eventfd.h"
+#include "mshv.h"
+#include "mshv_root.h"
+
+MODULE_AUTHOR("Microsoft");
+MODULE_LICENSE("GPL");
+
+int mshv_set_msi_routing(struct mshv_partition *partition,
+			 const struct mshv_msi_routing_entry *ue,
+			 unsigned int nr)
+{
+	struct mshv_msi_routing_table *new = NULL, *old;
+	u32 i, nr_rt_entries = 0;
+	int r = 0;
+
+	if (nr == 0)
+		goto swap_routes;
+
+	for (i = 0; i < nr; i++) {
+		if (ue[i].gsi >= MSHV_MAX_MSI_ROUTES)
+			return -EINVAL;
+
+		if (ue[i].address_hi)
+			return -EINVAL;
+
+		nr_rt_entries = max(nr_rt_entries, ue[i].gsi);
+	}
+	nr_rt_entries += 1;
+
+	new = kzalloc(struct_size(new, entries, nr_rt_entries),
+		      GFP_KERNEL_ACCOUNT);
+	if (!new)
+		return -ENOMEM;
+
+	new->nr_rt_entries = nr_rt_entries;
+	for (i = 0; i < nr; i++) {
+		struct mshv_kernel_msi_routing_entry *e;
+
+		e = &new->entries[ue[i].gsi];
+
+		/*
+		 * Allow only one to one mapping between GSI and MSI routing.
+		 */
+		if (e->gsi != 0) {
+			r = -EINVAL;
+			goto out;
+		}
+
+		e->gsi = ue[i].gsi;
+		e->address_lo = ue[i].address_lo;
+		e->address_hi = ue[i].address_hi;
+		e->data = ue[i].data;
+		e->entry_valid = true;
+	}
+
+swap_routes:
+	mutex_lock(&partition->irq_lock);
+	old = rcu_dereference_protected(partition->msi_routing, 1);
+	rcu_assign_pointer(partition->msi_routing, new);
+	mshv_irqfd_routing_update(partition);
+	mutex_unlock(&partition->irq_lock);
+
+	synchronize_srcu_expedited(&partition->irq_srcu);
+	new = old;
+
+out:
+	kfree(new);
+
+	return r;
+}
+
+void mshv_free_msi_routing(struct mshv_partition *partition)
+{
+	/*
+	 * Called only during vm destruction.
+	 * Nobody can use the pointer at this stage
+	 */
+	struct mshv_msi_routing_table *rt = rcu_access_pointer(partition->msi_routing);
+
+	kfree(rt);
+}
+
+struct mshv_kernel_msi_routing_entry
+mshv_msi_map_gsi(struct mshv_partition *partition, u32 gsi)
+{
+	struct mshv_kernel_msi_routing_entry entry = { 0 };
+	struct mshv_msi_routing_table *msi_rt;
+
+	msi_rt = srcu_dereference_check(partition->msi_routing,
+					&partition->irq_srcu,
+					lockdep_is_held(&partition->irq_lock));
+	if (!msi_rt) {
+		/*
+		 * Premature register_irqfd, setting valid_entry = 0
+		 * would ignore this entry anyway
+		 */
+		entry.gsi = gsi;
+		return entry;
+	}
+
+	return msi_rt->entries[gsi];
+}
+
+void mshv_set_msi_irq(struct mshv_kernel_msi_routing_entry *e,
+		      struct mshv_lapic_irq *irq)
+{
+	memset(irq, 0, sizeof(*irq));
+	if (!e || !e->entry_valid)
+		return;
+
+	irq->vector = e->data & 0xFF;
+	irq->apic_id = (e->address_lo >> 12) & 0xFF;
+	irq->control.interrupt_type = (e->data & 0x700) >> 8;
+	irq->control.level_triggered = (e->data >> 15) & 0x1;
+	irq->control.logical_dest_mode = (e->address_lo >> 2) & 0x1;
+}
diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
new file mode 100644
index 000000000000..88213d560e5e
--- /dev/null
+++ b/drivers/hv/mshv_portid_table.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <asm/mshyperv.h>
+
+#include "mshv.h"
+#include "mshv_root.h"
+
+/*
+ * Ports and connections are hypervisor struct used for inter-partition
+ * communication. Port represents the source and connection represents
+ * the destination. Partitions are responsible for managing the port and
+ * connection ids.
+ *
+ */
+
+#define PORTID_MIN	1
+#define PORTID_MAX	INT_MAX
+
+static DEFINE_IDR(port_table_idr);
+
+void
+mshv_port_table_fini(void)
+{
+	struct port_table_info *port_info;
+	unsigned long i, tmp;
+
+	idr_lock(&port_table_idr);
+	if (!idr_is_empty(&port_table_idr)) {
+		idr_for_each_entry_ul(&port_table_idr, port_info, tmp, i) {
+			port_info = idr_remove(&port_table_idr, i);
+			kfree_rcu(port_info, rcu);
+		}
+	}
+	idr_unlock(&port_table_idr);
+}
+
+int
+mshv_portid_alloc(struct port_table_info *info)
+{
+	int ret = 0;
+
+	idr_lock(&port_table_idr);
+	ret = idr_alloc(&port_table_idr, info, PORTID_MIN,
+			PORTID_MAX, GFP_KERNEL);
+	idr_unlock(&port_table_idr);
+
+	return ret;
+}
+
+void
+mshv_portid_free(int port_id)
+{
+	struct port_table_info *info;
+
+	idr_lock(&port_table_idr);
+	info = idr_remove(&port_table_idr, port_id);
+	WARN_ON(!info);
+	idr_unlock(&port_table_idr);
+
+	synchronize_rcu();
+	kfree(info);
+}
+
+int
+mshv_portid_lookup(int port_id, struct port_table_info *info)
+{
+	struct port_table_info *_info;
+	int ret = -ENOENT;
+
+	rcu_read_lock();
+	_info = idr_find(&port_table_idr, port_id);
+	rcu_read_unlock();
+
+	if (_info) {
+		*info = *_info;
+		ret = 0;
+	}
+
+	return ret;
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
new file mode 100644
index 000000000000..2c47a870832f
--- /dev/null
+++ b/drivers/hv/mshv_root.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ */
+
+#ifndef _MSHV_ROOT_H_
+#define _MSHV_ROOT_H_
+
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/semaphore.h>
+#include <linux/sched.h>
+#include <linux/srcu.h>
+#include <linux/wait.h>
+#include <linux/hashtable.h>
+#include <uapi/linux/mshv.h>
+
+/*
+ * Hypervisor must be between these version numbers (inclusive)
+ * to guarantee compatibility
+ */
+#define MSHV_HV_MIN_VERSION		(25212)
+#define MSHV_HV_MAX_VERSION		(25330)
+
+#define MSHV_PARTITIONS_HASH_BITS	9
+#define MSHV_MAX_VPS			256
+
+#define PIN_PAGES_BATCH_SIZE	(0x10000000 / HV_HYP_PAGE_SIZE)
+
+struct mshv_vp {
+	u32 index;
+	struct mshv_partition *partition;
+	struct mutex mutex;
+	struct page *register_page;
+	struct hv_message *intercept_message_page;
+	struct hv_register_assoc *registers;
+	struct {
+		atomic64_t signaled_count;
+		struct {
+			u64 explicit_suspend: 1;
+			u64 blocked_by_explicit_suspend: 1; /* root scheduler only */
+			u64 intercept_suspend: 1;
+			u64 blocked: 1; /* root scheduler only */
+			u64 reserved: 60;
+		} flags;
+		unsigned int kicked_by_hv;
+		wait_queue_head_t suspend_queue;
+	} run;
+};
+
+struct mshv_mem_region {
+	struct hlist_node hnode;
+	u64 size; /* bytes */
+	u64 guest_pfn;
+	u64 userspace_addr; /* start of the userspace allocated memory */
+	struct page *pages[];
+};
+
+struct mshv_irq_ack_notifier {
+	struct hlist_node link;
+	unsigned int gsi;
+	void (*irq_acked)(struct mshv_irq_ack_notifier *mian);
+};
+
+struct mshv_partition {
+	struct hlist_node hnode;
+	u64 id;
+	refcount_t ref_count;
+	struct mutex mutex;
+	struct hlist_head mem_regions; // not ordered
+	struct {
+		u32 count;
+		struct mshv_vp *array[MSHV_MAX_VPS];
+	} vps;
+
+	struct mutex irq_lock;
+	struct srcu_struct irq_srcu;
+	struct hlist_head irq_ack_notifier_list;
+
+	struct completion async_hypercall;
+
+	struct {
+		spinlock_t        lock;
+		struct hlist_head items;
+		struct mutex resampler_lock;
+		struct hlist_head resampler_list;
+	} irqfds;
+	struct {
+		struct hlist_head items;
+	} ioeventfds;
+	struct mshv_msi_routing_table __rcu *msi_routing;
+	u64 isolation_type;
+};
+
+struct mshv_lapic_irq {
+	u32 vector;
+	u64 apic_id;
+	union hv_interrupt_control control;
+};
+
+#define MSHV_MAX_MSI_ROUTES		4096
+
+struct mshv_kernel_msi_routing_entry {
+	u32 entry_valid;
+	u32 gsi;
+	u32 address_lo;
+	u32 address_hi;
+	u32 data;
+};
+
+struct mshv_msi_routing_table {
+	u32 nr_rt_entries;
+	struct mshv_kernel_msi_routing_entry entries[];
+};
+
+struct hv_synic_pages {
+	struct hv_message_page *synic_message_page;
+	struct hv_synic_event_flags_page *synic_event_flags_page;
+	struct hv_synic_event_ring_page *synic_event_ring_page;
+};
+
+struct mshv_root {
+	struct hv_synic_pages __percpu *synic_pages;
+	struct {
+		spinlock_t lock;
+		u64 count;
+		DECLARE_HASHTABLE(items, MSHV_PARTITIONS_HASH_BITS);
+	} partitions;
+};
+
+/*
+ * Callback for doorbell events.
+ * NOTE: This is called in interrupt context. Callback
+ * should defer slow and sleeping logic to later.
+ */
+typedef void (*doorbell_cb_t) (int doorbell_id, void *);
+
+/*
+ * port table information
+ */
+struct port_table_info {
+	struct rcu_head rcu;
+	enum hv_port_type port_type;
+	union {
+		struct {
+			u64 reserved[2];
+		} port_message;
+		struct {
+			u64 reserved[2];
+		} port_event;
+		struct {
+			u64 reserved[2];
+		} port_monitor;
+		struct {
+			doorbell_cb_t doorbell_cb;
+			void *data;
+		} port_doorbell;
+	};
+};
+
+int mshv_set_msi_routing(struct mshv_partition *partition,
+			 const struct mshv_msi_routing_entry *entries,
+			 unsigned int nr);
+void mshv_free_msi_routing(struct mshv_partition *partition);
+
+struct mshv_kernel_msi_routing_entry mshv_msi_map_gsi(struct mshv_partition *partition, u32 gsi);
+
+void mshv_set_msi_irq(struct mshv_kernel_msi_routing_entry *e,
+		      struct mshv_lapic_irq *irq);
+
+void mshv_irqfd_routing_update(struct mshv_partition *partition);
+
+void mshv_port_table_fini(void);
+int mshv_portid_alloc(struct port_table_info *info);
+int mshv_portid_lookup(int port_id, struct port_table_info *info);
+void mshv_portid_free(int port_id);
+
+int mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb,
+			   void *data, u64 gpa, u64 val, u64 flags);
+int mshv_unregister_doorbell(u64 partition_id, int doorbell_portid);
+
+void mshv_isr(void);
+int mshv_synic_init(unsigned int cpu);
+int mshv_synic_cleanup(unsigned int cpu);
+
+static inline bool mshv_partition_isolation_type_snp(struct mshv_partition *partition)
+{
+	return partition->isolation_type == HV_PARTITION_ISOLATION_TYPE_SNP;
+}
+
+extern struct mshv_root mshv_root;
+
+#endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
new file mode 100644
index 000000000000..33e21a6b1a83
--- /dev/null
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -0,0 +1,1015 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * Hypercall helper functions used by the mshv_root module.
+ *
+ * Authors:
+ *   Nuno Das Neves <nunodasneves@linux.microsoft.com>
+ *   Wei Liu <wei.liu@kernel.org>
+ *   Jinank Jain <jinankjain@microsoft.com>
+ *   Vineeth Remanan Pillai <viremana@linux.microsoft.com>
+ *   Asher Kariv <askariv@microsoft.com>
+ *   Muminul Islam <Muminul.Islam@microsoft.com>
+ *   Anatol Belski <anbelski@linux.microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <asm/mshyperv.h>
+
+/* Determined empirically */
+#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
+#define HV_MAP_GPA_DEPOSIT_PAGES	256
+
+#define HV_WITHDRAW_BATCH_SIZE	(HV_HYP_PAGE_SIZE / sizeof(u64))
+#define HV_MAP_GPA_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_map_gpa_pages)) \
+		/ sizeof(u64))
+#define HV_GET_VP_STATE_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_get_vp_state)) \
+		/ sizeof(u64))
+#define HV_SET_VP_STATE_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_state)) \
+		/ sizeof(u64))
+#define HV_GET_GPA_ACCESS_STATES_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(union hv_gpa_page_access_state)) \
+		/ sizeof(union hv_gpa_page_access_state))
+#define HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT                   \
+	((HV_HYP_PAGE_SIZE -                                                   \
+	  sizeof(struct hv_input_modify_sparse_spa_page_host_access)) /        \
+	 sizeof(u64))
+#define HV_ISOLATED_PAGE_BATCH_SIZE                                            \
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_import_isolated_pages)) /  \
+	 sizeof(u64))
+
+int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
+{
+	struct hv_input_withdraw_memory *input_page;
+	struct hv_output_withdraw_memory *output_page;
+	struct page *page;
+	u16 completed;
+	unsigned long remaining = count;
+	u64 status;
+	int i;
+	unsigned long flags;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+	output_page = page_address(page);
+
+	while (remaining) {
+		local_irq_save(flags);
+
+		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+		input_page->partition_id = partition_id;
+		input_page->proximity_domain_info =
+			numa_node_to_proximity_domain_info(node);
+		status = hv_do_rep_hypercall(HVCALL_WITHDRAW_MEMORY,
+					     min(remaining, HV_WITHDRAW_BATCH_SIZE),
+					     0, input_page, output_page);
+
+		local_irq_restore(flags);
+
+		completed = hv_repcomp(status);
+
+		for (i = 0; i < completed; i++)
+			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
+
+		if (!hv_result_success(status)) {
+			if (hv_result(status) == HV_STATUS_NO_RESOURCES)
+				status = HV_STATUS_SUCCESS;
+			else
+				pr_err("%s: %s\n", __func__,
+				       hv_status_to_string(status));
+			break;
+		}
+
+		remaining -= completed;
+	}
+	free_page((unsigned long)output_page);
+
+	return hv_status_to_errno(status);
+}
+
+int hv_call_create_partition(u64 flags,
+			     struct hv_partition_creation_properties creation_properties,
+			     union hv_partition_isolation_properties isolation_properties,
+			     u64 *partition_id)
+{
+	struct hv_input_create_partition *input;
+	struct hv_output_create_partition *output;
+	u64 status;
+	int ret;
+	unsigned long irq_flags;
+
+	do {
+		local_irq_save(irq_flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+		input->flags = flags;
+		input->proximity_domain_info =
+			numa_node_to_proximity_domain_info(NUMA_NO_NODE);
+		input->compatibility_version = HV_COMPATIBILITY_21_H2;
+
+		memcpy(&input->partition_creation_properties, &creation_properties,
+		       sizeof(creation_properties));
+
+		memcpy(&input->isolation_properties, &isolation_properties,
+		       sizeof(isolation_properties));
+
+		status = hv_do_hypercall(HVCALL_CREATE_PARTITION,
+					 input, output);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (hv_result_success(status))
+				*partition_id = output->partition_id;
+			else
+				pr_err("%s: %s\n",
+				       __func__, hv_status_to_string(status));
+			local_irq_restore(irq_flags);
+			ret = hv_status_to_errno(status);
+			break;
+		}
+		local_irq_restore(irq_flags);
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    hv_current_partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_initialize_partition(u64 partition_id)
+{
+	struct hv_input_initialize_partition input;
+	u64 status;
+	int ret;
+
+	input.partition_id = partition_id;
+
+	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
+				    HV_INIT_PARTITION_DEPOSIT_PAGES);
+	if (ret)
+		return ret;
+
+	do {
+		status = hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
+					       *(u64 *)&input);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (!hv_result_success(status))
+				pr_err("%s: %s\n",
+				       __func__, hv_status_to_string(status));
+			ret = hv_status_to_errno(status);
+			break;
+		}
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_finalize_partition(u64 partition_id)
+{
+	struct hv_input_finalize_partition input;
+	u64 status;
+
+	input.partition_id = partition_id;
+	status = hv_do_fast_hypercall8(HVCALL_FINALIZE_PARTITION, *(u64 *)&input);
+
+	if (!hv_result_success(status))
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+
+	return hv_status_to_errno(status);
+}
+
+int hv_call_delete_partition(u64 partition_id)
+{
+	struct hv_input_delete_partition input;
+	u64 status;
+
+	input.partition_id = partition_id;
+	status = hv_do_fast_hypercall8(HVCALL_DELETE_PARTITION, *(u64 *)&input);
+
+	if (!hv_result_success(status))
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+
+	return hv_status_to_errno(status);
+}
+
+int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
+			  u32 flags, struct page **pages)
+{
+	struct hv_input_map_gpa_pages *input_page;
+	u64 status;
+	int i;
+	struct page **p;
+	u32 completed = 0;
+	unsigned long remaining = page_count;
+	int rep_count;
+	unsigned long irq_flags;
+	int ret = 0;
+
+	if (page_count == 0)
+		return -EINVAL;
+
+	while (remaining) {
+		rep_count = min(remaining, HV_MAP_GPA_BATCH_SIZE);
+
+		local_irq_save(irq_flags);
+		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+		input_page->target_partition_id = partition_id;
+		input_page->target_gpa_base = gpa_target;
+		input_page->map_flags = flags;
+
+		for (i = 0, p = pages; i < rep_count; i++, p++)
+			input_page->source_gpa_page_list[i] = page_to_pfn(*p);
+		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count,
+					     0, input_page, NULL);
+		local_irq_restore(irq_flags);
+
+		completed = hv_repcomp(status);
+
+		if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
+			ret = hv_call_deposit_pages(NUMA_NO_NODE,
+						    partition_id,
+						    HV_MAP_GPA_DEPOSIT_PAGES);
+			if (ret)
+				break;
+		} else if (!hv_result_success(status)) {
+			pr_err("%s: completed %llu out of %llu, %s\n",
+			       __func__,
+			       page_count - remaining, page_count,
+			       hv_status_to_string(status));
+			ret = hv_status_to_errno(status);
+			break;
+		}
+
+		pages += completed;
+		remaining -= completed;
+		gpa_target += completed;
+	}
+
+	if (ret && remaining < page_count)
+		pr_err("%s: Partially succeeded; mapped regions may be in invalid state",
+		       __func__);
+
+	return ret;
+}
+
+int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
+			    u32 flags)
+{
+	struct hv_input_unmap_gpa_pages *input_page;
+	u64 status;
+	u32 completed = 0;
+	unsigned long remaining = page_count;
+	int rep_count;
+	unsigned long irq_flags;
+
+	if (page_count == 0)
+		return -EINVAL;
+
+	while (remaining) {
+		local_irq_save(irq_flags);
+		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+		input_page->target_partition_id = partition_id;
+		input_page->target_gpa_base = gpa_target;
+		input_page->unmap_flags = flags;
+		rep_count = min(remaining, HV_MAP_GPA_BATCH_SIZE);
+		status = hv_do_rep_hypercall(HVCALL_UNMAP_GPA_PAGES, rep_count,
+					     0, input_page, NULL);
+		local_irq_restore(irq_flags);
+
+		completed = hv_repcomp(status);
+		if (!hv_result_success(status)) {
+			pr_err("%s: completed %llu out of %llu, %s\n", __func__,
+			       page_count - remaining, page_count,
+			       hv_status_to_string(status));
+			if (remaining < page_count)
+				pr_err("%s: Partially succeeded; unmapped regions may be in invalid state",
+				       __func__);
+			return hv_status_to_errno(status);
+		}
+
+		remaining -= completed;
+		gpa_target += completed;
+	}
+
+	return 0;
+}
+
+int hv_call_get_gpa_access_states(u64 partition_id, u32 count,
+				  u64 gpa_base_pfn, u64 state_flags,
+				  int *written_total,
+				  union hv_gpa_page_access_state *states)
+{
+	struct hv_input_get_gpa_pages_access_state *input_page;
+	union hv_gpa_page_access_state *output_page;
+	int completed = 0;
+	unsigned long remaining = count;
+	int rep_count, i;
+	u64 status;
+	unsigned long flags;
+
+	*written_total = 0;
+	while (remaining) {
+		local_irq_save(flags);
+		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+		input_page->partition_id = partition_id;
+		input_page->hv_gpa_page_number = gpa_base_pfn + *written_total;
+		input_page->flags.as_uint64 = state_flags;
+		rep_count = min(remaining, HV_GET_GPA_ACCESS_STATES_BATCH_SIZE);
+
+		status = hv_do_rep_hypercall(HVCALL_GET_GPA_PAGES_ACCESS_STATES, rep_count,
+					     0, input_page, output_page);
+		if (!hv_result_success(status)) {
+			pr_err("%s: completed %li out of %u, %s\n",
+			       __func__,
+			       count - remaining, count,
+			       hv_status_to_string(status));
+			local_irq_restore(flags);
+			break;
+		}
+		completed = hv_repcomp(status);
+		for (i = 0; i < completed; ++i)
+			states[i].as_uint8 = output_page[i].as_uint8;
+
+		states += completed;
+		*written_total += completed;
+		remaining -= completed;
+		local_irq_restore(flags);
+	}
+
+	return hv_status_to_errno(status);
+}
+
+int hv_call_install_intercept(u64 partition_id, u32 access_type,
+			      enum hv_intercept_type intercept_type,
+			      union hv_intercept_parameters intercept_parameter)
+{
+	struct hv_input_install_intercept *input;
+	unsigned long flags;
+	u64 status;
+	int ret;
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		input->partition_id = partition_id;
+		input->access_type = access_type;
+		input->intercept_type = intercept_type;
+		input->intercept_parameter = intercept_parameter;
+		status = hv_do_hypercall(HVCALL_INSTALL_INTERCEPT, input, NULL);
+
+		local_irq_restore(flags);
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (!hv_result_success(status))
+				pr_err("%s: %s\n", __func__,
+				       hv_status_to_string(status));
+			ret = hv_status_to_errno(status);
+			break;
+		}
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector, u64 dest_addr,
+				     union hv_interrupt_control control)
+{
+	struct hv_input_assert_virtual_interrupt *input;
+	unsigned long flags;
+	u64 status;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->vector = vector;
+	input->dest_addr = dest_addr;
+	input->control = control;
+	status = hv_do_hypercall(HVCALL_ASSERT_VIRTUAL_INTERRUPT, input, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return hv_status_to_errno(status);
+	}
+
+	return 0;
+}
+
+#ifdef HV_SUPPORTS_VP_STATE
+
+int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
+			 enum hv_get_set_vp_state_type type,
+			 struct hv_vp_state_data_xsave xsave,
+			 /* Choose between pages and ret_output */
+			 u64 page_count, struct page **pages,
+			 union hv_output_get_vp_state *ret_output)
+{
+	struct hv_input_get_vp_state *input;
+	union hv_output_get_vp_state *output;
+	u64 status;
+	int i;
+	u64 control;
+	unsigned long flags;
+	int ret = 0;
+
+	if (page_count > HV_GET_VP_STATE_BATCH_SIZE)
+		return -EINVAL;
+
+	if (!page_count && !ret_output)
+		return -EINVAL;
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+		memset(input, 0, sizeof(*input));
+		memset(output, 0, sizeof(*output));
+
+		input->partition_id = partition_id;
+		input->vp_index = vp_index;
+		input->state_data.type = type;
+		memcpy(&input->state_data.xsave, &xsave, sizeof(xsave));
+		for (i = 0; i < page_count; i++)
+			input->output_data_pfns[i] = page_to_pfn(pages[i]);
+
+		control = (HVCALL_GET_VP_STATE) |
+			  (page_count << HV_HYPERCALL_VARHEAD_OFFSET);
+
+		status = hv_do_hypercall(control, input, output);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (!hv_result_success(status))
+				pr_err("%s: %s\n", __func__,
+				       hv_status_to_string(status));
+			else if (ret_output)
+				memcpy(ret_output, output, sizeof(*output));
+
+			local_irq_restore(flags);
+			ret = hv_status_to_errno(status);
+			break;
+		}
+		local_irq_restore(flags);
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
+			 enum hv_get_set_vp_state_type type,
+			 struct hv_vp_state_data_xsave xsave,
+			 /* Choose between pages and bytes */
+			 u64 page_count, struct page **pages,
+			 u32 num_bytes, u8 *bytes)
+{
+	struct hv_input_set_vp_state *input;
+	u64 status;
+	int i;
+	u64 control;
+	unsigned long flags;
+	int ret = 0;
+	u16 varhead_sz;
+
+	if (page_count > HV_SET_VP_STATE_BATCH_SIZE)
+		return -EINVAL;
+	if (sizeof(*input) + num_bytes > HV_HYP_PAGE_SIZE)
+		return -EINVAL;
+
+	if (num_bytes)
+		/* round up to 8 and divide by 8 */
+		varhead_sz = (num_bytes + 7) >> 3;
+	else if (page_count)
+		varhead_sz =  page_count;
+	else
+		return -EINVAL;
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		memset(input, 0, sizeof(*input));
+
+		input->partition_id = partition_id;
+		input->vp_index = vp_index;
+		input->state_data.type = type;
+		memcpy(&input->state_data.xsave, &xsave, sizeof(xsave));
+		if (num_bytes) {
+			memcpy((u8 *)input->data, bytes, num_bytes);
+		} else {
+			for (i = 0; i < page_count; i++)
+				input->data[i].pfns = page_to_pfn(pages[i]);
+		}
+
+		control = (HVCALL_SET_VP_STATE) |
+			  (varhead_sz << HV_HYPERCALL_VARHEAD_OFFSET);
+
+		status = hv_do_hypercall(control, input, NULL);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (!hv_result_success(status))
+				pr_err("%s: %s\n", __func__,
+				       hv_status_to_string(status));
+
+			local_irq_restore(flags);
+			ret = hv_status_to_errno(status);
+			break;
+		}
+		local_irq_restore(flags);
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+#endif
+
+int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+			      struct page **state_page)
+{
+	struct hv_input_map_vp_state_page *input;
+	struct hv_output_map_vp_state_page *output;
+	u64 status;
+	int ret;
+	unsigned long flags;
+
+	do {
+		local_irq_save(flags);
+
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+		input->partition_id = partition_id;
+		input->vp_index = vp_index;
+		input->type = type;
+
+		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input, output);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (hv_result_success(status))
+				*state_page = pfn_to_page(output->map_location);
+			else
+				pr_err("%s: %s\n", __func__,
+				       hv_status_to_string(status));
+			local_irq_restore(flags);
+			ret = hv_status_to_errno(status);
+			break;
+		}
+
+		local_irq_restore(flags);
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type)
+{
+	unsigned long flags;
+	u64 status;
+	struct hv_input_unmap_vp_state_page *input;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	memset(input, 0, sizeof(*input));
+
+	input->partition_id = partition_id;
+	input->vp_index = vp_index;
+	input->type = type;
+
+	status = hv_do_hypercall(HVCALL_UNMAP_VP_STATE_PAGE, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return hv_status_to_errno(status);
+	}
+
+	return 0;
+}
+
+int hv_call_get_partition_property(u64 partition_id, u64 property_code,
+				   u64 *property_value)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_get_partition_property *input;
+	struct hv_output_get_partition_property *output;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->property_code = property_code;
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_PROPERTY, input, output);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		local_irq_restore(flags);
+		return hv_status_to_errno(status);
+	}
+	*property_value = output->property_value;
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+int hv_call_set_partition_property(u64 partition_id, u64 property_code,
+				   u64 property_value,
+				   void (*completion_handler)(void * /* data */,
+							      u64 * /* status */),
+				   void *completion_data)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_set_partition_property *input;
+
+	if (!completion_handler) {
+		pr_err("%s: Missing completion handler for async set partition hypercall, property_code: %llu!\n",
+		       __func__, property_code);
+		return -EINVAL;
+	}
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->property_code = property_code;
+	input->property_value = property_value;
+	status = hv_do_hypercall(HVCALL_SET_PARTITION_PROPERTY, input, NULL);
+	local_irq_restore(flags);
+
+	if (unlikely(hv_result(status) == HV_STATUS_CALL_PENDING))
+		completion_handler(completion_data, &status);
+
+	if (!hv_result_success(status))
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+
+	return hv_status_to_errno(status);
+}
+
+int hv_call_translate_virtual_address(u32 vp_index, u64 partition_id, u64 flags,
+				      u64 gva, u64 *gpa,
+				      union hv_translate_gva_result *result)
+{
+	u64 status;
+	unsigned long irq_flags;
+	struct hv_input_translate_virtual_address *input;
+	struct hv_output_translate_virtual_address *output;
+
+	local_irq_save(irq_flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	memset(input, 0, sizeof(*input));
+	memset(output, 0, sizeof(*output));
+
+	input->partition_id = partition_id;
+	input->vp_index = vp_index;
+	input->control_flags = flags;
+	input->gva_page = gva >> HV_HYP_PAGE_SHIFT;
+
+	status = hv_do_hypercall(HVCALL_TRANSLATE_VIRTUAL_ADDRESS, input, output);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		goto out;
+	}
+
+	*result = output->translation_result;
+
+	*gpa = (output->gpa_page << HV_HYP_PAGE_SHIFT) + /* pfn to gpa */
+			((u64)gva & ~HV_HYP_PAGE_MASK);	 /* offset in gpa */
+
+out:
+	local_irq_restore(irq_flags);
+
+	return hv_status_to_errno(status);
+}
+
+int
+hv_call_clear_virtual_interrupt(u64 partition_id)
+{
+	unsigned long flags;
+	int status;
+
+	local_irq_save(flags);
+	status = hv_do_fast_hypercall8(HVCALL_CLEAR_VIRTUAL_INTERRUPT,
+				       partition_id);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return hv_status_to_errno(status);
+	}
+
+	return 0;
+}
+
+int
+hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
+		    u64 connection_partition_id,
+		    struct hv_port_info *port_info,
+		    u8 port_vtl, u8 min_connection_vtl, int node)
+{
+	struct hv_input_create_port *input;
+	unsigned long flags;
+	int ret = 0;
+	int status;
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		memset(input, 0, sizeof(*input));
+
+		input->port_partition_id = port_partition_id;
+		input->port_id = port_id;
+		input->connection_partition_id = connection_partition_id;
+		input->port_info = *port_info;
+		input->port_vtl = port_vtl;
+		input->min_connection_vtl = min_connection_vtl;
+		input->proximity_domain_info =
+			numa_node_to_proximity_domain_info(node);
+		status = hv_do_hypercall(HVCALL_CREATE_PORT, input, NULL);
+		local_irq_restore(flags);
+
+		if (hv_result_success(status))
+			break;
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			pr_err("%s: %s\n",
+			       __func__, hv_status_to_string(status));
+			ret = hv_status_to_errno(status);
+			break;
+		}
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, port_partition_id, 1);
+
+	} while (!ret);
+
+	return ret;
+}
+
+int
+hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id)
+{
+	union hv_input_delete_port input = { 0 };
+	unsigned long flags;
+	int status;
+
+	local_irq_save(flags);
+	input.port_partition_id = port_partition_id;
+	input.port_id = port_id;
+	status = hv_do_fast_hypercall16(HVCALL_DELETE_PORT,
+					input.as_uint64[0],
+					input.as_uint64[1]);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return hv_status_to_errno(status);
+	}
+
+	return 0;
+}
+
+int
+hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
+		     u64 connection_partition_id,
+		     union hv_connection_id connection_id,
+		     struct hv_connection_info *connection_info,
+		     u8 connection_vtl, int node)
+{
+	struct hv_input_connect_port *input;
+	unsigned long flags;
+	int ret = 0, status;
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		memset(input, 0, sizeof(*input));
+		input->port_partition_id = port_partition_id;
+		input->port_id = port_id;
+		input->connection_partition_id = connection_partition_id;
+		input->connection_id = connection_id;
+		input->connection_info = *connection_info;
+		input->connection_vtl = connection_vtl;
+		input->proximity_domain_info =
+			numa_node_to_proximity_domain_info(node);
+		status = hv_do_hypercall(HVCALL_CONNECT_PORT, input, NULL);
+
+		local_irq_restore(flags);
+		if (hv_result_success(status))
+			break;
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			pr_err("%s: %s\n",
+			       __func__, hv_status_to_string(status));
+			ret = hv_status_to_errno(status);
+			break;
+		}
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    connection_partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int
+hv_call_disconnect_port(u64 connection_partition_id,
+			union hv_connection_id connection_id)
+{
+	union hv_input_disconnect_port input = { 0 };
+	unsigned long flags;
+	int status;
+
+	local_irq_save(flags);
+	input.connection_partition_id = connection_partition_id;
+	input.connection_id = connection_id;
+	input.is_doorbell = 1;
+	status = hv_do_fast_hypercall16(HVCALL_DISCONNECT_PORT,
+					input.as_uint64[0],
+					input.as_uint64[1]);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return hv_status_to_errno(status);
+	}
+
+	return 0;
+}
+
+int
+hv_call_notify_port_ring_empty(u32 sint_index)
+{
+	union hv_input_notify_port_ring_empty input = { 0 };
+	unsigned long flags;
+	int status;
+
+	local_irq_save(flags);
+	input.sint_index = sint_index;
+	status = hv_do_fast_hypercall8(HVCALL_NOTIFY_PORT_RING_EMPTY,
+				       input.as_uint64);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return hv_status_to_errno(status);
+	}
+
+	return 0;
+}
+
+#ifdef HV_SUPPORTS_REGISTER_INTERCEPT
+
+int hv_call_register_intercept_result(u32 vp_index, u64 partition_id,
+				      enum hv_intercept_type intercept_type,
+				      union hv_register_intercept_result_parameters *params)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_register_intercept_result *in;
+	int ret = 0;
+
+	do {
+		local_irq_save(flags);
+		in = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		in->vp_index = vp_index;
+		in->partition_id = partition_id;
+		in->intercept_type = intercept_type;
+		in->parameters = *params;
+
+		status = hv_do_hypercall(HVCALL_REGISTER_INTERCEPT_RESULT, in, NULL);
+		local_irq_restore(flags);
+
+		if (hv_result_success(status))
+			break;
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			pr_err("%s: %s\n",
+			       __func__, hv_status_to_string(status));
+			ret = hv_status_to_errno(status);
+			break;
+		}
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+#endif
+
+int hv_call_signal_event_direct(u32 vp_index, u64 partition_id, u8 vtl,
+				u8 sint, u16 flag_number, u8 *newly_signaled)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_signal_event_direct *in;
+	struct hv_output_signal_event_direct *out;
+
+	local_irq_save(flags);
+	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	out = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	in->target_partition = partition_id;
+	in->target_vp = vp_index;
+	in->target_vtl = vtl;
+	in->target_sint = sint;
+	in->flag_number = flag_number;
+
+	status = hv_do_hypercall(HVCALL_SIGNAL_EVENT_DIRECT, in, out);
+	if (hv_result_success(status))
+		*newly_signaled = out->newly_signaled;
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return hv_status_to_errno(status);
+	}
+	return 0;
+}
+
+int hv_call_post_message_direct(u32 vp_index, u64 partition_id, u8 vtl,
+				u32 sint_index, u8 *message)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_post_message_direct *in;
+
+	local_irq_save(flags);
+	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	in->partition_id = partition_id;
+	in->vp_index = vp_index;
+	in->vtl = vtl;
+	in->sint_index = sint_index;
+	memcpy(&in->message, message, HV_MESSAGE_SIZE);
+
+	status = hv_do_hypercall(HVCALL_POST_MESSAGE_DIRECT, in, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return hv_status_to_errno(status);
+	}
+	return 0;
+}
+
+int hv_call_get_vp_cpuid_values(u32 vp_index, u64 partition_id,
+				union hv_get_vp_cpuid_values_flags values_flags,
+				struct hv_cpuid_leaf_info *info,
+				union hv_output_get_vp_cpuid_values *result)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_get_vp_cpuid_values *in;
+	union hv_output_get_vp_cpuid_values *out;
+
+	local_irq_save(flags);
+	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	out = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	memset(in, 0, sizeof(*in) + sizeof(*info));
+	in->partition_id = partition_id;
+	in->vp_index = vp_index;
+	in->flags = values_flags;
+	in->cpuid_leaf_info[0] = *info;
+
+	status = hv_do_rep_hypercall(HVCALL_GET_VP_CPUID_VALUES, 1, 0, in, out);
+	if (hv_result_success(status))
+		*result = *out;
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return hv_status_to_errno(status);
+	}
+	return 0;
+}
+
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
new file mode 100644
index 000000000000..74b2e0b2770d
--- /dev/null
+++ b/drivers/hv/mshv_root_main.c
@@ -0,0 +1,1920 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * The main part of the mshv_root module, providing APIs to create
+ * and manage guest partitions.
+ *
+ * Authors:
+ *   Nuno Das Neves <nunodasneves@linux.microsoft.com>
+ *   Lillian Grassin-Drake <ligrassi@microsoft.com>
+ *   Wei Liu <wei.liu@kernel.org>
+ *   Vineeth Remanan Pillai <viremana@linux.microsoft.com>
+ *   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
+ *   Asher Kariv <askariv@microsoft.com>
+ *   Muminul Islam <Muminul.Islam@microsoft.com>
+ *   Anatol Belski <anbelski@linux.microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/cpuhotplug.h>
+#include <linux/random.h>
+#include <linux/nospec.h>
+#include <asm/mshyperv.h>
+
+#include "mshv_eventfd.h"
+#include "mshv.h"
+#include "mshv_root.h"
+
+struct mshv_root mshv_root = {};
+
+enum hv_scheduler_type hv_scheduler_type;
+
+static bool ignore_hv_version;
+module_param(ignore_hv_version, bool, 0);
+
+/* Once we implement the fast extended hypercall ABI they can go away. */
+static void __percpu **root_scheduler_input;
+static void __percpu **root_scheduler_output;
+
+static int mshv_vp_release(struct inode *inode, struct file *filp);
+static long mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
+static struct mshv_partition *mshv_partition_get(struct mshv_partition *partition);
+static void mshv_partition_put(struct mshv_partition *partition);
+static int mshv_partition_release(struct inode *inode, struct file *filp);
+static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
+static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma);
+static vm_fault_t mshv_vp_fault(struct vm_fault *vmf);
+
+static const struct vm_operations_struct mshv_vp_vm_ops = {
+	.fault = mshv_vp_fault,
+};
+
+static const struct file_operations mshv_vp_fops = {
+	.owner = THIS_MODULE,
+	.release = mshv_vp_release,
+	.unlocked_ioctl = mshv_vp_ioctl,
+	.llseek = noop_llseek,
+	.mmap = mshv_vp_mmap,
+};
+
+static const struct file_operations mshv_partition_fops = {
+	.owner = THIS_MODULE,
+	.release = mshv_partition_release,
+	.unlocked_ioctl = mshv_partition_ioctl,
+	.llseek = noop_llseek,
+};
+
+static int mshv_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+				 struct hv_register_assoc *registers)
+{
+	union hv_input_vtl input_vtl;
+
+	input_vtl.as_uint8 = 0;
+	return hv_call_get_vp_registers(vp_index, partition_id,
+					count, input_vtl, registers);
+}
+
+static int mshv_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+				 struct hv_register_assoc *registers)
+{
+	union hv_input_vtl input_vtl;
+
+	input_vtl.as_uint8 = 0;
+	return hv_call_set_vp_registers(vp_index, partition_id,
+					count, input_vtl, registers);
+}
+
+static long
+mshv_vp_ioctl_get_set_regs(struct mshv_vp *vp, void __user *user_args, bool set)
+{
+	struct mshv_vp_registers args;
+	struct hv_register_assoc *registers;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.count == 0 || args.count > MSHV_VP_MAX_REGISTERS)
+		return -EINVAL;
+
+	registers = kmalloc_array(args.count,
+				  sizeof(*registers),
+				  GFP_KERNEL);
+	if (!registers)
+		return -ENOMEM;
+
+	if (copy_from_user(registers, (void __user *)args.regs_ptr,
+			   sizeof(*registers) * args.count)) {
+		ret = -EFAULT;
+		goto free_return;
+	}
+
+	if (set) {
+		u32 i;
+
+		for (i = 0; i < args.count; i++) {
+			/*
+			 * Disallow setting suspend registers to ensure run vp state
+			 * is consistent
+			 */
+			if (registers[i].name == HV_REGISTER_EXPLICIT_SUSPEND ||
+			    registers[i].name == HV_REGISTER_INTERCEPT_SUSPEND) {
+				pr_err("%s: not allowed to set suspend registers\n",
+				       __func__);
+				ret = -EINVAL;
+				goto free_return;
+			}
+		}
+
+		ret = mshv_set_vp_registers(vp->index, vp->partition->id,
+					    args.count, registers);
+	} else {
+		ret = mshv_get_vp_registers(vp->index, vp->partition->id,
+					    args.count, registers);
+		if (ret)
+			goto free_return;
+
+		if (copy_to_user((void __user *)args.regs_ptr, registers,
+				 sizeof(*registers) * args.count))
+			ret = -EFAULT;
+	}
+
+free_return:
+	kfree(registers);
+	return ret;
+}
+
+static inline long
+mshv_vp_ioctl_set_regs(struct mshv_vp *vp, void __user *user_args)
+{
+	return mshv_vp_ioctl_get_set_regs(vp, user_args, true);
+}
+
+static inline long
+mshv_vp_ioctl_get_regs(struct mshv_vp *vp, void __user *user_args)
+{
+	return mshv_vp_ioctl_get_set_regs(vp, user_args, false);
+}
+
+/*
+ * Explicit guest vCPU suspend is asynchronous by nature (as it is requested by
+ * dom0 vCPU for guest vCPU) and thus it can race with "intercept" suspend,
+ * done by the hypervisor.
+ * "Intercept" suspend leads to asynchronous message delivery to dom0 which
+ * should be awaited to keep the VP loop consistent (i.e. no message pending
+ * upon VP resume).
+ * VP intercept suspend can't be done when the VP is explicitly suspended
+ * already, and thus can be only two possible race scenarios:
+ *   1. implicit suspend bit set -> explicit suspend bit set -> message sent
+ *   2. implicit suspend bit set -> message sent -> explicit suspend bit set
+ * Checking for implicit suspend bit set after explicit suspend request has
+ * succeeded in either case allows us to reliably identify, if there is a
+ * message to receive and deliver to VMM.
+ */
+static long
+mshv_suspend_vp(const struct mshv_vp *vp, bool *message_in_flight)
+{
+	struct hv_register_assoc explicit_suspend = {
+		.name = HV_REGISTER_EXPLICIT_SUSPEND
+	};
+	struct hv_register_assoc intercept_suspend = {
+		.name = HV_REGISTER_INTERCEPT_SUSPEND
+	};
+	union hv_explicit_suspend_register *es =
+		&explicit_suspend.value.explicit_suspend;
+	union hv_intercept_suspend_register *is =
+		&intercept_suspend.value.intercept_suspend;
+	int ret;
+
+	es->suspended = 1;
+
+	ret = mshv_set_vp_registers(vp->index, vp->partition->id,
+				    1, &explicit_suspend);
+	if (ret) {
+		pr_err("%s: failed to explicitly suspend vCPU#%d in partition %lld\n",
+		       __func__, vp->index, vp->partition->id);
+		return ret;
+	}
+
+	ret = mshv_get_vp_registers(vp->index, vp->partition->id,
+				    1, &intercept_suspend);
+	if (ret) {
+		pr_err("%s: failed to get intercept suspend state vCPU#%d in partition %lld\n",
+		       __func__, vp->index, vp->partition->id);
+		return ret;
+	}
+
+	*message_in_flight = is->suspended;
+
+	return 0;
+}
+
+/*
+ * This function is used when VPs are scheduled by the hypervisor's
+ * scheduler.
+ *
+ * Caller has to make sure the registers contain cleared
+ * HV_REGISTER_INTERCEPT_SUSPEND and HV_REGISTER_EXPLICIT_SUSPEND registers
+ * exactly in this order (the hypervisor clears them sequentially) to avoid
+ * potential invalid clearing a newly arrived HV_REGISTER_INTERCEPT_SUSPEND
+ * after VP is released from HV_REGISTER_EXPLICIT_SUSPEND in case of the
+ * opposite order.
+ */
+static long
+mshv_run_vp_with_hv_scheduler(struct mshv_vp *vp, void __user *ret_message,
+			      struct hv_register_assoc *registers, size_t count)
+
+{
+	struct hv_message *msg = vp->intercept_message_page;
+	long ret;
+
+	/* Resume VP execution */
+	ret = mshv_set_vp_registers(vp->index, vp->partition->id,
+				    count, registers);
+	if (ret) {
+		pr_err("%s: failed to resume vCPU#%d in partition %lld\n",
+		       __func__, vp->index, vp->partition->id);
+		return ret;
+	}
+
+	ret = wait_event_interruptible(vp->run.suspend_queue,
+				       vp->run.kicked_by_hv == 1);
+	if (ret) {
+		bool message_in_flight;
+
+		/*
+		 * Otherwise the waiting was interrupted by a signal: suspend
+		 * the vCPU explicitly and copy message in flight (if any).
+		 */
+		ret = mshv_suspend_vp(vp, &message_in_flight);
+		if (ret)
+			return ret;
+
+		/* Return if no message in flight */
+		if (!message_in_flight)
+			return -EINTR;
+
+		/* Wait for the message in flight. */
+		wait_event(vp->run.suspend_queue, vp->run.kicked_by_hv == 1);
+	}
+
+	if (copy_to_user(ret_message, msg, sizeof(struct hv_message)))
+		return -EFAULT;
+
+	/*
+	 * Reset the flag to make the wait_event call above work
+	 * next time.
+	 */
+	vp->run.kicked_by_hv = 0;
+
+	return 0;
+}
+
+static long
+mshv_run_vp_with_root_scheduler(struct mshv_vp *vp, void __user *ret_message)
+{
+	struct hv_input_dispatch_vp *input;
+	struct hv_output_dispatch_vp *output;
+	long ret = 0;
+	u64 status;
+	bool complete = false;
+	bool got_intercept_message = false;
+
+	while (!complete) {
+		if (vp->run.flags.blocked_by_explicit_suspend) {
+			/*
+			 * Need to clear explicit suspend before dispatching.
+			 * Explicit suspend is either:
+			 * - set before the first VP dispatch or
+			 * - set explicitly via hypercall
+			 * Since the latter case is not supported, we simply
+			 * clear it here.
+			 */
+			struct hv_register_assoc explicit_suspend = {
+				.name = HV_REGISTER_EXPLICIT_SUSPEND,
+				.value.explicit_suspend.suspended = 0,
+			};
+
+			ret = mshv_set_vp_registers(vp->index, vp->partition->id,
+						    1, &explicit_suspend);
+			if (ret) {
+				pr_err("%s: failed to unsuspend partition %llu vp %u\n",
+				       __func__, vp->partition->id, vp->index);
+				complete = true;
+				break;
+			}
+
+			vp->run.flags.explicit_suspend = 0;
+
+			/* Wait for the hypervisor to clear the blocked state */
+			ret = wait_event_interruptible(vp->run.suspend_queue,
+						       vp->run.kicked_by_hv == 1);
+			if (ret) {
+				ret = -EINTR;
+				complete = true;
+				break;
+			}
+			vp->run.kicked_by_hv = 0;
+			vp->run.flags.blocked_by_explicit_suspend = 0;
+		}
+
+		if (vp->run.flags.blocked) {
+			/*
+			 * Dispatch state of this VP is blocked. Need to wait
+			 * for the hypervisor to clear the blocked state before
+			 * dispatching it.
+			 */
+			ret = wait_event_interruptible(vp->run.suspend_queue,
+						       vp->run.kicked_by_hv == 1);
+			if (ret) {
+				ret = -EINTR;
+				complete = true;
+				break;
+			}
+			vp->run.kicked_by_hv = 0;
+			vp->run.flags.blocked = 0;
+		}
+
+		preempt_disable();
+
+		while (!vp->run.flags.blocked_by_explicit_suspend && !got_intercept_message) {
+			u32 flags = 0;
+			unsigned long irq_flags, ti_work;
+			const unsigned long work_flags = _TIF_NEED_RESCHED |
+							 _TIF_SIGPENDING |
+							 _TIF_NOTIFY_SIGNAL |
+							 _TIF_NOTIFY_RESUME;
+
+			if (vp->run.flags.intercept_suspend)
+				flags |= HV_DISPATCH_VP_FLAG_CLEAR_INTERCEPT_SUSPEND;
+
+			local_irq_save(irq_flags);
+
+			ti_work = READ_ONCE(current_thread_info()->flags);
+			if (unlikely(ti_work & work_flags) || need_resched()) {
+				local_irq_restore(irq_flags);
+				preempt_enable();
+
+				ret = mshv_xfer_to_guest_mode_handle_work(ti_work);
+
+				preempt_disable();
+
+				if (ret) {
+					complete = true;
+					break;
+				}
+
+				continue;
+			}
+
+			/*
+			 * Note the lack of local_irq_restore after the dipatch
+			 * call. We rely on the hypervisor to do that for us.
+			 *
+			 * Thread context should always have interrupt enabled,
+			 * but we try to be defensive here by testing what it
+			 * truly was before we disabled interrupt.
+			 */
+			if (!irqs_disabled_flags(irq_flags))
+				flags |= HV_DISPATCH_VP_FLAG_ENABLE_CALLER_INTERRUPTS;
+
+			/* Preemption is disabled at this point */
+			input = *this_cpu_ptr(root_scheduler_input);
+			output = *this_cpu_ptr(root_scheduler_output);
+
+			memset(input, 0, sizeof(*input));
+			memset(output, 0, sizeof(*output));
+
+			input->partition_id = vp->partition->id;
+			input->vp_index = vp->index;
+			input->time_slice = 0; /* Run forever until something happens */
+			input->spec_ctrl = 0; /* TODO: set sensible flags */
+			input->flags = flags;
+
+			status = hv_do_hypercall(HVCALL_DISPATCH_VP, input, output);
+
+			if (!hv_result_success(status)) {
+				pr_err("%s: status %s\n", __func__, hv_status_to_string(status));
+				ret = hv_status_to_errno(status);
+				complete = true;
+				break;
+			}
+
+			vp->run.flags.intercept_suspend = 0;
+
+			if (output->dispatch_state == HV_VP_DISPATCH_STATE_BLOCKED) {
+				if (output->dispatch_event == HV_VP_DISPATCH_EVENT_SUSPEND) {
+					vp->run.flags.blocked_by_explicit_suspend = 1;
+					/* TODO: remove warning once VP canceling is supported */
+					WARN_ONCE(atomic64_read(&vp->run.signaled_count),
+						  "%s: vp#%d: unexpected explicit suspend\n",
+						   __func__, vp->index);
+				} else {
+					vp->run.flags.blocked = 1;
+					ret = wait_event_interruptible(vp->run.suspend_queue,
+								       vp->run.kicked_by_hv == 1);
+					if (ret) {
+						ret = -EINTR;
+						complete = true;
+						break;
+					}
+					vp->run.flags.blocked = 0;
+					vp->run.kicked_by_hv = 0;
+				}
+			} else {
+				/* HV_VP_DISPATCH_STATE_READY */
+				if (output->dispatch_event == HV_VP_DISPATCH_EVENT_INTERCEPT)
+					got_intercept_message = 1;
+			}
+		}
+
+		preempt_enable();
+
+		if (got_intercept_message) {
+			vp->run.flags.intercept_suspend = 1;
+			if (copy_to_user(ret_message, vp->intercept_message_page,
+					 sizeof(struct hv_message)))
+				ret =  -EFAULT;
+			complete = true;
+		}
+	}
+
+	return ret;
+}
+
+static long
+mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *ret_message)
+{
+	if (hv_scheduler_type != HV_SCHEDULER_TYPE_ROOT) {
+		struct hv_register_assoc suspend_registers[2] = {
+			{ .name = HV_REGISTER_INTERCEPT_SUSPEND },
+			{ .name = HV_REGISTER_EXPLICIT_SUSPEND }
+		};
+
+		return mshv_run_vp_with_hv_scheduler(vp, ret_message,
+				suspend_registers, ARRAY_SIZE(suspend_registers));
+	}
+
+	return mshv_run_vp_with_root_scheduler(vp, ret_message);
+}
+
+static long
+mshv_vp_ioctl_run_vp_regs(struct mshv_vp *vp,
+			  struct mshv_vp_run_registers __user *user_args)
+{
+	struct hv_register_assoc suspend_registers[2] = {
+		{ .name = HV_REGISTER_INTERCEPT_SUSPEND },
+		{ .name = HV_REGISTER_EXPLICIT_SUSPEND }
+	};
+	struct mshv_vp_run_registers run_regs;
+	struct hv_message __user *ret_message;
+	int i, regs_count;
+
+	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&run_regs, user_args, sizeof(run_regs)))
+		return -EFAULT;
+
+	ret_message = (struct hv_message __user *)run_regs.message_ptr;
+	regs_count = run_regs.registers.count;
+
+	if (regs_count + ARRAY_SIZE(suspend_registers) > MSHV_VP_MAX_REGISTERS)
+		return -EINVAL;
+
+	if (copy_from_user(vp->registers,
+			   (void __user *)run_regs.registers.regs_ptr,
+			   sizeof(*vp->registers) * regs_count))
+		return -EFAULT;
+
+	for (i = 0; i < regs_count; i++) {
+		/*
+		 * Disallow setting suspend registers to ensure run vp state
+		 * is consistent
+		 */
+		if (vp->registers[i].name == HV_REGISTER_EXPLICIT_SUSPEND ||
+		    vp->registers[i].name == HV_REGISTER_INTERCEPT_SUSPEND) {
+			pr_err("%s: not allowed to set suspend registers\n",
+			       __func__);
+			return -EINVAL;
+		}
+	}
+
+	/* Set the last registers to clear suspend */
+	memcpy(vp->registers + regs_count,
+	       suspend_registers, sizeof(suspend_registers));
+
+	return mshv_run_vp_with_hv_scheduler(vp, ret_message, vp->registers,
+			   regs_count + ARRAY_SIZE(suspend_registers));
+}
+
+#ifdef HV_SUPPORTS_VP_STATE
+
+static long
+mshv_vp_ioctl_get_set_state_pfn(struct mshv_vp *vp,
+				struct mshv_vp_state *args,
+				bool is_set)
+{
+	u64 page_count, remaining;
+	int completed;
+	struct page **pages;
+	long ret;
+	unsigned long u_buf;
+
+	/* Buffer must be page aligned */
+	if (!PAGE_ALIGNED(args->buf_size) ||
+	    !PAGE_ALIGNED(args->buf_ptr))
+		return -EINVAL;
+
+	if (!access_ok((void __user *)args->buf_ptr, args->buf_size))
+		return -EFAULT;
+
+	/* Pin user pages so hypervisor can copy directly to them */
+	page_count = args->buf_size >> HV_HYP_PAGE_SHIFT;
+	pages = kcalloc(page_count, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	remaining = page_count;
+	u_buf = (unsigned long)args->buf_ptr;
+	while (remaining) {
+		completed = pin_user_pages_fast(u_buf, remaining, FOLL_WRITE,
+						&pages[page_count - remaining]);
+		if (completed < 0) {
+			pr_err("%s: failed to pin user pages error %i\n",
+			       __func__, completed);
+			ret = completed;
+			goto unpin_pages;
+		}
+		remaining -= completed;
+		u_buf += completed * HV_HYP_PAGE_SIZE;
+	}
+
+	if (is_set)
+		ret = hv_call_set_vp_state(vp->index,
+					   vp->partition->id,
+					   args->type, args->xsave,
+					   page_count, pages,
+					   0, NULL);
+	else
+		ret = hv_call_get_vp_state(vp->index,
+					   vp->partition->id,
+					   args->type, args->xsave,
+					   page_count, pages,
+					   NULL);
+
+unpin_pages:
+	unpin_user_pages(pages, page_count - remaining);
+	kfree(pages);
+	return ret;
+}
+
+static long
+mshv_vp_ioctl_get_set_state(struct mshv_vp *vp, void __user *user_args, bool is_set)
+{
+	struct mshv_vp_state args;
+	long ret = 0;
+	union hv_output_get_vp_state vp_state;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	/* For now just support these */
+	if (args.type != HV_GET_SET_VP_STATE_LOCAL_INTERRUPT_CONTROLLER_STATE &&
+	    args.type != HV_GET_SET_VP_STATE_XSAVE)
+		return -EINVAL;
+
+	/* If we need to pin pfns, delegate to helper */
+	if (args.type & HV_GET_SET_VP_STATE_TYPE_PFN)
+		return mshv_vp_ioctl_get_set_state_pfn(vp, &args, is_set);
+
+	if (args.buf_size < sizeof(vp_state))
+		return -EINVAL;
+
+	if (is_set) {
+		if (copy_from_user(&vp_state, (void __user *)args.buf_ptr,
+				   sizeof(vp_state)))
+			return -EFAULT;
+
+		return hv_call_set_vp_state(vp->index,
+					    vp->partition->id,
+					    args.type, args.xsave,
+					    0, NULL,
+					    sizeof(vp_state),
+					    (u8 *)&vp_state);
+	}
+
+	ret = hv_call_get_vp_state(vp->index,
+				   vp->partition->id,
+				   args.type, args.xsave,
+				   0, NULL,
+				   &vp_state);
+
+	if (ret)
+		return ret;
+
+	if (copy_to_user((void __user *)args.buf_ptr,
+			 &vp_state.interrupt_controller_state,
+			 sizeof(vp_state.interrupt_controller_state)))
+		return -EFAULT;
+
+	return 0;
+}
+
+#endif
+
+#ifdef HV_SUPPORTS_REGISTER_INTERCEPT
+
+static long
+mshv_vp_ioctl_register_intercept_result(struct mshv_vp *vp, void __user *user_args)
+{
+	struct mshv_register_intercept_result args;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	ret = hv_call_register_intercept_result(vp->index,
+						vp->partition->id,
+						args.intercept_type,
+						&args.parameters);
+
+	return ret;
+}
+
+#endif
+
+static long
+mshv_vp_ioctl_get_cpuid_values(struct mshv_vp *vp, void __user *user_args)
+{
+	struct mshv_get_vp_cpuid_values args;
+	union hv_get_vp_cpuid_values_flags flags;
+	struct hv_cpuid_leaf_info info;
+	union hv_output_get_vp_cpuid_values result;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	flags.use_vp_xfem_xss = 1;
+	flags.apply_registered_values = 1;
+	flags.reserved = 0;
+
+	memset(&info, 0, sizeof(info));
+	info.eax = args.function;
+	info.ecx = args.index;
+
+	ret = hv_call_get_vp_cpuid_values(vp->index, vp->partition->id, flags,
+					  &info, &result);
+
+	if (ret)
+		return ret;
+
+	args.eax = result.eax;
+	args.ebx = result.ebx;
+	args.ecx = result.ecx;
+	args.edx = result.edx;
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+mshv_vp_ioctl_translate_gva(struct mshv_vp *vp, void __user *user_args)
+{
+	long ret;
+	struct mshv_translate_gva args;
+	u64 gpa;
+	union hv_translate_gva_result result;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	ret = hv_call_translate_virtual_address(vp->index, vp->partition->id,
+						args.flags, args.gva, &gpa,
+						&result);
+
+	if (ret)
+		return ret;
+
+	args.result = result;
+	args.gpa = gpa;
+
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	struct mshv_vp *vp = filp->private_data;
+	long r = -ENOTTY;
+
+	if (mutex_lock_killable(&vp->mutex))
+		return -EINTR;
+
+	switch (ioctl) {
+	case MSHV_RUN_VP:
+		r = mshv_vp_ioctl_run_vp(vp, (void __user *)arg);
+		break;
+	case MSHV_RUN_VP_REGISTERS:
+		r = mshv_vp_ioctl_run_vp_regs(vp, (void __user *)arg);
+		break;
+	case MSHV_GET_VP_REGISTERS:
+		r = mshv_vp_ioctl_get_regs(vp, (void __user *)arg);
+		break;
+	case MSHV_SET_VP_REGISTERS:
+		r = mshv_vp_ioctl_set_regs(vp, (void __user *)arg);
+		break;
+#ifdef HV_SUPPORTS_VP_STATE
+	case MSHV_GET_VP_STATE:
+		r = mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, false);
+		break;
+	case MSHV_SET_VP_STATE:
+		r = mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, true);
+		break;
+#endif
+	case MSHV_TRANSLATE_GVA:
+		r = mshv_vp_ioctl_translate_gva(vp, (void __user *)arg);
+		break;
+#ifdef HV_SUPPORTS_REGISTER_INTERCEPT
+	case MSHV_VP_REGISTER_INTERCEPT_RESULT:
+		r = mshv_vp_ioctl_register_intercept_result(vp, (void __user *)arg);
+		break;
+#endif
+	case MSHV_GET_VP_CPUID_VALUES:
+		r = mshv_vp_ioctl_get_cpuid_values(vp, (void __user *)arg);
+		break;
+	default:
+		pr_err("%s: invalid ioctl: %#x\n", __func__, ioctl);
+		break;
+	}
+	mutex_unlock(&vp->mutex);
+
+	return r;
+}
+
+static vm_fault_t mshv_vp_fault(struct vm_fault *vmf)
+{
+	struct mshv_vp *vp = vmf->vma->vm_file->private_data;
+
+	vmf->page = vp->register_page;
+	get_page(vp->register_page);
+
+	return 0;
+}
+
+static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int ret;
+	struct mshv_vp *vp = file->private_data;
+
+	if (vma->vm_pgoff != MSHV_VP_MMAP_REGISTERS_OFFSET)
+		return -EINVAL;
+
+	if (mutex_lock_killable(&vp->mutex))
+		return -EINTR;
+
+	if (!vp->register_page) {
+		ret = hv_call_map_vp_state_page(vp->partition->id,
+						vp->index,
+						HV_VP_STATE_PAGE_REGISTERS,
+						&vp->register_page);
+		if (ret) {
+			mutex_unlock(&vp->mutex);
+			return ret;
+		}
+	}
+
+	mutex_unlock(&vp->mutex);
+
+	vma->vm_ops = &mshv_vp_vm_ops;
+	return 0;
+}
+
+static int
+mshv_vp_release(struct inode *inode, struct file *filp)
+{
+	struct mshv_vp *vp = filp->private_data;
+
+	/* Rest of VP cleanup happens in destroy_partition() */
+	mshv_partition_put(vp->partition);
+	return 0;
+}
+
+static long
+mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
+			       void __user *arg)
+{
+	struct mshv_create_vp args;
+	struct mshv_vp *vp;
+	struct file *file;
+	int fd;
+	long ret;
+	struct page *intercept_message_page;
+
+	if (copy_from_user(&args, arg, sizeof(args)))
+		return -EFAULT;
+
+	if (args.vp_index >= MSHV_MAX_VPS)
+		return -EINVAL;
+
+	if (partition->vps.array[args.vp_index])
+		return -EEXIST;
+
+	vp = kzalloc(sizeof(*vp), GFP_KERNEL);
+
+	if (!vp)
+		return -ENOMEM;
+
+	mutex_init(&vp->mutex);
+	init_waitqueue_head(&vp->run.suspend_queue);
+
+	atomic64_set(&vp->run.signaled_count, 0);
+
+	vp->registers = kmalloc_array(MSHV_VP_MAX_REGISTERS,
+				      sizeof(*vp->registers), GFP_KERNEL);
+	if (!vp->registers) {
+		ret = -ENOMEM;
+		goto free_vp;
+	}
+
+	vp->index = args.vp_index;
+	vp->partition = mshv_partition_get(partition);
+	if (!vp->partition) {
+		ret = -EBADF;
+		goto free_registers;
+	}
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		ret = fd;
+		goto put_partition;
+	}
+
+	file = anon_inode_getfile("mshv_vp", &mshv_vp_fops, vp, O_RDWR);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto put_fd;
+	}
+
+	/* vp index set to 0 - only valid for root partition VPs */
+	ret = hv_call_create_vp(NUMA_NO_NODE, partition->id, args.vp_index, 0);
+	if (ret)
+		goto release_file;
+
+	ret = hv_call_map_vp_state_page(partition->id, vp->index,
+					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
+					&intercept_message_page);
+	if (ret)
+		goto release_file;
+
+	vp->intercept_message_page = page_to_virt(intercept_message_page);
+
+	/* already exclusive with the partition mutex for all ioctls */
+	partition->vps.count++;
+	partition->vps.array[args.vp_index] = vp;
+
+	fd_install(fd, file);
+
+	return fd;
+
+release_file:
+	file->f_op->release(file->f_inode, file);
+put_fd:
+	put_unused_fd(fd);
+put_partition:
+	mshv_partition_put(partition);
+free_registers:
+	kfree(vp->registers);
+free_vp:
+	kfree(vp);
+
+	return ret;
+}
+
+static long
+mshv_partition_ioctl_get_property(struct mshv_partition *partition,
+				  void __user *user_args)
+{
+	struct mshv_partition_property args;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	ret = hv_call_get_partition_property(partition->id, args.property_code,
+					     &args.property_value);
+
+	if (ret)
+		return ret;
+
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static void
+mshv_root_async_hypercall_handler(void *data, u64 *status)
+{
+	struct mshv_partition *partition = data;
+
+	wait_for_completion(&partition->async_hypercall);
+	reinit_completion(&partition->async_hypercall);
+
+	pr_debug("%s: Partition ID: %llu, async hypercall completed!\n",
+		 __func__, partition->id);
+
+	*status = HV_STATUS_SUCCESS;
+}
+
+static long
+mshv_partition_ioctl_set_property(struct mshv_partition *partition,
+				  void __user *user_args)
+{
+	struct mshv_partition_property args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return hv_call_set_partition_property(partition->id, args.property_code,
+					      args.property_value,
+					      mshv_root_async_hypercall_handler,
+					      partition);
+}
+
+static long
+mshv_partition_ioctl_map_memory(struct mshv_partition *partition,
+				struct mshv_user_mem_region __user *user_mem)
+{
+	struct mshv_user_mem_region mem;
+	struct mshv_mem_region *region;
+	int completed;
+	unsigned long remaining, batch_size, pin_addr;
+	struct page **pages;
+	u64 page_count, user_start, user_end, gpfn_start, gpfn_end;
+	u64 region_page_count, region_user_start, region_user_end;
+	u64 region_gpfn_start, region_gpfn_end;
+	long ret = 0;
+
+	if (copy_from_user(&mem, user_mem, sizeof(mem)))
+		return -EFAULT;
+
+	if (!mem.size ||
+	    !PAGE_ALIGNED(mem.size) ||
+	    !PAGE_ALIGNED(mem.userspace_addr) ||
+	    !access_ok((const void *)mem.userspace_addr, mem.size))
+		return -EINVAL;
+
+	/* Reject overlapping regions */
+	page_count = mem.size >> HV_HYP_PAGE_SHIFT;
+	user_start = mem.userspace_addr;
+	user_end = mem.userspace_addr + mem.size;
+	gpfn_start = mem.guest_pfn;
+	gpfn_end = mem.guest_pfn + page_count;
+
+	hlist_for_each_entry(region, &partition->mem_regions, hnode) {
+		region_page_count = region->size >> HV_HYP_PAGE_SHIFT;
+		region_user_start = region->userspace_addr;
+		region_user_end = region->userspace_addr + region->size;
+		region_gpfn_start = region->guest_pfn;
+		region_gpfn_end = region->guest_pfn + region_page_count;
+
+		if (!(user_end <= region_user_start) &&
+		    !(region_user_end <= user_start)) {
+			return -EEXIST;
+		}
+		if (!(gpfn_end <= region_gpfn_start) &&
+		    !(region_gpfn_end <= gpfn_start)) {
+			return -EEXIST;
+		}
+	}
+
+	region = vzalloc(sizeof(*region) + sizeof(*pages) * page_count);
+	if (!region)
+		return -ENOMEM;
+	region->size = mem.size;
+	region->guest_pfn = mem.guest_pfn;
+	region->userspace_addr = mem.userspace_addr;
+	pages = &region->pages[0];
+
+	/* Pin the userspace pages */
+	remaining = page_count;
+	while (remaining) {
+		/*
+		 * We need to batch this, as pin_user_pages_fast with the
+		 * FOLL_LONGTERM flag does a big temporary allocation
+		 * of contiguous memory
+		 */
+		batch_size = min(remaining, PIN_PAGES_BATCH_SIZE);
+		pin_addr = mem.userspace_addr + (page_count - remaining) * HV_HYP_PAGE_SIZE;
+		completed = pin_user_pages_fast(pin_addr, batch_size,
+						FOLL_WRITE | FOLL_LONGTERM,
+						&pages[page_count - remaining]);
+		if (completed < 0) {
+			pr_err("%s: failed to pin user pages error %i\n",
+			       __func__,
+			       completed);
+			ret = completed;
+			goto err_unpin_pages;
+		}
+		remaining -= completed;
+	}
+
+	/* Map the pages to GPA pages */
+	ret = hv_call_map_gpa_pages(partition->id, mem.guest_pfn,
+				    page_count, mem.flags, pages);
+
+	/* Install the new region */
+	hlist_add_head(&region->hnode, &partition->mem_regions);
+
+	return 0;
+
+err_unpin_pages:
+	unpin_user_pages(pages, page_count - remaining);
+	vfree(region);
+
+	return ret;
+}
+
+static long
+mshv_partition_ioctl_unmap_memory(struct mshv_partition *partition,
+				  struct mshv_user_mem_region __user *user_mem)
+{
+	struct mshv_user_mem_region mem;
+	struct mshv_mem_region *region;
+	u64 page_count;
+	long ret;
+
+	if (hlist_empty(&partition->mem_regions))
+		return -EINVAL;
+
+	if (copy_from_user(&mem, user_mem, sizeof(mem)))
+		return -EFAULT;
+
+	/* Find matching region */
+	hlist_for_each_entry(region, &partition->mem_regions, hnode) {
+		if (region->userspace_addr == mem.userspace_addr &&
+		    region->size == mem.size &&
+		    region->guest_pfn == mem.guest_pfn)
+			break;
+	}
+
+	if (!region)
+		return -EINVAL;
+
+	hlist_del(&region->hnode);
+	page_count = region->size >> HV_HYP_PAGE_SHIFT;
+	ret = hv_call_unmap_gpa_pages(partition->id, region->guest_pfn,
+				      page_count, 0);
+	if (ret)
+		return ret;
+
+	unpin_user_pages(&region->pages[0], page_count);
+	vfree(region);
+
+	return 0;
+}
+
+static long
+mshv_partition_ioctl_ioeventfd(struct mshv_partition *partition,
+			       void __user *user_args)
+{
+	struct mshv_ioeventfd args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return mshv_ioeventfd(partition, &args);
+}
+
+static long
+mshv_partition_ioctl_irqfd(struct mshv_partition *partition,
+			   void __user *user_args)
+{
+	struct mshv_irqfd args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return mshv_irqfd(partition, &args);
+}
+
+static long
+mshv_partition_ioctl_install_intercept(struct mshv_partition *partition,
+				       void __user *user_args)
+{
+	struct mshv_install_intercept args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return hv_call_install_intercept(partition->id, args.access_type_mask,
+					 args.intercept_type,
+					 args.intercept_parameter);
+}
+
+static long
+mshv_partition_ioctl_post_message_direct(struct mshv_partition *partition,
+					 void __user *user_args)
+{
+	struct mshv_post_message_direct args;
+	u8 message[HV_MESSAGE_SIZE];
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.length > HV_MESSAGE_SIZE)
+		return -E2BIG;
+
+	memset(&message[0], 0, sizeof(message));
+	if (copy_from_user(&message[0], args.message, args.length))
+		return -EFAULT;
+
+	return hv_call_post_message_direct(args.vp,
+					partition->id,
+					args.vtl,
+					args.sint,
+					&message[0]);
+}
+
+static long
+mshv_partition_ioctl_signal_event_direct(struct mshv_partition *partition,
+					 void __user *user_args)
+{
+	struct mshv_signal_event_direct args;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	ret = hv_call_signal_event_direct(args.vp, partition->id, args.vtl,
+					  args.sint, args.flag,
+					  &args.newly_signaled);
+
+	if (ret)
+		return ret;
+
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+mshv_partition_ioctl_assert_interrupt(struct mshv_partition *partition,
+				      void __user *user_args)
+{
+	struct mshv_assert_interrupt args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return hv_call_assert_virtual_interrupt(partition->id, args.vector,
+						args.dest_addr, args.control);
+}
+
+static long
+mshv_partition_ioctl_get_gpa_access_state(struct mshv_partition *partition,
+					  void __user *user_args)
+{
+	struct mshv_get_gpa_pages_access_state args;
+	union hv_gpa_page_access_state *states;
+	long ret;
+	int written = 0;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	states = vzalloc(args.count * sizeof(*states));
+	if (!states)
+		return -ENOMEM;
+	ret = hv_call_get_gpa_access_states(partition->id, args.count,
+					    args.hv_gpa_page_number,
+					    args.flags, &written, states);
+	if (ret)
+		goto free_return;
+
+	args.count = written;
+	if (copy_to_user(user_args, &args, sizeof(args))) {
+		ret = -EFAULT;
+		goto free_return;
+	}
+
+	if (copy_to_user((void __user *)args.states_ptr, states,
+			 sizeof(*states) * args.count))
+		ret = -EFAULT;
+
+free_return:
+	vfree(states);
+	return ret;
+}
+
+static long
+mshv_partition_ioctl_set_msi_routing(struct mshv_partition *partition,
+				     void __user *user_args)
+{
+	struct mshv_msi_routing_entry *entries = NULL;
+	struct mshv_msi_routing args;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.nr > MSHV_MAX_MSI_ROUTES)
+		return -EINVAL;
+
+	if (args.nr) {
+		struct mshv_msi_routing __user *urouting = user_args;
+
+		entries = vmemdup_user(urouting->entries,
+				       array_size(sizeof(*entries),
+						  args.nr));
+		if (IS_ERR(entries))
+			return PTR_ERR(entries);
+	}
+	ret = mshv_set_msi_routing(partition, entries, args.nr);
+	kvfree(entries);
+
+	return ret;
+}
+
+#ifdef HV_SUPPORTS_REGISTER_DELIVERABILITY_NOTIFICATIONS
+static long
+mshv_partition_ioctl_register_deliverabilty_notifications(struct mshv_partition *partition,
+							  void __user *user_args)
+{
+	struct mshv_register_deliverabilty_notifications args;
+	struct hv_register_assoc hv_reg;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	memset(&hv_reg, 0, sizeof(hv_reg));
+	hv_reg.name = HV_X64_REGISTER_DELIVERABILITY_NOTIFICATIONS;
+	hv_reg.value.reg64 = args.flag;
+
+	return mshv_set_vp_registers(args.vp, partition->id, 1, &hv_reg);
+}
+#endif
+
+static long
+mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	struct mshv_partition *partition = filp->private_data;
+	long ret;
+
+	if (mutex_lock_killable(&partition->mutex))
+		return -EINTR;
+
+	switch (ioctl) {
+	case MSHV_MAP_GUEST_MEMORY:
+		ret = mshv_partition_ioctl_map_memory(partition,
+						      (void __user *)arg);
+		break;
+	case MSHV_UNMAP_GUEST_MEMORY:
+		ret = mshv_partition_ioctl_unmap_memory(partition,
+							(void __user *)arg);
+		break;
+	case MSHV_CREATE_VP:
+		ret = mshv_partition_ioctl_create_vp(partition,
+						     (void __user *)arg);
+		break;
+	case MSHV_INSTALL_INTERCEPT:
+		ret = mshv_partition_ioctl_install_intercept(partition,
+							     (void __user *)arg);
+		break;
+	case MSHV_ASSERT_INTERRUPT:
+		ret = mshv_partition_ioctl_assert_interrupt(partition,
+							    (void __user *)arg);
+		break;
+	case MSHV_GET_PARTITION_PROPERTY:
+		ret = mshv_partition_ioctl_get_property(partition,
+							(void __user *)arg);
+		break;
+	case MSHV_SET_PARTITION_PROPERTY:
+		ret = mshv_partition_ioctl_set_property(partition,
+							(void __user *)arg);
+		break;
+	case MSHV_IRQFD:
+		ret = mshv_partition_ioctl_irqfd(partition,
+						 (void __user *)arg);
+		break;
+	case MSHV_IOEVENTFD:
+		ret = mshv_partition_ioctl_ioeventfd(partition,
+						     (void __user *)arg);
+		break;
+	case MSHV_SET_MSI_ROUTING:
+		ret = mshv_partition_ioctl_set_msi_routing(partition,
+							   (void __user *)arg);
+		break;
+	case MSHV_GET_GPA_ACCESS_STATES:
+		ret = mshv_partition_ioctl_get_gpa_access_state(partition,
+								(void __user *)arg);
+		break;
+	case MSHV_SIGNAL_EVENT_DIRECT:
+		ret = mshv_partition_ioctl_signal_event_direct(partition,
+							       (void __user *)arg);
+		break;
+	case MSHV_POST_MESSAGE_DIRECT:
+		ret = mshv_partition_ioctl_post_message_direct(partition,
+							       (void __user *)arg);
+		break;
+#ifdef HV_SUPPORTS_REGISTER_DELIVERABILITY_NOTIFICATIONS
+	case MSHV_REGISTER_DELIVERABILITY_NOTIFICATIONS:
+		ret = mshv_partition_ioctl_register_deliverabilty_notifications(partition,
+										(void __user *)arg);
+		break;
+#endif
+	default:
+		ret = -ENOTTY;
+	}
+
+	mutex_unlock(&partition->mutex);
+	return ret;
+}
+
+static int
+disable_vp_dispatch(struct mshv_vp *vp)
+{
+	int ret;
+	struct hv_register_assoc dispatch_suspend = {
+		.name = HV_REGISTER_DISPATCH_SUSPEND,
+		.value.dispatch_suspend.suspended = 1,
+	};
+
+	ret = mshv_set_vp_registers(vp->index, vp->partition->id,
+				    1, &dispatch_suspend);
+	if (ret)
+		pr_err("%s: failed to suspend partition %llu vp %u\n",
+		       __func__, vp->partition->id, vp->index);
+
+	return ret;
+}
+
+static int
+get_vp_signaled_count(struct mshv_vp *vp, u64 *count)
+{
+	int ret;
+	struct hv_register_assoc root_signal_count = {
+		.name = HV_REGISTER_VP_ROOT_SIGNAL_COUNT,
+	};
+
+	ret = mshv_get_vp_registers(vp->index, vp->partition->id,
+				    1, &root_signal_count);
+
+	if (ret) {
+		pr_err("%s: failed to get root signal count for partition %llu vp %u",
+		       __func__, vp->partition->id, vp->index);
+		*count = 0;
+		return ret;
+	}
+
+	*count = root_signal_count.value.reg64;
+
+	return ret;
+}
+
+static void
+drain_vp_signals(struct mshv_vp *vp)
+{
+	u64 hv_signal_count;
+	u64 vp_signal_count;
+
+	WARN_ON(get_vp_signaled_count(vp, &hv_signal_count));
+
+	vp_signal_count = atomic64_read(&vp->run.signaled_count);
+
+	/*
+	 * There should be at most 1 outstanding notification, but be extra
+	 * careful anyway.
+	 */
+	while (hv_signal_count != vp_signal_count) {
+		WARN_ON(hv_signal_count - vp_signal_count != 1);
+
+		if (wait_event_interruptible(vp->run.suspend_queue,
+					     vp->run.kicked_by_hv == 1))
+			break;
+		vp->run.kicked_by_hv = 0;
+		vp_signal_count = atomic64_read(&vp->run.signaled_count);
+	}
+}
+
+static void drain_all_vps(const struct mshv_partition *partition)
+{
+	int i;
+	struct mshv_vp *vp;
+
+	/*
+	 * VPs are reachable from ISR. It is safe to not take the partition
+	 * lock because nobody else can enter this function and drop the
+	 * partition from the list.
+	 */
+	for (i = 0; i < MSHV_MAX_VPS; i++) {
+		vp = partition->vps.array[i];
+		if (!vp)
+			continue;
+		/*
+		 * Disable dispatching of the VP in the hypervisor. After this
+		 * the hypervisor guarantees it won't generate any signals for
+		 * the VP and the hypervisor's VP signal count won't change.
+		 */
+		disable_vp_dispatch(vp);
+		drain_vp_signals(vp);
+	}
+}
+
+static void
+remove_partition(struct mshv_partition *partition)
+{
+	spin_lock(&mshv_root.partitions.lock);
+	hlist_del_rcu(&partition->hnode);
+
+	if (!--mshv_root.partitions.count)
+		hv_setup_mshv_irq(NULL);
+
+	spin_unlock(&mshv_root.partitions.lock);
+
+	synchronize_rcu();
+}
+
+static void
+destroy_partition(struct mshv_partition *partition)
+{
+	unsigned long page_count;
+	struct mshv_vp *vp;
+	struct mshv_mem_region *region;
+	int i;
+	struct hlist_node *n;
+
+	/*
+	 * This must be done before we drain all the vps and call
+	 * remove_partition, otherwise we won't receive the interrupt
+	 * for completion of this async hypercall.
+	 */
+	if (mshv_partition_isolation_type_snp(partition)) {
+		WARN_ON(hv_call_set_partition_property(partition->id,
+						       HV_PARTITION_PROPERTY_ISOLATION_STATE,
+						       HV_PARTITION_ISOLATION_INSECURE_DIRTY,
+						       mshv_root_async_hypercall_handler,
+						       partition));
+	}
+
+	/*
+	 * We only need to drain signals for root scheduler. This should be
+	 * done before removing the partition from the partition list.
+	 */
+	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
+		drain_all_vps(partition);
+
+	/*
+	 * Remove from list of partitions; after this point nothing else holds
+	 * a reference to the partition
+	 */
+	remove_partition(partition);
+
+	/* Remove vps */
+	for (i = 0; i < MSHV_MAX_VPS; ++i) {
+		vp = partition->vps.array[i];
+		if (!vp)
+			continue;
+
+		kfree(vp->registers);
+		if (vp->intercept_message_page) {
+			(void)hv_call_unmap_vp_state_page(partition->id, vp->index,
+					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE);
+			vp->intercept_message_page = NULL;
+		}
+		kfree(vp);
+	}
+
+	/* Deallocates and unmaps everything including vcpus, GPA mappings etc */
+	hv_call_finalize_partition(partition->id);
+	/* Withdraw and free all pages we deposited */
+	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->id);
+	hv_call_delete_partition(partition->id);
+
+	/* Remove regions and unpin the pages */
+	hlist_for_each_entry_safe(region, n, &partition->mem_regions, hnode) {
+		hlist_del(&region->hnode);
+		page_count = region->size >> HV_HYP_PAGE_SHIFT;
+		unpin_user_pages(&region->pages[0], page_count);
+		vfree(region);
+	}
+
+	mshv_free_msi_routing(partition);
+	kfree(partition);
+}
+
+static struct
+mshv_partition *mshv_partition_get(struct mshv_partition *partition)
+{
+	if (refcount_inc_not_zero(&partition->ref_count))
+		return partition;
+	return NULL;
+}
+
+struct
+mshv_partition *mshv_partition_find(u64 partition_id)
+	__must_hold(RCU)
+{
+	struct mshv_partition *p;
+
+	hash_for_each_possible_rcu(mshv_root.partitions.items, p, hnode, partition_id)
+		if (p->id == partition_id)
+			return p;
+
+	return NULL;
+}
+
+static void
+mshv_partition_put(struct mshv_partition *partition)
+{
+	if (refcount_dec_and_test(&partition->ref_count))
+		destroy_partition(partition);
+}
+
+static int
+mshv_partition_release(struct inode *inode, struct file *filp)
+{
+	struct mshv_partition *partition = filp->private_data;
+
+	mshv_eventfd_release(partition);
+
+	cleanup_srcu_struct(&partition->irq_srcu);
+
+	mshv_partition_put(partition);
+
+	return 0;
+}
+
+static int
+add_partition(struct mshv_partition *partition)
+{
+	spin_lock(&mshv_root.partitions.lock);
+
+	hash_add_rcu(mshv_root.partitions.items, &partition->hnode, partition->id);
+
+	mshv_root.partitions.count++;
+	if (mshv_root.partitions.count == 1)
+		hv_setup_mshv_irq(mshv_isr);
+
+	spin_unlock(&mshv_root.partitions.lock);
+
+	return 0;
+}
+
+static long
+__mshv_ioctl_create_partition(void __user *user_arg)
+{
+	struct mshv_create_partition args;
+	struct mshv_partition *partition;
+	struct file *file;
+	int fd;
+	long ret;
+
+	if (copy_from_user(&args, user_arg, sizeof(args)))
+		return -EFAULT;
+
+	/* Only support EXO partitions */
+	args.flags |= HV_PARTITION_CREATION_FLAG_EXO_PARTITION;
+	/* Enable intercept message page */
+	args.flags |= HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
+
+	partition = kzalloc(sizeof(*partition), GFP_KERNEL);
+	if (!partition)
+		return -ENOMEM;
+
+	partition->isolation_type = args.isolation_properties.isolation_type;
+
+	refcount_set(&partition->ref_count, 1);
+
+	mutex_init(&partition->mutex);
+
+	mutex_init(&partition->irq_lock);
+
+	init_completion(&partition->async_hypercall);
+
+	INIT_HLIST_HEAD(&partition->irq_ack_notifier_list);
+
+	INIT_HLIST_HEAD(&partition->mem_regions);
+
+	mshv_eventfd_init(partition);
+
+	ret = init_srcu_struct(&partition->irq_srcu);
+	if (ret)
+		goto free_partition;
+
+	ret = hv_call_create_partition(args.flags,
+				       args.partition_creation_properties,
+				       args.isolation_properties,
+				       &partition->id);
+	if (ret)
+		goto cleanup_irq_srcu;
+
+	ret = add_partition(partition);
+	if (ret)
+		goto delete_partition;
+
+	ret = hv_call_set_partition_property(partition->id,
+					     HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES,
+					     args.synthetic_processor_features.as_uint64[0],
+					     mshv_root_async_hypercall_handler,
+					     partition);
+	if (ret)
+		goto remove_partition;
+
+	ret = hv_call_initialize_partition(partition->id);
+	if (ret)
+		goto remove_partition;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		ret = fd;
+		goto finalize_partition;
+	}
+
+	file = anon_inode_getfile("mshv_partition", &mshv_partition_fops,
+				  partition, O_RDWR);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto put_fd;
+	}
+
+	fd_install(fd, file);
+
+	return fd;
+
+put_fd:
+	put_unused_fd(fd);
+finalize_partition:
+	hv_call_finalize_partition(partition->id);
+remove_partition:
+	remove_partition(partition);
+delete_partition:
+	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->id);
+	hv_call_delete_partition(partition->id);
+cleanup_irq_srcu:
+	cleanup_srcu_struct(&partition->irq_srcu);
+free_partition:
+	kfree(partition);
+	return ret;
+}
+
+static int mshv_cpuhp_online;
+static int mshv_root_sched_online;
+
+static const char *scheduler_type_to_string(enum hv_scheduler_type type)
+{
+	switch (type) {
+	case HV_SCHEDULER_TYPE_LP:
+		return "classic scheduler without SMT";
+	case HV_SCHEDULER_TYPE_LP_SMT:
+		return "classic scheduler with SMT";
+	case HV_SCHEDULER_TYPE_CORE_SMT:
+		return "core scheduler";
+	case HV_SCHEDULER_TYPE_ROOT:
+		return "root scheduler";
+	default:
+		return "unknown scheduler";
+	};
+}
+
+/* Retrieve and stash the supported scheduler type */
+static int __init mshv_retrieve_scheduler_type(void)
+{
+	struct hv_input_get_system_property *input;
+	struct hv_output_get_system_property *output;
+	unsigned long flags;
+	u64 status;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	memset(input, 0, sizeof(*input));
+	memset(output, 0, sizeof(*output));
+	input->property_id = HV_SYSTEM_PROPERTY_SCHEDULER_TYPE;
+
+	status = hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
+	if (!hv_result_success(status)) {
+		local_irq_restore(flags);
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return hv_status_to_errno(status);
+	}
+
+	hv_scheduler_type = output->scheduler_type;
+	local_irq_restore(flags);
+
+	pr_info("%s: hypervisor using %s\n", __func__,
+		scheduler_type_to_string(hv_scheduler_type));
+
+	switch (hv_scheduler_type) {
+	case HV_SCHEDULER_TYPE_CORE_SMT:
+	case HV_SCHEDULER_TYPE_LP_SMT:
+	case HV_SCHEDULER_TYPE_ROOT:
+	case HV_SCHEDULER_TYPE_LP:
+		/* Supported scheduler, nothing to do */
+		break;
+	default:
+		pr_err("%s: unsupported scheduler 0x%x, bailing.\n", __func__,
+		       hv_scheduler_type);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int mshv_root_scheduler_init(unsigned int cpu)
+{
+	void **inputarg, **outputarg, *p;
+
+	inputarg = (void **)this_cpu_ptr(root_scheduler_input);
+	outputarg = (void **)this_cpu_ptr(root_scheduler_output);
+
+	/* Allocate two consecutive pages. One for input, one for output. */
+	p = kmalloc(2 * HV_HYP_PAGE_SIZE, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	*inputarg = p;
+	*outputarg = (char *)p + HV_HYP_PAGE_SIZE;
+
+	return 0;
+}
+
+static int mshv_root_scheduler_cleanup(unsigned int cpu)
+{
+	void *p, **inputarg, **outputarg;
+
+	inputarg = (void **)this_cpu_ptr(root_scheduler_input);
+	outputarg = (void **)this_cpu_ptr(root_scheduler_output);
+
+	p = *inputarg;
+
+	*inputarg = NULL;
+	*outputarg = NULL;
+
+	kfree(p);
+
+	return 0;
+}
+
+/* Must be called after retrieving the scheduler type */
+static int
+root_scheduler_init(void)
+{
+	int ret;
+
+	if (hv_scheduler_type != HV_SCHEDULER_TYPE_ROOT)
+		return 0;
+
+	root_scheduler_input = alloc_percpu(void *);
+	root_scheduler_output = alloc_percpu(void *);
+
+	if (!root_scheduler_input || !root_scheduler_output) {
+		pr_err("%s: failed to allocate root scheduler buffers\n",
+		       __func__);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_root_sched",
+				mshv_root_scheduler_init,
+				mshv_root_scheduler_cleanup);
+
+	if (ret < 0) {
+		pr_err("%s: failed to setup root scheduler state: %i\n",
+		       __func__, ret);
+		goto out;
+	}
+
+	mshv_root_sched_online = ret;
+
+	return 0;
+
+out:
+	free_percpu(root_scheduler_input);
+	free_percpu(root_scheduler_output);
+	return ret;
+}
+
+static void
+root_scheduler_deinit(void)
+{
+	if (hv_scheduler_type != HV_SCHEDULER_TYPE_ROOT)
+		return;
+
+	cpuhp_remove_state(mshv_root_sched_online);
+	free_percpu(root_scheduler_input);
+	free_percpu(root_scheduler_output);
+}
+
+int __init mshv_root_init(void)
+{
+	int ret;
+	union hv_hypervisor_version_info version_info;
+
+	if (!hv_root_partition)
+		return -ENODEV;
+
+	if (hv_get_hypervisor_version(&version_info))
+		return -ENODEV;
+
+	if (version_info.build_number < MSHV_HV_MIN_VERSION ||
+	    version_info.build_number > MSHV_HV_MAX_VERSION) {
+		pr_warn("%s: Hypervisor version %u not supported!\n",
+			__func__, version_info.build_number);
+		pr_warn("%s: Min version: %u, max version: %u\n",
+			__func__, MSHV_HV_MIN_VERSION,
+			MSHV_HV_MAX_VERSION);
+		if (ignore_hv_version) {
+			pr_warn("%s: Continuing because param mshv_root.ignore_hv_version is set\n",
+				__func__);
+		} else {
+			pr_err("%s: Failing because version is not supported. Use param mshv_root.ignore_hv_version=1 to proceed anyway\n",
+			       __func__);
+			return -ENODEV;
+		}
+	}
+
+	if (mshv_retrieve_scheduler_type())
+		return -ENODEV;
+
+	ret = root_scheduler_init();
+	if (ret)
+		goto out;
+
+	mshv_root.synic_pages = alloc_percpu(struct hv_synic_pages);
+	if (!mshv_root.synic_pages) {
+		pr_err("%s: failed to allocate percpu synic page\n", __func__);
+		ret = -ENOMEM;
+		goto root_sched_deinit;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
+				mshv_synic_init,
+				mshv_synic_cleanup);
+	if (ret < 0) {
+		pr_err("%s: failed to setup cpu hotplug state: %i\n",
+		       __func__, ret);
+		goto free_synic_pages;
+	}
+	mshv_cpuhp_online = ret;
+
+	ret = mshv_irqfd_wq_init();
+	if (ret < 0) {
+		pr_err("%s: failed to setup mshv irqfd workqueue: %i\n",
+		       __func__, ret);
+		goto remove_cpu_state;
+	}
+
+	ret = mshv_set_create_partition_func(__mshv_ioctl_create_partition);
+	if (ret)
+		goto wq_cleanup;
+
+	spin_lock_init(&mshv_root.partitions.lock);
+	hash_init(mshv_root.partitions.items);
+
+	return 0;
+
+wq_cleanup:
+	mshv_irqfd_wq_cleanup();
+remove_cpu_state:
+	cpuhp_remove_state(mshv_cpuhp_online);
+free_synic_pages:
+	free_percpu(mshv_root.synic_pages);
+root_sched_deinit:
+	root_scheduler_deinit();
+out:
+	return ret;
+}
+
+void __exit mshv_root_exit(void)
+{
+	mshv_set_create_partition_func(NULL);
+
+	mshv_irqfd_wq_cleanup();
+
+	root_scheduler_deinit();
+
+	cpuhp_remove_state(mshv_cpuhp_online);
+	free_percpu(mshv_root.synic_pages);
+
+	mshv_port_table_fini();
+}
+
+module_init(mshv_root_init);
+module_exit(mshv_root_exit);
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
new file mode 100644
index 000000000000..1a8837021e1a
--- /dev/null
+++ b/drivers/hv/mshv_synic.c
@@ -0,0 +1,688 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * mshv_root module's main interrupt handler and associated functionality.
+ *
+ * Authors:
+ *   Nuno Das Neves <nunodasneves@linux.microsoft.com>
+ *   Lillian Grassin-Drake <ligrassi@microsoft.com>
+ *   Vineeth Remanan Pillai <viremana@linux.microsoft.com>
+ *   Wei Liu <wei.liu@kernel.org>
+ *   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/random.h>
+#include <asm/mshyperv.h>
+
+#include "mshv_eventfd.h"
+#include "mshv.h"
+
+u32
+synic_event_ring_get_queued_port(u32 sint_index)
+{
+	struct hv_synic_event_ring_page **event_ring_page;
+	struct hv_synic_event_ring *ring;
+	struct hv_synic_pages *spages;
+	u8 **synic_eventring_tail;
+	u32 message;
+	u8 tail;
+
+	spages = this_cpu_ptr(mshv_root.synic_pages);
+	event_ring_page = &spages->synic_event_ring_page;
+	synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+	tail = (*synic_eventring_tail)[sint_index];
+
+	if (unlikely(!(*event_ring_page))) {
+		pr_err("%s: Missing synic event ring page!\n", __func__);
+		return 0;
+	}
+
+	ring = &(*event_ring_page)->sint_event_ring[sint_index];
+
+	/*
+	 * Get the message.
+	 */
+	message = ring->data[tail];
+
+	if (!message) {
+		if (ring->ring_full) {
+			/*
+			 * Ring is marked full, but we would have consumed all
+			 * the messages. Notify the hypervisor that ring is now
+			 * empty and check again.
+			 */
+			ring->ring_full = 0;
+			hv_call_notify_port_ring_empty(sint_index);
+			message = ring->data[tail];
+		}
+
+		if (!message) {
+			ring->signal_masked = 0;
+			/*
+			 * Unmask the signal and sync with hypervisor
+			 * before one last check for any message.
+			 */
+			mb();
+			message = ring->data[tail];
+
+			/*
+			 * Ok, lets bail out.
+			 */
+			if (!message)
+				return 0;
+		}
+
+		ring->signal_masked = 1;
+	}
+
+	/*
+	 * Clear the message in the ring buffer.
+	 */
+	ring->data[tail] = 0;
+
+	if (++tail == HV_SYNIC_EVENT_RING_MESSAGE_COUNT)
+		tail = 0;
+
+	(*synic_eventring_tail)[sint_index] = tail;
+
+	return message;
+}
+
+static bool
+mshv_doorbell_isr(struct hv_message *msg)
+{
+	struct hv_notification_message_payload *notification;
+	u32 port;
+
+	if (msg->header.message_type != HVMSG_SYNIC_SINT_INTERCEPT)
+		return false;
+
+	notification = (struct hv_notification_message_payload *)msg->u.payload;
+	if (notification->sint_index != HV_SYNIC_DOORBELL_SINT_INDEX)
+		return false;
+
+	while ((port = synic_event_ring_get_queued_port(HV_SYNIC_DOORBELL_SINT_INDEX))) {
+		struct port_table_info ptinfo = { 0 };
+
+		if (mshv_portid_lookup(port, &ptinfo)) {
+			pr_err("Failed to get port information from port_table!\n");
+			continue;
+		}
+
+		if (ptinfo.port_type != HV_PORT_TYPE_DOORBELL) {
+			pr_warn("Not a doorbell port!, port: %d, port_type: %d\n",
+				port, ptinfo.port_type);
+			continue;
+		}
+
+		/* Invoke the callback */
+		ptinfo.port_doorbell.doorbell_cb(port, ptinfo.port_doorbell.data);
+	}
+
+	return true;
+}
+
+static bool mshv_async_call_completion_isr(struct hv_message *msg)
+{
+	bool handled = false;
+	struct hv_async_completion_message_payload *async_msg;
+	struct mshv_partition *partition;
+	u64 partition_id;
+
+	if (msg->header.message_type != HVMSG_ASYNC_CALL_COMPLETION)
+		goto out;
+
+	async_msg =
+		(struct hv_async_completion_message_payload *)msg->u.payload;
+
+	partition_id = async_msg->partition_id;
+
+	/*
+	 * Hold this lock for the rest of the isr, because the partition could
+	 * be released anytime.
+	 * e.g. the MSHV_RUN_VP thread could wake on another cpu; it could
+	 * release the partition unless we hold this!
+	 */
+	rcu_read_lock();
+
+	partition = mshv_partition_find(partition_id);
+	if (unlikely(!partition)) {
+		pr_err("%s: failed to find partition %llu\n",
+		       __func__, partition_id);
+		goto unlock_out;
+	}
+
+	pr_debug("%s: Partition ID: %llu completing async hypercall\n",
+		 __func__, async_msg->partition_id);
+
+	complete(&partition->async_hypercall);
+
+	handled = true;
+
+unlock_out:
+	rcu_read_unlock();
+out:
+	return handled;
+}
+
+static void kick_vp(struct mshv_vp *vp)
+{
+	atomic64_inc(&vp->run.signaled_count);
+	vp->run.kicked_by_hv = 1;
+	wake_up(&vp->run.suspend_queue);
+}
+
+static void
+handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
+{
+	int bank_idx, vp_signaled, bank_mask_size;
+	struct mshv_partition *partition;
+	const struct hv_vpset *vpset;
+	const u64 *bank_contents;
+	u64 partition_id = msg->partition_id;
+
+	if (msg->vp_bitset.bitset.format != HV_GENERIC_SET_SPARSE_4K) {
+		pr_debug("%s: scheduler message format is not HV_GENERIC_SET_SPARSE_4K",
+			 __func__);
+		return;
+	}
+
+	if (msg->vp_count == 0) {
+		pr_debug("%s: scheduler message with no VP specified", __func__);
+		return;
+	}
+
+	rcu_read_lock();
+
+	partition = mshv_partition_find(partition_id);
+	if (unlikely(!partition)) {
+		pr_err("%s: failed to find partition %llu\n", __func__,
+		       partition_id);
+		goto unlock_out;
+	}
+
+	vpset = &msg->vp_bitset.bitset;
+
+	bank_idx = -1;
+	bank_contents = vpset->bank_contents;
+	bank_mask_size = sizeof(vpset->valid_bank_mask) * BITS_PER_BYTE;
+
+	vp_signaled = 0;
+
+	while (true) {
+		int vp_bank_idx = -1;
+		int vp_bank_size = sizeof(*bank_contents) * BITS_PER_BYTE;
+		int vp_index;
+
+		bank_idx = find_next_bit((unsigned long *)&vpset->valid_bank_mask,
+					 bank_mask_size, bank_idx + 1);
+		if (bank_idx == bank_mask_size)
+			break;
+
+		while (true) {
+			struct mshv_vp *vp;
+
+			vp_bank_idx = find_next_bit((unsigned long *)bank_contents,
+						    vp_bank_size, vp_bank_idx + 1);
+			if (vp_bank_idx == vp_bank_size)
+				break;
+
+			vp_index = (bank_idx << HV_GENERIC_SET_SHIFT) + vp_bank_idx;
+
+			/* This shouldn't happen, but just in case. */
+			if (unlikely(vp_index >= MSHV_MAX_VPS)) {
+				pr_err("%s: VP index %u out of bounds\n",
+				       __func__, vp_index);
+				goto unlock_out;
+			}
+
+			vp = partition->vps.array[vp_index];
+			if (unlikely(!vp)) {
+				pr_err("%s: failed to find vp\n", __func__);
+				goto unlock_out;
+			}
+
+			kick_vp(vp);
+			vp_signaled++;
+		}
+
+		bank_contents++;
+	}
+
+unlock_out:
+	rcu_read_unlock();
+
+	if (vp_signaled != msg->vp_count)
+		pr_debug("%s: asked to signal %u VPs but only did %u\n",
+			 __func__, msg->vp_count, vp_signaled);
+}
+
+static void
+handle_pair_message(const struct hv_vp_signal_pair_scheduler_message *msg)
+{
+	struct mshv_partition *partition = NULL;
+	struct mshv_vp *vp;
+	int idx;
+
+	rcu_read_lock();
+
+	for (idx = 0; idx < msg->vp_count; idx++) {
+		u64 partition_id = msg->partition_ids[idx];
+		u32 vp_index = msg->vp_indexes[idx];
+
+		if (idx == 0 || partition->id != partition_id) {
+			partition = mshv_partition_find(partition_id);
+			if (unlikely(!partition)) {
+				pr_err("%s: failed to find partition %llu\n",
+				       __func__, partition_id);
+				break;
+			}
+		}
+
+		/* This shouldn't happen, but just in case. */
+		if (unlikely(vp_index >= MSHV_MAX_VPS)) {
+			pr_err("%s: VP index %u out of bounds\n", __func__,
+			       vp_index);
+			break;
+		}
+
+		vp = partition->vps.array[vp_index];
+		if (!vp) {
+			pr_err("%s: failed to find VP\n", __func__);
+			break;
+		}
+
+		kick_vp(vp);
+	}
+
+	rcu_read_unlock();
+}
+
+static bool
+mshv_scheduler_isr(struct hv_message *msg)
+{
+	if (msg->header.message_type != HVMSG_SCHEDULER_VP_SIGNAL_BITSET &&
+	    msg->header.message_type != HVMSG_SCHEDULER_VP_SIGNAL_PAIR)
+		return false;
+
+	if (msg->header.message_type == HVMSG_SCHEDULER_VP_SIGNAL_BITSET)
+		handle_bitset_message(
+			(struct hv_vp_signal_bitset_scheduler_message *)msg->u.payload);
+	else
+		handle_pair_message(
+			(struct hv_vp_signal_pair_scheduler_message *)msg->u.payload);
+
+	return true;
+}
+
+static bool
+mshv_intercept_isr(struct hv_message *msg)
+{
+	struct mshv_partition *partition;
+	bool handled = false;
+	struct mshv_vp *vp;
+	u64 partition_id;
+	u32 vp_index;
+
+	partition_id = msg->header.sender;
+
+	rcu_read_lock();
+
+	partition = mshv_partition_find(partition_id);
+	if (unlikely(!partition)) {
+		pr_err("%s: failed to find partition %llu\n",
+		       __func__, partition_id);
+		goto unlock_out;
+	}
+
+	if (msg->header.message_type == HVMSG_X64_APIC_EOI) {
+		/*
+		 * Check if this gsi is registered in the
+		 * ack_notifier list and invoke the callback
+		 * if registered.
+		 *
+		 * If there is a notifier, the ack callback is supposed
+		 * to handle the VMEXIT. So we need not pass this message
+		 * to vcpu thread.
+		 */
+		struct hv_x64_apic_eoi_message *eoi_msg =
+			(struct hv_x64_apic_eoi_message *)&msg->u.payload[0];
+
+		if (mshv_notify_acked_gsi(partition,
+					  eoi_msg->interrupt_vector)) {
+			handled = true;
+			goto unlock_out;
+		}
+	}
+
+	/*
+	 * We should get an opaque intercept message here for all intercept
+	 * messages, since we're using the mapped VP intercept message page.
+	 *
+	 * The intercept message will have been placed in intercept message
+	 * page at this point.
+	 *
+	 * Make sure the message type matches our expectation.
+	 */
+	if (msg->header.message_type != HVMSG_OPAQUE_INTERCEPT) {
+		pr_debug("%s: wrong message type %d", __func__,
+			 msg->header.message_type);
+		goto unlock_out;
+	}
+
+	/*
+	 * Since we directly index the vp, and it has to exist for us to be here
+	 * (because the vp is only deleted when the partition is), no additional
+	 * locking is needed here
+	 */
+	vp_index = ((struct hv_opaque_intercept_message *)msg->u.payload)->vp_index;
+	vp = partition->vps.array[vp_index];
+	if (unlikely(!vp)) {
+		pr_err("%s: failed to find vp\n", __func__);
+		goto unlock_out;
+	}
+
+	kick_vp(vp);
+
+	handled = true;
+
+unlock_out:
+	rcu_read_unlock();
+
+	return handled;
+}
+
+void mshv_isr(void)
+{
+	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
+	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_message *msg;
+	bool handled;
+
+	if (unlikely(!(*msg_page))) {
+		pr_err("%s: Missing synic page!\n", __func__);
+		return;
+	}
+
+	msg = &((*msg_page)->sint_message[HV_SYNIC_INTERCEPTION_SINT_INDEX]);
+
+	/*
+	 * If the type isn't set, there isn't really a message;
+	 * it may be some other hyperv interrupt
+	 */
+	if (msg->header.message_type == HVMSG_NONE)
+		return;
+
+	handled = mshv_doorbell_isr(msg);
+
+	if (!handled)
+		handled = mshv_scheduler_isr(msg);
+
+	if (!handled)
+		handled = mshv_async_call_completion_isr(msg);
+
+	if (!handled)
+		handled = mshv_intercept_isr(msg);
+
+	if (handled) {
+		/*
+		 * Acknowledge message with hypervisor if another message is
+		 * pending.
+		 */
+		msg->header.message_type = HVMSG_NONE;
+		/*
+		 * This mb() just ensures EOM is written to before clearing the
+		 * message_type to HVMSGE_NONE.
+		 *
+		 * If that happened, the hypervisor may not deliver the next
+		 * message as the slot is not empty.
+		 */
+		mb();
+		if (msg->header.message_flags.msg_pending)
+			hv_set_non_nested_register(HV_MSR_EOM, 0);
+
+#ifdef HYPERVISOR_CALLBACK_VECTOR
+		add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR);
+#endif
+	} else {
+		pr_warn_once("%s: unknown message type 0x%x\n", __func__,
+			     msg->header.message_type);
+	}
+}
+
+int mshv_synic_init(unsigned int cpu)
+{
+	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+	union hv_synic_sirbp sirbp;
+#ifdef HYPERVISOR_CALLBACK_VECTOR
+	union hv_synic_sint sint;
+#endif
+	union hv_synic_scontrol sctrl;
+	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
+	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_synic_event_flags_page **event_flags_page =
+			&spages->synic_event_flags_page;
+	struct hv_synic_event_ring_page **event_ring_page =
+			&spages->synic_event_ring_page;
+
+	/* Setup the Synic's message page */
+	simp.as_uint64 = hv_get_non_nested_register(HV_MSR_SIMP);
+	simp.simp_enabled = true;
+	*msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
+			     HV_HYP_PAGE_SIZE,
+			     MEMREMAP_WB);
+	if (!(*msg_page)) {
+		pr_err("%s: SIMP memremap failed\n", __func__);
+		return -EFAULT;
+	}
+	hv_set_non_nested_register(HV_MSR_SIMP, simp.as_uint64);
+
+	/* Setup the Synic's event flags page */
+	siefp.as_uint64 = hv_get_non_nested_register(HV_MSR_SIEFP);
+	siefp.siefp_enabled = true;
+	*event_flags_page = memremap(siefp.base_siefp_gpa << PAGE_SHIFT,
+				     PAGE_SIZE, MEMREMAP_WB);
+
+	if (!(*event_flags_page)) {
+		pr_err("%s: SIEFP memremap failed\n", __func__);
+		goto disable_simp;
+	}
+	hv_set_non_nested_register(HV_MSR_SIEFP, siefp.as_uint64);
+
+	/* Setup the Synic's event ring page */
+	sirbp.as_uint64 = hv_get_non_nested_register(HV_MSR_SIRBP);
+	sirbp.sirbp_enabled = true;
+	*event_ring_page = memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
+				    PAGE_SIZE, MEMREMAP_WB);
+
+	if (!(*event_ring_page)) {
+		pr_err("%s: SIRBP memremap failed\n", __func__);
+		goto disable_siefp;
+	}
+	hv_set_non_nested_register(HV_MSR_SIRBP, sirbp.as_uint64);
+
+#ifdef HYPERVISOR_CALLBACK_VECTOR
+	/* Enable intercepts */
+	sint.as_uint64 = hv_get_non_nested_register(HV_MSR_SINT0 +
+						    HV_SYNIC_INTERCEPTION_SINT_INDEX);
+	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.masked = false;
+	sint.auto_eoi = hv_recommend_using_aeoi();
+	hv_set_non_nested_register(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
+				   sint.as_uint64);
+
+	/* Enable doorbell SINT as an intercept */
+	sint.as_uint64 = hv_get_non_nested_register(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX);
+	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.masked = false;
+	sint.as_intercept = true;
+	sint.auto_eoi = hv_recommend_using_aeoi();
+	hv_set_non_nested_register(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
+				   sint.as_uint64);
+#endif
+
+	/* Enable the global synic bit */
+	sctrl.as_uint64 = hv_get_non_nested_register(HV_MSR_SCONTROL);
+	sctrl.enable = true;
+	hv_set_non_nested_register(HV_MSR_SCONTROL, sctrl.as_uint64);
+
+	return 0;
+
+disable_siefp:
+	siefp.as_uint64 = hv_get_non_nested_register(HV_MSR_SIEFP);
+	siefp.siefp_enabled = false;
+	siefp.base_siefp_gpa = 0;
+	hv_set_non_nested_register(HV_MSR_SIEFP, siefp.as_uint64);
+	memunmap(*event_flags_page);
+	*event_flags_page = NULL;
+disable_simp:
+	simp.as_uint64 = hv_get_non_nested_register(HV_MSR_SIMP);
+	simp.simp_enabled = false;
+	simp.base_simp_gpa = 0;
+	hv_set_non_nested_register(HV_MSR_SIMP, simp.as_uint64);
+	memunmap(*msg_page);
+	*msg_page = NULL;
+
+	return -EFAULT;
+}
+
+int mshv_synic_cleanup(unsigned int cpu)
+{
+	union hv_synic_sint sint;
+	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+	union hv_synic_sirbp sirbp;
+	union hv_synic_scontrol sctrl;
+	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
+	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_synic_event_flags_page **event_flags_page =
+		&spages->synic_event_flags_page;
+	struct hv_synic_event_ring_page **event_ring_page =
+		&spages->synic_event_ring_page;
+
+	/* Disable intercepts */
+	sint.as_uint64 = hv_get_non_nested_register(HV_MSR_SINT0 +
+						    HV_SYNIC_INTERCEPTION_SINT_INDEX);
+	sint.masked = true;
+	hv_set_non_nested_register(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
+				   sint.as_uint64);
+
+	/* Disable doorbell */
+	sint.as_uint64 = hv_get_non_nested_register(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX);
+	sint.masked = true;
+	hv_set_non_nested_register(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
+				   sint.as_uint64);
+
+	/* Disable synic pages */
+	sirbp.as_uint64 = hv_get_non_nested_register(HV_MSR_SIRBP);
+	sirbp.sirbp_enabled = false;
+	hv_set_non_nested_register(HV_MSR_SIRBP, sirbp.as_uint64);
+	memunmap(*event_ring_page);
+	*event_ring_page = NULL;
+
+	siefp.as_uint64 = hv_get_non_nested_register(HV_MSR_SIEFP);
+	siefp.siefp_enabled = false;
+	hv_set_non_nested_register(HV_MSR_SIEFP, siefp.as_uint64);
+	memunmap(*event_flags_page);
+	*event_flags_page = NULL;
+
+	simp.as_uint64 = hv_get_non_nested_register(HV_MSR_SIMP);
+	simp.simp_enabled = false;
+	hv_set_non_nested_register(HV_MSR_SIMP, simp.as_uint64);
+	memunmap(*msg_page);
+	*msg_page = NULL;
+
+	/* Disable global synic bit */
+	sctrl.as_uint64 = hv_get_non_nested_register(HV_MSR_SCONTROL);
+	sctrl.enable = false;
+	hv_set_non_nested_register(HV_MSR_SCONTROL, sctrl.as_uint64);
+
+	return 0;
+}
+
+int
+mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb, void *data,
+		       u64 gpa, u64 val, u64 flags)
+{
+	struct hv_connection_info connection_info = { 0 };
+	union hv_connection_id connection_id = { 0 };
+	struct port_table_info *port_table_info;
+	struct hv_port_info port_info = { 0 };
+	union hv_port_id port_id = { 0 };
+	int ret;
+
+	port_table_info = kmalloc(sizeof(*port_table_info),
+				  GFP_KERNEL);
+	if (!port_table_info)
+		return -ENOMEM;
+
+	port_table_info->port_type = HV_PORT_TYPE_DOORBELL;
+	port_table_info->port_doorbell.doorbell_cb = doorbell_cb;
+	port_table_info->port_doorbell.data = data;
+	ret = mshv_portid_alloc(port_table_info);
+	if (ret < 0) {
+		pr_err("Failed to create the doorbell port!\n");
+		kfree(port_table_info);
+		return ret;
+	}
+
+	port_id.u.id = ret;
+	port_info.port_type = HV_PORT_TYPE_DOORBELL;
+	port_info.doorbell_port_info.target_sint = HV_SYNIC_DOORBELL_SINT_INDEX;
+	port_info.doorbell_port_info.target_vp = HV_ANY_VP;
+	ret = hv_call_create_port(hv_current_partition_id, port_id, partition_id,
+				  &port_info,
+				  0, 0, NUMA_NO_NODE);
+
+	if (ret < 0) {
+		pr_err("Failed to create the port!\n");
+		mshv_portid_free(port_id.u.id);
+		return ret;
+	}
+
+	connection_id.u.id = port_id.u.id;
+	connection_info.port_type = HV_PORT_TYPE_DOORBELL;
+	connection_info.doorbell_connection_info.gpa = gpa;
+	connection_info.doorbell_connection_info.trigger_value = val;
+	connection_info.doorbell_connection_info.flags = flags;
+
+	ret = hv_call_connect_port(hv_current_partition_id, port_id, partition_id,
+				   connection_id, &connection_info, 0, NUMA_NO_NODE);
+	if (ret < 0) {
+		hv_call_delete_port(hv_current_partition_id, port_id);
+		mshv_portid_free(port_id.u.id);
+		return ret;
+	}
+
+	// lets use the port_id as the doorbell_id
+	return port_id.u.id;
+}
+
+int
+mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
+{
+	int ret = 0;
+	union hv_port_id port_id = { 0 };
+	union hv_connection_id connection_id = { 0 };
+
+	connection_id.u.id = doorbell_portid;
+	ret = hv_call_disconnect_port(partition_id, connection_id);
+	if (ret < 0)
+		pr_err("Failed to disconnect the doorbell connection!\n");
+
+	port_id.u.id = doorbell_portid;
+	ret = hv_call_delete_port(hv_current_partition_id, port_id);
+	if (ret < 0)
+		pr_err("Failed to disconnect the doorbell connection!\n");
+
+	mshv_portid_free(doorbell_portid);
+
+	return ret;
+}
+
diff --git a/drivers/hv/mshv_vtl.h b/drivers/hv/mshv_vtl.h
new file mode 100644
index 000000000000..1327c9a33cc3
--- /dev/null
+++ b/drivers/hv/mshv_vtl.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _MSHV_VTL_H
+#define _MSHV_VTL_H
+
+#include <linux/mshv.h>
+#include <linux/types.h>
+#include <asm/fpu/types.h>
+
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
+
+struct mshv_vtl_run {
+	u32 cancel;
+	u32 vtl_ret_action_size;
+	u32 pad[2];
+	char exit_message[MAX_RUN_MSG_SIZE];
+	union {
+		struct mshv_vtl_cpu_context cpu_context;
+
+		/*
+		 * Reserving room for the cpu context to grow and be
+		 * able to maintain compat with user mode.
+		 */
+		char reserved[1024];
+	};
+	char vtl_ret_actions[MAX_RUN_MSG_SIZE];
+};
+
+#endif /* _MSHV_VTL_H */
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
new file mode 100644
index 000000000000..5422163db432
--- /dev/null
+++ b/drivers/hv/mshv_vtl_main.c
@@ -0,0 +1,1517 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * Author:
+ *   Saurabh Sengar <ssengar@microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/anon_inodes.h>
+#include <linux/pfn_t.h>
+#include <linux/cpuhotplug.h>
+#include <linux/count_zeros.h>
+#include <linux/eventfd.h>
+#include <linux/poll.h>
+#include <linux/file.h>
+#include <asm/debugreg.h>
+#include <asm/mshyperv.h>
+#include <trace/events/ipi.h>
+#include <uapi/asm/mtrr.h>
+#include <uapi/linux/mshv.h>
+
+#include "../../../kernel/fpu/legacy.h"
+#include "mshv.h"
+#include "mshv_vtl.h"
+#include "hyperv_vmbus.h"
+
+MODULE_AUTHOR("Microsoft");
+MODULE_LICENSE("GPL");
+
+#define MSHV_ENTRY_REASON_LOWER_VTL_CALL     0x1
+#define MSHV_ENTRY_REASON_INTERRUPT          0x2
+#define MSHV_ENTRY_REASON_INTERCEPT          0x3
+
+#define MAX_GUEST_MEM_SIZE	BIT_ULL(40)
+#define MSHV_PG_OFF_CPU_MASK	0xFFFF
+#define MSHV_REAL_OFF_SHIFT	16
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
+struct mshv_vtl_hvcall_fd {
+	u64 allow_bitmap[2 * PAGE_SIZE];
+	bool allow_map_intialized;
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
+	u64 id;
+	refcount_t ref_count;
+};
+
+union mshv_synic_overlay_page_msr {
+	u64 as_u64;
+	struct {
+		u64 enabled: 1;
+		u64 reserved: 11;
+		u64 pfn: 52;
+	};
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
+	};
+	u64 as_uint64;
+} __packed;
+
+struct mshv_vtl_per_cpu {
+	struct mshv_vtl_run *run;
+	struct page *reg_page;
+};
+
+static struct mutex	mshv_vtl_poll_file_lock;
+static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
+static union hv_register_vsm_capabilities mshv_vsm_capabilities;
+
+static DEFINE_PER_CPU(struct mshv_vtl_poll_file, mshv_vtl_poll_file);
+static DEFINE_PER_CPU(unsigned long long, num_vtl0_transitions);
+static DEFINE_PER_CPU(struct mshv_vtl_per_cpu, mshv_vtl_per_cpu);
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
+static long __mshv_vtl_ioctl_check_extension(u32 arg)
+{
+	switch (arg) {
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
+static void mshv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
+{
+	struct hv_register_assoc reg_assoc = {};
+	union mshv_synic_overlay_page_msr overlay = {};
+	struct page *reg_page;
+	union hv_input_vtl vtl = { .as_uint8 = 0 };
+
+	reg_page = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
+	if (!reg_page) {
+		WARN(1, "failed to allocate register page\n");
+		return;
+	}
+
+	overlay.enabled = 1;
+	overlay.pfn = page_to_phys(reg_page) >> HV_HYP_PAGE_SHIFT;
+	reg_assoc.name = HV_X64_REGISTER_REG_PAGE;
+	reg_assoc.value.reg64 = overlay.as_u64;
+
+	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+				     1, vtl, &reg_assoc)) {
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
+	/* Setup VTL2 Host VSP SINT. */
+	hv_set_register(HV_MSR_SINT0 + VTL2_VMBUS_SINT_INDEX,
+			sint.as_uint64);
+
+	/* Enable intercepts */
+	if (!mshv_vsm_capabilities.intercept_page_available)
+		hv_set_register(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
+				sint.as_uint64);
+}
+
+static int mshv_vtl_get_vsm_regs(void)
+{
+	struct hv_register_assoc registers[2];
+	union hv_input_vtl input_vtl;
+	int ret, count = 2;
+
+	input_vtl.as_uint8 = 0;
+	registers[0].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
+	registers[1].name = HV_REGISTER_VSM_CAPABILITIES;
+
+	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+				       count, input_vtl, registers);
+	if (ret)
+		return ret;
+
+	mshv_vsm_page_offsets.as_uint64 = registers[0].value.reg64;
+	mshv_vsm_capabilities.as_uint64 = registers[1].value.reg64;
+
+	pr_debug("%s: VSM code page offsets: %#016llx\n", __func__,
+		 mshv_vsm_page_offsets.as_uint64);
+	pr_info("%s: VSM capabilities: %#016llx\n", __func__,
+		mshv_vsm_capabilities.as_uint64);
+
+	return ret;
+}
+
+static int mshv_vtl_configure_vsm_partition(void)
+{
+	union hv_register_vsm_partition_config config;
+	struct hv_register_assoc reg_assoc;
+	union hv_input_vtl input_vtl;
+
+	config.as_u64 = 0;
+	config.default_vtl_protection_mask = HV_MAP_GPA_PERMISSIONS_MASK;
+	config.enable_vtl_protection = 1;
+	config.zero_memory_on_reset = 1;
+	config.intercept_vp_startup = 1;
+	config.intercept_cpuid_unimplemented = 1;
+
+	if (mshv_vsm_capabilities.intercept_page_available) {
+		pr_debug("%s: using intercept page", __func__);
+		config.intercept_page = 1;
+	}
+
+	reg_assoc.name = HV_REGISTER_VSM_PARTITION_CONFIG;
+	reg_assoc.value.reg64 = config.as_u64;
+	input_vtl.as_uint8 = 0;
+
+	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+				       1, input_vtl, &reg_assoc);
+}
+
+static void mshv_vtl_vmbus_isr(void)
+{
+	struct hv_per_cpu_context *per_cpu;
+	struct hv_message *msg;
+	u32 message_type;
+	union hv_synic_event_flags *event_flags;
+	unsigned long word;
+	int i, j;
+	struct eventfd_ctx *eventfd;
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
+	for (i = 0; i < HV_EVENT_FLAGS_LONG_COUNT; i++) {
+		if (READ_ONCE(event_flags->flags[i])) {
+			word = xchg(&event_flags->flags[i], 0);
+			for_each_set_bit(j, &word, BITS_PER_LONG) {
+				rcu_read_lock();
+				eventfd = READ_ONCE(flag_eventfds[i * BITS_PER_LONG + j]);
+				if (eventfd)
+					eventfd_signal(eventfd, 1);
+				rcu_read_unlock();
+			}
+		}
+	}
+
+	vmbus_isr();
+}
+
+static int mshv_vtl_alloc_context(unsigned int cpu)
+{
+	struct mshv_vtl_per_cpu *per_cpu = this_cpu_ptr(&mshv_vtl_per_cpu);
+	struct page *run_page;
+
+	run_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!run_page)
+		return -ENOMEM;
+
+	per_cpu->run = page_address(run_page);
+	if (mshv_vsm_capabilities.intercept_page_available)
+		mshv_vtl_configure_reg_page(per_cpu);
+
+	mshv_vtl_synic_enable_regs(cpu);
+
+	return 0;
+}
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
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int vtl_get_vp_registers(u16 count,
+				struct hv_register_assoc *registers)
+{
+	union hv_input_vtl input_vtl;
+
+	input_vtl.as_uint8 = 0;
+	input_vtl.use_target_vtl = 1;
+	return hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+					count, input_vtl, registers);
+}
+
+static int vtl_set_vp_registers(u16 count,
+				struct hv_register_assoc *registers)
+{
+	union hv_input_vtl input_vtl;
+
+	input_vtl.as_uint8 = 0;
+	input_vtl.use_target_vtl = 1;
+	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+					count, input_vtl, registers);
+}
+
+static int mshv_vtl_ioctl_add_vtl0_mem(void __user *arg)
+{
+	struct mshv_vtl_ram_disposition vtl0_mem;
+	struct dev_pagemap *pgmap;
+	void *addr;
+
+	if (copy_from_user(&vtl0_mem, arg, sizeof(vtl0_mem)))
+		return -EFAULT;
+
+	if (vtl0_mem.last_pfn <= vtl0_mem.start_pfn) {
+		pr_err("%s: range start pfn (%llx) > end pfn (%llx)\n",
+		       __func__, vtl0_mem.start_pfn, vtl0_mem.last_pfn);
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
+	 * Determine the highest page order that can be used for the range.
+	 * This works best when the range is aligned; i.e. start and length.
+	 */
+	pgmap->vmemmap_shift = count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn);
+	pr_debug("%s: Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: %lu\n",
+		 __func__, vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
+
+	addr = devm_memremap_pages(mem_dev, pgmap);
+	if (IS_ERR(addr)) {
+		pr_err("%s: devm_memremap_pages error: %ld\n", __func__, PTR_ERR(addr));
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
+	if (!cpu_online(input.cpu))
+		return -EINVAL;
+
+	file = NULL;
+	if (input.fd >= 0) {
+		file = fget(input.fd);
+		if (!file)
+			return -EBADFD;
+	}
+
+	poll_file = per_cpu_ptr(&mshv_vtl_poll_file, input.cpu);
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
+static int mshv_vtl_set_reg(struct hv_register_assoc *regs)
+{
+	u64 reg64;
+	enum hv_register_name gpr_name;
+
+	gpr_name = regs->name;
+	reg64 = regs->value.reg64;
+
+	switch (gpr_name) {
+	case HV_X64_REGISTER_DR0:
+		native_set_debugreg(0, reg64);
+		break;
+	case HV_X64_REGISTER_DR1:
+		native_set_debugreg(1, reg64);
+		break;
+	case HV_X64_REGISTER_DR2:
+		native_set_debugreg(2, reg64);
+		break;
+	case HV_X64_REGISTER_DR3:
+		native_set_debugreg(3, reg64);
+		break;
+	case HV_X64_REGISTER_DR6:
+		if (!mshv_vsm_capabilities.dr6_shared)
+			goto hypercall;
+		native_set_debugreg(6, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_CAP:
+		wrmsrl(MSR_MTRRcap, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_DEF_TYPE:
+		wrmsrl(MSR_MTRRdefType, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0:
+		wrmsrl(MTRRphysBase_MSR(0), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1:
+		wrmsrl(MTRRphysBase_MSR(1), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2:
+		wrmsrl(MTRRphysBase_MSR(2), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3:
+		wrmsrl(MTRRphysBase_MSR(3), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4:
+		wrmsrl(MTRRphysBase_MSR(4), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5:
+		wrmsrl(MTRRphysBase_MSR(5), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6:
+		wrmsrl(MTRRphysBase_MSR(6), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7:
+		wrmsrl(MTRRphysBase_MSR(7), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8:
+		wrmsrl(MTRRphysBase_MSR(8), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9:
+		wrmsrl(MTRRphysBase_MSR(9), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA:
+		wrmsrl(MTRRphysBase_MSR(0xa), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB:
+		wrmsrl(MTRRphysBase_MSR(0xb), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC:
+		wrmsrl(MTRRphysBase_MSR(0xc), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASED:
+		wrmsrl(MTRRphysBase_MSR(0xd), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE:
+		wrmsrl(MTRRphysBase_MSR(0xe), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF:
+		wrmsrl(MTRRphysBase_MSR(0xf), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0:
+		wrmsrl(MTRRphysMask_MSR(0), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1:
+		wrmsrl(MTRRphysMask_MSR(1), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2:
+		wrmsrl(MTRRphysMask_MSR(2), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3:
+		wrmsrl(MTRRphysMask_MSR(3), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4:
+		wrmsrl(MTRRphysMask_MSR(4), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5:
+		wrmsrl(MTRRphysMask_MSR(5), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6:
+		wrmsrl(MTRRphysMask_MSR(6), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7:
+		wrmsrl(MTRRphysMask_MSR(7), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8:
+		wrmsrl(MTRRphysMask_MSR(8), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9:
+		wrmsrl(MTRRphysMask_MSR(9), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA:
+		wrmsrl(MTRRphysMask_MSR(0xa), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB:
+		wrmsrl(MTRRphysMask_MSR(0xa), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC:
+		wrmsrl(MTRRphysMask_MSR(0xc), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD:
+		wrmsrl(MTRRphysMask_MSR(0xd), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE:
+		wrmsrl(MTRRphysMask_MSR(0xe), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF:
+		wrmsrl(MTRRphysMask_MSR(0xf), reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX64K00000:
+		wrmsrl(MSR_MTRRfix64K_00000, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX16K80000:
+		wrmsrl(MSR_MTRRfix16K_80000, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX16KA0000:
+		wrmsrl(MSR_MTRRfix16K_A0000, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KC0000:
+		wrmsrl(MSR_MTRRfix4K_C0000, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KC8000:
+		wrmsrl(MSR_MTRRfix4K_C8000, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KD0000:
+		wrmsrl(MSR_MTRRfix4K_D0000, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KD8000:
+		wrmsrl(MSR_MTRRfix4K_D8000, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KE0000:
+		wrmsrl(MSR_MTRRfix4K_E0000, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KE8000:
+		wrmsrl(MSR_MTRRfix4K_E8000, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KF0000:
+		wrmsrl(MSR_MTRRfix4K_F0000, reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KF8000:
+		wrmsrl(MSR_MTRRfix4K_F8000, reg64);
+		break;
+
+	default:
+		goto hypercall;
+	}
+
+	return 0;
+
+hypercall:
+	return 1;
+}
+
+static int mshv_vtl_get_reg(struct hv_register_assoc *regs)
+{
+	u64 *reg64;
+	enum hv_register_name gpr_name;
+
+	gpr_name = regs->name;
+	reg64 = (u64 *)&regs->value.reg64;
+
+	switch (gpr_name) {
+	case HV_X64_REGISTER_DR0:
+		*reg64 = native_get_debugreg(0);
+		break;
+	case HV_X64_REGISTER_DR1:
+		*reg64 = native_get_debugreg(1);
+		break;
+	case HV_X64_REGISTER_DR2:
+		*reg64 = native_get_debugreg(2);
+		break;
+	case HV_X64_REGISTER_DR3:
+		*reg64 = native_get_debugreg(3);
+		break;
+	case HV_X64_REGISTER_DR6:
+		if (!mshv_vsm_capabilities.dr6_shared)
+			goto hypercall;
+		*reg64 = native_get_debugreg(6);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_CAP:
+		rdmsrl(MSR_MTRRcap, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_DEF_TYPE:
+		rdmsrl(MSR_MTRRdefType, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0:
+		rdmsrl(MTRRphysBase_MSR(0), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1:
+		rdmsrl(MTRRphysBase_MSR(1), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2:
+		rdmsrl(MTRRphysBase_MSR(2), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3:
+		rdmsrl(MTRRphysBase_MSR(3), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4:
+		rdmsrl(MTRRphysBase_MSR(4), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5:
+		rdmsrl(MTRRphysBase_MSR(5), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6:
+		rdmsrl(MTRRphysBase_MSR(6), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7:
+		rdmsrl(MTRRphysBase_MSR(7), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8:
+		rdmsrl(MTRRphysBase_MSR(8), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9:
+		rdmsrl(MTRRphysBase_MSR(9), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA:
+		rdmsrl(MTRRphysBase_MSR(0xa), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB:
+		rdmsrl(MTRRphysBase_MSR(0xb), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC:
+		rdmsrl(MTRRphysBase_MSR(0xc), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASED:
+		rdmsrl(MTRRphysBase_MSR(0xd), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE:
+		rdmsrl(MTRRphysBase_MSR(0xe), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF:
+		rdmsrl(MTRRphysBase_MSR(0xf), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0:
+		rdmsrl(MTRRphysMask_MSR(0), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1:
+		rdmsrl(MTRRphysMask_MSR(1), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2:
+		rdmsrl(MTRRphysMask_MSR(2), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3:
+		rdmsrl(MTRRphysMask_MSR(3), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4:
+		rdmsrl(MTRRphysMask_MSR(4), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5:
+		rdmsrl(MTRRphysMask_MSR(5), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6:
+		rdmsrl(MTRRphysMask_MSR(6), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7:
+		rdmsrl(MTRRphysMask_MSR(7), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8:
+		rdmsrl(MTRRphysMask_MSR(8), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9:
+		rdmsrl(MTRRphysMask_MSR(9), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA:
+		rdmsrl(MTRRphysMask_MSR(0xa), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB:
+		rdmsrl(MTRRphysMask_MSR(0xb), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC:
+		rdmsrl(MTRRphysMask_MSR(0xc), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD:
+		rdmsrl(MTRRphysMask_MSR(0xd), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE:
+		rdmsrl(MTRRphysMask_MSR(0xe), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF:
+		rdmsrl(MTRRphysMask_MSR(0xf), *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX64K00000:
+		rdmsrl(MSR_MTRRfix64K_00000, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX16K80000:
+		rdmsrl(MSR_MTRRfix16K_80000, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX16KA0000:
+		rdmsrl(MSR_MTRRfix16K_A0000, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KC0000:
+		rdmsrl(MSR_MTRRfix4K_C0000, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KC8000:
+		rdmsrl(MSR_MTRRfix4K_C8000, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KD0000:
+		rdmsrl(MSR_MTRRfix4K_D0000, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KD8000:
+		rdmsrl(MSR_MTRRfix4K_D8000, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KE0000:
+		rdmsrl(MSR_MTRRfix4K_E0000, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KE8000:
+		rdmsrl(MSR_MTRRfix4K_E8000, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KF0000:
+		rdmsrl(MSR_MTRRfix4K_F0000, *reg64);
+		break;
+	case HV_X64_REGISTER_MSR_MTRR_FIX4KF8000:
+		rdmsrl(MSR_MTRRfix4K_F8000, *reg64);
+		break;
+
+	default:
+		goto hypercall;
+	}
+
+	return 0;
+
+hypercall:
+	return 1;
+}
+
+static void mshv_vtl_return(struct mshv_vtl_cpu_context *vtl0)
+{
+	struct hv_vp_assist_page *hvp;
+	u64 hypercall_addr;
+
+	register u64 r8 asm("r8");
+	register u64 r9 asm("r9");
+	register u64 r10 asm("r10");
+	register u64 r11 asm("r11");
+	register u64 r12 asm("r12");
+	register u64 r13 asm("r13");
+	register u64 r14 asm("r14");
+	register u64 r15 asm("r15");
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
+	hvp->vtl_ret_x64rax = vtl0->rax;
+	hvp->vtl_ret_x64rcx = vtl0->rcx;
+
+	hypercall_addr = (u64)((u8 *)hv_hypercall_pg + mshv_vsm_page_offsets.vtl_return_offset);
+
+	kernel_fpu_begin_mask(0);
+	fxrstor(&vtl0->fx_state);
+	native_write_cr2(vtl0->cr2);
+	r8 = vtl0->r8;
+	r9 = vtl0->r9;
+	r10 = vtl0->r10;
+	r11 = vtl0->r11;
+	r12 = vtl0->r12;
+	r13 = vtl0->r13;
+	r14 = vtl0->r14;
+	r15 = vtl0->r15;
+
+	asm __volatile__ (	\
+	/* Save rbp pointer to the lower VTL, keep the stack 16-byte aligned */
+		"pushq	%%rbp\n"
+		"pushq	%%rcx\n"
+	/* Restore the lower VTL's rbp */
+		"movq	(%%rcx), %%rbp\n"
+	/* Load return kind into rcx (HV_VTL_RETURN_INPUT_NORMAL_RETURN == 0) */
+		"xorl	%%ecx, %%ecx\n"
+	/* Transition to the lower VTL */
+		CALL_NOSPEC
+	/* Save VTL0's rax and rcx temporarily on 16-byte aligned stack */
+		"pushq	%%rax\n"
+		"pushq	%%rcx\n"
+	/* Restore pointer to lower VTL rbp */
+		"movq	16(%%rsp), %%rax\n"
+	/* Save the lower VTL's rbp */
+		"movq	%%rbp, (%%rax)\n"
+	/* Restore saved registers */
+		"movq	8(%%rsp), %%rax\n"
+		"movq	24(%%rsp), %%rbp\n"
+		"addq	$32, %%rsp\n"
+
+		: "=a"(vtl0->rax), "=c"(vtl0->rcx),
+		  "+d"(vtl0->rdx), "+b"(vtl0->rbx), "+S"(vtl0->rsi), "+D"(vtl0->rdi),
+		  "+r"(r8), "+r"(r9), "+r"(r10), "+r"(r11),
+		  "+r"(r12), "+r"(r13), "+r"(r14), "+r"(r15)
+		: THUNK_TARGET(hypercall_addr), "c"(&vtl0->rbp)
+		: "cc", "memory");
+
+	vtl0->r8 = r8;
+	vtl0->r9 = r9;
+	vtl0->r10 = r10;
+	vtl0->r11 = r11;
+	vtl0->r12 = r12;
+	vtl0->r13 = r13;
+	vtl0->r14 = r14;
+	vtl0->r15 = r15;
+	vtl0->cr2 = native_read_cr2();
+
+	fxsave(&vtl0->fx_state);
+	kernel_fpu_end();
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
+	return false;
+}
+
+static int mshv_vtl_ioctl_return_to_lower_vtl(void)
+{
+	preempt_disable();
+	for (;;) {
+		const unsigned long VTL0_WORK = _TIF_SIGPENDING | _TIF_NEED_RESCHED |
+						_TIF_NOTIFY_RESUME | _TIF_NOTIFY_SIGNAL;
+		unsigned long ti_work;
+		u32 cancel;
+		unsigned long irq_flags;
+		struct hv_vp_assist_page *hvp;
+		int ret;
+
+		local_irq_save(irq_flags);
+		ti_work = READ_ONCE(current_thread_info()->flags);
+		cancel = READ_ONCE(mshv_vtl_this_run()->cancel);
+		if (unlikely((ti_work & VTL0_WORK) || cancel)) {
+			local_irq_restore(irq_flags);
+			preempt_enable();
+			if (cancel)
+				ti_work |= _TIF_SIGPENDING;
+			ret = mshv_xfer_to_guest_mode_handle_work(ti_work);
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
+	return 0;
+}
+
+static long
+mshv_vtl_ioctl_get_set_regs(void __user *user_args, bool set)
+{
+	struct mshv_vp_registers args;
+	struct hv_register_assoc *registers;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.count == 0 || args.count > MSHV_VP_MAX_REGISTERS)
+		return -EINVAL;
+
+	registers = kmalloc_array(args.count,
+				  sizeof(*registers),
+				  GFP_KERNEL);
+	if (!registers)
+		return -ENOMEM;
+
+	if (copy_from_user(registers, (void __user *)args.regs_ptr,
+			   sizeof(*registers) * args.count)) {
+		ret = -EFAULT;
+		goto free_return;
+	}
+
+	if (set) {
+		ret = mshv_vtl_set_reg(registers);
+		if (!ret)
+			goto free_return; /* No need of hypercall */
+		ret = vtl_set_vp_registers(args.count, registers);
+
+	} else {
+		ret = mshv_vtl_get_reg(registers);
+		if (!ret)
+			goto copy_args; /* No need of hypercall */
+		ret = vtl_get_vp_registers(args.count, registers);
+		if (ret)
+			goto free_return;
+
+copy_args:
+		if (copy_to_user((void __user *)args.regs_ptr, registers,
+				 sizeof(*registers) * args.count))
+			ret = -EFAULT;
+	}
+
+free_return:
+	kfree(registers);
+	return ret;
+}
+
+static inline long
+mshv_vtl_ioctl_set_regs(void __user *user_args)
+{
+	return mshv_vtl_ioctl_get_set_regs(user_args, true);
+}
+
+static inline long
+mshv_vtl_ioctl_get_regs(void __user *user_args)
+{
+	return mshv_vtl_ioctl_get_set_regs(user_args, false);
+}
+
+static long
+mshv_vtl_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	long ret;
+
+	switch (ioctl) {
+	case MSHV_VTL_SET_POLL_FILE:
+		ret = mshv_vtl_ioctl_set_poll_file((struct mshv_vtl_set_poll_file *)arg);
+		break;
+	case MSHV_GET_VP_REGISTERS:
+		ret = mshv_vtl_ioctl_get_regs((void __user *)arg);
+		break;
+	case MSHV_SET_VP_REGISTERS:
+		ret = mshv_vtl_ioctl_set_regs((void __user *)arg);
+		break;
+	case MSHV_VTL_RETURN_TO_LOWER_VTL:
+		ret = mshv_vtl_ioctl_return_to_lower_vtl();
+		break;
+	case MSHV_VTL_ADD_VTL0_MEMORY:
+		ret = mshv_vtl_ioctl_add_vtl0_mem((void __user *)arg);
+		break;
+	default:
+		pr_err("%s: invalid vtl ioctl: %#x\n", __func__, ioctl);
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
+static long __mshv_ioctl_create_vtl(void __user *user_arg)
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
+	if (fd < 0)
+		return fd;
+	file = anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
+				  vtl, O_RDWR);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+	refcount_set(&vtl->ref_count, 1);
+
+	fd_install(fd, file);
+
+	return fd;
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
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(fd_wait_queue, READ_ONCE(has_message));
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
+	if (READ_ONCE(has_message))
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
+static int mshv_vtl_sint_ioctl_post_message(struct mshv_vtl_sint_post_msg __user *arg)
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
+	u64 input;
+	struct mshv_vtl_signal_event signal_event;
+
+	if (copy_from_user(&signal_event, arg, sizeof(signal_event)))
+		return -EFAULT;
+
+	input = signal_event.connection_id | ((u64)signal_event.flag << 32);
+	return hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, input) & HV_HYPERCALL_RESULT_MASK;
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
+	mutex_lock(&flag_lock);
+	old_eventfd = flag_eventfds[set_eventfd.flag];
+	WRITE_ONCE(flag_eventfds[set_eventfd.flag], eventfd);
+	mutex_unlock(&flag_lock);
+
+	if (old_eventfd) {
+		synchronize_rcu();
+		eventfd_ctx_put(old_eventfd);
+	}
+
+	return 0;
+}
+
+static long mshv_vtl_sint_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case MSHV_SINT_POST_MESSAGE:
+		return mshv_vtl_sint_ioctl_post_message((struct mshv_vtl_sint_post_msg *)arg);
+	case MSHV_SINT_SIGNAL_EVENT:
+		return mshv_vtl_sint_ioctl_signal_event((struct mshv_vtl_signal_event *)arg);
+	case MSHV_SINT_SET_EVENTFD:
+		return mshv_vtl_sint_ioctl_set_eventfd((struct mshv_vtl_set_eventfd *)arg);
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
+static int mshv_vtl_hvcall_open(struct inode *node, struct file *f)
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
+	mutex_init(&fd->init_mutex);
+
+	f->private_data = fd;
+
+	return 0;
+}
+
+static int mshv_vtl_hvcall_release(struct inode *node, struct file *f)
+{
+	struct mshv_vtl_hvcall_fd *fd;
+
+	fd = f->private_data;
+	f->private_data = NULL;
+	vfree(fd);
+
+	return 0;
+}
+
+static int mshv_vtl_hvcall_setup(struct mshv_vtl_hvcall_fd *fd,
+				 struct mshv_vtl_hvcall_setup __user *hvcall_setup_user)
+{
+	int ret = 0;
+	struct mshv_vtl_hvcall_setup hvcall_setup;
+
+	mutex_lock(&fd->init_mutex);
+
+	if (fd->allow_map_intialized) {
+		pr_err("%s: Hypercall allow map has already been set, pid %d\n",
+		       __func__, current->pid);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (copy_from_user(&hvcall_setup, hvcall_setup_user,
+			   sizeof(struct mshv_vtl_hvcall_setup))) {
+		ret = -EFAULT;
+		goto exit;
+	}
+	if (hvcall_setup.bitmap_size > ARRAY_SIZE(fd->allow_bitmap)) {
+		ret = -EINVAL;
+		goto exit;
+	}
+	if (copy_from_user(&fd->allow_bitmap,
+			   (void __user *)hvcall_setup.allow_bitmap_ptr,
+			   hvcall_setup.bitmap_size)) {
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	pr_info("%s: Hypercall allow map has been set, pid %d\n",
+		__func__, current->pid);
+	fd->allow_map_intialized = true;
+
+exit:
+
+	mutex_unlock(&fd->init_mutex);
+
+	return ret;
+}
+
+bool mshv_vtl_hvcall_is_allowed(struct mshv_vtl_hvcall_fd *fd, u16 call_code)
+{
+	u8 bits_per_item = 8 * sizeof(fd->allow_bitmap[0]);
+	u16 item_index = call_code / bits_per_item;
+	u64 mask = 1ULL << (call_code % bits_per_item);
+
+	return fd->allow_bitmap[item_index] & mask;
+}
+
+static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
+				struct mshv_vtl_hvcall __user *hvcall_user)
+{
+	struct mshv_vtl_hvcall hvcall;
+	unsigned long flags;
+	void *in, *out;
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
+		pr_err("%s: Hypercall with control data %#llx isn't allowed\n",
+		       __func__, hvcall.control);
+		return -EPERM;
+	}
+
+	local_irq_save(flags);
+	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	out = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	if (copy_from_user(in, (void __user *)hvcall.input_ptr, hvcall.input_size)) {
+		local_irq_restore(flags);
+		return -EFAULT;
+	}
+
+	hvcall.status = hv_do_hypercall(hvcall.control, in, out);
+
+	if (copy_to_user((void __user *)hvcall.output_ptr, out, hvcall.output_size)) {
+		local_irq_restore(flags);
+		return -EFAULT;
+	}
+	local_irq_restore(flags);
+
+	return put_user(hvcall.status, &hvcall_user->status);
+}
+
+static long mshv_vtl_hvcall_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct mshv_vtl_hvcall_fd *fd = f->private_data;
+
+	switch (cmd) {
+	case MSHV_HVCALL_SETUP:
+		return mshv_vtl_hvcall_setup(fd, (struct mshv_vtl_hvcall_setup __user *)arg);
+	case MSHV_HVCALL:
+		return mshv_vtl_hvcall_call(fd, (struct mshv_vtl_hvcall __user *)arg);
+	default:
+		break;
+	}
+
+	return -ENOIOCTLCMD;
+}
+
+static const struct file_operations mshv_vtl_hvcall_file_ops = {
+	.owner = THIS_MODULE,
+	.open = mshv_vtl_hvcall_open,
+	.release = mshv_vtl_hvcall_release,
+	.unlocked_ioctl = mshv_vtl_hvcall_ioctl,
+};
+
+static struct miscdevice mshv_vtl_hvcall = {
+	.name = "mshv_hvcall",
+	.nodename = "mshv_hvcall",
+	.fops = &mshv_vtl_hvcall_file_ops,
+	.mode = 0600,
+	.minor = MISC_DYNAMIC_MINOR,
+};
+
+static int __init mshv_vtl_init(void)
+{
+	int ret;
+
+	tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
+	init_waitqueue_head(&fd_wait_queue);
+
+	if (mshv_vtl_get_vsm_regs()) {
+		pr_emerg("%s: Unable to get VSM capabilities !!\n", __func__);
+		BUG();
+	}
+	if (mshv_vtl_configure_vsm_partition()) {
+		pr_emerg("%s: VSM configuration failed !!\n", __func__);
+		BUG();
+	}
+
+	ret = hv_vtl_setup_synic();
+	if (ret)
+		return ret;
+
+	ret = misc_register(&mshv_vtl_sint_dev);
+	if (ret)
+		return ret;
+
+	ret = misc_register(&mshv_vtl_hvcall);
+	if (ret)
+		goto free_sint;
+
+	mem_dev = kzalloc(sizeof(*mem_dev), GFP_KERNEL);
+	if (!mem_dev) {
+		ret = -ENOMEM;
+		goto free_hvcall;
+	}
+
+	mutex_init(&mshv_vtl_poll_file_lock);
+
+	ret = mshv_setup_vtl_func(__mshv_ioctl_create_vtl,
+				  __mshv_vtl_ioctl_check_extension);
+	if (ret)
+		goto free_mem;
+
+	device_initialize(mem_dev);
+	dev_set_name(mem_dev, "mshv vtl mem dev");
+	ret = device_add(mem_dev);
+	if (ret) {
+		pr_err("%s: mshv vtl mem dev add: %d\n", __func__, ret);
+		goto deregister_module;
+	}
+
+	return 0;
+
+deregister_module:
+	mshv_setup_vtl_func(NULL, NULL);
+free_mem:
+	kfree(mem_dev);
+free_hvcall:
+	misc_deregister(&mshv_vtl_hvcall);
+free_sint:
+	misc_deregister(&mshv_vtl_sint_dev);
+	return ret;
+}
+
+static void __exit mshv_vtl_exit(void)
+{
+	mshv_setup_vtl_func(NULL, NULL);
+	misc_deregister(&mshv_vtl_sint_dev);
+	misc_deregister(&mshv_vtl_hvcall);
+	device_del(mem_dev);
+	kfree(mem_dev);
+}
+
+module_init(mshv_vtl_init);
+module_exit(mshv_vtl_exit);
diff --git a/drivers/hv/xfer_to_guest.c b/drivers/hv/xfer_to_guest.c
new file mode 100644
index 000000000000..4a3901d44209
--- /dev/null
+++ b/drivers/hv/xfer_to_guest.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains code that handles pending work before transferring
+ * to guest context. It needs to be in a separate file because the symbols
+ * it uses are not exported.
+ *
+ * Inspired by native and KVM switching code.
+ *
+ * Author: Wei Liu <wei.liu@kernel.org>
+ */
+
+#include <linux/resume_user_mode.h>
+
+/* Invoke with preemption and interrupt enabled */
+int mshv_xfer_to_guest_mode_handle_work(unsigned long ti_work)
+{
+	if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+		return -EINTR;
+
+	if (ti_work & _TIF_NEED_RESCHED)
+		schedule();
+
+	if (ti_work & _TIF_NOTIFY_RESUME)
+		resume_user_mode_work(NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mshv_xfer_to_guest_mode_handle_work);
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
new file mode 100644
index 000000000000..476410be4734
--- /dev/null
+++ b/include/uapi/linux/mshv.h
@@ -0,0 +1,306 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_MSHV_H
+#define _UAPI_LINUX_MSHV_H
+
+/*
+ * Userspace interface for /dev/mshv
+ * Microsoft Hypervisor root partition APIs
+ * NOTE: This API is not yet stable!
+ */
+
+#include <linux/types.h>
+#include <hyperv/hvhdk.h>
+
+#define MSHV_CAP_CORE_API_STABLE	0x0
+#define MSHV_CAP_REGISTER_PAGE		0x1
+#define MSHV_CAP_VTL_RETURN_ACTION	0x2
+#define MSHV_CAP_DR6_SHARED		0x3
+
+#define MSHV_VP_MMAP_REGISTERS_OFFSET (HV_VP_STATE_PAGE_REGISTERS * 0x1000)
+#define MAX_RUN_MSG_SIZE		256
+
+struct mshv_create_partition {
+	__u64 flags;
+	struct hv_partition_creation_properties partition_creation_properties;
+	union hv_partition_synthetic_processor_features synthetic_processor_features;
+	union hv_partition_isolation_properties isolation_properties;
+};
+
+/*
+ * Mappings can't overlap in GPA space or userspace
+ * To unmap, these fields must match an existing mapping
+ */
+struct mshv_user_mem_region {
+	__u64 size;		/* bytes */
+	__u64 guest_pfn;
+	__u64 userspace_addr;	/* start of the userspace allocated memory */
+	__u32 flags;		/* ignored on unmap */
+	__u32 padding;
+};
+
+struct mshv_create_vp {
+	__u32 vp_index;
+};
+
+#define MSHV_VP_MAX_REGISTERS	128
+
+struct mshv_vp_registers {
+	__u32 count;	/* at most MSHV_VP_MAX_REGISTERS */
+	__u32 padding;
+	__u64 regs_ptr;	/* pointer to struct hv_register_assoc */
+};
+
+struct mshv_install_intercept {
+	__u32 access_type_mask;
+	__u32 intercept_type; /* enum hv_intercept_type */
+	union hv_intercept_parameters intercept_parameter;
+};
+
+struct mshv_assert_interrupt {
+	union hv_interrupt_control control;
+	__u64 dest_addr;
+	__u32 vector;
+	__u32 padding;
+};
+
+#ifdef HV_SUPPORTS_VP_STATE
+
+struct mshv_vp_state {
+	__u32 type;			     /* enum hv_get_set_vp_state_type */
+	__u32 padding;
+	struct hv_vp_state_data_xsave xsave; /* only for xsave request */
+	__u64 buf_size;			     /* If xsave, must be page-aligned */
+	/*
+	 * If xsave, buf_ptr is a pointer to bytes, and must be page-aligned
+	 * If lapic, buf_ptr is a pointer to struct hv_local_interrupt_controller_state
+	 */
+	__u64 buf_ptr;
+};
+
+#endif
+
+struct mshv_partition_property {
+	__u32 property_code; /* enum hv_partition_property_code */
+	__u32 padding;
+	__u64 property_value;
+};
+
+struct mshv_translate_gva {
+	__u64 gva;
+	__u64 flags;
+	/* output */
+	union hv_translate_gva_result result;
+	__u64 gpa;
+};
+
+#define MSHV_IRQFD_FLAG_DEASSIGN (1 << 0)
+#define MSHV_IRQFD_FLAG_RESAMPLE (1 << 1)
+
+struct mshv_irqfd {
+	__s32 fd;
+	__s32 resamplefd;
+	__u32 gsi;
+	__u32 flags;
+};
+
+enum mshv_ioeventfd_flag {
+	MSHV_IOEVENTFD_FLAG_NR_DATAMATCH,
+	MSHV_IOEVENTFD_FLAG_NR_PIO,
+	MSHV_IOEVENTFD_FLAG_NR_DEASSIGN,
+	MSHV_IOEVENTFD_FLAG_NR_COUNT,
+};
+
+#define MSHV_IOEVENTFD_FLAG_DATAMATCH (1 << MSHV_IOEVENTFD_FLAG_NR_DATAMATCH)
+#define MSHV_IOEVENTFD_FLAG_PIO       (1 << MSHV_IOEVENTFD_FLAG_NR_PIO)
+#define MSHV_IOEVENTFD_FLAG_DEASSIGN  (1 << MSHV_IOEVENTFD_FLAG_NR_DEASSIGN)
+
+#define MSHV_IOEVENTFD_VALID_FLAG_MASK  ((1 << MSHV_IOEVENTFD_FLAG_NR_COUNT) - 1)
+
+struct mshv_ioeventfd {
+	__u64 datamatch;
+	__u64 addr;		/* legal pio/mmio address */
+	__u32 len;		/* 1, 2, 4, or 8 bytes    */
+	__s32 fd;
+	__u32 flags;		/* bitwise OR of MSHV_IOEVENTFD_FLAG_'s */
+	__u32 padding;
+};
+
+struct mshv_msi_routing_entry {
+	__u32 gsi;
+	__u32 address_lo;
+	__u32 address_hi;
+	__u32 data;
+};
+
+struct mshv_msi_routing {
+	__u32 nr;
+	__u32 padding;
+	struct mshv_msi_routing_entry entries[];
+};
+
+#ifdef HV_SUPPORTS_REGISTER_INTERCEPT
+struct mshv_register_intercept_result {
+	__u32 intercept_type; /* enum hv_intercept_type */
+	union hv_register_intercept_result_parameters parameters;
+};
+#endif
+
+struct mshv_signal_event_direct {
+	__u32 vp;
+	__u8 vtl;
+	__u8 sint;
+	__u16 flag;
+	/* output */
+	__u8 newly_signaled;
+	__u8 padding[3];
+};
+
+struct mshv_post_message_direct {
+	__u32 vp;
+	__u8 vtl;
+	__u8 sint;
+	__u16 length;
+	__u8 message[HV_MESSAGE_SIZE];
+};
+
+struct mshv_register_deliverabilty_notifications {
+	__u32 vp;
+	__u32 padding;
+	__u64 flag;
+};
+
+struct mshv_get_vp_cpuid_values {
+	__u32 function;
+	__u32 index;
+	/* output */
+	__u32 eax;
+	__u32 ebx;
+	__u32 ecx;
+	__u32 edx;
+};
+
+struct mshv_vp_run_registers {
+	__u64 message_ptr; /* pointer to struct hv_message */
+	struct mshv_vp_registers registers;
+};
+
+struct mshv_get_gpa_pages_access_state {
+	__u64 flags;
+	__u64 hv_gpa_page_number;
+	__u32 count;		/* in - requested. out - actual */
+	__u32 padding;
+	__u64 states_ptr;	/* pointer to union hv_gpa_page_access_state */
+} __packed;
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
+	__u32 payload_size;
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
+	__u64 bitmap_size;
+	__u64 allow_bitmap_ptr; /* pointer to __u64 */
+};
+
+struct mshv_vtl_hvcall {
+	__u64 control;
+	__u64 input_size;
+	__u64 input_ptr; /* pointer to input struct */
+	/* output */
+	__u64 status;
+	__u64 output_size;
+	__u64 output_ptr; /* pointer to output struct */
+};
+
+#define MSHV_IOCTL 0xB8
+
+/* mshv device */
+#define MSHV_CHECK_EXTENSION    _IOW(MSHV_IOCTL, 0x00, __u32)
+#define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x01, struct mshv_create_partition)
+
+/* partition device */
+#define MSHV_MAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x02, struct mshv_user_mem_region)
+#define MSHV_UNMAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x03, struct mshv_user_mem_region)
+#define MSHV_CREATE_VP		_IOW(MSHV_IOCTL, 0x04, struct mshv_create_vp)
+#define MSHV_INSTALL_INTERCEPT	_IOW(MSHV_IOCTL, 0x08, struct mshv_install_intercept)
+#define MSHV_ASSERT_INTERRUPT	_IOW(MSHV_IOCTL, 0x09, struct mshv_assert_interrupt)
+#define MSHV_SET_PARTITION_PROPERTY \
+				_IOW(MSHV_IOCTL, 0xC, struct mshv_partition_property)
+#define MSHV_GET_PARTITION_PROPERTY \
+				_IOWR(MSHV_IOCTL, 0xD, struct mshv_partition_property)
+#define MSHV_IRQFD		_IOW(MSHV_IOCTL, 0xE, struct mshv_irqfd)
+#define MSHV_IOEVENTFD		_IOW(MSHV_IOCTL, 0xF, struct mshv_ioeventfd)
+#define MSHV_SET_MSI_ROUTING	_IOW(MSHV_IOCTL, 0x11, struct mshv_msi_routing)
+#define MSHV_GET_GPA_ACCESS_STATES \
+				_IOWR(MSHV_IOCTL, 0x12, struct mshv_get_gpa_pages_access_state)
+/* vp device */
+#define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
+#define MSHV_SET_VP_REGISTERS   _IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
+#define MSHV_RUN_VP		_IOR(MSHV_IOCTL, 0x07, struct hv_message)
+#define MSHV_RUN_VP_REGISTERS	_IOWR(MSHV_IOCTL, 0x1C, struct mshv_vp_run_registers)
+#ifdef HV_SUPPORTS_VP_STATE
+#define MSHV_GET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0A, struct mshv_vp_state)
+#define MSHV_SET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0B, struct mshv_vp_state)
+#endif
+#define MSHV_TRANSLATE_GVA	_IOWR(MSHV_IOCTL, 0x0E, struct mshv_translate_gva)
+#ifdef HV_SUPPORTS_REGISTER_INTERCEPT
+#define MSHV_VP_REGISTER_INTERCEPT_RESULT \
+				_IOW(MSHV_IOCTL, 0x17, struct mshv_register_intercept_result)
+#endif
+#define MSHV_SIGNAL_EVENT_DIRECT \
+	_IOWR(MSHV_IOCTL, 0x18, struct mshv_signal_event_direct)
+#define MSHV_POST_MESSAGE_DIRECT \
+	_IOW(MSHV_IOCTL, 0x19, struct mshv_post_message_direct)
+#define MSHV_REGISTER_DELIVERABILITY_NOTIFICATIONS \
+	_IOW(MSHV_IOCTL, 0x1A, struct mshv_register_deliverabilty_notifications)
+#define MSHV_GET_VP_CPUID_VALUES \
+	_IOWR(MSHV_IOCTL, 0x1B, struct mshv_get_vp_cpuid_values)
+
+/* vtl device */
+#define MSHV_CREATE_VTL			_IOR(MSHV_IOCTL, 0x1D, char)
+#define MSHV_VTL_ADD_VTL0_MEMORY	_IOW(MSHV_IOCTL, 0x21, struct mshv_vtl_ram_disposition)
+#define MSHV_VTL_SET_POLL_FILE		_IOW(MSHV_IOCTL, 0x25, struct mshv_vtl_set_poll_file)
+#define MSHV_VTL_RETURN_TO_LOWER_VTL	_IO(MSHV_IOCTL, 0x27)
+
+/* VMBus device IOCTLs */
+#define MSHV_SINT_SIGNAL_EVENT    _IOW(MSHV_IOCTL, 0x22, struct mshv_vtl_signal_event)
+#define MSHV_SINT_POST_MESSAGE    _IOW(MSHV_IOCTL, 0x23, struct mshv_vtl_sint_post_msg)
+#define MSHV_SINT_SET_EVENTFD     _IOW(MSHV_IOCTL, 0x24, struct mshv_vtl_set_eventfd)
+
+/* hv_hvcall device */
+#define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_hvcall_setup)
+#define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl_hvcall)
+
+/* register page mapping example:
+ * struct hv_vp_register_page *regs = mmap(NULL,
+ *					   4096,
+ *					   PROT_READ | PROT_WRITE,
+ *					   MAP_SHARED,
+ *					   vp_fd,
+ *					   HV_VP_MMAP_REGISTERS_OFFSET);
+ * munmap(regs, 4096);
+ */
+
+#endif
-- 
2.25.1


