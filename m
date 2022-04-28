Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8680E51377A
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiD1O7B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348565AbiD1O7A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 10:59:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F1443DF;
        Thu, 28 Apr 2022 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651157745; x=1682693745;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TymbHLQLOivBB5TuFgZIkk0oRKZgOsSXpf3tD9EpOrU=;
  b=DysVTHtHT9pvJhC/dBsn/sqxMX+nvrwEUBCSAqsXUbjObLNo8HoYEuj8
   UurzFOy1Mg5yFne4sD/DtVtnx1OFBgxYlIIsSZUC0Id2xMoWuBFf3IMhS
   G25QM86kqnbPkC3I5g7gyLzFmsAHl2FJ7RY4kCq0UH0qEpMvNuVQS9y7O
   +x1c1psCme0+iwW/opaEdD0VowFCFFZNRgwowCwX2hzgQxk/8QJ++hafL
   Naw59yuRGyqgMlYrqGu0v8B5JQw/XSo8aRxonj7dZmrnhjXWT7LhsS+zH
   eoq1gvTdYfPc1QQKgzlUkjCH9sXubJ9l9huewWueI3id/u+59Kqt2eyvV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="263902289"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="263902289"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 07:55:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="651252042"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.19.92]) ([10.209.19.92])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 07:55:44 -0700
Message-ID: <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
Date:   Thu, 28 Apr 2022 07:55:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
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
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <YmqonHKBT8ftYHgY@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 4/28/2022 7:45 AM, Christoph Hellwig wrote:
> On Thu, Apr 28, 2022 at 03:44:36PM +0100, Robin Murphy wrote:
>> Rather than introduce this extra level of allocator complexity, how about
>> just dividing up the initial SWIOTLB allocation into multiple io_tlb_mem
>> instances?
> Yeah.  We're almost done removing all knowledge of swiotlb from drivers,
> so the very last thing I want is an interface that allows a driver to
> allocate a per-device buffer.

At least for TDX need parallelism with a single device for performance.

So if you split up the io tlb mems for a device then you would need a 
new mechanism to load balance the requests for single device over those. 
I doubt it would be any simpler.


-Andi


