Return-Path: <linux-hyperv+bounces-6036-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E67AEC486
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 05:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1EE4A809B
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 03:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8635921CA04;
	Sat, 28 Jun 2025 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWAK5csl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BC21B191;
	Sat, 28 Jun 2025 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081723; cv=none; b=ZOOMGUlat1k6HtUz1XFOWFe1R2G+cC/4sGJ5S19NTEeNawJk+wngvylziccSYAPqWzt04bo1+BklDf2bGZUvIQSq/IENlqhQubwwz7nBd/f29jQVTHN3lXC5P5vLTEqxDghuvF2JiFO7URfhsDWRml+KdryH9m0MWGK+RjtR+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081723; c=relaxed/simple;
	bh=j8bwDO3WHMvsfI9FYwYOft+Xg9EMM6fDrrMDsmZxkIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1MxPT0BgLCFXNNwokRBLLdtWGNyia4KQCr1rIO3mnqWpaOSM9MxZF7474XRC89W2GAribCUlROhK83J+B/GWSY5mFpavT+BWEUQpi2XETTEtc/4QhwPg16GmyW0njgmQdZ4qFSXPLH8+HdqKJsoDI80LPAr2re38pCBuQrQEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWAK5csl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751081722; x=1782617722;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=j8bwDO3WHMvsfI9FYwYOft+Xg9EMM6fDrrMDsmZxkIM=;
  b=EWAK5cslunnOAE7bnnLwsIT/mqA6LhmrQQhsj5oWs7GF8x/clehNvOpr
   7es6jUsZbPxhpwqXDLEi2W6HtcmcHKUFSV7a8TQhvztDy2+W2mnyt60JL
   lJzKmdJrRfqW0VJNDn71QaGvjxkDzkgRWzFpcviLZRfYM+PrQMEkOuefT
   MFoFsqjX21tdXok1HfjqdU32WGVjBTg1t/X3PWBUDwPRll4JuBjOY1IJp
   ifysf974+XA0rwTw3F4el7CVOToA0FSNPATBaLqNtD7zpJe0V2M6o1UeX
   anoe8iLOvfGQG1A9bEufc4Rlgux+Vt3BTGAYJNgiBE6iNVscMP4i8jgrP
   A==;
X-CSE-ConnectionGUID: 4r2Q0E5oQhSj1YyDM9iHZw==
X-CSE-MsgGUID: DbiERBBBRq6MJyTfprgV8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53335320"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53335320"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:19 -0700
X-CSE-ConnectionGUID: 8gZUoK9kSaCLkHnIUw2Xxg==
X-CSE-MsgGUID: cBP66ubWRh2R69UECU2RLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="153141921"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:19 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 27 Jun 2025 20:35:08 -0700
Subject: [PATCH v5 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to
 smpwakeup.c
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-rneri-wakeup-mailbox-v5-2-df547b1d196e@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751081737; l=9612;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=j8bwDO3WHMvsfI9FYwYOft+Xg9EMM6fDrrMDsmZxkIM=;
 b=iOLUJv03U65R+nis5QaxTTGaya9G/6TWV3DzM2ESFPNOSRyjUxFgflzE18qBEyhRjI5wnYLoo
 zXwR7rG40rNBLk7IXm6RxlJGTTHxiat92JldiVjUoj0D2xdlAQWBtS0
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

The bootstrap processor uses acpi_wakeup_cpu() to indicate to firmware that
it wants to boot a secondary CPU using a mailbox as described in the
Multiprocessor Wakeup Structure of the ACPI specification.

The platform firmware may implement the mailbox as described in the ACPI
specification but enumerate it using a DeviceTree graph. An example of
this is OpenHCL paravisor.

Move the code used to setup and use the mailbox for CPU wakeup out of the
ACPI directory into a new smpwakeup.c file that both ACPI and DeviceTree
can use.

No functional changes are intended.

Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
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
index 71019b3b54ea..e3009cb59928 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1114,6 +1114,13 @@ config X86_LOCAL_APIC
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
index 0d2a6d953be9..1fce3d20cf2d 100644
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


