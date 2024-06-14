Return-Path: <linux-hyperv+bounces-2423-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E599088FD
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 12:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC6A1C25C52
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5891991C3;
	Fri, 14 Jun 2024 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPLOfMrf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DED19645D;
	Fri, 14 Jun 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359166; cv=none; b=KMzHNUtivi3WnY7fo+ZUqxWjK3rHTOGm//NDWMnMnewTytH2tucAhL648QwypboW144D7IeItcvijhaLcGUmdJ1alAmuN54laLwXNvTZ4JKP3KGv+VUR2t+l1msNWO4jB1FslWQPQnZaZyGzOGcxrj4s/KpvAkStaiqCDJu1DSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359166; c=relaxed/simple;
	bh=qJsvWrpCuJ9uSiqZE99p8Rix7rLiZtwS71nVuH6DLkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfZtY6knVJ47GMsZ6vMF+d5iLnt1Apf9xymYwhTWLfk9qQAyQpV/Qks9ijqT3WzhpkJYnBht0IpwVR71zOBeWg66S0SD2WA7yAtkStAM9S/vPjw34U/YHYYPHoQsnvyu1VeJPqHIrMUAH316sEszMAOBYcSNUr0epwSgvR9wNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPLOfMrf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359165; x=1749895165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qJsvWrpCuJ9uSiqZE99p8Rix7rLiZtwS71nVuH6DLkM=;
  b=DPLOfMrfqyMOH3YKyqXkGqdI7FHWU1ZkJRrgcXVFA+VP9POD/5AJrPFr
   KsfFfY8N8mowigvdh4SkNjYcDaAXxDd0eVzBb76YdNLzauGxPGaHUTXHR
   bprk7fIUOWcIbMx5NgCewntgnqRZC8c5pDkh0rwFpkupfuEIAe6tvYG50
   Q7r++Hpc7gAq8cQ4M605vbYsIHypPDV9WXTpVh81zD9PZDBEAEN0wMovs
   5+BTXG4jJJIIQmySuXFUnwh67Z69E482OtpyruWx6NFra5pVUxssY522D
   4aHJ0gJYy+0auoaUVruzJJz3GlO+OBYqa4/6Ty73vUPs/OmLAtEStuCTU
   w==;
X-CSE-ConnectionGUID: ccDq68xMR3i+WMxvBp5i2w==
X-CSE-MsgGUID: zEwLRDhFSnuXCMfjOjoF0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="12072395"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="12072395"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:59:23 -0700
X-CSE-ConnectionGUID: Yjp77JZ5Qr2OaZCq3O8cFQ==
X-CSE-MsgGUID: lissGvhmTxicGn76+wsQ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44995854"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jun 2024 02:59:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 05AF02A7B; Fri, 14 Jun 2024 12:59:08 +0300 (EEST)
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
	Nikolay Borisov <nik.borisov@suse.com>,
	Tao Liu <ltao@redhat.com>
Subject: [PATCHv12 10/19] x86/mm: Add callbacks to prepare encrypted memory for kexec
Date: Fri, 14 Jun 2024 12:58:55 +0300
Message-ID: <20240614095904.1345461-11-kirill.shutemov@linux.intel.com>
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

AMD SEV and Intel TDX guests allocate shared buffers for performing I/O.
This is done by allocating pages normally from the buddy allocator and
then converting them to shared using set_memory_decrypted().

On kexec, the second kernel is unaware of which memory has been
converted in this manner. It only sees E820_TYPE_RAM. Accessing shared
memory as private is fatal.

Therefore, the memory state must be reset to its original state before
starting the new kernel with kexec.

The process of converting shared memory back to private occurs in two
steps:

- enc_kexec_begin() stops new conversions.

- enc_kexec_finish() unshares all existing shared memory, reverting it
  back to private.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/x86_init.h | 10 ++++++++++
 arch/x86/kernel/crash.c         | 12 ++++++++++++
 arch/x86/kernel/reboot.c        | 12 ++++++++++++
 arch/x86/kernel/x86_init.c      |  4 ++++
 4 files changed, 38 insertions(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 28ac3cb9b987..213cf5379a5a 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -149,12 +149,22 @@ struct x86_init_acpi {
  * @enc_status_change_finish	Notify HV after the encryption status of a range is changed
  * @enc_tlb_flush_required	Returns true if a TLB flush is needed before changing page encryption status
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
+ * @enc_kexec_begin		Begin the two-step process of converting shared memory back
+ *				to private. It stops the new conversions from being started
+ *				and waits in-flight conversions to finish, if possible.
+ * @enc_kexec_finish		Finish the two-step process of converting shared memory to
+ *				private. All memory is private after the call when
+ *				the function returns.
+ *				It is called on only one CPU while the others are shut down
+ *				and with interrupts disabled.
  */
 struct x86_guest {
 	int (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
 	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
+	void (*enc_kexec_begin)(void);
+	void (*enc_kexec_finish)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f06501445cd9..340af8155658 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -128,6 +128,18 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
+
+	/*
+	 * Non-crash kexec calls enc_kexec_begin() while scheduling is still
+	 * active. This allows the callback to wait until all in-flight
+	 * shared<->private conversions are complete. In a crash scenario,
+	 * enc_kexec_begin() gets called after all but one CPU have been shut
+	 * down and interrupts have been disabled. This allows the callback to
+	 * detect a race with the conversion and report it.
+	 */
+	x86_platform.guest.enc_kexec_begin();
+	x86_platform.guest.enc_kexec_finish();
+
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index f3130f762784..bb7a44af7efd 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
+#include <linux/kexec.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -716,6 +717,14 @@ static void native_machine_emergency_restart(void)
 
 void native_machine_shutdown(void)
 {
+	/*
+	 * Call enc_kexec_begin() while all CPUs are still active and
+	 * interrupts are enabled. This will allow all in-flight memory
+	 * conversions to finish cleanly.
+	 */
+	if (kexec_in_progress)
+		x86_platform.guest.enc_kexec_begin();
+
 	/* Stop the cpus and apics */
 #ifdef CONFIG_X86_IO_APIC
 	/*
@@ -752,6 +761,9 @@ void native_machine_shutdown(void)
 #ifdef CONFIG_X86_64
 	x86_platform.iommu_shutdown();
 #endif
+
+	if (kexec_in_progress)
+		x86_platform.guest.enc_kexec_finish();
 }
 
 static void __machine_emergency_restart(int emergency)
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a7143bb7dd93..82b128d3f309 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -138,6 +138,8 @@ static int enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool
 static int enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
+static void enc_kexec_begin_noop(void) {}
+static void enc_kexec_finish_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
@@ -161,6 +163,8 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 		.enc_status_change_finish  = enc_status_change_finish_noop,
 		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
 		.enc_cache_flush_required  = enc_cache_flush_required_noop,
+		.enc_kexec_begin	   = enc_kexec_begin_noop,
+		.enc_kexec_finish	   = enc_kexec_finish_noop,
 	},
 };
 
-- 
2.43.0


