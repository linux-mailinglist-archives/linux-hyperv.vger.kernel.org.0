Return-Path: <linux-hyperv+bounces-8182-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B0AD00367
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 22:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13D20302571C
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 21:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2B5324B19;
	Wed,  7 Jan 2026 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOmyPCrB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6DA318B89;
	Wed,  7 Jan 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822369; cv=none; b=rp4y9fvSpftsRksFP6tqX2A3ZIo+IrQqd85pgXbWGLvLGOK90hPbKm2PDNte0Dko/ZV/T7jPkxmjbZXDsvqXlT2fuGUXqhm7w9IVbrd0a1oH1vFN7h2S1xk05sWYtPbinGucJHgJvPRUf6nHjuwqKS89IFreGRdJsQhdslIJE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822369; c=relaxed/simple;
	bh=9blOcO6x27MrcdDd6HLxfjCPfcgkn5DijlmNh5tB5GE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xt09ag7lsiMELknr/3t+VSzLlJKx6ZRM4lFZ8mDWuVmPTzHXnW4DminCWEEt/qJafDMCjbwfJQW4NeP0uQksj7x/tUKjNRY1Ad2+e+ckmXf5guYfBq3OmBIgpYpTXdyUhOoyyYt4M1xFYHVX0Eo/N3auXlRWM2gc0JxP3Bt6rx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOmyPCrB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767822367; x=1799358367;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9blOcO6x27MrcdDd6HLxfjCPfcgkn5DijlmNh5tB5GE=;
  b=EOmyPCrBHGmafftBY7HCjGGWgRySfzdq/JObjIJ8z5bFbj6FS/0U7x+v
   S+d8S4lxuvD6Bvty2LQQX20j0/P2Y/wUd1KNATe9PSNp4OFWONFwLLmbn
   k9uFqEbRMcNDB4XIJeFYiH0Sy4ljHCWJP/FQWGQ59ByJaSEzWcHwknpnd
   XSOIAGNYCR00jWWk8ajKHs6qsjbBNAM9rHWgCgY3N+c+xO6gGi4fpz5OY
   3YALD+WvJwH6FpFvHLwEYn8bwP4gWwom8SRY0h8p779sGZkDOMTPQeunA
   3Lvjg61Ux/6HXxRShQCoF4DfgbKya2EfynvAZYHQTNgMLsNSKwZOAaqzy
   w==;
X-CSE-ConnectionGUID: 5GAMAeAsQBKdOZc/siPa7Q==
X-CSE-MsgGUID: 04HLYF0lRmaZMwb8xK8NaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69359292"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69359292"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:02 -0800
X-CSE-ConnectionGUID: unxsrMyDR/iuIl2qD/DfqQ==
X-CSE-MsgGUID: rv+/8wiBQe+wL8oW0cU/ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207510913"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:02 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 07 Jan 2026 13:44:42 -0800
Subject: [PATCH v8 06/10] x86/realmode: Make the location of the trampoline
 configurable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-rneri-wakeup-mailbox-v8-6-2f5b6785f2f5@linux.intel.com>
References: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
In-Reply-To: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767822314; l=3993;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=5LrntglSg7YhBSGj0x30FU7Ghm1ZgsQmlL/GeRIKcus=;
 b=jbos6LMgextmTayJjS4GcOl6d5B9wqgjLiFLlJzjv0EW0E4ixkYQR7Bu/OGT8rH9P+LgxB1+H
 z/zs4N0OM/rBIfK7QB8x3TV1N6K8JoGmiU1lUmi3N03Dr0ms8fzSZAH
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
Changes in v8:
 - None

Changes in v7:
 - None

Changes in v6:
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - None

Changes in v4:
 - Added Reviewed-by tag from Michael. Thanks!

Changes in v3:
 - Edited the commit message for clarity.
 - Minor tweaks to comments.
 - Removed the option to not reserve the first 1MB of memory as it is
   not needed.

Changes in v2:
 - Added this patch using code that Thomas suggested:
   https://lore.kernel.org/lkml/87a5ho2q6x.ffs@tglx/
---
 arch/x86/include/asm/x86_init.h | 3 +++
 arch/x86/kernel/x86_init.c      | 3 +++
 arch/x86/realmode/init.c        | 7 +++----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 6c8a6ead84f6..953d3199408a 100644
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


