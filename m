Return-Path: <linux-hyperv+bounces-3039-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A9897B86D
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 09:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753501C211AA
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 07:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42C8173328;
	Wed, 18 Sep 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okCLpWbx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FFF171E73;
	Wed, 18 Sep 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643899; cv=none; b=J0bYIykUPyBBG1vS1A/9G0UYevw5zTIqLeFQGotRFcKaiZevbJCdDidGMYx/k+czM0O0mCOZs71EWMWZQQvg6uA3V5cnr0PHM3vl8vnkGg7rvjAGTA93BorBo8oK5FdF9kxIid7Vr6mG9fIafb0EI8Xgv7tWOLRvHn8Idw9l6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643899; c=relaxed/simple;
	bh=zRxhwi9fkMH/RYkf+wX7A7MBC9h06ZQ0ELjsZ+U6ZVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NE7vwvDKxgbavWK62cYM3/DUgwuJCJ7H1uPm5sShNXDR5mHzesCaA9sN3n0G3WrMRcYa7O+LCNtVdFBE7LIT12Y0WomBZIrN2F/oVhIugLpIRdvHTNzJVoCWQqqE8V6dvR/1iVZVo/Ct5fY18CvWdPvMWuWW2r5wRoAjFb7It80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okCLpWbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F78C4CECE;
	Wed, 18 Sep 2024 07:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726643899;
	bh=zRxhwi9fkMH/RYkf+wX7A7MBC9h06ZQ0ELjsZ+U6ZVw=;
	h=From:To:Cc:Subject:Date:From;
	b=okCLpWbxqgUCtk9NdYTQWt2c+DRnl055R3zhNBBw2DdcBc90DMUr3kDVsWPrnSpJK
	 mLfJZx9sfi+6pqTzzOHDT+N6zqdImLo/wi27XJKpMNd/ABpphu9uInMOVeRgiGmW2X
	 HwpPK+Ra2Gn1HOHsxut1bs18L7M5I/7WDdZ0rQEKvJQwyudZKHWNAMtQN78xrvH7k+
	 kBZ9jSwZaV71u4qFTBtdHyTq9lMOMaeq8Opb4Eu8caW3PQzzkeVIvzjd4HFst92EBN
	 Aur7la8EncPZ1dWDJE+cXU8Cm0VazZxUkDWaNfI7Kv8qLi38j1cZVA1tdslkrerkLi
	 sVFAB1gPPzIiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Kelley <mhklinux@outlook.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	sthemmin@microsoft.com,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/2] x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency
Date: Wed, 18 Sep 2024 02:36:36 -0400
Message-ID: <20240918063638.238937-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.110
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

[ Upstream commit 8fcc514809de41153b43ccbe1a0cdf7f72b78e7e ]

A Linux guest on Hyper-V gets the TSC frequency from a synthetic MSR, if
available. In this case, set X86_FEATURE_TSC_KNOWN_FREQ so that Linux
doesn't unnecessarily do refined TSC calibration when setting up the TSC
clocksource.

With this change, a message such as this is no longer output during boot
when the TSC is used as the clocksource:

[    1.115141] tsc: Refined TSC clocksource calibration: 2918.408 MHz

Furthermore, the guest and host will have exactly the same view of the
TSC frequency, which is important for features such as the TSC deadline
timer that are emulated by the Hyper-V host.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Link: https://lore.kernel.org/r/20240606025559.1631-1-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240606025559.1631-1-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mshyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 9b039e9635e4..542b818c0d20 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -324,6 +324,7 @@ static void __init ms_hyperv_init_platform(void)
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_platform.calibrate_tsc = hv_get_tsc_khz;
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
-- 
2.43.0


