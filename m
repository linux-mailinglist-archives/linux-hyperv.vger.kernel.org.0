Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6662557625
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jun 2022 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiFWJBn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jun 2022 05:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiFWJBm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jun 2022 05:01:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4298246B10;
        Thu, 23 Jun 2022 02:01:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB85912FC;
        Thu, 23 Jun 2022 02:01:40 -0700 (PDT)
Received: from [10.57.85.4] (unknown [10.57.85.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 383EF3F792;
        Thu, 23 Jun 2022 02:01:39 -0700 (PDT)
Message-ID: <59c365d8-4b76-4e57-794b-e1d4b3f0e2a5@arm.com>
Date:   Thu, 23 Jun 2022 10:01:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dma-direct: use the correct size for dma_set_encrypted()
Content-Language: en-GB
To:     Dexuan Cui <decui@microsoft.com>, Christoph Hellwig <hch@lst.de>
Cc:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Andrea Parri <Andrea.Parri@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
References: <20220622191424.15777-1-decui@microsoft.com>
 <20220623054352.GA12543@lst.de>
 <SN6PR2101MB132705E084BCC12BCDDF4E7FBFB59@SN6PR2101MB1327.namprd21.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SN6PR2101MB132705E084BCC12BCDDF4E7FBFB59@SN6PR2101MB1327.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2022-06-23 08:00, Dexuan Cui wrote:
>> From: Christoph Hellwig <hch@lst.de>
>> Sent: Wednesday, June 22, 2022 10:44 PM
>> To: Dexuan Cui <decui@microsoft.com>
>>   ...
>> On Wed, Jun 22, 2022 at 12:14:24PM -0700, Dexuan Cui wrote:
>>> The third parameter of dma_set_encrypted() is a size in bytes rather than
>>> the number of pages.
>>>
>>> Fixes: 4d0564785bb0 ("dma-direct: factor out dma_set_{de,en}crypted
>> helpers")
>>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>>
>> see:
>>
>> commit 4a37f3dd9a83186cb88d44808ab35b78375082c9 (tag:
>> dma-mapping-5.19-2022-05-25)
>> Author: Robin Murphy <robin.murphy@arm.com>
>> Date:   Fri May 20 18:10:13 2022 +0100
>>
>>      dma-direct: don't over-decrypt memory
> 
> It looks like commit 4a37f3dd9a831 fixed a different issue?
> 
> Here my patch is for the latest mainline:
> 
> In dma_direct_alloc()'s error handling path, we pass 'size' to dma_set_encrypted():
>    out_encrypt_pages:
> 	  if (dma_set_encrypted(dev, page_address(page), size))
> 
> However, in dma_direct_free(), we pass ' 1 << page_order ' to dma_set_encrypted().
> I think the ' 1 << page_order' is incorrect and it should be 'size' as well?

I think technically you're both right - these instances clearly have a 
history tracing back to the original bug that my patch addressed, but 
the refactoring then made them into their own distinct bug in terms of 
the internal dma_set_encrypted() interface, per the commit message here. 
Apparently I failed to spot this when forward-porting 4a37f3dd9a831 from 
5.10 (as the commit message says, don't ask... ;) ) - I guess I was only 
looking at where the set_memory_*() callsites had moved to. For this patch,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks
Robin.
