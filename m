Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D055137F4
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348928AbiD1PTp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348927AbiD1PTo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 11:19:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A4AF1E6;
        Thu, 28 Apr 2022 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651158989; x=1682694989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pr+ey4rRc9gYEaidZyl/0OLhL2bGWJUaGv02tvBN1vQ=;
  b=XTy1BaP/iaSUjNBrGrzJuxCS9XnwlC9pOvppE0ALCJMFuHDl937BZ69N
   wU3CnLJGTib1ikLiq6bxJem+bs1Bo23FrsyUNoASgYOTERYDFoPRjKOgG
   tlWbS+auv4re7pRXe1CRBH2iang/Y4BpnvwXl09tmfwgnDPgTeMbHQfLw
   H7gNx9c2vvgLV+aBMEiLBa0oKq+0AfL+ygjpoaIFOywdw7uq+Lercb8P9
   0dMKIUPujmlCpkAV/aSlUmbCLumEvKiylG/h0rxgbM5lgVYm4qNguMvoS
   oDtKBGLNsXJf513HSveylikMOpk+BSF8MclbZOQnZL00sujJMVZV5IqZg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="329264513"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="329264513"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 08:16:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="651259674"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.19.92]) ([10.209.19.92])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 08:16:27 -0700
Message-ID: <25fdc11c-06b9-c16f-8427-77ac7673855c@linux.intel.com>
Date:   Thu, 28 Apr 2022 08:16:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Tianyu Lan <ltykernel@gmail.com>, m.szyprowski@samsung.com,
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
 <YmqtJr5lxDruT/9s@infradead.org>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <YmqtJr5lxDruT/9s@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 4/28/2022 8:05 AM, Christoph Hellwig wrote:
> On Thu, Apr 28, 2022 at 07:55:39AM -0700, Andi Kleen wrote:
>> At least for TDX need parallelism with a single device for performance.
> So find a way to make it happen without exposing details to random
> drivers.


That's what the original patch (that this one is derived from) did.

It was completely transparent to everyone outside swiotlb.c

-Andi

