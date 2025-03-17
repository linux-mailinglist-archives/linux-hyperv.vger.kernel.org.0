Return-Path: <linux-hyperv+bounces-4553-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A996AA65842
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 17:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459CB3A7CC2
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF951A0BD6;
	Mon, 17 Mar 2025 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUdtDrGp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426601A00F0;
	Mon, 17 Mar 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229449; cv=none; b=cHtZ4/Q/h5jEZVuOCeHLdHsucAbuDPoEKDeb87uTGWxN96y3MPdFO4iLSCTTwQhK9uCCupsDLe14GxoIfJvsSV1+F9wANbalyoPLogY4hH6kBl4cVNZFm8LEGSdqc/QT+JpLjnLzh49kFjkDGqNKoQAFeNN/eF/H5MWGys8YF4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229449; c=relaxed/simple;
	bh=N/aRBNxPho1kgMQVdIQBUk7vp1cyQKJPsr48d15Ncd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QGNLDq/jyF8XzV48W31OiWkg9Bw+EOUOtPWWKXcyOzgGiFXta4mquc2lQaMkFP5dVHfKF1U6AEjssaN6Ry5+hy/l5KScuM9MovNisQs5FiwNbr1YIopxE5JX+PJnBKT9/Yjjqdjx8+jFf6uSf6Hi6Dj2dZvYxApv1AaDy+KnC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUdtDrGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010CAC4CEE3;
	Mon, 17 Mar 2025 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229448;
	bh=N/aRBNxPho1kgMQVdIQBUk7vp1cyQKJPsr48d15Ncd8=;
	h=From:To:Cc:Subject:Date:From;
	b=jUdtDrGpgs/ChDc98BmwBjXLkvgcajah+UEnTjFTd+i+nrJS1xPdHDUg1TYFObOZv
	 yGNj3X5fl0kVKjfz9gbkQMiqlEv7tMG79KiwDxuVKS08FSBcCq5dXvBLWlq/2hlMAP
	 N37ly1/tI8Gndvcr3bZtM+Qq0nuhhbYEVw3Y/kuU39pDvj24RhVgew72iEUiTscNlv
	 pjip3S1PmLu2H84BXVXtwYXFpXf3fqFfWJ2x65Zmg0UWUg8nqi0rUPicG4JmAv5hmv
	 t2Ofv2m6btpBB2J2crxLF8AF05pvUf/nCtmbQpRSdpJHXEiKKuZl6OQvOl45Ol90M9
	 OMrlAdpIp13Wg==
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
Subject: [PATCH AUTOSEL 6.13 01/16] x86/hyperv/vtl: Stop kernel from probing VTL0 low memory
Date: Mon, 17 Mar 2025 12:37:10 -0400
Message-Id: <20250317163725.1892824-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.7
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


