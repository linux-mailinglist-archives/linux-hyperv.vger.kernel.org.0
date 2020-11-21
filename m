Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12AE2BBAED
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgKUAbL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:31:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51280 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgKUAax (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:53 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D538A20B8014;
        Fri, 20 Nov 2020 16:30:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D538A20B8014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918650;
        bh=bs8OXSmw7i3sGKbT+mWjBVnHpAlEDRGawtmvukwZx5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzrMi9RVcbtmwUoa6eg4I9eCrNP6SIdagXYCIcp1DqNIHnhIehGFxu/fbMdN2zeKw
         vZLJs04sIdrxOegXloUibjuoVU1lYwxEytIK6WwblDrTfFiZp6sQHT7vaMG3MUYF/7
         zvDGxx0g56w63SczfwWwr2tf6GU8Q8UNjGGiUkvM=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 18/18] virt/mshv: Add enlightenment bits to create partition ioctl
Date:   Fri, 20 Nov 2020 16:30:37 -0800
Message-Id: <1605918637-12192-19-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce hv_partition_synthetic_processor features mask to
MSHV_CREATE_PARTITION ioctl, which can be used to enable hypervisor
enlightenments for exo partitions.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst         |   3 +
 arch/x86/include/uapi/asm/hyperv-tlfs.h | 125 ++++++++++++++++++++++++
 include/uapi/asm-generic/hyperv-tlfs.h  |   1 +
 include/uapi/linux/mshv.h               |   1 +
 virt/mshv/mshv_main.c                   |  57 +++++++----
 5 files changed, 167 insertions(+), 20 deletions(-)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index 609400313b7e..afd56fff1038 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -167,4 +167,7 @@ The page is laid out in struct hv_vp_register_page in asm/hyperv-tlfs.h.
 
 Can be used to get/set various properties of a partition.
 
+Some properties can only be set at partition creation. For these, there are
+parameters in MSHV_CREATE_PARTITION.
+
 
diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
index a241178567ff..65cd0d166d5b 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -1184,4 +1184,129 @@ struct hv_vp_register_page {
 	__u64 instruction_emulation_hints;
 };
 
+#define HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS 1
+
+union hv_partition_synthetic_processor_features {
+	__u64 as_uint64[HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS];
+
+	struct {
+		/* Report a hypervisor is present. CPUID leaves
+		 * 0x40000000 and 0x40000001 are supported.
+		 */
+		__u64 hypervisor_present:1;
+
+		/*
+		 * Features associated with HV#1:
+		 */
+
+		/* Report support for Hv1 (CPUID leaves 0x40000000 - 0x40000006). */
+		__u64 hv1:1;
+
+		/* Access to HV_X64_MSR_VP_RUNTIME.
+		 * Corresponds to access_vp_run_time_reg privilege.
+		 */
+		__u64 access_vp_run_time_reg:1;
+
+		/* Access to HV_X64_MSR_TIME_REF_COUNT.
+		 * Corresponds to access_partition_reference_counter privilege.
+		 */
+		__u64 access_partition_reference_counter:1;
+
+		/* Access to SINT-related registers (HV_X64_MSR_SCONTROL through
+		 * HV_X64_MSR_EOM and HV_X64_MSR_SINT0 through HV_X64_MSR_SINT15).
+		 * Corresponds to access_synic_regs privilege.
+		 */
+		__u64 access_synic_regs:1;
+
+		/* Access to synthetic timers and associated MSRs
+		 * (HV_X64_MSR_STIMER0_CONFIG through HV_X64_MSR_STIMER3_COUNT).
+		 * Corresponds to access_synthetic_timer_regs privilege.
+		 */
+		__u64 access_synthetic_timer_regs:1;
+
+		/* Access to APIC MSRs (HV_X64_MSR_EOI, HV_X64_MSR_ICR and HV_X64_MSR_TPR)
+		 * as well as the VP assist page.
+		 * Corresponds to access_intr_ctrl_regs privilege.
+		 */
+		__u64 access_intr_ctrl_regs:1;
+
+		/* Access to registers associated with hypercalls (HV_X64_MSR_GUEST_OS_ID
+		 * and HV_X64_MSR_HYPERCALL).
+		 * Corresponds to access_hypercall_msrs privilege.
+		 */
+		__u64 access_hypercall_regs:1;
+
+		/* VP index can be queried. corresponds to access_vp_index privilege. */
+		__u64 access_vp_index:1;
+
+		/* Access to the reference TSC. Corresponds to access_partition_reference_tsc
+		 * privilege.
+		 */
+		__u64 access_partition_reference_tsc:1;
+
+		/* Partition has access to the guest idle reg. Corresponds to
+		 * access_guest_idle_reg privilege.
+		 */
+		__u64 access_guest_idle_reg:1;
+
+		/* Partition has access to frequency regs. corresponds to access_frequency_regs
+		 * privilege.
+		 */
+		__u64 access_frequency_regs:1;
+
+		__u64 reserved_z12:1; /* Reserved for access_reenlightenment_controls. */
+		__u64 reserved_z13:1; /* Reserved for access_root_scheduler_reg. */
+		__u64 reserved_z14:1; /* Reserved for access_tsc_invariant_controls. */
+
+		/* Extended GVA ranges for HvCallFlushVirtualAddressList hypercall.
+		 * Corresponds to privilege.
+		 */
+		__u64 enable_extended_gva_ranges_for_flush_virtual_address_list:1;
+
+		__u64 reserved_z16:1; /* Reserved for access_vsm. */
+		__u64 reserved_z17:1; /* Reserved for access_vp_registers. */
+
+		/* Use fast hypercall output. Corresponds to privilege. */
+		__u64 fast_hypercall_output:1;
+
+		__u64 reserved_z19:1; /* Reserved for enable_extended_hypercalls. */
+
+		/*
+		 * HvStartVirtualProcessor can be used to start virtual processors.
+		 * Corresponds to privilege.
+		 */
+		__u64 start_virtual_processor:1;
+
+		__u64 reserved_z21:1; /* Reserved for Isolation. */
+
+		/* Synthetic timers in direct mode. */
+		__u64 direct_synthetic_timers:1;
+
+		__u64 reserved_z23:1; /* Reserved for synthetic time unhalted timer */
+
+		/* Use extended processor masks. */
+		__u64 extended_processor_masks:1;
+
+		/* HvCallFlushVirtualAddressSpace / HvCallFlushVirtualAddressList are supported. */
+		__u64 tb_flush_hypercalls:1;
+
+		/* HvCallSendSyntheticClusterIpi is supported. */
+		__u64 synthetic_cluster_ipi:1;
+
+		/* HvCallNotifyLongSpinWait is supported. */
+		__u64 notify_long_spin_wait:1;
+
+		/* HvCallQueryNumaDistance is supported. */
+		__u64 query_numa_distance:1;
+
+		/* HvCallSignalEvent is supported. Corresponds to privilege. */
+		__u64 signal_events:1;
+
+		/* HvCallRetargetDeviceInterrupt is supported. */
+		__u64 retarget_device_interrupt:1;
+
+		__u64 reserved:33;
+	};
+};
+
 #endif
diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
index d1c341de34fe..5c6379a3cfd5 100644
--- a/include/uapi/asm-generic/hyperv-tlfs.h
+++ b/include/uapi/asm-generic/hyperv-tlfs.h
@@ -100,6 +100,7 @@ enum hv_vp_state_page_type {
 enum hv_partition_property_code {
 	/* Privilege properties */
 	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS				= 0x00010000,
+	HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES			= 0x00010001,
 
 	/* Scheduling properties */
 	HV_PARTITION_PROPERTY_SUSPEND					= 0x00020000,
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 721f5b1999d5..bf2d8c8a0a37 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -18,6 +18,7 @@
 struct mshv_create_partition {
 	__u64 flags;
 	struct hv_partition_creation_properties partition_creation_properties;
+	union hv_partition_synthetic_processor_features synthetic_processor_features;
 };
 
 /*
diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
index bfbadeb4f1fe..78a1e70cac96 100644
--- a/virt/mshv/mshv_main.c
+++ b/virt/mshv/mshv_main.c
@@ -547,6 +547,33 @@ hv_call_map_vp_state_page(u32 vp_index, u64 partition_id,
 	return ret;
 }
 
+static long
+hv_call_set_partition_property(u64 partition_id,
+			       u64 property_code,
+			       u64 property_value)
+{
+	int status;
+	unsigned long flags;
+	struct hv_set_partition_property *input;
+
+	local_irq_save(flags);
+	input = (struct hv_set_partition_property *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->property_code = property_code;
+	input->property_value = property_value;
+	status = hv_do_hypercall(HVCALL_SET_PARTITION_PROPERTY,
+				 input,
+				 NULL) & HV_HYPERCALL_RESULT_MASK;
+	local_irq_restore(flags);
+
+	if (status != HV_STATUS_SUCCESS)
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+
+	return -hv_status_to_errno(status);
+}
+
 static void
 mshv_isr(void)
 {
@@ -1373,30 +1400,13 @@ mshv_partition_ioctl_set_property(struct mshv_partition *partition,
 				  void __user *user_args)
 {
 	struct mshv_partition_property args;
-	int status;
-	unsigned long flags;
-	struct hv_set_partition_property *input;
 
 	if (copy_from_user(&args, user_args, sizeof(args)))
 		return -EFAULT;
 
-	local_irq_save(flags);
-	input = (struct hv_set_partition_property *)(*this_cpu_ptr(
-			hyperv_pcpu_input_arg));
-	memset(input, 0, sizeof(*input));
-	input->partition_id = partition->id;
-	input->property_code = args.property_code;
-	input->property_value = args.property_value;
-	status = hv_do_hypercall(HVCALL_SET_PARTITION_PROPERTY, input,
-			NULL) & HV_HYPERCALL_RESULT_MASK;
-	local_irq_restore(flags);
-
-	if (status != HV_STATUS_SUCCESS) {
-		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
-		return -hv_status_to_errno(status);
-	}
-
-	return 0;
+	return hv_call_set_partition_property(partition->id,
+					      args.property_code,
+					      args.property_value);
 }
 
 static long
@@ -1831,6 +1841,13 @@ mshv_ioctl_create_partition(void __user *user_arg)
 	if (ret)
 		goto put_fd;
 
+	ret = hv_call_set_partition_property(
+				partition->id,
+				HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES,
+				args.synthetic_processor_features.as_uint64[0]);
+	if (ret)
+		goto delete_partition;
+
 	ret = hv_call_initialize_partition(partition->id);
 	if (ret)
 		goto delete_partition;
-- 
2.25.1

