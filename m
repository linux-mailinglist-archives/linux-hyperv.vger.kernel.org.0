Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63441B63F
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Sep 2021 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbhI1SdF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Sep 2021 14:33:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50902 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242220AbhI1SdB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Sep 2021 14:33:01 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 069FC20B4843;
        Tue, 28 Sep 2021 11:31:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 069FC20B4843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632853882;
        bh=yELODPV6v1EpDcSbKeOYb9pRtmI8VrjG7gjfFcCNNgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYroFhK4iMfCjmvfXVoU5ThjlY761SvZx6JRE8AtqeWqhPcmH9SXo5PstQQf9Gx1j
         JCnjKTfywEiRksJYvfSrbkk1Wsyb35DUD2PUuGjxE5Wsntf/mb9ZYu2F676XBxzY8a
         lWGku9Lk1u9YtkFutq6lOMjxdjEhMwChgi7wv0KE=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH v3 14/19] drivers/hv: assert interrupt ioctl
Date:   Tue, 28 Sep 2021 11:31:10 -0700
Message-Id: <1632853875-20261-15-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce ioctl for asserting an interrupt on a given APIC within a
guest partition.

Co-developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst         | 11 ++++++++++
 arch/x86/include/asm/hyperv-tlfs.h      | 14 ------------
 arch/x86/include/uapi/asm/hyperv-tlfs.h | 22 +++++++++++++++++++
 drivers/hv/hv_call.c                    | 29 +++++++++++++++++++++++++
 drivers/hv/mshv.h                       |  5 +++++
 drivers/hv/mshv_main.c                  | 20 +++++++++++++++++
 include/asm-generic/hyperv-tlfs.h       | 11 ++++++++++
 include/uapi/linux/mshv.h               |  7 ++++++
 8 files changed, 105 insertions(+), 14 deletions(-)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index f0094258d834..76f98485cd93 100644
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
index 2b6f7dca79e6..871f5d014ae0 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -546,20 +546,6 @@ struct hv_partition_assist_pg {
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
index 442c4bb4113e..e234297521a3 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -989,6 +989,28 @@ union hv_intercept_parameters {
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
+		__u32 interrupt_type; /* enum hv_interrupt type */
+		__u32 level_triggered : 1;
+		__u32 logical_dest_mode : 1;
+		__u32 rsvd : 30;
+	} __packed;
+	__u64 as_uint64;
+};
 
 #endif
diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
index ec71b5a08a76..72e93d13d8ee 100644
--- a/drivers/hv/hv_call.c
+++ b/drivers/hv/hv_call.c
@@ -432,3 +432,32 @@ int hv_call_install_intercept(
 	return ret;
 }
 
+int hv_call_assert_virtual_interrupt(
+		u64 partition_id,
+		u32 vector,
+		u64 dest_addr,
+		union hv_interrupt_control control)
+{
+	struct hv_assert_virtual_interrupt *input;
+	unsigned long flags;
+	u64 status;
+
+	local_irq_save(flags);
+	input = (struct hv_assert_virtual_interrupt *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
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
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index 541c83a36767..c0a0ccb3626a 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -67,5 +67,10 @@ int hv_call_set_vp_registers(
 int hv_call_install_intercept(u64 partition_id, u32 access_type,
 		enum hv_intercept_type intercept_type,
 		union hv_intercept_parameters intercept_parameter);
+int hv_call_assert_virtual_interrupt(
+		u64 partition_id,
+		u32 vector,
+		u64 dest_addr,
+		union hv_interrupt_control control);
 
 #endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 911dfc61e24c..ee41b59cc922 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -583,6 +583,22 @@ mshv_partition_ioctl_install_intercept(struct mshv_partition *partition,
 			args.intercept_parameter);
 }
 
+static long
+mshv_partition_ioctl_assert_interrupt(struct mshv_partition *partition,
+				      void __user *user_args)
+{
+	struct mshv_assert_interrupt args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return hv_call_assert_virtual_interrupt(
+			partition->id,
+			args.vector,
+			args.dest_addr,
+			args.control);
+}
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -609,6 +625,10 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
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
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 4453ba4d3293..d1cc5dbc78b5 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -165,6 +165,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
 #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
 #define HVCALL_RETARGET_INTERRUPT		0x007e
+#define HVCALL_ASSERT_VIRTUAL_INTERRUPT		0x0094
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 
@@ -821,4 +822,14 @@ struct hv_install_intercept {
 	union hv_intercept_parameters intercept_parameter;
 } __packed;
 
+struct hv_assert_virtual_interrupt {
+	u64 partition_id;
+	union hv_interrupt_control control;
+	u64 dest_addr; /* cpu's apic id */
+	u32 vector;
+	u8 target_vtl;
+	u8 rsvd_z0;
+	u16 rsvd_z1;
+} __packed;
+
 #endif
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 8574a4e62715..f65248a1ee89 100644
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
-- 
2.23.4

