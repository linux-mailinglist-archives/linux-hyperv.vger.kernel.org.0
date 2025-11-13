Return-Path: <linux-hyperv+bounces-7557-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB45C59D37
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 20:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8830634503C
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 19:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD02E2FC881;
	Thu, 13 Nov 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pDqyispT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE395789D;
	Thu, 13 Nov 2025 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063136; cv=none; b=Kjlpffvh5yxAl5UqHcGGnFx3uMXrgOQWoHntxjiKAm6gxrVuwCwWiqQWIuMEgBNStgpV96ObKSXPObApEPTSyfoC8EuAm5H3r9dZrTDCM75kppZwAixkYexvVa/MV4NLP4RkhkiXAk2F2SqX/H0scRHIvmwaAMwRgS9RXfM03TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063136; c=relaxed/simple;
	bh=5FLi5IvFjvaxeFqv7Yvqf/eMC+WOjM5eh8KtwSU30Cg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=u7M5DTAPUI+UGn2jgu1+nxdoi6R89HIC6uGusnbx5fUYa1PxkCH20+/3odx0bAiLZtJ4UA1aTn9vCNYk/SiWhjA84KxfwJxE0dYck8jQeI2T9luQUliQLME7upWP+6zCTbYa3KOZaAcY92dO9otsMlLjwjdMEf0VzhJ1F9WjlNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pDqyispT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id C093F2017FB3; Thu, 13 Nov 2025 11:45:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C093F2017FB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763063134;
	bh=+zdtdNimIwCPV/km8xNNGD+QgyM406vgyFahM7aGuJk=;
	h=From:To:Cc:Subject:Date:From;
	b=pDqyispTSBYIi2b4m3FYhzgSo3uNx5rL1ol1VHUjK8XSMoAJFZkXo5Mmq5gs7ZPy9
	 drSp3xUxo8mWm+xFiuH2lhlCt4XWlAUUMnoR5b3tg9/Jl3sJDRKnOX6pK1QUf3NuUb
	 wtDDoSffa4ayqHHZWiojFqmvtiFB4QHdorXh0Jy8=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wei.liu@kernel.org,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	skinsburskii@linux.microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	muislam@microsoft.com,
	anrayabh@linux.microsoft.com,
	Jinank Jain <jinankjain@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v5] mshv: Extend create partition ioctl to support cpu features
Date: Thu, 13 Nov 2025 11:45:33 -0800
Message-Id: <1763063133-3878-1-git-send-email-nunodasneves@linux.microsoft.com>
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

Introduce a new flag MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables
the new structure. If unset, the original mshv_create_partition struct
is used, with the old behavior of enabling all features.

Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
Signed-off-by: Muminul Islam <muislam@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v5:
- Re-validate v1 struct fields after copying v2 struct, as a precaution
  against the data changing in between [Michael Kelley]

Changes in v4:
- Change BIT() to BIT_ULL() [Michael Kelley]
- Enforce pt_num_cpu_fbanks == MSHV_NUM_CPU_FEATURES_BANKS and expect
  that number to never change. In future, additional processor banks
  will be settable as 'early' partition properties. Remove redundant
  code that set default values for unspecified banks [Michael Kelley]
- Set xsave features to 0 on arm64 [Michael Kelley]
- Add clarifying comments in a few places

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
 drivers/hv/mshv_root_main.c | 118 +++++++++++++++++++++++++++++-------
 include/uapi/linux/mshv.h   |  34 +++++++++++
 2 files changed, 131 insertions(+), 21 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index d542a0143bb8..621c5f3cea48 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1900,43 +1900,119 @@ add_partition(struct mshv_partition *partition)
 	return 0;
 }
 
-static long
-mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
+static_assert(MSHV_NUM_CPU_FEATURES_BANKS ==
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
+	/* First, copy v1 struct in case user is on previous versions */
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
+	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
+		if (copy_from_user(&args, user_arg, sizeof(args)))
+			return -EFAULT;
+
+		/* Re-validate v1 fields after second copy_from_user() */
+		if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
+		    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
+			return -EINVAL;
+
+		if (args.pt_num_cpu_fbanks != MSHV_NUM_CPU_FEATURES_BANKS ||
+		    mshv_field_nonzero(args, pt_rsvd) ||
+		    mshv_field_nonzero(args, pt_rsvd1))
+			return -EINVAL;
+
+		/*
+		 * Note this assumes MSHV_NUM_CPU_FEATURES_BANKS will never
+		 * change and equals HV_PARTITION_PROCESSOR_FEATURES_BANKS
+		 * (i.e. 2).
+		 *
+		 * Further banks (index >= 2) will be modifiable as 'early'
+		 * properties via the set partition property hypercall.
+		 */
+		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
+			disabled_procs->as_uint64[i] = args.pt_cpu_fbanks[i];
+
+#if IS_ENABLED(CONFIG_X86_64)
+		disabled_xsave->as_uint64 = args.pt_disabled_xsave;
+#else
+		/*
+		 * In practice this field is ignored on arm64, but safer to
+		 * zero it in case it is ever used.
+		 */
+		disabled_xsave->as_uint64 = 0;
+
+		if (mshv_field_nonzero(args, pt_rsvd2))
+			return -EINVAL;
+#endif
+	} else {
+		/*
+		 * v1 behavior: try to enable everything. The hypervisor will
+		 * disable features that are not supported. The banks can be
+		 * queried via the get partition property hypercall.
+		 */
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
+
+	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_LAPIC))
+		*pt_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
+	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_X2APIC))
+		*pt_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
+	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_GPA_SUPER_PAGES))
+		*pt_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
 
-	if (args.pt_flags & BIT(MSHV_PT_BIT_LAPIC))
-		creation_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
-	if (args.pt_flags & BIT(MSHV_PT_BIT_X2APIC))
-		creation_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
-	if (args.pt_flags & BIT(MSHV_PT_BIT_GPA_SUPER_PAGES))
-		creation_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
+	isol_props->as_uint64 = 0;
 
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
+	struct hv_partition_creation_properties creation_properties;
+	union hv_partition_isolation_properties isolation_properties;
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
index 876bfe4e4227..cf904f3aa201 100644
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
+ * This is the initial/v1 version for backward compatibility.
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
+ * @pt_num_cpu_fbanks: Must be set to MSHV_NUM_CPU_FEATURES_BANKS.
+ * @pt_cpu_fbanks: Disabled processor feature banks array.
+ * @pt_disabled_xsave: Disabled xsave feature bits.
+ *
+ * pt_cpu_fbanks and pt_disabled_xsave are passed through as-is to the create
+ * partition hypercall.
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


