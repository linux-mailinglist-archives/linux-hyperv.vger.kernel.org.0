Return-Path: <linux-hyperv+bounces-2836-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F1695D99D
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 01:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C734B2244A
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5CB1CC889;
	Fri, 23 Aug 2024 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Svs1PoSF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11F1C93AB;
	Fri, 23 Aug 2024 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455437; cv=none; b=QpfsvckNS9aD7VqRKTqHr0jmR3PKy+eboPejurj0hYNWxFI0m0fNBn0+AQpKuNXjUjzANyHewIfYpw+IrBKa4wd/FDLf06cKcs/3OBPJ/lvjyx4VXx8rtfiC2/suM4tRj248D2NLTDLaOqgOlDZpX72Bg3EGBwn/kUhjd1xpUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455437; c=relaxed/simple;
	bh=nZn1ciyBR2B58kThtRvuFisoY3nNii91Qu7mIDzoZRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWaHI+8BRbrshWukUz53/gyLSlx6kD+hZvEQ5S1OQ5YBEyZ8k3l8h8+tKKJMzTlq3SY0AVa+NUA2vouuKk5p1bHzrd3DqNJ1jWdXpnRfQ/GyeotdcTyvdJw/EbemjS3bCBVCGC/yEhnw0teH4odLsdTK27x0IsMf5ailENOv2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Svs1PoSF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724455436; x=1755991436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZn1ciyBR2B58kThtRvuFisoY3nNii91Qu7mIDzoZRk=;
  b=Svs1PoSFDpx4lzFEy+jDVsWKyMrS/KynkMX64MZtXTHjju87XLH6ZsYL
   4GG+5e6UuzFLUl56pLz0VQNXu8oYYjGJlA/jj0fIbOGL17pETQa4zEC5E
   o/TVFRIxSMYsfPpCKo0dmNehSk/45jzFA+DV7uFODp+OtZzM6YFdmeWlW
   4lxW/TD8A43ydKYUa+2QYGkH8rsCINwsmufr4/zEE+a0UkDYyry3+cDoV
   oHdyxajC8vGZjoSEvkuG8eX4MrximiY4oMhwdxFQNGDjuXRJx+tciC6so
   Ylyma9e4eoDlN4g+3KfarE5v6L27NkLZsPmYaUijobXEaGeb/I2bxQxQH
   w==;
X-CSE-ConnectionGUID: XDCrokDETsWVfz7hbBkwJQ==
X-CSE-MsgGUID: mpXhe/XpQjmD5iigTi6tpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33619291"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33619291"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:23:53 -0700
X-CSE-ConnectionGUID: cXsBjzu7TOK844sOw0PN9g==
X-CSE-MsgGUID: XJ/Gd9XORcmLHgqaB4gRyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61641005"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by fmviesa007.fm.intel.com with ESMTP; 23 Aug 2024 16:23:52 -0700
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
Subject: [PATCH v2 3/9] x86/dt: Support the ACPI multiprocessor wakeup for device tree
Date: Fri, 23 Aug 2024 16:23:21 -0700
Message-Id: <20240823232327.2408869-4-yunhong.jiang@linux.intel.com>
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
 arch/x86/include/asm/madt_wakeup.h | 16 +++++++++++++
 arch/x86/kernel/madt_wakeup.c      | 38 ++++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/madt_wakeup.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5555a3bbac5f..900de6501eba 100644
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
index d422247b2882..dba46dd30049 100644
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
index 000000000000..a8cd50af581a
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
+u64 dtb_parse_mp_wake(void);
+#else
+static inline u64 dtb_parse_mp_wake(void)
+{
+	return 0;
+}
+#endif
+
+#endif /* __ASM_X86_MADT_WAKEUP_H */
diff --git a/arch/x86/kernel/madt_wakeup.c b/arch/x86/kernel/madt_wakeup.c
index d5ef6215583b..7257e7484569 100644
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
@@ -122,6 +124,7 @@ static int __init init_transition_pgtable(pgd_t *pgd)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
 static int __init acpi_mp_setup_reset(u64 reset_vector)
 {
 	struct x86_mapping_info info = {
@@ -168,6 +171,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 
 	return 0;
 }
+#endif
 
 static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {
@@ -226,6 +230,7 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
 static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
 {
 	cpu_hotplug_disable_offlining();
@@ -290,3 +295,36 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	return 0;
 }
+#endif /* CONFIG_ACPI */
+
+#ifdef CONFIG_OF
+u64 __init dtb_parse_mp_wake(void)
+{
+	struct device_node *node;
+	u64 mailaddr = 0;
+
+	node = of_find_node_by_path("/cpus");
+	if (!node)
+		return 0;
+
+	if (of_property_match_string(node, "enable-method", "acpi-wakeup-mailbox") < 0) {
+		pr_err("No acpi wakeup mailbox enable-method\n");
+		goto done;
+	}
+
+	if (of_property_read_u64(node, "wakeup-mailbox-addr", &mailaddr)) {
+		pr_err("Invalid wakeup mailbox addr\n");
+		goto done;
+	}
+	acpi_mp_wake_mailbox_paddr = mailaddr;
+	pr_info("dt wakeup-mailbox: addr 0x%llx\n", mailaddr);
+
+	/* No support for the MADT reset vector yet */
+	cpu_hotplug_disable_offlining();
+	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+
+done:
+	of_node_put(node);
+	return mailaddr;
+}
+#endif /* CONFIG_OF */
-- 
2.25.1


