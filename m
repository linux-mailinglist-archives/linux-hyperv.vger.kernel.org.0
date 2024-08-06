Return-Path: <linux-hyperv+bounces-2738-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D3949B1F
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 00:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5213D1F22F5C
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A32617838E;
	Tue,  6 Aug 2024 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbrTeDy8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88526176FB8;
	Tue,  6 Aug 2024 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982389; cv=none; b=pu4vodxPWvXc7VlDoXbQxfrGN5hvROHkEBSLppH/3ncVXQli8GI96YUC7qzfG8aC/O3Hm+8VhKS1HVZRXougfoqQzZST9VNDfJt0lhuJ29QMrEXxg5nnvK0xabEGAGwvygUIP3/UHJmrzvbW1WpXl6ooEAYI6dtySeR+HZmy5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982389; c=relaxed/simple;
	bh=ZUq86fmEIT+y08JWAU6WM9quSZ2U1+eaMw8WLXb0+0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmZrX9fQGESiB4cwuBpGjTd3/VIBtXTboCA7ZmDMXLzCBIvCX+Va7eB3SfnVcC//H0j4sfr5k2OYoIqR3X8urgyFIAVtl6G6fHYElqxjDaVMRFbORp71oBz5Sk78ahK6Dfkiso+auRMabhMIslC47QWqOYikVboJYzo+8y4aY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbrTeDy8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982388; x=1754518388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZUq86fmEIT+y08JWAU6WM9quSZ2U1+eaMw8WLXb0+0I=;
  b=nbrTeDy8K5vCFF1cwX2G6CM47gqlHP4DrWT9llPgQKWShqsBKGsLjn0g
   DPB0mQTks/TgJSbQNv3UmYe70oiDbAs1GV6PNTnyrOKtU2n+YSiMl9FEx
   ZfXQJIXmlk64kCGj4Pdy7hpAVEmsT0XeatP4ZREn15IEKJ2NeEVXAAEdB
   i+lHKoI5PaY/DEsonxKO8RKwmGXmJBAaFxm2KJk+YDuriHtufj71g6VPR
   /PCZfui6kMWgFSEiMK0D9fc6JCb2mFxU30Wkftj6TPeJpZwEvGSeaLYzQ
   NOKjfJaGT5zS9KDREaCypHnqdvGhxHUqYNlhnxZD48Qt7AurCVOGwirNy
   A==;
X-CSE-ConnectionGUID: RggpQsz6TIKEcHwp4n4QTQ==
X-CSE-MsgGUID: TXqHKEqiQGCTmoKEGy6Sig==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38534413"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38534413"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:13:07 -0700
X-CSE-ConnectionGUID: 1VXGpvhbRb+biuLLfyBGhg==
X-CSE-MsgGUID: hLgNtRGXRWGozjepu793sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61465652"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 15:13:06 -0700
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
Subject: [PATCH 6/7] x86/hyperv: Reserve real mode when ACPI wakeup mailbox is available
Date: Tue,  6 Aug 2024 15:12:36 -0700
Message-Id: <20240806221237.1634126-7-yunhong.jiang@linux.intel.com>
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

The trampoline_start64 is utilized when the BSP wakes up the APs through
ACPI wakeup mailbox mechanism. Because trampoline_start64 is currently
part of the real model startup code, the real mode memory need to be
reserved.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 arch/x86/hyperv/hv_vtl.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index bfe54afcdf1d..a1eb5548bd4d 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -13,6 +13,7 @@
 #include <asm/mshyperv.h>
 #include <asm/realmode.h>
 #include <../kernel/smpboot.h>
+#include <linux/memblock.h>
 
 extern struct boot_params boot_params;
 static struct real_mode_header hv_vtl_real_mode_header;
@@ -34,12 +35,28 @@ static bool hv_is_private_mmio_tdx(u64 addr)
 	return false;
 }
 
+static void __init hv_reserve_real_mode(void)
+{
+	phys_addr_t mem;
+	size_t size = real_mode_size_needed();
+
+	/*
+	 * We only need the memory to be <4GB since the 64-bit trampoline goes
+	 * down to 32-bit mode.
+	 */
+	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, SZ_4G);
+	if (!mem)
+		panic("No sub-4G memory is available for the trampoline\n");
+	set_real_mode_mem(mem);
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
 
 	if (wakeup_mailbox_addr) {
 		x86_platform.hyper.is_private_mmio = hv_is_private_mmio_tdx;
+		x86_platform.realmode_reserve = hv_reserve_real_mode;
 	} else {
 		x86_platform.realmode_reserve = x86_init_noop;
 		x86_platform.realmode_init = x86_init_noop;
@@ -259,7 +276,8 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	real_mode_header = &hv_vtl_real_mode_header;
+	if (!wakeup_mailbox_addr)
+		real_mode_header = &hv_vtl_real_mode_header;
 	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;
-- 
2.25.1


