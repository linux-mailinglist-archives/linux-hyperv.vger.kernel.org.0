Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6ED4C29B9
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Feb 2022 11:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiBXKmP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Feb 2022 05:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiBXKmO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Feb 2022 05:42:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37F4B45AEF;
        Thu, 24 Feb 2022 02:41:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB6B0ED1;
        Thu, 24 Feb 2022 02:41:43 -0800 (PST)
Received: from [10.163.48.178] (unknown [10.163.48.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BF8A3F70D;
        Thu, 24 Feb 2022 02:41:36 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 05/11] swiotlb: pass a gfp_mask argument to
 swiotlb_init_late
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org, tboot-devel@lists.sourceforge.net,
        linux-pci@vger.kernel.org
References: <20220222153514.593231-1-hch@lst.de>
 <20220222153514.593231-6-hch@lst.de>
Message-ID: <e3eb6441-129e-35fe-b07c-fea86908222c@arm.com>
Date:   Thu, 24 Feb 2022 16:11:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220222153514.593231-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 2/22/22 9:05 PM, Christoph Hellwig wrote:
> Let the caller chose a zone to allocate from.

This is being used later via xen_swiotlb_gfp() on arm platform.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/pci/sta2x11-fixup.c | 2 +-
>  include/linux/swiotlb.h      | 2 +-
>  kernel/dma/swiotlb.c         | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
> index e0c039a75b2db..c7e6faf59a861 100644
> --- a/arch/x86/pci/sta2x11-fixup.c
> +++ b/arch/x86/pci/sta2x11-fixup.c
> @@ -57,7 +57,7 @@ static void sta2x11_new_instance(struct pci_dev *pdev)
>  		int size = STA2X11_SWIOTLB_SIZE;
>  		/* First instance: register your own swiotlb area */
>  		dev_info(&pdev->dev, "Using SWIOTLB (size %i)\n", size);
> -		if (swiotlb_init_late(size))
> +		if (swiotlb_init_late(size, GFP_DMA))
>  			dev_emerg(&pdev->dev, "init swiotlb failed\n");
>  	}
>  	list_add(&instance->list, &sta2x11_instance_list);
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index b48b26bfa0edb..1befd6b2ccf5e 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -40,7 +40,7 @@ extern void swiotlb_init(int verbose);
>  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
>  unsigned long swiotlb_size_or_default(void);
>  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
> -int swiotlb_init_late(size_t size);
> +int swiotlb_init_late(size_t size, gfp_t gfp_mask);
>  extern void __init swiotlb_update_mem_attributes(void);
>  
>  phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 5f64b02fbb732..a653fcf1fe6c2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -290,7 +290,7 @@ swiotlb_init(int verbose)
>   * initialize the swiotlb later using the slab allocator if needed.
>   * This should be just like above, but with some error catching.
>   */
> -int swiotlb_init_late(size_t size)
> +int swiotlb_init_late(size_t size, gfp_t gfp_mask)
>  {
>  	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
>  	unsigned long bytes;
> @@ -309,7 +309,7 @@ int swiotlb_init_late(size_t size)
>  	bytes = nslabs << IO_TLB_SHIFT;
>  
>  	while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
> -		vstart = (void *)__get_free_pages(GFP_DMA | __GFP_NOWARN,
> +		vstart = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
>  						  order);
>  		if (vstart)
>  			break;
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
