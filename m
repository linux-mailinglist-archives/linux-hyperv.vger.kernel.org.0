Return-Path: <linux-hyperv+bounces-7404-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC2DC33196
	for <lists+linux-hyperv@lfdr.de>; Tue, 04 Nov 2025 22:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F25354E133A
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Nov 2025 21:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AB2346771;
	Tue,  4 Nov 2025 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZPGfGYbn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EAB2BDC29;
	Tue,  4 Nov 2025 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762292849; cv=none; b=ZTsYjMd/PCfOV7EG6TXc1USmDcKIFFETU+5LgFmSF34O6vz6DCKjv5MswvnkzWkOT6/V6mzQcjsGi54s77Vi6yJEAY+NZqLa99rOGG+BExknpQmRNYoiCPOdoGjzoTegPvdklnog0IowkLI3KfQSARFdHuQ2dy0TGwkCnzMG3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762292849; c=relaxed/simple;
	bh=C/V75WKhFtUr5X5/hqDoOWxq9rYkvuscW8zpVGnzBJo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JlbrKAcaKSwHfPGfTIUHnZs4sDYdoIuJu0zNqlUp7fC8XREuXHu1rFRq2w8ZiHYzlrsjzqvdHgiycgV8LbRjRZQi0uVwvDzF0MW+KKvHGLJEOT1ex5hV91TJtUtjopMTQutk7DmC1maSWRoO6Rf9PMDjCgG64iedLrdrt+bTMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZPGfGYbn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 7FF28201209B; Tue,  4 Nov 2025 13:47:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7FF28201209B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762292847;
	bh=w3/mCW/Nl+xm2f0lhZZvppea6WsEHRH9j7+3VnfnSX8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZPGfGYbnFyA0L9mOON/PZQXfn/W2bWM3bsT16a8JD3wdmsDLczsxiXgGp2kHr/Tv9
	 bt2V4+EPInF912zxQj3h16ZlLn4rEUlZ+L8/02jrNyAAGDTq97fgpsL/x3TW8/xQnz
	 MvxktwCYxgpmIx9hsc1kPu4mtTcszaeIjDIoviHY=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wei.liu@kernel.org,
	muislam@microsoft.com,
	easwar.hariharan@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com,
	romank@linux.microsoft.com,
	Jinank Jain <jinankjain@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v3] mshv: Extend create partition ioctl to support cpu features
Date: Tue,  4 Nov 2025 13:47:26 -0800
Message-Id: <1762292846-14253-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Muminul Islam <muislam@microsoft.com>

The existing mshv create partition ioctl does not provide a way to
specify which cpu features are enabled in the guest. Instead, it
attempts to enable all features and those that are not supported are
silently disabled by the hypervisor.

This was done to reduce unnecessary complexity and is sufficient for
many cases. However, new scenarios require fine-grained control over
these features.

Define a new mshv_create_partition_v2 structure which supports
passing the disabled processor and xsave feature bits through to the
create partition hypercall directly.

The kernel does not introspect the bits in these new fields as they
are part of the hypervisor ABI. Require the caller to provide the
number of cpu feature banks passed, to support extending the number
of banks in future. Disable all banks that are not specified to ensure
the behavior is predictable with newer hypervisors.

Introduce a new flag MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables
the new structure. If unset, the original mshv_create_partition struct
is used, with the old behavior of enabling all features.

Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
Signed-off-by: Muminul Islam <muislam@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
Changes in v3:
- Remove the new cpu features definitions in hvhdk.h, and retain the
  old behavior of enabling all features for the old struct. For the v2
  struct, still disable unspecified feature banks, since that makes it
  robust to future extensions.
- Amend comments and commit message to reflect the above
- Fix unused variable on arm64 [kernel test robot]

Changes in v2:
- Fix exposure of CONFIG_X86_64 to uapi [kernel test robot]
- Fix compilation issue on arm64 [kernel test robot]

---
 drivers/hv/mshv_root_main.c | 94 ++++++++++++++++++++++++++++++-------
 include/uapi/linux/mshv.h   | 34 ++++++++++++++
 2 files changed, 110 insertions(+), 18 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index d542a0143bb8..814465a0912d 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1900,43 +1900,101 @@ add_partition(struct mshv_partition *partition)
 	return 0;
 }
 
-static long
-mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
+static_assert(MSHV_NUM_CPU_FEATURES_BANKS <=
+	      HV_PARTITION_PROCESSOR_FEATURES_BANKS);
+
+static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
+					struct hv_partition_creation_properties *cr_props,
+					union hv_partition_isolation_properties *isol_props)
 {
-	struct mshv_create_partition args;
-	u64 creation_flags;
-	struct hv_partition_creation_properties creation_properties = {};
-	union hv_partition_isolation_properties isolation_properties = {};
-	struct mshv_partition *partition;
-	struct file *file;
-	int fd;
-	long ret;
+	int i;
+	struct mshv_create_partition_v2 args;
+	union hv_partition_processor_features *disabled_procs;
+	union hv_partition_processor_xsave_features *disabled_xsave;
 
-	if (copy_from_user(&args, user_arg, sizeof(args)))
+	/* First, copy orig struct in case user is on previous versions */
+	if (copy_from_user(&args, user_arg,
+			   sizeof(struct mshv_create_partition)))
 		return -EFAULT;
 
 	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
 	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
 		return -EINVAL;
 
+	disabled_procs = &cr_props->disabled_processor_features;
+	disabled_xsave = &cr_props->disabled_processor_xsave_features;
+
+	/* Check if user provided newer struct with feature fields */
+	if (args.pt_flags & BIT(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
+		if (copy_from_user(&args, user_arg, sizeof(args)))
+			return -EFAULT;
+
+		if (args.pt_num_cpu_fbanks > MSHV_NUM_CPU_FEATURES_BANKS ||
+		    mshv_field_nonzero(args, pt_rsvd) ||
+		    mshv_field_nonzero(args, pt_rsvd1))
+			return -EINVAL;
+
+
+		for (i = 0; i < args.pt_num_cpu_fbanks; i++)
+			disabled_procs->as_uint64[i] = args.pt_cpu_fbanks[i];
+
+		/* Disable any features left unspecified */
+		for (; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
+			disabled_procs->as_uint64[i] = -1;
+
+#if IS_ENABLED(CONFIG_X86_64)
+		disabled_xsave->as_uint64 = args.pt_disabled_xsave;
+#else
+		if (mshv_field_nonzero(args, pt_rsvd2))
+			return -EINVAL;
+
+		disabled_xsave->as_uint64 = -1;
+#endif
+	} else {
+		/* v1 behavior: try to enable everything */
+		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
+			disabled_procs->as_uint64[i] = 0;
+
+		disabled_xsave->as_uint64 = 0;
+	}
+
 	/* Only support EXO partitions */
-	creation_flags = HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
-			 HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
+	*pt_flags = HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
+		    HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
 
 	if (args.pt_flags & BIT(MSHV_PT_BIT_LAPIC))
-		creation_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
+		*pt_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
 	if (args.pt_flags & BIT(MSHV_PT_BIT_X2APIC))
-		creation_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
+		*pt_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
 	if (args.pt_flags & BIT(MSHV_PT_BIT_GPA_SUPER_PAGES))
-		creation_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
+		*pt_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
 
 	switch (args.pt_isolation) {
 	case MSHV_PT_ISOLATION_NONE:
-		isolation_properties.isolation_type =
-			HV_PARTITION_ISOLATION_TYPE_NONE;
+		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_NONE;
 		break;
 	}
 
+	return 0;
+}
+
+static long
+mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
+{
+	u64 creation_flags;
+	struct hv_partition_creation_properties creation_properties = {};
+	union hv_partition_isolation_properties isolation_properties = {};
+	struct mshv_partition *partition;
+	struct file *file;
+	int fd;
+	long ret;
+
+	ret = mshv_ioctl_process_pt_flags(user_arg, &creation_flags,
+					  &creation_properties,
+					  &isolation_properties);
+	if (ret)
+		return ret;
+
 	partition = kzalloc(sizeof(*partition), GFP_KERNEL);
 	if (!partition)
 		return -ENOMEM;
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 876bfe4e4227..9091946cba23 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -26,6 +26,7 @@ enum {
 	MSHV_PT_BIT_LAPIC,
 	MSHV_PT_BIT_X2APIC,
 	MSHV_PT_BIT_GPA_SUPER_PAGES,
+	MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES,
 	MSHV_PT_BIT_COUNT,
 };
 
@@ -41,6 +42,8 @@ enum {
  * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
  * @pt_isolation: MSHV_PT_ISOLATION_*
  *
+ * This is the initial/v0 version for backward compatibility.
+ *
  * Returns a file descriptor to act as a handle to a guest partition.
  * At this point the partition is not yet initialized in the hypervisor.
  * Some operations must be done with the partition in this state, e.g. setting
@@ -52,6 +55,37 @@ struct mshv_create_partition {
 	__u64 pt_isolation;
 };
 
+#define MSHV_NUM_CPU_FEATURES_BANKS 2
+
+/**
+ * struct mshv_create_partition_v2
+ *
+ * This is extended version of the above initial MSHV_CREATE_PARTITION
+ * ioctl and allows for following additional parameters:
+ *
+ * @pt_num_cpu_fbanks: number of processor feature banks being provided.
+ *                     This must not exceed MSHV_NUM_CPU_FEATURES_BANKS.
+ *                     If set to less than the number of available banks,
+ *                     additional banks will be set to -1 (disabled).
+ * @pt_cpu_fbanks: disabled processor feature banks array.
+ * @pt_disabled_xsave: disabled xsave feature bits.
+ *
+ * Returns : same as above original mshv_create_partition
+ */
+struct mshv_create_partition_v2 {
+	__u64 pt_flags;
+	__u64 pt_isolation;
+	__u16 pt_num_cpu_fbanks;
+	__u8  pt_rsvd[6];		/* MBZ */
+	__u64 pt_cpu_fbanks[MSHV_NUM_CPU_FEATURES_BANKS];
+	__u64 pt_rsvd1[2];		/* MBZ */
+#if defined(__x86_64__)
+	__u64 pt_disabled_xsave;
+#else
+	__u64 pt_rsvd2;			/* MBZ */
+#endif
+} __packed;
+
 /* /dev/mshv */
 #define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
 
-- 
2.34.1


