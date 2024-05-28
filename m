Return-Path: <linux-hyperv+bounces-2230-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E5F8D17B4
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 11:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B91B23A87
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA8A16C854;
	Tue, 28 May 2024 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpcPVHk2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FD16ABDE;
	Tue, 28 May 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890144; cv=none; b=a+HnviDYS7no3HnVfALkkV8VN4k9WOkN/hqEECKqpBfvhRALMOh7GRH8+7GKpfCMPzqXZ8xhN3Gbu7g8new/xSwcjWKTqQIDMoWtZbKiALnQ1+4368Cr/gx0hLRNacWcqiPTyZjdCWEanVYmhLnIGmnrqYJGzDmkQsUm5K/dCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890144; c=relaxed/simple;
	bh=ZUiXcW7hC4PknzlHzEIxbEGjZYshXHBK0zojzFc4RxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlGDYKqtHN70Y4JixqZ5Po9ptkWSs6dbOsfOqB2u84JWksP+QW/gD0MUGNYpdWKQpr2Ai7sZPAu8jZ5L1I6cFHBG38YRWh2cs63QpIvWWJs2J0flmzpbM2HRR07GUk93HZOq7svQj2MaPkYXr++rt4a6qM4CHvuM57ofgIveaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpcPVHk2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716890143; x=1748426143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZUiXcW7hC4PknzlHzEIxbEGjZYshXHBK0zojzFc4RxY=;
  b=YpcPVHk2gFBIyVYp0XWpMKQ0k6+r/GXCrYNMSU3n3EAZcwSmeQ57T0AD
   eYE0MvyGOpjr2UN1Tmw3SY1f0kMJF1M1F4by1G23Sg4vbMShmHtOMEc9Z
   Iyd/Kt/ws03svI5FGchVuGi8uAmehPvfq6pwrvnnLnlIQ8TmzaoBNioWh
   xyvFIhr6PlzBvNgoSTMbmirnpmUOtqR+qD+txO6oSTf2oqpnMjmXbswU/
   Oi9UqGmDM5DsDM7pr6iWtkoNuSFvNT3fCptw9x9KBt53c0rbbaS0tBTQn
   eMBdSmpg2vvehJ/Gb+HHGaDp1qTDjUGggd8okOYPf+PkYGQylbv/imnun
   w==;
X-CSE-ConnectionGUID: GgOfFIHYRD6RMoZLATW7Ew==
X-CSE-MsgGUID: lp4bNqkeTieHBaKHc4cKpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13097756"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13097756"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:55:41 -0700
X-CSE-ConnectionGUID: 9xrhv8WrR22gC93PqHv50g==
X-CSE-MsgGUID: BEkOX6SDRsSnZMGuSwGRqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34951754"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 02:55:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C60D98B8; Tue, 28 May 2024 12:55:26 +0300 (EEST)
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
Subject: [PATCHv11 11/19] x86/tdx: Convert shared memory back to private on kexec
Date: Tue, 28 May 2024 12:55:14 +0300
Message-ID: <20240528095522.509667-12-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
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
 arch/x86/coco/tdx/tdx.c           | 69 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/pgtable.h    |  5 +++
 arch/x86/include/asm/set_memory.h |  3 ++
 arch/x86/mm/pat/set_memory.c      | 41 ++++++++++++++++--
 4 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 979891e97d83..c0a651fa8963 100644
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
@@ -831,6 +833,70 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return 0;
 }
 
+/* Stop new private<->shared conversions */
+static void tdx_kexec_begin(bool crash)
+{
+	/*
+	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!set_memory_enc_stop_conversion(!crash))
+		pr_warn("Failed to stop shared<->private conversions\n");
+}
+
+/* Walk direct mapping and convert all shared memory back to private */
+static void tdx_kexec_finish(void)
+{
+	unsigned long addr, end;
+	long found = 0, shared;
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
@@ -890,6 +956,9 @@ void __init tdx_early_init(void)
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
index 9aee31862b4a..d490db38db9e 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -49,8 +49,11 @@ int set_memory_wb(unsigned long addr, int numpages);
 int set_memory_np(unsigned long addr, int numpages);
 int set_memory_p(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
+
+bool set_memory_enc_stop_conversion(bool wait);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
+
 int set_memory_np_noalias(unsigned long addr, int numpages);
 int set_memory_nonglobal(unsigned long addr, int numpages);
 int set_memory_global(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index a7a7a6c6a3fb..2a548b65ef5f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2227,12 +2227,47 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
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
+ *
+ * If sleep is not allowed, as in a crash scenario, try to take the lock.
+ * Failure indicates that there is a race with the conversion.
+ */
+bool set_memory_enc_stop_conversion(bool wait)
+{
+	if (!wait)
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


