Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F1D6D9ADB
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Apr 2023 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbjDFOnt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Apr 2023 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbjDFOne (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Apr 2023 10:43:34 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF69A5F8;
        Thu,  6 Apr 2023 07:42:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PskWP4spGz9xqnc;
        Thu,  6 Apr 2023 22:33:21 +0800 (CST)
Received: from [10.48.151.63] (unknown [10.48.151.63])
        by APP2 (Coremail) with SMTP id GxC2BwA3AFc62i5ki__8AQ--.42S2;
        Thu, 06 Apr 2023 15:42:13 +0100 (CET)
Message-ID: <15d9dab3-379b-c62c-dd52-a810abe6985d@huaweicloud.com>
Date:   Thu, 6 Apr 2023 16:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
To:     Kelsey Steele <kelseysteele@linux.microsoft.com>,
        Petr Tesa????k <petr@tesarici.cz>
Cc:     Dexuan Cui <decui@microsoft.com>,
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
Content-Language: en-US
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <20230406045204.GA20027@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwA3AFc62i5ki__8AQ--.42S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW5GF4UZw1kCw1kZrWkZwb_yoW5GFWfpF
        WSya1qkF4DJry8tw12y3srta12q345Gr1UXr1rK34Skrn8KFn5JryUKrWj9asxKr4fWa10
        vr4jqFW3tFy5JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UdxhLUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Kelsey,

On 4/6/2023 6:52 AM, Kelsey Steele wrote:
> On Wed, Apr 05, 2023 at 07:50:34AM +0200, Petr Tesa????k wrote:
>> On Wed, 5 Apr 2023 07:32:06 +0200
>> Petr Tesa????k <petr@tesarici.cz> wrote:
>>
>>> On Wed, 5 Apr 2023 05:11:42 +0000
>>> Dexuan Cui <decui@microsoft.com> wrote:
>>>
>>>>> From: Petr Tesa????k <petr@tesarici.cz>
>>>>> Sent: Tuesday, April 4, 2023 9:40 PM    
>>>>>>> ...
>>>>>>> Hi Petr, this patch has gone into the mainline:
>>>>>>> 0eee5ae10256 ("swiotlb: fix slot alignment checks")
>>>>>>>
>>>>>>> Somehow it breaks Linux VMs on Hyper-V: a regular VM with
>>>>>>> swiotlb=force or a confidential VM (which uses swiotlb) fails to boot.
>>>>>>> If I revert this patch, everything works fine.  
>>>>>>
>>>>>> The log is pasted below. Looks like the SCSI driver hv_storvsc fails to
>>>>>> detect the disk capacity:    
>>>>>
>>>>> The first thing I can imagine is that there are in fact no (free) slots
>>>>> in the SWIOTLB which match the alignment constraints, so the map
>>>>> operation fails. However, this would result in a "swiotlb buffer is
>>>>> full" message in the log, and I can see no such message in the log
>>>>> excerpt you have posted.
>>>>>
>>>>> Please, can you check if there are any "swiotlb" messages preceding the
>>>>> first error message?
>>>>>
>>>>> Petr T    
>>>>
>>>> There is no "swiotlb buffer is full" error.
>>>>
>>>> The hv_storvsc driver (drivers/scsi/storvsc_drv.c) calls scsi_dma_map(),
>>>> which doesn't return -ENOMEM when the failure happens.  
>>>
>>> I see...
>>>
>>> Argh, you're right. This is a braino. The alignment mask is in fact an
>>> INVERTED mask, i.e. it masks off bits that are not relevant for the
>>> alignment. The more strict alignment needed the more bits must be set,
>>> so the individual alignment constraints must be combined with an OR
>>> instead of an AND.
>>>
>>> Can you apply the following change and check if it fixes the issue?
>>
>> Actually, this will not work either. The mask is used to mask off both
>> high address bits and low address bits (below swiotlb slot granularity).
>>
>> What should help is this:
>>
> 
> Hi Petr, 
> 
> The suggested fix on this patch boots for me and initially looks ok,
> though when I start to use git commands I get flooded with "swiotlb
> buffer is full" messages and my session becomes unusable. This is on WSL
> which uses Hyper-V.

Roberto noticed that my initial quick fix left iotlb_align_mask
uninitialized. As a result, high address bits are set randomly, and if
they do not match actual swiotlb addresses, allocations may fail with
"swiotlb buffer is full". I fixed it in the patch that I have just posted.

HTH
Petr T

