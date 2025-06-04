Return-Path: <linux-hyperv+bounces-5731-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F281ACD08C
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 02:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B35176672
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 00:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747521A29A;
	Wed,  4 Jun 2025 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/jyPP6Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB9D6AA7;
	Wed,  4 Jun 2025 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748996285; cv=none; b=Dq9QdoumhRc+g0+MbnX3BjyR7UcYzQsFnwFYIA1StDyJfrsf8J0/v69b9Ire5uP5Tx1rMoZshbLiZWhrMklzgi0l4Ay7SaL8DgQJFgzdoiwUxKsjzMyB6AfJLCFOA0rlKKxgLsKzeowu/CnK84ySCRd8OdzJ3MdG3KDJMjTsBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748996285; c=relaxed/simple;
	bh=pPl7b6XtSmseHCkcheCWPHAL+avH9O3JDG2Rt0uU5Cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qKn4HhF68oGP7L67Uf2XukwVJEdB/LIGmEhBxLDp73sXyXTmQqmwVoT68U3g+Ks3234p83Ueulm1qCcAtkVK4BAdIoFMHKxaafS1PNOzEwzNGriHAHkEhmFJB65HtK1mMFr5HlHhGcaMVdwte+pp92SrRKGtT9iIcDUGQQ2Rxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/jyPP6Z; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748996284; x=1780532284;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pPl7b6XtSmseHCkcheCWPHAL+avH9O3JDG2Rt0uU5Cw=;
  b=Z/jyPP6ZYBpX+Z8b/Ruo3OYK6qvjtsNsreN1tufhB9h1i66HotpgxIGb
   u+AhljMyLzBNh55nsSU9jiCxNTyjkOhtF/fFWlWKK7GEjbJCdwcD/gVaF
   xSLgMb73uhjwcqZrDVtKpKLUKdrfl8ktdnHzK7vttxc9LcC2wuvr7KW2K
   wTdNZ5ucEHgevR8KGoLM2DMiDvIYTz5pZX4uNtpmlZ+C4DhNYW6l2edEk
   Kqb0ImjHE/rpVNC98StelQG7e2LYV1YGbw6kN9kDMLyVtpLDkSRWAw0ws
   iQbDk6H8pjFVLNi6p0hfdNSSl8XS81wYj22iUQ3JIZrZlDX0O2sIWKWHt
   Q==;
X-CSE-ConnectionGUID: UCdK2FJ6QLOGmSZhffrvwQ==
X-CSE-MsgGUID: nMnDq8f5QlCX9vozTg+xLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62112933"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62112933"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:01 -0700
X-CSE-ConnectionGUID: CM18UCLdQiaVfJzzHWlACw==
X-CSE-MsgGUID: 1Qu4mFWMT3SAvRMiB7sUoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="149904454"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:00 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 03 Jun 2025 17:15:14 -0700
Subject: [PATCH v4 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to
 smpwakeup.c
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-rneri-wakeup-mailbox-v4-2-d533272b7232@linux.intel.com>
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
In-Reply-To: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
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
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748996287; l=9450;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=pPl7b6XtSmseHCkcheCWPHAL+avH9O3JDG2Rt0uU5Cw=;
 b=1CCcC47E8CEf8V9oEUfYfQ2PLhaqmKAjC4IoI7CWqbrsBCxPy6I600CaJjUQDi5DwST4QzLSO
 TFA/jgJvaoLBYkCri6ifvEz4vr70dPsF1WtSmu1lHdmWpzLhFz5Sym3
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
index cb0f4af31789..82147edb355a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1113,6 +1113,13 @@ config X86_LOCAL_APIC
 	depends on X86_64 || SMP || X86_UP_APIC || PCI_MSI
 	select IRQ_DOMAIN_HIERARCHY
 
+config X86_MAILBOX_WAKEUP
+	def_bool y
+	depends on OF || ACPI_MADT_WAKEUP
+	depends on X86_64
+	depends on SMP
+	depends on X86_LOCAL_APIC
+
 config ACPI_MADT_WAKEUP
 	def_bool y
 	depends on X86_64
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 99a783fd4691..8f078af42a71 100644
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
index 4033c804307a..a7e0158269b0 100644
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
 
-static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
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
index 000000000000..e34ffbfffaf5
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
+static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
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


