Return-Path: <linux-hyperv+bounces-7168-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9E2BCA161
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Oct 2025 18:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60913BB44C
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Oct 2025 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463252D0C8F;
	Thu,  9 Oct 2025 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DPWw11UP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1252110;
	Thu,  9 Oct 2025 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025920; cv=none; b=IWlg6JE1ctayOH71WM/WT3z+AsE31X4jOXVb0/Fs16S7mEPCS1vwgAcaAm2qvO12Uh4ZYS64q1kyuFT9pYdWL3yLLcARb3EZGPMC5W54G6XKRbnpHXuvO+FLUGItZuCh+TJQK/EVUOuIy2T3ECTyTmnNI0Ia+n2aG4jhSqODmRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025920; c=relaxed/simple;
	bh=u0pFlnTloCT5M/Rh2VATn4bgkUk4gEeJ7s3pbAIxvYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWywDT0Q/tN5sWZOPh5NE9WO4fVyzoYBvsgg97h+SGQ8aGuFyqMzqfvNGIYMjc7AbmLL1Xb4Hdf1d2nZUGEvHZt6AnATxhxCJzMl2jUn0GRv4amNzZEN/m0rMdtgyY+q38ve49+OF3qpa9GCzHtuw8IivAUzrGUag6c55Kex7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DPWw11UP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (syn-072-191-074-189.res.spectrum.com [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id 372CA211CE0F;
	Thu,  9 Oct 2025 09:05:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 372CA211CE0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760025912;
	bh=1Vc1iV/FS/KWNNaLUjA2zbVYY+CatKvwxbkgYqCU0KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPWw11UPKqw/QoC9/1xS1mlD3ZGi8yyINbkKJX6KD2sPy3YhiGbQh82L5iedqTZ9I
	 HFWpQzISJS8OQFL+r54nikCOZyHrIOot1722uXfD9jVnF1+q/SnERpBVLR4JVxWunO
	 pjqUkFPvtAQA5rr8nIsjcJVn8NGlTvmLNRRndhb8=
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
	prapal@linux.microsoft.com
Subject: [PATCH 1/2] hyperv: Add definitions for MSHV sleep state configuration
Date: Thu,  9 Oct 2025 10:58:50 -0500
Message-ID: <20251009160501.6356-2-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009160501.6356-1-prapal@linux.microsoft.com>
References: <20251009160501.6356-1-prapal@linux.microsoft.com>
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
---
 include/hyperv/hvgdk_mini.h |  4 +++-
 include/hyperv/hvhdk_mini.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 77abddfc750e..943df5d292f2 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -464,18 +464,20 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_RESET_DEBUG_SESSION			0x006b
 #define HVCALL_MAP_STATS_PAGE				0x006c
 #define HVCALL_UNMAP_STATS_PAGE				0x006d
+#define HVCALL_SET_SYSTEM_PROPERTY			0x006f
 #define HVCALL_ADD_LOGICAL_PROCESSOR			0x0076
 #define HVCALL_GET_SYSTEM_PROPERTY			0x007b
 #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
 #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
 #define HVCALL_RETARGET_INTERRUPT			0x007e
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
index 858f6a3925b3..8fa86c014c25 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -114,10 +114,24 @@ enum hv_snp_status {
 
 enum hv_system_property {
 	/* Add more values when needed */
+	HV_SYSTEM_PROPERTY_SLEEP_STATE = 3,
 	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE = 15,
 	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY = 21,
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
@@ -145,6 +159,25 @@ struct hv_output_get_system_property {
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


