Return-Path: <linux-hyperv+bounces-7182-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE9BCEA55
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 23:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C519E4E4D67
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A801D303CAE;
	Fri, 10 Oct 2025 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n+jxr/A1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15047303A3C;
	Fri, 10 Oct 2025 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760133356; cv=none; b=izpBBbvJ1p7lWPhEP7RfLa4wi+7N2p2rZolxAMChiTLhRiUDLf//951WZj9po/GRbP86wdraGcz2IvoPKy6A73JYZe1QgMoJX1JupHhA02RKkQPydImDoIrS0f7jjuG5pOvd9+dy8baVXQqyUyvjMvpxi4lTosAsANdfDJaKb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760133356; c=relaxed/simple;
	bh=nDG+FqHEF2uWfERwfxdlFG79+fDu1fcON8lIsJ+tKS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IfDj92ksCPha07WYA2GhI6UNCrG2ZtuNCbZZYk1cQcn51M/3Xe3xVMLvWEk53+ktAd6tdQW913WreUavqW0qKenok+3FSEFMgFIgFiugk1WbAo+bMWyrvpnfLv187B0yyCRgVmEY9m2O5aTMiOIWjuCaFTC8k/3/LCeGn65r3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n+jxr/A1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id C193B211CE0E; Fri, 10 Oct 2025 14:55:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C193B211CE0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760133354;
	bh=khNI2QfJhxIYESS2MZZhw2efQWlG80GW8tmxjQrDVM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+jxr/A1dgo3bcXaGApMDZn2ouXqWVnyWBIhmCtIESQxdOZX6Dk7S3Z16lOG3qMX2
	 dns8HNgbX1ccJkerbyhJYdny/QaDzzUR3heXFdpXYAyrESZqIsv+OMivoEWKShETrK
	 eIwlK+VifJYYCgAvrLutH/veaIy4gVFd1rtoa3vQ=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com,
	anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v5 2/5] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX hypercall
Date: Fri, 10 Oct 2025 14:55:48 -0700
Message-Id: <1760133351-6643-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1760133351-6643-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1760133351-6643-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>

This hypercall can be used to fetch extended properties of a
partition. Extended properties are properties with values larger than
a u64. Some of these also need additional input arguments.

Add helper function for using the hypercall in the mshv_root driver.

Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/mshv_root.h         |  2 ++
 drivers/hv/mshv_root_hv_call.c | 31 ++++++++++++++++++++++++++
 include/hyperv/hvgdk_mini.h    |  1 +
 include/hyperv/hvhdk.h         | 40 ++++++++++++++++++++++++++++++++++
 include/hyperv/hvhdk_mini.h    | 26 ++++++++++++++++++++++
 5 files changed, 100 insertions(+)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index e3931b0f1269..4aeb03bea6b6 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -303,6 +303,8 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
 int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 				   u64 page_struct_count, u32 host_access,
 				   u32 flags, u8 acquire);
+int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 arg,
+				      void *property_value, size_t property_value_sz);
 
 extern struct mshv_root mshv_root;
 extern enum hv_scheduler_type hv_scheduler_type;
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index c9c274f29c3c..8049e51c45dc 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -590,6 +590,37 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 	return hv_result_to_errno(status);
 }
 
+int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code,
+				      u64 arg, void *property_value,
+				      size_t property_value_sz)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_get_partition_property_ex *input;
+	struct hv_output_get_partition_property_ex *output;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->property_code = property_code;
+	input->arg = arg;
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_PROPERTY_EX, input, output);
+
+	if (!hv_result_success(status)) {
+		local_irq_restore(flags);
+		hv_status_debug(status, "\n");
+		return hv_result_to_errno(status);
+	}
+	memcpy(property_value, &output->property_value, property_value_sz);
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
 int
 hv_call_clear_virtual_interrupt(u64 partition_id)
 {
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 77abddfc750e..2914fdb24f84 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -490,6 +490,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_VP_STATE				0x00e3
 #define HVCALL_SET_VP_STATE				0x00e4
 #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
+#define HVCALL_GET_PARTITION_PROPERTY_EX		0x0101
 #define HVCALL_MMIO_READ				0x0106
 #define HVCALL_MMIO_WRITE				0x0107
 
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index b4067ada02cf..416c0d45b793 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -376,6 +376,46 @@ struct hv_input_set_partition_property {
 	u64 property_value;
 } __packed;
 
+union hv_partition_property_arg {
+	u64 as_uint64;
+	struct {
+		union {
+			u32 arg;
+			u32 vp_index;
+		};
+		u16 reserved0;
+		u8 reserved1;
+		u8 object_type;
+	} __packed;
+};
+
+struct hv_input_get_partition_property_ex {
+	u64 partition_id;
+	u32 property_code; /* enum hv_partition_property_code */
+	u32 padding;
+	union {
+		union hv_partition_property_arg arg_data;
+		u64 arg;
+	};
+} __packed;
+
+/*
+ * NOTE: Should use hv_input_set_partition_property_ex_header to compute this
+ * size, but hv_input_get_partition_property_ex is identical so it suffices
+ */
+#define HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE \
+	(HV_HYP_PAGE_SIZE - sizeof(struct hv_input_get_partition_property_ex))
+
+union hv_partition_property_ex {
+	u8 buffer[HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE];
+	struct hv_partition_property_vmm_capabilities vmm_capabilities;
+	/* More fields to be filled in when needed */
+};
+
+struct hv_output_get_partition_property_ex {
+	union hv_partition_property_ex property_value;
+} __packed;
+
 enum hv_vp_state_page_type {
 	HV_VP_STATE_PAGE_REGISTERS = 0,
 	HV_VP_STATE_PAGE_INTERCEPT_MESSAGE = 1,
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 858f6a3925b3..bf2ce27dfcc5 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -96,8 +96,34 @@ enum hv_partition_property_code {
 	HV_PARTITION_PROPERTY_XSAVE_STATES                      = 0x00060007,
 	HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE		= 0x00060008,
 	HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY		= 0x00060009,
+
+	/* Extended properties with larger property values */
+	HV_PARTITION_PROPERTY_VMM_CAPABILITIES			= 0x00090007,
 };
 
+#define HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT		1
+#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	59
+
+struct hv_partition_property_vmm_capabilities {
+	u16 bank_count;
+	u16 reserved[3];
+	union {
+		u64 as_uint64[HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT];
+		struct {
+			u64 map_gpa_preserve_adjustable: 1;
+			u64 vmm_can_provide_overlay_gpfn: 1;
+			u64 vp_affinity_property: 1;
+#if IS_ENABLED(CONFIG_ARM64)
+			u64 vmm_can_provide_gic_overlay_locations: 1;
+#else
+			u64 reservedbit3: 1;
+#endif
+			u64 assignable_synthetic_proc_features: 1;
+			u64 reserved0: HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT;
+		} __packed;
+	};
+} __packed;
+
 enum hv_snp_status {
 	HV_SNP_STATUS_NONE = 0,
 	HV_SNP_STATUS_AVAILABLE = 1,
-- 
2.34.1


