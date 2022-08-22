Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF99659BD1E
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Aug 2022 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiHVJtY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Aug 2022 05:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiHVJtY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Aug 2022 05:49:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B9D629821;
        Mon, 22 Aug 2022 02:49:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA29213D5;
        Mon, 22 Aug 2022 02:49:24 -0700 (PDT)
Received: from [10.57.15.77] (unknown [10.57.15.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 536F13F718;
        Mon, 22 Aug 2022 02:49:15 -0700 (PDT)
Message-ID: <f8c743d8-fcbe-4ef7-5f86-d63086552ffd@arm.com>
Date:   Mon, 22 Aug 2022 10:49:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 4/4] swiotlb: panic if nslabs is too small
Content-Language: en-GB
To:     Yu Zhao <yuzhao@google.com>, dongli.zhang@oracle.com
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        alexander.sverdlin@nokia.com, andi.kleen@intel.com, bp@alien8.de,
        bp@suse.de, cminyard@mvista.com, corbet@lwn.net,
        damien.lemoal@opensource.wdc.com, dave.hansen@linux.intel.com,
        hch@infradead.org, iommu@lists.linux-foundation.org,
        joe.jin@oracle.com, joe@perches.com, keescook@chromium.org,
        kirill.shutemov@intel.com, kys@microsoft.com,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        ltykernel@gmail.com, michael.h.kelley@microsoft.com,
        mingo@redhat.com, m.szyprowski@samsung.com, parri.andrea@gmail.com,
        paulmck@kernel.org, pmladek@suse.com, rdunlap@infradead.org,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        Tianyu.Lan@microsoft.com, tsbogend@alpha.franken.de,
        vkuznets@redhat.com, wei.liu@kernel.org, x86@kernel.org
References: <20220611082514.37112-5-dongli.zhang@oracle.com>
 <20220820012031.1285979-1-yuzhao@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220820012031.1285979-1-yuzhao@google.com>
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

On 2022-08-20 02:20, Yu Zhao wrote:
>> Panic on purpose if nslabs is too small, in order to sync with the remap
>> retry logic.
>>
>> In addition, print the number of bytes for tlb alloc failure.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>   kernel/dma/swiotlb.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index fd21f4162f4b..1758b724c7a8 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -242,6 +242,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>>   	if (swiotlb_force_disable)
>>   		return;
>>   
>> +	if (nslabs < IO_TLB_MIN_SLABS)
>> +		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
> 
> Hi,
> 
> This patch breaks MIPS. Please take a look. Thanks.

Hmm, it's possible this might be quietly fixed by 20347fca71a3, but 
either way I'm not sure why we would need to panic *before* we've even 
tried to allocate anything, when we could simply return with no harm 
done? If we've ended up calculating (or being told) a buffer size which 
is too small to be usable, that should be no different to disabling 
SWIOTLB entirely.

Historically, passing "swiotlb=1" on the command line has been used to 
save memory when the user knows SWIOTLB isn't needed. That should 
definitely not be allowed to start panicking.

(once again, another patch which was not CCed to the correct reviewers, 
sigh...)

Thanks,
Robin.

> On v5.19.0:
>    Linux version 5.19.0 (builder@buildhost) (mips64-openwrt-linux-musl-gcc (OpenWrt GCC 11.2.0 r19590-042d558536) 11.2.0, GNU ld (GNU Binutils) 2.37) #0 SMP Sun Jul 31 15:12:47 2022
>    Skipping L2 locking due to reduced L2 cache size
>    CVMSEG size: 0 cache lines (0 bytes)
>    printk: bootconsole [early0] enabled
>    CPU0 revision is: 000d9301 (Cavium Octeon II)
>    Kernel sections are not in the memory maps
>    Wasting 278528 bytes for tracking 4352 unused pages
>    Initrd not found or empty - disabling initrd
>    Using appended Device Tree.
>    software IO TLB: SWIOTLB bounce buffer size adjusted to 0MB
>    software IO TLB: mapped [mem 0x0000000004b0c000-0x0000000004b4c000] (0MB)
> 
> On v6.0-rc1, with
>    commit 0bf28fc40d89 ("swiotlb: panic if nslabs is too small")
>    commit 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
>    commit 534ea58b3ceb ("Revert "MIPS: octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32"")
> 
>    Linux version 6.0.0-rc1 (builder@buildhost) (mips64-openwrt-linux-musl-gcc (OpenWrt GCC 11.2.0 r19590-042d558536) 11.2.0, GNU ld (GNU Binutils) 2.37) #0 SMP Sun Jul 31 15:12:47 2022
>    Failed to allocate CAVIUM_RESERVE32 memory area
>    Skipping L2 locking due to reduced L2 cache size
>    CVMSEG size: 0 cache lines (0 bytes)
>    printk: bootconsole [early0] enabled
>    CPU0 revision is: 000d9301 (Cavium Octeon II)
>    Kernel sections are not in the memory maps
>    Wasting 278528 bytes for tracking 4352 unused pages
>    Initrd not found or empty - disabling initrd
>    Using appended Device Tree.
>    software IO TLB: SWIOTLB bounce buffer size adjusted to 0MB
>    software IO TLB: area num 1.
>    Kernel panic - not syncing: swiotlb_init_remap: nslabs = 128 too small
> 
> On v6.0-rc1, with
>    commit 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
>    commit 534ea58b3ceb ("Revert "MIPS: octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32"")
> 
>    Linux version 6.0.0-rc1+ (builder@buildhost) (mips64-openwrt-linux-musl-gcc (OpenWrt GCC 11.2.0 r19590-042d558536) 11.2.0, GNU ld (GNU Binutils) 2.37) #0 SMP Sun Jul 31 15:12:47 2022
>    Failed to allocate CAVIUM_RESERVE32 memory area
>    Skipping L2 locking due to reduced L2 cache size
>    CVMSEG size: 0 cache lines (0 bytes)
>    printk: bootconsole [early0] enabled
>    CPU0 revision is: 000d9301 (Cavium Octeon II)
>    Kernel sections are not in the memory maps
>    Wasting 278528 bytes for tracking 4352 unused pages
>    Initrd not found or empty - disabling initrd
>    Using appended Device Tree.
>    software IO TLB: SWIOTLB bounce buffer size adjusted to 0MB
>    software IO TLB: area num 1.
>    software IO TLB: mapped [mem 0x0000000004c0c000-0x0000000004c4c000] (0MB)
