Return-Path: <linux-hyperv+bounces-3042-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE8C97B879
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 09:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAF61F243C4
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 07:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F561779BD;
	Wed, 18 Sep 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeS8RSep"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541E170A0E;
	Wed, 18 Sep 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643916; cv=none; b=BPIvXZdGecdeRWXU+lADnz0nLcQ4lOkKhiyAtYbU+r+V4PWZjbtHRqKO6lBktxaDCcdwlYZ4n+x71agrQwS1NQxcg0Pig1FDS6tXF6ShlJ+SDvh8GvCBc73CTSTmUlVUhDaxYlnmRQEDbTiupNxu8dl+0zANU0Ikb8NYMSlND8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643916; c=relaxed/simple;
	bh=hh+WycHH6Z6p+W6icKMvD7SXRmmE5UIy5QgBOc1EhWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evwuWmTPFPLz83ouIWme0EPjtVLu/XpZ75nR/873vWWJi7RW3KpWSB8VMkths8BEza/bJ0prdGPwEzJmrpGi1zPfNXeREvkOteDTVVr6DHb7EcxQZba4ZYnWbqkDssnnsNQbBHIxFoSOhlrSkYPU7G7P2LmKwIcQbPDe3MxISX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeS8RSep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F3EC4CED0;
	Wed, 18 Sep 2024 07:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726643916;
	bh=hh+WycHH6Z6p+W6icKMvD7SXRmmE5UIy5QgBOc1EhWg=;
	h=From:To:Cc:Subject:Date:From;
	b=IeS8RSepcS3GOBxamo1kITCmvyoN2a5n5vTrnHY6JVAKWDyEoOcY6moC+BKgDT0v4
	 21Z+flXe//Ee/DNRRYMp0yokeA7h6Ttv/n2bAPslSZNvPbD5B9fu3HhoMTTFbJqYRs
	 KfM1K4M0nx+r9LLaV/gHR7W73QJmitT83tb2myfQj9zVM04bP1n3SO8Oh00DsoiD/j
	 HC09YUGKJGVifJP+xMMsIoOthIE4vLErs4k2n223TnPMlzcwwKZQnbd8TVvG3bBw4Z
	 n1Z1SsD4ggP1ToObkOanc6OnE+7Cz8EsqTh6gOOqprfYauqRIpgK+3QCk1whe7/Crd
	 ToqjYbMQA7uBQ==
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
Subject: [PATCH AUTOSEL 5.10] x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency
Date: Wed, 18 Sep 2024 02:36:54 -0400
Message-ID: <20240918063655.239021-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 021cd067733e..a91aad434d03 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -275,6 +275,7 @@ static void __init ms_hyperv_init_platform(void)
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_platform.calibrate_tsc = hv_get_tsc_khz;
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
 	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
-- 
2.43.0


