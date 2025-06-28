Return-Path: <linux-hyperv+bounces-6035-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 177F3AEC480
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 05:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E9E1BC70AE
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 03:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E5721C165;
	Sat, 28 Jun 2025 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eV2Q6Zyu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D41DC9A3;
	Sat, 28 Jun 2025 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081722; cv=none; b=HsUgi7WpbMZc0NNnPiKflMB/D1JXqwSwxtmCtoUPFyhD+AVU278QSdZW+oMWIYSmGxbEcH6b6+5P9I2xNL0z0gbjUD5YXXYKyBG2vHQNK59WsvbRXndxmo139stkTiQUMr9cWOPKvYsb/wf0nEoywRGrr5kjU+P9jGMzOXfkTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081722; c=relaxed/simple;
	bh=s9EY1xoCTSXe3LXRtsiD6ykIH2wv0AgLTU6Q6NZ6HRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OU4ujcws8p245D4c5PnmtohCwSBg+y7bOD2pMCqPpPqLROcgA5yuzlbQNVMfoEQsw8QrqOrhvQ3JWpeZh/lkMAyKpaGtOY/mDXEwY3jgaAAlbaszieoKbgAXiobEDsUiYd7Qzhz+F6CBhMVFxIL1GTSY282zECqBYZH3ty0dvPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eV2Q6Zyu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751081721; x=1782617721;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=s9EY1xoCTSXe3LXRtsiD6ykIH2wv0AgLTU6Q6NZ6HRY=;
  b=eV2Q6ZyuRfvmhlbRFS4dpMjuvPP+KLaJPcD12DhX9ZoVIBfJzb1w7pFO
   uKPUL67mORSvQL7R0yrhnwsKwUJQ+iNe9FCY6+JBxaHbQArclooM3efv0
   Ik3t+3H6QGp1w5wB2ogMVdOfvAXCgjr4vaY7muvYBxFeekGkxMo7T1jRL
   uUPY2Cm8DwSae0CNywWH/GhDfTYFMMPbXBqEbAu4+Jk5ID5HDjpq0WkS2
   bEM9r7s6ld7VL8J7s5oVfx3AQQpVKhgpNwO+EVbNu3GnZEaoPP5zpoKwd
   pL+JKxw69HunsnGMOdWgxMVEDgeW+wFj33CIOi3zNUqO2HNDMoBboUwIw
   A==;
X-CSE-ConnectionGUID: GVmPJyG3SqKI04JSsCBujA==
X-CSE-MsgGUID: t2yAe5quQli8Gm+zypvv4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53335315"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53335315"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:19 -0700
X-CSE-ConnectionGUID: 4FEp2KyLTSyYRB/3M03tZg==
X-CSE-MsgGUID: OTd2bSHFSnSS8+Bso9AhrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="153141917"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:18 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 27 Jun 2025 20:35:07 -0700
Subject: [PATCH v5 01/10] x86/acpi: Add a helper functions to setup and
 access the wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-rneri-wakeup-mailbox-v5-1-df547b1d196e@linux.intel.com>
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
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751081737; l=3970;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=s9EY1xoCTSXe3LXRtsiD6ykIH2wv0AgLTU6Q6NZ6HRY=;
 b=xBFp2wyk51bdqt8PiSY1kNZPqGW5l1kIw8zXSsz1Fx/zgAMPjdi7xoBNzrpqijHvtg3cExfji
 2jQy0w+H/evBZ51dzpWRdRHmURWYGeqph6Vjfpe026PrWXNFuxD+Tfg
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

In preparation to move the functionality to wake secondary CPUs up out of
the ACPI code, add two helper functions.

The function acpi_setup_mp_wakeup_mailbox() stores the physical address of
the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.

There is a slight change in behavior: now the APIC callback is updated
before configuring CPU hotplug offline behavior. This is fine as the APIC
callback continues to be updated unconditionally, regardless of the
restriction on CPU offlining.

The function acpi_madt_multiproc_wakeup_mailbox() returns a pointer to the
mailbox. Use this helper function only in the portions of the code for
which the variable acpi_mp_wake_mailbox will be out of scope once it is
relocated out of the ACPI directory.

The wakeup mailbox is only supported for CONFIG_X86_64 and needed only with
CONFIG_SMP=y.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 - None

Changes since v3:
 - Squashed the two first patches of the series into one, both introduce
   helper functions. (Rafael)
 - Renamed setup_mp_wakeup_mailbox() as acpi_setup_mp_wakeup_mailbox().
   (Rafael)
 - Dropped the function prototype for !CONFIG_X86_64. (Rafael)

Changes since v2:
 - Introduced this patch.

Changes since v1:
 - N/A
---
 arch/x86/include/asm/smp.h         |  3 +++
 arch/x86/kernel/acpi/madt_wakeup.c | 20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 0c1c68039d6f..77dce560a70a 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -146,6 +146,9 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 	return per_cpu(cpu_l2c_shared_map, cpu);
 }
 
+void acpi_setup_mp_wakeup_mailbox(u64 addr);
+struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void);
+
 #else /* !CONFIG_SMP */
 #define wbinvd_on_cpu(cpu)     wbinvd()
 static inline int wbinvd_on_all_cpus(void)
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 6d7603511f52..c3ac5ecf3e7d 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -37,6 +37,7 @@ static void acpi_mp_play_dead(void)
 
 static void acpi_mp_cpu_die(unsigned int cpu)
 {
+	struct acpi_madt_multiproc_wakeup_mailbox *mailbox = acpi_get_mp_wakeup_mailbox();
 	u32 apicid = per_cpu(x86_cpu_to_apicid, cpu);
 	unsigned long timeout;
 
@@ -46,13 +47,13 @@ static void acpi_mp_cpu_die(unsigned int cpu)
 	 *
 	 * BIOS has to clear 'command' field of the mailbox.
 	 */
-	acpi_mp_wake_mailbox->apic_id = apicid;
-	smp_store_release(&acpi_mp_wake_mailbox->command,
+	mailbox->apic_id = apicid;
+	smp_store_release(&mailbox->command,
 			  ACPI_MP_WAKE_COMMAND_TEST);
 
 	/* Don't wait longer than a second. */
 	timeout = USEC_PER_SEC;
-	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
+	while (READ_ONCE(mailbox->command) && --timeout)
 		udelay(1);
 
 	if (!timeout)
@@ -227,7 +228,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
+	acpi_setup_mp_wakeup_mailbox(mp_wake->mailbox_address);
 
 	if (mp_wake->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
 	    mp_wake->header.length >= ACPI_MADT_MP_WAKEUP_SIZE_V1) {
@@ -243,7 +244,16 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 		acpi_mp_disable_offlining(mp_wake);
 	}
 
+	return 0;
+}
+
+void __init acpi_setup_mp_wakeup_mailbox(u64 mailbox_paddr)
+{
+	acpi_mp_wake_mailbox_paddr = mailbox_paddr;
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+}
 
-	return 0;
+struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
+{
+	return acpi_mp_wake_mailbox;
 }

-- 
2.43.0


