Return-Path: <linux-hyperv+bounces-3044-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4397B87F
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 09:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE14B1F251B2
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 07:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CFE171E40;
	Wed, 18 Sep 2024 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG7rcNAS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75F16C852;
	Wed, 18 Sep 2024 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643929; cv=none; b=TvwJ0c3xuqAr7pVQykEL3s+QD0ih7mD0nG5ycRloLtYSicvDsb4TJeAW3CX8ImXg3eCiP3A4MgNYU8oV8Y0eCHThBzKhuV8oDPWk16+C9TGiHfFvWpdK1M9A7ppUyrbA/LKX2jteL4bDUsp5+AX+9mRFzA1jyyNixAww5r8FRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643929; c=relaxed/simple;
	bh=fIa3wVVCW5R5P5pqEr4eBZ0oenK86QFnyOrqyo7qkg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLp21CDP8FMowPbvTD5HqKH+O4pwmV/YQFRQfWR4YnV2mo+GYA7/L2hOAPbXzpYC+po7ioDg7Qmrp8wB4Z3dIy3ilj2kEeDW2M3K82BhHAsNUC7rw9UkGgEeq+D7rC+NiUic8A4mbHhjepDoSdaYYrgJZ1FJRIWZz9IB6JGKnRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qG7rcNAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD7EC4CECF;
	Wed, 18 Sep 2024 07:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726643929;
	bh=fIa3wVVCW5R5P5pqEr4eBZ0oenK86QFnyOrqyo7qkg8=;
	h=From:To:Cc:Subject:Date:From;
	b=qG7rcNAS8gq6STwMf58yCPSkjX7YgPGGIePxUtN/5iK1I8QZogjKHorz97NCBnxJu
	 6/MySugP7nAIe0UuMAGkswisiQhqakMdxmPqpGjIz+UDFE1TVjjYFGAFJRdelwfLqf
	 ylbDq1pojNbbNfdkx+lkruUcDMGR6zIX4yFwh6mKBPrLy6ufOjApa2flckTeWjKXp7
	 zlH2RDANtsgE5B/M81DcXUaHlf5XCJbZwrRJhpPwux/3GgBMUidinsmBcGeONFsGCf
	 mKDK2XTjo5RbEpejNJSj8R8R7MDFeI9t9s7lKqsw8XzL8VZa35DEW/21GSHmLvhY12
	 XIviAeCpH0qOg==
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
Subject: [PATCH AUTOSEL 4.19] x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency
Date: Wed, 18 Sep 2024 02:37:07 -0400
Message-ID: <20240918063708.239096-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index f8b0fa2dbe37..b43f25b3c99d 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -243,6 +243,7 @@ static void __init ms_hyperv_init_platform(void)
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_platform.calibrate_tsc = hv_get_tsc_khz;
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
 	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
-- 
2.43.0


