Return-Path: <linux-hyperv+bounces-5333-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20084AA822C
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9EF1B61042
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0A280300;
	Sat,  3 May 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfyg5vhd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B16E27F738;
	Sat,  3 May 2025 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299417; cv=none; b=QIGVpUCmnWd3l1XcM5Sau34O5lKkCqHBA52tOQEJK55lmmedveDGaxRM3YyGK5ex2/0FjRVThjyT1ND9uf+tw9MtMKAbIWWpO1TlA+7e6XwFmP0rqUaxNP6wkLEPRsMiH/wb1sU5ZCoHe3BM2D69zOs6x6rrz5kIMBeXQAevgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299417; c=relaxed/simple;
	bh=8yh12neJuVAsQUujZm/Vfdbuz1pj4bfgQ7MsKN5YAU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UraiaB/t5qLM2Y2ls3awRuAiPvcnzsfweYYfrO2jm5NSUwXT0IfGC/xocPs6n81S3U4OpHtuwmwiUDIb0voRN04VqQIUeJQh5iKvPmjFrRWgGTipJs2a9r02HHboPWSu+dzNT/p74LTz83ZfgulNBlRRPDlPigVKY/b3sYWJLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfyg5vhd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299416; x=1777835416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8yh12neJuVAsQUujZm/Vfdbuz1pj4bfgQ7MsKN5YAU4=;
  b=mfyg5vhdmOxxW3bfUSG9GpjFLT3vT2HBUj3l5/QQEJzOO08gpLE+DhI8
   sgjeUq396qrtMw3LBvjmRNcOR6yQG52PAe7rHEFPJgPa2e5niouknZ3h9
   3FEaMMzP3nSGe8PCjkA4BrDLh11eqAvHHc+eQpacLJ2EeszDs6T1lCHST
   xW1oTBVcx9Rx+NRdYNXN4RJcfPbZEBSFRKCy3x8peeqt4+zomIxAJzE+6
   kl4+5djaD3vTC0p+ghPElJqypuPHUJU9SCwZ+ReAb5eBq7ot66WqCu2wg
   w3wgFsuA2rT077UTrhKt0Mp7DvDtZDhYOTjATkcEHEkGUyzxrQ07BWRYR
   Q==;
X-CSE-ConnectionGUID: yhx4rgsPR9Chv8/COuw3XA==
X-CSE-MsgGUID: kSoVO3/qTHywrTGiot5qSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095634"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:14 -0700
X-CSE-ConnectionGUID: j0CcJvp3TlG/WY77LKjhhw==
X-CSE-MsgGUID: NZWvzE9CTBKfxfhmtAB56w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046101"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:13 -0700
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
Subject: [PATCH v3 07/13] x86/dt: Parse the Wakeup Mailbox for Intel processors
Date: Sat,  3 May 2025 12:15:09 -0700
Message-Id: <20250503191515.24041-8-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The Wakeup Mailbox is a mechanism to boot secondary CPUs used on systems
that do not want or cannot use the INIT + StartUp IPI messages.

Add `intel,wakeup-mailbox` to the set of supported enable methods. Also add
functionality to find and parse the parameters of the mailbox from the
DeviceTree from the platform firmware.

The operation and structure of the Wakeup Mailbox are described in the
corresponding DeviceTree schema that accompanies the documentation of the
Linux kernel.

The Wakeup Mailbox is compatible with the Multiprocessor Wakeup Mailbox
Structure described in the ACPI specification. Reuse the existing
functionality to set the memory location of the mailbox and update the
wakeup_secondary_cpu_64() APIC callback.

do_boot_cpu() uses wakeup_secondary_cpu_64() when set. If a wakeup mailbox
is found (enumerated via an ACPI table or a DeviceTree node) it will be
used unconditionally. For cases in which this behavior is not desired, this
APIC callback can be updated later during boot using platform-specific
hooks.

Originally-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
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
 arch/x86/kernel/devicetree.c | 57 ++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5835afc74acd..d03d9e23c693 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 #include <linux/of_pci.h>
 #include <linux/initrd.h>
+#include <linux/smp.h>
 
 #include <asm/irqdomain.h>
 #include <asm/hpet.h>
@@ -128,7 +129,59 @@ static void __init dtb_setup_hpet(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 
 #ifdef CONFIG_SMP
-static const char *dtb_supported_enable_methods[] __initconst = { };
+
+#ifdef CONFIG_X86_64
+
+#define WAKEUP_MAILBOX_SIZE	0x1000
+#define WAKEUP_MAILBOX_ALIGN	0x1000
+
+static int __init dtb_parse_wakeup_mailbox(const char *enable_method)
+{
+	struct device_node *node;
+	struct resource res;
+	int ret = 0;
+
+	if (strcmp(enable_method, "intel,wakeup-mailbox"))
+		return -EINVAL;
+
+	node = of_find_compatible_node(NULL, NULL, "intel,wakeup-mailbox");
+	if (!node)
+		return -ENODEV;
+
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret)
+		goto done;
+
+	/* The mailbox is a 4KB-aligned region.*/
+	if (res.start & (WAKEUP_MAILBOX_ALIGN - 1)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	/* The mailbox has a size of 4KB. */
+	if (res.end - res.start + 1 != WAKEUP_MAILBOX_SIZE) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	/* Not supported when the mailbox is used. */
+	cpu_hotplug_disable_offlining();
+
+	setup_mp_wakeup_mailbox(res.start);
+done:
+	of_node_put(node);
+	return ret;
+}
+#else /* !CONFIG_X86_64 */
+static inline int dtb_parse_wakeup_mailbox(const char *enable_method)
+{
+	return -ENOTSUPP;
+}
+#endif /* CONFIG_X86_64 */
+
+static const char *dtb_supported_enable_methods[] __initconst = {
+	"intel,wakeup-mailbox"
+};
 
 static bool __init dtb_enable_method_is_valid(const char *enable_method_a,
 					      const char *enable_method_b)
@@ -155,7 +208,7 @@ static int __init dtb_configure_enable_method(const char *enable_method)
 	if (!enable_method || IS_ERR(enable_method))
 		return 0;
 
-	return -ENOTSUPP;
+	return dtb_parse_wakeup_mailbox(enable_method);
 }
 #else /* !CONFIG_SMP */
 static inline bool dtb_enable_method_is_valid(const char *enable_method_a,
-- 
2.43.0


