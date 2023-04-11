Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526CF6DDFE5
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Apr 2023 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDKPqn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Apr 2023 11:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDKPqm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Apr 2023 11:46:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4049EF;
        Tue, 11 Apr 2023 08:46:40 -0700 (PDT)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PwqtZ19r6z67b1p;
        Tue, 11 Apr 2023 23:45:42 +0800 (CST)
Received: from [10.48.147.90] (10.48.147.90) by frapeml500002.china.huawei.com
 (7.182.85.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Apr
 2023 17:46:36 +0200
Message-ID: <7065e2ee-3de4-f54d-04a9-12bfcd3a9481@huawei.com>
Date:   Tue, 11 Apr 2023 17:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
To:     Kelsey Steele <kelseysteele@linux.microsoft.com>
CC:     Petr Tesa????k <petr@tesarici.cz>,
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
 <20230407041304.GA28729@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From:   Petr Tesarik <petr.tesarik.ext@huawei.com>
In-Reply-To: <20230407041304.GA28729@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.147.90]
X-ClientProxiedBy: frapeml500001.china.huawei.com (7.182.85.94) To
 frapeml500002.china.huawei.com (7.182.85.205)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/7/2023 6:13 AM, Kelsey Steele wrote:
> On Thu, Apr 06, 2023 at 04:42:00PM +0200, Petr Tesarik wrote:
>> Hi Kelsey,
>>
>> On 4/6/2023 6:52 AM, Kelsey Steele wrote:
>>> On Wed, Apr 05, 2023 at 07:50:34AM +0200, Petr Tesa????k wrote:
>>>> On Wed, 5 Apr 2023 07:32:06 +0200
>>>> Petr Tesa????k <petr@tesarici.cz> wrote:
>>>>
>>>>> On Wed, 5 Apr 2023 05:11:42 +0000
>>>>> Dexuan Cui <decui@microsoft.com> wrote:
>>>>>
>>>>>>> From: Petr Tesa????k <petr@tesarici.cz>
>>>>>>> Sent: Tuesday, April 4, 2023 9:40 PM    
>>>>>>>>> ...
>>>>>>>>> Hi Petr, this patch has gone into the mainline:
>>>>>>>>> 0eee5ae10256 ("swiotlb: fix slot alignment checks")
>>>>>>>>>
>>>>>>>>> Somehow it breaks Linux VMs on Hyper-V: a regular VM with
>>>>>>>>> swiotlb=force or a confidential VM (which uses swiotlb) fails to boot.
>>>>>>>>> If I revert this patch, everything works fine.  
>>>>>>>>
>>>>>>>> The log is pasted below. Looks like the SCSI driver hv_storvsc fails to
>>>>>>>> detect the disk capacity:    
>>>>>>>
>>>>>>> The first thing I can imagine is that there are in fact no (free) slots
>>>>>>> in the SWIOTLB which match the alignment constraints, so the map
>>>>>>> operation fails. However, this would result in a "swiotlb buffer is
>>>>>>> full" message in the log, and I can see no such message in the log
>>>>>>> excerpt you have posted.
>>>>>>>
>>>>>>> Please, can you check if there are any "swiotlb" messages preceding the
>>>>>>> first error message?
>>>>>>>
>>>>>>> Petr T    
>>>>>>
>>>>>> There is no "swiotlb buffer is full" error.
>>>>>>
>>>>>> The hv_storvsc driver (drivers/scsi/storvsc_drv.c) calls scsi_dma_map(),
>>>>>> which doesn't return -ENOMEM when the failure happens.  
>>>>>
>>>>> I see...
>>>>>
>>>>> Argh, you're right. This is a braino. The alignment mask is in fact an
>>>>> INVERTED mask, i.e. it masks off bits that are not relevant for the
>>>>> alignment. The more strict alignment needed the more bits must be set,
>>>>> so the individual alignment constraints must be combined with an OR
>>>>> instead of an AND.
>>>>>
>>>>> Can you apply the following change and check if it fixes the issue?
>>>>
>>>> Actually, this will not work either. The mask is used to mask off both
>>>> high address bits and low address bits (below swiotlb slot granularity).
>>>>
>>>> What should help is this:
>>>>
>>>
>>> Hi Petr, 
>>>
>>> The suggested fix on this patch boots for me and initially looks ok,
>>> though when I start to use git commands I get flooded with "swiotlb
>>> buffer is full" messages and my session becomes unusable. This is on WSL
>>> which uses Hyper-V.
>>
>> Roberto noticed that my initial quick fix left iotlb_align_mask
>> uninitialized. As a result, high address bits are set randomly, and if
>> they do not match actual swiotlb addresses, allocations may fail with
>> "swiotlb buffer is full". I fixed it in the patch that I have just posted.
>>
>> HTH
>> Petr T
> 
> I pulled the patches from dma-mapping after your fix got applied and
> everything appears ok and goes back to the way it was; so no other
> errors to report. :) Unfortunately still getting the "swiotlb buffer is
> full" messages during kernel builds, though that was happening before
> your patches hit.
> 
> Thanks so much, Petr!

Sorry for breaking it in the first place. But the story also tells us
that some drivers do not really need as strict alignment as they
request, otherwise the kernel would have failed my smoke-testing.

Petr T

