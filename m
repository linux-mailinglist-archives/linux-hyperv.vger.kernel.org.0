Return-Path: <linux-hyperv+bounces-5330-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92368AA8222
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574E61B60D65
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431A27F731;
	Sat,  3 May 2025 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEyNQ2cn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC327E7EF;
	Sat,  3 May 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299415; cv=none; b=MhTaZZOuBu7eG1K7EDE2VIJ3Z3CDWJ6jXgNzlAZX+pw7icC++lv8P8uhBLSFemY4Ivkn4f9Ng6q5xLt1AdN0ipL/AZSZQC6Y01jhVyEyMi1P7wH1RRyPrzvOk/BXdtSA7Djja0s8mE7iUEQzol63TCdjWGxTpzeSn5KeKNaMTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299415; c=relaxed/simple;
	bh=hZjwXQ4U3Ogt5HXln+2a/BfG4CZuHW1U7jlyBw+QUNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jMoCQWiEVy5o1k085g4SLpTxKSETYRroqkElHItxIFIIFeKSdis0i3RcmY5P092zP851kvfxQp6SWnqtL8oigQgFP9DybDQ6YRBCNt3c4meBxtYnaNF9HuoTQkghIhrstzeNFyxSxvYHZmoK8NNTY1KDTkMxSR7BZgMbNcxVgGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEyNQ2cn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299414; x=1777835414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hZjwXQ4U3Ogt5HXln+2a/BfG4CZuHW1U7jlyBw+QUNE=;
  b=aEyNQ2cnGxY95Sg8lj7LCxRW4wRPL5YTJ395J7bqDl67Qj/dHb0FMEfK
   pCiVP2fUimlNZjwu5+FsmhxMMQh6wbly4cMl/OS8NFJNR7xKtLKAeA8cH
   vKhbBl1ei7fOQ4QhI4F+cqwEP7yH5gjh2h/rIQSB8FjUpYq2tViWNC8+E
   Yn70JnJDTv3dPA9G8H2LlP8yeBBIfS9iaqku9JitL3tOi2+1zvH11A2E8
   mS+edcQw3kRMU3Ju2SjiDKZvj7D/quP2Nhtszy8C6lGUHP7kBCtuTmbBY
   b8H0yUND8zwg0Osj4ewBwrPEC/2XoXi3AXefKC3tuuiFmQLGLSOo5Y0rL
   A==;
X-CSE-ConnectionGUID: omT3abupRr2q0VYOAQDRKw==
X-CSE-MsgGUID: UxkOfDSMSDWf3RxV2i97iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095614"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095614"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:11 -0700
X-CSE-ConnectionGUID: wUy/Qb8YSg6h8CY66vUBTA==
X-CSE-MsgGUID: 7Ed1AHtyQDuXnRhaP2CW9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046088"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:11 -0700
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
Subject: [PATCH v3 03/13] x86/acpi: Move acpi_wakeup_cpu() and helpers to smpboot.c
Date: Sat,  3 May 2025 12:15:05 -0700
Message-Id: <20250503191515.24041-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The bootstrap processor uses acpi_wakeup_cpu() to indicate to firmware that
it wants to boot a secondary CPU using a mailbox as described in the
Multiprocessor Wakeup Structure of the ACPI specification.

The wakeup mailbox does not strictly require support from ACPI. The
platform firmware can implement a mailbox compatible in structure and
operation and enumerate it using other mechanisms such a DeviceTree graph.

Move the code used to setup and use the mailbox out of the ACPI
directory to use it when support for ACPI is not available or needed.

No functional changes are intended.

Originally-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 - Only move to smpboot.c the portions of the code that configure and
   use the mailbox. This also resolved the compile warnings about unused
   functions that Michael Kelley reported.
 - Edited the commit message for clarity.

Changes since v1:
 - None.
---
 arch/x86/kernel/acpi/madt_wakeup.c | 75 ----------------------------
 arch/x86/kernel/smpboot.c          | 78 ++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 75 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 6b9e41a24574..15627f63f9f5 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -2,7 +2,6 @@
 #include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
-#include <linux/io.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
 #include <linux/pgtable.h>
@@ -15,12 +14,6 @@
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
 
@@ -127,63 +120,6 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
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
@@ -246,14 +182,3 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	return 0;
 }
-
-void __init setup_mp_wakeup_mailbox(u64 mailbox_paddr)
-{
-	acpi_mp_wake_mailbox_paddr = mailbox_paddr;
-	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
-}
-
-struct acpi_madt_multiproc_wakeup_mailbox *get_mp_wakeup_mailbox(void)
-{
-	return acpi_mp_wake_mailbox;
-}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d6cf1e23c2a3..6f39ebe4d192 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -61,7 +61,9 @@
 #include <linux/cpuhotplug.h>
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
+#include <linux/io.h>
 
+#include <asm/barrier.h>
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpuid.h>
@@ -1354,3 +1356,79 @@ void native_play_dead(void)
 }
 
 #endif
+
+#ifdef CONFIG_X86_64
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
+void __init setup_mp_wakeup_mailbox(u64 mailbox_paddr)
+{
+	acpi_mp_wake_mailbox_paddr = mailbox_paddr;
+	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+}
+
+struct acpi_madt_multiproc_wakeup_mailbox *get_mp_wakeup_mailbox(void)
+{
+	return acpi_mp_wake_mailbox;
+}
+#endif
-- 
2.43.0


