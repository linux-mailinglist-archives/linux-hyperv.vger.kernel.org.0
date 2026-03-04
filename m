Return-Path: <linux-hyperv+bounces-9140-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMtoIZHDqGk2xAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9140-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2CC2090D5
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DAF0308CE66
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 23:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9520391825;
	Wed,  4 Mar 2026 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiQRHS59"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7933845B3;
	Wed,  4 Mar 2026 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667752; cv=none; b=YhmBbTb0bx2NJcIDQfBWLyaYnJxDLJ+sOLmgKmwnCv3rnqot5bu2MfBqXfLIP9o/w47SjpLZkr8yK/krjwUTuN1yyWkrhqCNiqf+i3dTnCrkLmZsOTHVGezplaiL40/sliZ8y3iHAMZX0T6nrOCApTzuxMyhJmtO2kS10WAQyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667752; c=relaxed/simple;
	bh=qXYoaEms0cS0wZC2ODKoxzgS7jq86FPFbDCJ0PJAAY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eCiFZsqraeNfoWOCIXU6gqnMyy/S5huuLfkNbFLFV95Jk/DkQL7MRn2YrYsETtOacPHk7VX5+iyL5dM+WmDeR5qyTFGtELkAK4dca/TemxHuRt7PO/uHix3qOF44RBVD6rhVupVmcBs4P8CfSn7qNTqLXoMoR4TmS2+LfAq7YA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiQRHS59; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772667752; x=1804203752;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qXYoaEms0cS0wZC2ODKoxzgS7jq86FPFbDCJ0PJAAY8=;
  b=TiQRHS59RL6M2CUPgLmHldNfKSLKuxdRagtxMG10youMLCGZqUEmwMFx
   61yQN8nzI14QlXQr0AF2cdq7i1ke0eO9/vlYnx1kwvYLy3urTCNezdinQ
   I/gaI7nyB9Sg4kCmSdFq6B8K7Lzm2zzJKuKzjFgY+/Y4T/3OxmSaiCA/t
   +qa5FsMJdUNN0a/gDjJl6N4Bx1RfvGQNeSBZKWQZf/Juih0xs7D8UBvWB
   y2kYNH0DQeEVNqog3YqYwEtomCGpL9rd2IZB1ujArDE6R37jSLXW9qszV
   N0E1DUPsn71GhPZ08YUWsWvX3UKRiroCxzRRMK2FHWoLuFhemlp/eFazB
   g==;
X-CSE-ConnectionGUID: DmvOwcpUSxCm9wSy4g7foQ==
X-CSE-MsgGUID: VpjcBPklTK6j0w7Dsn719w==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96359379"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="96359379"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:30 -0800
X-CSE-ConnectionGUID: DpyxQfphQvKbvlEYc1Y6mw==
X-CSE-MsgGUID: vvWKmyObRIO42J1Vpg/z9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215376902"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:28 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 04 Mar 2026 15:41:15 -0800
Subject: [PATCH v9 04/10] x86/dt: Parse the Wakeup Mailbox for Intel
 processors
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-rneri-wakeup-mailbox-v9-4-a5c6845e6251@linux.intel.com>
References: <20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com>
In-Reply-To: <20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772667694; l=4553;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=qXYoaEms0cS0wZC2ODKoxzgS7jq86FPFbDCJ0PJAAY8=;
 b=a0g3m9Q5qiVTigofzAeeCBKtUdDx3rbqCjAs87qGUQ4NPFgf7qEh0lMxPnmPSC9TlUynsog64
 x3BjpM1/8q3CglVWda/ewap8tYkawwB5xPLM05Z1Nq/7GiSqJ6RkDiP
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=
X-Rspamd-Queue-Id: 1E2CC2090D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9140-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,n:email]
X-Rspamd-Action: no action

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
Changes in v9:
 - None

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


