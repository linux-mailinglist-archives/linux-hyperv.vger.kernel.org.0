Return-Path: <linux-hyperv+bounces-2422-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF69088FA
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 12:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049981F2841F
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB4198A25;
	Fri, 14 Jun 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJWt5qNv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD171195FE6;
	Fri, 14 Jun 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359165; cv=none; b=dSBvytEVYIuAhakS1F0YY10mKVPgSTL+4w9YpOHG7GfhVHjddU27r8o/3P8dlAg1WWzxsSUZf2ltyhMr7cKSCWmmeAww8XkbTxkv8GA2QVceVm5x6a9V0BINFHPt8Ea8lhN5/n+7lZLC0NY6NufWBNt4npclICxMwDzjRrq2Jp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359165; c=relaxed/simple;
	bh=ECdX67CT706dj0mlzCOMRqGiltd61ccVv16An5RaII4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3uAmv2jyzeTcQ63azGjMXGSd7BFm5+bZV60jgpgLb/BaM+XPZGpiJ8V6w6VNgZdMDyvpMQg+N9gdPVcr/AjkJco7qXUVwCjK5wQZZYzqCl+sLj8g5lPqmxYlEkwybIlxGOUKKWptKROYg/pmQmOwHtDx4w3KvOEDw8XEfIbN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJWt5qNv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359164; x=1749895164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ECdX67CT706dj0mlzCOMRqGiltd61ccVv16An5RaII4=;
  b=mJWt5qNvl7FDVUzcbeMrwWeHIhZaZIr/4CEY05VtCy84AqHANY9oSyMT
   5bayERdHCqYb0mZ2zmXbjHvvFDGUKPV0II3A+n4X8TVQty5OFfPccRBCw
   JNLsFdp32TVa6iaCU+xGyynOQgvTgC7JGYWphbVzo90V8U7vV1jFVuOhy
   u7LpA45oNte3ZyKyGgneP21TAiOnGQFCcDO5QUN10qu+7CgHw8Jw2jPU2
   lceZ/tp00mAsQyn174c9Auj8PtP+oQI1Qt5nZHX3xN0Sr/le+RnTe7R2f
   /H3VByVbrk8nQ5Rw93y1Tl2MEIZZ/Ma7kF/8ETgXLCuglif+R38RGRNd+
   g==;
X-CSE-ConnectionGUID: LClRbMp0SjOUkK2HOd9qiQ==
X-CSE-MsgGUID: CiVTX/oVSZKyUyTHwnxCDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15466687"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15466687"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:59:23 -0700
X-CSE-ConnectionGUID: puMiRCSZT32mQjsnE6YUJQ==
X-CSE-MsgGUID: DQWwLt08TtyIctJ4+UFzKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="77930011"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 14 Jun 2024 02:59:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D1FFA29E6; Fri, 14 Jun 2024 12:59:08 +0300 (EEST)
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
	Dave Hansen <dave.hansen@intel.com>,
	Tao Liu <ltao@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCHv12 07/19] x86/mm: Make x86_platform.guest.enc_status_change_*() return errno
Date: Fri, 14 Jun 2024 12:58:52 +0300
Message-ID: <20240614095904.1345461-8-kirill.shutemov@linux.intel.com>
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

TDX is going to have more than one reason to fail
enc_status_change_prepare().

Change the callback to return errno instead of assuming -EIO;
enc_status_change_finish() changed too to keep the interface symmetric.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/coco/tdx/tdx.c         | 20 +++++++++++---------
 arch/x86/hyperv/ivm.c           | 22 ++++++++++------------
 arch/x86/include/asm/x86_init.h |  4 ++--
 arch/x86/kernel/x86_init.c      |  4 ++--
 arch/x86/mm/mem_encrypt_amd.c   |  8 ++++----
 arch/x86/mm/pat/set_memory.c    | 12 +++++++-----
 6 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c1cb90369915..26fa47db5782 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -798,28 +798,30 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
-static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
-					  bool enc)
+static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
+					 bool enc)
 {
 	/*
 	 * Only handle shared->private conversion here.
 	 * See the comment in tdx_early_init().
 	 */
-	if (enc)
-		return tdx_enc_status_changed(vaddr, numpages, enc);
-	return true;
+	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc))
+		return -EIO;
+
+	return 0;
 }
 
-static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
+static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 					 bool enc)
 {
 	/*
 	 * Only handle private->shared conversion here.
 	 * See the comment in tdx_early_init().
 	 */
-	if (!enc)
-		return tdx_enc_status_changed(vaddr, numpages, enc);
-	return true;
+	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
+		return -EIO;
+
+	return 0;
 }
 
 void __init tdx_early_init(void)
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 768d73de0d09..b4a851d27c7c 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -523,9 +523,9 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
  * transition is complete, hv_vtom_set_host_visibility() marks the pages
  * as "present" again.
  */
-static bool hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc)
+static int hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc)
 {
-	return !set_memory_np(kbuffer, pagecount);
+	return set_memory_np(kbuffer, pagecount);
 }
 
 /*
@@ -536,20 +536,19 @@ static bool hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc
  * with host. This function works as wrap of hv_mark_gpa_visibility()
  * with memory base and size.
  */
-static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bool enc)
+static int hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bool enc)
 {
 	enum hv_mem_host_visibility visibility = enc ?
 			VMBUS_PAGE_NOT_VISIBLE : VMBUS_PAGE_VISIBLE_READ_WRITE;
 	u64 *pfn_array;
 	phys_addr_t paddr;
+	int i, pfn, err;
 	void *vaddr;
 	int ret = 0;
-	bool result = true;
-	int i, pfn;
 
 	pfn_array = kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!pfn_array) {
-		result = false;
+		ret = -ENOMEM;
 		goto err_set_memory_p;
 	}
 
@@ -568,10 +567,8 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
 			ret = hv_mark_gpa_visibility(pfn, pfn_array,
 						     visibility);
-			if (ret) {
-				result = false;
+			if (ret)
 				goto err_free_pfn_array;
-			}
 			pfn = 0;
 		}
 	}
@@ -586,10 +583,11 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 	 * order to avoid leaving the memory range in a "broken" state. Setting
 	 * the PRESENT bits shouldn't fail, but return an error if it does.
 	 */
-	if (set_memory_p(kbuffer, pagecount))
-		result = false;
+	err = set_memory_p(kbuffer, pagecount);
+	if (err && !ret)
+		ret = err;
 
-	return result;
+	return ret;
 }
 
 static bool hv_vtom_tlb_flush_required(bool private)
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 6149eabe200f..28ac3cb9b987 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -151,8 +151,8 @@ struct x86_init_acpi {
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
  */
 struct x86_guest {
-	bool (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
-	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
+	int (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
+	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
 };
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index d5dc5a92635a..a7143bb7dd93 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -134,8 +134,8 @@ struct x86_cpuinit_ops x86_cpuinit = {
 
 static void default_nmi_init(void) { };
 
-static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
-static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
+static int enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
+static int enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
 static bool is_private_mmio_noop(u64 addr) {return false; }
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 422602f6039b..e7b67519ddb5 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -283,7 +283,7 @@ static void enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
 #endif
 }
 
-static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
+static int amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
 {
 	/*
 	 * To maintain the security guarantees of SEV-SNP guests, make sure
@@ -292,11 +292,11 @@ static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool
 	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
 		snp_set_memory_shared(vaddr, npages);
 
-	return true;
+	return 0;
 }
 
 /* Return true unconditionally: return value doesn't matter for the SEV side */
-static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
+static int amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
 {
 	/*
 	 * After memory is mapped encrypted in the page table, validate it
@@ -308,7 +308,7 @@ static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool e
 	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
 
-	return true;
+	return 0;
 }
 
 static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 19fdfbb171ed..498812f067cd 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2196,7 +2196,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
-	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
+	ret = x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
+	if (ret)
 		goto vmm_fail;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
@@ -2214,16 +2215,17 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 		return ret;
 
 	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
-	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
+	ret = x86_platform.guest.enc_status_change_finish(addr, numpages, enc);
+	if (ret)
 		goto vmm_fail;
 
 	return 0;
 
 vmm_fail:
-	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=%p, numpages=%d) to %s.\n",
-		  (void *)addr, numpages, enc ? "private" : "shared");
+	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=%p, numpages=%d) to %s: %d\n",
+		  (void *)addr, numpages, enc ? "private" : "shared", ret);
 
-	return -EIO;
+	return ret;
 }
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
-- 
2.43.0


