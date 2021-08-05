Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C50E3E1DE5
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 23:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhHEVY4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 17:24:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46546 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbhHEVYt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 17:24:49 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5B5E520BE661;
        Thu,  5 Aug 2021 14:24:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B5E520BE661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628198674;
        bh=RFtA0XpBh8LNz/BXtdNgDlUtX2iPhbZUZ0EJfqOEQrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6s4KOQAdZVjleIkx27B8ciU4iIevE/Ix7qee5mg9W4iMQiHix87wR2TjgeV14/eX
         s+3YhQQBfiaZBNceMgr86ls0lITNuHd0r3jvvw681tLmv7ZOl5WXnEIu26ml3bWMa/
         dGvHTaGKWZCj/JPuhSiGbivsIZ6xeobS7QQQehUs=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH 17/19] drivers/hv: get and set partition property ioctls
Date:   Thu,  5 Aug 2021 14:23:59 -0700
Message-Id: <1628198641-791-18-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce ioctls for getting and setting properties of guest partitions.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst        |  8 ++++
 drivers/hv/hv_call.c                   | 58 +++++++++++++++++++++++++
 drivers/hv/mshv.h                      |  8 ++++
 drivers/hv/mshv_main.c                 | 47 ++++++++++++++++++++
 include/asm-generic/hyperv-tlfs.h      | 19 +++++++++
 include/uapi/asm-generic/hyperv-tlfs.h | 59 ++++++++++++++++++++++++++
 include/uapi/linux/mshv.h              |  9 ++++
 7 files changed, 208 insertions(+)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index bf3c060bd418..e660e0e6865e 100644
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
 
diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
index eb98183ce8ef..776095de9679 100644
--- a/drivers/hv/hv_call.c
+++ b/drivers/hv/hv_call.c
@@ -638,3 +638,61 @@ int hv_call_map_vp_state_page(
 
 	return ret;
 }
+
+int hv_call_get_partition_property(
+		u64 partition_id,
+		u64 property_code,
+		u64 *property_value)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_get_partition_property_in *input;
+	struct hv_get_partition_property_out *output;
+
+	local_irq_save(flags);
+	input = (struct hv_get_partition_property_in *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
+	output = (struct hv_get_partition_property_out *)(*this_cpu_ptr(
+			hyperv_pcpu_output_arg));
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->property_code = property_code;
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_PROPERTY, input,
+			output);
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
+int hv_call_set_partition_property(
+		u64 partition_id,
+		u64 property_code,
+		u64 property_value)
+{
+	u64 status;
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
+	status = hv_do_hypercall(HVCALL_SET_PARTITION_PROPERTY, input, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+
+	return hv_status_to_errno(status);
+}
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index a9215581be6b..8230368b4257 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -101,5 +101,13 @@ int hv_call_map_vp_state_page(
 		u32 vp_index,
 		u64 partition_id,
 		struct page **state_page);
+int hv_call_get_partition_property(
+		u64 partition_id,
+		u64 property_code,
+		u64 *property_value);
+int hv_call_set_partition_property(
+		u64 partition_id,
+		u64 property_code,
+		u64 property_value);
 
 #endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 1495ac2fd90b..d522f8a26a19 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -576,6 +576,45 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	return ret;
 }
 
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
+	ret = hv_call_get_partition_property(
+					partition->id,
+					args.property_code,
+					&args.property_value);
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
+mshv_partition_ioctl_set_property(struct mshv_partition *partition,
+				  void __user *user_args)
+{
+	struct mshv_partition_property args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return hv_call_set_partition_property(
+			partition->id,
+			args.property_code,
+			args.property_value);
+}
+
 static long
 mshv_partition_ioctl_map_memory(struct mshv_partition *partition,
 				struct mshv_user_mem_region __user *user_mem)
@@ -795,6 +834,14 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
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
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index f8f44008c013..2c0dfd0b8763 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -147,6 +147,8 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_INITIALIZE_PARTITION		0x0041
 #define HVCALL_FINALIZE_PARTITION		0x0042
 #define HVCALL_DELETE_PARTITION			0x0043
+#define HVCALL_GET_PARTITION_PROPERTY		0x0044
+#define HVCALL_SET_PARTITION_PROPERTY		0x0045
 #define HVCALL_GET_PARTITION_ID			0x0046
 #define HVCALL_DEPOSIT_MEMORY			0x0048
 #define HVCALL_WITHDRAW_MEMORY			0x0049
@@ -882,4 +884,21 @@ struct hv_map_vp_state_page_out {
 	u64 map_location; /* page number */
 } __packed;
 
+struct hv_get_partition_property_in {
+	u64 partition_id;
+	u32 property_code; /* enum hv_partition_property_code */
+	u32 padding;
+} __packed;
+
+struct hv_get_partition_property_out {
+	u64 property_value;
+} __packed;
+
+struct hv_set_partition_property {
+	u64 partition_id;
+	u32 property_code; /* enum hv_partition_property_code */
+	u32 padding;
+	u64 property_value;
+} __packed;
+
 #endif
diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
index a1bc77e463dd..1e572d38234a 100644
--- a/include/uapi/asm-generic/hyperv-tlfs.h
+++ b/include/uapi/asm-generic/hyperv-tlfs.h
@@ -136,4 +136,63 @@ enum hv_vp_state_page_type {
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
index 718a3617e1f1..1a6c22db4978 100644
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
-- 
2.23.4

