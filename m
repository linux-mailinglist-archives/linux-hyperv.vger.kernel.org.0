Return-Path: <linux-hyperv+bounces-6514-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5700DB2394F
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Aug 2025 21:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAEE1667C3
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Aug 2025 19:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F66F2F83D8;
	Tue, 12 Aug 2025 19:52:54 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D955296BCA;
	Tue, 12 Aug 2025 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028374; cv=none; b=d3ADO6UBk2sK8fVov0lxSIvQAaP608nqQhVeE9dNZKDX3LbFzxdcdigjHUGXT5HabpqKwm3mC2mHc6zbavpNfXoVIUipj1kt+J5k65GLC9mTNHbqlfKd24aYI7TWpK8w3Ypx4LtoOq9YSefdV5kQUH0zPXi0zdXSa42WxyUNtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028374; c=relaxed/simple;
	bh=zwQz0ilEKedZwHYIZLWZIKiyToJnxknOD79+72n+sec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UaZuL5G16xeXRqyF3hkt/YIfdK/J+2ZoXm9YISyEdZtejoiFCiYU++OCq3V0QkGd/plEyGFQK4kDtWWaMZwn7T/GI6LAYfDcKXjnvE60pcZFb2pvKN8iL1Z6oje1J5HsH5ACGAgVhQNBjBcsfXfUDqVCCNmeCyAp5ehf+RIEemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24041a39005so37650425ad.2;
        Tue, 12 Aug 2025 12:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755028372; x=1755633172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGZX7VlSW0LiYWlY8lqgNLUDW960h+8kYKNvFAOEEg8=;
        b=MAPIWYP3p4ujpL+SmDPIxEwX1g2ihncvjIT8k7gsgWvIaniX0kf55zK8Z+7A5pes96
         2IniWDQpSPYSaRBqOQ/g4HWjBTxGnxzUFVwhyFmvGDWN23QbcxfnX1NjnBxaAn1aQSl4
         wiofSjSiFx1R+q3+0lTqXSRVxhaU8jbVybKcBu0T5P2UFKOv80O4wMVmfUCsM2h7bxOd
         EVUI5twLxe9dV8y0TJT5Bvbm7sTeBnj/YI7Z5g6h3WrJ8qnJjBzPFOBeRio4DQ/QONPt
         e69mEzZV7sMNXxsasy9WvuRPzK7qaqqL9YY4FwB5rUE7XLqqW/P/E4KU6wKU3ilmoZTR
         /9LA==
X-Forwarded-Encrypted: i=1; AJvYcCV/mD4TKeK4MuelcWbSmeGF9WMOrruKZ4PLJgkdpGgML9QXZYOq9LJNH4U9k0WY1vNAWad4yEyVqAQ9eOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS950rbjsz1Y1nHXFm+whNBeGU7CESqL7gbab6nErXY1Mdi63c
	JoZbR6UYlDca3RvAOM3d3iLIoV6rP43cgwx7vgV+KIegfysH+k7QKsRGdn8x+A==
X-Gm-Gg: ASbGncsFA+8YcsZbNddX40eKlrbhk4tkZhm4cAw4cP7FIJ4/NI50oANTUdZDPE7JAue
	OjYGB/OCoCoREC1LtgFeO6z1NOlblE3H/K0hxHjpr1kQ+f5SDj4ThPPDGwrfwV20i+6jsL5Cqcx
	bXVAfvg2bCH+SnZq5hidY5d1A/qDAzc6XVZnGikDdGu3q7TFtE6vDWA8Pf+1wUl5uiEwe57jIFH
	LQvS5aKdj/zOfWEjCDcKWn+60BmjImXKiBmJ99BKua7dJPPqOk66tDKdyfMOKHDD7PB2W4piewY
	R1UZaePSYWh57nnhCjeqKgMtrzk71OQKgeVpLtiPZ7jH9lSkLrUZkEAEbChDt98BM24FuVPmpez
	F7Kbc0zMEVREUv2XLzw+mhT0SY5FZ8gQJW7dZofhIeTqJec2SElSkA4NK1atGcKTVMwo=
X-Google-Smtp-Source: AGHT+IHT7ZXV8ietv3ter6vWdrRZgM8xAlWihlOf2APQO5CEn5WD2Wzpd4EFVbFMejSPudaAh2wJTQ==
X-Received: by 2002:a17:903:1b43:b0:21f:4649:fd49 with SMTP id d9443c01a7336-2430d219bedmr7575045ad.49.1755028371716;
        Tue, 12 Aug 2025 12:52:51 -0700 (PDT)
Received: from liuwe-devbox-ubuntu-v2.tail21d00.ts.net ([20.187.48.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89768fcsm307171545ad.82.2025.08.12.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 12:52:51 -0700 (PDT)
From: Wei Liu <wei.liu@kernel.org>
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: mhklinux@outlook.com,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v2] clocksource: hyper-v: Skip unnecessary checks for the root partition
Date: Tue, 12 Aug 2025 19:48:45 +0000
Message-ID: <20250812194846.2647201-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HV_ACCESS_TSC_INVARIANT bit is always zero when Linux runs as the
root partition. The root partition will see directly what the hardware
provides.

The old logic in ms_hyperv_init_platform caused the native TSC clock
source to be incorrectly marked as unstable on x86. Fix it.

Skip the unnecessary checks in code for the root partition. Add one
extra comment in code to clarify the behavior.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
v2: update the commit message and comments
---
 arch/x86/kernel/cpu/mshyperv.c     | 11 ++++++++++-
 drivers/clocksource/hyperv_timer.c | 10 +++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c78f860419d6..25773af116bc 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -565,6 +565,11 @@ static void __init ms_hyperv_init_platform(void)
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
 #endif
 #endif
+	/*
+	 * HV_ACCESS_TSC_INVARIANT is always zero for the root partition. Root
+	 * partition doesn't need to write to synthetic MSR to enable invariant
+	 * TSC feature. It sees what the hardware provides.
+	 */
 	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
 		/*
 		 * Writing to synthetic MSR 0x40000118 updates/changes the
@@ -636,8 +641,12 @@ static void __init ms_hyperv_init_platform(void)
 	 * TSC should be marked as unstable only after Hyper-V
 	 * clocksource has been initialized. This ensures that the
 	 * stability of the sched_clock is not altered.
+	 *
+	 * HV_ACCESS_TSC_INVARIANT is always zero for the root partition. No
+	 * need to check for it.
 	 */
-	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
+	if (!hv_root_partition() &&
+	    !(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
 
 	hardlockup_detector_disable();
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 2edc13ca184e..ca39044a4a60 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -549,14 +549,22 @@ static void __init hv_init_tsc_clocksource(void)
 	union hv_reference_tsc_msr tsc_msr;
 
 	/*
+	 * When running as a guest partition:
+	 *
 	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctly
 	 * handles frequency and offset changes due to live migration,
 	 * pause/resume, and other VM management operations.  So lower the
 	 * Hyper-V Reference TSC rating, causing the generic TSC to be used.
 	 * TSC_INVARIANT is not offered on ARM64, so the Hyper-V Reference
 	 * TSC will be preferred over the virtualized ARM64 arch counter.
+	 *
+	 * When running as the root partition:
+	 *
+	 * There is no HV_ACCESS_TSC_INVARIANT feature. Skip the unnecessary
+	 * check.
 	 */
-	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
+	if ((ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) ||
+	    hv_root_partition()) {
 		hyperv_cs_tsc.rating = 250;
 		hyperv_cs_msr.rating = 245;
 	}
-- 
2.43.0


