Return-Path: <linux-hyperv+bounces-1012-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 218ED7F382E
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 22:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7E3B21D5F
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ADB584C0;
	Tue, 21 Nov 2023 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhCTNzgj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEF0D54;
	Tue, 21 Nov 2023 13:20:39 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso53418935ad.3;
        Tue, 21 Nov 2023 13:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700601639; x=1701206439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GaTpmJEyBw9jgDXZhROPeIa70x6P8adbd0c2l8Nz7M=;
        b=GhCTNzgjp1E1H2GMZvf7NcUtCrVynDaxcwpfg0JDlFEYkf4baH+J9O5zNkkwr1oov0
         wOLF4Y3K/y9/ejW90v5O5iyb1vqo/Km+lVXQPUQAIlqRjL0pMUF1f1947WYqvyHp8jH5
         LVBdUUYT5dJuqvtEIXcMYe1lu+j6DljqP5Q3aCbqXJmEI+uOp2snAfYSi5LmaNYFaRbR
         cwuTo/QPC03hv8WGEQtvLv1oa93UYRt5BICFTSkOJIFIUXuOIYZcS4mMHiPsr+G4LTOu
         oS5AM1i922gL1yuGPYUO8GJLkBJ0mD05MkO7j+IYy242jAIMrplrHyXTUIV3WH5gQBPx
         CXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700601639; x=1701206439;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7GaTpmJEyBw9jgDXZhROPeIa70x6P8adbd0c2l8Nz7M=;
        b=Z+z53Qxz3Z/+Q8TManmtlwpLnGH1H59FWfdaAt2Ayrt9zJN4wq+MznAw7WwunezOqe
         Y4dzFJfXrb2TNEIeQir5D96L0kS6r6eUmp60GsXyo/qa6qol2SeDEUfHU83uFLCklvY/
         FIsE3kAqGPIrU/Xw4FxHxvVcrWZK8BjrdUGjmLRnfZKWd4pLqJ90YPshsdawiwzzv3nF
         stznalxhGiHSO7DBC6PizLVy4HAVVhBcsY2Dnl//YVmzyAJ1l2q5i3EonjgLT0tC3EkG
         Cg9Z1iFixCMCgUnqYrSKYLzxHkFGHYsp8Qz6KWDMhxjJPtjHdj1mpomSK7MPL3AYdCf+
         Hvqw==
X-Gm-Message-State: AOJu0YyCh6s8azmW8uRcRkWuKZvBqJF2RjTga9fZt4qfUgHl+bIEOPR0
	ploy9uNj2Rj7YGxrhihJoHo=
X-Google-Smtp-Source: AGHT+IF20yx0OHR4w+dYeGZB9G5yHsyZo0dLpfvxQzVoTuUqgi8K6gHCFS0wku5f4MEmMYr1ReDSPw==
X-Received: by 2002:a17:903:2448:b0:1ce:6589:d1c0 with SMTP id l8-20020a170903244800b001ce6589d1c0mr372895pls.46.1700601639270;
        Tue, 21 Nov 2023 13:20:39 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001bf52834696sm8281924pll.207.2023.11.21.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:20:39 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	luto@kernel.org,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	lstoakes@gmail.com,
	thomas.lendacky@amd.com,
	ardb@kernel.org,
	jroedel@suse.de,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 5/8] x86/mm: Mark CoCo VM pages not present while changing encrypted state
Date: Tue, 21 Nov 2023 13:20:13 -0800
Message-Id: <20231121212016.1154303-6-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121212016.1154303-1-mhklinux@outlook.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

In a CoCo VM when a page transitions from encrypted to decrypted, or vice
versa, attributes in the PTE must be updated *and* the hypervisor must
be notified of the change. Because there are two separate steps, there's
a window where the settings are inconsistent.  Normally the code that
initiates the transition (via set_memory_decrypted() or
set_memory_encrypted()) ensures that the memory is not being accessed
during a transition, so the window of inconsistency is not a problem.
However, the load_unaligned_zeropad() function can read arbitrary memory
pages at arbitrary times, which could access a transitioning page during
the window.  In such a case, CoCo VM specific exceptions are taken
(depending on the CoCo architecture in use).  Current code in those
exception handlers recovers and does "fixup" on the result returned by
load_unaligned_zeropad().  Unfortunately, this exception handling can't
work in paravisor scenarios (TDX Paritioning and SEV-SNP in vTOM mode)
if the exceptions are routed to the paravisor.  The paravisor
can't do the load_unaligned_zeropad() fixup, so the exceptions would
need to be forwarded from the paravisor to the Linux guest, but there
are no architectural specs for how to do that.

Fortunately, there's a simpler way to solve the problem by changing
the core transition code in __set_memory_enc_pgtable() to do the
following:

1.  Remove aliasing mappings
2.  Flush the data cache if needed
3.  Remove the PRESENT bit from the PTEs of all transitioning pages
4.  Notify the hypervisor of the impending encryption status change
5.  Set/clear the encryption attribute as appropriate
6.  Flush the TLB so the changed encryption attribute isn't visible
7.  Notify the hypervisor after the encryption status change
8.  Add back the PRESENT bit, making the changed attribute visible

With this approach, load_unaligned_zeropad() just takes its normal
page-fault-based fixup path if it touches a page that is transitioning.
As a result, load_unaligned_zeropad() and CoCo VM page transitioning
are completely decoupled.  CoCo VM page transitions can proceed
without needing to handle architecture-specific exceptions and fix
things up. This decoupling reduces the complexity due to separate
TDX and SEV-SNP fixup paths, and gives more freedom to revise and
introduce new capabilities in future versions of the TDX and SEV-SNP
architectures. Paravisor scenarios work properly without needing
to forward exceptions.

Because Step 3 always does a TLB flush, the separate TLB flush
callback is no longer required and is removed.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/coco/tdx/tdx.c         | 20 --------------
 arch/x86/hyperv/ivm.c           |  6 -----
 arch/x86/include/asm/x86_init.h |  2 --
 arch/x86/kernel/x86_init.c      |  2 --
 arch/x86/mm/mem_encrypt_amd.c   |  6 -----
 arch/x86/mm/pat/set_memory.c    | 48 ++++++++++++++++++++++++---------
 6 files changed, 35 insertions(+), 49 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1b5d17a9f70d..39ead21bcba6 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -697,24 +697,6 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 	return true;
 }
 
-static bool tdx_tlb_flush_required(bool private)
-{
-	/*
-	 * TDX guest is responsible for flushing TLB on private->shared
-	 * transition. VMM is responsible for flushing on shared->private.
-	 *
-	 * The VMM _can't_ flush private addresses as it can't generate PAs
-	 * with the guest's HKID.  Shared memory isn't subject to integrity
-	 * checking, i.e. the VMM doesn't need to flush for its own protection.
-	 *
-	 * There's no need to flush when converting from shared to private,
-	 * as flushing is the VMM's responsibility in this case, e.g. it must
-	 * flush to avoid integrity failures in the face of a buggy or
-	 * malicious guest.
-	 */
-	return !private;
-}
-
 static bool tdx_cache_flush_required(void)
 {
 	/*
@@ -876,9 +858,7 @@ void __init tdx_early_init(void)
 	 */
 	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
 	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
-
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
-	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 8ba18635e338..4005c573e00c 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -550,11 +550,6 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 	return result;
 }
 
-static bool hv_vtom_tlb_flush_required(bool private)
-{
-	return true;
-}
-
 static bool hv_vtom_cache_flush_required(void)
 {
 	return false;
@@ -614,7 +609,6 @@ void __init hv_vtom_init(void)
 
 	x86_platform.hyper.is_private_mmio = hv_is_private_mmio;
 	x86_platform.guest.enc_cache_flush_required = hv_vtom_cache_flush_required;
-	x86_platform.guest.enc_tlb_flush_required = hv_vtom_tlb_flush_required;
 	x86_platform.guest.enc_status_change_finish = hv_vtom_set_host_visibility;
 
 	/* Set WB as the default cache mode. */
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c878616a18b8..5b3a9a214815 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -146,13 +146,11 @@ struct x86_init_acpi {
  *
  * @enc_status_change_prepare	Notify HV before the encryption status of a range is changed
  * @enc_status_change_finish	Notify HV after the encryption status of a range is changed
- * @enc_tlb_flush_required	Returns true if a TLB flush is needed before changing page encryption status
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
  */
 struct x86_guest {
 	bool (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
-	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
 };
 
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a37ebd3b4773..1c0d23a2b6cf 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -133,7 +133,6 @@ static void default_nmi_init(void) { };
 
 static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
 static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
-static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
@@ -156,7 +155,6 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 	.guest = {
 		.enc_status_change_prepare = enc_status_change_prepare_noop,
 		.enc_status_change_finish  = enc_status_change_finish_noop,
-		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
 		.enc_cache_flush_required  = enc_cache_flush_required_noop,
 	},
 };
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index a68f2dda0948..652cc61b89b6 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -242,11 +242,6 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 	return pfn;
 }
 
-static bool amd_enc_tlb_flush_required(bool enc)
-{
-	return true;
-}
-
 static bool amd_enc_cache_flush_required(void)
 {
 	return !cpu_feature_enabled(X86_FEATURE_SME_COHERENT);
@@ -464,7 +459,6 @@ void __init sme_early_init(void)
 
 	x86_platform.guest.enc_status_change_prepare = amd_enc_status_change_prepare;
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
-	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
 
 	/*
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d7ef8d312a47..b125035608d5 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2019,6 +2019,11 @@ int set_memory_wb(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_wb);
 
+static int set_memory_p(unsigned long *addr, int numpages)
+{
+	return change_page_attr_set(addr, numpages, __pgprot(_PAGE_PRESENT), 0);
+}
+
 /* Prevent speculative access to a page by marking it not-present */
 #ifdef CONFIG_X86_64
 int set_mce_nospec(unsigned long pfn)
@@ -2049,11 +2054,6 @@ int set_mce_nospec(unsigned long pfn)
 	return rc;
 }
 
-static int set_memory_p(unsigned long *addr, int numpages)
-{
-	return change_page_attr_set(addr, numpages, __pgprot(_PAGE_PRESENT), 0);
-}
-
 /* Restore full speculative operation to the pfn. */
 int clear_mce_nospec(unsigned long pfn)
 {
@@ -2144,6 +2144,23 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
 		addr &= PAGE_MASK;
 
+	/*
+	 * The caller must ensure that the memory being transitioned between
+	 * encrypted and decrypted is not being accessed.  But if
+	 * load_unaligned_zeropad() touches the "next" page, it may generate a
+	 * read access the caller has no control over. To ensure such accesses
+	 * cause a normal page fault for the load_unaligned_zeropad() handler,
+	 * mark the pages not present until the transition is complete.  We
+	 * don't want a #VE or #VC fault due to a mismatch in the memory
+	 * encryption status, since paravisor configurations can't cleanly do
+	 * the load_unaligned_zeropad() handling in the paravisor.
+	 *
+	 * set_memory_np() flushes the TLB.
+	 */
+	ret = set_memory_np(addr, numpages);
+	if (ret)
+		return ret;
+
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
@@ -2156,14 +2173,16 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	vm_unmap_aliases();
 
 	/* Flush the caches as needed before changing the encryption attribute. */
-	if (x86_platform.guest.enc_tlb_flush_required(enc))
-		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
+	if (x86_platform.guest.enc_cache_flush_required())
+		cpa_flush(&cpa, 1);
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
 	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
 		return -EIO;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
+	if (ret)
+		return ret;
 
 	/*
 	 * After changing the encryption attribute, we need to flush TLBs again
@@ -2174,13 +2193,16 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, 0);
 
-	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
-	if (!ret) {
-		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
-			ret = -EIO;
-	}
+	/* Notify hypervisor that we have successfully set/clr encryption attr. */
+	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
+		return -EIO;
 
-	return ret;
+	/*
+	 * Now that the hypervisor is sync'ed with the page table changes
+	 * made here, add back _PAGE_PRESENT. set_memory_p() does not flush
+	 * the TLB.
+	 */
+	return set_memory_p(&addr, numpages);
 }
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
-- 
2.25.1


