Return-Path: <linux-hyperv+bounces-2840-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D00395D9AD
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 01:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0061F24145
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95EB1CFEB7;
	Fri, 23 Aug 2024 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbJkAc59"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199881CDA3C;
	Fri, 23 Aug 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455439; cv=none; b=TyWNeswZ/q7GkhBLzCuePQDlrXfTRtQveYylgEyI/jwv1PVSwruJ3dJncC2aKM3zfMDxbXqydCKHiF0s2nvuw3Zy3r+6VctZbZpcJWGearvkMPgZjSdKS1ETFy7hP71D+K2qE8+ogcnY0EpMa7GMXacvOUouCs4t2KQXKPPyO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455439; c=relaxed/simple;
	bh=2e7sGZyRynvsWmKdrDBVMnvtPnbG9Uh/7HTPebS7aKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YB0dn2asxWXZ/zYPlR+NeUOcdw6joN1OiUCZJEaH1MpSV2rE3JpsITFvm4d/rI6hlcAC5mbp0xZpDIoYB62oJv//fUOtSDpOBpC1ILpCNXdA+8sE4BZgWfw/jF+PiHy4J80x0lb9SeCFF+r8ptOdXbkMQUmebIzeB0qY3bEOens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbJkAc59; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724455438; x=1755991438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2e7sGZyRynvsWmKdrDBVMnvtPnbG9Uh/7HTPebS7aKI=;
  b=kbJkAc59wGFXPBe3P43RjI0X6wYH2kT5NzfsypBNJDsM3TT7+mr4zqWt
   jRMSJTyDq0RRNZ+gmkZ4sFFq/Z7X8ao0O6p8aomCqvx2bQvl65cMz6TGz
   W9s2by3+yUbtT8d93nNArKgsIEDm4AHpLQKvvUZnq+hPet8Z/id9siqV6
   PPBGekoZzpGfMiRIqlG1xpNrDt1hPwxl3AVkJtTZn2EJ3Mei5mjhEPFHc
   OGfqW99+jUcvkolxPcdp8N0Nd6ZLe6ggWlBOkZeQvuVh9889xfiROMLCY
   8gu/F5wzcab7N8PVMvi6tuNg2WHur84vRPYZ2FuuTEN1StlxA7mLmG0MI
   g==;
X-CSE-ConnectionGUID: cKKh1XcNSSqKzy546fWJ7A==
X-CSE-MsgGUID: yEa+ElfTTUObhm3TdMnJnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33619319"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33619319"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:23:54 -0700
X-CSE-ConnectionGUID: bxBRT0axQ/i/+COSXSIVgg==
X-CSE-MsgGUID: VUbrnRePTcmM6DK6x9C5fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61641017"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by fmviesa007.fm.intel.com with ESMTP; 23 Aug 2024 16:23:54 -0700
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
	kirill.shutemov@linux.intel.com,
	yunhong.jiang@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 7/9] x86/hyperv: Move setting the real_mode_header to hv_vtl_init_platform
Date: Fri, 23 Aug 2024 16:23:25 -0700
Message-Id: <20240823232327.2408869-8-yunhong.jiang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the VTL2 hyperv guest, currently the hv_vtl_init_platform() clears
x86_platform.realmode_reserve/init while the hv_vtl_early_init() sets the
real_mode_header.

Set the real_mode_header together with x86_platform.realmode_reserve/init
in hv_vtl_init_platform(). This is ok because x86_platform.realmode_init()
is invoked from an early initcall while hv_vtl_init_platform() is called
during early boot.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87a5ho2q6x.ffs@tglx/
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 arch/x86/hyperv/hv_vtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 987a6a1200b0..e5aa2688cdd0 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -44,6 +44,7 @@ void __init hv_vtl_init_platform(void)
 		x86_platform.hyper.is_private_mmio = hv_is_private_mmio_tdx;
 	x86_platform.realmode_reserve = x86_init_noop;
 	x86_platform.realmode_init = x86_init_noop;
+	real_mode_header = &hv_vtl_real_mode_header;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 
@@ -259,7 +260,6 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	real_mode_header = &hv_vtl_real_mode_header;
 	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;
-- 
2.25.1


