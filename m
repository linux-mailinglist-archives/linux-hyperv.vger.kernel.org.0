Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9A041B64C
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Sep 2021 20:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbhI1SdN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Sep 2021 14:33:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50948 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242239AbhI1SdC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Sep 2021 14:33:02 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5F43320B4845;
        Tue, 28 Sep 2021 11:31:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F43320B4845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632853882;
        bh=2CEa8Y2P2v9LL2Hx9XBfqJlbw3zRvuMpZGJV72Luz7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNZ5dYfYiDuoTd7GqsMfOP9U710WXUBDjEzJbTXPVBRXYGGY9k+uXoqTqxmdfj1Ne
         KEJGzIKU2WeODWoM+xcnW0YYDgRC8TU1F7MBw+a4mjAaooWyQ5cK6iTY/BLKnHIxiN
         1cF7vzbo8y+tKnKKxbh4nPeg2jUepDOHNtUCnefA=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH v3 18/19] drivers/hv: Add enlightenment bits to create partition ioctl
Date:   Tue, 28 Sep 2021 11:31:14 -0700
Message-Id: <1632853875-20261-19-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
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
 drivers/hv/mshv_main.c                  |   7 ++
 include/uapi/asm-generic/hyperv-tlfs.h  |   1 +
 include/uapi/linux/mshv.h               |   1 +
 5 files changed, 137 insertions(+)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index e660e0e6865e..56a6edfcfe29 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -167,4 +167,7 @@ The page is laid out in struct hv_vp_register_page in asm/hyperv-tlfs.h.
 
 Can be used to get/set various properties of a partition.
 
+Some properties can only be set at partition creation. For these, there are
+parameters in MSHV_CREATE_PARTITION.
+
 
diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
index 5430f3c98934..4447ef5362e9 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -1146,4 +1146,129 @@ struct hv_vp_register_page {
 	__u64 instruction_emulation_hints;
 } __packed;
 
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
+	} __packed;
+};
+
 #endif
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index d65bcd8567a4..766ba7d5d168 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -1000,6 +1000,13 @@ mshv_ioctl_create_partition(void __user *user_arg)
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
diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
index 1e572d38234a..5d8d5e89f432 100644
--- a/include/uapi/asm-generic/hyperv-tlfs.h
+++ b/include/uapi/asm-generic/hyperv-tlfs.h
@@ -139,6 +139,7 @@ enum hv_vp_state_page_type {
 enum hv_partition_property_code {
 	/* Privilege properties */
 	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS				= 0x00010000,
+	HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES			= 0x00010001,
 
 	/* Scheduling properties */
 	HV_PARTITION_PROPERTY_SUSPEND					= 0x00020000,
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 1a6c22db4978..ec8281712430 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -19,6 +19,7 @@
 struct mshv_create_partition {
 	__u64 flags;
 	struct hv_partition_creation_properties partition_creation_properties;
+	union hv_partition_synthetic_processor_features synthetic_processor_features;
 };
 
 /*
-- 
2.23.4

