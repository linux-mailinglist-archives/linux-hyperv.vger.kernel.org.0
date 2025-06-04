Return-Path: <linux-hyperv+bounces-5735-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693D5ACD099
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 02:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F76217664D
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 00:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13A78F3A;
	Wed,  4 Jun 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBgQv1dU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB71F5F6;
	Wed,  4 Jun 2025 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748996287; cv=none; b=uRZ+8DvB8HxpoOVPsg0HVGIL8eXyr0mILPWtn96gz3yxYCMYLGandoBFY3fbitNVlxIFwIdGGACNzl8B7vLWbAtqdkQ4Rx4xwFDppQkOK93ilPwewFiH9dIx2nAmq6iV5VIR/Jk3glhuHmCDhdKfGmV4PW0x7+I2K2bh4anCmus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748996287; c=relaxed/simple;
	bh=PUVIKq1UhmNARwP0ctBdFVOtRbG0LlOJlEurpP6Xx3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PSx9iltcquB2KArONJXdTdMmAsnBXYibbG7K/DMcLxWsYohUhReFbGnk0ZbD91UqqdHbhqL0zFYtLQQ0CuEjzxv5IZpaLWNE312alGnBm8mdWy6CdsKhbtQg/ECN+DYQzaC71DH/a4yyRvg4hurGD69L0bOjhC1MNF7iS8Le0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBgQv1dU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748996286; x=1780532286;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PUVIKq1UhmNARwP0ctBdFVOtRbG0LlOJlEurpP6Xx3E=;
  b=EBgQv1dUlHE2CZlhHxNg25hSEZKgiqCIcxfIET8r3fTOa6tXaVdFVD/p
   HhrPR6rFgd7qO8Ogqr1Xa2vNA88rVckdvXAQq6V1A8ppSkuQpEGgsdGFk
   yTlD2tYeSxjyzA54rAbTpz8sOIm6C2cHcqVxGc3lCm/SiH+nY8w7+e6Ww
   FINvemgpBnmMs0xMwgVCY4HIY79ar+EpetCWiEi8pZKoRXs+j127r9MVj
   P3dLeB2+mizSwSg58zQEjQQTWLCmfJQYUv2m8qvssqO7UTfiuyJ7+4qUM
   ZFMMA1X5b0AiGlaD/oEb7LCye0OTW92ma4axqKXojyST3m2UJDJIHpx+2
   g==;
X-CSE-ConnectionGUID: t5oLCuGHQvymGiRa0nXYrg==
X-CSE-MsgGUID: cVe64yC8QiuSOW4LGKmEUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62112958"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62112958"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:02 -0700
X-CSE-ConnectionGUID: /ko6f3r6TCCDd6JYel0ZPQ==
X-CSE-MsgGUID: Ob0sN+IXQnGj7OFjfya1kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="149904471"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:01 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 03 Jun 2025 17:15:18 -0700
Subject: [PATCH v4 06/10] x86/realmode: Make the location of the trampoline
 configurable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-rneri-wakeup-mailbox-v4-6-d533272b7232@linux.intel.com>
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
In-Reply-To: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
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
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748996287; l=3871;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=oG+sUwuixbImCg84nwDCAdPZ8WWhaG4+2hWqfX0US3g=;
 b=6eMJvAFiFCJGbc0qNGLUaFhNrRZ537Mn+HoUALex7amHrbkkOhLfHPAywBIjS6kzLkQYMT0jY
 XBqXoCRR2AnCVn3FCfciuLvuP43P7P9T+0SO2dXQMdq96vH/dBOBlwx
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


