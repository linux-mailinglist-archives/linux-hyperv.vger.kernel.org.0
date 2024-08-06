Return-Path: <linux-hyperv+bounces-2735-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9362949B13
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 00:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F2B1C227C4
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 22:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D5C176AA0;
	Tue,  6 Aug 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4/bV4uJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DAE17557C;
	Tue,  6 Aug 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982385; cv=none; b=efz85EGT89+Oe6dSVKlIuimo5HlELsO6PEBCs+fLBFjnEN9aZr4e4iB5lYDgiQ0c1VqzChZx39zgPmGB+gnAAFoemslptxRw3goTfXZ8yPdAc0mdj5e8k3+FLZmZZLer1QNiIJ7K6+vq8GaEVSsJmNZ3+9LQ/ciGmx1mu48wg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982385; c=relaxed/simple;
	bh=JEd2GxiAIny6JtBY2mtFnm7gnPkCETwQcwUHua+Mxsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZdADQ/xwG+GKLEe2pui3F5uyljAZJjyiLpyHx3AQ4QFI1qXeglUq3STw6jVxS743fThsC2fwZ2doICKcEuuJu01+5BYK/l5KtgZXHUXFOV5PlhkHJG22PwINd5JQ87yK84ww8zcwuCUeTmowda6q0kJDcX1hq20EbSZYPk6+Gs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4/bV4uJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982384; x=1754518384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JEd2GxiAIny6JtBY2mtFnm7gnPkCETwQcwUHua+Mxsg=;
  b=a4/bV4uJWEKQYqQF+aWkBjSfqxO5jcMXd6njUmLu/NmDYHNCorqKRWfy
   /GOJJbHIlgmfd3n/4YO4FEK31rWmj5blVbYk4O9CqKMNe0UtYg/WGWytk
   hIrpyQhXlqVZGwVXv/JDWSyvvR8Iu5MBF2tuY0Nrjm2oxe/qvGp4YgPkJ
   45MZwQeC/KMLhdDbKrvNiddb+opSL8Wh8dg+8NPBdChkftYjUBhfcqSiA
   oiNa50FFfMC7fjnx1y50TSRQY4XT2Ycnd6TSl2Oml3Z1FwuuIu+OxnNPm
   1VkuQKlGfbzMSpOzeuwLdlA365d91Q0+8PyyYamoMNSJ7Nb9/vmqcUr/k
   A==;
X-CSE-ConnectionGUID: +dNNqzRvT86qUozZiIDAzQ==
X-CSE-MsgGUID: 4KvToao5S7uyUUlXYCrhcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38534380"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38534380"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:13:03 -0700
X-CSE-ConnectionGUID: z7J3GVN8TxmZkz4i+gb0nQ==
X-CSE-MsgGUID: 6q4aD9QxRRe9A7ACdXaZcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61465629"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 15:13:02 -0700
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
Subject: [PATCH 3/7] x86/dt: Support the ACPI multiprocessor wakeup for device tree
Date: Tue,  6 Aug 2024 15:12:33 -0700
Message-Id: <20240806221237.1634126-4-yunhong.jiang@linux.intel.com>
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

When a TDX guest boots with the device tree instead of ACPI, it can
reuse the ACPI multiprocessor wakeup mechanism to wake up application
processors(AP), without introducing a new mechanism from scrach.

In the ACPI spec, two structures are defined to wake up the APs: the
multiprocessor wakeup structure and the multiprocessor wakeup mailbox
structure. The multiprocessor wakeup structure is passed to OS through a
Multiple APIC Description Table(MADT), one field specifying the physical
address of the multiprocessor wakeup mailbox structure. The OS sends
a message to firmware through the multiprocessor wakeup mailbox
structure, to bring up the APs.

In device tree environment, the multiprocessor wakeup structure is not
used, to reduce the dependency on the generic ACPI table. The
information defined in this structure is defined in the properties of
cpus node in the device tree. The "wakeup-mailbox-addr" property
specifies the physical address of the multiprocessor wakeup mailbox
structure. The OS will follow the ACPI spec to send the message to the
firmware to bring up the APs.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 MAINTAINERS                        |  1 +
 arch/x86/Kconfig                   |  2 +-
 arch/x86/include/asm/acpi.h        |  1 -
 arch/x86/include/asm/madt_wakeup.h | 16 ++++++++++
 arch/x86/kernel/madt_wakeup.c      | 47 ++++++++++++++++++++++++++++--
 5 files changed, 63 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/include/asm/madt_wakeup.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cc6d5c367df..de3eaa0fdaaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -288,6 +288,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
 F:	Documentation/ABI/testing/configfs-acpi
 F:	Documentation/ABI/testing/sysfs-bus-acpi
 F:	Documentation/firmware-guide/acpi/
+F:	arch/x86/include/asm/madt_wakeup.h
 F:	arch/x86/kernel/acpi/
 F:	arch/x86/kernel/madt_playdead.S
 F:	arch/x86/kernel/madt_wakeup.c
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 02775a61b557..e92dfefba675 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1123,7 +1123,7 @@ config X86_LOCAL_APIC
 config ACPI_MADT_WAKEUP
 	def_bool y
 	depends on X86_64
-	depends on ACPI
+	depends on ACPI || OF
 	depends on SMP
 	depends on X86_LOCAL_APIC
 
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 21bc53f5ed0c..0e082303ca26 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -83,7 +83,6 @@ union acpi_subtable_headers;
 int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 			      const unsigned long end);
 
-void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
 
 /*
  * Check if the CPU can handle C2 and deeper
diff --git a/arch/x86/include/asm/madt_wakeup.h b/arch/x86/include/asm/madt_wakeup.h
new file mode 100644
index 000000000000..faabf51c1e8f
--- /dev/null
+++ b/arch/x86/include/asm/madt_wakeup.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_X86_MADT_WAKEUP_H
+#define __ASM_X86_MADT_WAKEUP_H
+
+void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
+
+#if defined(CONFIG_OF) && defined(CONFIG_ACPI_MADT_WAKEUP)
+int dtb_parse_mp_wake(u64 *wake_mailbox_paddr);
+#else
+static inline int dtb_parse_mp_wake(u64 *wake_mailbox_paddr)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* __ASM_X86_MADT_WAKEUP_H */
diff --git a/arch/x86/kernel/madt_wakeup.c b/arch/x86/kernel/madt_wakeup.c
index 6cfe762be28b..f6795a6ab2d3 100644
--- a/arch/x86/kernel/madt_wakeup.c
+++ b/arch/x86/kernel/madt_wakeup.c
@@ -14,6 +14,8 @@
 #include <asm/nmi.h>
 #include <asm/processor.h>
 #include <asm/reboot.h>
+#include <asm/madt_wakeup.h>
+#include <asm/prom.h>
 
 /* Physical address of the Multiprocessor Wakeup Structure mailbox */
 static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
@@ -122,7 +124,7 @@ static int __init init_transition_pgtable(pgd_t *pgd)
 	return 0;
 }
 
-static int __init acpi_mp_setup_reset(u64 reset_vector)
+static int __init __maybe_unused acpi_mp_setup_reset(u64 reset_vector)
 {
 	struct x86_mapping_info info = {
 		.alloc_pgt_page = alloc_pgt_page,
@@ -226,7 +228,7 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 	return 0;
 }
 
-static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
+static void __maybe_unused acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
 {
 	cpu_hotplug_disable_offlining();
 
@@ -248,6 +250,7 @@ static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake
 	mp_wake->mailbox_address = 0;
 }
 
+#ifdef CONFIG_ACPI
 int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 			      const unsigned long end)
 {
@@ -290,3 +293,43 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	return 0;
 }
+#endif /* CONFIG_ACPI */
+
+#ifdef CONFIG_OF
+int __init dtb_parse_mp_wake(u64 *wake_mailbox_paddr)
+{
+	struct device_node *node;
+	u64 mailaddr;
+	int ret = 0;
+
+	node = of_find_node_by_path("/cpus");
+	if (!node)
+		return -ENODEV;
+
+	if (of_property_match_string(node, "enable-method",
+				     "acpi-wakeup-mailbox") < 0) {
+		pr_err("No acpi wakeup mailbox enable-method\n");
+		ret = -ENODEV;
+		goto done;
+	}
+
+	/*
+	 * No support to the MADT reset vector yet.
+	 */
+	cpu_hotplug_disable_offlining();
+
+	if (of_property_read_u64(node, "wakeup-mailbox-addr", &mailaddr)) {
+		pr_err("Invalid wakeup mailbox addr\n");
+		ret = -EINVAL;
+		goto done;
+	}
+	acpi_mp_wake_mailbox_paddr = mailaddr;
+	if (wake_mailbox_paddr)
+		*wake_mailbox_paddr = mailaddr;
+	pr_info("dt wakeup-mailbox: addr 0x%llx\n", mailaddr);
+	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+done:
+	of_node_put(node);
+	return ret;
+}
+#endif /* CONFIG_OF */
-- 
2.25.1


