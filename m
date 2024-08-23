Return-Path: <linux-hyperv+bounces-2839-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD0295D9A8
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 01:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1DD1F23FEA
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE6D1CE717;
	Fri, 23 Aug 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlcaJUeD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C191CC8AE;
	Fri, 23 Aug 2024 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455438; cv=none; b=Gr7Qyo4dNhVNGA4s8JTi4PtulDVw8Cu5T504Bg0F5SaLeqEsIaoxfS+9U3eSC9KCaXeIYVDkOXCRSSQ6bT0z65yxOm31OOHBtxsNepdb4m/mRhlymbQ8UtxKU/FA+M6IPEPqt7OsZhgh9IXf5bLiothDICatAleno/S5pY18Gsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455438; c=relaxed/simple;
	bh=o2HQIx5/tygSCb2wirmG6bn6UMn/ikF+6wrGc+/jrxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SXmZCaAeTYoy8QId/1vSMasmdR+2X7SWtekybem/jqQKDbluqd6HseRSy+Psorg4T6yvoMrEhc9RwVwjb68Zg8xXdK4ZsITj7Da2Yb6yScfkSX8E4WhhnnTzy7JalVsSqmbsXdmD6/Ra2QuvX8pPrhYimdxywx2V1DOEnpu5nqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlcaJUeD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724455437; x=1755991437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o2HQIx5/tygSCb2wirmG6bn6UMn/ikF+6wrGc+/jrxM=;
  b=DlcaJUeDVAT1DCZwLkkbJ1HGs6ubSP4FIy5Qv+pydSrblH25veUz8EfE
   g1DGmqGDVAxI9W5FUKX/h18FQEhjkweTXecH6YBKPtBshHMCfo+LcAB2b
   cXYw/pZNNtiP9VqLd9x7wOWBljomQ8FTkabhFQqvPfLEuLRjDB+aBxiSv
   9Z+wMD0je1E0JjNitK/N1Mu+K8SyG9g1yCAeHoo1YSf+MQveI/r6rvd0J
   G234xH79WRy/JSRO75xwkF2K0VC+ozRHqZijjMjm7Q6fR2lsCemuHB+3F
   f46Agz0QXuMXDsxf3VpFKW6WoMpDq2G35wgd6CLso/gJpDoXUShxJ1FSm
   Q==;
X-CSE-ConnectionGUID: TBKsCdr4SyG6rLQeGoys3Q==
X-CSE-MsgGUID: 79Pn0/kXTOaEid5F5OvjzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33619312"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33619312"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:23:54 -0700
X-CSE-ConnectionGUID: UNshJelQSJ+9lYuqqWLiEA==
X-CSE-MsgGUID: 8TMXqT6kRXOphT+7wNmqeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61641013"
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
Subject: [PATCH v2 6/9] x86/realmode: Add memory range support to reserve_real_mode
Date: Fri, 23 Aug 2024 16:23:24 -0700
Message-Id: <20240823232327.2408869-7-yunhong.jiang@linux.intel.com>
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

Currently the reserve_real_mode() always allocates memory from below 1M
range, although some real mode blob code can execute above 1M.

The VTL2 TDX hyperv guest may have no memory available below 1M, but it
needs to invoke some real mode blob code that can execute above 1M memory.

Instead of providing a platform specific realmode_reserve callback, the
reserve_real_mode() is updated to support flexible memory range to meet
this requirement.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87a5ho2q6x.ffs@tglx/

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 arch/x86/include/asm/x86_init.h |  6 ++++++
 arch/x86/kernel/x86_init.c      |  3 +++
 arch/x86/realmode/init.c        | 14 ++++++--------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 213cf5379a5a..9e3198bfe56e 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -31,12 +31,18 @@ struct x86_init_mpparse {
  *				platform
  * @memory_setup:		platform specific memory setup
  * @dmi_setup:			platform specific DMI setup
+ * @realmode_limit:		platform specific address limit for the realmode trampoline
+ *				(default 1M)
+ * @reserve_bios:		platform specific address limit for reserving the BIOS area
+ *				(default 1M)
  */
 struct x86_init_resources {
 	void (*probe_roms)(void);
 	void (*reserve_resources)(void);
 	char *(*memory_setup)(void);
 	void (*dmi_setup)(void);
+	unsigned long realmode_limit;
+	unsigned long reserve_bios;
 };
 
 /**
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 82b128d3f309..f3226aa77bfb 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -8,6 +8,7 @@
 #include <linux/ioport.h>
 #include <linux/export.h>
 #include <linux/pci.h>
+#include <linux/sizes.h>
 
 #include <asm/acpi.h>
 #include <asm/bios_ebda.h>
@@ -68,6 +69,8 @@ struct x86_init_ops x86_init __initdata = {
 		.reserve_resources	= reserve_standard_io_resources,
 		.memory_setup		= e820__memory_setup_default,
 		.dmi_setup		= dmi_setup,
+		.realmode_limit		= SZ_1M,
+		.reserve_bios		= SZ_1M,
 	},
 
 	.mpparse = {
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index f9bc444a3064..6d658ad8c0f4 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -45,7 +45,7 @@ void load_trampoline_pgtable(void)
 
 void __init reserve_real_mode(void)
 {
-	phys_addr_t mem;
+	phys_addr_t mem, limit = x86_init.resources.realmode_limit;
 	size_t size = real_mode_size_needed();
 
 	if (!size)
@@ -54,17 +54,15 @@ void __init reserve_real_mode(void)
 	WARN_ON(slab_is_available());
 
 	/* Has to be under 1M so we can execute real-mode AP code. */
-	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, 1<<20);
+	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, limit);
 	if (!mem)
-		pr_info("No sub-1M memory is available for the trampoline\n");
+		pr_info("No memory below %lluM for the real-mode trampoline\n", limit >> 20);
 	else
 		set_real_mode_mem(mem);
 
-	/*
-	 * Unconditionally reserve the entire first 1M, see comment in
-	 * setup_arch().
-	 */
-	memblock_reserve(0, SZ_1M);
+	/* Reserve the entire first 1M, if enabled. See comment in setup_arch(). */
+	if (x86_init.resources.reserve_bios)
+		memblock_reserve(0, x86_init.resources.reserve_bios);
 }
 
 static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
-- 
2.25.1


