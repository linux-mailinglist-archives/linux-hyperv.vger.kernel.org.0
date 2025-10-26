Return-Path: <linux-hyperv+bounces-7332-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84536C0AB51
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Oct 2025 15:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E003B2EEA
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Oct 2025 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864F2DF15E;
	Sun, 26 Oct 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCqrYxQx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD841527B4;
	Sun, 26 Oct 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490254; cv=none; b=frktvhB4pS4eqrajmU1EdBDWRWHTpDPgXe+wUy6ePikrFSM5fMiMuimlnjOz8yOTftGfoCVnlc1K7r7svRSm4Kaa0ZkGecpt+2J2m/i8d5uf+NGX1HGyocb7QscKsJUiQIlj7BDEpj5F7UZCVqyL+u8HJUCkNgrX1BryP2hDEKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490254; c=relaxed/simple;
	bh=tZ1b/j/xd1u/qe2VCxt/mPYUg7poWAV2HiZHY/okZbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5f9EYof9X7PZ04p6dTfZL1oVr/LubQT0G16x9lQkusYtMxG3shcpbnLadrJpVmlVYt+OvsZB7fpP0ILLTWmBOrVBO9c9jxYe7RjqcosGVm0/1SkrNAQQyLE6xKQrEvKto5TLztIcLYdlFd142IXMSBVIRXPF5BH1k0RCxm7qyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCqrYxQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2482EC4CEE7;
	Sun, 26 Oct 2025 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761490254;
	bh=tZ1b/j/xd1u/qe2VCxt/mPYUg7poWAV2HiZHY/okZbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCqrYxQxmUvs67PQ1gnztDLpP6E7DtwEX/RUh+inS+saHLxYfIlXmlIz4FyeMLbsG
	 7GDW0oxxljkLSzxM/fXJjnKD7RUhVk+HvVrI8Ljk528OMnjCpbQFa6w6T8GC4nW3Fx
	 5EI6FSoPIr/BOls5HnRVI3owOGdmOSMCFFtX8sSMLdDYTg7e+eYiGQ2mk8q9Z7KUF5
	 ygXnIRymU3ZIcKRg9FVILQe/kRcPYzhSCB215bQ9pZ2CvGBhRsW0y8FhF6V2wM8FA7
	 5mIysJlWkpZym+sVxzKlPWqPpwvmYuDbY6LxD5n3iAKZQJwd2zzFzWPykeY98rGBfz
	 vGkTSE2aSSjwg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wei Liu <wei.liu@kernel.org>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] clocksource: hyper-v: Skip unnecessary checks for the root partition
Date: Sun, 26 Oct 2025 10:49:03 -0400
Message-ID: <20251026144958.26750-25-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026144958.26750-1-sashal@kernel.org>
References: <20251026144958.26750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

[ Upstream commit 47691ced158ab3a7ce2189b857b19c0c99a9aa80 ]

The HV_ACCESS_TSC_INVARIANT bit is always zero when Linux runs as the
root partition. The root partition will see directly what the hardware
provides.

The old logic in ms_hyperv_init_platform caused the native TSC clock
source to be incorrectly marked as unstable on x86. Fix it.

Skip the unnecessary checks in code for the root partition. Add one
extra comment in code to clarify the behavior.

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – this fix prevents Linux Hyper-V root partitions from unnecessarily
downgrading their primary time source.

- `mark_tsc_unstable()` is now gated by `!hv_root_partition()`
  (`arch/x86/kernel/cpu/mshyperv.c:655`), so the native TSC is no longer
  flagged as unreliable when the kernel is the Hyper-V root partition.
  Without this, hosts always fell back to the slower Hyper-V reference
  clock, hurting timekeeping and scheduler precision.
- The Hyper-V clocksource ratings are lowered for either
  `HV_ACCESS_TSC_INVARIANT` guests or root partitions
  (`drivers/clocksource/hyperv_timer.c:566-569`). That ensures the
  hardware TSC regains priority on hosts, matching what the platform
  actually guarantees.
- All new behaviour is tightly scoped to the root-partition path; guests
  still see the old logic, so regression risk for common deployments is
  negligible.
- The change aligns the code with the documented hardware behaviour
  (root partitions always see hardware invariant TSC) without
  introducing new features, making it an appropriate stable fix. (On
  older trees that still expose `hv_root_partition` as a global, this
  needs the usual trivial adaptation.)

 arch/x86/kernel/cpu/mshyperv.c     | 11 ++++++++++-
 drivers/clocksource/hyperv_timer.c | 10 +++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c78f860419d69..25773af116bc4 100644
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
index 2edc13ca184e0..10356d4ec55c3 100644
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
+	 * There is no HV_ACCESS_TSC_INVARIANT feature. Always lower the rating
+	 * of the Hyper-V Reference TSC.
 	 */
-	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
+	if ((ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) ||
+	    hv_root_partition()) {
 		hyperv_cs_tsc.rating = 250;
 		hyperv_cs_msr.rating = 245;
 	}
-- 
2.51.0


