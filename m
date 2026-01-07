Return-Path: <linux-hyperv+bounces-8180-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3326D003C4
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 22:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 406643089CC2
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFD1318EEF;
	Wed,  7 Jan 2026 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHKEh0dx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0717302163;
	Wed,  7 Jan 2026 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822367; cv=none; b=VthzcHkAmjsHG+K6WO+5DJDtR9fUdJxFmVp0mrgufyUMFw2bwGV5HGfZEF3m/Cb54WZ34r8UKrGQw4G4YUntXtGoWXOZ8H6r2gHlIiIX87iKqfNN9I/twOsbhy+MtzRn8RXlwhfflNJ/s3+P1L0No8PBdUpK3ABcnVZVPnpk+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822367; c=relaxed/simple;
	bh=vBl/wFc/Idotd1xOdmbDaIFtFynyU3RgAK2c/Q+umoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1vWmY9faxEzySOvjpol14aHmvmC5xRinZZD4DmbTY2f0jEnpET4sZBCdusB6je4/l+OWNnv8lplYsf/tzrSiknZcc32DYNnSc3NGxPyVeVqpaxfTkNsH5tEIAllHPXYZyEezK61KtcL+ba9KxM6wFVhL4If7dDL/gxN016qq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHKEh0dx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767822365; x=1799358365;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vBl/wFc/Idotd1xOdmbDaIFtFynyU3RgAK2c/Q+umoY=;
  b=BHKEh0dxCTClVlc1ajuCqjCIA38WVNx8u9DnjZiThV1NTaosJDm3C8ou
   Y619/9D2PfxcWOIlZcfLvq/8WCE2WS+paQ6ipjUygpDBjwGyzvuc5G3oc
   6M0BOAq/eEpFs/o598Vb/nwo+jt5dSB2CYfNNha19SRZdTDEdj2uqncZ5
   HQmtjeCHOVeADKSwmIQnLjlDDK/EQ3QaSQZS5WSb2Zz+Ey4f5rEJotXmA
   dWNsYcBaHx4we9Li9HNVRxVszq5gQW6CQ5TxAhKewXrst6HfhR2fIj50N
   PgNmL8eFnkESy9uGBJR95Y/b5+jYQKCSsxMy7HPGrvkXg0+uqhGSfceF2
   g==;
X-CSE-ConnectionGUID: O6D65noRSpa5Ug9XD2YYwA==
X-CSE-MsgGUID: VmCIeIoJRjyLbq+0vTDOXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69359282"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69359282"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:02 -0800
X-CSE-ConnectionGUID: b699fbwcS96ObaZIGuXTuw==
X-CSE-MsgGUID: JwuWCHS/TjuG+cWkMwtnBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207510905"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:01 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 07 Jan 2026 13:44:40 -0800
Subject: [PATCH v8 04/10] x86/dt: Parse the Wakeup Mailbox for Intel
 processors
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-rneri-wakeup-mailbox-v8-4-2f5b6785f2f5@linux.intel.com>
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
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767822314; l=4526;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=vBl/wFc/Idotd1xOdmbDaIFtFynyU3RgAK2c/Q+umoY=;
 b=1rluzKqIUMLBqdqnTjcprdZ+KRCf95fTZOk2YpJdAl9fKddOTnqZmqIT1MeOnm4+OxRULdk9T
 xploiIBFo7dAXrLBsRx5fsvGWRpNGfiT6E0wwQJK/F5qRtQRhdV/ws0
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
Changes in v8:
 - None

Changes in v7:
 - #included asm/acpi.h to reflect the updated declaration of the
   needed functions.
 - (Kept Reviewed-by tag from Dexuan, as this single change is trivial.)

Changes in v6:
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - Made CONFIG_X86_MAILBOX_WAKEUP depend on CONFIG_OF or CONFIG_ACPI_
   MADT_WAKEUP.

Changes in v4:
 - Look for the wakeup mailbox unconditionally, regardless of whether
   cpu@N nodes have an `enable-method` property.
 - Add a reference to the ACPI specification. (Rafael)

Changes in v3:
 - Added extra sanity checks when parsing the mailbox node.
 - Probe the mailbox using its `compatible` property
 - Setup the Wakeup Mailbox if the `enable-method` is found in the CPU
   nodes.
 - Cleaned up unneeded ifdeffery.
 - Clarified the mechanisms used to override the wakeup_secondary_64()
   callback to not use the mailbox when not desired. (Michael)
 - Edited the commit message for clarity.

Changes in v2:
 - Disabled CPU offlining.
 - Modified dtb_parse_mp_wake() to return the address of the mailbox.
---
 arch/x86/kernel/devicetree.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index dd8748c45529..318acaecb5ca 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -18,6 +18,7 @@
 #include <linux/of_pci.h>
 #include <linux/initrd.h>
 
+#include <asm/acpi.h>
 #include <asm/irqdomain.h>
 #include <asm/hpet.h>
 #include <asm/apic.h>
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


