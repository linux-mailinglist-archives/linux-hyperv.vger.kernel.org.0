Return-Path: <linux-hyperv+bounces-3624-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D5A06828
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 23:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F76167C2F
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 22:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41CE2040A1;
	Wed,  8 Jan 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qKXkSIBJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0E119D8A3;
	Wed,  8 Jan 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374901; cv=none; b=kaViurQ+S7Ju36LBb0ORffsDfQZ/j6fT5/b3Yutz5EjLcniudk/DC1PL7xMx28t41fceiSK72mlr8cCY4rL/g0NwvSvslhdVEGzE2yrB4ddTROmaTvUh2+QzWs1zQztm+nf1giCyPQxsWlCMlX9rvUYauBB90CRvuogJidJLoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374901; c=relaxed/simple;
	bh=qcafMXV1WerZOL9+iELEnwK79b3MrkBNbG5ndg57gCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AE07LER3jQHIEC1bxF3rUUTM18ml1PozK7oJBEJblsoWIglR5xFfv265AYfsZqUba9Ip9RxJc0FThjA5VPHjvzskS7SD0qpU9l221HL2DRtspIQa/9o1Eg+X5PawoPWkE6NGCjNJhfxlkb6rgSPnXqfvq4r2YhJAaJXGGzxJW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qKXkSIBJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB96B203E3AC;
	Wed,  8 Jan 2025 14:21:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB96B203E3AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736374900;
	bh=vwwWa71Zd50P34+bo52kV00/vqPmYY6R52Sz0B4X140=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKXkSIBJNQYru0xoUE9y20f8XCr+s5p4r4lPYGKEf2WjCw+2EHWicqnW3v6VUzBz4
	 r+LAHql86rPrRUTPrUuOzveE3/VIkbxfjFyoLtyl+GLhvM/P2Ww6aEhCXS17t+aIJo
	 FnDnj/dYQrbzBpOgkuBdNTQ2y4Nk595LA3o43NQQ=
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
Subject: [PATCH v6 1/5] hyperv: Define struct hv_output_get_vp_registers
Date: Wed,  8 Jan 2025 14:21:34 -0800
Message-Id: <20250108222138.1623703-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108222138.1623703-1-romank@linux.microsoft.com>
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
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
 include/hyperv/hvgdk_mini.h | 41 +++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index db3d1aaf7330..4fffca9e16df 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1068,6 +1068,35 @@ union hv_dispatch_suspend_register {
 	} __packed;
 };
 
+union hv_arm64_pending_interruption_register {
+	u64 as_uint64;
+	struct {
+		u64 interruption_pending : 1;
+		u64 interruption_type: 1;
+		u64 reserved : 30;
+		u64 error_code : 32;
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
+		u8 event_pending : 1;
+		u8 event_type : 3;
+		u8 reserved : 4;
+		u8 rsvd[3];
+		u64 context;
+	} __packed;
+};
+
 union hv_x64_interrupt_state_register {
 	u64 as_uint64;
 	struct {
@@ -1103,8 +1132,20 @@ union hv_register_value {
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
+/* NOTE: Linux helper struct - NOT from Hyper-V code. */
+struct hv_output_get_vp_registers {
+	DECLARE_FLEX_ARRAY(union hv_register_value, values);
 };
 
 #if defined(CONFIG_ARM64)
-- 
2.34.1


