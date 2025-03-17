Return-Path: <linux-hyperv+bounces-4555-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FD7A6588C
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 17:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB43A17CEB5
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 16:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE731AF0A4;
	Mon, 17 Mar 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBd6lIRm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83201AA795;
	Mon, 17 Mar 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229504; cv=none; b=SI9P8UvwmvqFK4zbnkdBLSCTIPMqsQcypaUpliGoGvjbR9aMZge8QKx9pr8MykefNWufLvC1HARrbZqtY5O+X6KSBXVzFu8l1cABQchVf4VU3/abmZCT6tKNy+0xoBKbqfWpJkwxQFE/ycB8/1txgaeor8ywhrE21uAf+3RxEZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229504; c=relaxed/simple;
	bh=N/aRBNxPho1kgMQVdIQBUk7vp1cyQKJPsr48d15Ncd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cvAS349KFWUob2qHUzzG2sca4HAGG2eL2gv07VaeHSq2zf44asfr9lImz4Or1ZqV+DfDNJkr8TOK/mzIxENhQEnnoom/+WHiM3IP+r7XDjwonKgw9ZH6ymd5RHOegbOIak3Adea9Kiet8tH09O4S3P6FjYr6adj+2r1cZgm81Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBd6lIRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9957DC4CEE3;
	Mon, 17 Mar 2025 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229503;
	bh=N/aRBNxPho1kgMQVdIQBUk7vp1cyQKJPsr48d15Ncd8=;
	h=From:To:Cc:Subject:Date:From;
	b=RBd6lIRm1hIWxm0KUeLj7d+UXMQdXGpBSyZO/q0qgLiTEptbB240lZjInIYnkBcDC
	 24UUVbf+cYbnzBmlVpsojn2X/cLpJLStnJekoHZxRaGA+ZfkAngQ3mcws1IFhaOFjK
	 GzkEa9PRMW2h+9sr9uzssHHCX37Ju33eJTy9Bc059354isq8togX1gM52QXEo6WidW
	 13oCCKWqrZfeIGau4gfFJirkpeCEgVJMFOIuvdC9g5aYmVDF2nMXhIz7Fj6fBOGTAJ
	 WyfeFzgXbTT8DNxAtc1IYzoKBFol/4uuuP7lAi+ptLTQedDZfzYsFGcsZmbsyQiKrK
	 QSSaF5tEeHkCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 01/13] x86/hyperv/vtl: Stop kernel from probing VTL0 low memory
Date: Mon, 17 Mar 2025 12:38:06 -0400
Message-Id: <20250317163818.1893102-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.19
Content-Transfer-Encoding: 8bit

From: Naman Jain <namjain@linux.microsoft.com>

[ Upstream commit 59115e2e25f42924181055ed7cc1d123af7598b7 ]

For Linux, running in Hyper-V VTL (Virtual Trust Level), kernel in VTL2
tries to access VTL0 low memory in probe_roms. This memory is not
described in the e820 map. Initialize probe_roms call to no-ops
during boot for VTL2 kernel to avoid this. The issue got identified
in OpenVMM which detects invalid accesses initiated from kernel running
in VTL2.

Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Tested-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250116061224.1701-1-namjain@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20250116061224.1701-1-namjain@linux.microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_vtl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 04775346369c5..d04ccd4b3b4af 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -30,6 +30,7 @@ void __init hv_vtl_init_platform(void)
 	x86_platform.realmode_init = x86_init_noop;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
+	x86_init.resources.probe_roms = x86_init_noop;
 
 	/* Avoid searching for BIOS MP tables */
 	x86_init.mpparse.find_mptable = x86_init_noop;
-- 
2.39.5


