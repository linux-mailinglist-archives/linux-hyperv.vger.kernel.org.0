Return-Path: <linux-hyperv+bounces-1390-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881258277C9
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 19:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E811F23B65
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1A54F83;
	Mon,  8 Jan 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbPbCyEH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D755C07;
	Mon,  8 Jan 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704739054; x=1736275054;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=OHCMnUym3kiJu7MowwwFDStEQeC8LwsWW80R0Z2s7Lo=;
  b=ZbPbCyEHvA3sgqVSirhfm0Foo7vKnsUmpHTuCv4NVeNkX1LP9JszVugE
   K80XMgSMclxZBPsVEk9T6hjoSa/qnOrkXiqhOlBlAyUXRtRBZPHci4oKd
   /SA1OGiGrVyLN4xcUFxrUC9Ytm5UmNvQRCZpF8qnv98b2z9grd4L53sHx
   cNrHSIO12kd8ibasXg8f0Ga/cfw/k5Wg+6bUEWYbq0x4PHrcVXO6GfKnx
   t28HSGUkxHjLeYSsKFXdxC30KPTZD1Bdd3/8296S5or6VrKK7NodCzJWr
   BHidnxCG4fRAGD2FTopHPkW4dWvUagP4oT8S2seD9Ie8qo18RJWMhylL0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4717269"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="4717269"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 10:37:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="757693603"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="757693603"
Received: from nsingiri-mobl2.amr.corp.intel.com (HELO [10.212.166.188]) ([10.212.166.188])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 10:37:32 -0800
Message-ID: <a559406d-acd5-40eb-906e-2b8b11739e9e@linux.intel.com>
Date: Mon, 8 Jan 2024 10:37:28 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] x86/hyperv: Make encrypted/decrypted changes safe
 for load_unaligned_zeropad()
Content-Language: en-US
To: mhklinux@outlook.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kirill.shutemov@linux.intel.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, luto@kernel.org, peterz@infradead.org,
 akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
 lstoakes@gmail.com, thomas.lendacky@amd.com, ardb@kernel.org,
 jroedel@suse.de, seanjc@google.com, rick.p.edgecombe@intel.com,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-hyperv@vger.kernel.org, linux-mm@kvack.org
References: <20240105183025.225972-1-mhklinux@outlook.com>
 <20240105183025.225972-4-mhklinux@outlook.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240105183025.225972-4-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/5/2024 10:30 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> In a CoCo VM, when transitioning memory from encrypted to decrypted, or
> vice versa, the caller of set_memory_encrypted() or set_memory_decrypted()
> is responsible for ensuring the memory isn't in use and isn't referenced
> while the transition is in progress.  The transition has multiple steps,
> and the memory is in an inconsistent state until all steps are complete.
> A reference while the state is inconsistent could result in an exception
> that can't be cleanly fixed up.
> 
> However, the kernel load_unaligned_zeropad() mechanism could cause a stray
> reference that can't be prevented by the caller of set_memory_encrypted()
> or set_memory_decrypted(), so there's specific code to handle this case.
> But a CoCo VM running on Hyper-V may be configured to run with a paravisor,
> with the #VC or #VE exception routed to the paravisor. There's no
> architectural way to forward the exceptions back to the guest kernel, and
> in such a case, the load_unaligned_zeropad() specific code doesn't work.
> 
> To avoid this problem, mark pages as "not present" while a transition
> is in progress. If load_unaligned_zeropad() causes a stray reference, a
> normal page fault is generated instead of #VC or #VE, and the
> page-fault-based fixup handlers for load_unaligned_zeropad() resolve the
> reference. When the encrypted/decrypted transition is complete, mark the
> pages as "present" again.

Change looks good to me. But I am wondering why are adding it part of prepare
and finish callbacks instead of directly in set_memory_encrypted() function.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/hyperv/ivm.c | 49 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 8ba18635e338..5ad39256a5d2 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -15,6 +15,7 @@
>  #include <asm/io.h>
>  #include <asm/coco.h>
>  #include <asm/mem_encrypt.h>
> +#include <asm/set_memory.h>
>  #include <asm/mshyperv.h>
>  #include <asm/hypervisor.h>
>  #include <asm/mtrr.h>
> @@ -502,6 +503,31 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
>  		return -EFAULT;
>  }
>  
> +/*
> + * When transitioning memory between encrypted and decrypted, the caller
> + * of set_memory_encrypted() or set_memory_decrypted() is responsible for
> + * ensuring that the memory isn't in use and isn't referenced while the
> + * transition is in progress.  The transition has multiple steps, and the
> + * memory is in an inconsistent state until all steps are complete. A
> + * reference while the state is inconsistent could result in an exception
> + * that can't be cleanly fixed up.
> + *
> + * But the Linux kernel load_unaligned_zeropad() mechanism could cause a
> + * stray reference that can't be prevented by the caller, so Linux has
> + * specific code to handle this case. But when the #VC and #VE exceptions
> + * routed to a paravisor, the specific code doesn't work. To avoid this
> + * problem, mark the pages as "not present" while the transition is in
> + * progress. If load_unaligned_zeropad() causes a stray reference, a normal
> + * page fault is generated instead of #VC or #VE, and the page-fault-based
> + * handlers for load_unaligned_zeropad() resolve the reference.  When the
> + * transition is complete, hv_vtom_set_host_visibility() marks the pages
> + * as "present" again.
> + */
> +static bool hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc)
> +{
> +	return !set_memory_np(kbuffer, pagecount);
> +}
> +
>  /*
>   * hv_vtom_set_host_visibility - Set specified memory visible to host.
>   *
> @@ -521,7 +547,7 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
>  
>  	pfn_array = kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
>  	if (!pfn_array)
> -		return false;
> +		goto err_set_memory_p;
>  
>  	for (i = 0, pfn = 0; i < pagecount; i++) {
>  		/*
> @@ -545,14 +571,30 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
>  		}
>  	}
>  
> - err_free_pfn_array:
> +err_free_pfn_array:
>  	kfree(pfn_array);
> +
> +err_set_memory_p:
> +	/*
> +	 * Set the PTE PRESENT bits again to revert what hv_vtom_clear_present()
> +	 * did. Do this even if there is an error earlier in this function in
> +	 * order to avoid leaving the memory range in a "broken" state. Setting
> +	 * the PRESENT bits shouldn't fail, but return an error if it does.
> +	 */
> +	if (set_memory_p(kbuffer, pagecount))
> +		result = false;
> +
>  	return result;
>  }
>  
>  static bool hv_vtom_tlb_flush_required(bool private)
>  {
> -	return true;
> +	/*
> +	 * Since hv_vtom_clear_present() marks the PTEs as "not present"
> +	 * and flushes the TLB, they can't be in the TLB. That makes the
> +	 * flush controlled by this function redundant, so return "false".
> +	 */
> +	return false;
>  }
>  
>  static bool hv_vtom_cache_flush_required(void)
> @@ -615,6 +657,7 @@ void __init hv_vtom_init(void)
>  	x86_platform.hyper.is_private_mmio = hv_is_private_mmio;
>  	x86_platform.guest.enc_cache_flush_required = hv_vtom_cache_flush_required;
>  	x86_platform.guest.enc_tlb_flush_required = hv_vtom_tlb_flush_required;
> +	x86_platform.guest.enc_status_change_prepare = hv_vtom_clear_present;
>  	x86_platform.guest.enc_status_change_finish = hv_vtom_set_host_visibility;
>  
>  	/* Set WB as the default cache mode. */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

