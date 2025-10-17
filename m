Return-Path: <linux-hyperv+bounces-7238-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB26BE6252
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 04:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E8D5E0CB9
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 02:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278882741AB;
	Fri, 17 Oct 2025 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JB6H5wgt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB592580F3;
	Fri, 17 Oct 2025 02:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669335; cv=none; b=oiW0r6ZK3K80iLyXAYXejrZbJu4qjT1TW1p93tXXVQvhIlY7fts5TJ/aJPScHZcOaTXHw9LDB4tmMeKfRmaMHhLzxiF3EkU22r9dX2cVf7dy4/tg1sbw1MzzaxsU48gdgj93nLK9otinh/noQ6LxX6+USr319Yd0iP1xKwutZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669335; c=relaxed/simple;
	bh=DeJzn/2MLyfQfhOYgPps5Tvmb93NuC81Q2Ua9386CMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjsRvF8dp1VBsGVRQw7g268kweZDuWi+tLYze3VsK4+aeN2phM08liihrjx03xHZ7NWzHy/7trViRUGd1LsoBlDBY6GA4wYaEhBCP7yMpeojdPrYQnMNv9vftgM6ilyneEwN2mbQrXYqmAFOyfTHXXFlVbU8aBvMeC/EPIVIwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JB6H5wgt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760669334; x=1792205334;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DeJzn/2MLyfQfhOYgPps5Tvmb93NuC81Q2Ua9386CMI=;
  b=JB6H5wgtaR0MEpek4PoJYEYgZYF0NzGd3NE9LQbykFf3YkdRlN+RfN1k
   Tk6fPASUVkhn2Epm9i6Ud5/RNBAGJ14W4ScdOsI/sEFwDeVcZfml5tlzK
   IDcpeasGxUm5MMDRiU1LWNC5T+S7mXfoLS6P/dfy++Bo+JSW+Uwn56irU
   R7AcXZJ/vbFXN2G7P1UbmMWPTxEs4gkgXHnrS5zBotPtIpDKwOlIW1Qqh
   UD9jjkGIt473ToBTuD0LQhf9YBmIBXqHU4wlZRe5NR19oz472IxS2YtB2
   W99AyUe+OYjELyGbXho1w31wcXRFlDPcDlIDKKowKBLQbIKF/jm+54Q+q
   w==;
X-CSE-ConnectionGUID: Bal3VBUPQHejUySIl93XQQ==
X-CSE-MsgGUID: lOpanzbOSIyPi5FxjqAcsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="80321921"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="80321921"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:50 -0700
X-CSE-ConnectionGUID: VJj+24f7RLiwKgo5DBzSQg==
X-CSE-MsgGUID: sjyNK5HBS0SPLx+rYCJGLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="219776567"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:49 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 16 Oct 2025 19:57:28 -0700
Subject: [PATCH v6 06/10] x86/realmode: Make the location of the trampoline
 configurable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-rneri-wakeup-mailbox-v6-6-40435fb9305e@linux.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
In-Reply-To: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760669902; l=3954;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=oL1YhWY/xGIk9t6USOhIG8l08ECXRGdJqyRJsOKl2CY=;
 b=qKhMO51qHmMJ+tfxM0h06tffd16MXjS6/Ug3OnES7XvGAbvGYRXbCG07YaWwZjz83J6h+CV/h
 9ygeo7A9VeGAwoIDiRsQUiZgqO9pRv9jtZK0hWiXktj0/rWV4SEOscr
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>

x86 CPUs boot in real mode. This mode uses a 1MB address space. The
trampoline must reside below this 1MB memory boundary.

There are platforms in which the firmware boots the secondary CPUs,
switches them to long mode and transfers control to the kernel. An example
of such a mechanism is the ACPI Multiprocessor Wakeup Structure.

In this scenario there is no restriction on locating the trampoline under
1MB memory. Moreover, certain platforms (for example, Hyper-V VTL guests)
may not have memory available for allocation below 1MB.

Add a new member to struct x86_init_resources to specify the upper bound
for the location of the trampoline memory. Preserve the default upper bound
of 1MB to conserve the current behavior.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 - Added Reviewed-by tag from Dexuan. Thanks!

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


