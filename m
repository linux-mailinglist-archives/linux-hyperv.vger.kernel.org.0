Return-Path: <linux-hyperv+bounces-7234-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B942BBE6218
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 04:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B660C1A63CA0
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 02:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56CD2566F7;
	Fri, 17 Oct 2025 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUHArk9Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF101B424F;
	Fri, 17 Oct 2025 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669332; cv=none; b=OBKBAdmWZi4U4+jks2YScqVW/ESg2c9ZHTKlHzzTthiWqh7xtpCu6d1qdH86WtGa6Zs2VeseIQulcp0vXqLapOn/cnWkKwmFyqGcHI7aqDRJecFZHA/pwc8dlGbJ/4KOLJGIjCfG4qYnaYKiZNW9ASpEf0Rhj9vFOUvXm5rct9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669332; c=relaxed/simple;
	bh=yy8wYdbt9kakgXaxoWtnz9ydjfY97cM1sePEpjOv73o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SS0uiZecoX2wXMzS7TDRVT+K9+kH+WhuDTcRAAIUt9Ki24krtKgadifzufH7vxEs6NaZMV4uTpNBZywlCZRG5H9pvEJvn5ggAv5bJok9yD+Z1Fv9cBglT/0jDnsU/AkL9rUvNa2Nmio9PzXSK0kyOtfzO5wVUZ7zHaR669gn+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUHArk9Z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760669331; x=1792205331;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yy8wYdbt9kakgXaxoWtnz9ydjfY97cM1sePEpjOv73o=;
  b=XUHArk9ZZMu4N1u700rFgHtdc1PK5cDjAYmPWJd3uafcZk34Lpi/aL1B
   NxDwUeUfrI4NqVBGACWQV8FEZbi/+C78ir224qppveITpWp+ZCxKYBFUR
   M3jbQ3jPj3rlHzDdWE/oBjoSmkE+1NNXwtrkBTiZd7cGxULAtbB6Bgr94
   tTpyZ6m1RgWPzLKF2MTReiEz6WjVqcCVYUY747zNeQ098mCNlEiK/5z/A
   c7Pcc51cyKDIfXV2I4Eexm+RZDKpd0v7YGJSIhdcX0fDJp4xHcJYeKcXA
   P/2NM1S1FQBA+LWRwkjWSKAx1I2/xW2Inq+KtYP6PTeBwL5K/tgleXiyw
   w==;
X-CSE-ConnectionGUID: bNgvcg6AQ6CSq05JBRISBQ==
X-CSE-MsgGUID: WSjgmA3OS0mRNFdq8SVuoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="80321899"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="80321899"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:49 -0700
X-CSE-ConnectionGUID: h0+G6mV7QCahHB/mCFN4IA==
X-CSE-MsgGUID: tT/BvW3oRRyDGVSfzbUgKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="219776547"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:48 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 16 Oct 2025 19:57:24 -0700
Subject: [PATCH v6 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to
 smpwakeup.c
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-rneri-wakeup-mailbox-v6-2-40435fb9305e@linux.intel.com>
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
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760669902; l=9884;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=yy8wYdbt9kakgXaxoWtnz9ydjfY97cM1sePEpjOv73o=;
 b=wEFZNVJnjhsLlVPvFsCnUmZagCentzfOsu+9MFEc6nC6SZsqy+Z30RMqqzdLRo/0fcLzgF5WZ
 rA/rx1CdnZWDRgKyBJoP2aLaHljEOUWYSrVbnrDgP18B+RWwT5GFSxm
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

The bootstrap processor uses acpi_wakeup_cpu() to indicate to firmware that
it wants to boot a secondary CPU using a mailbox as described in the
Multiprocessor Wakeup Structure of the ACPI specification.

The platform firmware may implement the mailbox as described in the ACPI
specification but enumerate it using a DeviceTree graph. An example of
this is the OpenHCL paravisor.

Move the code used to setup and use the mailbox for CPU wakeup out of the
ACPI directory into a new smpwakeup.c file that can be used by both ACPI
and DeviceTree.

No functional changes are intended.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 - Minor change to the changelog. (Rafael)
 - Added Acked-by tag from Rafael. Thanks!
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes since v4:
 - Removed dependency on CONFIG_OF. It will be added in a later patch.
   (Rafael)
 - Rebased on v6.16-rc3.

Changes since v3:
 - Create a new file smpwakeup.c instead of relocating it to smpboot.c.
   (Rafael)

Changes since v2:
 - Only move to smpboot.c the portions of the code that configure and
   use the mailbox. This also resolved the compile warnings about unused
   functions that Michael Kelley reported.
 - Edited the commit message for clarity.

Changes since v1:
 - None.
---
 arch/x86/Kconfig                   |  7 ++++
 arch/x86/kernel/Makefile           |  1 +
 arch/x86/kernel/acpi/madt_wakeup.c | 76 ----------------------------------
 arch/x86/kernel/smpwakeup.c        | 83 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 76 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a..f57192a34a87 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1108,6 +1108,13 @@ config X86_LOCAL_APIC
 	depends on X86_64 || SMP || X86_UP_APIC || PCI_MSI
 	select IRQ_DOMAIN_HIERARCHY
 
+config X86_MAILBOX_WAKEUP
+	def_bool y
+	depends on ACPI_MADT_WAKEUP
+	depends on X86_64
+	depends on SMP
+	depends on X86_LOCAL_APIC
+
 config ACPI_MADT_WAKEUP
 	def_bool y
 	depends on X86_64
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index bc184dd38d99..a9a1fbc798fb 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -94,6 +94,7 @@ apm-y				:= apm_32.o
 obj-$(CONFIG_APM)		+= apm.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP)		+= smpboot.o
+obj-$(CONFIG_X86_MAILBOX_WAKEUP) += smpwakeup.o
 obj-$(CONFIG_X86_TSC)		+= tsc_sync.o
 obj-$(CONFIG_SMP)		+= setup_percpu.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index c3ac5ecf3e7d..a7e0158269b0 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -2,12 +2,10 @@
 #include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
-#include <linux/io.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
 #include <linux/pgtable.h>
 #include <linux/sched/hotplug.h>
-#include <asm/apic.h>
 #include <asm/barrier.h>
 #include <asm/init.h>
 #include <asm/intel_pt.h>
@@ -15,12 +13,6 @@
 #include <asm/processor.h>
 #include <asm/reboot.h>
 
-/* Physical address of the Multiprocessor Wakeup Structure mailbox */
-static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
-
-/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
-static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
-
 static u64 acpi_mp_pgd __ro_after_init;
 static u64 acpi_mp_reset_vector_paddr __ro_after_init;
 
@@ -127,63 +119,6 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 	return 0;
 }
 
-static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip, unsigned int cpu)
-{
-	if (!acpi_mp_wake_mailbox_paddr) {
-		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
-		return -EOPNOTSUPP;
-	}
-
-	/*
-	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
-	 *
-	 * Wakeup of secondary CPUs is fully serialized in the core code.
-	 * No need to protect acpi_mp_wake_mailbox from concurrent accesses.
-	 */
-	if (!acpi_mp_wake_mailbox) {
-		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
-						sizeof(*acpi_mp_wake_mailbox),
-						MEMREMAP_WB);
-	}
-
-	/*
-	 * Mailbox memory is shared between the firmware and OS. Firmware will
-	 * listen on mailbox command address, and once it receives the wakeup
-	 * command, the CPU associated with the given apicid will be booted.
-	 *
-	 * The value of 'apic_id' and 'wakeup_vector' must be visible to the
-	 * firmware before the wakeup command is visible.  smp_store_release()
-	 * ensures ordering and visibility.
-	 */
-	acpi_mp_wake_mailbox->apic_id	    = apicid;
-	acpi_mp_wake_mailbox->wakeup_vector = start_ip;
-	smp_store_release(&acpi_mp_wake_mailbox->command,
-			  ACPI_MP_WAKE_COMMAND_WAKEUP);
-
-	/*
-	 * Wait for the CPU to wake up.
-	 *
-	 * The CPU being woken up is essentially in a spin loop waiting to be
-	 * woken up. It should not take long for it wake up and acknowledge by
-	 * zeroing out ->command.
-	 *
-	 * ACPI specification doesn't provide any guidance on how long kernel
-	 * has to wait for a wake up acknowledgment. It also doesn't provide
-	 * a way to cancel a wake up request if it takes too long.
-	 *
-	 * In TDX environment, the VMM has control over how long it takes to
-	 * wake up secondary. It can postpone scheduling secondary vCPU
-	 * indefinitely. Giving up on wake up request and reporting error opens
-	 * possible attack vector for VMM: it can wake up a secondary CPU when
-	 * kernel doesn't expect it. Wait until positive result of the wake up
-	 * request.
-	 */
-	while (READ_ONCE(acpi_mp_wake_mailbox->command))
-		cpu_relax();
-
-	return 0;
-}
-
 static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
 {
 	cpu_hotplug_disable_offlining();
@@ -246,14 +181,3 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	return 0;
 }
-
-void __init acpi_setup_mp_wakeup_mailbox(u64 mailbox_paddr)
-{
-	acpi_mp_wake_mailbox_paddr = mailbox_paddr;
-	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
-}
-
-struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
-{
-	return acpi_mp_wake_mailbox;
-}
diff --git a/arch/x86/kernel/smpwakeup.c b/arch/x86/kernel/smpwakeup.c
new file mode 100644
index 000000000000..5089bcda615d
--- /dev/null
+++ b/arch/x86/kernel/smpwakeup.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+#include <asm/apic.h>
+#include <asm/barrier.h>
+#include <asm/processor.h>
+
+/* Physical address of the Multiprocessor Wakeup Structure mailbox */
+static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
+
+/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+
+static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip, unsigned int cpu)
+{
+	if (!acpi_mp_wake_mailbox_paddr) {
+		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
+	 *
+	 * Wakeup of secondary CPUs is fully serialized in the core code.
+	 * No need to protect acpi_mp_wake_mailbox from concurrent accesses.
+	 */
+	if (!acpi_mp_wake_mailbox) {
+		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
+						sizeof(*acpi_mp_wake_mailbox),
+						MEMREMAP_WB);
+	}
+
+	/*
+	 * Mailbox memory is shared between the firmware and OS. Firmware will
+	 * listen on mailbox command address, and once it receives the wakeup
+	 * command, the CPU associated with the given apicid will be booted.
+	 *
+	 * The value of 'apic_id' and 'wakeup_vector' must be visible to the
+	 * firmware before the wakeup command is visible.  smp_store_release()
+	 * ensures ordering and visibility.
+	 */
+	acpi_mp_wake_mailbox->apic_id	    = apicid;
+	acpi_mp_wake_mailbox->wakeup_vector = start_ip;
+	smp_store_release(&acpi_mp_wake_mailbox->command,
+			  ACPI_MP_WAKE_COMMAND_WAKEUP);
+
+	/*
+	 * Wait for the CPU to wake up.
+	 *
+	 * The CPU being woken up is essentially in a spin loop waiting to be
+	 * woken up. It should not take long for it wake up and acknowledge by
+	 * zeroing out ->command.
+	 *
+	 * ACPI specification doesn't provide any guidance on how long kernel
+	 * has to wait for a wake up acknowledgment. It also doesn't provide
+	 * a way to cancel a wake up request if it takes too long.
+	 *
+	 * In TDX environment, the VMM has control over how long it takes to
+	 * wake up secondary. It can postpone scheduling secondary vCPU
+	 * indefinitely. Giving up on wake up request and reporting error opens
+	 * possible attack vector for VMM: it can wake up a secondary CPU when
+	 * kernel doesn't expect it. Wait until positive result of the wake up
+	 * request.
+	 */
+	while (READ_ONCE(acpi_mp_wake_mailbox->command))
+		cpu_relax();
+
+	return 0;
+}
+
+void __init acpi_setup_mp_wakeup_mailbox(u64 mailbox_paddr)
+{
+	acpi_mp_wake_mailbox_paddr = mailbox_paddr;
+	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+}
+
+struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
+{
+	return acpi_mp_wake_mailbox;
+}

-- 
2.43.0


