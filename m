Return-Path: <linux-hyperv+bounces-1387-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003F826F46
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 14:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C01A1F22FDC
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3F14121E;
	Mon,  8 Jan 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxnJZAOv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD541218;
	Mon,  8 Jan 2024 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704719288; x=1736255288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jzTq7VWB7XmiLfpeuE4JA2ASHQLGj6MFtlAwRa1zfoE=;
  b=jxnJZAOv5AJDJsoAOIBFNCnfri5g8WtrwTgYUNa3FiRwqbI0DsmsLd+q
   6FuYixfwcbYyr1MqOOMtKcNBn5AYjRDS5HLOHu9A5emP+ghsDKoXrIo+v
   Vq8fQet56MoT2dZJ9geulTjvBxaBHNitGvlmQWDq1lmFr1Ov2V/0gmWrt
   3cn4jXmhZsyZ/OpdmDdRQaCFrC7rWT3kbdAnqmQ8ffco4hKDC0jOLS5Fc
   OAXJsMJ4lhDcIJl9jhV5nN7ao80zCJSgancJ13J28mJsPEhefnxNVKiGN
   vUJWdSciqdi01vua8lRvU3d8VgsEfYLzkBfuwsFawTmp7Wr9+mQ59r9nF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="4665009"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="4665009"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:08:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="815601069"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="815601069"
Received: from ddraghic-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.53])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:08:00 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 5EB1510498C; Mon,  8 Jan 2024 16:07:57 +0300 (+03)
Date: Mon, 8 Jan 2024 16:07:57 +0300
From: kirill.shutemov@linux.intel.com
To: mhklinux@outlook.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	luto@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
	urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
	thomas.lendacky@amd.com, ardb@kernel.org, jroedel@suse.de,
	seanjc@google.com, rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Message-ID: <20240108130757.xryzva4fkmgeekhu@box.shutemov.name>
References: <20240105183025.225972-1-mhklinux@outlook.com>
 <20240105183025.225972-2-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105183025.225972-2-mhklinux@outlook.com>

On Fri, Jan 05, 2024 at 10:30:23AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> In preparation for temporarily marking pages not present during a
> transition between encrypted and decrypted, use slow_virt_to_phys()
> in the hypervisor callback. As long as the PFN is correct,
> slow_virt_to_phys() works even if the leaf PTE is not present.
> The existing functions that depend on vmalloc_to_page() all
> require that the leaf PTE be marked present, so they don't work.
> 
> Update the comments for slow_virt_to_phys() to note this broader usage
> and the requirement to work even if the PTE is not marked present.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/hyperv/ivm.c        |  9 ++++++++-
>  arch/x86/mm/pat/set_memory.c | 13 +++++++++----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 02e55237d919..8ba18635e338 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -524,7 +524,14 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
>  		return false;
>  
>  	for (i = 0, pfn = 0; i < pagecount; i++) {
> -		pfn_array[pfn] = virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_SIZE);
> +		/*
> +		 * Use slow_virt_to_phys() because the PRESENT bit has been
> +		 * temporarily cleared in the PTEs.  slow_virt_to_phys() works
> +		 * without the PRESENT bit while virt_to_hvpfn() or similar
> +		 * does not.
> +		 */
> +		pfn_array[pfn] = slow_virt_to_phys((void *)kbuffer +
> +					i * HV_HYP_PAGE_SIZE) >> HV_HYP_PAGE_SHIFT;

I think you can make it much more readable by introducing few variables:

		virt = (void *)kbuffer + i * HV_HYPPAGE_SIZE;
		phys = slow_virt_to_phys(virt);
		pfn_array[pfn] = phys >> HV_HYP_PAGE_SHIFT;

>  		pfn++;
>  
>  		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index bda9f129835e..8e19796e7ce5 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -755,10 +755,15 @@ pmd_t *lookup_pmd_address(unsigned long address)
>   * areas on 32-bit NUMA systems.  The percpu areas can
>   * end up in this kind of memory, for instance.
>   *
> - * This could be optimized, but it is only intended to be
> - * used at initialization time, and keeping it
> - * unoptimized should increase the testing coverage for
> - * the more obscure platforms.
> + * It is also used in callbacks for CoCo VM page transitions between private
> + * and shared because it works when the PRESENT bit is not set in the leaf
> + * PTE. In such cases, the state of the PTEs, including the PFN, is otherwise
> + * known to be valid, so the returned physical address is correct. The similar
> + * function vmalloc_to_pfn() can't be used because it requires the PRESENT bit.
> + *
> + * This could be optimized, but it is only used in paths that are not perf
> + * sensitive, and keeping it unoptimized should increase the testing coverage
> + * for the more obscure platforms.
>   */
>  phys_addr_t slow_virt_to_phys(void *__virt_addr)
>  {
> -- 
> 2.25.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

