Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE31632E2A
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Nov 2022 21:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKUUsz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Nov 2022 15:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKUUsy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Nov 2022 15:48:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89572C9A87;
        Mon, 21 Nov 2022 12:48:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D0AD1FB;
        Mon, 21 Nov 2022 12:48:59 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB3B73F73B;
        Mon, 21 Nov 2022 12:48:51 -0800 (PST)
Message-ID: <671bc0d5-2c14-32ea-2a37-e15c8a0621ff@arm.com>
Date:   Mon, 21 Nov 2022 20:48:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] swiotlb: check set_memory_decrypted()'s return value
Content-Language: en-GB
To:     Dexuan Cui <decui@microsoft.com>, hch@lst.de,
        m.szyprowski@samsung.com, iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20221121194839.21722-1-decui@microsoft.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221121194839.21722-1-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2022-11-21 19:48, Dexuan Cui wrote:
> swiotlb_update_mem_attributes() is called from a system where decrypted
> swiotlb bounce buffers are required. Panic the system if
> set_memory_decrypted() fails.
> 
> When rmem_swiotlb_device_init() -> set_memory_decrypted(), let's try
> to handle it gracefully.
> 
> Not sure how to handle the failure in swiotlb_init_late(). Add a WARN().
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>   kernel/dma/swiotlb.c | 42 +++++++++++++++++++++++++++++-------------
>   1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 339a990554e7..8e26c09c625c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -248,12 +248,16 @@ void __init swiotlb_update_mem_attributes(void)
>   	struct io_tlb_mem *mem = &io_tlb_default_mem;
>   	void *vaddr;
>   	unsigned long bytes;
> +	int rc;
>   
>   	if (!mem->nslabs || mem->late_alloc)
>   		return;
>   	vaddr = phys_to_virt(mem->start);
>   	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
> -	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
> +
> +	rc = set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
> +	if (rc)
> +		panic("Failed to decrypt swiotlb bounce buffers (%d)\n", rc);

Aww, I just cleaned up all the panics! AFAICS we could warn and set 
mem->nslabs to 0 here to semi-gracefully disable SWIOTLB (presumably 
decryption failure is sufficiently unexpected that "leaking" the SWIOTLB 
memory is the least of the system's problems). Or indeed just warn and 
do nothing as in the swiotlb_init_late() case below - what's with the 
inconsistency? In either path we have the same expectation that 
decryption succeeds (or does nothing, successfully), so failure is no 
more or less fatal to later SWIOTLB operation depending on when the 
architecture chose to set it up.

>   	mem->vaddr = swiotlb_mem_remap(mem, bytes);
>   	if (!mem->vaddr)
> @@ -447,8 +451,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>   	if (!mem->slots)
>   		goto error_slots;
>   
> -	set_memory_decrypted((unsigned long)vstart,
> -			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> +	rc = set_memory_decrypted((unsigned long)vstart,
> +				  (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> +	WARN(rc, "Failed to decrypt swiotlb bounce buffers (%d)\n", rc);
> +
>   	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, 0, true,
>   				default_nareas);
>   
> @@ -986,6 +992,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>   
>   	/* Set Per-device io tlb area to one */
>   	unsigned int nareas = 1;
> +	int rc = -ENOMEM;
>   
>   	/*
>   	 * Since multiple devices can share the same pool, the private data,
> @@ -998,21 +1005,22 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>   			return -ENOMEM;
>   
>   		mem->slots = kcalloc(nslabs, sizeof(*mem->slots), GFP_KERNEL);
> -		if (!mem->slots) {
> -			kfree(mem);
> -			return -ENOMEM;
> -		}
> +		if (!mem->slots)
> +			goto free_mem;
>   
>   		mem->areas = kcalloc(nareas, sizeof(*mem->areas),
>   				GFP_KERNEL);
> -		if (!mem->areas) {
> -			kfree(mem->slots);
> -			kfree(mem);
> -			return -ENOMEM;
> +		if (!mem->areas)
> +			goto free_slots;
> +
> +		rc = set_memory_decrypted(
> +				(unsigned long)phys_to_virt(rmem->base),
> +				rmem->size >> PAGE_SHIFT);
> +		if (rc) {
> +			pr_err("Failed to decrypt rmem buffer (%d)\n", rc);
> +			goto free_areas;

So in 3 init paths we have 3 different outcomes from the same thing :(

1: make the whole system unusable
2: continue with possible data corruption (or at least weird DMA errors) 
if devices still see encrypted memory contents
3: cleanly disable SWIOTLB, thus also all subsequent attempts to use it

(OK, for the rmem case this isn't actually 3 since falling back to 
io_tlb_default_mem might work out more like 2, but hopefully you get my 
point)

Thanks,
Robin.

>   		}
>   
> -		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> -				     rmem->size >> PAGE_SHIFT);
>   		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, SWIOTLB_FORCE,
>   					false, nareas);
>   		mem->for_alloc = true;
> @@ -1025,6 +1033,14 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>   	dev->dma_io_tlb_mem = mem;
>   
>   	return 0;
> +
> +free_areas:
> +	kfree(mem->areas);
> +free_slots:
> +	kfree(mem->slots);
> +free_mem:
> +	kfree(mem);
> +	return rc;
>   }
>   
>   static void rmem_swiotlb_device_release(struct reserved_mem *rmem,
