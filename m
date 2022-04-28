Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602D9513A8D
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242210AbiD1RCi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 13:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbiD1RCh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 13:02:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D3F6B7C4B;
        Thu, 28 Apr 2022 09:59:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CE991474;
        Thu, 28 Apr 2022 09:59:21 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BA103F774;
        Thu, 28 Apr 2022 09:59:18 -0700 (PDT)
Message-ID: <3686314d-4226-b360-a72d-267af52c8918@arm.com>
Date:   Thu, 28 Apr 2022 17:59:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-GB
To:     Andi Kleen <ak@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     parri.andrea@gmail.com, thomas.lendacky@amd.com,
        wei.liu@kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        konrad.wilk@oracle.com, linux-hyperv@vger.kernel.org,
        Tianyu Lan <ltykernel@gmail.com>, linux-kernel@vger.kernel.org,
        michael.h.kelley@microsoft.com, iommu@lists.linux-foundation.org,
        andi.kleen@intel.com, brijesh.singh@amd.com, vkuznets@redhat.com,
        kys@microsoft.com, kirill.shutemov@intel.com, hch@lst.de
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
 <YmqonHKBT8ftYHgY@infradead.org>
 <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
 <aa8e2fab-5b7e-cac3-0fbd-7c6edbbf942a@arm.com>
 <b3059196-a28b-a509-fc0e-75d2dbebdbae@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <b3059196-a28b-a509-fc0e-75d2dbebdbae@linux.intel.com>
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

On 2022-04-28 17:02, Andi Kleen wrote:
> 
> On 4/28/2022 8:07 AM, Robin Murphy wrote:
>> On 2022-04-28 15:55, Andi Kleen wrote:
>>>
>>> On 4/28/2022 7:45 AM, Christoph Hellwig wrote:
>>>> On Thu, Apr 28, 2022 at 03:44:36PM +0100, Robin Murphy wrote:
>>>>> Rather than introduce this extra level of allocator complexity, how 
>>>>> about
>>>>> just dividing up the initial SWIOTLB allocation into multiple 
>>>>> io_tlb_mem
>>>>> instances?
>>>> Yeah.  We're almost done removing all knowledge of swiotlb from 
>>>> drivers,
>>>> so the very last thing I want is an interface that allows a driver to
>>>> allocate a per-device buffer.
>>>
>>> At least for TDX need parallelism with a single device for performance.
>>>
>>> So if you split up the io tlb mems for a device then you would need a 
>>> new mechanism to load balance the requests for single device over 
>>> those. I doubt it would be any simpler.
>>
>> Eh, I think it would be, since the round-robin retry loop can then 
>> just sit around the existing io_tlb_mem-based allocator, vs. the churn 
>> of inserting it in the middle, plus it's then really easy to 
>> statically distribute different starting points across different 
>> devices via dev->dma_io_tlb_mem if we wanted to.
>>
>> Admittedly the overall patch probably ends up about the same size, 
>> since it likely pushes a bit more complexity into swiotlb_init to 
>> compensate, but that's still a trade-off I like.
> 
> Unless you completely break the external API this will require a new 
> mechanism to search a list of io_tlb_mems for the right area to free into.
> 
> If the memory area not contiguous (like in the original patch) this will 
> be a O(n) operation on the number of io_tlb_mems, so it would get more 
> and more expensive on larger systems. Or you merge them all together (so 
> that the simple address arithmetic to look up the area works again), 
> which will require even more changes in the setup. Or you add hashing or 
> similar which will be even more complicated.
> 
> In the end doing it with a single io_tlb_mem is significantly simpler 
> and also more natural.

Sorry if "dividing up the initial SWIOTLB allocation" somehow sounded 
like "making multiple separate SWIOTLB allocations all over the place"?

I don't see there being any *functional* difference in whether a slice 
of the overall SWIOTLB memory is represented by 
"io_tlb_default_mem->areas[i]->blah" or "io_tlb_default_mem[i]->blah", 
I'm simply advocating for not churning the already-complex allocator 
internals by pushing the new complexity out to the margins instead.

Thanks,
Robin.
