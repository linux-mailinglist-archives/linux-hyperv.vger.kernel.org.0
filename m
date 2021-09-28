Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73B41B64D
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Sep 2021 20:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242366AbhI1SdN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Sep 2021 14:33:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50876 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbhI1SdC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Sep 2021 14:33:02 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 754DF20B4848;
        Tue, 28 Sep 2021 11:31:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 754DF20B4848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632853882;
        bh=zKovBa81qifiHRYZF45MAPlI611FkkRyiRt+nL6hV3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9XbynYM2kznb8STnpBFEggWLXJ3NMEO3xeqT5hQi2vI+erQjrZ/3OA1UCbsiAgEF
         PGiNn+xIWK4BusWVFtMdGrC3WpBoO+PqYExzWzunE3AGwGYxVVTCLTfE3yl971xLf9
         9L2eLI4qq67vPlgtAWmAW4dq/sjd6/JxAwPxvjWM=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH v3 19/19] drivers/hv: Translate GVA to GPA
Date:   Tue, 28 Sep 2021 11:31:15 -0700
Message-Id: <1632853875-20261-20-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org>

Introduce ioctl for translating Guest Virtual Address (GVA) to Guest
Physical Address (GPA)

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/hv_call.c                   | 44 ++++++++++++++++++++++++++
 drivers/hv/mshv.h                      |  7 ++++
 drivers/hv/mshv_main.c                 | 34 ++++++++++++++++++++
 include/asm-generic/hyperv-tlfs.h      | 14 ++++++++
 include/uapi/asm-generic/hyperv-tlfs.h | 43 +++++++++++++++++++++++++
 include/uapi/linux/mshv.h              |  8 +++++
 6 files changed, 150 insertions(+)

diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
index 776095de9679..0900e7377826 100644
--- a/drivers/hv/hv_call.c
+++ b/drivers/hv/hv_call.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/hyperv.h>
 #include <asm/mshyperv.h>
 
 #include "mshv.h"
@@ -696,3 +697,46 @@ int hv_call_set_partition_property(
 
 	return hv_status_to_errno(status);
 }
+
+int hv_call_translate_virtual_address(
+		u32 vp_index,
+		u64 partition_id,
+		u64 flags,
+		u64 gva,
+		u64 *gpa,
+		union hv_translate_gva_result *result)
+{
+	u64 status;
+	unsigned long irq_flags;
+	struct hv_translate_virtual_address_in *input;
+	struct hv_translate_virtual_address_out *output;
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
+	*gpa = (output->gpa_page << HV_HYP_PAGE_SHIFT) + offset_in_hvpage(gva);
+
+out:
+	local_irq_restore(irq_flags);
+
+	return hv_status_to_errno(status);
+}
+
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index 8230368b4257..1a8c94edb9c5 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -109,5 +109,12 @@ int hv_call_set_partition_property(
 		u64 partition_id,
 		u64 property_code,
 		u64 property_value);
+int hv_call_translate_virtual_address(
+		u32 vp_index,
+		u64 partition_id,
+		u64 flags,
+		u64 gva,
+		u64 *gpa,
+		union hv_translate_gva_result *result);
 
 #endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 766ba7d5d168..26426d03d521 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -411,6 +411,37 @@ mshv_vp_ioctl_get_set_state(struct mshv_vp *vp, void __user *user_args, bool is_
 	return 0;
 }
 
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
+	ret = hv_call_translate_virtual_address(
+			vp->index,
+			vp->partition->id,
+			args.flags,
+			args.gva,
+			&gpa,
+			&result);
+
+	if (ret)
+		return ret;
+
+	if (copy_to_user(args.result, &result, sizeof(*args.result)))
+		return -EFAULT;
+
+	if (copy_to_user(args.gpa, &gpa, sizeof(*args.gpa)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long
 mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -436,6 +467,9 @@ mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case MSHV_SET_VP_STATE:
 		r = mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, true);
 		break;
+	case MSHV_TRANSLATE_GVA:
+		r = mshv_vp_ioctl_translate_gva(vp, (void __user *)arg);
+		break;
 	default:
 		r = -ENOTTY;
 		break;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 2c0dfd0b8763..2e520e7d765d 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -158,6 +158,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_CREATE_VP			0x004e
 #define HVCALL_GET_VP_REGISTERS			0x0050
 #define HVCALL_SET_VP_REGISTERS			0x0051
+#define HVCALL_TRANSLATE_VIRTUAL_ADDRESS	0x0052
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
 #define HVCALL_POST_DEBUG_DATA			0x0069
@@ -901,4 +902,17 @@ struct hv_set_partition_property {
 	u64 property_value;
 } __packed;
 
+struct hv_translate_virtual_address_in {
+	u64 partition_id;
+	u32 vp_index;
+	u32 padding;
+	u64 control_flags;
+	u64 gva_page;
+} __packed;
+
+struct hv_translate_virtual_address_out {
+	union hv_translate_gva_result translation_result;
+	u64 gpa_page;
+} __packed;
+
 #endif
diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
index 5d8d5e89f432..95020e3a67ba 100644
--- a/include/uapi/asm-generic/hyperv-tlfs.h
+++ b/include/uapi/asm-generic/hyperv-tlfs.h
@@ -196,4 +196,47 @@ enum hv_partition_property_code {
 	HV_PARTITION_PROPERTY_PROCESSOR_VIRTUALIZATION_FEATURES		= 0x00080000,
 };
 
+enum hv_translate_gva_result_code {
+	HV_TRANSLATE_GVA_SUCCESS			= 0,
+
+	/* Translation failures. */
+	HV_TRANSLATE_GVA_PAGE_NOT_PRESENT		= 1,
+	HV_TRANSLATE_GVA_PRIVILEGE_VIOLATION		= 2,
+	HV_TRANSLATE_GVA_INVALIDE_PAGE_TABLE_FLAGS	= 3,
+
+	/* GPA access failures. */
+	HV_TRANSLATE_GVA_GPA_UNMAPPED			= 4,
+	HV_TRANSLATE_GVA_GPA_NO_READ_ACCESS		= 5,
+	HV_TRANSLATE_GVA_GPA_NO_WRITE_ACCESS		= 6,
+	HV_TRANSLATE_GVA_GPA_ILLEGAL_OVERLAY_ACCESS	= 7,
+
+	/*
+	 * Intercept for memory access by either
+	 *  - a higher VTL
+	 *  - a nested hypervisor (due to a violation of the nested page table)
+	 */
+	HV_TRANSLATE_GVA_INTERCEPT			= 8,
+
+	HV_TRANSLATE_GVA_GPA_UNACCEPTED			= 9,
+};
+
+union hv_translate_gva_result {
+	__u64 as_uint64;
+	struct {
+		__u32 result_code; /* enum hv_translate_hva_result_code */
+		__u32 cache_type : 8;
+		__u32 overlay_page : 1;
+		__u32 reserved : 23;
+	} __packed;
+};
+
+/* hv_translage_gva flags */
+#define HV_TRANSLATE_GVA_VALIDATE_READ		0x0001
+#define HV_TRANSLATE_GVA_VALIDATE_WRITE		0x0002
+#define HV_TRANSLATE_GVA_VALIDATE_EXECUTE	0x0004
+#define HV_TRANSLATE_GVA_PRIVILEGE_EXCEMP	0x0008
+#define HV_TRANSLATE_GVA_SET_PAGE_TABLE_BITS	0x0010
+#define HV_TRANSLATE_GVA_TLB_FLUSH_INHIBIT	0x0020
+#define HV_TRANSLATE_GVA_CONTROL_MASK		0x003f
+
 #endif
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index ec8281712430..0c46ce77cbb3 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -72,6 +72,13 @@ struct mshv_partition_property {
 	__u64 property_value;
 };
 
+struct mshv_translate_gva {
+	__u64 gva;
+	__u64 flags;
+	union hv_translate_gva_result *result;
+	__u64 *gpa;
+};
+
 #define MSHV_IOCTL 0xB8
 
 /* mshv device */
@@ -95,6 +102,7 @@ struct mshv_partition_property {
 #define MSHV_RUN_VP		_IOR(MSHV_IOCTL, 0x07, struct hv_message)
 #define MSHV_GET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0A, struct mshv_vp_state)
 #define MSHV_SET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0B, struct mshv_vp_state)
+#define MSHV_TRANSLATE_GVA	_IOWR(MSHV_IOCTL, 0x0E, struct mshv_translate_gva)
 
 /* register page mapping example:
  * struct hv_vp_register_page *regs = mmap(NULL,
-- 
2.23.4

