Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4657D9B4
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Jul 2022 07:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiGVFFB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 Jul 2022 01:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiGVFFA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Jul 2022 01:05:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AC12A40E;
        Thu, 21 Jul 2022 22:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=asODde90Fe99CD/7037EAdFEELjMHmpfutuUG7tUMtw=; b=EbxHkWrLQKjioOqreWsRtwi0BB
        bgDVV7unChEfeR/HS9HZiyh6T2XfVtNwyC3I/onp0TQpBXHyDWKYkHanNPhz04Ek7NSKRVJOyXWzE
        2Yo3gzYgeFb0J4/SVM6D7+ybWev5m0RGMMSz6Wi+QcTEbNIyfyA/Np67k7LB/Dk7wUBBxZfPRx9sR
        8ha+QudaNuysXUNfUTpRitcG9Z/ugSlBkMdZp1/OcIe8PtlVj4W6P/8uIKgGjSddAXBY0Rof/5KsZ
        McXkISB7585Oo1E9ioKBTt74h8Z1OUh68UuYosbI9J2Aikw+Haikjupz4DRxeyhoK/lQTzsj3lWQX
        1BH6e8/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEkqL-0000oV-F5; Fri, 22 Jul 2022 05:04:53 +0000
Date:   Thu, 21 Jul 2022 22:04:53 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Tianyu Lan <ltykernel@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] swiotlb: Clean up some coding style and minor issues
Message-ID: <Ytov9VdwIv5HVsbr@infradead.org>
References: <20220722033846.950237-1-ltykernel@gmail.com>
 <PH0PR21MB3025A8991E4126A6B92126D9D7909@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025A8991E4126A6B92126D9D7909@PH0PR21MB3025.namprd21.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 22, 2022 at 04:03:21AM +0000, Michael Kelley (LINUX) wrote:
> I think you missed one of the bugs I pointed out in my previous
> comments.  In the function rmem_swiotlb_device_init(), the two
> calls to kfree() in the error path are in the wrong order.   It's a
> path that will probably never happen, but it still should be fixed.

That is already fixed in the dma-mapping tree:

http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/4a97739474c402e0a14cf6a432f1920262f6811c

> The other fixes look good to me.

Can you make that a formal Reviewed-by?

> 
> Michael
> 
> > Fixes: 26ffb91fa5e0 ("swiotlb: split up the global swiotlb lock")
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  3 +-
> >  kernel/dma/swiotlb.c                          | 42 ++++++++++++-------
> >  2 files changed, 30 insertions(+), 15 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > b/Documentation/admin-guide/kernel-parameters.txt
> > index 4a6ad177d4b8..ddca09550f76 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5907,7 +5907,8 @@
> >  			Format: { <int> [,<int>] | force | noforce }
> >  			<int> -- Number of I/O TLB slabs
> >  			<int> -- Second integer after comma. Number of swiotlb
> > -				 areas with their own lock. Must be power of 2.
> > +				 areas with their own lock. Will be rounded up
> > +				 to a power of 2.
> >  			force -- force using of bounce buffers even if they
> >  			         wouldn't be automatically used by the kernel
> >  			noforce -- Never use bounce buffers (for debugging)
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index c39483bf067d..5752db98a1f2 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -96,7 +96,13 @@ struct io_tlb_slot {
> > 
> >  static void swiotlb_adjust_nareas(unsigned int nareas)
> >  {
> > -	if (!is_power_of_2(nareas))
> > +	/*
> > +	 * Set area number to 1 when input area number
> > +	 * is zero.
> > +	 */
> > +	if (!nareas)
> > +		nareas  = 1;
> > +	else if (!is_power_of_2(nareas))
> >  		nareas = roundup_pow_of_two(nareas);
> > 
> >  	default_nareas = nareas;
> > @@ -270,6 +276,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem,
> > phys_addr_t start,
> >  	for (i = 0; i < mem->nareas; i++) {
> >  		spin_lock_init(&mem->areas[i].lock);
> >  		mem->areas[i].index = 0;
> > +		mem->areas[i].used = 0;
> >  	}
> > 
> >  	for (i = 0; i < mem->nslabs; i++) {
> > @@ -353,8 +360,8 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned
> > int flags,
> >  		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
> >  		      __func__, alloc_size, PAGE_SIZE);
> > 
> > -	mem->areas = memblock_alloc(sizeof(struct io_tlb_area) *
> > -		default_nareas, SMP_CACHE_BYTES);
> > +	mem->areas = memblock_alloc(array_size(sizeof(struct io_tlb_area),
> > +		default_nareas), SMP_CACHE_BYTES);
> >  	if (!mem->areas)
> >  		panic("%s: Failed to allocate mem->areas.\n", __func__);
> > 
> > @@ -479,7 +486,7 @@ void __init swiotlb_exit(void)
> >  		free_pages((unsigned long)mem->slots, get_order(slots_size));
> >  	} else {
> >  		memblock_free_late(__pa(mem->areas),
> > -				   mem->nareas * sizeof(struct io_tlb_area));
> > +				   array_size(sizeof(*mem->areas), mem->nareas));
> >  		memblock_free_late(mem->start, tbl_size);
> >  		memblock_free_late(__pa(mem->slots), slots_size);
> >  	}
> > @@ -593,11 +600,12 @@ static unsigned int wrap_area_index(struct io_tlb_mem
> > *mem, unsigned int index)
> >   * Find a suitable number of IO TLB entries size that will fit this request and
> >   * allocate a buffer from that IO TLB pool.
> >   */
> > -static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
> > -		struct io_tlb_area *area, int area_index,
> > -		struct device *dev, phys_addr_t orig_addr,
> > +static int swiotlb_do_find_slots(struct device *dev,
> > +		int area_index, phys_addr_t orig_addr,
> >  		size_t alloc_size, unsigned int alloc_align_mask)
> >  {
> > +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> > +	struct io_tlb_area *area = mem->areas + area_index;
> >  	unsigned long boundary_mask = dma_get_seg_boundary(dev);
> >  	dma_addr_t tbl_dma_addr =
> >  		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
> > @@ -686,13 +694,12 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t
> > orig_addr,
> >  		size_t alloc_size, unsigned int alloc_align_mask)
> >  {
> >  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> > -	int start = raw_smp_processor_id() & ((1U << __fls(mem->nareas)) - 1);
> > +	int start = raw_smp_processor_id() & (mem->nareas - 1);
> >  	int i = start, index;
> > 
> >  	do {
> > -		index = swiotlb_do_find_slots(mem, mem->areas + i, i,
> > -					      dev, orig_addr, alloc_size,
> > -					      alloc_align_mask);
> > +		index = swiotlb_do_find_slots(dev, i, orig_addr,
> > +					      alloc_size, alloc_align_mask);
> >  		if (index >= 0)
> >  			return index;
> >  		if (++i >= mem->nareas)
> > @@ -903,17 +910,24 @@ bool is_swiotlb_active(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(is_swiotlb_active);
> > 
> > +static int io_tlb_used_get(void *data, u64 *val)
> > +{
> > +	*val = mem_used(&io_tlb_default_mem);
> > +
> > +	return 0;
> > +}
> > +DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%llu\n");
> > +
> >  static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
> >  					 const char *dirname)
> >  {
> > -	unsigned long used = mem_used(mem);
> > -
> >  	mem->debugfs = debugfs_create_dir(dirname, io_tlb_default_mem.debugfs);
> >  	if (!mem->nslabs)
> >  		return;
> > 
> >  	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
> > -	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &used);
> > +	debugfs_create_file_unsafe("io_tlb_used", 0400, mem->debugfs, NULL,
> > +			&fops_io_tlb_used);
> >  }
> > 
> >  static int __init __maybe_unused swiotlb_create_default_debugfs(void)
> > --
> > 2.25.1
> 
---end quoted text---
