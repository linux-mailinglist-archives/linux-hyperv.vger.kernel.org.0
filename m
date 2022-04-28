Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9E5513780
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 16:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348558AbiD1O7t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347213AbiD1O7s (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 10:59:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 218664833E;
        Thu, 28 Apr 2022 07:56:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC8C61474;
        Thu, 28 Apr 2022 07:56:33 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B923C3F774;
        Thu, 28 Apr 2022 07:56:29 -0700 (PDT)
Message-ID: <f0ab2aa5-ca23-fa40-6147-43fc1f385bc8@arm.com>
Date:   Thu, 28 Apr 2022 15:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-GB
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Tianyu Lan <ltykernel@gmail.com>, m.szyprowski@samsung.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        parri.andrea@gmail.com, thomas.lendacky@amd.com,
        wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@intel.com,
        iommu@lists.linux-foundation.org, andi.kleen@intel.com,
        brijesh.singh@amd.com, vkuznets@redhat.com, hch@lst.de
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
 <YmqonHKBT8ftYHgY@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YmqonHKBT8ftYHgY@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2022-04-28 15:45, Christoph Hellwig wrote:
> On Thu, Apr 28, 2022 at 03:44:36PM +0100, Robin Murphy wrote:
>> Rather than introduce this extra level of allocator complexity, how about
>> just dividing up the initial SWIOTLB allocation into multiple io_tlb_mem
>> instances?
> 
> Yeah.  We're almost done removing all knowledge of swiotlb from drivers,
> so the very last thing I want is an interface that allows a driver to
> allocate a per-device buffer.

FWIW I'd already started thinking about having a distinct io_tlb_mem for 
non-coherent devices where vaddr is made non-cacheable to avoid the 
hassle of keeping the arch_dma_sync_* calls lined up, so I'm certainly 
in favour of bringing in a bit more flexibility at this level :)

Robin.
