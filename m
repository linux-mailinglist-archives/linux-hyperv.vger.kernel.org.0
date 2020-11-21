Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BA52BBAEC
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgKUAbK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:31:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51276 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgKUAax (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:53 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7E4C320B800F;
        Fri, 20 Nov 2020 16:30:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E4C320B800F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918650;
        bh=0FM0Gp7vRmpLA4paOc0mWVwmDBifgginhQ/YgRayZak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFmBUWBz7GoXDhJByRgbx3PLLSVtHRQjIhbQRgBORzGEmOeooSdWw5WAKwCtes3ic
         Bs7uCAgQ0gft21l6CTkZ6qNe98LUNe8Q5ZSJVS90VApXGH6SjWJDCJr+F6fSs9EVH8
         j765CHGmrpJtgNJk1xixFG94plnlf3356R1/WUsM=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 14/18] virt/mshv: assert interrupt ioctl
Date:   Fri, 20 Nov 2020 16:30:33 -0800
Message-Id: <1605918637-12192-15-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce ioctl for asserting an interrupt on a given APIC within a
guest partition.

Co-developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst         | 11 ++++++++
 arch/x86/include/asm/hyperv-tlfs.h      | 14 ----------
 arch/x86/include/uapi/asm/hyperv-tlfs.h | 22 +++++++++++++++
 include/asm-generic/hyperv-tlfs.h       | 11 ++++++++
 include/uapi/linux/mshv.h               |  7 +++++
 virt/mshv/mshv_main.c                   | 36 +++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index 95ec77dc73f0..694f978131f9 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -130,3 +130,14 @@ Enable and configure different types of intercepts. Intercepts are events in a
 guest partition that will suspend the guest vp and send a message to the root
 partition (returned from MSHV_RUN_VP).
 
+3.8 MSHV_ASSERT_INTERRUPT
+--------------------------
+:Type: partition ioctl
+:Parameters: struct mshv_assert_interrupt
+:Returns: 0 on success
+
+Assert interrupts in partitions that use Microsoft Hypervisor's internal
+emulated LAPIC. This must be enabled on partition creation with the flag:
+HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED
+
+
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index c34a6bb4f457..0de3c2e30a21 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -498,20 +498,6 @@ struct hv_partition_assist_pg {
 	u32 tlb_lock_count;
 };
 
-enum hv_interrupt_type {
-	HV_X64_INTERRUPT_TYPE_FIXED             = 0x0000,
-	HV_X64_INTERRUPT_TYPE_LOWESTPRIORITY    = 0x0001,
-	HV_X64_INTERRUPT_TYPE_SMI               = 0x0002,
-	HV_X64_INTERRUPT_TYPE_REMOTEREAD        = 0x0003,
-	HV_X64_INTERRUPT_TYPE_NMI               = 0x0004,
-	HV_X64_INTERRUPT_TYPE_INIT              = 0x0005,
-	HV_X64_INTERRUPT_TYPE_SIPI              = 0x0006,
-	HV_X64_INTERRUPT_TYPE_EXTINT            = 0x0007,
-	HV_X64_INTERRUPT_TYPE_LOCALINT0         = 0x0008,
-	HV_X64_INTERRUPT_TYPE_LOCALINT1         = 0x0009,
-	HV_X64_INTERRUPT_TYPE_MAXIMUM           = 0x000A,
-};
-
 #include <asm-generic/hyperv-tlfs.h>
 
 #endif
diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
index 28917301b6df..5478d4943bfc 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -1027,6 +1027,28 @@ union hv_intercept_parameters {
 #define HV_INTERCEPT_ACCESS_MASK_WRITE		0x02
 #define HV_INTERCEPT_ACCESS_MASK_EXECUTE	0x04
 
+enum hv_interrupt_type {
+	HV_X64_INTERRUPT_TYPE_FIXED             = 0x0000,
+	HV_X64_INTERRUPT_TYPE_LOWESTPRIORITY    = 0x0001,
+	HV_X64_INTERRUPT_TYPE_SMI               = 0x0002,
+	HV_X64_INTERRUPT_TYPE_REMOTEREAD        = 0x0003,
+	HV_X64_INTERRUPT_TYPE_NMI               = 0x0004,
+	HV_X64_INTERRUPT_TYPE_INIT              = 0x0005,
+	HV_X64_INTERRUPT_TYPE_SIPI              = 0x0006,
+	HV_X64_INTERRUPT_TYPE_EXTINT            = 0x0007,
+	HV_X64_INTERRUPT_TYPE_LOCALINT0         = 0x0008,
+	HV_X64_INTERRUPT_TYPE_LOCALINT1         = 0x0009,
+	HV_X64_INTERRUPT_TYPE_MAXIMUM           = 0x000A
+};
 
+union hv_interrupt_control {
+	struct {
+		enum hv_interrupt_type interrupt_type;
+		__u32 level_triggered : 1;
+		__u32 logical_dest_mode : 1;
+		__u32 rsvd : 30;
+	};
+	__u64 as_uint64;
+};
 
 #endif
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 93571bbab3a6..2cd46241c545 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -164,6 +164,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
 #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
 #define HVCALL_RETARGET_INTERRUPT		0x007e
+#define HVCALL_ASSERT_VIRTUAL_INTERRUPT		0x0094
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 
@@ -785,4 +786,14 @@ struct hv_install_intercept {
 	union hv_intercept_parameters intercept_parameter;
 };
 
+struct hv_assert_virtual_interrupt {
+	u64 partition_id;
+	union hv_interrupt_control control;
+	u64 dest_addr; /* cpu's apic id */
+	u32 vector;
+	u8 target_vtl;
+	u8 rsvd_z0;
+	u16 rsvd_z1;
+};
+
 #endif
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index e784b2d1a3fd..faed9d065bb7 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -47,6 +47,12 @@ struct mshv_install_intercept {
 	union hv_intercept_parameters intercept_parameter;
 };
 
+struct mshv_assert_interrupt {
+	union hv_interrupt_control control;
+	__u64 dest_addr;
+	__u32 vector;
+};
+
 #define MSHV_IOCTL 0xB8
 
 /* mshv device */
@@ -58,6 +64,7 @@ struct mshv_install_intercept {
 #define MSHV_UNMAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x03, struct mshv_user_mem_region)
 #define MSHV_CREATE_VP		_IOW(MSHV_IOCTL, 0x04, struct mshv_create_vp)
 #define MSHV_INSTALL_INTERCEPT	_IOW(MSHV_IOCTL, 0x08, struct mshv_install_intercept)
+#define MSHV_ASSERT_INTERRUPT	_IOW(MSHV_IOCTL, 0x09, struct mshv_assert_interrupt)
 
 /* vp device */
 #define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
index 8392d5a45e04..9cf236ade50a 100644
--- a/virt/mshv/mshv_main.c
+++ b/virt/mshv/mshv_main.c
@@ -1189,6 +1189,38 @@ mshv_partition_ioctl_install_intercept(struct mshv_partition *partition,
 	return ret;
 }
 
+static long
+mshv_partition_ioctl_assert_interrupt(struct mshv_partition *partition,
+				      void __user *user_args)
+{
+	struct mshv_assert_interrupt args;
+	int status;
+	unsigned long flags;
+	struct hv_assert_virtual_interrupt *input;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	local_irq_save(flags);
+	input = (struct hv_assert_virtual_interrupt *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition->id;
+	input->control = args.control;
+	input->dest_addr = args.dest_addr;
+	input->vector = args.vector;
+	status = hv_do_hypercall(HVCALL_ASSERT_VIRTUAL_INTERRUPT, input,
+			NULL) & HV_HYPERCALL_RESULT_MASK;
+	local_irq_restore(flags);
+
+	if (status != HV_STATUS_SUCCESS) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return -hv_status_to_errno(status);
+	}
+
+	return 0;
+}
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl,
 		     unsigned long arg)
@@ -1216,6 +1248,10 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl,
 		ret = mshv_partition_ioctl_install_intercept(partition,
 							(void __user *)arg);
 		break;
+	case MSHV_ASSERT_INTERRUPT:
+		ret = mshv_partition_ioctl_assert_interrupt(partition,
+							(void __user *)arg);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
-- 
2.25.1

