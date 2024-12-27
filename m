Return-Path: <linux-hyperv+bounces-3540-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50049FD6F0
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 19:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E193A2276
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 18:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB6C1F8ACC;
	Fri, 27 Dec 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kJ0UAyzL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608FE1F3D3F;
	Fri, 27 Dec 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735324318; cv=none; b=kUDEiDp7W2ts8WuOkIFvyrrkYJ6eI/ku/bSq0pHj/1eKrx8iXZvtbw2ajHavMYjB2dwG4wBpoluDbzCkvzPufaAXfFc+4rlsNZhM4a1wOBsk6+XNJVTH/mNnvwT9bkwwiDJMgG0QMUSepK6WPZrYl2HWnar9pno0D1tiovxm590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735324318; c=relaxed/simple;
	bh=4Jyuc+ffyw2DPcfTMSQ1RAZin8tjZuGQZQsUwjg4JRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZl8NuqnOkd0sgkY2cYejZAr0BdBMKLTQeIgJm3+ocJ1kcT6Ap4zsy6ICDbxMOXals6li2gMR4J9NOBtYIzRpkhemWRCS+oh91ItOi+7awYM8LrYwanJd2vQRA6v46YSIpjBOo3fEXeHkdH/SNMq2VzIO+eN5WBmOPh+5ZOBZ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kJ0UAyzL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id ABEDE203EC3C;
	Fri, 27 Dec 2024 10:31:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ABEDE203EC3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735324316;
	bh=/ype7uZEpe5xHc678iTj/2AT9nHkiZEOccSLzIQb1I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJ0UAyzLCLcvujCLicUTafOri7Ih75fzDkcMoWY7zEZ4usZFibh+1wm8CIgH/uCnv
	 SUHMbr5oTyt+tgMKlyUXhfQJsm7AZT7JwZPit0FlBfWKUTvH0jLOJQVcN7NGf3irBE
	 q1698ABSjfOcovYfSvMloLgtoj9Ql9bQxCBxNgVw=
From: Roman Kisel <romank@linux.microsoft.com>
To: hpa@zytor.com,
	kys@microsoft.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	eahariha@linux.microsoft.com,
	haiyangz@microsoft.com,
	mingo@redhat.com,
	mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com,
	tglx@linutronix.de,
	tiala@microsoft.com,
	wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v4 1/5] hyperv: Define struct hv_output_get_vp_registers
Date: Fri, 27 Dec 2024 10:31:51 -0800
Message-Id: <20241227183155.122827-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227183155.122827-1-romank@linux.microsoft.com>
References: <20241227183155.122827-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no definition of the output structure for the
GetVpRegisters hypercall. Hence, using the hypercall
is not possible when the output value has some structure
to it. Even getting a datum of a primitive type reads
as ad-hoc without that definition.

Define struct hv_output_get_vp_registers to enable using
the GetVpRegisters hypercall. Make provisions for all
supported architectures. No functional changes.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h | 65 +++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index db3d1aaf7330..c2f5cc231dce 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -781,6 +781,8 @@ struct hv_timer_message_payload {
 	__u64 delivery_time;	/* When the message was delivered */
 } __packed;
 
+#if defined(CONFIG_X86)
+
 struct hv_x64_segment_register {
 	u64 base;
 	u32 limit;
@@ -807,6 +809,8 @@ struct hv_x64_table_register {
 	u64 base;
 } __packed;
 
+#endif
+
 union hv_input_vtl {
 	u8 as_uint8;
 	struct {
@@ -1068,6 +1072,41 @@ union hv_dispatch_suspend_register {
 	} __packed;
 };
 
+#if defined(CONFIG_ARM64)
+
+union hv_arm64_pending_interruption_register {
+	u64 as_uint64;
+	struct {
+		u64 interruption_pending : 1;
+		u64 interruption_type : 1;
+		u64 reserved : 30;
+		u32 error_code;
+	} __packed;
+};
+
+union hv_arm64_interrupt_state_register {
+	u64 as_uint64;
+	struct {
+		u64 interrupt_shadow : 1;
+		u64 reserved : 63;
+	} __packed;
+};
+
+union hv_arm64_pending_synthetic_exception_event {
+	u64 as_uint64[2];
+	struct {
+		u32 event_pending : 1;
+		u32 event_type : 3;
+		u32 reserved : 4;
+		u32 exception_type;
+		u64 context;
+	} __packed;
+};
+
+#endif
+
+#if defined(CONFIG_X86)
+
 union hv_x64_interrupt_state_register {
 	u64 as_uint64;
 	struct {
@@ -1091,6 +1130,8 @@ union hv_x64_pending_interruption_register {
 	} __packed;
 };
 
+#endif
+
 union hv_register_value {
 	struct hv_u128 reg128;
 	u64 reg64;
@@ -1098,13 +1139,33 @@ union hv_register_value {
 	u16 reg16;
 	u8 reg8;
 
-	struct hv_x64_segment_register segment;
-	struct hv_x64_table_register table;
 	union hv_explicit_suspend_register explicit_suspend;
 	union hv_intercept_suspend_register intercept_suspend;
 	union hv_dispatch_suspend_register dispatch_suspend;
+#if defined(CONFIG_X86)
+	struct hv_x64_segment_register segment;
+	struct hv_x64_table_register table;
 	union hv_x64_interrupt_state_register interrupt_state;
 	union hv_x64_pending_interruption_register pending_interruption;
+#endif
+#if defined(CONFIG_ARM64)
+	union hv_arm64_pending_interruption_register pending_interruption;
+	union hv_arm64_interrupt_state_register interrupt_state;
+	union hv_arm64_pending_synthetic_exception_event pending_synthetic_exception_event;
+#endif
+};
+
+/*
+ * NOTE: Linux helper struct - NOT from Hyper-V code.
+ * DECLARE_FLEX_ARRAY() needs to be wrapped into
+ * a structure and have at least one more member besides
+ * DECLARE_FLEX_ARRAY.
+ */
+struct hv_output_get_vp_registers {
+	struct {
+		DECLARE_FLEX_ARRAY(union hv_register_value, values);
+		struct {} values_end;
+	};
 };
 
 #if defined(CONFIG_ARM64)
-- 
2.34.1


