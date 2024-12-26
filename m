Return-Path: <linux-hyperv+bounces-3527-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBA89FCDFF
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 22:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11017A15BA
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 21:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0D814900B;
	Thu, 26 Dec 2024 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mCP1RPIn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588413C80D;
	Thu, 26 Dec 2024 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735248674; cv=none; b=ox/m0We0cyCEpgzD9o0yIfTmaFVhu5l6NgFvCw6S/EyN1+qZPoisflcrRPAfl4CcNAcl3DXOoc88UqJ+4qDzCTYZtrr/hJsLCV4dIc/mXaBSSiQHfFMu7MJyzNSdjW8sLgPQMBITZCPO/+Y8H3S7opSijCjThiN17KwmjytOYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735248674; c=relaxed/simple;
	bh=NRkCjRnkhySE+BcClf+onZvPISWdYGLXxqfdEBq6MW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OGa9kvP1JQfSj/8sco+EpcBCfcAQOG7Pvy+PGBnxiK3q4cE8b52fgQ06i8QnYR+VN0A4SK9kA5M0oMUJmB/mclamwleApnRWe8rh/h8RWdz02JbjWtyDuRZgnqRh229SYuR1iKuwr5t74WByA0fucUeYb719D30YErc8ICnDW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mCP1RPIn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 356FB203EC25;
	Thu, 26 Dec 2024 13:31:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 356FB203EC25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735248672;
	bh=ry0dde5x4r+6U0CVAjvuGCMTA9d6rF8pmhm+rOPKAfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCP1RPInqFse7xfQ8xBnIe7QVRvyzxoD8dEJZf2ez5/3XVjnXldr1EmhgKvZssouz
	 InaPnf81lEeBoiyZSi9zDiEGIEKupM7eiL9gn9cyfkzNJiseFQql0785+fFJ6QKcOr
	 fcxYukrbNjqUkmtvcNchBz5GHM1nHBXXvm+V5564=
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
Subject: [PATCH v3 1/5] hyperv: Define struct hv_output_get_vp_registers
Date: Thu, 26 Dec 2024 13:31:06 -0800
Message-Id: <20241226213110.899497-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226213110.899497-1-romank@linux.microsoft.com>
References: <20241226213110.899497-1-romank@linux.microsoft.com>
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


