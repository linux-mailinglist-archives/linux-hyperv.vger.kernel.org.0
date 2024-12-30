Return-Path: <linux-hyperv+bounces-3558-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695FC9FE9A0
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 19:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B1B3A3AE5
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 18:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA91B0418;
	Mon, 30 Dec 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Aqhvdvb8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02AF1AAA2C;
	Mon, 30 Dec 2024 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582185; cv=none; b=XqyW2qdLja8g7lsOD5Sk9e5Y4ET7rYv4R0IZICjv5eQlK++8U8ESTdzNb6J3kiqY76oii0DQpzcp6eYAxRdnhA8g1/c5Pb7nXiQjlToQj6Oqi8tv3lTiTu/FOxU5nCOpXWeKt6ArVQE/yEc35KUSeeXk+cBA/lograKVd2j0+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582185; c=relaxed/simple;
	bh=q1kkFkBG+MDcXdsQLHGr+JLc+o4F3AcSoiEu5nL8GYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nt6/wfxPZ0pAipmItykV/Lrnv2EadfQl7hnTZmvBN87ZV1v3DiS6yChBhGMvOqxEejd3156SInQNmn/liJFguxZz1dUQPxXSRUHJBbG59ai3yh0zyuh4jdQw9alJZnLiltsomkkSVXPTImZkJKvHO0CDoO8ad88jBMJPFLEEQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Aqhvdvb8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D6CA205A750;
	Mon, 30 Dec 2024 10:09:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D6CA205A750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735582183;
	bh=V3r7eiTyEw6zyMZkhiaqTwssurL0nihzW0DLTQHyZ1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aqhvdvb8GML83Zx84fLw+ha4O9T/xW5a0pOQIdPk8pOnlC+imkJuRpZAJj8EUmppi
	 P7LJI439b9oESPTzZITE8c18+fmxQARdJ9FYSRhF87SjRbkLwUOkn1v5BJp95jXs7k
	 b8LC4Nx3tfjrAHsMHYKu6RY3yxD+XLg03AeTbE68=
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
Subject: [PATCH v5 1/5] hyperv: Define struct hv_output_get_vp_registers
Date: Mon, 30 Dec 2024 10:09:37 -0800
Message-Id: <20241230180941.244418-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230180941.244418-1-romank@linux.microsoft.com>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
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
 include/hyperv/hvgdk_mini.h | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index db3d1aaf7330..e8e3faa78e15 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1068,6 +1068,35 @@ union hv_dispatch_suspend_register {
 	} __packed;
 };
 
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
 union hv_x64_interrupt_state_register {
 	u64 as_uint64;
 	struct {
@@ -1103,8 +1132,28 @@ union hv_register_value {
 	union hv_explicit_suspend_register explicit_suspend;
 	union hv_intercept_suspend_register intercept_suspend;
 	union hv_dispatch_suspend_register dispatch_suspend;
+#ifdef CONFIG_ARM64
+	union hv_arm64_interrupt_state_register interrupt_state;
+	union hv_arm64_pending_interruption_register pending_interruption;
+#endif
+#ifdef CONFIG_X86
 	union hv_x64_interrupt_state_register interrupt_state;
 	union hv_x64_pending_interruption_register pending_interruption;
+#endif
+	union hv_arm64_pending_synthetic_exception_event pending_synthetic_exception_event;
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


