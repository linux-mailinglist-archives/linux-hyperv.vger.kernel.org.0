Return-Path: <linux-hyperv+bounces-7362-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A2CC16DDA
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Oct 2025 22:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 511AB4E33E6
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Oct 2025 21:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA6027145F;
	Tue, 28 Oct 2025 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="agDNx7Oo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845C7221721;
	Tue, 28 Oct 2025 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685572; cv=none; b=WRDOvJtKnAYtMZdZOXQSrpZiRdgo/wcU2qOZH1z4s3k6ZWd5vy5mXvwSZP0QCpqzCjrn+elkjiFQJvjk4sXpUxqWfkBtv9kHxdjru4wgDvPKjKwwj/w5cVJ0ADMwOr4MfSTCnuEC843zm+PwKHJCvEMgCjX/BuYaKd6nWtdB5ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685572; c=relaxed/simple;
	bh=kitR7m5KnvH+ZRKUhX/MrPNsTxsfJfQviq9Iqgvue6E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=docqNdAovHxNXxxOZnq03JS2D2bzxFFSOSyEGeT2c5mhjQioh0UNmx7FdWH9tWhRKk5Ej3e/D6b09iEKk2NsQbZs04Z5AcnfdqRP3aLOswmZxXmosE1/AfI/XD+jupKYqMoDfHWk5T2EyTLQxSNk4qsTmY0Dv2mtdEJ/3mWHpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=agDNx7Oo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 092BD2017271; Tue, 28 Oct 2025 14:06:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 092BD2017271
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761685570;
	bh=qMb76jaghQKVqkZyBwGI2ua34ZTwv6azHIe9NlNMVuU=;
	h=From:To:Cc:Subject:Date:From;
	b=agDNx7Ooz/+NSoquqrROVKo3sHV7QnQH6bp6UfOtgTEjyNkgyHFNcsp/a/6F9yDnM
	 tWtlelz+cJUuoXnKsvJEtdwqK5klGUm5osANTXv8mQM4JtWkC3ZNsjfK9wLJFR0sM6
	 /Fdk46+IlkSjhdPW2YFPjlbfK62+rLHVTa5iUjQk=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muislam@microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com,
	romank@linux.microsoft.com,
	Jinank Jain <jinankjain@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH] mshv: Extend create partition ioctl to support cpu features
Date: Tue, 28 Oct 2025 14:06:02 -0700
Message-Id: <1761685562-6272-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Muminul Islam <muislam@microsoft.com>

The existing mshv create partition ioctl does not provide a way to
specify which cpu features are enabled in the guest. This was done
to reduce unnecessary complexity in the API.

However, some new scenarios require fine-grained control over the
cpu feature bits.

Define a new mshv_create_partition_v2 structure which supports passing
through the disabled cpu flags and xsave flags to the hypervisor
directly.

When these are not specified (pt_num_cpu_fbanks == 0) or the old
structure is used, define a set of default flags which cover most
cases.

Retain backward compatibility with the old structure via a new flag
MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables the new struct.

Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
Signed-off-by: Muminul Islam <muislam@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 176 ++++++++++++++++++++++++++++++++----
 include/hyperv/hvhdk.h      |  86 +++++++++++++++++-
 include/uapi/linux/mshv.h   |  34 +++++++
 3 files changed, 272 insertions(+), 24 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index d542a0143bb8..6d444d26e9dc 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1900,43 +1900,181 @@ add_partition(struct mshv_partition *partition)
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
-	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
+	     args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
 		return -EINVAL;
 
+	disabled_procs = &cr_props->disabled_processor_features;
+
+	/* Disable all processor features first */
+	for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
+		disabled_procs->as_uint64[i] = -1;
+
+#if IS_ENABLED(CONFIG_X86_64)
+	/* Enable default features that are known to be supported */
+	disabled_procs->cet_ibt_support = 0;
+	disabled_procs->cet_ss_support = 0;
+	disabled_procs->smep_support = 0;
+	disabled_procs->rdtscp_support = 0;
+	disabled_procs->tsc_invariant_support = 0;
+	disabled_procs->sse3_support = 0;
+	disabled_procs->lahf_sahf_support = 0;
+	disabled_procs->ssse3_support = 0;
+	disabled_procs->sse4_1_support = 0;
+	disabled_procs->sse4_2_support = 0;
+	disabled_procs->sse4a_support = 0;
+	disabled_procs->xop_support = 0;
+	disabled_procs->pop_cnt_support = 0;
+	disabled_procs->cmpxchg16b_support = 0;
+	disabled_procs->altmovcr8_support = 0;
+	disabled_procs->lzcnt_support = 0;
+	disabled_procs->mis_align_sse_support = 0;
+	disabled_procs->mmx_ext_support = 0;
+	disabled_procs->amd3dnow_support = 0;
+	disabled_procs->extended_amd3dnow_support = 0;
+	disabled_procs->aes_support = 0;
+	disabled_procs->pclmulqdq_support = 0;
+	disabled_procs->pcid_support = 0;
+	disabled_procs->fma4_support = 0;
+	disabled_procs->f16c_support = 0;
+	disabled_procs->rd_rand_support = 0;
+	disabled_procs->rd_wr_fs_gs_support = 0;
+	disabled_procs->enhanced_fast_string_support = 0;
+	disabled_procs->bmi1_support = 0;
+	disabled_procs->bmi2_support = 0;
+	disabled_procs->hle_support_deprecated = 0;
+	disabled_procs->rtm_support_deprecated = 0;
+	disabled_procs->movbe_support = 0;
+	disabled_procs->npiep1_support = 0;
+	disabled_procs->dep_x87_fpu_save_support = 0;
+	disabled_procs->rd_seed_support = 0;
+	disabled_procs->adx_support = 0;
+	disabled_procs->intel_prefetch_support = 0;
+	disabled_procs->smap_support = 0;
+	disabled_procs->hle_support = 0;
+	disabled_procs->rtm_support = 0;
+	disabled_procs->invpcid_support = 0;
+	disabled_procs->ibrs_support = 0;
+	disabled_procs->stibp_support = 0;
+	disabled_procs->mdd_support = 0;
+	disabled_procs->ibpb_support = 0;
+	disabled_procs->l1dcache_flush_support = 0;
+	disabled_procs->virt_spec_ctrl_support = 0;
+	disabled_procs->mb_clear_support = 0;
+	disabled_procs->tsx_ctrl_support = 0;
+	disabled_procs->clflushopt_support = 0;
+	disabled_procs->rdcl_no_support = 0;
+	disabled_procs->ibrs_all_support = 0;
+	disabled_procs->page_1gb_support = 0;
+	disabled_procs->skip_l1df_support = 0;
+	disabled_procs->ssb_no_support = 0;
+	disabled_procs->mbs_no_support = 0;
+	disabled_procs->taa_no_support = 0;
+	disabled_procs->fb_clear_support = 0;
+	disabled_procs->gds_no_support = 0;
+	disabled_procs->bhi_no_support = 0;
+	disabled_procs->bhi_dis_support = 0;
+	disabled_procs->btc_no_support = 0;
+	disabled_procs->mitigation_ctrl_support = 0;
+	disabled_procs->rfds_no_support = 0;
+	disabled_procs->rfds_clear_support = 0;
+	disabled_procs->unrestricted_guest_support = 0;
+	disabled_procs->fast_short_rep_mov_support = 0;
+	disabled_procs->rsb_a_no_support = 0;
+	disabled_procs->rd_pid_support = 0;
+	disabled_procs->umip_support = 0;
+	disabled_procs->vmx_exception_inject_support = 0;
+	disabled_procs->rdpru_support = 0;
+	disabled_procs->mbec_support = 0;
+	disabled_procs->psfd_support = 0;
+
+	/* Enable default XSave features that are known to be supported*/
+	disabled_xsave = &cr_props->disabled_processor_xsave_features;
+	disabled_xsave->as_uint64 = -1;
+	disabled_xsave->xsave_support = 0;
+	disabled_xsave->xsaveopt_support = 0;
+	disabled_xsave->avx_support = 0;
+	disabled_xsave->xsave_supervisor_support = 0;
+	disabled_xsave->xsave_comp_support = 0;
+#endif
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
+		for (i = 0; i < args.pt_num_cpu_fbanks; i++)
+			disabled_procs->as_uint64[i] = args.pt_cpu_fbanks[i];
+
+#if IS_ENABLED(CONFIG_X86_64)
+		disabled_xsave->as_uint64 = args.pt_disabled_xsave;
+#else
+		if (mshv_field_nonzero(args, pt_rsvd2))
+			return -EINVAL
+#endif
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
+		break;
+	case MSHV_PT_ISOLATION_SNP:
+		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_SNP;
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
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 416c0d45b793..221a90ab07fa 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -220,10 +220,51 @@ union hv_partition_processor_features {
 		u64 serialize_support : 1;
 		u64 tsc_deadline_tmr_support : 1;
 		u64 tsc_adjust_support : 1;
-		u64 fzlrep_movsb : 1;
-		u64 fsrep_stosb : 1;
-		u64 fsrep_cmpsb : 1;
-		u64 reserved_bank1 : 42;
+		u64 fzl_rep_movsb : 1;
+		u64 fs_rep_stosb : 1;
+		u64 fs_rep_cmpsb : 1;
+		u64 tsx_ld_trk_support : 1;
+		u64 vmx_ins_outs_exit_info_support : 1;
+		u64 hlat_support : 1;
+		u64 sbdr_ssdp_no_support : 1;
+		u64 fbsdp_no_support : 1;
+		u64 psdp_no_support : 1;
+		u64 fb_clear_support : 1;
+		u64 btc_no_support : 1;
+		u64 ibpb_rsb_flush_support : 1;
+		u64 stibp_always_on_support : 1;
+		u64 perf_global_ctrl_support : 1;
+		u64 npt_execute_only_support : 1;
+		u64 npt_ad_flags_support : 1;
+		u64 npt1_gb_page_support : 1;
+		u64 amd_processor_topology_node_id_support : 1;
+		u64 local_machine_check_support : 1;
+		u64 extended_topology_leaf_fp256_amd_support : 1;
+		u64 gds_no_support : 1;
+		u64 cmpccxadd_support : 1;
+		u64 tsc_aux_virtualization_support : 1;
+		u64 rmp_query_support : 1;
+		u64 bhi_no_support : 1;
+		u64 bhi_dis_support : 1;
+		u64 prefetch_i_support : 1;
+		u64 sha512_support : 1;
+		u64 mitigation_ctrl_support : 1;
+		u64 rfds_no_support : 1;
+		u64 rfds_clear_support : 1;
+		u64 sm3_support : 1;
+		u64 sm4_support : 1;
+		u64 secure_avic_support : 1;
+		u64 guest_intercept_ctrl_support : 1;
+		u64 sbpb_supported : 1;
+		u64 ibpb_br_type_supported : 1;
+		u64 srso_no_supported : 1;
+		u64 srso_user_kernel_no_supported : 1;
+		u64 vrew_clear_supported : 1;
+		u64 tsa_l1_no_supported : 1;
+		u64 tsa_sq_no_supported : 1;
+		u64 lass_support : 1;
+		/* Remaining reserved bits */
+		u64 reserved_bank1 : 2;
 	} __packed;
 };
 
@@ -232,7 +273,42 @@ union hv_partition_processor_xsave_features {
 		u64 xsave_support : 1;
 		u64 xsaveopt_support : 1;
 		u64 avx_support : 1;
-		u64 reserved1 : 61;
+		u64 avx2_support : 1;
+		u64 fma_support: 1;
+		u64 mpx_support: 1;
+		u64 avx512_support : 1;
+		u64 avx512_dq_support : 1;
+		u64 avx512_cd_support : 1;
+		u64 avx512_bw_support : 1;
+		u64 avx512_vl_support : 1;
+		u64 xsave_comp_support : 1;
+		u64 xsave_supervisor_support : 1;
+		u64 xcr1_support : 1;
+		u64 avx512_bitalg_support : 1;
+		u64 avx512_i_fma_support : 1;
+		u64 avx512_v_bmi_support : 1;
+		u64 avx512_v_bmi2_support : 1;
+		u64 avx512_vnni_support : 1;
+		u64 gfni_support : 1;
+		u64 vaes_support : 1;
+		u64 avx512_v_popcntdq_support : 1;
+		u64 vpclmulqdq_support : 1;
+		u64 avx512_bf16_support : 1;
+		u64 avx512_vp2_intersect_support : 1;
+		u64 avx512_fp16_support : 1;
+		u64 xfd_support : 1;
+		u64 amx_tile_support : 1;
+		u64 amx_bf16_support : 1;
+		u64 amx_int8_support : 1;
+		u64 avx_vnni_support : 1;
+		u64 avx_ifma_support : 1;
+		u64 avx_ne_convert_support : 1;
+		u64 avx_vnni_int8_support : 1;
+		u64 avx_vnni_int16_support : 1;
+		u64 avx10_1_256_support : 1;
+		u64 avx10_1_512_support : 1;
+		u64 amx_fp16_support : 1;
+		u64 reserved1 : 26;
 	} __packed;
 	u64 as_uint64;
 };
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 876bfe4e4227..2687a2f27f05 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -26,6 +26,7 @@ enum {
 	MSHV_PT_BIT_LAPIC,
 	MSHV_PT_BIT_X2APIC,
 	MSHV_PT_BIT_GPA_SUPER_PAGES,
+	MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES,
 	MSHV_PT_BIT_COUNT,
 };
 
@@ -33,6 +34,7 @@ enum {
 
 enum {
 	MSHV_PT_ISOLATION_NONE,
+	MSHV_PT_ISOLATION_SNP,
 	MSHV_PT_ISOLATION_COUNT,
 };
 
@@ -41,6 +43,8 @@ enum {
  * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
  * @pt_isolation: MSHV_PT_ISOLATION_*
  *
+ * This is the initial/v0 version for backward compatibility.
+ *
  * Returns a file descriptor to act as a handle to a guest partition.
  * At this point the partition is not yet initialized in the hypervisor.
  * Some operations must be done with the partition in this state, e.g. setting
@@ -52,6 +56,36 @@ struct mshv_create_partition {
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
+ * @pt_cpu_fbanks: processor feature banks array
+ * @pt_disabled_xsave: disabled xsave feature bits. Refer to
+ *                     union hv_partition_processor_xsave_feature
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
+#if IS_ENABLED(CONFIG_X86_64)
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


