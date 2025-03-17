Return-Path: <linux-hyperv+bounces-4557-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A23FA658BA
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6BA189DDAB
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537721C6FE6;
	Mon, 17 Mar 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwMz313e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C41C07DA;
	Mon, 17 Mar 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229546; cv=none; b=giWa4x9mFi53zVFVps6OkYiipdcNbAO7fAHuPg9X/FAmBabqIWQPCme7xp8EUo9gCjA5GPRgsXCb/36GFY0qQ03W55BS3fYMyf+dP6wo998jz6uF99scdheguWshguyuZNopZR2urDWmZOFtHUfaf7yhMjP3hpCtUwqKk7x08Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229546; c=relaxed/simple;
	bh=z0/rcr6pKsVrPCadWbOR4vFRtxHFCNxR8+1qfGyjtPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jxo5sv9bltvrOK3DEEmmaHfC+XorTizoxu6WitDZcxqpcbyW+5r1a42DsRFoQ5a0SFBThoc/6RmWQvBXi21rB8bQzNbL9n7LJ+DfRUirvVCN4jQ1k6vTLuvUAAfElJ2eJjsToK/NAS2/O5OB4FV1ZuGommy3Dbf7TUEgjbDkc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwMz313e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47496C4CEE3;
	Mon, 17 Mar 2025 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229546;
	bh=z0/rcr6pKsVrPCadWbOR4vFRtxHFCNxR8+1qfGyjtPI=;
	h=From:To:Cc:Subject:Date:From;
	b=RwMz313ecKnpVn7ZI0hdMKOhvOeWi0gc813yhza7a4HGJY1gsqCobd1fzPmrSUOGj
	 prJKUyPxVvpH5krVslIgmT8If+a91ZPmc/pLN7LTGfEbIUTswM/oi3OnO6yfULkGA5
	 58iYQgOjs0g/o3m0aPm+ytLHWaOBdr+N7zQq1MDBOo57AqoIAP6CAcjzrJtG0uOExN
	 VMgHYXMxQAo52xaZAg4hbMSFOQbYcTk/jmmI/bKr5i+R4yixN6/VbtH+4Y/ms2KW8p
	 l/XucbWA75Da/8pwZTD2kZWxosbYhMVR1prhpfLohN6+aJOEcAS8XP0thv9xYxCRff
	 +NCqXQJ8Ch+AA==
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
Subject: [PATCH AUTOSEL 6.6 1/8] x86/hyperv/vtl: Stop kernel from probing VTL0 low memory
Date: Mon, 17 Mar 2025 12:38:55 -0400
Message-Id: <20250317163902.1893378-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.83
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
index c2f78fabc865b..b12bef0ff7bb6 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -30,6 +30,7 @@ void __init hv_vtl_init_platform(void)
 	x86_platform.realmode_init = x86_init_noop;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
+	x86_init.resources.probe_roms = x86_init_noop;
 
 	/* Avoid searching for BIOS MP tables */
 	x86_init.mpparse.find_smp_config = x86_init_noop;
-- 
2.39.5


