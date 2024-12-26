Return-Path: <linux-hyperv+bounces-3522-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5695A9FCDA1
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 21:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A0C1882C85
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 20:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934314E2E2;
	Thu, 26 Dec 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kWXnLmSd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC03145FE0;
	Thu, 26 Dec 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735245054; cv=none; b=PSn0z8wmRnuW8WTI7l7EWgk0EeqDLJZLIw2GM6HpT8lteMlH8OwfNwhfMiXV7vCy19WYCV/BPS0K3sEdoeWmIOL2VBCzkGA7CHMvz4K8fYzxbUGoowDx1pF9XwPDR19u7GFXLroBH3lvvUfY8jP3r3hR5Dz6TZPII19oVS7WXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735245054; c=relaxed/simple;
	bh=NRkCjRnkhySE+BcClf+onZvPISWdYGLXxqfdEBq6MW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYzLolvuahwskHQB+pJ109Ve/JEpNW7cAc80HjfQLJPVYva/WbP02R8FtDtnLJLSn57eck6NKnGSaKhZaEdvn8njEf0GmkB0x2Six3Brm3e9pV9HenWlC898iz0IaE16KeU3tXmYriGawm0qq4dcH3c1geZZupGreUcx1RxY8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kWXnLmSd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7908E203EC24;
	Thu, 26 Dec 2024 12:30:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7908E203EC24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735245052;
	bh=ry0dde5x4r+6U0CVAjvuGCMTA9d6rF8pmhm+rOPKAfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWXnLmSdDLLQhzu9vL74ileaK5i9Fuy0Y6/pZBPBtHgUX+GhKSTQEj6g/ySOecYdP
	 fgLgriLtzp2Mmx8c8S8ijaOFdKYPLeMM5AH9W8xUqhNkYDzANXe6Q/Wg9IxslSEtk6
	 dhNpy55rV1n/SGOKZp+NVHQXiQh3c4GYSC9PJ8zw=
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
Subject: [PATCH v2 1/3] hyperv: Define struct hv_output_get_vp_registers
Date: Thu, 26 Dec 2024 12:30:48 -0800
Message-Id: <20241226203050.800524-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226203050.800524-1-romank@linux.microsoft.com>
References: <20241226203050.800524-1-romank@linux.microsoft.com>
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
 include/hyperv/hvgdk_mini.h | 58 +++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index db3d1aaf7330..31c11550af73 100644
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
@@ -1098,13 +1139,26 @@ union hv_register_value {
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
+#elif defined(CONFIG_ARM64)
+	union hv_arm64_pending_interruption_register pending_interruption;
+	union hv_arm64_interrupt_state_register interrupt_state;
+	union hv_arm64_pending_synthetic_exception_event pending_synthetic_exception_event;
+#else
+	#error "This architecture is not supported"
+#endif
+};
+
+/* NOTE: Linux helper struct - NOT from Hyper-V code */
+struct hv_output_get_vp_registers {
+	DECLARE_FLEX_ARRAY(union hv_register_value, values);
 };
 
 #if defined(CONFIG_ARM64)
-- 
2.34.1


