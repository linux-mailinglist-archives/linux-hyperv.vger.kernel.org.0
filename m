Return-Path: <linux-hyperv+bounces-2737-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74EF949B1B
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 00:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DCA1C22935
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062BA17799F;
	Tue,  6 Aug 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNUbJG89"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2954D176AB8;
	Tue,  6 Aug 2024 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982387; cv=none; b=eblmEoDUoVlvQu4f8/J7gkpgyZLERlcNoDJDetyAh1Y+g3AYk8rWRaWRGL1CP5Xaem7DXiPhUhemN6kBEU8t27lH3jYd5lI0lVsWey6vHd6LAOu2D4Ks3wKK/eMjKRSCeSeWYuha2DmzfaxayD6x7BVwMh48d3YlvxpPdDlOZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982387; c=relaxed/simple;
	bh=GvAvetipniNPqDCAsSTJ2tKWGXpPgxdxr/ozQTWDvlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yol5ohQFfMPIEX4o6T5WIrLMBzbDwnUzBin7scxQHaScEzP2DaJdKvQAzZK4EB0FOL6Q9G4h9DpFEakOMv+hrZnnwRhX2wgFwtpCoMDCrLmoDDZ3f5B2hLaxy8BmF3OPnSWI8T/tpquo6FV4CJZUVWrceIWrWNA6AxEBadgbNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNUbJG89; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982386; x=1754518386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GvAvetipniNPqDCAsSTJ2tKWGXpPgxdxr/ozQTWDvlk=;
  b=lNUbJG89xzqttfZ5O/PjOEYayu53aa2k3tmBxa7e/sekh4B/c1R1RKO0
   mCFf3iKITNNht6b7r2u4BEOC6t4PE6glH81wWvPm63PI92yNU4FrcVpMW
   ZopxEuo14rnGcH2Usf2+JmHESI4PzCUeUHZta1v2WVDG4j3bVbX7onsOP
   ZnpftkDyWa67Ayrtm+ZUykytbNsXRh70gZrseSTke1fnnLmMzuRa4phkH
   LLq9JK6gRS34km0Mz15g4shiM632bd6Vy05lJI953GRYUDh9kMbM54W8K
   7LUiS5v3h2QkGEwSpLwb1pt+qy1T3Eh37AwSzZ1bBQOCUlYHPNf9xE6et
   g==;
X-CSE-ConnectionGUID: Qne+LIBSQFi7o0xsl3Sl5w==
X-CSE-MsgGUID: Lq9DLeo9QXax/YCyn3la0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38534405"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38534405"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:13:06 -0700
X-CSE-ConnectionGUID: R6lNlHPWSLuWhnu03N0OBA==
X-CSE-MsgGUID: tu2pjLBeRdqKJzGInNHZmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61465646"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 15:13:05 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	kirill.shutemov@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	yunhong.jiang@linux.intel.com
Subject: [PATCH 5/7] x86/hyperv: Mark ACPI wakeup mailbox page as private
Date: Tue,  6 Aug 2024 15:12:35 -0700
Message-Id: <20240806221237.1634126-6-yunhong.jiang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI wakeup mailbox is accessed by the OS and the firmware, both are
in the guest's context, instead of the hypervisor/VMM context. Mark the
address private explicitly.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 arch/x86/hyperv/hv_vtl.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 04775346369c..bfe54afcdf1d 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -22,12 +22,28 @@ static bool __init hv_vtl_msi_ext_dest_id(void)
 	return true;
 }
 
+/*
+ * The ACPI wakeup mailbox are accessed by the OS and the BIOS, both are in the
+ * guest's context, instead of the hypervisor/VMM context.
+ */
+static bool hv_is_private_mmio_tdx(u64 addr)
+{
+	if (wakeup_mailbox_addr && (addr >= wakeup_mailbox_addr &&
+	    addr < (wakeup_mailbox_addr + PAGE_SIZE)))
+		return true;
+	return false;
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
 
-	x86_platform.realmode_reserve = x86_init_noop;
-	x86_platform.realmode_init = x86_init_noop;
+	if (wakeup_mailbox_addr) {
+		x86_platform.hyper.is_private_mmio = hv_is_private_mmio_tdx;
+	} else {
+		x86_platform.realmode_reserve = x86_init_noop;
+		x86_platform.realmode_init = x86_init_noop;
+	}
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 
-- 
2.25.1


