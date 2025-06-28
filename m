Return-Path: <linux-hyperv+bounces-6040-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA62AEC494
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 05:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3895B4A8458
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 03:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1265D220F35;
	Sat, 28 Jun 2025 03:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLYPp4M9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BC21D3DF;
	Sat, 28 Jun 2025 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081726; cv=none; b=NwJQtTao4GTEYH564h0j47PW/O/ExYbMrzpOjpMuR2Q2Bc13iVnbD26JC/Xf6HTxUoc6WPDeiMmT5lI79ot6Fdz/eaZ7QRuNWdg8JU+DYkcaGUQyaAo5vyXTVIGrzoRXsm2Vywzjp/+RuvSmo5z52YVzJlU1WOxnaULYyjg3tmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081726; c=relaxed/simple;
	bh=Kts6osMw25DFJPrmkqjwGgkGlhZj4Myjy58szbwE5mI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0+WmGpvVsZ89yKTcF2BnKj12UlyXa2SoAxEInyTnJEPBM+6kBjEIVpYxrUy3WZTvRT4I0iN1080jZEQnhCPoIRdMlJU3UplvwsWA4XnHzmf5TZS1NbMDdeCoX4rfK7iUPKhXzllHRu+qv9nqG+DFwe9DhJgg6N1zWfS/ondl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLYPp4M9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751081724; x=1782617724;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Kts6osMw25DFJPrmkqjwGgkGlhZj4Myjy58szbwE5mI=;
  b=GLYPp4M9+8e0fSc5bHqNrErRHTSgB20Yo+GVrYTSW/Vywyfq8G2bhRGI
   i3euI28Vg28SjpjUtpgJG8xYrD1zwUsWVbhteCUJidU0+ETrGFcnHnSbb
   3U/EPDM0mIrEc6i972Won3voLtf4UTP0f/BwjHg0pLTzZXMEBp0Pvz3Y7
   +FDngSKKHh13k1RI54kub6j3R2g2tXYgdUGrXs6f8i9HsF4fwUOvCKT6Z
   YO5iLzduPFMMIgu9csks8KlkY7QEHPg9oLHOCLeCi1qCl/K8wvPTPWt6P
   9YoWj7c4txFg8upcltK5bPexAOWyOm7BhnDGjo8iLF79ToFGL1jjbpLic
   Q==;
X-CSE-ConnectionGUID: M4wEEV9QSuS6SPNwKugqdg==
X-CSE-MsgGUID: mqKbW3Y4R6qlc4Cei00+MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53335342"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53335342"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:21 -0700
X-CSE-ConnectionGUID: 6cjRth4PQ1W+yY8rugUgrg==
X-CSE-MsgGUID: UbsGVhuVSgOEzqJzdHCZsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="153141943"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:20 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 27 Jun 2025 20:35:12 -0700
Subject: [PATCH v5 06/10] x86/realmode: Make the location of the trampoline
 configurable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-rneri-wakeup-mailbox-v5-6-df547b1d196e@linux.intel.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751081737; l=3901;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=3Y2yQTIkiUMza6WQc6fzVojZ2dudUc37najPGFxbD1U=;
 b=Gc08BMYpD5yUks4YcmUApezjyQIp4cgUYBoY20Zw9gn8hkGm7vEAG1Hc/IlOEHvHo1gWZ7uT0
 aLbJ/v8atJwCoEjrIQzZoJNofSx1O4zeDcyZzkPYpVxg02ofUgYi5gY
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

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

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 - None

Changes since v3:
 - Added Reviewed-by tag from Michael. Thanks!

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
index 88be32026768..694d80a5c68e 100644
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


