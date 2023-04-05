Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E54D6D7C63
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Apr 2023 14:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbjDEMZC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 08:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbjDEMZB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 08:25:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A220540F9;
        Wed,  5 Apr 2023 05:24:46 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pk2Bn-00016R-NG; Wed, 05 Apr 2023 14:24:35 +0200
Message-ID: <b8843192-c5ae-17ea-dfa8-02f379112995@leemhuis.info>
Date:   Wed, 5 Apr 2023 14:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
Content-Language: en-US, de-DE
To:     Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jianxiong Gao <jxgao@google.com>,
        David Stevens <stevensd@chromium.org>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, Tianyu.Lan@microsoft.com,
        linux-hyperv@vger.kernel.org
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
 <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
 <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680697486;1e83ec65;
X-HE-SMSGID: 1pk2Bn-00016R-NG
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 04.04.23 21:55, Dexuan-Linux Cui wrote:
> On Tue, Mar 21, 2023 at 1:37 AM Petr Tesarik
> <petrtesarik@huaweicloud.com> wrote:
>>
>> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>>
>> Explicit alignment and page alignment are used only to calculate
>> the stride, not when checking actual slot physical address.
>>
>> Originally, only page alignment was implemented, and that worked,
>> because the whole SWIOTLB is allocated on a page boundary, so
>> aligning the start index was sufficient to ensure a page-aligned
>> slot.
>>
>> When Christoph Hellwig added support for min_align_mask, the index
>> could be incremented in the search loop, potentially finding an
>> unaligned slot if minimum device alignment is between IO_TLB_SIZE
>> and PAGE_SIZE. The bug could go unnoticed, because the slot size
>> is 2 KiB, and the most common page size is 4 KiB, so there is no
>> alignment value in between.
>>
>> IIUC the intention has been to find a slot that conforms to all
>> alignment constraints: device minimum alignment, an explicit
>> alignment (given as function parameter) and optionally page
>> alignment (if allocation size is >= PAGE_SIZE). The most
>> restrictive mask can be trivially computed with logical AND. The
>> rest can stay.
>>
>> Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
>> Fixes: e81e99bacc9f ("swiotlb: Support aligned swiotlb buffers")
>> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
>> ---
> [...]
> 
> Hi Petr, this patch has gone into the mainline:
> 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> 
> Somehow it breaks Linux VMs on Hyper-V: a regular VM with
> swiotlb=force or a confidential VM (which uses swiotlb) fails to boot.
> If I revert this patch, everything works fine.
> 
> Cc'd Tianyu/Michael and the Hyper-V list.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 0eee5ae10256
#regzbot title swiotlb: Linux VMs on Hyper-V broken
#regzbot monitor:
https://lore.kernel.org/all/20230405003549.GA21326@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
