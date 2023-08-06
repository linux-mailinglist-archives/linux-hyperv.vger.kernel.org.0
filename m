Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963DF77172E
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Aug 2023 00:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjHFWUA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Aug 2023 18:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFWUA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Aug 2023 18:20:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF4E107;
        Sun,  6 Aug 2023 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691360397; x=1722896397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aZsEp5j0Pf9SedmvNogSqrO1lS+hWeVBVgPfwHg6VlM=;
  b=KhNvi/5MZCtnqOG6yauGbbSJivWaThtZl3rHQdWdhdYgcLor2ns0wVxk
   DqcxcKCH7lNdx6F58Adno7F2m+aktrQqHcR9FhuJy+5iQSZNUuQ0PGqCA
   Ns68tmcLGyqOdkarD01rcvbAwJI03cgZDf6zhDirLT7Kj5DWgzYfWmAOX
   MGcd+fewEBk1HEC9nSxFTLPAC/WscUhVuUJMwrJIWhnTX+7wpy9dg8HY7
   pOjijccYxvbF/qnhBS/2+xfsgxtluz5n6viB7LD8Ni7dH7JJBuz4UU0/7
   YKLovld15M+VtmsDOAah4MsNiV+JuYT+N4461Vq5vVKgtO6ZfVaLRbeo8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="350725368"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="350725368"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 15:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="760235469"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="760235469"
Received: from vkonyche-mobl1.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.63.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 15:19:52 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4FED210A119; Mon,  7 Aug 2023 01:19:49 +0300 (+03)
Date:   Mon, 7 Aug 2023 01:19:49 +0300
From:   kirill.shutemov@linux.intel.com
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, thomas.lendacky@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Message-ID: <20230806221949.ckoi6ssomsuaeaab@box.shutemov.name>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 06, 2023 at 09:41:59AM -0700, Michael Kelley wrote:
> In a CoCo VM when a page transitions from private to shared, or vice
> versa, attributes in the PTE must be updated *and* the hypervisor must
> be notified of the change. Because there are two separate steps, there's
> a window where the settings are inconsistent.  Normally the code that
> initiates the transition (via set_memory_decrypted() or
> set_memory_encrypted()) ensures that the memory is not being accessed
> during a transition, so the window of inconsistency is not a problem.
> However, the load_unaligned_zeropad() function can read arbitrary memory
> pages at arbitrary times, which could access a transitioning page during
> the window.  In such a case, CoCo VM specific exceptions are taken
> (depending on the CoCo architecture in use).  Current code in those
> exception handlers recovers and does "fixup" on the result returned by
> load_unaligned_zeropad().  Unfortunately, this exception handling and
> fixup code is tricky and somewhat fragile.  At the moment, it is
> broken for both TDX and SEV-SNP.

I believe it is not fixed for TDX. Is it still a problem for SEV-SNP?

> There's also a problem with the current code in paravisor scenarios:
> TDX Partitioning and SEV-SNP in vTOM mode. The exceptions need
> to be forwarded from the paravisor to the Linux guest, but there
> are no architectural specs for how to do that.
> 
> To avoid these complexities of the CoCo exception handlers, change
> the core transition code in __set_memory_enc_pgtable() to do the
> following:
> 
> 1.  Remove aliasing mappings
> 2.  Remove the PRESENT bit from the PTEs of all transitioning pages
> 3.  Flush the TLB globally
> 4.  Flush the data cache if needed
> 5.  Set/clear the encryption attribute as appropriate
> 6.  Notify the hypervisor of the page status change
> 7.  Add back the PRESENT bit

Okay, looks safe.

> With this approach, load_unaligned_zeropad() just takes its normal
> page-fault-based fixup path if it touches a page that is transitioning.
> As a result, load_unaligned_zeropad() and CoCo VM page transitioning
> are completely decoupled.  CoCo VM page transitions can proceed
> without needing to handle architecture-specific exceptions and fix
> things up. This decoupling reduces the complexity due to separate
> TDX and SEV-SNP fixup paths, and gives more freedom to revise and
> introduce new capabilities in future versions of the TDX and SEV-SNP
> architectures. Paravisor scenarios work properly without needing
> to forward exceptions.
> 
> This approach may make __set_memory_enc_pgtable() slightly slower
> because of touching the PTEs three times instead of just once. But
> the run time of this function is already dominated by the hypercall
> and the need to flush the TLB at least once and maybe twice. In any
> case, this function is only used for CoCo VM page transitions, and
> is already unsuitable for hot paths.
> 
> The architecture specific callback function for notifying the
> hypervisor typically must translate guest kernel virtual addresses
> into guest physical addresses to pass to the hypervisor.  Because
> the PTEs are invalid at the time of callback, the code for doing the
> translation needs updating.  virt_to_phys() or equivalent continues
> to work for direct map addresses.  But vmalloc addresses cannot use
> vmalloc_to_page() because that function requires the leaf PTE to be
> valid. Instead, slow_virt_to_phys() must be used. Both functions
> manually walk the page table hierarchy, so performance is the same.

Uhmm.. But why do we expected slow_virt_to_phys() to work on non-present
page table entries? It seems accident for me that it works now. Somebody
forgot pte_present() check.

Generally, if present bit is clear we cannot really assume anything about
the rest of the bits without external hints.

This smells bad.

Maybe the interface has to be reworked to operate on GPAs?

 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
> 
> I'm assuming the TDX handling of the data cache flushing is the
> same with this new approach, and that it doesn't need to be paired
> with a TLB flush as in the current code.  If that's not a correct
> assumption, let me know.
> 
> I've left the two hypervisor callbacks, before and after Step 5
> above. If the PTEs are invalid, it seems like the order of Step 5
> and Step 6 shouldn't matter, so perhaps one of the callback could
> be dropped.  Let me know if there are reasons to do otherwise.
> 
> It may well be possible to optimize the new implementation of
> __set_memory_enc_pgtable(). The existing set_memory_np() and
> set_memory_p() functions do all the right things in a very clear
> fashion, but perhaps not as optimally as having all three PTE
> manipulations directly in the same function. It doesn't appear
> that optimizing the performance really matters here, but I'm open
> to suggestions.
> 
> I've tested this on TDX VMs and SEV-SNP + vTOM VMs.  I can also
> test on SEV-SNP VMs without vTOM. But I'll probably need help
> covering SEV and SEV-ES VMs.
> 
> This RFC patch does *not* remove code that would no longer be
> needed. If there's agreement to take this new approach, I'll
> add patches to remove the unneeded code.
> 
> This patch is built against linux-next20230704.
> 
>  arch/x86/hyperv/ivm.c        |  3 ++-
>  arch/x86/kernel/sev.c        |  2 +-
>  arch/x86/mm/pat/set_memory.c | 32 ++++++++++++--------------------
>  3 files changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 28be6df..2859ec3 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -308,7 +308,8 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
>  		return false;
>  
>  	for (i = 0, pfn = 0; i < pagecount; i++) {
> -		pfn_array[pfn] = virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_SIZE);
> +		pfn_array[pfn] = slow_virt_to_phys((void *)kbuffer +
> +					i * HV_HYP_PAGE_SIZE) >> HV_HYP_PAGE_SHIFT;
>  		pfn++;
>  
>  		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 1ee7bed..59db55e 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -784,7 +784,7 @@ static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long
>  		hdr->end_entry = i;
>  
>  		if (is_vmalloc_addr((void *)vaddr)) {
> -			pfn = vmalloc_to_pfn((void *)vaddr);
> +			pfn = slow_virt_to_phys((void *)vaddr) >> PAGE_SHIFT;
>  			use_large_entry = false;
>  		} else {
>  			pfn = __pa(vaddr) >> PAGE_SHIFT;
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index bda9f12..8a194c7 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2136,6 +2136,11 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
>  		addr &= PAGE_MASK;
>  
> +	/* set_memory_np() removes aliasing mappings and flushes the TLB */
> +	ret = set_memory_np(addr, numpages);
> +	if (ret)
> +		return ret;
> +
>  	memset(&cpa, 0, sizeof(cpa));
>  	cpa.vaddr = &addr;
>  	cpa.numpages = numpages;
> @@ -2143,36 +2148,23 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	cpa.mask_clr = enc ? pgprot_decrypted(empty) : pgprot_encrypted(empty);
>  	cpa.pgd = init_mm.pgd;
>  
> -	/* Must avoid aliasing mappings in the highmem code */
> -	kmap_flush_unused();
> -	vm_unmap_aliases();


Why did you drop this?

> -
>  	/* Flush the caches as needed before changing the encryption attribute. */
> -	if (x86_platform.guest.enc_tlb_flush_required(enc))
> -		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
> +	if (x86_platform.guest.enc_cache_flush_required())
> +		cpa_flush(&cpa, 1);

Do you remove the last enc_cache_flush_required() user?

>  	/* Notify hypervisor that we are about to set/clr encryption attribute. */
>  	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
>  		return -EIO;
>  
>  	ret = __change_page_attr_set_clr(&cpa, 1);
> -
> -	/*
> -	 * After changing the encryption attribute, we need to flush TLBs again
> -	 * in case any speculative TLB caching occurred (but no need to flush
> -	 * caches again).  We could just use cpa_flush_all(), but in case TLB
> -	 * flushing gets optimized in the cpa_flush() path use the same logic
> -	 * as above.
> -	 */
> -	cpa_flush(&cpa, 0);
> +	if (ret)
> +		return ret;
>  
>  	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
> -	if (!ret) {
> -		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> -			ret = -EIO;
> -	}
> +	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> +		return -EIO;
>  
> -	return ret;
> +	return set_memory_p(&addr, numpages);
>  }
>  
>  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> -- 
> 1.8.3.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
