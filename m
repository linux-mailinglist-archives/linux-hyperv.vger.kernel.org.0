Return-Path: <linux-hyperv+bounces-5335-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CBEAA8238
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18BE7B00C0
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B3D280CCD;
	Sat,  3 May 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J833lDcj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A327FD75;
	Sat,  3 May 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299419; cv=none; b=FTQQ7WRrblkcaqWZjSEYQO2JPJYzhBHSbKVO5ZqZNqheVGqYuLQZZP8mVtgoJCET6vzy3xiOiYr6jUlpUmaK0ghbwAyfh+muCZeK8+VS/0Ia56NYrkVu5MK2oYANauTNHxoSuToqY6B84RSgrXU1ob06FMGoJ7FIphZS2LVE8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299419; c=relaxed/simple;
	bh=B6axyb2KV+UrgzmgnYGTQ1Bq6srlUV5UH9OE6so1vs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SHyFkhV8XJRilxC4DXR2CJW6Jj/HSO8ZA/C0mYXe2KTPayGaAvVpLY+Sf6AbVXzH/tJUQ7yESdo4B0T7+lw6bA8fcp/8pbmUBVIIgiUOb+vLd5BxIn+sc4Anr9QnzTqTyiOHsjJcG8Em7fgGAm/W5qp8VQQwk7sq0RkpSjEQO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J833lDcj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299418; x=1777835418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=B6axyb2KV+UrgzmgnYGTQ1Bq6srlUV5UH9OE6so1vs8=;
  b=J833lDcjdHmbu5QU+U7M4ZfJm2Of6kWn54I6PBsJyPKrByjgOqFgIOB/
   dit1yP6abZMCfobYigIgris1tPzwcNu0PS2tzY/T+bLS6b854j9ur1dut
   2l/+7WasTJjjZ/5ttJLrgE963pif9UcGILjFjvDV9ieKCQdMhh/pRSQ6a
   Mt5asMIbyB3ZJ77wLa7s/JL8aHBrU8Fn0DQhJVfglojWnOT8fgPVJybP5
   Wbs03FqLk0x7qJwU7BRR2ZmHdxvPPU9/PRACBjaDZhpk52iUaeZ5Vmjp+
   e/GkHFAfQXvWJ5vn26jjwqAmXHotHu2nrf9bO93Sj4oVnv+S6A1yKPADR
   w==;
X-CSE-ConnectionGUID: y/FTjRvZRMiq4NtTRLSFcg==
X-CSE-MsgGUID: xZF+YUHfTHq6pq+UMAcL8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095645"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095645"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:15 -0700
X-CSE-ConnectionGUID: mYiZvxssRQKfRCxJsOJ0YA==
X-CSE-MsgGUID: ius8xGQMTKC5F3k4ygrgLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046110"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:14 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org ,
	linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v3 09/13] x86/realmode: Make the location of the trampoline configurable
Date: Sat,  3 May 2025 12:15:11 -0700
Message-Id: <20250503191515.24041-10-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>

x86 CPUs boot in real mode. This mode uses 20-bit memory addresses (16-bit
registers plus 4-bit segment selectors). This implies that the trampoline
must reside under the 1MB memory boundary.

There are platforms in which the firmware boots the secondary CPUs,
switches them to long mode and transfers control to the kernel. An example
of such mechanism is the ACPI Multiprocessor Wakeup Structure.

In this scenario there is no restriction to locate the trampoline under 1MB
memory. Moreover, certain platforms (for example, Hyper-V VTL guests) may
not have memory available for allocation under 1MB.

Add a new member to struct x86_init_resources to specify the upper bound
for the location of the trampoline memory. Keep the default upper bound of
1MB to conserve the current behavior.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 - Edited the commit message for clarity.
 - Minor tweaks to comments.
 - Removed the option to not reserve the first 1MB of memory as it is
   not needed.

Changes since v1:
 - Added this patch using code that Thomas suggested:
   https://lore.kernel.org/lkml/87a5ho2q6x.ffs@tglx/
---
 arch/x86/include/asm/x86_init.h | 3 +++
 arch/x86/kernel/x86_init.c      | 3 +++
 arch/x86/realmode/init.c        | 7 +++----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 36698cc9fb44..e770ce507a87 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -31,12 +31,15 @@ struct x86_init_mpparse {
  *				platform
  * @memory_setup:		platform specific memory setup
  * @dmi_setup:			platform specific DMI setup
+ * @realmode_limit:		platform specific address limit for the real mode trampoline
+ *				(default 1M)
  */
 struct x86_init_resources {
 	void (*probe_roms)(void);
 	void (*reserve_resources)(void);
 	char *(*memory_setup)(void);
 	void (*dmi_setup)(void);
+	unsigned long realmode_limit;
 };
 
 /**
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 0a2bbd674a6d..a25fd7282811 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <linux/sizes.h>
 
 #include <asm/acpi.h>
 #include <asm/bios_ebda.h>
@@ -69,6 +70,8 @@ struct x86_init_ops x86_init __initdata = {
 		.reserve_resources	= reserve_standard_io_resources,
 		.memory_setup		= e820__memory_setup_default,
 		.dmi_setup		= dmi_setup,
+		/* Has to be under 1M so we can execute real-mode AP code. */
+		.realmode_limit		= SZ_1M,
 	},
 
 	.mpparse = {
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index ed5c63c0b4e5..01155f995b2b 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -46,7 +46,7 @@ void load_trampoline_pgtable(void)
 
 void __init reserve_real_mode(void)
 {
-	phys_addr_t mem;
+	phys_addr_t mem, limit = x86_init.resources.realmode_limit;
 	size_t size = real_mode_size_needed();
 
 	if (!size)
@@ -54,10 +54,9 @@ void __init reserve_real_mode(void)
 
 	WARN_ON(slab_is_available());
 
-	/* Has to be under 1M so we can execute real-mode AP code. */
-	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, 1<<20);
+	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, limit);
 	if (!mem)
-		pr_info("No sub-1M memory is available for the trampoline\n");
+		pr_info("No memory below %pa for the real-mode trampoline\n", &limit);
 	else
 		set_real_mode_mem(mem);
 
-- 
2.43.0


