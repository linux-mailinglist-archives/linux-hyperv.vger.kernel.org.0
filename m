Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8404B2BBAE3
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgKUAay (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:30:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51226 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgKUAaw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:52 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 26C8D20B800B;
        Fri, 20 Nov 2020 16:30:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26C8D20B800B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918650;
        bh=nwhcLGlcvXHITUCwPSuM21FVS/8xh08tIJuRX+J/KaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4ifr+D98i5vwpYPJhH1ed7xfhsa9GDF+oyT0yRJzExR2L/Z3aVAnD4lQVZRd+w+I
         a0Yi4JhVltWUxTq42kKQZGDlVB2Bs0SntRvLsCUKymb1AQdG82qp8inN4Cw/rsmVMQ
         /ViV2FkRRR4XHi/am+sQlW1f5UeAD2SjHW7RIJK4=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 10/18] virt/mshv: get and set vcpu registers ioctls
Date:   Fri, 20 Nov 2020 16:30:29 -0800
Message-Id: <1605918637-12192-11-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add ioctls for getting and setting virtual processor registers.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst         |  11 +
 arch/x86/include/uapi/asm/hyperv-tlfs.h | 601 ++++++++++++++++++++++++
 include/asm-generic/hyperv-tlfs.h       |  65 +--
 include/linux/mshv.h                    |   1 +
 include/uapi/linux/mshv.h               |  12 +
 virt/mshv/mshv_main.c                   | 258 +++++++++-
 6 files changed, 903 insertions(+), 45 deletions(-)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index f997f49f8690..20a626ac02d4 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -96,3 +96,14 @@ is backed by physical memory.
 Create a virtual processor in a guest partition, returning a file descriptor to
 represent the vp and perform ioctls on.
 
+3.5 MSHV_GET_VP_REGISTERS and MSHV_SET_VP_REGISTERS
+---------------------------------------------------
+:Type: vp ioctl
+:Parameters: struct mshv_vp_registers
+:Returns: 0 on success
+
+Get/set vp registers. See asm/hyperv-tlfs.h for the complete set of registers.
+Includes general purpose platform registers, MSRs, and virtual registers that
+are part of Microsoft Hypervisor platform and not directly exposed to the guest.
+
+
diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
index 72150c25ffe6..2ff655962738 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -121,4 +121,605 @@ struct hv_partition_creation_properties {
 		disabled_processor_xsave_features;
 };
 
+enum hv_register_name {
+	/* Suspend Registers */
+	HV_REGISTER_EXPLICIT_SUSPEND		= 0x00000000,
+	HV_REGISTER_INTERCEPT_SUSPEND		= 0x00000001,
+	HV_REGISTER_INSTRUCTION_EMULATION_HINTS	= 0x00000002,
+	HV_REGISTER_DISPATCH_SUSPEND		= 0x00000003,
+	HV_REGISTER_INTERNAL_ACTIVITY_STATE	= 0x00000004,
+
+	/* Version */
+	HV_REGISTER_HYPERVISOR_VERSION	= 0x00000100, /* 128-bit result same as CPUID 0x40000002 */
+
+	/* Feature Access (registers are 128 bits) - same as CPUID 0x40000003 - 0x4000000B */
+	HV_REGISTER_PRIVILEGES_AND_FEATURES_INFO	= 0x00000200,
+	HV_REGISTER_FEATURES_INFO			= 0x00000201,
+	HV_REGISTER_IMPLEMENTATION_LIMITS_INFO		= 0x00000202,
+	HV_REGISTER_HARDWARE_FEATURES_INFO		= 0x00000203,
+	HV_REGISTER_CPU_MANAGEMENT_FEATURES_INFO	= 0x00000204,
+	HV_REGISTER_SVM_FEATURES_INFO			= 0x00000205,
+	HV_REGISTER_SKIP_LEVEL_FEATURES_INFO		= 0x00000206,
+	HV_REGISTER_NESTED_VIRT_FEATURES_INFO		= 0x00000207,
+	HV_REGISTER_IPT_FEATURES_INFO			= 0x00000208,
+
+	/* Guest Crash Registers */
+	HV_REGISTER_GUEST_CRASH_P0	= 0x00000210,
+	HV_REGISTER_GUEST_CRASH_P1	= 0x00000211,
+	HV_REGISTER_GUEST_CRASH_P2	= 0x00000212,
+	HV_REGISTER_GUEST_CRASH_P3	= 0x00000213,
+	HV_REGISTER_GUEST_CRASH_P4	= 0x00000214,
+	HV_REGISTER_GUEST_CRASH_CTL	= 0x00000215,
+
+	/* Power State Configuration */
+	HV_REGISTER_POWER_STATE_CONFIG_C1	= 0x00000220,
+	HV_REGISTER_POWER_STATE_TRIGGER_C1	= 0x00000221,
+	HV_REGISTER_POWER_STATE_CONFIG_C2	= 0x00000222,
+	HV_REGISTER_POWER_STATE_TRIGGER_C2	= 0x00000223,
+	HV_REGISTER_POWER_STATE_CONFIG_C3	= 0x00000224,
+	HV_REGISTER_POWER_STATE_TRIGGER_C3	= 0x00000225,
+
+	/* Frequency Registers */
+	HV_REGISTER_PROCESSOR_CLOCK_FREQUENCY	= 0x00000240,
+	HV_REGISTER_INTERRUPT_CLOCK_FREQUENCY	= 0x00000241,
+
+	/* Idle Register */
+	HV_REGISTER_GUEST_IDLE	= 0x00000250,
+
+	/* Guest Debug */
+	HV_REGISTER_DEBUG_DEVICE_OPTIONS	= 0x00000260,
+
+	/* Memory Zeroing Conrol Register */
+	HV_REGISTER_MEMORY_ZEROING_CONTROL	= 0x00000270,
+
+	/* Pending Event Register */
+	HV_REGISTER_PENDING_EVENT0	= 0x00010004,
+	HV_REGISTER_PENDING_EVENT1	= 0x00010005,
+
+	/* Misc */
+	HV_REGISTER_VP_RUNTIME			= 0x00090000,
+	HV_REGISTER_GUEST_OS_ID			= 0x00090002,
+	HV_REGISTER_VP_INDEX			= 0x00090003,
+	HV_REGISTER_TIME_REF_COUNT		= 0x00090004,
+	HV_REGISTER_CPU_MANAGEMENT_VERSION	= 0x00090007,
+	HV_REGISTER_VP_ASSIST_PAGE		= 0x00090013,
+	HV_REGISTER_VP_ROOT_SIGNAL_COUNT	= 0x00090014,
+	HV_REGISTER_REFERENCE_TSC		= 0x00090017,
+
+	/* Performance statistics Registers */
+	HV_REGISTER_STATS_PARTITION_RETAIL	= 0x00090020,
+	HV_REGISTER_STATS_PARTITION_INTERNAL	= 0x00090021,
+	HV_REGISTER_STATS_VP_RETAIL		= 0x00090022,
+	HV_REGISTER_STATS_VP_INTERNAL		= 0x00090023,
+
+	HV_REGISTER_NESTED_VP_INDEX	= 0x00091003,
+
+	/* Hypervisor-defined Registers (Synic) */
+	HV_REGISTER_SINT0	= 0x000A0000,
+	HV_REGISTER_SINT1	= 0x000A0001,
+	HV_REGISTER_SINT2	= 0x000A0002,
+	HV_REGISTER_SINT3	= 0x000A0003,
+	HV_REGISTER_SINT4	= 0x000A0004,
+	HV_REGISTER_SINT5	= 0x000A0005,
+	HV_REGISTER_SINT6	= 0x000A0006,
+	HV_REGISTER_SINT7	= 0x000A0007,
+	HV_REGISTER_SINT8	= 0x000A0008,
+	HV_REGISTER_SINT9	= 0x000A0009,
+	HV_REGISTER_SINT10	= 0x000A000A,
+	HV_REGISTER_SINT11	= 0x000A000B,
+	HV_REGISTER_SINT12	= 0x000A000C,
+	HV_REGISTER_SINT13	= 0x000A000D,
+	HV_REGISTER_SINT14	= 0x000A000E,
+	HV_REGISTER_SINT15	= 0x000A000F,
+	HV_REGISTER_SCONTROL	= 0x000A0010,
+	HV_REGISTER_SVERSION	= 0x000A0011,
+	HV_REGISTER_SIFP	= 0x000A0012,
+	HV_REGISTER_SIPP	= 0x000A0013,
+	HV_REGISTER_EOM		= 0x000A0014,
+	HV_REGISTER_SIRBP	= 0x000A0015,
+
+	HV_REGISTER_NESTED_SINT0	= 0x000A1000,
+	HV_REGISTER_NESTED_SINT1	= 0x000A1001,
+	HV_REGISTER_NESTED_SINT2	= 0x000A1002,
+	HV_REGISTER_NESTED_SINT3	= 0x000A1003,
+	HV_REGISTER_NESTED_SINT4	= 0x000A1004,
+	HV_REGISTER_NESTED_SINT5	= 0x000A1005,
+	HV_REGISTER_NESTED_SINT6	= 0x000A1006,
+	HV_REGISTER_NESTED_SINT7	= 0x000A1007,
+	HV_REGISTER_NESTED_SINT8	= 0x000A1008,
+	HV_REGISTER_NESTED_SINT9	= 0x000A1009,
+	HV_REGISTER_NESTED_SINT10	= 0x000A100A,
+	HV_REGISTER_NESTED_SINT11	= 0x000A100B,
+	HV_REGISTER_NESTED_SINT12	= 0x000A100C,
+	HV_REGISTER_NESTED_SINT13	= 0x000A100D,
+	HV_REGISTER_NESTED_SINT14	= 0x000A100E,
+	HV_REGISTER_NESTED_SINT15	= 0x000A100F,
+	HV_REGISTER_NESTED_SCONTROL	= 0x000A1010,
+	HV_REGISTER_NESTED_SVERSION	= 0x000A1011,
+	HV_REGISTER_NESTED_SIFP		= 0x000A1012,
+	HV_REGISTER_NESTED_SIPP		= 0x000A1013,
+	HV_REGISTER_NESTED_EOM		= 0x000A1014,
+	HV_REGISTER_NESTED_SIRBP	= 0x000a1015,
+
+
+	/* Hypervisor-defined Registers (Synthetic Timers) */
+	HV_REGISTER_STIMER0_CONFIG		= 0x000B0000,
+	HV_REGISTER_STIMER0_COUNT		= 0x000B0001,
+	HV_REGISTER_STIMER1_CONFIG		= 0x000B0002,
+	HV_REGISTER_STIMER1_COUNT		= 0x000B0003,
+	HV_REGISTER_STIMER2_CONFIG		= 0x000B0004,
+	HV_REGISTER_STIMER2_COUNT		= 0x000B0005,
+	HV_REGISTER_STIMER3_CONFIG		= 0x000B0006,
+	HV_REGISTER_STIMER3_COUNT		= 0x000B0007,
+	HV_REGISTER_STIME_UNHALTED_TIMER_CONFIG	= 0x000B0100,
+	HV_REGISTER_STIME_UNHALTED_TIMER_COUNT	= 0x000b0101,
+
+	/* Synthetic VSM registers */
+
+	/* 0x000D0000-1 are available for future use. */
+	HV_REGISTER_VSM_CODE_PAGE_OFFSETS	= 0x000D0002,
+	HV_REGISTER_VSM_VP_STATUS		= 0x000D0003,
+	HV_REGISTER_VSM_PARTITION_STATUS	= 0x000D0004,
+	HV_REGISTER_VSM_VINA			= 0x000D0005,
+	HV_REGISTER_VSM_CAPABILITIES		= 0x000D0006,
+	HV_REGISTER_VSM_PARTITION_CONFIG	= 0x000D0007,
+
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL0	= 0x000D0010,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL1	= 0x000D0011,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL2	= 0x000D0012,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL3	= 0x000D0013,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL4	= 0x000D0014,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL5	= 0x000D0015,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL6	= 0x000D0016,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL7	= 0x000D0017,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL8	= 0x000D0018,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL9	= 0x000D0019,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL10	= 0x000D001A,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL11	= 0x000D001B,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL12	= 0x000D001C,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL13	= 0x000D001D,
+	HV_REGISTER_VSM_VP_SECURE_CONFIG_VTL14	= 0x000D001E,
+
+	HV_REGISTER_VSM_VP_WAIT_FOR_TLB_LOCK	= 0x000D0020,
+
+	HV_REGISTER_ISOLATION_CAPABILITIES	= 0x000D0100,
+
+	/* Pending Interruption Register */
+	HV_REGISTER_PENDING_INTERRUPTION	= 0x00010002,
+
+	/* Interrupt State register */
+	HV_REGISTER_INTERRUPT_STATE	= 0x00010003,
+
+	/* Interruptible notification register */
+	HV_X64_REGISTER_DELIVERABILITY_NOTIFICATIONS	= 0x00010006,
+
+	/* X64 User-Mode Registers */
+	HV_X64_REGISTER_RAX	= 0x00020000,
+	HV_X64_REGISTER_RCX	= 0x00020001,
+	HV_X64_REGISTER_RDX	= 0x00020002,
+	HV_X64_REGISTER_RBX	= 0x00020003,
+	HV_X64_REGISTER_RSP	= 0x00020004,
+	HV_X64_REGISTER_RBP	= 0x00020005,
+	HV_X64_REGISTER_RSI	= 0x00020006,
+	HV_X64_REGISTER_RDI	= 0x00020007,
+	HV_X64_REGISTER_R8	= 0x00020008,
+	HV_X64_REGISTER_R9	= 0x00020009,
+	HV_X64_REGISTER_R10	= 0x0002000A,
+	HV_X64_REGISTER_R11	= 0x0002000B,
+	HV_X64_REGISTER_R12	= 0x0002000C,
+	HV_X64_REGISTER_R13	= 0x0002000D,
+	HV_X64_REGISTER_R14	= 0x0002000E,
+	HV_X64_REGISTER_R15	= 0x0002000F,
+	HV_X64_REGISTER_RIP	= 0x00020010,
+	HV_X64_REGISTER_RFLAGS	= 0x00020011,
+
+	/* X64 Floating Point and Vector Registers */
+	HV_X64_REGISTER_XMM0			= 0x00030000,
+	HV_X64_REGISTER_XMM1			= 0x00030001,
+	HV_X64_REGISTER_XMM2			= 0x00030002,
+	HV_X64_REGISTER_XMM3			= 0x00030003,
+	HV_X64_REGISTER_XMM4			= 0x00030004,
+	HV_X64_REGISTER_XMM5			= 0x00030005,
+	HV_X64_REGISTER_XMM6			= 0x00030006,
+	HV_X64_REGISTER_XMM7			= 0x00030007,
+	HV_X64_REGISTER_XMM8			= 0x00030008,
+	HV_X64_REGISTER_XMM9			= 0x00030009,
+	HV_X64_REGISTER_XMM10			= 0x0003000A,
+	HV_X64_REGISTER_XMM11			= 0x0003000B,
+	HV_X64_REGISTER_XMM12			= 0x0003000C,
+	HV_X64_REGISTER_XMM13			= 0x0003000D,
+	HV_X64_REGISTER_XMM14			= 0x0003000E,
+	HV_X64_REGISTER_XMM15			= 0x0003000F,
+	HV_X64_REGISTER_FP_MMX0			= 0x00030010,
+	HV_X64_REGISTER_FP_MMX1			= 0x00030011,
+	HV_X64_REGISTER_FP_MMX2			= 0x00030012,
+	HV_X64_REGISTER_FP_MMX3			= 0x00030013,
+	HV_X64_REGISTER_FP_MMX4			= 0x00030014,
+	HV_X64_REGISTER_FP_MMX5			= 0x00030015,
+	HV_X64_REGISTER_FP_MMX6			= 0x00030016,
+	HV_X64_REGISTER_FP_MMX7			= 0x00030017,
+	HV_X64_REGISTER_FP_CONTROL_STATUS	= 0x00030018,
+	HV_X64_REGISTER_XMM_CONTROL_STATUS	= 0x00030019,
+
+	/* X64 Control Registers */
+	HV_X64_REGISTER_CR0	= 0x00040000,
+	HV_X64_REGISTER_CR2	= 0x00040001,
+	HV_X64_REGISTER_CR3	= 0x00040002,
+	HV_X64_REGISTER_CR4	= 0x00040003,
+	HV_X64_REGISTER_CR8	= 0x00040004,
+	HV_X64_REGISTER_XFEM	= 0x00040005,
+
+	/* X64 Intermediate Control Registers */
+	HV_X64_REGISTER_INTERMEDIATE_CR0	= 0x00041000,
+	HV_X64_REGISTER_INTERMEDIATE_CR4	= 0x00041003,
+	HV_X64_REGISTER_INTERMEDIATE_CR8	= 0x00041004,
+
+	/* X64 Debug Registers */
+	HV_X64_REGISTER_DR0	= 0x00050000,
+	HV_X64_REGISTER_DR1	= 0x00050001,
+	HV_X64_REGISTER_DR2	= 0x00050002,
+	HV_X64_REGISTER_DR3	= 0x00050003,
+	HV_X64_REGISTER_DR6	= 0x00050004,
+	HV_X64_REGISTER_DR7	= 0x00050005,
+
+	/* X64 Segment Registers */
+	HV_X64_REGISTER_ES	= 0x00060000,
+	HV_X64_REGISTER_CS	= 0x00060001,
+	HV_X64_REGISTER_SS	= 0x00060002,
+	HV_X64_REGISTER_DS	= 0x00060003,
+	HV_X64_REGISTER_FS	= 0x00060004,
+	HV_X64_REGISTER_GS	= 0x00060005,
+	HV_X64_REGISTER_LDTR	= 0x00060006,
+	HV_X64_REGISTER_TR	= 0x00060007,
+
+	/* X64 Table Registers */
+	HV_X64_REGISTER_IDTR	= 0x00070000,
+	HV_X64_REGISTER_GDTR	= 0x00070001,
+
+	/* X64 Virtualized MSRs */
+	HV_X64_REGISTER_TSC		= 0x00080000,
+	HV_X64_REGISTER_EFER		= 0x00080001,
+	HV_X64_REGISTER_KERNEL_GS_BASE	= 0x00080002,
+	HV_X64_REGISTER_APIC_BASE	= 0x00080003,
+	HV_X64_REGISTER_PAT		= 0x00080004,
+	HV_X64_REGISTER_SYSENTER_CS	= 0x00080005,
+	HV_X64_REGISTER_SYSENTER_EIP	= 0x00080006,
+	HV_X64_REGISTER_SYSENTER_ESP	= 0x00080007,
+	HV_X64_REGISTER_STAR		= 0x00080008,
+	HV_X64_REGISTER_LSTAR		= 0x00080009,
+	HV_X64_REGISTER_CSTAR		= 0x0008000A,
+	HV_X64_REGISTER_SFMASK		= 0x0008000B,
+	HV_X64_REGISTER_INITIAL_APIC_ID	= 0x0008000C,
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
+	HV_X64_REGISTER_TSC_AUX		= 0x0008007B,
+	HV_X64_REGISTER_BNDCFGS		= 0x0008007C,
+	HV_X64_REGISTER_DEBUG_CTL	= 0x0008007D,
+
+	/* Available */
+	HV_X64_REGISTER_AVAILABLE0008007E	= 0x0008007E,
+	HV_X64_REGISTER_AVAILABLE0008007F	= 0x0008007F,
+
+	HV_X64_REGISTER_SGX_LAUNCH_CONTROL0	= 0x00080080,
+	HV_X64_REGISTER_SGX_LAUNCH_CONTROL1	= 0x00080081,
+	HV_X64_REGISTER_SGX_LAUNCH_CONTROL2	= 0x00080082,
+	HV_X64_REGISTER_SGX_LAUNCH_CONTROL3	= 0x00080083,
+	HV_X64_REGISTER_SPEC_CTRL		= 0x00080084,
+	HV_X64_REGISTER_PRED_CMD		= 0x00080085,
+	HV_X64_REGISTER_VIRT_SPEC_CTRL		= 0x00080086,
+
+	/* Other MSRs */
+	HV_X64_REGISTER_MSR_IA32_MISC_ENABLE		= 0x000800A0,
+	HV_X64_REGISTER_IA32_FEATURE_CONTROL		= 0x000800A1,
+	HV_X64_REGISTER_IA32_VMX_BASIC			= 0x000800A2,
+	HV_X64_REGISTER_IA32_VMX_PINBASED_CTLS		= 0x000800A3,
+	HV_X64_REGISTER_IA32_VMX_PROCBASED_CTLS		= 0x000800A4,
+	HV_X64_REGISTER_IA32_VMX_EXIT_CTLS		= 0x000800A5,
+	HV_X64_REGISTER_IA32_VMX_ENTRY_CTLS		= 0x000800A6,
+	HV_X64_REGISTER_IA32_VMX_MISC			= 0x000800A7,
+	HV_X64_REGISTER_IA32_VMX_CR0_FIXED0		= 0x000800A8,
+	HV_X64_REGISTER_IA32_VMX_CR0_FIXED1		= 0x000800A9,
+	HV_X64_REGISTER_IA32_VMX_CR4_FIXED0		= 0x000800AA,
+	HV_X64_REGISTER_IA32_VMX_CR4_FIXED1		= 0x000800AB,
+	HV_X64_REGISTER_IA32_VMX_VMCS_ENUM		= 0x000800AC,
+	HV_X64_REGISTER_IA32_VMX_PROCBASED_CTLS2	= 0x000800AD,
+	HV_X64_REGISTER_IA32_VMX_EPT_VPID_CAP		= 0x000800AE,
+	HV_X64_REGISTER_IA32_VMX_TRUE_PINBASED_CTLS	= 0x000800AF,
+	HV_X64_REGISTER_IA32_VMX_TRUE_PROCBASED_CTLS	= 0x000800B0,
+	HV_X64_REGISTER_IA32_VMX_TRUE_EXIT_CTLS		= 0x000800B1,
+	HV_X64_REGISTER_IA32_VMX_TRUE_ENTRY_CTLS	= 0x000800B2,
+
+	/* Performance monitoring MSRs */
+	HV_X64_REGISTER_PERF_GLOBAL_CTRL	= 0x00081000,
+	HV_X64_REGISTER_PERF_GLOBAL_STATUS	= 0x00081001,
+	HV_X64_REGISTER_PERF_GLOBAL_IN_USE	= 0x00081002,
+	HV_X64_REGISTER_FIXED_CTR_CTRL		= 0x00081003,
+	HV_X64_REGISTER_DS_AREA			= 0x00081004,
+	HV_X64_REGISTER_PEBS_ENABLE		= 0x00081005,
+	HV_X64_REGISTER_PEBS_LD_LAT		= 0x00081006,
+	HV_X64_REGISTER_PEBS_FRONTEND		= 0x00081007,
+	HV_X64_REGISTER_PERF_EVT_SEL0		= 0x00081100,
+	HV_X64_REGISTER_PMC0			= 0x00081200,
+	HV_X64_REGISTER_FIXED_CTR0		= 0x00081300,
+
+	HV_X64_REGISTER_LBR_TOS		= 0x00082000,
+	HV_X64_REGISTER_LBR_SELECT	= 0x00082001,
+	HV_X64_REGISTER_LER_FROM_LIP	= 0x00082002,
+	HV_X64_REGISTER_LER_TO_LIP	= 0x00082003,
+	HV_X64_REGISTER_LBR_FROM0	= 0x00082100,
+	HV_X64_REGISTER_LBR_TO0		= 0x00082200,
+	HV_X64_REGISTER_LBR_INFO0	= 0x00083300,
+
+	/* Intel processor trace MSRs */
+	HV_X64_REGISTER_RTIT_CTL		= 0x00081008,
+	HV_X64_REGISTER_RTIT_STATUS		= 0x00081009,
+	HV_X64_REGISTER_RTIT_OUTPUT_BASE	= 0x0008100A,
+	HV_X64_REGISTER_RTIT_OUTPUT_MASK_PTRS	= 0x0008100B,
+	HV_X64_REGISTER_RTIT_CR3_MATCH		= 0x0008100C,
+	HV_X64_REGISTER_RTIT_ADDR0A		= 0x00081400,
+
+	/* RtitAddr0A/B - RtitAddr3A/B occupy 0x00081400-0x00081407. */
+
+	/* X64 Apic registers. These match the equivalent x2APIC MSR offsets. */
+	HV_X64_REGISTER_APIC_ID		= 0x00084802,
+	HV_X64_REGISTER_APIC_VERSION	= 0x00084803,
+
+	/* Hypervisor-defined registers (Misc) */
+	HV_X64_REGISTER_HYPERCALL	= 0x00090001,
+
+	/* X64 Virtual APIC registers synthetic MSRs */
+	HV_X64_REGISTER_SYNTHETIC_EOI	= 0x00090010,
+	HV_X64_REGISTER_SYNTHETIC_ICR	= 0x00090011,
+	HV_X64_REGISTER_SYNTHETIC_TPR	= 0x00090012,
+
+	/* Partition Timer Assist Registers */
+	HV_X64_REGISTER_EMULATED_TIMER_PERIOD	= 0x00090030,
+	HV_X64_REGISTER_EMULATED_TIMER_CONTROL	= 0x00090031,
+	HV_X64_REGISTER_PM_TIMER_ASSIST		= 0x00090032,
+
+	/* Intercept Control Registers */
+	HV_X64_REGISTER_CR_INTERCEPT_CONTROL			= 0x000E0000,
+	HV_X64_REGISTER_CR_INTERCEPT_CR0_MASK			= 0x000E0001,
+	HV_X64_REGISTER_CR_INTERCEPT_CR4_MASK			= 0x000E0002,
+	HV_X64_REGISTER_CR_INTERCEPT_IA32_MISC_ENABLE_MASK	= 0x000E0003,
+
+};
+
+struct hv_u128 {
+	__u64 high_part;
+	__u64 low_part;
+};
+
+union hv_x64_fp_register {
+	struct hv_u128 as_uint128;
+	struct {
+		__u64 mantissa;
+		__u64 biased_exponent : 15;
+		__u64 sign : 1;
+		__u64 reserved : 48;
+	};
+};
+
+union hv_x64_fp_control_status_register {
+	struct hv_u128 as_uint128;
+	struct {
+		__u16 fp_control;
+		__u16 fp_status;
+		__u8 fp_tag;
+		__u8 reserved;
+		__u16 last_fp_op;
+		union {
+			/* long mode */
+			__u64 last_fp_rip;
+			/* 32 bit mode */
+			struct {
+				__u32 last_fp_eip;
+				__u16 last_fp_cs;
+			};
+		};
+	};
+};
+
+union hv_x64_xmm_control_status_register {
+	struct hv_u128 as_uint128;
+	struct {
+		union {
+			/* long mode */
+			__u64 last_fp_rdp;
+			/* 32 bit mode */
+			struct {
+				__u32 last_fp_dp;
+				__u16 last_fp_ds;
+			};
+		};
+		__u32 xmm_status_control;
+		__u32 xmm_status_control_mask;
+	};
+};
+
+struct hv_x64_segment_register {
+	__u64 base;
+	__u32 limit;
+	__u16 selector;
+	union {
+		struct {
+			__u16 segment_type : 4;
+			__u16 non_system_segment : 1;
+			__u16 descriptor_privilege_level : 2;
+			__u16 present : 1;
+			__u16 reserved : 4;
+			__u16 available : 1;
+			__u16 _long : 1;
+			__u16 _default : 1;
+			__u16 granularity : 1;
+		};
+		__u16 attributes;
+	};
+};
+
+struct hv_x64_table_register {
+	__u16 pad[3];
+	__u16 limit;
+	__u64 base;
+};
+
+union hv_explicit_suspend_register {
+	__u64 as_uint64;
+	struct {
+		__u64 suspended : 1;
+		__u64 reserved : 63;
+	};
+};
+
+union hv_intercept_suspend_register {
+	__u64 as_uint64;
+	struct {
+		__u64 suspended : 1;
+		__u64 reserved : 63;
+	};
+};
+
+union hv_dispatch_suspend_register {
+	__u64 as_uint64;
+	struct {
+		__u64 suspended : 1;
+		__u64 reserved : 63;
+	};
+};
+
+union hv_x64_interrupt_state_register {
+	__u64 as_uint64;
+	struct {
+		__u64 interrupt_shadow : 1;
+		__u64 nmi_masked : 1;
+		__u64 reserved : 62;
+	};
+};
+
+union hv_x64_pending_interruption_register {
+	__u64 as_uint64;
+	struct {
+		__u32 interruption_pending : 1;
+		__u32 interruption_type : 3;
+		__u32 deliver_error_code : 1;
+		__u32 instruction_length : 4;
+		__u32 nested_event : 1;
+		__u32 reserved : 6;
+		__u32 interruption_vector : 16;
+		__u32 error_code;
+	};
+};
+
+union hv_x64_msr_npiep_config_contents {
+	__u64 as_uint64;
+	struct {
+		/*
+		 * These bits enable instruction execution prevention for
+		 * specific instructions.
+		 */
+		__u64 prevents_gdt : 1;
+		__u64 prevents_idt : 1;
+		__u64 prevents_ldt : 1;
+		__u64 prevents_tr : 1;
+
+		/* The reserved bits must always be 0. */
+		__u64 reserved : 60;
+	};
+};
+
+union hv_x64_pending_exception_event {
+	__u64 as_uint64[2];
+	struct {
+		__u32 event_pending : 1;
+		__u32 event_type : 3;
+		__u32 reserved0 : 4;
+		__u32 deliver_error_code : 1;
+		__u32 reserved1 : 7;
+		__u32 vector : 16;
+		__u32 error_code;
+		__u64 exception_parameter;
+	};
+};
+
+union hv_x64_pending_virtualization_fault_event {
+	__u64 as_uint64[2];
+	struct {
+		__u32 event_pending : 1;
+		__u32 event_type : 3;
+		__u32 reserved0 : 4;
+		__u32 reserved1 : 8;
+		__u32 parameter0 : 16;
+		__u32 code;
+		__u64 parameter1;
+	};
+};
+
+union hv_register_value {
+	struct hv_u128 reg128;
+	__u64 reg64;
+	__u32 reg32;
+	__u16 reg16;
+	__u8 reg8;
+	union hv_x64_fp_register fp;
+	union hv_x64_fp_control_status_register fp_control_status;
+	union hv_x64_xmm_control_status_register xmm_control_status;
+	struct hv_x64_segment_register segment;
+	struct hv_x64_table_register table;
+	union hv_explicit_suspend_register explicit_suspend;
+	union hv_intercept_suspend_register intercept_suspend;
+	union hv_dispatch_suspend_register dispatch_suspend;
+	union hv_x64_interrupt_state_register interrupt_state;
+	union hv_x64_pending_interruption_register pending_interruption;
+	union hv_x64_msr_npiep_config_contents npiep_config;
+	union hv_x64_pending_exception_event pending_exception_event;
+	union hv_x64_pending_virtualization_fault_event
+		pending_virtualization_fault_event;
+};
+
 #endif
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 6e5072e29897..b9295400c20b 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -622,53 +622,30 @@ struct hv_retarget_device_interrupt {
 } __packed __aligned(8);
 
 
-/* HvGetVpRegisters hypercall input with variable size reg name list*/
-struct hv_get_vp_registers_input {
-	struct {
-		u64 partitionid;
-		u32 vpindex;
-		u8  inputvtl;
-		u8  padding[3];
-	} header;
-	struct input {
-		u32 name0;
-		u32 name1;
-	} element[];
-} __packed;
-
+/* HvGetVpRegisters hypercall with variable size reg name list*/
+struct hv_get_vp_registers {
+	u64 partition_id;
+	u32 vp_index;
+	u8  input_vtl;
+	u8  rsvd_z8;
+	u16 rsvd_z16;
+	__aligned(8) enum hv_register_name names[];
+} __aligned(8);
 
-/* HvGetVpRegisters returns an array of these output elements */
-struct hv_get_vp_registers_output {
-	union {
-		struct {
-			u32 a;
-			u32 b;
-			u32 c;
-			u32 d;
-		} as32 __packed;
-		struct {
-			u64 low;
-			u64 high;
-		} as64 __packed;
-	};
+/* HvSetVpRegisters hypercall with variable size reg name/value list*/
+struct hv_register_assoc {
+	enum hv_register_name name;
+	__aligned(16) union hv_register_value value;
 };
 
-/* HvSetVpRegisters hypercall with variable size reg name/value list*/
-struct hv_set_vp_registers_input {
-	struct {
-		u64 partitionid;
-		u32 vpindex;
-		u8  inputvtl;
-		u8  padding[3];
-	} header;
-	struct {
-		u32 name;
-		u32 padding1;
-		u64 padding2;
-		u64 valuelow;
-		u64 valuehigh;
-	} element[];
-} __packed;
+struct hv_set_vp_registers {
+	u64 partition_id;
+	u32 vp_index;
+	u8  input_vtl;
+	u8  rsvd_z8;
+	u16 rsvd_z16;
+	struct hv_register_assoc elements[];
+} __aligned(16);
 
 enum hv_device_type {
 	HV_DEVICE_TYPE_LOGICAL = 0,
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index 50521c5f7948..dfe469f573f9 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -17,6 +17,7 @@
 struct mshv_vp {
 	u32 index;
 	struct mshv_partition *partition;
+	struct mutex mutex;
 };
 
 struct mshv_mem_region {
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 1f053eae68a6..5d53ed655429 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -33,6 +33,14 @@ struct mshv_create_vp {
 	__u32 vp_index;
 };
 
+#define MSHV_VP_MAX_REGISTERS	128
+
+struct mshv_vp_registers {
+	int count; /* at most MSHV_VP_MAX_REGISTERS */
+	enum hv_register_name *names;
+	union hv_register_value *values;
+};
+
 #define MSHV_IOCTL 0xB8
 
 /* mshv device */
@@ -44,4 +52,8 @@ struct mshv_create_vp {
 #define MSHV_UNMAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x03, struct mshv_user_mem_region)
 #define MSHV_CREATE_VP		_IOW(MSHV_IOCTL, 0x04, struct mshv_create_vp)
 
+/* vp device */
+#define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
+#define MSHV_SET_VP_REGISTERS   _IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
+
 #endif
diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
index 3be9d9a468c1..2a10137a1e84 100644
--- a/virt/mshv/mshv_main.c
+++ b/virt/mshv/mshv_main.c
@@ -74,6 +74,12 @@ static struct miscdevice mshv_dev = {
 #define HV_MAP_GPA_BATCH_SIZE	\
 		(PAGE_SIZE / sizeof(struct hv_map_gpa_pages) / sizeof(u64))
 #define PIN_PAGES_BATCH_SIZE	(0x10000000 / PAGE_SIZE)
+#define HV_GET_REGISTER_BATCH_SIZE	\
+	(PAGE_SIZE / \
+	 sizeof(struct hv_get_vp_registers) / sizeof(enum hv_register_name))
+#define HV_SET_REGISTER_BATCH_SIZE	\
+	(PAGE_SIZE / \
+	 sizeof(struct hv_set_vp_registers) / sizeof(struct hv_register_assoc))
 
 static int
 hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
@@ -380,10 +386,258 @@ hv_call_unmap_gpa_pages(u64 partition_id,
 	return ret;
 }
 
+static int
+hv_call_get_vp_registers(u32 vp_index,
+			 u64 partition_id,
+			 u16 count,
+			 const enum hv_register_name *names,
+			 union hv_register_value *values)
+{
+	struct hv_get_vp_registers *input_page;
+	union hv_register_value *output_page;
+	u16 completed = 0;
+	u64 hypercall_status;
+	unsigned long remaining = count;
+	int rep_count;
+	int status;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	input_page = (struct hv_get_vp_registers *)(*this_cpu_ptr(
+		hyperv_pcpu_input_arg));
+	output_page = (union hv_register_value *)(*this_cpu_ptr(
+		hyperv_pcpu_output_arg));
+
+	input_page->partition_id = partition_id;
+	input_page->vp_index = vp_index;
+	input_page->input_vtl = 0;
+	input_page->rsvd_z8 = 0;
+	input_page->rsvd_z16 = 0;
+
+	while (remaining) {
+		rep_count = min(remaining, HV_GET_REGISTER_BATCH_SIZE);
+		memcpy(input_page->names, names,
+			sizeof(enum hv_register_name) * rep_count);
+
+		hypercall_status =
+			hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS, rep_count,
+					    0, input_page, output_page);
+		status = hypercall_status & HV_HYPERCALL_RESULT_MASK;
+		if (status != HV_STATUS_SUCCESS) {
+			pr_err("%s: completed %li out of %u, %s\n",
+			       __func__,
+			       count - remaining, count,
+			       hv_status_to_string(status));
+			break;
+		}
+		completed = (hypercall_status & HV_HYPERCALL_REP_COMP_MASK) >>
+			    HV_HYPERCALL_REP_COMP_OFFSET;
+		memcpy(values, output_page,
+			sizeof(union hv_register_value) * completed);
+
+		names += completed;
+		values += completed;
+		remaining -= completed;
+	}
+	local_irq_restore(flags);
+
+	return -hv_status_to_errno(status);
+}
+
+static int
+hv_call_set_vp_registers(u32 vp_index,
+			 u64 partition_id,
+			 u16 count,
+			 struct hv_register_assoc *registers)
+{
+	struct hv_set_vp_registers *input_page;
+	u16 completed = 0;
+	u64 hypercall_status;
+	unsigned long remaining = count;
+	int rep_count;
+	int status;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	input_page = (struct hv_set_vp_registers *)(*this_cpu_ptr(
+		hyperv_pcpu_input_arg));
+
+	input_page->partition_id = partition_id;
+	input_page->vp_index = vp_index;
+	input_page->input_vtl = 0;
+	input_page->rsvd_z8 = 0;
+	input_page->rsvd_z16 = 0;
+
+	while (remaining) {
+		rep_count = min(remaining, HV_SET_REGISTER_BATCH_SIZE);
+		memcpy(input_page->elements, registers,
+			sizeof(struct hv_register_assoc) * rep_count);
+
+		hypercall_status =
+			hv_do_rep_hypercall(HVCALL_SET_VP_REGISTERS, rep_count,
+					    0, input_page, NULL);
+		status = hypercall_status & HV_HYPERCALL_RESULT_MASK;
+		if (status != HV_STATUS_SUCCESS) {
+			pr_err("%s: completed %li out of %u, %s\n",
+			       __func__,
+			       count - remaining, count,
+			       hv_status_to_string(status));
+			break;
+		}
+		completed = (hypercall_status & HV_HYPERCALL_REP_COMP_MASK) >>
+			    HV_HYPERCALL_REP_COMP_OFFSET;
+		registers += completed;
+		remaining -= completed;
+	}
+
+	local_irq_restore(flags);
+
+	return -hv_status_to_errno(status);
+}
+
+static long
+mshv_vp_ioctl_get_regs(struct mshv_vp *vp, void __user *user_args)
+{
+	struct mshv_vp_registers args;
+	enum hv_register_name *names;
+	union hv_register_value *values;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.count > MSHV_VP_MAX_REGISTERS)
+		return -EINVAL;
+
+	names = kmalloc_array(args.count,
+			      sizeof(enum hv_register_name),
+			      GFP_KERNEL);
+	if (!names)
+		return -ENOMEM;
+
+	values = kmalloc_array(args.count,
+			       sizeof(union hv_register_value),
+			       GFP_KERNEL);
+	if (!values) {
+		kfree(names);
+		return -ENOMEM;
+	}
+
+	if (copy_from_user(names, args.names,
+			   sizeof(enum hv_register_name) * args.count)) {
+		ret = -EFAULT;
+		goto free_return;
+	}
+
+	ret = hv_call_get_vp_registers(vp->index, vp->partition->id,
+				       args.count, names, values);
+	if (ret)
+		goto free_return;
+
+	if (copy_to_user(args.values, values,
+			 sizeof(union hv_register_value) * args.count)) {
+		ret = -EFAULT;
+	}
+
+free_return:
+	kfree(names);
+	kfree(values);
+	return ret;
+}
+
+static long
+mshv_vp_ioctl_set_regs(struct mshv_vp *vp, void __user *user_args)
+{
+	int i;
+	struct mshv_vp_registers args;
+	struct hv_register_assoc *registers;
+	enum hv_register_name *names;
+	union hv_register_value *values;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.count > MSHV_VP_MAX_REGISTERS)
+		return -EINVAL;
+
+	names = kmalloc_array(args.count,
+			      sizeof(enum hv_register_name),
+			      GFP_KERNEL);
+	if (!names)
+		return -ENOMEM;
+
+	values = kmalloc_array(args.count,
+			       sizeof(union hv_register_value),
+			       GFP_KERNEL);
+	if (!values) {
+		kfree(names);
+		return -ENOMEM;
+	}
+
+	registers = kmalloc_array(args.count,
+				  sizeof(struct hv_register_assoc),
+				  GFP_KERNEL);
+	if (!registers) {
+		kfree(values);
+		kfree(names);
+		return -ENOMEM;
+	}
+
+	if (copy_from_user(names, args.names,
+			   sizeof(enum hv_register_name) * args.count)) {
+		ret = -EFAULT;
+		goto free_return;
+	}
+
+	if (copy_from_user(values, args.values,
+			   sizeof(union hv_register_value) * args.count)) {
+		ret = -EFAULT;
+		goto free_return;
+	}
+
+	for (i = 0; i < args.count; i++) {
+		memcpy(&registers[i].name, &names[i],
+		       sizeof(enum hv_register_name));
+		memcpy(&registers[i].value, &values[i],
+		       sizeof(union hv_register_value));
+	}
+
+	ret = hv_call_set_vp_registers(vp->index, vp->partition->id,
+				       args.count, registers);
+
+free_return:
+	kfree(names);
+	kfree(values);
+	kfree(registers);
+	return ret;
+}
+
+
 static long
 mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
-	return -ENOTTY;
+	struct mshv_vp *vp = filp->private_data;
+	long r = 0;
+
+	if (mutex_lock_killable(&vp->mutex))
+		return -EINTR;
+
+	switch (ioctl) {
+	case MSHV_GET_VP_REGISTERS:
+		r = mshv_vp_ioctl_get_regs(vp, (void __user *)arg);
+		break;
+	case MSHV_SET_VP_REGISTERS:
+		r = mshv_vp_ioctl_set_regs(vp, (void __user *)arg);
+		break;
+	default:
+		r = -ENOTTY;
+		break;
+	}
+	mutex_unlock(&vp->mutex);
+
+	return r;
 }
 
 static int
@@ -420,6 +674,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (!vp)
 		return -ENOMEM;
 
+	mutex_init(&vp->mutex);
+
 	vp->index = args.vp_index;
 	vp->partition = mshv_partition_get(partition);
 	if (!vp->partition) {
-- 
2.25.1

