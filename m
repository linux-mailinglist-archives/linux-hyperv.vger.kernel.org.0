Return-Path: <linux-hyperv+bounces-2418-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65B09088ED
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 12:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35291C257F3
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FD8194C9C;
	Fri, 14 Jun 2024 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDJKk0Lc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57819306F;
	Fri, 14 Jun 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359160; cv=none; b=GnUuTJXCe6Vdn7LrdmdjqQnU7TJlpKTixR5icKcJCyAvm16gOtfdH/FfaTUnZqGIf/w6qlQZWLoFajMH80W4V8hatQiklI3v01mn42eMHHpp7oBtKM29XL7wlFNzucBsXv5uDFS1BMmLgZN9nP480OGLsBC7zK5/qgtUJt0mfcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359160; c=relaxed/simple;
	bh=DqFK3hyuZlJ5+kDcyQ2OetQDdz/iqM4ad903QnelwbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APH83JBjRxpirrqg134kH6I5oBcG7QxXUtUFWOzjVI8SwZ70e2QRBaarpAhAAMp2WdwqsDQMKVP6N30GChFRJHMtnrTS6TYMtaOf5V/GPQDgxTdi79ulL3FTJpnWfPr+PIFAr39HlJJpQtZdKh1J7/ok3VgDHs+KVCk05iC8Mg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDJKk0Lc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359158; x=1749895158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqFK3hyuZlJ5+kDcyQ2OetQDdz/iqM4ad903QnelwbI=;
  b=nDJKk0LcBMNLIJb/bf3ieAyS1SmcKLy2T0Gz2tzUiljwZkyAdGHlvxMu
   5IqFndamuTY+TGo0NiMPSqMFulOzoxfiA16Ctqn0xTlxNLEQfeusHeO+v
   UlD32Y1rbCnXWBQAy03zj7ezG6V2Au1CEWOFHp1JGmj7CYJdcgkkHVW0F
   gvk4/ZvDiXtBp/wgT4FqOuZIZAH7wDYCRwQokYOCBxVF6spIVbMvM7xAu
   yBaak5gLNwpDBEKsIlCvtz5Pu5QRF4pAP43xTH2Nf6DH4PbhEsyReJs7e
   pV8/tmx4tyFY/TmVBwZN+5eRgU/UVheRA+ws3Obv1PuGduObvWf7ppUGD
   g==;
X-CSE-ConnectionGUID: oDid1gBlT6umKDtlXp5HLQ==
X-CSE-MsgGUID: Ar0HmfygQ+KTn0Q+RKql4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15466667"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15466667"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:59:16 -0700
X-CSE-ConnectionGUID: +VG5y63SRROBrG8n3Xy2GQ==
X-CSE-MsgGUID: R2u/EAgWRCecka8r0mGh/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="77929997"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 14 Jun 2024 02:59:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7A32811EC; Fri, 14 Jun 2024 12:59:08 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Tao Liu <ltao@redhat.com>
Subject: [PATCHv12 01/19] x86/acpi: Extract ACPI MADT wakeup code into a separate file
Date: Fri, 14 Jun 2024 12:58:46 +0300
Message-ID: <20240614095904.1345461-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to prepare for the expansion of support for the ACPI MADT
wakeup method, move the relevant code into a separate file.

Introduce a new configuration option to clearly indicate dependencies
without the use of ifdefs.

There have been no functional changes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/Kconfig                   |  7 +++
 arch/x86/include/asm/acpi.h        |  5 ++
 arch/x86/kernel/acpi/Makefile      |  1 +
 arch/x86/kernel/acpi/boot.c        | 86 +-----------------------------
 arch/x86/kernel/acpi/madt_wakeup.c | 82 ++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+), 85 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e8837116704c..e30ea4129d2c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1118,6 +1118,13 @@ config X86_LOCAL_APIC
 	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
 	select IRQ_DOMAIN_HIERARCHY
 
+config ACPI_MADT_WAKEUP
+	def_bool y
+	depends on X86_64
+	depends on ACPI
+	depends on SMP
+	depends on X86_LOCAL_APIC
+
 config X86_IO_APIC
 	def_bool y
 	depends on X86_LOCAL_APIC || X86_UP_IOAPIC
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 5af926c050f0..ceacac2b335d 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -78,6 +78,11 @@ static inline bool acpi_skip_set_wakeup_address(void)
 
 #define acpi_skip_set_wakeup_address acpi_skip_set_wakeup_address
 
+union acpi_subtable_headers;
+
+int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
+			      const unsigned long end);
+
 /*
  * Check if the CPU can handle C2 and deeper
  */
diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
index fc17b3f136fe..2feba7257665 100644
--- a/arch/x86/kernel/acpi/Makefile
+++ b/arch/x86/kernel/acpi/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ACPI)		+= boot.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_$(BITS).o
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc.o
+obj-$(CONFIG_ACPI_MADT_WAKEUP)	+= madt_wakeup.o
 
 ifneq ($(CONFIG_ACPI_PROCESSOR),)
 obj-y				+= cstate.o
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4bf82dbd2a6b..9f4618dcd704 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -67,13 +67,6 @@ static bool has_lapic_cpus __initdata;
 static bool acpi_support_online_capable;
 #endif
 
-#ifdef CONFIG_X86_64
-/* Physical address of the Multiprocessor Wakeup Structure mailbox */
-static u64 acpi_mp_wake_mailbox_paddr;
-/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
-static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
-#endif
-
 #ifdef CONFIG_X86_IO_APIC
 /*
  * Locks related to IOAPIC hotplug
@@ -341,60 +334,6 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
 
 	return 0;
 }
-
-#ifdef CONFIG_X86_64
-static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
-{
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
-	 * has to wait for a wake up acknowledgement. It also doesn't provide
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
-#endif /* CONFIG_X86_64 */
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
@@ -1124,29 +1063,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	}
 	return 0;
 }
-
-#ifdef CONFIG_X86_64
-static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
-				     const unsigned long end)
-{
-	struct acpi_madt_multiproc_wakeup *mp_wake;
-
-	if (!IS_ENABLED(CONFIG_SMP))
-		return -ENODEV;
-
-	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
-	if (BAD_MADT_ENTRY(mp_wake, end))
-		return -EINVAL;
-
-	acpi_table_print_madt_entry(&header->common);
-
-	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
-
-	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
-
-	return 0;
-}
-#endif				/* CONFIG_X86_64 */
 #endif				/* CONFIG_X86_LOCAL_APIC */
 
 #ifdef	CONFIG_X86_IO_APIC
@@ -1343,7 +1259,7 @@ static void __init acpi_process_madt(void)
 				smp_found_config = 1;
 			}
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_ACPI_MADT_WAKEUP
 			/*
 			 * Parse MADT MP Wake entry.
 			 */
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
new file mode 100644
index 000000000000..7f164d38bd0b
--- /dev/null
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include <asm/apic.h>
+#include <asm/barrier.h>
+#include <asm/processor.h>
+
+/* Physical address of the Multiprocessor Wakeup Structure mailbox */
+static u64 acpi_mp_wake_mailbox_paddr;
+
+/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+
+static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
+{
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
+int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
+			      const unsigned long end)
+{
+	struct acpi_madt_multiproc_wakeup *mp_wake;
+
+	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
+	if (BAD_MADT_ENTRY(mp_wake, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(&header->common);
+
+	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
+
+	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+
+	return 0;
+}
-- 
2.43.0


