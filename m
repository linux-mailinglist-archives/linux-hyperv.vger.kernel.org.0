Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E0D51372F
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 16:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347623AbiD1OsE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiD1OsB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 10:48:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 814386D3BF;
        Thu, 28 Apr 2022 07:44:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4104114BF;
        Thu, 28 Apr 2022 07:44:46 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3921E3F5A1;
        Thu, 28 Apr 2022 07:44:42 -0700 (PDT)
Message-ID: <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
Date:   Thu, 28 Apr 2022 15:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-GB
To:     Tianyu Lan <ltykernel@gmail.com>, hch@infradead.org,
        m.szyprowski@samsung.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com
Cc:     parri.andrea@gmail.com, thomas.lendacky@amd.com,
        wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@intel.com,
        iommu@lists.linux-foundation.org, andi.kleen@intel.com,
        brijesh.singh@amd.com, vkuznets@redhat.com, hch@lst.de
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220428141429.1637028-2-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2022-04-28 15:14, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Traditionally swiotlb was not performance critical because it was only
> used for slow devices. But in some setups, like TDX/SEV confidential
> guests, all IO has to go through swiotlb. Currently swiotlb only has a
> single lock. Under high IO load with multiple CPUs this can lead to
> significat lock contention on the swiotlb lock.
> 
> This patch splits the swiotlb into individual areas which have their
> own lock. When there are swiotlb map/allocate request, allocate
> io tlb buffer from areas averagely and free the allocation back
> to the associated area. This is to prepare to resolve the overhead
> of single spinlock among device's queues. Per device may have its
> own io tlb mem and bounce buffer pool.
> 
> This idea from Andi Kleen patch(https://github.com/intel/tdx/commit/4529b578
> 4c141782c72ec9bd9a92df2b68cb7d45). Rework it and make it may work
> for individual device's io tlb mem. The device driver may determine
> area number according to device queue number.

Rather than introduce this extra level of allocator complexity, how 
about just dividing up the initial SWIOTLB allocation into multiple 
io_tlb_mem instances?

Robin.

> Based-on-idea-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>   include/linux/swiotlb.h |  25 ++++++
>   kernel/dma/swiotlb.c    | 173 +++++++++++++++++++++++++++++++---------
>   2 files changed, 162 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 7ed35dd3de6e..489c249da434 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -62,6 +62,24 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
>   #ifdef CONFIG_SWIOTLB
>   extern enum swiotlb_force swiotlb_force;
>   
> +/**
> + * struct io_tlb_area - IO TLB memory area descriptor
> + *
> + * This is a single area with a single lock.
> + *
> + * @used:	The number of used IO TLB block.
> + * @area_index: The index of to tlb area.
> + * @index:	The slot index to start searching in this area for next round.
> + * @lock:	The lock to protect the above data structures in the map and
> + *		unmap calls.
> + */
> +struct io_tlb_area {
> +	unsigned long used;
> +	unsigned int area_index;
> +	unsigned int index;
> +	spinlock_t lock;
> +};
> +
>   /**
>    * struct io_tlb_mem - IO TLB Memory Pool Descriptor
>    *
> @@ -89,6 +107,9 @@ extern enum swiotlb_force swiotlb_force;
>    * @late_alloc:	%true if allocated using the page allocator
>    * @force_bounce: %true if swiotlb bouncing is forced
>    * @for_alloc:  %true if the pool is used for memory allocation
> + * @num_areas:  The area number in the pool.
> + * @area_start: The area index to start searching in the next round.
> + * @area_nslabs: The slot number in the area.
>    */
>   struct io_tlb_mem {
>   	phys_addr_t start;
> @@ -102,6 +123,10 @@ struct io_tlb_mem {
>   	bool late_alloc;
>   	bool force_bounce;
>   	bool for_alloc;
> +	unsigned int num_areas;
> +	unsigned int area_start;
> +	unsigned int area_nslabs;
> +	struct io_tlb_area *areas;
>   	struct io_tlb_slot {
>   		phys_addr_t orig_addr;
>   		size_t alloc_size;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index e2ef0864eb1e..00a16f540f20 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -62,6 +62,8 @@
>   
>   #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
>   
> +#define NUM_AREAS_DEFAULT 1
> +
>   static bool swiotlb_force_bounce;
>   static bool swiotlb_force_disable;
>   
> @@ -70,6 +72,25 @@ struct io_tlb_mem io_tlb_default_mem;
>   phys_addr_t swiotlb_unencrypted_base;
>   
>   static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
> +static unsigned long default_area_num = NUM_AREAS_DEFAULT;
> +
> +static int swiotlb_setup_areas(struct io_tlb_mem *mem,
> +		unsigned int num_areas, unsigned long nslabs)
> +{
> +	if (nslabs < 1 || !is_power_of_2(num_areas)) {
> +		pr_err("swiotlb: Invalid areas parameter %d.\n", num_areas);
> +		return -EINVAL;
> +	}
> +
> +	/* Round up number of slabs to the next power of 2.
> +	 * The last area is going be smaller than the rest if default_nslabs is
> +	 * not power of two.
> +	 */
> +	mem->area_start = 0;
> +	mem->num_areas = num_areas;
> +	mem->area_nslabs = nslabs / num_areas;
> +	return 0;
> +}
>   
>   static int __init
>   setup_io_tlb_npages(char *str)
> @@ -114,6 +135,8 @@ void __init swiotlb_adjust_size(unsigned long size)
>   		return;
>   	size = ALIGN(size, IO_TLB_SIZE);
>   	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
> +	swiotlb_setup_areas(&io_tlb_default_mem, default_area_num,
> +			    default_nslabs);
>   	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
>   }
>   
> @@ -195,7 +218,8 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>   				    unsigned long nslabs, bool late_alloc)
>   {
>   	void *vaddr = phys_to_virt(start);
> -	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
> +	unsigned long bytes = nslabs << IO_TLB_SHIFT, i, j;
> +	unsigned int block_list;
>   
>   	mem->nslabs = nslabs;
>   	mem->start = start;
> @@ -206,8 +230,13 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>   	if (swiotlb_force_bounce)
>   		mem->force_bounce = true;
>   
> -	spin_lock_init(&mem->lock);
> -	for (i = 0; i < mem->nslabs; i++) {
> +	for (i = 0, j = 0, k = 0; i < mem->nslabs; i++) {
> +		if (!(i % mem->area_nslabs)) {
> +			mem->areas[j].index = 0;
> +			spin_lock_init(&mem->areas[j].lock);
> +			j++;
> +		}
> +
>   		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
>   		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
>   		mem->slots[i].alloc_size = 0;
> @@ -272,6 +301,13 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>   		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
>   		      __func__, alloc_size, PAGE_SIZE);
>   
> +	swiotlb_setup_areas(&io_tlb_default_mem, default_area_num,
> +		    default_nslabs);
> +	mem->areas = memblock_alloc(sizeof(struct io_tlb_area) * mem->num_areas,
> +			    SMP_CACHE_BYTES);
> +	if (!mem->areas)
> +		panic("%s: Failed to allocate mem->areas.\n", __func__);
> +
>   	swiotlb_init_io_tlb_mem(mem, __pa(tlb), default_nslabs, false);
>   	mem->force_bounce = flags & SWIOTLB_FORCE;
>   
> @@ -296,7 +332,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>   	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
>   	unsigned long bytes;
>   	unsigned char *vstart = NULL;
> -	unsigned int order;
> +	unsigned int order, area_order;
>   	int rc = 0;
>   
>   	if (swiotlb_force_disable)
> @@ -334,18 +370,32 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>   		goto retry;
>   	}
>   
> +	swiotlb_setup_areas(&io_tlb_default_mem, default_area_num,
> +			    nslabs);
> +
> +	area_order = get_order(array_size(sizeof(*mem->areas),
> +		default_area_num));
> +	mem->areas = (struct io_tlb_area *)
> +		__get_free_pages(GFP_KERNEL | __GFP_ZERO, area_order);
> +	if (!mem->areas)
> +		goto error_area;
> +
>   	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>   		get_order(array_size(sizeof(*mem->slots), nslabs)));
> -	if (!mem->slots) {
> -		free_pages((unsigned long)vstart, order);
> -		return -ENOMEM;
> -	}
> +	if (!mem->slots)
> +		goto error_slots;
>   
>   	set_memory_decrypted((unsigned long)vstart, bytes >> PAGE_SHIFT);
>   	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, true);
>   
>   	swiotlb_print_info();
>   	return 0;
> +
> +error_slots:
> +	free_pages((unsigned long)mem->areas, area_order);
> +error_area:
> +	free_pages((unsigned long)vstart, order);
> +	return -ENOMEM;
>   }
>   
>   void __init swiotlb_exit(void)
> @@ -353,6 +403,7 @@ void __init swiotlb_exit(void)
>   	struct io_tlb_mem *mem = &io_tlb_default_mem;
>   	unsigned long tbl_vaddr;
>   	size_t tbl_size, slots_size;
> +	unsigned int area_order;
>   
>   	if (swiotlb_force_bounce)
>   		return;
> @@ -367,9 +418,14 @@ void __init swiotlb_exit(void)
>   
>   	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
>   	if (mem->late_alloc) {
> +		area_order = get_order(array_size(sizeof(*mem->areas),
> +			mem->num_areas));
> +		free_pages((unsigned long)mem->areas, area_order);
>   		free_pages(tbl_vaddr, get_order(tbl_size));
>   		free_pages((unsigned long)mem->slots, get_order(slots_size));
>   	} else {
> +		memblock_free_late(__pa(mem->areas),
> +				   mem->num_areas * sizeof(struct io_tlb_area));
>   		memblock_free_late(mem->start, tbl_size);
>   		memblock_free_late(__pa(mem->slots), slots_size);
>   	}
> @@ -472,9 +528,9 @@ static inline unsigned long get_max_slots(unsigned long boundary_mask)
>   	return nr_slots(boundary_mask + 1);
>   }
>   
> -static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
> +static unsigned int wrap_area_index(struct io_tlb_mem *mem, unsigned int index)
>   {
> -	if (index >= mem->nslabs)
> +	if (index >= mem->area_nslabs)
>   		return 0;
>   	return index;
>   }
> @@ -483,10 +539,13 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
>    * Find a suitable number of IO TLB entries size that will fit this request and
>    * allocate a buffer from that IO TLB pool.
>    */
> -static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
> -			      size_t alloc_size, unsigned int alloc_align_mask)
> +static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
> +				 struct io_tlb_area *area,
> +				 int area_index,
> +				 struct device *dev, phys_addr_t orig_addr,
> +				 size_t alloc_size,
> +				 unsigned int alloc_align_mask)
>   {
> -	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>   	unsigned long boundary_mask = dma_get_seg_boundary(dev);
>   	dma_addr_t tbl_dma_addr =
>   		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
> @@ -497,8 +556,11 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>   	unsigned int index, wrap, count = 0, i;
>   	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>   	unsigned long flags;
> +	unsigned int slot_base;
> +	unsigned int slot_index;
>   
>   	BUG_ON(!nslots);
> +	BUG_ON(area_index >= mem->num_areas);
>   
>   	/*
>   	 * For mappings with an alignment requirement don't bother looping to
> @@ -510,16 +572,20 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>   		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
>   	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
>   
> -	spin_lock_irqsave(&mem->lock, flags);
> -	if (unlikely(nslots > mem->nslabs - mem->used))
> +	spin_lock_irqsave(&area->lock, flags);
> +	if (unlikely(nslots > mem->area_nslabs - area->used))
>   		goto not_found;
>   
> -	index = wrap = wrap_index(mem, ALIGN(mem->index, stride));
> +	slot_base = area_index * mem->area_nslabs;
> +	index = wrap = wrap_area_index(mem, ALIGN(area->index, stride));
> +
>   	do {
> +		slot_index = slot_base + index;
> +
>   		if (orig_addr &&
> -		    (slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=
> -			    (orig_addr & iotlb_align_mask)) {
> -			index = wrap_index(mem, index + 1);
> +		    (slot_addr(tbl_dma_addr, slot_index) &
> +		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
> +			index = wrap_area_index(mem, index + 1);
>   			continue;
>   		}
>   
> @@ -528,26 +594,26 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>   		 * contiguous buffers, we allocate the buffers from that slot
>   		 * and mark the entries as '0' indicating unavailable.
>   		 */
> -		if (!iommu_is_span_boundary(index, nslots,
> +		if (!iommu_is_span_boundary(slot_index, nslots,
>   					    nr_slots(tbl_dma_addr),
>   					    max_slots)) {
> -			if (mem->slots[index].list >= nslots)
> +			if (mem->slots[slot_index].list >= nslots)
>   				goto found;
>   		}
> -		index = wrap_index(mem, index + stride);
> +		index = wrap_area_index(mem, index + stride);
>   	} while (index != wrap);
>   
>   not_found:
> -	spin_unlock_irqrestore(&mem->lock, flags);
> +	spin_unlock_irqrestore(&area->lock, flags);
>   	return -1;
>   
>   found:
> -	for (i = index; i < index + nslots; i++) {
> +	for (i = slot_index; i < slot_index + nslots; i++) {
>   		mem->slots[i].list = 0;
>   		mem->slots[i].alloc_size =
> -			alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
> +			alloc_size - (offset + ((i - slot_index) << IO_TLB_SHIFT));
>   	}
> -	for (i = index - 1;
> +	for (i = slot_index - 1;
>   	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
>   	     mem->slots[i].list; i--)
>   		mem->slots[i].list = ++count;
> @@ -555,14 +621,45 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>   	/*
>   	 * Update the indices to avoid searching in the next round.
>   	 */
> -	if (index + nslots < mem->nslabs)
> -		mem->index = index + nslots;
> +	if (index + nslots < mem->area_nslabs)
> +		area->index = index + nslots;
>   	else
> -		mem->index = 0;
> -	mem->used += nslots;
> +		area->index = 0;
> +	area->used += nslots;
> +	spin_unlock_irqrestore(&area->lock, flags);
> +	return slot_index;
> +}
>   
> -	spin_unlock_irqrestore(&mem->lock, flags);
> -	return index;
> +static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
> +			      size_t alloc_size, unsigned int alloc_align_mask)
> +{
> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +	int start, i, index;
> +
> +	i = start = mem->area_start;
> +	mem->area_start = (mem->area_start + 1) % mem->num_areas;
> +
> +	do {
> +		index = swiotlb_do_find_slots(mem, mem->areas + i, i,
> +					      dev, orig_addr, alloc_size,
> +					      alloc_align_mask);
> +		if (index >= 0)
> +			return index;
> +		if (++i >= mem->num_areas)
> +			i = 0;
> +	} while (i != start);
> +
> +	return -1;
> +}
> +
> +static unsigned long mem_used(struct io_tlb_mem *mem)
> +{
> +	int i;
> +	unsigned long used = 0;
> +
> +	for (i = 0; i < mem->num_areas; i++)
> +		used += mem->areas[i].used;
> +	return used;
>   }
>   
>   phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> @@ -594,7 +691,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   		if (!(attrs & DMA_ATTR_NO_WARN))
>   			dev_warn_ratelimited(dev,
>   	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
> -				 alloc_size, mem->nslabs, mem->used);
> +				 alloc_size, mem->nslabs, mem_used(mem));
>   		return (phys_addr_t)DMA_MAPPING_ERROR;
>   	}
>   
> @@ -624,6 +721,8 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
>   	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
>   	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
>   	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
> +	int aindex = index / mem->area_nslabs;
> +	struct io_tlb_area *area = &mem->areas[aindex];
>   	int count, i;
>   
>   	/*
> @@ -632,7 +731,9 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
>   	 * While returning the entries to the free list, we merge the entries
>   	 * with slots below and above the pool being returned.
>   	 */
> -	spin_lock_irqsave(&mem->lock, flags);
> +	BUG_ON(aindex >= mem->num_areas);
> +
> +	spin_lock_irqsave(&area->lock, flags);
>   	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
>   		count = mem->slots[index + nslots].list;
>   	else
> @@ -656,8 +757,8 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
>   	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 && mem->slots[i].list;
>   	     i--)
>   		mem->slots[i].list = ++count;
> -	mem->used -= nslots;
> -	spin_unlock_irqrestore(&mem->lock, flags);
> +	area->used -= nslots;
> +	spin_unlock_irqrestore(&area->lock, flags);
>   }
>   
>   /*
