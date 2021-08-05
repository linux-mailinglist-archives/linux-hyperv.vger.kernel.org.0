Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28C93E1DE3
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 23:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbhHEVYz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 17:24:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46586 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhHEVYt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 17:24:49 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 040A720BE64E;
        Thu,  5 Aug 2021 14:24:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 040A720BE64E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628198674;
        bh=FR26dOJz1GTxInAa2NKFKh0c4+WJE61r37pqVD2Thv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1EZjrV9r+dH6qnaStzwciD4MC58x5pEVH1pWc8KFp65BjEgfnmr4BIh4udKjTNp5
         by5mcFxZLomnTRJS8MTfpwjSk+FAeYBR8eLI/swpdWVif9ep3WKHLJtgEMaOoFgULr
         JXux/ek6xiLBgisTb0jxonuszJEyyrucusx2V8c8=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH 13/19] drivers/hv: install intercept ioctl
Date:   Thu,  5 Aug 2021 14:23:55 -0700
Message-Id: <1628198641-791-14-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce ioctl for configuring intercept messages from a guest partition.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst         |  9 ++++++
 arch/x86/include/uapi/asm/hyperv-tlfs.h | 43 +++++++++++++++++++++++++
 drivers/hv/hv_call.c                    | 38 ++++++++++++++++++++++
 drivers/hv/mshv.h                       |  3 ++
 drivers/hv/mshv_main.c                  | 20 ++++++++++++
 include/asm-generic/hyperv-tlfs.h       |  8 +++++
 include/uapi/linux/mshv.h               |  7 ++++
 7 files changed, 128 insertions(+)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index 9deddcd7de54..f0094258d834 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -120,4 +120,13 @@ This ioctl will fail on any vp that's already running (not suspended).
 
 Information about the intercept is returned in the hv_message struct.
 
+3.7 MSHV_INSTALL_INTERCEPT
+--------------------------
+:Type: partition ioctl
+:Parameters: struct mshv_install_intercept
+:Returns: 0 on success
+
+Enable and configure different types of intercepts. Intercepts are events in a
+guest partition that will suspend the guest vp and send a message to the root
+partition (returned from MSHV_RUN_VP).
 
diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
index 4ffa7e1cd185..442c4bb4113e 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -948,4 +948,47 @@ struct hv_x64_apic_eoi_message {
 	__u32 interrupt_vector;
 } __packed;
 
+enum hv_intercept_type {
+	HV_INTERCEPT_TYPE_X64_IO_PORT			= 0X00000000,
+	HV_INTERCEPT_TYPE_X64_MSR			= 0X00000001,
+	HV_INTERCEPT_TYPE_X64_CPUID			= 0X00000002,
+	HV_INTERCEPT_TYPE_EXCEPTION			= 0X00000003,
+	HV_INTERCEPT_TYPE_REGISTER			= 0X00000004,
+	HV_INTERCEPT_TYPE_MMIO				= 0X00000005,
+	HV_INTERCEPT_TYPE_X64_GLOBAL_CPUID		= 0X00000006,
+	HV_INTERCEPT_TYPE_X64_APIC_SMI			= 0X00000007,
+	HV_INTERCEPT_TYPE_HYPERCALL			= 0X00000008,
+	HV_INTERCEPT_TYPE_X64_APIC_INIT_SIPI		= 0X00000009,
+	HV_INTERCEPT_MC_UPDATE_PATCH_LEVEL_MSR_READ	= 0X0000000A,
+	HV_INTERCEPT_TYPE_X64_APIC_WRITE		= 0X0000000B,
+	HV_INTERCEPT_TYPE_MAX,
+	HV_INTERCEPT_TYPE_INVALID			= 0XFFFFFFFF,
+};
+
+union hv_intercept_parameters {
+	__u64 as_uint64;
+
+	/* hv_intercept_type_x64_io_port */
+	__u16 io_port;
+
+	/* hv_intercept_type_x64_cpuid */
+	__u32 cpuid_index;
+
+	/* hv_intercept_type_x64_apic_write */
+	__u32 apic_write_mask;
+
+	/* hv_intercept_type_exception */
+	__u16 exception_vector;
+
+	/* N.B. Other intercept types do not have any parameters. */
+};
+
+/* Access types for the install intercept hypercall parameter */
+#define HV_INTERCEPT_ACCESS_MASK_NONE		0x00
+#define HV_INTERCEPT_ACCESS_MASK_READ		0X01
+#define HV_INTERCEPT_ACCESS_MASK_WRITE		0x02
+#define HV_INTERCEPT_ACCESS_MASK_EXECUTE	0x04
+
+
+
 #endif
diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
index 37dcd6c636a7..ec71b5a08a76 100644
--- a/drivers/hv/hv_call.c
+++ b/drivers/hv/hv_call.c
@@ -394,3 +394,41 @@ int hv_call_set_vp_registers(
 	return hv_status_to_errno(status);
 }
 
+int hv_call_install_intercept(
+		u64 partition_id,
+		u32 access_type,
+		enum hv_intercept_type intercept_type,
+		union hv_intercept_parameters intercept_parameter)
+{
+	struct hv_install_intercept *input;
+	unsigned long flags;
+	u64 status;
+	int ret;
+
+	do {
+		local_irq_save(flags);
+		input = (struct hv_install_intercept *)(*this_cpu_ptr(
+					hyperv_pcpu_input_arg));
+		input->partition_id = partition_id;
+		input->access_type = access_type;
+		input->intercept_type = intercept_type;
+		input->intercept_parameter = intercept_parameter;
+		status = hv_do_hypercall(
+				HVCALL_INSTALL_INTERCEPT, input, NULL);
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
+
+	} while (!ret);
+
+	return ret;
+}
+
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index 014352a11190..541c83a36767 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -64,5 +64,8 @@ int hv_call_set_vp_registers(
 		u64 partition_id,
 		u16 count,
 		struct hv_register_assoc *registers);
+int hv_call_install_intercept(u64 partition_id, u32 access_type,
+		enum hv_intercept_type intercept_type,
+		union hv_intercept_parameters intercept_parameter);
 
 #endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 46b39c8f1f55..34d213cf337f 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -567,6 +567,22 @@ mshv_partition_ioctl_unmap_memory(struct mshv_partition *partition,
 	return 0;
 }
 
+static long
+mshv_partition_ioctl_install_intercept(struct mshv_partition *partition,
+				       void __user *user_args)
+{
+	struct mshv_install_intercept args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return hv_call_install_intercept(
+			partition->id,
+			args.access_type_mask,
+			args.intercept_type,
+			args.intercept_parameter);
+}
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -589,6 +605,10 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		ret = mshv_partition_ioctl_create_vp(partition,
 							(void __user *)arg);
 		break;
+	case MSHV_INSTALL_INTERCEPT:
+		ret = mshv_partition_ioctl_install_intercept(partition,
+							(void __user *)arg);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index ace8fca88f66..4453ba4d3293 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -152,6 +152,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_WITHDRAW_MEMORY			0x0049
 #define HVCALL_MAP_GPA_PAGES			0x004b
 #define HVCALL_UNMAP_GPA_PAGES			0x004c
+#define HVCALL_INSTALL_INTERCEPT		0x004d
 #define HVCALL_CREATE_VP			0x004e
 #define HVCALL_GET_VP_REGISTERS			0x0050
 #define HVCALL_SET_VP_REGISTERS			0x0051
@@ -813,4 +814,11 @@ struct hv_unmap_gpa_pages {
 	u32 padding;
 } __packed;
 
+struct hv_install_intercept {
+	u64 partition_id;
+	u32 access_type; /* mask */
+	u32 intercept_type;
+	union hv_intercept_parameters intercept_parameter;
+} __packed;
+
 #endif
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 229abac9502f..8574a4e62715 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -41,6 +41,12 @@ struct mshv_vp_registers {
 	struct hv_register_assoc *regs;
 };
 
+struct mshv_install_intercept {
+	__u32 access_type_mask;
+	enum hv_intercept_type intercept_type;
+	union hv_intercept_parameters intercept_parameter;
+};
+
 #define MSHV_IOCTL 0xB8
 
 /* mshv device */
@@ -51,6 +57,7 @@ struct mshv_vp_registers {
 #define MSHV_MAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x02, struct mshv_user_mem_region)
 #define MSHV_UNMAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x03, struct mshv_user_mem_region)
 #define MSHV_CREATE_VP		_IOW(MSHV_IOCTL, 0x04, struct mshv_create_vp)
+#define MSHV_INSTALL_INTERCEPT	_IOW(MSHV_IOCTL, 0x08, struct mshv_install_intercept)
 
 /* vp device */
 #define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
-- 
2.23.4

