Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D124513953
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 18:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349781AbiD1QFo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 12:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349786AbiD1QFl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 12:05:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEEC5BD09;
        Thu, 28 Apr 2022 09:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651161747; x=1682697747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dtS2kF8FdLLSnqYyxKV7E3Bfk2VxTI+riuYpWaXfRcs=;
  b=a3E+hgDcibmP4UPg1XzdeNlXwGK3/+tFZYJaPSz+8TduEg+DOC3k/E+Z
   Xfj+2Rc4RLlWonOfJgGbhN6HTl90Oiml3VkZnELgsWzYfxAG3FMBjqobA
   iLd+5vKPQs8ezxySdtaOFxHElKU9geFnpJfsDfqHbQN4WOictwLroXHGi
   Tr+c5BU20QqtegLPNVnJ7/sC/CgCHb3aZimSrGgpYFGtz2wMsv0GdleQ0
   tKorFA3M5bz36lcuEsiko4JHOs6zLD6wJIU2O9iU1PzId3GvhbVW+PoHg
   TrYco9SZbtmwvqwN31qivARG2soeF2uzy0g/r2hVi/VEqnc6ZCY6eaWUK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="248265570"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="248265570"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 09:02:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="651277756"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.19.92]) ([10.209.19.92])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 09:02:25 -0700
Message-ID: <b3059196-a28b-a509-fc0e-75d2dbebdbae@linux.intel.com>
Date:   Thu, 28 Apr 2022 09:02:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
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
 <aa8e2fab-5b7e-cac3-0fbd-7c6edbbf942a@arm.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <aa8e2fab-5b7e-cac3-0fbd-7c6edbbf942a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 4/28/2022 8:07 AM, Robin Murphy wrote:
> On 2022-04-28 15:55, Andi Kleen wrote:
>>
>> On 4/28/2022 7:45 AM, Christoph Hellwig wrote:
>>> On Thu, Apr 28, 2022 at 03:44:36PM +0100, Robin Murphy wrote:
>>>> Rather than introduce this extra level of allocator complexity, how 
>>>> about
>>>> just dividing up the initial SWIOTLB allocation into multiple 
>>>> io_tlb_mem
>>>> instances?
>>> Yeah.  We're almost done removing all knowledge of swiotlb from 
>>> drivers,
>>> so the very last thing I want is an interface that allows a driver to
>>> allocate a per-device buffer.
>>
>> At least for TDX need parallelism with a single device for performance.
>>
>> So if you split up the io tlb mems for a device then you would need a 
>> new mechanism to load balance the requests for single device over 
>> those. I doubt it would be any simpler.
>
> Eh, I think it would be, since the round-robin retry loop can then 
> just sit around the existing io_tlb_mem-based allocator, vs. the churn 
> of inserting it in the middle, plus it's then really easy to 
> statically distribute different starting points across different 
> devices via dev->dma_io_tlb_mem if we wanted to.
>
> Admittedly the overall patch probably ends up about the same size, 
> since it likely pushes a bit more complexity into swiotlb_init to 
> compensate, but that's still a trade-off I like.

Unless you completely break the external API this will require a new 
mechanism to search a list of io_tlb_mems for the right area to free into.

If the memory area not contiguous (like in the original patch) this will 
be a O(n) operation on the number of io_tlb_mems, so it would get more 
and more expensive on larger systems. Or you merge them all together (so 
that the simple address arithmetic to look up the area works again), 
which will require even more changes in the setup. Or you add hashing or 
similar which will be even more complicated.

In the end doing it with a single io_tlb_mem is significantly simpler 
and also more natural.

-Andi


