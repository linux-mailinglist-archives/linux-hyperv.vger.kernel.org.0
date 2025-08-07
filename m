Return-Path: <linux-hyperv+bounces-6506-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFB3B1DC08
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Aug 2025 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D883A9237
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Aug 2025 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E0926B777;
	Thu,  7 Aug 2025 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfOqAIBm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5BA1E5207;
	Thu,  7 Aug 2025 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585930; cv=none; b=Un2CVLVo/RM+MQVvgoaWGd6GQ2F528aCeV5k/n1k9MIulT9hCSptaHcgJ/a+dOkX4oEgHUAf5nOpPuuWNk+BcE5Zdh/858yB5i4ixIq41RwOP3FBLAq+nWwKFNhNKRQiwd0t+V7wzkLXWsdozDDEGksxgIRHJCCLNnNZkbGiQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585930; c=relaxed/simple;
	bh=L9kJeILxhivms4kbpTOCUGDER7CKIe19iSx5Rex2KxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVT7dOr3zXSGCc1LtB2cEX1izINmpP+oN2+GtcO95DroDQTdfUzThPR+50vh+ji1o8XS/xtDAxvFu+Uqt8ae7W0+cKZKntuABKhvLXxLtYBqF1ocgokiFroFRjd6cGp3pmGg+n/H1XLfUyNrkSaoC7x3NrSHlTA5DBh5V08Ul8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfOqAIBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEAEC4CEEB;
	Thu,  7 Aug 2025 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754585929;
	bh=L9kJeILxhivms4kbpTOCUGDER7CKIe19iSx5Rex2KxY=;
	h=From:To:Cc:Subject:Date:From;
	b=cfOqAIBmxn6DPFAcC8Y/YfW/5sxGu40s+t3EH0hKSBosWdf6TB9knDw7hvmG93uHh
	 q1ZJqRJGPWmrzyZ3q9wUVlQr0tEechca2LdTJqq5WARYRcFZ7E0liwDoELjlDX6jVx
	 zYQgF6JUpgjJ0TJ/42UnUh4RKJ3oKgP2kMq2hL6HMeI2TxCXT7RL60hPar0v9h0MP6
	 tBVJhd6DH6TAFKNh2NcMsiWlEZ1aiBjsHdyNkSD8DUM/xfMcwnKNxLn5oiyrHndORy
	 +62vlvE7hFYEih5uMo/r8XXw4G1h0MGL0uOTkaMtLZNT6DnbFMg76Wuu3AtdPRzmBy
	 TFEwCGwo0X4hQ==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
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
Subject: [PATCH] clocksource: hyper-v: Prefer architecture counter when running as root partition
Date: Thu,  7 Aug 2025 16:58:46 +0000
Message-ID: <20250807165846.1804541-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

There is no HV_ACCESS_TSC_INVARIANT bit when Linux runs as the root
partition. The old logic caused the native TSC clock source to be
incorrectly marked as unstable on x86.

The clock source driver runs on both x86 and ARM64. Change it to prefer
architectural counter when it runs on Linux root.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
Cc: Michael Kelley <mhklinux@outlook.com>

Pending further testing.

The preference of architectural counter over Hyper-V Reference TSC for
Linux root is confirmed by the hypervisor team.
---
 arch/x86/kernel/cpu/mshyperv.c     |  6 +++++-
 drivers/clocksource/hyperv_timer.c | 10 +++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index fd708180d2d9..1713545dcf4a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -966,8 +966,12 @@ static void __init ms_hyperv_init_platform(void)
 	 * TSC should be marked as unstable only after Hyper-V
 	 * clocksource has been initialized. This ensures that the
 	 * stability of the sched_clock is not altered.
+	 *
+	 * The root partition doesn't see HV_ACCESS_TSC_INVARIANT.
+	 * No need to check for it.
 	 */
-	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
+	if (!hv_root_partition() &&
+	    !(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
 
 	hardlockup_detector_disable();
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index f6415e726e96..59c3e09f1961 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -534,14 +534,22 @@ static void __init hv_init_tsc_clocksource(void)
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
+	 * There is no HV_ACCESS_TSC_INVARIANT feature. Always prefer the
+	 * architectural defined counter over the Hyper-V Reference TSC.
 	 */
-	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
+	if ((ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) ||
+	    hv_root_partition()) {
 		hyperv_cs_tsc.rating = 250;
 		hyperv_cs_msr.rating = 245;
 	}
-- 
2.43.0


