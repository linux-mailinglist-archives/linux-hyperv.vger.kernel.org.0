Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944666DA82D
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Apr 2023 06:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjDGENI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Apr 2023 00:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjDGENG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Apr 2023 00:13:06 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88E1855A6;
        Thu,  6 Apr 2023 21:13:05 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1131)
        id E53BD20B83F9; Thu,  6 Apr 2023 21:13:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E53BD20B83F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680840784;
        bh=S7cYlRUmpxutG5DWPkMCJGfQpuc+T1LziF0NxcTNJKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cl4TcWnkFl4En1BraZZAgTsJnwTM25vRyZGkrb+vgteeLKExFITar9is2gKdzWEYq
         acy/LCOnTA6uuLw3xdB7l0Puz3wpIhGNn2+kKoAK9iJ1D5rUiHdCscw9eklAtnMQKi
         qIMrNJJxyE58hiASuZgy1Xa1FfetFaHxAqACY7CE=
Date:   Thu, 6 Apr 2023 21:13:04 -0700
From:   Kelsey Steele <kelseysteele@linux.microsoft.com>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Petr Tesa????k <petr@tesarici.cz>,
        Dexuan Cui <decui@microsoft.com>,
        Dexuan-Linux Cui <dexuan.linux@gmail.com>,
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
Message-ID: <20230407041304.GA28729@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
 <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
 <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
 <CO1PR21MB13320305E02BA121623213DABF939@CO1PR21MB1332.namprd21.prod.outlook.com>
 <20230405064019.6258ebb3@meshulam.tesarici.cz>
 <SA1PR21MB1335C5F774195F2C3431BF93BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20230405072801.05bb94ef@meshulam.tesarici.cz>
 <20230405075034.3c36bb77@meshulam.tesarici.cz>
 <20230406045204.GA20027@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <15d9dab3-379b-c62c-dd52-a810abe6985d@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15d9dab3-379b-c62c-dd52-a810abe6985d@huaweicloud.com>
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

On Thu, Apr 06, 2023 at 04:42:00PM +0200, Petr Tesarik wrote:
> Hi Kelsey,
> 
> On 4/6/2023 6:52 AM, Kelsey Steele wrote:
> > On Wed, Apr 05, 2023 at 07:50:34AM +0200, Petr Tesa????k wrote:
> >> On Wed, 5 Apr 2023 07:32:06 +0200
> >> Petr Tesa????k <petr@tesarici.cz> wrote:
> >>
> >>> On Wed, 5 Apr 2023 05:11:42 +0000
> >>> Dexuan Cui <decui@microsoft.com> wrote:
> >>>
> >>>>> From: Petr Tesa????k <petr@tesarici.cz>
> >>>>> Sent: Tuesday, April 4, 2023 9:40 PM    
> >>>>>>> ...
> >>>>>>> Hi Petr, this patch has gone into the mainline:
> >>>>>>> 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> >>>>>>>
> >>>>>>> Somehow it breaks Linux VMs on Hyper-V: a regular VM with
> >>>>>>> swiotlb=force or a confidential VM (which uses swiotlb) fails to boot.
> >>>>>>> If I revert this patch, everything works fine.  
> >>>>>>
> >>>>>> The log is pasted below. Looks like the SCSI driver hv_storvsc fails to
> >>>>>> detect the disk capacity:    
> >>>>>
> >>>>> The first thing I can imagine is that there are in fact no (free) slots
> >>>>> in the SWIOTLB which match the alignment constraints, so the map
> >>>>> operation fails. However, this would result in a "swiotlb buffer is
> >>>>> full" message in the log, and I can see no such message in the log
> >>>>> excerpt you have posted.
> >>>>>
> >>>>> Please, can you check if there are any "swiotlb" messages preceding the
> >>>>> first error message?
> >>>>>
> >>>>> Petr T    
> >>>>
> >>>> There is no "swiotlb buffer is full" error.
> >>>>
> >>>> The hv_storvsc driver (drivers/scsi/storvsc_drv.c) calls scsi_dma_map(),
> >>>> which doesn't return -ENOMEM when the failure happens.  
> >>>
> >>> I see...
> >>>
> >>> Argh, you're right. This is a braino. The alignment mask is in fact an
> >>> INVERTED mask, i.e. it masks off bits that are not relevant for the
> >>> alignment. The more strict alignment needed the more bits must be set,
> >>> so the individual alignment constraints must be combined with an OR
> >>> instead of an AND.
> >>>
> >>> Can you apply the following change and check if it fixes the issue?
> >>
> >> Actually, this will not work either. The mask is used to mask off both
> >> high address bits and low address bits (below swiotlb slot granularity).
> >>
> >> What should help is this:
> >>
> > 
> > Hi Petr, 
> > 
> > The suggested fix on this patch boots for me and initially looks ok,
> > though when I start to use git commands I get flooded with "swiotlb
> > buffer is full" messages and my session becomes unusable. This is on WSL
> > which uses Hyper-V.
> 
> Roberto noticed that my initial quick fix left iotlb_align_mask
> uninitialized. As a result, high address bits are set randomly, and if
> they do not match actual swiotlb addresses, allocations may fail with
> "swiotlb buffer is full". I fixed it in the patch that I have just posted.
> 
> HTH
> Petr T

I pulled the patches from dma-mapping after your fix got applied and
everything appears ok and goes back to the way it was; so no other
errors to report. :) Unfortunately still getting the "swiotlb buffer is
full" messages during kernel builds, though that was happening before
your patches hit.

Thanks so much, Petr!

Cheers, 
Kelsey. 
