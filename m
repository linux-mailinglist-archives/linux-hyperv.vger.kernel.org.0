Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF65137CB
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 17:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348708AbiD1PLO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiD1PLN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 11:11:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A217522F8;
        Thu, 28 Apr 2022 08:07:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3375A1474;
        Thu, 28 Apr 2022 08:07:58 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9725C3F774;
        Thu, 28 Apr 2022 08:07:54 -0700 (PDT)
Message-ID: <aa8e2fab-5b7e-cac3-0fbd-7c6edbbf942a@arm.com>
Date:   Thu, 28 Apr 2022 16:07:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-GB
To:     Andi Kleen <ak@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Tianyu Lan <ltykernel@gmail.com>, m.szyprowski@samsung.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        parri.andrea@gmail.com, thomas.lendacky@amd.com,
        wei.liu@kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@intel.com,
        iommu@lists.linux-foundation.org, andi.kleen@intel.com,
        brijesh.singh@amd.com, vkuznets@redhat.com, hch@lst.de
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
 <YmqonHKBT8ftYHgY@infradead.org>
 <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2022-04-28 15:55, Andi Kleen wrote:
> 
> On 4/28/2022 7:45 AM, Christoph Hellwig wrote:
>> On Thu, Apr 28, 2022 at 03:44:36PM +0100, Robin Murphy wrote:
>>> Rather than introduce this extra level of allocator complexity, how 
>>> about
>>> just dividing up the initial SWIOTLB allocation into multiple io_tlb_mem
>>> instances?
>> Yeah.  We're almost done removing all knowledge of swiotlb from drivers,
>> so the very last thing I want is an interface that allows a driver to
>> allocate a per-device buffer.
> 
> At least for TDX need parallelism with a single device for performance.
> 
> So if you split up the io tlb mems for a device then you would need a 
> new mechanism to load balance the requests for single device over those. 
> I doubt it would be any simpler.

Eh, I think it would be, since the round-robin retry loop can then just 
sit around the existing io_tlb_mem-based allocator, vs. the churn of 
inserting it in the middle, plus it's then really easy to statically 
distribute different starting points across different devices via 
dev->dma_io_tlb_mem if we wanted to.

Admittedly the overall patch probably ends up about the same size, since 
it likely pushes a bit more complexity into swiotlb_init to compensate, 
but that's still a trade-off I like.

Thanks,
Robin.
