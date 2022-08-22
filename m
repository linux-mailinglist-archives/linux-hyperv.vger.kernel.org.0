Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93FA59BF84
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Aug 2022 14:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiHVMcq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Aug 2022 08:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiHVMcp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Aug 2022 08:32:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF396BF4A;
        Mon, 22 Aug 2022 05:32:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B03D612FC;
        Mon, 22 Aug 2022 05:32:47 -0700 (PDT)
Received: from [10.57.15.77] (unknown [10.57.15.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEB0A3F718;
        Mon, 22 Aug 2022 05:32:38 -0700 (PDT)
Message-ID: <d5016c1e-55d9-4224-278a-50377d4c6454@arm.com>
Date:   Mon, 22 Aug 2022 13:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 4/4] swiotlb: panic if nslabs is too small
Content-Language: en-GB
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yu Zhao <yuzhao@google.com>, dongli.zhang@oracle.com,
        ak@linux.intel.com, akpm@linux-foundation.org,
        alexander.sverdlin@nokia.com, andi.kleen@intel.com, bp@alien8.de,
        bp@suse.de, cminyard@mvista.com, corbet@lwn.net,
        damien.lemoal@opensource.wdc.com, dave.hansen@linux.intel.com,
        iommu@lists.linux-foundation.org, joe.jin@oracle.com,
        joe@perches.com, keescook@chromium.org, kirill.shutemov@intel.com,
        kys@microsoft.com, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, ltykernel@gmail.com,
        michael.h.kelley@microsoft.com, mingo@redhat.com,
        m.szyprowski@samsung.com, parri.andrea@gmail.com,
        paulmck@kernel.org, pmladek@suse.com, rdunlap@infradead.org,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        Tianyu.Lan@microsoft.com, tsbogend@alpha.franken.de,
        vkuznets@redhat.com, wei.liu@kernel.org, x86@kernel.org
References: <20220611082514.37112-5-dongli.zhang@oracle.com>
 <20220820012031.1285979-1-yuzhao@google.com>
 <f8c743d8-fcbe-4ef7-5f86-d63086552ffd@arm.com>
 <YwNn92WP3rP4ylZu@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YwNn92WP3rP4ylZu@infradead.org>
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

On 2022-08-22 12:26, Christoph Hellwig wrote:
> On Mon, Aug 22, 2022 at 10:49:09AM +0100, Robin Murphy wrote:
>> Hmm, it's possible this might be quietly fixed by 20347fca71a3, but either
>> way I'm not sure why we would need to panic *before* we've even tried to
>> allocate anything, when we could simply return with no harm done? If we've
>> ended up calculating (or being told) a buffer size which is too small to be
>> usable, that should be no different to disabling SWIOTLB entirely.
> 
> Hmm.  I think this might be a philosophical question, but I think
> failing the boot with a clear error report for a configuration that is
> supposed to work but can't is way better than just panicing later on.

Depends which context of "supposed to work" you mean there. The most 
logical reason to end up with a tiny SWIOTLB size is because you don't 
expect to need SWIOTLB, therefore if there's now a functional minimum 
size limit, failing gracefully such that the system keeps working as 
before is correct in that context. Even if we assume the expectation 
goes the other way, then it should be on SWIOTLB to adjust the initial 
allocation size to whatever minimum it now needs, which as I say it 
looks like 20347fca71a3 might do anyway. Creating new breakage by 
panicking instead of making a decision one way or the other was never 
the right answer.

>> Historically, passing "swiotlb=1" on the command line has been used to save
>> memory when the user knows SWIOTLB isn't needed. That should definitely not
>> be allowed to start panicking.
> 
> I've never seen swiotlb=1 advertized as a way to disable swiotlb.
> That's always been swiotlb=noforce, which cleanly disables it.

No, it's probably not been advertised as such, but it's what clearly 
fell out of the available options before "noforce" was added (which was 
considerably more recently than "always"), and the fact is that people 
*are* still using it even today (presumably copy-pasted through Android 
BSPs since before 4.10).

Thanks,
Robin.
