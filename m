Return-Path: <linux-hyperv+bounces-7977-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6434CCA93E2
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 21:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFAC7311BA30
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 20:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF52D8763;
	Fri,  5 Dec 2025 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m7RlyNgZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688614A8E;
	Fri,  5 Dec 2025 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965854; cv=none; b=HEf8CWB/ZBfyLolrh86jzXvUz4R1nqzW+yfLY1hJh2fnROh3E8Cegfsg1t31L4QIT1Gb6afFSPwQ1GyY35g7acZ+mFOJXmMXgdCO+7S4ZffCHFJQKmRMhjisVAhZSy76/umai0YkE+AIWWcdp/PWN2ehe+xzIvHfxbmmneXCwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965854; c=relaxed/simple;
	bh=NrUobtHk5U7x6sX2kK40coXoOQ57ITpJT5M19hrapgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBw7s/SjQS2sIw1t8NQ5Brsy+NpczkPHKIlzlWSxKZFKbBUScs+5RK0KVLX7TH/0BSZuruOz/OX9aPi3e4IjEbUGrvrksq0Kz1hRq0WsipWFQRGzvH00nktfbZacjFxSXrVjPFXhLzLwZfhqcWxaFjC4gaYLktaIwKzuTompBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m7RlyNgZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2EF6E2116022;
	Fri,  5 Dec 2025 12:17:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EF6E2116022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764965852;
	bh=RpWyJkAOispYpx27Qwz72E6esZ4g7bJ5EM9opNXbx+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m7RlyNgZSJlJ61vWwmdUkuVLzV5FFoLd5xC/L1kDtMznJmKNS9sjkS4uYKOs8+MGz
	 t8/6J5wxjGljZkDz9EP1y8n1AhfEl/qJ6YIuo3tYw4MseDby4eS3rXRokBGr+TCsgN
	 AVjCXkvoLVE/FpGqXcvNpyd1E7FJYiMk6E7Rlo6k=
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
Subject: [PATCH v7 2/4] hyperv: Add definitions for MSHV sleep state configuration
Date: Fri,  5 Dec 2025 14:17:06 -0600
Message-ID: <20251205201721.7253-3-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201721.7253-1-prapal@linux.microsoft.com>
References: <20251205201721.7253-1-prapal@linux.microsoft.com>
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
Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h |  4 +++-
 include/hyperv/hvhdk_mini.h | 40 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 1d5ce11be8b6..04b18d0e37af 100644
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
index f2d7b50de7a4..41a29bf8ec14 100644
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
@@ -184,6 +198,32 @@ struct hv_output_get_system_property {
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
+
+		/*
+		 * Add a reserved field to ensure the union is 8-byte aligned as
+		 * existing members may not be. This is a temporary measure
+		 * until all remaining members are added.
+		 */
+		 u64 reserved0[8];
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


