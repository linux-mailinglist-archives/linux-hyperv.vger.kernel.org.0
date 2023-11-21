Return-Path: <linux-hyperv+bounces-1014-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA097F382A
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 22:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF131C20D90
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CC5584C9;
	Tue, 21 Nov 2023 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjGBXwoR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE2D67;
	Tue, 21 Nov 2023 13:20:41 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf63ca9b1bso19017105ad.3;
        Tue, 21 Nov 2023 13:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700601641; x=1701206441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYzSG2iLW5ukNXtkNm2hP56hOS32ndgpWoY3EW0G0CY=;
        b=CjGBXwoR3OtRBGpkkjJacdYSq6QWbX7cFhSJPSQlRuBrdNn556BTKihy/X1C1/bGXH
         ASqGCZFZlviPJxlCITNe511fFhBh7UGzb2A9SLm1Ho9mdtWjZufLiJJv/2A576VA1RZt
         wYV3i6qMAQMErkgwggxYPjFcxTE+AyaeNpn9UoFp4pKSTl7pCg355CVFcPHsedsnqJvM
         N7nvFGySeVHweLmh/4MsyuFtp2MrTJPSTM81ZN7PMnKnGDe+nKsMChiqrKGdQ5YIOGH5
         izx5wwKOSx/7xm3tAzU10vHsIAMBhueA0fHrbvR2ZWVCDRCugNkN2LvnkxDPwwsVXNRR
         T5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700601641; x=1701206441;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYzSG2iLW5ukNXtkNm2hP56hOS32ndgpWoY3EW0G0CY=;
        b=Nlf+GW13ph+UOFLE3lZVZZA3XrMpNniVtCLH/ZXLtbMit3y2+rRi29/1++08LszuFY
         SNQEi7FkCHZNaXYCSJec3l2W+rXAfywtP0X0dKftI+Uga5eFH8ACuayylwI470+scbe6
         EtBWPunkwq5KnYOvRsT6/9y3Q+GHRAPRZ82YA9AhBto1VMNJCsDMRq6NHtwOCWP26LL2
         ejDVvsQbICWn9hr7BARxiIOmlfrKle1wH9BloT4zwfe7dw2YYcjycnuPWZ0Lz/2tG0CF
         M42vbp4rFFcRHqOiYTDEoiyJVgeU2Ol15rFfPnW8hrgXXSX/qVC+kM05dRIo4wfVDxJt
         qUhw==
X-Gm-Message-State: AOJu0YyFrapxE6vsIinB9m6FYTqqqI4IWVr84v5afTotMxjHUQ6QgRWc
	0Jp85aGdrEHUK47Tcb1mEtg=
X-Google-Smtp-Source: AGHT+IE1MVXP9jLgCRz1LuG0iGobjYSCE+L/5OxloFuh71PnRNTZVUoMxlDiAphtLEUCzLU7eX0E5A==
X-Received: by 2002:a17:902:9a02:b0:1cc:70dd:62c3 with SMTP id v2-20020a1709029a0200b001cc70dd62c3mr349053plp.30.1700601640736;
        Tue, 21 Nov 2023 13:20:40 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001bf52834696sm8281924pll.207.2023.11.21.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:20:40 -0800 (PST)
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
Subject: [PATCH v2 6/8] x86/mm: Merge CoCo prepare and finish hypervisor callbacks
Date: Tue, 21 Nov 2023 13:20:14 -0800
Message-Id: <20231121212016.1154303-7-mhklinux@outlook.com>
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

With CoCo VM pages being marked not present when changing between
encrypted and decrypted, the order of updating the guest PTEs and
notifying the hypervisor doesn't matter. As such, only a single
hypervisor callback is needed, rather than one before and one after
the PTE update. Simplify the code by eliminating the extra
hypervisor callback and merging the TDX and SEV-SNP code that
handles the before and after cases.

Eliminating the additional callback also allows optimizing PTE
manipulation when changing between encrypted and decrypted.
The initial marking of the PTE as not present and the changes
to the encyption-related protection flags can be done as a
single operation.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/coco/tdx/tdx.c         | 46 +--------------------------------
 arch/x86/include/asm/sev.h      |  6 ++---
 arch/x86/include/asm/x86_init.h |  2 --
 arch/x86/kernel/sev.c           | 17 +++---------
 arch/x86/kernel/x86_init.c      |  2 --
 arch/x86/mm/mem_encrypt_amd.c   | 17 ++----------
 arch/x86/mm/pat/set_memory.c    | 31 ++++++++++------------
 7 files changed, 22 insertions(+), 99 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 39ead21bcba6..12fbc6824fb3 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -779,30 +779,6 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
-static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
-					  bool enc)
-{
-	/*
-	 * Only handle shared->private conversion here.
-	 * See the comment in tdx_early_init().
-	 */
-	if (enc)
-		return tdx_enc_status_changed(vaddr, numpages, enc);
-	return true;
-}
-
-static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
-					 bool enc)
-{
-	/*
-	 * Only handle private->shared conversion here.
-	 * See the comment in tdx_early_init().
-	 */
-	if (!enc)
-		return tdx_enc_status_changed(vaddr, numpages, enc);
-	return true;
-}
-
 void __init tdx_early_init(void)
 {
 	struct tdx_module_args args = {
@@ -837,27 +813,7 @@ void __init tdx_early_init(void)
 	 */
 	physical_mask &= cc_mask - 1;
 
-	/*
-	 * The kernel mapping should match the TDX metadata for the page.
-	 * load_unaligned_zeropad() can touch memory *adjacent* to that which is
-	 * owned by the caller and can catch even _momentary_ mismatches.  Bad
-	 * things happen on mismatch:
-	 *
-	 *   - Private mapping => Shared Page  == Guest shutdown
-         *   - Shared mapping  => Private Page == Recoverable #VE
-	 *
-	 * guest.enc_status_change_prepare() converts the page from
-	 * shared=>private before the mapping becomes private.
-	 *
-	 * guest.enc_status_change_finish() converts the page from
-	 * private=>shared after the mapping becomes private.
-	 *
-	 * In both cases there is a temporary shared mapping to a private page,
-	 * which can result in a #VE.  But, there is never a private mapping to
-	 * a shared page.
-	 */
-	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
-	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
+	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_changed;
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 
 	/*
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce3d368..1183b470d090 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -204,8 +204,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned long npages);
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
-void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
-void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
+void snp_set_memory(unsigned long vaddr, unsigned long npages, bool enc);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
@@ -228,8 +227,7 @@ early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned
 static inline void __init
 early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
-static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
-static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
+static inline void snp_set_memory(unsigned long vaddr, unsigned long npages, bool enc) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 5b3a9a214815..3e15c4c9ab49 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -144,12 +144,10 @@ struct x86_init_acpi {
 /**
  * struct x86_guest - Functions used by misc guest incarnations like SEV, TDX, etc.
  *
- * @enc_status_change_prepare	Notify HV before the encryption status of a range is changed
  * @enc_status_change_finish	Notify HV after the encryption status of a range is changed
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
  */
 struct x86_guest {
-	bool (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_cache_flush_required)(void);
 };
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 08b2e2a0d67d..9569fd6e968a 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -885,25 +885,16 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages,
 						op, temp_vaddr);
 }
 
-void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
+void snp_set_memory(unsigned long vaddr, unsigned long npages, bool enc)
 {
 	struct vm_struct *area;
 	unsigned long temp_vaddr;
+	enum psc_op op;
 
 	area = get_vm_area(PAGE_SIZE * (PTRS_PER_PMD + 1), 0);
 	temp_vaddr = ALIGN((unsigned long)(area->addr + PAGE_SIZE), PMD_SIZE);
-	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED, temp_vaddr);
-	free_vm_area(area);
-}
-
-void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
-{
-	struct vm_struct *area;
-	unsigned long temp_vaddr;
-
-	area = get_vm_area(PAGE_SIZE * (PTRS_PER_PMD + 1), 0);
-	temp_vaddr = ALIGN((unsigned long)(area->addr + PAGE_SIZE), PMD_SIZE);
-	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE, temp_vaddr);
+	op = enc ? SNP_PAGE_STATE_PRIVATE : SNP_PAGE_STATE_SHARED;
+	set_pages_state(vaddr, npages, op, temp_vaddr);
 	free_vm_area(area);
 }
 
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 1c0d23a2b6cf..cf5179bb1857 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -131,7 +131,6 @@ struct x86_cpuinit_ops x86_cpuinit = {
 
 static void default_nmi_init(void) { };
 
-static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
 static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
 static bool enc_cache_flush_required_noop(void) { return false; }
 static bool is_private_mmio_noop(u64 addr) {return false; }
@@ -153,7 +152,6 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 	.hyper.is_private_mmio		= is_private_mmio_noop,
 
 	.guest = {
-		.enc_status_change_prepare = enc_status_change_prepare_noop,
 		.enc_status_change_finish  = enc_status_change_finish_noop,
 		.enc_cache_flush_required  = enc_cache_flush_required_noop,
 	},
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 652cc61b89b6..90753a27eb53 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -277,18 +277,6 @@ static void enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
 #endif
 }
 
-static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
-{
-	/*
-	 * To maintain the security guarantees of SEV-SNP guests, make sure
-	 * to invalidate the memory before encryption attribute is cleared.
-	 */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
-		snp_set_memory_shared(vaddr, npages);
-
-	return true;
-}
-
 /* Return true unconditionally: return value doesn't matter for the SEV side */
 static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
 {
@@ -296,8 +284,8 @@ static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool e
 	 * After memory is mapped encrypted in the page table, validate it
 	 * so that it is consistent with the page table updates.
 	 */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && enc)
-		snp_set_memory_private(vaddr, npages);
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		snp_set_memory(vaddr, npages, enc);
 
 	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
@@ -457,7 +445,6 @@ void __init sme_early_init(void)
 	/* Update the protection map with memory encryption mask */
 	add_encrypt_protection_map();
 
-	x86_platform.guest.enc_status_change_prepare = amd_enc_status_change_prepare;
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b125035608d5..c13178f37b13 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2144,6 +2144,10 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
 		addr &= PAGE_MASK;
 
+	memset(&cpa, 0, sizeof(cpa));
+	cpa.vaddr = &addr;
+	cpa.numpages = numpages;
+
 	/*
 	 * The caller must ensure that the memory being transitioned between
 	 * encrypted and decrypted is not being accessed.  But if
@@ -2155,17 +2159,12 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	 * encryption status, since paravisor configurations can't cleanly do
 	 * the load_unaligned_zeropad() handling in the paravisor.
 	 *
-	 * set_memory_np() flushes the TLB.
+	 * There's no requirement to do so, but for efficiency we can clear
+	 * _PAGE_PRESENT and set/clr encryption attr as a single operation.
 	 */
-	ret = set_memory_np(addr, numpages);
-	if (ret)
-		return ret;
-
-	memset(&cpa, 0, sizeof(cpa));
-	cpa.vaddr = &addr;
-	cpa.numpages = numpages;
 	cpa.mask_set = enc ? pgprot_encrypted(empty) : pgprot_decrypted(empty);
-	cpa.mask_clr = enc ? pgprot_decrypted(empty) : pgprot_encrypted(empty);
+	cpa.mask_clr = enc ? pgprot_decrypted(__pgprot(_PAGE_PRESENT)) :
+				pgprot_encrypted(__pgprot(_PAGE_PRESENT));
 	cpa.pgd = init_mm.pgd;
 
 	/* Must avoid aliasing mappings in the highmem code */
@@ -2176,20 +2175,16 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	if (x86_platform.guest.enc_cache_flush_required())
 		cpa_flush(&cpa, 1);
 
-	/* Notify hypervisor that we are about to set/clr encryption attribute. */
-	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
-		return -EIO;
-
 	ret = __change_page_attr_set_clr(&cpa, 1);
 	if (ret)
 		return ret;
 
 	/*
-	 * After changing the encryption attribute, we need to flush TLBs again
-	 * in case any speculative TLB caching occurred (but no need to flush
-	 * caches again).  We could just use cpa_flush_all(), but in case TLB
-	 * flushing gets optimized in the cpa_flush() path use the same logic
-	 * as above.
+	 * After clearing _PAGE_PRESENT and changing the encryption attribute,
+	 * we need to flush TLBs to ensure no further accesses to the memory can
+	 * be made with the old encryption attribute (but no need to flush caches
+	 * again).  We could just use cpa_flush_all(), but in case TLB flushing
+	 * gets optimized in the cpa_flush() path use the same logic as above.
 	 */
 	cpa_flush(&cpa, 0);
 
-- 
2.25.1


