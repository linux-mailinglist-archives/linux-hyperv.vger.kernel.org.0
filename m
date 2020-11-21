Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867822BBAFF
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgKUAba (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:31:30 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51220 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgKUAav (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:51 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 68B9220B717A;
        Fri, 20 Nov 2020 16:30:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68B9220B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918650;
        bh=U9h0Km35sBKxmZuE6RxA7gUge5mdqa26rFIcXsherRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCF5MzAAaWJ4UCEJZr8ivPUKFkh8oXLXSk7JJFXlDo7wjIOlIWmYUNN1c1lK9g+cV
         pplUaY/8RDwlRhQjRw9eXz+1vI2PO9EeYF4KYDyOpF5xa+kCEotq+EqUWMEk07L6Pl
         9HHhhZovDHSivOj85e78BZWlAPbtTmVVR+ix8Brw=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 13/18] virt/mshv: install intercept ioctl
Date:   Fri, 20 Nov 2020 16:30:32 -0800
Message-Id: <1605918637-12192-14-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce ioctl for configuring intercept messages from a guest partition.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst         |  9 +++++
 arch/x86/include/uapi/asm/hyperv-tlfs.h | 43 ++++++++++++++++++++++
 include/asm-generic/hyperv-tlfs.h       |  8 ++++
 include/uapi/linux/mshv.h               |  7 ++++
 virt/mshv/mshv_main.c                   | 49 ++++++++++++++++++++++++-
 5 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index f525c81f2bdd..95ec77dc73f0 100644
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
index c6a27053f791..28917301b6df 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -986,4 +986,47 @@ struct hv_x64_apic_eoi_message {
 	__u32 interrupt_vector;
 };
 
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
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index e0185c3872a9..93571bbab3a6 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -151,6 +151,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_WITHDRAW_MEMORY			0x0049
 #define HVCALL_MAP_GPA_PAGES			0x004b
 #define HVCALL_UNMAP_GPA_PAGES			0x004c
+#define HVCALL_INSTALL_INTERCEPT		0x004d
 #define HVCALL_CREATE_VP			0x004e
 #define HVCALL_GET_VP_REGISTERS			0x0050
 #define HVCALL_SET_VP_REGISTERS			0x0051
@@ -777,4 +778,11 @@ struct hv_unmap_gpa_pages {
 	u32 unmap_flags;
 };
 
+struct hv_install_intercept {
+	u64 partition_id;
+	u32 access_type; /* mask */
+	enum hv_intercept_type intercept_type;
+	union hv_intercept_parameters intercept_parameter;
+};
+
 #endif
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 5be9e2d23893..e784b2d1a3fd 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -41,6 +41,12 @@ struct mshv_vp_registers {
 	union hv_register_value *values;
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
diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
index 7ddb66d260ce..8392d5a45e04 100644
--- a/virt/mshv/mshv_main.c
+++ b/virt/mshv/mshv_main.c
@@ -1148,7 +1148,50 @@ mshv_partition_ioctl_unmap_memory(struct mshv_partition *partition,
 }
 
 static long
-mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+mshv_partition_ioctl_install_intercept(struct mshv_partition *partition,
+				       void __user *user_args)
+{
+	struct mshv_install_intercept args;
+	struct hv_install_intercept *input;
+	unsigned long flags;
+	int status;
+	int ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	do {
+		local_irq_save(flags);
+		input = (struct hv_install_intercept *)(*this_cpu_ptr(
+					hyperv_pcpu_input_arg));
+		input->partition_id = partition->id;
+		input->access_type = args.access_type_mask;
+		input->intercept_type = args.intercept_type;
+		input->intercept_parameter = args.intercept_parameter;
+		status = hv_do_hypercall(
+				HVCALL_INSTALL_INTERCEPT, input, NULL) &
+					HV_HYPERCALL_RESULT_MASK;
+
+		local_irq_restore(flags);
+		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (status != HV_STATUS_SUCCESS) {
+				pr_err("%s: %s\n", __func__,
+				       hv_status_to_string(status));
+			}
+			ret = -hv_status_to_errno(status);
+			break;
+		}
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->id, 1);
+
+	} while (!ret);
+
+	return ret;
+}
+
+static long
+mshv_partition_ioctl(struct file *filp, unsigned int ioctl,
+		     unsigned long arg)
 {
 	struct mshv_partition *partition = filp->private_data;
 	long ret;
@@ -1169,6 +1212,10 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
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
-- 
2.25.1

