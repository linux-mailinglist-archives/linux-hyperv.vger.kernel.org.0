Return-Path: <linux-hyperv+bounces-7345-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE88C1165B
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 21:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5792561B44
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CD13168E3;
	Mon, 27 Oct 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ud7vx8hf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA42E6CC4;
	Mon, 27 Oct 2025 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596950; cv=none; b=b81/yiRPp/KvKxMrVVnSNGQZQj1mFfsb+Xaoq6353xUcedDFJaCLQeyofxHr9WkFRakrRwa7344/JTR5IfM1sBJKc6IaTuzmmgpzG0QR1/7Nf6NamC+e7b7HzvRvn7oadS30fuhyNXZCfGPblsJiBhScmuIPAyYgVmjQ0CMMHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596950; c=relaxed/simple;
	bh=+OHPmiHb8Qr8ikqxVBVdSociPtpqc68PQQWThCAQ3S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aylPZEPiuRIyauUH2WquGNJMM7jpgYV+5+FnzJcl2CPpfWNlQ3RIAxs8qypfC0SQuJzIaUlTNvPiw8JuDaZ/MZpVgjgZ35i5jzXGMispT7OBgPdHQev4CSt2IM2wZQLnV/vo2pc90R8t0ok4UwI5A0dfYZUB9pK4Q/PwI8NWOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ud7vx8hf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6D12A2123276;
	Mon, 27 Oct 2025 13:29:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D12A2123276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761596948;
	bh=kx4cc9dIKZ5GN3KGqK1WNCmEcB9p20r5huy+RyJftZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ud7vx8hfwYSe/mgMa3EQDP0b3GTdvJon3bTWrjnIGlGuIXG3Y0QQ786/aAAegw/zH
	 y72d3TIiEswOoTr00zlcA/HyqNgYEtW5SmFw2naa0IENcV8wdMKufONZNq1aeJ1DL0
	 cdX9t7XtIUOpV27x9sVX5jM/RjVF/jl32DmwuZDA=
From: Praveen K Paladugu <prapal@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Cc: anbelski@linux.microsoft.com,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com,
	skinsburskii@linux.microsoft.com
Subject: [PATCH v3 1/2] hyperv: Add definitions for MSHV sleep state configuration
Date: Mon, 27 Oct 2025 15:28:42 -0500
Message-ID: <20251027202859.72006-2-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027202859.72006-1-prapal@linux.microsoft.com>
References: <20251027202859.72006-1-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the definitions required to configure sleep states in mshv hypervsior.

Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h |  4 +++-
 include/hyperv/hvhdk_mini.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 7499a679e60a..b43fa1c9ed2c 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -465,19 +465,21 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_RESET_DEBUG_SESSION			0x006b
 #define HVCALL_MAP_STATS_PAGE				0x006c
 #define HVCALL_UNMAP_STATS_PAGE				0x006d
+#define HVCALL_SET_SYSTEM_PROPERTY			0x006f
 #define HVCALL_ADD_LOGICAL_PROCESSOR			0x0076
 #define HVCALL_GET_SYSTEM_PROPERTY			0x007b
 #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
 #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
 #define HVCALL_RETARGET_INTERRUPT			0x007e
 #define HVCALL_NOTIFY_PARTITION_EVENT                   0x0087
+#define HVCALL_ENTER_SLEEP_STATE			0x0084
 #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
 #define HVCALL_REGISTER_INTERCEPT_RESULT		0x0091
 #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
 #define HVCALL_CREATE_PORT				0x0095
 #define HVCALL_CONNECT_PORT				0x0096
 #define HVCALL_START_VP					0x0099
-#define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
+#define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
 #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index f2d7b50de7a4..06cf30deb319 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -140,6 +140,7 @@ enum hv_snp_status {
 
 enum hv_system_property {
 	/* Add more values when needed */
+	HV_SYSTEM_PROPERTY_SLEEP_STATE = 3,
 	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE = 15,
 	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY = 21,
 	HV_SYSTEM_PROPERTY_CRASHDUMPAREA = 47,
@@ -155,6 +156,19 @@ union hv_pfn_range {            /* HV_SPA_PAGE_RANGE */
 	} __packed;
 };
 
+enum hv_sleep_state {
+	HV_SLEEP_STATE_S1 = 1,
+	HV_SLEEP_STATE_S2 = 2,
+	HV_SLEEP_STATE_S3 = 3,
+	HV_SLEEP_STATE_S4 = 4,
+	HV_SLEEP_STATE_S5 = 5,
+	/*
+	 * After hypervisor has received this, any follow up sleep
+	 * state registration requests will be rejected.
+	 */
+	HV_SLEEP_STATE_LOCK = 6
+};
+
 enum hv_dynamic_processor_feature_property {
 	/* Add more values when needed */
 	HV_X64_DYNAMIC_PROCESSOR_FEATURE_MAX_ENCRYPTED_PARTITIONS = 13,
@@ -184,6 +198,25 @@ struct hv_output_get_system_property {
 	};
 } __packed;
 
+struct hv_sleep_state_info {
+	u32 sleep_state; /* enum hv_sleep_state */
+	u8 pm1a_slp_typ;
+	u8 pm1b_slp_typ;
+} __packed;
+
+struct hv_input_set_system_property {
+	u32 property_id; /* enum hv_system_property */
+	u32 reserved;
+	union {
+		/* More fields to be filled in when needed */
+		struct hv_sleep_state_info set_sleep_state_info;
+	};
+} __packed;
+
+struct hv_input_enter_sleep_state {     /* HV_INPUT_ENTER_SLEEP_STATE */
+	u32 sleep_state;        /* enum hv_sleep_state */
+} __packed;
+
 struct hv_input_map_stats_page {
 	u32 type; /* enum hv_stats_object_type */
 	u32 padding;
-- 
2.51.0


