Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A19522154
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 May 2022 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbiEJQiM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 May 2022 12:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiEJQiJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 May 2022 12:38:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EACE2A28CD;
        Tue, 10 May 2022 09:34:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 575CC12FC;
        Tue, 10 May 2022 09:34:10 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25D593F73D;
        Tue, 10 May 2022 09:34:06 -0700 (PDT)
Message-ID: <cd64adcd-26fc-0452-754d-7ab0f5536142@arm.com>
Date:   Tue, 10 May 2022 17:33:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] swiotlb: Max mapping size takes min align mask into
 account
Content-Language: en-GB
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hch@infradead.org,
        m.szyprowski@samsung.com, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        vkuznets@redhat.com, konrad.wilk@oracle.com, hch@lst.de,
        parri.andrea@gmail.com, thomas.lendacky@amd.com
References: <20220510142109.777738-1-ltykernel@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220510142109.777738-1-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2022-05-10 15:21, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> swiotlb_find_slots() skips slots according to io tlb aligned mask
> calculated from min aligned mask and original physical address
> offset. This affects max mapping size. The mapping size can't
> achieve the IO_TLB_SEGSIZE * IO_TLB_SIZE when original offset is
> non-zero. This will cause system boot up failure in Hyper-V
> Isolation VM where swiotlb force is enabled. Scsi layer use return
> value of dma_max_mapping_size() to set max segment size and it
> finally calls swiotlb_max_mapping_size(). Hyper-V storage driver
> sets min align mask to 4k - 1. Scsi layer may pass 256k length of
> request buffer with 0~4k offset and Hyper-V storage driver can't
> get swiotlb bounce buffer via DMA API. Swiotlb_find_slots() can't
> find 256k length bounce buffer with offset. Make swiotlb_max_mapping
> _size() take min align mask into account.

Hmm, this seems a bit pessimistic - the offset can vary per mapping, so 
it feels to me like it should really be the caller's responsibility to 
account for it if they're already involved enough to care about both 
constraints. But I'm not sure how practical that would be.

Robin.

> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>   kernel/dma/swiotlb.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 73a41cec9e38..0d6684ca7eab 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -743,7 +743,18 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
>   
>   size_t swiotlb_max_mapping_size(struct device *dev)
>   {
> -	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
> +	int min_align_mask = dma_get_min_align_mask(dev);
> +	int min_align = 0;
> +
> +	/*
> +	 * swiotlb_find_slots() skips slots according to
> +	 * min align mask. This affects max mapping size.
> +	 * Take it into acount here.
> +	 */
> +	if (min_align_mask)
> +		min_align = roundup(min_align_mask, IO_TLB_SIZE);
> +
> +	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE - min_align;
>   }
>   
>   bool is_swiotlb_active(struct device *dev)
