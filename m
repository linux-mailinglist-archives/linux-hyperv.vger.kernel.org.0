Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EFE2BBAF4
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgKUAbL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:31:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51282 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgKUAaw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:52 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id BF76F20B8012;
        Fri, 20 Nov 2020 16:30:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF76F20B8012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918650;
        bh=NcrH7CwavrK7WmwsR/alvLCXOgZY4cpUXeIXxp9dP/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtFgrgWIZHggHml8naTMH4xyILS+IUy+/2u6QZg1xeERTN7k/e6FLpP9bm9dXnB+m
         q9DBPcdL4hK52ORwsMO0STNeTNSqMdBMDYYm3ctHdEopgMD68JcLH/WlqahD5cYwPm
         QZHWfYm1TzgOIlVYLnSnAVuZGJ+ZtFJlUGsMnI+M=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 17/18] virt/mshv: get and set partition property ioctls
Date:   Fri, 20 Nov 2020 16:30:36 -0800
Message-Id: <1605918637-12192-18-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce ioctls for getting and setting properties of guest partitions.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst        |  8 +++
 include/asm-generic/hyperv-tlfs.h      | 17 ++++++
 include/uapi/asm-generic/hyperv-tlfs.h | 59 ++++++++++++++++++++
 include/uapi/linux/mshv.h              |  9 +++
 virt/mshv/mshv_main.c                  | 76 ++++++++++++++++++++++++++
 5 files changed, 169 insertions(+)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index 89c276a8778f..609400313b7e 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -159,4 +159,12 @@ Maps a page into userspace that can be used to get and set common registers
 while the vp is suspended.
 The page is laid out in struct hv_vp_register_page in asm/hyperv-tlfs.h.
 
+3.11 MSHV_SET_PARTITION_PROPERTY and MSHV_GET_PARTITION_PROPERTY
+----------------------------------------------------------------
+:Type: partition ioctl
+:Parameters: struct mshv_partition_property
+:Returns: 0 on success
+
+Can be used to get/set various properties of a partition.
+
 
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 9eed4b869110..f3998027f6a3 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -146,6 +146,8 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_INITIALIZE_PARTITION		0x0041
 #define HVCALL_FINALIZE_PARTITION		0x0042
 #define HVCALL_DELETE_PARTITION			0x0043
+#define HVCALL_GET_PARTITION_PROPERTY		0x0044
+#define HVCALL_SET_PARTITION_PROPERTY		0x0045
 #define HVCALL_GET_PARTITION_ID			0x0046
 #define HVCALL_DEPOSIT_MEMORY			0x0048
 #define HVCALL_WITHDRAW_MEMORY			0x0049
@@ -847,4 +849,19 @@ struct hv_map_vp_state_page_out {
 	u64 map_location; /* page number */
 };
 
+struct hv_get_partition_property_in {
+	u64 partition_id;
+	enum hv_partition_property_code property_code;
+};
+
+struct hv_get_partition_property_out {
+	u64 property_value;
+};
+
+struct hv_set_partition_property {
+	u64 partition_id;
+	enum hv_partition_property_code property_code;
+	u64 property_value;
+};
+
 #endif
diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
index a747f39b132a..d1c341de34fe 100644
--- a/include/uapi/asm-generic/hyperv-tlfs.h
+++ b/include/uapi/asm-generic/hyperv-tlfs.h
@@ -97,4 +97,63 @@ enum hv_vp_state_page_type {
 	HV_VP_STATE_PAGE_COUNT
 };
 
+enum hv_partition_property_code {
+	/* Privilege properties */
+	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS				= 0x00010000,
+
+	/* Scheduling properties */
+	HV_PARTITION_PROPERTY_SUSPEND					= 0x00020000,
+	HV_PARTITION_PROPERTY_CPU_RESERVE				= 0x00020001,
+	HV_PARTITION_PROPERTY_CPU_CAP					= 0x00020002,
+	HV_PARTITION_PROPERTY_CPU_WEIGHT				= 0x00020003,
+	HV_PARTITION_PROPERTY_CPU_GROUP_ID				= 0x00020004,
+
+	/* Time properties */
+	HV_PARTITION_PROPERTY_TIME_FREEZE				= 0x00030003,
+
+	/* Debugging properties */
+	HV_PARTITION_PROPERTY_DEBUG_CHANNEL_ID				= 0x00040000,
+
+	/* Resource properties */
+	HV_PARTITION_PROPERTY_VIRTUAL_TLB_PAGE_COUNT			= 0x00050000,
+	HV_PARTITION_PROPERTY_VSM_CONFIG				= 0x00050001,
+	HV_PARTITION_PROPERTY_ZERO_MEMORY_ON_RESET			= 0x00050002,
+	HV_PARTITION_PROPERTY_PROCESSORS_PER_SOCKET			= 0x00050003,
+	HV_PARTITION_PROPERTY_NESTED_TLB_SIZE				= 0x00050004,
+	HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING			= 0x00050005,
+	HV_PARTITION_PROPERTY_VSM_PERMISSIONS_DIRTY_SINCE_LAST_QUERY	= 0x00050006,
+	HV_PARTITION_PROPERTY_SGX_LAUNCH_CONTROL_CONFIG			= 0x00050007,
+	HV_PARTITION_PROPERTY_DEFAULT_SGX_LAUNCH_CONTROL0		= 0x00050008,
+	HV_PARTITION_PROPERTY_DEFAULT_SGX_LAUNCH_CONTROL1		= 0x00050009,
+	HV_PARTITION_PROPERTY_DEFAULT_SGX_LAUNCH_CONTROL2		= 0x0005000a,
+	HV_PARTITION_PROPERTY_DEFAULT_SGX_LAUNCH_CONTROL3		= 0x0005000b,
+	HV_PARTITION_PROPERTY_ISOLATION_STATE				= 0x0005000c,
+	HV_PARTITION_PROPERTY_ISOLATION_CONTROL				= 0x0005000d,
+	HV_PARTITION_PROPERTY_RDT_L3_COS_INDEX				= 0x0005000e,
+	HV_PARTITION_PROPERTY_RDT_RMID					= 0x0005000f,
+	HV_PARTITION_PROPERTY_IMPLEMENTED_PHYSICAL_ADDRESS_BITS		= 0x00050010,
+	HV_PARTITION_PROPERTY_NON_ARCHITECTURAL_CORE_SHARING		= 0x00050011,
+	HV_PARTITION_PROPERTY_HYPERCALL_DOORBELL_PAGE			= 0x00050012,
+
+	/* Compatibility properties */
+	HV_PARTITION_PROPERTY_PROCESSOR_VENDOR				= 0x00060000,
+	HV_PARTITION_PROPERTY_PROCESSOR_FEATURES_DEPRECATED		= 0x00060001,
+	HV_PARTITION_PROPERTY_PROCESSOR_XSAVE_FEATURES			= 0x00060002,
+	HV_PARTITION_PROPERTY_PROCESSOR_CL_FLUSH_SIZE			= 0x00060003,
+	HV_PARTITION_PROPERTY_ENLIGHTENMENT_MODIFICATIONS		= 0x00060004,
+	HV_PARTITION_PROPERTY_COMPATIBILITY_VERSION			= 0x00060005,
+	HV_PARTITION_PROPERTY_PHYSICAL_ADDRESS_WIDTH			= 0x00060006,
+	HV_PARTITION_PROPERTY_XSAVE_STATES				= 0x00060007,
+	HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE			= 0x00060008,
+	HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY			= 0x00060009,
+	HV_PARTITION_PROPERTY_PROCESSOR_FEATURES0			= 0x0006000a,
+	HV_PARTITION_PROPERTY_PROCESSOR_FEATURES1			= 0x0006000b,
+
+	/* Guest software properties */
+	HV_PARTITION_PROPERTY_GUEST_OS_ID				= 0x00070000,
+
+	/* Nested virtualization properties */
+	HV_PARTITION_PROPERTY_PROCESSOR_VIRTUALIZATION_FEATURES		= 0x00080000,
+};
+
 #endif
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 8537ff29aee5..721f5b1999d5 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -66,6 +66,11 @@ struct mshv_vp_state {
 	} buf;
 };
 
+struct mshv_partition_property {
+	enum hv_partition_property_code property_code;
+	__u64 property_value;
+};
+
 #define MSHV_IOCTL 0xB8
 
 /* mshv device */
@@ -78,6 +83,10 @@ struct mshv_vp_state {
 #define MSHV_CREATE_VP		_IOW(MSHV_IOCTL, 0x04, struct mshv_create_vp)
 #define MSHV_INSTALL_INTERCEPT	_IOW(MSHV_IOCTL, 0x08, struct mshv_install_intercept)
 #define MSHV_ASSERT_INTERRUPT	_IOW(MSHV_IOCTL, 0x09, struct mshv_assert_interrupt)
+#define MSHV_SET_PARTITION_PROPERTY \
+				_IOW(MSHV_IOCTL, 0xC, struct mshv_partition_property)
+#define MSHV_GET_PARTITION_PROPERTY \
+				_IOWR(MSHV_IOCTL, 0xD, struct mshv_partition_property)
 
 /* vp device */
 #define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
index a597254fa4f4..bfbadeb4f1fe 100644
--- a/virt/mshv/mshv_main.c
+++ b/virt/mshv/mshv_main.c
@@ -1331,6 +1331,74 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	return ret;
 }
 
+static long
+mshv_partition_ioctl_get_property(struct mshv_partition *partition,
+				  void __user *user_args)
+{
+	struct mshv_partition_property args;
+	int status;
+	unsigned long flags;
+	struct hv_get_partition_property_in *input;
+	struct hv_get_partition_property_out *output;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	local_irq_save(flags);
+	input = (struct hv_get_partition_property_in *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
+	output = (struct hv_get_partition_property_out *)(*this_cpu_ptr(
+			hyperv_pcpu_output_arg));
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition->id;
+	input->property_code = args.property_code;
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_PROPERTY, input,
+			output) & HV_HYPERCALL_RESULT_MASK;
+	args.property_value = output->property_value;
+	local_irq_restore(flags);
+
+	if (status != HV_STATUS_SUCCESS) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return -hv_status_to_errno(status);
+	}
+
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+mshv_partition_ioctl_set_property(struct mshv_partition *partition,
+				  void __user *user_args)
+{
+	struct mshv_partition_property args;
+	int status;
+	unsigned long flags;
+	struct hv_set_partition_property *input;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	local_irq_save(flags);
+	input = (struct hv_set_partition_property *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition->id;
+	input->property_code = args.property_code;
+	input->property_value = args.property_value;
+	status = hv_do_hypercall(HVCALL_SET_PARTITION_PROPERTY, input,
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
 mshv_partition_ioctl_map_memory(struct mshv_partition *partition,
 				struct mshv_user_mem_region __user *user_mem)
@@ -1596,6 +1664,14 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl,
 		ret = mshv_partition_ioctl_assert_interrupt(partition,
 							(void __user *)arg);
 		break;
+	case MSHV_GET_PARTITION_PROPERTY:
+		ret = mshv_partition_ioctl_get_property(partition,
+							(void __user *)arg);
+		break;
+	case MSHV_SET_PARTITION_PROPERTY:
+		ret = mshv_partition_ioctl_set_property(partition,
+							(void __user *)arg);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
-- 
2.25.1

