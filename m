Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D305B6D8E8C
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Apr 2023 06:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjDFEwI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Apr 2023 00:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjDFEwG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Apr 2023 00:52:06 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2868E7AA4;
        Wed,  5 Apr 2023 21:52:05 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1131)
        id 88284210DEFC; Wed,  5 Apr 2023 21:52:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88284210DEFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680756724;
        bh=mdW5uItNtDtJNCgm+oI/5HO2zGI9+DE/FTkk+TWdNw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZSIGp3aFHSy/LkqaHbMeb+lvu332Pe0GbceJCQHppGXx5ByltR5byJQoDZjeDcxN
         PRuTDtTB5Ex8gCKqzqqNZwUuXWi1SGHtZW/HYbS5qbpa1W7qgJ45my6iDznDBBE2KF
         IonL4kHtP1THeXLQbxfFK1qj74n1EHnV3/2+0ojM=
Date:   Wed, 5 Apr 2023 21:52:04 -0700
From:   Kelsey Steele <kelseysteele@linux.microsoft.com>
To:     Petr Tesa????k <petr@tesarici.cz>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jianxiong Gao <jxgao@google.com>,
        David Stevens <stevensd@chromium.org>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
Message-ID: <20230406045204.GA20027@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
 <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
 <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
 <CO1PR21MB13320305E02BA121623213DABF939@CO1PR21MB1332.namprd21.prod.outlook.com>
 <20230405064019.6258ebb3@meshulam.tesarici.cz>
 <SA1PR21MB1335C5F774195F2C3431BF93BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20230405072801.05bb94ef@meshulam.tesarici.cz>
 <20230405075034.3c36bb77@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405075034.3c36bb77@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 05, 2023 at 07:50:34AM +0200, Petr Tesa????k wrote:
> On Wed, 5 Apr 2023 07:32:06 +0200
> Petr Tesa????k <petr@tesarici.cz> wrote:
> 
> > On Wed, 5 Apr 2023 05:11:42 +0000
> > Dexuan Cui <decui@microsoft.com> wrote:
> > 
> > > > From: Petr Tesa????k <petr@tesarici.cz>
> > > > Sent: Tuesday, April 4, 2023 9:40 PM    
> > > > > > ...
> > > > > > Hi Petr, this patch has gone into the mainline:
> > > > > > 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> > > > > >
> > > > > > Somehow it breaks Linux VMs on Hyper-V: a regular VM with
> > > > > > swiotlb=force or a confidential VM (which uses swiotlb) fails to boot.
> > > > > > If I revert this patch, everything works fine.  
> > > > >
> > > > > The log is pasted below. Looks like the SCSI driver hv_storvsc fails to
> > > > > detect the disk capacity:    
> > > > 
> > > > The first thing I can imagine is that there are in fact no (free) slots
> > > > in the SWIOTLB which match the alignment constraints, so the map
> > > > operation fails. However, this would result in a "swiotlb buffer is
> > > > full" message in the log, and I can see no such message in the log
> > > > excerpt you have posted.
> > > > 
> > > > Please, can you check if there are any "swiotlb" messages preceding the
> > > > first error message?
> > > > 
> > > > Petr T    
> > > 
> > > There is no "swiotlb buffer is full" error.
> > > 
> > > The hv_storvsc driver (drivers/scsi/storvsc_drv.c) calls scsi_dma_map(),
> > > which doesn't return -ENOMEM when the failure happens.  
> > 
> > I see...
> > 
> > Argh, you're right. This is a braino. The alignment mask is in fact an
> > INVERTED mask, i.e. it masks off bits that are not relevant for the
> > alignment. The more strict alignment needed the more bits must be set,
> > so the individual alignment constraints must be combined with an OR
> > instead of an AND.
> > 
> > Can you apply the following change and check if it fixes the issue?
> 
> Actually, this will not work either. The mask is used to mask off both
> high address bits and low address bits (below swiotlb slot granularity).
> 
> What should help is this:
>

Hi Petr, 

The suggested fix on this patch boots for me and initially looks ok,
though when I start to use git commands I get flooded with "swiotlb
buffer is full" messages and my session becomes unusable. This is on WSL
which uses Hyper-V.

I noticed today these same warnings appear when I build kernels while
running a 6.1 kernel (i.e. 6.1.21). I couldn't reproduce these messages
on a 5.15 kernel and before applying this patch, I've only been able to
get the "swiotlb buffer is full" messages to appear during the kernel
builds and there's a slight delay caused.. I haven't had a chance to bisect
yet to find out more. Should a working version of this patch help to
resolve the warnings vs adding more or should I be looking elsewhere? I
included a small chunk of my log below.

Please let me know if there's anything else I can supply to help out. I
appreciate your time and help!

-Kelsey


[  123.951630] hv_storvsc fd1d2cbd-ce7c-535c-966b-eb5f811c95f0: swiotlb
buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)
[  128.451717] swiotlb_tbl_map_single: 74 callbacks suppressed
[  128.451723] hv_storvsc fd1d2cbd-ce7c-535c-966b-eb5f811c95f0: swiotlb
buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)
[  128.511736] hv_storvsc fd1d2cbd-ce7c-535c-966b-eb5f811c95f0: swiotlb
buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)
[  128.571704] hv_storvsc fd1d2cbd-ce7c-535c-966b-eb5f811c95f0: swiotlb
buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)
[  128.631713] hv_storvsc fd1d2cbd-ce7c-535c-966b-eb5f811c95f0: swiotlb
buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)
[  128.691625] hv_storvsc fd1d2cbd-ce7c-535c-966b-eb5f811c95f0: swiotlb
buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)


 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 5b919ef832b6..c924e53d679e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -622,8 +622,7 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
>  	dma_addr_t tbl_dma_addr =
>  		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
>  	unsigned long max_slots = get_max_slots(boundary_mask);
> -	unsigned int iotlb_align_mask =
> -		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> +	unsigned int iotlb_align_mask;
>  	unsigned int nslots = nr_slots(alloc_size), stride;
>  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>  	unsigned int index, slots_checked, count = 0, i;
> @@ -639,8 +638,9 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
>  	 * allocations.
>  	 */
>  	if (alloc_size >= PAGE_SIZE)
> -		iotlb_align_mask &= PAGE_MASK;
> -	iotlb_align_mask &= alloc_align_mask;
> +		iotlb_align_mask |= ~PAGE_MASK;
> +	iotlb_align_mask |= alloc_align_mask | dma_get_min_align_mask(dev);
> +	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
>  
>  	/*
>  	 * For mappings with an alignment requirement don't bother looping to
> 
> Petr T
