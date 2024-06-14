Return-Path: <linux-hyperv+bounces-2427-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D390890D
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 12:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15863B2089F
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 10:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5AA19AD71;
	Fri, 14 Jun 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBUsq7IU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311F1991C9;
	Fri, 14 Jun 2024 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359168; cv=none; b=anZP/b2sDQtaC3uasFLFZhedZrRFAwzN3hi8Uy1UK0/QLAw3TReEEO+pVEezE4WKg/SmSyzIDVfrz65QVIkCjUSH2g5S/+Zrjvtb6JaJtT08auX9Fkp6imDJmL2JX8dOhr5hijdBgEpi8hhKCTdsfDl80dzevteLiFdLrJKJpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359168; c=relaxed/simple;
	bh=8oUo3AHOPVWP0yU5bkr/khntypl8fcyNHpiWhFTzrxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAbHY2zerKFmzla3gax30OmfhYPovQw2QJWgStRelOx+bqy+hW5n9u0vjt46qnFXCkHrH163HOoW9pSCSwJZp5ge+ZIIcn4hHosz0uH+wmIKqUAHwlzarp8VaSeh5fv/Sr6n/m4iisQ/J4nZmy1tCS3dh8wirHaoug9n/I0MsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBUsq7IU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359167; x=1749895167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8oUo3AHOPVWP0yU5bkr/khntypl8fcyNHpiWhFTzrxM=;
  b=dBUsq7IUJvThh12R2Dfr1CyTE0+SYosft7S2/KztpNqa7CStFThps8ti
   WoGFZbRMdL72MBMtwfAaTHjPSoRh5+5p1sB2euT3R943kYzVJpu2MyGxw
   ykC7E/Ks6oZAZG/06xh83oRHfcfoHaMqCWHt7h2FxeEZKr5dz8Be0PJZX
   GXChuFH/NiX5ZUMiXmd1+TdiqHbDdbjzZfDXIAG05eNcNAoMikh0swrl1
   nzjl85jt1zaeuwEsrUj3In1p8x0ccxeMaEyw0mv05hLpt/OMBIItRuU2g
   fSuff+/omembAqb32gFDkw9oCon5GGBdBrC6Pi8Pf6l2XX51dyMw1SoGY
   w==;
X-CSE-ConnectionGUID: 5dm+aeuoTB67mW+f0bFDIQ==
X-CSE-MsgGUID: QlNxbRalSK6eCDbTmyevHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="12072413"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="12072413"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:59:23 -0700
X-CSE-ConnectionGUID: 2Dv0h5crS2SCvOXbhTbfqg==
X-CSE-MsgGUID: RQ2MZZXZRgyJxhuHgeaElw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44995857"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jun 2024 02:59:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 130AB2AF1; Fri, 14 Jun 2024 12:59:09 +0300 (EEST)
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
	Tao Liu <ltao@redhat.com>
Subject: [PATCHv12 11/19] x86/tdx: Convert shared memory back to private on kexec
Date: Fri, 14 Jun 2024 12:58:56 +0300
Message-ID: <20240614095904.1345461-12-kirill.shutemov@linux.intel.com>
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

TDX guests allocate shared buffers to perform I/O. It is done by
allocating pages normally from the buddy allocator and converting them
to shared with set_memory_decrypted().

The second, kexec-ed kernel has no idea what memory is converted this
way. It only sees E820_TYPE_RAM.

Accessing shared memory via private mapping is fatal. It leads to
unrecoverable TD exit.

On kexec walk direct mapping and convert all shared memory back to
private. It makes all RAM private again and second kernel may use it
normally.

The conversion occurs in two steps: stopping new conversions and
unsharing all memory. In the case of normal kexec, the stopping of
conversions takes place while scheduling is still functioning. This
allows for waiting until any ongoing conversions are finished. The
second step is carried out when all CPUs except one are inactive and
interrupts are disabled. This prevents any conflicts with code that may
access shared memory.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/coco/tdx/tdx.c           | 94 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/pgtable.h    |  5 ++
 arch/x86/include/asm/set_memory.h |  3 +
 arch/x86/mm/pat/set_memory.c      | 42 +++++++++++++-
 4 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 979891e97d83..078e2bac2553 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/kexec.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -14,6 +15,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/set_memory.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -831,6 +833,95 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return 0;
 }
 
+/* Stop new private<->shared conversions */
+static void tdx_kexec_begin(void)
+{
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	/*
+	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!set_memory_enc_stop_conversion())
+		pr_warn("Failed to stop shared<->private conversions\n");
+}
+
+/* Walk direct mapping and convert all shared memory back to private */
+static void tdx_kexec_finish(void)
+{
+	unsigned long addr, end;
+	long found = 0, shared;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	lockdep_assert_irqs_disabled();
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		if (pte && pte_decrypted(*pte)) {
+			int pages = size / PAGE_SIZE;
+
+			/*
+			 * Touching memory with shared bit set triggers implicit
+			 * conversion to shared.
+			 *
+			 * Make sure nobody touches the shared range from
+			 * now on.
+			 */
+			set_pte(pte, __pte(0));
+
+			/*
+			 * Memory encryption state persists across kexec.
+			 * If tdx_enc_status_changed() fails in the first
+			 * kernel, it leaves memory in an unknown state.
+			 *
+			 * If that memory remains shared, accessing it in the
+			 * *next* kernel through a private mapping will result
+			 * in an unrecoverable guest shutdown.
+			 *
+			 * The kdump kernel boot is not impacted as it uses
+			 * a pre-reserved memory range that is always private.
+			 * However, gathering crash information could lead to
+			 * a crash if it accesses unconverted memory through
+			 * a private mapping which is possible when accessing
+			 * that memory through /proc/vmcore, for example.
+			 *
+			 * In all cases, print error info in order to leave
+			 * enough bread crumbs for debugging.
+			 */
+			if (!tdx_enc_status_changed(addr, pages, true)) {
+				pr_err("Failed to unshare range %#lx-%#lx\n",
+				       addr, addr + size);
+			}
+
+			found += pages;
+		}
+
+		addr += size;
+	}
+
+	__flush_tlb_all();
+
+	shared = atomic_long_read(&nr_shared);
+	if (shared != found) {
+		pr_err("shared page accounting is off\n");
+		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
+	}
+}
+
 void __init tdx_early_init(void)
 {
 	struct tdx_module_args args = {
@@ -890,6 +981,9 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
+	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
+	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 65b8e5bb902c..e39311a89bf4 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -140,6 +140,11 @@ static inline int pte_young(pte_t pte)
 	return pte_flags(pte) & _PAGE_ACCESSED;
 }
 
+static inline bool pte_decrypted(pte_t pte)
+{
+	return cc_mkdec(pte_val(pte)) == pte_val(pte);
+}
+
 #define pmd_dirty pmd_dirty
 static inline bool pmd_dirty(pmd_t pmd)
 {
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 9aee31862b4a..4b2abce2e3e7 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -49,8 +49,11 @@ int set_memory_wb(unsigned long addr, int numpages);
 int set_memory_np(unsigned long addr, int numpages);
 int set_memory_p(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
+
+bool set_memory_enc_stop_conversion(void);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
+
 int set_memory_np_noalias(unsigned long addr, int numpages);
 int set_memory_nonglobal(unsigned long addr, int numpages);
 int set_memory_global(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index a7a7a6c6a3fb..443a97e515c0 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2227,12 +2227,48 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	return ret;
 }
 
+/*
+ * The lock serializes conversions between private and shared memory.
+ *
+ * It is taken for read on conversion. A write lock guarantees that no
+ * concurrent conversions are in progress.
+ */
+static DECLARE_RWSEM(mem_enc_lock);
+
+/*
+ * Stop new private<->shared conversions.
+ *
+ * Taking the exclusive mem_enc_lock waits for in-flight conversions to complete.
+ * The lock is not released to prevent new conversions from being started.
+ */
+bool set_memory_enc_stop_conversion(void)
+{
+	/*
+	 * In a crash scenario, sleep is not allowed. Try to take the lock.
+	 * Failure indicates that there is a race with the conversion.
+	 */
+	if (oops_in_progress)
+		return down_write_trylock(&mem_enc_lock);
+
+	down_write(&mem_enc_lock);
+
+	return true;
+}
+
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		return __set_memory_enc_pgtable(addr, numpages, enc);
+	int ret = 0;
 
-	return 0;
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+		if (!down_read_trylock(&mem_enc_lock))
+			return -EBUSY;
+
+		ret = __set_memory_enc_pgtable(addr, numpages, enc);
+
+		up_read(&mem_enc_lock);
+	}
+
+	return ret;
 }
 
 int set_memory_encrypted(unsigned long addr, int numpages)
-- 
2.43.0


