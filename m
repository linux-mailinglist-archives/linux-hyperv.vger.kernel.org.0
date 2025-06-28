Return-Path: <linux-hyperv+bounces-6038-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F95AEC48E
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 05:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DBA17B12CD
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 03:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A800821E082;
	Sat, 28 Jun 2025 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FL62iX2K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86B21C186;
	Sat, 28 Jun 2025 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081724; cv=none; b=tuv/c/B9FBlFqiSuvVP7QNqyetPyul2QxWFlMqRcOMT7iwn7BigNm4qdKY+VzB6g+2CxcuVLWaTtbedO7mwgRToPc1pjWO/jgLP9tUQszVNoaZAXKQGG6DqWJMEaYh3VDZL0TM/lppNjR961Je0I7Qj8+oi6W3VOFQ1JxUOPM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081724; c=relaxed/simple;
	bh=KGJP3nxc6fAkIgk3la9kd24UeoXHH3LZl3OFegytHj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAWnXE9LEqm3yRz+XJWe7WGAOpJyg8STkrGcwEuTxPP2yVGU2PUT/bGCnAVBFEncEA3dFCCyECsz/blDxlnC87a15V1O93/DmPXW51yvUUW7OxR8P1pmTY1rlii47HRB47VqILlI6wf3VzDJ21kCDqPgUS5U7wX3NwpAu9vpHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FL62iX2K; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751081723; x=1782617723;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KGJP3nxc6fAkIgk3la9kd24UeoXHH3LZl3OFegytHj8=;
  b=FL62iX2KPjsRU13o5EhzltySvZEZGxsfqdT7CwIKp+pXB6cmrifn4jkl
   wYImZXW7kDVcUK4dCb6kPkfkWRQf6XCRBjfpvOOYhZEC28ZGReBYxVnvX
   q9HZqWwKrZDnMM6EcxLFoIbRlMevUSS3aZxIOSB8cShUAGERMaFHPSf30
   apsDPRCRtMwyyUmSjYvhu7UQ1ppirqCeuYmdDQuC9WDPUbZ0+mSIh/1WD
   FktpISQ9KdHxTfhHQj9qQc2mICiKoorm6I1adnbulcyF+ybG9NjfOA3Bi
   X93sXs+VKBTA83RSBRxYohz2vPfbj79gfUWXvaECs0dpX3qVJs2/UqkRV
   w==;
X-CSE-ConnectionGUID: /5rsuMbrRbe+OfPzuW87Cw==
X-CSE-MsgGUID: tJtSgauVSSyXpW+V+oezyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53335330"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53335330"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:20 -0700
X-CSE-ConnectionGUID: 7+qyvk0GTH27qfYtN/MIcQ==
X-CSE-MsgGUID: yY0nxV/lTAqxG6MhpvdI4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="153141931"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:19 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 27 Jun 2025 20:35:10 -0700
Subject: [PATCH v5 04/10] x86/dt: Parse the Wakeup Mailbox for Intel
 processors
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-rneri-wakeup-mailbox-v5-4-df547b1d196e@linux.intel.com>
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
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751081737; l=4671;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=KGJP3nxc6fAkIgk3la9kd24UeoXHH3LZl3OFegytHj8=;
 b=MhuKuyKFBN/ZcWk1phHIjifrsUw360CkK408sE3DgyKH8M4GettG4XfQwaBAkTvNV8RPitnhT
 uWEbpIzfUEQAvyQnfEWq1gMwpgHx0Nd/gHuI6mTb8zYeXUIPcScKDJy
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

The Wakeup Mailbox is a mechanism to boot secondary CPUs used on systems
that do not want or cannot use the INIT + StartUp IPI messages.

The platform firmware is expected to implement the mailbox as described in
the Multiprocessor Wakeup Structure of the ACPI specification. It is also
expected to publish the mailbox to the operating system as described in the
corresponding DeviceTree schema that accompanies the documentation of the
Linux kernel.

Reuse the existing functionality to set the memory location of the mailbox
and update the wakeup_secondary_cpu_64() APIC callback. Make this
functionality available to DeviceTree-based systems by making CONFIG_X86_
MAILBOX_WAKEUP depend on either CONFIG_OF or CONFIG_ACPI_MADT_WAKEUP.

do_boot_cpu() uses wakeup_secondary_cpu_64() when set. If a wakeup mailbox
is found (enumerated via an ACPI table or a DeviceTree node) it will be
used unconditionally. For cases in which this behavior is not desired, this
APIC callback can be updated later during boot using platform-specific
hooks.

Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 - Made CONFIG_X86_MAILBOX_WAKEUP depend on CONFIG_OF or CONFIG_ACPI_
   MADT_WAKEUP.

Changes since v3:
 - Look for the wakeup mailbox unconditionally, regardless of whether
   cpu@N nodes have an `enable-method` property.
 - Add a reference to the ACPI specification. (Rafael)

Changes since v2:
 - Added extra sanity checks when parsing the mailbox node.
 - Probe the mailbox using its `compatible` property
 - Setup the Wakeup Mailbox if the `enable-method` is found in the CPU
   nodes.
 - Cleaned up unneeded ifdeffery.
 - Clarified the mechanisms used to override the wakeup_secondary_64()
   callback to not use the mailbox when not desired. (Michael)
 - Edited the commit message for clarity.

Changes since v1:
 - Disabled CPU offlining.
 - Modified dtb_parse_mp_wake() to return the address of the mailbox.
---
 arch/x86/Kconfig             |  2 +-
 arch/x86/kernel/devicetree.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e3009cb59928..027f8ae878ec 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1116,7 +1116,7 @@ config X86_LOCAL_APIC
 
 config X86_MAILBOX_WAKEUP
 	def_bool y
-	depends on ACPI_MADT_WAKEUP
+	depends on OF || ACPI_MADT_WAKEUP
 	depends on X86_64
 	depends on SMP
 	depends on X86_LOCAL_APIC
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index dd8748c45529..494a560614a8 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 #include <linux/of_pci.h>
 #include <linux/initrd.h>
+#include <linux/smp.h>
 
 #include <asm/irqdomain.h>
 #include <asm/hpet.h>
@@ -125,6 +126,51 @@ static void __init dtb_setup_hpet(void)
 #endif
 }
 
+#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
+
+#define WAKEUP_MAILBOX_SIZE	0x1000
+#define WAKEUP_MAILBOX_ALIGN	0x1000
+
+/** dtb_wakeup_mailbox_setup() - Parse the wakeup mailbox from the device tree
+ *
+ * Look for the presence of a wakeup mailbox in the DeviceTree. The mailbox is
+ * expected to follow the structure and operation described in the Multiprocessor
+ * Wakeup Structure of the ACPI specification.
+ */
+static void __init dtb_wakeup_mailbox_setup(void)
+{
+	struct device_node *node;
+	struct resource res;
+
+	node = of_find_compatible_node(NULL, NULL, "intel,wakeup-mailbox");
+	if (!node)
+		return;
+
+	if (of_address_to_resource(node, 0, &res))
+		goto done;
+
+	/* The mailbox is a 4KB-aligned region.*/
+	if (res.start & (WAKEUP_MAILBOX_ALIGN - 1))
+		goto done;
+
+	/* The mailbox has a size of 4KB. */
+	if (res.end - res.start + 1 != WAKEUP_MAILBOX_SIZE)
+		goto done;
+
+	/* Not supported when the mailbox is used. */
+	cpu_hotplug_disable_offlining();
+
+	acpi_setup_mp_wakeup_mailbox(res.start);
+done:
+	of_node_put(node);
+}
+#else /* !CONFIG_X86_64 || !CONFIG_SMP */
+static inline int dtb_wakeup_mailbox_setup(void)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_X86_64 && CONFIG_SMP */
+
 #ifdef CONFIG_X86_LOCAL_APIC
 
 static void __init dtb_cpu_setup(void)
@@ -287,6 +333,7 @@ static void __init x86_dtb_parse_smp_config(void)
 
 	dtb_setup_hpet();
 	dtb_apic_setup();
+	dtb_wakeup_mailbox_setup();
 }
 
 void __init x86_flattree_get_config(void)

-- 
2.43.0


