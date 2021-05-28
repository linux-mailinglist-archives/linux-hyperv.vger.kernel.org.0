Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540023948CC
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 May 2021 00:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhE1WpU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 May 2021 18:45:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55852 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhE1WpS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 May 2021 18:45:18 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id A705C20B8013;
        Fri, 28 May 2021 15:43:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A705C20B8013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622241822;
        bh=FhYvTcJrEBVFMZZAZzBE40oXRAsPuY30e6s35+0uRRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5mt49UoEJwrsuybTcXPW99p4xQ+gce3c2DIqOVf0sW/gvU5RxiImxPQYz2A7m67q
         +4vWBx0fxyNnPwWu3vbHDDul2kT0sIup9FE5RMefinTl8nzwBjYwGu+KJEvZIRn/DH
         Rltm6O9fm9pDIiDL1aFLF37VA2cm+4ME6Nb5Wuns=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com
Subject: [PATCH 06/19] drivers/hv: create, initialize, finalize, delete partition hypercalls
Date:   Fri, 28 May 2021 15:43:26 -0700
Message-Id: <1622241819-21155-7-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add hypercalls for fully setting up and mostly tearing down a guest
partition.
Export hv_call_deposit_memory and hv_call_create_vp.
The teardown operation will generate an error as the deposited
memory has not been withdrawn.
This is fixed in the next patch.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 arch/x86/hyperv/hv_proc.c               |   2 +
 arch/x86/include/uapi/asm/hyperv-tlfs.h |   6 +-
 drivers/hv/Makefile                     |   2 +-
 drivers/hv/hv_call.c                    | 129 ++++++++++++++++++++++++
 drivers/hv/mshv.h                       |  28 +++++
 drivers/hv/mshv_main.c                  |  34 ++++++-
 include/asm-generic/hyperv-tlfs.h       |  49 +++++++++
 7 files changed, 245 insertions(+), 5 deletions(-)
 create mode 100644 drivers/hv/hv_call.c
 create mode 100644 drivers/hv/mshv.h

diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 30951e778577..ec9b0c69603e 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -137,6 +137,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	kfree(counts);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 {
@@ -234,4 +235,5 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hv_call_create_vp);
 
diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
index 72150c25ffe6..8a5fc59bb33a 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -101,7 +101,7 @@ union hv_partition_processor_features {
 		__u64 fsrep_stosb:1;
 		__u64 fsrep_cmpsb:1;
 		__u64 reserved_bank1:42;
-	};
+	} __packed;
 	__u64 as_uint64[HV_PARTITION_PROCESSOR_FEATURE_BANKS];
 };
 
@@ -111,7 +111,7 @@ union hv_partition_processor_xsave_features {
 		__u64 xsaveopt_support : 1;
 		__u64 avx_support : 1;
 		__u64 reserved1 : 61;
-	};
+	} __packed;
 	__u64 as_uint64;
 };
 
@@ -119,6 +119,6 @@ struct hv_partition_creation_properties {
 	union hv_partition_processor_features disabled_processor_features;
 	union hv_partition_processor_xsave_features
 		disabled_processor_xsave_features;
-};
+} __packed;
 
 #endif
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index c943fbeb70e7..649748c9c144 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -13,4 +13,4 @@ hv_vmbus-y := vmbus_drv.o \
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
 
-mshv-y                          += mshv_main.o
+mshv-y                          += mshv_main.o hv_call.o
diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
new file mode 100644
index 000000000000..7d85f1bd959a
--- /dev/null
+++ b/drivers/hv/hv_call.c
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021, Microsoft Corporation.
+ *
+ * Authors:
+ *   Nuno Das Neves <nudasnev@microsoft.com>
+ *   Lillian Grassin-Drake <ligrassi@microsoft.com>
+ *   Vineeth Pillai <viremana@linux.microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <asm/mshyperv.h>
+
+#include "mshv.h"
+
+int hv_call_create_partition(
+		u64 flags,
+		struct hv_partition_creation_properties creation_properties,
+		u64 *partition_id)
+{
+	struct hv_create_partition_in *input;
+	struct hv_create_partition_out *output;
+	u64 status;
+	int ret;
+	unsigned long irq_flags;
+	int i;
+
+	do {
+		local_irq_save(irq_flags);
+		input = (struct hv_create_partition_in *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
+		output = (struct hv_create_partition_out *)(*this_cpu_ptr(
+			hyperv_pcpu_output_arg));
+
+		input->flags = flags;
+		input->proximity_domain_info.as_uint64 = 0;
+		input->compatibility_version = HV_COMPATIBILITY_20_H1;
+		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURE_BANKS; ++i)
+			input->partition_creation_properties
+				.disabled_processor_features.as_uint64[i] = 0;
+		input->partition_creation_properties
+			.disabled_processor_xsave_features.as_uint64 = 0;
+		input->isolation_properties.as_uint64 = 0;
+
+		status = hv_do_hypercall(HVCALL_CREATE_PARTITION,
+					 input, output);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (hv_result_success(status))
+				*partition_id = output->partition_id;
+			else
+				pr_err("%s: %s\n",
+				       __func__, hv_status_to_string(status));
+			local_irq_restore(irq_flags);
+			ret = hv_status_to_errno(status);
+			break;
+		}
+		local_irq_restore(irq_flags);
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    hv_current_partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_initialize_partition(u64 partition_id)
+{
+	struct hv_initialize_partition input;
+	u64 status;
+	int ret;
+
+	input.partition_id = partition_id;
+
+	ret = hv_call_deposit_pages(
+				NUMA_NO_NODE,
+				partition_id,
+				HV_INIT_PARTITION_DEPOSIT_PAGES);
+	if (ret)
+		return ret;
+
+	do {
+		status = hv_do_fast_hypercall8(
+				HVCALL_INITIALIZE_PARTITION,
+				*(u64*)&input);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (!hv_result_success(status))
+				pr_err("%s: %s\n",
+				       __func__, hv_status_to_string(status));
+			ret = hv_status_to_errno(status);
+			break;
+		}
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_finalize_partition(u64 partition_id)
+{
+	struct hv_finalize_partition input;
+	u64 status;
+
+	input.partition_id = partition_id;
+	status = hv_do_fast_hypercall8(
+			HVCALL_FINALIZE_PARTITION,
+			*(u64*)&input);
+
+	if (!hv_result_success(status))
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+
+	return hv_status_to_errno(status);
+}
+
+int hv_call_delete_partition(u64 partition_id)
+{
+	struct hv_delete_partition input;
+	u64 status;
+
+	input.partition_id = partition_id;
+	status = hv_do_fast_hypercall8(HVCALL_DELETE_PARTITION, *(u64*)&input);
+
+	if (!hv_result_success(status))
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+
+	return hv_status_to_errno(status);
+}
+
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
new file mode 100644
index 000000000000..46121bd30592
--- /dev/null
+++ b/drivers/hv/mshv.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021, Microsoft Corporation.
+ *
+ * Authors:
+ *   Nuno Das Neves <nudasnev@microsoft.com>
+ *   Lillian Grassin-Drake <ligrassi@microsoft.com>
+ *   Vineeth Pillai <viremana@linux.microsoft.com>
+ */
+
+#ifndef _MSHV_H_
+#define _MSHV_H_
+
+/* Determined empirically */
+#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
+
+/*
+ * Hyper-V hypercalls
+ */
+int hv_call_create_partition(
+		u64 flags,
+		struct hv_partition_creation_properties creation_properties,
+		u64 *partition_id);
+int hv_call_initialize_partition(u64 partition_id);
+int hv_call_finalize_partition(u64 partition_id);
+int hv_call_delete_partition(u64 partition_id);
+
+#endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 067b6373402b..c32618357da8 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -15,6 +15,9 @@
 #include <linux/file.h>
 #include <linux/anon_inodes.h>
 #include <linux/mshv.h>
+#include <asm/mshyperv.h>
+
+#include "mshv.h"
 
 MODULE_AUTHOR("Microsoft");
 MODULE_LICENSE("GPL");
@@ -49,6 +52,7 @@ static struct miscdevice mshv_dev = {
 	.mode = 600,
 };
 
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -78,6 +82,17 @@ destroy_partition(struct mshv_partition *partition)
 
 	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
 
+	/*
+	 * There are no remaining references to the partition,
+	 * so the remaining cleanup can be lockless
+	 */
+
+	/* Deallocates and unmaps everything including vcpus, GPA mappings etc */
+	hv_call_finalize_partition(partition->id);
+	/* TODO: Withdraw and free all pages we deposited */
+
+	hv_call_delete_partition(partition->id);
+
 	kfree(partition);
 }
 
@@ -138,6 +153,9 @@ mshv_ioctl_create_partition(void __user *user_arg)
 	if (copy_from_user(&args, user_arg, sizeof(args)))
 		return -EFAULT;
 
+	/* Only support EXO partitions */
+	args.flags |= HV_PARTITION_CREATION_FLAG_EXO_PARTITION;
+
 	partition = kzalloc(sizeof(*partition), GFP_KERNEL);
 	if (!partition)
 		return -ENOMEM;
@@ -148,11 +166,21 @@ mshv_ioctl_create_partition(void __user *user_arg)
 		goto free_partition;
 	}
 
+	ret = hv_call_create_partition(args.flags,
+				       args.partition_creation_properties,
+				       &partition->id);
+	if (ret)
+		goto put_fd;
+
+	ret = hv_call_initialize_partition(partition->id);
+	if (ret)
+		goto delete_partition;
+
 	file = anon_inode_getfile("mshv_partition", &mshv_partition_fops,
 				  partition, O_RDWR);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
-		goto put_fd;
+		goto finalize_partition;
 	}
 	refcount_set(&partition->ref_count, 1);
 
@@ -166,6 +194,10 @@ mshv_ioctl_create_partition(void __user *user_arg)
 
 release_file:
 	file->f_op->release(file->f_inode, file);
+finalize_partition:
+	hv_call_finalize_partition(partition->id);
+delete_partition:
+	hv_call_delete_partition(partition->id);
 put_fd:
 	put_unused_fd(fd);
 free_partition:
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 50dc6eafb6a6..49099b7e0f71 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -143,6 +143,10 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
 #define HVCALL_SEND_IPI_EX			0x0015
+#define HVCALL_CREATE_PARTITION			0x0040
+#define HVCALL_INITIALIZE_PARTITION		0x0041
+#define HVCALL_FINALIZE_PARTITION		0x0042
+#define HVCALL_DELETE_PARTITION			0x0043
 #define HVCALL_GET_PARTITION_ID			0x0046
 #define HVCALL_DEPOSIT_MEMORY			0x0048
 #define HVCALL_CREATE_VP			0x004e
@@ -826,4 +830,49 @@ struct hv_memory_hint {
 	union hv_gpa_page_range ranges[];
 } __packed;
 
+union hv_partition_isolation_properties {
+	u64 as_uint64;
+	struct {
+		u64 isolation_type: 5;
+		u64 rsvd_z: 7;
+		u64 shared_gpa_boundary_page_number: 52;
+	};
+} __packed;
+
+/* Non-userspace-visible partition creation flags */
+#define HV_PARTITION_CREATION_FLAG_EXO_PARTITION                    BIT(8)
+
+#define HV_MAKE_COMPATIBILITY_VERSION(major_, minor_)	\
+	((u32)((major_) << 8 | (minor_)))
+
+#define HV_COMPATIBILITY_19_H1		HV_MAKE_COMPATIBILITY_VERSION(0X6, 0X5)
+#define HV_COMPATIBILITY_20_H1		HV_MAKE_COMPATIBILITY_VERSION(0X6, 0X7)
+#define HV_COMPATIBILITY_PRERELEASE	HV_MAKE_COMPATIBILITY_VERSION(0XFE, 0X0)
+#define HV_COMPATIBILITY_EXPERIMENT	HV_MAKE_COMPATIBILITY_VERSION(0XFF, 0X0)
+
+struct hv_create_partition_in {
+	u64 flags;
+	union hv_proximity_domain_info proximity_domain_info;
+	u32 compatibility_version;
+	u32 padding;
+	struct hv_partition_creation_properties partition_creation_properties;
+	union hv_partition_isolation_properties isolation_properties;
+} __packed;
+
+struct hv_create_partition_out {
+	u64 partition_id;
+} __packed;
+
+struct hv_initialize_partition {
+	u64 partition_id;
+} __packed;
+
+struct hv_finalize_partition {
+	u64 partition_id;
+} __packed;
+
+struct hv_delete_partition {
+	u64 partition_id;
+} __packed;
+
 #endif
-- 
2.25.1

