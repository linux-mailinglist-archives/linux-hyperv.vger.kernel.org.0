Return-Path: <linux-hyperv+bounces-7236-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A307BE622D
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 04:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AF41A64056
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 02:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6F625A2DD;
	Fri, 17 Oct 2025 02:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkZYUkvl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5DA247295;
	Fri, 17 Oct 2025 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669333; cv=none; b=uCGd/vTKfV/svo9jezOiHkK538aiPooCeP9SFDxebNCJEjn591WaAVkKD/CC2HTE3Ci5+fqZFPhM+pjCmiULKX8Ti/OSIrIbOeO+5uYkx+EiGtZvdP3mZt4JSMTgYcDvPfb8NoqS0LWlwPH6enMmzQBJbAcBY0MyTas3eZyMTOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669333; c=relaxed/simple;
	bh=oXWsd28ZYIu8vxK+MbiTx/39CzqDc6qRRX5JmOANHeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGydU1PKUgEKHItxq23wIVxCzOYXNFHS+xXtVDtkhpRdxqs6LZ2pJ6mk7iaqAraCo19RhxYf1qzG0y+iZxHvcjTTSoWcyXCEeEALiib5scxP21ykXlp8sTXwMObjBul7N8i5aDFbrIfj4E8TyXud1Ot7VhbwM3LSYVbY/FcBa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkZYUkvl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760669332; x=1792205332;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oXWsd28ZYIu8vxK+MbiTx/39CzqDc6qRRX5JmOANHeA=;
  b=lkZYUkvlIYkrcPnDdtEhQQL6UGcvJZhd6q13Ws/1FG9SEWw5sCjyKmp5
   FxAShEUHtZNccrhO3FwXEoBT7/1di4ad+49qs/DIVnkHGbYyPuSraPwsj
   xvusHgP/g4eKbAB9/xBd16lqgs3u02imlwclAJCfH0SwVjxCHldnKYPKg
   tF5yBuxM0rLqf3eAsBuS2A61DICaGWXd5ZqXfT0LhB9h1aghztnQhCqAc
   V8UX3KQ+LugiMqEGXBWfSMBF/0I6tdgtMSAA8aewEXmRFEG55W/gFS3cT
   7ZvXQmGziKt5x2iSdFtZuZDN+YbqZi2VVyriqbaKhH6nj/IhDEnMPpzPh
   w==;
X-CSE-ConnectionGUID: BQEeQE35QVKqsS4YCDYgFg==
X-CSE-MsgGUID: yQP8MIZFRfen9lz091Evsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="80321909"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="80321909"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:49 -0700
X-CSE-ConnectionGUID: rY0CYWSzTDmG6s6HC60+gw==
X-CSE-MsgGUID: bGxa3S8oRE+jTvvlLT7DYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="219776557"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:48 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 16 Oct 2025 19:57:26 -0700
Subject: [PATCH v6 04/10] x86/dt: Parse the Wakeup Mailbox for Intel
 processors
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-rneri-wakeup-mailbox-v6-4-40435fb9305e@linux.intel.com>
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
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760669902; l=4755;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=oXWsd28ZYIu8vxK+MbiTx/39CzqDc6qRRX5JmOANHeA=;
 b=uvwOXP6ZwXDqHgpG6xU1JjmRkOdzIemqxEhf3DWHVE/wIB0jldo5fzXjvnP8TxLAjrB3WSDZJ
 uFvCfQOLn+yDjZp2XuxuEwukc3ACjC2BihEjQiUsNs1D2PcMG4lrD6E
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

The Wakeup Mailbox is a mechanism to boot secondary CPUs on systems that do
not want or cannot use the INIT + StartUp IPI messages.

The platform firmware is expected to implement the mailbox as described in
the Multiprocessor Wakeup Structure of the ACPI specification. It is also
expected to publish the mailbox to the operating system as described in the
corresponding DeviceTree schema that accompanies the documentation of the
Linux kernel.

Reuse the existing functionality to set the memory location of the mailbox
and update the wakeup_secondary_cpu_64() APIC callback. Make this
functionality available to DeviceTree-based systems by making CONFIG_X86_
MAILBOX_WAKEUP depend on either CONFIG_OF or CONFIG_ACPI_MADT_WAKEUP.

do_boot_cpu() uses wakeup_secondary_cpu_64() when set. It will be set if a
wakeup mailbox is enumerated via an ACPI table or a DeviceTree node. For
cases in which this behavior is not desired, this APIC callback can be
updated later during boot using platform-specific hooks.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 - Added Reviewed-by tag from Dexuan. Thanks!

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
index f57192a34a87..5a9d0b2d5174 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1110,7 +1110,7 @@ config X86_LOCAL_APIC
 
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


