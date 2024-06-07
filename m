Return-Path: <linux-hyperv+bounces-2340-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45991900864
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 17:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51F01F22AC1
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4968B197501;
	Fri,  7 Jun 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbP1Lc9b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75007194A5F;
	Fri,  7 Jun 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773278; cv=none; b=tZt++x+AciXeB0iP9Bt1L4pEBnEk+E1DXfIflaX4Q6zAUvwuWAkNN2qOd8aI4ulhxVCBuGZLXkCXJX/0xNW/tRIEqP0kwXOgsPeaKaK/n2NzBVvUHjKCUOsRBwgWrSCKmE1yzK4or+rHVO0Uen3pGJollZAUKYtAeftrSKocc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773278; c=relaxed/simple;
	bh=XXq1CUm0YM3BcuboGgGpWREXpzYqe98jsob87/Kz8JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou4xBPRxtyRGRoMrG1nQWGyJ+1KuROA4r4vHAlOeKe1Yct4RGH35vky66NiTeSZ+TLUkCLrvRicHUjKpv/0BPDX2Q2nu2wmTOyncW5YK2C+3B2krur/jDNyHzsa2YNqCCwb+KlDaPvBv0vs60p7j90dDQb/rTjUz5UllsR+DCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbP1Lc9b; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717773277; x=1749309277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XXq1CUm0YM3BcuboGgGpWREXpzYqe98jsob87/Kz8JM=;
  b=mbP1Lc9bjz3jlAGWRx2ati9EfYWspYDlb8lauOus/K5Bw2oJ3fuU86Wi
   G4i4+8mXI3OG/2tzXARuh6O3lt+LOtn5U033tbhowY4S0izuntJ6GmZQM
   ErwjMSRG4J9i67Mijvd5d6E032SHnTGFwpnrETt3t+tGgIntGy7Qxb1z6
   g+IgVObLtkGFAg4nUV8a97QWSs882V2Vt7eCDvuZ4fYMkWbWS8DZbktUC
   BGr6WV3w0N4raI32HlbfCBjqpQKBt88r4cB9asi42xGm2l/bNgmFulLMK
   5tHwCbowC+62jXSS+TSFXd2nKcbdVo12SAX5bVqV55nBLaLgb6Wk8uRvA
   A==;
X-CSE-ConnectionGUID: cMAZt/+MSXyB28MQs4VPMA==
X-CSE-MsgGUID: 9+xIDLWFTUGYB6lzKlnS4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="31994431"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="31994431"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 08:14:36 -0700
X-CSE-ConnectionGUID: 1DJWudwORySimsNrY6/5dg==
X-CSE-MsgGUID: AMPzl3/PTV+d/VteOjVbvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38470479"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 07 Jun 2024 08:14:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8D1922DC; Fri, 07 Jun 2024 18:14:28 +0300 (EEST)
Date: Fri, 7 Jun 2024 18:14:28 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>

On Mon, Jun 03, 2024 at 10:39:30AM +0200, Borislav Petkov wrote:
> > +/*
> > + * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
> > + * the same place as in the kernel page tables. asm_acpi_mp_play_dead() switches
> > + * to the identity mapping and the function has be present at the same spot in
> > + * the virtual address space before and after switching page tables.
> > + */
> > +static int __init init_transition_pgtable(pgd_t *pgd)
> 
> This looks like a generic helper which should be in set_memory.c. And
> looking at that file, there's populate_pgd() which does pretty much the
> same thing, if I squint real hard.
> 
> Let's tone down the duplication.

Okay, there is a function called kernel_map_pages_in_pgd() in set_memory.c
that does what we need here.

I tried to use it, but encountered a few issues:

- The code in set_memory.c allocates memory using the buddy allocator,
  which is not yet ready. We can work around this limitation by delaying
  the initialization of offlining until later, using a separate
  early_initcall();

- I noticed a complaint that the allocation is being done from an atomic
  context: a spinlock called cpa_lock is taken when populate_pgd()
  allocates memory.

  I am not sure why this was not noticed before. kernel_map_pages_in_pgd()
  has only been used in EFI mapping initialization so far, so maybe it is
  somehow special, I don't know.

  I was able to address this issue by switching cpa_lock to a mutex.
  However, this solution will only work if the callers for set_memory
  interfaces are not called from an atomic context. I need to verify if
  this is the case.

- The function __flush_tlb_all() in kernel_(un)map_pages_in_pgd() must be
  called with preemption disabled. Once again, I am unsure why this has
  not caused issues in the EFI case.

- I discovered a bug in kernel_ident_mapping_free() when it is used on a
  machine with 5-level paging. I will submit a proper patch to fix this
  issue.

The fixup is below.

Any comments?

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 6cfe762be28b..fbbfe78f7f27 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -59,82 +59,55 @@ static void acpi_mp_cpu_die(unsigned int cpu)
 		pr_err("Failed to hand over CPU %d to BIOS\n", cpu);
 }
 
+static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
+{
+	cpu_hotplug_disable_offlining();
+
+	/*
+	 * ACPI MADT doesn't allow to offline a CPU after it was onlined. This
+	 * limits kexec: the second kernel won't be able to use more than one CPU.
+	 *
+	 * To prevent a kexec kernel from onlining secondary CPUs invalidate the
+	 * mailbox address in the ACPI MADT wakeup structure which prevents a
+	 * kexec kernel to use it.
+	 *
+	 * This is safe as the booting kernel has the mailbox address cached
+	 * already and acpi_wakeup_cpu() uses the cached value to bring up the
+	 * secondary CPUs.
+	 *
+	 * Note: This is a Linux specific convention and not covered by the
+	 *       ACPI specification.
+	 */
+	mp_wake->mailbox_address = 0;
+}
+
 /* The argument is required to match type of x86_mapping_info::alloc_pgt_page */
 static void __init *alloc_pgt_page(void *dummy)
 {
-	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+	return (void *)get_zeroed_page(GFP_KERNEL);
 }
 
 static void __init free_pgt_page(void *pgt, void *dummy)
 {
-	return memblock_free(pgt, PAGE_SIZE);
+	return free_page((unsigned long)pgt);
 }
 
-/*
- * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
- * the same place as in the kernel page tables. asm_acpi_mp_play_dead() switches
- * to the identity mapping and the function has be present at the same spot in
- * the virtual address space before and after switching page tables.
- */
-static int __init init_transition_pgtable(pgd_t *pgd)
-{
-	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
-	unsigned long vaddr, paddr;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	vaddr = (unsigned long)asm_acpi_mp_play_dead;
-	pgd += pgd_index(vaddr);
-	if (!pgd_present(*pgd)) {
-		p4d = (p4d_t *)alloc_pgt_page(NULL);
-		if (!p4d)
-			return -ENOMEM;
-		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
-	}
-	p4d = p4d_offset(pgd, vaddr);
-	if (!p4d_present(*p4d)) {
-		pud = (pud_t *)alloc_pgt_page(NULL);
-		if (!pud)
-			return -ENOMEM;
-		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
-	}
-	pud = pud_offset(p4d, vaddr);
-	if (!pud_present(*pud)) {
-		pmd = (pmd_t *)alloc_pgt_page(NULL);
-		if (!pmd)
-			return -ENOMEM;
-		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
-	}
-	pmd = pmd_offset(pud, vaddr);
-	if (!pmd_present(*pmd)) {
-		pte = (pte_t *)alloc_pgt_page(NULL);
-		if (!pte)
-			return -ENOMEM;
-		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
-	}
-	pte = pte_offset_kernel(pmd, vaddr);
-
-	paddr = __pa(vaddr);
-	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
-
-	return 0;
-}
-
-static int __init acpi_mp_setup_reset(u64 reset_vector)
+static int __init acpi_mp_setup_reset(union acpi_subtable_headers *header,
+			      const unsigned long end)
 {
+	struct acpi_madt_multiproc_wakeup *mp_wake;
 	struct x86_mapping_info info = {
 		.alloc_pgt_page = alloc_pgt_page,
 		.free_pgt_page	= free_pgt_page,
 		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
-		.kernpg_flag    = _KERNPG_TABLE_NOENC,
+		.kernpg_flag    = _KERNPG_TABLE,
 	};
+	unsigned long vaddr, pfn;
 	pgd_t *pgd;
 
 	pgd = alloc_pgt_page(NULL);
 	if (!pgd)
-		return -ENOMEM;
+		goto err;
 
 	for (int i = 0; i < nr_pfn_mapped; i++) {
 		unsigned long mstart, mend;
@@ -143,30 +116,45 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 		mend   = pfn_mapped[i].end << PAGE_SHIFT;
 		if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
 			kernel_ident_mapping_free(&info, pgd);
-			return -ENOMEM;
+			goto err;
 		}
 	}
 
 	if (kernel_ident_mapping_init(&info, pgd,
-				      PAGE_ALIGN_DOWN(reset_vector),
-				      PAGE_ALIGN(reset_vector + 1))) {
+				      PAGE_ALIGN_DOWN(acpi_mp_reset_vector_paddr),
+				      PAGE_ALIGN(acpi_mp_reset_vector_paddr + 1))) {
 		kernel_ident_mapping_free(&info, pgd);
-		return -ENOMEM;
+		goto err;
 	}
 
-	if (init_transition_pgtable(pgd)) {
+	/*
+	 * Make sure asm_acpi_mp_play_dead() is present in the identity mapping
+	 * at the same place as in the kernel page tables.
+	 *
+	 * asm_acpi_mp_play_dead() switches to the identity mapping and the
+	 * function has be present at the same spot in the virtual address space
+	 * before and after switching page tables.
+	 */
+	vaddr = (unsigned long)asm_acpi_mp_play_dead;
+	pfn = __pa(vaddr) >> PAGE_SHIFT;
+	if (kernel_map_pages_in_pgd(pgd, pfn, vaddr, 1, _KERNPG_TABLE)) {
 		kernel_ident_mapping_free(&info, pgd);
-		return -ENOMEM;
+		goto err;
 	}
 
 	smp_ops.play_dead = acpi_mp_play_dead;
 	smp_ops.stop_this_cpu = acpi_mp_stop_this_cpu;
 	smp_ops.cpu_die = acpi_mp_cpu_die;
 
-	acpi_mp_reset_vector_paddr = reset_vector;
 	acpi_mp_pgd = __pa(pgd);
 
 	return 0;
+err:
+	pr_warn("Failed to setup MADT reset vector\n");
+	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
+	acpi_mp_disable_offlining(mp_wake);
+	return -ENOMEM;
+
 }
 
 static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
@@ -226,28 +214,6 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 	return 0;
 }
 
-static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
-{
-	cpu_hotplug_disable_offlining();
-
-	/*
-	 * ACPI MADT doesn't allow to offline a CPU after it was onlined. This
-	 * limits kexec: the second kernel won't be able to use more than one CPU.
-	 *
-	 * To prevent a kexec kernel from onlining secondary CPUs invalidate the
-	 * mailbox address in the ACPI MADT wakeup structure which prevents a
-	 * kexec kernel to use it.
-	 *
-	 * This is safe as the booting kernel has the mailbox address cached
-	 * already and acpi_wakeup_cpu() uses the cached value to bring up the
-	 * secondary CPUs.
-	 *
-	 * Note: This is a Linux specific convention and not covered by the
-	 *       ACPI specification.
-	 */
-	mp_wake->mailbox_address = 0;
-}
-
 int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 			      const unsigned long end)
 {
@@ -274,10 +240,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	if (mp_wake->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
 	    mp_wake->header.length >= ACPI_MADT_MP_WAKEUP_SIZE_V1) {
-		if (acpi_mp_setup_reset(mp_wake->reset_vector)) {
-			pr_warn("Failed to setup MADT reset vector\n");
-			acpi_mp_disable_offlining(mp_wake);
-		}
+		acpi_mp_reset_vector_paddr = mp_wake->reset_vector;
 	} else {
 		/*
 		 * CPU offlining requires version 1 of the ACPI MADT wakeup
@@ -290,3 +253,13 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	return 0;
 }
+
+static int __init acpi_mp_offline_init(void)
+{
+	if (!acpi_mp_reset_vector_paddr)
+		return 0;
+
+	return acpi_table_parse_madt(ACPI_MADT_TYPE_MULTIPROC_WAKEUP,
+				     acpi_mp_setup_reset, 1);
+}
+early_initcall(acpi_mp_offline_init);
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 3996af7b4abf..c45127265f2f 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -60,7 +60,7 @@ static void free_p4d(struct x86_mapping_info *info, pgd_t *pgd)
 	}
 
 	if (pgtable_l5_enabled())
-		info->free_pgt_page(pgd, info->context);
+		info->free_pgt_page(p4d, info->context);
 }
 
 void kernel_ident_mapping_free(struct x86_mapping_info *info, pgd_t *pgd)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 443a97e515c0..72715674f492 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -69,7 +69,7 @@ static const int cpa_warn_level = CPA_PROTECT;
  * entries change the page attribute in parallel to some other cpu
  * splitting a large page entry along with changing the attribute.
  */
-static DEFINE_SPINLOCK(cpa_lock);
+static DEFINE_MUTEX(cpa_lock);
 
 #define CPA_FLUSHTLB 1
 #define CPA_ARRAY 2
@@ -1186,10 +1186,10 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 	struct page *base;
 
 	if (!debug_pagealloc_enabled())
-		spin_unlock(&cpa_lock);
+		mutex_unlock(&cpa_lock);
 	base = alloc_pages(GFP_KERNEL, 0);
 	if (!debug_pagealloc_enabled())
-		spin_lock(&cpa_lock);
+		mutex_lock(&cpa_lock);
 	if (!base)
 		return -ENOMEM;
 
@@ -1804,10 +1804,10 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 			cpa->numpages = 1;
 
 		if (!debug_pagealloc_enabled())
-			spin_lock(&cpa_lock);
+			mutex_lock(&cpa_lock);
 		ret = __change_page_attr(cpa, primary);
 		if (!debug_pagealloc_enabled())
-			spin_unlock(&cpa_lock);
+			mutex_unlock(&cpa_lock);
 		if (ret)
 			goto out;
 
@@ -2516,7 +2516,9 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 	cpa.mask_set = __pgprot(_PAGE_PRESENT | page_flags);
 
 	retval = __change_page_attr_set_clr(&cpa, 1);
+	preempt_disable();
 	__flush_tlb_all();
+	preempt_enable();
 
 out:
 	return retval;
@@ -2551,7 +2553,9 @@ int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
 
 	retval = __change_page_attr_set_clr(&cpa, 1);
+	preempt_disable();
 	__flush_tlb_all();
+	preempt_enable();
 
 	return retval;
 }
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

