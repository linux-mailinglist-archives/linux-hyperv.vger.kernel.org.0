Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D642E569A22
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 07:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiGGF6q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 01:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiGGF6p (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 01:58:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E967B2F013;
        Wed,  6 Jul 2022 22:58:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96BA568AA6; Thu,  7 Jul 2022 07:58:40 +0200 (CEST)
Date:   Thu, 7 Jul 2022 07:58:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-hyperv@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 2/2] dma-direct: Fix dma_direct_{alloc,free}() for
 Hyperv-V IVMs
Message-ID: <20220707055840.GA13401@lst.de>
References: <20220706195027.76026-1-parri.andrea@gmail.com> <20220706195027.76026-3-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706195027.76026-3-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 06, 2022 at 09:50:27PM +0200, Andrea Parri (Microsoft) wrote:
> @@ -305,6 +306,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		ret = page_address(page);
>  		if (dma_set_decrypted(dev, ret, size))
>  			goto out_free_pages;
> +#ifdef CONFIG_HAS_IOMEM
> +		/*
> +		 * Remap the pages in the unencrypted physical address space
> +		 * when dma_unencrypted_base is set (e.g., for Hyper-V AMD
> +		 * SEV-SNP isolated guests).
> +		 */
> +		if (dma_unencrypted_base) {
> +			phys_addr_t ret_pa = virt_to_phys(ret);
> +
> +			ret_pa += dma_unencrypted_base;
> +			ret = memremap(ret_pa, size, MEMREMAP_WB);
> +			if (!ret)
> +				goto out_encrypt_pages;
> +		}
> +#endif


So:

this needs to move into dma_set_decrypted, otherwise we don't handle
the dma_alloc_pages case (never mind that this is pretty unreadable).

Which then again largely duplicates the code in swiotlb.  So I think
what we need here is a low-level helper that does the
set_memory_decrypted and memremap.  I'm not quite sure where it
should go, but maybe some of the people involved with memory
encryption might have good ideas.  unencrypted_base should go with
it and then both swiotlb and dma-direct can call it.

> +	/*
> +	 * If dma_unencrypted_base is set, the virtual address returned by
> +	 * dma_direct_alloc() is in the vmalloc address range.
> +	 */
> +	if (!dma_unencrypted_base && is_vmalloc_addr(cpu_addr)) {
>  		vunmap(cpu_addr);
>  	} else {
>  		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
>  			arch_dma_clear_uncached(cpu_addr, size);
> +#ifdef CONFIG_HAS_IOMEM
> +		if (dma_unencrypted_base) {
> +			memunmap(cpu_addr);
> +			/* re-encrypt the pages using the original address */
> +			cpu_addr = page_address(pfn_to_page(PHYS_PFN(
> +					dma_to_phys(dev, dma_addr))));
> +		}
> +#endif
>  		if (dma_set_encrypted(dev, cpu_addr, size))

Same on the unmap side.  It might also be worth looking into reordering
the checks in some form instead o that raw dma_unencrypted_base check
before the unmap.
