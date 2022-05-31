Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98700538BDF
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 May 2022 09:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbiEaHQv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 May 2022 03:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiEaHQu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 May 2022 03:16:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B0433AD;
        Tue, 31 May 2022 00:16:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 42FE068B05; Tue, 31 May 2022 09:16:40 +0200 (CEST)
Date:   Tue, 31 May 2022 09:16:39 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Tianyu Lan <ltykernel@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "andi.kleen@intel.com" <andi.kleen@intel.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        KY Srinivasan <kys@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kirill.shutemov" <kirill.shutemov@intel.com>
Subject: Re: [RFC PATCH V2 1/2] swiotlb: Add Child IO TLB mem support
Message-ID: <20220531071639.GA23482@lst.de>
References: <20220502125436.23607-1-ltykernel@gmail.com> <20220502125436.23607-2-ltykernel@gmail.com> <YoH+mbxQAp/2XGyG@infradead.org> <PH0PR21MB30258D2B3B727A9BCEE039FCD7DD9@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB30258D2B3B727A9BCEE039FCD7DD9@PH0PR21MB3025.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 30, 2022 at 01:52:37AM +0000, Michael Kelley (LINUX) wrote:
> B) The contents of the memory buffer must transition between
> encrypted and not encrypted.  The hardware doesn't provide
> any mechanism to do such a transition "in place".  The only
> way to transition is for the CPU to copy the contents between
> an encrypted area and an unencrypted area of memory.
> 
> Because of (B), we're stuck needing bounce buffers.  There's no
> way to avoid them with the current hardware.  Tianyu also pointed
> out not wanting to expose uninitialized guest memory to the host,
> so, for example, sharing a read buffer with the host requires that
> it first be initialized to zero.

Ok, B is a deal breaker.  I just brought this in because I've received
review comments that state bouncing is just the easiest option for
now and we could map it into the hypervisor in the future.  But at
least for SEV that does not seem like an option without hardware
changes.

> We should reset and make sure we agree on the top-level approach.
> 1) We want general scalability improvements to swiotlb.  These
>     improvements should scale to high CPUs counts (> 100) and for
>     multiple NUMA nodes.
> 2) Drivers should not require any special knowledge of swiotlb to
>     benefit from the improvements.  No new swiotlb APIs should be
>     need to be used by drivers -- the swiotlb scalability improvements
>     should be transparent.
> 3) The scalability improvements should not be based on device
>     boundaries since a single device may have multiple channels
>     doing bounce buffering on multiple CPUs in parallel.

Agreed to all counts.

> The patch from Andi Kleen [3] (not submitted upstream, but referenced
> by Tianyu as the basis for his patches) seems like a good starting point
> for meeting the top-level approach.

Yes, I think doing per-cpu and/or per-node scaling sounds like the
right general approach. Why was this never sent out?

> Andi and Robin had some
> back-and-forth about Andi's patch that I haven't delved into yet, but
> getting that worked out seems like a better overall approach.  I had
> an offline chat with Tianyu, and he would agree as well.

Where was this discussion?
