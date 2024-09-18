Return-Path: <linux-hyperv+bounces-3041-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A33397B875
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 09:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E229AB24F20
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 07:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3533516FF5F;
	Wed, 18 Sep 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU7b3YON"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98C16F287;
	Wed, 18 Sep 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643910; cv=none; b=pt7v9/w+Duh+8SpC0DtIX84BP+wkVlTJ3Opblc7djep3uFkyqFHIrAeq9HUharN17cM86WamD0owYo6hA6PaoTQX1mY3FuGmPS3SBrhJI9w0PE/vlr44H/7zz/IX+LaC+rmA7a/OeS0AmfAI1RCLdl4wEbXxcNPTiEoxMlFSESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643910; c=relaxed/simple;
	bh=dnhsqbCOWUoit2/9tPUNmsQl94NPOfYnbAOX5RPxv7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tq04u1K9b1woXjCd9h/h+jxHvSSEmcwRJezvh059yn3l08SAs4fFJUa48PbUM77i6+ZQDZVJ6HB2IlycHmAKs8mrRzh8Zb2ZbEqMWMvR5RFUOb66UvzOCdMMv8SjNclQAcNxKihApZd5bXOGHMN4Oh0nE43mZYtYbiTaZ1hxelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU7b3YON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766DBC4CECD;
	Wed, 18 Sep 2024 07:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726643909;
	bh=dnhsqbCOWUoit2/9tPUNmsQl94NPOfYnbAOX5RPxv7c=;
	h=From:To:Cc:Subject:Date:From;
	b=LU7b3YONrWlGhrp3nSqm3b5/ds8QRFH1PLlcHCd0IS1w1+8r6V15tkEf1UArpq9be
	 QAD5XVduz1zelZPS3J2UdWkqGhEptDydxH8a3haFp9hVXyoaDJYFNK7Cquo4eoNTkL
	 md4MZULMilFVVI8R+ffY4kWZe8B+M5MbgKpMNf9Cwjya5mLJPoFOMTF6A1hQZbK3Cg
	 TDQx0zA2tsgkaO4bCE+QRE9C8s+zdefzYGRzRqZ2kYe9ojhnvKYjaaZsLOIvUzOjDI
	 SEY2M+IB/c601mAxCJPjoIGDEis7GK6/Gm96CADdnHxSKOipTlJyJoGnOtbX2f2aI4
	 N8vYWtx/ZksbA==
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
Subject: [PATCH AUTOSEL 5.15] x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency
Date: Wed, 18 Sep 2024 02:36:48 -0400
Message-ID: <20240918063648.238989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index 8d3c649a1769..3794b223fd69 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -322,6 +322,7 @@ static void __init ms_hyperv_init_platform(void)
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_platform.calibrate_tsc = hv_get_tsc_khz;
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
-- 
2.43.0


